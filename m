Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CDA422C8A
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 17:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbhJEPeC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 11:34:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhJEPeB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 11:34:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A61A61506;
        Tue,  5 Oct 2021 15:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633447931;
        bh=H3pKhwTklWLaDsL51TfQhZRDZK2KeR8lRiAX6OaEU6Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EFrgucdfZog0KduaFPgrblqhgreWtpb0AB1/VA1+qCFTqwOaKbeKUkmLETjUig0A9
         RmvKLqlG7mCkIirr6jt+n4Lefl1DIJZxNWsWIPJIG/NF5GAovVn5JalR1TOceiMn1v
         jFpREVWQiSh5FnftJAssB1p2O0QG9JV3CwLNl+zgiAED3ZZlZrNQWRixkrjuvtUXPZ
         6VHVKmHFWSunjhwXhM4youuxPuDpmliH029p3zOvTVETR1VWe2bQhc5jl9gCJXjdc0
         sS55UEM0tgJoC44WXUc1jtflTcqosK5tBH1F/KUEh4vU8U+yLidIw/4fRbg39NKRtK
         8ctmZlWFdp3UQ==
Date:   Tue, 5 Oct 2021 10:32:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        nsaenz@kernel.org, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] PCI: brcmstb: Add ACPI config space quirk
Message-ID: <20211005153209.GA1083986@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826071557.29239-3-jeremy.linton@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 26, 2021 at 02:15:55AM -0500, Jeremy Linton wrote:
> The Pi Firmware Task Force (PFTF: https://github.com/pftf) Compute
> Module 4 (CM4: an embedded form factor RPi4) is an ACPI platform that
> isn't ECAM compliant. Its config space is in two parts. One part is for
> the root port registers and a second moveable window pointing at a
> device's 4K config space. Thus it doesn't have an MCFG, and any MCFG
> provided would be nonsense anyway.
> 
> Instead, a custom pci_ecam_ops quirk is created. The custom ops override
> the .init and .map_bus functions. The former to assure that cfg->win
> points at a single mapping that contains the root port registers and the
> device config window, as well as disabling MSIs due to lack of a
> GICv2M. map_bus() then provides the address of either the standard
> portion of the root port registers or to the device config window after
> it has been moved.
> 
> Additionally, some basic bus/device filtering exist to avoid sending
> config transactions to invalid devices on the RP's primary or
> secondary bus. A basic link check is also made to assure that
> something is operational on the secondary side before probing the
> remainder of the config space. If either of these constraints are
> violated and a config operation is lost in the ether because an EP
> doesn't respond an unrecoverable SERROR is raised.

It's not "lost"; I assume the root port raises an error because it
can't send a transaction over a link that is down.

Is "SERROR" an ARM64 thing?  My guess is the root port would raise an
Unsupported Request error or similar, and the root complex turns that
into a system-specific SERROR?

> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/controller/Makefile            |  1 +
>  drivers/pci/controller/pcie-brcmstb-acpi.c | 79 ++++++++++++++++++++++
>  include/linux/pci-ecam.h                   |  1 +
>  3 files changed, 81 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-brcmstb-acpi.c
> 
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index aaf30b3dcc14..65aa6fd3ed89 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -57,5 +57,6 @@ ifdef CONFIG_PCI_QUIRKS
>  obj-$(CONFIG_ARM64) += pci-thunder-ecam.o
>  obj-$(CONFIG_ARM64) += pci-thunder-pem.o
>  obj-$(CONFIG_ARM64) += pci-xgene.o
> +obj-$(CONFIG_ARM64) += pcie-brcmstb-acpi.o
>  endif
>  endif
> diff --git a/drivers/pci/controller/pcie-brcmstb-acpi.c b/drivers/pci/controller/pcie-brcmstb-acpi.c
> new file mode 100644
> index 000000000000..528b2b3ffbd2
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-brcmstb-acpi.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * ACPI quirks for Brcm2711 PCIe host controller
> + * As used on the Raspberry Pi Compute Module 4
> + *
> + * Copyright (C) 2021 Arm Ltd.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/pci.h>
> +#include <linux/pci-ecam.h>
> +#include "../pci.h"
> +#include "pcie-brcmstb.h"
> +
> +static int brcm_acpi_init(struct pci_config_window *cfg)
> +{
> +	/*
> +	 * This platform doesn't technically have anything that could be called
> +	 * ECAM. Its config region has root port specific registers between
> +	 * standard PCIe defined config registers. Thus the region setup by the
> +	 * generic ECAM code needs to be adjusted. The HW can access bus 0-ff
> +	 * but the footprint isn't a nice power of 2 (40k). For purposes of
> +	 * mapping the config region we are just going to squash the standard
> +	 * and nonstandard registers together rather than mapping them separately.

Wrap this and comment below to fit in 80 columns.  Nothing magic about
80 columns except for the fact that all the other code in drivers/pci
fits in that width and consistency is helpful.

> +	 */
> +	iounmap(cfg->win);
> +	cfg->win = pci_remap_cfgspace(cfg->res.start, resource_size(&cfg->res));
> +	if (!cfg->win)
> +		goto err_exit;
> +
> +	/* MSI is nonstandard as well */
> +	pci_no_msi();

This doesn't seem to fit in an MCFG quirk.

> +	return 0;
> +err_exit:
> +	dev_err(cfg->parent, "PCI: Failed to remap config\n");
> +	return -ENOMEM;
> +}
> +
> +static void __iomem *brcm_pcie_map_conf2(struct pci_bus *bus,
> +					unsigned int devfn, int where)
> +{
> +	struct pci_config_window *cfg = bus->sysdata;
> +	void __iomem *base = cfg->win;
> +	int idx;
> +	u32 up;
> +
> +	/* Accesses to the RC go right to the RC registers if slot==0 */
> +	if (pci_is_root_bus(bus))
> +		return PCI_SLOT(devfn) ? NULL : base + where;
> +
> +	/*
> +	 * Assure the link is up before sending requests downstream. This is done
> +	 * to avoid sending transactions to EPs that don't exist. Link flap
> +	 * conditions/etc make this race more probable. The resulting unrecoverable
> +	 * SERRORs will result in the machine crashing.

Is the crash because SERROR is fundamentally unrecoverable?  Is there
any control over what kind of system-specific error the PCIe errors
are mapped to?

I know there are other systems where PCIe errors always cause a system
crash, but most platforms seem to be moving toward at least the
theoretical ability to recover from I/O errors.

> +	 */
> +	up = readl(base + PCIE_MISC_PCIE_STATUS);
> +	if (!(up & PCIE_MISC_PCIE_STATUS_PCIE_DL_ACTIVE_MASK))
> +		return NULL;
> +
> +	if (!(up & PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_MASK))
> +		return NULL;
> +
> +	/* For devices, write to the config space index register */
> +	idx = PCIE_ECAM_OFFSET(bus->number, devfn, 0);
> +	writel(idx, base + PCIE_EXT_CFG_INDEX);
> +	return base + PCIE_EXT_CFG_DATA + where;
> +}
> +
> +const struct pci_ecam_ops bcm2711_pcie_ops = {
> +	.init		= brcm_acpi_init,
> +	.bus_shift	= 1,
> +	.pci_ops	= {
> +		.map_bus	= brcm_pcie_map_conf2,
> +		.read		= pci_generic_config_read,
> +		.write		= pci_generic_config_write,
> +	}
> +};
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index adea5a4771cf..a5de0285bb7f 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -87,6 +87,7 @@ extern const struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene PCIe v1 *
>  extern const struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe v2.x */
>  extern const struct pci_ecam_ops al_pcie_ops;	/* Amazon Annapurna Labs PCIe */
>  extern const struct pci_ecam_ops tegra194_pcie_ops; /* Tegra194 PCIe */
> +extern const struct pci_ecam_ops bcm2711_pcie_ops; /* Bcm2711 PCIe */
>  #endif
>  
>  #if IS_ENABLED(CONFIG_PCI_HOST_COMMON)
> -- 
> 2.31.1
> 
