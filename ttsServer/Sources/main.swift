import Kitura
import HeliumLogger
import Foundation
import SwiftyJSON

HeliumLogger.use()

let router = Router()
router.post(middleware: BodyParser())
var parameters = [String:String]()
let username = "64a3ecc4-182b-47e9-a659-c580a7b5ca02"
let password = "AnnGIdp6kCU7"
let loginString = String(format: "%@:%@", username, password) //convert credential
let loginData = loginString.data(using: String.Encoding.utf8)!
let base64LoginString = loginData.base64EncodedString()

    router.post("/translates") { request, res, next in
        
        guard let body = request.body,
            let json = body.asJSON,
            let textToTranslate = json["text"].string,
            let targetLang = json["target"].string,
            let sourceLang = json["source"].string
            else {
                try res.status(.badRequest).end()
                return
        }
        
        parameters["source"] = sourceLang
        parameters["target"] = targetLang
        parameters["text"] = textToTranslate
        
        let url = URL(string: "https://gateway.watsonplatform.net/language-translator/api/v2/translate")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if response != nil {}
            
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
                            res.send(finalStr)
                        }
                    }
                    
                }
                catch {
                    print(error)
                }
                
            }
            }.resume()
        
    }

Kitura.addHTTPServer(onPort: 8080, with: router)
Kitura.run()
