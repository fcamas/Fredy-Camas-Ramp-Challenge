/*
 Hello! Thank you for taking the time to complete our
 coding challenge. There are 3 challenges, each on a
 separate page. The clue derived from each page will
 provide instructions for the next challenge.

 When you are done, please rename this playground to
 "first-last Ramp Challenge.playground" and submit it to
 ios-submissions@ramp.com.

 We recommend turning "Editor > Show Rendered Markup"
 on for a classier experience.

 Good Luck!

 - The Ramp Mobile Team

 */

// = = = = = = = = = = = = = = = = = = = = = = = =

//: [Challenge 2](@previous)
//: #### Challenge 3
//: Get the prompt from Challenge 2 and paste it below.
//: Solve the challenge, and take a screenshot of the rendered view.
//: Include the screenshot of the view in your submission!

import Foundation
import SwiftUI
import PlaygroundSupport

let prompt = """
Solve challenge 2 to get the prompt and paste it here.

Nice Work! For the final challenge, update ContentView.body to display a smiley face using only native SwiftUI views (no Sf Symbols or emojis). Be creative and have fun! Don't forget to submit a screenshot of your view with the completed playground.

"""

// Show your work here! When you are done take a screenshot
// of the end result and follow the submission instructions above.
// Include the screenshot of the view in your submission!


PlaygroundPage.current
    .needsIndefiniteExecution = true
PlaygroundPage.current
    .setLiveView(ContentView())

struct ContentView: View {
    @State private var showCircle = false
    
    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .strokeBorder(.black, lineWidth: 5)
                .frame(width: 200, height: 200)
                .foregroundColor(.white)
                .overlay {
                    VStack {
                        smileyEyesRow()
                            .foregroundColor(.black)
                            .padding(.top, 30)
                            .overlay{
                                smileyEyesRow()
                                    .foregroundColor(.white)
                                    .padding(.top, 60)
                            }
                        
                        // Smiley mouth
                        Circle()
                            .trim(from: 0, to: 0.5)
                            .rotation(.degrees(-5))
                            .foregroundColor(.black)
                            .frame(width: 80, height: 50)
                            .padding(.bottom, 20)
                    }
                }
        }
    }
    
    @ViewBuilder
    private func smileyEyesRow() -> some View {
        HStack {
            // Left eye
            smileyEye()
            
            // Right eye
            smileyEye()
        }
    }
    
    @ViewBuilder
    private func smileyEye() -> some View {
        Circle()
            .overlay {
                // Eye pupil
                Circle()
                    .foregroundColor(.black)
                    .frame(width: 50, height: 50)
            }
    }
}


