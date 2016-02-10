import Foundation
import HealthKit

/**
*  Protocol Declares that conforming types have an optional variable called "sample" of type HKQuantitySample
*/
// MARK: - HealthQuantitySampleType protocol
public protocol HealthQuantitySampleType {
	/// An instance of HKQuantitySample
	var sample: HKQuantitySample? { get set }
}

// MARK: - Extension to define your instance of the HealthKitUnitTypeManager
// This should be the only edit you need to make to use this protocol in your project
extension HealthQuantitySampleType {
	/// The HealthKitUnitTypeManager Instance responsible for formatting
	/// Your Samples as Strings & Determining the correct Unit Types for samples.
	/// In your project this should return an instance of unitTypeManager
	/// stored in your HealthKitSingleton Helper Class, for this playground
	/// I've just defined a constant at the end of this file.
	var unitManager: HealthKitUnitTypeManager { return theUnitManager }
}

// MARK: - Extension Defines a few Useful Basic prperties you may want from your HKSample
public extension HealthQuantitySampleType {
	/// A Double representation of your samples value
	var value: Double {
		guard let s = sample else {return 0.0}
		return s.quantity.doubleValueForUnit(unitManager.unitForQuantityType(s.quantityType))
	}
	
	/// The Sample Start Date
	var date: NSDate? {
		guard let s = self.sample else {return nil}
		return s.startDate
	}
	
	/// The Sample Type
	var type: HKQuantityType? {
		guard let s = self.sample else {return nil}
		return s.quantityType
	}
	
	/// Alternate Representaions of Sample
	var integerValue: Int { return Int(round(value)) }
	var valueLabel: String {
		guard let type = type else { return "" }
		return unitManager.unitStringForQuantityType(type, fromDoubleValue: value)
	}
	
	/// Date & Time Strings for Sample
	var timeString: String {
		guard let date = date else {return ""}
		return timeFormatter.stringFromDate(date)
	}
	var dateString: String {
		guard let date = date else {return ""}
		return dateFormatter.stringFromDate(date)
	}
	var dateAndTimeString: String {
		guard let date = date else {return ""}
		return dateTimeFormatter.stringFromDate(date)
	}
}

// MARK: - Type Constaint extension to CustomStringConvertible to provide the string for casting.
public extension CustomStringConvertible where Self: HealthQuantitySampleType {
	/// The variable returnng the String Representation of your sample.
	var description: String {
		guard value != 0 else { return "--" }
		return unitManager.stringRepresentationForDoubleValue(value, ofQuantityType: type!)
	}
}


/// A global dummy constant since our playground doesn't have a 
/// HealthKit Helper singleton your app would normally have
public var theUnitManager = HealthKitUnitTypeManager()

