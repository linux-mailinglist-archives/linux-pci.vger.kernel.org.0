Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437A939C37A
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jun 2021 00:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhFDW1w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 18:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbhFDW1v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jun 2021 18:27:51 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD70C061766;
        Fri,  4 Jun 2021 15:26:04 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so10532968otp.11;
        Fri, 04 Jun 2021 15:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ki8vKKno4iHAkGtgYWAx1Pz0nIKwuTWphcF1Ru1+kS4=;
        b=PhlNMnGlKNcB8mLmtrh54UtFqjFJAGujVsDz0z5O54o3HEkK4dj0LHHgiwlAdkhGfL
         W+Vzino3Ghe/es4KCT26OQAtq/cNtTI9W/FRbf1tiuGafWqk409yuPX0pwvC3roJk3Qm
         oLpSB0G4gYUuj+FPXMyR6VHHJtkTEbmKT9fKFM1J3N9gfyGJnn6C+Nktd+I0ePJLgizO
         AkRgxaxetCZxPyPUI84pnBp+lgutpiisgVCp3bFc5kELU84ggBJ/iAjR5EH8QQuYLItW
         hw9lFnJvpCiFuX0INkXrSFBLGX06CKGd7CP0xImM/8yBvpNs8wyNtBTMputpF/IBhBnt
         npdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ki8vKKno4iHAkGtgYWAx1Pz0nIKwuTWphcF1Ru1+kS4=;
        b=GgvA+4TJlrwSrSPFJx/4TnXJBtADHPkspEyr4Cdssuzxip0+GCyY6gfP6tXf4Gk/IJ
         Cyw7xyqMLnrlNGPXk2Xq5jYtTojWKcmdcVxJ0WFEFUXCA1B6tOh/qBVXqeYEbHVyzHkH
         lyB16+8MegE49o61WFIeVb7LebT6ZPMQzvpvVoQGLIPob/1CmMkhsQprkV4/WHC5Kq2a
         05TrQukoq64LZM+05T9DWj+byUbjAATyECCYwO33Iw6fVBTxMKxmF6p+p6Eb1S4URk+n
         g5Wg8KWrRo4WhwtwXMQqt3hhzgOvnfqZfmca512D6f2EjAx2JhlYwOzEeMmfSlSYFiy1
         uLig==
X-Gm-Message-State: AOAM533OYa0WOTtdl+hbI+8PD5Sb3HnwPwA//hftEsySlY4EJ9Hux/iQ
        I1SLh6J8aKyPPTH5fcnjtalhrzjBoHGRwvlHOHk=
X-Google-Smtp-Source: ABdhPJxxfHNDEIY9WUZhRCxAIZ9Pgp1uIcU9XO0m9y9w4xdeVL1vtZihor57DZXJGR8We3i87yWIdV6aQ4IBjWJZncs=
X-Received: by 2002:a05:6830:19d9:: with SMTP id p25mr5592032otp.236.1622845563428;
 Fri, 04 Jun 2021 15:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210515124055.22225-1-sergio.paracuellos@gmail.com>
 <20210515124055.22225-3-sergio.paracuellos@gmail.com> <20210604193012.GB3695694@robh.at.kernel.org>
In-Reply-To: <20210604193012.GB3695694@robh.at.kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 5 Jun 2021 00:25:52 +0200
Message-ID: <CAMhs-H_z18Pk=y+YeiuxqFS0phW5We4SNKb9=DopEJQdA-6erQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] MIPS: pci: Add driver for MT7621 PCIe controller
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:MIPS" <linux-mips@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-staging@lists.linux.dev,
        Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

Thanks for the review.

