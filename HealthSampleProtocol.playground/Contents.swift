//: A protocol driven, value type based approache to quickly displaying HKQuantitySamples in your UI

import HealthKit

/**
	A simple struct that we'll store our HKSamples in that conforms to HealthQuantitySample & CustomStringConvertible protocols
	- Note: The sample variable is an optional. If you init an empty instance of your struct, `HealthSample()`, it will simply output "--" when cast into a string. This way you can set up your UI and update the HKSample in your type with the results of an HKQuery later.

*/
struct HealthSample: HealthQuantitySample, CustomStringConvertible {
	var sample: HKQuantitySample?
}

var heartrate = HealthSample() // An empty Sample
var walkingDistance = HealthSample(sample: distanceSample) // Walking Distance
var bodyWeight = HealthSample(sample: weightSample) // Bodyweight
var bodyFat = HealthSample(sample: bodyFatSample)
var bmi = HealthSample(sample: bmiSample)
var glucose = HealthSample(sample: glucoseSample)
var redRingSample = HealthSample(sample: activeEnergySample)
var food = HealthSample(sample: foodSample)
var steps = HealthSample()

// Outputting values as strings
String(heartrate)
// Add an HK Sample to our HealthSample
heartrate.sample = hrSample
String(heartrate)

steps.sample = stepSample
String(steps)

// Accessing some of our free sample properties from the protocol extension
heartrate.value
heartrate.date


//Other Samples
String(walkingDistance)
walkingDistance.value
String(bodyWeight)
bodyWeight.value
String(bodyFat)
String(bmi)
String(glucose)
String(redRingSample)
String(food)



