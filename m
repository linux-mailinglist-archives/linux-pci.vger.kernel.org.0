Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0038F5353E0
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 21:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244410AbiEZTZQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 15:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241395AbiEZTZQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 15:25:16 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4823DFF5E;
        Thu, 26 May 2022 12:25:14 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id k186so3294115oia.2;
        Thu, 26 May 2022 12:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WkfpM0OKNjZ58Pj1oshsgsLk6TTCD0mFMGxTL7FchT0=;
        b=PZk5wviiUu0eaZb6DHAW56g2F3jB60uhCC8va2h5ABIG8GnP/MJw5FHe1P33DQvB6z
         m0jFZRToavtpN98i9z1bvYYlpwzcowLjw9lyOV0fmlxfnABnsJk/BWO7Dcun2TSmkltd
         X+UUXmHTzNikP7+7nl4yAJYxIZPk14C5r4itIFWiIfGg3XeehvHrtWSBMJiveNHQMoY2
         L/rTQfl7eJTxSY77S/hzCzlM7FCpTYsLqya0UNDhGM6kM+YC0wWRMlK5sTqYaHT/KJ+k
         tnCrOQBztJwRXAbbUat+sYhGJB5cy+DGMVGOyiwsHFhx3q1zHPdQQsd34LY1bAjiUYtX
         mgfg==
X-Gm-Message-State: AOAM5304364Ly1wj1pgZykiPKR3LWMANTm+18HD+KCqweaSkLX5JPzkD
        9Tr8K7cKAoMhW5CC246AkQ==
X-Google-Smtp-Source: ABdhPJwDT0RSUAQFO84pF/r9pGgZ/kRr5SVWgTMTnfmEvJYD8SkRikBzG6GQFlBDxfCrLmjBf6aiCg==
X-Received: by 2002:a05:6808:f8b:b0:326:a1ed:942e with SMTP id o11-20020a0568080f8b00b00326a1ed942emr2117240oiw.240.1653593114040;
        Thu, 26 May 2022 12:25:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id oa17-20020a056870bc1100b000f2ac7313d3sm29283oab.19.2022.05.26.12.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 12:25:13 -0700 (PDT)
Received: (nullmailer pid 184126 invoked by uid 1000);
        Thu, 26 May 2022 19:25:12 -0000
Date:   Thu, 26 May 2022 14:25:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Dutton <james.dutton@gmail.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1] PCI: brcmstb: Fix regression regarding missing PCIe
 linkup
Message-ID: <20220526192512.GH54904-robh@kernel.org>
References: <CANCKTBvqp7_MSG3aMpp6pmNoPUnYpH0c+8-r7Pzgebuzb4sZPA@mail.gmail.com>
 <20220523221036.GA130515@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523221036.GA130515@bhelgaas>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 23, 2022 at 05:10:36PM -0500, Bjorn Helgaas wrote:
