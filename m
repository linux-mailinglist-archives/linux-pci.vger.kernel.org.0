Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D4FC2977
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 00:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfI3W1d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 18:27:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbfI3W1c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 18:27:32 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36EE82081B;
        Mon, 30 Sep 2019 22:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569882451;
        bh=drw2jqaygRfgFQ/qKNI7KdpkbRJVbTgoSvuGceP3BXw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=2gOfuKZkZJ5L3EUFFddykrVuc4ZDWfyFyfPMxVniDfmLHp1+27zI2IHKgNzhUO2NG
         2hO3aBRtMIJNUomJxfHTLrby0uneiFwHRlrLvqxuhqN/G6y1akkbyOI8U9bexB/otZ
         Wt01l9kgjRIugPVsS6qpDtlf8cEdmPyllgWGVmec=
Date:   Mon, 30 Sep 2019 17:27:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kitszel, PrzemyslawX" <przemyslawx.kitszel@intel.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Maslowski, Karol" <karol.maslowski@intel.com>,
        Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v2] PCI: Add quirk for VCA NTB
Message-ID: <20190930222729.GA215153@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5683A335CC8BE1438C3C30C49DCC38DF637CED8E@IRSMSX102.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 17, 2019 at 09:20:48AM +0000, Kitszel, PrzemyslawX wrote:
> From 8ec717d913bba70e3e0dd783eebf355e0d64a159 Mon Sep 17 00:00:00 2001
> From: Slawomir Pawlowski <slawomir.pawlowski@intel.com>
> Date: Fri, 21 Sep 2018 15:55:12 +0200
> Subject: [PATCH v2] PCI: Add quirk for VCA NTB
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
> All possible slot numbers (0x20) are used, since we are unable to tell what
> slot is used on other side.
> This quirk is intended for both host and computational unit sides.
> The VCA devices have up to 5 functions - 4 for DMA channels and one
> additional.
> 
> Signed-off-by: Slawomir Pawlowski <slawomir.pawlowski@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslawx.kitszel@intel.com>

Applied to pci/virtualization for v5.5, thanks!

> ---
> Changes in v2:
>   - fix typos: s/sine/since/g
> 
>  drivers/pci/quirks.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ded60757a573..921a080146f3 100644
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
> + * All possible slot numbers (0x20) are used, since we are unable to tell what
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
