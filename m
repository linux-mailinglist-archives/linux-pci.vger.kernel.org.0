Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87464102D7A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 21:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfKSUXI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 15:23:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:50094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfKSUXI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 15:23:08 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FBCD2235D;
        Tue, 19 Nov 2019 20:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574194988;
        bh=gGqBvXglDEzCSK8thnzKNOyVmnBORJCnCuazwZu8Wmo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qrsJKda4M4ryOc9ETyXtnEeKouT6QOkDTRulbKdjk20avj2s4UH5QDkaoX2uJX/Ma
         n5V457p79EcIba3noyQ3FLcAQBBxUy9i1KvyDfxpnx8id3VHLuTBxvcXyJoKeWQblT
         cckiTKZsqFMWpLv633GqE8wUA9KNg896rOnsGE2w=
Date:   Tue, 19 Nov 2019 14:23:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xiang Zheng <zhengxiang9@huawei.com>
Cc:     willy@infradead.org, wangxiongfeng2@huawei.com,
        wanghaibin.wang@huawei.com, guoheyi@huawei.com,
        yebiaoxiang@huawei.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        tglx@linutronix.de, guohanjun@huawei.com, yangyingliang@huawei.com
Subject: Re: [PATCH v2] pci: lock the pci_cfg_wait queue for the consistency
 of data
Message-ID: <20191119202305.GA214858@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119011545.15408-1-zhengxiang9@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 19, 2019 at 09:15:45AM +0800, Xiang Zheng wrote:
> Commit "7ea7e98fd8d0" suggests that the "pci_lock" is sufficient,
> and all the callers of pci_wait_cfg() are wrapped with the "pci_lock".
> 
> However, since the commit "cdcb33f98244" merged, the accesses to
> the pci_cfg_wait queue are not safe anymore. A "pci_lock" is
> insufficient and we need to hold an additional queue lock while
> read/write the wait queue.
> 
> So let's use the add_wait_queue()/remove_wait_queue() instead of
> __add_wait_queue()/__remove_wait_queue(). Also move the wait queue
> functionality around the "schedule()" function to avoid reintroducing
> the deadlock addressed by "cdcb33f98244".

Procedural nits:

  - Run "git log --oneline drivers/pci/access.c" and follow the
    convention, e.g., starts with "PCI: " and first subsequent word is
    capitalized.

  - Use conventional commit references, e.g., 7ea7e98fd8d0 ("PCI:
    Block on access to temporarily unavailable pci device") and
    cdcb33f98244 ("PCI: Avoid possible deadlock on pci_lock and
    p->pi_lock")

  - IIRC you found that this actually caused a panic; please include
    the lore.kernel.org URL to that report.

You can wait for a while to see if there are more substantive comments
to address before posting a v3.

> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> Cc: Heyi Guo <guoheyi@huawei.com>
> Cc: Biaoxiang Ye <yebiaoxiang@huawei.com>
> ---
> 
> v2:
>  - Move the wait queue functionality around the "schedule()" function to
>    avoid reintroducing the deadlock addressed by "cdcb33f98244"
> 
> ---
> 
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
