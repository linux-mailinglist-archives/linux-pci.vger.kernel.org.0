Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EB454FF54
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 23:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbiFQV1c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 17:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiFQV1b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 17:27:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FE536E32;
        Fri, 17 Jun 2022 14:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655501248; x=1687037248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WmlbIpa8tKIKwHtk2vU55R2bfgbhvPFn3mU/igiV7O4=;
  b=UQu86+QHfJ9MO2i8DoeuZq0HaR3+motWykEm9utAh68V1W2eYXTMA2q4
   ABhsROXRw/lxKSwtGgDzcqy+yOpJvdipI0F/7NS3vhTTogiQBElU6m0Ks
   BXSrhdPvLr7h3C4NDBBBne+bPpyesbYwMKZmBmYFMAIQ73mtiQT/pJmXt
   +FeljP27Bboj5mU2EoB+NYjZDoTnkfl7AI8ns4IE4RyWlXNz8U/aLUxUS
   cQHQ5ADpLdFIx75jh20Yoen7d1gzSs/S/6z/b2KhkiAI8G+22q/Taj4Kx
   RYdvy9H5VEjweKpeUTPk5UyTmVmMMRpO8tYFUpzjzMahIJ5FdQjjRaAG7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="260020379"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="260020379"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 14:27:27 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="578899894"
Received: from ecastill-mobl2.amr.corp.intel.com (HELO ldmartin-desk2) ([10.212.204.20])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 14:27:27 -0700
Date:   Fri, 17 Jun 2022 14:27:27 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
        linux-kernel@vger.kernel.org, priyanka.dandamudi@intel.com,
        matthew.auld@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [Intel-gfx] [PATCH 1/2] drm/i915: Add support for LMEM PCIe
 resizable bar
Message-ID: <20220617212727.h5r2o3schvl73bbk@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20220617184441.7kbs4al7gmpxjuuy@ldmartin-desk2>
 <20220617203252.GA1203491@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220617203252.GA1203491@bhelgaas>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 17, 2022 at 03:32:52PM -0500, Bjorn Helgaas wrote:
>[+cc Christian, author of pci_resize_resource(), Sergei, author of
>rebalancing patches]
>
>Hi Lucas,
>
>On Fri, Jun 17, 2022 at 11:44:41AM -0700, Lucas De Marchi wrote:
>> Cc'ing intel-pci, lkml, Bjorn
>>
>> On Fri, Jun 17, 2022 at 11:32:37AM +0300, Jani Nikula wrote:
>> > On Thu, 16 Jun 2022, priyanka.dandamudi@intel.com wrote:
>> > > From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
>> > >
>> > > Add support for the local memory PICe resizable bar, so that
>> > > local memory can be resized to the maximum size supported by the device,
>> > > and mapped correctly to the PCIe memory bar. It is usual that GPU
>> > > devices expose only 256MB BARs primarily to be compatible with 32-bit
>> > > systems. So, those devices cannot claim larger memory BAR windows size due
>> > > to the system BIOS limitation. With this change, it would be possible to
>> > > reprogram the windows of the bridge directly above the requesting device
>> > > on the same BAR type.
>>
>> There is a big caveat here that this may be too late as other drivers
>> may have already mapped their BARs - so probably too late in the pci scan
>> for it to be effective. In fact, after using this for a while, it seems
>> to fail too often, particularly on CFL systems.
>
>Help me understand the "too late" part.  Do you mean that there is
>enough available space for the max BAR size, but it's fragmented and
>therefore not usable?  And that if we could do something earlier,
>before drivers have claimed their devices, we might be able to compact
>the BARs of other devices to make a larger contiguous available space?

yes. I will dig some logs I had in the past to confirm.


>That is theoretically possible, but I think the current
>pci_resize_resource() only supports resizing of the specified BAR and
>any upstream bridge windows.  I don't think it supports moving BARs of
>other devices.
>
>Sergei did some nice work that might help with this situation because
>it can move BARs around more generally.  It hasn't quite achieved
>critical mass yet, but maybe this would help get there:
>
>  https://lore.kernel.org/linux-pci/20201218174011.340514-1-s.miroshnichenko@yadro.com/

oh... I hadn't thought about pause/ioremap/unpause. That looks rad :).
So it seems this would integrate neatly with
pci_resize_resource() (what this patch is doing), as long as drivers for
devices affected implement
.bar_fixed()/.rescan_prepare()/.rescan_done(). That seems it would solve
our issues too.

thanks
Lucas De Marchi

