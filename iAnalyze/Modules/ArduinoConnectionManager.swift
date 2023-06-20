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
    private let targetServiceUUID = CBUUID(string: "19B10000-E8F2-537E-4F6C-D104768A1214")
    private let targetCharacteristicUUID = CBUUID(string: "19B10001-E8F2-537E-4F6C-D104768A1214")

    @Published var receivedValue: Float = 0.0
    @Published var isConnected: Bool = false
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
            
            // Add a timer to stop scanning after a certain duration
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                self.stopScanning()
            }
        } else {
            // Handle the case when Bluetooth is unavailable or already scanning
            // delegate?.didFailToStartBluetooth()
        }
    }
    
    func stopScanning() {
        if isScanning {
            centralManager.stopScan()
            isScanning = false
        }
    }
    
    func connect(to peripheral: CBPeripheral) {
        centralManager.connect(peripheral, options: nil)
    }
    
    func bluetoothUnavailable(to peripheral: CBPeripheral) {

    }

    func captureFloatData() {
         guard let selectedDevice = selectedDevice,
               let service = selectedDevice.services?.first(where: { $0.uuid == targetServiceUUID }),
               let characteristic = service.characteristics?.first(where: { $0.uuid == targetCharacteristicUUID }) else {
             // Handle the case when the selected device, service, or characteristic is not available
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
        print("tu jestem1")
        receivedValue = floatValue
     }
}

extension ArduinoConnectionManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        // Handle central manager state updates if needed
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        let existingDevice = devices.first { $0.identifier == peripheral.identifier }
        if existingDevice == nil {
            devices.append(peripheral)
        }
    }
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        // Handle successful connection
        isConnected = true
        selectedDevice = peripheral
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        // Handle failed connection
        isFailed = true
    }
}
