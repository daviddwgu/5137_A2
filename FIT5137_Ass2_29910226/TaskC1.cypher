##FIT5137 Assessment 2 C1 
##Student Name: Dawei Gu
##Student ID: 29910226
##Tutorial Section: FIT5137 Laboratory 05, 12:00m-14:00pm Tue  
##Tutor: Agnes Haryanto


#Cypher Script

#loading host nodes
LOAD CSV WITH HEADERS FROM "file:///host_v2.csv"
AS row
WITH row WHERE row.host_id IS NOT NULL
MERGE (h:Host {host_id: row.host_id})
ON CREATE SET h.host_url = row.host_url,
                           h.host_name = row.host_name,
                            h.host_verifications = split(split(split(row.host_verifications, '[')[1], ']')[0], ', '),
                            h.host_since = row.host_since,
                            h.year = toInteger(split(row.host_since,'-')[0]),
                            h.host_location = row.host_location,
                            h.host_response_time = row.host_response_time,
                            h.host_is_superhost = row.host_is_superhost;


#load list
LOAD CSV WITH HEADERS FROM "file:///listing_v2.csv" AS row
WITH row WHERE row.id IS NOT NULL
MERGE (l:List {list_id: row.id})
ON CREATE SET l.name = row.name,
                           l.summary = row.summary,
                           l.listing_url = row.listing_url,
                           l.picture_url = row.picture_url,
                           l.neighbourhood = row.neighbourhood,
                           l.street= row.street,
                           l.zipcode = row.zipcode,
                           l.latitude = toFloat(row.latitude),
                           l.longitude = toFloat(row.longitude),
                           l.room_type = row.room_type,
                           l.amenities = split(split(split(row.amenities, '{')[1], '}')[0], ','),
                           l.price = toInteger(row.price),
                           l.extra_people = toFloat(replace(row.extra_people,'$', '')),
                           l.minimum_nights = toInteger(row.minimum_nights),
                           l.calculated_host_listings_count = toInteger(row.calculated_host_listings_count),
                           l.availability_365 = toInteger(row.availability_365);



#loading reviewer nodes
LOAD CSV WITH HEADERS FROM "file:///review_v2.csv"
AS row
WITH row WHERE row.reviewer_id IS NOT NULL
MERGE (r:Reviewer {reviewer_id: row.reviewer_id})
ON CREATE SET r.reviewer_name = row.reviewer_name;


#loading review nodes
LOAD CSV WITH HEADERS FROM "file:///review_v2.csv"
AS row
WITH row WHERE row.id IS NOT NULL
MERGE (r:Review {review_id: row.id})
ON CREATE SET r.year = toInteger(split(row.date,'-')[0]),
                           r.month = toInteger(split(row.date,'-')[1]),
                           r.day = toInteger(split(row.date,'-')[2]),
                           r.review_scores_rating = toInteger(row.review_scores_rating),
                           r.comments = row.comments;


#add relationship between list and host
LOAD CSV WITH HEADERS FROM "file:///listing_v2.csv" AS csvLine
MATCH (h:Host {host_id: csvLine.host_id})
MATCH (l:List {list_id: csvLine.id})
CREATE (h)-[:own]->(l);


#add relationship between review and reviewer
LOAD CSV WITH HEADERS FROM "file:///review_v2.csv" AS csvLine
MATCH (p:Reviewer {reviewer_id: csvLine.reviewer_id})
MATCH (r:Review {review_id: csvLine.id})
CREATE (p)-[:write]->(r);


#add relationship between review and list
LOAD CSV WITH HEADERS FROM "file:///review_v2.csv" AS csvLine
MATCH (l:List {list_id: csvLine.listing_id})
MATCH (r:Review {review_id: csvLine.id})
CREATE (r)-[:review]->(l);



















