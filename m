Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E867246672D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 16:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359207AbhLBPyH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 10:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359195AbhLBPxx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 10:53:53 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2BEC06174A;
        Thu,  2 Dec 2021 07:50:31 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id ay21so56677850uab.12;
        Thu, 02 Dec 2021 07:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KPLWuZbDpzv1kp0LWjPj2YqGR9hJaA24u975f2wyCYk=;
        b=qhqaps9Vt2YampZvLYdHoGtB7r+0dKFd1QcIRQQ7RtqIAQO+9AiE1xZ4ny5GV8HEpM
         N65nEBqMVXm4Mj5fDdvjuAoIm3D38Eus24wSgspvKxIzu66qMBhiTW41y7lzYNdUWGRh
         tZ6PO3v88lZ7kAVrkWrP1l8h2+HHpyvgIzPAP1fa9CLqv9hA8GMNIR8+pxTTGZCmblto
         +uj1/0VoWVQxODdtgX/biboaczF5HhgVuXTL/uP4EPk0PFJBYwPT0e/cmhKS4qBLbl9B
         HO/ckVEzVm/Uflv+fmj+1bl93fTZNBdvKH6uZDEDgeIORJhcty1Evchqa9Cu0yMildqV
         wVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KPLWuZbDpzv1kp0LWjPj2YqGR9hJaA24u975f2wyCYk=;
        b=29/ZTTs6Q3q0wbeqRMUnOoNy0uM95NBZ1+1abgd9yel9AVxrZOJgnkl7r3e8FAJkdV
         rqpj54qJpvA9zC3Oj2hWZvlWQ9BNG4pVo7XeXgUdIGSr0Nqf9T4Kkyo42sdwDM7CNIfB
         GAzcJdI0lNQOQrFfulWP7yOomytc93M8UmOKcHViioCctn/GLQq8jHsF54QERX582buw
         LoWvftvhmjGV6ApBhnkX082tBincB5AwFK2757noy/z3RwODKZnyAqOzqvwtwyqKW81r
         4kkGMjkfOsYnBlUG4eu6vkAQw9eZfWpkiIep3Xs+ThtdDylUzRkSzhvJtmP3bYovGTHO
         BAzw==
X-Gm-Message-State: AOAM530xG+/YLgdyX0px5BoaFYvjzV/LrCSQv5c4BnibWbNoVAkMih4P
        WuJiLhKmhQJ/8aegTdTG5XAIxAGZEu0BxScnVtc=
X-Google-Smtp-Source: ABdhPJy1bmw0Xg/IQFqHcoCGPTFUqt/k5Ldc15mJ2WgIKzBSh9DjID3VoaehV9XAooEg7FJwjlbB3a7aLyHHE1QbNJc=
X-Received: by 2002:ab0:6883:: with SMTP id t3mr15658152uar.66.1638460230314;
 Thu, 02 Dec 2021 07:50:30 -0800 (PST)
MIME-Version: 1.0
References: <20211201215127.23550-1-sergio.paracuellos@gmail.com>
 <20211201215127.23550-3-sergio.paracuellos@gmail.com> <d243a90d-25b2-a65f-b69d-af7497db8742@roeck-us.net>
 <CAMhs-H_i7aFeqf4EBtzdL0SKgKrseZGpVU-ytvangpeCMVTmFw@mail.gmail.com> <9401e88b-de5a-dd2a-7e82-f3657ea86e8f@roeck-us.net>
In-Reply-To: <9401e88b-de5a-dd2a-7e82-f3657ea86e8f@roeck-us.net>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 2 Dec 2021 16:50:18 +0100
Message-ID: <CAMhs-H8vw48RkpFz+rqvoPqDPpkaHdn60j6SdbDJHTNTTp7Fcg@mail.gmail.com>
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

Hi Guenter,

On Thu, Dec 2, 2021 at 4:06 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 12/2/21 12:29 AM, Sergio Paracuellos wrote:
> > Hi Guenter,
> >
> > On Wed, Dec 1, 2021 at 11:17 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On 12/1/21 1:51 PM, Sergio Paracuellos wrote:
> >>> PCI core code call 'pcibios_root_bridge_prepare()' function inside function
> >>> 'pci_register_host_bridge()'. This point is very good way to properly enter
> >>> into this MIPS ralink specific code to properly setup I/O coherency units
> >>> with PCI memory addresses.
> >>>
> >>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> >>> ---
> >>>    arch/mips/ralink/mt7621.c | 30 ++++++++++++++++++++++++++++++
> >>>    1 file changed, 30 insertions(+)
> >>>
> >>> diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
> >>> index bd71f5b14238..7649416c1cd7 100644
> >>> --- a/arch/mips/ralink/mt7621.c
> >>> +++ b/arch/mips/ralink/mt7621.c
> >>> @@ -10,6 +10,7 @@
> >>>    #include <linux/slab.h>
> >>>    #include <linux/sys_soc.h>
> >>>    #include <linux/memblock.h>
> >>> +#include <linux/pci.h>
> >>>
> >>>    #include <asm/bootinfo.h>
> >>>    #include <asm/mipsregs.h>
> >>> @@ -22,6 +23,35 @@
> >>>
> >>>    static void *detect_magic __initdata = detect_memory_region;
> >>>
> >>> +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> >>> +{
> >>> +     struct resource_entry *entry;
> >>> +     resource_size_t mask;
> >>> +
> >>> +     entry = resource_list_first_type(&bridge->windows, IORESOURCE_MEM);
> >>> +     if (!entry) {
> >>> +             pr_err("Cannot get memory resource\n");
> >>> +             return -EINVAL;
> >>> +     }
> >>> +
> >>> +     if (mips_cps_numiocu(0)) {
> >>> +             /*
> >>> +              * FIXME: hardware doesn't accept mask values with 1s after
> >>> +              * 0s (e.g. 0xffef), so it would be great to warn if that's
> >>> +              * about to happen
> >>> +              */ > +         mask = ~(entry->res->end - entry->res->start);
> >>> +
> >>
> >> Try something like this:
> >>                  WARN_ON((mask != ~0UL && BIT(ffz(mask)) - 1 != mask);
> >
> > Thanks for the tip. The following works for me:
> >
> >                    WARN_ON(mask != ~0UL && ~(BIT(__ffs(mask)) - 1) != mask);
>
> Are you sure ? __ffs() returns the first bit set, which isn't useful
> for this test.

My mask is calculated as follows:
 mask = ~(entry->res->end - entry->res->start);

Where for normal memory resource:
 - entry->res->end = 0x6fffffff;
 - entry->res->start = 0x60000000;

So I end up with a mask: 0xf0000000.

So applying ~(BIT(__ffs(mask)) - 1) I get a good '0xf0000000' for this
particular case which looks correct.

Suppose an invalid case with the mask being 0xffef0000.

Applying ~(BIT(__ffs(mask)) - 1) will be 0xffff0000 which will trigger
the WARN_ON since 0xffff0000 != 0xffef0000

So I think this is correct... Am I missing something?

Thanks,
    Sergio Paracuellos
>
> Guenter
>
> >
> > I will send this as a different patch, though.
> >
> > Best regards,
> >      Sergio Paracuellos
> >
> >>
> >>> +             write_gcr_reg1_base(entry->res->start);
> >>> +             write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
> >>> +             pr_info("PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
> >>> +                     (unsigned long long)read_gcr_reg1_base(),
> >>> +                     (unsigned long long)read_gcr_reg1_mask());
> >>> +     }
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>>    phys_addr_t mips_cpc_default_phys_base(void)
> >>>    {
> >>>        panic("Cannot detect cpc address");
> >>>
> >>
>
