//
//  CNContact+Helpers.swift
//  ContactDestroyer🛳
//
//  Created by Gero Embser on 25.04.18.
//  Copyright © 2018 Gero Embser. All rights reserved.
//

import Foundation
import Contacts

extension CNContact {
    ///Returns a mutable representation of the receiver.
    func asMutableContact() -> CNMutableContact {
        if let mutable = self as? CNMutableContact {
            return mutable
        }
        
        return self.mutableCopy() as! CNMutableContact
    }
}
