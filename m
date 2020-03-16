Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 842BF186FCD
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 17:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbgCPQPq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 12:15:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732021AbgCPQPq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Mar 2020 12:15:46 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBACB20663;
        Mon, 16 Mar 2020 16:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584375345;
        bh=/eBtlkOiKcO6ZlA+qIf14mPMdZiJ8IbhdChfZYtVt7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oe0DgkIxtYUvB5CcHxnVNQef6TAC/uDpXd7wBH+hzp3nNM5LWBlwl/moll45Ciz3/
         YRA9+DOm71mHFLCUgOhuWEGuI1aLGvpMkly4ellVaJ6jo5oRvchAwWlUky2JIcTRHN
         xAO7AfYFPve/eIaGnoGWcozstTe20vdHnokYWrLo=
Date:   Mon, 16 Mar 2020 09:15:43 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     "Hoyer, David" <David.Hoyer@netapp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Kernel hangs when powering up/down drive using sysfs
Message-ID: <20200316161543.GB1069861@dhcp-10-100-145-180.wdl.wdc.com>
References: <DM5PR06MB313235E97731D97AB813F65D92FB0@DM5PR06MB3132.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR06MB313235E97731D97AB813F65D92FB0@DM5PR06MB3132.namprd06.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 14, 2020 at 02:19:44PM +0000, Hoyer, David wrote:
> We have come across what we believe to be a kernel bug (using 4.19.98-1 kernel in Debian Buster).
> 
> We are seeing an issue with the latest kernel when it comes to powering up/down drives.    If you use /sys/bus/pci/slots/<N>/power to power up/down a drive, the command is hanging with this latest version of the kernel.   We have found that applying the following change appears to fix it.   We are not finding any bug reports upstream yet.
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index c3e3f53..c4d230a 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -637,6 +637,8 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>         events = atomic_xchg(&ctrl->pending_events, 0);
>         if (!events) {
>                 pci_config_pm_runtime_put(pdev);
> +               ctrl->ist_running = false;
> +               wake_up(&ctrl->requester);
>                 return IRQ_NONE;
>        }
> 
> We believe the reason we see this (and not the others who introduced it) are because of our timings on our PLX-based switch.  Since we fan things out over I2C transactions instead of direct GPIOs, there are different timings than most folks would see.
> 
> We've instrumented the code and we do see that pciehp_ist() runs twice, once exiting with IRQ_HANDLED and then again with IRQ_NONE.  We believe that is due to the timing differences.  Adding debug in here changes the timings enough that the hang goes away, so we are having troubles proving this 100% at the moment.  But just based on code inspection, if pciehp_ist() exits with the IRQ_NONE case, then nothing will ever set ist_running=false until a subsequent hotplug event happens that causes the IRQ_HANDLED case to run.  (We were able to prove that will cause things to "unhang" and progress at that point - if you're hung and you remove a drive, the slot status change will then unstick things.)
> 
> So we currently believe the problem is:
> pciehp_sysfs_enable/disable_slot() each have a wait_event() that checks for ctrl->pending_events and ctrl->ist_running to both be false.  We run through pciehp_ist() the first time, return with IRQ_HANDLED, pending_events==0, ist_running==0.  While pciehp_sysfs_enable/disable_slot() are waking up, pciehp_ist() runs a 2nd time, setting ist_running==1, (pending_events is still 0) and returning IRQ_NONE.  Now that ist_running==1, the original wait_event() goes back to waiting and will not be woken up until something causes pciehp_ist() to run again with a pending_events!=0 that will result in returning IRQ_HANDLED.
> 
> Setting ist_running=0 and issuing a wake_up() for the IRQ_NONE return case in pciehp_ist() seems to fix this.

I follow what you're saying.

I'm not sure why the hard-irq context is even setting the thread running
flag while it can still exit without handling anything. Shouldn't it leave
the flag cleared until knows it's actually going to do something?

---
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 8a2cb1764386..adf13657b3d2 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -618,7 +618,6 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	irqreturn_t ret;
 	u32 events;
 
-	ctrl->ist_running = true;
 	pci_config_pm_runtime_get(pdev);
 
 	/* rerun pciehp_isr() if the port was inaccessible on interrupt */
@@ -638,6 +637,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
+	ctrl->ist_running = true;
 	/* Check Attention Button Pressed */
 	if (events & PCI_EXP_SLTSTA_ABP) {
 		ctrl_info(ctrl, "Slot(%s): Attention button pressed\n",
--
