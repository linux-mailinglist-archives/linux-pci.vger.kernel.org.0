Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F7C264B77
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 19:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgIJRjJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 13:39:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727868AbgIJRiL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Sep 2020 13:38:11 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6861B206A1;
        Thu, 10 Sep 2020 17:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759490;
        bh=wirOhMrKlm4G/NzCV37qJEm6kwJQ042CHK5V4SSeCZU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=zxlCCK0rGyMV8ypDJyD1tkzQbiSvWrnBaodEvAqatfCOCzCtRiJy4JzB4J0ptpyh3
         THPpFpYirqSfT6jt8FHBpsPzF1u09HKLzj4Ma/TGldVy6Ahbtv85Q8G5MVijxCI/Z4
         hNIvUv8z5cBHamwkgYZi7chChE55WQxZN6XkojdA=
Date:   Thu, 10 Sep 2020 12:38:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
        "kw@linux.com" <kw@linux.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "refactormyself@gmail.com" <refactormyself@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
Message-ID: <20200910173809.GA797818@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b7513ff64315d7a1c2529d34cd78b51ce3c3605.camel@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 10, 2020 at 04:33:39PM +0000, Derrick, Jonathan wrote:
> On Wed, 2020-09-09 at 20:55 -0500, Bjorn Helgaas wrote:
> > On Fri, Aug 21, 2020 at 08:32:20PM +0800, Kai-Heng Feng wrote:
> > > New Intel laptops with VMD cannot reach deeper power saving state,
> > > renders very short battery time.
> > > 
> > > As BIOS may not be able to program the config space for devices under
> > > VMD domain, ASPM needs to be programmed manually by software. This is
> > > also the case under Windows.
> > > 
> > > The VMD controller itself is a root complex integrated endpoint that
> > > doesn't have ASPM capability, so we can't propagate the ASPM settings to
> > > devices under it. Hence, simply apply ASPM_STATE_ALL to the links under
> > > VMD domain, unsupported states will be cleared out anyway.
> > > 
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > >  drivers/pci/pcie/aspm.c |  3 ++-
> > >  drivers/pci/quirks.c    | 11 +++++++++++
> > >  include/linux/pci.h     |  2 ++
> > >  3 files changed, 15 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index 253c30cc1967..dcc002dbca19 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -624,7 +624,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
> > >  		aspm_calc_l1ss_info(link, &upreg, &dwreg);
> > >  
> > >  	/* Save default state */
> > > -	link->aspm_default = link->aspm_enabled;
> > > +	link->aspm_default = parent->dev_flags & PCI_DEV_FLAGS_ENABLE_ASPM ?
> > > +			     ASPM_STATE_ALL : link->aspm_enabled;
> > 
> > This function is ridiculously complicated already, and I really don't
> > want to make it worse.
> > 
> > What exactly is the PCIe topology here?  Apparently the VMD controller
> > is a Root Complex Integrated Endpoint, so it's a Type 0 (non-bridge)
> > device.  And it has no Link, hence no Link Capabilities or Control and
> > hence no ASPM-related bits.  Right?
>
> That's correct. VMD is the Type 0 device providing config/mmio
> apertures to another segment and MSI/X remapping. No link and no ASPM
> related bits.
> 
> Hierarchy is usually something like:
> 
> Segment 0           | VMD segment
> Root Complex -> VMD | Type 0 (RP/Bridge; physical slot) - Type 1
>                     | Type 0 (RP/Bridge; physical slot) - Type 1
> 
> > 
> > And the devices under the VMD controller?  I guess they are regular
> > PCIe Endpoints, Switch Ports, etc?  Obviously there's a Link involved
> > somewhere.  Does the VMD controller have some magic, non-architected
> > Port on the downstream side?
>
> Correct: Type 0 and Type 1 devices, and any number of Switch ports as
> it's usually pinned out to physical slot.
> 
> > Does this patch enable ASPM on this magic Link between VMD and the
> > next device?  Configuring ASPM correctly requires knowledge and knobs
> > from both ends of the Link, and apparently we don't have those for the
> > VMD end.
>
> VMD itself doesn't have the link to it's domain. It's really just the
> config/mmio aperture and MSI/X remapper. The PCIe link is between the
> Type 0 and Type 1 devices on the VMD domain. So fortunately the VMD
> itself is not the upstream part of the link.
> 
> > Or is it for Links deeper in the hierarchy?  I assume those should
> > just work already, although there might be issues with latency
> > computation, etc., because we may not be able to account for the part
> > of the path above VMD.
>
> That's correct. This is for the links within the domain itself, such as
> between a type 0 and NVMe device.

OK, great.  So IIUC, below the VMD, there is a Root Port, and the Root
Port has a link to some Endpoint or Switch, e.g., an NVMe device.  And
we just want to enable ASPM on that link.

That should not be a special case; we should be able to make this so
it Just Works.  Based on this patch, I guess the reason it doesn't
work is because link->aspm_enabled for that link isn't set correctly.

So is this just a consequence of us depending on the initial Link
Control value from BIOS?  That seems like something we shouldn't
really depend on.

> > I want aspm.c to eventually get out of the business of managing struct
> > pcie_link_state.  I think it should manage *device* state for each end
> > of the link.  Maybe that's a path forward, e.g., if we cache the Link
> > Capabilities during enumeration, quirks could modify that directly,
> > and aspm.c could just consume that cached information.  I think Saheed
> > (cc'd) is already working on patches in this direction.
> > 
> > I'm still not sure how this works if VMD is the upstream end of a
> > Link, though.
> > 
> > >  	/* Setup initial capable state. Will be updated later */
> > >  	link->aspm_capable = link->aspm_support;
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index bdf9b52567e0..2e2f525bd892 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -5632,3 +5632,14 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
> > >  }
> > >  DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
> > >  			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
> > > +
> > > +/*
> > > + * Device [8086:9a09]
> > > + * BIOS may not be able to access config space of devices under VMD domain, so
> > > + * it relies on software to enable ASPM for links under VMD.
> > > + */
> > > +static void pci_fixup_enable_aspm(struct pci_dev *pdev)
> > > +{
> > > +	pdev->dev_flags |= PCI_DEV_FLAGS_ENABLE_ASPM;
> > > +}
> > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a09, pci_fixup_enable_aspm);
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 835530605c0d..66a45916c7c6 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -227,6 +227,8 @@ enum pci_dev_flags {
> > >  	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
> > >  	/* Don't use Relaxed Ordering for TLPs directed at this device */
> > >  	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
> > > +	/* Enable ASPM regardless of how LnkCtl is programmed */
> > > +	PCI_DEV_FLAGS_ENABLE_ASPM = (__force pci_dev_flags_t) (1 << 12),
> > >  };
> > >  
> > >  enum pci_irq_reroute_variant {
> > > -- 
> > > 2.17.1
> > > 
