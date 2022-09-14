Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DAB5B8FD7
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 22:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiINU7q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 16:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiINU7n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 16:59:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A25DF99;
        Wed, 14 Sep 2022 13:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663189181; x=1694725181;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GMGUF2YUT7R8DDXSnvaI+2DZGCJatg+6nd152nyIvcg=;
  b=E68YEXYJt/Cfe9xqLT7KrS6zWp/7UW2+6l1MRxkmiolNR67HWqweeSpb
   dINE5SKQOL2nWD7ejtXEPaxYNRZpf86SAbmSatXLYt85SYPkEAN9C3INR
   WHwKqKsKyDM2qLgwa3DA+qSZlMfEYUDqkwEyi9q15w+FMdJW92UUSyujY
   2X7ELWOsWERPyNzF64VU9B2ZYTB4snXe4nKaLWdyvZjHtfBm/OD3Iaoab
   VaMyrP+sM7O6uzW/i6tOpHCD3c8MSfI/SjyzLF1rHRBZTzd6mskBlgmbh
   WgM3XOgTu08EburZ1+KEREZN48V0+HG5KlGwwtkG/5sJkKQ0vcjSP8LR9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="324797640"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="324797640"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 13:59:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="612642821"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 14 Sep 2022 13:59:41 -0700
Received: from jtlang-mobl.amr.corp.intel.com (unknown [10.209.111.79])
        by linux.intel.com (Postfix) with ESMTP id 0EC10580C37;
        Wed, 14 Sep 2022 13:59:41 -0700 (PDT)
Message-ID: <c3f69569e7693ec9e04c388ee6c2456c3cbccde0.camel@linux.intel.com>
Subject: Re: [PATCH V6 3/3] PCI: vmd: Configure PCIe ASPM and LTR
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com,
        michael.a.bottini@linux.intel.com, rafael@kernel.org,
        me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 14 Sep 2022 13:59:35 -0700
In-Reply-To: <20220826170133.GA2933821@bhelgaas>
References: <20220826170133.GA2933821@bhelgaas>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Sorry for the delay. I'm just back from an extended leave.

On Fri, 2022-08-26 at 12:01 -0500, Bjorn Helgaas wrote:
> On Mon, Feb 28, 2022 at 08:19:43PM -0800, David E. Box wrote:
> > PCIe ports reserved for VMD use are not visible to BIOS and therefore not
> > configured to enable PCIE ASPM.
> > Additionally, PCIE LTR values may be left unset since BIOS will set
> > a default maximum LTR value on endpoints to ensure that they don't
> > block SoC power management.
> 
> If the ports aren't visible to BIOS, I assume BIOS doesn't configure
> *anything*, including LTR.  This sentence seems like it has a little
> too much information; if BIOS doesn't see the ports, LTR, SoC power
> management, etc., is not relevant.

It's mentioned as an explanation for why the patch also programs LTR values.

> 
> > Lack of this programming results in high power consumption on
> > laptops as reported in bugzilla [1].
> > For currently affected products, use pci_enable_default_link_state to set
> > the allowed link states for devices on the root ports.
> 
> "Currently affected products" makes me wonder about the *other*
> products?  Seems like we should handle *all* VMD devices the same way.

Well it affects Rocket Lake, Tiger Lake, and Alder Lake. It partially affects
Raptor Lake because we were able to have BIOS implement a solution to program
the LTR values. The plan is to use the same method to also program ASPM by
Meteor Lake and future products. So we do intend this to be a quirk for current
platforms, not a permanent solution.

> > Also set the LTR value to the maximum value needed for the SoC. Per
> > the VMD hardware team future products using VMD will enable BIOS
> > configuration of these capabilities. This solution is a workaround
> > for current products that mainly targets laptops.
> 
> I guess the cover letter has a little more background on this,
> although I don't understand how talking to the Intel BIOS team can
> solve this for *all* vendors using these parts.
> 
> > Support is not provided if a switch used nor for hotplug.
> 
> What switch are you referring to?

An expansion switch added between the root port and the downstream device.

>   What is the hotplug scenario?  Are
> VMD ports hot-pluggable? I assumed they were built into the Root
> Complex and not hot-pluggable.

I understand that they can be hot-pluggable. But the focus of the patch is to
address high power consumption on laptop systems since this is where we have
bugs reported. I don't know that it's worth the effort to make this work with
hot-plug.

> 
> s/PCIE/PCIe/ several times above so they're all consistent.
> 
> s/pci_enable_default_link_state/pci_enable_default_link_state()/ so it
> looks like a function.
> 
> That's a big block of text; maybe could be 2-3 paragraphs.

Ack

