Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC87C4DE1F7
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 20:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiCRTx2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 15:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240380AbiCRTx1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 15:53:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8033B2EA0C7
        for <linux-pci@vger.kernel.org>; Fri, 18 Mar 2022 12:52:05 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m22so8270477pja.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Mar 2022 12:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TxyQU9xdSTkDPf7DmanTZxFZkgyt6Ymcs32y6swvm7I=;
        b=DijbxZfrxX0OVNg9nPviaR8NlqNiTJr0xRztihOJbp1FrlOqpH26AZNpdR/uJzYkNe
         xx5fcNzAFACZHHPZj1xOf/faiwovtl7pf3ZWUK9ZJ4oHuiUv86sf4LpfTb2ucsCF55Re
         gxgEzPwh1fo+XGdbgliXaye4kZlREpsTZyt9jfG1nhRYD+Ph/4VaH4Dqv5R2FIw1HKJX
         3uKl7qfNT1EVVeOdnP8rptW/Os4lgEEyqYueW6xMaeJM6c63YaAhHSAM02SmlyfF76FV
         RH+R8ji/J/HG5GwkA1cXRqCno6O7xmpr+JCGxlHmbxGJF/4dEF5BPmR29RsV9l/bO0r3
         0yEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TxyQU9xdSTkDPf7DmanTZxFZkgyt6Ymcs32y6swvm7I=;
        b=dnMKwM0DDr13w6QaB+u9N5tvKTUGm2mBOV17o7aKg6hHxrDdCtgyGLqmI3ayoQ0f6a
         42JaVv3nuKlTUQL/pya5sCisem5RMImlySbkZNcG8JmI/Jv0mzwdgBWq8jUXXeyL7xvx
         VMfBmjZdCsRNnRf0MvdRuaY2TDkwS6/LAeF4KOBi+81Ov/64t7skBTZp1m5Uf4FRWIZj
         SAjMRU9EyoyEd/jnTnBvdn/3lHxaACHXfi/SksCoWiiXD/WfbUxtO6qDj4oQdih8ez9W
         cZdJHeDVZS6mvWsD1Iwn7OKsevoSwuRp/KGZ2SciPsXGwDY9GFoQWLRk7qYV6oe4K1Sv
         WhdQ==
X-Gm-Message-State: AOAM531c/7YK79C/v7pOVcV9KpoOh25WTKqJ0pprzVoXYW5KdiNiFWYc
        1ft/hB101fCV36ZCOwYJKCFgfZNMh6zY7WSV4e7d6kznT5OB7g==
X-Google-Smtp-Source: ABdhPJybM4M5BvZOTXZQ0xgtK4A/Ap+r4Jh2y7ZWqTwZFsrjGPv/0bsTnrh4+FfvZQ8gjguS1CtuNr29pJGsVdRq708=
X-Received: by 2002:a17:902:d504:b0:154:172:3677 with SMTP id
 b4-20020a170902d50400b0015401723677mr1087759plg.147.1647633124965; Fri, 18
 Mar 2022 12:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164740405408.3912056.16337643017370667205.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220317105659.000075fc@Huawei.com>
In-Reply-To: <20220317105659.000075fc@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Mar 2022 12:51:54 -0700
Message-ID: <CAPcyv4jOSmva4gkAzz_Y6YijjvWmR6mYPZZQ6VyAOdZqkmZvug@mail.gmail.com>
Subject: Re: [PATCH 6/8] cxl/pci: Prepare for mapping RAS Capability Structure
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 17, 2022 at 3:57 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 15 Mar 2022 21:14:14 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > The RAS Capabilitiy Structure is a CXL Component register capability
> > block. Unlike the HDM Decoder Capability, it will be referenced by the
> > cxl_pci driver in response to PCIe AER events. Due to this it is no
> > longer the case that cxl_map_component_regs() can assume that it should
> > map all component registers. Plumb a bitmask of capability ids to map
> > through cxl_map_component_regs().
> >
> > For symmetry cxl_probe_device_regs() is updated to populate @id in
> > 'struct cxl_reg_map' even though cxl_map_device_regs() does not have a
> > need to map a subset of the device registers per caller.
>
> I guess it doesn't hurt to add that, though without the mask being
> passed into appropriate functions it's a bit pointless.  What we have
> is now 'half symmetric' perhaps.

True, I was mainly worried about someone dumping the rmap->id in a
debug session and wondering why all the ids are zero for
device-register instances, but no need to add the per-id allocation
since there's only one cxl_map_device_regs() caller today.

> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> A few trivial comments inline, but basically looks good to me.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> > ---
> >  drivers/cxl/core/hdm.c  |    3 ++-
> >  drivers/cxl/core/regs.c |   36 ++++++++++++++++++++++++++----------
> >  drivers/cxl/cxl.h       |    7 ++++---
> >  3 files changed, 32 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 09221afca309..b348217ab704 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -92,7 +92,8 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
> >               return -ENXIO;
> >       }
> >
> > -     return cxl_map_component_regs(&port->dev, regs, &map);
> > +     return cxl_map_component_regs(&port->dev, regs, &map,
> > +                                   BIT(CXL_CM_CAP_CAP_ID_HDM));
> >  }
> >
> >  /**
> > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > index 219c7d0e43e2..c022c8937dfc 100644
> > --- a/drivers/cxl/core/regs.c
> > +++ b/drivers/cxl/core/regs.c
> > @@ -92,6 +92,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
> >               if (!rmap)
> >                       continue;
> >               rmap->valid = true;
> > +             rmap->id = cap_id;
> >               rmap->offset = CXL_CM_OFFSET + offset;
> >               rmap->size = length;
> >       }
> > @@ -159,6 +160,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> >               if (!rmap)
> >                       continue;
> >               rmap->valid = true;
> > +             rmap->id = cap_id;
> >               rmap->offset = offset;
> >               rmap->size = length;
> >       }
> > @@ -187,17 +189,31 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> >  }
> >
> >  int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
> > -                        struct cxl_register_map *map)
> > +                        struct cxl_register_map *map, unsigned long map_mask)
>
> Maybe pass an unsigned long *map_mask from the start for the inevitable
> capability IDs passing the minimum length of a long?
> Disadvantage being you'll need to roll a local BITMAP to pass in at all callsites.

I'm ok to leave that to future folks since we're only up to 8 ids in
today's spec, and the compiler will flag "error: left shift count >=
width of type" if someone tries to add support for that high numbered
capability id.

>
> >  {
> > -     resource_size_t phys_addr;
> > -     resource_size_t length;
> > -
> > -     phys_addr = map->resource;
> > -     phys_addr += map->component_map.hdm_decoder.offset;
> > -     length = map->component_map.hdm_decoder.size;
> > -     regs->hdm_decoder = devm_cxl_iomap_block(dev, phys_addr, length);
> > -     if (!regs->hdm_decoder)
> > -             return -ENOMEM;
> > +     struct mapinfo {
> > +             struct cxl_reg_map *rmap;
> > +             void __iomem **addr;
> > +     } mapinfo[] = {
> > +             { .rmap = &map->component_map.hdm_decoder, &regs->hdm_decoder },
>
> As in previous instance, mixing two styles of assignment seems odd.

Yup, will fix.

>
> > +     };
> > +     int i;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
> > +             struct mapinfo *mi = &mapinfo[i];
> > +             resource_size_t phys_addr;
> > +             resource_size_t length;
> > +
> > +             if (!mi->rmap->valid)
> > +                     continue;
> > +             if (!test_bit(mi->rmap->id, &map_mask))
> > +                     continue;
> > +             phys_addr = map->resource + mi->rmap->offset;
> > +             length = mi->rmap->size;
> > +             *(mi->addr) = devm_cxl_iomap_block(dev, phys_addr, length);
> > +             if (!*(mi->addr))
> > +                     return -ENOMEM;
> > +     }
> >
> >       return 0;
> >  }
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 2080a75c61fe..52bd77d8e22a 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -115,6 +115,7 @@ struct cxl_regs {
> >
> >  struct cxl_reg_map {
> >       bool valid;
> > +     int id;
> >       unsigned long offset;
> >       unsigned long size;
> >  };
> > @@ -153,9 +154,9 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
> >                             struct cxl_component_reg_map *map);
> >  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> >                          struct cxl_device_reg_map *map);
> > -int cxl_map_component_regs(struct device *dev,
> > -                        struct cxl_component_regs *regs,
> > -                        struct cxl_register_map *map);
> > +int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
>
> Worth the rewrapping and extra diff as a result?  (I think it's precisely 80 chars)

clang-format says yes. If I ask it to flow just the new @map_mask
argument it reflows the whole declaration. However, this formatting
change should be pushed back to "[PATCH 4/8] cxl/core/regs: Make
cxl_map_{component, device}_regs() device generic", because that's the
patch that reduced the first argument from "struct pci_dev *pdev" to
the shorter "struct device *dev" allowing the second arg to move onto
the same line.

>
> > +                        struct cxl_register_map *map,
> > +                        unsigned long map_mask);
> >  int cxl_map_device_regs(struct device *dev,
> >                       struct cxl_device_regs *regs,
> >                       struct cxl_register_map *map);
> >
>
