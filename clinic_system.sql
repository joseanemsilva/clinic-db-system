-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema clinic_system
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema clinic_system
DROP SCHEMA IF EXISTS `clinic_system`;
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `clinic_system` DEFAULT CHARACTER SET utf8 ;
USE `clinic_system` ;

-- -----------------------------------------------------
-- Table `clinic_system`.`doctors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_system`.`doctors` (
  `doctor_id` INT NOT NULL AUTO_INCREMENT COMMENT 'Primary key of the table',
  `doctor_first_name` VARCHAR(100) NOT NULL COMMENT 'Doctor First Name\n',
  `doctor_last_name` VARCHAR(100) NOT NULL COMMENT 'Doctor Last Name\n',
  `doctor_phone_number` VARCHAR(12) NOT NULL COMMENT 'Doctor Phone Number',
  `doctor_date_of_birth` DATE NOT NULL COMMENT 'Birth Date ',
  `doctor_email` VARCHAR(50) NOT NULL COMMENT 'Doctor Email\n',
  UNIQUE INDEX `doctor_id_UNIQUE` (`doctor_id` ASC),
  PRIMARY KEY (`doctor_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_system`.`emergency_contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_system`.`emergency_contact` (
  `emergency_contact_id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `contact_first_name` VARCHAR(100) NOT NULL COMMENT 'Contact Person First Name',
  `contact_last_name` VARCHAR(100) NOT NULL COMMENT 'Contact Person Last Name',
  `contact_phone_number` VARCHAR(50) NOT NULL COMMENT 'Contact Person phone number',
  `relationship` VARCHAR(50) NOT NULL COMMENT 'Relation with patient',
  PRIMARY KEY (`emergency_contact_id`),
  UNIQUE INDEX `emergency_contact_person_id_UNIQUE` (`emergency_contact_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_system`.`patients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_system`.`patients` (
  `patient_id` INT NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `patient_ first_name` VARCHAR(100) NOT NULL COMMENT 'Patient First Name\n',
  `patient_last_name` VARCHAR(100) NOT NULL COMMENT 'Patient Last Name',
  `patient_date_of_birth` DATE NOT NULL COMMENT 'Patient Birth Date\n',
  `patient_address` VARCHAR(100) NOT NULL COMMENT 'Patient address\n',
  `city` VARCHAR(50) NOT NULL COMMENT 'City',
  `zipcode` VARCHAR(10) NOT NULL COMMENT 'zipcode',
  `country` VARCHAR(100) NOT NULL COMMENT 'country',
  `patient_phone_number` VARCHAR(50) NOT NULL COMMENT 'Patient Phone umber',
  `patient_email` VARCHAR(100) NOT NULL COMMENT 'Patient Email',
  `patient_type` ENUM('Walk-in', 'enrolled') NOT NULL COMMENT 'Walk-in patient or enrolled patient',
  `emergency_contact_id` INT UNSIGNED NOT NULL,
  `doctor_id` INT NULL,
  PRIMARY KEY (`patient_id`),
  UNIQUE INDEX `patient_id_UNIQUE` (`patient_id` ASC),
  INDEX `fk_Patients_Emergency Contact Person1_idx` (`emergency_contact_id` ASC),
  INDEX `fk_Patients_Doctors1_idx` (`doctor_id` ASC),
  CONSTRAINT `fk_Patients_Emergency Contact Person1`
    FOREIGN KEY (`emergency_contact_id`)
    REFERENCES `clinic_system`.`emergency_contact` (`emergency_contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Patients_Doctors1`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `clinic_system`.`doctors` (`doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_system`.`appointments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_system`.`appointments` (
  `appointment_id` INT NOT NULL AUTO_INCREMENT COMMENT 'Primary Key on appointment table',
  `appointment_date` DATE NOT NULL COMMENT 'Date of appointment',
  `appointment_time` TIME NOT NULL COMMENT 'Time of appointment',
  `appointment_status` ENUM('Booked', 'Cancelled', 'Checked In', 'Checked Out', 'Left Without Treatment') NOT NULL COMMENT 'Booked, Cancelled, Checked In, Checked Out, Left Without Treatment',
  `patient_id` INT NOT NULL,
  `doctor_id` INT NOT NULL,
  PRIMARY KEY (`appointment_id`),
  UNIQUE INDEX `appointment_id_UNIQUE` (`appointment_id` ASC),
  INDEX `fk_Appointments_Patients1_idx` (`patient_id` ASC),
  INDEX `fk_Appointments_Doctors1_idx` (`doctor_id` ASC),
  CONSTRAINT `fk_Appointments_Patients1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `clinic_system`.`patients` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointments_Doctors1`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `clinic_system`.`doctors` (`doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_system`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_system`.`employees` (
  `employee_id` INT NOT NULL AUTO_INCREMENT COMMENT 'Primary Key of employee table',
  `employee_first_name` VARCHAR(100) NOT NULL COMMENT 'Employee fist name',
  `employee_last_name` VARCHAR(100) NOT NULL COMMENT 'Employee last name',
  `employee_position` VARCHAR(50) NOT NULL COMMENT 'Role: 6 nurses, 5 office secretaries, 2 administrative assistants, one manager',
  `employee_date_of_birth` DATE NULL COMMENT 'Employee date of birth',
  `employee_phone_number` VARCHAR(20) NOT NULL COMMENT 'Employee phone number information',
  `employee_email` VARCHAR(100) NOT NULL COMMENT 'Employee email information',
  `hourly_salary` DECIMAL(10) NOT NULL COMMENT 'Salary per hour for each employee, considering the position they work in.',
  PRIMARY KEY (`employee_id`),
  UNIQUE INDEX `employee_id_UNIQUE` (`employee_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_system`.`patient_visit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_system`.`patient_visit` (
  `patient_visit_id` INT NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `purpose_of_visit` VARCHAR(500) NOT NULL COMMENT 'Just check up or any illness',
  `patient_symptoms` VARCHAR(100) NULL COMMENT 'Patient symptoms for each visit and additional information',
  `blood_pressure` VARCHAR(10) NOT NULL,
  `temperature_measurement` INT NULL COMMENT 'can be null',
  `patient_height` FLOAT NULL COMMENT 'can be null',
  `patient_weight` FLOAT NULL COMMENT 'can be null',
  `visit_notes` VARCHAR(1000) NULL COMMENT 'Additional notes about the patient visit',
  `appointment_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`patient_visit_id`),
  UNIQUE INDEX `patient_visit_id_UNIQUE` (`patient_visit_id` ASC),
  INDEX `fk_Patient Visit_Appointments1_idx` (`appointment_id` ASC),
  INDEX `fk_Patient Visit_Employees1_idx` (`employee_id` ASC),
  CONSTRAINT `fk_Patient Visit_Appointments1`
    FOREIGN KEY (`appointment_id`)
    REFERENCES `clinic_system`.`appointments` (`appointment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Patient Visit_Employees1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `clinic_system`.`employees` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_system`.`patient_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_system`.`patient_history` (
  `patient_history_id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `allergies_history` VARCHAR(250) NULL COMMENT 'any allergy conditions',
  `history_date` DATE NULL COMMENT 'Date when patient ...',
  `patient_condition` VARCHAR(250) NULL COMMENT 'Any previous health conditions',
  `additional_information` VARCHAR(250) NULL COMMENT 'Any previous surgery or other important information to mention',
  `patient_id` INT NOT NULL,
  PRIMARY KEY (`patient_history_id`),
  INDEX `fk_Patient History_Patients1_idx` (`patient_id` ASC),
  UNIQUE INDEX `patient_history_id_UNIQUE` (`patient_history_id` ASC),
  CONSTRAINT `fk_Patient History_Patients1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `clinic_system`.`patients` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_system`.`patient_prescription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_system`.`patient_prescription` (
  `patient_prescription_id` INT NOT NULL AUTO_INCREMENT COMMENT 'Primary key on patient prescription table',
  `patient_treatment` VARCHAR(250) NULL COMMENT 'Example of treatment: Medication, referral, diagnostic test',
  `patient_visit_id` INT NOT NULL,
  PRIMARY KEY (`patient_prescription_id`),
  UNIQUE INDEX `patient_prescription_id_UNIQUE` (`patient_prescription_id` ASC),
  INDEX `fk_Patient Prescription_Patient Visit1_idx` (`patient_visit_id` ASC),
  CONSTRAINT `fk_Patient Prescription_Patient Visit1`
    FOREIGN KEY (`patient_visit_id`)
    REFERENCES `clinic_system`.`patient_visit` (`patient_visit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_system`.`diagnostic_test`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_system`.`diagnostic_test` (
  `patient_diagnostic_test_id` INT NOT NULL AUTO_INCREMENT COMMENT 'Primary key on patient diagnostic test table',
  `diagnostic_test_date` DATE NOT NULL,
  `diagnostic_test_type` VARCHAR(250) NOT NULL COMMENT 'Specific diagnostic test (example: blood work, XRAY, Ultrasound)',
  `diagnostic_test_resultl` VARCHAR(100) NULL,
  `patient_prescription_id` INT NOT NULL,
  PRIMARY KEY (`patient_diagnostic_test_id`),
  UNIQUE INDEX `patient_diagnostic_test_id_UNIQUE` (`patient_diagnostic_test_id` ASC),
  INDEX `fk_Diagnostic Test_Patient Prescription1_idx` (`patient_prescription_id` ASC),
  CONSTRAINT `fk_Diagnostic Test_Patient Prescription1`
    FOREIGN KEY (`patient_prescription_id`)
    REFERENCES `clinic_system`.`patient_prescription` (`patient_prescription_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_system`.`appointment_followup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_system`.`appointment_followup` (
  `appointment_followup_id` INT NOT NULL,
  `appointment_id` INT NOT NULL,
  PRIMARY KEY (`appointment_followup_id`),
  UNIQUE INDEX `appointment_followup_id_UNIQUE` (`appointment_followup_id` ASC),
  INDEX `fk_Appointment Follow Up_Appointments1_idx` (`appointment_id` ASC),
  CONSTRAINT `fk_Appointment Follow Up_Appointments1`
    FOREIGN KEY (`appointment_id`)
    REFERENCES `clinic_system`.`appointments` (`appointment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_system`.`schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_system`.`schedule` (
  `schedule_id` INT NOT NULL AUTO_INCREMENT COMMENT 'Primary key of schedule table',
  `date` DATE NOT NULL COMMENT 'Schedule specific date',
  `start_time` VARCHAR(45) NOT NULL COMMENT 'Scheduled shift start time',
  `end_time` VARCHAR(45) NOT NULL COMMENT 'Scheduled shift end time',
  PRIMARY KEY (`schedule_id`),
  UNIQUE INDEX `schedule_id_UNIQUE` (`schedule_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_system`.`health_insurance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_system`.`health_insurance` (
  `health_insurance_id` INT NOT NULL AUTO_INCREMENT COMMENT 'Primary Key on health insurance table',
  `company` VARCHAR(100) NOT NULL COMMENT 'Company name',
  `health_insurance_number` VARCHAR(100) NOT NULL COMMENT 'Health insurance number',
  `patient_id` INT NOT NULL,
  PRIMARY KEY (`health_insurance_id`),
  UNIQUE INDEX `health_insurance_id_UNIQUE` (`health_insurance_id` ASC),
  INDEX `fk_Health Insurance_Patients1_idx` (`patient_id` ASC),
  CONSTRAINT `fk_Health Insurance_Patients1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `clinic_system`.`patients` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_system`.`billing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_system`.`billing` (
  `billing_id` INT NOT NULL AUTO_INCREMENT COMMENT 'Primary key of billing table',
  `amount` DECIMAL(10) NOT NULL COMMENT 'Total amount on the billing',
  `payment_date` DATE NULL COMMENT 'Billing payment date ',
  `insurance_payable` DECIMAL(9,2) NULL COMMENT 'Total payable by the insurance company',
  `patient_payable` DECIMAL(9,2) NULL COMMENT 'Total payable by the patient (if applicable)',
  `appointment_id` INT NOT NULL,
  PRIMARY KEY (`billing_id`),
  UNIQUE INDEX `billing_id_UNIQUE` (`billing_id` ASC),
  INDEX `fk_Billing_Appointments1_idx` (`appointment_id` ASC),
  CONSTRAINT `fk_Billing_Appointments1`
    FOREIGN KEY (`appointment_id`)
    REFERENCES `clinic_system`.`appointments` (`appointment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_system`.`services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_system`.`services` (
  `services_id` INT NOT NULL AUTO_INCREMENT COMMENT 'Primary key of services table',
  `service_name` VARCHAR(50) NOT NULL COMMENT 'Service type offered on the clinic, and no show or any additional service/item specification and price',
  `current_price` DECIMAL(9,2) NOT NULL COMMENT 'Services offered at the clinic and respective price.',
  PRIMARY KEY (`services_id`),
  UNIQUE INDEX `services_id_UNIQUE` (`services_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_system`.`billing_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_system`.`billing_details` (
  `billing_details_id` INT NOT NULL AUTO_INCREMENT COMMENT 'Primary key of billing details',
  `quantity` INT NOT NULL COMMENT 'Quantity of item/service',
  `total_service_price` DECIMAL(10) NOT NULL COMMENT 'Total price for services',
  `billing_id` INT NOT NULL,
  `services_id` INT NOT NULL,
  PRIMARY KEY (`billing_details_id`),
  UNIQUE INDEX `billing_details_id_UNIQUE` (`billing_details_id` ASC),
  INDEX `fk_Billing Details_Billing1_idx` (`billing_id` ASC),
  INDEX `fk_Billing Details_Services1_idx` (`services_id` ASC),
  CONSTRAINT `fk_Billing Details_Billing1`
    FOREIGN KEY (`billing_id`)
    REFERENCES `clinic_system`.`billing` (`billing_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Billing Details_Services1`
    FOREIGN KEY (`services_id`)
    REFERENCES `clinic_system`.`services` (`services_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_system`.`bill_payment_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_system`.`bill_payment_history` (
  `Bill_Payment_History_id` INT NOT NULL,
  `amount_paid` DECIMAL(10,2) NULL,
  `payer` ENUM('Patient', 'Insurance') NULL,
  `note` VARCHAR(500) NULL,
  `billing_id` INT NULL,
  INDEX `fk_Bill Payment History_Billing1_idx` (`billing_id` ASC),
  PRIMARY KEY (`Bill_Payment_History_id`),
  UNIQUE INDEX `Bill_Payment_History_id_UNIQUE` (`Bill_Payment_History_id` ASC),
  CONSTRAINT `fk_Bill Payment History_Billing1`
    FOREIGN KEY (`billing_id`)
    REFERENCES `clinic_system`.`billing` (`billing_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_system`.`doctors_schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_system`.`doctors_schedule` (
  `schedule_id` INT NOT NULL,
  `doctor_id` INT NOT NULL,
  PRIMARY KEY (`schedule_id`, `doctor_id`),
  INDEX `fk_Schedule_has_Doctors_Doctors1_idx` (`doctor_id` ASC),
  INDEX `fk_Schedule_has_Doctors_Schedule1_idx` (`schedule_id` ASC),
  CONSTRAINT `fk_Schedule_has_Doctors_Schedule1`
    FOREIGN KEY (`schedule_id`)
    REFERENCES `clinic_system`.`schedule` (`schedule_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Schedule_has_Doctors_Doctors1`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `clinic_system`.`doctors` (`doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_system`.`employees_schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_system`.`employees_schedule` (
  `schedule_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`schedule_id`, `employee_id`),
  INDEX `fk_Employees_has_Schedule_Schedule1_idx` (`schedule_id` ASC),
  INDEX `fk_Employees_has_Schedule_Employees1_idx` (`employee_id` ASC),
  CONSTRAINT `fk_Employees_has_Schedule_Schedule1`
    FOREIGN KEY (`schedule_id`)
    REFERENCES `clinic_system`.`schedule` (`schedule_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employees_has_Schedule_Employees1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `clinic_system`.`employees` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinic_system`.`billing_has_insurance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinic_system`.`billing_has_insurance` (
  `health_insurance_id` INT NOT NULL,
  `billing_id` INT NOT NULL,
  PRIMARY KEY (`health_insurance_id`, `billing_id`),
  INDEX `fk_Health Insurance_has_Billing_Billing1_idx` (`billing_id` ASC),
  INDEX `fk_Health Insurance_has_Billing_Health Insurance1_idx` (`health_insurance_id` ASC),
  CONSTRAINT `fk_Health Insurance_has_Billing_Health Insurance1`
    FOREIGN KEY (`health_insurance_id`)
    REFERENCES `clinic_system`.`health_insurance` (`health_insurance_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Health Insurance_has_Billing_Billing1`
    FOREIGN KEY (`billing_id`)
    REFERENCES `clinic_system`.`billing` (`billing_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `clinic_system`.`doctors`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinic_system`;
INSERT INTO `clinic_system`.`doctors` (`doctor_id`, `doctor_first_name`, `doctor_last_name`, `doctor_phone_number`, `doctor_date_of_birth`, `doctor_email`) VALUES (1, 'Ted', 'Colon', '258-367-4041', '1994-12-05', 'T.Colon@torontoclinic.ca');
INSERT INTO `clinic_system`.`doctors` (`doctor_id`, `doctor_first_name`, `doctor_last_name`, `doctor_phone_number`, `doctor_date_of_birth`, `doctor_email`) VALUES (2, 'Lucy', 'Carson', '777-645-7255', '1992-06-11', 'L.Carson@torontoclinic.ca');
INSERT INTO `clinic_system`.`doctors` (`doctor_id`, `doctor_first_name`, `doctor_last_name`, `doctor_phone_number`, `doctor_date_of_birth`, `doctor_email`) VALUES (3, 'Edie', 'Peck', '258-587-2154', '1990-12-11', 'E.Perk@torontoclinic.ca');
INSERT INTO `clinic_system`.`doctors` (`doctor_id`, `doctor_first_name`, `doctor_last_name`, `doctor_phone_number`, `doctor_date_of_birth`, `doctor_email`) VALUES (4, 'Kurt', 'Logan', '435-458-7831', '1984-05-12', 'K.Logan@torontoclinic.ca');
INSERT INTO `clinic_system`.`doctors` (`doctor_id`, `doctor_first_name`, `doctor_last_name`, `doctor_phone_number`, `doctor_date_of_birth`, `doctor_email`) VALUES (5, 'Nellie', 'Swanson', '531-893-4688', '1982-01-25', 'N.Swanson@torontoclinic.ca');
INSERT INTO `clinic_system`.`doctors` (`doctor_id`, `doctor_first_name`, `doctor_last_name`, `doctor_phone_number`, `doctor_date_of_birth`, `doctor_email`) VALUES (6, 'Howard', 'Holmes', '647-554-7821', '1979-11-28', 'H.Holmes@torontoclinic.ca');
INSERT INTO `clinic_system`.`doctors` (`doctor_id`, `doctor_first_name`, `doctor_last_name`, `doctor_phone_number`, `doctor_date_of_birth`, `doctor_email`) VALUES (7, 'Jessica', 'Wells', '435-489-6696', '1969-12-29', 'J.Wells@torontoclinic.ca');
INSERT INTO `clinic_system`.`doctors` (`doctor_id`, `doctor_first_name`, `doctor_last_name`, `doctor_phone_number`, `doctor_date_of_birth`, `doctor_email`) VALUES (8, 'Leo', 'Wells', '777-457-3336', '1965-02-09', 'L.Wells@torontoclinic.ca');
INSERT INTO `clinic_system`.`doctors` (`doctor_id`, `doctor_first_name`, `doctor_last_name`, `doctor_phone_number`, `doctor_date_of_birth`, `doctor_email`) VALUES (9, 'Chris', 'Berger', '250-478-4478', '1987-08-07', 'C.Berger@torontoclinic.ca');
INSERT INTO `clinic_system`.`doctors` (`doctor_id`, `doctor_first_name`, `doctor_last_name`, `doctor_phone_number`, `doctor_date_of_birth`, `doctor_email`) VALUES (10, 'Louisa', 'Gray', '283-468-1120', '1978-12-27', 'L.Gray@torontoclinic.ca');

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinic_system`.`emergency_contact`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinic_system`;
INSERT INTO `clinic_system`.`emergency_contact` (`emergency_contact_id`, `contact_first_name`, `contact_last_name`, `contact_phone_number`, `relationship`) VALUES (1, 'Lucia', 'Hampton', '506-112-7785', 'Godparent');
INSERT INTO `clinic_system`.`emergency_contact` (`emergency_contact_id`, `contact_first_name`, `contact_last_name`, `contact_phone_number`, `relationship`) VALUES (2, 'Ellis', 'Maddox', '564-121-4454', 'Aunt');
INSERT INTO `clinic_system`.`emergency_contact` (`emergency_contact_id`, `contact_first_name`, `contact_last_name`, `contact_phone_number`, `relationship`) VALUES (3, 'Wilson', 'Pratt', '467-225-1130', 'In-law');
INSERT INTO `clinic_system`.`emergency_contact` (`emergency_contact_id`, `contact_first_name`, `contact_last_name`, `contact_phone_number`, `relationship`) VALUES (4, 'Keeley', 'Perkins', '664-110-1313', 'Mother');
INSERT INTO `clinic_system`.`emergency_contact` (`emergency_contact_id`, `contact_first_name`, `contact_last_name`, `contact_phone_number`, `relationship`) VALUES (5, 'Jakub', 'Bailey', '509-145-1230', 'Gaurdian');
INSERT INTO `clinic_system`.`emergency_contact` (`emergency_contact_id`, `contact_first_name`, `contact_last_name`, `contact_phone_number`, `relationship`) VALUES (6, 'Zohaib', 'Contreras', '641-122-8970', 'Spouse');
INSERT INTO `clinic_system`.`emergency_contact` (`emergency_contact_id`, `contact_first_name`, `contact_last_name`, `contact_phone_number`, `relationship`) VALUES (7, 'Sarrah', 'West', '506-565-1822', 'Mother');
INSERT INTO `clinic_system`.`emergency_contact` (`emergency_contact_id`, `contact_first_name`, `contact_last_name`, `contact_phone_number`, `relationship`) VALUES (8, 'Leila', 'Schultz', '506-112-7913', 'Sister');
INSERT INTO `clinic_system`.`emergency_contact` (`emergency_contact_id`, `contact_first_name`, `contact_last_name`, `contact_phone_number`, `relationship`) VALUES (9, 'Frank', 'Buckley', '644-123-7858', 'Gaurdian');
INSERT INTO `clinic_system`.`emergency_contact` (`emergency_contact_id`, `contact_first_name`, `contact_last_name`, `contact_phone_number`, `relationship`) VALUES (10, 'Lois', 'Atkinson', '750-122-1100', 'Spouse');

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinic_system`.`patients`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinic_system`;
INSERT INTO `clinic_system`.`patients` (`patient_id`, `patient_ first_name`, `patient_last_name`, `patient_date_of_birth`, `patient_address`, `city`, `zipcode`, `country`, `patient_phone_number`, `patient_email`, `patient_type`, `emergency_contact_id`, `doctor_id`) VALUES (1, 'Ava', 'Reid', '1940-08-17', '945 Bogisich Plaza', 'Kitchener', 'N2A 2N9', 'Canada', '519-895-4675', 'AvaReid@gmail.com', 'enrolled', 1, 1);
INSERT INTO `clinic_system`.`patients` (`patient_id`, `patient_ first_name`, `patient_last_name`, `patient_date_of_birth`, `patient_address`, `city`, `zipcode`, `country`, `patient_phone_number`, `patient_email`, `patient_type`, `emergency_contact_id`, `doctor_id`) VALUES (2, 'Hallie', 'Rosales', '1977-02-23', '900 Massachusetts St', 'Lawrence', '66044', 'United States', '456-778-0125', 'AvaReid@gmail.com', 'enrolled', 2, 2);
INSERT INTO `clinic_system`.`patients` (`patient_id`, `patient_ first_name`, `patient_last_name`, `patient_date_of_birth`, `patient_address`, `city`, `zipcode`, `country`, `patient_phone_number`, `patient_email`, `patient_type`, `emergency_contact_id`, `doctor_id`) VALUES (3, 'Dana', 'Greene', '1979-01-05', '4415 Park Blvd', 'Wildwood', '08260', 'United States', '164-013-4545', 'DanaGreene@gmail.com', 'enrolled', 3, 3);
INSERT INTO `clinic_system`.`patients` (`patient_id`, `patient_ first_name`, `patient_last_name`, `patient_date_of_birth`, `patient_address`, `city`, `zipcode`, `country`, `patient_phone_number`, `patient_email`, `patient_type`, `emergency_contact_id`, `doctor_id`) VALUES (4, 'Norman', 'Walton', '1943-06-21', '210 James St', 'Hamilton', 'L8R 2L2', 'Canada', '435-215-0135', 'NormanWalton@gmail.com', 'walk-in', 6, NULL);
INSERT INTO `clinic_system`.`patients` (`patient_id`, `patient_ first_name`, `patient_last_name`, `patient_date_of_birth`, `patient_address`, `city`, `zipcode`, `country`, `patient_phone_number`, `patient_email`, `patient_type`, `emergency_contact_id`, `doctor_id`) VALUES (5, 'Fatimah', 'Grace', '1938-08-16', '9528 25 Hwy', 'Halton Hills', 'L9T 2X7', 'Canada', '445-785-1125', 'FatimahGrace@gmail.com', 'enrolled', 4, 5);
INSERT INTO `clinic_system`.`patients` (`patient_id`, `patient_ first_name`, `patient_last_name`, `patient_date_of_birth`, `patient_address`, `city`, `zipcode`, `country`, `patient_phone_number`, `patient_email`, `patient_type`, `emergency_contact_id`, `doctor_id`) VALUES (6, 'Robert', 'Tanner', '1999-05-20', '6200 University Blvd', 'Vancouver', 'V6T 1Z3', 'Canada', '457-233-6666', 'RobertTanner@gmail.com', 'walk-in', 7, NULL);
INSERT INTO `clinic_system`.`patients` (`patient_id`, `patient_ first_name`, `patient_last_name`, `patient_date_of_birth`, `patient_address`, `city`, `zipcode`, `country`, `patient_phone_number`, `patient_email`, `patient_type`, `emergency_contact_id`, `doctor_id`) VALUES (7, 'Ilyas', 'Boyd', '2017-11-14', '2534A Twp Rd 245A', 'Acheson', 'T7X 5A3', 'Canada', '468-112-4016', 'IlyasBoyd@gmail.com', 'walk-in', 8, NULL);
INSERT INTO `clinic_system`.`patients` (`patient_id`, `patient_ first_name`, `patient_last_name`, `patient_date_of_birth`, `patient_address`, `city`, `zipcode`, `country`, `patient_phone_number`, `patient_email`, `patient_type`, `emergency_contact_id`, `doctor_id`) VALUES (8, 'Victor', 'Higgins', '2022-05-08', '6116 Broadway', 'West New York', '07093', 'United States', '519-487-1102', 'VictorHiggins@gmail.com', 'walk-in', 9, NULL);
INSERT INTO `clinic_system`.`patients` (`patient_id`, `patient_ first_name`, `patient_last_name`, `patient_date_of_birth`, `patient_address`, `city`, `zipcode`, `country`, `patient_phone_number`, `patient_email`, `patient_type`, `emergency_contact_id`, `doctor_id`) VALUES (9, 'Jacques', 'O\'Quinn', '1956-12-28', '215 Chain Lake Dr', 'Halifax', 'B3S 1C9', 'Canada', '647-220-6485', 'JacquesOQuinn@gmail.com', 'walk-in', 10, NULL);
INSERT INTO `clinic_system`.`patients` (`patient_id`, `patient_ first_name`, `patient_last_name`, `patient_date_of_birth`, `patient_address`, `city`, `zipcode`, `country`, `patient_phone_number`, `patient_email`, `patient_type`, `emergency_contact_id`, `doctor_id`) VALUES (10, 'Gemma', 'Schmidt', '2024-10-24', '1544 Pacific Ave', 'Atlantic City', '08400', 'United States', '447-448-7878', 'GemmaSchmidt@gmail.com', 'enrolled', 5, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinic_system`.`appointments`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinic_system`;
INSERT INTO `clinic_system`.`appointments` (`appointment_id`, `appointment_date`, `appointment_time`, `appointment_status`, `patient_id`, `doctor_id`) VALUES (1, '2023-06-05', '10:00', 'Booked', 2, 1);
INSERT INTO `clinic_system`.`appointments` (`appointment_id`, `appointment_date`, `appointment_time`, `appointment_status`, `patient_id`, `doctor_id`) VALUES (2, '2023-07-12', '14:30', 'Cancelled', 8, 3);
INSERT INTO `clinic_system`.`appointments` (`appointment_id`, `appointment_date`, `appointment_time`, `appointment_status`, `patient_id`, `doctor_id`) VALUES (3, '2024-08-17', '09:45', 'Checked Out', 1, 7);
INSERT INTO `clinic_system`.`appointments` (`appointment_id`, `appointment_date`, `appointment_time`, `appointment_status`, `patient_id`, `doctor_id`) VALUES (4, '2023-09-01', '11:15', 'Left Without Treatment', 4, 9);
INSERT INTO `clinic_system`.`appointments` (`appointment_id`, `appointment_date`, `appointment_time`, `appointment_status`, `patient_id`, `doctor_id`) VALUES (5, '2025-01-23', '13:00', 'Checked In', 6, 5);
INSERT INTO `clinic_system`.`appointments` (`appointment_id`, `appointment_date`, `appointment_time`, `appointment_status`, `patient_id`, `doctor_id`) VALUES (6, '2023-04-25', '15:00', 'Booked', 9, 2);
INSERT INTO `clinic_system`.`appointments` (`appointment_id`, `appointment_date`, `appointment_time`, `appointment_status`, `patient_id`, `doctor_id`) VALUES (7, '2022-06-30', '20:30', 'Cancelled', 10, 4);
INSERT INTO `clinic_system`.`appointments` (`appointment_id`, `appointment_date`, `appointment_time`, `appointment_status`, `patient_id`, `doctor_id`) VALUES (8, '2024-07-08', '12:00', 'Checked Out', 5, 8);
INSERT INTO `clinic_system`.`appointments` (`appointment_id`, `appointment_date`, `appointment_time`, `appointment_status`, `patient_id`, `doctor_id`) VALUES (9, '2023-08-25', '10:45', 'Checked In', 3, 6);
INSERT INTO `clinic_system`.`appointments` (`appointment_id`, `appointment_date`, `appointment_time`, `appointment_status`, `patient_id`, `doctor_id`) VALUES (10, '2024-09-10', '14:00', 'Left Without Treatment', 7, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinic_system`.`employees`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinic_system`;
INSERT INTO `clinic_system`.`employees` (`employee_id`, `employee_first_name`, `employee_last_name`, `employee_position`, `employee_date_of_birth`, `employee_phone_number`, `employee_email`, `hourly_salary`) VALUES (1, 'John', 'Patricia', 'Nurse', '1985-06-15', '416-123-4567', 'abc@torontoclinic.ca', 40.00);
INSERT INTO `clinic_system`.`employees` (`employee_id`, `employee_first_name`, `employee_last_name`, `employee_position`, `employee_date_of_birth`, `employee_phone_number`, `employee_email`, `hourly_salary`) VALUES (2, 'Emily', 'John', 'Nurse', '1985-06-15', '416-123-4567', 'abc@torontoclinic.ca', 40.00);
INSERT INTO `clinic_system`.`employees` (`employee_id`, `employee_first_name`, `employee_last_name`, `employee_position`, `employee_date_of_birth`, `employee_phone_number`, `employee_email`, `hourly_salary`) VALUES (3, 'Michael', 'Emily', 'Office Secretary', '1985-06-15', '416-123-4567', 'abc@torontoclinic.ca', 40.00);
INSERT INTO `clinic_system`.`employees` (`employee_id`, `employee_first_name`, `employee_last_name`, `employee_position`, `employee_date_of_birth`, `employee_phone_number`, `employee_email`, `hourly_salary`) VALUES (4, 'Sarah', 'Michael', 'Office Secretary', '1985-06-15', '416-123-4567', 'abc@torontoclinic.ca', 40.00);
INSERT INTO `clinic_system`.`employees` (`employee_id`, `employee_first_name`, `employee_last_name`, `employee_position`, `employee_date_of_birth`, `employee_phone_number`, `employee_email`, `hourly_salary`) VALUES (5, 'David', 'Sarah', 'Office Secretary', '1985-06-15', '416-123-4567', 'abc@torontoclinic.ca', 40.00);
INSERT INTO `clinic_system`.`employees` (`employee_id`, `employee_first_name`, `employee_last_name`, `employee_position`, `employee_date_of_birth`, `employee_phone_number`, `employee_email`, `hourly_salary`) VALUES (6, 'Laura', 'David', 'Office Secretary', '1985-06-15', '416-123-4567', 'abc@torontoclinic.ca', 40.00);
INSERT INTO `clinic_system`.`employees` (`employee_id`, `employee_first_name`, `employee_last_name`, `employee_position`, `employee_date_of_birth`, `employee_phone_number`, `employee_email`, `hourly_salary`) VALUES (7, 'Robert', 'Laura', 'Nurse', '1985-06-15', '416-123-4567', 'abc@torontoclinic.ca', 40.00);
INSERT INTO `clinic_system`.`employees` (`employee_id`, `employee_first_name`, `employee_last_name`, `employee_position`, `employee_date_of_birth`, `employee_phone_number`, `employee_email`, `hourly_salary`) VALUES (8, 'Linda', 'Robert', 'Nurse', '1985-06-15', '416-123-4567', 'abc@torontoclinic.ca', 40.00);
INSERT INTO `clinic_system`.`employees` (`employee_id`, `employee_first_name`, `employee_last_name`, `employee_position`, `employee_date_of_birth`, `employee_phone_number`, `employee_email`, `hourly_salary`) VALUES (9, 'James', 'Linda', 'Nurse', '1985-06-15', '416-123-4567', 'abc@torontoclinic.ca', 40.00);
INSERT INTO `clinic_system`.`employees` (`employee_id`, `employee_first_name`, `employee_last_name`, `employee_position`, `employee_date_of_birth`, `employee_phone_number`, `employee_email`, `hourly_salary`) VALUES (10, 'Patricia', 'James', 'Manager', '1985-06-15', '416-123-4567', 'abc@torontoclinic.ca', 40.00);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinic_system`.`patient_visit`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinic_system`;
INSERT INTO `clinic_system`.`patient_visit` (`patient_visit_id`, `purpose_of_visit`, `patient_symptoms`, `blood_pressure`, `temperature_measurement`, `patient_height`, `patient_weight`, `visit_notes`, `appointment_id`, `employee_id`) VALUES (1, 'Check-up', 'Headache, fatigue', '120/80', 98, 167, 66, 'Healthy, recommends regular exercise', 10, 1);
INSERT INTO `clinic_system`.`patient_visit` (`patient_visit_id`, `purpose_of_visit`, `patient_symptoms`, `blood_pressure`, `temperature_measurement`, `patient_height`, `patient_weight`, `visit_notes`, `appointment_id`, `employee_id`) VALUES (2, 'Annual Physical Exam', 'No symptoms', '110/70', 98, 173, 73, 'All clear, no issues', 9, 2);
INSERT INTO `clinic_system`.`patient_visit` (`patient_visit_id`, `purpose_of_visit`, `patient_symptoms`, `blood_pressure`, `temperature_measurement`, `patient_height`, `patient_weight`, `visit_notes`, `appointment_id`, `employee_id`) VALUES (3, 'Emergency Care (Injury)', 'Sprained ankle, swelling', '130/85', 99, 163, 70, 'Ice and rest advised', 8, 3);
INSERT INTO `clinic_system`.`patient_visit` (`patient_visit_id`, `purpose_of_visit`, `patient_symptoms`, `blood_pressure`, `temperature_measurement`, `patient_height`, `patient_weight`, `visit_notes`, `appointment_id`, `employee_id`) VALUES (4, 'Consultation', 'Chronic back pain', '135/90', 98, 178, 86, 'Referred to physiotherapy', 7, 4);
INSERT INTO `clinic_system`.`patient_visit` (`patient_visit_id`, `purpose_of_visit`, `patient_symptoms`, `blood_pressure`, `temperature_measurement`, `patient_height`, `patient_weight`, `visit_notes`, `appointment_id`, `employee_id`) VALUES (5, 'Post-Surgery Follow-up', 'Stitches healing, mild discomfort', '125/75', 97, 170, 73, 'Healing well, continue with prescribed medication', 6, 5);
INSERT INTO `clinic_system`.`patient_visit` (`patient_visit_id`, `purpose_of_visit`, `patient_symptoms`, `blood_pressure`, `temperature_measurement`, `patient_height`, `patient_weight`, `visit_notes`, `appointment_id`, `employee_id`) VALUES (6, 'Fever', 'High fever, chills, body aches', '125/80', 102, 183, 79, 'Diagnosed with flu, bed rest and fluids advised', 5, 6);
INSERT INTO `clinic_system`.`patient_visit` (`patient_visit_id`, `purpose_of_visit`, `patient_symptoms`, `blood_pressure`, `temperature_measurement`, `patient_height`, `patient_weight`, `visit_notes`, `appointment_id`, `employee_id`) VALUES (7, 'Check-up', 'Fatigue, slight dizziness', '115/75', 98, 165, 64, 'Blood work scheduled for next visit', 4, 7);
INSERT INTO `clinic_system`.`patient_visit` (`patient_visit_id`, `purpose_of_visit`, `patient_symptoms`, `blood_pressure`, `temperature_measurement`, `patient_height`, `patient_weight`, `visit_notes`, `appointment_id`, `employee_id`) VALUES (8, 'Prenatal Check-up', 'Nausea, mild cramping', '110/70', 98, 160, 57, 'Healthy pregnancy, keep monitoring symptoms', 3, 8);
INSERT INTO `clinic_system`.`patient_visit` (`patient_visit_id`, `purpose_of_visit`, `patient_symptoms`, `blood_pressure`, `temperature_measurement`, `patient_height`, `patient_weight`, `visit_notes`, `appointment_id`, `employee_id`) VALUES (9, 'Mental Health Consultation', 'Anxiety, sleep disturbances', '118/78', 98, 175, 165, 'Therapy and lifestyle changes recommended', 2, 9);
INSERT INTO `clinic_system`.`patient_visit` (`patient_visit_id`, `purpose_of_visit`, `patient_symptoms`, `blood_pressure`, `temperature_measurement`, `patient_height`, `patient_weight`, `visit_notes`, `appointment_id`, `employee_id`) VALUES (10, 'Diabetes Management', 'Frequent urination, fatigue', '140/90', 99, 180, 91, 'Adjusted insulin dosage, diet plan advised', 1, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinic_system`.`patient_history`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinic_system`;
INSERT INTO `clinic_system`.`patient_history` (`patient_history_id`, `allergies_history`, `history_date`, `patient_condition`, `additional_information`, `patient_id`) VALUES (1, 'Pollen Allergy', '2023-06-15', 'Pollen Allergy', 'Sneezing, itchy eyes, seasonal flare-ups', 10);
INSERT INTO `clinic_system`.`patient_history` (`patient_history_id`, `allergies_history`, `history_date`, `patient_condition`, `additional_information`, `patient_id`) VALUES (2, 'Foold Allergy', '2023-08-22', 'Severe Food Allergy (Shellfish)', 'Severe anaphylactic reaction after consumption, carries an epinephrine auto-injector', 9);
INSERT INTO `clinic_system`.`patient_history` (`patient_history_id`, `allergies_history`, `history_date`, `patient_condition`, `additional_information`, `patient_id`) VALUES (3, 'Dust Mite Allergy', '2022-11-01', 'Dust Mite Allergy', 'Chronic sneezing and nasal congestion, using air purifiers and allergy medications', 8);
INSERT INTO `clinic_system`.`patient_history` (`patient_history_id`, `allergies_history`, `history_date`, `patient_condition`, `additional_information`, `patient_id`) VALUES (4, 'Pet Dander Allergy', '2023-01-19', 'Pet Dander Allergy', 'Coughing, itchy skin, and watery eyes around pets; currently avoids animal contact', 7);
INSERT INTO `clinic_system`.`patient_history` (`patient_history_id`, `allergies_history`, `history_date`, `patient_condition`, `additional_information`, `patient_id`) VALUES (5, 'Latex Allergy', '2022-10-05', 'Latex Allergy', 'Skin rash, hives, and swelling after exposure to latex products; always ensures non-latex gloves are used', 6);
INSERT INTO `clinic_system`.`patient_history` (`patient_history_id`, `allergies_history`, `history_date`, `patient_condition`, `additional_information`, `patient_id`) VALUES (6, 'Mold Allergy', '2023-02-25', 'Mold Allergy', 'Wheezing, coughing, and congestion, exacerbated by damp conditions; avoids areas with visible mold', 5);
INSERT INTO `clinic_system`.`patient_history` (`patient_history_id`, `allergies_history`, `history_date`, `patient_condition`, `additional_information`, `patient_id`) VALUES (7, 'Insect Sting Allergy', '2023-07-30', 'Insect Sting Allergy (Bee Stings)', 'Past anaphylactic reaction, uses an epinephrine pen as precaution, avoids outdoor areas with high insect presence', 4);
INSERT INTO `clinic_system`.`patient_history` (`patient_history_id`, `allergies_history`, `history_date`, `patient_condition`, `additional_information`, `patient_id`) VALUES (8, 'Drug Allergy', '2021-05-12', 'Drug Allergy (Penicillin)', 'Skin rash, fever, and difficulty breathing after taking penicillin; marked as allergic in medical records', 3);
INSERT INTO `clinic_system`.`patient_history` (`patient_history_id`, `allergies_history`, `history_date`, `patient_condition`, `additional_information`, `patient_id`) VALUES (9, 'Fragrance Allergy', '2023-07-17', 'Migranes', 'Headaches, dizziness, and skin irritation after exposure to strong perfumes; avoids scented products', 2);
INSERT INTO `clinic_system`.`patient_history` (`patient_history_id`, `allergies_history`, `history_date`, `patient_condition`, `additional_information`, `patient_id`) VALUES (10, 'Soy Allergy', '2022-12-09', 'Soy Allergy', 'Digestive issues, including bloating and stomach cramps after consuming soy products; strictly avoids soy in foods', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinic_system`.`patient_prescription`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinic_system`;
INSERT INTO `clinic_system`.`patient_prescription` (`patient_prescription_id`, `patient_treatment`, `patient_visit_id`) VALUES (1, 'Medication', 10);
INSERT INTO `clinic_system`.`patient_prescription` (`patient_prescription_id`, `patient_treatment`, `patient_visit_id`) VALUES (2, 'Medication', 9);
INSERT INTO `clinic_system`.`patient_prescription` (`patient_prescription_id`, `patient_treatment`, `patient_visit_id`) VALUES (3, 'Medication', 8);
INSERT INTO `clinic_system`.`patient_prescription` (`patient_prescription_id`, `patient_treatment`, `patient_visit_id`) VALUES (4, 'Referral', 7);
INSERT INTO `clinic_system`.`patient_prescription` (`patient_prescription_id`, `patient_treatment`, `patient_visit_id`) VALUES (5, 'Medication', 6);
INSERT INTO `clinic_system`.`patient_prescription` (`patient_prescription_id`, `patient_treatment`, `patient_visit_id`) VALUES (6, 'Diagnostic Test', 5);
INSERT INTO `clinic_system`.`patient_prescription` (`patient_prescription_id`, `patient_treatment`, `patient_visit_id`) VALUES (7, 'Diagnostic Test', 4);
INSERT INTO `clinic_system`.`patient_prescription` (`patient_prescription_id`, `patient_treatment`, `patient_visit_id`) VALUES (8, 'Medication', 3);
INSERT INTO `clinic_system`.`patient_prescription` (`patient_prescription_id`, `patient_treatment`, `patient_visit_id`) VALUES (9, 'Referral', 2);
INSERT INTO `clinic_system`.`patient_prescription` (`patient_prescription_id`, `patient_treatment`, `patient_visit_id`) VALUES (10, 'Diagnostic Test', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinic_system`.`diagnostic_test`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinic_system`;
INSERT INTO `clinic_system`.`diagnostic_test` (`patient_diagnostic_test_id`, `diagnostic_test_date`, `diagnostic_test_type`, `diagnostic_test_resultl`, `patient_prescription_id`) VALUES (1, '2024-06-10', 'Blood Test', 'Normal', 1);
INSERT INTO `clinic_system`.`diagnostic_test` (`patient_diagnostic_test_id`, `diagnostic_test_date`, `diagnostic_test_type`, `diagnostic_test_resultl`, `patient_prescription_id`) VALUES (2, '2024-07-15', 'X-ray', 'Mild pneumonia detected', 2);
INSERT INTO `clinic_system`.`diagnostic_test` (`patient_diagnostic_test_id`, `diagnostic_test_date`, `diagnostic_test_type`, `diagnostic_test_resultl`, `patient_prescription_id`) VALUES (3, '2024-05-25', 'Allergy Test', 'Positive for pollen and pet dander', 3);
INSERT INTO `clinic_system`.`diagnostic_test` (`patient_diagnostic_test_id`, `diagnostic_test_date`, `diagnostic_test_type`, `diagnostic_test_resultl`, `patient_prescription_id`) VALUES (4, '2023-08-02', 'Urine Test', 'Potential kidney issue', 4);
INSERT INTO `clinic_system`.`diagnostic_test` (`patient_diagnostic_test_id`, `diagnostic_test_date`, `diagnostic_test_type`, `diagnostic_test_resultl`, `patient_prescription_id`) VALUES (5, '2025-03-18', 'ECG', 'Normal', 5);
INSERT INTO `clinic_system`.`diagnostic_test` (`patient_diagnostic_test_id`, `diagnostic_test_date`, `diagnostic_test_type`, `diagnostic_test_resultl`, `patient_prescription_id`) VALUES (6, '2023-09-10', 'Blood Test', 'High cholesterol', 6);
INSERT INTO `clinic_system`.`diagnostic_test` (`patient_diagnostic_test_id`, `diagnostic_test_date`, `diagnostic_test_type`, `diagnostic_test_resultl`, `patient_prescription_id`) VALUES (7, '2023-04-22', 'CT scan', 'No abnormalities detected', 7);
INSERT INTO `clinic_system`.`diagnostic_test` (`patient_diagnostic_test_id`, `diagnostic_test_date`, `diagnostic_test_type`, `diagnostic_test_resultl`, `patient_prescription_id`) VALUES (8, '2025-01-25', 'COVID-19 PCR Test', 'Negative', 8);
INSERT INTO `clinic_system`.`diagnostic_test` (`patient_diagnostic_test_id`, `diagnostic_test_date`, `diagnostic_test_type`, `diagnostic_test_resultl`, `patient_prescription_id`) VALUES (9, '2024-05-10', 'MRI', 'Mild Swelling observed (Possible migraine-related)', 9);
INSERT INTO `clinic_system`.`diagnostic_test` (`patient_diagnostic_test_id`, `diagnostic_test_date`, `diagnostic_test_type`, `diagnostic_test_resultl`, `patient_prescription_id`) VALUES (10, '2024-12-14', 'Blood Test', 'Low thyroid function', 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinic_system`.`appointment_followup`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinic_system`;
INSERT INTO `clinic_system`.`appointment_followup` (`appointment_followup_id`, `appointment_id`) VALUES (1, 1);
INSERT INTO `clinic_system`.`appointment_followup` (`appointment_followup_id`, `appointment_id`) VALUES (2, 2);
INSERT INTO `clinic_system`.`appointment_followup` (`appointment_followup_id`, `appointment_id`) VALUES (3, 3);
INSERT INTO `clinic_system`.`appointment_followup` (`appointment_followup_id`, `appointment_id`) VALUES (4, 4);
INSERT INTO `clinic_system`.`appointment_followup` (`appointment_followup_id`, `appointment_id`) VALUES (5, 5);
INSERT INTO `clinic_system`.`appointment_followup` (`appointment_followup_id`, `appointment_id`) VALUES (6, 6);
INSERT INTO `clinic_system`.`appointment_followup` (`appointment_followup_id`, `appointment_id`) VALUES (7, 7);
INSERT INTO `clinic_system`.`appointment_followup` (`appointment_followup_id`, `appointment_id`) VALUES (8, 8);
INSERT INTO `clinic_system`.`appointment_followup` (`appointment_followup_id`, `appointment_id`) VALUES (9, 9);
INSERT INTO `clinic_system`.`appointment_followup` (`appointment_followup_id`, `appointment_id`) VALUES (10, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinic_system`.`schedule`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinic_system`;
INSERT INTO `clinic_system`.`schedule` (`schedule_id`, `date`, `start_time`, `end_time`) VALUES (1, '2025-03-23', '08:00:00', '16:00:00');
INSERT INTO `clinic_system`.`schedule` (`schedule_id`, `date`, `start_time`, `end_time`) VALUES (2, '2025-03-24', '08:00:00', '20:00:00');
INSERT INTO `clinic_system`.`schedule` (`schedule_id`, `date`, `start_time`, `end_time`) VALUES (3, '2025-03-25', '08:00:00', '16:00:00');
INSERT INTO `clinic_system`.`schedule` (`schedule_id`, `date`, `start_time`, `end_time`) VALUES (4, '2025-03-26', '10:00:00', '20:00:00');
INSERT INTO `clinic_system`.`schedule` (`schedule_id`, `date`, `start_time`, `end_time`) VALUES (5, '2025-03-27', '10:00:00', '16:00:00');
INSERT INTO `clinic_system`.`schedule` (`schedule_id`, `date`, `start_time`, `end_time`) VALUES (6, '2025-03-23', '10:00:00', '20:00:00');
INSERT INTO `clinic_system`.`schedule` (`schedule_id`, `date`, `start_time`, `end_time`) VALUES (7, '2025-03-24', '10:00:00', '16:00:00');
INSERT INTO `clinic_system`.`schedule` (`schedule_id`, `date`, `start_time`, `end_time`) VALUES (8, '2025-03-25', '09:15:00', '20:00:00');
INSERT INTO `clinic_system`.`schedule` (`schedule_id`, `date`, `start_time`, `end_time`) VALUES (9, '2025-03-26', '09:15:00', '16:00:00');
INSERT INTO `clinic_system`.`schedule` (`schedule_id`, `date`, `start_time`, `end_time`) VALUES (10, '2025-03-27', '09:15:00', '20:00:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinic_system`.`health_insurance`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinic_system`;
INSERT INTO `clinic_system`.`health_insurance` (`health_insurance_id`, `company`, `health_insurance_number`, `patient_id`) VALUES (1, 'Manulife', 'MI-1001', 1);
INSERT INTO `clinic_system`.`health_insurance` (`health_insurance_id`, `company`, `health_insurance_number`, `patient_id`) VALUES (2, 'Canada Life', 'CL-6006', 2);
INSERT INTO `clinic_system`.`health_insurance` (`health_insurance_id`, `company`, `health_insurance_number`, `patient_id`) VALUES (3, 'Empire Life', 'EL-8008', 3);
INSERT INTO `clinic_system`.`health_insurance` (`health_insurance_id`, `company`, `health_insurance_number`, `patient_id`) VALUES (4, 'Manulife', 'MI-1002', 4);
INSERT INTO `clinic_system`.`health_insurance` (`health_insurance_id`, `company`, `health_insurance_number`, `patient_id`) VALUES (5, 'Canada Life', 'CL-6007', 5);
INSERT INTO `clinic_system`.`health_insurance` (`health_insurance_id`, `company`, `health_insurance_number`, `patient_id`) VALUES (6, 'Empire Life', 'EL-8009', 6);
INSERT INTO `clinic_system`.`health_insurance` (`health_insurance_id`, `company`, `health_insurance_number`, `patient_id`) VALUES (7, 'Manulife', 'MI-1003', 7);
INSERT INTO `clinic_system`.`health_insurance` (`health_insurance_id`, `company`, `health_insurance_number`, `patient_id`) VALUES (8, 'Canada Life', 'CL-6008', 8);
INSERT INTO `clinic_system`.`health_insurance` (`health_insurance_id`, `company`, `health_insurance_number`, `patient_id`) VALUES (9, 'Empire Life', 'EL-8005', 9);
INSERT INTO `clinic_system`.`health_insurance` (`health_insurance_id`, `company`, `health_insurance_number`, `patient_id`) VALUES (10, 'Manulife', 'MI-1004', 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinic_system`.`billing`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinic_system`;
INSERT INTO `clinic_system`.`billing` (`billing_id`, `amount`, `payment_date`, `insurance_payable`, `patient_payable`, `appointment_id`) VALUES (1, 200.00, '2025-03-20', 150.00, 50.00, 5);
INSERT INTO `clinic_system`.`billing` (`billing_id`, `amount`, `payment_date`, `insurance_payable`, `patient_payable`, `appointment_id`) VALUES (2, 200.00, '2025-03-20', 150.00, 50.00, 9);
INSERT INTO `clinic_system`.`billing` (`billing_id`, `amount`, `payment_date`, `insurance_payable`, `patient_payable`, `appointment_id`) VALUES (3, 200.00, '2025-03-20', 150.00, 50.00, 1);
INSERT INTO `clinic_system`.`billing` (`billing_id`, `amount`, `payment_date`, `insurance_payable`, `patient_payable`, `appointment_id`) VALUES (4, 200.00, '2025-03-20', 150.00, 50.00, 3);
INSERT INTO `clinic_system`.`billing` (`billing_id`, `amount`, `payment_date`, `insurance_payable`, `patient_payable`, `appointment_id`) VALUES (5, 200.00, '2025-03-20', 150.00, 50.00, 4);
INSERT INTO `clinic_system`.`billing` (`billing_id`, `amount`, `payment_date`, `insurance_payable`, `patient_payable`, `appointment_id`) VALUES (6, 220.00, '2025-03-20', 170.00, 50.00, 6);
INSERT INTO `clinic_system`.`billing` (`billing_id`, `amount`, `payment_date`, `insurance_payable`, `patient_payable`, `appointment_id`) VALUES (7, 220.00, '2025-03-25', 170.00, 50.00, 3);
INSERT INTO `clinic_system`.`billing` (`billing_id`, `amount`, `payment_date`, `insurance_payable`, `patient_payable`, `appointment_id`) VALUES (8, 220.00, '2025-03-25', 170.00, 50.00, 1);
INSERT INTO `clinic_system`.`billing` (`billing_id`, `amount`, `payment_date`, `insurance_payable`, `patient_payable`, `appointment_id`) VALUES (9, 220.00, '2025-03-25', 170.00, 50.00, 2);
INSERT INTO `clinic_system`.`billing` (`billing_id`, `amount`, `payment_date`, `insurance_payable`, `patient_payable`, `appointment_id`) VALUES (10, 220.00, '2025-03-25', 170.00, 50.00, 9);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinic_system`.`services`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinic_system`;
INSERT INTO `clinic_system`.`services` (`services_id`, `service_name`, `current_price`) VALUES (1, 'General Consultation', 100.00);
INSERT INTO `clinic_system`.`services` (`services_id`, `service_name`, `current_price`) VALUES (2, 'General Consultation', 100.00);
INSERT INTO `clinic_system`.`services` (`services_id`, `service_name`, `current_price`) VALUES (3, 'General Consultation', 100.00);
INSERT INTO `clinic_system`.`services` (`services_id`, `service_name`, `current_price`) VALUES (4, 'General Consultation', 100.00);
INSERT INTO `clinic_system`.`services` (`services_id`, `service_name`, `current_price`) VALUES (5, 'X-Ray', 200.00);
INSERT INTO `clinic_system`.`services` (`services_id`, `service_name`, `current_price`) VALUES (6, 'X-Ray', 200.00);
INSERT INTO `clinic_system`.`services` (`services_id`, `service_name`, `current_price`) VALUES (7, 'X-Ray', 200.00);
INSERT INTO `clinic_system`.`services` (`services_id`, `service_name`, `current_price`) VALUES (8, 'X-Ray', 200.00);
INSERT INTO `clinic_system`.`services` (`services_id`, `service_name`, `current_price`) VALUES (9, 'Blood Test', 80.00);
INSERT INTO `clinic_system`.`services` (`services_id`, `service_name`, `current_price`) VALUES (10, 'Blood Test', 80.00);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinic_system`.`billing_details`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinic_system`;
INSERT INTO `clinic_system`.`billing_details` (`billing_details_id`, `quantity`, `total_service_price`, `billing_id`, `services_id`) VALUES (1, 1, 100.00, 1, 1);
INSERT INTO `clinic_system`.`billing_details` (`billing_details_id`, `quantity`, `total_service_price`, `billing_id`, `services_id`) VALUES (2, 1, 100.00, 2, 2);
INSERT INTO `clinic_system`.`billing_details` (`billing_details_id`, `quantity`, `total_service_price`, `billing_id`, `services_id`) VALUES (3, 1, 100.00, 3, 3);
INSERT INTO `clinic_system`.`billing_details` (`billing_details_id`, `quantity`, `total_service_price`, `billing_id`, `services_id`) VALUES (4, 1, 100.00, 4, 4);
INSERT INTO `clinic_system`.`billing_details` (`billing_details_id`, `quantity`, `total_service_price`, `billing_id`, `services_id`) VALUES (5, 1, 100.00, 5, 5);
INSERT INTO `clinic_system`.`billing_details` (`billing_details_id`, `quantity`, `total_service_price`, `billing_id`, `services_id`) VALUES (6, 2, 200.00, 6, 6);
INSERT INTO `clinic_system`.`billing_details` (`billing_details_id`, `quantity`, `total_service_price`, `billing_id`, `services_id`) VALUES (7, 2, 200.00, 7, 7);
INSERT INTO `clinic_system`.`billing_details` (`billing_details_id`, `quantity`, `total_service_price`, `billing_id`, `services_id`) VALUES (8, 2, 200.00, 8, 8);
INSERT INTO `clinic_system`.`billing_details` (`billing_details_id`, `quantity`, `total_service_price`, `billing_id`, `services_id`) VALUES (9, 2, 200.00, 9, 9);
INSERT INTO `clinic_system`.`billing_details` (`billing_details_id`, `quantity`, `total_service_price`, `billing_id`, `services_id`) VALUES (10, 2, 200.00, 10, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinic_system`.`bill_payment_history`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinic_system`;
INSERT INTO `clinic_system`.`bill_payment_history` (`Bill_Payment_History_id`, `amount_paid`, `payer`, `note`, `billing_id`) VALUES (1, 50, 'patient', 'Paid by credit card', 1);
INSERT INTO `clinic_system`.`bill_payment_history` (`Bill_Payment_History_id`, `amount_paid`, `payer`, `note`, `billing_id`) VALUES (2, 50, 'patient', 'Paid by credit card', 2);
INSERT INTO `clinic_system`.`bill_payment_history` (`Bill_Payment_History_id`, `amount_paid`, `payer`, `note`, `billing_id`) VALUES (3, 50, 'patient', 'Paid by credit card', 3);
INSERT INTO `clinic_system`.`bill_payment_history` (`Bill_Payment_History_id`, `amount_paid`, `payer`, `note`, `billing_id`) VALUES (4, 50, 'patient', 'Paid by credit card', 4);
INSERT INTO `clinic_system`.`bill_payment_history` (`Bill_Payment_History_id`, `amount_paid`, `payer`, `note`, `billing_id`) VALUES (5, 50, 'patient', 'Paid by credit card', 5);
INSERT INTO `clinic_system`.`bill_payment_history` (`Bill_Payment_History_id`, `amount_paid`, `payer`, `note`, `billing_id`) VALUES (6, 50, 'patient', 'Paid by credit card', 6);
INSERT INTO `clinic_system`.`bill_payment_history` (`Bill_Payment_History_id`, `amount_paid`, `payer`, `note`, `billing_id`) VALUES (7, 50, 'patient', 'Paid by credit card', 7);
INSERT INTO `clinic_system`.`bill_payment_history` (`Bill_Payment_History_id`, `amount_paid`, `payer`, `note`, `billing_id`) VALUES (8, 50, 'patient', 'Paid by credit card', 8);
INSERT INTO `clinic_system`.`bill_payment_history` (`Bill_Payment_History_id`, `amount_paid`, `payer`, `note`, `billing_id`) VALUES (9, 50, 'patient', 'Paid by credit card', 9);
INSERT INTO `clinic_system`.`bill_payment_history` (`Bill_Payment_History_id`, `amount_paid`, `payer`, `note`, `billing_id`) VALUES (10, 50, 'patient', 'Paid by credit card', 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clinic_system`.`employees_schedule`
-- -----------------------------------------------------
START TRANSACTION;
USE `clinic_system`;
INSERT INTO `clinic_system`.`employees_schedule` (`schedule_id`, `employee_id`) VALUES (1, 1);
INSERT INTO `clinic_system`.`employees_schedule` (`schedule_id`, `employee_id`) VALUES (2, 2);
INSERT INTO `clinic_system`.`employees_schedule` (`schedule_id`, `employee_id`) VALUES (3, 3);
INSERT INTO `clinic_system`.`employees_schedule` (`schedule_id`, `employee_id`) VALUES (4, 4);
INSERT INTO `clinic_system`.`employees_schedule` (`schedule_id`, `employee_id`) VALUES (5, 5);
INSERT INTO `clinic_system`.`employees_schedule` (`schedule_id`, `employee_id`) VALUES (6, 6);
INSERT INTO `clinic_system`.`employees_schedule` (`schedule_id`, `employee_id`) VALUES (7, 7);
INSERT INTO `clinic_system`.`employees_schedule` (`schedule_id`, `employee_id`) VALUES (8, 8);
INSERT INTO `clinic_system`.`employees_schedule` (`schedule_id`, `employee_id`) VALUES (9, 9);
INSERT INTO `clinic_system`.`employees_schedule` (`schedule_id`, `employee_id`) VALUES (10, 10);

COMMIT;

