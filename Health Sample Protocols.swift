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
	/// In your project this should return a global instance of unitTypeManager.
	var globalUnitManager: HealthKitUnitTypeManager { return unitManager }
}

// MARK: - Extension Defines a few Useful Basic prperties you may want from your HKSample
public extension HealthQuantitySampleType {
	/// A Double representation of your samples value
	var value: Double {
		guard let s = sample else {return 0.0}
		return s.quantity.doubleValueForUnit(globalUnitManager.unitForQuantityType(s.quantityType))
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
		return globalUnitManager.unitStringForQuantityType(type, fromDoubleValue: value)
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
		return globalUnitManager.stringRepresentationForDoubleValue(value, ofQuantityType: type!)
	}
}