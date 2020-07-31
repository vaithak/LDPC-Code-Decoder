import numpy as np

def sig (x):
    if x<0:
        return -1
    else:
        return 1

def bin_to_float(var):
    x = var
    num = 0.0
    num = num + 0.25 * (x%10)
    x = int(x/10)
    num = num + 0.5 * (x%10)
    x = int(x/10)
    num = num + (x%10)
    x = int(x/10)
    num = num + 2 * (x%10)
    x = int(x/10)
    sign = 1 if x%10==0 else -1
    num = num * sign
    return num

def f(x):
    x = abs(x)
    if(x < 1e-5): return 3.75

    t = np.e**(-x)
    return min(np.log((1+t)/(1-t)), 3.75)

def round_to(num, target):
    return round(num/target)*target

def calc_bits_from_Y_val(num: int) -> str :
    sign_of_num = 1 if num<0 else 0
    num = abs(num)
    rounded_Y_val = round_to(num, 0.25)
    int_val = int(np.floor(rounded_Y_val))

    frac_val = rounded_Y_val - int_val
    frac_str = ""
    i = round(100*frac_val)

    if   i == 0  :  frac_str = "00"
    elif i == 25 :  frac_str = "01"
    elif i == 50 :  frac_str = "10"
    elif i == 75 :  frac_str = "11"

    return ("{0:01b}".format(sign_of_num)) + ("{0:02b}".format(int_val)) + frac_str

input_1 = int(input("X[0]:"))
input_2 = int(input("X[1]:"))
input_3 = int(input("X[2]:"))
input_4 = int(input("X[3]:"))
input_5 = int(input("X[4]:"))
input_6 = int(input("X[5]:"))

inputs = [bin_to_float(input_1),
          bin_to_float(input_2),
          bin_to_float(input_3),
          bin_to_float(input_4),
          bin_to_float(input_5),
          bin_to_float(input_6)]

sign_product = 1
sum = 0
for x in inputs:
    sign_product = sign_product * int(sig(x))
    sum = sum + abs(x)

for x in inputs:
    alpha = sum - abs(x)
    product = int(sign_product * int(sig(x)))
    message = product * f(alpha)
    print(calc_bits_from_Y_val(message))
