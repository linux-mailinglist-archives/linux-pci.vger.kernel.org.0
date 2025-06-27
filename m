Return-Path: <linux-pci+bounces-30981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2257AEC2BB
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 00:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473641C61D63
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 22:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D4F290BBD;
	Fri, 27 Jun 2025 22:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7kQQLWP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC6D290BA2;
	Fri, 27 Jun 2025 22:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751064304; cv=none; b=Z4HE9mjJYGidQwxkGvNOZabP4SjHZL0NTiorMWiRTrx0tY63ZlndYhm9vgJgEedkgrHCyMcm50zAGZO9VLb+S7Fm/B5ZepJuGpfsnZ5QtQzC+Cas5AgoKzreANRmibJGw3XeYD/GWf/KYms28QgTtywL8/i9qlXTjA44x2NzV2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751064304; c=relaxed/simple;
	bh=1Ak7U+3T27pJCrkrLOvYmrUZEuSxGOOTIPu+voQsYb4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pLwuRc8IXtMJ6R5URZ1eh5A8ATvPNUYMOAD9QAcrqRg71/C6UOv4Wt5gM0DgXzWK2bimFHYJS28azWVNTrFbzyMbNnhbBWtQSJVYv9crXIDfF59gVzRSI8YnasFsni1HDRGyCXrA/1sAsdS90guyoyLegvt1crAn92cQqYIte70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7kQQLWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE333C4CEE3;
	Fri, 27 Jun 2025 22:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751064304;
	bh=1Ak7U+3T27pJCrkrLOvYmrUZEuSxGOOTIPu+voQsYb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=X7kQQLWPMN6KESV3rn22HM+loiDcLkcFT+iXLgdJUm+rbYLCIN4iz4oOT8pSs/8pr
	 vTpwHkmGU+4fkD09WwoBHwEIuyD3FDHQuUp+j1FivGk+w7F7G4aFXhd+90rT65MJfU
	 mPG9fDPcYvTcRD+KnbmwMoZ+0FF05hcF+RZTjJo6TAfSeCiHuXAvWzY/mOUPC5I06n
	 1NWoeSdsP5rE6sYz1DTLCkwX+vdOknVjUW3NK1D5094LBwKCRk64w1sx/Emo83WfmF
	 ZK6qFzoEgFX0YsP6to9rLJDxN/D3WeaklFZP6PXsxLqpIC9oVBT+SnyLYOErDuROus
	 ThxYyzYEm9Ozw==
Date: Fri, 27 Jun 2025 17:45:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, brgl@bgdev.pl, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, lukas@wunner.de,
	Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH v3] PCI/pwrctrl: Move pci_pwrctrl_create_device()
 definition to drivers/pci/pwrctrl/
Message-ID: <20250627224502.GA1687792@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616053209.13045-1-mani@kernel.org>

On Mon, Jun 16, 2025 at 11:02:09AM +0530, Manivannan Sadhasivam wrote:
> pci_pwrctrl_create_device() is a PWRCTRL framework API. So it should be
> built only when CONFIG_PWRCTRL is enabled. Currently, it is built
> independently of CONFIG_PWRCTRL. This creates enumeration failure on
> platforms like brcmstb using out-of-tree devicetree that describes the
> power supplies for endpoints in the PCIe child node, but doesn't use
> PWRCTRL framework to manage the supplies. The controller driver itself
> manages the supplies.
> 
> But in any case, the API should be built only when CONFIG_PWRCTRL is
> enabled. So move its definition to drivers/pci/pwrctrl/core.c and provide
> a stub in drivers/pci/pci.h when CONFIG_PWRCTRL is not enabled. This also
> fixes the enumeration issues on the affected platforms.

Finally circling back to this since I think brcmstb is broken since
v6.15 and we should fix it for v6.16 final.

IIUC, v3 is the current patch and needs at least a fix for the build
issue [1], and I guess the options are:

  1) Make CONFIG_PCI_PWRCTRL bool.  On my x86-64 system
     pci-pwrctrl-core.o is 8880 bytes, which seems like kind of a lot
     when only a few systems need it.

  2) Leave pci_pwrctrl_create_device() in probe.c.  It gets optimized
     away if CONFIG_OF=n because of_pci_find_child_device() returns
     NULL, but still a little ugly for readers.

  3) Put pci_pwrctrl_create_device() in a separate
     drivers/pci/pwrctrl/ file that is always compiled even if PWRCTRL
     itself is a module.  Ugly because then we sort of have two "core"
     files (core.c and whatever new file is always compiled).

