Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B721E31EA
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 00:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391738AbgEZWBr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 18:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390639AbgEZWBr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 18:01:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54A8C03E96D
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2020 15:01:46 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h4so1155394wmb.4
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2020 15:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SdxC6l3m+bQG91grYSJ7i2ndjfK4R2ucc+n9fkumIc4=;
        b=aBK0vxQT1l+ZohFwKm07oRm1W2PZ2wGi2DLu96f5egTMeIiVPtpJvEubQVaDSgYRdl
         8ahJu31JddVKaP288EzASEU/vjnRI/HaINMV43cXsVKanYzuJ6hEuor74EnU3JB95dGh
         MHjuRC91F0zMY+2KGOBQHsaOmoMXgi+D1r2uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SdxC6l3m+bQG91grYSJ7i2ndjfK4R2ucc+n9fkumIc4=;
        b=m4zNXnd9qDf59CWDWINTLZbIGuJ0eQDAjheeqxQxi1/RZJ3mCk01Pau+zfAU2De0kZ
         AU+utx5mqHuMCScPaNwrpIgkdrsj3BDnp1GYzNfl/LS7zD5G1MxnnAMdcJk7p/GxPru2
         yTFmPaiKtQFCV96SC1sucU+7CalZVNxGE+gKz+F/PdEBUyOwYX9r0Esy20Io4dxGs3hY
         rYYxtPKsab9wQ92+TbZpVMh8fEXjHBCDX6kFS4mj4nRd8XPx2iwYZyfOvtzkX+g/IPIn
         x7OFiVgdDFAF+oM/sym2ev+N6iNWQ+eiCwl/QIwyPPd1wT2PtQNUPASs9JwXix001/qW
         9dKQ==
X-Gm-Message-State: AOAM532vde2/HxMrUVwg1AWbftpO2AC9YHDBfXCYP2PlbJQYLNlasH6M
        SJ12SgLkruSgXdLnr2QL3bUZ4nWv3JqxD8NKE1aE3Xxa
X-Google-Smtp-Source: ABdhPJwfIgA4eouOfhmDbwylJHRx9EwTl8kvunBH1z0/OXwsP4fk9fbZi9FIiufnG/JQ2WjEz8WJfvRR2+WeJx4b9a8=
X-Received: by 2002:a1c:7305:: with SMTP id d5mr1190780wmb.85.1590530505131;
 Tue, 26 May 2020 15:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200526191303.1492-1-james.quinlan@broadcom.com>
 <20200526191303.1492-10-james.quinlan@broadcom.com> <20200526205448.GA1634618@smile.fi.intel.com>
In-Reply-To: <20200526205448.GA1634618@smile.fi.intel.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Tue, 26 May 2020 18:01:32 -0400
Message-ID: <CA+-6iNwQG9bz_EW+zKfDkAF27KrW9Nv2KrG6jQ-Edma7rG6LfQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] device core: Add ability to handle multiple dma offsets
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Wolfram Sang <wsa@kernel.org>, Corey Minyard <minyard@acm.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Andy,

