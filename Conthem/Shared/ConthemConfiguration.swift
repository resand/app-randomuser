//
//  ConthemConfiguration.swift
//  Conthem
//
//  Created by René Sandoval on 07/08/22.
//

final class ConthemConfiguration {
    static var shared = ConthemConfiguration()

    var logLevel: LogLevel = .debug
}
