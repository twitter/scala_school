#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'redcloth'
require 'erb'

DIR_NAME = File.expand_path File.dirname(__FILE__)
LESSONS = Dir["#{DIR_NAME}/*.textile"].map { |f| f[/([^\/]+)\.textile$/, 1] }
set :views, DIR_NAME

def render_lesson(page)
  html = textile(page)
  heading = [html[/\A<h1>(.+)?<\/h1>/,1], html[/<\/h1>\n<h2>(.+)?<\/h2>/m,1]].compact
  heading.each { |h| html.gsub!(h,'') }
  erb :main, :locals => {
    :text => html,
    :heading => heading,
    :lessons => LESSONS
  }
end

get '/' do
  render_lesson LESSONS.first.to_sym
end

get '/:page' do
  render_lesson params[:page].to_sym if LESSONS.include?(params[:page])
end

helpers do
  def titleize(str)
    num, name = str[/(\d+)/,1], str[/([a-z]+)$/i,1]
    name.gsub(/^([a-z])/i) { $1.upcase } + (" #{num}" if num.to_i > 0).to_s
  end
end

__END__

@@ main

<html>
  <head>
    <title>Twitter Scala School</title>
    <style type='text/css'><%= erb :styles %></style>
  </head>
  <body>
    <div id='topbar' class='black'>
      <div class='fixed-container clearfix'>
        <ul class='right'>
          <li class='menu'>
            <a href='#' class='parent'>Lessons</a>
            <ul>
              <% lessons.each do |l| %>
                <li><a href='<%= l %>'><%= titleize l %></a></li>
              <% end %>
            </ul>
          </li>
        </ul>
        <h3>
          <a href='#'>Twitter Scala School</a>
        </h3>
      </div>
    </div>

    <div id='workspace'>
      <div class='fixed-container'>
        <div class='page-header'>
          <h1>
            <%= heading[0] %>
            <%= "<br /><small>#{heading[1]}</small>" if heading[1] %>
          </h1>
        </div>
        <div class='row clearfix'>
          <div class='sixteen columns'>
            <%= text %>
          </div>
        </div>
      </div>
    </div>
    <div id='foot_pad'></div>
  </body>
</html>

@@ styles

