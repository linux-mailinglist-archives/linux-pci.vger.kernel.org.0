Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5262444E9E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 23:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfFMVi0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 17:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfFMVi0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 17:38:26 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E703721537;
        Thu, 13 Jun 2019 21:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560461905;
        bh=M6myfQdWWELGGbpAI4gL7Nt7LV9Ty3oKQkl8fFDTXBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GiOEXmkQohC5GhiHicscoDbvsQnf1y6heSN7wKnwrYQrCz878j+fqKZhH5xjnDUtK
         HhOJKhXv2jJryT0/NZONEpoeKAfuYHFAaB9cSSFQfosZn4xl0zVA4fUuKHkiM7ydu1
         90kKhgggnzfRc1MHJRuCVCOy+GoZO/RJA7zEt05k=
Date:   Thu, 13 Jun 2019 16:38:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] PCI: PM: Skip devices in D0 for suspend-to-idle
Message-ID: <20190613213823.GM13533@google.com>
References: <2513600.jR9RdVMSR0@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2513600.jR9RdVMSR0@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 12:14:02AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
> attempted to avoid a problem with devices whose drivers want them to
> stay in D0 over suspend-to-idle and resume, but it did not go as far
> as it should with that.
> 
> Namely, first of all, it is questionable to change the power state
> of a PCI bridge with a device in D0 under it, but that is not
> actively prevented from happening during system-wide PM transitions,
> so use the skip_bus_pm flag introduced by commit d491f2b75237 for
> that.

I think it's more than questionable.  I think a bridge is *required*
to be in D0 if any downstream device is in D0.  Based on the PCI PM
spec r1.2, sec 6, table 6-1, if the bridge is not in D0, there can be
no PCI transactions on its secondary bus.

> Second, the configuration of devices left in D0 (whatever the reason)
> during suspend-to-idle need not be changed and attempting to put them
> into D0 again by force may confuse some firmware, so explicitly avoid
> doing that.

I don't know what to do with "may confuse some firmware"; it doesn't
say what firmware is affected or why, so it sort of leads to "we can
never touch this code because we don't know what might break."

But IMO the first reason by itself is more than enough to keep a
bridge in D0 if any downstream device is in D0.

> Fixes: d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Tested on Dell XPS13 9360 with no issues.
> 
> ---
>  drivers/pci/pci-driver.c |   47 +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 35 insertions(+), 12 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-driver.c
> +++ linux-pm/drivers/pci/pci-driver.c
> @@ -524,7 +524,6 @@ static void pci_pm_default_resume_early(
>  	pci_power_up(pci_dev);
>  	pci_restore_state(pci_dev);
>  	pci_pme_restore(pci_dev);
> -	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>  }
>  
>  /*
> @@ -842,18 +841,16 @@ static int pci_pm_suspend_noirq(struct d
>  
>  	if (pci_dev->skip_bus_pm) {
>  		/*
> -		 * The function is running for the second time in a row without
> +		 * Either the device is a bridge with a child in D0 below it, or
> +		 * the function is running for the second time in a row without
>  		 * going through full resume, which is possible only during
> -		 * suspend-to-idle in a spurious wakeup case.  Moreover, the
> -		 * device was originally left in D0, so its power state should
> -		 * not be changed here and the device register values saved
> -		 * originally should be restored on resume again.
> +		 * suspend-to-idle in a spurious wakeup case.  The device should
> +		 * be in D0 at this point, but if it is a bridge, it may be
> +		 * necessary to save its state.
>  		 */
> -		pci_dev->state_saved = true;
> -	} else if (pci_dev->state_saved) {
> -		if (pci_dev->current_state == PCI_D0)
> -			pci_dev->skip_bus_pm = true;
> -	} else {
> +		if (!pci_dev->state_saved)
> +			pci_save_state(pci_dev);
> +	} else if (!pci_dev->state_saved) {
>  		pci_save_state(pci_dev);
>  		if (pci_power_manageable(pci_dev))
>  			pci_prepare_to_sleep(pci_dev);
> @@ -862,6 +859,22 @@ static int pci_pm_suspend_noirq(struct d
>  	dev_dbg(dev, "PCI PM: Suspend power state: %s\n",
>  		pci_power_name(pci_dev->current_state));
>  
> +	if (pci_dev->current_state == PCI_D0) {
> +		pci_dev->skip_bus_pm = true;
> +		/*
> +		 * Changing the power state of a PCI bridge with a device in D0
> +		 * below it is questionable, so avoid doing that by setting the
> +		 * skip_bus_pm flag for the parent bridge.

Maybe "Per PCI PM r1.2, table 6-1, a bridge must be in D0 if any
downstream device is in D0"?

> +		 */
> +		if (pci_dev->bus->self)
> +			pci_dev->bus->self->skip_bus_pm = true;
> +	}
> +
> +	if (pci_dev->skip_bus_pm && !pm_suspend_via_firmware()) {
> +		dev_dbg(dev, "PCI PM: Skipped\n");
> +		goto Fixup;
> +	}
> +
>  	pci_pm_set_unknown_state(pci_dev);
>  
>  	/*
> @@ -909,7 +922,16 @@ static int pci_pm_resume_noirq(struct de
>  	if (dev_pm_smart_suspend_and_suspended(dev))
>  		pm_runtime_set_active(dev);
>  
> -	pci_pm_default_resume_early(pci_dev);
> +	/*
> +	 * In the suspend-to-idle case, devices left in D0 during suspend will
> +	 * stay in D0, so it is not necessary to restore or update their
> +	 * configuration here and attempting to put them into D0 again may
> +	 * confuse some firmware, so avoid doing that.
> +	 */
> +	if (!pci_dev->skip_bus_pm || pm_suspend_via_firmware())
> +		pci_pm_default_resume_early(pci_dev);
> +
> +	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>  
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_resume_early(dev);
> @@ -1200,6 +1222,7 @@ static int pci_pm_restore_noirq(struct d
>  	}
>  
>  	pci_pm_default_resume_early(pci_dev);
> +	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>  
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_resume_early(dev);
> 
> 
> 
