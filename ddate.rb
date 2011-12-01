# (c) Copyright 2011 David Wagner.
#
# Complain/commend: http://noiseandheat.com/
#
#
# Licensed under the MIT license:
#
#     http://www.opensource.org/licenses/mit-license.php
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

module NoiseAndHeat
    class DiscordianDate < Liquid::Tag
        def initialize(tag_name, markup, tokens)
            if markup =~ /(post|page)?(.*)/i
                @use_post_date = $1 ? true : false
                @date_time = $2
            else
                raise ::Liquid::SyntaxError.new("ddate should be of the form {% ddate %} for date at generation, {% ddate post %} for date of post or {% ddate 1976-07-15 18:40 %} for a custom date")
            end
        end

        def parse_date_time(date_time)
            if date_time
                date, time = date_time.split " "
                if date =~ /-/
                    year, month, day = date.split "-"
                elsif date =~ /\//
                    year, month, day = date.split "/"
                elsif date =~ /\\/
                    year, month, day = date.split "\\"
                else
                    return Time.now
                end
                return Time.utc year, month, day
            end
            return Time.now
        end

        def render(context)
            if @use_post_date
                if context["page"]
                    ddate = DDate.new(context["page"]["date"]).to_s
                elsif context["post"]
                    ddate = DDate.new(context["post"]["date"]).to_s
                end
            else
                ddate = DDate.new(parse_date_time(@date_time)).to_s
            end

            return ddate
        end
    end
end

Liquid::Template.register_tag('ddate', NoiseAndHeat::DiscordianDate)

############################################################################
# DDate class originally taken from:
#    http://ddate.rubyforge.org/
############################################################################
# As is written in the Principia Discordia:


# St. Tib's Day occurs once every 4 years (1+4= 5 ) and is inserted between the 59th and 60th days of the Season of Chaos.
#       The year that is 1991 by the Thuddite Reckoning is 3157 to Discordians. The next St. Tibs Day after that year is 3158.
#      
# 
#                     SM BT PD PP SO                          SM BT PD PP SO
#                     -- -- -- -- --                          -- -- -- -- --
# Jan  1  2  3  4  5   1  2  3  4  5 Chs  Jul  5  6  7  8  9  40 41 42 43 44 Cfn
#      6  7  8  9 10   6  7  8  9 10          10 11 12 13 14  45 46 47 48 49    
#     11 12 13 14 15  11 12 13 14 15          15 16 17 18 19  50 51 52 53 54    
#     16 17 18 19 20  16 17 18 19 20          20 21 22 23 24  55 56 57 58 59    
#     21 22 23 24 25  21 22 23 24 25          25 26 27 28 29  60 61 62 63 64    
#     26 27 28 29 30  26 27 28 29 30          30 31  1  2  3  65 66 67 68 69    
#     31  1  2  3  4  31 32 33 34 35      Aug  4  5  6  7  8  70 71 72 73  1 Bcy
# Feb  5  6  7  8  9  36 37 38 39 40           9 10 11 12 13   2  3  4  5  6    
#     10 11 12 13 14  41 42 43 44 45          14 15 16 17 18   7  8  9 10 11    
#     15 16 17 18 19  46 47 48 49 50          19 20 21 22 23  12 13 14 15 16    
#     20 21 22 23 24  51 52 53 54 55          24 25 26 27 28  17 18 19 20 21    
#     25 26 27 28* 1  56 57 58 59 60          29 30 31  1  2  22 23 24 25 26    
# Mar  2  3  4  5  6  61 62 63 64 65      Sep  3  4  5  6  7  27 28 29 30 31    
#      7  8  9 10 11  66 67 68 69 70           8  9 10 11 12  32 33 34 35 36    
#     12 13 14 15 16  71 72 73  1  2 Dsc      13 14 15 16 17  37 38 39 40 41    
#     17 18 19 20 21   3  4  5  6  7          18 19 20 21 22  42 43 44 45 46    
#     22 23 24 25 26   8  9 10 11 12          23 24 25 26 27  47 48 49 50 51    
#     27 28 29 30 31  13 14 15 16 17          28 29 30  1  2  52 53 54 55 56    
# Apr  1  2  3  4  5  18 19 20 21 22      Oct  3  4  5  6  7  57 58 59 60 61    
#      6  7  8  9 10  23 24 25 26 27           8  9 10 11 12  62 63 64 65 66    
#     11 12 13 14 15  28 29 30 31 32          13 14 15 16 17  67 68 69 70 71    
#     16 17 18 19 20  33 34 35 36 37          18 19 20 21 22  72 73  1  2  3 Afm
#     21 22 23 24 25  38 39 40 41 42          23 24 25 26 27   4  5  6  7  8    
#     26 27 28 29 30  43 44 45 46 47          28 29 30 31  1   9 10 11 12 13    
# May  1  2  3  4  5  48 49 50 51 52      Nov  2  3  4  5  6  14 15 16 17 18    
#      6  7  8  9 10  53 54 55 56 57           7  8  9 10 11  19 20 21 22 23    
#     11 12 13 14 15  58 59 60 61 62          12 13 14 15 16  24 25 26 27 28    
#     16 17 18 19 20  63 64 65 66 67          17 18 19 20 21  29 30 31 32 33    
#     21 22 23 24 25  68 69 70 71 72          22 23 24 25 26  34 35 36 37 38    
#     26 27 28 29 30  73  1  2  3  4 Cfn      27 28 29 30  1  39 40 41 42 43    
#     31  1  2  3  4   5  6  7  8  9      Dec  2  3  4  5  6  44 45 46 47 48    
# Jun  5  6  7  8  9  10 11 12 13 14           7  8  9 10 11  49 50 51 52 53    
#     10 11 12 13 14  15 16 17 18 19          12 13 14 15 16  54 55 56 57 58    
#     15 16 17 18 19  20 21 22 23 24          17 18 19 20 21  59 60 61 62 63    
#     20 21 22 23 24  25 26 27 28 29          22 23 24 25 26  64 65 66 67 68    
#     25 26 27 28 29  30 31 32 33 34          27 28 29 30 31  69 70 71 72 73    
#     30  1  2  3  4  35 36 37 38 39


