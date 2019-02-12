import XCTest
import SQ1CountriesKit

class Tests: XCTestCase {

    func testGetCountries() {
        let countries = Countries.getCountryList()
        
        XCTAssertGreaterThan(countries.count, 0)
    }
    
    func testFindCountriesByPhoneCode(){
        let country = Countries.findCountryByPhoneCode(353)
        XCTAssertNotNil(country)
        XCTAssertEqual(country!.code, "IE")
    }
    
    func testFindCountriesByPhoneCodeNoResult(){
        let country = Countries.findCountryByPhoneCode(999999999999)
        XCTAssertNil(country)
    }
    
    func testFindCountriesByNameCapitalized(){
        let country = Countries.findCountryByLocalizedName("Ireland")
        XCTAssertNotNil(country)
        XCTAssertEqual(country!.code, "IE")
    }
    
    func testFindCountriesByNameUppercased(){
        let country = Countries.findCountryByLocalizedName("IRELAND")
        XCTAssertNotNil(country)
        XCTAssertEqual(country!.code, "IE")
    }
    
    func testFindCountriesByNameNoResult(){
        let country = Countries.findCountryByLocalizedName("AAAAAAAAA")
        XCTAssertNil(country)
    }
    
    func testFindCountriesByRegionCodeLowerCased(){
        let country = Countries.findCountryByRegionCode("ie")
        XCTAssertNotNil(country)
        XCTAssertEqual(country?.code, "IE")
    }
    
    func testFindCountriesByRegionCodeUppercased(){
        let country = Countries.findCountryByRegionCode("IE")
        XCTAssertNotNil(country)
        XCTAssertEqual(country!.code, "IE")
    }
    
    func testFindCountriesByRegionCodeNoResult(){
        let country = Countries.findCountryByRegionCode("WEQW")
        XCTAssertNil(country)
    }
    
    func testCountryModel(){
        let country = Country(code: "IE", phoneCode: 353)
        XCTAssertEqual(country.name, "Ireland")
        XCTAssertEqual(country.currencySymbol, "€")
        XCTAssertEqual(country.currencyCode, "EUR")
        XCTAssertNotNil(country.flag)
    }
    
    func testCountryModelUnexistentCountryCode(){
        let currencyFail = "¤"
        let country = Country(code: "AAAAAAAAAA", phoneCode: 0)
        XCTAssertNil(country.name)
        XCTAssertEqual(country.currencySymbol, currencyFail)
        XCTAssertNil(country.currencyCode)
        XCTAssertNil(country.flag)
    }
    
}
