
import Foundation

import UIKit

import SystemConfiguration

class Request {
    
    var debug:Bool = false
    
    
    
    func post(_ url : String, params : String, controller:UIViewController, successHandler: @escaping (_ response: Data) -> Void) {
        
        if(self.internet()){
            
            let url = URL(string: url)
            
            let params = String(params);
            
            var request = URLRequest(url:url!)
            
            //let request = NSMutableURLRequest(url: url!); ¡changed!
            
            request.httpMethod = "POST" // POST
            
            request.httpBody = params?.data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(
                with: request,
                completionHandler: {
                    
                    data, response, error in
                    
                    //in case of error
                    
                    if error != nil {
                        
                        print("AN ERROR HAS OCURRED SENDING POST REQUEST!")
                        
                        print(error); return
                        
                    }
                    
                    successHandler(data!)
                    
                    
                    
            })
            
            task.resume();
            
        } else {
            
            //Utility().displayAlert(controller, title: "Alert", message: "You are no longer connected to the internet. See It Pronto requires access to the internet to provide you with accurate information", performSegue: "")
            
        }
        
    }
    
    
    func get(_ url : String, params : String, controller:UIViewController, type:Int, successHandler: @escaping (_ response: Data) -> Void) {
        
        if(self.internet()){
            
            let url = URL(string: url)
            
            let params = String(params);
            
            var request = URLRequest(url:url!)
            
            //let request = NSMutableURLRequest(url: url!); ¡changed!
            
            request.httpMethod = "GET" // POST
            
            request.httpBody = params?.data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(
                with: request,
                completionHandler: {
                    
                    data, response, error in
                    
                    //in case of error
                    
                    if error != nil {
                        
                        print("AN ERROR HAS OCURRED SENDING POST REQUEST!")
                        
                        print(error); return
                        
                    }
                    
                    successHandler(data!)
                    
            })
            
            task.resume();
            
        } else {
            
            //Utility().displayAlert(controller, title: "Alert", message: "You are no longer connected to the internet. See It Pronto requires access to the internet to provide you with accurate information", performSegue: "")
            
        }
        
    }
    
    
    func internet()->Bool {
        
        var zeroAddress = sockaddr_in()
        
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        /*guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
         
         SCNetworkReachabilityCreateWithAddress(nil, $0)
         
         }) else {
         
         return false
         
         }*/
        
        
        
        var flags : SCNetworkReachabilityFlags = []
        
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            
            return false
            
        }
        
        
        
        let isReachable = flags.contains(.reachable)
        
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
        
    }
    
}