On Fri, Jun 4, 2021 at 9:30 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sat, May 15, 2021 at 02:40:53PM +0200, Sergio Paracuellos wrote:
> > This patch adds a driver for the PCIe controller of MT7621 SoC.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  arch/mips/pci/Makefile     |   1 +
> >  arch/mips/pci/pci-mt7621.c | 624 +++++++++++++++++++++++++++++++++++++
> >  arch/mips/ralink/Kconfig   |   9 +-
> >  3 files changed, 633 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/mips/pci/pci-mt7621.c
> >
> > diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
> > index f3eecc065e5c..178c550739c4 100644
> > --- a/arch/mips/pci/Makefile
> > +++ b/arch/mips/pci/Makefile
> > @@ -24,6 +24,7 @@ obj-$(CONFIG_PCI_AR2315)    += pci-ar2315.o
> >  obj-$(CONFIG_SOC_AR71XX)     += pci-ar71xx.o
> >  obj-$(CONFIG_PCI_AR724X)     += pci-ar724x.o
> >  obj-$(CONFIG_PCI_XTALK_BRIDGE)       += pci-xtalk-bridge.o
> > +obj-$(CONFIG_PCI_MT7621)     += pci-mt7621.o
> >  #
> >  # These are still pretty much in the old state, watch, go blind.
> >  #
> > diff --git a/arch/mips/pci/pci-mt7621.c b/arch/mips/pci/pci-mt7621.c
> > new file mode 100644
> > index 000000000000..fe1945819d25
> > --- /dev/null
> > +++ b/arch/mips/pci/pci-mt7621.c
> > @@ -0,0 +1,624 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * BRIEF MODULE DESCRIPTION
> > + *     PCI init for Ralink RT2880 solution
> > + *
> > + * Copyright 2007 Ralink Inc. (bruce_chang@ralinktech.com.tw)
> > + *
> > + * May 2007 Bruce Chang
> > + * Initial Release
> > + *
> > + * May 2009 Bruce Chang
> > + * support RT2880/RT3883 PCIe
> > + *
> > + * May 2011 Bruce Chang
> > + * support RT6855/MT7620 PCIe
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_pci.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/pci.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/reset.h>
> > +#include <linux/sys_soc.h>
> > +
> > +/* MediaTek specific configuration registers */
> > +#define PCIE_FTS_NUM                 0x70c
> > +#define PCIE_FTS_NUM_MASK            GENMASK(15, 8)
> > +#define PCIE_FTS_NUM_L0(x)           (((x) & 0xff) << 8)
> > +
> > +/* Host-PCI bridge registers */
> > +#define RALINK_PCI_PCICFG_ADDR               0x0000
> > +#define RALINK_PCI_PCIMSK_ADDR               0x000C
> > +#define RALINK_PCI_CONFIG_ADDR               0x0020
> > +#define RALINK_PCI_CONFIG_DATA               0x0024
> > +#define RALINK_PCI_MEMBASE           0x0028
> > +#define RALINK_PCI_IOBASE            0x002C
> > +
> > +/* PCIe RC control registers */
> > +#define MT7621_PCIE_OFFSET           0x2000
> > +#define MT7621_NEXT_PORT             0x1000
> > +
> > +#define RALINK_PCI_BAR0SETUP_ADDR    0x0010
>
> Standard BAR0 register?

Ok, I will remove this and use 'PCI_BASE_ADDRESS_0' instead.

