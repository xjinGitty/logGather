Effective Bugs Rate Research
============================

Task Description
----------------
the goal of the task is to see how well we went from SLED11SP3 to SLED12 and then SLED11SP4, trying to answer to what extent the bugs we reported are real defects and how much we can get the results improved in early future.

Search Method
-------------
Use following links to filter wanted bugs

Filtered = AllBugs - ENHANCEMENT - DUPLICATED - INVALID - WONTFIX - WORKSFORME - FEATURE

The target bugs is from APAC I team ONLY:
yfjiang@suse.com,bchou@suse.com,nwang@suse.com,xdzhang@suse.com,xjin@suse.com,yosun@suse.com,ychen@suse.com,wjiang@suse.com,ysun@suse.com,akong@suse.com,sywang@suse.com,whdu@suse.com


### SLED11SP4
[Filtered](https://bugzilla.suse.com/buglist.cgi?bug_severity=Blocker&bug_severity=Critical&bug_severity=Major&bug_severity=Normal&bug_severity=Minor&classification=SUSE%20Linux%20Enterprise%20Desktop&email3=%28bchou|nwang|wjiang|whdu|xdzhang|xjin|yfjiang|ysun|yosun|sywang|ychen%29%40suse.com&emailreporter3=1&emailtype3=regexp&list_id=1967413&product=SUSE%20Linux%20Enterprise%20Desktop%2011%20SP4%20%28SLED%2011%20SP4%29&query_format=advanced&resolution=INVALID&resolution=WONTFIX&resolution=FEATURE&resolution=DUPLICATE&resolution=WORKSFORME)

[All Bugs](https://bugzilla.suse.com/buglist.cgi?classification=SUSE%20Linux%20Enterprise%20Desktop&product=SUSE%20Linux%20Enterprise%20Desktop%2012&query_format=advanced&f1=reporter&o1=anywords&v1=yfjiang@suse.com,bchou@suse.com,nwang@suse.com,xdzhang@suse.com,xjin@suse.com,yosun@suse.com,ychen@suse.com,wjiang@suse.com,ysun@suse.com,akong@suse.com,sywang@suse.com,whdu@suse.com://bugzilla.suse.com/buglist.cgi?bug_severity=Blocker&bug_severity=Critical&bug_severity=Major&bug_severity=Normal&bug_severity=Minor&bug_severity=Enhancement&classification=SUSE%20Linux%20Enterprise%20Desktop&email3=%28bchou|nwang|wjiang|whdu|xdzhang|xjin|yfjiang|ysun|yosun|sywang|ychen%29%40suse.com&emailreporter3=1&emailtype3=regexp&list_id=1967414&product=SUSE%20Linux%20Enterprise%20Desktop%2011%20SP4%20%28SLED%2011%20SP4%29&query_format=advanced&resolution=---&resolution=FIXED&resolution=INVALID&resolution=WONTFIX&resolution=NORESPONSE&resolution=UPSTREAM&resolution=FEATURE&resolution=DUPLICATE&resolution=WORKSFORME&resolution=MOVED)

### SLED12
[Filtered](https://bugzilla.suse.com/buglist.cgi?bug_severity=Blocker&bug_severity=Critical&bug_severity=Major&bug_severity=Normal&bug_severity=Minor&classification=SUSE%20Linux%20Enterprise%20Desktop&email3=%28bchou|nwang|wjiang|whdu|xdzhang|xjin|yfjiang|ysun|yosun|sywang|ychen%29%40suse.com&emailreporter3=1&emailtype3=regexp&list_id=1967475&product=SUSE%20Linux%20Enterprise%20Desktop%2012&query_format=advanced&resolution=---&resolution=FIXED&resolution=NORESPONSE&resolution=UPSTREAM&resolution=MOVED)

[All Bugs](https://bugzilla.suse.com/buglist.cgi?bug_severity=Blocker&bug_severity=Critical&bug_severity=Major&bug_severity=Normal&bug_severity=Minor&bug_severity=Enhancement&classification=SUSE%20Linux%20Enterprise%20Desktop&email3=%28bchou|nwang|wjiang|whdu|xdzhang|xjin|yfjiang|ysun|yosun|sywang|ychen%29%40suse.com&emailreporter3=1&emailtype3=regexp&list_id=1967457&product=SUSE%20Linux%20Enterprise%20Desktop%2012&query_format=advanced&resolution=---&resolution=FIXED&resolution=INVALID&resolution=WONTFIX&resolution=NORESPONSE&resolution=UPSTREAM&resolution=FEATURE&resolution=DUPLICATE&resolution=WORKSFORME&resolution=MOVED)

### SLED11SP3
[Filtered](https://bugzilla.suse.com/buglist.cgi?bug_severity=Blocker&bug_severity=Critical&bug_severity=Major&bug_severity=Normal&bug_severity=Minor&classification=SUSE%20Linux%20Enterprise%20Desktop&email3=%28bchou|nwang|wjiang|whdu|xdzhang|xjin|yfjiang|ysun|yosun|sywang|ychen%29%40suse.com&emailreporter3=1&emailtype3=regexp&list_id=1967506&product=SUSE%20Linux%20Enterprise%20Desktop%2011%20SP3&query_format=advanced&resolution=---&resolution=FIXED&resolution=NORESPONSE&resolution=UPSTREAM&resolution=MOVED)

[All Bugs](https://bugzilla.suse.com/buglist.cgi?bug_severity=Blocker&bug_severity=Critical&bug_severity=Major&bug_severity=Normal&bug_severity=Minor&bug_severity=Enhancement&classification=SUSE%20Linux%20Enterprise%20Desktop&email3=%28bchou|nwang|wjiang|whdu|xdzhang|xjin|yfjiang|ysun|yosun|sywang|ychen%29%40suse.com&emailreporter3=1&emailtype3=regexp&list_id=1967535&product=SUSE%20Linux%20Enterprise%20Desktop%2011%20SP3&query_format=advanced&resolution=---&resolution=FIXED&resolution=INVALID&resolution=WONTFIX&resolution=NORESPONSE&resolution=UPSTREAM&resolution=FEATURE&resolution=DUPLICATE&resolution=WORKSFORME&resolution=MOVED)

Results
-------

Because "Severity" and "Resolution" have the intersection. In another word, some bugs belong to "Enhancement" and "WONTFIX"(or other ineffective resolution) at the same time. So we want to analyze them separately. 

### Severity (Enhancement)

_Including all the resolutions like "INVALID,WONTFIX,DUPLICATE,WORKSFORME,FEATURE"_

**Quantities**
|               | SLED11SP3 | SLED12 | SLED11SP4 |
| ------------- | --------- | ------ | --------- |
| Total         | 76        | 167    | 52        |
| Enhancement   | 0         | 25     | 2         |
                                                  
**Percentage**                                    
|               | SLED11SP3 | SLED12 | SLED11SP4 |
| ------------- | --------- | ------ | --------- |
| Enhancement   | 0         | 14.9%  | 3.84%     |
                                                  
### Resolution                                    
                                                  
**Quantities**                                    
|               | SLED11SP3 | SLED12 | SLED11SP4 |
| ------------- | --------- | ------ | --------- |
| Total         | 76        | 167    | 52        |
| DUPLICATE     | 5         | 29     | 5         |
| INVALID       | 12        | 10     | 5         |
| WONTFIX       | 3         | 3      | 4         |
| WORKSFORME    | 4         | 4      | 2         |
| FEATURE       | 2         | 2      | 2         |
                                                  
**Percentage**                                    
|               | SLED11SP3 | SLED12 | SLED11SP4 |
| ------------- | --------- | ------ | --------- |
| DUPLICATE     | 7.2%      | 17.3%  |  9.61%    |
| INVALID       | 15.9%     | 5.9%   |  9.61%    |
| WONTFIX       | 1.4%      | 1.7%   |  7.69%    |
| WORKSFORME    | 4.3%      | 2.3%   |  3.84%    |
| FEATURE       | 4.3%      | 1.19%  |  3.84%    |

### Ineffective Bugs in Components
_Excluding Enhancement_

#### Components in the ineffective Bugs

|                      | SLED11SP3 | SLED12    | SLED11SP4 | 
| -------------------- | --------- | --------- | --------- | 
| Total                | 20        | 46        | 18        | 
| Installer/ ~tion     | 2   10%   | 20  43.4% | 2   11.1% | 
| Basesystem           |           | 5   10.8% | 1   5.55% | 
| GNOME                | 4   20%   | 2   4.3%  | 2   11.1% | 
| Network              | 2   10%   | 2   4.3%  |           | 
| YaST2                |           | 2   4.3%  | 3   16.7% | 
| Kernel               | 1   5%    | 2   4.3%  | 2   11.1% | 
| Other                | 3   15%   | 2   4.3%  |           | 
| X Server             |           | 2   4.3%  |           | 
| Update Problems      |           | 1   2.1%  |           | 
| Registration         | 1   5%    | 1   2.1%  |           | 
| Samba                |           | 1   2.1%  |           | 
| Printing             |           | 1   2.1%  | 1   5.55% | 
| Packages             | 2   10%   | 1   2.1%  |           | 
| libzypp              |           | 1   2.1%  |           | 
| XEN:Save/Restore/Mig | 1   5%    |           | 1   5.55% | 
| Evolution            | 1   5%    | 1   2.1%  | 1   5.55% | 
| Firefox              | 3   15%   |           |           | 
| Console Applications |           | 1   2.1%  |           | 
| Artwork&Branding     |           | 1   2.1%  |           | 
| Banshee              |           | 1   2.1%  | 2  11.11% | 
| Legal issue          |           | 1   2.1%  | 1   5.55% | 
| sound                |           | 1   2.1%  | 1   5.55% | 
| KDE                  |           | 1   2.1%  | 1   5.55% | 
                                                             
                                                             
#### Ineffective Bugs in Components             
                                                             
|                      | SLED11SP3  | SLED12      | SLED11SP4 |
| -------------------- | ---------- | ----------  | ----------|
| Total                | 22/76      | 46/167      | 18/52     |
| Update Problems      | 0/2        | 1/1   100%  | 0/0       |
| Console Applications | 0/0        | 1/1   100%  | 0/0       |
| Basesystem           | 0/0        | 5/8   62.5  | 1/2 50%   |
| X Server             | 0/2        | 2/3   66.6  | 0/0       |
| Printing             | 0/0        | 1/2   50.0  | 1/1 100%  |
| libzypp              | 0/0        | 1/2   50.0  | 0/0       |
| Installer            | 2/5  40%   | 20/52 38.4  | 2/6 33.3% |
| Registration         | 1/3  33.3% | 1/3   33.3  | 0/0       |
| Evolution            | 1/2  50.0% | 1/3   33.3  | 1/2 50%   |
| Artwork&Branding     | 0/0        | 1/3   33.3  | 0/0       |
| Network              | 2/6  33.3% | 2/7   28.5  | 0/0       |
| Other                | 3/9  33.3% | 2/7   28.5  | 0/0       |
| Samba                | 0/0        | 1/5   20.0  | 0/0       |
| Packages             | 2/7  28.5% | 1/6   16.6  | 0/0       |
| YaST2                | 0/1        | 2/19  10.5  | 3/7 42.8% |
| GNOME                | 4/12 33.3% | 2/33  6.0%  | 2/5 40 %  |
| XEN:Save/Restore/Mig | 1/2  50.0% | 0/0         | 1/1 100 % |
| Firefox              | 3/7  42.8% | 0/3         | 0/0       |
| X ATI/fglrx Driver   | 0/2        | 0/0         | 0/0       |
| Documentation        | 0/2        | 0/2         | 0/0       |
| Banshee              | 0/2        | -           | 0/0       |
| Translations         | 0/0        | 0/1         | 0/0       |
| Patterns             | 0/1        | 0/1         | 0/0       |
| Mobile Devices       | 0/1        | 0/0         | 0/0       |
| Novell Client Linux  | 0/1        | -           | 0/0       |
| Virt:Guest Inst      | 0/0        | 0/1         | 0/0       |
| Virt:ManagementTools | 0/0        | 0/1         | 0/0       |
| Kernel               | 0/0        | 0/0         | 2/5 40%   | 
| Banshee              | 0/0        | 0/0         | 2/5 40 %  | 
| Legal issue          | 0/0        | 0/0         | 1/1 100 % | 
| sound                | 0/0        | 0/0         | 1/1 100 % | 
| KDE                  | 0/0        | 0/0         | 1/4 25 %  | 
                                                                
**Drop components whose bug number less than 5**
                                                                
|                      | SLED11SP3  | SLED12      | SLED11SP4  |
| -------------------- | ---------- | ----------  | ---------- |
| Total                | 22/76      | 46/167      | 18/52      |
| Installer            | 2/5  40%   | 20/52 38.4  | 2/6 33.3%  |
| Network              | 2/6  33.3% | 2/7   28.5  | 0/0        |
| Other                | 3/9  33.3% | 2/7   28.5  | 0/0        |
| Packages             | 2/7  28.5% | 1/6   16.6  | 0/0        |
| GNOME                | 4/12 33.3% | 2/33  6.0%  | 2/5 40 %   |

The number of bugs must big enough to be analyzed. Otherwise the data have no meaning for our research. So we simply ignore the components whose bug number less than 5. Note: 5 is not a accurate number, it's come from estimation.

The results (percentage) doest not have too much dulation between the components.
And the value are closed between SLED11SP3, SLED12 and SLED11SP4 too.

The only exception is GNOME in SLED12. It is possible that the new GNOME3 involved too many bugs, which make they are less chance to be duplicated.
