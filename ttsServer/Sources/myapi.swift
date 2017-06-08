import Foundation
import Kitura
import SwiftyJSON

class MyApi {
    
    var parameters = [String:String]()

    var router: Router?
    
    init() {
        //let viewCont = ViewController()
        self.router = Router()
        router?.all(middleware: BodyParser())
    }
    
    func myApiRoutes() -> Router {
      
        //POST REQUEST
        router?.post("/") { request, response, next in
            
            guard let postData = request.body else {next(); return}
            
            switch (postData) {
                
            case .json(let jsonData):
                let sourceLang = jsonData["source"].string ?? ""
                let targetLang = jsonData["target"].string ?? ""
                let textToTranslate = jsonData["text"].string ?? ""
                if sourceLang == "English" {
                    self.parameters["source"] = "en"
                    //response.send("en")
                }
                if targetLang == "Spanish" {
                    self.parameters["target"] = "es"
                    //response.send("es")
                }
                if textToTranslate == "Hello" {
                    self.parameters["text"] = "Hello"
                    //response.send("Hello")
                }
                //print(self.parameters)
            default:
                try response.send("Default").end()
            }
            
            self.callWatson(parameters: self.parameters)
            print("Returned")
        }
        print("Returned")
        return router!
    }
    
    func callWatson ( parameters: ([String:String]) ) {
        print(parameters)
        guard let url = URL(string: "https://watson-api-explorer.mybluemix.net/language-translator/api/v2/translate") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            //print(type(response))
            if let response = response {
                print(response)
            }
            
            if let data = data {
                self.formatData(data: data)
            }
        }.resume()
    
    
    return
    }
    
    func formatData(data: Data) {
        print("$$$$$ Data: ")
        print(data)
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            if let translation = json["translations"]  {
                for index in 0...translation.count-1 {
                    let aObject = translation[index] as! [String : AnyObject]
                    let something = String(describing: aObject)
                    //cut out useless characters from JSON response
                    let tempStr = String(something.characters.dropLast(1))
                    let finalStr = String(tempStr.characters.dropFirst(16))
                    print("final STRING: \(finalStr)")
                }
            }
            
        }
        catch {
            print(error)
        }

    }
}
