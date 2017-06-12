import Foundation
import Kitura
import SwiftyJSON

class MyApi {
    
    var parameters = [String:String]()
    var str = ""

    var router: Router?
    
    init() {
        self.router = Router()
        router?.all(middleware: BodyParser())
    }
    
    func callWatson (completionHandler: @escaping (String)->(), parameters: ([String:String]) ) -> String {
        
        print(parameters)
        guard let url = URL(string: "https://watson-api-explorer.mybluemix.net/language-translator/api/v2/translate") else {return "error"}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return "error"}
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if response != nil {
                print("There is a response, but it is too long and annoying to view in the console. ")
            }
            
            if let data = data {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
                    if let translation = json["translations"]  {
                        for index in 0...translation.count-1 {
                            let aObject = translation[index] as! [String : AnyObject]
                            let something = String(describing: aObject)
                            //cut out useless characters from JSON response
                            let tempStr = String(something.characters.dropLast(1))
                            let finalStr = String(tempStr.characters.dropFirst(16))
                            completionHandler(finalStr)
                        }
                    }
                    
                }
                catch {
                    print(error)
                }
                
                          }
            }.resume()
        return "error"
    }
    
    func myApiRoutes() -> Router {
      
        //POST REQUEST
        router?.post("/translate") { request, response, next in
            
//            guard let body = request.body,
//                let json = body.asJSON,
//            let name = json["text"].string
//            else {
//                try response.status(.badRequest).end()
//                return
//            }
//            
//            response.send(name)
//            next()
            
            guard let postData = request.body else {next(); return}
            
            switch (postData) {
                
            case .json(let jsonData):
                let sourceLang = jsonData["source"].string ?? ""
                let targetLang = jsonData["target"].string ?? ""
                let textToTranslate = jsonData["text"].string ?? ""
                if sourceLang == "English" {
                    self.parameters["source"] = "en"
                }
                if targetLang == "Spanish" {
                    self.parameters["target"] = "es"
                }
                if textToTranslate == "something cool" {
                    self.parameters["text"] = textToTranslate
                }
            default:
                try response.send("Default").end()
            }
            
            let pfd = MyApi()
            pfd.callWatson(completionHandler: { (jsonString) in
                response.send(jsonString)
            }, parameters: self.parameters)
            
        }
        return router!
    }
    
    
}
