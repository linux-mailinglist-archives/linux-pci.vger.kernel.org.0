Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3E052DE00
	for <lists+linux-pci@lfdr.de>; Thu, 19 May 2022 21:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiEST6Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 15:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiEST6Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 15:58:16 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6F95FF13;
        Thu, 19 May 2022 12:58:14 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id y66so1676010oia.1;
        Thu, 19 May 2022 12:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bNwZ2EL5l9pqOGLmXHwS/SvVt+YGwEiHYwLMjnHme0g=;
        b=CT128T0ENZ1kod4vIh+TAdBdple26wIN5+dSwQn6ibzKvp8wufDONSNbKVx60faDiO
         9EDQm7hVNFeeWpSN1jL+hEjaaSa5/9NJE3492tAu18nyRwifP4+wujmTmtMDFe97XFxU
         9tCOi6bTI4fcu1E4MyCntBnLuws/LFJuiO9f964BiX6drJPbDykIYgxC6rDgjJKV5DGz
         QuK2cQWn3KmoO+cWzKHXTloxY4xyCkItQWd2FOvxtFHA2Vl3EcEhxydTKskW0s5hBcZe
         Wa8UOaG1/aQreMNblE5RXKt6CDIa9rpXlhdSrQieJUUG5/yefL+82Ls3nIw+Ofs7tSlK
         V++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bNwZ2EL5l9pqOGLmXHwS/SvVt+YGwEiHYwLMjnHme0g=;
        b=rTYIq2aq6pzYo8AYPmwOs9HOGSR0CD91C18nh0jhDHnTax7Zmmp3Wt+xvnfYZ8bUAS
         UfIMwVFMSWXfagVAAsRBPY2CP3M+T4EOarTRpR3gGK85WDizfAVufhjzNttY5tzTUU+s
         P8gJCj3lOZsfi0ccKFwr0pXkvK2nWs5BfsrQuhhHW8KDntm5XYCvYc8NAibWk9zZp2bH
         7mnArKomtBrRX1Pn5LLi2Dfgw308PoVvS+JWvehuvELSSQYiCGRSIOWf0gNaoeVhn4e0
         l5zUJZyPbSRCLrFXwgrlw7PJe3H/L94swQfMu5Pkjl1NZmy7KjfRhXhf4L1+Ry4ESNES
         D84g==
X-Gm-Message-State: AOAM530YixE1nUpQkjr1jSAyOOYYnFs7ah1i0mFXtJ/lVlH7+pFSI9sP
        KgocOyYJ/7Npit9MmujAlEc0yS3mbIWRJINPGHs=
X-Google-Smtp-Source: ABdhPJyRYb0iYBT1siYFoH9meYhzmoo/50aNTb3ItoRVR3vElGVH+zzBidNJVfI14JMomY26RpXQ5WpKnccxD+3uldQ=
X-Received: by 2002:a05:6808:148e:b0:326:abe8:af49 with SMTP id
 e14-20020a056808148e00b00326abe8af49mr3698725oiw.73.1652990293708; Thu, 19
 May 2022 12:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220518194211.20143-1-jim2101024@gmail.com> <20220519161053.GA24069@bhelgaas>
 <CANCKTBsmtTwNcAYR6bkM4b__sJXXd1U++KrMTgkDbuiyX=UKLQ@mail.gmail.com>
In-Reply-To: <CANCKTBsmtTwNcAYR6bkM4b__sJXXd1U++KrMTgkDbuiyX=UKLQ@mail.gmail.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Thu, 19 May 2022 15:58:02 -0400
Message-ID: <CANCKTBuz9FG-aGuwM-thFgkAyTi480=1j78DpjWUkgU4UDuurg@mail.gmail.com>
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