html,body{margin:0;padding:0;}
h1,h2,h3,h4,h5,h6,p,blockquote,pre,a,abbr,acronym,address,cite,code,del,dfn,em,img,q,s,samp,small,strike,strong,sub,sup,tt,var,dd,dl,dt,li,ol,ul,fieldset,form,label,legend,button,table,caption,tbody,tfoot,thead,tr,th,td{margin:0;padding:0;border:0;font-weight:normal;font-style:normal;font-size:100%;line-height:1;font-family:inherit;text-align:left;}
table{border-collapse:collapse;border-spacing:0;}
ol,ul{list-style:none;}
q:before,q:after,blockquote:before,blockquote:after{content:"";}
body{font:normal 14px/20px "Helvetica Neue",Helvetica,Arial,sans-serif;color:#333;-webkit-font-smoothing:antialiased;text-rendering:optimizeLegibility;}
a,a:visited{color:#0084b4;text-decoration:none;}
a:hover{color:#005f81;text-decoration:underline;}
hr{margin:26px 0;border:0;border-top:1px solid #eee;border-bottom:1px solid #fff;}
strong{font-style:inherit;font-weight:bold;}
em{font-style:italic;font-weight:inherit;}
blockquote{margin:20px 0 20px 15px;border-left:5px solid #eee;padding:5px 20px 5px 20px;}
blockquote p{font-size:18px;font-weight:300;line-height:25px;margin-bottom:10px;}
blockquote cite{display:block;margin-bottom:10px;font-size:12px;color:#999;font-style:normal;}
blockquote cite:before{content:'\2014 \00A0';}
address{display:block;line-height:18px;margin-bottom:15px;}
code,pre{padding:0 3px 2px;font-family:Monaco, Andale Mono, Courier New, monospace;font-size:12px;border-radius:3px;-khtml-border-radius:3px;-moz-border-radius:3px;-webkit-border-radius:3px;border-radius:3px;-khtml-border-radius:3px;-moz-border-radius:3px;-webkit-border-radius:3px;}
code{background:rgba(250, 162, 38, 0.25);color:rgba(0, 0, 0, 0.75);display:inline-block;padding:2px 3px 3px;}
pre{font: normal normal normal 12px/normal Monaco, 'Courier New', 'DejaVu Sans Mono', 'Bitstream Vera Sans Mono', monospace;line-height:1.5em;background:#f8f8ff;display:block;padding:5px;margin:10px 0 18px;box-shadow:inset 0 1px 2px rgba(0, 0, 0, 0.2);-moz-box-shadow:inset 0 1px 2px rgba(0, 0, 0, 0.2);-webkit-box-shadow:inset 0 1px 2px rgba(0, 0, 0, 0.2);border-radius:3px;-khtml-border-radius:3px;-moz-border-radius:3px;-webkit-border-radius:3px;border-radius:3px;-khtml-border-radius:3px;-moz-border-radius:3px;-webkit-border-radius:3px;border:1px solid rgba(0, 0, 0, 0.2);box-shadow:0 1px 2px rgba(0, 0, 0, 0.15);-moz-box-shadow:0 1px 2px rgba(0, 0, 0, 0.15);-webkit-box-shadow:0 1px 2px rgba(0, 0, 0, 0.15);-webkit-font-smoothing:subpixel-antialiased;}
p{font-size:14px;line-height:20px;margin:0 0 15px;}
p.lead{font-size:18px;line-height:25px;margin-bottom:15px;font-weight:300;color:;}
h1,h2,h3,h4,h5,h6{margin:0;line-height:1;color:#111;}
h1{font-size:40px;margin:0 0 14px;letter-spacing:-1px;}
h2{font-size:30px;margin:3px 0;letter-spacing:-1px;}
h3{font-size:24px;margin:9px 0 3px;}
h4{font-size:18px;margin:14px 0 4px;}
h5{font-size:16px;margin:14px 0 6px;}
h5{font-size:14px;margin:14px 0 9px;}
h1 small,h2 small,h3 small{color:#999;}
h1 small{font-size:20px;}
h2 small{font-size:18px;}
h3 small{font-size:16px;}
ul,ol{margin:0 0 15px 25px;padding:0;}
ul ul,ul ol,ol ol,ol ul{margin-bottom:0;}
ul{list-style:disc;}
ol{list-style:decimal;}
li{line-height:20px;}
ul.unstyled{list-style:none;margin:0 0 15px;}
dl{margin:0 0 15px;}
dl dt,dl dd{line-height:20px;}
dl dt{font-weight:bold;}
dl dd{margin-bottom:5px;}
.row{margin-left:-20px;}
.row .column,.row .columns{display:inline;float:left;margin-left:20px;}
.row .sixteen{width:940px;}
.clearfix{zoom:1;}
.clearfix:after{content:".";display:block;height:0;clear:both;visibility:hidden;}
div#topbar{background:#00a0d1;background:#00a0d1 -webkit-gradient(linear, 0 0, 0 100%, from(#00a0d1), to(#008db8));background:#00a0d1 -moz-linear-gradient(#00a0d1, #008db8);height:40px;position:fixed;top:0;right:0;left:0;z-index:100;overflow:visible;box-shadow:0 1px 3px rgba(0, 0, 0, 0.25),inset 0 -1px 0 rgba(0, 0, 0, 0.15);-moz-box-shadow:0 1px 3px rgba(0, 0, 0, 0.25),inset 0 -1px 0 rgba(0, 0, 0, 0.15);-webkit-box-shadow:0 1px 3px rgba(0, 0, 0, 0.25),inset 0 -1px 0 rgba(0, 0, 0, 0.15);}
div#topbar a{text-shadow:0 -1px 0 rgba(0, 0, 0, 0.5);}
div#topbar ul a:hover,div#topbar h3 a:hover{background-color:#008db8;color:#fff;text-decoration:none;}
div#topbar h3{font-size:18px;line-height:1;margin:0;color:#fff;}
div#topbar h3 a{background:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACEAAAAXCAYAAACFxybfAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAUZJREFUeNq0VoENgjAQROMAHQE3YARGYAPrBjqBbIBOgBs4Am6gG1QnwA3er75Jg5T+13rJpQmlz5X+/3UGAFli5DRWyD1rhRWRkBWyhzc+ow6t802oCAGF8+EPNpy1vomOqJkCrGgD4zD0h8QiaieI3V2DzCcC1RCGjjmOfiRQOyLG9+4YKomIjD7mC946ebMBPoxURGh3PSWjARm+/sZionoPyN3EvEJ2NEqwQj6cnnIOZX0D/4U91mweUH14KU2PG/KIvCOLkAjbess/iMgptsWV04hSH8mJEppVHcNe0CUSUQ7jzwQuColyYTl8OBcE2DqlFYu1z8pLptspKqlYNCHv0BOuqei5+bUfcAxMO4suJMqkakgSKy8FjggMb4m+1KgEvaGV3M5CVl7T0XBwoZ2Lr4bcPmGdsiCqQd3ffvWXpwADAGj/P4ZZFeICAAAAAElFTkSuQmCC) no-repeat 10px 8px;float:left;margin-left:-10px;padding:10px 10px 12px;padding-left:50px;color:#fff;font-weight:bold;}
div#topbar h3 a small{font-size:14px;color:rgba(255, 255, 255, 0.5);text-shadow:0 -1px 0 rgba(0, 0, 0, 0.25);}
div#topbar ul{float:left;display:block;margin:0;}
div#topbar ul.right{float:right;}
div#topbar ul li{display:block;float:left;font-size:13px;position:relative;}
div#topbar ul a{display:block;float:none;padding:0 10px;color:#fff;font-weight:bold;line-height:40px;text-decoration:none;}
div#topbar ul li.active a,div#topbar ul li ul li.active a{background:#3f7ca0;color:#fff;}
div#topbar ul li.active a{border-left:0;padding-left:14px;}
div#topbar form{float:right;margin:0;padding:7px 13px 0;}
div#topbar form input{width:200px;font:13px/1 "Helvetica Neue",Helvetica,Arial,sans-serif;}
div#topbar ul li.menu a.parent{padding-right:26px;background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAHCAYAAAAIy204AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAEhJREFUeNpi/P//PwM1ASO1DWQAGjjtP3YAEmcgFYMIZiDeiGbYRqg4WQaCMCcQn4QadhLKZ6DEQBAWBeK9UJqBXEz1SAEIMAAhUQYw1OXVaAAAAABJRU5ErkJggg==);background-position:right center;background-repeat:no-repeat;}
div#topbar ul li ul{background:#142f3c;background:rgba(0, 43, 56, 0.9);float:left;display:block;position:absolute;z-index:1000;width:160px;text-align:left;padding:5px 0;border-radius:0 0 5px 5px;-khtml-border-radius:0 0 5px 5px;-moz-border-radius:0 0 5px 5px;-webkit-border-bottom-left-radius:5px;-webkit-border-bottom-right-radius:5px;box-shadow:0 1px 3px rgba(0, 0, 0, 0.25);-moz-box-shadow:0 1px 3px rgba(0, 0, 0, 0.25);-webkit-box-shadow:0 1px 3px rgba(0, 0, 0, 0.25);border:0;}
div#topbar ul.left li ul{position:absolute;top:-999em;left:0;}
div#topbar ul.right li ul{position:absolute;top:-999em;right:0;}
div#topbar ul li ul li{float:none;}
div#topbar ul li ul li a{line-height:25px;border:0;font-weight:normal;}
div#topbar ul li:hover ul{top:40px;}
div#topbar ul ul li.divider{height:auto;margin:5px 0;border-top:1px solid rgba(0, 0, 0, 0.15);border-bottom:1px solid rgba(255, 255, 255, 0.1);}
div#topbar.black{background:#333;background:#333333 -webkit-gradient(linear, 0 0, 0 100%, from(#333333), to(#111111));background:#333333 -moz-linear-gradient(#333333, #111111);box-shadow:0 1px 2px rgba(0, 0, 0, 0.5),inset 0 -1px 0 rgba(0, 0, 0, 0.3);-moz-box-shadow:0 1px 2px rgba(0, 0, 0, 0.5),inset 0 -1px 0 rgba(0, 0, 0, 0.3);-webkit-box-shadow:0 1px 2px rgba(0, 0, 0, 0.5),inset 0 -1px 0 rgba(0, 0, 0, 0.3);}
div#topbar.black ul a:hover,div#topbar.black h3 a:hover{background-color:#333;}
div#topbar.black ul{border-left-color:rgba(0, 0, 0, 0.15);}
div#topbar.black ul li a{border-right-color:rgba(0, 0, 0, 0.15);}
div#topbar.black ul li.active a,div#topbar.black ul li ul li.active a{background:#333;}
div#topbar.black ul li ul li a:hover{background:#222;}
div#topbar.black ul li ul{background:#333;background:rgba(0, 0, 0, 0.8);}
div#workspace{margin-top:40px;padding-top:20px;}
div.fixed-container{padding:0;width:940px;margin:0 auto;}
div#topbar div.fixed-container ul.right{margin-right:-15px;}
div#topbar div.fluid-container{padding-left:10px;}
div#workspace div.fluid-container{margin:0 0 0 220px;}
div#foot_pad{height:75em;}
table{width:100%;margin:5px 0 20px;border-collapse:separate;}
table tr:hover{background:rgba(0, 0, 0, 0.03);}
table{background:#fff;box-shadow:0 1px 1px rgba(0, 0, 0, 0.3);-moz-box-shadow:0 1px 1px rgba(0, 0, 0, 0.3);-webkit-box-shadow:0 1px 1px rgba(0, 0, 0, 0.3);border-radius:3px;-khtml-border-radius:3px;-moz-border-radius:3px;-webkit-border-radius:3px;border-radius:3px;-khtml-border-radius:3px;-moz-border-radius:3px;-webkit-border-radius:3px;border:1px solid #ddd;}table.table-bordered thead tr:first-child th:first-child{border-radius:3px 0 0 0;-khtml-border-radius:3px 0 0 0;-moz-border-radius:3px 0 0 0;-webkit-border-top-left-radius:3px;}
table tr:first-child th:last-child{border-radius:0 3px 0 0;-khtml-border-radius:0 3px 0 0;-moz-border-radius:0 3px 0 0;-webkit-border-top-right-radius:3px;}
table tr:last-child td{border-bottom:0 !important;}
table tr:last-child th:first-child,table.table-bordered tfoot tr:last-child th:first-child{border-radius:0 0 0 3px;-khtml-border-radius:0 0 0 3px;-moz-border-radius:0 0 0 3px;-webkit-border-bottom-left-radius:3px;}
table tr:last-child th:last-child,table.table-bordered tfoot tr:last-child th:last-child{border-radius:0 0 3px 0;-khtml-border-radius:0 0 3px 0;-moz-border-radius:0 0 3px 0;-webkit-border-bottom-right-radius:3px;}
table tr th+th,table tr td+td{border-left:1px solid rgba(255, 255, 255, 0.5) !important;border-right:1px solid rgba(0, 0, 0, 0.1) !important;}
table tr th:first-child,table.table-bordered td:first-child{border-right:1px solid rgba(0, 0, 0, 0.1) !important;}
table tr th:last-child,table.table-bordered td:last-child{border-right:0 !important;}
table tr td{padding:5px 10px;color:#555;line-height:18px;border-bottom:1px solid #eee;vertical-align:top;}
table tr td a.block-link{display:block;margin:-10px;padding:10px;font-weight:bold;text-shadow:0 1px 1px rgba(255, 255, 255, 0.75);}

