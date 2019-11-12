//
//  NetworkError.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 12/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case parseDataError
    case refreshTokenFailed
    case unknownError
}
