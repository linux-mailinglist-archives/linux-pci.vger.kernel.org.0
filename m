Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798E63D73D2
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jul 2021 12:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbhG0K4A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 06:56:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:41168 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236169AbhG0Kz7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jul 2021 06:55:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="297992762"
X-IronPort-AV: E=Sophos;i="5.84,273,1620716400"; 
   d="scan'208";a="297992762"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 03:55:56 -0700
X-IronPort-AV: E=Sophos;i="5.84,273,1620716400"; 
   d="scan'208";a="498442110"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 03:55:53 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 27 Jul 2021 13:55:51 +0300
Date:   Tue, 27 Jul 2021 13:55:51 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>
Subject: Re: [RFT][PATCH] PCI: PM: Add special case handling for PCIe device
 wakeup
Message-ID: <YP/mN6kSwMPWW+Mn@lahna>
References: <5475468.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5475468.DvuYhMxLoT@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rafael,

On Mon, Jul 12, 2021 at 07:06:47PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Some PCIe devices only support PME (Power Management Event) from
> D3cold.  One example is the ASMedia xHCI controller:
> 
>  11:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller (prog-if 30 [XHCI])
>    ...
>    Capabilities: [78] Power Management version 3
>            Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
>            Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 
> In those cases, if the device is expected to generate wakeup events
> from its final power state, pci_target_state() returns D0, which
> prevents the PCIe port the device is connected to from entering any
> low-power states too.  However, if the device were allowed to go into
> D3hot, its parent PCIe port would also be able to go into D3 and if
> it goes into D3cold, it would cause the endpoint device to end up in
> D3cold too (as per the PCI PM spec v1.2, Table 6-1), in which case
> the endpoint would be able to signal PME.  This means that the system
> could be put into a lower-power configuration without sacrificing the
> the given device's ability to generate PME.
> 
> In order to avoid missing that opportunity, extend pci_pme_capable()
> to check the device's parent in the special case when the target
> state is D3hot and the device can only signal PME from D3cold and
> update pci_target_state() to return the current target state if
> pci_pme_capable() returns 'true' for it.

Thanks a lot for this!

I tried the patch and unfortunately it does not solve the issue but I
think I know what the problem is, see below.

> Link: https://lore.kernel.org/linux-pm/20210617123653.58640-1-mika.westerberg@linux.intel.com
> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
> Reported-by: Koba Ko <koba.ko@canonical.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Hi,
> 
> Anyone who can reproduce the problem described in the changelog,
> please test the patch and let me know the result.
> 
> Thanks!
> 
> ---
>  drivers/pci/pci.c |   38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.c
> +++ linux-pm/drivers/pci/pci.c
> @@ -2298,10 +2298,29 @@ void pci_pme_wakeup_bus(struct pci_bus *
>   */
>  bool pci_pme_capable(struct pci_dev *dev, pci_power_t state)
>  {
> +	struct pci_dev *parent;
> +
>  	if (!dev->pm_cap)
>  		return false;
>  
> -	return !!(dev->pme_support & (1 << state));
> +	if (dev->pme_support & (1 << state))
> +		return true;
> +
> +	/*
> +	 * Special case: The target state is D3hot and the device only supports
> +	 * signaling PME from D3cold, but it is a PCIe device whose parent port
> +	 * can go into D3cold.  In that case, if the device is allowed to go
> +	 * into D3hot, the parent port can go into D3cold which will cause the
> +	 * device to end up in D3cold, so it will be able to signal PME from the
> +	 * final state.
> +	 */
> +	if (state != PCI_D3hot || !(dev->pme_support & (1 << PCI_D3cold)))
> +		return false;
> +
> +	parent = dev->bus->self;
> +	return pci_bridge_d3_possible(parent) &&
> +		platform_pci_power_manageable(parent) &&

Here. We cannot assume that the parent has ACPI node either. For
instance when PCIe is tunneled over TBT/USB4 there can be several PCIe
switches between the problem endpoint and the root port (which has the
ACPI node of course). I think the safe assumption is to check for the
root port and whether platform_pci_power_manageable() returns true for
it but I may be missing something.

> +		platform_pci_choose_state(parent) == PCI_D3cold;
>  }
>  EXPORT_SYMBOL(pci_pme_capable);
>  
> @@ -2595,17 +2614,12 @@ static pci_power_t pci_target_state(stru
>  	if (dev->current_state == PCI_D3cold)
>  		target_state = PCI_D3cold;
>  
> -	if (wakeup) {
> -		/*
> -		 * Find the deepest state from which the device can generate
> -		 * PME#.
> -		 */
> -		if (dev->pme_support) {
> -			while (target_state
> -			      && !(dev->pme_support & (1 << target_state)))
> -				target_state--;
> -		}
> -	}
> +	if (!wakeup || !dev->pme_support || pci_pme_capable(dev, target_state))
> +		return target_state;
> +
> +	/* Find the deepest state from which the device can generate PME#. */
> +	while (target_state && !(dev->pme_support & (1 << target_state)))
> +		target_state--;
>  
>  	return target_state;
>  }
> 
> 
