Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AF44B0792
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 08:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbiBJHxZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 02:53:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbiBJHxY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 02:53:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1617BBAE;
        Wed,  9 Feb 2022 23:53:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6431B8242A;
        Thu, 10 Feb 2022 07:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8371DC004E1;
        Thu, 10 Feb 2022 07:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644479602;
        bh=EHwtLM12IbKnr52SQSPs2DLSwzmhLw4dlVHdIhuPQH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OdokNtUiyrMrUPJ0VCJJsJTW4mKKYRNCBNXxN0aUy5RxG2w86ncVE5+FU+Qn2QHiT
         kM/16O96B5YY3s1D7iignRSt2fmuy+VXsz2Lwbp3fhIHe3eFkMEO1DqaxOiemkUVV9
         OlmtDEdLoivzOnpqg5uOFCG0gduGisOH0j+gy6g4=
Date:   Thu, 10 Feb 2022 08:53:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 1/2] PCI: Allow internal devices to be marked as
 untrusted
Message-ID: <YgTEbpIIuKiBbqqY@kroah.com>
References: <YgNVJKy0s8MGBRoa@kroah.com>
 <20220209183945.GA571585@bhelgaas>
 <CAJZ5v0hYFRe-HseDnqh4AFpBzzmAjx9nfJo2yC5o=jzbWUqqOw@mail.gmail.com>
 <CACK8Z6Erfmqv39C2a5nAtDMXz3_w1B0ibQLc3dd4HJZ_z=xg+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6Erfmqv39C2a5nAtDMXz3_w1B0ibQLc3dd4HJZ_z=xg+g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 09, 2022 at 02:00:54PM -0800, Rajat Jain wrote:
