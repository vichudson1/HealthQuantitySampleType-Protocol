import Foundation
import HealthKit
/**
Use this type to quickly determine HKUnits for HKQuantityTypes, as well as convert HealthKitQuantity values into strings
*/
public struct HealthKitUnitTypeManager {
	/// This Dictionary Contains HKQuantityTypes paired with respective HKUnits `[HKQuantityType : HKUnit]`
	var units: [HKQuantityType : HKUnit] {
		get {
			/// Return some default HKUnits if no user defined unit set available
			guard let units = userPreferredUnits else { return defaultUnits }
			return units
		}
		set { userPreferredUnits = newValue }
	}
	/**
	Use this method to find out the correct HKUnit for HKQuantityTypes.
	
	- parameter type: `HKQuantityType` - This is the type of sample you have.
	
	- returns: `HKUnit` The corresponding HKUnit for the passed in Type.
	*/
	func unitForQuantityType(type: HKQuantityType) -> HKUnit {
		return units[type]!
	}
	
	/**
	This private method is used to return hand coded unit strings for types without a Foundation Provided Formatter. Public calls for unitString should use `unitStringForQuantityType(_:, fromDoubleValue:?)`, which will fallback to this method when needed.
	- Note: You should add cases for any types you use that fit this criteria.
	- parameter type: `HKQuantityType` This is the type of sample you have.
	
	- returns: `String` Returns Unit String for the Type Passed in.
	*/
	private func unitStringForQuantityType(type: HKQuantityType) -> String {
		switch type {
		// Define your custom suffixes for types here
		case heartRateType: return "bpm"
		case bloodGlucoseType:
			if unitForQuantityType(bloodGlucoseType) == HKUnit(fromString: "mg/dL") {
				return "mg/dL"
			}
			return "mmol/L"
		case bodyFatPercentageType: return "%"
		case stepCountType: return "steps"
			
		// Types with out a defined suffix will get an empty string
		default: return ""
		}
	}
	
	/**
	THis Method will return the Unit String User Friendly Label for Quanity Types
	
	- parameter type:  `HKQuantityType` This is the quantity type you have.
	- parameter value: `Double` Optional value associated with the type.
	
	- returns: `String` The User Friendly Unit String for the quantity type.
	*/
	func unitStringForQuantityType(type: HKQuantityType, fromDoubleValue value: Double? = 0.0) -> String {
		switch type {
		// handle the types that use provided formatters here
		case bodyMassType:
			let formatterUnit = HKUnit.massFormatterUnitFromUnit(unitForQuantityType(type))
			return weightFormatter.unitStringFromValue(value!, unit: formatterUnit)
			
		case walkingRunningDistanceType:
			let formatterUnit = HKUnit.lengthFormatterUnitFromUnit(unitForQuantityType(type))
			return distanceFormatter.unitStringFromValue(value!, unit: formatterUnit)
			
		case bodyMassType:
			let formatterUnit = HKUnit.massFormatterUnitFromUnit(unitForQuantityType(type))
			return weightFormatter.unitStringFromValue(value!, unit: formatterUnit)
			
		case dietaryEnergyType, activeEnergyType:
			let formatterUnit = HKUnit.energyFormatterUnitFromUnit(unitForQuantityType(type))
			return calorieFormatter.unitStringFromValue(value!, unit: formatterUnit)
		// All others fall through to the defined unitStrings
		default: return unitStringForQuantityType(type)
		}
	}
	
	/**
	This method returns a user friendly string for the value and type passed in.
	
	- parameter value: `Double` The value of your Quantity Sample
	- parameter type:  `HKQuantityType` The type of sample you have.
	
	- returns: `String` The USer friendly string representing your Quantity Value.
	*/
	func stringRepresentationForDoubleValue(value: Double, ofQuantityType type: HKQuantityType) -> String {
		switch type {
			// for cases where there are formatters provided by the system.
			// these formatters are defined as constants in the sources folder.
		case walkingRunningDistanceType:
			let formatterUnit = HKUnit.lengthFormatterUnitFromUnit(unitForQuantityType(type))
			return distanceFormatter.stringFromValue(value, unit: formatterUnit)
			
		case bodyMassType:
			let formatterUnit = HKUnit.massFormatterUnitFromUnit(unitForQuantityType(type))
			return weightFormatter.stringFromValue(value, unit: formatterUnit)
			
		case dietaryEnergyType, activeEnergyType:
			let formatterUnit = HKUnit.energyFormatterUnitFromUnit(unitForQuantityType(type))
			return calorieFormatter.stringFromValue(value, unit: formatterUnit)
			
			// Many types will need a string suffix manually attached
			// let them default to the provided suffix provided by protocol if available
		default: return "\(numberFormatter.stringFromNumber(value)!) \(unitStringForQuantityType(type))"
		}
	}
	
	/**
	This method will return a user friendly value string directly from a passed in HKQuantitySample.
	
	- parameter sample: `HKQuantitySample` The sample you wish to display.
	
	- returns: `String` The User friendly string representing your Sample's Value.
	*/
	func stringRepresentationOfValueFromHKQuantitySample(sample: HKQuantitySample) -> String {
		let type = sample.quantityType
		let unit = unitForQuantityType(type)
		let sampleValue = sample.quantity.doubleValueForUnit(unit)
		return self.stringRepresentationForDoubleValue(sampleValue, ofQuantityType: type)
	}
	
	
 /// Private Property where user defined Unit Types for Quantity Types are stored. This should be set with the `units` setter within the completion block of a call to `healthKitStore.preferredUnitsForQuantityTypes(_ quantityTypes: Set<HKQuantityType>, completion completion: ([HKQuantityType : HKUnit], NSError?) -> Void)`
	/// of your HealthKit Helper Singlton in your actual implementation.
	/// This way you'll be presenting units in your users prefered format.
	private var userPreferredUnits: [HKQuantityType : HKUnit]?
	/// Some Default Unit Types so we have some initial UnitTypes to work with.
	private let defaultUnits: [HKQuantityType : HKUnit] = [
		stepCountType: HKUnit(fromString: "count"),
		dietaryEnergyType: HKUnit(fromString: "kcal"),
		activeEnergyType: HKUnit(fromString: "kcal"),
		bodyFatPercentageType: HKUnit(fromString: "%"),
		bloodGlucoseType: HKUnit(fromString: "mg/dL"),
		bodyMassType: HKUnit(fromString: "lb"),
		bodyMassIndexType: HKUnit(fromString: "count"),
		walkingRunningDistanceType: HKUnit(fromString: "mi"),
		heartRateType: HKUnit(fromString: "count/min")
	]
}

/// More digestibly named constants for our HKQuantityTypes
let stepCountType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)!
let dietaryEnergyType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryEnergyConsumed)!
let activeEnergyType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned)!
let bodyFatPercentageType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyFatPercentage)!
let bloodGlucoseType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBloodGlucose)!
let heartRateType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)!
let walkingRunningDistanceType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDistanceWalkingRunning)!
let bodyMassType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)!
let bodyMassIndexType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMassIndex)!


