Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF0A2D82B0
	for <lists+linux-pci@lfdr.de>; Sat, 12 Dec 2020 00:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407122AbgLKXWe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 18:22:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:43842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733131AbgLKXWL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Dec 2020 18:22:11 -0500
Date:   Fri, 11 Dec 2020 17:21:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607728890;
        bh=3VgLDCACXpJY6wxWW9+nWtwWslnzlCni0gtSsYXLq1o=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=czQZgMhuwEPebAeGGCrIUMfWC9yOp5H6gu6xzPUiAlDmGF/gyoEzbGgagLrbZMebo
         VF3nKPxApMb6KKA3vv6IR5t53oFW/DipTC2WdkkrTwos9JG2XlQNAWyZhpNnfkVoFW
         AvoGryB/40junWu2tn892WOnYojJRfPPzXgS+PqkKOhMm4bg28zjOQxy23CFQ7THsw
         dpCtGwOGDpOHLIB9MeyG6E2ccQWYeEWwrizclhjmv8Xxzo5/MJe8i84Nu+Wjbsdzz1
         +UT1KMsB/vaqrBmTQLQk06ZdT+Ajg1mlx4ofTN/4elzV9HtbMlrlGIut97ABAWHamn
         nnfMVwtfFfbJw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] PCI: ACPI: Fix up ACPI companion lookup for device 0 on
 the root bus
Message-ID: <20201211232129.GA118451@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4673285.9aE2nYKHPr@kreacher>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 11, 2020 at 09:17:35PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In some cases acpi_pci_find_companion() returns an incorrect device
> object as the ACPI companion for device 0 on the root bus (bus 0).
> 
> On the affected systems that device is the PCI interface to the
> host bridge and the "ACPI companion" returned for it corresponds
> to a non-PCI device located in the SoC (e.g. a sensor on an I2C
> bus).  As a result of this, the ACPI device object "attached"
> to PCI device 00:00.0 cannot be used for enumerating the device
> that is really represented by it which (of course) is problematic.
> 
> Address that issue by preventing acpi_pci_find_companion() from
> returning a device object with a valid _HID (which by the spec
> should not be present uder ACPI device objects corresponding to
> PCI devices) for PCI device 00:00.0.
> 
> Link: https://lore.kernel.org/linux-acpi/1409ba0c-1580-dc09-e6fe-a0c9bcda6462@gmail.com/
> Reported-by: Daniel Scally <djrscally@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied with Daniel's Tested-by and Reviewed-by to pci/enumeration for
v5.11, thanks!

> ---
>  drivers/pci/pci-acpi.c |   20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -1162,14 +1162,32 @@ void acpi_pci_remove_bus(struct pci_bus
>  static struct acpi_device *acpi_pci_find_companion(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	struct acpi_device *adev;
>  	bool check_children;
>  	u64 addr;
>  
>  	check_children = pci_is_bridge(pci_dev);
>  	/* Please ref to ACPI spec for the syntax of _ADR */
>  	addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
> -	return acpi_find_child_device(ACPI_COMPANION(dev->parent), addr,
> +	adev = acpi_find_child_device(ACPI_COMPANION(dev->parent), addr,
>  				      check_children);
> +	/*
> +	 * There may be ACPI device objects in the ACPI namespace that are
> +	 * children of the device object representing the host bridge, but don't
> +	 * represent PCI devices.  Both _HID and _ADR may be present for them,
> +	 * even though that is against the specification (for example, see
> +	 * Section 6.1 of ACPI 6.3), but in many cases the _ADR returns 0 which
> +	 * appears to indicate that they should not be taken into consideration
> +	 * as potential companions of PCI devices on the root bus.
> +	 *
> +	 * To catch this special case, disregard the returned device object if
> +	 * it has a valid _HID, addr is 0 and the PCI device at hand is on the
> +	 * root bus.
> +	 */
> +	if (adev && adev->pnp.type.platform_id && !addr && !pci_dev->bus->parent)
> +		return NULL;
> +
> +	return adev;
>  }
>  
>  /**
> 
> 
> 
