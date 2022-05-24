Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF857532F43
	for <lists+linux-pci@lfdr.de>; Tue, 24 May 2022 18:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbiEXQzE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 May 2022 12:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbiEXQzD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 May 2022 12:55:03 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1B36D3B5;
        Tue, 24 May 2022 09:55:01 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id e189so22078157oia.8;
        Tue, 24 May 2022 09:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q7MNyK+VOj693sCizrtazs9RC32iyg0d6aBiSHrRtQY=;
        b=cfYQF+ug6IqHD1NhjD3HnOxR801AE9jo7vN6y2k9kmGuDskNHuzRjT7nKWdtgc6cYN
         HEjVzueSrMd1HGFoNxj5qjiHPA4t4LKcZ5WgITSffNz+M6Abt5wxcmTUWALywcS2UAFb
         a9/GwL3DLfmv+JSl9r6L/Sh/QVDh7Q8AXvbhFwOUpJhum95rE7DknN9+ZcvQEXN4f58B
         3+DUIB/3DPzgV20vzK5GmzLGkQHGkcYMnxsOoL+A29BGYU0cF7qOVODK2MNE3WTe8u5c
         cihsf+qW6fjYy+4s+FY51ead5YmYYTcg0+EQGbkTR1pUS4h/5T2Ue1a+xuzX8VKXQkFy
         TeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q7MNyK+VOj693sCizrtazs9RC32iyg0d6aBiSHrRtQY=;
        b=SRZEfCb56vCGBTjiy6p53rCn7z0510ksaoY9xYJkF8WQNkzM7YuygZQEcTZ71OQhiV
         wZ1slqjJi2j98d0CQrdoj7bgMJRZf54LuC4Nd36em3jIbAJWIwwygx+agzT7t2EcpE9g
         sCiPvSIrKFMLA0O3TtMRbnYIWT6lMRuPm/W/yvQQ4PDjAlxwSieJIAGKQa8w2XikEnRH
         Chs/IrU/Ony+c6sZJ26jqAJpv68IJmTmMxRtwOcazRSlJkDOFCgfaAKpjq+9Rry6IEWy
         xl3yRfWhmJ/txQL5KkMvGK58muMsWYp92bCLKcPG9Yjzuq5f8xCb3AaPxThE/dKt5fRS
         l+6A==
X-Gm-Message-State: AOAM533V2nbg3qaIFY7UMvz9tDVYqRT4o9yzYWzrBcFKZfKPRgsyRPpr
        D4FlQe+lOIlWzV681dVAObrjwovgWBZVwIqejow=
X-Google-Smtp-Source: ABdhPJzLd14aA8Ne3YkIl8lR0lmmRULiJISJEp1zMZ/yYKn5fRo54CO/iO7HRDbHN4505md4O6TUntvWwVK9EAVibcU=
X-Received: by 2002:a54:4688:0:b0:325:9a36:ecfe with SMTP id
 k8-20020a544688000000b003259a36ecfemr2969867oic.96.1653411301118; Tue, 24 May
 2022 09:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <CANCKTBvqp7_MSG3aMpp6pmNoPUnYpH0c+8-r7Pzgebuzb4sZPA@mail.gmail.com>
 <20220523221036.GA130515@bhelgaas>
In-Reply-To: <20220523221036.GA130515@bhelgaas>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Tue, 24 May 2022 12:54:48 -0400
Message-ID: <CANCKTBsEjkbdWCB4D22iamPr7YP0qUX=M1dZNNgxkfk1EwjjZQ@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: brcmstb: Fix regression regarding missing PCIe linkup
To:     Bjorn Helgaas <helgaas@kernel.org>
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
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 23, 2022 at 6:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
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

Hi Bjorn,

Yes, I meant it to skip the turning on of the regulators if the DT
node was missing
but I failed to notice that it would also skip the pcie linkup as well.  As you
may have guessed, all of my test systems have the PCIe root port
DT node.

>
> I guess RPi4 CM has no DT node to describe regulators, so we skip both
> turning them on *and* bringing the link up?

