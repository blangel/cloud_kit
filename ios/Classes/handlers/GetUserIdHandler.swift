//
//  GetUserIdHandler.swift
//  cloud_kit
//
//  Created by Manuel on 07.04.23.
//

import CloudKit

class GetUserIdHandler: CommandHandler {

    var COMMAND_NAME: String = "GET_USER_ID"

    func evaluateExecution(command: String) -> Bool {
        return command == COMMAND_NAME
    }

    func handle(command: String, arguments: Dictionary<String, Any>, result: @escaping FlutterResult) {
        if (!evaluateExecution(command: command)) {
            return
        }

        if let containerId = arguments["containerId"] as? String {
            let defaultContainer: CKContainer = CKContainer(identifier: containerId)
            defaultContainer.fetchUserRecordID { recordID, error in
                guard let recordID = recordID, error == nil else {
                    result(FlutterError(code: "Error", message: "Error fetching user record ID: \(error?.localizedDescription ?? "Unknown error")", details: nil))
                    return
                }
                result(recordID.recordName)
            }
        } else {
            result(FlutterError.init(code: "Error", message: "Failed to parse arguments", details: nil))
        }
    }

}
