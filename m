Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EC756C2C7
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 01:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbiGHTEZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 15:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbiGHTEY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 15:04:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A99324F32;
        Fri,  8 Jul 2022 12:04:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 187496268E;
        Fri,  8 Jul 2022 19:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D021C341C0;
        Fri,  8 Jul 2022 19:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657307062;
        bh=oui8wCa3qk4Jyj1sD0GNtvI01oLWs14a3bNFwt4hqps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=blNrTUQR4iGITv/VbfqWtLvtLYopvZO9sR9G9uJsGJYBjtiH3RCk16oKMrcRUXUv7
         ClMaATEuz4AWhknXzklJbUkBKtoXYPRASKU44G97dy4bVJBQ9gzMrRY4lfc4zUUvVY
         FR+O25pWMtO9Ins0nhOf9YReYInqML0w0rgH7wVMmvTuO2cstCoRnc8WndlYAxNY42
         Zjw7n07ll+KOiKyer5AvLM8IclUkTqiy9YWc1vdBxC85ZNerwiG4HhIP9BmSB+fiVv
         dA181wqrUYlhAYq/Zyq5n7UkrmEm95XIX86NE6NrDnNdtJ7LIVibH3Fo4g0BmqrIJY
         KTAxNIsx2VrJw==
Date:   Fri, 8 Jul 2022 14:04:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] PCI: brcmstb: Split brcm_pcie_setup() into two
 funcs
Message-ID: <20220708190420.GA364925@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNzQZVi8MbyeZNcBzE0hGjGiYSUk3riSXxTALtFyC00aPQ@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 08, 2022 at 09:29:27AM -0400, Jim Quinlan wrote:
> On Wed, Jul 6, 2022 at 5:56 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jul 01, 2022 at 12:27:22PM -0400, Jim Quinlan wrote:
> > > We need to take some code in brcm_pcie_setup() and put it in a new function
> > > brcm_pcie_linkup().  In future commits the brcm_pcie_linkup() function will
> > > be called indirectly by pci_host_probe() as opposed to the host driver
> > > invoking it directly.
> > >
> > > Some code that was executed after the PCIe linkup is now placed so that it
> > > executes prior to linkup, since this code has to run prior to the
> > > invocation of pci_host_probe().
> >
> > This says we need to move some code from brcm_pcie_setup() to
> > brcm_pcie_linkup(), but not *why* we need to do that.
> I will elaborate in the commit message.
> >
> > In brcm_pcie_resume(), they're called together:
> >
> >   brcm_pcie_resume
> >     brcm_pcie_setup
> >     brcm_pcie_linkup
> >
> > In the probe path, they're not called together, but they're in the
> > same order:
> >
> >   brcm_pcie_probe
> >     brcm_pcie_setup
> >     pci_host_probe
> >       ...
> >         brcm_pcie_add_bus               # bus->ops->add_bus
> >           brcm_pcie_linkup
> >
> > Is there something that must happen *between* them in the probe path?
> 
> Yes.  In the probe() case, we must do things in this order:
> 
> 1. brcm_pcie_setup()
> 2. Turn on regulators
> 3. brcm_pcie_linkup()

Ah, I see, both 2) and 3) happen in brcm_pcie_add_bus:

  brcm_pcie_add_bus                    # bus->ops->add_bus
    pci_subdev_regulators_add_bus
      regulator_bulk_enable            # turn on regulators
    brcm_pcie_linkup

> Since the voltage regulators are turned on during enumeration,
> pci_host_probe() must be invoked prior to 3.  Before regulators, we
> did not care.

I guess in the pre-regulator case, i.e., pcie->sr not set, the power
for downstream devices must always be on.

> In the resume case, there is no enumeration of course but our driver
> has a handle to the regulators and can turn them on/off w/o help.

And I guess we don't need brcm_pcie_setup() in the resume path because
suspend turns off power only for downstream devices, not for the root
port itself, so the programming done by brcm_pcie_setup() doesn't need
to be done again.