Yes. One repo did not have this node (Cyril/debina?), one did
(https://github.com/raspberrypi/firmware/tree/master/boot).
Of course there is nothing wrong with omitting the node; it should
have pcie linkup regardless.

>
> But above you say it's the *endpoint* node that doesn't exist.  The
> existing code looks like it's checking for the *bridge* node
> (bus->dev->of_node).  We haven't even enumerated the devices on the
> child bus, so we don't know about them at this point.
You are absolutely correct and I must change the commit message
to say the "root port DT node".   I'm sorry; this mistake likely did not
help you understand the fix. :-(

>
> What happens if there is a DT node for the bridge, but it doesn't
> describe any regulators?  I assume regulator_bulk_get() will fail, and
> it looks like that might still keep us from bringing the link up?
The regulator_bulk_get()  func does not fail if the regulators are not
present.  Instead it "gets"
a dummy device and issues a warning per missing regulator.
A version of my pullreq submitted code to prescan the DT node and call
regulator_bulk_get() with
only the names of the regulators present, but IIRC this was NAKd.
Hopefully I will not be swamped with RPi developers'  emails when they
think these warnings are an issue.

>
> I would think that lack of regulator description in the DT would mean
> that any regulators are always on and the OS doesn't need to do
> anything.pci_subdev_regulators_remove_bus
I agree.

>
> > >  What happens if we turn on the power but don't find any
> > >  downstream devices?
> >
> > They are turned off to conserve power.pci_subdev_regulators_remove_bus
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

I was just adding  background information but I see that I really
didn't answer your
question.   Allow me another chance:

When brcm_pcie_add_bus() is invoked, we will "get" and enable any
regulators that are present in the DT node.  If the busno==1, we will
will also attempt pcie-linkup.  If PCIe linkup fails, which can happen for
multiple reasons but most due to a  missing device, we turn
on "refusal" mode to prevent our unforgiving PCIe HW from causing an
abort on any subsequent PCIe config-space accesses.  Further,
a failed linkup will have brcm_pcie_probe() stopping and removing
the root bus, which in turn invokes  brcm_pcie_remove_bus() (actually
named pci_subdev_regulators_remove_bus() as it may someday find its
way into bus.c), which invokes regulator_bulk_disable() on any
regulators that were enabled by the probe.

>
> The only calls to regulator_bulk_disable() are in
> pci_subdev_regulators_remove_bus(), brcm_pcie_suspend(), and
> brcm_pcie_resume().  I don't think the fact that enumeration didn't
> find any devices necessarily leads to any of those.  What am I
> missing?  (This is really a tangent that isn't critical for fixing the
> regression.)
If there was no linkup during the probe, the probe follows this
path before it returns with error:

brcm_pcie_probe()
    brcm_pcie_remove()
        pci_stop_root_bus();
        pci_remove_root_bus();
            pci_remove_bus_device()
                pci_remove_bus_device()
                    pci_subdev_regulators_remove_bus()
                        regulator_bulk_disable()


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

Got it.

Unless you object, I plan on sending you a v2 of my regression fix which will
correct the commit message, change the "if (busno == 1)" conditional to
only guard the pcie linkup call, and add further comments.

I have noted and will also address your other concerns and suggestions
in a future
patchset as I think it is best that I get my hands on a CM4 board
before I submit
any more changes.

Kind Regards,
Jim Quinlan
Broadcom STB
>
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
> the right goal.  As you said, if the power is off, we don't know
> whether there's an endpoint or what it is, so the driver isn't in the
> picture (I know sometimes endpoints are described in DT, and that
> might be needed for non-discoverable properties, but I don't think
> it's a good way to *enumerate* the device).
>
> I don't know much about ACPI power management, but I kind of think it
> turns on power to *everything* initially so we can enumerate all the
> devices (Rafael or others, please correct me!)  After enumeration, we
> can turn off devices we don't need, and the power management framework
> already supports turning devices on again when we use them.
>
> > > I think the brcmstb root bus is always bus 0, it only has a single
> > > Root Port on the root bus, and it always leads to bus 1, so it sort of
> > > makes sense that we only need to turn on power when we're about to
> > > scan "bus->number == 1".
> >
> > Correct.
> >
> > > But this power management seems like a pattern that other
> > > controllers will use.  Other controllers will have several Root
> > > Ports, so checking the bus number won't work for them.  Instead of
> > > checking the bus number, I think brcmstb should check more
> > > directly for a power regulator.
> >
> > I agree.  That is why I said that we should consider removing the
> > "busno==1" conditional if we want this feature for general use.  If
> > you want, I can submit a V2 that removes this conditional.
>
> If it's as easy as dropping a needlessly platform-dependent check, we
> should absolutely do it.  Are you saying the patch would just become
> this?
>
> > I have a series of patches coming up that address some of these concerns.
> > Can we please take this up then but allow us to escape "revert jail" first?
>
> Of course.  That's why I labeled these "tangents"; they're just things
> for future work that I noticed and didn't want to forget.
>
> Bjorn
