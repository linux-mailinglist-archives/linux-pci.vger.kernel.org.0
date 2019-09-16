Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51E32B3E4E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 18:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbfIPQAV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 12:00:21 -0400
Received: from foss.arm.com ([217.140.110.172]:46464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfIPQAV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Sep 2019 12:00:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61B9828;
        Mon, 16 Sep 2019 09:00:20 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE1493F67D;
        Mon, 16 Sep 2019 09:00:19 -0700 (PDT)
Date:   Mon, 16 Sep 2019 17:00:18 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     "Kitszel, PrzemyslawX" <przemyslawx.kitszel@intel.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Maslowski, Karol" <karol.maslowski@intel.com>
Subject: Re: [PATCH] PCI: Add quirk for VCA NTB
Message-ID: <20190916160017.GV9720@e119886-lin.cambridge.arm.com>
References: <5683A335CC8BE1438C3C30C49DCC38DF637CDE70@IRSMSX102.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5683A335CC8BE1438C3C30C49DCC38DF637CDE70@IRSMSX102.ger.corp.intel.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 13, 2019 at 12:22:38PM +0000, Kitszel, PrzemyslawX wrote:
> From 863d9ea0d888233dbfcbf52212ae97b2bc557ae6 Mon Sep 17 00:00:00 2001
> From: Slawomir Pawlowski <slawomir.pawlowski@intel.com>
> Date: Fri, 21 Sep 2018 15:55:12 +0200
> Subject: [PATCH] PCI: Add quirk for VCA NTB
> 
> Intel Visual Compute Accelerator (VCA) is a family of PCIe add-in devices
> exposing computational units via Non Transparent Bridges (NTB, PEX 87xx).
> 
> Similarly to MIC x200, there is need to add DMA aliases to allow buffer
> access when IOMMU is enabled.
> Following aliases are allowing host device and computational unit to access
> each other.
> Together those aliases marks whole VCA device as one IOMMU group.
> 
> All possible slot numbers (0x20) are used, sine we are unable to tell what

s/sine/since/g

Thanks,

Andrew Murray

> slot is used on other side.
> This quirk is intended for both host and computational unit sides.
> The VCA devices have up to 5 functions - 4 for DMA channels and one
> additional.
> 
> Signed-off-by: Slawomir Pawlowski <slawomir.pawlowski@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslawx.kitszel@intel.com>
> ---
>  drivers/pci/quirks.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ded60757a573..349ca28e0ae4 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4062,6 +4062,38 @@ static void quirk_mic_x200_dma_alias(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2260, quirk_mic_x200_dma_alias);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2264, quirk_mic_x200_dma_alias);
>  
> +/*
> + * Intel Visual Compute Accelerator (VCA) is a family of PCIe add-in devices
> + * exposing computational units via Non Transparent Bridges (NTB, PEX 87xx).
> + * Similarly to MIC x200, there is need to add DMA aliases to allow buffer
> + * access when IOMMU is enabled.
> + * Following aliases are allowing host device and computational unit to access
> + * each other. Together those aliases marks whole VCA device as one IOMMU group.
> + * All possible slot numbers (0x20) are used, sine we are unable to tell what
> + * slot is used on other side.
> + * This quirk is intended for both host and computational unit sides.
> + * The VCA devices have up to 5 functions (4 for DMA channels and 1 additional).
> + */
> +static void quirk_pex_vca_alias(struct pci_dev *pdev)
> +{
> +	const unsigned int num_pci_slots = 0x20;
> +	unsigned int slot;
> +
> +	for (slot = 0; slot < num_pci_slots; slot++) {
> +		pci_add_dma_alias(pdev, PCI_DEVFN(slot, 0x0));
> +		pci_add_dma_alias(pdev, PCI_DEVFN(slot, 0x1));
> +		pci_add_dma_alias(pdev, PCI_DEVFN(slot, 0x2));
> +		pci_add_dma_alias(pdev, PCI_DEVFN(slot, 0x3));
> +		pci_add_dma_alias(pdev, PCI_DEVFN(slot, 0x4));
> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2954, quirk_pex_vca_alias);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2955, quirk_pex_vca_alias);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2956, quirk_pex_vca_alias);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2958, quirk_pex_vca_alias);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2959, quirk_pex_vca_alias);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x295A, quirk_pex_vca_alias);
> +
>  /*
>   * The IOMMU and interrupt controller on Broadcom Vulcan/Cavium ThunderX2 are
>   * associated not at the root bus, but at a bridge below. This quirk avoids
> -- 
> 2.22.0
> 