On Tue, May 26, 2020 at 4:54 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, May 26, 2020 at 03:12:48PM -0400, Jim Quinlan wrote:
> > The new field in struct device 'dma_pfn_offset_map' is used to facilitate
> > the use of multiple pfn offsets between cpu addrs and dma addrs.  It is
> > similar to 'dma_pfn_offset' except that the offset chosen depends on the
> > cpu or dma address involved.
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >  drivers/of/address.c        | 65 +++++++++++++++++++++++++++++++++++--
> >  drivers/usb/core/message.c  |  3 ++
> >  drivers/usb/core/usb.c      |  3 ++
> >  include/linux/device.h      | 10 +++++-
> >  include/linux/dma-direct.h  | 10 ++++--
> >  include/linux/dma-mapping.h | 46 ++++++++++++++++++++++++++
> >  kernel/dma/Kconfig          | 13 ++++++++
> >  7 files changed, 144 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index 96d8cfb14a60..a01afffcde7d 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -918,6 +918,47 @@ void __iomem *of_io_request_and_map(struct device_node *np, int index,
> >  }
> >  EXPORT_SYMBOL(of_io_request_and_map);
> >
> > +#ifdef CONFIG_DMA_PFN_OFFSET_MAP
> > +static int attach_dma_pfn_offset_map(struct device *dev,
> > +                                  struct device_node *node, int num_ranges)
> > +{
> > +     struct of_range_parser parser;
> > +     struct of_range range;
> > +     size_t r_size = (num_ranges + 1)
> > +             * sizeof(struct dma_pfn_offset_region);
> > +     struct dma_pfn_offset_region *r;
> > +
>
> > +     r = devm_kzalloc(dev, r_size, GFP_KERNEL);
>
> devm_?!

Yes, otherwise if the device gets unbound/bound repeatedly then there
would be a memory leak.

>
>
> Looking at r_size it should be rather kcalloc().

Yep.
>
>
> > +     if (!r)
> > +             return -ENOMEM;
> > +     dev->dma_pfn_offset_map = r;
> > +     of_dma_range_parser_init(&parser, node);
> > +
> > +     /*
> > +      * Record all info for DMA ranges array.  We could
> > +      * just use the of_range struct, but if we did that it
> > +      * would require more calculations for phys_to_dma and
> > +      * dma_to_phys conversions.
> > +      */
> > +     for_each_of_range(&parser, &range) {
> > +             r->cpu_beg = range.cpu_addr;
> > +             r->cpu_end = r->cpu_beg + range.size;
> > +             r->dma_beg = range.bus_addr;
> > +             r->dma_end = r->dma_beg + range.size;
> > +             r->pfn_offset = PFN_DOWN(range.cpu_addr)
> > +                     - PFN_DOWN(range.bus_addr);
> > +             r++;
> > +     }
> > +     return 0;
> > +}
> > +#else
> > +static int attach_dma_pfn_offset_map(struct device *dev,
> > +                                  struct device_node *node, int num_ranges)
> > +{
> > +     return 0;
> > +}
> > +#endif
> > +
> >  /**
> >   * of_dma_get_range - Get DMA range info
> >   * @dev:     device pointer; only needed for a corner case.
> > @@ -947,6 +988,8 @@ int of_dma_get_range(struct device *dev, struct device_node *np, u64 *dma_addr,
> >       struct of_range_parser parser;
> >       struct of_range range;
> >       u64 dma_start = U64_MAX, dma_end = 0, dma_offset = 0;
> > +     bool dma_multi_pfn_offset = false;
> > +     int num_ranges = 0;
> >
> >       while (node) {
> >               ranges = of_get_property(node, "dma-ranges", &len);
> > @@ -977,10 +1020,19 @@ int of_dma_get_range(struct device *dev, struct device_node *np, u64 *dma_addr,
> >               pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
> >                        range.bus_addr, range.cpu_addr, range.size);
> >
> > +             num_ranges++;
> >               if (dma_offset && range.cpu_addr - range.bus_addr != dma_offset) {
> > -                     pr_warn("Can't handle multiple dma-ranges with different offsets on node(%pOF)\n", node);
> > -                     /* Don't error out as we'd break some existing DTs */
> > -                     continue;
> > +                     if (!IS_ENABLED(CONFIG_DMA_PFN_OFFSET_MAP)) {
> > +                             pr_warn("Can't handle multiple dma-ranges with different offsets on node(%pOF)\n", node);
> > +                             pr_warn("Perhaps set DMA_PFN_OFFSET_MAP=y?\n");
> > +                             /*
> > +                              * Don't error out as we'd break some existing
> > +                              * DTs that are using configs w/o
> > +                              * CONFIG_DMA_PFN_OFFSET_MAP set.
> > +                              */
> > +                             continue;
> > +                     }
> > +                     dma_multi_pfn_offset = true;
> >               }
> >               dma_offset = range.cpu_addr - range.bus_addr;
> >
> > @@ -991,6 +1043,13 @@ int of_dma_get_range(struct device *dev, struct device_node *np, u64 *dma_addr,
> >                       dma_end = range.bus_addr + range.size;
> >       }
> >
> > +     if (dma_multi_pfn_offset) {
> > +             dma_offset = 0;
> > +             ret = attach_dma_pfn_offset_map(dev, node, num_ranges);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> >       if (dma_start >= dma_end) {
> >               ret = -EINVAL;
> >               pr_debug("Invalid DMA ranges configuration on node(%pOF)\n",
> > diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> > index 6197938dcc2d..aaa3e58f5eb4 100644
> > --- a/drivers/usb/core/message.c
> > +++ b/drivers/usb/core/message.c
> > @@ -1960,6 +1960,9 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
> >                */
> >               intf->dev.dma_mask = dev->dev.dma_mask;
> >               intf->dev.dma_pfn_offset = dev->dev.dma_pfn_offset;
> > +#ifdef CONFIG_DMA_PFN_OFFSET_MAP
> > +             intf->dev.dma_pfn_offset_map = dev->dev.dma_pfn_offset_map;
> > +#endif
> >               INIT_WORK(&intf->reset_ws, __usb_queue_reset_device);
> >               intf->minor = -1;
> >               device_initialize(&intf->dev);
> > diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> > index f16c26dc079d..d2ed4d90e56e 100644
> > --- a/drivers/usb/core/usb.c
> > +++ b/drivers/usb/core/usb.c
> > @@ -612,6 +612,9 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
> >        */
> >       dev->dev.dma_mask = bus->sysdev->dma_mask;
> >       dev->dev.dma_pfn_offset = bus->sysdev->dma_pfn_offset;
> > +#ifdef CONFIG_DMA_PFN_OFFSET_MAP
> > +     dev->dev.dma_pfn_offset_map = bus->sysdev->dma_pfn_offset_map;
> > +#endif
> >       set_dev_node(&dev->dev, dev_to_node(bus->sysdev));
> >       dev->state = USB_STATE_ATTACHED;
> >       dev->lpm_disable_count = 1;
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index ac8e37cd716a..67a240ad4fc5 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -493,6 +493,8 @@ struct dev_links_info {
> >   * @bus_dma_limit: Limit of an upstream bridge or bus which imposes a smaller
> >   *           DMA limit than the device itself supports.
> >   * @dma_pfn_offset: offset of DMA memory range relatively of RAM
> > + * @dma_pfn_offset_map:      Like dma_pfn_offset but used when there are multiple
> > + *           pfn offsets for multiple dma-ranges.
> >   * @dma_parms:       A low level driver may set these to teach IOMMU code about
> >   *           segment limitations.
> >   * @dma_pools:       Dma pools (if dma'ble device).
> > @@ -578,7 +580,13 @@ struct device {
> >                                            allocations such descriptors. */
> >       u64             bus_dma_limit;  /* upstream dma constraint */
> >       unsigned long   dma_pfn_offset;
> > -
> > +#ifdef CONFIG_DMA_PFN_OFFSET_MAP
> > +     const struct dma_pfn_offset_region *dma_pfn_offset_map;
>
> > +                                     /* Like dma_pfn_offset, but for
> > +                                      * the unlikely case of multiple
> > +                                      * offsets. If non-null, dma_pfn_offset
> > +                                      * will be set to 0. */
>
> A bit harder to read comment indented too much and located after the declared variable.

Okay, will change. I was trying to keep the comment style of the other
variables.

> > +#endif
> >       struct device_dma_parameters *dma_parms;
> >
> >       struct list_head        dma_pools;      /* dma pools (if dma'ble) */
> > diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> > index 24b8684aa21d..03110a57eabc 100644
> > --- a/include/linux/dma-direct.h
> > +++ b/include/linux/dma-direct.h
> > @@ -14,15 +14,21 @@ extern unsigned int zone_dma_bits;
> >  static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
> >  {
> >       dma_addr_t dev_addr = (dma_addr_t)paddr;
> > +     /* The compiler should remove the 2nd term if !DMA_PFN_OFFSET_MAP */
> > +     unsigned long dma_pfn_offset = dev->dma_pfn_offset
> > +             + dma_pfn_offset_from_phys_addr(dev, paddr);
> >
> > -     return dev_addr - ((dma_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
> > +     return dev_addr - ((dma_addr_t)dma_pfn_offset << PAGE_SHIFT);
> >  }
> >
> >  static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dev_addr)
> >  {
> >       phys_addr_t paddr = (phys_addr_t)dev_addr;
> > +     /* The compiler should remove the 2nd term if !DMA_PFN_OFFSET_MAP */
> > +     unsigned long dma_pfn_offset = dev->dma_pfn_offset
> > +             + dma_pfn_offset_from_dma_addr(dev, paddr);
> >
> > -     return paddr + ((phys_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
> > +     return paddr + ((phys_addr_t)dma_pfn_offset << PAGE_SHIFT);
> >  }
> >  #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
> >
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index 330ad58fbf4d..91940bba2229 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -256,6 +256,52 @@ static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
> >  size_t dma_direct_max_mapping_size(struct device *dev);
> >
> >  #ifdef CONFIG_HAS_DMA
> > +#ifdef CONFIG_DMA_PFN_OFFSET_MAP
> > +struct dma_pfn_offset_region {
>
> > +     phys_addr_t     cpu_beg;
> > +     phys_addr_t     cpu_end;
> > +     dma_addr_t      dma_beg;
> > +     dma_addr_t      dma_end;
>
> Perhaps
>         s,beg,start,
> in above names
>
Okay.

>
> > +     unsigned long   pfn_offset;
> > +};
> > +
> > +static inline unsigned long dma_pfn_offset_from_dma_addr(struct device *dev,
> > +                                                      dma_addr_t dma_addr)
> > +{
> > +     const struct dma_pfn_offset_region *m = dev->dma_pfn_offset_map;
>
> > +     if (m)
> > +             for (; m->cpu_end; m++)
>
> Why not simple
>
>         while (m) {
>                 ...
>         }
>
> ?
>
That won't work;  'm' is either null or a valid pointer to an array
which has an additional entry that is 0-filled..  If non-null, 'm'
will never turn into NULL via 'm++' and the while loop will not
terminate.
>
>
> > +                     if (dma_addr >= m->dma_beg && dma_addr < m->dma_end)
> > +                             return m->pfn_offset;
> > +     return 0;
> > +}
> > +
> > +static inline unsigned long dma_pfn_offset_from_phys_addr(struct device *dev,
> > +                                                       phys_addr_t paddr)
> > +{
> > +     const struct dma_pfn_offset_region *m = dev->dma_pfn_offset_map;
> > +
>
> > +     if (m)
> > +             for (; m->cpu_end; m++)
>
> Ditto.
>
> > +                     if (paddr >= m->cpu_beg && paddr < m->cpu_end)
> > +                             return m->pfn_offset;
> > +     return 0;
> > +}
> > +#else  /* CONFIG_DMA_PFN_OFFSET_MAP */
> > +static inline unsigned long dma_pfn_offset_from_dma_addr(struct device *dev,
> > +                                                      dma_addr_t dma_addr)
> > +{
> > +     return 0;
> > +}
> > +
> > +static inline unsigned long dma_pfn_offset_from_phys_addr(struct device *dev,
> > +                                                       phys_addr_t paddr)
> > +{
> > +     return 0;
> > +}
> > +#endif /* CONFIG_DMA_PFN_OFFSET_MAP */
> > +
> >  #include <asm/dma-mapping.h>
> >
> >  static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
> > diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> > index 4c103a24e380..ceb7e5e8f501 100644
> > --- a/kernel/dma/Kconfig
> > +++ b/kernel/dma/Kconfig
> > @@ -195,3 +195,16 @@ config DMA_API_DEBUG_SG
> >         is technically out-of-spec.
> >
> >         If unsure, say N.
> > +
> > +config DMA_PFN_OFFSET_MAP
> > +     bool "Uses a DMA range map to calculate PFN offset"
> > +     depends on PCIE_BRCMSTB
>
> > +     default n
>
> Redundant.

Okay.
>
> > +     help
> > +       Some devices have a dma-range that gets converted to
> > +       a dev->dma_pfn_offset value.  This option is for the
> > +       atypical case of there being multiple dma-ranges requiring
> > +       multiple pfn offsets, which are selected from when
> > +       converting to phys to dma and vice versa.
> > +
> > +       If unsure, say N.
> > --
> > 2.17.1
> >
>
> --
> With Best Regards,
> Andy Shevchenko


Thanks!
Jim Quinlan
