//
//  BLogic.swift
//  MindTeckProjectByPavan
//
//  Created by Pavankumar Tupale on 02/12/21.
//

import Foundation
import UIKit

class BLogic: NSObject {
    
    var userDataModelObject = [[UserDataModel]]()
    var counter = 0
    var isSearch : Bool = false
    var imgArr = [  UIImage(named:"car1"),
                    UIImage(named:"car2") ,
                    UIImage(named:"car3") ]

    
    func craeteDataForUser(count: Int) {
        userDataModelObject = [[UserDataModel]]()
        
        for j in 1...imgArr.count {
            var tempObject = [UserDataModel]()
            for i in 0..<j*2 {
                if i.isMultiple(of: 2) {
                    tempObject.append(UserDataModel.init(userName: "MindTeck", image: UIImage.init(named: "mindteck.png")!))
                }else {
                    tempObject.append(UserDataModel.init(userName: "Teck", image: UIImage.init(named: "mindteck.png")!))
                }
            }
            userDataModelObject.append(tempObject)
        }
        

    }
}