# So it shall be:

class DDate
  def initialize(gregorian_time=nil)
    @time = gregorian_time || Time.now
  end
  
  def month_number
    (yday-1) / 73
  end
  
  def month
    ["Chaos", "Discord", "Confusion", "Bureaucracy", "The Aftermath"][month_number]
  end
  
  
  def day_of_month
    yday % 73 == 0 ? 73 : yday % 73
  end
  
  def day_of_week
    return -1 if tibs_day?
    yday % 5
  end
  
  def day_of_week_name
    return "St. Tib's Day" if tibs_day?
    ["Setting Orange", 'Sweetmorn', 'Boomtime', 'Pungenday', 'Prickle Prickle'][day_of_week]
  end
  
  def year
    @time.year + 1166
  end
  
  def holyday
    case day_of_month
    when 5
      ["Mungday", "Mojoday", "Syaday", "Zaraday", "Maladay"][month_number] 
    when 50
      ["Chaoflux", "Discoflux", "Confuflux", "Bureflux", "Afflux"][month_number] 
    else
      "St. Tib's Day" if tibs_day?
    end
  end

  
  def to_s(format_str="%W[, %d] of %M %y YOLD{ and the holyday of %H}")
    format(format_str)
  end
  
  def format(str)
    formattings = [["%w","day_of_week"],
                   ["%W","day_of_week_name"],
                   ["%d","day_of_month"],
                   ["%m","month_number"],
                   ["%M","month"],
                   ["%H","holyday"],
                   ["%y","year"]]
    formattings.each do |from,to|
      str.gsub!(from,eval(to).to_s)
    end
    bracketings = [["{}","!holyday or tibs_day?"],
                   ["[]","tibs_day?"]]
    bracketings.each do |wrappers,condition|
      if eval(condition)
        regex = Regexp.new("\\" + wrappers[0,1] + ".*" + "\\" + wrappers[1,1])
      else
        regex = Regexp.new("[\\" + wrappers[0,1] + "\\" + wrappers[1,1] + "]")
      end
      str.gsub!(regex,"")
    end
    str
  end
  
  def tib_year?
    @time.year % 4 == 0
  end
  
  def tibs_day?
    tib_year? && @time.yday == 31+29
  end
  
private
  def yday
    return (@time.yday-1) if tib_year? and @time.yday > 60
    @time.yday
  end
end
