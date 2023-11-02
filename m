Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E317DF0E7
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 12:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347260AbjKBLIZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 07:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347302AbjKBLIX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 07:08:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D25181;
        Thu,  2 Nov 2023 04:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698923296; x=1730459296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=odjc9dr4DIBNf+sdcc67k5/3mIvmgLlogDDgZmqqTho=;
  b=JkShQwMfAfj7ECauXBsqZi//XwqUaouL4sj9JzoITCGQHVkBkoYk7w1v
   4IEdi/SbmBQE2IrbQwnFKWGyq3ZvwCd2+RWCIafzl4Jw4nC5I+J7RZt5z
   gYBxuidlDp2NDKnYrYijHZrCHHZM4tiSnsUsK7djQM9xzjpIj1OU+x/Kq
   hoRvUNERjLKF4Dx+9wUlmyTecivlb9w7YUbu+sthV8nxIplDpdBcVmmnT
   W6mU2coGBU4qMZ56jVv80DsbAcEuvkrj///URylesn7yaKCu1Mcbr4eBE
   9vPMEdHXHSECP/hOAeY1gV2g8T4P/062PGYu7MZRbzzC6vFQbERPLTBBH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="7328808"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="7328808"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 04:08:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="764877653"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="764877653"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 02 Nov 2023 04:08:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 8AEB14F0; Thu,  2 Nov 2023 12:31:08 +0200 (EET)
Date:   Thu, 2 Nov 2023 12:31:08 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Alexander.Deucher@amd.com
Subject: Re: [PATCH 2/2] PCI: Ignore PCIe ports used for tunneling in
 pcie_bandwidth_available()
Message-ID: <20231102103108.GK17433@black.fi.intel.com>
References: <20231101225259.GA101390@bhelgaas>
 <928df647-5b20-406b-8da5-3199f5cfbb48@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <928df647-5b20-406b-8da5-3199f5cfbb48@amd.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 01, 2023 at 08:14:31PM -0500, Mario Limonciello wrote:
