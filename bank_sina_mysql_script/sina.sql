CREATE TABLE inbound_messages_new LIKE inbound_messages;
CREATE TABLE outbound_messages_new LIKE outbound_messages;
SELECT  @maxii :=  max(inbound_message_id)+500000 FROM inbound_messages;
SELECT  @maxoo :=  max(outboundmessage_id)+500000 FROM outbound_messages;
set @queryii = CONCAT("ALTER TABLE inbound_messages_new AUTO_INCREMENT = ", @maxii);
set @queryoo = CONCAT("ALTER TABLE outbound_messages_new AUTO_INCREMENT = ", @maxoo);
prepare stmtii from @queryii;
execute stmtii;
deallocate prepare stmtii;
prepare stmtoo from @queryoo;
execute stmtoo;
deallocate prepare stmtoo;
RENAME table inbound_messages TO inbound_messages_13990631 , inbound_messages_new TO inbound_messages;
RENAME table outbound_messages TO outbound_messages_13990631 , outbound_messages_new TO outbound_messages;
INSERT INTO inbound_messages select * from inbound_messages_13990631 where date >= '2020-09-21 00:00:00';
INSERT INTO outbound_messages select * from outbound_messages_13990631 where creation_date >= '2020-09-21 00:00:00';
DELETE FROM inbound_messages_13990631 where date > '2020-09-21 00:00:00';
DELETE FROM outbound_messages_13990631 where creation_date > '2020-09-21 00:00:00';
SELECT count(outboundmessage_id),status FROM outbound_messages_13990631 GROUP BY status;

LOAD DATA LOCAL INFILE '/root/sina_ref_9909.csv' INTO TABLE reference CHARACTER SET UTF8mb4 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'(referenceid,status);
UPDATE outbound_messages_13990930 AS o JOIN reference AS r ON o.result = r.referenceid SET o.status = 'DELIVERED';

#INSERT INTO outbound_messages_13980731 select * from outbound_messages_tmp9807till980713 where creation_date BETWEEN '2019-11-22 00:00:00' AND  '2019-12-21 00:00:00';
#INSERT INTO  outbound_messages_13980931  select * from outbound_messages where creation_date  BETWEEN '2019-11-22 00:00:00' AND  '2019-12-21 00:00:00';
#DELETE FROM outbound_messages_13980931 where creation_date <  '2019-12-21 23:59:59';
# select count(*) from outbound_messages_13980931 where creation_date  BETWEEN  '2019-12-21 00:00:00'  AND '2019-12-21 23:59:59';
select count(*) where  customer_id=72 and  creation_date BETWEEN '2020-07-22 00:00:00' AND  '2020-08-22 00:00:00';
SELECT
     d.referenceid,
    d.status
    FROM vesal.destination AS d
     JOIN vesal.number AS n ON d.originator = n.number
     WHERE
     d.status NOT IN ('NOT_DELIVERED', 'CANCELED', 'IN_QUEUE') AND d.insertdate BETWEEN '2020-08-22 00:00:00' AND  '2020-09-22 00:00:00' AND n.customer_id = 72
    INTO OUTFILE '/var/lib/mysql-files/sina_ref_9906.csv'
    FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
