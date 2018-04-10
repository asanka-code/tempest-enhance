
% sudo apt install octave-image
pkg load image

I1=imread("TSDR_2018-03-12_17-26-32_400MHz.png");
I2=imread("TSDR_2018-03-12_17-26-34_400MHz.png");
I3=imread("TSDR_2018-03-12_17-26-35_400MHz.png");
I4=imread("TSDR_2018-03-12_17-26-37_400MHz.png");
I5=imread("TSDR_2018-03-12_17-26-38_400MHz.png");
I6=imread("TSDR_2018-03-12_17-26-40_400MHz.png");
I7=imread("TSDR_2018-03-12_17-26-41_400MHz.png");
I8=imread("TSDR_2018-03-12_17-26-42_400MHz.png");
I9=imread("TSDR_2018-03-12_17-26-44_400MHz.png");
I10=imread("TSDR_2018-03-12_17-26-45_400MHz.png");
I11=imread("TSDR_2018-03-12_17-26-47_400MHz.png");
I12=imread("TSDR_2018-03-12_17-26-48_400MHz.png");

J=imadd(I1,I2, 'uint8');
J=imadd(J,I3, 'uint8');
J=imadd(J,I4, 'uint8');
J=imadd(J,I5, 'uint8');
J=imadd(J,I6, 'uint8');
%J=imadd(J,I7, 'uint8');
%J=imadd(J,I8, 'uint8');
%J=imadd(J,I9, 'uint8');
%J=imadd(J,I10, 'uint8');
%J=imadd(J,I11, 'uint8');
%J=imadd(J,I12, 'uint8');

imshow(J)

imwrite (J, "output.png");