> On 11/1/2023 17:52, Bjorn Helgaas wrote:
> > On Tue, Oct 31, 2023 at 08:34:38AM -0500, Mario Limonciello wrote:
> > > The USB4 spec specifies that PCIe ports that are used for tunneling
> > > PCIe traffic over USB4 fabric will be hardcoded to advertise 2.5GT/s.
> > > 
> > > In reality these ports speed is controlled by the fabric implementation.
> > 
> > So I guess you're saying the speed advertised by PCI_EXP_LNKSTA is not
> > the actual speed?  And we don't have a generic way to find the actual
> > speed?
> 
> Correct.
> 
> > 
> > > Downstream drivers such as amdgpu which utilize pcie_bandwidth_available()
> > > to program the device will always find the PCIe ports used for
> > > tunneling as a limiting factor and may make incorrect decisions.
> > > 
> > > To prevent problems in downstream drivers check explicitly for ports
> > > being used for PCIe tunneling and skip them when looking for bandwidth
> > > limitations.
> > > 
> > > 2 types of devices are detected:
> > > 1) PCIe root port used for PCIe tunneling
> > > 2) Intel Thunderbolt 3 bridge
> > > 
> > > Downstream drivers could make this change on their own but then they
> > > wouldn't be able to detect other potential speed bottlenecks.
> > 
> > Is the implication that a tunneling port can *never* be a speed
> > bottleneck?  That seems to be how this patch would work in practice.
> 
> I think that's a stretch we should avoid concluding.
> 
> IIUC the fabric can be hosting other traffic and it's entirely possible the
> traffic over the tunneling port runs more slowly at times.
> 
> Perhaps that's why the the USB4 spec decided to advertise it this way? I
> don't know.
> 
> > 
> > > Link: https://lore.kernel.org/linux-pci/7ad4b2ce-4ee4-429d-b5db-3dfc360f4c3e@amd.com/
> > > Link: https://www.usb.org/document-library/usb4r-specification-v20
> > >        USB4 V2 with Errata and ECN through June 2023 - CLEAN p710
> > 
> > I guess this is sec 11.2.1 ("PCIe Physical Layer Logical Sub-block")
> > on PDF p710 (labeled "666" on the printed page).  How annoying that
> > the PDF page numbers don't match the printed ones; do the section
> > numbers at least stay stable in new spec revisions?
> 
> I'd hope so.  I'll change it to section numbers in the next revision.
> 
> > 
> > > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2925
> > 
> > This issue says the external GPU doesn't work at all.  Does this patch
> > fix that?  This patch looks like it might improve GPU performance, but
> > wouldn't fix something that didn't work at all.
> 
> The issue actually identified 4 distinct different problems.  The 3 problems
> will be fixed in amdgpu which are functional.
> 
> This performance one was from later in the ticket after some back and forth
> identifying proper solutions for the first 3.
> 
> > 
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   drivers/pci/pci.c | 41 +++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 41 insertions(+)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 59c01d68c6d5..4a7dc9c2b8f4 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -6223,6 +6223,40 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
> > >   }
> > >   EXPORT_SYMBOL(pcie_set_mps);
> > > +/**
> > > + * pcie_is_tunneling_port - Check if a PCI device is used for TBT3/USB4 tunneling
> > > + * @dev: PCI device to check
> > > + *
> > > + * Returns true if the device is used for PCIe tunneling, false otherwise.
> > > + */
> > > +static bool
> > > +pcie_is_tunneling_port(struct pci_dev *pdev)
> > 
> > Use usual function signature styling (all on one line).
> 
> OK.
> 
> > 
> > > +{
> > > +	struct device_link *link;
> > > +	struct pci_dev *supplier;
> > > +
> > > +	/* Intel TBT3 bridge */
> > > +	if (pdev->is_thunderbolt)
> > > +		return true;
> > > +
> > > +	if (!pci_is_pcie(pdev))
> > > +		return false;
> > > +
> > > +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)
> > > +		return false;
> > > +
> > > +	/* PCIe root port used for tunneling linked to USB4 router */
> > > +	list_for_each_entry(link, &pdev->dev.links.suppliers, c_node) {
> > > +		supplier = to_pci_dev(link->supplier);
> > > +		if (!supplier)
> > > +			continue;
> > > +		if (supplier->class == PCI_CLASS_SERIAL_USB_USB4)
> > > +			return true;
> > 
> > Since this is in drivers/pci, and this USB4/Thunderbolt routing is not
> > covered by the PCIe specs, this is basically black magic.  Is there a
> > reference to the USB4 spec we could include to help make it less
> > magical?
> 
> The "magic" part is that there is an ACPI construct to indicate a PCIe port
> is linked to a USB4 router.
> 
> Here is a link to the page that is explained:
> https://learn.microsoft.com/en-us/windows-hardware/design/component-guidelines/usb4-acpi-requirements#port-mapping-_dsd-for-usb-3x-and-pcie
> 
> In the Linux side this link is created in the 'thunderbolt' driver.
> 
> Thinking about this again, this does actually mean we could have a different
> result based on whether pcie_bandwidth_available() is called before or after
> the 'thunderbolt' driver has loaded.
> 
> For example if a GPU driver that called pcie_bandwidth_available() was in
> the initramfs but 'thunderbolt' was in the rootfs we might end up with the
> wrong result again.

Right, that's possible if the boot firmware has support for a connection
manager. Although we do reset the whole topology with the USB4 v2 host
routers this is kept as is for v1.

> Considering this I think it's a good idea to move that creation of the
> device link into drivers/pci/pci-acpi.c and store a bit in struct pci_device
> to indicate it's a tunneled port.

Note it currently is setting the link between xHCI and the
USB4/Thunderbolt host controller but we may want to change it later to
link between USB 3.x port and the USB4/Thunderbolt host to allow more
fine grained power management, this is especially true with the new USB
Gen T tunneling. So for now it is only PCI but we may need to touch the
USB stack too (perhaps put it in drivers/acpi/ instead).

> Then 'thunderbolt' can look for this directly instead of walking all the FW
> nodes.
> 
> pcie_bandwidth_available() can just look at the tunneled port bit instead of
> the existence of the device link.
> 
> > 
> > Lukas' brief intro in
> > https://lore.kernel.org/all/20230925141930.GA21033@wunner.de/ really
> > helped me connect a few dots, because things like
> > Documentation/admin-guide/thunderbolt.rst assume we already know those
> > details.
> 
> Thanks for sharing that.  If I move the detection mechanism as I suggested
> above I'll reference some of that as well in the commit message to explain
> what exactly a tunneled port is.

I'm not sure it makes sense to explain from the zero all this stuff that
people can easily look up from the corresponding spec, such as PCIe or
USB.

There is a good picture in USB4 v2 ch 2.2.3 about paths crossing USB4
fabric, perhaps reference that one? Or ch 2.2.10.3 that shows how this
works with PCIe tunneling instead (although they are similar).
