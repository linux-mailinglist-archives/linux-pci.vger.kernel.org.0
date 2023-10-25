Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22227D65BE
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 10:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjJYItw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 04:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbjJYIi7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 04:38:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBDC18A;
        Wed, 25 Oct 2023 01:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698223136; x=1729759136;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=I38QlpUe3v1pEBGiWrdhG1N+IsOTdBzI0QWTg8Einzg=;
  b=hsU31vsdN88OnBef8+dmnMimGXvgqnPreD5T7NGXvid1SK/CO+Y6dw9n
   kcS0n+sj71PZ+U2yBjzH+bNMcLeJjdizSj5KtYm/UrT9GBj1rSiu27xqJ
   ZNxAjwM0B3QHwUTTgFc7w+OPb9srYMEZXqvHZ9RdZLSMkJ4oaaJIfdIcN
   /d68SNThZkLQANLPtSJ4OdiDfFL7TUicl5Fe6f5lJr7EWPaFxHQh71dLN
   PXRdosgCk84GQ7MQQADaXg0olAMCkhgrN+rUTKZWi16GYGFEQb6lSvKVU
   d99MZksodkSkpuo54GqHUHAhZAd+NSUFY4KJVnl1f5qG3gFUiOYJ5rmQa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="391132691"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="391132691"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 01:38:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="758800777"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="758800777"
Received: from cristina-mobl3.ger.corp.intel.com ([10.251.212.45])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 01:38:51 -0700
Date:   Wed, 25 Oct 2023 11:38:46 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
cc:     "David E. Box" <david.e.box@linux.intel.com>,
        nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, michael.a.bottini@intel.com,
        "Rafael J. Wysocki" <rafael@kernel.org>, me@adhityamohan.in,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH V2] PCI: Move VMD ASPM/LTR fix to PCI quirk
In-Reply-To: <ZTf6ALl3xNvhLN6M@intel.com>
Message-ID: <ab823587-1e2b-474e-f0e7-14e4782ce49f@linux.intel.com>
References: <20230411213323.1362300-1-david.e.box@linux.intel.com> <ZTf6ALl3xNvhLN6M@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1564197198-1698222874=:1881"
Content-ID: <f4607477-96fb-95c1-42e4-b229f896a124@linux.intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1564197198-1698222874=:1881
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <7a409998-66d4-3482-222-b4908db15982@linux.intel.com>

On Tue, 24 Oct 2023, Ville Syrjälä wrote:

