CREATE TABLE Jobs_applied(
    job_id INT,
    application_date DATE,
    customer_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
  )

INSERT INTO Jobs_applied (
    job_id,
    application_date,
    customer_resume,
    resume_file_name,
    cover_letter_sent,
    cover_letter_file_name,
    status
)
VALUES
    (101, '2026-08-03', TRUE,  'Resume_DataAnalyst_GhanaBank.pdf',    TRUE,  'CoverLetter_DataAnalyst_GhanaBank.pdf',    'Rejected'),
    (102, '2026-08-11', FALSE, 'Resume_General_2026.pdf',             FALSE, NULL,                                       'No Response'),
    (103, '2026-08-19', TRUE,  'Resume_ProjectAssistant_AHK.pdf',     TRUE,  'CoverLetter_ProjectAssistant_AHK.pdf',     'Offer Received'),
    (104, '2026-08-25', TRUE,  'Resume_BIAnalyst_TelcoGH.pdf',        TRUE,  'CoverLetter_BIAnalyst_TelcoGH.pdf',        'Interview Scheduled'),
    (105, '2026-09-02', FALSE, 'Resume_General_2026.pdf',             TRUE,  'CoverLetter_OpsAssistant_LogisticsCo.pdf', 'Under Review'),
    (106, '2026-09-09', TRUE,  'Resume_DataIntern_NGO.pdf',           FALSE, NULL,                                       'Rejected'),
    (107, '2026-09-15', TRUE,  'Resume_ReportingAnalyst_Insure.pdf',  TRUE,  'CoverLetter_ReportingAnalyst_Insure.pdf',  'Interview Completed'),
    (108, '2026-09-22', FALSE, 'Resume_General_2026.pdf',             FALSE, NULL,                                       'Applied'),
    (109, '2026-10-01', TRUE,  'Resume_ProgrammeOfficer_GIZ.pdf',     TRUE,  'CoverLetter_ProgrammeOfficer_GIZ.pdf',     'Withdrawn'),
    (110, '2026-10-08', TRUE,  'Resume_PowerBIDeveloper_FinTech.pdf', TRUE,  'CoverLetter_PowerBIDeveloper_FinTech.pdf', 'Applied');

ALTER TABLE Jobs_applied
ADD Contact VARCHAR(50);

SELECT *
FROM Jobs_applied;


UPDATE Jobs_applied SET contact = 'akosua.mensah@ghanabank.example'    WHERE job_id = 101;
UPDATE Jobs_applied SET contact = 'careers@hrportal.example'           WHERE job_id = 102;
UPDATE Jobs_applied SET contact = 'kofi.boateng@ahk-ghana.example'     WHERE job_id = 103;
UPDATE Jobs_applied SET contact = 'esi.owusu@telcogh.example'          WHERE job_id = 104;
UPDATE Jobs_applied SET contact = 'recruitment@logisticsco.example'    WHERE job_id = 105;
UPDATE Jobs_applied SET contact = 'yaw.asante@ngo-accra.example'       WHERE job_id = 106;
UPDATE Jobs_applied SET contact = 'abena.darko@insure.example'         WHERE job_id = 107;
UPDATE Jobs_applied SET contact = 'jobs@retailgroup.example'           WHERE job_id = 108;
UPDATE Jobs_applied SET contact = 'nana.agyeman@giz-ghana.example'     WHERE job_id = 109;
UPDATE Jobs_applied SET contact = 'kwame.ofori@fintech.example'        WHERE job_id = 110;

ALTER TABLE Jobs_applied
RENAME COLUMN contact TO contact_email;
