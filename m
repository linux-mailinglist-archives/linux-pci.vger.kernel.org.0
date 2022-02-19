Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C254BCA57
	for <lists+linux-pci@lfdr.de>; Sat, 19 Feb 2022 19:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbiBSS71 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Feb 2022 13:59:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBSS70 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Feb 2022 13:59:26 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A5B59A53;
        Sat, 19 Feb 2022 10:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645297146; x=1676833146;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YjcmreUpCIrBCYdc1cFbN9dGuwQFr7PWHG7P8Kh35AU=;
  b=mxYwLOvVLbye2UJZxyeA0uzPeDhAvaxPjDXmvFS/d3tS+n5Ma4Oi8Vhq
   BM601u6AUCVDJCSFvqehXGTujNgXQP+lLoVvf8oGxBAuhoFos5DXQZ0zJ
   QvWh5Y/bRAA2CIMaWf3kpiLC7WZ2nAKl9DdG4UioFD62u7QeAw8PgvCAC
   Yt3vWaVnZKxdKT4NWoND+6a1WgngogzRwl/xtYpKWl0tahbdgXwTMFMl8
   6rGNQBnPUvfSx/OBNWc1eWXRHcl7WOb61lhverkEwLe0eNnxc842zqg4J
   W9xTVOUocbq9RyKKu+gXdQGTKLEn+OwxjSyaidzFelCela0uZtMLzZZTP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10263"; a="251501265"
X-IronPort-AV: E=Sophos;i="5.88,381,1635231600"; 
   d="scan'208";a="251501265"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2022 10:59:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,381,1635231600"; 
   d="scan'208";a="531330912"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 19 Feb 2022 10:59:06 -0800
Received: from kpavlasx-mobl2.amr.corp.intel.com (kpavlasx-mobl2.amr.corp.intel.com [10.209.114.238])
        by linux.intel.com (Postfix) with ESMTP id D74A3580975;
        Sat, 19 Feb 2022 10:59:05 -0800 (PST)
Message-ID: <f5318c1171c5733388c9b455f2058f9aed127b8b.camel@linux.intel.com>
Subject: Re: [PATCH V5 3/3] PCI: vmd: Configure PCIe ASPM and LTR
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Jonathan Derrick <jonathan.derrick@linux.dev>,
        nirmal.patel@linux.intel.com, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@linux.intel.com,
        rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 19 Feb 2022 10:59:05 -0800
In-Reply-To: <1a163e75-f620-dfe7-01b1-5356fe767b2d@linux.dev>
References: <20220218045056.333799-1-david.e.box@linux.intel.com>
         <20220218045056.333799-4-david.e.box@linux.intel.com>
         <1a163e75-f620-dfe7-01b1-5356fe767b2d@linux.dev>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, 2022-02-18 at 14:30 -0700, Jonathan Derrick wrote:
> 
> On 2/17/2022 9:50 PM, David E. Box wrote:
> > Currently, PCIe ports reserved for VMD use are not visible to BIOS
> > and
> > therefore not configured to enable PCIE ASPM. Additionally, PCIE
> > LTR
> > values may be left unset since BIOS will set a default maximum LTR
> > value
> > on endpoints to ensure that misconfigured devices don't block SoC
> > power
> > management. Lack of this programming results in high power
> > consumption
> > on laptops as reported in bugzilla [1].  For currently affected
> > products, use pci_enable_default_link_state to set the allowed link
> > states for devices on the root ports. Also set the LTR value to the
> > maximum value needed for the SoC. Per the VMD hardware team future
> > products using VMD will enable BIOS configuration of these
> > capabilities.
> Will the refreshes of the affected CPU be supported in BIOS or this
> workaround?

I'll have to check with the hardware/BIOS team. Still because it is
BIOS this should check for signs that it hasn't already configured ASPM
before modifying anything. I'll make this change.

David

