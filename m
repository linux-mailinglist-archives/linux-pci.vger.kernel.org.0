Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10D684AB31
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 21:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfFRTsg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 15:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730176AbfFRTsf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Jun 2019 15:48:35 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0A5F206E0;
        Tue, 18 Jun 2019 19:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560887314;
        bh=B+P3EIUfBOoeviB9x7VEMBkgJuOvE5XAkLXgLqXgA1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d4aa/HY3/uH51bmvZBqzTIu09V5+HGoAigLH5I1623wc4xfpXh2MoiaiNUSAwpnj6
         zRjfudgEhpNOEJI5ndiRQtB+LNX2PfCB3UfJPSWUtv0sFrCigj1HorhtNz8CoB9NZu
         135PY4ZSiiSgFSk95kmQcQGjwDkbVwFjQbOfsHQQ=
Date:   Tue, 18 Jun 2019 14:48:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V6 20/27] PCI: tegra: Disable MSI for Tegra PCIe root port
Message-ID: <20190618194830.GA110859@google.com>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
 <20190618180206.4908-21-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618180206.4908-21-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 18, 2019 at 11:31:59PM +0530, Manikanta Maddireddy wrote:
> Tegra PCIe generates PME and AER events over legacy interrupt line. Disable
> MSI to avoid service drivers registering interrupt routine over MSI IRQ
> line.
> 
> PME and AER interrupts registered to MSI without this change,
> cat /proc/interrupts | grep -i pci
> 36: 21 0 0 0 0 0 GICv2 104 Level       PCIE
> 37: 35 0 0 0 0 0 GICv2 105 Level       Tegra PCIe MSI
> 76: 0  0 0 0 0 0 Tegra PCIe MSI 0 Edge PCIe PME, aerdrv, PCIe BW notif
> 
> PME and AER interrupts registered to legacy IRQ with this change,
> cat /proc/interrupts | grep -i pci
> 36: 33 0 0 0 0 0 GICv2 104 Level      PCIE, PCIe PME, aerdrv, PCIe BW notif
> 37: 52 0 0 0 0 0 GICv2 105 Level      Tegra PCIe MSI
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V6: Replaced pcie_pme_disable_msi() with no_msi quirk
> 
> V5: No change
> 
> V4: No change
> 
> V3: Corrected typo in commit log
> 
> V2: No change
> 
>  drivers/pci/quirks.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index a59ad09ce911..20dcad421991 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2576,6 +2576,45 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
>  			PCI_DEVICE_ID_NVIDIA_NVENET_15,
>  			nvenet_msi_disable);
>  
> +/*
> + * Tegra PCIe generates PME and AER events over legacy interrupt line.
> + * So disable msi for Tegra PCIe root ports.

s/msi/MSI/

What's going on here?  Vidya posted a very similar patch [1] (although
his included nice spec citations, which you omitted), but his added
quirks for 0x1ad0, 0x1ad1, and 0x1ad2.  You didn't include any of
those here.

Maybe Lorenzo will sort this all out, but it would make things easier
if you and Vidya got together and integrated your patches yourselves
so Lorenzo didn't have to worry about it.

[1] https://lore.kernel.org/lkml/20190612095339.20118-3-vidyas@nvidia.com

> + */
> +static void pci_quirk_nvidia_tegra_disable_rp_msi(struct pci_dev *dev)
> +{
> +	dev->no_msi = 1;
> +}
> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf0,
> +			      PCI_CLASS_BRIDGE_PCI, 8,
> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf1,
> +			      PCI_CLASS_BRIDGE_PCI, 8,
> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1c,
> +			      PCI_CLASS_BRIDGE_PCI, 8,
> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1d,
> +			      PCI_CLASS_BRIDGE_PCI, 8,
> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e12,
> +			      PCI_CLASS_BRIDGE_PCI, 8,
> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e13,
> +			      PCI_CLASS_BRIDGE_PCI, 8,
> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0fae,
> +			      PCI_CLASS_BRIDGE_PCI, 8,
> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0faf,
> +			      PCI_CLASS_BRIDGE_PCI, 8,
> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x10e5,
> +			      PCI_CLASS_BRIDGE_PCI, 8,
> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x10e6,
> +			      PCI_CLASS_BRIDGE_PCI, 8,
> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
> +
>  /*
>   * Some versions of the MCP55 bridge from Nvidia have a legacy IRQ routing
>   * config register.  This register controls the routing of legacy
> -- 
> 2.17.1
> 
