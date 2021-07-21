#!python3
# -*- coding: utf-8 -*-
#
# write : 0xBADC0DE
# This program is only private library for me
# Functhion List
#   [01] (2019-02-01) help()								: Show Export Function
#   [02] (2019-01-31) listCompare(list, list)			: Compare string list and show unique string
#   [03] (2019-02-01) uniqueNsort(list)				: Show unique and sort
#   [04] (2019-02-05) kisaWhois(str)					: KISA WHOIS
#   [05] (2019-02-18) getFilePath(str)					: Return to fullPath, folderName, fileName
#   [06] (2019-05-03) getToday()						: Show today date (ex: 190503)
#   [98] (2019-02-01) cprint(str, int)					: Color print
#   [99] (2019-02-01) print_error(str)					: Color print for error message
#
#
# import <moduleName> as <aliasName>


def main():
	help()
	

#############################################################################		
# [01] (2019-02-01) Show Export Function
#############################################################################	
def help():
	import sys

	logo = '''msbangLib is private library (for %s) Ver 19.11.30
Copyright (C) 2018-2019 0xBADC0DE. All rights reserved.
'''
	print('------------------------------------------------------------')
	s = logo % (sys.platform.upper())
	cprint(s, FOREGROUND_CYAN | FOREGROUND_INTENSITY)
	print('------------------------------------------------------------')

	# delete CR(carriage return)
	# ex) print("  %-45s "  %(u"0001. (2019-02-01) help")),
	# ex) cprint(u": for unicode", FOREGROUND_CYAN | FOREGROUND_INTENSITY)
	print("[Library List]")
	print("  %-45s %s" % ("#01 [190201] help()", ": Show export function"))
	print("  %-45s %s" % ("#02 [190131] listCompare(list,list)", ": Compare string list and show unique string"))
	print("  %-45s %s" % ("#03 [190201] uniqueNsort(list)", ": Show unique and sort"))
	print("  %-45s %s" % ("#04 [190205] kisaWhois(str)", ": KISA WHOIS"))
	print("  %-45s %s" % ("#05 [190218] getFilePath(str)", ": Return to fullPath, folderName, fileName"))
	print("  %-45s %s" % ("#06 [190503] getToday()", ": Show today date (ex: 190503)"))
	print("  %-45s %s" % ("#98 [190201] cprint(str,int)", ": Color print"))
	print("  %-45s %s" % ("#99 [190201] print_error(str)", ": Color print for error message"))


#############################################################################
# [02] (2019-01-31) Compare string list and show unique string
# Python 2.7.x (32bit)
# - find_list	: <type 'list'> key string list
# - total_list	: <type 'list'> target string list
# - return		: <type 'list'> found key string
#############################################################################
def listCompare(find_list, total_list):
	import re

	result = []

	if type(find_list) is not list:
		print("[TypeError][Func:listCompare] Argument_#1 is not 'list' type")
		return result
	elif type(total_list) is not list:
		print("[TypeError][Func:listCompare] Argument_#2 is not 'list' type")
		return result

	for find_text in find_list:
		find_text = str(find_text).strip()
		for total_text in total_list:
			total_text = str(total_text).strip()
			if re.search(find_text, total_text) > 0:
				result.append(total_text)
	return result


#############################################################################
# [03] (2019-02-01) Show unique and sort
# Python 2.7.x (32bit)
# - target_list	: <type 'list'> target list
# - return		: <type 'list'> result unique and sort
#############################################################################	
def uniqueNsort(target_list):
	result = []

	if type(target_list) is not list:
		print("[TypeError] [Func:listCompare] Argument_#1 is not 'list' type")
		return result

	uniq = list(set(target_list))
	sort = sorted(uniq)

	for i in sort:
		i = str(i).strip()
		result.append(i)
	return result


#############################################################################
# [04] (2019-02-05) KISA WHOIS (using only Internet)
# Python 2.7.x (32bit)
# - ip			: <type 'str'> target IP
# - return_1	: <type 'str'> result ISP name
# - return_2	: <type 'str'> result IP user name
#############################################################################	
def kisaWhois(ip):
	if type(ip) is not str:
		print("[TypeError] [Func:kisaWhois] Argument_#1 is not 'str' type")
		return "None", "None"

	import urllib2
	from xml.dom import minidom

	apiKey = "2016071518481727631881"
	url_head = "http://whois.kisa.or.kr/openapi/whois.jsp?query="
	url_midd = "&key="
	url_foot = "&answer=xml"

	ip = ip.strip()
	url = url_head + ip + url_midd + apiKey + url_foot
	dom = minidom.parse(urllib2.urlopen(url))
	items = dom.getElementsByTagName("orgName")

	try:
		return items[0].firstChild.data, items[1].firstChild.data
	except:
		return "ISP lookup failed", "IP lookup failed"


