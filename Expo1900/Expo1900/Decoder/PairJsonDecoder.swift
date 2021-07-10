//
//  Decoder.swift
//  Expo1900
//
//  Created by 편대호 on 2021/07/09.
//

import Foundation
import UIKit

class PairJsonDecoder {
    static let shared = PairJsonDecoder()
    private init() {}
    
    let decoder: JSONDecoder = JSONDecoder()
    
}
