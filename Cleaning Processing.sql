 --convert gender (M) to (Male) and (F) to (Female) --convert (non binary and prefer not to say) to (Other)

UPDATE Employee
       SET Gender = CASE 
                WHEN Gender = 'M' THEN 'Male' 
                WHEN Gender = 'F' THEN 'Female' 
                WHEN Gender IN ('Non-binary', 'Prefer not to say') THEN 'Other' 
                ELSE Gender 
            END;


-- convert distance from numbers to (near, medium, far)
 --near (from 1 to 15)
 --medium (from 15 to 30)
 --far (more than 30)

UPDATE Emplo_Distance
       SET DistanceStatus = CASE 
                WHEN DistanceFromHome_KM >= 1 AND DistanceFromHome_KM < 15 THEN 'Near' 
                WHEN DistanceFromHome_KM >= 15 AND DistanceFromHome_KM <= 30 THEN 'Medium' 
                WHEN DistanceFromHome_KM > 30 THEN 'Far' 
                ELSE DistanceStatus  
              END;


-- convert (manager) to (sales manager) in job role column

UPDATE Employee
     SET JobRole = 'Sales Manager'
      WHERE JobRole = 'Manager';


-- create new column (employee full name) instead of two columns (first name) and (last name)
-- Add the New Column

ALTER TABLE Employee ADD COLUMN EmployeeName VARCHAR(255);

-- Update the New Column with Combined Names

UPDATE Employee
SET EmployeeName = CONCAT(first_name, ' ', last_name);

-- Remove Old Columns (First Name & Last Name)

ALTER TABLE Employee DROP COLUMN first_name, DROP COLUMN last_name;


-- convert department column from (names) to (numbers)
--number 1 for sales
--number 2 for human resources
--number 3 to technology

UPDATE Employee
SET Department =  CASE 
        WHEN Department = 'Sales' THEN '1'
        WHEN Department = 'Human Resources' THEN '2'
        WHEN Department = 'Technology' THEN '3'
        ELSE Department 'NULL'
    END;