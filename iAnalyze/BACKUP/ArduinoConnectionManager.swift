//
//  BluetoothModule.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 18/06/2023.
//

import Foundation
import CoreBluetooth

class ArduinoDeviceConnector: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    let deviceUUID = CBUUID(string: "19B10000-E8F2-537E-4F6C-D104768A1214")
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral?
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            central.scanForPeripherals(withServices: [deviceUUID], options: nil)
        } else {
            // Handle Bluetooth not available or turned off
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if peripheral.identifier.uuidString == deviceUUID.uuidString {
            self.peripheral = peripheral
            central.connect(peripheral, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                if characteristic.uuid.uuidString == deviceUUID.uuidString {
                    peripheral.setNotifyValue(true, for: characteristic)
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let data = characteristic.value {
            let value = data.withUnsafeBytes { $0.load(as: Int.self) }
            // Handle the received value
            print("Received value: \(value)")
        }
    }
}
