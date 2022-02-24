//
//  TickType.swift
//  BithumbAPITest
//
//  Created by 박형석 on 2022/02/23.
//

import Foundation

enum TickType: String, Encodable {
    case thirtyMinutes = "30M"
    case oneHour = "1H"
    case twelveHour = "12H"
    case oneDay = "24H"
    case MID = "MID"
}
