import Kitura
import Foundation

let router = Router()
router.post(middleware: BodyParser())

var parameters = [String:String]()
let username = "username"
let password = "password"
let loginString = String(format: "%@:%@", username, password) //convert credential
let loginData = loginString.data(using: String.Encoding.utf8)!
let base64LoginString = loginData.base64EncodedString()

router.post("/translates") { request, res, next in
    
    guard let body = request.body,
    let json = body.asJSON, //convert to JSON
    let textToTranslate = json["text"].string,
    let targetLang = json["target"].string,
    let sourceLang = json["source"].string
    else {try res.status(.badRequest).end();return}
    
    //populate the body
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
    
    //URLSESSION POST REQUEST
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        let returnData = String(data: data!, encoding: .utf8) //data to String
        res.send(returnData!) //send response back
    }.resume()
    
}

Kitura.addHTTPServer(onPort: 8080, with: router)
Kitura.run()