>
> > +#define RALINK_PCI_ID                        0x0030
> > +#define RALINK_PCI_CLASS             0x0034
> > +#define RALINK_PCI_SUBID             0x0038
> > +#define RALINK_PCI_STATUS            0x0050
> > +
> > +/* Some definition values */
> > +#define PCIE_REVISION_ID             BIT(0)
> > +#define PCIE_CLASS_CODE                      (0x60400 << 8)
> > +#define PCIE_BAR_MAP_MAX             GENMASK(30, 16)
> > +#define PCIE_BAR_ENABLE                      BIT(0)
> > +#define PCIE_PORT_INT_EN(x)          BIT(20 + (x))
> > +#define PCIE_PORT_LINKUP             BIT(0)
> > +
> > +#define PERST_DELAY_MS                       100
> > +
> > +/**
> > + * struct mt7621_pcie_port - PCIe port information
> > + * @base: I/O mapped register base
> > + * @list: port list
> > + * @pcie: pointer to PCIe host info
> > + * @clk: pointer to the port clock gate
> > + * @phy: pointer to PHY control block
> > + * @pcie_rst: pointer to port reset control
> > + * @gpio_rst: gpio reset
> > + * @slot: port slot
> > + * @enabled: indicates if port is enabled
> > + */
> > +struct mt7621_pcie_port {
> > +     void __iomem *base;
> > +     struct list_head list;
> > +     struct mt7621_pcie *pcie;
> > +     struct clk *clk;
> > +     struct phy *phy;
> > +     struct reset_control *pcie_rst;
> > +     struct gpio_desc *gpio_rst;
> > +     u32 slot;
> > +     bool enabled;
> > +};
> > +
> > +/**
> > + * struct mt7621_pcie - PCIe host information
> > + * @base: IO Mapped Register Base
> > + * @io: IO resource
> > + * @mem: pointer to non-prefetchable memory resource
> > + * @dev: Pointer to PCIe device
> > + * @io_map_base: virtual memory base address for io
> > + * @ports: pointer to PCIe port information
> > + * @resets_inverted: depends on chip revision
> > + * reset lines are inverted.
> > + */
> > +struct mt7621_pcie {
> > +     void __iomem *base;
> > +     struct device *dev;
>
> > +     struct resource io;
> > +     struct resource *mem;
> > +     unsigned long io_map_base;
>
> These are all stored in the host bridge struct, no need for you to store
> them.

IO resources must be requested and mapped manually (see my explanation
below) and I use mem resource to also setup mips iocu regions, that is
why I am storing it also here.

>
> > +     struct list_head ports;
>
> A list is kind of an overkill for 3 entries and you know how many ports.
> Just embed an array of struct mt7621_pcie_port. Then you only need 1
> alloc.

Since ports are at most three but can be one or two also depending on
the board I ended up using a list instead of a fixed array of three
ports. This list is dynamically updated depending on link status. If
some of the ports are not present in the board nodes initially stored
after device tree parsing are deleted for the list. If it is not a big
problem I prefer to maintain this list as it is.

>
> > +     bool resets_inverted;
> > +};
> > +
> > +static inline u32 pcie_read(struct mt7621_pcie *pcie, u32 reg)
> > +{
> > +     return readl(pcie->base + reg);
>
> Can use _relaxed variants here and through out.

Ok will change into _relaxed variants if is preferred.

>
> > +}
> > +
> > +static inline void pcie_write(struct mt7621_pcie *pcie, u32 val, u32 reg)
> > +{
> > +     writel(val, pcie->base + reg);
> > +}
> > +
> > +static inline void pcie_rmw(struct mt7621_pcie *pcie, u32 reg, u32 clr, u32 set)
> > +{
> > +     u32 val = readl(pcie->base + reg);
> > +
> > +     val &= ~clr;
> > +     val |= set;
> > +     writel(val, pcie->base + reg);
> > +}
> > +
> > +static inline u32 pcie_port_read(struct mt7621_pcie_port *port, u32 reg)
> > +{
> > +     return readl(port->base + reg);
> > +}
> > +
> > +static inline void pcie_port_write(struct mt7621_pcie_port *port,
> > +                                u32 val, u32 reg)
> > +{
> > +     writel(val, port->base + reg);
> > +}
> > +
> > +static inline u32 mt7621_pci_get_cfgaddr(unsigned int bus, unsigned int slot,
> > +                                      unsigned int func, unsigned int where)
> > +{
> > +     return (((where & 0xF00) >> 8) << 24) | (bus << 16) | (slot << 11) |
> > +             (func << 8) | (where & 0xfc) | 0x80000000;
> > +}
> > +
> > +static void __iomem *mt7621_pcie_map_bus(struct pci_bus *bus,
> > +                                      unsigned int devfn, int where)
> > +{
> > +     struct mt7621_pcie *pcie = bus->sysdata;
> > +     u32 address = mt7621_pci_get_cfgaddr(bus->number, PCI_SLOT(devfn),
> > +                                          PCI_FUNC(devfn), where);
> > +
> > +     writel(address, pcie->base + RALINK_PCI_CONFIG_ADDR);
> > +
> > +     return pcie->base + RALINK_PCI_CONFIG_DATA + (where & 3);
> > +}
> > +
> > +struct pci_ops mt7621_pci_ops = {
> > +     .map_bus        = mt7621_pcie_map_bus,
> > +     .read           = pci_generic_config_read,
> > +     .write          = pci_generic_config_write,
> > +};
> > +
> > +static u32 read_config(struct mt7621_pcie *pcie, unsigned int dev, u32 reg)
> > +{
> > +     u32 address = mt7621_pci_get_cfgaddr(0, dev, 0, reg);
> > +
> > +     pcie_write(pcie, address, RALINK_PCI_CONFIG_ADDR);
> > +     return pcie_read(pcie, RALINK_PCI_CONFIG_DATA);
> > +}
> > +
> > +static void write_config(struct mt7621_pcie *pcie, unsigned int dev,
> > +                      u32 reg, u32 val)
> > +{
> > +     u32 address = mt7621_pci_get_cfgaddr(0, dev, 0, reg);
> > +
> > +     pcie_write(pcie, address, RALINK_PCI_CONFIG_ADDR);
> > +     pcie_write(pcie, val, RALINK_PCI_CONFIG_DATA);
> > +}
> > +
> > +static inline void mt7621_rst_gpio_pcie_assert(struct mt7621_pcie_port *port)
> > +{
> > +     if (port->gpio_rst)
>
> Don't need the if. gpiod_set_value should work with NULL.

Gpio resets can be optional. Some boards use one gpio reset pin for
each port but others only one for all of them. So if no reset is not
requested for a port I don't want to do anything. Hence, the check.

>
> > +             gpiod_set_value(port->gpio_rst, 1);
> > +}
> > +
> > +static inline void mt7621_rst_gpio_pcie_deassert(struct mt7621_pcie_port *port)
> > +{
> > +     if (port->gpio_rst)
> > +             gpiod_set_value(port->gpio_rst, 0);
> > +}
> > +
> > +static inline bool mt7621_pcie_port_is_linkup(struct mt7621_pcie_port *port)
> > +{
> > +     return (pcie_port_read(port, RALINK_PCI_STATUS) & PCIE_PORT_LINKUP) != 0;
> > +}
> > +
> > +static inline void mt7621_control_assert(struct mt7621_pcie_port *port)
> > +{
> > +     struct mt7621_pcie *pcie = port->pcie;
> > +
> > +     if (pcie->resets_inverted)
> > +             reset_control_assert(port->pcie_rst);
> > +     else
> > +             reset_control_deassert(port->pcie_rst);
> > +}
> > +
> > +static inline void mt7621_control_deassert(struct mt7621_pcie_port *port)
> > +{
> > +     struct mt7621_pcie *pcie = port->pcie;
> > +
> > +     if (pcie->resets_inverted)
> > +             reset_control_deassert(port->pcie_rst);
> > +     else
> > +             reset_control_assert(port->pcie_rst);
> > +}
> > +
> > +static void setup_cm_memory_region(struct mt7621_pcie *pcie)
> > +{
> > +     struct resource *mem_resource = pcie->mem;
> > +     struct device *dev = pcie->dev;
> > +     resource_size_t mask;
> > +
> > +     if (mips_cps_numiocu(0)) {
> > +             /*
> > +              * FIXME: hardware doesn't accept mask values with 1s after
> > +              * 0s (e.g. 0xffef), so it would be great to warn if that's
> > +              * about to happen
> > +              */
> > +             mask = ~(mem_resource->end - mem_resource->start);
> > +
> > +             write_gcr_reg1_base(mem_resource->start);
> > +             write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
> > +             dev_info(dev, "PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
> > +                      (unsigned long long)read_gcr_reg1_base(),
> > +                      (unsigned long long)read_gcr_reg1_mask());
> > +     }
> > +}
> > +
> > +static int mt7621_pci_parse_request_of_pci_ranges(struct pci_host_bridge *host)
> > +{
> > +     struct mt7621_pcie *pcie = pci_host_bridge_priv(host);
> > +     struct device *dev = pcie->dev;
> > +     struct device_node *node = dev->of_node;
> > +     struct of_pci_range_parser parser;
> > +     struct resource_entry *entry;
> > +     struct of_pci_range range;
> > +     LIST_HEAD(res);
> > +
> > +     if (of_pci_range_parser_init(&parser, node)) {
> > +             dev_err(dev, "missing \"ranges\" property\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     /*
> > +      * IO_SPACE_LIMIT for MIPS is 0xffff but this platform uses IO at
> > +      * upper address 0x001e160000. of_pci_range_to_resource does not work
>
> I think that's normal...

No, pci_address_to_pio will fail and io resources are not properly
assigned at all.

>
> > +      * well for MIPS platforms that don't define PCI_IOBASE, so set the IO
> > +      * resource manually instead.
>
> Can't this be fixed?

This is the way the current PCI architecture is in mips... Maybe
Thomas has a strong opinion on this.

>
> > +      */
> > +     for_each_of_pci_range(&parser, &range) {
> > +             switch (range.flags & IORESOURCE_TYPE_BITS) {
>
> The core code already parses ranges for you. Try not to do it again.
> (Use the resource instead)

See below...

>
> > +             case IORESOURCE_IO:
> > +                     pcie->io_map_base =
> > +                             (unsigned long)ioremap(range.cpu_addr,
> > +                                                    range.size);
> > +                     pcie->io.name = node->full_name;
> > +                     pcie->io.flags = range.flags;
> > +                     pcie->io.start = range.cpu_addr;
> > +                     pcie->io.end = range.cpu_addr + range.size - 1;
> > +                     pcie->io.parent = pcie->io.child = pcie->io.sibling = NULL;
> > +                     set_io_port_base(pcie->io_map_base);
> > +                     break;
> > +             }
> > +     }
> > +
> > +     entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
> > +     if (!entry) {
> > +             dev_err(dev, "Cannot get memory resource");
> > +             return -EINVAL;
> > +     }
> > +
> > +     pcie->mem = entry->res;
> > +     pci_add_resource(&res, &pcie->io);
> > +     pci_add_resource(&res, entry->res);
> > +     list_splice_init(&res, &host->windows);
>
> This should already be done for you.

Most MIPS platforms do not define PCI_IOBASE, nor implement
pci_address_to_pio(). Moreover, IO_SPACE_LIMIT is 0xffff for most MIPS
platforms. of_pci_range_to_resource passes the _start address_ of the
IO range into pci_address_to_pio, which then checks it against
IO_SPACE_LIMIT and fails. So I have to do this manually or nothing
will work properly...

>
> > +
> > +     return 0;
> > +}
> > +
> > +static int mt7621_pcie_parse_port(struct mt7621_pcie *pcie,
> > +                               int slot)
> > +{
> > +     struct mt7621_pcie_port *port;
> > +     struct device *dev = pcie->dev;
> > +     struct platform_device *pdev = to_platform_device(dev);
> > +     char name[10];
> > +
> > +     port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> > +     if (!port)
> > +             return -ENOMEM;
> > +
> > +     port->base = devm_platform_ioremap_resource(pdev, slot + 1);
> > +     if (IS_ERR(port->base))
> > +             return PTR_ERR(port->base);
> > +
> > +     snprintf(name, sizeof(name), "pcie%d", slot);
> > +     port->clk = devm_clk_get(dev, name);
> > +     if (IS_ERR(port->clk)) {
> > +             dev_err(dev, "failed to get pcie%d clock\n", slot);
> > +             return PTR_ERR(port->clk);
> > +     }
> > +
> > +     snprintf(name, sizeof(name), "pcie%d", slot);
> > +     port->pcie_rst = devm_reset_control_get_exclusive(dev, name);
> > +     if (PTR_ERR(port->pcie_rst) == -EPROBE_DEFER) {
> > +             dev_err(dev, "failed to get pcie%d reset control\n", slot);
> > +             return PTR_ERR(port->pcie_rst);
> > +     }
> > +
> > +     snprintf(name, sizeof(name), "pcie-phy%d", slot);
> > +     port->phy = devm_phy_get(dev, name);
> > +     if (IS_ERR(port->phy) && slot != 1)
> > +             return PTR_ERR(port->phy);
> > +
> > +     port->gpio_rst = devm_gpiod_get_index_optional(dev, "reset", slot,
> > +                                                    GPIOD_OUT_LOW);
> > +     if (IS_ERR(port->gpio_rst)) {
> > +             dev_err(dev, "Failed to get GPIO for PCIe%d\n", slot);
> > +             return PTR_ERR(port->gpio_rst);
> > +     }
> > +
> > +     port->slot = slot;
> > +     port->pcie = pcie;
> > +
> > +     INIT_LIST_HEAD(&port->list);
> > +     list_add_tail(&port->list, &pcie->ports);
> > +
> > +     return 0;
> > +}
> > +
> > +static int mt7621_pcie_parse_dt(struct mt7621_pcie *pcie)
> > +{
> > +     struct device *dev = pcie->dev;
> > +     struct platform_device *pdev = to_platform_device(dev);
> > +     struct device_node *node = dev->of_node, *child;
> > +     int err;
> > +
> > +     pcie->base = devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(pcie->base))
> > +             return PTR_ERR(pcie->base);
> > +
> > +     for_each_available_child_of_node(node, child) {
> > +             int slot;
> > +
> > +             err = of_pci_get_devfn(child);
> > +             if (err < 0) {
> > +                     of_node_put(child);
> > +                     dev_err(dev, "failed to parse devfn: %d\n", err);
> > +                     return err;
> > +             }
> > +
> > +             slot = PCI_SLOT(err);
> > +
> > +             err = mt7621_pcie_parse_port(pcie, slot);
> > +             if (err) {
> > +                     of_node_put(child);
> > +                     return err;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int mt7621_pcie_init_port(struct mt7621_pcie_port *port)
> > +{
> > +     struct mt7621_pcie *pcie = port->pcie;
> > +     struct device *dev = pcie->dev;
> > +     u32 slot = port->slot;
> > +     int err;
> > +
> > +     err = phy_init(port->phy);
> > +     if (err) {
> > +             dev_err(dev, "failed to initialize port%d phy\n", slot);
> > +             return err;
> > +     }
> > +
> > +     err = phy_power_on(port->phy);
> > +     if (err) {
> > +             dev_err(dev, "failed to power on port%d phy\n", slot);
> > +             phy_exit(port->phy);
> > +             return err;
> > +     }
> > +
> > +     port->enabled = true;
> > +
> > +     return 0;
> > +}
> > +
> > +static void mt7621_pcie_reset_assert(struct mt7621_pcie *pcie)
> > +{
> > +     struct mt7621_pcie_port *port;
> > +
> > +     list_for_each_entry(port, &pcie->ports, list) {
> > +             /* PCIe RC reset assert */
> > +             mt7621_control_assert(port);
> > +
> > +             /* PCIe EP reset assert */
> > +             mt7621_rst_gpio_pcie_assert(port);
> > +     }
> > +
> > +     msleep(PERST_DELAY_MS);
> > +}
> > +
> > +static void mt7621_pcie_reset_rc_deassert(struct mt7621_pcie *pcie)
> > +{
> > +     struct mt7621_pcie_port *port;
> > +
> > +     list_for_each_entry(port, &pcie->ports, list)
> > +             mt7621_control_deassert(port);
> > +}
> > +
> > +static void mt7621_pcie_reset_ep_deassert(struct mt7621_pcie *pcie)
> > +{
> > +     struct mt7621_pcie_port *port;
> > +
> > +     list_for_each_entry(port, &pcie->ports, list)
> > +             mt7621_rst_gpio_pcie_deassert(port);
> > +
> > +     msleep(PERST_DELAY_MS);
> > +}
> > +
> > +static void mt7621_pcie_init_ports(struct mt7621_pcie *pcie)
> > +{
> > +     struct device *dev = pcie->dev;
> > +     struct mt7621_pcie_port *port, *tmp;
> > +     int err;
> > +
> > +     mt7621_pcie_reset_assert(pcie);
> > +     mt7621_pcie_reset_rc_deassert(pcie);
> > +
> > +     list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> > +             u32 slot = port->slot;
> > +
> > +             if (slot == 1) {
> > +                     port->enabled = true;
> > +                     continue;
> > +             }
> > +
> > +             err = mt7621_pcie_init_port(port);
> > +             if (err) {
> > +                     dev_err(dev, "Initiating port %d failed\n", slot);
> > +                     list_del(&port->list);
> > +             }
> > +     }
> > +
> > +     mt7621_pcie_reset_ep_deassert(pcie);
> > +
> > +     tmp = NULL;
> > +     list_for_each_entry(port, &pcie->ports, list) {
> > +             u32 slot = port->slot;
> > +
> > +             if (!mt7621_pcie_port_is_linkup(port)) {
> > +                     dev_err(dev, "pcie%d no card, disable it (RST & CLK)\n",
> > +                             slot);
> > +                     mt7621_control_assert(port);
> > +                     clk_disable_unprepare(port->clk);
> > +                     port->enabled = false;
> > +
> > +                     if (slot == 0) {
> > +                             tmp = port;
> > +                             continue;
> > +                     }
> > +
> > +                     if (slot == 1 && tmp && !tmp->enabled)
> > +                             phy_power_off(tmp->phy)
> > +             }
> > +     }
> > +}
> > +
> > +static void mt7621_pcie_enable_port(struct mt7621_pcie_port *port)
> > +{
> > +     struct mt7621_pcie *pcie = port->pcie;
> > +     u32 slot = port->slot;
> > +     u32 offset = MT7621_PCIE_OFFSET + (slot * MT7621_NEXT_PORT);
>
> I don't see how this works unless the ports happen to be at the same VA
> offset. The writes below are to the 'common' registers which are 0x100
> bytes long based on the DT example, but the offset lines up with the
> port offsets.

RC registers for port 0 start at physical address 0x1e142000, for port
1 0x1e143000 and for port 2 0x1e144000. We are using
'pcie_write' which internally uses pcie->base which is 0x1e140000, but
all the previous ones have been already requested and mapped for each
port so we calculate the offset from this 0x1e140000 and write there.

>
> > +     u32 val;
> > +
> > +     /* enable pcie interrupt */
> > +     val = pcie_read(pcie, RALINK_PCI_PCIMSK_ADDR);
> > +     val |= PCIE_PORT_INT_EN(slot);
> > +     pcie_write(pcie, val, RALINK_PCI_PCIMSK_ADDR);
> > +
> > +     /* map 2G DDR region */
> > +     pcie_write(pcie, PCIE_BAR_MAP_MAX | PCIE_BAR_ENABLE,
> > +                offset + RALINK_PCI_BAR0SETUP_ADDR);
> > +
> > +     /* configure class code and revision ID */
> > +     pcie_write(pcie, PCIE_CLASS_CODE | PCIE_REVISION_ID,
> > +                offset + RALINK_PCI_CLASS);
> > +}
> > +
> > +static int mt7621_pcie_enable_ports(struct mt7621_pcie *pcie)
> > +{
> > +     struct device *dev = pcie->dev;
> > +     struct mt7621_pcie_port *port;
> > +     u8 num_slots_enabled = 0;
> > +     u32 slot;
> > +     u32 val;
> > +     int err;
> > +
> > +     /* Setup MEMWIN and IOWIN */
> > +     pcie_write(pcie, 0xffffffff, RALINK_PCI_MEMBASE);
> > +     pcie_write(pcie, pcie->io.start, RALINK_PCI_IOBASE);
> > +
> > +     list_for_each_entry(port, &pcie->ports, list) {
> > +             if (port->enabled) {
> > +                     err = clk_prepare_enable(port->clk);
> > +                     if (err) {
> > +                             dev_err(dev, "enabling clk pcie%d\n", slot);
> > +                             return err;
> > +                     }
> > +
> > +                     mt7621_pcie_enable_port(port);
> > +                     dev_info(dev, "PCIE%d enabled\n", port->slot);
> > +                     num_slots_enabled++;
> > +             }
> > +     }
> > +
> > +     for (slot = 0; slot < num_slots_enabled; slot++) {
> > +             val = read_config(pcie, slot, PCI_COMMAND);
> > +             val |= PCI_COMMAND_MASTER;
> > +             write_config(pcie, slot, PCI_COMMAND, val);
> > +             /* configure RC FTS number to 250 when it leaves L0s */
> > +             val = read_config(pcie, slot, PCIE_FTS_NUM);
> > +             val &= ~PCIE_FTS_NUM_MASK;
> > +             val |= PCIE_FTS_NUM_L0(0x50);
> > +             write_config(pcie, slot, PCIE_FTS_NUM, val);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int mt7621_pcie_register_host(struct pci_host_bridge *host)
> > +{
> > +     struct mt7621_pcie *pcie = pci_host_bridge_priv(host);
> > +
> > +     host->ops = &mt7621_pci_ops;
> > +     host->sysdata = pcie;
> > +     return pci_host_probe(host);
> > +}
> > +
> > +static const struct soc_device_attribute mt7621_pci_quirks_match[] = {
> > +     { .soc_id = "mt7621", .revision = "E2" }
> > +};
> > +
> > +static int mt7621_pci_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     const struct soc_device_attribute *attr;
> > +     struct mt7621_pcie *pcie;
> > +     struct pci_host_bridge *bridge;
> > +     int err;
> > +
> > +     if (!dev->of_node)
> > +             return -ENODEV;
> > +
> > +     bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> > +     if (!bridge)
> > +             return -ENOMEM;
> > +
> > +     pcie = pci_host_bridge_priv(bridge);
> > +     pcie->dev = dev;
> > +     platform_set_drvdata(pdev, pcie);
> > +     INIT_LIST_HEAD(&pcie->ports);
> > +
> > +     attr = soc_device_match(mt7621_pci_quirks_match);
> > +     if (attr)
> > +             pcie->resets_inverted = true;
> > +
> > +     err = mt7621_pcie_parse_dt(pcie);
> > +     if (err) {
> > +             dev_err(dev, "Parsing DT failed\n");
> > +             return err;
> > +     }
> > +
> > +     err = mt7621_pci_parse_request_of_pci_ranges(bridge);
> > +     if (err) {
> > +             dev_err(dev, "Error requesting pci resources from ranges");
> > +             return err;
> > +     }
> > +
> > +     /* set resources limits */
> > +     ioport_resource.start = pcie->io.start;
> > +     ioport_resource.end = pcie->io.end;
> > +
> > +     mt7621_pcie_init_ports(pcie);
> > +
> > +     err = mt7621_pcie_enable_ports(pcie);
>
> Really need 2 functions here?

mt7621_pcie_init_ports is in charge of power on the phy and checks for
link status to see which ports are in use and mt7621_pcie_enable_ports
just enable all the stuff to be ready to be used.

>
> > +     if (err) {
> > +             dev_err(dev, "Error enabling pcie ports\n");
> > +             return err;
> > +     }
> > +
> > +     setup_cm_memory_region(pcie);
> > +
> > +     return mt7621_pcie_register_host(bridge);
> > +}
> > +
> > +static const struct of_device_id mt7621_pci_ids[] = {
> > +     { .compatible = "mediatek,mt7621-pci" },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, mt7621_pci_ids);
> > +
> > +static struct platform_driver mt7621_pci_driver = {
> > +     .probe = mt7621_pci_probe,
> > +     .driver = {
> > +             .name = "mt7621-pci",
> > +             .of_match_table = of_match_ptr(mt7621_pci_ids),
> > +     },
> > +};
> > +builtin_platform_driver(mt7621_pci_driver);
> > diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
> > index ec4daa63c5e3..50e5a54f7d9e 100644
> > --- a/arch/mips/ralink/Kconfig
> > +++ b/arch/mips/ralink/Kconfig
> > @@ -56,7 +56,7 @@ choice
> >               select MIPS_GIC
> >               select COMMON_CLK
> >               select CLKSRC_MIPS_GIC
> > -             select HAVE_PCI if PCI_MT7621
> > +             select HAVE_PCI
> >               select SOC_BUS
> >  endchoice
> >
> > @@ -101,4 +101,11 @@ choice
> >
> >  endchoice
> >
> > +config PCI_MT7621
> > +     bool "MediaTek MT7621 PCI Controller"
> > +     depends on RALINK && SOC_MT7621
>
> Ideally this should also have (|| COMPILE_TEST), but looks like there
> are a few MIPS dependencies in here. So maybe (|| (MIPS &&
> COMPILE_TEST)? If it's not built by allmodconfig or defconfig, it's hard
> for people to compile test it.

Ok, I will add (|| (MIPS && COMPILE_TEST) here.

Best regards,
    Sergio Paracuellos

>
>
> > +     select PCI_DRIVERS_GENERIC
> > +     help
> > +       This selects a driver for the MediaTek MT7621 PCI Controller.
> > +
> >  endif
> > --
> > 2.25.1
