##FIT5137 Assessment 2 C2 
##Student Name: Dawei Gu
##Student ID: 29910226
##Tutorial Section: FIT5137 Laboratory 05, 12:00m-14:00pm Tue  
##Tutor: Agnes Haryanto


#Cypher Script

#Create index
CREATE INDEX ON :List(list_id, price);
CREATE INDEX ON :Host(host_id);
CREATE INDEX ON :Reviewer(reviewer_id);

#1. How many reviews does “Sunny 1950s Apartment, St Kilda East” have? 
MATCH (l:List) -- (r:Review)
WHERE l.name CONTAINS 'Sunny 1950s Apartment, St Kilda East'
RETURN count(r);


#2. Show all reviews in Port Phillip. 
MATCH (l:List{neighbourhood:'Port Phillip'}) -- (r:Review)
RETURN l.neighbourhood, r;


#3. Can you recommend accommodations that Jerome (reviewer 4162110) has never been but 
#    Sandy & Pete (reviewer 317848)  have stayed and gave ratings above 90? 
MATCH (l:List) -- (r:Review) -- (p:Reviewer)
WHERE p.reviewer_id = '317848' 
             AND NOT p.reviewer_id = '4162110' 
             AND r.review_scores_rating > 90
RETURN l.name, r.review_scores_rating, p.reviewer_name;


#4. List all accommodation names and locations that do not provide Wi-Fi. 
MATCH (l:List)
WHERE NOT ('Wifi' in l.amenities)
RETURN l


#5. Count how many times a reviewer left reviews. 
MATCH (p:Reviewer) -- (r:Review)
RETURN p.reviewer_id AS id, p.reviewer_name AS Name, count(r) AS Num_review
ORDER BY id;


#6. Display a list of pairs of accommodations having more than three amenities in common. 
MATCH (l:List)
MATCH (h:List)
WHERE NOT l.list_id = h.list_id 
      AND SIZE(FILTER(x IN l.amenities WHERE x IN h.amenities)) > 3
RETURN l.list_id, l.name, l.street, h.list_id, h.name, h.street;


#7. Which listings do not have any review? 
MATCH (l:List)
WHERE NOT (l) -- (:Review)
RETURN l


#8. Show all hosts who have multiple listings. Display both the host details and the listing name and price. 
MATCH (h:Host) -- (l:List)
WHERE size((h) -- ()) > 1
RETURN h.host_id, h.host_name, l.name, l.price;


#9. What is the average price for accommodations in Melbourne neighbourhood? 
MATCH (l:List)
WHERE l.neighbourhood = 'Melbourne'
RETURN avg(l.price) AS average_price;


#10. Where are the top 5 most expensive accommodations? 
#Display the locations, host information, and names of those accommodation. 
MATCH (l:List) -- (h:Host)
RETURN l.name, l.neighbourhood, l.street, h.host_name
ORDER BY l.price DESC
LIMIT 5;


#11. How many accommodations were reviewed in 2017? 
MATCH (l:List) -- (r:Review)
WHERE r.year = 2017
RETURN COUNT(DISTINCT(l));


#12. What are the top 10 most popular neighbourhoods based on the total average reviews? 
MATCH (l:List) -- (r:Review)
RETURN l.neighbourhood, count(r) AS num_review
ORDER BY num_review DESC
LIMIT 10;


#13. Find hosts whose location are different from their listings. 
#      Show the host name, host location, listing name, and listing location. 
MATCH (l:List) -- (h:Host)
WHERE NOT h.host_location = l.street
RETURN h.host_name, h.host_location, l.name, l.street;


#14. Assuming that each accommodation only accepts two guests, calculate the price of each 
#     accommodation for four people staying for five nights. Display only the accommodation name, 
#     location, price per night, extra people charge, and total price. 
#     Rank the accommodation from the cheapest price. 
MATCH (l:List)
WHERE l.minimum_nights < 5
             AND l.availability_365 > 4
RETURN l.name, l.street, l.price, l.extra_people, (5*l.price + 5*2*l.extra_people) AS total_price
ORDER BY total_price;



#15. For each listing, rank other listings that are close to each other by their locations. 
#      You will need to use the longitude and latitude to calculate the distance between listings. 
MATCH (l:List)
MATCH (h:List)
WHERE NOT l.list_id = h.list_id
WITH point({ longitude: l.longitude, latitude: l.latitude }) AS pointa, 
          l.list_id AS lista_id,
          l.name AS lista_name,
          point({ longitude: h.longitude, latitude: h.latitude }) AS pointb,
          h.list_id AS listb_id,
          h.name AS listb_name
RETURN lista_id, lista_name, listb_id, listb_name, round(distance(pointa, pointb)) AS travelDistance
ORDER BY lista_id, travelDistance;


#Addional Q1. What is most recent 100 reviews, and how is reviewer?
MATCH (r:Review) -- (p:Reviewer)
RETURN r.review_id, r.year, r.month, r.day, r.review_scores_rating, r.comments, p.reviewer_name
ORDER BY r.year DESC, r.month DESC, r.day DESC
LIMIT 100;


#Addional Q2. What is the top 10 city have the highest review rating?
MATCH (l:List) -- (r:Review)
RETURN l.street, avg(r.review_scores_rating) AS average_rating
ORDER BY average_rating DESC
LIMIT 10;


# Addional Q3. What is number of reviews per month?
MATCH (r:Review)
RETURN r.year, r.month, count(r) AS num_review
ORDER BY r.year, r.month;


#Addional Q4. What the average rate that each reviewer give?
MATCH (r:Review) -- (p:Reviewer)
WHERE NOT r.review_scores_rating IS NULL
RETURN p.reviewer_id, p.reviewer_name, avg(r.review_scores_rating) AS average_rating
ORDER BY p.reviewer_id;


#Addional Q5. What is the number of accommodation and avgerage price of accommodation of each host?
MATCH (h:Host) -- (l:List)
RETURN h.host_id, h.host_name, count(l) AS num_listing, avg(l.price) AS avg_price
ORDER BY num_listing DESC;