> On Tue, Apr 11, 2023 at 02:33:23PM -0700, David E. Box wrote:
> > In commit f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and
> > LTR") the VMD driver calls pci_enabled_link_state as a callback from
> > pci_bus_walk. Both will acquire the pci_bus_sem lock leading to a lockdep
> > warning. Instead of doing the pci_bus_walk, move the fix to quirks.c using
> > DECLARE_PCI_FIXUP_FINAL.
> 
> What happened to this patch? We're still carrying a local fix
> for this in drm-tip...
> 
> > 
> > Fixes: f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR")
> > Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> > 
> > V2 - Instead of adding a lock flag argument to pci_enabled_link_state, move
> >      the fix to quirks.c
> > 
> >  drivers/pci/controller/vmd.c | 55 +--------------------------
> >  drivers/pci/quirks.c         | 72 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 73 insertions(+), 54 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > index 990630ec57c6..47fa3e5f2dc5 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -66,22 +66,11 @@ enum vmd_features {
> >  	 * interrupt handling.
> >  	 */
> >  	VMD_FEAT_CAN_BYPASS_MSI_REMAP		= (1 << 4),
> > -
> > -	/*
> > -	 * Enable ASPM on the PCIE root ports and set the default LTR of the
> > -	 * storage devices on platforms where these values are not configured by
> > -	 * BIOS. This is needed for laptops, which require these settings for
> > -	 * proper power management of the SoC.
> > -	 */
> > -	VMD_FEAT_BIOS_PM_QUIRK		= (1 << 5),
> >  };
> >  
> > -#define VMD_BIOS_PM_QUIRK_LTR	0x1003	/* 3145728 ns */
> > -
> >  #define VMD_FEATS_CLIENT	(VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |	\
> >  				 VMD_FEAT_HAS_BUS_RESTRICTIONS |	\
> > -				 VMD_FEAT_OFFSET_FIRST_VECTOR |		\
> > -				 VMD_FEAT_BIOS_PM_QUIRK)
> > +				 VMD_FEAT_OFFSET_FIRST_VECTOR)
> >  
> >  static DEFINE_IDA(vmd_instance_ida);
> >  
> > @@ -724,46 +713,6 @@ static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
> >  	vmd_bridge->native_dpc = root_bridge->native_dpc;
> >  }
> >  
> > -/*
> > - * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
> > - */
> > -static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
> > -{
> > -	unsigned long features = *(unsigned long *)userdata;
> > -	u16 ltr = VMD_BIOS_PM_QUIRK_LTR;
> > -	u32 ltr_reg;
> > -	int pos;
> > -
> > -	if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
> > -		return 0;
> > -
> > -	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
> > -
> > -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
> > -	if (!pos)
> > -		return 0;
> > -
> > -	/*
> > -	 * Skip if the max snoop LTR is non-zero, indicating BIOS has set it
> > -	 * so the LTR quirk is not needed.
> > -	 */
> > -	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg);
> > -	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
> > -		return 0;
> > -
> > -	/*
> > -	 * Set the default values to the maximum required by the platform to
> > -	 * allow the deepest power management savings. Write as a DWORD where
> > -	 * the lower word is the max snoop latency and the upper word is the
> > -	 * max non-snoop latency.
> > -	 */
> > -	ltr_reg = (ltr << 16) | ltr;
> > -	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
> > -	pci_info(pdev, "VMD: Default LTR value set by driver\n");
> > -
> > -	return 0;
> > -}
> > -
> >  static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> >  {
> >  	struct pci_sysdata *sd = &vmd->sysdata;
> > @@ -936,8 +885,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> >  
> >  	pci_assign_unassigned_bus_resources(vmd->bus);
> >  
> > -	pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, &features);
> > -
> >  	/*
> >  	 * VMD root buses are virtual and don't return true on pci_is_pcie()
> >  	 * and will fail pcie_bus_configure_settings() early. It can instead be
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 44cab813bf95..2d86623f96e3 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -6023,3 +6023,75 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
> >  #endif
> > +
> > +#ifdef CONFIG_VMD
> > +/*
> > + * Enable ASPM on the PCIE root ports under VMD and set the default LTR of the
> > + * storage devices on platforms where these values are not configured by BIOS.
> > + * This is needed for laptops, which require these settings for proper power
> > + * management of the SoC.
> > + */
> > +#define VMD_DEVICE_LTR	0x1003	/* 3145728 ns */

This should be defined using FIELD_PREP()s. It is better to construct both 
snoop and nosnoop registers here and not do the shift below at all.

There are new defines for the nosnoop reg in pci/field-get branch for the 
nosnoop reg fields.

-- 
 i.

> > +static void quirk_intel_vmd(struct pci_dev *pdev)
> > +{
> > +	struct pci_dev *parent;
> > +	u16 ltr = VMD_DEVICE_LTR;
> > +	u32 ltr_reg;
> > +	int pos;
> > +
> > +	/* Check in VMD domain */
> > +	if (pci_domain_nr(pdev->bus) < 0x10000)
> > +		return;
> > +
> > +	/* Get Root Port */
> > +	parent = pci_upstream_bridge(pdev);
> > +	if (!parent || parent->vendor != PCI_VENDOR_ID_INTEL)
> > +		return;
> > +
> > +	/* Get VMD Host Bridge */
> > +	parent = to_pci_dev(parent->dev.parent);
> > +	if (!parent)
> > +		return;
> > +
> > +	/* Get RAID controller */
> > +	parent = to_pci_dev(parent->dev.parent);
> > +	if (!parent)
> > +		return;
> > +
> > +	switch (parent->device) {
> > +	case 0x467f:
> > +	case 0x4c3d:
> > +	case 0xa77f:
> > +	case 0x7d0b:
> > +	case 0xad0b:
> > +	case 0x9a0b:
> > +		break;
> > +	default:
> > +		return;
> > +	}
> > +
> > +	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
> > +
> > +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
> > +	if (!pos)
> > +		return;
> > +
> > +	/* Skip if the max snoop LTR is non-zero, indicating BIOS has set it */
> > +	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg);
> > +	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
> > +		return;
> > +
> > +	/*
> > +	 * Set the LTR values to the maximum required by the platform to
> > +	 * allow the deepest power management savings. Write as a DWORD where
> > +	 * the lower word is the max snoop latency and the upper word is the
> > +	 * max non-snoop latency.
> > +	 */
> > +	ltr_reg = (ltr << 16) | ltr;
> > +	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
> > +	pci_info(pdev, "LTR set by VMD PCI quick\n");
> > +
> > +}
> > +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
> > +			      PCI_CLASS_STORAGE_EXPRESS, 0, quirk_intel_vmd);
> > +#endif
> > -- 
> > 2.34.1
> 
> 
--8323329-1564197198-1698222874=:1881--
