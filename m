Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB63948D21F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 06:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiAMFxf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 00:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiAMFxf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jan 2022 00:53:35 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A37C06173F;
        Wed, 12 Jan 2022 21:53:34 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id c36so9046200uae.13;
        Wed, 12 Jan 2022 21:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bMxYIWRHh/o0aoNNOBZsT8i9mIQwEB01tPO+0Hzff7Q=;
        b=SZH4NnGXXPqrHuCGv+xI+aIuxfj7QWksW1kUlQyhMEel+Ir/tLwSzaXXstrg8rM8nV
         QOuXyA7mT/bNIs3xHQDxTtsxo5+OOnAoxqElY0NQjr4nziJTA1KbHuHBDrF4c9KRz8zI
         WCJKuIwDtYeWAdLZJKHc2qfqWAJpdjjiWNKoHxvtG3T1MzfynPRytBb4dEgmOxZ0NL3I
         dQ4YY5ktLtyak6uMDivjasLJLVMAg/HNnxaD0pxBnQ+UAdSFAy7nFxaxfw2DyTkZFkUg
         JgmgombYaG88pBMOD6acsoCqGLixMUb4mrGzVE2PD3U5YIgmzms6M00JU1f1EJC7VHf7
         jlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bMxYIWRHh/o0aoNNOBZsT8i9mIQwEB01tPO+0Hzff7Q=;
        b=v7d3hP782y5GPScRr0Swkk9PIM66ROq8hoBAiI80ePi5cMQ1pK6lCJHOZQDuEhJo3M
         XZLaVI4kk+UZrAcZoEszRGnZhJERm7vyLi8IZg3KVxLUkEBbyT3J25G/BVThSWTalBit
         jr7yTAvTWwdodSjE8VFM/89ccN/Sk79HafHB/wKKi5cv8WfyZH67Qu/4vWMZdHOX+jVz
         TTxl+Jek7NSTx1piVRC9c8dhhT+6SxOGtQNT+WGQkee5CMnhHRBpMu5kg/szSClVI5uV
         0V0rueKNM0susyjPuX88Ha2zN9XFuL/dxCOzqgqSyEbfCW3rN1nplDlppkfScY+efBKK
         lCig==
X-Gm-Message-State: AOAM53292KeuAbd5YlFWYDAQ/VVVEHEPYOnvws+VJ8connJgfJMMzRVR
        ROhQD8WZP98EdKgvAsP3IEj/GswDRprkjIVAg9g=
X-Google-Smtp-Source: ABdhPJywBUQRpT9CYmQvKAuwIDqYbr79iN/R9ZkvEqNhKhQu/73v2C4lUpRgi8YUDBrGb44yawRTQyvCVQP7A62D0s4=
X-Received: by 2002:a67:be18:: with SMTP id x24mr1619373vsq.43.1642053214016;
 Wed, 12 Jan 2022 21:53:34 -0800 (PST)
MIME-Version: 1.0
References: <20211207104924.21327-1-sergio.paracuellos@gmail.com>
 <20211207104924.21327-3-sergio.paracuellos@gmail.com> <20220112201056.GA5653@alpha.franken.de>
In-Reply-To: <20220112201056.GA5653@alpha.franken.de>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 13 Jan 2022 06:53:22 +0100
Message-ID: <CAMhs-H9xjKZQ7g-Ns9PzfTB59hU1UKLT3Q+1HUv8FP0wLy58Vg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] MIPS: ralink: implement 'pcibios_root_bridge_prepare()'
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 9:11 PM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Tue, Dec 07, 2021 at 11:49:21AM +0100, Sergio Paracuellos wrote:
> > PCI core code call 'pcibios_root_bridge_prepare()' function inside function
> > 'pci_register_host_bridge()'. This point is very good way to properly enter
> > into this MIPS ralink specific code to properly setup I/O coherency units
> > with PCI memory addresses.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
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
>
> Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thanks, Thomas!

Best regards,
    Sergio Paracuellos
>
> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