And I guess all of these options still depend on CONFIG_PCI_PWRCTRL
not being enabled in a kernel that has brcmstb enabled?  If so, that
seems ugly to me.  We should be able to enable both PWRCTRL and
brcmstb at the same time, e.g., for a single kernel image that works
both on a brcmstb system and a system that needs pwrctrl.

Bjorn

[1] https://lore.kernel.org/r/202506162013.go7YyNYL-lkp@intel.com

> Fixes: 957f40d039a9 ("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()")
> Reported-by: Jim Quinlan <james.quinlan@broadcom.com>
> Closes: https://lore.kernel.org/r/CA+-6iNwgaByXEYD3j=-+H_PKAxXRU78svPMRHDKKci8AGXAUPg@mail.gmail.com
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
> 
> Changes in v3:
> 
> * Used IS_ENABLED instead of ifdef in drivers/pci/pci.h (Sathyanarayanan)
> 
> Changes in v2:
> 
> * Dropped the unused headers from probe.c (Lukas)
> 
>  drivers/pci/pci.h          |  8 ++++++++
>  drivers/pci/probe.c        | 32 --------------------------------
>  drivers/pci/pwrctrl/core.c | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 44 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 12215ee72afb..22df9e2bfda6 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1159,4 +1159,12 @@ static inline int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int inde
>  	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
>  	 PCI_CONF1_EXT_REG(reg))
>  
> +#if IS_ENABLED(CONFIG_PCI_PWRCTRL)
> +struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus,
> +						  int devfn);
> +#else
> +static inline struct platform_device *
> +pci_pwrctrl_create_device(struct pci_bus *bus, int devfn) { return NULL; }
> +#endif
> +
>  #endif /* DRIVERS_PCI_H */
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4b8693ec9e4c..478e217928a6 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -9,8 +9,6 @@
>  #include <linux/pci.h>
>  #include <linux/msi.h>
>  #include <linux/of_pci.h>
> -#include <linux/of_platform.h>
> -#include <linux/platform_device.h>
>  #include <linux/pci_hotplug.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> @@ -2508,36 +2506,6 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>  }
>  EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
>  
> -static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
> -{
> -	struct pci_host_bridge *host = pci_find_host_bridge(bus);
> -	struct platform_device *pdev;
> -	struct device_node *np;
> -
> -	np = of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
> -	if (!np || of_find_device_by_node(np))
> -		return NULL;
> -
> -	/*
> -	 * First check whether the pwrctrl device really needs to be created or
> -	 * not. This is decided based on at least one of the power supplies
> -	 * being defined in the devicetree node of the device.
> -	 */
> -	if (!of_pci_supply_present(np)) {
> -		pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
> -		return NULL;
> -	}
> -
> -	/* Now create the pwrctrl device */
> -	pdev = of_platform_device_create(np, NULL, &host->dev);
> -	if (!pdev) {
> -		pr_err("PCI/pwrctrl: Failed to create pwrctrl device for node: %s\n", np->name);
> -		return NULL;
> -	}
> -
> -	return pdev;
> -}
> -
>  /*
>   * Read the config data for a PCI device, sanity-check it,
>   * and fill in the dev structure.
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 6bdbfed584d6..20585b2c3681 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -6,11 +6,47 @@
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
>  #include <linux/pci.h>
>  #include <linux/pci-pwrctrl.h>
> +#include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
>  
> +#include "../pci.h"
> +
> +struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(bus);
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +
> +	np = of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
> +	if (!np || of_find_device_by_node(np))
> +		return NULL;
> +
> +	/*
> +	 * First check whether the pwrctrl device really needs to be created or
> +	 * not. This is decided based on at least one of the power supplies
> +	 * being defined in the devicetree node of the device.
> +	 */
> +	if (!of_pci_supply_present(np)) {
> +		pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
> +		return NULL;
> +	}
> +
> +	/* Now create the pwrctrl device */
> +	pdev = of_platform_device_create(np, NULL, &host->dev);
> +	if (!pdev) {
> +		pr_err("PCI/pwrctrl: Failed to create pwrctrl device for node: %s\n", np->name);
> +		return NULL;
> +	}
> +
> +	return pdev;
> +}
> +
>  static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
>  			      void *data)
>  {
> -- 
> 2.43.0
> 

