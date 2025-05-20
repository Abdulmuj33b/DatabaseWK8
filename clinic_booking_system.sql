-- -----------------------------------------------------
-- Database: ClinicBookingSystem
-- Purpose: Manage patient records, doctor schedules,
--          appointments, and treatments in a clinic.
-- -----------------------------------------------------

-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS ClinicBookingSystem;

-- Select the database for use
USE ClinicBookingSystem;

-- -----------------------------------------------------
-- Table: Patients
-- Description: Stores patient personal and contact information.
-- -----------------------------------------------------
CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for each patient',
    FullName VARCHAR(100) NOT NULL COMMENT 'Full name of the patient',
    DateOfBirth DATE COMMENT 'Date of birth of the patient',
    Gender ENUM('Male', 'Female', 'Other') COMMENT 'Gender of the patient',
    ContactNumber VARCHAR(15) COMMENT 'Contact phone number',
    Email VARCHAR(100) UNIQUE COMMENT 'Unique email address'
) COMMENT='Table containing patient details';

-- -----------------------------------------------------
-- Table: Doctors
-- Description: Stores doctor personal and professional information.
-- -----------------------------------------------------
CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for each doctor',
    FullName VARCHAR(100) NOT NULL COMMENT 'Full name of the doctor',
    Specialty VARCHAR(100) COMMENT 'Medical specialty of the doctor',
    ContactNumber VARCHAR(15) COMMENT 'Contact phone number',
    Email VARCHAR(100) UNIQUE COMMENT 'Unique email address'
) COMMENT='Table containing doctor details';

-- -----------------------------------------------------
-- Table: Appointments
-- Description: Records appointments between patients and doctors.
-- -----------------------------------------------------
CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for each appointment',
    PatientID INT NOT NULL COMMENT 'Reference to the patient',
    DoctorID INT NOT NULL COMMENT 'Reference to the doctor',
    AppointmentDate DATETIME NOT NULL COMMENT 'Scheduled date and time of the appointment',
    Reason TEXT COMMENT 'Reason for the appointment',
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
) COMMENT='Table recording appointments between patients and doctors';

-- -----------------------------------------------------
-- Table: Treatments
-- Description: Lists available treatments offered by the clinic.
-- -----------------------------------------------------
CREATE TABLE Treatments (
    TreatmentID INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for each treatment',
    TreatmentName VARCHAR(100) NOT NULL COMMENT 'Name of the treatment',
    Description TEXT COMMENT 'Detailed description of the treatment'
) COMMENT='Table listing treatments available in the clinic';

-- -----------------------------------------------------
-- Table: PatientTreatments
-- Description: Associates patients with treatments they have received.
--              Implements a many-to-many relationship between Patients and Treatments.
-- -----------------------------------------------------
CREATE TABLE PatientTreatments (
    PatientID INT NOT NULL COMMENT 'Reference to the patient',
    TreatmentID INT NOT NULL COMMENT 'Reference to the treatment',
    DateAdministered DATE COMMENT 'Date when the treatment was administered',
    PRIMARY KEY (PatientID, TreatmentID),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (TreatmentID) REFERENCES Treatments(TreatmentID)
) COMMENT='Associative table linking patients to treatments received';

