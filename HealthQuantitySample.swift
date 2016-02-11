//
//  HealthQuantitySample.swift
//  Health Up Display
//
//  Created by Victor Hudson on 2/10/16.
//  Copyright © 2016 Victor Hudson. All rights reserved.
//

import Foundation
import HealthKit

struct HealthQuantitySample: HealthQuantitySampleType, CustomStringConvertible {
	var sample: HKQuantitySample?
}