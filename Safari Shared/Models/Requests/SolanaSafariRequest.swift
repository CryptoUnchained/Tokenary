// Copyright © 2022 Tokenary. All rights reserved.

import Foundation

extension SafariRequest {
    
    struct Solana: SafariRequestBody {
        
        enum Method: String, Decodable, CaseIterable {
            case connect, signMessage, signTransaction, signAllTransactions, signAndSendTransaction
        }
        
        struct SendOptions: Codable {
            let maxRetries: Int?
            let preflightCommitment: String?
            let skipPreflight: Bool?
        }
        
        let method: Method
        let publicKey: String
        let message: String?
        let messages: [String]?
        let display: String?
        
        init?(name: String, json: [String: Any]) {
            guard let method = Method(rawValue: name),
                  let publicKey = json["publicKey"] as? String else { return nil }
            self.method = method
            self.publicKey = publicKey
            let parameters = (json["object"] as? [String: Any])?["params"] as? [String: Any]
            self.message = parameters?["message"] as? String
            self.messages = parameters?["messages"] as? [String]
            self.display = parameters?["display"] as? String
        }
        
        var responseUpdatesStoredConfiguration: Bool {
            switch method {
            case .connect:
                return true
            case .signMessage, .signTransaction, .signAllTransactions, .signAndSendTransaction:
                return false
            }
        }
        
    }
    
}
