##FIT5137 Assessment 2 C3 
##Student Name: Dawei Gu
##Student ID: 29910226
##Tutorial Section: FIT5137 Laboratory 05, 12:00m-14:00pm Tue  
##Tutor: Agnes Haryanto


#Cypher Script

#1. Go to AirBnB website and add three new listings, including the hosts details and some related reviews of the
#    listings you chose. The IDs in this case can be assigned manually by yourself. 

CREATE (h:Host {host_id: '98798133', 
                            host_url: 'https://www.airbnb.com.au/users/show/98798133',
                            host_name: 'Hadi',
                            host_verifications: ['Government ID', 'Email address', 'Phone number'],
                            host_since: '2016/10/08',
                            year: 2016,
                            host_location: 'Melbourne, Australia',
                            host_response_time: 'N/A',
                            host_is_superhost: 'f'});

CREATE (h:Host {host_id: '41369546', 
                           host_url: 'https://www.airbnb.com.au/users/show/41369546',
                           host_name: 'Wendy',
                           host_verifications: ['Government ID', 'Selfie', 'Email address', 'Phone number'],
                           host_since: '2015/08/13',
                           year: 2015,
                           host_location: 'Melbourne, Australia',
                           host_response_time: 'N/A',
                           host_is_superhost: 'f'});

CREATE (h:Host {host_id: '153057309', 
                           host_url: 'https://www.airbnb.com.au/users/show/153057309',
                           host_name: 'Bryan And Soraida',
                           host_verifications: ["Government ID","Selfie","Email address","Phone number"],
                           host_since: '2017/10/03',
                           year: 2017,
                           host_location: 'Melbourne, Australia',
                           host_response_time: 'N/A',
                           host_is_superhost: 't'});


CREATE (l:List {list_id: '1',
                        name: 'Cityview Master Bedroom in The Green Abode',
                        summary: 'Located in the heart of Melbourne with a vibrant and thriving lifestyle. Guest(s) will stay in the master bedroom furnished with king size mattress complete with 2 pillows and bed sheets. The common spaces such as living room and kitchen area are fully furnished dominated by minimalist style furnitures and greeneries. Perfect for solo nomad or couple. This unit opens its door to any types of couple or individual.',
                        listing_url: 'https://www.airbnb.com.au/rooms/17465305',
                        picture_url: 'N/A',
                        neighbourhood: 'Melbourne',
                        street: 'Melbourne, VIC, Australia',
                        zipcode: '3000',
                        latitude: -37.816114,
                        longitude: 144.953123,
                        room_type: 'Private room',
                        amenities: ['Wifi', 'Dryer', 'Air conditioning', 'Washing mashine', 'Essentials', 'TV', 'Heating', 'Hot water', 'Lift', 'Gym', 'Pool', 'Paid parking off premisses', 'Free street parking', 'Microwave', 'Refrigerator', 'Oven', 'Stove'],
                        price: 50,
                        extra_people: 0,
                        minimum_nights: 1,
                        calculated_host_listings_count: 1,
                        availability_365: 120});

CREATE (l:List {list_id: '2',
                        name: 'Eco-friendly Studio*Private bathroom*Wifi*Pool*Gym',
                        summary: 'A cozy and homey studio located in the CBD, perfect for tourists and professionals. Easily accessible by public transports (free tram zone, 100m Melbourne Central Station). Close to some top rated attractions (State Library, Royal Exhibition Building, Parliament House), two steps away from QV Center, China Town, restaurants, cafes, pubs. Swimming pool, sauna, gym are available in the building.' ,
                        listing_url: 'https://www.airbnb.com.au/rooms/28907077',
                        picture_url: 'N/A',
                        neighbourhood: 'Melbourne',
                        street: 'Melbourne, VIC, Australia',
                        zipcode: '3000',
                        latitude: -37.810159,
                        longitude: 144.967390,
                        room_type: 'Entire home/apt',
                        amenities: ['Wifi', 'Essentials', 'TV', 'Heating', 'Hot water', 'Lift', 'Gym', 'Pool', 'Paid parking off premisses', 'Microwave', 'Refrigerator', 'Stove'],
                        price: 67,
                        extra_people: 20,
                        minimum_nights: 1,
                        calculated_host_listings_count: 2,
                        availability_365: 90});