>
>If I understand Sergei's series correctly, this rebalancing actually
>cannot be done during enumeration because we only move BARs if a
>driver for the device indicates that it supports it, so there would be
>no requirement to do this early.
>
>> Do we have any alternative to be done in the PCI subsystem during the
>> scan?  There is other work in progress to allow i915 to use the rest of
>> the device memory even with a smaller BAR, but it would be better if we
>> can improve our chances of succeeding the resize.
>
>> > > Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
>> > > Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
>> > > Cc: Stuart Summers <stuart.summers@intel.com>
>> > > Cc: Michael J Ruhl <michael.j.ruhl@intel.com>
>> > > Cc: Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>
>> > > Signed-off-by: Priyanka Dandamudi <priyanka.dandamudi@intel.com>
>> > > Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>> >
>> > Please see https://lore.kernel.org/r/87pmj8vesm.fsf@intel.com
>> >
>> > > ---
>> > >  drivers/gpu/drm/i915/i915_driver.c | 92 ++++++++++++++++++++++++++++++
>> > >  1 file changed, 92 insertions(+)
>> > >
>> > > diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
>> > > index d26dcca7e654..4bdb471cb2e2 100644
>> > > --- a/drivers/gpu/drm/i915/i915_driver.c
>> > > +++ b/drivers/gpu/drm/i915/i915_driver.c
>> > > @@ -303,6 +303,95 @@ static void sanitize_gpu(struct drm_i915_private *i915)
>> > >  		__intel_gt_reset(to_gt(i915), ALL_ENGINES);
>> > >  }
>> > >
>> > > +static void __release_bars(struct pci_dev *pdev)
>> > > +{
>> > > +	int resno;
>> > > +
>> > > +	for (resno = PCI_STD_RESOURCES; resno < PCI_STD_RESOURCE_END; resno++) {
>> > > +		if (pci_resource_len(pdev, resno))
>> > > +			pci_release_resource(pdev, resno);
>> > > +	}
>> > > +}
>> > > +
>> > > +static void
>> > > +__resize_bar(struct drm_i915_private *i915, int resno, resource_size_t size)
>> > > +{
>> > > +	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
>> > > +	int bar_size = pci_rebar_bytes_to_size(size);
>> > > +	int ret;
>> > > +
>> > > +	__release_bars(pdev);
>> > > +
>> > > +	ret = pci_resize_resource(pdev, resno, bar_size);
>> > > +	if (ret) {
>> > > +		drm_info(&i915->drm, "Failed to resize BAR%d to %dM (%pe)\n",
>> > > +			 resno, 1 << bar_size, ERR_PTR(ret));
>> > > +		return;
>> > > +	}
>> > > +
>> > > +	drm_info(&i915->drm, "BAR%d resized to %dM\n", resno, 1 << bar_size);
>> > > +}
>> > > +
>> > > +/* BAR size starts from 1MB - 2^20 */
>> > > +#define BAR_SIZE_SHIFT 20
>> > > +static resource_size_t
>> > > +__lmem_rebar_size(struct drm_i915_private *i915, int resno)
>> > > +{
>> > > +	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
>> > > +	u32 rebar = pci_rebar_get_possible_sizes(pdev, resno);
>> > > +	resource_size_t size;
>> > > +
>> > > +	if (!rebar)
>> > > +		return 0;
>> > > +
>> > > +	size = 1ULL << (__fls(rebar) + BAR_SIZE_SHIFT);
>> > > +
>> > > +	if (size <= pci_resource_len(pdev, resno))
>> > > +		return 0;
>> > > +
>> > > +	return size;
>> > > +}
>> > > +
>> > > +#define LMEM_BAR_NUM 2
>> > > +static void i915_resize_lmem_bar(struct drm_i915_private *i915)
>> > > +{
>> > > +	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
>> > > +	struct pci_bus *root = pdev->bus;
>> > > +	struct resource *root_res;
>> > > +	resource_size_t rebar_size = __lmem_rebar_size(i915, LMEM_BAR_NUM);
>> > > +	u32 pci_cmd;
>> > > +	int i;
>> > > +
>> > > +	if (!rebar_size)
>> > > +		return;
>> > > +
>> > > +	/* Find out if root bus contains 64bit memory addressing */
>> > > +	while (root->parent)
>> > > +		root = root->parent;
>> > > +
>> > > +	pci_bus_for_each_resource(root, root_res, i) {
>> > > +		if (root_res && root_res->flags & (IORESOURCE_MEM |
>> > > +					IORESOURCE_MEM_64) && root_res->start > 0x100000000ull)
>> > > +			break;
>> > > +	}
>> > > +
>> > > +	/* pci_resize_resource will fail anyways */
>> > > +	if (!root_res) {
>> > > +		drm_info(&i915->drm, "Can't resize LMEM BAR - platform support is missing\n");
>> > > +		return;
>> > > +	}
>> > > +
>> > > +	/* First disable PCI memory decoding references */
>> > > +	pci_read_config_dword(pdev, PCI_COMMAND, &pci_cmd);
>> > > +	pci_write_config_dword(pdev, PCI_COMMAND,
>> > > +			       pci_cmd & ~PCI_COMMAND_MEMORY);
>> > > +
>> > > +	__resize_bar(i915, LMEM_BAR_NUM, rebar_size);
>> > > +
>> > > +	pci_assign_unassigned_bus_resources(pdev->bus);
>> > > +	pci_write_config_dword(pdev, PCI_COMMAND, pci_cmd);
>> > > +}
>> > > +
>> > >  /**
>> > >   * i915_driver_early_probe - setup state not requiring device access
>> > >   * @dev_priv: device private
>> > > @@ -852,6 +941,9 @@ int i915_driver_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>> > >
>> > >  	disable_rpm_wakeref_asserts(&i915->runtime_pm);
>> > >
>> > > +	if (HAS_LMEM(i915))
>> > > +		i915_resize_lmem_bar(i915);
>> > > +
>> > >  	intel_vgpu_detect(i915);
>> > >
>> > >  	ret = intel_gt_probe_all(i915);
>> >
>> > --
>> > Jani Nikula, Intel Open Source Graphics Center
