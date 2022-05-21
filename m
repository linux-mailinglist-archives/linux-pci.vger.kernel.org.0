Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A4E52FED9
	for <lists+linux-pci@lfdr.de>; Sat, 21 May 2022 20:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiEUSv7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 May 2022 14:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344774AbiEUSv4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 21 May 2022 14:51:56 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CCA5C359;
        Sat, 21 May 2022 11:51:55 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id v66so13485863oib.3;
        Sat, 21 May 2022 11:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iVL4I5m+wb94H8NYF6zCO0ltg5mRlY60c0R22l/iI+A=;
        b=CnSWn5tWuaro/W8HifGINIM6J08IrorqwDiBFEh0twJ5xg6tcdtXrDIDyCGy++un+4
         ORI8IfjGjth1rmsOV5dWV/R5edptaHXrS19xoj/nvUkPf/wigy74oq4TLp9bNHbxaHAj
         9VPzuq/1vXuSy4kgYX5KEyJf1jfDCew6Jfvj56Y5pl6ISCbckXKJwd03yjq/sSrZ/Bm7
         2gt+GyZtuykoxy/oqRpy+ju+yESnpF14Q2kfsbnp26YtxLjsEDA7PdBbLgFAdJIVSbmf
         4HOuF9npSWsOKO6jSLCrVPLVBSG3hBX7FhsK7gzOvLNSxnVGH7/LUrifAh4HTiL2WsXs
         2Vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iVL4I5m+wb94H8NYF6zCO0ltg5mRlY60c0R22l/iI+A=;
        b=RjigCg59XV8HBMJT1+83EBDkli16v1qmREaxuYCRWkoZ1iFprXMpy3+E2qantqL6fu
         7RAOl28ngHCOVMyjCcjpDzdUoDbLE+jM4KwedZ92bIBHm+djA+b2r20tgqNA2Hp7stbW
         xIsyTOlhAg/Obyt9vE/tgS+qzgqBSEiJbZ/KpicspAyi34BBxBj2wKEp4iU3JwKIEko8
         Zm1BNrQUa7Rymg4oZeTrGuH/CbxEsTVe9m2ACIs+TvnJhFJ27W0D3SyImHGUc8HaAeo1
         z+zh/x4dlaGNYzzLbY/o1e4MlZXDF9A/J1PWuYX/mwTdpil7u6z32ooUFAiU24iSEd8j
         ENtg==
X-Gm-Message-State: AOAM532esmUEK9HTpMK2KZ1VVflsrsUgWg8gFvxOUfHfVa3lCgqltnSu
        FeNLS9hXinqNZLoIQK7PfRUbMApUJID8q+xRkGI=
X-Google-Smtp-Source: ABdhPJz9GCCHInZssTuhbKPJnao681PuLaqBKrfaVBud1jisvwLRtYh9utUbkj1Z7DIJpk7HQmopaI+jZDLldFQIYFM=
X-Received: by 2002:a05:6808:148e:b0:326:abe8:af49 with SMTP id
 e14-20020a056808148e00b00326abe8af49mr8611096oiw.73.1653159114268; Sat, 21
 May 2022 11:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220518194211.20143-1-jim2101024@gmail.com> <20220521164303.GA106705@bhelgaas>
In-Reply-To: <20220521164303.GA106705@bhelgaas>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Sat, 21 May 2022 14:51:42 -0400
Message-ID: <CANCKTBvqp7_MSG3aMpp6pmNoPUnYpH0c+8-r7Pzgebuzb4sZPA@mail.gmail.com>
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

On Sat, May 21,
2CONFIG_INITRAMFS_SOURCE="/work3/jq921458/cpio/54-arm64-rootfs.cpio022
at 12:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rafael, linux-pm because I think there are interesting power
> management questions here]
>
> On Wed, May 18, 2022 at 03:42:11PM -0400, Jim Quinlan wrote:
> > commit 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")
> >
> > introduced a regression on the PCIe RPi4 Compute Module.  If the PCIe
> > endpoint node described in [2] was missing, no linkup would be attempted,
> > and subsequent accesses would cause a panic because this particular PCIe HW
> > causes a CPU abort on illegal accesses (instead of returning 0xffffffff).
> >
> > We fix this by allowing the DT endpoint subnode to be missing.  This is
> > important for platforms like the CM4 which have a standard PCIe socket and
> > the endpoint device is unknown.
>
> I think the problem here is that on the CM, we try to enumerate
> devices that are not powered up, isn't it?  The commit log should say
> something about that power situation and how the driver learns aboutCONFIG_INITRAMFS_SOURCE="/work3/jq921458/cpio/54-arm64-rootfs.cpio
> the power regulators instead of just pointing at an DT endpoint node.
Hi Bjorn,

This is incorrect.  The regression occurred because the code mistakenly
skips PCIe-linkup if the PCI portdrv DT node  does not exist. With our
RC HW, doing a config space access to bus 1  w/o first linking up results
in a  CPU abort.  This regression has nothing to do with EP power at all.

The RPi does not use the "PCIe regulator" feature of my original patchset.
It is currently used only by our STB and Cable Modem  products.

>
> I guess the intent of this patch is to turn on the power to downstream
> devices before enumerating them?
Are you referring to my original patchset or the one I just submitted?
 If the former,
