# phreakshot
Turns your android device into a wardialer via ADB. For whitehat testing purposes only... Do not use this software at all, most certainly not for anything illegal.
I am not responsible in any way for anything that happens to you, your health or your property as a result of proper or improper use of this thing.

USAGE:


brute [--cruise-control on] [--dict-file dict.txt] [--pin-len 4] [--start 100] [--end 200] [--pause 3.8]

cruise-control: if cruise-control is passed as off, user must press enter between pin entries, in sequential mode, 
user can press r for repeat, - for going back one, s for skip. if cruise-control on (default) program waits for
the value passed to pause in seconds between pin entries.



dict-file: dictionary file (default dict.txt)

pin-len: length of pin (default 4)

start: start of pin range

end: end of pin range

pause: number of seconds to pause in between pin entries when cruise-control is on.



