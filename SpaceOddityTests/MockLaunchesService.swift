//
//  MockLaunchesService.swift
//  SpaceOddityTests
//
//  Created by Rajeev Bhatia on 09/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation
@testable import SpaceOddity

class MockLaunchesService: LaunchesServiceable {
    
    private let responseString: String
    init(responseString: String = MockLaunches.successResponseString) {
        self.responseString = responseString
    }
    
    func fetchLaunches(completion: @escaping (Result<LaunchesResponse, ConnectionError>) -> Void) {
        
        guard let responseData = responseString.data(using: .utf8) else {
            completion(.failure(.couldNotGetDetails))
            return
        }
        
        guard let launchesResponse: LaunchesResponse = Parser.decode(data: responseData) else {
            completion(.failure(.couldNotGetDetails))
            return
        }
        
        completion(.success(launchesResponse))
    }
    
    
}

struct MockLaunches {
    static let failureResponseString = "this cannot be parsed"
    static let successResponseString = #"{"launches":[{"id":1200,"name":"Falcon 9 Block 5 | RADARSAT Constellation","windowstart":"June 12, 2019 14:17:00 UTC","windowend":"June 12, 2019 14:17:00 UTC","net":"June 12, 2019 14:17:00 UTC","wsstamp":1560349020,"westamp":1560349020,"netstamp":1591974000,"isostart":"20190612T141700Z","isoend":"20190612T141700Z","isonet":"20190612T141700Z","status":1,"inhold":0,"tbdtime":0,"vidURLs":[],"vidURL":null,"infoURLs":[],"infoURL":null,"holdreason":null,"failreason":null,"tbddate":0,"probability":-1,"hashtag":null,"changed":"2019-06-05 23:03:26","location":{"pads":[{"id":100,"name":"Space Launch Complex 4E, Vandenberg AFB, CA","infoURL":"","wikiURL":"","mapURL":"http://maps.google.com/maps?q=34.632+N,+120.611+W","latitude":34.632,"longitude":-120.611,"agencies":[]}],"id":18,"name":"Vandenberg AFB, CA, USA","infoURL":"","wikiURL":"","countryCode":"USA"},"rocket":{"id":188,"name":"Falcon 9 Block 5","configuration":"9 Block 5","familyname":"Falcon","agencies":[{"id":121,"name":"SpaceX","abbrev":"SpX","countryCode":"USA","type":3,"infoURL":null,"wikiURL":"http://en.wikipedia.org/wiki/SpaceX","changed":"2017-02-21 00:00:00","infoURLs":["http://www.spacex.com/","https://twitter.com/SpaceX","https://www.youtube.com/channel/UCtI0Hodo5o5dUb67FeUjDeA"]}],"wikiURL":"https://en.wikipedia.org/wiki/Falcon_9_Full_Thrust#Block_5","infoURLs":["http://www.spacex.com/falcon9"],"infoURL":"http://www.spacex.com/falcon9","imageSizes":[320,480,640,720,768,800,960,1024,1080,1280,1440,1920],"imageURL":"https://s3.amazonaws.com/launchlibrary/RocketImages/Falcon9Block5.jpg_1920.jpg"},"missions":[{"id":1198,"name":"RADARSAT Constellation","description":"The Radarsat Constellation Mission is a follow-on project to RADARSAT-2 currently developed by MDA. The constellation will consist of a fleet of three spacecraft, and be both complementary and a follow-on to the upcoming deployment of the RADARSAT-2 mission. The primary purpose of the RCM is to provide C-Band data continuity for RADARSAT-2 users, as well as adding a new series of applications enabled through the constellation approach.\n\nThe main uses of RCM are expected to be in the areas of: maritime surveillance (ship detection, ice monitoring, and oil spill detection), disaster management, ecosystem monitoring.\n\nThe primary areas of interest are the landmass of Canada and its surrounding Arctic, Pacific and Atlantic maritime areas. The images and derived information are required to be provided to Canadian government users at frequent area coverage rates. Contrary to the earlier RadarSat missions, the imagery will not be available commercially.\n\nThe spacecraft Payload will consist of a Synthetic Aperture Radar (SAR) sensor integrated with an Automated Identification System (AIS). The SAR Payload concept is a 2-panel deployable SAR antenna of length approximately 7 meters.","type":1,"wikiURL":"https://en.wikipedia.org/wiki/RADARSAT_Constellation","typeName":"Earth Science","agencies":[{"id":16,"name":"Canadian Space Agency","abbrev":"CSA","countryCode":"CAN","type":1,"infoURL":null,"wikiURL":"http://en.wikipedia.org/wiki/Canadian_Space_Agency","changed":"2017-02-21 00:00:00","infoURLs":["http://asc-csa.gc.ca/eng/","https://twitter.com/csa_asc","https://www.facebook.com/CanadianSpaceAgency","https://www.instagram.com/canadianspaceagency/","https://www.linkedin.com/company/9441729/"]}],"payloads":[{"id":441,"name":"RADARSAT Constellation Mission"}]}],"lsp":{"id":121,"name":"SpaceX","abbrev":"SpX","countryCode":"USA","type":3,"infoURL":null,"wikiURL":"http://en.wikipedia.org/wiki/SpaceX","changed":"2017-02-21 00:00:00","infoURLs":["http://www.spacex.com/","https://twitter.com/SpaceX","https://www.youtube.com/channel/UCtI0Hodo5o5dUb67FeUjDeA"]}},{"id":1343,"name":"Ariane 5 ECA | Eutelsat 7C & AT&T T-16","windowstart":"June 20, 2019 21:43:00 UTC","windowend":"June 20, 2019 23:30:00 UTC","net":"June 20, 2019 21:43:00 UTC","wsstamp":1561066980,"westamp":1561073400,"netstamp":1561066980,"isostart":"20190620T214300Z","isoend":"20190620T233000Z","isonet":"20190620T214300Z","status":1,"inhold":0,"tbdtime":0,"vidURLs":["http://www.arianespace.com/mission/ariane-flight-va248/"],"vidURL":null,"infoURLs":[],"infoURL":null,"holdreason":null,"failreason":null,"tbddate":0,"probability":-1,"hashtag":null,"changed":"2019-06-08 12:57:52","location":{"pads":[{"id":137,"name":"Ariane Launch Area 3, Kourou","infoURL":"http://www.esa.int/Our_Activities/Launchers/Europe_s_Spaceport/Europe_s_Spaceport2","wikiURL":"http://en.wikipedia.org/wiki/ELA-3","mapURL":"https://www.google.com/maps/?q=5.239,-52.769","latitude":5.239,"longitude":-52.768,"agencies":[]}],"id":3,"name":"Kourou, French Guiana","infoURL":"","wikiURL":"","countryCode":"GUF"},"rocket":{"id":27,"name":"Ariane 5 ECA","configuration":"ECA","familyname":"Ariane","agencies":[],"wikiURL":"https://en.wikipedia.org/wiki/Ariane_5","infoURLs":["http://www.arianespace.com/vehicle/ariane-5/"],"infoURL":"http://www.arianespace.com/vehicle/ariane-5/","imageSizes":[320,480,640,720,768,800,960,1024,1080,1280,1440,1920],"imageURL":"https://s3.amazonaws.com/launchlibrary/RocketImages/Ariane+5+ECA_1920.jpg"},"missions":[],"lsp":{"id":115,"name":"Arianespace","abbrev":"ASA","countryCode":"FRA","type":3,"infoURL":null,"wikiURL":"http://en.wikipedia.org/wiki/Arianespace","changed":"2017-02-21 00:00:00","infoURLs":["http://www.arianespace.com","https://www.youtube.com/channel/UCRn9F2D9j-t4A-HgudM7aLQ","https://www.facebook.com/ArianeGroup","https://twitter.com/arianespace","https://www.instagram.com/arianespace"]}},{"id":1112,"name":"Proton-M/Blok DM-03 | Spektr-RG","windowstart":"June 21, 2019 12:17:00 UTC","windowend":"June 21, 2019 12:17:00 UTC","net":"June 21, 2019 12:17:00 UTC","wsstamp":1561119420,"westamp":1561119420,"netstamp":1561119420,"isostart":"20190621T121700Z","isoend":"20190621T121700Z","isonet":"20190621T121700Z","status":1,"inhold":0,"tbdtime":0,"vidURLs":[],"vidURL":null,"infoURLs":[],"infoURL":null,"holdreason":null,"failreason":null,"tbddate":0,"probability":-1,"hashtag":null,"changed":"2019-06-06 17:13:30","location":{"pads":[],"id":10,"name":"Baikonur Cosmodrome, Republic of Kazakhstan","infoURL":"","wikiURL":"","countryCode":"KAZ"},"rocket":{"id":62,"name":"Proton-M/Blok DM-03","configuration":"-M/Blok DM-03","familyname":"Proton / UR-500","agencies":[],"wikiURL":"https://en.wikipedia.org/wiki/Proton-M","infoURLs":[],"imageURL":"https://s3.amazonaws.com/launchlibrary/RocketImages/placeholder_1920.png","imageSizes":[320,480,640,720,768,800,960,1024,1080,1280,1440,1920]},"missions":[{"id":748,"name":"Spektr-RG","description":"Spektr-RG is a joint Russian-German observatory-class mission. It is intented to study the interplanetary magnetic field, galaxies and black holes.","type":3,"wikiURL":"https://en.wikipedia.org/wiki/Spektr-RG","typeName":"Astrophysics","agencies":[{"id":27,"name":"European Space Agency","abbrev":"ESA","countryCode":"AUT,BEL,CZE,DNK,FIN,FRA,DEU,GRC,IRE,ITA,LUZ,NLD,NOR,POL,PRT,ROU,ESP,SWE,CHE,GBR","type":2,"infoURL":null,"wikiURL":"http://en.wikipedia.org/wiki/European_Space_Agency","changed":"2017-02-21 00:00:00","infoURLs":["http://www.esa.int/","https://www.facebook.com/EuropeanSpaceAgency","https://twitter.com/esa","https://www.youtube.com/channel/UCIBaDdAbGlFDeS33shmlD0A"]}],"payloads":[{"id":109,"name":"Spektr-RG"}]}],"lsp":{"id":96,"name":"Khrunichev State Research and Production Space Center","abbrev":"KhSC","countryCode":"RUS","type":1,"infoURL":"http://www.khrunichev.ru/main.php?lang=en","wikiURL":"http://en.wikipedia.org/wiki/Khrunichev_State_Research_and_Production_Space_Center","changed":"2017-02-21 00:00:00","infoURLs":["http://www.khrunichev.ru/main.php?lang=en"]}},{"id":1932,"name":"Electron | \"Make It Rain\"","windowstart":"June 25, 2019 00:00:00 UTC","windowend":"June 25, 2019 00:00:00 UTC","net":"June 25, 2019 00:00:00 UTC","wsstamp":0,"westamp":0,"netstamp":0,"isostart":"20190625T000000Z","isoend":"20190625T000000Z","isonet":"20190625T000000Z","status":3,"inhold":0,"tbdtime":1,"vidURLs":[],"vidURL":null,"infoURLs":[],"infoURL":null,"holdreason":null,"failreason":null,"tbddate":1,"probability":-1,"hashtag":null,"changed":"2019-05-15 06:20:53","location":{"pads":[{"id":166,"name":"Rocket Lab Launch Complex 1","infoURL":"","wikiURL":"https://en.wikipedia.org/wiki/Rocket_Lab_Launch_Complex_1","mapURL":"https://www.google.ee/maps/place/39°15'46.2\"S+177°51'52.1\"E/","latitude":-39.262833,"longitude":177.864469,"agencies":[{"id":147,"name":"Rocket Lab Ltd","abbrev":"RL","countryCode":"USA","type":3,"infoURL":null,"wikiURL":"http://en.wikipedia.org/wiki/Rocket_Lab","changed":"2017-02-21 00:00:00","infoURLs":["http://www.rocketlabusa.com/","https://twitter.com/rocketlab","https://www.youtube.com/user/RocketLabNZ","https://www.facebook.com/RocketLabUSA","https://www.linkedin.com/company/rocket-lab-limited"]}]}],"id":40,"name":"Onenui Station, Mahia Peninsula, New Zealand","infoURL":"","wikiURL":"","countryCode":"NZL"},"rocket":{"id":148,"name":"Electron","configuration":"","familyname":"Electron","agencies":[{"id":147,"name":"Rocket Lab Ltd","abbrev":"RL","countryCode":"USA","type":3,"infoURL":null,"wikiURL":"http://en.wikipedia.org/wiki/Rocket_Lab","changed":"2017-02-21 00:00:00","infoURLs":["http://www.rocketlabusa.com/","https://twitter.com/rocketlab","https://www.youtube.com/user/RocketLabNZ","https://www.facebook.com/RocketLabUSA","https://www.linkedin.com/company/rocket-lab-limited"]}],"wikiURL":"https://en.wikipedia.org/wiki/Rocket_Lab#Electron_Launch_Vehicle","infoURLs":[],"imageSizes":[320,480,640,720,768,800,960,1024,1080,1280,1440],"imageURL":"https://s3.amazonaws.com/launchlibrary/RocketImages/Electron.jpg_1440.jpg"},"missions":[{"id":1209,"name":"\"Make It Rain\"","description":"Rideshare mission for Spaceflight. The mission is named ‘Make it Rain’ in a nod to the high volume of rainfall in Seattle, where Spaceflight is headquartered, as well in New Zealand where Launch Complex 1 is located. Among the satellites on the mission for Spaceflight are BlackSky’s Global-4, two U.S. Special Operations Command (USSOCOM) Prometheus and Melbourne Space Program’s ACRUX-1.","type":14,"wikiURL":"","typeName":"Dedicated Rideshare","agencies":null,"payloads":[]}],"lsp":{"id":147,"name":"Rocket Lab Ltd","abbrev":"RL","countryCode":"USA","type":3,"infoURL":null,"wikiURL":"http://en.wikipedia.org/wiki/Rocket_Lab","changed":"2017-02-21 00:00:00","infoURLs":["http://www.rocketlabusa.com/","https://twitter.com/rocketlab","https://www.youtube.com/user/RocketLabNZ","https://www.facebook.com/RocketLabUSA","https://www.linkedin.com/company/rocket-lab-limited"]}},{"id":1929,"name":"Smart Dragon 1 | Maiden Flight","windowstart":"June 25, 2019 00:00:00 UTC","windowend":"June 25, 2019 00:00:00 UTC","net":"June 25, 2019 00:00:00 UTC","wsstamp":0,"westamp":0,"netstamp":0,"isostart":"20190625T000000Z","isoend":"20190625T000000Z","isonet":"20190625T000000Z","status":2,"inhold":0,"tbdtime":1,"vidURLs":[],"vidURL":null,"infoURLs":[],"infoURL":null,"holdreason":null,"failreason":null,"tbddate":1,"probability":-1,"hashtag":null,"changed":"2019-05-23 10:16:51","location":{"pads":[{"id":115,"name":"Unknown Pad, Jiuquan","infoURL":"","wikiURL":"","mapURL":"","latitude":40.958,"longitude":100.291,"agencies":null}],"id":1,"name":"Jiuquan, People's Republic of China","infoURL":"","wikiURL":"","countryCode":"CHN"},"rocket":{"id":221,"name":"Smart Dragon 1","configuration":"Smart Dragon 1","familyname":"Dragon","agencies":[{"id":272,"name":"Chinarocket Co., Ltd.","abbrev":"CHNR","countryCode":"CHN","type":3,"infoURL":"","wikiURL":null,"changed":"2019-04-24 16:24:23","infoURLs":[]}],"wikiURL":"","infoURLs":[],"imageURL":"https://s3.amazonaws.com/launchlibrary/RocketImages/placeholder_1920.png","imageSizes":[320,480,640,720,768,800,960,1024,1080,1280,1440,1920]},"missions":[{"id":1201,"name":"Maiden Flight","description":"First launch of the new solid-fueled rocket by Chinarocket Co., Ltd., which is a commercial subsidiary of CASC. On this launch Smart Dragon 1 will also carry payloads for four private companies.","type":13,"wikiURL":"","typeName":"Test Flight","agencies":[{"id":272,"name":"Chinarocket Co., Ltd.","abbrev":"CHNR","countryCode":"CHN","type":3,"infoURL":"","wikiURL":null,"changed":"2019-04-24 16:24:23","infoURLs":[]}],"payloads":[]}],"lsp":{"id":272,"name":"Chinarocket Co., Ltd.","abbrev":"CHNR","countryCode":"CHN","type":3,"infoURL":"","wikiURL":null,"changed":"2019-04-24 16:24:23","infoURLs":[]}},{"id":318,"name":"Falcon Heavy | STP-2","windowstart":"June 25, 2019 03:30:00 UTC","windowend":"June 25, 2019 07:30:00 UTC","net":"June 25, 2019 03:30:00 UTC","wsstamp":1561433400,"westamp":1561447800,"netstamp":1561433400,"isostart":"20190625T033000Z","isoend":"20190625T073000Z","isonet":"20190625T033000Z","status":1,"inhold":0,"tbdtime":0,"vidURLs":["http://www.spacex.com/webcast/"],"vidURL":null,"infoURLs":["https://www.spacex.com/stp-2"],"infoURL":null,"holdreason":null,"failreason":null,"tbddate":0,"probability":-1,"hashtag":null,"changed":"2019-06-07 17:09:26","location":{"pads":[{"id":87,"name":"Launch Complex 39A, Kennedy Space Center, FL","infoURL":"","wikiURL":"https://en.wikipedia.org/wiki/Kennedy_Space_Center_Launch_Complex_39#Launch_Pad_39A","mapURL":"http://maps.google.com/maps?q=28.608+N,+80.604+W","latitude":28.60822681,"longitude":-80.60428186,"agencies":[]}],"id":17,"name":"Kennedy Space Center, FL, USA","infoURL":"","wikiURL":"","countryCode":"USA"},"rocket":{"id":58,"name":"Falcon Heavy","configuration":"Heavy","familyname":"Falcon","agencies":[{"id":121,"name":"SpaceX","abbrev":"SpX","countryCode":"USA","type":3,"infoURL":null,"wikiURL":"http://en.wikipedia.org/wiki/SpaceX","changed":"2017-02-21 00:00:00","infoURLs":["http://www.spacex.com/","https://twitter.com/SpaceX","https://www.youtube.com/channel/UCtI0Hodo5o5dUb67FeUjDeA"]}],"wikiURL":"https://en.wikipedia.org/wiki/Falcon_Heavy","infoURLs":["http://www.spacex.com/falcon-heavy"],"infoURL":"http://www.spacex.com/falcon-heavy","imageSizes":[320,480,640,720,768,800,960,1024,1080,1280,1440,1920,2560],"imageURL":"https://s3.amazonaws.com/launchlibrary/RocketImages/FalconHeavy.jpg_2560.jpg"},"missions":[{"id":687,"name":"STP-2","description":"The STP-2 payload is composed of 25 small spacecraft. Included is COSMIC-2 constellation to provide radio occultation data, along with 8 cubesat nanosatellites. \nOther payloads include LightSail carried by the Prox-1 nanosatellite, Oculus-ASR nanosatellite, GPIM and the Deep Space Atomic Clock.","type":14,"wikiURL":"https://en.wikipedia.org/wiki/Space_Test_Program","typeName":"Dedicated Rideshare","agencies":[{"id":161,"name":"United States Air Force","abbrev":"USAF","countryCode":"USA","type":1,"infoURL":null,"wikiURL":"http://en.wikipedia.org/wiki/United_States_Air_Force","changed":"2017-02-21 00:00:00","infoURLs":["http://www.af.mil","https://www.facebook.com/USairforce","https://twitter.com/USairforce","https://www.youtube.com/afbluetube","https://www.instagram.com/usairforce","https://www.flickr.com/photos/usairforce"]}],"payloads":[]}],"lsp":{"id":121,"name":"SpaceX","abbrev":"SpX","countryCode":"USA","type":3,"infoURL":null,"wikiURL":"http://en.wikipedia.org/wiki/SpaceX","changed":"2017-02-21 00:00:00","infoURLs":["http://www.spacex.com/","https://twitter.com/SpaceX","https://www.youtube.com/channel/UCtI0Hodo5o5dUb67FeUjDeA"]}},{"id":1203,"name":"Atlas V 551 | AEHF-5","windowstart":"June 27, 2019 12:27:00 UTC","windowend":"June 27, 2019 14:27:00 UTC","net":"June 27, 2019 12:27:00 UTC","wsstamp":0,"westamp":0,"netstamp":0,"isostart":"20190627T122700Z","isoend":"20190627T142700Z","isonet":"20190627T122700Z","status":2,"inhold":0,"tbdtime":1,"vidURLs":[],"vidURL":null,"infoURLs":[],"infoURL":null,"holdreason":null,"failreason":null,"tbddate":1,"probability":-1,"hashtag":null,"changed":"2019-06-08 12:34:45","location":{"pads":[{"id":85,"name":"Space Launch Complex 41, Cape Canaveral, FL","infoURL":"","wikiURL":"https://en.wikipedia.org/wiki/Cape_Canaveral_Air_Force_Station_Space_Launch_Complex_41","mapURL":"http://maps.google.com/maps?q=28.58341025,-80.58303644","latitude":28.58341025,"longitude":-80.58303644,"agencies":[]}],"id":16,"name":"Cape Canaveral, FL, USA","infoURL":"","wikiURL":"","countryCode":"USA"},"rocket":{"id":37,"name":"Atlas V 551","configuration":"551","familyname":"Atlas","agencies":[],"wikiURL":"https://en.wikipedia.org/wiki/Atlas_V","infoURLs":[],"imageSizes":[320,480,640,720,768,800,960,1024,1080,1280,1440,1920],"imageURL":"https://s3.amazonaws.com/launchlibrary/RocketImages/Atlas+V+551_1920.jpg"},"missions":[{"id":405,"name":"AEHF-5","description":"This is the fifth satellite in the Advanced Extremely High Frequency (AEHF) system, which is a series of communications satellites operated by the United States Air Force Space Command. It provides global, survivable, protected communications capabilities for strategic command and tactical warfighters operating on ground, sea and air platforms.","type":10,"wikiURL":"https://en.wikipedia.org/wiki/Advanced_Extremely_High_Frequency","typeName":"Communications","agencies":[],"payloads":[]}],"lsp":{"id":124,"name":"United Launch Alliance","abbrev":"ULA","countryCode":"USA","type":3,"infoURL":null,"wikiURL":"http://en.wikipedia.org/wiki/United_Launch_Alliance","changed":"2017-02-21 00:00:00","infoURLs":["http://www.ulalaunch.com/","https://www.youtube.com/channel/UCnrGPRKAg1PgvuSHrRIl3jg","https://twitter.com/ulalaunch","https://www.facebook.com/ulalaunch","https://www.instagram.com/ulalaunch/"]}},{"id":1937,"name":"Kuaizhou-11 | Maiden Flight","windowstart":"June 30, 2019 00:00:00 UTC","windowend":"June 30, 2019 00:00:00 UTC","net":"June 30, 2019 00:00:00 UTC","wsstamp":0,"westamp":0,"netstamp":0,"isostart":"20190630T000000Z","isoend":"20190630T000000Z","isonet":"20190630T000000Z","status":2,"inhold":0,"tbdtime":1,"vidURLs":[],"vidURL":null,"infoURLs":[],"infoURL":null,"holdreason":null,"failreason":null,"tbddate":1,"probability":-1,"hashtag":null,"changed":"2019-06-06 17:15:06","location":{"pads":[{"id":115,"name":"Unknown Pad, Jiuquan","infoURL":"","wikiURL":"","mapURL":"","latitude":40.958,"longitude":100.291,"agencies":null}],"id":1,"name":"Jiuquan, People's Republic of China","infoURL":"","wikiURL":"","countryCode":"CHN"},"rocket":{"id":223,"name":"Kuaizhou-11","configuration":"11","familyname":"Kuaizhou","agencies":null,"wikiURL":"https://en.wikipedia.org/wiki/Kuaizhou#Models","infoURLs":[],"imageURL":"https://s3.amazonaws.com/launchlibrary/RocketImages/placeholder_1920.png","imageSizes":[320,480,640,720,768,800,960,1024,1080,1280,1440,1920]},"missions":[{"id":1212,"name":"Maiden Flight","description":"First flight of the new solid launcher developed by ExPace, subsidiary of CASIC. It will carry 2 communication satellites on this launch.","type":13,"wikiURL":"","typeName":"Test Flight","agencies":null,"payloads":[]}],"lsp":{"id":194,"name":"ExPace","abbrev":"EP","countryCode":"CHN","type":3,"infoURL":"","wikiURL":"https://en.wikipedia.org/wiki/ExPace","changed":"2017-02-21 00:00:00","infoURLs":[]}},{"id":1059,"name":"Pegasus XL | Ionospheric Connection Explorer (ICON)","windowstart":"July 1, 2019 00:00:00 UTC","windowend":"July 1, 2019 00:00:00 UTC","net":"July 1, 2019 00:00:00 UTC","wsstamp":0,"westamp":0,"netstamp":0,"isostart":"20190701T000000Z","isoend":"20190701T000000Z","isonet":"20190701T000000Z","status":2,"inhold":0,"tbdtime":1,"vidURLs":[],"vidURL":null,"infoURLs":[],"infoURL":null,"holdreason":"","failreason":null,"tbddate":1,"probability":-1,"changed":"2019-06-06 15:34:31","location":{"pads":[{"id":164,"name":"Cape Canaveral","infoURL":null,"wikiURL":"https://en.wikipedia.org/wiki/Cape_Canaveral","mapURL":"https://www.google.com/maps?ll=28.455556,-80.527778&q=28.455556,-80.527778&hl=en&t=m&z=15","latitude":28.455556,"longitude":-80.527778,"agencies":[]}],"id":39,"name":"Air launch to orbit","infoURL":"","wikiURL":"","countryCode":"UNK"},"rocket":{"id":8,"name":"Pegasus XL","configuration":"XL","familyname":"Pegasus","agencies":[{"id":179,"name":"Orbital ATK","abbrev":"OA","countryCode":"USA","type":3,"infoURL":null,"wikiURL":"https://en.wikipedia.org/wiki/Orbital_ATK","changed":"2017-02-21 00:00:00","infoURLs":["https://www.orbitalatk.com/","https://www.youtube.com/channel/UCLr1shBflPt0esLOrNFqAPA","https://twitter.com/OrbitalATK","https://www.facebook.com/OrbitalATK"]}],"wikiURL":"http://en.wikipedia.org/wiki/Pegasus_XL","infoURLs":[],"imageSizes":[320,480,640,720,768,800,960,1024,1080,1280],"imageURL":"https://s3.amazonaws.com/launchlibrary/RocketImages/Pegasus+XL_1280.jpg"},"missions":[{"id":552,"name":"Ionospheric Connection Explorer (ICON)","description":"Ionospheric Connection Explorer (ICON) is a NASA mission to study Earth's thermosphere and ionosphere and the connection between space weather and weather on our planet. Mission is planned to last for two years.","type":1,"wikiURL":"https://en.wikipedia.org/wiki/Ionospheric_Connection_Explorer","typeName":"Earth Science","agencies":[{"id":44,"name":"National Aeronautics and Space Administration","abbrev":"NASA","countryCode":"USA","type":1,"infoURL":null,"wikiURL":"http://en.wikipedia.org/wiki/National_Aeronautics_and_Space_Administration","changed":"2017-02-21 00:00:00","infoURLs":["http://www.nasa.gov","https://www.youtube.com/channel/UCLA_DiR1FfKNvjuUpBHmylQ","https://twitter.com/nasa","https://www.facebook.com/nasa"]}],"payloads":[{"id":111,"name":"Ionospheric Connection Explorer (ICON)"}]}],"lsp":{"id":257,"name":"Northrop Grumman Innovation Systems","abbrev":"NGIS","countryCode":"USA","type":3,"infoURL":null,"wikiURL":"https://en.wikipedia.org/wiki/Northrop_Grumman#Innovation_Systems","changed":"2018-07-02 15:40:27","infoURLs":["http://www.northropgrumman.com/AboutUs/BusinessSectors/InnovationSystems/Pages/default.aspx","https://twitter.com/northropgrumman","https://www.facebook.com/NorthropGrumman"]}},{"id":1137,"name":"Long March 4B | CBERS-4A","windowstart":"July 1, 2019 00:00:00 UTC","windowend":"July 1, 2019 00:00:00 UTC","net":"July 1, 2019 00:00:00 UTC","wsstamp":0,"westamp":0,"netstamp":0,"isostart":"20190701T000000Z","isoend":"20190701T000000Z","isonet":"20190701T000000Z","status":2,"inhold":0,"tbdtime":1,"vidURLs":[],"vidURL":null,"infoURLs":[],"infoURL":null,"holdreason":null,"failreason":null,"tbddate":1,"probability":-1,"hashtag":null,"changed":"2017-02-21 00:00:00","location":{"pads":[{"id":116,"name":"Unknown Pad, Taiyuan","infoURL":"","wikiURL":"","mapURL":"","latitude":38.849,"longitude":111.608,"agencies":null}],"id":2,"name":"Taiyuan, People's Republic of China","infoURL":"","wikiURL":"","countryCode":"CHN"},"rocket":{"id":16,"name":"Long March 4B","configuration":"B","familyname":"Long March 4","agencies":[{"id":88,"name":"China Aerospace Science and Technology Corporation","abbrev":"CASC","countryCode":"CHN","type":1,"infoURL":null,"wikiURL":"https://en.wikipedia.org/wiki/China_Aerospace_Science_and_Technology_Corporation","changed":"2017-02-21 00:00:00","infoURLs":["http://english.spacechina.com/","http://www.cast.cn/item/list.asp?id=1561"]}],"wikiURL":"http://en.wikipedia.org/wiki/Long_March_4B","infoURLs":[],"imageURL":"https://s3.amazonaws.com/launchlibrary/RocketImages/placeholder_1920.png","imageSizes":[320,480,640,720,768,800,960,1024,1080,1280,1440,1920]},"missions":[],"lsp":{"id":88,"name":"China Aerospace Science and Technology Corporation","abbrev":"CASC","countryCode":"CHN","type":1,"infoURL":null,"wikiURL":"https://en.wikipedia.org/wiki/China_Aerospace_Science_and_Technology_Corporation","changed":"2017-02-21 00:00:00","infoURLs":["http://english.spacechina.com/","http://www.cast.cn/item/list.asp?id=1561"]}}],"total":202,"offset":0,"count":10}"#
    static let launchesCount = 10
    static let searchQuery = "maiden"
    static let expectedNumberOfSearches = 2
    static let indexOfCompleteLaunch = 0
    static let indexOfLaunchWithoutMission = 1
    static let indexOfLaunchWithoutPad = 2
    static let indexOfLaunchWithoutDate = 3
}
