Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D022446725C
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 08:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243016AbhLCHG4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 02:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237867AbhLCHG4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 02:06:56 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE7CC06174A;
        Thu,  2 Dec 2021 23:03:33 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id ay21so3625109uab.12;
        Thu, 02 Dec 2021 23:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QJwiOrFQoyT/DFZ7NrGBfihykc/tgLBTmMyaxCgbZN0=;
        b=cARvOhzbk+98NFxDOIUeYpptxDaN0n0NklsGqrhionsXI2kRHcAFDotrRBF+weDfxj
         sMXA5ahhB7CJF8Z9LvCML2fb9JFoUbSEONPT2YqfQ1xChdLxZS7WWK6OIs6gTv0WV0Wm
         TKfn0yFzm+u1J/Aq77QeRZL5m3lOE9gyK/AIKIC4dblR3vKTXDpKlUgkvU5nAYPB0cCe
         n447+7t/hr8doZ5fn9vYNAjnJ8FDukCXSI1X1HBo/6q/bpyogv5ilxW4TaIXLy6TmCrn
         AsWFhuBmzJTFQ13WfXi7Ewv4Tp/P9NrjLA60tJ5kLdwjsnNwxKdHHp/DgrrZnzVFp59R
         u5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJwiOrFQoyT/DFZ7NrGBfihykc/tgLBTmMyaxCgbZN0=;
        b=MNKPFJ9e/zHY1gJ9WiwH1NhUjvChkZxzU5+BNt2mAycz7R4z24S7nv0li6o7iJ+yqv
         9P9B2fIpbwn1kOuJw87G11FF4TAzx/5ilz6isnfWtEQaKC9N4CRk9pf+9H3VRqb29wFO
         tBuETb3Eq01ns5t7g9IjShsu5kVKj5FilKtl7mAr9bvp0gLl+DbPUIwuPjoZffK1lNcO
         9QfMM8/iUvZagAW7VBPl1nQR+5ItYt39sobzbcWUgpx52Pjqj5My3THKA0Yj1wUq6tr+
         5LjK9T104rcLf6XvPxQfDAYZPlWG8PJU1m9uJkp5m2PIZMQj//gSn1W4ose6m4pfL2n7
         WedQ==
X-Gm-Message-State: AOAM533zrhQCh8GJqlnFWJrlbs1CIIEPQ8iLfMYkToE4r33pvlGSVIcF
        u1xe1dtDLb3GmiqmHZEh2m5eidDXBM3kiNdxcQ0=
X-Google-Smtp-Source: ABdhPJwjIuk1em7vd/YHbdqVvjuxdC2a8NZdd0mxjqAjPQc42tfDhqmlF+1uD7fgR+6Bft+JN52l1LdpYSNe0OVtSkA=
X-Received: by 2002:ab0:14a:: with SMTP id 68mr20041354uak.0.1638515012183;
 Thu, 02 Dec 2021 23:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20211201215127.23550-1-sergio.paracuellos@gmail.com>
 <20211201215127.23550-3-sergio.paracuellos@gmail.com> <6ebd3d77-e012-4b27-f0dc-a81c59d76fe4@roeck-us.net>
In-Reply-To: <6ebd3d77-e012-4b27-f0dc-a81c59d76fe4@roeck-us.net>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 3 Dec 2021 08:03:21 +0100
Message-ID: <CAMhs-H_Kdai3nOKZjAT04HMu67+wA3saoW_akQkfv3U0po41AQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] MIPS: ralink: implement 'pcibios_root_bridge_prepare()'
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 2, 2021 at 8:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 12/1/21 1:51 PM, Sergio Paracuellos wrote:
> > PCI core code call 'pcibios_root_bridge_prepare()' function inside function
> > 'pci_register_host_bridge()'. This point is very good way to properly enter
> > into this MIPS ralink specific code to properly setup I/O coherency units
> > with PCI memory addresses.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >   arch/mips/ralink/mt7621.c | 30 ++++++++++++++++++++++++++++++
> >   1 file changed, 30 insertions(+)
> >
> > diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
> > index bd71f5b14238..7649416c1cd7 100644
> > --- a/arch/mips/ralink/mt7621.c
> > +++ b/arch/mips/ralink/mt7621.c
> > @@ -10,6 +10,7 @@
> >   #include <linux/slab.h>
> >   #include <linux/sys_soc.h>
> >   #include <linux/memblock.h>
> > +#include <linux/pci.h>
> >
> >   #include <asm/bootinfo.h>
> >   #include <asm/mipsregs.h>
> > @@ -22,6 +23,35 @@
> >
> >   static void *detect_magic __initdata = detect_memory_region;
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
> > +              * FIXME: hardware doesn't accept mask values with 1s after
> > +              * 0s (e.g. 0xffef), so it would be great to warn if that's
> > +              * about to happen
> > +              */
> > +             mask = ~(entry->res->end - entry->res->start);
> > +
>
> One more comment: From the include file,
>
> #define CM_GCR_REGn_MASK_ADDRMASK               GENMASK(31, 16)
>
> suggests that only the upper 16 bit are valid (relevant ?) for the mask.
> Given that, it might make sense to make sure that the lower 16 bit are not set,
> maybe with
>                 mask = ~(entry->res->end - entry->res->start) & CM_GCR_REGn_MASK_ADDRMASK;
>

Makes sense, thanks.

Best regards,
     Sergio Paracuellos

> Thanks,
> Guenter
>
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
> >   phys_addr_t mips_cpc_default_phys_base(void)
> >   {
> >       panic("Cannot detect cpc address");
> >
>
