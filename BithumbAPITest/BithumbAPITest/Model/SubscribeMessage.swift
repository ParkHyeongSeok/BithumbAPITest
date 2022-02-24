//
//  SubscribeMessage.swift
//  BithumbAPITest
//
//  Created by 박형석 on 2022/02/23.
//

import Foundation

struct SubscribeMessage: Encodable {
    let type: SubscribeType
    let symbols: [SymbolType]
    let tickType: [TickType]?
}
