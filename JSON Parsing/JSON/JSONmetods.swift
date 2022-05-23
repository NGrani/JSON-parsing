//
//  JSONmetods.swift
//  JSON Parsing
//
//  Created by Георгий Маркарян on 22.05.2022.
//

import Foundation
class JsonMetod{
    func loadJson(filename fileName: String )->ResponseData{
        var level: ResponseData?
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                level = jsonData
                
            } catch {
                print("error:\(error)")
            }
        }
        return level!
    }
    func saveJson(fileName: String, model: ResponseData ){
        if let filepath = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
            let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                let data = try encoder.encode(model)
                let json = String(data: data, encoding: .utf8)
                try json!.write(toFile: filepath, atomically: false, encoding: .utf8)
//              let contents = try String(contentsOfFile: filepath)
            } catch {
                print("error:\(error)")
            }
        }
    }

    func saveJsonTwo( model: ResponseData ){
        if  let logFilePath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("JSONexample.json")) {
            do {
            let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                let data = try encoder.encode(model)
//              let json = String(data: data, encoding: .utf8)

                guard let fileHandle = FileHandle(forWritingAtPath: logFilePath.path) else {
                    try! data.write(to: logFilePath)
                    return
                }
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            } catch {
                print("error:\(error)")
            }
        }
    }
}
