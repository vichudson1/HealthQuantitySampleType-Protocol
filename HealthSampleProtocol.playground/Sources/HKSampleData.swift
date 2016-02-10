import Foundation
import HealthKit

//: HKQuantity Samples to work with
public let hrSample = HKQuantitySample(
	type: heartRateType,
	quantity: HKQuantity(unit: HKUnit(fromString: "count/min"), doubleValue: 90),
	startDate: NSDate(),
	endDate: NSDate())

public let distanceSample = HKQuantitySample(
	type: walkingRunningDistanceType,
	quantity: HKQuantity(unit: HKUnit(fromString: "mi"), doubleValue: 6.345),
	startDate: NSDate(),
	endDate: NSDate())

public let weightSample = HKQuantitySample(
	type: bodyMassType,
	quantity: HKQuantity(unit: HKUnit(fromString: "lb"), doubleValue: 162.3),
	startDate: NSDate(),
	endDate: NSDate())

public let bodyFatSample = HKQuantitySample(
	type: bodyFatPercentageType,
	quantity: HKQuantity(unit: HKUnit(fromString: "%"), doubleValue: 22.3),
	startDate: NSDate(),
	endDate: NSDate())


public let bmiSample = HKQuantitySample(
	type: bodyMassIndexType,
	quantity: HKQuantity(unit: HKUnit(fromString: "count"), doubleValue: 28.4),
	startDate: NSDate(),
	endDate: NSDate())

public let glucoseSample = HKQuantitySample(
	type: bloodGlucoseType,
	quantity: HKQuantity(unit: HKUnit(fromString: "mg/dL"), doubleValue: 86),
	startDate: NSDate(),
	endDate: NSDate())

public let activeEnergySample = HKQuantitySample(
	type: activeEnergyType,
	quantity: HKQuantity(unit: HKUnit(fromString: "kcal"), doubleValue: 220.2),
	startDate: NSDate(),
	endDate: NSDate())

public let foodSample = HKQuantitySample(
	type: dietaryEnergyType,
	quantity: HKQuantity(unit: HKUnit(fromString: "kcal"), doubleValue: 189.6),
	startDate: NSDate(),
	endDate: NSDate())

public let stepSample = HKQuantitySample(
	type: stepCountType,
	quantity: HKQuantity(unit: HKUnit(fromString: "count"), doubleValue: 3_042),
	startDate: NSDate(),
	endDate: NSDate())