> On Sat, May 21, 2022 at 02:51:42PM -0400, Jim Quinlan wrote:
> > On Sat, May 21,
> > 2CONFIG_INITRAMFS_SOURCE="/work3/jq921458/cpio/54-arm64-rootfs.cpio022
> > at 12:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Wed, May 18, 2022 at 03:42:11PM -0400, Jim Quinlan wrote:
> > > > commit 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice
> > > > voltage regulators")
> > > >
> > > > introduced a regression on the PCIe RPi4 Compute Module.  If the
> > > > PCIe endpoint node described in [2] was missing, no linkup would
> > > > be attempted, and subsequent accesses would cause a panic
> > > > because this particular PCIe HW causes a CPU abort on illegal
> > > > accesses (instead of returning 0xffffffff).
> > > >
> > > > We fix this by allowing the DT endpoint subnode to be missing.
> > > > This is important for platforms like the CM4 which have a
> > > > standard PCIe socket and the endpoint device is unknown.
> > >
> > > I think the problem here is that on the CM, we try to enumerate
> > > devices that are not powered up, isn't it?  The commit log should
> > > say something about that power situation and how the driver learns
> > > about the power regulators instead of just pointing at an DT
> > > endpoint node.
> > 
> > This is incorrect.  The regression occurred because the code
> > mistakenly skips PCIe-linkup if the PCI portdrv DT node does not
> > exist. With our RC HW, doing a config space access to bus 1 w/o
> > first linking up results in a CPU abort.  This regression has
> > nothing to do with EP power at all.
> 
> OK, I think I'm starting to see, but I'm still missing some things.
> 
> 67211aadcb4b ("PCI: brcmstb: Add mechanism to turn on subdev
> regulators") added pci_subdev_regulators_add_bus() as an .add_bus()
> method.  This is called by pci_alloc_child_bus(), and if the DT
> describes any regulators for the bridge leading to the new child bus,
> we turn them on.
> 
> Then 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage
> regulators") added brcm_pcie_add_bus() and made *it* the .add_bus()
> method.  It turns on the regulators and brings the link up, but it
> skips both if there's no DT node for the bridge to the new bus.
> 
> I guess RPi4 CM has no DT node to describe regulators, so we skip both
> turning them on *and* bringing the link up?
> 
> But above you say it's the *endpoint* node that doesn't exist.  The
> existing code looks like it's checking for the *bridge* node
> (bus->dev->of_node).  We haven't even enumerated the devices on the
> child bus, so we don't know about them at this point.
> 
> What happens if there is a DT node for the bridge, but it doesn't
> describe any regulators?  I assume regulator_bulk_get() will fail, and
> it looks like that might still keep us from bringing the link up?
> 
> I would think that lack of regulator description in the DT would mean
> that any regulators are always on and the OS doesn't need to do
> anything.
> 
> > >  What happens if we turn on the power but don't find any
> > >  downstream devices?
> >
> > They are turned off to conserve power.
> > 
> > > From looking at the code, I assume we just leave the power on.
> > > Maybe that's what you want, I dunno.
> 
> > For STB and Cable Modem products we do not leave the power on.  In
> > fact, our Cable Modem group was the first to request this feature.
> > It appears that the RPi CM4 always keeps endpoint power on but I do
> > not know for sure.
> 
> I'm confused.  Why can't we tell by looking at pcie-brcmstb.c?  All I
> know is what's in pcie-brcmstb.c; I have no idea which things apply to
> which products.
> 
> The only calls to regulator_bulk_disable() are in
> pci_subdev_regulators_remove_bus(), brcm_pcie_suspend(), and
> brcm_pcie_resume().  I don't think the fact that enumeration didn't
> find any devices necessarily leads to any of those.  What am I
> missing?  (This is really a tangent that isn't critical for fixing the
> regression.)
> 
> > > I added Rafael because this seems vaguely similar to runtime power
> > > management, and if we can integrate with that somehow, I'd sure like
> > > to avoid building a parallel infrastructure for it.
> > >
> > > The current path we're on is to move some of this code that's
> > > currently in pcie-brcmstb.c to the PCIe portdrv [0].  I'm a little
> > > hesitant about that because ACPI does just fine without it.  If we're
> > > adding new DT functionality that could not be implemented via ACPI,
> > > that's one thing.  But I'm not convinced this is that new.
> >
> > AFAICT, Broadcom STB and Cable Modem products do not have/use/want
> > ACPI.  We are fine with keeping this "PCIe regulator" feature
> > private to our driver and giving you speedy and full support in
> > maintaining it.
> 
> I don't mean that you should use ACPI, only that ACPI platforms can do
> this sort of power control using the existing PCI core infrastructure,
> and maybe there's a way for OF/DT platforms to hook into that same
> infrastructure to minimize the driver-specific work.  E.g., maybe
> there's a way to extend platform_pci_set_power_state() and similar to
> manage these regulators.

The big difference is ACPI abstracts how to control power for a device. 
The OS just knows D0, D3, etc. states. For DT, there is no such 
abstraction. You need device specific code to do device specific power 
management.

> > > [0] https://lore.kernel.org/r/20211110221456.11977-6-jim2101024@gmail.com
> > >
> > > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=215925
> > > > [2] Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > >
> > > > Fixes: 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")
> > > > Fixes: 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two funcs")
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=215925
> > > > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > > > ---
> > > >  drivers/pci/controller/pcie-brcmstb.c | 8 +++++---
> > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > > > index ba5c120816b2..adca74e235cb 100644
> > > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > > @@ -540,16 +540,18 @@ static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
> > > >
> > > >  static int brcm_pcie_add_bus(struct pci_bus *bus)
> > > >  {
> > > > -     struct device *dev = &bus->dev;
> > > >       struct brcm_pcie *pcie = (struct brcm_pcie *) bus->sysdata;
> > > >       int ret;
> > > >
> > > > -     if (!dev->of_node || !bus->parent || !pci_is_root_bus(bus->parent))
> > > > +     /* Only busno==1 requires us to linkup */
> > > > +     if ((int)bus->number != 1)
> > > >               return 0;
> > > >
> > > >       ret = pci_subdev_regulators_add_bus(bus);
> > > > -     if (ret)
> > > > +     if (ret) {
> > > > +             pcie->refusal_mode = true;
> > > >               return ret;
> > > > +     }
> > > >
> > > >       /* Grab the regulators for suspend/resume */
> > > >       pcie->sr = bus->dev.driver_data;
> > >
> > > IIUC, this path:
> > >
> > >   pci_alloc_child_bus
> > >     brcm_pcie_add_bus                   # .add_bus method
> > >       pci_subdev_regulators_add_bus     # in pcie-brcmstb.c for now
> > >         alloc_subdev_regulators         # in pcie-brcmstb.c for now
> > >         regulator_bulk_get
> > >         regulator_bulk_enable
> > >       brcm_pcie_linkup                  # bring link up
> > >
> > > is basically so we can leave power to downstream devices off, then
> > > turn it on when we're ready to enumerate those downstream devices.
> >
> > Yes  -- it is the "chicken-and-egg" problem.  Ideally, we would like
> > for the endpoint driver to turn on its own regulators, but even to
> > know which endpoint driver to probe we must turn on the regulator to
> > establish linkup.
> 
> I don't think having an endpoint driver turn on power to its device is
> the right goal.  

DT requires device specific code to control a specific device. That 
belongs in the driver for that device.

> As you said, if the power is off, we don't know
> whether there's an endpoint or what it is, so the driver isn't in the
> picture (I know sometimes endpoints are described in DT, and that
> might be needed for non-discoverable properties, but I don't think
> it's a good way to *enumerate* the device).

Well, I don't think there is another way. People have tried to hack 
around this for years. There's the 'generic' bindings with never ending 
properties added one-by-one to try to handle new ctrl or timing needs 
for new device. Or there's the pseudo virtual platform device and driver 
to do power management on the side.

The only way generic control by the upstream (on the bus) device works 
is if there's a standard connector which has standard power supplies, 
reset, etc. which we know the timing for ('cause it's in the PCI spec).


> I don't know much about ACPI power management, but I kind of think it
> turns on power to *everything* initially so we can enumerate all the
> devices (Rafael or others, please correct me!)  After enumeration, we
> can turn off devices we don't need, and the power management framework 
> already supports turning devices on again when we use them.

That's basically requiring the firmware turn on everything before boot. 
Might work for some, but probably not everyone because they can't change 
firmware. There's also the issue that the kernel turns off unused clocks 
and regulators at late_initcall which is a problem if the PCI device's 
driver is a module.

Rob
