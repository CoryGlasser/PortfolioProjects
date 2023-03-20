#!/usr/bin/env python
# coding: utf-8

# # BMI Calculator

# In[ ]:


name = input('Enter your name: ')

weight = int(input("Enter your weight in pounds: "))

height = int(input("Enter your height in inches: "))

BMI = (weight * 703) / (height * height)

print(BMI)

if BMI > 0:
    if(BMI < 18.5):
        print(name + ", you are underweight.")
    elif(BMI < 25):
        print(name + ", you are normal weight.")
    elif(BMI < 30):
        print(name + ", you are overweight.")
    elif(BMI < 35):
        print(name + ", you are obese.")
    elif(BMI < 40):
        print(name + ", you are severely obese.")
    else:
        print(name + ", you are morbidly obese.")
else:
    print("Enter valid input.")

