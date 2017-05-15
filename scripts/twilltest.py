#!/usr/bin/env python2
import twill
import twill.commands
t_com = twill.commands
## get the default browser
t_brw = t_com.get_browser()
## open the url
url = 'https://login.live.com/login.srf?wa=wsignin1.0&rpsnv=11&ct=1361634551&rver=6.1.6206.0&wp=MBI&wreply=http:%2F%2Fmail.live.com%2Fdefault.aspx&lc=1033&id=64855&mkt=en-us&cbcxt=mai&snsc=1'
t_brw.go(url)
## get all forms from that URL
all_forms = t_brw.get_all_forms()         ## this returns list of form objects
 
## now, you have to choose only that form, which is having POST method
 
for each_frm in all_forms:
    attr = each_frm.attrs             ## all attributes of form
    if each_frm.method == 'POST':
        ctrl = each_frm.controls    ## return all control objects within that form (all html tags as control inside form)
        for ct in ctrl:
                if ct.type == 'text':     ## i did it as per my use, you can put your condition here
                        ct._value = "elwoode@hotmail.co.uk"
                        t_brw.clicked(each_frm,ct.attrs['name'])            ## clicked takes two parameter, form object and button name to be clicked.
                        t_brw.submit()
 
## you might write the output (submitted page) to any file using content = t_brw.get_html()
## dont forget to reset the browser and putputs.
t_com.reset_browser
t_com.reset_output