> > > Link: https://lore.kernel.org/r/20220106160332.2143-5-jim2101024@gmail.com
> > > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > > ---
> > >  drivers/pci/controller/pcie-brcmstb.c | 69 +++++++++++++++++----------
> > >  1 file changed, 43 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > > index e61058e13818..2bf5cc399fd0 100644
> > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > @@ -926,16 +926,9 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
> > >
> > >  static int brcm_pcie_setup(struct brcm_pcie *pcie)
> > >  {
> > > -     struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> > >       u64 rc_bar2_offset, rc_bar2_size;
> > >       void __iomem *base = pcie->base;
> > > -     struct device *dev = pcie->dev;
> > > -     struct resource_entry *entry;
> > > -     bool ssc_good = false;
> > > -     struct resource *res;
> > > -     int num_out_wins = 0;
> > > -     u16 nlw, cls, lnksta;
> > > -     int i, ret, memc;
> > > +     int ret, memc;
> > >       u32 tmp, burst, aspm_support;
> > >
> > >       /* Reset the bridge */
> > > @@ -1025,6 +1018,40 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> > >       if (pcie->gen)
> > >               brcm_pcie_set_gen(pcie, pcie->gen);
> > >
> > > +     /* Don't advertise L0s capability if 'aspm-no-l0s' */
> > > +     aspm_support = PCIE_LINK_STATE_L1;
> > > +     if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
> > > +             aspm_support |= PCIE_LINK_STATE_L0S;
> > > +     tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> > > +     u32p_replace_bits(&tmp, aspm_support,
> > > +             PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
> > > +     writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> > > +
> > > +     /*
> > > +      * For config space accesses on the RC, show the right class for
> > > +      * a PCIe-PCIe bridge (the default setting is to be EP mode).
> > > +      */
> > > +     tmp = readl(base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> > > +     u32p_replace_bits(&tmp, 0x060400,
> > > +                       PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK);
> > > +     writel(tmp, base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int brcm_pcie_linkup(struct brcm_pcie *pcie)
> > > +{
> > > +     struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> > > +     struct device *dev = pcie->dev;
> > > +     void __iomem *base = pcie->base;
> > > +     struct resource_entry *entry;
> > > +     struct resource *res;
> > > +     int num_out_wins = 0;
> > > +     u16 nlw, cls, lnksta;
> > > +     bool ssc_good = false;
> > > +     u32 tmp;
> > > +     int ret, i;
> > > +
> > >       /* Unassert the fundamental reset */
> > >       pcie->perst_set(pcie, 0);
> > >
> > > @@ -1075,24 +1102,6 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> > >               num_out_wins++;
> > >       }
> > >
> > > -     /* Don't advertise L0s capability if 'aspm-no-l0s' */
> > > -     aspm_support = PCIE_LINK_STATE_L1;
> > > -     if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
> > > -             aspm_support |= PCIE_LINK_STATE_L0S;
> > > -     tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> > > -     u32p_replace_bits(&tmp, aspm_support,
> > > -             PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
> > > -     writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> > > -
> > > -     /*
> > > -      * For config space accesses on the RC, show the right class for
> > > -      * a PCIe-PCIe bridge (the default setting is to be EP mode).
> > > -      */
> > > -     tmp = readl(base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> > > -     u32p_replace_bits(&tmp, 0x060400,
> > > -                       PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK);
> > > -     writel(tmp, base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> > > -
> > >       if (pcie->ssc) {
> > >               ret = brcm_pcie_set_ssc(pcie);
> > >               if (ret == 0)
> > > @@ -1281,6 +1290,10 @@ static int brcm_pcie_resume(struct device *dev)
> > >       if (ret)
> > >               goto err_reset;
> > >
> > > +     ret = brcm_pcie_linkup(pcie);
> > > +     if (ret)
> > > +             goto err_reset;
> > > +
> > >       if (pcie->msi)
> > >               brcm_msi_set_regs(pcie->msi);
> > >
> > > @@ -1398,6 +1411,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
> > >       if (ret)
> > >               goto fail;
> > >
> > > +     ret = brcm_pcie_linkup(pcie);
> > > +     if (ret)
> > > +             goto fail;
> > > +
> > >       pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
> > >       if (pcie->type == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
> > >               dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
> > > --
> > > 2.17.1
> > >
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

