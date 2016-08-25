#Host Family Connection

An individual project: a application to link between host families and volunteers.Implemented two different users to register, login and view new students who are admitted by UTDallas. Students' information include name, major, email, arrival time, phone number, airport and flight. Host family users provide host family and volunteer users pick new student up on the airport based on arrival time.
And Established host family contact with volunteer. If a host family user accepts a student and the volunteer accepts the same student, volunteer will view host family user's address and phone number. Meanwhile, host family user will know volunteer's phone number.


##Requirements
* Firebase account
* Mac & Xcode (nonsense word)

![](https://github.com/shi-edward/Connection-App/blob/master/Project-Image/FuozbAn5S3Zkp1TgTKD3BzLkqsQk-2.png)
##Installation
```
$ cd your-project directory
$ pod init
$ pod install
$ open your-project.xcworkspace
```
Please follow the Firebase's document.
##To do list
* Use sketch3 to optimize UI
* Create students registration and login
* Add students' information 

##Custom
Configure firebase
```
target 'Connection' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Auth'
  pod 'Firebase/Storage'
  # Pods for Connection

  target 'ConnectionTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ConnectionUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
```
##Architecture

![](https://github.com/shi-edward/Connection-App/blob/master/Project-Image/Screen%20Shot%202016-08-04%20at%205.07.34%20PM.png) 

##demo show

![](https://github.com/shi-edward/Connection-App/blob/master/Project-Image/ezgif.com-video-to-gif.gif)

##Screenshots

firebase database

![](https://github.com/shi-edward/Connection-App/blob/master/Project-Image/Screen%20Shot%202016-08-04%20at%204.55.32%20PM.png)
![](https://github.com/shi-edward/Connection-App/blob/master/Project-Image/Screen%20Shot%202016-08-04%20at%204.55.44%20PM.png)

![](https://github.com/shi-edward/Connection-App/blob/master/Project-Image/FiwuvXyUzibRYoxPJyBYe2a6lSVw.png) 
![](https://github.com/shi-edward/Connection-App/blob/master/Project-Image/Fi06P6PMROb6kdC-k9nJ1Ayx-tTh.png)

![](https://github.com/shi-edward/Connection-App/blob/master/Project-Image/FgScXDAh9cd7pfTv9dsuu7IlK1Y7.png) 
![](https://github.com/shi-edward/Connection-App/blob/master/Project-Image/FhVFzw-Y_TEmVmCNg0K_DvrFuFiw.png)

![](https://github.com/shi-edward/Connection-App/blob/master/Project-Image/Fjk6NyJ-Lbom2XUUP3UYXSojk1YN.png) 
![](https://github.com/shi-edward/Connection-App/blob/master/Project-Image/FjZVm2FjeClzkK-0OMf19Ez0XBcH.png)

![](https://github.com/shi-edward/Connection-App/blob/master/Project-Image/FphVJA_p3vHnWLEWZON8ZnJKZvpB.png)

##Discuss
* [submit issue](https://github.com/shi-edward/Connection-App/issues)
* email: edwardshi95@gmail.com
