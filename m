Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7479C20971F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jun 2020 01:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbgFXXXG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 19:23:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728791AbgFXXXF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jun 2020 19:23:05 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6DE02078D;
        Wed, 24 Jun 2020 23:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593040985;
        bh=nPI49zTWRNSvP8Jvg+xhd85cvTlBnh0/0rExkbWE0lA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=swvfE3rFFptAtwSzvy+bAf1tIZFFh+R9rmsamsXumIQXd/yv/O8mLr27Nx824qP53
         YMLkQV24cEdR1JzTci8AM4TXangvdCcrS1btQ24hMLufZ9SiJxwLDU4Ukqjf3DMBdw
         tdOU9KEgJUCfgbeEB7AXOCLDqJtik83LLVTdX1cA=
Date:   Wed, 24 Jun 2020 18:23:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xiang Zheng <zhengxiang9@huawei.com>
Cc:     bhelgaas@google.com, willy@infradead.org,
        wangxiongfeng2@huawei.com, wanghaibin.wang@huawei.com,
        guoheyi@huawei.com, yebiaoxiang@huawei.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, tglx@linutronix.de, guohanjun@huawei.com,
        yangyingliang@huawei.com, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3] PCI: Lock the pci_cfg_wait queue for the consistency
 of data
Message-ID: <20200624232303.GA2594945@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210031527.40136-1-zhengxiang9@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Stephane]

On Tue, Dec 10, 2019 at 11:15:27AM +0800, Xiang Zheng wrote:
> 7ea7e98fd8d0 ("PCI: Block on access to temporarily unavailable pci
> device") suggests that the "pci_lock" is sufficient, and all the
> callers of pci_wait_cfg() are wrapped with the "pci_lock".
> 
> However, since the commit cdcb33f98244 ("PCI: Avoid possible deadlock on
> pci_lock and p->pi_lock") merged, the accesses to the pci_cfg_wait queue
> are not safe anymore. This would cause kernel panic in a very low chance
> (See more detailed information from the below link). A "pci_lock" is
> insufficient and we need to hold an additional queue lock while read/write
> the wait queue.

<tangent>

  I'm not proud of cdcb33f98244 ("PCI: Avoid possible deadlock on
  pci_lock and p->pi_lock").

  It seems like an ad hoc solution to a problem that shouldn't exist.
  I think what it fixes is reading performance counters from PCI
  config space during a context switch when we're holding the
  task_struct pi_lock.  That doesn't seem like a path that should
  acquire pci_lock.

  I think I should have instead tried to make a lockless PCI config
  accessor that returns failure whenever we aren't allowed to read
  config space, e.g., during the recovery time after a reset or power
  state transition.  We currently *do* use pci_cfg_access_lock() to
  prevent user accesses via /proc or /sys during some of those times,
  but there's nothing that prevents kernel accesses.

  I think we're a little vulnerable there if we read those PCI
  performance counters right after changing the device power state.
  Hopefully it's nothing worse than getting ~0 data back.

</tangent>

> So let's use the add_wait_queue()/remove_wait_queue() instead of
> __add_wait_queue()/__remove_wait_queue(). Also move the wait queue
> functionality around the "schedule()" function to avoid reintroducing
> the deadlock addressed by "cdcb33f98244".
> 
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> Cc: Heyi Guo <guoheyi@huawei.com>
> Cc: Biaoxiang Ye <yebiaoxiang@huawei.com>
> Link: https://lore.kernel.org/linux-pci/79827f2f-9b43-4411-1376-b9063b67aee3@huawei.com/
> ---
> 
> v3:
>   Improve the commit subject and message.
> 
> v2:
>   Move the wait queue functionality around the "schedule()".
> 
> ---
>  drivers/pci/access.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 2fccb5762c76..09342a74e5ea 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -207,14 +207,14 @@ static noinline void pci_wait_cfg(struct pci_dev *dev)
>  {
>  	DECLARE_WAITQUEUE(wait, current);
>  
> -	__add_wait_queue(&pci_cfg_wait, &wait);
>  	do {
>  		set_current_state(TASK_UNINTERRUPTIBLE);
>  		raw_spin_unlock_irq(&pci_lock);
> +		add_wait_queue(&pci_cfg_wait, &wait);
>  		schedule();
> +		remove_wait_queue(&pci_cfg_wait, &wait);
>  		raw_spin_lock_irq(&pci_lock);
>  	} while (dev->block_cfg_access);
> -	__remove_wait_queue(&pci_cfg_wait, &wait);
>  }
>  
>  /* Returns 0 on success, negative values indicate error. */
> -- 
> 2.19.1
> 
> 
