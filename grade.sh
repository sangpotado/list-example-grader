CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'
# CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'
expectedFILE="ListExamples.java"

set -e

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

#Check that the student code has the correct file submitted
submittedFILES=`find student-submission/$expectedFILE`
# echo $submittedFILES  #debug line
# for file in $submittedFILES       #alternative
# do
#     if [[ -f $file ]] && [[ $file == *$expectedFILE ]]
#     then 
#       echo "Student submitted correct file"
#     else 
#       echo "Excpected file $expectedFILE not found!"
#     fi
# done
if [[ -f $submittedFILES ]]
    then
        echo "Student submitted correct file"
    else 
      echo "Excpected file $expectedFILE not found!"
fi

#3. Get the student code, the .java file with the grading tests, and any other files the script needs into the grading-area directory
cp -r $submittedFILES grading-area
echo "$submittedFILES coppied to grading-area"
cp TestListExamples.java grading-area
echo "TestListExamples.java coppied to grading-area"
cp -r lib grading-area

set +e #reset 
# # 4.  Compile your tests and the student’s code from the appropriate directory with the appropriate classpath commands

#java -cp $CPATH org.junit.runner.JUnitCore grading-area/TestListExamples > hello.txt
cd grading-area
javac -cp ".:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar" *.java
if [[ $? -ne 0 ]]
then
    echo "failed to compile"
    exit 1
fi
echo "java files compiled"
java -cp ".:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar" org.junit.runner.JUnitCore TestListExamples > hello.txt
# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

