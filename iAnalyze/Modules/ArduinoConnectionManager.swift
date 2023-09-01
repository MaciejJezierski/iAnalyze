//
//  ArduinoConnectionManager.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 18/06/2023.
//

import Foundation
import CoreBluetooth

class ArduinoConnectionManager: NSObject, ObservableObject {
    
    private var centralManager: CBCentralManager!

    private var isScanning: Bool = false
    private var dataCharacteristic: CBCharacteristic?
    private let targetServiceUUID = CBUUID(string: "89a2e4f8-76cc-4bdb-81e1-14b585e66844")
    private let targetCharacteristicUUID = CBUUID(string: "cde86603-7243-49cd-a02e-0fc4c663e4fa")

    @Published var receivedValue: Float = 0.0
    @Published var triggerValue: Float = 0.0
    @Published var isConnected = false
    @Published var isServiceFound = false
    @Published var isCharacteristicFound = false
    @Published var isFailed: Bool = false
    @Published var devices: [CBPeripheral] = []
    var selectedDevice: CBPeripheral?

    override init() {
            super.init()
            centralManager = CBCentralManager(delegate: self, queue: nil)
        }
    
    
    func startScanning() {
        if centralManager.state == .poweredOn && !isScanning {
            let options = [CBCentralManagerScanOptionAllowDuplicatesKey: false]
            centralManager.scanForPeripherals(withServices: nil, options: options)
            isScanning = true
        }
    }

    func connect(to peripheral: CBPeripheral) {
        centralManager.stopScan()
        peripheral.delegate = self
        centralManager.connect(peripheral, options: nil)
    }
    
    func bluetoothUnavailable(to peripheral: CBPeripheral) {

    }

    func captureFloatData(from peripheral: CBPeripheral) {
        peripheral.delegate = self
         guard let service = peripheral.services?.first(where: { $0.uuid == targetServiceUUID }),
               let characteristic = service.characteristics?.first(where: { $0.uuid == targetCharacteristicUUID }) else {
                    print("Couldn't find service/characteristic")
                    return
                }
         
         peripheral.readValue(for: characteristic)
         
         guard let data = characteristic.value else {
             return
         }
        receivedValue = data.withUnsafeBytes { $0.load(as: Float.self) }
     }
    
    func startAnalysis(from peripheral: CBPeripheral) {
        peripheral.delegate = self
         guard let service = peripheral.services?.first(where: { $0.uuid == targetServiceUUID }),
               let characteristic = service.characteristics?.first(where: { $0.uuid == targetCharacteristicUUID }) else {
                    print("Couldn't find service/characteristic")
                    return
                }
        
        let triggerData = withUnsafeBytes(of: &triggerValue) { Data($0) }
        peripheral.writeValue(triggerData, for: characteristic, type: .withResponse)
     }
}


extension ArduinoConnectionManager: CBCentralManagerDelegate, CBPeripheralDelegate, CBPeripheralManagerDelegate{
    
    //------------------------------------------------------------------------------------------------------------------------------------
    //DISCOVERING
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        
        let existingDevice = devices.first { $0.identifier == peripheral.identifier }
        if existingDevice == nil {
            devices.append(peripheral)
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
          guard let services = peripheral.services else {
              // Handle error or no services found
              return
          }
          
          for service in services {
              isServiceFound = true
              print("Discovered service: \(service)")
              selectedDevice?.discoverCharacteristics([targetCharacteristicUUID], for: service) // Passing nil will discover all characteristics
          }
      }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        isCharacteristicFound = true
      }
    
    
    //------------------------------------------------------------------------------------------------------------------------------------
    //CONNECTION
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        // Handle successful connection
        isConnected = true
        selectedDevice = peripheral
        selectedDevice?.delegate = self
        selectedDevice?.discoverServices([targetServiceUUID])
    }

    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        // Handle failed connection
        isFailed = true
    }
    //------------------------------------------------------------------------------------------------------------------------------------
    //REST
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        peripheral.readValue(for: characteristic)
        guard let data = characteristic.value else {
            return
        }
       receivedValue = data.withUnsafeBytes { $0.load(as: Float.self) }
                
        }
    
    //------------------------------------------------------------------------------------------------------------------------------------
    //REST
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
    }
}
