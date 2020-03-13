Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 484D2184F4E
	for <lists+linux-pci@lfdr.de>; Fri, 13 Mar 2020 20:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCMTbx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Mar 2020 15:31:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43890 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgCMTbx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Mar 2020 15:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TWYAqokCcfWkKMi+uskmT0kPQPWgnZ09HxOC11bOvv8=; b=A8fzSfmaz33/cmU/FNtev5DSqN
        XnsyHgHGdqVFyYjwY5+2SnGZLWaN6zTWJqN5Th5YliHeA8BGAN7ILd5q020d0rkby6wd8YKw6gYUI
        7GLYu7vLOTx7I8M1YQ95JmVgFoeLy5wzDm8ugoH7vH12okGKG5ocx7UvRkBgZ4vPzTNFn6ET7kuvc
        H//91qf1J5wHOlVRnj2qO7n+62oYGxq4H4iD+wE+SFYiMpfUeiY3usCraF/sgm2oTZ27g711Gw70h
        fMGoA54cUpiO5Qb+ard6egTVb2GJ3/hV3qXUAGs6nADFHTc5dBgD9Ek9BGl1dRnDYgu56VTNDKn7X
        m5+iwXqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCq1z-0004dt-1v; Fri, 13 Mar 2020 19:31:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D05133011E0;
        Fri, 13 Mar 2020 20:31:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C12232BE08CC8; Fri, 13 Mar 2020 20:31:32 +0100 (CET)
Date:   Fri, 13 Mar 2020 20:31:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/9] pci/switchtec: Don't abuse completion wait queue for
 poll
Message-ID: <20200313193132.GE12521@hirez.programming.kicks-ass.net>
References: <20200313174701.148376-1-bigeasy@linutronix.de>
 <20200313174701.148376-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313174701.148376-4-bigeasy@linutronix.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 13, 2020 at 06:46:55PM +0100, Sebastian Andrzej Siewior wrote:
> The poll callback is abusing the completion wait queue and sticks it into
> poll_wait() to wake up pollers after a command has completed.
> 
> First of all it's a layering violation as it imposes restrictions on the
> inner workings of completions. Just because C allows to do so does not
> justify that in any way. The proper way to do such things is to post
> patches which extend the core infrastructure and not by silently abusing
> it.
> 
> Aside of that the implementation is seriously broken:
> 
>  1) It cannot work with EPOLLEXCLUSIVE
> 
>  2) It's racy:
> 
>   poll()	      	  	 write()
>    switchtec_dev_poll()		   switchtec_dev_write()
>     poll_wait(&s->comp.wait);        mrpc_queue_cmd()
>     				       init_completion(&s->comp)
> 					 init_waitqueue_head(&s->comp.wait)
> 
> Replace it with a regular wait queue which removes the completion abuse and
> cures #1 and #2 above.
> 
> Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Relying on implementation details of locking primitives like that is
yuck.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
