Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9679948CCE4
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 21:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357012AbiALUKe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 15:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357224AbiALUKc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 15:10:32 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E21C06173F;
        Wed, 12 Jan 2022 12:10:32 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id i5so7006855uaq.10;
        Wed, 12 Jan 2022 12:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+xNMNzoJN9YEqe7h1YnZR3MXu+BdsLUcSma3TBj/qlY=;
        b=Fc332POiwbXnXeouq/OsiseB/jSFhy8NuD3ewinUwSgJc2Okx9WuCU5kw573bQJMb/
         Wwp3TiKkulw4sS5a+0PK5CyozC15eo6WnXWDAjVStUD87OHorpeOVJZYu/4d0qctRO2Q
         cTdcC7R8UusoY1OMP3d0pE36glbukZgEDa9S4Hw6vGfnX5xMD24cC/vz+J1fWTua8/dx
         dmBuiZAh2tLic0LuIlZwH2ebZzfsZcDvmWZ27SrjTyWQe5yWOT6tM1uZFaXe/MkTFkFg
         FHAEfZU0yXUSMqkRxGCsbXMYNDI8hfhfuYsUFOjHx0ZiVs8GaVHe8S9bU7gJuDk+J3J2
         u1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+xNMNzoJN9YEqe7h1YnZR3MXu+BdsLUcSma3TBj/qlY=;
        b=QNk5yaC57bz1jml9bkfL+TqCOmlfH8FcaCis+ry014MZn6+Z6lV/u2vvOJr/dl/u4V
         CIqt+qHtLwJEUMcFcbu4H20Ztov3HoL4g+3tLgc327jSwTd75p9z26G+XnLLHZfN8eFG
         8aiT+Q63kYZzEhIRsF14J6fskd2rdu/a1qTUF63U+GN9R8RpXIJTRLnM6Cm1+bMudR3l
         VA46gA52qk/a11rzvWe87bzDUHGq/wkvuIE+Ym6yzT7dXpM2jtUFMzxBr7/7XTeJVmR3
         ldXBu4vXcH4SgBl1yP0C4K8xlHLbskPPp/+iCWvfWKdkdZVq2BnlotQ8h0rAoVx8XEPG
         jhjA==
X-Gm-Message-State: AOAM533cTdYgRjMR4j2e/sBpGMJ6lUlE8sUhCWaEC25QBhMqvobHb7et
        OvdzMLsgqNq164VM4a/sasFOYk+e8SjkbX9wUhnPPXgoqK0=
X-Google-Smtp-Source: ABdhPJy5RKhxrrj/E+Fu3TMCFp6rkiROs/fdwrPPO31p9X01uWbr3szh2g2yqu2kAt/PBWC+yT7CJe/NlMHCJJ6ZStg=
X-Received: by 2002:a05:6102:dc9:: with SMTP id e9mr893623vst.17.1642018231219;
 Wed, 12 Jan 2022 12:10:31 -0800 (PST)
MIME-Version: 1.0
References: <20211207104924.21327-1-sergio.paracuellos@gmail.com>
 <20211207104924.21327-3-sergio.paracuellos@gmail.com> <20220112182015.GA403047@roeck-us.net>
In-Reply-To: <20220112182015.GA403047@roeck-us.net>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 12 Jan 2022 21:10:19 +0100
Message-ID: <CAMhs-H851_Dh4R2TXWh80n1BwXQ7PdY+mQ652iWkJs2erCgK-A@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] MIPS: ralink: implement 'pcibios_root_bridge_prepare()'
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 7:20 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Dec 07, 2021 at 11:49:21AM +0100, Sergio Paracuellos wrote:
> > PCI core code call 'pcibios_root_bridge_prepare()' function inside function
> > 'pci_register_host_bridge()'. This point is very good way to properly enter
> > into this MIPS ralink specific code to properly setup I/O coherency units
> > with PCI memory addresses.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>
> FWIW:
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks!

Best regards,
    Sergio Paracuellos

>
> > ---
> >  arch/mips/ralink/mt7621.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
> > index bd71f5b14238..d6efffd4dd20 100644
> > --- a/arch/mips/ralink/mt7621.c
> > +++ b/arch/mips/ralink/mt7621.c
> > @@ -10,6 +10,8 @@
> >  #include <linux/slab.h>
> >  #include <linux/sys_soc.h>
> >  #include <linux/memblock.h>
> > +#include <linux/pci.h>
> > +#include <linux/bug.h>
> >
> >  #include <asm/bootinfo.h>
> >  #include <asm/mipsregs.h>
> > @@ -22,6 +24,35 @@
> >
> >  static void *detect_magic __initdata = detect_memory_region;
> >
> > +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> > +{
> > +     struct resource_entry *entry;
> > +     resource_size_t mask;
> > +
> > +     entry = resource_list_first_type(&bridge->windows, IORESOURCE_MEM);
> > +     if (!entry) {
> > +             pr_err("Cannot get memory resource\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (mips_cps_numiocu(0)) {
> > +             /*
> > +              * Hardware doesn't accept mask values with 1s after
> > +              * 0s (e.g. 0xffef), so warn if that's happen
> > +              */
> > +             mask = ~(entry->res->end - entry->res->start) & CM_GCR_REGn_MASK_ADDRMASK;
> > +             WARN_ON(mask && BIT(ffz(~mask)) - 1 != ~mask);
> > +
> > +             write_gcr_reg1_base(entry->res->start);
> > +             write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
> > +             pr_info("PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
> > +                     (unsigned long long)read_gcr_reg1_base(),
> > +                     (unsigned long long)read_gcr_reg1_mask());
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  phys_addr_t mips_cpc_default_phys_base(void)
> >  {
> >       panic("Cannot detect cpc address");
> > --
> > 2.33.0
> >
