Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFD12B2AB
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2019 13:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfE0LCy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 May 2019 07:02:54 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63556 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfE0LCx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 May 2019 07:02:53 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id cfb2f764cd3f14d9; Mon, 27 May 2019 13:02:50 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] PCI: PM: Avoid possible suspend-to-idle issue
Date:   Mon, 27 May 2019 13:02:49 +0200
Message-ID: <10983642.dUqMSvAAlD@kreacher>
In-Reply-To: <2315917.ZGeXE6pBFC@kreacher>
References: <2315917.ZGeXE6pBFC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday, May 17, 2019 11:08:50 AM CEST Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If a PCI driver leaves the device handled by it in D0 and calls
> pci_save_state() on the device in its ->suspend() or ->suspend_late()
> callback, it can expect the device to stay in D0 over the whole
> s2idle cycle.  However, that may not be the case if there is a
> spurious wakeup while the system is suspended, because in that case
> pci_pm_suspend_noirq() will run again after pci_pm_resume_noirq()
> which calls pci_restore_state(), via pci_pm_default_resume_early(),
> so state_saved is cleared and the second iteration of
> pci_pm_suspend_noirq() will invoke pci_prepare_to_sleep() which
> may change the power state of the device.
> 
> To avoid that, add a new internal flag, skip_bus_pm, that will be set
> by pci_pm_suspend_noirq() when it runs for the first time during the
> given system suspend-resume cycle if the state of the device has
> been saved already and the device is still in D0.  Setting that flag
> will cause the next iterations of pci_pm_suspend_noirq() to set
> state_saved for pci_pm_resume_noirq(), so that it always restores the
> device state from the originally saved data, and avoid calling
> pci_prepare_to_sleep() for the device.
> 
> Fixes: 33e4f80ee69b ("ACPI / PM: Ignore spurious SCI wakeups from suspend-to-idle")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/pci/pci-driver.c |   17 ++++++++++++++++-
>  include/linux/pci.h      |    1 +
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-driver.c
> +++ linux-pm/drivers/pci/pci-driver.c
> @@ -734,6 +734,8 @@ static int pci_pm_suspend(struct device
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
> +	pci_dev->skip_bus_pm = false;
> +
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_suspend(dev, PMSG_SUSPEND);
>  
> @@ -827,7 +829,20 @@ static int pci_pm_suspend_noirq(struct d
>  		}
>  	}
>  
> -	if (!pci_dev->state_saved) {
> +	if (pci_dev->skip_bus_pm) {
> +		/*
> +		 * The function is running for the second time in a row without
> +		 * going through full resume, which is possible only during
> +		 * suspend-to-idle in a spurious wakeup case.  Moreover, the
> +		 * device was originally left in D0, so its power state should
> +		 * not be changed here and the device register values saved
> +		 * originally should be restored on resume again.
> +		 */
> +		pci_dev->state_saved = true;
> +	} else if (pci_dev->state_saved) {
> +		if (pci_dev->current_state == PCI_D0)
> +			pci_dev->skip_bus_pm = true;
> +	} else {
>  		pci_save_state(pci_dev);
>  		if (pci_power_manageable(pci_dev))
>  			pci_prepare_to_sleep(pci_dev);
> Index: linux-pm/include/linux/pci.h
> ===================================================================
> --- linux-pm.orig/include/linux/pci.h
> +++ linux-pm/include/linux/pci.h
> @@ -344,6 +344,7 @@ struct pci_dev {
>  						   D3cold, not set for devices
>  						   powered on/off by the
>  						   corresponding bridge */
> +	unsigned int	skip_bus_pm:1;	/* Internal: Skip bus-level PM */
>  	unsigned int	ignore_hotplug:1;	/* Ignore hotplug events */
>  	unsigned int	hotplug_user_indicators:1; /* SlotCtl indicators
>  						      controlled exclusively by
> 

Bjorn, I've assumed no concerns or objections from you regarding this one and
queued it up.

If that assumption is incorrect, please let me know.



