Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060A039CB23
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jun 2021 23:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhFEVRU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Jun 2021 17:17:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhFEVRU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Jun 2021 17:17:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63C246138C;
        Sat,  5 Jun 2021 21:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622927731;
        bh=Zsr65MFw+GKpFwPBz1qIIPrramPqzvT+hq8OpA/dsw8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PpQkexKXL/HrnTJKDSxtaqT/wuScq4lBKN00VPLB4GQS5Hd78Pno7tx8Hn1dUbUke
         9ADly4qYdfE4xM6qq15vV0OlkGKuLKOqRzamE3sctih8AHhXmQS8+kFtaUnxeo9BRG
         SkVGp958M2kqkbUF2wXCW5bGL7Awaz/Lc41moXdFgMydn15rgT2ug3029gUQf1ovqB
         ls9K+w9se/B02XNEX7OoCKGQXaSJjy4YQ/5ZEp5tT2QRpfi+j+1RdW1j3w7lmo2Ft7
         +WJoy2w77K1AfEdYtRafzSG5KZLZX7KNUtMoXCG3l+1EYQSPMZhv8O4ZjkGebN74AG
         /+zjiqT498HgA==
Date:   Sat, 5 Jun 2021 16:15:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V2 2/4] PCI: Move loongson pci quirks to quirks.c
Message-ID: <20210605211529.GA2326325@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528071503.1444680-3-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 28, 2021 at 03:15:01PM +0800, Huacai Chen wrote:
> Loongson PCH (LS7A chipset) will be used by both MIPS-based and
> LoongArch-based Loongson processors. MIPS-based Loongson uses FDT
> but LoongArch-base Loongson uses ACPI, but the driver in drivers/
> pci/controller/pci-loongson.c is FDT-only. So move the quirks to
> quirks.c where can be shared by all architectures.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/pci/controller/pci-loongson.c | 69 ---------------------------
>  drivers/pci/quirks.c                  | 69 +++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 48169b1e3817..88066e9db69e 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -12,15 +12,6 @@
>  
>  #include "../pci.h"
>  
> -/* Device IDs */
> -#define DEV_PCIE_PORT_0	0x7a09
> -#define DEV_PCIE_PORT_1	0x7a19
> -#define DEV_PCIE_PORT_2	0x7a29
> -
> -#define DEV_LS2K_APB	0x7a02
> -#define DEV_LS7A_CONF	0x7a10
> -#define DEV_LS7A_LPC	0x7a0c
> -
>  #define FLAG_CFG0	BIT(0)
>  #define FLAG_CFG1	BIT(1)
>  #define FLAG_DEV_FIX	BIT(2)
> @@ -32,66 +23,6 @@ struct loongson_pci {
>  	u32 flags;
>  };
>  
> -/* Fixup wrong class code in PCIe bridges */
> -static void bridge_class_quirk(struct pci_dev *dev)
> -{
> -	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> -}
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> -			DEV_PCIE_PORT_0, bridge_class_quirk);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> -			DEV_PCIE_PORT_1, bridge_class_quirk);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> -			DEV_PCIE_PORT_2, bridge_class_quirk);
> -
> -static void system_bus_quirk(struct pci_dev *pdev)
> -{
> -	/*
> -	 * The address space consumed by these devices is outside the
> -	 * resources of the host bridge.
> -	 */
> -	pdev->mmio_always_on = 1;
> -	pdev->non_compliant_bars = 1;
> -}
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> -			DEV_LS2K_APB, system_bus_quirk);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> -			DEV_LS7A_CONF, system_bus_quirk);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> -			DEV_LS7A_LPC, system_bus_quirk);
> -
> -static void loongson_mrrs_quirk(struct pci_dev *dev)
> -{
> -	struct pci_bus *bus = dev->bus;
> -	struct pci_dev *bridge;
> -	static const struct pci_device_id bridge_devids[] = {
> -		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
> -		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
> -		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
> -		{ 0, },
> -	};
> -
> -	/* look for the matching bridge */
> -	while (!pci_is_root_bus(bus)) {
> -		bridge = bus->self;
> -		bus = bus->parent;
> -		/*
> -		 * Some Loongson PCIe ports have a h/w limitation of
> -		 * 256 bytes maximum read request size. They can't handle
> -		 * anything larger than this. So force this limit on
> -		 * any devices attached under these ports.
> -		 */
> -		if (pci_match_id(bridge_devids, bridge)) {
> -			if (pcie_get_readrq(dev) > 256) {
> -				pci_info(dev, "limiting MRRS to 256\n");
> -				pcie_set_readrq(dev, 256);
> -			}
> -			break;
> -		}
> -	}
> -}
> -DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
> -
>  static void __iomem *cfg1_map(struct loongson_pci *priv, int bus,
>  				unsigned int devfn, int where)
>  {
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index dcb229de1acb..66e4bea69431 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -205,6 +205,75 @@ static void quirk_mmio_always_on(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_ANY_ID, PCI_ANY_ID,
>  				PCI_CLASS_BRIDGE_HOST, 8, quirk_mmio_always_on);
>  
> +/* Loongson-related quirks */
> +#define DEV_PCIE_PORT_0	0x7a09
> +#define DEV_PCIE_PORT_1	0x7a19
> +#define DEV_PCIE_PORT_2	0x7a29
> +
> +#define DEV_LS2K_APB	0x7a02
> +#define DEV_LS7A_CONF	0x7a10
> +#define DEV_LS7A_LPC	0x7a0c

If you're moving these from device-specific file to a generic file,
these #defines now need to have device-specific names.

But these appear to be for built-in hardware that can only be present
in Loongson (I assume mips?) systems.  If that's the case, maybe they
should go to a mips-specific file like arch/mips/pci/quirks.c?

But I see you see you mention LoongArch above, so I don't know if
that's part of arch/mips, or if there's an arch/loongson coming, or
what.

> +/* Fixup wrong class code in PCIe bridges */
> +static void loongson_bridge_class_quirk(struct pci_dev *dev)
> +{
> +	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_0, loongson_bridge_class_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_1, loongson_bridge_class_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_2, loongson_bridge_class_quirk);
> +
> +static void loongson_system_bus_quirk(struct pci_dev *pdev)
> +{
> +	/*
> +	 * The address space consumed by these devices is outside the
> +	 * resources of the host bridge.
> +	 */
> +	pdev->mmio_always_on = 1;
> +	pdev->non_compliant_bars = 1;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_LS2K_APB, loongson_system_bus_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_LS7A_CONF, loongson_system_bus_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_LS7A_LPC, loongson_system_bus_quirk);
> +
> +static void loongson_mrrs_quirk(struct pci_dev *dev)
> +{
> +	struct pci_bus *bus = dev->bus;
> +	struct pci_dev *bridge;
> +	static const struct pci_device_id bridge_devids[] = {
> +		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
> +		{ 0, },
> +	};
> +
> +	/* look for the matching bridge */
> +	while (!pci_is_root_bus(bus)) {
> +		bridge = bus->self;
> +		bus = bus->parent;
> +		/*
> +		 * Some Loongson PCIe ports have a h/w limitation of
> +		 * 256 bytes maximum read request size. They can't handle
> +		 * anything larger than this. So force this limit on
> +		 * any devices attached under these ports.
> +		 */
> +		if (pci_match_id(bridge_devids, bridge)) {
> +			if (pcie_get_readrq(dev) > 256) {
> +				pci_info(dev, "limiting MRRS to 256\n");
> +				pcie_set_readrq(dev, 256);
> +			}
> +			break;
> +		}
> +	}
> +}
> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
> +
>  /*
>   * The Mellanox Tavor device gives false positive parity errors.  Disable
>   * parity error reporting.
> -- 
> 2.27.0
> 
