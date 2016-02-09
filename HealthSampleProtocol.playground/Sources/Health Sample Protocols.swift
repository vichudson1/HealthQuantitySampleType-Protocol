import Foundation
import HealthKit

//: This hardcoded dictionary should be replaced with the results of a call to `healthKitStore.preferredUnitsForQuantityTypes(_ quantityTypes: Set<HKQuantityType>, completion completion: ([HKQuantityType : HKUnit], NSError?) -> Void)` in your actual implementation. This way you'll be presenting units in your users prefered format.
public let units: [HKQuantityType : HKUnit] = [
	HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)!: HKUnit(fromString: "count"),
	HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryEnergyConsumed)!: HKUnit(fromString: "kcal"),
	HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyFatPercentage)!: HKUnit(fromString: "%"),
	HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned)!: HKUnit(fromString: "kcal"),
	HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBloodGlucose)!: HKUnit(fromString: "mg/dL"),
	HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)!: HKUnit(fromString: "lb"),
	HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMassIndex)!: HKUnit(fromString: "count"),
	HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDistanceWalkingRunning)!: HKUnit(fromString: "mi"),
	HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)!: HKUnit(fromString: "count/min")
]

/**
*  Protocol Declares that conforming types have an optional variable called "sample" of type HKQuantitySample
*/
public protocol HealthQuantitySample {
	/// An instance of HKQuantitySample
	var sample: HKQuantitySample? { get set }
}

// MARK: - Extension Defines a few Useful prperties you may want from your HKSample
public extension HealthQuantitySample {
	var value: Double {
		guard let s = sample else {return 0.0}
		return s.quantity.doubleValueForUnit(unitFromType(s.quantityType))
	}
	
	var date: NSDate {
		guard let s = self.sample else {return NSDate()}
		return s.startDate
	}
}

// MARK: - Type Constaint extension to CustomStringConvertible to provide the string for casting.
public extension CustomStringConvertible where Self: HealthQuantitySample {
	var description: String {
		guard value != 0 else { return "--" }
		return stringRepresentationForType(self.type!)
	}
}

// This extension defines some private methods that should only be used by the protocol itself.
private extension HealthQuantitySample {
	var type: HKQuantityType? {
		guard let s = self.sample else {return nil}
		return s.quantityType
	}
	
	func unitFromType(type: HKQuantityType) -> HKUnit {
		return units[type]!
	}
	
	func suffixForType(type: HKQuantityType) -> String {
		switch type {
		// Define your custom suffixes for types here
		case HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)!: return "bpm"
		case HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBloodGlucose)!:
			// You should determine whether to return mg/dL or mmol for this sample I'm only returning mg/dL
			return "mg/dL"
		case HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyFatPercentage)!: return "%"
		case HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)!: return " steps"
			
		// Types with out a defined suffix will get an empty string
		default: return ""
		}
	}
	
	func stringRepresentationForType(type: HKQuantityType) -> String {
		switch type {
		// for cases where there are formatters provided by the system.
		case HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDistanceWalkingRunning)!:
			let formatterUnit = HKUnit.lengthFormatterUnitFromUnit(unitFromType(type))
			return distanceFormatter.stringFromValue(value, unit: formatterUnit)
		case HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)!:
			let formatterUnit = HKUnit.massFormatterUnitFromUnit(unitFromType(type))
			return weightFormatter.stringFromValue(value, unit: formatterUnit)
		case HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryEnergyConsumed)!, HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned)!:
			let formatterUnit = HKUnit.energyFormatterUnitFromUnit(unitFromType(type))
			return calorieFormatter.stringFromValue(value, unit: formatterUnit)
			
		// Many types will need a string suffix manually attached
		// let them default to the provided suffix provided by protocol if available
		default: return "\(numberFormatter.stringFromNumber(value)!)\(suffixForType(type))"
			
		}
	}
}

