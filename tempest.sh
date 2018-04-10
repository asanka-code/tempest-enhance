#!/bin/bash

# Tuning frequency
#FREQ=345000000
FREQ=343000000

# Sample rate
#SAMP_RATE=4000000
SAMP_RATE=20000000

# Number of samples
NUM_SAMPS=300000000

# RF amplifier value 0 or 14 dB
RF_GAIN=0

# LNA value 0 to 40 dB in 8 dB steps
IF_GAIN=24

# Baseband (vga) value 0 to 62 dB in 2 dB steps
BB_GAIN=20

# Date and time
TIMESTAMP=$(date '+%Y-%m-%d-%H:%M:%S')

# File name
INFILE=$( echo "./data/hackrf-F${FREQ}-S${SAMP_RATE}-a${RF_GAIN}-l${IF_GAIN}-g${BB_GAIN}-${TIMESTAMP}.iq" )
OUTFILE=$( echo "./data/hackrf-F${FREQ}-S${SAMP_RATE}-a${RF_GAIN}-l${IF_GAIN}-g${BB_GAIN}-${TIMESTAMP}-filtered.iq" )

echo "HackRF settings:"
echo "Frequency: ${FREQ}"
echo "Sample rate: ${SAMP_RATE}"
echo "Number of samples: ${NUM_SAMPS}"
echo "RF gain: ${RF_GAIN}"
echo "IF gain: ${IF_GAIN}"
echo "Baseband gain: ${BB_GAIN}"

echo "Start sampling..."

hackrf_transfer -r ${INFILE} -f ${FREQ} -s ${SAMP_RATE} -a ${RF_GAIN} -l ${IF_GAIN} -g ${BB_GAIN} -n ${NUM_SAMPS}

if [ $? -eq 0 ]
then
    echo "Sampling completed"
else
    echo "HackRF error occurred"
    exit 1
fi

echo "Saved data to file: ${INFILE}"

echo "Starting band-pass filtering..."
octave-cli iqprocess.m ${INFILE} ${OUTFILE}
echo "Completed filtering"



