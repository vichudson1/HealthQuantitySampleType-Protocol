# HealthQuantitySampleType-Protocol:
A protocol oriented approach to making HKQuantity Samples easy to display in your UI.

Full example use is in the playground. The protocol and supporting extensions are in the sources folder along with files containing the constant formatters used by the protocol, because hey, formatter creation is expensive, right? There is also a file with some sample HKQuantitySamples defined to play with in the playground.

I've also pulled some of the original methods from the protocol extension, and placed them into a new Value Type because they could be really useful in contexts out side of the protocol defined here. See HealthKitUnitTypeManager in HealthKitUnitTypeManager.swift in the sources folder.

#Usage:
Create a struct that confirms to HealthQuantitySampleType & CustomStringConvertable. Init an instance with an HKQUantitySample, or without one and add the sample to it later. Your struct will then get several free properties to pull user friendly strings for the property values of the HKSample to display in your UI, without haveing to deal with converting the values and unit types of the HKQuantitySample. After creating your sample instance and giving it an HKQuantity Sample just cast it into a string to get the user friendly UI String for your sample. String(hrSample) // 77 bpm

#Supported Properties of the protocol:
* value: Double - A Double representation of your samples value
* date: NSDate - The Sample Start Date
* type: HKQuantityType - The Sample Type
* integerValue: Int - The sample value rounded to the nearest Integer
* timeString: String - A formatted string with the time of your sample.
* dateString: String - A formatted string with the date of your sample.
* dateAndTimeString: String - A formatted string with the date & time of your sample.
