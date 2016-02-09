import Foundation
import HealthKit

//: HKQuantity Samples to work with
public let hrSample = HKQuantitySample(
	type: HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)!,
	quantity: HKQuantity(unit: HKUnit(fromString: "count/min"), doubleValue: 90),
	startDate: NSDate(),
	endDate: NSDate())

public let distanceSample = HKQuantitySample(
	type: HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDistanceWalkingRunning)!,
	quantity: HKQuantity(unit: HKUnit(fromString: "mi"), doubleValue: 6.345),
	startDate: NSDate(),
	endDate: NSDate())

public let weightSample = HKQuantitySample(
	type: HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)!,
	quantity: HKQuantity(unit: HKUnit(fromString: "lb"), doubleValue: 162.3),
	startDate: NSDate(),
	endDate: NSDate())

public let bodyFatSample = HKQuantitySample(
	type: HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyFatPercentage)!,
	quantity: HKQuantity(unit: HKUnit(fromString: "%"), doubleValue: 22.3),
	startDate: NSDate(),
	endDate: NSDate())


public let bmiSample = HKQuantitySample(
	type: HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMassIndex)!,
	quantity: HKQuantity(unit: HKUnit(fromString: "count"), doubleValue: 28.4),
	startDate: NSDate(),
	endDate: NSDate())

public let glucoseSample = HKQuantitySample(
	type: HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBloodGlucose)!,
	quantity: HKQuantity(unit: HKUnit(fromString: "mg/dL"), doubleValue: 86),
	startDate: NSDate(),
	endDate: NSDate())

public let activeEnergySample = HKQuantitySample(
	type: HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned)!,
	quantity: HKQuantity(unit: HKUnit(fromString: "kcal"), doubleValue: 220.2),
	startDate: NSDate(),
	endDate: NSDate())

public let foodSample = HKQuantitySample(
	type: HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryEnergyConsumed)!,
	quantity: HKQuantity(unit: HKUnit(fromString: "kcal"), doubleValue: 189.6),
	startDate: NSDate(),
	endDate: NSDate())

public let stepSample = HKQuantitySample(
	type: HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)!,
	quantity: HKQuantity(unit: HKUnit(fromString: "count"), doubleValue: 3_042),
	startDate: NSDate(),
	endDate: NSDate())