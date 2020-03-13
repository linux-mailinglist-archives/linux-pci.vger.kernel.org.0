Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA4B8184E67
	for <lists+linux-pci@lfdr.de>; Fri, 13 Mar 2020 19:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgCMSMD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Mar 2020 14:12:03 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59974 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgCMSMD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Mar 2020 14:12:03 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jComa-0002J7-J4; Fri, 13 Mar 2020 12:11:41 -0600
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20200313174701.148376-1-bigeasy@linutronix.de>
 <20200313174701.148376-4-bigeasy@linutronix.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <4d3a997d-ced4-3dbe-d766-0b1e9fc35b29@deltatee.com>
Date:   Fri, 13 Mar 2020 12:11:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313174701.148376-4-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, bhelgaas@google.com, kurt.schwemmer@microsemi.com, tglx@linutronix.de, torvalds@linux-foundation.org, rostedt@goodmis.org, joel@joelfernandes.org, paulmck@kernel.org, will@kernel.org, mingo@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org, bigeasy@linutronix.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_EXCLUSIVE autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH 3/9] pci/switchtec: Don't abuse completion wait queue for
 poll
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-03-13 11:46 a.m., Sebastian Andrzej Siewior wrote:
> The poll callback is abusing the completion wait queue and sticks it into
> poll_wait() to wake up pollers after a command has completed.
> 
> First of all it's a layering violation as it imposes restrictions on the
> inner workings of completions. Just because C allows to do so does not
> justify that in any way. The proper way to do such things is to post
> patches which extend the core infrastructure and not by silently abusing
> it.

As I've said previously, I disagree with this approach. Open coding
standard primitives sweeps issues under the rug and is a step backwards
for code quality. Calling it a layering violation is just one opinion
and if it is, the better solution would be to create an interface you
find appropriate so that it isn't one.

> Aside of that the implementation is seriously broken:
> 
>  1) It cannot work with EPOLLEXCLUSIVE

Why? You don't explain this. And I don't see how this patch would change
anything to do with the call to poll_wait(). All you've done is
open-code the completion.

Not that it matters that much, having multiple waiters poll on this
interface can pretty much never happen. It only makes sense for the
process who submitted the write to poll on the interface.

>  2) It's racy:
> 
>   poll()	      	  	 write()
>    switchtec_dev_poll()		   switchtec_dev_write()
>     poll_wait(&s->comp.wait);        mrpc_queue_cmd()
>     				       init_completion(&s->comp)
> 					 init_waitqueue_head(&s->comp.wait)

That's a nice catch! But wouldn't an easier solution be to change the
code to use reinit_completion() instead of using the bug to justify a
different change?

Thanks,

Logan
