//
//  Functions.swift
//  Countries
//
//  Created by Ricardo Antolin on 07/02/2019.
//  Copyright © 2019 Square1. All rights reserved.
//

public class Countries {
    private static var countries: [Country] = {
        guard let path = getPodBundle()?.path(forResource: "countries", ofType: "json") else {
            return []
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return try JSONDecoder().decode([Country].self, from: data)
        } catch {
            print(error)
            return []
        }
    }()
    
    public class func getCountryList() -> [Country]{
        return countries
    }
    
    public class func getCountryListSortedByLocalizedName() -> [Country]{
        return countries.sorted{ $0.name ?? "" < $1.name ?? "" }
    }
    
    public class func findCountryByPhoneCode(_ phoneCode: UInt64) -> Country? {
        return countries.first{ $0.phoneCode == phoneCode }
    }
    
    public class func findCountryByRegionCode(_ regionCode: String) -> Country? {
        return countries.first{ $0.code.lowercased() == regionCode.lowercased() }
    }
    
    public class func findCountryByLocalizedName(_ name: String) -> Country? {
        return countries
            .first{ Locale.current.localizedString(forRegionCode: $0.code)?.lowercased() == name.lowercased() }
    }
    
    class func getPodBundle() -> Bundle? {
        let bundle = Bundle(for: Countries.self)
        let bundleURL = bundle.resourceURL?.appendingPathComponent("SQ1CountriesKit.bundle")
        print(bundleURL ?? "")
        return Bundle(url: bundleURL!)
    }
    
}

extension Locale {
    static let currency = Locale.isoRegionCodes.reduce(into: [:]) {
        let locale = Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.countryCode.rawValue: $1]))
        $0[$1] = (locale.currencyCode, locale.currencySymbol)
    }
}

