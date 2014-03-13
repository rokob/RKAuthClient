# RKAuthClient CHANGELOG

## 0.0.1

Initial release.

## 0.0.2

I am terrible at this who cocoapods thing still, initial commit still.

## 0.0.5

Skipped a few, whatever. I am commenting out the Firebase and Parse stuff because there is an issue with pods built from Frameworks not getting the
headers found properly when using them within a pod. This is an annoyance that I don't feel like working out the details of at the moment. Thus the
files are still in the repo, I just got rid of the explicit subspecs that use them. This way I can use this library, but I can also just copy some
files over depending on which backend I use. Stupid I know, but meh for now it is okay. I want to move forward with using this library rather than
fixing the build problem for just the pod.
