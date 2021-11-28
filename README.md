# Engage21
Application provides students to submit weekly preferences for attending class in-person or remotely. The tool then assigns available seats to students who want to physically attend class and provides the faculty with a roster of who has been cleared to attend as per condition set by lecturer. Lecturer would be able to download covid certificates of students who are going to attend offline and remove those who submitted malformed certificates. Lecturer would also be able to mark daily attendance and check total attendance percentage of every attendee. Application also provides a calendar to view events, talks and lecture going on.

## Instructions
### Windows
1. Set up flutter from the steps mentioned in following link:
https://docs.flutter.dev/get-started/install/windows 
2. Run `flutter doctor` to check if properly installed
3. Clone the repository `git clone https://github.com/Mohul44/Engage21.git`
4. Get the dependencies using `flutter pub get`
5. You must be having an emulator or android device connected refer to following links
    <br /> https://developer.android.com/studio/run/emulator
    <br /> https://developer.android.com/studio/run/device 
6. Use `flutter run` command to start the application

### Android
Download apk from https://drive.google.com/file/d/1BSJn0C0t76aZyfr2kAcl6os4FWsX6Tdr/view?usp=sharing

## Tech Stack:-
1. Flutter for front end implementation
2. Firebase Auth for authentication
3. CLoud firestore as database
4. Firebase cloud messaging for notifications

## Features 
1. Users can sign up as teachers or students from the sign up page
2. Teachers can add new lecture slot, events, talks which would be added to calendar dynamically
3. Students can add lecture slot to their schedule, choose whether to attend offline or online, copy gmeet link and remove any lecture from their schedule 
4. Teachers can fix minimum vaccination requirement, starting time, venue, weekdays on which lecture would be conducted while creating the lecture slot
5. Teachers can view students who are cleared to attend offline class, who will be attending online class and list of all the students enrolled
6. Teachers can download the vaccination certificate from the offline list by tapping on the name and if found suscpicious can remove the student from offline class by double tapping
7. Teachers can record the attendance for a lecture slot and view the attendance of all students enrolled
8. Firebase push notifications to keep users engaged scheduled 4 in a day

## Interfaces
  1. Authentication Screens - Sign up, Sign in, forgot password!
  2. Home page - Student home page, teacher home page
  3. Calendar
  4. Add task to student schedule
  5. Add lecture slot
  6. Update profile
  7. Show list of offline students
  8. Mark attendance

## Agile Methodology
1. The program was divided into 4 sprints of 5 days.
2. In the first sprint I completed the ideation and drew UI/UX wireframes for the project.
3. In the second sprint I completed the UI implementation for all the pages.
4. In the third sprint I integrated the application with the firebase and completed the backend functionality.
5. In the fourth sprint I added the X factor features such as calendar, push notifications and recording attendance and uploading vaccination certificates.

## Future Extensions
1. Will add QR code generator and barcode scanner so that attendance could be done and teacher would not require to record attendance manually
2. For each lecture slot, teacher can add online assignments to be submitted and also access the submissions of student once they upload
3. Adding custom avatar icon





