import XCTest
import SQ1CountriesKit

class Tests: XCTestCase {

    func testGetCountries() {
        let countries = Countries.getCountryList()
        
        XCTAssertGreaterThan(countries.count, 0)
    }
    
    func testFindCountriesByPhoneCode(){
        let country = Countries.findCountryByPhoneCode(phoneCode: 353)
        XCTAssertNotNil(country)
        XCTAssertEqual(country!.code, "IE")
    }
    
    func testFindCountriesByPhoneCodeNoResult(){
        let country = Countries.findCountryByPhoneCode(phoneCode: 999999999999)
        XCTAssertNil(country)
    }
    
    func testFindCountriesByNameCapitalized(){
        let country = Countries.findCountryByName(name: "Ireland")
        XCTAssertNotNil(country)
        XCTAssertEqual(country!.code, "IE")
    }
    
    func testFindCountriesByNameUppercased(){
        let country = Countries.findCountryByName(name: "IRELAND")
        XCTAssertNotNil(country)
        XCTAssertEqual(country!.code, "IE")
    }
    
    func testFindCountriesByNameNoResult(){
        let country = Countries.findCountryByName(name: "AAAAAAAAA")
        XCTAssertNil(country)
    }
    
    func testCountryModel(){
        let country = Country(code: "IE")
        XCTAssertEqual(country.name, "Ireland")
        XCTAssertEqual(country.phoneCode, 353)
        XCTAssertEqual(country.currencySymbol, "€")
        XCTAssertEqual(country.currencyCode, "EUR")
        XCTAssertNotNil(country.flag)
    }
    
    func testCountryModelUnexistentCountryCode(){
        let currencyFail = "¤"
        let country = Country(code: "AAAAAAAAAA")
        XCTAssertNil(country.name)
        XCTAssertNil(country.phoneCode)
        XCTAssertEqual(country.currencySymbol, currencyFail)
        XCTAssertNil(country.currencyCode)
        XCTAssertNil(country.flag)
    }
    
}
