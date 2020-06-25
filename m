Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B9B20A8C4
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jun 2020 01:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407791AbgFYXYd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Jun 2020 19:24:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406893AbgFYXYd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Jun 2020 19:24:33 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBD8620768;
        Thu, 25 Jun 2020 23:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593127472;
        bh=aVumzs2i6SVWQ21uSfbq/tTSu2oAmt6We1Iict7EXCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PNUBQx4xIOohi5GLdP4CfGT+vF9SGuhXsdDk9BuJ24mPuyyyXbURCuwxhBwgMSJWU
         9+zaas/+CspyEepUHrq5pwqCGfL+3mA+Ly8z9nsGdNv8QnWhTb058kQ5z8l38HENGD
         4hUJNB7/eG47xwYic1W4uUME1dpfwJ8BuJ6hVAHg=
Date:   Thu, 25 Jun 2020 18:24:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xiang Zheng <zhengxiang9@huawei.com>
Cc:     bhelgaas@google.com, willy@infradead.org,
        wangxiongfeng2@huawei.com, wanghaibin.wang@huawei.com,
        guoheyi@huawei.com, yebiaoxiang@huawei.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, tglx@linutronix.de, guohanjun@huawei.com,
        yangyingliang@huawei.com
Subject: Re: [PATCH v3] PCI: Lock the pci_cfg_wait queue for the consistency
 of data
Message-ID: <20200625232430.GA2739986@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624232309.GA2601999@bjorn-Precision-5520>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 24, 2020 at 06:23:09PM -0500, Bjorn Helgaas wrote:
> On Tue, Dec 10, 2019 at 11:15:27AM +0800, Xiang Zheng wrote:
> > 7ea7e98fd8d0 ("PCI: Block on access to temporarily unavailable pci
> > device") suggests that the "pci_lock" is sufficient, and all the
> > callers of pci_wait_cfg() are wrapped with the "pci_lock".
> > 
> > However, since the commit cdcb33f98244 ("PCI: Avoid possible deadlock on
> > pci_lock and p->pi_lock") merged, the accesses to the pci_cfg_wait queue
> > are not safe anymore. This would cause kernel panic in a very low chance
> > (See more detailed information from the below link). A "pci_lock" is
> > insufficient and we need to hold an additional queue lock while read/write
> > the wait queue.
> > 
> > So let's use the add_wait_queue()/remove_wait_queue() instead of
> > __add_wait_queue()/__remove_wait_queue(). Also move the wait queue
> > functionality around the "schedule()" function to avoid reintroducing
> > the deadlock addressed by "cdcb33f98244".
> 
> I see that add_wait_queue() acquires the wq_head->lock, while
> __add_wait_queue() does not.
> 
> But I don't understand why the existing pci_lock is insufficient.  
> pci_cfg_wait is only used in pci_wait_cfg() and
> pci_cfg_access_unlock().
> 
> In pci_wait_cfg(), both __add_wait_queue() and __remove_wait_queue()
> are called while holding pci_lock, so that doesn't seem like the
> problem.
> 
> In pci_cfg_access_unlock(), we have:
> 
>   pci_cfg_access_unlock
>     wake_up_all(&pci_cfg_wait)
>       __wake_up(&pci_cfg_wait, ...)
>         __wake_up_common_lock(&pci_cfg_wait, ...)
> 	  spin_lock(&pci_cfg_wait->lock)
> 	  __wake_up_common(&pci_cfg_wait, ...)
> 	    list_for_each_entry_safe_from(...)
> 	      list_add_tail(...)                <-- problem?
> 	  spin_unlock(&pci_cfg_wait->lock)
> 
> Is the problem that the wake_up_all() modifies the pci_cfg_wait list
> without holding pci_lock?
> 
> If so, I don't quite see how the patch below fixes it.  Oh, wait,
> maybe I do ... by using add_wait_queue(), we protect the list using
> the *same* lock used by __wake_up_common_lock.  Is that it?

Any reaction to the following?  Certainly not as optimized, but also a
little less magic and more in the mainstream of wait_event/wake_up
usage.

I don't claim any real wait queue knowledge and haven't tested it.
There are only a handful of __add_wait_queue() users compared with
over 1600 users of wait_event() and variants, and I don't like being
such a special case.

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 79c4a2ef269a..7c2222bddbff 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -205,16 +205,11 @@ static DECLARE_WAIT_QUEUE_HEAD(pci_cfg_wait);
 
 static noinline void pci_wait_cfg(struct pci_dev *dev)
 {
-	DECLARE_WAITQUEUE(wait, current);
-
-	__add_wait_queue(&pci_cfg_wait, &wait);
 	do {
-		set_current_state(TASK_UNINTERRUPTIBLE);
 		raw_spin_unlock_irq(&pci_lock);
-		schedule();
+		wait_event(pci_cfg_wait, !dev->block_cfg_access);
 		raw_spin_lock_irq(&pci_lock);
 	} while (dev->block_cfg_access);
-	__remove_wait_queue(&pci_cfg_wait, &wait);
 }
 
 /* Returns 0 on success, negative values indicate error. */
