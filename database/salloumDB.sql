CREATE TABLE `students` (
  `student_id` VARCHAR(20) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `course` VARCHAR(50) NOT NULL,
  `grade` VARCHAR(2) NOT NULL
);

INSERT INTO `students` (`student_id`, `name`, `course`, `grade`) VALUES
('42130477', 'Ali Salloum', 'CSCI410', 'A'),
('72635173', 'Ahmad Fakih', 'CSCI410', 'F'),
('42651425', 'celine Dbouk', 'CSCI410', 'A-'),
('42716490', 'Diana ghaddar', 'CSCI410', 'B+'),
('72635173', 'abdallah ahmad', 'CSCI410', 'C');