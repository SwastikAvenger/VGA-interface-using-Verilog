
# The following program reads an edf file and displays the data in READABLE FORMAT

import mne
import numpy as np 
import pandas as pd

raw = mne.io.read_raw_edf("Subject01_2.edf", preload=True, verbose=False)       # reading the data (load into memory)

print(f"\nSubject Information : {raw.info["subject_info"]}")      # subject information

print(f"\nSampling Frequency : {raw.info["sfreq"]}")              # Sampling Frequency

print(f"\nNo. of Channel : {len(raw.info['ch_names'])}")          # No. of Channels

print(f"\nChannel Names : {raw.ch_names}")                        # Channel Names

data = raw.get_data()                                             # shape: (row = no, of channels, column = times), floats

times = np.arange(raw.n_times) / raw.info["sfreq"]                # creates a corresponding time array for each point. Dividing by sample freq, 
                                                                  # converts the sample indices to actual time points. 

df = pd.DataFrame(data.T, columns=raw.ch_names)                   # transposing the numerical data to row = times, column = no. of channel
                                                                  # columns=raw.ch_names explicitly mentions the column names to be actual column names
                                                                  # removing it will cause column name to appear as 0,1,2 ...
                                                                
df.insert(0, "time_s", times)                                     # this adds the time array that was previously created
                                                                  # 0 specifies column position, time_s is the column name, times is the data array

print("\n\n", df.head(15))