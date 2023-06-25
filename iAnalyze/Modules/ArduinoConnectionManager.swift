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
    @Published var isConnected = false
    @Published var isServiceFound = false
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
//            centralManager.scanForPeripherals(withServices: [targetServiceUUID], options: options)
            centralManager.scanForPeripherals(withServices: nil, options: options)

            isScanning = true
            
            // Add a timer to stop scanning after a certain duration
//            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//                centralManager.stopScanning()
//            }
        } else {
            // Handle the case when Bluetooth is unavailable or already scanning
            // delegate?.didFailToStartBluetooth()
        }
    }
    
//    func stopScanning() {
//        if isScanning {
//            centralManager.stopScan()
//            isScanning = false
//        }
//    }
//

    func connect(to peripheral: CBPeripheral) {
        centralManager.stopScan()
        peripheral.delegate = self
        centralManager.connect(peripheral, options: nil)
    }
    
    func bluetoothUnavailable(to peripheral: CBPeripheral) {

    }

    func captureFloatData() {
         guard let selectedDevice = selectedDevice,
               let service = selectedDevice.services?.first(where: { $0.uuid == targetServiceUUID }),
               let characteristic = service.characteristics?.first(where: { $0.uuid == targetCharacteristicUUID }) else {
             // Handle the case when the selected device, service, or characteristic is not available
             print(targetServiceUUID)
             print("cos sie znowu zjebalo")
             print(isConnected)
              return
         }
         
         selectedDevice.readValue(for: characteristic)
         
         guard let data = characteristic.value else {
             print("tu jestem1")
             // Handle the case when no data is available
             return
         }
         
         let floatValue = data.withUnsafeBytes { $0.load(as: Float.self) }
         // Use the captured float value as needed
        print("tu jestem2")
        receivedValue = floatValue
     }
}

extension ArduinoConnectionManager: CBCentralManagerDelegate, CBPeripheralDelegate, CBPeripheralManagerDelegate{
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
    }


    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        
        let existingDevice = devices.first { $0.identifier == peripheral.identifier }
        if existingDevice == nil {
            devices.append(peripheral)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        isServiceFound = true
          guard let services = peripheral.services else {
              // Handle error or no services found
              return
          }
          
          for service in services {
              print("Discovered service: \(service)")
              peripheral.discoverCharacteristics(nil, for: service) // Passing nil will discover all characteristics
          }
      }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        // Handle successful connection
        isConnected = true
        selectedDevice = peripheral
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        guard let services = peripheral.services?[0] else {
            print("tu jestem2")
            return
        }
//        peripheral.discoverCharacteristics([targetCharacteristicUUID], for: services)
    }

    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        // Handle failed connection
        isFailed = true
    }
}