yes.  If the latter, no.

>  What happens if we turn on the power
> but don't find any downstream devices?
They are turned off to conserve power.

> From looking at the code, I
> assume we just leave the power on.  Maybe that's what you want, I
> dunno.
For STB and Cable Modem products we do not leave the power on.  In
fact, our Cable
Modem group was the first to request this feature.   It appears that the RPi CM4
always keeps endpoint power on but I do not know for sure.

>
> I added Rafael because this seems vaguely similar to runtime power
> management, and if we can integrate with that somehow, I'd sure like
> to avoid building a parallel infrastructure for it.
>
> The current path we're on is to move some of this code that's
> currently in pcie-brcmstb.c to the PCIe portdrv [0].  I'm a little
> hesitant about that because ACPI does just fine without it.  If we're
> adding new DT functionality that could not be implemented via ACPI,
> that's one thing.  But I'm not convinced this is that new.
AFAICT, Broadcom STB and Cable Modem products do not have/use/want ACPI.
We are fine with keeping this "PCIe regulator" feature private to our driver and
giving you speedy and full support in maintaining it.

> That's a longer term question.  In the short term we need to fix the
> regression.  More specifics about that below.
>
> [0] https://lore.kernel.org/r/20211110221456.11977-6-jim2101024@gmail.com
>
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=215925
> > [2] Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> >
> > Fixes: 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")
> > Fixes: 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two funcs")
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=215925
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index ba5c120816b2..adca74e235cb 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -540,16 +540,18 @@ static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
> >
> >  static int brcm_pcie_add_bus(struct pci_bus *bus)
> >  {
> > -     struct device *dev = &bus->dev;
> >       struct brcm_pcie *pcie = (struct brcm_pcie *) bus->sysdata;
> >       int ret;
> >
> > -     if (!dev->of_node || !bus->parent || !pci_is_root_bus(bus->parent))
> > +     /* Only busno==1 requires us to linkup */
> > +     if ((int)bus->number != 1)
> >               return 0;
> >
> >       ret = pci_subdev_regulators_add_bus(bus);
> > -     if (ret)
> > +     if (ret) {
> > +             pcie->refusal_mode = true;
> >               return ret;
> > +     }
> >
> >       /* Grab the regulators for suspend/resume */
> >       pcie->sr = bus->dev.driver_data;
>
> IIUC, this path:
>
>   pci_alloc_child_bus
>     brcm_pcie_add_bus                   # .add_bus method
>       pci_subdev_regulators_add_bus     # in pcie-brcmstb.c for now
>         alloc_subdev_regulators         # in pcie-brcmstb.c for now
>         regulator_bulk_get
>         regulator_bulk_enable
>       brcm_pcie_linkup                  # bring link up
>
> is basically so we can leave power to downstream devices off, then
> turn it on when we're ready to enumerate those downstream devices.
Yes  -- it is the "chicken-and-egg" problem.  Ideally, we would like
for the endpoint
driver to turn on its own regulators, but even to know which endpoint
driver to probe
we must turn on the regulator to establish linkup.

> I think the brcmstb root bus is always bus 0, it only has a single
> Root Port on the root bus, and it always leads to bus 1, so it sort of
> makes sense that we only need to turn on power when we're about to
> scan "bus->number == 1".
Correct.

>
> But this power management seems like a pattern that other controllers
> will use.  Other controllers will have several Root Ports, so checking
> the bus number won't work for them.  Instead of checking the bus
> number, I think brcmstb should check more directly for a power
> regulator.
I agree.  That is why I said that we should consider removing the "busno==1"
conditional if we want this feature for general use.  If you want,
I can submit a V2 that removes this conditional.

I'm guessing here but I think the Rockchip folks could use this "pcie
regulator"  feature.
They got regulator DT properties in their PCIe RC DT node upstreamed
but we were denied for trying the same approach.

>
> Tangent 1: I think this means a downstream device goes from D3cold to
> D0uninitialized?  Does this code account for the required delays
> accesses to the device?  I see some in brcm_pcie_linkup(), but I don't
> see anything that looks like Tpvperl (the time PERST# must remain
> asserted after power becomes valid) or Tperst (when asserted, PERST#
> must remain asserted at least this long) (both from PCIe r6.0, sec
> 6.6.1).
I have a series of patches coming up that address some of these concerns.
Can we please take this up then but allow us to escape "revert jail" first?
I promise I will copy your tangents and address all of them with the
future patchset.

>
> Tangent 2: "brcm_pcie_link_up()" makes sense -- it's the conventional
> name for the simple boolean function that tells us whether the link is
> up.  "brcm_pcie_linkup()", which *brings* the link up, is confusing
> because it's too similar to "brcm_pcie_link_up()".  The conventional
> name for this would be "brcm_pcie_start_link()".
I will fix this in the future patchset.

>
> Tangent 3: There are fewer than 20 forward function declarations in
> drivers/pci/controller/, and 9 of them are in pcie-brcmstb.c.  It's a
> lot easier to maintain all these drivers if they use a common style.
> Generally speaking, Linux code orders function definitions to avoid
> the need for forward declarations.
I will improve the situation in the future patchset

Regards,
Jim Quinlan
Broadcom STB
>
> Bjorn