#############################################################################		
# [05] (2019-02-18) Return to fullPath, folderName, fileName
# Python 2.7.x (32bit)
# - cur_Path	: <type 'str'> fullPath of current file(__file__)
# - return_1	: <type 'str'> full Path
# - return_2	: <type 'str'> folder Name
# - return_3	: <type 'str'> file Name
#############################################################################	
def getFilePath(cur_Path=__file__):
	if type(cur_Path) is not str:
		print("[TypeError][Func:getFilePath] Argument_#1 is not 'str' type")
		return "None", "None", "None"

	import os
	file_name = os.path.basename(cur_Path)
	dir_path = os.path.dirname(cur_Path)
	pathTmp = dir_path.split(os.sep)
	current_dir = pathTmp[len(pathTmp) - 1]

	return cur_Path, current_dir, file_name


#############################################################################
# [06] (2019-05-03) Show today date
# Python 2.7.x (32bit)
# - return	: <type 'str'> today date (ex: 190503)
#############################################################################
def getToday():
	import datetime

	todayTmp = str(datetime.date.today())
	today = todayTmp[2:4] + todayTmp[5:7] + todayTmp[8:10]

	return today


#############################################################################		
# From here, class and function for color print
# python 2.7.x 32bit
#############################################################################	
from ctypes import windll, Structure, c_short, c_ushort, byref

# wincon.h
FOREGROUND_BLACK = 0x0000
FOREGROUND_BLUE = 0x0001
FOREGROUND_GREEN = 0x0002
FOREGROUND_CYAN = 0x0003
FOREGROUND_RED = 0x0004
FOREGROUND_MAGENTA = 0x0005
FOREGROUND_YELLOW = 0x0006
FOREGROUND_GREY = 0x0007
FOREGROUND_INTENSITY = 0x0008  # foreground color is intensified.

BACKGROUND_BLACK = 0x0000
BACKGROUND_BLUE = 0x0010
BACKGROUND_GREEN = 0x0020
BACKGROUND_CYAN = 0x0030
BACKGROUND_RED = 0x0040
BACKGROUND_MAGENTA = 0x0050
BACKGROUND_YELLOW = 0x0060
BACKGROUND_GREY = 0x0070
BACKGROUND_INTENSITY = 0x0080  # background color is intensified.

SHORT = c_short
WORD = c_ushort

class Coord(Structure):
	_fields_ = [
		("X", SHORT),
		("Y", SHORT)]

class SmallRect(Structure):
	_fields_ = [
		("Left", SHORT),
		("Top", SHORT),
		("Right", SHORT),
		("Bottom", SHORT)]

class ConsoleScreenBufferInfo(Structure):
	_fields_ = [
		("dwSize", Coord),
		("dwCursorPosition", Coord),
		("wAttributes", WORD),
		("srWindow", SmallRect),
		("dwMaximumWindowSize", Coord)]

# winbase.h
STD_INPUT_HANDLE = -10
STD_OUTPUT_HANDLE = -11
STD_ERROR_HANDLE = -12

stdout_handle = windll.kernel32.GetStdHandle(STD_OUTPUT_HANDLE)
SetConsoleTextAttribute = windll.kernel32.SetConsoleTextAttribute
GetConsoleScreenBufferInfo = windll.kernel32.GetConsoleScreenBufferInfo

def get_text_attr():
	csbi = ConsoleScreenBufferInfo()
	GetConsoleScreenBufferInfo(stdout_handle, byref(csbi))
	return csbi.wAttributes

def set_text_attr(color):
	SetConsoleTextAttribute(stdout_handle, color)


#############################################################################
# msg	: <type 'str'>
# color	: <type 'int'>
# ex) cprint("hello", FOREGROUND_CYAN | FOREGROUND_INTENSITY)
#############################################################################		
def cprint(msg, color=FOREGROUND_CYAN | FOREGROUND_INTENSITY):
	import sys

	default_colors = get_text_attr()
	default_bg = default_colors & 0x00F0

	set_text_attr(color | default_bg)
	sys.stdout.write(msg)
	set_text_attr(default_colors)

	sys.stdout.flush()


def print_error(msg):
	cprint('Error: ', FOREGROUND_RED | FOREGROUND_INTENSITY)
	print (msg)


#############################################################################
if __name__ == '__main__':
	main()