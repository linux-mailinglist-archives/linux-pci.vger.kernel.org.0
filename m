Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FF254FE5C
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 22:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348676AbiFQUdA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 16:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241902AbiFQUc5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 16:32:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B06C15FDC;
        Fri, 17 Jun 2022 13:32:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA1A862002;
        Fri, 17 Jun 2022 20:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5542C3411B;
        Fri, 17 Jun 2022 20:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655497974;
        bh=WjorfQwH6E8hN5MzDsY4aBtjcQ1w6h/bD/WKIu6wqaM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NpWWaQDsQrlhRYE9Y5iLyRQtUhmGo3LRH69xMlAYg3ohixvolV91Z9JCv9WMv+OtF
         F/vyYyVaXNSkq/CJC1f6298aNY31U11AtAwl3SII6a/nTFbvSn4Uk1Ow25kxAa1B9h
         WoC01+iw2POKAaOyXn9OtnWSeqdK8BAC2z5BrkuQvnTgV8SuGpM/DOMd/rBy4CSjK1
         g22L9kSZ3m8rcwax5SvU3xbN4wceW/WyQ3rnAuBL48T6itcJntc/509OwFafgc3noP
         lFCGa3zityWCztPZmdAjznVM7kw84KbfkdoP/OMOZyzovHh9M5CERs/1qDfj1pjS7e
         MWk8TaJn8HjYg==
Date:   Fri, 17 Jun 2022 15:32:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        linux-pci@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, priyanka.dandamudi@intel.com,
        matthew.auld@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [Intel-gfx] [PATCH 1/2] drm/i915: Add support for LMEM PCIe
 resizable bar
Message-ID: <20220617203252.GA1203491@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220617184441.7kbs4al7gmpxjuuy@ldmartin-desk2>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Christian, author of pci_resize_resource(), Sergei, author of
rebalancing patches]

Hi Lucas,

On Fri, Jun 17, 2022 at 11:44:41AM -0700, Lucas De Marchi wrote:
> Cc'ing intel-pci, lkml, Bjorn
> 
> On Fri, Jun 17, 2022 at 11:32:37AM +0300, Jani Nikula wrote:
> > On Thu, 16 Jun 2022, priyanka.dandamudi@intel.com wrote:
> > > From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> > > 
> > > Add support for the local memory PICe resizable bar, so that
> > > local memory can be resized to the maximum size supported by the device,
> > > and mapped correctly to the PCIe memory bar. It is usual that GPU
> > > devices expose only 256MB BARs primarily to be compatible with 32-bit
> > > systems. So, those devices cannot claim larger memory BAR windows size due
> > > to the system BIOS limitation. With this change, it would be possible to
> > > reprogram the windows of the bridge directly above the requesting device
> > > on the same BAR type.
> 
> There is a big caveat here that this may be too late as other drivers
> may have already mapped their BARs - so probably too late in the pci scan
> for it to be effective. In fact, after using this for a while, it seems
> to fail too often, particularly on CFL systems.

Help me understand the "too late" part.  Do you mean that there is
enough available space for the max BAR size, but it's fragmented and
therefore not usable?  And that if we could do something earlier,
before drivers have claimed their devices, we might be able to compact
the BARs of other devices to make a larger contiguous available space?

That is theoretically possible, but I think the current
pci_resize_resource() only supports resizing of the specified BAR and
any upstream bridge windows.  I don't think it supports moving BARs of
other devices.

Sergei did some nice work that might help with this situation because
it can move BARs around more generally.  It hasn't quite achieved
critical mass yet, but maybe this would help get there:

  https://lore.kernel.org/linux-pci/20201218174011.340514-1-s.miroshnichenko@yadro.com/

If I understand Sergei's series correctly, this rebalancing actually
cannot be done during enumeration because we only move BARs if a
driver for the device indicates that it supports it, so there would be
no requirement to do this early.

> Do we have any alternative to be done in the PCI subsystem during the
> scan?  There is other work in progress to allow i915 to use the rest of
> the device memory even with a smaller BAR, but it would be better if we
> can improve our chances of succeeding the resize.

> > > Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> > > Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
> > > Cc: Stuart Summers <stuart.summers@intel.com>
> > > Cc: Michael J Ruhl <michael.j.ruhl@intel.com>
> > > Cc: Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>
> > > Signed-off-by: Priyanka Dandamudi <priyanka.dandamudi@intel.com>
> > > Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> > 
> > Please see https://lore.kernel.org/r/87pmj8vesm.fsf@intel.com
> > 
> > > ---
> > >  drivers/gpu/drm/i915/i915_driver.c | 92 ++++++++++++++++++++++++++++++
> > >  1 file changed, 92 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
> > > index d26dcca7e654..4bdb471cb2e2 100644
> > > --- a/drivers/gpu/drm/i915/i915_driver.c
> > > +++ b/drivers/gpu/drm/i915/i915_driver.c
> > > @@ -303,6 +303,95 @@ static void sanitize_gpu(struct drm_i915_private *i915)
> > >  		__intel_gt_reset(to_gt(i915), ALL_ENGINES);
> > >  }
> > > 
> > > +static void __release_bars(struct pci_dev *pdev)
> > > +{
> > > +	int resno;
> > > +
> > > +	for (resno = PCI_STD_RESOURCES; resno < PCI_STD_RESOURCE_END; resno++) {
> > > +		if (pci_resource_len(pdev, resno))
> > > +			pci_release_resource(pdev, resno);
> > > +	}
> > > +}
> > > +
> > > +static void
> > > +__resize_bar(struct drm_i915_private *i915, int resno, resource_size_t size)
> > > +{
> > > +	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
> > > +	int bar_size = pci_rebar_bytes_to_size(size);
> > > +	int ret;
> > > +
> > > +	__release_bars(pdev);
> > > +
> > > +	ret = pci_resize_resource(pdev, resno, bar_size);
> > > +	if (ret) {
> > > +		drm_info(&i915->drm, "Failed to resize BAR%d to %dM (%pe)\n",
> > > +			 resno, 1 << bar_size, ERR_PTR(ret));
> > > +		return;
> > > +	}
> > > +
> > > +	drm_info(&i915->drm, "BAR%d resized to %dM\n", resno, 1 << bar_size);
> > > +}
> > > +
> > > +/* BAR size starts from 1MB - 2^20 */
> > > +#define BAR_SIZE_SHIFT 20
> > > +static resource_size_t
> > > +__lmem_rebar_size(struct drm_i915_private *i915, int resno)
> > > +{
> > > +	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
> > > +	u32 rebar = pci_rebar_get_possible_sizes(pdev, resno);
> > > +	resource_size_t size;
> > > +
> > > +	if (!rebar)
> > > +		return 0;
> > > +
> > > +	size = 1ULL << (__fls(rebar) + BAR_SIZE_SHIFT);
> > > +
> > > +	if (size <= pci_resource_len(pdev, resno))
> > > +		return 0;
> > > +
> > > +	return size;
> > > +}
> > > +
> > > +#define LMEM_BAR_NUM 2
> > > +static void i915_resize_lmem_bar(struct drm_i915_private *i915)
> > > +{
> > > +	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
> > > +	struct pci_bus *root = pdev->bus;
> > > +	struct resource *root_res;
> > > +	resource_size_t rebar_size = __lmem_rebar_size(i915, LMEM_BAR_NUM);
> > > +	u32 pci_cmd;
> > > +	int i;
> > > +
> > > +	if (!rebar_size)
> > > +		return;
> > > +
> > > +	/* Find out if root bus contains 64bit memory addressing */
> > > +	while (root->parent)
> > > +		root = root->parent;
> > > +
> > > +	pci_bus_for_each_resource(root, root_res, i) {
> > > +		if (root_res && root_res->flags & (IORESOURCE_MEM |
> > > +					IORESOURCE_MEM_64) && root_res->start > 0x100000000ull)
> > > +			break;
> > > +	}
> > > +
> > > +	/* pci_resize_resource will fail anyways */
> > > +	if (!root_res) {
> > > +		drm_info(&i915->drm, "Can't resize LMEM BAR - platform support is missing\n");
> > > +		return;
> > > +	}
> > > +
> > > +	/* First disable PCI memory decoding references */
> > > +	pci_read_config_dword(pdev, PCI_COMMAND, &pci_cmd);
> > > +	pci_write_config_dword(pdev, PCI_COMMAND,
> > > +			       pci_cmd & ~PCI_COMMAND_MEMORY);
> > > +
> > > +	__resize_bar(i915, LMEM_BAR_NUM, rebar_size);
> > > +
> > > +	pci_assign_unassigned_bus_resources(pdev->bus);
> > > +	pci_write_config_dword(pdev, PCI_COMMAND, pci_cmd);
> > > +}
> > > +
> > >  /**
> > >   * i915_driver_early_probe - setup state not requiring device access
> > >   * @dev_priv: device private
> > > @@ -852,6 +941,9 @@ int i915_driver_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> > > 
> > >  	disable_rpm_wakeref_asserts(&i915->runtime_pm);
> > > 
> > > +	if (HAS_LMEM(i915))
> > > +		i915_resize_lmem_bar(i915);
> > > +
> > >  	intel_vgpu_detect(i915);
> > > 
> > >  	ret = intel_gt_probe_all(i915);
> > 
> > -- 
> > Jani Nikula, Intel Open Source Graphics Center
