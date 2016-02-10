//: A protocol driven, value type based approache to quickly displaying HKQuantitySamples in your UI

import HealthKit

/**
	A simple struct that we'll store our HKSamples in that conforms to HealthQuantitySample & CustomStringConvertible protocols. You can view the protocol in the sources folder.
	- Note: The sample variable is an optional. If you init an empty instance of your struct, `HealthSample()`, it will simply output "--" when cast into a string. This way you can set up your UI and update the HKSample in your type with the results of an HKQuery later.

*/
struct HealthSample: HealthQuantitySampleType, CustomStringConvertible {
	var sample: HKQuantitySample?
}

// lets create a bunch of samples to play with
// The HKQuantity Samples used are defined in the sources folder
var heartrate = HealthSample() // An empty Sample
var walkingDistance = HealthSample(sample: distanceSample) // Walking Distance
var bodyWeight = HealthSample(sample: weightSample) // Bodyweight
var bodyFat = HealthSample(sample: bodyFatSample) // body fat %
var bmi = HealthSample(sample: bmiSample) // Body Mass Index
var glucose = HealthSample(sample: glucoseSample) // Blood Glucose
var redRingSample = HealthSample(sample: activeEnergySample) // active energy calories
var food = HealthSample(sample: foodSample) // dietary calories
var steps = HealthSample() // a step count

// Outputting values as strings
String(heartrate)
// Add an HK Sample to our HealthSample
heartrate.sample = hrSample
String(heartrate)

// lets add some steps to our stepcount
steps.sample = stepSample
String(steps)

// Accessing some of our free sample properties from the protocol extension
heartrate.value
heartrate.valueLabel
heartrate.date
heartrate.dateString
heartrate.timeString
heartrate.dateAndTimeString


// Demo some other samples types
String(walkingDistance)
String(bodyWeight)
String(bodyFat)
String(bmi)
String(glucose)
glucose.valueLabel
String(redRingSample)
String(food)
