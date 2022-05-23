Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA32531E5D
	for <lists+linux-pci@lfdr.de>; Tue, 24 May 2022 00:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiEWWKn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 18:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiEWWKn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 18:10:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BD6BA553;
        Mon, 23 May 2022 15:10:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D388B8162C;
        Mon, 23 May 2022 22:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5AAC385AA;
        Mon, 23 May 2022 22:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653343838;
        bh=yQVurtYEo5Ovn07aQzlO31017UwCZBxe6EyP0GZUBI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pj5rw/4/Oehudh25vKqU7IKu15HY3CB/4gvutCSqOFZuHAZ34pq/7z/d4kwmWXUjC
         kYjseRqkOfrCcXgvgU54/8v5SilNE4o88EDFNfQ2QrSGnh5yYtAf6igJ+7iBi7+Fw7
         KJjU4/TS+z1cKpIEFzXBThVmJNJKAJJhYzCH8wWPuplyLR9RsnfzuGQCzEsLqaU63n
         ebBPOMljRrR47dIYs7F71FgXSFwPAWnpvXaM+9MRqDAySTy1Dlm/By7UnW0r7+XhUQ
         3024KG3TlRxKzzp8zYTe8Ous53CVXDFTtqYEJD6OobHEcPacqXfUa2AIi4M0BV0YPC
         joBoDBsc5S2WQ==
Date:   Mon, 23 May 2022 17:10:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Dutton <james.dutton@gmail.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1] PCI: brcmstb: Fix regression regarding missing PCIe
 linkup
Message-ID: <20220523221036.GA130515@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANCKTBvqp7_MSG3aMpp6pmNoPUnYpH0c+8-r7Pzgebuzb4sZPA@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 21, 2022 at 02:51:42PM -0400, Jim Quinlan wrote:
> On Sat, May 21,
> 2CONFIG_INITRAMFS_SOURCE="/work3/jq921458/cpio/54-arm64-rootfs.cpio022
> at 12:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, May 18, 2022 at 03:42:11PM -0400, Jim Quinlan wrote:
> > > commit 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice
> > > voltage regulators")
> > >
> > > introduced a regression on the PCIe RPi4 Compute Module.  If the
> > > PCIe endpoint node described in [2] was missing, no linkup would
> > > be attempted, and subsequent accesses would cause a panic
> > > because this particular PCIe HW causes a CPU abort on illegal
> > > accesses (instead of returning 0xffffffff).
> > >
> > > We fix this by allowing the DT endpoint subnode to be missing.
> > > This is important for platforms like the CM4 which have a
> > > standard PCIe socket and the endpoint device is unknown.
> >
> > I think the problem here is that on the CM, we try to enumerate
> > devices that are not powered up, isn't it?  The commit log should
> > say something about that power situation and how the driver learns
> > about the power regulators instead of just pointing at an DT
> > endpoint node.
> 
> This is incorrect.  The regression occurred because the code
> mistakenly skips PCIe-linkup if the PCI portdrv DT node does not
> exist. With our RC HW, doing a config space access to bus 1 w/o
> first linking up results in a CPU abort.  This regression has
> nothing to do with EP power at all.

OK, I think I'm starting to see, but I'm still missing some things.

