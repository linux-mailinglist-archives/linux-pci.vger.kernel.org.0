Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906D83E31AC
	for <lists+linux-pci@lfdr.de>; Sat,  7 Aug 2021 00:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241518AbhHFWWK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Aug 2021 18:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232178AbhHFWWJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Aug 2021 18:22:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D27F61050;
        Fri,  6 Aug 2021 22:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628288513;
        bh=UYsjy2E3yhimUFnBlBJOSfmSWLozHm9GL4oX3tbHK1g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NbRryqMgEPgafGh/mL+ZhMbNrOHEuCWrF9ePeSSFqjsuxLkMjWFhzFjmxdYevikQq
         rAnJV9eke+haJI39SXaqpltJSeWeXH9iMLscoKMLKkJEuUExlqDJmPQ30vmzo1hiXy
         Ueb5IjBL0EJXJ0iyMmiAW5QS+UZqnaHSZtZwP8DK02A6ZXrIGvXaw9gacpeKmJyme6
         7l5fQNGSA6jjEGI3x6o+1lY55u97ViLawLUupRViSsdk5xXCL32K0BeM3PziCFmdSJ
         7klPseCMxNxMZ3kLjbgVF5nnsDhaSki7sOK+G4355XbgsnCdfwo5va7slfyEu1SR9O
         ZkV58UL4JVxew==
Date:   Fri, 6 Aug 2021 17:21:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        nsaenz@kernel.org, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: brcmstb: Add ACPI config space quirk
Message-ID: <20210806222151.GA1892781@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805211200.491275-3-jeremy.linton@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 05, 2021 at 04:11:59PM -0500, Jeremy Linton wrote:
> The PFTF CM4 is an ACPI platform that is following the PCIe SMCCC
> standard because its PCIe config space isn't ECAM compliant and is
> split into two parts. One part for the root port registers and a
> moveable window which points at a given device's 4K config space.
> Thus it doesn't have a MCFG (and really any MCFG provided would be
> nonsense anyway). As Linux doesn't support the PCIe SMCCC standard
> we key off a Linux specific host bridge _DSD to add custom ECAM
> ops and cfgres. The cfg op selects between those two regions, as
> well as disallowing problematic accesses, particularly if the link
> is down because there isn't an attached device.

I'm not sure SMCCC is *really* relevant here.  If it is, an expansion
of the acronym and a link to a spec would be helpful.

But AFAICT the only important thing here is that it doesn't have
standard ECAM, and we're going to work around that.

I don't see anything about _DSD in this series.

> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/pci/controller/Makefile            |  1 +
>  drivers/pci/controller/pcie-brcmstb-acpi.c | 77 ++++++++++++++++++++++
>  include/linux/pci-ecam.h                   |  1 +
>  3 files changed, 79 insertions(+)
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
> index 000000000000..76944876155f
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-brcmstb-acpi.c
> @@ -0,0 +1,77 @@
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
> +#include <linux/pci-acpi.h>

Do we use something from pci-acpi.h?

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
> +	 * and nonstandard registers together rather than mapping them
> +	 * separately. This code simply honors the quirk provided base+size
> +	 * instead.
> +	 */
> +	iounmap(cfg->win);
> +	cfg->win = pci_remap_cfgspace(cfg->res.start, resource_size(&cfg->res));
> +	if (!cfg->win)
> +		goto err_exit;
> +
> +	/* MSI is nonstandard as well */
> +	pci_no_msi();
> +
> +	return 0;
> +err_exit:
> +	dev_err(cfg->parent, "PCI: Failed to remap config\n");
> +	return -ENOMEM;
> +}
> +
> +static void __iomem *brcm_pcie_map_conf2(struct pci_bus *bus, unsigned int devfn,
> +					int where)

Rewrap to fit in 80 columns.  81 is just ... weird :)

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
> +	/* Assure link up before sending request */
> +	up = readl(base + PCIE_MISC_PCIE_STATUS);
> +	if (!(up & PCIE_MISC_PCIE_STATUS_PCIE_DL_ACTIVE_MASK))
> +		return NULL;
> +
> +	if (!(up & PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_MASK))
> +		return NULL;

What happens if the link goes down here?  Hopefully that's a
recoverable error?

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