> 
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=213717
> > 
> > Signed-off-by: Michael Bottini <michael.a.bottini@linux.intel.com>
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> >  V6
> >   - Set ASPM first before setting LTR. This is needed because some
> >     devices may only have LTR set by BIOS and not ASPM
> >   - Skip setting the LTR if the current LTR in non-zero.
> >  V5
> >   - Provide the LTR value as driver data.
> >   - Use DWORD for the config space write to avoid PCI WORD access bug.
> >   - Set ASPM links firsts, enabling all link states, before setting a
> >     default LTR if the capability is present
> >   - Add kernel message that VMD is setting the device LTR.
> >  V4
> >   - Refactor vmd_enable_apsm() to exit early, making the lines shorter
> >     and more readable. Suggested by Christoph.
> >  V3
> >   - No changes
> >  V2
> >   - Use return status to print pci_info message if ASPM cannot be enabled.
> >   - Add missing static declaration, caught by lkp@intel.com
> > 
> >  drivers/pci/controller/vmd.c | 66 +++++++++++++++++++++++++++++++++---
> >  1 file changed, 62 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > index cde6e2cba210..8525bb8312f2 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -67,10 +67,19 @@ enum vmd_features {
> >  	 * interrupt handling.
> >  	 */
> >  	VMD_FEAT_CAN_BYPASS_MSI_REMAP		= (1 << 4),
> > +
> > +	/*
> > +	 * Enable ASPM on the PCIE root ports and set the default LTR of the
> > +	 * storage devices on platforms where these values are not configured by
> > +	 * BIOS. This is needed for laptops, which require these settings for
> > +	 * proper power management of the SoC.
> > +	 */
> > +	VMD_FEAT_BIOS_PM_QUIRK		= (1 << 5),
> >  };
> >  
> >  struct vmd_device_data {
> >  	enum vmd_features features;
> > +	u16 ltr;
> >  };
> >  
> >  static DEFINE_IDA(vmd_instance_ida);
> > @@ -714,6 +723,45 @@ static void vmd_copy_host_bridge_flags(struct
> > pci_host_bridge *root_bridge,
> >  	vmd_bridge->native_dpc = root_bridge->native_dpc;
> >  }
> >  
> > +/*
> > + * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
> > + */
> > +static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
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
> > +	 * Skip if the max snoop LTR is non-zero, indicating BIOS has set it
> > +	 * so the LTR quirk is not needed.
> > +	 */
> > +	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg);
> > +	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
> > +		return 0;
> > +
> > +	/*
> > +	 * Set the default values to the maximum required by the platform to
> > +	 * allow the deepest power management savings. Write as a DWORD where
> > +	 * the lower word is the max snoop latency and the upper word is the
> > +	 * max non-snoop latency.
> > +	 */
> > +	ltr_reg = (info->ltr << 16) | info->ltr;
> 
> The fact that you have to hard-code the LTR values in the driver seems
> problematic because it requires updates for every new device.  I guess
> you have to update the driver anyway to add Device IDs.
> 
> But surely there should be a firmware interface to discover this
> platform-specific information?  Does the _DSM for Latency Tolerance
> Reporting (PCI Firmware spec r3.3, sec 4.6.6) supply this?
> 
> We badly need generic support for that _DSM, but the documentation is
> somewhat lacking.

Looking at the spec (and at current DSDTs) it looks like that _DSM can be used
for exactly this purpose. However, proper VMD ACPI support is yet another
headache for Linux. The AML exists, but uses a different addressing scheme in
order to hide the devices from normal enumeration. Because of this, there are no
ACPI companion devices associated with the PCI devices.

David

> 
> > +	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
> > +	pci_info(pdev, "VMD: Default LTR set\n");
> > +
> > +	return 0;
> > +}
> > +
> >  static int vmd_enable_domain(struct vmd_dev *vmd, struct vmd_device_data
> > *info)
> >  {
> >  	struct pci_sysdata *sd = &vmd->sysdata;
> > @@ -867,6 +915,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, struct
> > vmd_device_data *info)
> >  		pci_reset_bus(child->self);
> >  	pci_assign_unassigned_bus_resources(vmd->bus);
> >  
> > +	pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, info);
> > +
> >  	/*
> >  	 * VMD root buses are virtual and don't return true on pci_is_pcie()
> >  	 * and will fail pcie_bus_configure_settings() early. It can instead be
> > @@ -1016,28 +1066,36 @@ static const struct pci_device_id vmd_ids[] = {
> >  		(kernel_ulong_t)&(struct vmd_device_data) {
> >  			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> >  				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
> > -				    VMD_FEAT_OFFSET_FIRST_VECTOR,
> > +				    VMD_FEAT_OFFSET_FIRST_VECTOR |
> > +				    VMD_FEAT_BIOS_PM_QUIRK,
> > +			.ltr = 0x1003, /* 3145728 ns */
> >  		},
> >  	},
> >  	{ PCI_VDEVICE(INTEL, 0x4c3d),
> >  		(kernel_ulong_t)&(struct vmd_device_data) {
> >  			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> >  				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
> > -				    VMD_FEAT_OFFSET_FIRST_VECTOR,
> > +				    VMD_FEAT_OFFSET_FIRST_VECTOR |
> > +				    VMD_FEAT_BIOS_PM_QUIRK,
> > +			.ltr = 0x1003, /* 3145728 ns */
> >  		},
> >  	},
> >  	{ PCI_VDEVICE(INTEL, 0xa77f),
> >  		(kernel_ulong_t)&(struct vmd_device_data) {
> >  			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> >  				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
> > -				    VMD_FEAT_OFFSET_FIRST_VECTOR,
> > +				    VMD_FEAT_OFFSET_FIRST_VECTOR |
> > +				    VMD_FEAT_BIOS_PM_QUIRK,
> > +			.ltr = 0x1003, /* 3145728 ns */
> >  		},
> >  	},
> >  	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> >  		(kernel_ulong_t)&(struct vmd_device_data) {
> >  			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> >  				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
> > -				    VMD_FEAT_OFFSET_FIRST_VECTOR,
> > +				    VMD_FEAT_OFFSET_FIRST_VECTOR |
> > +				    VMD_FEAT_BIOS_PM_QUIRK,
> > +			.ltr = 0x1003, /* 3145728 ns */
> >  		},
> >  	},
> >  	{ }
> > -- 
> > 2.25.1
> > 

