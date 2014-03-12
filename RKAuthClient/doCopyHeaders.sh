#!/bin/sh

mkdir ./Pods/Headers/Firebase
cp ./Pods/Firebase/Firebase.framework/Headers/*.h ./Pods/Headers/Firebase/
mkdir ./Pods/Headers/Parse
cp ./Pods/Parse/Parse.framework/Headers/*.h ./Pods/Headers/Parse/
mkdir ./Pods/Headers/FirebaseSimpleLogin
cp ../Frameworks/FirebaseSimpleLogin.framework/Headers/*.h ./Pods/Headers/FirebaseSimpleLogin/
