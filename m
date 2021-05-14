Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33255380C8F
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 17:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhENPLs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 11:11:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhENPLs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 May 2021 11:11:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47E7761350;
        Fri, 14 May 2021 15:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621005036;
        bh=sqIUVE17wY0syd+Dj7WFOoITeL+puoY14vmGlaLRpNc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eWMWADisHM94UXXfqbvvJrS71clY9wtexOZ4yYVbISukxOb953gfJgwrwV3CxKb7u
         EacUdy6lDm8mWBcB+4o9rnKOiEiWNumb9O51lN0OSaadkvKvwh7GJngORtH9GdXn2c
         dGtfMSXq2Y8sj1ak0o1w9rM6Qvk94JOSKsYT8xNlY88cciv9AIp1LscMq/u1nBQJTd
         hGYLkO8h2fVzCITXcwAWnR+2I6ZuFqfUHIb/SBN91uI4Lv77/bKolLhiMcRpzylw1X
         UsXCgUAK2euJozR+oNeYSO9FMO5HIwWVuiH7kW0l0IU/KHTjjJjt2zIHn9J4iRU+WO
         fm198i/dHsWgQ==
Date:   Fri, 14 May 2021 10:10:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jingfeng Sui <suijingfeng@loongson.cn>
Subject: Re: [PATCH 5/5] PCI: Support ASpeed VGA cards behind a misbehaving
 bridge
Message-ID: <20210514151034.GA2759806@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514080025.1828197-6-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 14, 2021 at 04:00:25PM +0800, Huacai Chen wrote:
> According to PCI-to-PCI bridge spec, bit 3 of Bridge Control Register is
> VGA Enable bit which modifies the response to VGA compatible addresses.

The bridge spec is pretty old, and most of the content has been
incorporated into the PCIe spec.  I think you can cite "PCIe r5.0, sec
7.5.1.3.13" here instead.

> If the VGA Enable bit is set, the bridge will decode and forward the
> following accesses on the primary interface to the secondary interface.

*Which* following accesses?  The structure of English requires that if
you say "the following accesses," you must continue by *listing* the
accesses.

> The ASpeed AST2500 hardward does not set the VGA Enable bit on its
> bridge control register, which causes vgaarb subsystem don't think the
> VGA card behind the bridge as a valid boot vga device.

s/hardward/bridge/
s/vga/VGA/ (also in code comments and dmesg strings below)

From the code, it looks like AST2500 ([1a03:2000]) is a VGA device,
since it apparently has a VGA class code.  But here you say the
AST2500 has a Bridge Control register, which suggests that it's a
bridge.  If AST2500 is some sort of combination that includes both a
bridge and a VGA device, please outline that topology.

But the hardware defect is that some bridges forward VGA accesses even
though their VGA Enable bit is not set?  The quirk should be attached
to broken *bridges*, not to VGA devices.

If a bridge forwards VGA accesses regardless of how its VGA Enable bit
is set, that means VGA arbitration (in vgaarb.c) cannot work
correctly, so merely setting the default VGA device once in a quirk is
not sufficient.  You would have to somehow disable any future attempts
to use other VGA devices.  Only the VGA device below this defective
bridge is usable.  Any other VGA devices in the system would be
useless.

> So we provide a quirk to fix Xorg auto-detection.
> 
> See similar bug:
> 
> https://patchwork.kernel.org/project/linux-pci/patch/20170619023528.11532-1-dja@axtens.net/

This patch was never merged.  If we merged a revised version, please
cite the SHA1 instead.

> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Jingfeng Sui <suijingfeng@loongson.cn>
> ---
>  drivers/pci/quirks.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 6ab4b3bba36b..adf5490706ad 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -28,6 +28,7 @@
>  #include <linux/platform_data/x86/apple.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/switchtec.h>
> +#include <linux/vgaarb.h>
>  #include <asm/dma.h>	/* isa_dma_bridge_buggy */
>  #include "pci.h"
>  
> @@ -297,6 +298,52 @@ static void loongson_mrrs_quirk(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
>  
> +
> +static void aspeed_fixup_vgaarb(struct pci_dev *pdev)
> +{
> +	struct pci_dev *bridge;
> +	struct pci_bus *bus;
> +	struct pci_dev *vdevp = NULL;
> +	u16 config;
> +
> +	bus = pdev->bus;
> +	bridge = bus->self;
> +
> +	/* Is VGA routed to us? */
> +	if (bridge && (pci_is_bridge(bridge))) {
> +		pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &config);
> +
> +		/* Yes, this bridge is PCI bridge-to-bridge spec compliant,
> +		 *  just return!
> +		 */
> +		if (config & PCI_BRIDGE_CTL_VGA)
> +			return;
> +
> +		dev_warn(&pdev->dev, "VGA bridge control is not enabled\n");
> +	}

You cannot assume that a bridge is defective just because
PCI_BRIDGE_CTL_VGA is not set.

> +	/* Just return if the system already have a default device */
> +	if (vga_default_device())
> +		return;
> +
> +	/* No default vga device */
> +	while ((vdevp = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, vdevp))) {
> +		if (vdevp->vendor != 0x1a03) {
> +			/* Have other vga devcie in the system, do nothing */
> +			dev_info(&pdev->dev, "Another boot vga device: 0x%x:0x%x\n",
> +				vdevp->vendor, vdevp->device);
> +			return;
> +		}
> +	}
> +
> +	vga_set_default_device(pdev);
> +
> +	dev_info(&pdev->dev, "Boot vga device set as 0x%x:0x%x\n",
> +			pdev->vendor, pdev->device);
> +}
> +DECLARE_PCI_FIXUP_CLASS_FINAL(0x1a03, 0x2000, PCI_CLASS_DISPLAY_VGA, 8, aspeed_fixup_vgaarb);
> +
> +
>  /*
>   * The Mellanox Tavor device gives false positive parity errors.  Disable
>   * parity error reporting.
> -- 
> 2.27.0
> 
