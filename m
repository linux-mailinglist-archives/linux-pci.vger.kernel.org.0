Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3225E185A08
	for <lists+linux-pci@lfdr.de>; Sun, 15 Mar 2020 05:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgCOESw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Mar 2020 00:18:52 -0400
Received: from ale.deltatee.com ([207.54.116.67]:53738 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgCOESw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Mar 2020 00:18:52 -0400
Received: from s0106602ad0811846.cg.shawcable.net ([68.147.191.165] helo=[192.168.0.12])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jCzrI-0005st-KT; Sat, 14 Mar 2020 00:01:17 -0600
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
 <87sgibeqcs.fsf@nanos.tec.linutronix.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9213d617-207e-da4e-094a-45ae587fdc98@deltatee.com>
Date:   Sat, 14 Mar 2020 00:01:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87sgibeqcs.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.191.165
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, bhelgaas@google.com, kurt.schwemmer@microsemi.com, torvalds@linux-foundation.org, rostedt@goodmis.org, joel@joelfernandes.org, paulmck@kernel.org, will@kernel.org, mingo@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org, bigeasy@linutronix.de, tglx@linutronix.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_EXCLUSIVE,MYRULES_FREE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.2
Subject: Re: [PATCH 3/9] pci/switchtec: Don't abuse completion wait queue for
 poll
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-03-13 6:23 p.m., Thomas Gleixner wrote:
> Logan Gunthorpe <logang@deltatee.com> writes:
>> On 2020-03-13 11:46 a.m., Sebastian Andrzej Siewior wrote:
>>> The poll callback is abusing the completion wait queue and sticks it into
>>> poll_wait() to wake up pollers after a command has completed.
>>>
>>> First of all it's a layering violation as it imposes restrictions on the
>>> inner workings of completions. Just because C allows to do so does not
>>> justify that in any way. The proper way to do such things is to post
>>> patches which extend the core infrastructure and not by silently abusing
>>> it.
>>
>> As I've said previously, I disagree with this approach.
> 
> Feel free to do s.
> 
>> Open coding standard primitives sweeps issues under the rug and is a
>> step backwards for code quality. Calling it a layering violation is
>> just one opinion and if it is, the better solution would be to create
>> an interface you find appropriate so that it isn't one.
> 
> There is no standard primitive which allows to poll on a completion.
> 
> You decided that this is smart to do and just because C does not
> allow to hide implementation details this is not a justification for
> this at all.
> 
> Due to the limitations of C, the kernel has to rely on the assumption
> that developers know and respect the difference between API and
> implementation.
> 
> Relying on implementation details of an interface and then arguing that
> this is a standard primitive for the chosen purpose is just backwards.
> 
> What's even more hillarious is that you now request that we give you a
> replacement interface for something which was not an interface to use in
> the first place.

I'm in awe at the lack of professionalism in your emails. If you
bothered to edit out the ad hominems, you might have noticed that nobody
has yet described how the poll interface fails here (with
EPOLLEXCLUSIVE) or how replacing one wait queue for another fixes the
purported problem.

We clearly disagree on what's considered appropriate usage of the
completion helper (calling it a "locking primitive" is a bit
disingenuous) and it doesn't sound like that's going to change. I hold
no power here, but you aren't going to bully me into giving this patch
an Ack or into silencing my opinion on the matter.

I'd prefer it if you submit a patch that's honest about what it's trying
to accomplish and why (ie. it doesn't masquerade as being necessary to
fix a bug). I also ask that you accept that I'm within my right to voice
my dissent. If, after that, Bjorn chooses to take your patch, then I
will respect his decision. I trust that he's able to read behind the
personal attacks and look only at the technical issues.

Logan
