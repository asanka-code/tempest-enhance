# Image module: http://effbot.org/imagingbook/image.htm
# Image conversion modes: http://effbot.org/imagingbook/concepts.htm#mode
# Image filter module: http://effbot.org/imagingbook/imagefilter.htm


################################################################################
#                                                                              #
# This script takes images from 'images' folder and process them to produce    #
# output images in the results folder.                                         #
#                                                                              #
################################################################################


import Image
import ImageFilter
import ImageEnhance
# sudo apt install python-opencv
import cv2 as cv
import numpy as np
import shutil, os
import time
from datetime import datetime
# sudo apt install python-skimage
from skimage.measure import structural_similarity as ssim


# Image type to be used in processing
imageTypes=["1", "L", "RGB", "RGBA"]
# Image brightness steps
brightnessStep=10
# Image contrast steps
contrastStep=10
# Total number of images available
totalImages=60
# Image number steps
numImageSteps=10

# Create a temporary directory to keep files
os.mkdir("temp")
# Create a diectory to keep resulting image files and log file
os.mkdir("results")
# Create the log file
logfile = open("./results/tempest.log","w", 0)

for t in imageTypes:

	brightness=0
	while(brightness<256):

		contrast=0
		while(contrast<256):


			numImages=10
			while(numImages<=totalImages):

				#------------------------------------------------
				# Remove the temporary files in temp directory and create it again
				shutil.rmtree("temp")
				os.mkdir("temp")

				# Contribution from each image
				contribution=1/float(numImages)

                                # Resulting file name
                                filename = t + "-" + str(brightness) + "-" + str(contrast) + "-" + str(numImages) + ".png"

				# Create a transparent image with the dimentions of the images from tempestsdr library
				J = Image.new(t, (2576,1125))

				i=1
				while(i<=numImages):
                                        # Convert image type
                                        I = Image.open("images/"+str(i)+".png")
                                        I = I.resize((2576,1125))
                                        I = I.convert(t)
                                        I.save("temp/" + str(i) + ".png","PNG")

    					I = Image.open("temp/"+str(i)+".png")
					I_en = ImageEnhance.Brightness(I)
					I_en.enhance(brightness).save("temp/"+str(i)+".png")

					I = Image.open("temp/"+str(i)+".png")
					I_en = ImageEnhance.Contrast(I)
					I_en.enhance(contrast).save("temp/"+str(i)+".png")

					I = Image.open("temp/"+str(i)+".png")
					J = Image.blend(J, I, contribution)
					i=i+1

				J.save("results/" + filename,"PNG")


                                # Calculate SSIM
                                first = cv.imread("images/real-screen-content.png")
                                second = cv.imread("results/" + filename)
                                first = cv.resize(first, (2576,1125))
                                second = cv.resize(second, (2576,1125))
                                first = cv.cvtColor(first, cv.COLOR_BGR2GRAY)
                                second = cv.cvtColor(second, cv.COLOR_BGR2GRAY)
                                s = ssim(first, second)


				# Put a log file entry
                                print("timestamp: %s | type: %s | brightness: %d | contrast: %d | image size: %d | image contribution: %f | SSIM: %f | result: %s" % (datetime.now(), t, brightness, contrast, numImages, contribution, s, filename))
                                logfile.write("%s %s %d %d %d %f %f %s \n" % (datetime.now(), t, brightness, contrast, numImages, contribution, s, filename))

				#------------------------------------------------
				numImages = numImages + numImageSteps

			contrast = contrast + contrastStep

		brightness = brightness + brightnessStep

# Closing log file
logfile.close()
# Cleanup temporary files
shutil.rmtree("temp")

'''
#print("Image thresholding")
#img = cv.imread('images/new.png',0)
#th = cv.adaptiveThreshold(img, 255, cv.ADAPTIVE_THRESH_MEAN_C, cv.THRESH_BINARY,11,2)
#th = cv.adaptiveThreshold(img,255, cv.ADAPTIVE_THRESH_GAUSSIAN_C, cv.THRESH_BINARY,11,2)
#ret, th = cv.threshold(img, 0, 255, cv.THRESH_BINARY+cv.THRESH_OTSU)
#cv.imwrite("images/new.png", th)
'''



