Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844187D596F
	for <lists+linux-pci@lfdr.de>; Tue, 24 Oct 2023 19:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344020AbjJXRIb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Oct 2023 13:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344034AbjJXRIa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Oct 2023 13:08:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DE4118;
        Tue, 24 Oct 2023 10:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698167305; x=1729703305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hUGirVag7S8n+zT+Bt5TDAK/SLrrk9OVdLzyMdWj1BM=;
  b=MK0rHJbLLv/T5s/Xh7JJJg0HxouXOgh6hV+Tv8dzO0kjvhQ3DvGVXTCw
   2V0Jel9mU1SFM2FcBkrblU+HU/VjodqXH3/KzqDqzejMGjb9zBQa54O+3
   cOrSot/OYcEbMDHZFOTeZD0aQ5Bd/t+I9UYLrxsIlZNQG9Bcbhfym8hQ2
   4QIN0Id3JeSLbaNKMdLB/rSUSF1e25uMGk8sEsLy/Z7Z5tcnYk67nxLQI
   s+3QzNxHqs6ZeYuGr1vJOhdbruYg8B6UXePPdGyJHGRp2S0ExyuDTftSt
   ta9cFGaKdzFpqX/AkvBFThLi3yZIL/OEJMv/3HKVRkbv2R7YwTisKtc4/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="5740573"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="5740573"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 10:08:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="758546619"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="758546619"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga002.jf.intel.com with SMTP; 24 Oct 2023 10:08:16 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 24 Oct 2023 20:08:16 +0300
Date:   Tue, 24 Oct 2023 20:08:16 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH V2] PCI: Move VMD ASPM/LTR fix to PCI quirk
Message-ID: <ZTf6ALl3xNvhLN6M@intel.com>
References: <20230411213323.1362300-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411213323.1362300-1-david.e.box@linux.intel.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 11, 2023 at 02:33:23PM -0700, David E. Box wrote:
> In commit f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and
> LTR") the VMD driver calls pci_enabled_link_state as a callback from
> pci_bus_walk. Both will acquire the pci_bus_sem lock leading to a lockdep
> warning. Instead of doing the pci_bus_walk, move the fix to quirks.c using
> DECLARE_PCI_FIXUP_FINAL.

What happened to this patch? We're still carrying a local fix
for this in drm-tip...

> 
> Fixes: f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR")
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> 
> V2 - Instead of adding a lock flag argument to pci_enabled_link_state, move
>      the fix to quirks.c
> 
>  drivers/pci/controller/vmd.c | 55 +--------------------------
>  drivers/pci/quirks.c         | 72 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 990630ec57c6..47fa3e5f2dc5 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -66,22 +66,11 @@ enum vmd_features {
>  	 * interrupt handling.
>  	 */
>  	VMD_FEAT_CAN_BYPASS_MSI_REMAP		= (1 << 4),
> -
> -	/*
> -	 * Enable ASPM on the PCIE root ports and set the default LTR of the
> -	 * storage devices on platforms where these values are not configured by
> -	 * BIOS. This is needed for laptops, which require these settings for
> -	 * proper power management of the SoC.
> -	 */
> -	VMD_FEAT_BIOS_PM_QUIRK		= (1 << 5),
>  };
>  
> -#define VMD_BIOS_PM_QUIRK_LTR	0x1003	/* 3145728 ns */
> -
>  #define VMD_FEATS_CLIENT	(VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |	\
>  				 VMD_FEAT_HAS_BUS_RESTRICTIONS |	\
> -				 VMD_FEAT_OFFSET_FIRST_VECTOR |		\
> -				 VMD_FEAT_BIOS_PM_QUIRK)
> +				 VMD_FEAT_OFFSET_FIRST_VECTOR)
>  
>  static DEFINE_IDA(vmd_instance_ida);
>  
> @@ -724,46 +713,6 @@ static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
>  	vmd_bridge->native_dpc = root_bridge->native_dpc;
>  }
>  
> -/*
> - * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
> - */
> -static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
> -{
> -	unsigned long features = *(unsigned long *)userdata;
> -	u16 ltr = VMD_BIOS_PM_QUIRK_LTR;
> -	u32 ltr_reg;
> -	int pos;
> -
> -	if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
> -		return 0;
> -
> -	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
> -
> -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
> -	if (!pos)
> -		return 0;
> -
> -	/*
> -	 * Skip if the max snoop LTR is non-zero, indicating BIOS has set it
> -	 * so the LTR quirk is not needed.
> -	 */
> -	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg);
> -	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
> -		return 0;
> -
> -	/*
> -	 * Set the default values to the maximum required by the platform to
> -	 * allow the deepest power management savings. Write as a DWORD where
> -	 * the lower word is the max snoop latency and the upper word is the
> -	 * max non-snoop latency.
> -	 */
> -	ltr_reg = (ltr << 16) | ltr;
> -	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
> -	pci_info(pdev, "VMD: Default LTR value set by driver\n");
> -
> -	return 0;
> -}
> -
>  static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  {
>  	struct pci_sysdata *sd = &vmd->sysdata;
> @@ -936,8 +885,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  
>  	pci_assign_unassigned_bus_resources(vmd->bus);
>  
> -	pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, &features);
> -
>  	/*
>  	 * VMD root buses are virtual and don't return true on pci_is_pcie()
>  	 * and will fail pcie_bus_configure_settings() early. It can instead be
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 44cab813bf95..2d86623f96e3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6023,3 +6023,75 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
>  #endif
> +
> +#ifdef CONFIG_VMD
> +/*
> + * Enable ASPM on the PCIE root ports under VMD and set the default LTR of the
> + * storage devices on platforms where these values are not configured by BIOS.
> + * This is needed for laptops, which require these settings for proper power
> + * management of the SoC.
> + */
> +#define VMD_DEVICE_LTR	0x1003	/* 3145728 ns */
> +static void quirk_intel_vmd(struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent;
> +	u16 ltr = VMD_DEVICE_LTR;
> +	u32 ltr_reg;
> +	int pos;
> +
> +	/* Check in VMD domain */
> +	if (pci_domain_nr(pdev->bus) < 0x10000)
> +		return;
> +
> +	/* Get Root Port */
> +	parent = pci_upstream_bridge(pdev);
> +	if (!parent || parent->vendor != PCI_VENDOR_ID_INTEL)
> +		return;
> +
> +	/* Get VMD Host Bridge */
> +	parent = to_pci_dev(parent->dev.parent);
> +	if (!parent)
> +		return;
> +
> +	/* Get RAID controller */
> +	parent = to_pci_dev(parent->dev.parent);
> +	if (!parent)
> +		return;
> +
> +	switch (parent->device) {
> +	case 0x467f:
> +	case 0x4c3d:
> +	case 0xa77f:
> +	case 0x7d0b:
> +	case 0xad0b:
> +	case 0x9a0b:
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
> +	if (!pos)
> +		return;
> +
> +	/* Skip if the max snoop LTR is non-zero, indicating BIOS has set it */
> +	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg);
> +	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
> +		return;
> +
> +	/*
> +	 * Set the LTR values to the maximum required by the platform to
> +	 * allow the deepest power management savings. Write as a DWORD where
> +	 * the lower word is the max snoop latency and the upper word is the
> +	 * max non-snoop latency.
> +	 */
> +	ltr_reg = (ltr << 16) | ltr;
> +	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
> +	pci_info(pdev, "LTR set by VMD PCI quick\n");
> +
> +}
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
> +			      PCI_CLASS_STORAGE_EXPRESS, 0, quirk_intel_vmd);
> +#endif
> -- 
> 2.34.1

-- 
Ville Syrjälä
Intel
