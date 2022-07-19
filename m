Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664D55796A1
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 11:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiGSJq7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 05:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGSJq6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 05:46:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9C25F72;
        Tue, 19 Jul 2022 02:46:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC08160FD8;
        Tue, 19 Jul 2022 09:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B3CC341C6;
        Tue, 19 Jul 2022 09:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658224013;
        bh=Pyg2cyHZvb2nxsbB95NOQZMo3b52LGxCLOxt8vFHb9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mi8XOOr4nAuOxiRtPTwaG/UnrmyXQG3LBiIXxe6za33cL6cb3QESJQcE6sZ9pkTth
         IQ9rx3wapY5hnVD1QlYoDakXs4K4dXOPJVdzr7uIL7kG5GfMjvK/rbTi4wGxKVenzm
         A5ftRNSzeFO3Phzs/NzX4IlNchKWbrOj1PfKCmqysmGihRtAjbDEqazHoEayvTO/b3
         hs/pQ6yi9Ohf+ELRmkcNLOelsxL1dA0QTj1ShLOo3BzL29dWnzZQWPyICoQJUlmeUp
         3/mG7CE7mAA1FancvYS5hwK245d38jLM/vbsXJEC8G1G75vyGdqhYJFOURrrLSq6o8
         7JiZUowaIZT4g==
Received: by pali.im (Postfix)
        id 03C60F3C; Tue, 19 Jul 2022 11:46:49 +0200 (CEST)
Date:   Tue, 19 Jul 2022 11:46:49 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mauri Sandberg <maukka@ext.kapsi.fi>,
        linux-pci <linux-pci@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] PCI: mvebu: add support for orion5x
Message-ID: <20220719094649.pzyrqdvm3fm5fqh2@pali>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
 <20220718202843.6766-4-maukka@ext.kapsi.fi>
 <CAK8P3a042yoLR0eqt4Bm0KH4X9SJhUsjKDh1S9M+MF6mU1mPNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a042yoLR0eqt4Bm0KH4X9SJhUsjKDh1S9M+MF6mU1mPNw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Tuesday 19 July 2022 10:05:28 Arnd Bergmann wrote:
> On Mon, Jul 18, 2022 at 10:28 PM Mauri Sandberg <maukka@ext.kapsi.fi> wrote:
> >
> > Add support for orion5x PCIe controller.
> >
> > There is Orion-specific errata that config space via CF8/CFC registers
> > is broken. Workaround documented in errata documented (linked from above
> > documentation) does not work when DMA is used and instead other
> > undocumented workaround is needed which maps config space to memory
> > (and therefore avoids usage of broken CF8/CFC memory mapped registers).
> >
> > Signed-off-by: Mauri Sandberg <maukka@ext.kapsi.fi>
> > Cc: Pali Rohár <pali@kernel.org>
> 
> Nice job, glad you managed to figure this out!
> 
> > diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
> > index 7bcb41137bbf..9d8be5ce1266 100644
> > --- a/arch/arm/mach-orion5x/common.c
> > +++ b/arch/arm/mach-orion5x/common.c
> > @@ -231,19 +231,6 @@ void __init orion5x_init_early(void)
> >
> >  void orion5x_setup_wins(void)
> >  {
> > -       /*
> > -        * The PCIe windows will no longer be statically allocated
> > -        * here once Orion5x is migrated to the pci-mvebu driver.
> > -        */
> > -       mvebu_mbus_add_window_remap_by_id(ORION_MBUS_PCIE_IO_TARGET,
> > -                                         ORION_MBUS_PCIE_IO_ATTR,
> > -                                         ORION5X_PCIE_IO_PHYS_BASE,
> > -                                         ORION5X_PCIE_IO_SIZE,
> > -                                         ORION5X_PCIE_IO_BUS_BASE);
> > -       mvebu_mbus_add_window_by_id(ORION_MBUS_PCIE_MEM_TARGET,
> > -                                   ORION_MBUS_PCIE_MEM_ATTR,
> > -                                   ORION5X_PCIE_MEM_PHYS_BASE,
> > -                                   ORION5X_PCIE_MEM_SIZE);
> >         mvebu_mbus_add_window_remap_by_id(ORION_MBUS_PCI_IO_TARGET,
> >                                           ORION_MBUS_PCI_IO_ATTR,
> >                                           ORION5X_PCI_IO_PHYS_BASE,
> 
> If the idea is to have the PCI_MVEBU driver only used for the DT based orion5x
> machines, but not the legacy board files, I suspect this breaks the legacy
> pci driver, unless you move the mbus configuration into the pcie_setup()
> function.
> 
> > +/* Relevant only for Orion-1/Orion-NAS */
> > +#define ORION5X_PCIE_WA_PHYS_BASE      0xf0000000
> > +#define ORION5X_PCIE_WA_VIRT_BASE      IOMEM(0xfd000000)
> 
> You should not need to hardcode these here. The ORION5X_PCIE_WA_PHYS_BASE
> should already be part of the DT binding.

Of course! But the issue is that we do not know how to do this DT
binding. I have already wrote email with asking for help in which
property and which format should be this config range defined, but no
answer yet: https://lore.kernel.org/linux-pci/20220710225108.bgedria6igtqpz5l@pali/

> There is little practical difference
> here, but I see no value in taking the shortcut here either.
> 
> For the ORION5X_PCIE_WA_VIRT_BASE, you rely on this to match the
> definition in arch/arm/mach-orion5x/common.c, and this is rather fragile.
> 
> Instead, please use ioremap() to create a mapping at runtime. The ioremap()
> implementation on ARM is smart enough to reuse the address from the static
> mapping in common.c, but will also keep working if that should go away.

I'm planning to work with Mauri on this, but current blocker is DT.

> > +#define ORION5X_PCIE_WA_SIZE           SZ_16M
> > +#define ORION_MBUS_PCIE_WA_TARGET      0x04
> > +#define ORION_MBUS_PCIE_WA_ATTR                0x79
> > +
> > +static int mvebu_pcie_child_rd_conf_wa(struct pci_bus *bus, u32 devfn, int where, int size, u32 *val)
> > +{
> > +       struct mvebu_pcie *pcie = bus->sysdata;
> > +       struct mvebu_pcie_port *port;
> > +
> > +       port = mvebu_pcie_find_port(pcie, bus, devfn);
> > +       if (!port)
> > +               return PCIBIOS_DEVICE_NOT_FOUND;
> > +
> > +       if (!mvebu_pcie_link_up(port))
> > +               return PCIBIOS_DEVICE_NOT_FOUND;
> > +
> > +       /*
> > +        * We only support access to the non-extended configuration
> > +        * space when using the WA access method (or we would have to
> > +        * sacrifice 256M of CPU virtual address space.)
> > +        */
> > +       if (where >= 0x100) {
> > +               *val = 0xffffffff;
> > +               return PCIBIOS_DEVICE_NOT_FOUND;
> > +       }
> > +
> > +       return orion_pcie_rd_conf_wa(ORION5X_PCIE_WA_VIRT_BASE, bus, devfn, where, size, val);
> > +}
> > +
> 
> This is probably good enough here, though I think you could also use
> the trick from drivers/pci/ecam.c and map each bus at a time.
> 
>       Arnd

Yes, there are also helper functions like map bus and etc. which could
simplify this code. I'm planning to do cleanups once we have fully
working driver for Orion.
