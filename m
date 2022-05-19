Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2453152DC4A
	for <lists+linux-pci@lfdr.de>; Thu, 19 May 2022 20:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbiESSEd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 14:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiESSEc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 14:04:32 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355C557B3D;
        Thu, 19 May 2022 11:04:31 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-edf3b6b0f2so7685491fac.9;
        Thu, 19 May 2022 11:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ac+RQQyS8m3R/YRla76MBJC/2wCOQ77Ox9vvKC22in8=;
        b=KG0KUtyYvnjFjgAo9ZbMqZFIRqckE3H77XI6u40oIH5pnAqVgKs24sr5souiKfqwZ0
         eo6HWwuu3XrcLs0AF9dSPR1Vw6QBBDPPQlZZ58MjNCnJKRwd1+3zYjmwDsxafHYmu74H
         fArinfpDTlFWZ26LEam46duEhxQY3/1kSGJT2COASBJscuMu1zxQgfLSXdoQCg2i6vO3
         KO4aHhfktLUAjAlxlQUye8UjBZD08o2WXN9FVUQeaPSe+R3OiJRAcrPMixmkzU+vpj4j
         f8O7USAVld1RbYnN8TbK+6x53gHT3AcrRr0YxVuvyFR+kvuKdqN3+xadB4VfvqHvGnIc
         +rTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ac+RQQyS8m3R/YRla76MBJC/2wCOQ77Ox9vvKC22in8=;
        b=K1/gbE0ts1R+eA8jOdS+60LlABtU+0TFdqhZ5Y0pyOvwcqr8N/tG6EDlgtBTCXxbeg
         gYWODaYzcm8jHu8wavvS2N7k4gRgFbQssG9AXafVQl1PIP9MhUEZ9LtQMheYN40YstVU
         TJNLcVsQ5zTRpitXZZppL6FvspidErgrA66E6GMbuLptwsMTOCljIkC4jkz416Q64mBH
         7ZZdGfuYIVWb2XbQrqf9oJhh3m7dh2/EaEM0vePYF7Re2SOwVSDNd32ZZOw1rSCqEiW3
         Px66xVwBLJX6OFf8aYRID7i4KGDITVe/2itLB2RhNrZstgUQVBo7Uh69eOultTsUaipH
         4sJg==
X-Gm-Message-State: AOAM531MEhTAdxS2onhNTNlvLMN+ECngIelc9CvStPKFzLdmiutYTq1L
        wsDGn/2EomKSBYzQX/X/bJvUfbsbHFSkFSWtMzLkyAPwKGtqRA==
X-Google-Smtp-Source: ABdhPJwVHU2GGx4rK43KLGKk99G5D7szID68cIIrTXkzpzlyJbYyq7gM+z7XRJa8CbKlg4M839b10q+pkHHvIKgjUxg=
X-Received: by 2002:a05:6870:3508:b0:f1:f7ab:acfe with SMTP id
 k8-20020a056870350800b000f1f7abacfemr2227100oah.96.1652983470531; Thu, 19 May
 2022 11:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220518194211.20143-1-jim2101024@gmail.com> <20220519161053.GA24069@bhelgaas>
In-Reply-To: <20220519161053.GA24069@bhelgaas>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Thu, 19 May 2022 14:04:18 -0400
Message-ID: <CANCKTBsmtTwNcAYR6bkM4b__sJXXd1U++KrMTgkDbuiyX=UKLQ@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: brcmstb: Fix regression regarding missing PCIe linkup
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Dutton <james.dutton@gmail.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Thu, May 19, 2022 at 12:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+to Rob for my naive DT questions]
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
> I assume you're referring specifically to making this optional in the
> DT:
>
>     /* PCIe endpoint */
>     pci-ep@0,0 {
>             assigned-addresses =
>                 <0x82010000 0x0 0xf8000000 0x6 0x00000000 0x0 0x2000>;
>             reg = <0x0 0x0 0x0 0x0 0x0>;
>             compatible = "pci14e4,1688";
>     };
>
Actually, both that and the node that contains it, i.e. pci@0,0.

