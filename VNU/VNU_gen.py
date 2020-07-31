import numpy as np

def f(x):
    x = abs(x)
    if(x < 1e-5): return 3.75

    t = np.e**(-x)
    return min(np.log((1+t)/(1-t)), 3.75)

def round_to(num, target):
    return round(num/target)*target

def calc_x_val(var):
    x    = var
    num  = ((x%10)*0.25)
    x    = int(x/10)
    num  = num + ((x%10)*0.5)
    x    = int(x/10)
    num  = num + (x%10)
    x    = int(x/10)
    num  = num + ((x%10)*2)
    x    = int(x/10)
    sign = 1 if (x%10)==0 else -1
    num  = num * sign
    return num

def calc_bits_from_Y_val(num: int) -> str :
    flag = 0
    if num<0:
        sign = 1
        flag = 1
    num           = abs(num)
    rounded_Y_val = round_to(num, 0.25)

    int_val       = int(np.floor(rounded_Y_val))

    frac_val      = rounded_Y_val - int_val
    frac_str      = ""
    if not flag:
        sign = 0
    i = round(100*frac_val)

    if   i == 0  :  frac_str = "00"
    elif i == 25 :  frac_str = "01"
    elif i == 50 :  frac_str = "10"
    elif i == 75 :  frac_str = "11"
    return ("{0:01b}".format(sign)) + ("{0:02b}".format(int_val)) + frac_str

Z   = int(input("Z:"))
X_0 = int(input("X_0:"))
X_1 = int(input("X_1:"))
X_2 = int(input("X_2:"))
list      = [calc_x_val(X_0), calc_x_val(X_1), calc_x_val(X_2)]
#code to calculate float value from Z in two's complement

var       = Z
intrinsic = (var%10)*0.25
var       = int(var/10)
intrinsic = intrinsic + (var%10)*0.5
var       = int(var/10)
intrinsic = intrinsic + (var%10)
var       = int(var/10)
intrinsic = intrinsic + (var%10)*2
var       = int(var/10)
intrinsic = intrinsic + (var%10)*(-4)

sum = 0
for x in list:
    sum = sum + x

for x in list:
    gamma    = intrinsic + (sum - x)
    sign     = 1 if gamma>=0 else -1
    message  = sign * f(gamma)
    hd_raw_1 = intrinsic + sum
    hd_1     = "0" if hd_raw_1>0 else "1"
    print(hd_1 + calc_bits_from_Y_val(message))

hd_raw_2 = intrinsic + sum
hd_2     = 0 if hd_raw_2>0 else 1
print(hd_2)
