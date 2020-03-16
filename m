Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 804DE187374
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 20:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbgCPTet (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 15:34:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52812 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732366AbgCPTet (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Mar 2020 15:34:49 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jDvVT-0004MQ-5x; Mon, 16 Mar 2020 20:34:35 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 84ABC1013B2; Mon, 16 Mar 2020 20:34:34 +0100 (CET)
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
Date:   Mon, 16 Mar 2020 20:34:34 +0100
Message-ID: <87v9n4ccvp.fsf@nanos.tec.linutronix.de>
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
>>  1) It cannot work with EPOLLEXCLUSIVE
>
> Why? You don't explain this.

man epoll_ctt(2)

EPOLLEXCLUSIVE (since Linux 4.5)

  Sets an exclusive wakeup mode for the epoll file descriptor that is
  being attached to the target file descriptor, fd.  When a wakeup event
  occurs and multiple epoll file descriptors are attached to the same
  target file using EPOLLEXCLUSIVE, one or more of the epoll file
  descriptors will receive an event with epoll_wait(2).

As this uses complete_all() there is no distinction possible, because
complete_all() wakes up everything.

> And I don't see how this patch would change anything to do with the
> call to poll_wait(). All you've done is open-code the completion.

wake_up_interruptible(x) resolves to: 

     __wake_up(x, TASK_INTERRUPTIBLE, 1, NULL)

which wakes exactly 1 exclusive waiter.

Also the other way round is just working because the waker side uses
complete_all(). Why? Because completion internally defaults to exclusive
mode and complete() wakes exactly one exlusive waiter.

There is a conceptual difference and while it works for that particular
purpose to some extent it's not suitable as a general wait notification
construct.

Thanks,

        tglx
