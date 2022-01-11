Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D4848B630
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jan 2022 19:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350242AbiAKSzn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jan 2022 13:55:43 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54620 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350250AbiAKSzl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jan 2022 13:55:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CF356176D;
        Tue, 11 Jan 2022 18:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8210C36AE3;
        Tue, 11 Jan 2022 18:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641927339;
        bh=zojY8MTCnk8nwBqZ+pXLnQcYipINl6Y5Z/qNYwqhFRc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=q6rIpxYlfnP/5Kr6nyyWLHpNrmEsfDvrClt4rm7Sxa+1/jl/V84qxepgXn6Z1rAuV
         D4gwcA5ZtoWGkG6HLcaC+VisaRHHhwJbOIdSmEU6qKbp+oWzrfFQi8OP1ZmfgK8KGT
         mtMF+0rbkAPCQKXPXwlIXWrhLX2nDzaohYCxuShmtjY1QZGoVnUQdnhDCk4RGeYGCH
         JqWvFMyFdFXK+NlxHa/2xaj+Fa911Zg0OouSpg7ZOaBvPfXIhBlQBskNawWvNYPpEF
         I8pNitn+N71ZQzXYH4yFJvtFiD07SMzFThKa0m1x6j1pnwBd5t6JwSHMP9A3hOWbgW
         quz7Pk34Z32wA==
Date:   Tue, 11 Jan 2022 12:55:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yao Hongbo <yaohongbo@linux.alibaba.com>
Cc:     bhelgaas@google.com, lukas@wunner.de,
        zhangliguang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH v2] PCI: Waiting command completed in
 get_port_device_capability()
Message-ID: <20220111185538.GA152548@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641525769-113099-1-git-send-email-yaohongbo@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lukas, Rafael (in case you have any recollection of 2bd50dd800b5)]

On Fri, Jan 07, 2022 at 11:22:49AM +0800, Yao Hongbo wrote:
> According to the PCIe specification Revision 5.0, section
> 7.5.3.11 (slot Status Register), if Command Complete notification
> is supported,  a write to the slot control register needs to set
> the command completed bit, which can indicate the controller is
> ready to receive the next command.
> 
> However, before probing the pcie hotplug service, there needs to set
> HPIE bit in the slot ctrl register to disable hotplug interrupts,
> and there is no wait currently.
> 
> The interval between the two functions get_port_device_capability() and
> pcie_disable_notification() is not long, which may cause the latter to
> be interfered by the former.
> 
> The command complete event received by pcie_disable_notification() may
> belong to the operation of get_port_device_capability().

Yes, looks like a potential problem.

> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> Signed-off-by: Yao Hongbo <yaohongbo@linux.alibaba.com>
> ---
>  drivers/pci/pcie/portdrv_core.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index bda6308..ec2088b6e 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -15,6 +15,7 @@
>  #include <linux/string.h>
>  #include <linux/slab.h>
>  #include <linux/aer.h>
> +#include <linux/delay.h>
>  
>  #include "../pci.h"
>  #include "portdrv.h"
> @@ -190,6 +191,42 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>  	return 0;
>  }
>  
> +static void pcie_port_disable_hp_interrupt(struct pci_dev *dev)
> +{
> +	u16 slot_status;
> +	u32 slot_cap;
> +	int timeout = 1000;
> +
> +	pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> +			PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> +
> +	/*
> +	 * If the command completed notification is not supported,
> +	 * we don't need to wait after writing to the slot ctrl register.
> +	 */
> +	pcie_capability_read_dword(dev, PCI_EXP_SLTCAP, &slot_cap);
> +	if (slot_cap & PCI_EXP_SLTCAP_NCCS)
> +		return;
> +
> +	do {
> +		pcie_capability_read_word(dev, PCI_EXP_SLTSTA, &slot_status);
> +		if (slot_status == (u16) ~0) {
> +			pci_info(dev, "%s: no response from device\n",  __func__);
> +			return;
> +		}
> +
> +		if (slot_status & PCI_EXP_SLTSTA_CC) {
> +			pcie_capability_write_word(dev, PCI_EXP_SLTSTA, PCI_EXP_SLTSTA_CC);
> +			return;
> +		}
> +
> +		msleep(10);
> +		timeout -= 10;
> +	} while (timeout >= 0);
> +
> +	pci_info(dev, "Timeout on hotplug disable interrupt!\n");
> +}
> +
>  /**
>   * get_port_device_capability - discover capabilities of a PCI Express port
>   * @dev: PCI Express port to examine
> @@ -213,8 +250,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  		 * Disable hot-plug interrupts in case they have been enabled
>  		 * by the BIOS and the hot-plug service driver is not loaded.
>  		 */
> -		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> -			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> +		pcie_port_disable_hp_interrupt(dev);

This originally came from 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port
services during port initialization"), where we disable hotplug
interrupts in case the hotplug driver is not available.

In general, I think the OS should not be responsible for disabling
interrupts for feature X.  The OS may predate feature X and may not
know anything about X at all.  The power-on default for interrupts
related to X should be "disabled" (as it is for HPIE and CCIE), and if
firmware enables them, it should disable them or arrange to handle
them itself before handing off to the OS.

I don't know whether 2bd50dd800b5 was prompted by spurious hotplug
interrupts or not.  If it was, I think we were seeing a firmware
defect or possibly a pciehp initialization issue.

At the time of 2bd50dd800b5, we always cleared HPIE and CCIE here.

But now, on ACPI systems, we only clear HPIE and CCIE here if we *do*
have the hotplug driver (because host->native_pcie_hotplug only
remains set if we have been granted control via _OSC, and we only
request control when CONFIG_HOTPLUG_PCI_PCIE is enabled).  On these
systems, we should be able to remove this disable code because pciehp
will do whatever it needs.

For non-ACPI systems, bridge->native_pcie_hotplug will always be set,
so we will clear HPIE and CCIE here and then (if
CONFIG_HOTPLUG_PCI_PCIE is enabled) initialize pciehp soon after,
which may be a problem as you describe.

What kind of system are you seeing the problem on?  It seems like it
should be safe to drop the HPIE and CCIE disable here for ACPI
systems.  And *likely* we could do the same for non-ACPI systems,
though I have no experience there.

Bjorn