> 
> > This solution is a workaround for current products that mainly
> > targets
> > laptops. Support is not provided if a switch is used nor for
> > hotplug.
> > 
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=213717
> > 
> > Signed-off-by: Michael Bottini <michael.a.bottini@linux.intel.com>
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> > V5
> >   - Provide the LTR value as driver data.
> >   - Use DWORD for the config space write to avoid PCI WORD access
> > bug.
> >   - Set ASPM links firsts, enabling all link states, before setting
> > a
> >     default LTR if the capability is present
> >   - Add kernel message that VMD is setting the device LTR.
> > V4
> >   - Refactor vmd_enable_apsm() to exit early, making the lines
> > shorter
> >     and more readable. Suggested by Christoph.
> > V3
> >   - No changes
> > V2
> >   - Use return status to print pci_info message if ASPM cannot be
> > enabled.
> >   - Add missing static declaration, caught by lkp@intel.com
> > 
> >   drivers/pci/controller/vmd.c | 48
> > +++++++++++++++++++++++++++++++++++-
> >   1 file changed, 47 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/vmd.c
> > b/drivers/pci/controller/vmd.c
> > index a582c351b461..eac379c80cd7 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -67,10 +67,19 @@ enum vmd_features {
> >   	 * interrupt handling.
> >   	 */
> >   	VMD_FEAT_CAN_BYPASS_MSI_REMAP		= (1 << 4),
> > +
> > +	/*
> > +	 * Enable ASPM on the PCIE root ports and set the default LTR
> > of the
> > +	 * storage devices on platforms where these values are not
> > configured by
> > +	 * BIOS. This is needed for laptops, which require these
> > settings for
> > +	 * proper power management of the SoC.
> > +	 */
> > +	VMD_FEAT_BIOS_PM_QUIRK		= (1 << 5),
> >   };
> >   
> >   struct vmd_device_data {
> >   	enum vmd_features features;
> > +	u16 ltr;
> >   };
> >   
> >   static DEFINE_IDA(vmd_instance_ida);
> > @@ -714,6 +723,38 @@ static void vmd_copy_host_bridge_flags(struct
> > pci_host_bridge *root_bridge,
> >   	vmd_bridge->native_dpc = root_bridge->native_dpc;
> >   }
> >   
> > +/*
> > + * Enable ASPM and LTR settings on devices that aren't configured
> > by BIOS.
> > + */
> > +static int vmd_pm_enable_quirk(struct pci_dev *pdev, void
> > *userdata)
> > +{
> > +	struct vmd_device_data *info = userdata;
> > +	u32 ltr_reg;
> > +	int pos;
> > +
> > +	if (!(info->features & VMD_FEAT_BIOS_PM_QUIRK))
> > +		return 0;
> > +
> > +	pci_enable_default_link_state(pdev, PCIE_LINK_STATE_ALL);
> > +
> > +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
> > +	if (!pos)
> > +		return 0;
> > +
> > +	/*
> > +	 * If the LTR capability is present, set the default values to
> > the
> > +	 * maximum required by the platform to allow the deepest power
> > +	 * management savings. Write this as a single DWORD where the
> > lower word
> > +	 * is the max snoop latency and the upper word is the max non-
> > snoop
> > +	 * latency.
> > +	 */
> > +	pci_info(pdev, "VMD: Setting a default LTR\n");
> > +	ltr_reg = (info->ltr << 16) | info->ltr;
> > +	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT,
> > ltr_reg);
> > +
> > +	return 0;
> > +}
> > +
> >   static int vmd_enable_domain(struct vmd_dev *vmd, struct
> > vmd_device_data *info)
> >   {
> >   	struct pci_sysdata *sd = &vmd->sysdata;
> > @@ -867,6 +908,8 @@ static int vmd_enable_domain(struct vmd_dev
> > *vmd, struct vmd_device_data *info)
> >   		pci_reset_bus(child->self);
> >   	pci_assign_unassigned_bus_resources(vmd->bus);
> >   
> > +	pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, info);
> > +
> >   	/*
> >   	 * VMD root buses are virtual and don't return true on
> > pci_is_pcie()
> >   	 * and will fail pcie_bus_configure_settings() early. It can
> > instead be
> > @@ -1012,7 +1055,10 @@ static const struct vmd_device_data
> > vmd_28c0_data = {
> >   static const struct vmd_device_data vmd_467f_data = {
> >   	.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> >   		    VMD_FEAT_HAS_BUS_RESTRICTIONS |
> > -		    VMD_FEAT_OFFSET_FIRST_VECTOR,
> > +		    VMD_FEAT_OFFSET_FIRST_VECTOR |
> > +		    VMD_FEAT_BIOS_PM_QUIRK,
> > +	/* 3145728 ns (LatencyScale of 1048576 ns with a LatencyValue
> > of 3) */
> > +	.ltr = 0x1003,
> >   };
> >   
> >   static const struct pci_device_id vmd_ids[] = {