CREATE (l:List {list_id: '3',
                        name: 'Studio~Best Memories in CBD ❤ *Free Tram Zone!',
                        summary: 'N/A',
                        listing_url: 'https://www.airbnb.com.au/rooms/28630130',
                        picture_url: 'N/A',
                        neighbourhood: 'Melbourne',
                        street: 'Melbourne, VIC, Australia',
                        zipcode: '3000',
                        latitude: -37.809941,
                        longitude: 144.958056,
                        room_type: 'Entire home/apt',
                        amenities: ['Wifi', 'Essentials', 'TV', 'Heating', 'Hot water', 'Lift', 'Gym', 'Pool', 'Paid parking off premisses', 'Microwave', 'Refrigerator', 'Stove'],
                        price: 50,
                        extra_people: 0,
                        minimum_nights: 2,
                        calculated_host_listings_count: 2,
                        availability_365: 120});

CREATE (r:Review {review_id: '1',
                               year: 2019,
                               month: 8,
                               day: 1,
                               review_scores_rating: 95,
                               comments: 'Very clean place and supe close to everything. So much great food and bars around'});

CREATE (r:Reviewer {reviewer_id: '1', reviewer_name: 'Joel'});

CREATE (r:Review {review_id: '2',
                               year: 2019,
                               month: 10,
                               day: 1,
                               review_scores_rating: 96,
                               comments: "It's a good place for a short trip to Melbourne. Very convenient to get around everywhere."});

CREATE (r:Reviewer {reviewer_id: '2', reviewer_name: 'Chia Jane'});

CREATE (r:Review {review_id: '3',
                               year: 2019,
                               month: 10,
                               day: 04,
                               review_scores_rating: 98,
                               comments: 'Absolutely amazing spot for our trip :D'});

CREATE (r:Reviewer {reviewer_id: '3', reviewer_name: 'Alex'});

MATCH (l:List{list_id: '1'})
MATCH (h:Host{host_id: '98798133'})
CREATE (h)-[:own]->(l);

MATCH (l:List{list_id: '2'})
MATCH (h:Host{host_id: '41369546'})
CREATE (h)-[:own]->(l);

MATCH (l:List{list_id: '3'})
MATCH (h:Host{host_id: '153057309'})
CREATE (h)-[:own]->(l);

MATCH (l:List{list_id: '1'})
MATCH (r:Review{review_id: '1'})
CREATE (r)-[:review]->(l);

MATCH (l:List{list_id: '2'})
MATCH (r:Review{review_id: '2'})
CREATE (r)-[:review]->(l);

MATCH (l:List{list_id: '3'})
MATCH (r:Review{review_id: '3'})
CREATE (r)-[:review]->(l);

MATCH (p:Reviewer {reviewer_id: '1'})
MATCH (r:Review {review_id: '1'})
CREATE (p)-[:write]->(r);

MATCH (p:Reviewer {reviewer_id: '2'})
MATCH (r:Review {review_id: '2'})
CREATE (p)-[:write]->(r);

MATCH (p:Reviewer {reviewer_id: '3'})
MATCH (r:Review {review_id: '3'})
CREATE (p)-[:write]->(r);

#2. Update the host verification for those who registered in 2009 and add Facebook to the list of existing 
#    verifications. 
MATCH (h:Host)
WHERE h.year = 2009
             AND NOT 'Facebook' IN  h.host_verifications
SET h.host_verifications = (h.host_verifications + 'Facebook')
RETURN h;

#3. Update hosts who respond “within an hour” to a superhost. For this update you may only use the 
#  “host response time” and “host is a super host” information. 
MATCH (h:Host)
WHERE h.host_response_time = 'within an hour'
SET h.host_is_superhost = 't'
RETURN h;

#4. Update hosts who do not receive any reviews for their accommodation since 2017 and add a new property 
#    called active. This new property accepts Boolean value. 
MATCH (h:Host) -- (l:List)
WHERE NOT (l) -- (:Review{year:2017}) 
             AND NOT (l) -- (:Review{year:2018})
             AND NOT (l) -- (:Review{year:2019})
SET h.active = false
RETURN h;


#5. Delete all listings with zero availability and have no reviews. 
MATCH (l:List)
WHERE l.availability_365 = 0 
             OR NOT (l) -- (:Review)
DETACH DELETE l;


