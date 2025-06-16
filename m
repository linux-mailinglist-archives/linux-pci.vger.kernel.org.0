Return-Path: <linux-pci+bounces-29830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C5CADA740
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 06:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F5A3B0980
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 04:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CA319005E;
	Mon, 16 Jun 2025 04:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWx4OYEm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE677262B;
	Mon, 16 Jun 2025 04:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750049293; cv=none; b=EOL21ogNHa3P95cd0BfYfwTRnNQb1IDgrunpNw5TsQwwxpFX7dataA1nSuG134pI6ged+BQIkx/eN6wF0RAcDTXXdJxjrDZmq8ZB/Yb2ClFNVq3dCFQd/tTQgbpOmOzcKj8x7JCXdKbG5la+0FX29xZ5dggqrH0T01yN7rhIWEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750049293; c=relaxed/simple;
	bh=n2sOXBLK6AXbeesX4JomxJLun5vDwhepApFXQMOOX/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4g2r2DTvZcR9M1nnBHi626lnQOGsXbcvptShjB95+y7RXldQX37gwNUknB1xJbwGxkBoa4cb9ox41hsq8TcNx1gv4pzqj0KYqYFDRjtTh+4MaJSjv2OkeWpqV5etA7L5//7XmTV9LGScq6bFLfkd5tQ/GhHbteHylz10b5bFV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWx4OYEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FCCC4CEEA;
	Mon, 16 Jun 2025 04:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750049292;
	bh=n2sOXBLK6AXbeesX4JomxJLun5vDwhepApFXQMOOX/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gWx4OYEmsfT/0AeT/wZywOnS9ksanf0snac+THUIMULQmauZLlNcokUxINbTaCuco
	 WRqgOrMP9oEqwk/lk+MY9Y3aF6xVNev3t/afq53yswH+UgM5/vxIgmjOdJMOoVKAs7
	 o6rk0DcEhG2V28E/hjjGBGynRwEJ0IuY33A5ggyHI/qHUXI56JGsUPva5BkOUljGTe
	 42peYU1WhttYdJPmVG8siBy9izDNc/wiP+vEyBfcW8Y/j11vvCphId/rlsNA9zYN91
	 OPC8/T9sbSXUDSWFpRDBwOD3U+6JdzONuYpV4uPEaCPh8xiQ/UiKwUzhyqeJYjSxXY
	 xxYtDRoNtg7RQ==
Date: Mon, 16 Jun 2025 10:17:59 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: bhelgaas@google.com, brgl@bgdev.pl, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lukas@wunner.de, Jim Quinlan <james.quinlan@broadcom.com>, 
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2] PCI/pwrctrl: Move pci_pwrctrl_create_device()
 definition to drivers/pci/pwrctrl/
Message-ID: <i3zosvjotv2cmlfay63rk2xigsn2264kltcexxcb77oeogo3sb@lk5oytftpas2>
References: <20250614112009.6478-1-mani@kernel.org>
 <0442f060-1e8b-469a-a700-c96d18d5b737@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0442f060-1e8b-469a-a700-c96d18d5b737@linux.intel.com>

On Sun, Jun 15, 2025 at 12:25:38AM -0700, Sathyanarayanan Kuppuswamy wrote:
> 
> On 6/14/25 4:20 AM, Manivannan Sadhasivam wrote:
> > pci_pwrctrl_create_device() is a PWRCTRL framework API. So it should be
> > built only when CONFIG_PWRCTRL is enabled. Currently, it is built
> > independently of CONFIG_PWRCTRL. This creates enumeration failure on
> > platforms like brcmstb using out-of-tree devicetree that describes the
> > power supplies for endpoints in the PCIe child node, but doesn't use
> > PWRCTRL framework to manage the supplies. The controller driver itself
> > manages the supplies.
> > 
> > But in any case, the API should be built only when CONFIG_PWRCTRL is
> > enabled. So move its definition to drivers/pci/pwrctrl/core.c and provide
> > a stub in drivers/pci/pci.h when CONFIG_PWRCTRL is not enabled. This also
> > fixes the enumeration issues on the affected platforms.
> > 
> > Fixes: 957f40d039a9 ("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()")
> > Reported-by: Jim Quinlan <james.quinlan@broadcom.com>
> > Closes: https://lore.kernel.org/r/CA+-6iNwgaByXEYD3j=-+H_PKAxXRU78svPMRHDKKci8AGXAUPg@mail.gmail.com
> > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> > ---
> > 
> > Changes in v2:
> > 
> > * Dropped the unused headers from probe.c (Lukas)
> > 
> >   drivers/pci/pci.h          |  8 ++++++++
> >   drivers/pci/probe.c        | 32 --------------------------------
> >   drivers/pci/pwrctrl/core.c | 36 ++++++++++++++++++++++++++++++++++++
> >   3 files changed, 44 insertions(+), 32 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 12215ee72afb..c5efd8b9c96a 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -1159,4 +1159,12 @@ static inline int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int inde
> >   	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
> >   	 PCI_CONF1_EXT_REG(reg))
> > +#ifdef CONFIG_PCI_PWRCTRL
> 
> Use IS_ENABLED?
> 

