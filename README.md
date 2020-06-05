# DON'T DIE NOW AND RUN

This project was made as part of an IOT course at the ESGI school, during quarantine.

## :checkered_flag: Project and goals

We decided to create a connected bracelet to use during a sporting activity in order to control the heart rate.

The primary objective is security: unlike the various connected watches and bracelets that do many things, we put aside other features and design in order to be able to alert the user very visibly of a potential danger.

The bracelet has several LEDs changing color depending on the user's heartbeat: from green for a normal beat to red for an alarming beat. If the heartbeat sounds alarming based on the user's age, an alarm will sound. The user can press a button to stop the alarm.

A mobile application allows the user to create an account and enter its age. It also allows to view reports on the cardiac activity.

## :wrench: Technical requirements

### Hardware
#### IOT

|        Component        | Quantity | Reference |
| ----------------------- | -------- | --------- |
| Arduino Uno R3          | 1        | Text      |
| Bande 8 NeoPixels       | 2        | Text      |
| Élément piézoélectrique | 2        | Text      |
| Bouton poussoir         | 1        | Text      |

#### Smartphone

* Android smartphone: `enter min version`
* Apple smartphone: `enter min version`

### Software
#### IOT
The IOT software was developed and tested in the TinkerCad editor.
All the code is available in this repository, folder `enter folder name here`.
#### Smartphone
The mobile application is available on Apple and IOS. It was developed with Flutter.
All the code is available in this repository, folder `app`.

## :art: TinkerCad modeling
The TinkerCad modeling can be accessed on this [link](https://www.tinkercad.com/things/jK6SQg8SGpy-smashing-jarv/editel?sharecode=iQTb7cqvDhjBPXpZf3uuodtSexlGJFPdbsY2lHX28s8).
`insert tinkercad modeling screenshot`

## :fuelpump: How it works



## :arrows_clockwise: Usage
`insert barto gif`
1. **Setup the connected object** according to the TinkerCad modeling
2. **Register** with an username, a password and your date of birth.
3. **Sign in** with the username and password previously filled.
4. **Activate bluetooth on the smartphone**
5. **Pair with the connected object**
6. You can now use your bracelet while doing sporting activities and view reports on your smartphone!
