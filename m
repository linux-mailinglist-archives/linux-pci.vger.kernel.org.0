Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2647B185341
	for <lists+linux-pci@lfdr.de>; Sat, 14 Mar 2020 01:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgCNAYY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Mar 2020 20:24:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48291 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgCNAYY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Mar 2020 20:24:24 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jCuah-0005UY-Sv; Sat, 14 Mar 2020 01:23:48 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 16D97101115; Sat, 14 Mar 2020 01:23:47 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Logan Gunthorpe <logang@deltatee.com>,
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
Subject: Re: [PATCH 3/9] pci/switchtec: Don't abuse completion wait queue for poll
In-Reply-To: <4d3a997d-ced4-3dbe-d766-0b1e9fc35b29@deltatee.com>
References: <20200313174701.148376-1-bigeasy@linutronix.de> <20200313174701.148376-4-bigeasy@linutronix.de> <4d3a997d-ced4-3dbe-d766-0b1e9fc35b29@deltatee.com>
Date:   Sat, 14 Mar 2020 01:23:47 +0100
Message-ID: <87sgibeqcs.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Logan Gunthorpe <logang@deltatee.com> writes:
> On 2020-03-13 11:46 a.m., Sebastian Andrzej Siewior wrote:
>> The poll callback is abusing the completion wait queue and sticks it into
>> poll_wait() to wake up pollers after a command has completed.
>> 
>> First of all it's a layering violation as it imposes restrictions on the
>> inner workings of completions. Just because C allows to do so does not
>> justify that in any way. The proper way to do such things is to post
>> patches which extend the core infrastructure and not by silently abusing
>> it.
>
> As I've said previously, I disagree with this approach.

Feel free to do s.

> Open coding standard primitives sweeps issues under the rug and is a
> step backwards for code quality. Calling it a layering violation is
> just one opinion and if it is, the better solution would be to create
> an interface you find appropriate so that it isn't one.

There is no standard primitive which allows to poll on a completion.

You decided that this is smart to do and just because C does not
allow to hide implementation details this is not a justification for
this at all.

Due to the limitations of C, the kernel has to rely on the assumption
that developers know and respect the difference between API and
implementation.

Relying on implementation details of an interface and then arguing that
this is a standard primitive for the chosen purpose is just backwards.

What's even more hillarious is that you now request that we give you a
replacement interface for something which was not an interface to use in
the first place.

>>  1) It cannot work with EPOLLEXCLUSIVE
>
> Why? You don't explain this. And I don't see how this patch would change
> anything to do with the call to poll_wait(). All you've done is
> open-code the completion.
>
> Not that it matters that much, having multiple waiters poll on this
> interface can pretty much never happen. It only makes sense for the
> process who submitted the write to poll on the interface.

It does not matter whether your envisioned usage implies that it cannot
happen. Fact is that there is no restriction. That means using this with
the well documented semantics of poll(2) will result in failure. 

>>  2) It's racy:
>> 
>>   poll()	      	  	 write()
>>    switchtec_dev_poll()		   switchtec_dev_write()
>>     poll_wait(&s->comp.wait);        mrpc_queue_cmd()
>>     				       init_completion(&s->comp)
>> 					 init_waitqueue_head(&s->comp.wait)
>
> That's a nice catch! But wouldn't an easier solution be to change the
> code to use reinit_completion() instead of using the bug to justify a
> different change?

Sure taht can be cured by changing it to reinit, but that does not cure
the abuse of implementation details. As Peter, who maintains the
completion code says:

  Relying on implementation details of locking primitives like that is
  yuck.

Thanks,

        tglx
