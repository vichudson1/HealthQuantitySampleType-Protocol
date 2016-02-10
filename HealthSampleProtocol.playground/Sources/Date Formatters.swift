import Foundation

public let dateFormatter: NSDateFormatter = {
	let formatter = NSDateFormatter()
	formatter.dateStyle = .ShortStyle
	formatter.timeStyle = .NoStyle
	formatter.doesRelativeDateFormatting = true
	return formatter
}()

public let timeFormatter: NSDateFormatter = {
	let formatter = NSDateFormatter()
	formatter.dateStyle = .NoStyle
	formatter.timeStyle = .ShortStyle
	formatter.doesRelativeDateFormatting = true
	return formatter
}()

public let dateTimeFormatter: NSDateFormatter = {
	let formatter = NSDateFormatter()
	formatter.dateStyle = .ShortStyle
	formatter.timeStyle = .ShortStyle
	return formatter
}()
