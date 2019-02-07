//
//  Countries.swift
//  Countries
//
//  Created by Ricardo Antolin on 07/02/2019.
//  Copyright © 2019 Square1. All rights reserved.
//
import PhoneNumberKit
import UIKit

public class Country {
    public var name: String? {
        get{
            return Locale
                .current
                .localizedString(forRegionCode: code)
        }
    }
    public let code: String
    public var phoneCode: UInt64?{
        get {
            return PhoneNumberKit().countryCode(for: code)
        }
    }
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
            return UIImage(named: code.lowercased(), in: getPodBundle(), compatibleWith: nil)
        }
    }
    
    public init(code: String) {
        self.code = code
    }
    
    private func identifierFromCode(_ code: String) -> String {
        return Locale.identifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
    }
    
    private func getPodBundle() -> Bundle? {
        let bundle = Bundle(for: type(of: self))
        let bundleURL = bundle.resourceURL?.appendingPathComponent("SQ1CountriesKit.bundle")
        print(bundleURL)
        return Bundle(url: bundleURL!)
    }
}
