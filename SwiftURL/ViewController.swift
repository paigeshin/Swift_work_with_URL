//
//  ViewController.swift
//  SwiftURL
//
//  Created by shin seunghyun on 2020/07/07.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

//각각의 함수가 개념들임.
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    //1. Basic URL Operation
    func basic() {
        let url = URL(string: "https://www.avanderlee.com")!
    }

    //2. Extension, unwrappedString
    func unwrappedString() {
        var unwrappedURL = URL("https://www.avanderlee.com")
        //3. Converting a URL into a String
        print(unwrappedURL.absoluteString)
    }
    
    //3. Making a URL releative to a base URL
    func relativeURL() {
        let category = "Swift"
        let baseURL = URL(string: "https://www.avanderlee.com")!
        let blogURL = URL(string: category, relativeTo: baseURL)!
        print(blogURL) //https://www.avanderlee.com
        print(blogURL.absoluteURL) //https://www.avanderlee.com/swift
    }
    
    //4. you can get the base for a certain link if the URL itself is not absolute.
    func handleAbsoluteURL() {
        let baseURL = URL(string: "https://www.avanderlee.com")!
        let absoluteURL = URL(string: "https://www.avanderlee.com")
        let relativeURL = URL(string: "swift", relativeTo: baseURL)
        print(absoluteURL?.baseURL) //이미 absoluteURL 자체가 absolute URL이기 때문에 nil 값을 반환한다.
        print(relativeURL?.baseURL) //relativeURL 같은 경우는 baseURL을 가져올 수 있다.
    }
    
    //5. Get scheme and host
    func getSchemeAndHost() {
        let swiftLeeURL = URL(string: "https://www.avanderlee.com")!
        print(swiftLeeURL.scheme) //http:// or https://
        print(swiftLeeURL.host) //www.avanderlee.com
        
    }
    
    //6. Working with URL Components
    func analyzeComponent() {
        let twitterAvatarURL = URL(string: "https://twitter.com/twannl/photo.png?width=200&height=200")!
        print(twitterAvatarURL.path) // /twannl/photo.png
        print(twitterAvatarURL.pathComponents) //  ["/", "tawnnl", "photo.png"]
        print(twitterAvatarURL.pathExtension) // png
        print(twitterAvatarURL.lastPathComponent) // photo.png
    }
    
    //7. Get the value of query parameter
    func getQueryParamater() {
        let components = URLComponents(string: "https://twitter.com/twannl/photo.png?width=200&height=200")
        print(components?.query) // width=200&height=200
        print(components?.queryItems) // [width=200, height=200]
    }
    
    //8. loop throguh query items array
    func loopQueryItems() {
        let components = URLComponents(string: "https://twitter.com/twannl/photo.png?width=200&height=200")
        let width = components?.queryItems?.first(where: { queryItem -> Bool in
            return queryItem.name == "width"
        })!.value!
        let height = components?.queryItems?.first(where: { (queryItem) -> Bool in
            return queryItem.name == "height"
        })!.value!
        let imageSize = CGSize(width: Int(width!)!, height: Int(height!)!)
        print(imageSize)
    }
    
    //9. Constructuring a URL with `parameters`
    func constructURLParameters() {
        let parameters = [
            "width": 500,
            "height": 500
        ]
        var avatarURLComponents = URLComponents(string: "https://twitter.com/twannl/photo.png")!
        avatarURLComponents.queryItems = parameters.map({(key, value) -> URLQueryItem in
            return URLQueryItem(name: key, value: String(value))
        })
        print(avatarURLComponents.url!) // Prints: https://twitter.com/twannl/photo.png?width=500&height=500
    }
 
    //10. Use Extension to construct a URL with `parameters
    func constructURLParametersWithExtensionFuction() {
        let pagingParameters = [
            "offset": 2,
            "limit": 50
        ]
        var twitterFeedURLComponents = URLComponents(string: "https://twitter.com/feed")!
        twitterFeedURLComponents.queryItems = .init(pagingParameters)
        print(twitterFeedURLComponents.url!) // Prints: https://twitter.com/feed?offset=2&limit=50
    }
    
    //11. Working with file URLs
    func workingWithFileURL() {
        var remoteFileURL = URL(string: "https://www.twitter.com/avatar.jpg")!
        var fileURL = URL(string: "file:///users/anotine/avatar.jpg")!
        print(remoteFileURL.isFileURL) // false
        print(fileURL.isFileURL) // true
        
        //getting extension
        print(fileURL.pathExtension) //jpg
        //getting file name
        print(fileURL.deletingPathExtension().lastPathComponent) // prints: avatar
        
    }
    
}

//2. Extension
extension URL {
    
    init(_ string: StaticString) {
        self.init(string: "\(string)")!
    }
    
    
}


//10. Extension
extension Array where Element == URLQueryItem {
    init<T: LosslessStringConvertible>(_ dictionary: [String: T]) {
        self = dictionary.map({(key, value) -> Element in
            return URLQueryItem(name: key, value: String(value))
        })
    }
}
