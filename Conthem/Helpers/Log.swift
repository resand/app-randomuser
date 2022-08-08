//
//  Log.swift
//  Conthem
//
//  Created by René Sandoval on 07/08/22.
//

import Foundation

func >= (levelA: LogLevel, levelB: LogLevel) -> Bool {
    return levelA.rawValue >= levelB.rawValue
}

func log(_ log: String) {
    print("Conthem :: " + log)
}

func logInfo(_ message: String) {
    guard ConthemConfiguration.shared.logLevel >= .info else { return }

    log(message)
}

func logWarn(_ message: String, filename: NSString = #file, line: Int = #line, funcname: String = #function) {
    guard ConthemConfiguration.shared.logLevel >= .error else { return }

    let caller = "\(filename.lastPathComponent)(\(line)) \(funcname)"
    log("⚠️⚠️⚠️ WARNING: " + message)
    log("⚠️⚠️⚠️ ⤷ FROM CALLER: " + caller + "\n")
}

func logError(_ error: NSError?, filename: NSString = #file, line: Int = #line, funcname: String = #function) {
    guard
        ConthemConfiguration.shared.logLevel >= .error,
        let err = error
    else { return }

    if let code = error?.code, code == 401 || code == 402 {
        log("Invalid credentials!!")
        return
    }

    let caller = "\(filename.lastPathComponent)(\(line)) \(funcname)"
    log("‼️‼️‼️ ERROR: " + err.localizedDescription)
    log("‼️‼️‼️ ⤷ FROM CALLER: " + caller)
    log("‼️‼️‼️ ⤷ USER INFO: \(err.userInfo)\n")
}
