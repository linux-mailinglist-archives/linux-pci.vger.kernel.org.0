Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE1C01876B2
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 01:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732960AbgCQASC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 20:18:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53129 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732903AbgCQASC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Mar 2020 20:18:02 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jDzvF-00079O-4t; Tue, 17 Mar 2020 01:17:29 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id EC905101161; Tue, 17 Mar 2020 01:17:27 +0100 (CET)
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
In-Reply-To: <39f2bd27-1a4a-f7ad-5d54-7fe133390cd0@deltatee.com>
References: <20200313174701.148376-1-bigeasy@linutronix.de> <20200313174701.148376-4-bigeasy@linutronix.de> <4d3a997d-ced4-3dbe-d766-0b1e9fc35b29@deltatee.com> <87v9n4ccvp.fsf@nanos.tec.linutronix.de> <39f2bd27-1a4a-f7ad-5d54-7fe133390cd0@deltatee.com>
Date:   Tue, 17 Mar 2020 01:17:27 +0100
Message-ID: <87sgi7deco.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Logan,

Logan Gunthorpe <logang@deltatee.com> writes:
> On 2020-03-16 1:34 p.m., Thomas Gleixner wrote:
>> Logan Gunthorpe <logang@deltatee.com> writes:
> I certainly would not agree that this qualifies as "seriously broken",

I concede that this is the wrong wording, but chasing things like this
and constantly mopping up code is not necessarily keeping my mood up all
the time.

> and I'm not even sure I'd agree that this actually violates the
> semantics of poll() seeing the man page clearly states that with
> EPOLLEXCLUSIVE set, "one or more" pollers will be woken up. So waking up
> all of them is still allowed. Ensuring fewer pollers wake up is just an
> optimization to avoid the thundering herd problem which users of this
> interface are very unlikely to ever have (I can confidently tell you
> that none have this problem now).

I can see the point, but in general we should just strive for keeping
the interfaces consistent and not subject to interpretation by
individual developers. Maybe in your case the probability that someone
wants to use it in that way is close to zero, but we've been surprised
often enough by the creativity of user space developers who came up with
use cases nobody ever expected.

> If we do want to say that all poll_wait() users *must* respect
> EPOLLEXCLUSIVE, we should at least have some documentation saying that
> combining poll_wait() with wake_up_all() (or similar) is not allowed. A
> *very* quick check finds there's at least a few drivers doing this:
>
>   drivers/char/ipmi/ipmb_dev_int.c
>   drivers/dma-buf/sync_file.c
>   drivers/gpu/vga/vgaarb.c

Right. There is surely quite some stuff in drivers which either predates
these things or slipped through review.

> Finally, since we seem to back to more reasonable discussion, I will
> make this point: it's fairly common for wait queue users to directly use
> the spinlock from within wait_queue_head_t without an interface (even
> completion.c does it).

completions and waitqueues are both core code. Core primitives build
obviously on other primitives so dependencies on the inner workings are
expected to some degree, especially for real and valuable optimization
reasons. Solving these dependencies when one primitive changes has
limited scope.

> How are developers supposed to know when an interface is required and
> when it's not? Sometimes using "implementation" details interface-free
> is standard practice, but other times it's "yuck" and will illicit ire
> from other developers? Is it valid to use completion.wait.lock?
> Where's the line?

That's a good question, but that question simply arises due to the fact
that C does not provide proper privatizing or if you want to work around
that it forces you to come up with really horrible constructs.

The waitqueue lock usage has a very long history. It goes back to 2002
when the semaphore implementation was optimized. That exposed some of
the waitqueue internals which got consequently used elsewhere as
well. But looking at the actual usage sites, that's a pretty limited
amount. Most of them are core infrastrucure. Of course there are drivers
as well which use it for questionable reasons.

In general I think that silently using implementation details just to
scratch an itch or "optimizing" code is pretty much bad practice.

Especially as this has a tendency to spread out in creative ways. And
this happens simply because developers often copy the next thing which
looks suitable and then expand on it. As this is not necessarily caught
in reviews, this can spread to the point where the core infrastructure
cannot be changed anymore.

That's not a made up nightmare scenario. This happened in reality and
caused me to mop up 50+ interrupt chip implementations in order to be
able to make an urgently needed 10 line change to the core interrupt
infrastructure. Guess what, the vast majority of instances fiddling with
the core internals were either voodoo programming or plain bugs. There
were a few legitimate issues, but they had been better solved in the
core code upfront.  Even after that cleanup a driver got merged which
had #include "../../../../kernel/irg/internal.h" inside just because the
code which was developed out of tree before this change had be made to
"work".

That's just not a workable solution with the ever expanding code base of
the kernel.

I really prefer when people come along and show the problem they want to
solve - I'm completely fine with the POC hack which uses internals for
that purpose - so that this can be discussed and eventually integrated
into core infrastructure in one way or the other or better suitable
solutions can be found.

There are other aspects to this:

 - Using existing interfaces allows a reviewer to do the quick check on
   init, run time usage and tear down instead of wrapping his head
   around the special case

 - Verification tooling of all sorts just works

 - Improvements to the core implementation including new features are
   just coming for free.

I hope that clarifies where I'm coming from.

This has nothing to do with you personally, you just triggered a few
sensible fuses while understandably defending your admittedly smart
solution.

Thanks,

        tglx
