-- Queries runned to retrieve information from the clinic database system, considering some specified questions.

-- a) Create a query that returns Patients’ full names, addresses, phone numbers and email addresses.
select patient_id, 
	CONCAT(patient_first_name, ', ', patient_last_name)
		AS patient_full_name,
	CONCAT(patient_address, ', ', city, ', ', zipcode, ', ', province)
		AS patient_full_address,
	patient_phone_number,
	patient_email
FROM clinic_system.patients;

-- b) Create a query that lists all patients who have not had any appointment in the clinic in the last 2 years.
select patient_id, CONCAT(patient_first_name, ', ', patient_last_name) 
	AS patient_full_name
from clinic_system.patients
WHERE patient_id NOT IN 
	(SELECT patient_id
    FROM clinic_system.appointments);

-- c) Create a query that returns the all appointment by a particular patient in the year of 2023 (should return 5 appointments at least)
-- the result set would include patient names, examining doctors’ and nurses’ names, dates and times of the appointments, 
-- any tests ordered by the doctors for the patient.
select a.appointment_id, appointment_date, appointment_time,
	CONCAT(patient_first_name, ', ', patient_last_name) AS patient_name,
	CONCAT(doctor_first_name, ', ', doctor_last_name) AS doctor_name,
    CONCAT(em.employee_first_name, ', ', em.employee_last_name) AS nurse_name,
    GROUP_CONCAT(diagnostic_test_type SEPARATOR ', ') as diagonistic_tests
from clinic_system.appointments a
	JOIN clinic_system.patients p
		ON a.patient_id = p.patient_id
	JOIN clinic_system.doctors d
 		ON a.doctor_id = d.doctor_id
    JOIN clinic_system.patient_visit pv
		ON pv.appointment_id = a.appointment_id
	JOIN clinic_system.patient_prescription pp
		ON pv.patient_visit_id = pp.patient_visit_id
	JOIN clinic_system.diagnostic_test dt
		ON dt.patient_prescription_id = pp.patient_prescription_id
	JOIN clinic_system.employees em
		ON pv.employee_id = em.employee_id
WHERE appointment_date between '2023-01-01' and '2023-12-31'
	AND p.patient_id = 10
    AND appointment_status = 'Checked In'
GROUP BY pv.patient_visit_id;

-- d) Create a query that returns all appointments that were either cancelled, or patients were No Show in the month of December 2023.
select * 
from clinic_system.appointments
where appointment_status in ('Cancelled', 'No Show')
and appointment_date between '2023-12-01' and '2023-12-31';


-- e) Create a query that that returns staff members’ names (excluding doctors), their hourly rates, number of hours worked and Salary
--  for the two-week period.
use clinic_system;
select 
	e.employee_id,
	e.employee_first_name,
	e.employee_last_name,
    e.hourly_salary,
    s.start_time,
    s.end_time,
    round((TIMEDIFF(s.end_time, s.start_time)) / 3600,2) 
		AS working_hours,
    round((e.hourly_salary * TIME_TO_SEC(TIMEDIFF(s.end_time, s.start_time)) / 3600),2) 
		AS total_salary
from clinic_system.employees e
	JOIN clinic_system.employees_schedule es 
		ON e.employee_id = es.employee_id
	JOIN clinic_system.schedule s
		ON es.schedule_id = s.schedule_id;


-- f) The Clinic Manager has decided to send “Happy holidays” greeting cards to all patients and clinic staff, in December 
-- and want to print mailing labels which consist of two columns; the concatenated full names and complete addresses 
-- (concatenate the: street address, city, province, Postal Code).
SELECT 
	CONCAT(patient_first_name, ', ', patient_last_name) 
		AS patient_full_name,
    CONCAT(patient_address, ', ', city, ', ', province, ', ', zipcode) 
		AS patient_address
from clinic_system.patients;


-- g) Create a query that returns all patients enrolled permanently with one of the doctors.
SELECT 
    *
FROM
    clinic_system.patients
WHERE
    patient_type LIKE 'enrolled';
    
-- h) Create a query that returns a list of all patients and their family member.
SELECT
	CONCAT(patient_first_name, ', ', patient_last_name) AS patient_name,
    CONCAT(contact_first_name, ', ', contact_last_name) AS contact_person,
    relationship
FROM clinic_system.patients p
	INNER JOIN clinic_system.emergency_contact ec
    ON p.emergency_contact_id = ec.emergency_contact_id;

-- i) Create a query that would create a list of all patients that were seen by a particular doctor on a given date (i.e. 12 December, 2022)
use clinic_system;
SELECT 
    patients.patient_first_name,
    patients.patient_last_name,
    doctors.doctor_first_name,
    doctors.doctor_last_name,
    appointments.appointment_date
FROM
    clinic_system.appointments
        JOIN
    patients ON appointments.patient_id = patients.patient_id
        JOIN
    doctors ON appointments.doctor_id = doctors.doctor_id
WHERE
    appointments.appointment_date LIKE '2022-12-12';


-- J Create a query that would return name of a patient who paid some sort of a fee to the clinic, also retrieve the service for which 
-- he paid and the doctor’s name (for example Dr Smith, Sick Note)
use clinic_system;
SELECT 
	CONCAT(patient_first_name, ', ', patient_last_name) 
    AS patient_full_name,
	s.service_name,
    bd.total_service_price,
    CONCAT('Dr. ', d.doctor_last_name) AS doctor_name
from patients p
	JOIN appointments a
		ON a.patient_id = p.patient_id
	JOIN billing b
		ON b.appointment_id = a.appointment_id
	JOIN billing_details bd
		ON bd.billing_id = b.billing_id
	JOIN services s
		ON s.services_id = bd.services_id
	JOIN doctors d ON d.doctor_id = a.doctor_id
WHERE bd.total_service_price > 0;


