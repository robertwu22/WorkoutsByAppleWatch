//
//  ContentView.swift
//  MyWorkouts WatchKit Extension
//
//  Created by Robert Wu on 01/08/22.
//

import SwiftUI
import HealthKit

struct StartView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    var workoutTypes: [HKWorkoutActivityType] = [.cycling, .running, .walking]
    
    var body: some View {
        List(workoutTypes) { workoutType in
            NavigationLink(
                workoutType.name,
                destination: SessionPagingView(),
                tag: workoutType,
                selection: $workoutManager.selectedWorkout
            ).padding( EdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 5) )
        }
        .listStyle(.carousel)
        .navigationBarTitle("Workouts")
        .onAppear {
            workoutManager.requestAuthorization()
        }
    }
}

/*struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}*/

extension HKWorkoutActivityType: Identifiable {
    public var id: UInt {
        rawValue
    }
    
    var name: String {
        switch self {
        case .running:
            return "Run ✓"
        case .cycling:
            return "Bike 🚲"
        case .walking:
            return "Walk 🚶"
        default:
            return ""
        }
    }
}
