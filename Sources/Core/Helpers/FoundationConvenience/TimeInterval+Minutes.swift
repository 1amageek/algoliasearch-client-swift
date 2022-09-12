//
//  TimeInterval+Minutes.swift
//  
//
//  Created by Vladislav Fitc on 19/02/2020.
//

import Foundation


extension TimeInterval {
    
    public static func hours(_ hoursCount: Int) -> TimeInterval {
        return TimeInterval(hoursCount) * 60 * 60
    }
    
}

extension TimeInterval {
    
    public static func minutes(_ minutesCount: Int) -> TimeInterval {
        return TimeInterval(minutesCount) * 60
    }
}

extension TimeInterval {
    
    public static func seconds(_ secondsCount: Int) -> TimeInterval {
        return TimeInterval(secondsCount)
    }
}

extension TimeInterval {

    public static func days(_ daysCount: Int) -> TimeInterval {
        return TimeInterval(daysCount) * 60 * 60 * 24
    }
}
