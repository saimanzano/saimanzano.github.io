---
permalink: /projects/
title: "Interesting resources"
author_profile: true
---

This is a collection of side things I've been doing over the years to tune my coding skills, for curiosity purposes, or plainly just for fun. I hoope you find them useful or, at the very leeast, interesting.

## Secret Santa generator

[Github Repo ]([https://socviz.co/](https://github.com/saimanzano/SecretSanta)https://github.com/saimanzano/SecretSanta)

Organizing the Secret Santa for the lab, when the old-school paper-on-a-bag approach was not feasible, I realized I didn't like outsourcing the raffle to an external website and havingt to give my email to a random website. I also didn't think it fair to have someone know all the gifter-giftee pairs and have to send the emails. Therefore I created this little script that takes care of that. You only need a gmail account, which can be generated very fast and does not require you to use your own personal email. It also allows to ban certain matches (e.g so that couples don't gift each other). It is R based.



### Dependencies and requirements
Requires installing R libraries "argparse" and "blastula" which is handled automatically by the script via library "Pacman". For the emails, you will require the "app password" from that gmail address. Please see how to obtain it from: https://rstudio.github.io/blastula/articles/sending_using_smtp.html

### Usage

```
SecretSanta.R [-h] [-e EMAIL] [-p PARTICIPANTS] [-a ADDITIONAL]

options:

-e EMAIL, --email EMAIL email address for the notifications to be sent from. Must be gmail
-p PARTICIPANTS, --participants PARTICIPANTS CSV file with following fields: name, email, ban(s). Bans are matches that cannot be made (e.g so that couples are not matched to each other). Can be more than one ban, separated by anything other than a comma.
-a ADDITIONAL, --additional ADDITIONAL Character string with additional info you want on the email (e.g budget, deadline, etc). Default: "Have fun!"
```