67211aadcb4b ("PCI: brcmstb: Add mechanism to turn on subdev
regulators") added pci_subdev_regulators_add_bus() as an .add_bus()
method.  This is called by pci_alloc_child_bus(), and if the DT
describes any regulators for the bridge leading to the new child bus,
we turn them on.

Then 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage
regulators") added brcm_pcie_add_bus() and made *it* the .add_bus()
method.  It turns on the regulators and brings the link up, but it
skips both if there's no DT node for the bridge to the new bus.

I guess RPi4 CM has no DT node to describe regulators, so we skip both
turning them on *and* bringing the link up?

But above you say it's the *endpoint* node that doesn't exist.  The
existing code looks like it's checking for the *bridge* node
(bus->dev->of_node).  We haven't even enumerated the devices on the
child bus, so we don't know about them at this point.

What happens if there is a DT node for the bridge, but it doesn't
describe any regulators?  I assume regulator_bulk_get() will fail, and
it looks like that might still keep us from bringing the link up?

I would think that lack of regulator description in the DT would mean
that any regulators are always on and the OS doesn't need to do
anything.

> >  What happens if we turn on the power but don't find any
> >  downstream devices?
>
> They are turned off to conserve power.
> 
> > From looking at the code, I assume we just leave the power on.
> > Maybe that's what you want, I dunno.

> For STB and Cable Modem products we do not leave the power on.  In
> fact, our Cable Modem group was the first to request this feature.
> It appears that the RPi CM4 always keeps endpoint power on but I do
> not know for sure.

I'm confused.  Why can't we tell by looking at pcie-brcmstb.c?  All I
know is what's in pcie-brcmstb.c; I have no idea which things apply to
which products.

The only calls to regulator_bulk_disable() are in
pci_subdev_regulators_remove_bus(), brcm_pcie_suspend(), and
brcm_pcie_resume().  I don't think the fact that enumeration didn't
find any devices necessarily leads to any of those.  What am I
missing?  (This is really a tangent that isn't critical for fixing the
regression.)

> > I added Rafael because this seems vaguely similar to runtime power
> > management, and if we can integrate with that somehow, I'd sure like
> > to avoid building a parallel infrastructure for it.
> >
> > The current path we're on is to move some of this code that's
> > currently in pcie-brcmstb.c to the PCIe portdrv [0].  I'm a little
> > hesitant about that because ACPI does just fine without it.  If we're
> > adding new DT functionality that could not be implemented via ACPI,
> > that's one thing.  But I'm not convinced this is that new.
>
> AFAICT, Broadcom STB and Cable Modem products do not have/use/want
> ACPI.  We are fine with keeping this "PCIe regulator" feature
> private to our driver and giving you speedy and full support in
> maintaining it.

I don't mean that you should use ACPI, only that ACPI platforms can do
this sort of power control using the existing PCI core infrastructure,
and maybe there's a way for OF/DT platforms to hook into that same
infrastructure to minimize the driver-specific work.  E.g., maybe
there's a way to extend platform_pci_set_power_state() and similar to
manage these regulators.

> > [0] https://lore.kernel.org/r/20211110221456.11977-6-jim2101024@gmail.com
> >
> > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=215925
> > > [2] Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > >
> > > Fixes: 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")
> > > Fixes: 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two funcs")
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=215925
> > > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > > ---
> > >  drivers/pci/controller/pcie-brcmstb.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > > index ba5c120816b2..adca74e235cb 100644
> > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > @@ -540,16 +540,18 @@ static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
> > >
> > >  static int brcm_pcie_add_bus(struct pci_bus *bus)
> > >  {
> > > -     struct device *dev = &bus->dev;
> > >       struct brcm_pcie *pcie = (struct brcm_pcie *) bus->sysdata;
> > >       int ret;
> > >
> > > -     if (!dev->of_node || !bus->parent || !pci_is_root_bus(bus->parent))
> > > +     /* Only busno==1 requires us to linkup */
> > > +     if ((int)bus->number != 1)
> > >               return 0;
> > >
> > >       ret = pci_subdev_regulators_add_bus(bus);
> > > -     if (ret)
> > > +     if (ret) {
> > > +             pcie->refusal_mode = true;
> > >               return ret;
> > > +     }
> > >
> > >       /* Grab the regulators for suspend/resume */
> > >       pcie->sr = bus->dev.driver_data;
> >
> > IIUC, this path:
> >
> >   pci_alloc_child_bus
> >     brcm_pcie_add_bus                   # .add_bus method
> >       pci_subdev_regulators_add_bus     # in pcie-brcmstb.c for now
> >         alloc_subdev_regulators         # in pcie-brcmstb.c for now
> >         regulator_bulk_get
> >         regulator_bulk_enable
> >       brcm_pcie_linkup                  # bring link up
> >
> > is basically so we can leave power to downstream devices off, then
> > turn it on when we're ready to enumerate those downstream devices.
>
> Yes  -- it is the "chicken-and-egg" problem.  Ideally, we would like
> for the endpoint driver to turn on its own regulators, but even to
> know which endpoint driver to probe we must turn on the regulator to
> establish linkup.

I don't think having an endpoint driver turn on power to its device is
the right goal.  As you said, if the power is off, we don't know
whether there's an endpoint or what it is, so the driver isn't in the
picture (I know sometimes endpoints are described in DT, and that
might be needed for non-discoverable properties, but I don't think
it's a good way to *enumerate* the device).

I don't know much about ACPI power management, but I kind of think it
turns on power to *everything* initially so we can enumerate all the
devices (Rafael or others, please correct me!)  After enumeration, we
can turn off devices we don't need, and the power management framework 
already supports turning devices on again when we use them.

> > I think the brcmstb root bus is always bus 0, it only has a single
> > Root Port on the root bus, and it always leads to bus 1, so it sort of
> > makes sense that we only need to turn on power when we're about to
> > scan "bus->number == 1".
>
> Correct.
> 
> > But this power management seems like a pattern that other
> > controllers will use.  Other controllers will have several Root
> > Ports, so checking the bus number won't work for them.  Instead of
> > checking the bus number, I think brcmstb should check more
> > directly for a power regulator.
>
> I agree.  That is why I said that we should consider removing the
> "busno==1" conditional if we want this feature for general use.  If
> you want, I can submit a V2 that removes this conditional.

If it's as easy as dropping a needlessly platform-dependent check, we
should absolutely do it.  Are you saying the patch would just become
this?

> I have a series of patches coming up that address some of these concerns.
> Can we please take this up then but allow us to escape "revert jail" first?

Of course.  That's why I labeled these "tangents"; they're just things
for future work that I noticed and didn't want to forget.

Bjorn
