#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Nov  9 01:24:08 2019

@author: yushengfu
"""

from selenium import webdriver
import time
import csv

class Crawl_apartments:
	def __init__(self, keyword):
		self.driver = webdriver.Chrome('/Users/yushengfu/Desktop/All/758YDataBase/Python/chromedriver')
		# self.driver = webdriver.Chrome()
		self.driver.maximize_window()
		self.driver.get('https://www.apartments.com/')
		self.keyword = keyword
		self.filename = keyword + '.csv'
	def run(self):
		# 输入关键词并搜索
		self.driver.find_element_by_xpath("//*[@id='quickSearchLookup']").send_keys(self.keyword)
		time.sleep(1)
		self.driver.find_element_by_xpath("//*[@title='Search apartments for rent']").click()

		# 获取到url判断加载结束
		while True:
			try:
				self.driver.current_url
				break
			except:
				pass

		# 获取当前第一节点
		while True:
			try:
				ele = self.driver.find_element_by_xpath("//*[@class='placardTitle js-placardTitle  ']")
				break
			except:
				pass

		while True:
			try:
				# 获取元素信息
				a = self.driver.find_element_by_xpath("//*[@class='placardTitle js-placardTitle  ']").text
				print(a)
				b = self.driver.find_element_by_xpath("//*[@class='location']").text
				print(b)
				c = self.driver.find_element_by_xpath("//*[@class='altRentDisplay']").text
				print(c)
				d = self.driver.find_element_by_xpath("//*[@class='unitLabel ']").text
				print('户型', d)
				try:
					e = self.driver.find_element_by_xpath("//*[@class='availabilityDisplay noBedSelected ']").text
				except:
					e = self.driver.find_element_by_xpath("//*[@class='availabilityDisplay  ']").text
				print(e)
				f = self.driver.find_element_by_xpath("//*[@class='phone']").text
				print('📞', f)
				print('-----------------------------------------------------------------------------')
				self.driver.execute_script("ele = document.getElementById('placardContainer').getElementsByTagName('li')[0];ele.parentNode.removeChild(ele)")

				# 储存数据代码
				try:
					with open(self.filename, "a", newline='', encoding='utf_8_sig') as file:
						csv_file = csv.writer(file)
						csv_file.writerow([a, b, c, d, e, f])
				except Exception as E:
					print('文件疑似被占用无法写入，解除占用后程序将会继续...\n错误信息：', E)
					while True:
						try:
							with open(self.filename, "a", newline='', encoding='utf_8_sig') as file:
								csv_file = csv.writer(file)
								csv_file.writerow([a, b, c, d, e, f])
							break
						except:
							time.sleep(1)
			except:
				time.sleep(1)
				# 报错表示当前页已爬取完毕,试图翻页
				try:
					self.driver.find_element_by_xpath("//a[@class='next ']").click()
					while True:
						try:
							new_ele = self.driver.find_element_by_xpath("//*[@class='placardTitle js-placardTitle  ']")
							if new_ele != ele:
								ele = new_ele
								break
						except:
							pass
					# 如果第一节点和
				except:
					# 翻页报错表示爬取结束availabilityDisplay noBedSelected
					self.driver.quit()
					break




if __name__ == '__main__':
	crawl = Crawl_apartments('College Park')
	crawl.run()
