#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'redcloth'
require 'erb'

DIR_NAME = File.expand_path File.dirname(__FILE__)
set :views, DIR_NAME

def render_lesson(page)
  erb :main, :locals => {
    :text => textile(page),
    :lessons => Dir["#{DIR_NAME}/*.textile"].map { |f| f[/([^\/]+)\.textile$/, 1] }
  }
end

get '/' do
  render_lesson :index
end

get '/:page' do
  render_lesson params[:page].to_sym if File.exists?("#{DIR_NAME}/#{params[:page]}.textile")
end


__END__

@@ main

<html>
  <head>
    <title>Twitter Scala School</title>
    <style type='text/css'><%= erb :styles %></style>
  </head>
  <body>
    <div id='workspace'>
      <div id='sidebar'>
        <ul>
          <li>
            <strong>Lessons</strong>
            <ul>
              <% lessons.each do |l| %>
                <li class='<%= :active if params[:page] == l %>'><a href='<%= l %>'><%= l %></a></li>
              <% end %>
            </ul>
          <li>
        </ul>
      </div>
      <div class='fluid-container'>
        <div class='inner-wrapper'>
          <div class='page-header'>
            <h1>Twitter Scala School</h1>
          </div>
          <%= text %>
        </div>
      </div>
  </body>
</html>

@@ styles

html,body{margin:0;padding:0;background:#fff;}
h1,h2,h3,h4,h5,h6,p,blockquote,pre,a,abbr,acronym,address,cite,code,del,dfn,em,img,q,s,samp,small,strike,strong,sub,sup,tt,var,dd,dl,dt,li,ol,ul,fieldset,form,label,legend,button,table,caption,tbody,tfoot,thead,tr,th,td{margin:0;padding:0;border:0;font-weight:normal;font-style:normal;font-size:100%;line-height:1;font-family:inherit;text-align:left;}
table{border-collapse:collapse;border-spacing:0;}
ol,ul{list-style:none;}
q:before,q:after,blockquote:before,blockquote:after{content:"";}
a:hover img.bordered{box-shadow:0 0 9px rgba(55, 135, 168, 0.75);-moz-box-shadow:0 0 9px rgba(55, 135, 168, 0.75);-webkit-box-shadow:0 0 9px rgba(55, 135, 168, 0.75);top:-5px;}
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
pre{background:#eee;display:block;padding:5px;margin:10px 0 18px;box-shadow:inset 0 1px 2px rgba(0, 0, 0, 0.2);-moz-box-shadow:inset 0 1px 2px rgba(0, 0, 0, 0.2);-webkit-box-shadow:inset 0 1px 2px rgba(0, 0, 0, 0.2);border-radius:3px;-khtml-border-radius:3px;-moz-border-radius:3px;-webkit-border-radius:3px;border-radius:3px;-khtml-border-radius:3px;-moz-border-radius:3px;-webkit-border-radius:3px;border:1px solid rgba(0, 0, 0, 0.2);box-shadow:0 1px 2px rgba(0, 0, 0, 0.15);-moz-box-shadow:0 1px 2px rgba(0, 0, 0, 0.15);-webkit-box-shadow:0 1px 2px rgba(0, 0, 0, 0.15);-webkit-font-smoothing:subpixel-antialiased;}
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
.clearfix{zoom:1;}
.clearfix:after{content:".";display:block;height:0;clear:both;visibility:hidden;}
span.status-label{background:#ccc;padding:3px 5px;font-size:10px;font-weight:bold;color:#fff;text-shadow:0 0 1px rgba(0, 0, 0, 0.01) !important;text-transform:uppercase;border-radius:3px;-moz-border-radius:3px;-webkit-border-radius:3px;}
span.status-label.disabled{background-color:#ccc;}
span.status-label.active,span.status-label.scheduled{background-color:#489b48;}
div#workspace{margin-top:40px;padding-top:20px;}
div#workspace div.fluid-container{margin:0 0 0 215px;}
div.fluid-container div.inner-wrapper{min-width:940px;max-width:1200px;padding:20px 20px 40px;overflow:hidden;}
div#sidebar{background:#f5f5f5 url(../images/dirty.png);float:left;width:199px;min-height:500px;margin:0 0 20px 20px;padding:15px 0 0;font-size:13px;line-height:15px;border-radius:6px;-khtml-border-radius:6px;-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;-khtml-border-radius:6px;-moz-border-radius:6px;-webkit-border-radius:6px;box-shadow:inset 0 1px 2px rgba(0, 0, 0, 0.15);-moz-box-shadow:inset 0 1px 2px rgba(0, 0, 0, 0.15);-webkit-box-shadow:inset 0 1px 2px rgba(0, 0, 0, 0.15);}
div#sidebar ul{margin:0;}
div#sidebar li{display:block;}
div#sidebar li a,div#sidebar li strong{display:block;margin-bottom:1px;padding:5px 15px;text-decoration:none;font-size:13px;}
div#sidebar li strong{color:rgba(0, 0, 0, 0.5);}
div#sidebar li a:hover{background:rgba(255, 255, 255, 0.5);}
div#sidebar li a.active,div#sidebar li.active a{background:#00a0d1;background:#00a0d1 -webkit-gradient(linear, 0 0, 0 100%, from(#00a0d1), to(#008db8));background:#00a0d1 -moz-linear-gradient(#00a0d1, #008db8);color:#fff;text-shadow:0 -1px 0 rgba(0, 0, 0, 0.3);}
div#sidebar li.inactive a,div#sidebar li.inactive a:hover{background:none;color:#777777;cursor:none;}
div#sidebar ul li ul{padding-bottom:10px;}