> I don't really understand what's going on here, but I assume this
> describes a [14e4:1688] device, which the PCI database says is a
> NetXtreme BCM5761 10/100/1000BASE-T Ethernet
> (https://pci-ids.ucw.cz/read/PC/14e4/1688)

Yes.  I use an assortment of PCIe endpoint devices for testing.
>
> Why do you *ever* need this stanza?  "git grep pci-ep
> Documentation/devicetree/bindings/pci/" says no other DT has one.

You'll find one in
"Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.txt", line
~240, although this
is a board DTS example.  They use "pci@0,0" for endpoint 02:00.0,
whereas I find "pci-ep" to
be more descriptive.

Note that  the "pci-ep@0,0" node is in the "example" section of
brcm,stb-pcie.yaml; but nothing
says it is required.  I believe it was added it because a reviewer
asked me to, but if I remember
incorrectly,  it does illustrate that "pcie@0,0" is not the endpoint
device node as many would think.

Note that the regression occurred because "pci@0,0" was missing, not
"pci-ep@0,0" as I first thought.

>
> If the link does come up, I assume normal PCI enumeration would
> discover the [14e4:1688] or whatever device is plugged into a CM4
> socket, and it would read and assign BARs as needed.  Why do we need
> to describe any of this in the DT?
The only  reason one needs to describe this node is  when a regulator is
under the root port, in my case pci@0,0.  In the example this is

                            vpcie3v3-supply = <&vreg7>;

This was the entire reason behind the original patchset.
>
> If the link doesn't come up, it looks like you set the "refusal_mode"
> so subsequent config accesses fail gracefully instead of with a CPU
> abort.
Yes.
>
> [Tangent: since you never clear "refusal_mode", I assume there's no
> possibility of hot-adding a device.  A device must be put in the slot
> before power-up, right?]
Yes, we do not have the HW functionality to support hotplug.

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
>
> It's a big leap from "DT endpoint is optional" to "bus->number == 1 if
> DT endpoint is missing" (if that's even what it means).  Help me
> connect the dots here.
The brcm_pcie_add_bus() function returned immediately and skipped linkup
when (!dev->of_node). That clause was removed from that function, which
is the true fix for the regression,  but you can see thiscondition
is still tested in pci_subdev_regulators_add_bus().

I added the "busno != 1" as an added precaution,
as the brcmstb RC driver only cares about pcie linkup and turning on
regulators when busno==1.

If this regulator mechanism becomes a feature any RC driver may use --
as it was in
v8 of the original patch but was moved to pcie-brcamstb only to avoid conflicts
with Pali's upcoming RC functionality improvements -- I would probably consider
removing the busno==1 clause.

Regards and thanks,
Jim Quinlan
Broadcom S


>
> I *guess* this is really saying "we only want to bring the link up for
> RPs"?
>
> And "bus->number == 1" assumes the RP is on bus 0, there's only one
> RP, and that RP's secondary bus is 1?  So it's only in that case
> (we're adding the secondary bus of the RP), that we need to manually
> bring up the link?
>
> >               return 0;
> >
> >       ret = pci_subdev_regulators_add_bus(bus);
> > -     if (ret)
> > +     if (ret) {
> > +             pcie->refusal_mode = true;
>
> Is this related?  It doesn't *look* related to making the DT endpoint
> optional.
>
> >               return ret;
> > +     }
> >
> >       /* Grab the regulators for suspend/resume */
> >       pcie->sr = bus->dev.driver_data;
> >
> > base-commit: ef1302160bfb19f804451d0e919266703501c875
> > prerequisite-patch-id: 23a425390a4226bd70bbff459148c80f5e28379c
> > prerequisite-patch-id: e3f2875124b46b2b1cf9ea28883bf0c864b79479
> > prerequisite-patch-id: 9cdd706ee2038c7b393c4d65ff76a1873df1ca03
> > prerequisite-patch-id: 332ac90be6e4e4110e27bdd1caaff212c129f547
> > prerequisite-patch-id: 32a74f87cbfe9e8d52c34a4edeee6d271925665a
> > prerequisite-patch-id: f57cdf7ec7080bb8c95782bc7c3ec672db8ec1ce
> > prerequisite-patch-id: 18dc9236aed47f708f5c854afd832f3c80be5ea7
> > prerequisite-patch-id: dd147c6854c4ca12a9a8bd4f5714968a59d60e4e
> > --
> > 2.17.1
> >