On Thu, May 19, 2022 at 2:04 PM Jim Quinlan <jim2101024@gmail.com> wrote:
>
> On Thu, May 19, 2022 at 12:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+to Rob for my naive DT questions]
> >
> > On Wed, May 18, 2022 at 03:42:11PM -0400, Jim Quinlan wrote:
> > > commit 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")
> > >
> > > introduced a regression on the PCIe RPi4 Compute Module.  If the PCIe
> > > endpoint node described in [2] was missing, no linkup would be attempted,
> > > and subsequent accesses would cause a panic because this particular PCIe HW
> > > causes a CPU abort on illegal accesses (instead of returning 0xffffffff).
> > >
> > > We fix this by allowing the DT endpoint subnode to be missing.  This is
> > > important for platforms like the CM4 which havedev->dev.of_nodei a standard PCIe socket and
> > > the endpoint device is unknown.
> >
> > I assume you're referring specifically to making this optional in the
> > DT:
> >
> >     /* PCIe endpoint */
> >     pci-ep@0,0 {
> >             assigned-addresses =
> >                 <0x82010000 0x0 0xf8000000 0x6 0x00000000 0x0 0x2000>;
> >             reg = <0x0 0x0 0x0 0x0 0x0>;
> >             compatible = "pci14e4,1688";
> >     };
> >
> Actually, both that and the node that contains it, i.e. pci@0,0.
>
> > I don't really understand what's going on here, but I assume this
> > describes a [14e4:1688] device, which the PCI database says is a
> > NetXtreme BCM5761 10/100/1000BASE-T Ethernet
> > (https://pci-ids.ucw.cz/read/PC/14e4/1688)
>
> Yes.  I use an assortment of PCIe endpoint devices for testing.
> >
> > Why do you *ever* need this stanza?  "git grep pci-ep
> > Documentation/devicetree/bindings/pci/" says no other DT has one.
>
> You'll find one in
> "Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.txt", line
> ~240, although this
> is a board DTS example.  They use "pci@0,0" for endpoint 02:00.0,
> whereas I find "pci-ep" to
> be more descriptive.
>
> Note that  the "pci-ep@0,0" node is in the "example" section of
> brcm,stb-pcie.yaml; but nothing
> says it is required.  I believe it was added it because a reviewer
> asked me to, but if I remember
> incorrectly,  it does illustrate that "pcie@0,0" is not the endpoint
> device node as many would think.
>
> Note that the regression occurred because "pci@0,0" was missing, not
> "pci-ep@0,0" as I first thought.
>
> >
> > If the link does come up, I assume normal PCI enumeration would
> > discover the [14e4:1688] or whatever device is plugged into a CM4
> > socket, and it would read and assign BARs as needed.  Why do we need
> > to describe any of this in the DT?
Hi Bjorn,

I was remiss in not mentioning our biggest actual use of specifying
this sub-subnode: to pass info to the endproint driver.  For example:

pcie@1000110000 {
        compatible = "brcm,bcm7211-pcie";
        /* ... */

        pci@0,0 {
                compatible = "pciclass,0604";
                /* ... */

                pci-ep@0,0 {
                        local-mac-address = [ 00 10 18 d0 3c 51 ];
                        reg = <0x10000 0x0 0x0 0x0 0x0>;
                };
        };
};

The PCIe endpoint driver can just invoke

        of_get_mac_address(dev->dev.of_node, &addr)


Regards,
Jim Quinlan
Broadcom STB


> The only  reason one needs to describe this node is  when a regulator is
> under the root port, in my case pci@0,0.  In the example this is
>
>                             vpcie3v3-supply = <&vreg7>;
>
> This was the entire reason behind the original patchset.
> >
> > If the link doesn't come up, it looks like you set the "refusal_mode"
> > so subsequent config accesses fail gracefully instead of with a CPU
> > abort.
> Yes.
> >
> > [Tangent: since you never clear "refusal_mode", I assume there's no
> > possibility of hot-adding a device.  A device must be put in the slot
> > before power-up, right?]
> Yes, we do not have the HW functionality to support hotplug.
>
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
> >
> > It's a big leap from "DT endpoint is optional" to "bus->number == 1 if
> > DT endpoint is missing" (if that's even what it means).  Help me
> > connect the dots here.
> The brcm_pcie_add_bus() function returned immediately and skipped linkup
> when (!dev->of_node). That clause was removed from that function, which
> is the true fix for the regression,  but you can see thiscondition
> is still tested in pci_subdev_regulators_add_bus().
>
> I added the "busno != 1" as an added precaution,
> as the brcmstb RC driver only cares about pcie linkup and turning on
> regulators when busno==1.
>
> If this regulator mechanism becomes a feature any RC driver may use --
> as it was in
> v8 of the original patch but was moved to pcie-brcamstb only to avoid conflicts
> with Pali's upcoming RC functionality improvements -- I would probably consider
> removing the busno==1 clause.
>
> Regards and thanks,
> Jim Quinlan
> Broadcom S
>
>
> >
> > I *guess* this is really saying "we only want to bring the link up for
> > RPs"?
> >
> > And "bus->number == 1" assumes the RP is on bus 0, there's only one
> > RP, and that RP's secondary bus is 1?  So it's only in that case
> > (we're adding the secondary bus of the RP), that we need to manually
> > bring up the link?
> >
> > >               return 0;
> > >
> > >       ret = pci_subdev_regulators_add_bus(bus);
> > > -     if (ret)
> > > +     if (ret) {
> > > +             pcie->refusal_mode = true;
> >
> > Is this related?  It doesn't *look* related to making the DT endpoint
> > optional.
> >
> > >               return ret;
> > > +     }
> > >
> > >       /* Grab the regulators for suspend/resume */
> > >       pcie->sr = bus->dev.driver_data;
> > >
> > > base-commit: ef1302160bfb19f804451d0e919266703501c875
> > > prerequisite-patch-id: 23a425390a4226bd70bbff459148c80f5e28379c
> > > prerequisite-patch-id: e3f2875124b46b2b1cf9ea28883bf0c864b79479
> > > prerequisite-patch-id: 9cdd706ee2038c7b393c4d65ff76a1873df1ca03
> > > prerequisite-patch-id: 332ac90be6e4e4110e27bdd1caaff212c129f547
> > > prerequisite-patch-id: 32a74f87cbfe9e8d52c34a4edeee6d271925665a
> > > prerequisite-patch-id: f57cdf7ec7080bb8c95782bc7c3ec672db8ec1ce
> > > prerequisite-patch-id: 18dc9236aed47f708f5c854afd832f3c80be5ea7
> > > prerequisite-patch-id: dd147c6854c4ca12a9a8bd4f5714968a59d60e4e
> > > --
> > > 2.17.1
> > >
