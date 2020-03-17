Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 098F418775D
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 02:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbgCQBQQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 21:16:16 -0400
Received: from ale.deltatee.com ([207.54.116.67]:54966 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733017AbgCQBQP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Mar 2020 21:16:15 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jE0pn-0008BY-Ie; Mon, 16 Mar 2020 19:15:56 -0600
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20200313174701.148376-1-bigeasy@linutronix.de>
 <20200313174701.148376-4-bigeasy@linutronix.de>
 <4d3a997d-ced4-3dbe-d766-0b1e9fc35b29@deltatee.com>
 <87v9n4ccvp.fsf@nanos.tec.linutronix.de>
 <39f2bd27-1a4a-f7ad-5d54-7fe133390cd0@deltatee.com>
 <87sgi7deco.fsf@nanos.tec.linutronix.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1adfff2f-86a5-d692-bac6-c87a15f24d67@deltatee.com>
Date:   Mon, 16 Mar 2020 19:15:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87sgi7deco.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, bhelgaas@google.com, kurt.schwemmer@microsemi.com, torvalds@linux-foundation.org, rostedt@goodmis.org, joel@joelfernandes.org, paulmck@kernel.org, will@kernel.org, mingo@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org, bigeasy@linutronix.de, tglx@linutronix.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 3/9] pci/switchtec: Don't abuse completion wait queue for
 poll
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-03-16 6:17 p.m., Thomas Gleixner wrote:
> That's a good question, but that question simply arises due to the fact
> that C does not provide proper privatizing or if you want to work around
> that it forces you to come up with really horrible constructs.

Well, we do have the underscore convention. Though, I concede this code
could potentially predate that. Had there been a preceding underscore, I
definitely would have thought twice before touching it.

> That's not a made up nightmare scenario. This happened in reality and
> caused me to mop up 50+ interrupt chip implementations in order to be
> able to make an urgently needed 10 line change to the core interrupt
> infrastructure. Guess what, the vast majority of instances fiddling with
> the core internals were either voodoo programming or plain bugs. There
> were a few legitimate issues, but they had been better solved in the
> core code upfront.  Even after that cleanup a driver got merged which
> had #include "../../../../kernel/irg/internal.h" inside just because the
> code which was developed out of tree before this change had be made to
> "work".

I get where your coming from, and it sucks having to clean up so many
instances in an urgent situation. But I see this kind of cleanup work as
routine, a necessary thing that happens all the time. I've done it
myself a couple times before in the kernel. The hard trick is to get
developers to do more of it, before it becomes a problem like the one
you faced.

In my experience, what makes clean up work even harder is where
developers see an interface, notice it's not a perfect fit and so open
code the whole thing themselves. Then you have random buggy primitives
open coded all over the place that are impossible to find. And the
primitives themselves never improve or grow new interfaces because
nobody knows there's a bunch of instances that require the improvement.
That's a much bigger mess.

> I really prefer when people come along and show the problem they want to
> solve - I'm completely fine with the POC hack which uses internals for
> that purpose - so that this can be discussed and eventually integrated
> into core infrastructure in one way or the other or better suitable
> solutions can be found.

Yes, and this code was a prototype at one point and went through review
from a number of people in the community, and nobody complained about
this. I've also been in the situation where I submitted a POC and
somebody pointed out a better way (though with a few swears thrown in
for good measure); but in that case, I was actually changing a primitive
so it got their attention more easily.

It's impossible for the maintainer of a primitive to review all the use
cases of every primitive when new code gets merged. But at least if new
code uses/abuses the primitive they will eventually come to light and
can be cleaned up as appropriate with a holistic view.

> I hope that clarifies where I'm coming from.

Yes, I understood your point. And I concede that a completion is a
pretty trivial primitive to open code and the change is not really worth
any further fight. If the patch gets merged (preferably with a reworked
commit message), I will not complain.

> This has nothing to do with you personally, you just triggered a few
> sensible fuses while understandably defending your admittedly smart
> solution.

Thank you.

Logan