> Hello,
> 
> On Wed, Feb 9, 2022 at 10:49 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Feb 9, 2022 at 7:39 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Wed, Feb 09, 2022 at 06:46:12AM +0100, Greg Kroah-Hartman wrote:
> > > > On Tue, Feb 08, 2022 at 04:23:27PM -0800, Rajat Jain wrote:
> > > > > On Tue, Feb 1, 2022 at 6:01 PM Rajat Jain <rajatja@google.com> wrote:
> > > > > >
> > > > > > Today the pci_dev->untrusted is set for any devices sitting downstream
> > > > > > an external facing port (determined via "ExternalFacingPort" or the
> > > > > > "external-facing" properties).
> > > > > >
> > > > > > However, currently there is no way for internal devices to be marked as
> > > > > > untrusted.
> > > > > >
> > > > > > There are use-cases though, where a platform would like to treat an
> > > > > > internal device as untrusted (perhaps because it runs untrusted firmware
> > > > > > or offers an attack surface by handling untrusted network data etc).
> > > > > >
> > > > > > Introduce a new "UntrustedDevice" property that can be used by the
> > > > > > firmware to mark any device as untrusted.
> > > > >
> > > > > Just to unite the threads (from
> > > > > https://www.spinics.net/lists/linux-pci/msg120221.html). I did reach
> > > > > out to Microsoft but they haven't acknowledged my email. I also pinged
> > > > > them again yesterday, but I suspect I may not be able to break the
> > > > > ice. So this patch may be ready to go in my opinion.
> > > > >
> > > > > I don't see any outstanding comments on this patch, but please let me
> > > > > know if you have any comments.
> > > > >
> > > > > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > > > > ---
> > > > > > v2: * Also use the same property for device tree based systems.
> > > > > >     * Add documentation (next patch)
> > > > > >
> > > > > >  drivers/pci/of.c       | 2 ++
> > > > > >  drivers/pci/pci-acpi.c | 1 +
> > > > > >  drivers/pci/pci.c      | 9 +++++++++
> > > > > >  drivers/pci/pci.h      | 2 ++
> > > > > >  4 files changed, 14 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > > > > index cb2e8351c2cc..e8b804664b69 100644
> > > > > > --- a/drivers/pci/of.c
> > > > > > +++ b/drivers/pci/of.c
> > > > > > @@ -24,6 +24,8 @@ void pci_set_of_node(struct pci_dev *dev)
> > > > > >                                                     dev->devfn);
> > > > > >         if (dev->dev.of_node)
> > > > > >                 dev->dev.fwnode = &dev->dev.of_node->fwnode;
> > > > > > +
> > > > > > +       pci_set_untrusted(dev);
> > > > > >  }
> > > > > >
> > > > > >  void pci_release_of_node(struct pci_dev *dev)
> > > > > > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > > > > > index a42dbf448860..2bffbd5c6114 100644
> > > > > > --- a/drivers/pci/pci-acpi.c
> > > > > > +++ b/drivers/pci/pci-acpi.c
> > > > > > @@ -1356,6 +1356,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
> > > > > >
> > > > > >         pci_acpi_optimize_delay(pci_dev, adev->handle);
> > > > > >         pci_acpi_set_external_facing(pci_dev);
> > > > > > +       pci_set_untrusted(pci_dev);
> > > > > >         pci_acpi_add_edr_notifier(pci_dev);
> > > > > >
> > > > > >         pci_acpi_add_pm_notifier(adev, pci_dev);
> > > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > > index 9ecce435fb3f..41e887c27004 100644
> > > > > > --- a/drivers/pci/pci.c
> > > > > > +++ b/drivers/pci/pci.c
> > > > > > @@ -6869,3 +6869,12 @@ static int __init pci_realloc_setup_params(void)
> > > > > >         return 0;
> > > > > >  }
> > > > > >  pure_initcall(pci_realloc_setup_params);
> > > > > > +
> > > > > > +void pci_set_untrusted(struct pci_dev *pdev)
> > > > > > +{
> > > > > > +       u8 val;
> > > > > > +
> > > > > > +       if (!device_property_read_u8(&pdev->dev, "UntrustedDevice", &val)
> > >
> > > If we do this, can we combine it with set_pcie_untrusted(), where we
> > > already set pdev->untrusted?  Maybe that needs to be renamed; I don't
> > > see anything PCIe-specific there, and it looks like it works for
> > > conventional PCI as well.
> 
> Yes, I agree it makes sense to combine with set_pcie_untrusted(). I
> can do that in the next iteration of my patch, that I intend to work
> on after we reach some sort of conclusion on the other major comments
> below.
> 
> > >
> > > > Please no, "Untrusted" does not really convey much, if anything here.
> > > > You are taking an odd in-kernel-value and making it a user api.
> > > >
> > > > Where is this "trust" defined?  Who defines it?  What policy does the
> > > > kernel impose on it?
> > >
> > > I'm a bit hesitant about this, too.  It really doesn't have anything
> > > in particular to do with the PCI core.  It's not part of the PCI
> > > specs, and it could apply to any kind of device, not just PCI (ACPI,
> > > platform, USB, etc).
> > >
> > > We have:
> > >
> > >   dev->removable                # struct device
> > >   pdev->is_thunderbolt
> > >   pdev->untrusted
> > >   pdev->external_facing
> > >
> > > and it feels a little hard to keep everything straight.  Most of them
> > > are "discovered" based on some DT or ACPI firmware property.  None of
> > > them really has anything specifically to do with *PCI*, and I don't
> > > think the PCI core depends on any of them.  I think
> > > pdev->is_thunderbolt is the only one we discover based on a PCI
> > > feature (the Thunderbolt Capability), and the things we *use* it for
> > > are actually not things specified by that capability [1].
> > >
> > > Could drivers just look for these properties directly instead of
> > > relying on the PCI core to get in the middle?  Most callers of
> > > device_property_read_*() are in drivers.  I do see that doing it in
> > > the PCI core might help enforce standard usage in DT/ACPI, but we
> > > could probably do that in other ways, too.
> >
> > FWIW, I agree that looking at these things in drivers would be better.
> 
> The pci_dev->untrusted property is currently used by:
> 
> - IOMMU drivers to determine whether bounce buffers should be used,
> and whether flush queue should be used for these devices.

Then how about naming it "use_iommu" or something like that?  "Trust"
has nothing to do with this at all.

> - PCI subsystem to determine ACS settings (ATS / TB etc)

Why is this relevant?

> As we can see from the usage above, the current primary use of
> untrusted property in the kernel is to flag and protect against
> devices that can create a DMA attack on the host physical memory
> address space (also documented for these properties in [1][2]). IMHO,
> this property belongs to PCI devices because:
>  * I do not know of any other bus (other than PCI) that can allow DMA
> access of the host memory, to a device on that bus.
>  * There is some use of this property within the PCI (see above),
> although I agree it is not much.
>  * The existing properties are currently documented [1][2] to be part
> of PCIe root ports / PCI-PCI bridges (only):
> 
> [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
> [2] Documentation/devicetree/bindings/pci/pci.txt

Then let us mark these as "able to do DMA" or something like that.
"Trust" is a userspace policy decision, not a kernel decision to make.

And there are other busses that can do DMA, PCI is not unique here.

> One can possibly read the device properties in IOMMU drivers, but
> they'd need to keep it in some device structure.

That's fine, let's move it there.

> I understand moving
> the pci_dev->untrusted into struct device has been brought up a couple
> of times in the past, and has met with much stronger resistance.

Because of the issues I am raising here.  It's a bad name and doesn't
mean what people think it means.

> The
> discussion turned into a discussion on security, and the semantics of
> this property, and allowing userspace to change this property etc,
> requiring major changes, and thus fizzled out of motivation.

So I guess no one really cares :)

> I'd like to mention that I'm not proposing any changes to the way
> (already existing) pci_dev->untrusted is being used, or the semantics
> of this flag. I'm only trying to solve a corner case here i.e.
> internal devices don't have a way to specify this attribute. Thus
> requiring us (Chromeos) to carry hacks like [3]. I believe there are
> others who are also looking for this corner case. From [4]:

Why does Chromeos care about this flag?  What userspace decisions do you
make based on it?

> ==============================
> We have a similar trust issue with the BMC in servers even
> though they're internal devices. They're typically network accessible
> and infrequently updated so treating them as trustworthy isn't a great
> idea. We have been slowly de-privileging the BMC over the last few
> years, but the PCIe interface isn't locked down enough for my liking
> since the SoCs we use do allow software to set the VDID and perform
> arbitrary DMAs (thankfully limited to 32bit). If we're going to add in
> infrastructure for handling possibly untrustworthy PCI devices then
> I'd like to use that for BMCs too.
> =============================
> 
> [3] https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3171209
> [4] https://lkml.org/lkml/2020/6/9/1467
> 
> So from what I see, there is a need to solve this problem for internal
> PCI devices. And presently what I have, seemed like the path of least
> resistance to me (i.e. without running into big discussions, and major
> code changes).

It needs those code changes, please do not try to keep adding more to
this to avoid the real-work that is needed here.  Refer to those other
discussions you mention above for what should happen to do this
correctly.

thanks,

greg k-h
