-- Query to count number of distinct cookies by visit to a website
-- v1
SELECT visit_id, count(name) from (SELECT * FROM 'javascript_cookies' WHERE record_type="added-or-changed" GROUP BY host, name, visit_id ORDER BY visit_id ASC) GROUP BY visit_id
-- v2
SELECT site_url, count(name) from (SELECT * FROM javascript_cookies WHERE record_type="added-or-changed" GROUP BY host, name, visit_id ORDER BY visit_id ASC) AS q INNER JOIN site_visits AS sv on q.visit_id = sv.visit_id GROUP BY q.visit_id


-- Example query to get set of distinct cookies set with a specified visit_id
-- v1
SELECT * FROM 'javascript_cookies' WHERE record_type="added-or-changed" AND visit_id=690707769616691 GROUP BY host, name ORDER BY name ASC
-- v2
SELECT id, jc.visit_id, site_url, expiry, host, name, value  FROM javascript_cookies AS jc INNER  JOIN site_visits AS sv ON jc.visit_id = sv.visit_id WHERE record_type='added-or-changed' AND jc.visit_id=690707769616691 GROUP BY host, name ORDER BY name ASC

-- Example query to get set of distinct first party cookies set with a specified visit_id and site url
-- v1
SELECT * FROM 'javascript_cookies' WHERE record_type="added-or-changed" AND visit_id=690707769616691 AND host LIKE "%elfcosmetics%" GROUP BY host, name ORDER BY name ASC
-- v2
SELECT id, jc.visit_id, site_url, expiry, host, name, value  FROM javascript_cookies AS jc INNER  JOIN site_visits AS sv ON jc.visit_id = sv.visit_id WHERE record_type="added-or-changed" AND jc.visit_id=690707769616691 AND host LIKE "%elfcosmetics%" GROUP BY host, name ORDER BY name ASC



-- Example query to count number of distinct first party cookies set with a specified visit_id and site url
-- v1
SELECT count(id) from (SELECT * FROM 'javascript_cookies' WHERE record_type="added-or-changed" AND visit_id=690707769616691 AND host LIKE "%elfcosmetics%" GROUP BY host, name ORDER BY name ASC)
-- v2
SELECT site_url, count(id) from (SELECT * FROM javascript_cookies AS jc INNER  JOIN site_visits AS sv ON jc.visit_id = sv.visit_id WHERE record_type="added-or-changed" AND jc.visit_id=690707769616691 AND host LIKE "%elfcosmetics%" GROUP BY host, name ORDER BY name ASC)


-- Example query to get set of distinct third party cookies set with a specified visit_id and host
-- v1
SELECT * FROM 'javascript_cookies' WHERE record_type="added-or-changed" AND visit_id=690707769616691 AND host NOT LIKE "%elfcosmetics%" GROUP BY host, name ORDER BY name ASC
-- v2
SELECT id, jc.visit_id, site_url, expiry, host, name, value  FROM javascript_cookies AS jc INNER  JOIN site_visits AS sv ON jc.visit_id = sv.visit_id WHERE record_type="added-or-changed" AND jc.visit_id=690707769616691 AND host NOT LIKE "%elfcosmetics%" GROUP BY host, name ORDER BY name ASC

-- Example query to count number of third party cookies set with a specified visit_id and host
-- v1
SELECT count(id) from (SELECT * FROM 'javascript_cookies' WHERE record_type="added-or-changed" AND visit_id=690707769616691 AND host NOT LIKE "%elfcosmetics%" GROUP BY host, name ORDER BY name ASC)
-- v2
SELECT site_url, count(id) from (SELECT * FROM javascript_cookies AS jc INNER  JOIN site_visits AS sv ON jc.visit_id = sv.visit_id WHERE record_type="added-or-changed" AND jc.visit_id=690707769616691 AND host NOT LIKE "%elfcosmetics%" GROUP BY host, name ORDER BY name ASC)

-- Example query to count both number of first and third party cookies set with a specified visit_id and host
SELECT c1.site_url, count(id) as 'first_party_cookies', third_party_cookies from (SELECT * FROM javascript_cookies AS jc INNER  JOIN site_visits AS sv ON jc.visit_id = sv.visit_id WHERE record_type="added-or-changed" AND jc.visit_id=232613013306348 AND host LIKE "%baume-et-mercier%" GROUP BY host, name ORDER BY name ASC) AS c1 INNER JOIN (SELECT site_url, count(id) as 'third_party_cookies' from (SELECT * FROM javascript_cookies AS jc INNER  JOIN site_visits AS sv ON jc.visit_id = sv.visit_id WHERE record_type="added-or-changed" AND jc.visit_id=232613013306348 AND host NOT LIKE "%baume-et-mercier%" GROUP BY host, name ORDER BY name ASC)) AS c2 ON c1.site_url = c2.site_url

-- Example query to get count of overall occurance of cookie by host
SELECT count(id) FROM javascript_cookies WHERE host LIKE '%demdex.net%'








