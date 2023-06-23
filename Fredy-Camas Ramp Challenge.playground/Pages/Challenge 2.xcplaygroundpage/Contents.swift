/*
 Hello! Thank you for taking the time to complete our
 coding challenge. There are 3 challenges, each on a
 separate page. The clue derived from each page will
 provide instructions for the next challenge.

 We recommend turning "Editor > Show Rendered Markup"
 on for a classier experience.

 When you are done, please rename this playground to
 "first-last Ramp Challenge.playground" and submit it to
 ios-submissions@ramp.com.

 Good Luck!

 - The Ramp Mobile Team

 */

// = = = = = = = = = = = = = = = = = = = = = = = =

//: [Challenge 1](@previous)
//: #### Challenge 2
//: Get the prompt from Challenge 1 and paste it below.
//: Solve the challenge to get the prompt for Challenge 3.

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let prompt = """
Solve challenge 1 to get the prompt and paste it here.

Great job!

Next we've hosted a JSON file at at this url: https://api.jsonbin.io/v3/b/646bed328e4aa6225ea22a79. Your job is to write a script to
download the contents of the URL (hint: The X-ACCESS-KEY is $2b$10$Ke1iwieFO7/7qsSKU.GYU.oYXZMW1EeHrwd4xx9ylboJik5mstZk6)
sort the data by each elements 'bar' key
filter out elements where 'baz' is not divisible by 3
concatenate each elements 'foo' value

Do each of these steps to reveal the instructions for the final part. Remember to show your work!
"""

// Show your work here! When you are done move on to Challenge 3

let semaphore = DispatchSemaphore(value: 0)

struct DataItem: Codable {
    let foo: String
    let bar: Int
    let baz: Int
}

struct Record: Codable {
    var data: [DataItem]
}

struct Response: Codable {
    var record: Record
}


class CallingAPI: ObservableObject {
    
     var dataMain:Response?
    var sortDataMain:Response?
    
    init() {
        fetchDessert()
    }
    
    let urlString = "https://api.jsonbin.io/v3/b/646bed328e4aa6225ea22a79"
    let accessKeyString = "$2b$10$Ke1iwieFO7/7qsSKU.GYU.oYXZMW1EeHrwd4xx9ylboJik5mstZk6"

    func fetchDessert() {
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL.")
        }

        var request = URLRequest(url: url)
        request.setValue(accessKeyString, forHTTPHeaderField: "X-ACCESS-KEY")

        URLSession.shared.fetchData(for: request) { (result: Result<Response, Error>) in
            switch result {
                
            case .success(let response):
                
                 
               // DispatchQueue.main.async {
                    self.dataMain = response
                    self.sortDataMain = response
                    
                //}
                
                // Step 2: Sort the data by 'bar' key
                let sortedData = self.sortDataMain?.record.data.sorted(by: { $0.bar < $1.bar })
                self.sortDataMain?.record.data = sortedData ?? []
                
                
               //Step 3: filter out elements where 'baz' is not divisible by 3
                let filteredData = self.sortDataMain?.record.data.filter({ $0.baz % 3 == 0 })
                self.sortDataMain?.record.data = filteredData ?? []
                
                //Step 4: concatenate each elements 'foo' value
                let concatenatedString = self.sortDataMain?.record.data.reduce("", { $0 + $1.foo })
                print("\(concatenatedString ?? "")")
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
  
}


extension URLSession {
    
    func fetchData<T: Decodable>(for request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        // Perform data task with the provided request
        self.dataTask(with: request) { (data, response, error) in
            
            // Check for any error during the request
            if let error = error {
                completion(.failure(error))
                return
            }

            // Ensure that data is not nil
            guard let data = data else {
                // If data is nil, create and return a failure result with an NSError
                completion(.failure(NSError(domain: "Data is nil", code: -1, userInfo: nil)))
                return
            }

            do {
                // Decode the data using JSONDecoder and the specified type 'T'
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch let decoderError {
                // If there's an error during decoding, return a failure result with the error
                completion(.failure(decoderError))
            }
        }.resume()
    }
}




let Challenge2 = CallingAPI()
semaphore.wait()

//: [Challenge 3](@next)
