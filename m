Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A659F579549
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 10:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbiGSIeZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 19 Jul 2022 04:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiGSIeZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 04:34:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD71232BA7;
        Tue, 19 Jul 2022 01:34:23 -0700 (PDT)
Received: from mail-ot1-f48.google.com ([209.85.210.48]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MI5YN-1oGj6I3zQF-00FFE9; Tue, 19 Jul 2022 10:34:22 +0200
Received: by mail-ot1-f48.google.com with SMTP id r22-20020a056830419600b0061c6edc5dcfso11153969otu.12;
        Tue, 19 Jul 2022 01:34:21 -0700 (PDT)
X-Gm-Message-State: AJIora8zDtd34SM0f8Evi8yusEvG+001JjS3ZKiZntDKkWa1m5Gd8Wn6
        EWoqGiregyMRFEeOMHA1qgCpirfFj1v37o1/Lw4=
X-Google-Smtp-Source: AGRyM1ufEAWksjkMvj9tEJzYY5hH71bvz6izLKVChTmEgCkEaBUSJ/YN8HWkIZNgYF2aCIi2ybpPIw7GMEG0afM3trQ=
X-Received: by 2002:a81:6dce:0:b0:31e:5a3b:d3a2 with SMTP id
 i197-20020a816dce000000b0031e5a3bd3a2mr2244432ywc.495.1658217945828; Tue, 19
 Jul 2022 01:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220718202843.6766-1-maukka@ext.kapsi.fi> <20220718202843.6766-4-maukka@ext.kapsi.fi>
In-Reply-To: <20220718202843.6766-4-maukka@ext.kapsi.fi>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Jul 2022 10:05:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a042yoLR0eqt4Bm0KH4X9SJhUsjKDh1S9M+MF6mU1mPNw@mail.gmail.com>
Message-ID: <CAK8P3a042yoLR0eqt4Bm0KH4X9SJhUsjKDh1S9M+MF6mU1mPNw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: mvebu: add support for orion5x
To:     Mauri Sandberg <maukka@ext.kapsi.fi>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
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
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:S0/HcIKDpqem1xph+v8nynll+9XBx7ff9rz8qcK9eJZWtL07V2R
 8jAYs2eqxL9aRB0jlT3oPV0TDRlOumUpa97016u50zhYEHR/3QGsV2x4BqUkHy2qjdv/0vj
 LtuhjpSGWuCeEaUukUYIqZi3Bcucopbi85ZmZeNos/DsfXTNH7T3ChTgendkngXDRQzlR7e
 Nd5+DX/N/nz8PhMskmFbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PavivdfLPIg=:/LYI37Cd5I6g3+EGFq5fWC
 cevZJlL46u2g2Z5FuN0+5yBKlhG4hcRyVi8eoF8oGWLHzJouWPbXqbPBT+Cy0JuePXgcvpOkD
 GWIRBf3Y6AeN0Kmce6VFlR0zxzWOVMrTMN6no1s1x4mhhJFXcLtX+PT2mwmdjN90Yu9vf5TVe
 MIWQbKM2+QhSy3Njld2AeHum0AhhFyxQYxnfbiQyZNBgVQJw6NuNFecmjn0WAWtfnmeYReONk
 c3LCaHs+b2xLXW0ktGIaTNdHAh+88gRct0rMvJizKTKrYkbwwXduy4h6oXA6Ygauf11B4FHGH
 Umob9nrZsv3xNROgvxtT00jPZjk56J+snK0ghpVgda5ctPhDyqDelkwnhWNCgOrHZNSwT2t3n
 zuwp8lDJQNihgMii+RE4v/APUBJA4u/8B+MmhWUwwORhOI4eyCmjCcYX/d8bRJPoXVLL5WCO1
 k6AbSdma+EyXPX+6zcNPESCfkEaaXYfbAe2uMYKweSqOP1QWf87WH3BR7sfOFqZHvTvjWRA+Y
 fl+IRvVj0eeE2Avo0HnKhb+n8iK7OEKBUEKAQVSnU3lslG0KBdE/lmb+poQw4zpgn7X1ST4kI
 xrcw5/xfEpkurchzy7XwKBHVSuc6Y+SxtuVVyHjV6yb1z1NJqBmbGkP2fRi5sgkorFBi7ZJcI
 tL7iy7p0Nv+jyAWpXanxUgRy9bxh3rVJk2Izr1SM9IHWRPJDYfRrsmLKrDPb11Tw/KwbpAt2G
 Pyruw4GRQ4FKa84APoHkIxitJsoX+O4z3ceF7dSQDmbb1tMueGgZ5UqpmTIaKv5XsQ0bUMvD+
 lOvqscAMZGe91S/Bhg8btDfk33B8tHe82dqx/qUeZFMlaXoGYU/talUQBlQKEwM5ZhxAd2qtv
 A2NF2tHvGeVdQOBv14/A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 18, 2022 at 10:28 PM Mauri Sandberg <maukka@ext.kapsi.fi> wrote:
>
> Add support for orion5x PCIe controller.
>
> There is Orion-specific errata that config space via CF8/CFC registers
> is broken. Workaround documented in errata documented (linked from above
> documentation) does not work when DMA is used and instead other
> undocumented workaround is needed which maps config space to memory
> (and therefore avoids usage of broken CF8/CFC memory mapped registers).
>
> Signed-off-by: Mauri Sandberg <maukka@ext.kapsi.fi>
> Cc: Pali Rohár <pali@kernel.org>

Nice job, glad you managed to figure this out!

> diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
> index 7bcb41137bbf..9d8be5ce1266 100644
> --- a/arch/arm/mach-orion5x/common.c
> +++ b/arch/arm/mach-orion5x/common.c
> @@ -231,19 +231,6 @@ void __init orion5x_init_early(void)
>
>  void orion5x_setup_wins(void)
>  {
> -       /*
> -        * The PCIe windows will no longer be statically allocated
> -        * here once Orion5x is migrated to the pci-mvebu driver.
> -        */
> -       mvebu_mbus_add_window_remap_by_id(ORION_MBUS_PCIE_IO_TARGET,
> -                                         ORION_MBUS_PCIE_IO_ATTR,
> -                                         ORION5X_PCIE_IO_PHYS_BASE,
> -                                         ORION5X_PCIE_IO_SIZE,
> -                                         ORION5X_PCIE_IO_BUS_BASE);
> -       mvebu_mbus_add_window_by_id(ORION_MBUS_PCIE_MEM_TARGET,
> -                                   ORION_MBUS_PCIE_MEM_ATTR,
> -                                   ORION5X_PCIE_MEM_PHYS_BASE,
> -                                   ORION5X_PCIE_MEM_SIZE);
>         mvebu_mbus_add_window_remap_by_id(ORION_MBUS_PCI_IO_TARGET,
>                                           ORION_MBUS_PCI_IO_ATTR,
>                                           ORION5X_PCI_IO_PHYS_BASE,

If the idea is to have the PCI_MVEBU driver only used for the DT based orion5x
machines, but not the legacy board files, I suspect this breaks the legacy
pci driver, unless you move the mbus configuration into the pcie_setup()
function.

> +/* Relevant only for Orion-1/Orion-NAS */
> +#define ORION5X_PCIE_WA_PHYS_BASE      0xf0000000
> +#define ORION5X_PCIE_WA_VIRT_BASE      IOMEM(0xfd000000)

You should not need to hardcode these here. The ORION5X_PCIE_WA_PHYS_BASE
should already be part of the DT binding. There is little practical difference
here, but I see no value in taking the shortcut here either.

For the ORION5X_PCIE_WA_VIRT_BASE, you rely on this to match the
definition in arch/arm/mach-orion5x/common.c, and this is rather fragile.

Instead, please use ioremap() to create a mapping at runtime. The ioremap()
implementation on ARM is smart enough to reuse the address from the static
mapping in common.c, but will also keep working if that should go away.

> +#define ORION5X_PCIE_WA_SIZE           SZ_16M
> +#define ORION_MBUS_PCIE_WA_TARGET      0x04
> +#define ORION_MBUS_PCIE_WA_ATTR                0x79
> +
> +static int mvebu_pcie_child_rd_conf_wa(struct pci_bus *bus, u32 devfn, int where, int size, u32 *val)
> +{
> +       struct mvebu_pcie *pcie = bus->sysdata;
> +       struct mvebu_pcie_port *port;
> +
> +       port = mvebu_pcie_find_port(pcie, bus, devfn);
> +       if (!port)
> +               return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +       if (!mvebu_pcie_link_up(port))
> +               return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +       /*
> +        * We only support access to the non-extended configuration
> +        * space when using the WA access method (or we would have to
> +        * sacrifice 256M of CPU virtual address space.)
> +        */
> +       if (where >= 0x100) {
> +               *val = 0xffffffff;
> +               return PCIBIOS_DEVICE_NOT_FOUND;
> +       }
> +
> +       return orion_pcie_rd_conf_wa(ORION5X_PCIE_WA_VIRT_BASE, bus, devfn, where, size, val);
> +}
> +

This is probably good enough here, though I think you could also use
the trick from drivers/pci/ecam.c and map each bus at a time.

      Arnd
