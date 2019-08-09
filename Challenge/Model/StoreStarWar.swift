//
//  StoreStarWar.swift
//  PhunChallenge
//
//  Created by Chang Choi on 8/3/19.
//  Copyright © 2019 solechang. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class StoreStarWar: Object, Decodable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var descriptions: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var timestamp: String = ""
    @objc dynamic var image: String?
    @objc dynamic var date: String = ""
    @objc dynamic var phone: String?
    @objc dynamic var locationline1: String = ""
    @objc dynamic var locationline2: String = ""
    
    private enum StoreStarWarKeys: String, CodingKey {
        case id, descriptions = "description", title, timestamp, image, date, phone, locationline1, locationline2
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StoreStarWarKeys.self)
        
        let id = try container.decode(Int.self, forKey: .id)
        let descriptions = try container.decode(String.self, forKey: .descriptions)
        
        let title = try container.decode(String.self, forKey: .title)
        let timestamp = try container.decode(String.self, forKey: .timestamp)
        let image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        let phone = try container.decodeIfPresent(String.self, forKey: .phone) ?? ""
        let date = try container.decode(String.self, forKey: .date)
        let locationline1 = try container.decode(String.self, forKey: .locationline1)
        let locationline2 = try container.decode(String.self, forKey: .locationline2)
        
        self.init(id: id, descriptions: descriptions, title: title, timestamp: timestamp, image: image, phone: phone, date: date, locationline1: locationline1, locationline2: locationline2)

    }
   
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int, descriptions: String, title: String, timestamp: String, image: String, phone: String, date: String, locationline1: String, locationline2: String) {
        
        self.init()
        
        self.id = id
        self.descriptions = descriptions
        self.title = title
        self.timestamp = timestamp.toLocalTime()
        self.image = image
        self.phone = phone
        self.date = date.toLocalTime()
        self.locationline1 = locationline1
        self.locationline2 = locationline2
 
    }

    init(starwar: StoreStarWar) {
        self.id = starwar.id
        self.descriptions = starwar.descriptions
        self.title = starwar.title
        self.timestamp = starwar.timestamp
        self.image = starwar.image ?? ""
        self.phone = starwar.phone ?? ""
        self.date = starwar.date
        self.locationline1 = starwar.locationline1
        self.locationline2 = starwar.locationline2
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
        
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
}

extension String {
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.init(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        guard let dateObj = dateFormatter.date(from: self) else {
            return ""
        }
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "MMMM d, yyyy 'at' h:mm a"
        
        return dateFormatter.string(from: dateObj)
    }
    
}
