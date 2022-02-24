//
//  BithumbWebSocketAPI.swift
//  BithumbAPITest
//
//  Created by 박형석 on 2022/02/23.
//

import Foundation
import Starscream
import RxSwift
import RxCocoa

final class BithumbWebSocketTickerAPI {
    private let socket: WebSocket
    
    let tickerSubject = PublishSubject<RealtimeTicker>()
    
    init() {
        let urlString: String = "wss://pubwss.bithumb.com/pub/ws"
        let url: URL = .init(string: urlString)!
        var urlRequest: URLRequest = .init(url: url)
        urlRequest.timeoutInterval = 5
        self.socket = WebSocket(request: urlRequest)
        self.socket.delegate = self
        self.socket.connect()
    }
    
    deinit {
        self.socket.disconnect()
        self.socket.delegate = nil
    }
    
    private func sendMessage() throws {
        do {
            let message = self.makeMessage()
            let data: Data = try JSONEncoder().encode(message)
            self.socket.write(data: data, completion: nil)
        } catch {
            throw NetworkError.encodeFail
        }
    }
    
    private func makeMessage() -> SubscribeMessage {
        return .init(type: .ticker, symbols: [.BTC_KRW, .ETH_KRW], tickType: [.oneHour, .twelveHour])
    }
}

extension BithumbWebSocketTickerAPI: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(_):
            print("🌍 connected : Bithumb WebSocket API Connect")
            try? self.sendMessage()
        case .disconnected(_, _):
            print("🌍 disconnected : Bithumb WebSocket API disconnect")
        case .text(let result):
            guard let data = result.data(using: .utf8) else {
                return
            }
            
//            let response = try? JSONDecoder().decode(NetworkResponce<T>.self, from: data)
 
        case .error(_):
            print("에러 처리")
        case .reconnectSuggested(_):
            print("재연결 관련 에러 처리")
        default:
            break
        }
    }
}
