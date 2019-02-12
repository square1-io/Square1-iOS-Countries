//
//  Countries.swift
//  Countries
//
//  Created by Ricardo Antolin on 07/02/2019.
//  Copyright © 2019 Square1. All rights reserved.
//

import UIKit

public class Country: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case code
        case phoneCode = "prefix"
    }
    
    public var name: String? {
        get{
            return Locale
                .current
                .localizedString(forRegionCode: code)
        }
    }
    public let code: String
    public var phoneCode: UInt64
    
    public var currencySymbol: String?{
        get {
            return Locale(identifier: identifierFromCode(code))
                .currencySymbol
        }
    }
    public var currencyCode: String?{
        get {
            return Locale(identifier: identifierFromCode(code))
            .currencyCode
        }
    }
    public var flag: UIImage? {
        get {
            return UIImage(named: code.lowercased(), in: Countries.getPodBundle(), compatibleWith: nil)
        }
    }
    
    public init(code: String,
                phoneCode: UInt64) {
        self.code = code
        self.phoneCode = phoneCode
    }
    
    private func identifierFromCode(_ code: String) -> String {
        return Locale.identifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
    }
}

