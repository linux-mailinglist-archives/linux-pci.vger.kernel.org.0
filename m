Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49B8219692C
	for <lists+linux-pci@lfdr.de>; Sat, 28 Mar 2020 21:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgC1UZq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Mar 2020 16:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgC1UZq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Mar 2020 16:25:46 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3A4A20714;
        Sat, 28 Mar 2020 20:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585427145;
        bh=eU5vvlb/p/F49VuznZhEQWvTKhP4Cf14rGgIeKWbFzs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ugUuwV9O8UVDv+bDGWX8w3KDQ9/ggrQ2JBC71mkO44Uk75zmJATq8pAMCwopO0DY+
         ju40maGhisD6ZWQvzsPeOAIKR+x7iDTuVtwF1OKLeWC7OYFHrDA4wgJ/XgR3Sj2kJU
         Z5BN+t17d1Q2v6vChjl7d6DfeiTA8BSJ9Iprw9TA=
Date:   Sat, 28 Mar 2020 15:25:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     David Hoyer <David.Hoyer@netapp.com>,
        Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH] PCI: pciehp: Fix indefinite wait on sysfs requests
Message-ID: <20200328202543.GA112622@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cca1effa488065cb055120aa01b65719094bdcb5.1584530321.git.lukas@wunner.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 18, 2020 at 12:33:12PM +0100, Lukas Wunner wrote:
> David Hoyer reports that powering pciehp slots up or down via sysfs may
> hang:  The call to wait_event() in pciehp_sysfs_enable_slot() and
> _disable_slot() does not return because ctrl->ist_running remains true.
> 
> This flag, which was introduced by commit 54ecb8f7028c ("PCI: pciehp:
> Avoid returning prematurely from sysfs requests"), signifies that the
> IRQ thread pciehp_ist() is running.  It is set to true at the top of
> pciehp_ist() and reset to false at the end.  However there are two
> additional return statements in pciehp_ist() before which the commit
> neglected to reset the flag to false and wake up waiters for the flag.
> 
> That omission opens up the following race when powering up the slot:
> 
> * pciehp_ist() runs because a PCI_EXP_SLTSTA_PDC event was requested
>   by pciehp_sysfs_enable_slot()
> 
> * pciehp_ist() turns on slot power via the following call stack:
>   pciehp_handle_presence_or_link_change() -> pciehp_enable_slot() ->
>   __pciehp_enable_slot() -> board_added() -> pciehp_power_on_slot()
> 
> * after slot power is turned on, the link comes up, resulting in a
>   PCI_EXP_SLTSTA_DLLSC event
> 
> * the IRQ handler pciehp_isr() stores the event in ctrl->pending_events
>   and returns IRQ_WAKE_THREAD
> 
> * the IRQ thread is already woken (it's bringing up the slot), but the
>   genirq code remembers to re-run the IRQ thread after it has finished
>   (such that it can deal with the new event) by setting IRQTF_RUNTHREAD
>   via __handle_irq_event_percpu() -> __irq_wake_thread()
> 
> * the IRQ thread removes PCI_EXP_SLTSTA_DLLSC from ctrl->pending_events
>   via board_added() -> pciehp_check_link_status() in order to deal with
>   presence and link flaps per commit 6c35a1ac3da6 ("PCI: pciehp:
>   Tolerate initially unstable link")
> 
> * after pciehp_ist() has successfully brought up the slot, it resets
>   ctrl->ist_running to false and wakes up the sysfs requester
> 
> * the genirq code re-runs pciehp_ist(), which sets ctrl->ist_running
>   to true but then returns with IRQ_NONE because ctrl->pending_events
>   is empty
> 
> * pciehp_sysfs_enable_slot() is finally woken but notices that
>   ctrl->ist_running is true, hence continues waiting
> 
> The only way to get the hung task going again is to trigger a hotplug
> event which brings down the slot, e.g. by yanking out the card.
> 
> The same race exists when powering down the slot because remove_board()
> likewise clears link or presence changes in ctrl->pending_events per
> commit 3943af9d01e9 ("PCI: pciehp: Ignore Link State Changes after
> powering off a slot") and thereby may cause a re-run of pciehp_ist()
> which returns with IRQ_NONE without resetting ctrl->ist_running to false.
> 
> Fix by adding a goto label before the teardown steps at the end of
> pciehp_ist() and jumping to that label from the two return statements
> which currently neglect to reset the ctrl->ist_running flag.
> 
> Fixes: 54ecb8f7028c ("PCI: pciehp: Avoid returning prematurely from sysfs requests")
> Reported-by: David Hoyer <David.Hoyer@netapp.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.19+
> Cc: Keith Busch <kbusch@kernel.org>

Applied to pci/hotplug for v5.7, thanks!

> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index e4627c68b30f..5f1a27bfcb19 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -663,17 +663,15 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>  	if (atomic_fetch_and(~RERUN_ISR, &ctrl->pending_events) & RERUN_ISR) {
>  		ret = pciehp_isr(irq, dev_id);
>  		enable_irq(irq);
> -		if (ret != IRQ_WAKE_THREAD) {
> -			pci_config_pm_runtime_put(pdev);
> -			return ret;
> -		}
> +		if (ret != IRQ_WAKE_THREAD)
> +			goto out;
>  	}
>  
>  	synchronize_hardirq(irq);
>  	events = atomic_xchg(&ctrl->pending_events, 0);
>  	if (!events) {
> -		pci_config_pm_runtime_put(pdev);
> -		return IRQ_NONE;
> +		ret = IRQ_NONE;
> +		goto out;
>  	}
>  
>  	/* Check Attention Button Pressed */
> @@ -702,10 +700,12 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>  		pciehp_handle_presence_or_link_change(ctrl, events);
>  	up_read(&ctrl->reset_lock);
>  
> +	ret = IRQ_HANDLED;
> +out:
>  	pci_config_pm_runtime_put(pdev);
>  	ctrl->ist_running = false;
>  	wake_up(&ctrl->requester);
> -	return IRQ_HANDLED;
> +	return ret;
>  }
>  
>  static int pciehp_poll(void *data)
> -- 
> 2.25.0
> 
