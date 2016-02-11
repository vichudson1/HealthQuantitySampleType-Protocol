import Foundation

// Formatters
let numberFormatter: NSNumberFormatter = {
	let formatter = NSNumberFormatter()
	formatter.maximumFractionDigits = 1
	formatter.numberStyle = .DecimalStyle
	return formatter
}()

let integerFormatter: NSNumberFormatter = {
	let formatter = NSNumberFormatter()
	formatter.maximumFractionDigits = 0
	formatter.numberStyle = .DecimalStyle
	return formatter
}()

let weightFormatter: NSMassFormatter = {
	let formatter = NSMassFormatter()
	formatter.forPersonMassUse = true
	formatter.numberFormatter.maximumFractionDigits = 1
	return formatter
}()

let distanceFormatter: NSLengthFormatter = {
	let formatter = NSLengthFormatter()
	formatter.numberFormatter.maximumFractionDigits = 2
	return formatter
}()

let calorieFormatter: NSEnergyFormatter = {
	let formatter = NSEnergyFormatter()
	formatter.forFoodEnergyUse = true
	formatter.numberFormatter = numberFormatter
	return formatter
}()
