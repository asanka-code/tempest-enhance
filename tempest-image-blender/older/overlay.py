# Image module: http://effbot.org/imagingbook/image.htm
# Image conversion modes: http://effbot.org/imagingbook/concepts.htm#mode
# Image filter module: http://effbot.org/imagingbook/imagefilter.htm


import Image
import ImageFilter
import ImageEnhance

# sudo apt install python-opencv
import cv2 as cv

import numpy as np


# number of images to process
#numImages=72
numImages=40
#numImages=10

# contribution from each image
contribution=1/float(numImages)
print("contribution= %f " % contribution)

# Create a transparent image with the dimentions of the images from tempestsdr library
#J = Image.new("1", (2576,1125))
J = Image.new("L", (2576,1125))
#J = Image.new("RGB", (2576,1125))
print("Created transparent first image")


i=1
while(i<=numImages):
	I = Image.open("images/"+str(i)+".png")
	I = I.resize((2576,1125))
	I = I.convert("L")
	#I = I.convert("RGB")
	#I.filter(ImageFilter.MedianFilter(size=5)) # size can be either 3 or 5
	#I.filter(ImageFilter.MaxFilter(size=5)) # size can be either 3 or 5
	#I.filter(ImageFilter.MinFilter(size=5)) # size can be either 3 or 5
	J = Image.blend(J, I, contribution)
	print("processed image %d " % i)
	i=i+1

J.save("images/new.png","PNG")

#print("Image thresholding")
#img = cv.imread('images/new.png',0)
#th = cv.adaptiveThreshold(img, 255, cv.ADAPTIVE_THRESH_MEAN_C, cv.THRESH_BINARY,11,2)
#th = cv.adaptiveThreshold(img,255, cv.ADAPTIVE_THRESH_GAUSSIAN_C, cv.THRESH_BINARY,11,2)
#ret, th = cv.threshold(img, 0, 255, cv.THRESH_BINARY+cv.THRESH_OTSU)
#cv.imwrite("images/new.png", th)


print("Enhancing brightness")
J = Image.open("images/new.png")
J_en = ImageEnhance.Brightness(J)
J_en.enhance(20.0).save("images/new.png")


print("Enhancing contrast")
J = Image.open("images/new.png")
J_en = ImageEnhance.Contrast(J)
J_en.enhance(20.0).save("images/new.png")


print("Enhancing sharpness")
J = Image.open("images/new.png")
J_en = ImageEnhance.Sharpness(J)
J_en.enhance(20.0).save("images/new.png")





