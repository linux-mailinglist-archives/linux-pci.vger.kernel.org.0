Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA7F2CE2DE
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 00:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgLCXps (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 18:45:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:47088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgLCXps (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Dec 2020 18:45:48 -0500
X-Gm-Message-State: AOAM531wNiFmzKNAmhJQL04hJ7NEE/fmRNZ3FV3kniBFewxJjnnt5AQ0
        Jrc5gU4sw5pXHPhic6NYWqbQpnpVooRkAEbzUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607039107;
        bh=GoCfv6yRa59sMk527Ilw/+P9dXejkhutWIlptCRT1hg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SqgvJerutN1qMoH8pYUzEcPSIsJ9sP8VFu+42eVKRdll6974434/9HJgEPzfPc2ut
         sAcgaFzFWR5QGZqMBZlMUokIlcWqu6qGFNoOn8GBXiVfmB4ROkZ8ZMOIgkxC4d4eCi
         zKG4bvUiCDa571GtN88AFHeT71Qn4jUlslXTPD2WyEi2FQRLvg5pwccKNT0De1ujaE
         cTINc0vnHl481EIQ2tAlbTVCvNbdv2Vw+otqvpe3uTy/vZ4J31x9jAezv5V06Xbc+b
         kg7WFxRP/hFvhp9EbFzqg35iBkhenG+PQAG9fa1OhZtdTjk2441kdV2AsE9Vb+6xoK
         WwkSGmETCahFA==
X-Google-Smtp-Source: ABdhPJzncl3GtBbyvGBWlJ5Po1um/61Va2O6Pd4oRqyNsS2Sfx5aBQoaKNXV6nCinRK8wYpb1ruoYB7s3oKHDjkSo6s=
X-Received: by 2002:a05:620a:148c:: with SMTP id w12mr5439539qkj.311.1607039106330;
 Thu, 03 Dec 2020 15:45:06 -0800 (PST)
MIME-Version: 1.0
References: <20201203121018.16432-4-daire.mcnamara@microchip.com> <20201203210748.GA1594918@bjorn-Precision-5520>
In-Reply-To: <20201203210748.GA1594918@bjorn-Precision-5520>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 3 Dec 2020 16:44:54 -0700
X-Gmail-Original-Message-ID: <CAL_JsqK-TxRwmmP8qAQdwH__p53VzW4usY4o1z_Ee75QXa91tA@mail.gmail.com>
Message-ID: <CAL_JsqK-TxRwmmP8qAQdwH__p53VzW4usY4o1z_Ee75QXa91tA@mail.gmail.com>
Subject: Re: [PATCH v18 3/4] PCI: microchip: Add host driver for Microchip
 PCIe controller
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        david.abdurachmanov@gmail.com, cyril.jean@microchip.com,
        Ben Dooks <ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 3, 2020 at 2:07 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Dec 03, 2020 at 12:10:17PM +0000, daire.mcnamara@microchip.com wrote:
> > From: Daire McNamara <daire.mcnamara@microchip.com>
> >
> > Add support for the Microchip PolarFire PCIe controller when
> > configured in host (Root Complex) mode.
> >
> > Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> > +static void mc_pcie_isr(struct irq_desc *desc)
> > +{
> > +     struct irq_chip *chip = irq_desc_get_chip(desc);
> > +     struct mc_port *port = irq_desc_get_handler_data(desc);
> > +     struct device *dev = port->dev;
> > +     struct mc_msi *msi = &port->msi;
> > +     void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
> > +     void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE1_CTRL_ADDR;
> > +     u32 status;
> > +     unsigned long intx_status;
> > +     unsigned long msi_status;
> > +     u32 bit;
> > +     u32 virq;
> > +
> > +     /*
> > +      * The core provides a single interrupt for both INTx/MSI messages.
> > +      * So we'll read both INTx and MSI status.
> > +      */
> > +     chained_irq_enter(chip, desc);
> > +
> > +     status = readl_relaxed(ctrl_base_addr + MC_SEC_ERROR_INT);
>
> Other than a few in mc_setup_window(), it looks like all the accesses
> in this driver are relaxed.

I may have asked for that.

> readl_relaxed() and writel_relaxed() are only used by a few of the
> host bridge drivers.  I doubt this is because those devices behave
> differently than all the rest, so I suspect there's a general rule
> that they all should use.  I don't know what that rule is, but maybe
> you do?

Generally, if the access doesn't need to be ordered with respect to
DMA accesses relaxed can be used. I think relaxed variants should also
not be used on PCI resources (long ago there was some debate that
readl/writel was only for PCI). Most of the host bridge accesses
aren't PCI accesses, but rather host bus accesses so relaxed should be
correct.

> Per Documentation/memory-barriers.txt, the relaxed versions provide
> weaker ordering guarantees, so the safest thing would be to use the
> non-relaxed versions and include a little justification for when/why
> it is safe to use the relaxed versions.

The relaxed variant is newish, so we have a good mixture in the
kernel. Usually, it's not performance critical, so it's really only
new code that use relaxed variants.

> A lot of uses are in non-performance paths where there's really no
> benefit to using the relaxed versions.

Code size. Minimally, it's a barrier instruction on every access.
There are cases on arm32 where the barrier also has an mmio access.

> Not asking you to do anything here, but in case you've analyzed this
> and come to the conclusion that the relaxed versions are safe here,
> but not in mc_setup_window(), that rationale might be useful to others
> if you included it in the commit log or a brief comment in the code.
>
> > +static void mc_setup_window(void __iomem *bridge_base_addr, u32 index, phys_addr_t axi_addr,
> > +                         phys_addr_t pci_addr, size_t size)
> > +{
> > +     u32 atr_sz = ilog2(size) - 1;
> > +     u32 val;
> > +
> > +     if (index == 0)
> > +             val = PCIE_CONFIG_INTERFACE;
> > +     else
> > +             val = PCIE_TX_RX_INTERFACE;
> > +
> > +     writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) + MC_ATR0_AXI4_SLV0_TRSL_PARAM);

Humm, I could see ordering mattering here, but a writel doesn't
actually help. You might want an access (not using readl/writel) to
the region being setup to work immediately after this writel. However,
the barrier for writel is before the write.

But these regions are also generally one-time, statically configured,
so I'm not sure it's really worth spending more time analyzing
theoretical problems.

Rob