Yes, thanks for pointing it out. I should've never used ifdef here.

- Mani

> > +struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus,
> > +						  int devfn);
> > +#else
> > +static inline struct platform_device *
> > +pci_pwrctrl_create_device(struct pci_bus *bus, int devfn) { return NULL; }
> > +#endif
> > +
> >   #endif /* DRIVERS_PCI_H */
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 4b8693ec9e4c..478e217928a6 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -9,8 +9,6 @@
> >   #include <linux/pci.h>
> >   #include <linux/msi.h>
> >   #include <linux/of_pci.h>
> > -#include <linux/of_platform.h>
> > -#include <linux/platform_device.h>
> >   #include <linux/pci_hotplug.h>
> >   #include <linux/slab.h>
> >   #include <linux/module.h>
> > @@ -2508,36 +2506,6 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
> >   }
> >   EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
> > -static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
> > -{
> > -	struct pci_host_bridge *host = pci_find_host_bridge(bus);
> > -	struct platform_device *pdev;
> > -	struct device_node *np;
> > -
> > -	np = of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
> > -	if (!np || of_find_device_by_node(np))
> > -		return NULL;
> > -
> > -	/*
> > -	 * First check whether the pwrctrl device really needs to be created or
> > -	 * not. This is decided based on at least one of the power supplies
> > -	 * being defined in the devicetree node of the device.
> > -	 */
> > -	if (!of_pci_supply_present(np)) {
> > -		pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
> > -		return NULL;
> > -	}
> > -
> > -	/* Now create the pwrctrl device */
> > -	pdev = of_platform_device_create(np, NULL, &host->dev);
> > -	if (!pdev) {
> > -		pr_err("PCI/pwrctrl: Failed to create pwrctrl device for node: %s\n", np->name);
> > -		return NULL;
> > -	}
> > -
> > -	return pdev;
> > -}
> > -
> >   /*
> >    * Read the config data for a PCI device, sanity-check it,
> >    * and fill in the dev structure.
> > diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> > index 6bdbfed584d6..20585b2c3681 100644
> > --- a/drivers/pci/pwrctrl/core.c
> > +++ b/drivers/pci/pwrctrl/core.c
> > @@ -6,11 +6,47 @@
> >   #include <linux/device.h>
> >   #include <linux/export.h>
> >   #include <linux/kernel.h>
> > +#include <linux/of.h>
> > +#include <linux/of_pci.h>
> > +#include <linux/of_platform.h>
> >   #include <linux/pci.h>
> >   #include <linux/pci-pwrctrl.h>
> > +#include <linux/platform_device.h>
> >   #include <linux/property.h>
> >   #include <linux/slab.h>
> > +#include "../pci.h"
> > +
> > +struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
> > +{
> > +	struct pci_host_bridge *host = pci_find_host_bridge(bus);
> > +	struct platform_device *pdev;
> > +	struct device_node *np;
> > +
> > +	np = of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
> > +	if (!np || of_find_device_by_node(np))
> > +		return NULL;
> > +
> > +	/*
> > +	 * First check whether the pwrctrl device really needs to be created or
> > +	 * not. This is decided based on at least one of the power supplies
> > +	 * being defined in the devicetree node of the device.
> > +	 */
> > +	if (!of_pci_supply_present(np)) {
> > +		pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
> > +		return NULL;
> > +	}
> > +
> > +	/* Now create the pwrctrl device */
> > +	pdev = of_platform_device_create(np, NULL, &host->dev);
> > +	if (!pdev) {
> > +		pr_err("PCI/pwrctrl: Failed to create pwrctrl device for node: %s\n", np->name);
> > +		return NULL;
> > +	}
> > +
> > +	return pdev;
> > +}
> > +
> >   static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
> >   			      void *data)
> >   {
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
> 

-- 
மணிவண்ணன் சதாசிவம்

