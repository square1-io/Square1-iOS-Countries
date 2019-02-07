//
//  Functions.swift
//  Countries
//
//  Created by Ricardo Antolin on 07/02/2019.
//  Copyright © 2019 Square1. All rights reserved.
//

import PhoneNumberKit

public class Countries {
    public class func getCountryList() -> [Country]{
        return Locale.isoRegionCodes.map{ Country(code: $0) }
    }
    
    public class func findCountryByPhoneCode(phoneCode: UInt64) -> Country? {
        if let countryCode = PhoneNumberKit().mainCountry(forCode: phoneCode) {
            return Country(code: countryCode)
        }
        return nil
    }
    
    public class func findCountryByName(name: String) -> Country? {
        return Locale.isoRegionCodes
            .first{ Locale.current.localizedString(forRegionCode: $0)?.lowercased() == name.lowercased() }
            .map{ Country(code: $0) }
    }
}

extension Locale {
    static let currency = Locale.isoRegionCodes.reduce(into: [:]) {
        let locale = Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.countryCode.rawValue: $1]))
        $0[$1] = (locale.currencyCode, locale.currencySymbol)
    }
}

