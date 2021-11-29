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
or https://github.com/Mohul44/Engage21/tree/main/build/app/outputs/apk/release

## Tech Stack:-
1. Flutter for front end implementation
2. Firebase Auth for authentication
3. CLoud firestore as database
4. Firebase cloud messaging for notifications
![1_DRwLVCQ6Su7ypiYbnrnV_Q](https://user-images.githubusercontent.com/43715905/143836884-56c25295-30e2-42aa-b210-334efce8e3f2.png)

## Features 
1. Users can sign up as teachers or students from the sign up page
2. Teachers can add new lecture slot, events, talks which would be added to calendar dynamically
3. Students can add lecture slot to their schedule, choose whether to attend offline or online, copy gmeet link and remove any lecture from their schedule 
4. Teachers can fix minimum vaccination requirement, starting time, venue, weekdays on which lecture would be conducted while creating the lecture slot
5. Teachers can view students who are cleared to attend offline class, who will be attending online class and list of all the students enrolled
6. Teachers can download the vaccination certificate from the offline list by tapping on the name and if found suscpicious can remove the student from offline class by double tapping
7. Teachers can record the attendance for a lecture slot and view the attendance of all students enrolled
8. Firebase push notifications to keep users engaged scheduled 4 in a day

## Agile Methodology
1. The program was divided into 4 sprints of 5 days.
2. In the first sprint I completed the ideation and drew UI/UX wireframes for the project.
3. In the second sprint I completed the UI implementation for all the pages.
4. In the third sprint I integrated the application with the firebase and completed the backend functionality.
5. In the fourth sprint I added the X factor features such as calendar, push notifications and recording attendance and uploading vaccination certificates.

![github_scrum_agile_dev](https://user-images.githubusercontent.com/43715905/143837017-631b7757-4b3a-4780-95cc-35d7c8d78ca6.png)


## Interfaces
  1. Authentication Screens - Sign up, Sign in, forgot password!
  2. Home page - Student home page, teacher home page
  3. Calendar
  4. Add task to student schedule
  5. Add lecture slot
  6. Update profile
  7. Show list of offline students
  8. Mark attendance
 

## Future Extensions
1. Will add QR code generator and barcode scanner so that attendance could be done and teacher would not require to record attendance manually
2. For each lecture slot, teacher can add online assignments to be submitted and also access the submissions of student once they upload
3. Adding custom avatar icon

## Uuseful links
[Linkedin](https://www.linkedin.com/in/mohul-maheshwari-a2899a173/?originalSubdomain=in)<br>
[Video demo](https://www.youtube.com/watch?v=rPcyzni9NSU)<br>
[Presentation](https://docs.google.com/presentation/d/1vPJVDD5ybOx7Ib6biWb9NwPXG1aHrojKcg_6gEgK0nc/edit#slide=id.g104bef31bbf_0_4)<br>
 Feel free to connect me  on Linkedin if you want to ask something! <br>
## Gallery


 <img src="https://user-images.githubusercontent.com/43715905/143833501-5ce80af5-1ef1-4fff-877b-719d5c13345f.jpg" width="192" height="400"> <img src="https://user-images.githubusercontent.com/43715905/143834111-3f84a6d0-1ed4-4b0a-ab20-6de5217c6155.jpg" width="192" height="400"> <img src="https://user-images.githubusercontent.com/43715905/143834627-c6ed9373-1804-4fa3-81dc-a49011ea4cd5.jpg" width="192" height="400">   <img src="https://user-images.githubusercontent.com/43715905/143834895-ad35e13e-f5ec-4a1e-930a-4fb9266dbc1f.jpg" width="192" height="400"> <img src="https://user-images.githubusercontent.com/43715905/143835092-293fec61-c9b2-4879-82f8-335a26867e85.jpg" width="192" height="400">   <img src="https://user-images.githubusercontent.com/43715905/143835306-d9efb226-ef16-4fa1-8bf5-c6c770c0739a.jpg" width="192" height="400">  <img src="https://user-images.githubusercontent.com/43715905/143835302-44ad37ad-5caa-457c-b7d0-09c7c4cd455e.jpg" width="192" height="400"> <img src="https://user-images.githubusercontent.com/43715905/143835092-293fec61-c9b2-4879-82f8-335a26867e85.jpg" width="192" height="400"> <img src="https://user-images.githubusercontent.com/43715905/143835092-293fec61-c9b2-4879-82f8-335a26867e85.jpg" width="192" height="400"><img src="https://user-images.githubusercontent.com/43715905/143835295-f6b15930-45cc-4178-bac1-5a6d286e2dc9.jpg" width="192" height="400">
<!-- 
![scheduler3](https://user-images.githubusercontent.com/43715905/143833501-5ce80af5-1ef1-4fff-877b-719d5c13345f.jpg)

![fp](https://user-images.githubusercontent.com/43715905/143834111-3f84a6d0-1ed4-4b0a-ab20-6de5217c6155.jpg)
![signup](https://user-images.githubusercontent.com/43715905/143834627-c6ed9373-1804-4fa3-81dc-a49011ea4cd5.jpg)

![thp](https://user-images.githubusercontent.com/43715905/143834895-ad35e13e-f5ec-4a1e-930a-4fb9266dbc1f.jpg)
![shp](https://user-images.githubusercontent.com/43715905/143834901-5c70d992-5b35-4d52-abd0-689fc3f85647.jpg)
![calendar](https://user-images.githubusercontent.com/43715905/143835092-293fec61-c9b2-4879-82f8-335a26867e85.jpg)
![markattendance](https://user-images.githubusercontent.com/43715905/143835295-f6b15930-45cc-4178-bac1-5a6d286e2dc9.jpg)
![addlecture](https://user-images.githubusercontent.com/43715905/143835302-44ad37ad-5caa-457c-b7d0-09c7c4cd455e.jpg)
![addtask](https://user-images.githubusercontent.com/43715905/143835306-d9efb226-ef16-4fa1-8bf5-c6c770c0739a.jpg) -->
