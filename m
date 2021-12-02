Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB994669FA
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 19:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhLBSpI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 13:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhLBSpH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 13:45:07 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0E1C06174A;
        Thu,  2 Dec 2021 10:41:44 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id m16so194400vkl.13;
        Thu, 02 Dec 2021 10:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jlkcU/LshfTlpRQHKItZ7lgWIZTTU48Suk27bZaQ6SI=;
        b=SszHNGbdgz/q4zTK7ZHrq1za+0KN7+WYA/iVNcpc9SRp08lSjUByV7AIC9aXz7DCwh
         Osz6YuxLLvMELPudYYGzNvZ93Blos078XmJiOCqPImcFIuoIDo2dJ18HyZJCM5EBXj40
         XpCVxiiROH0NBqXy8wyV7xZ2jnB4V67c2kniEMZemnkwApNucMZDazz0C/STmwn9i6+a
         kos07nDW2V7MkHAoqrZ5zPT7QdYl7dmvydMOWbAb2g4DBK+UX5dVGXL09rtqpPzW6dBn
         zRnQRlnPGOw5uAdLzMuNL6NeqwQcleguRca68oaS2CLZXOcVMXcQaSCZ/5bzkjylG8ic
         U6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jlkcU/LshfTlpRQHKItZ7lgWIZTTU48Suk27bZaQ6SI=;
        b=y7kJHrkTSLQcStDYClAsZLKEZDMZgOkkAV3D6fm5b+s5bLe1drqAfRX0DP6x9Gh5CP
         Pf5PbmQG/ImoIJVQmDiWnJNCsTLZFujw0KaQjsbpn0YdAKiLbMbeWW4QCNfcE6ldTh3s
         RJJ4BTFEAtQR3S66Tp47+wtLY+hcGfyu+hBfRAn31tH+L/E/AxvtJtIzHcM7stQCCZCA
         urvWcrEdPIp+LZdQWNCmfyL//3y4fSxl44ccqUTGbILndZpWeoYi3/bJfxa9wVH1Rd/q
         ay7lEaOhPTqn7TNii8hfyrw456vz0kGxq4qVHuI8B9q0HjwRVSA9e4FsOEvTVxY94Ut4
         1m2Q==
X-Gm-Message-State: AOAM533e4G06j7N7RDmoq9/TrDuEPTt+3J+1J/6EdKGRYLp/oSSJva66
        J8rso9paP+MM7tJVga+WF8N9q1p6eK6vV51pzpo=
X-Google-Smtp-Source: ABdhPJz8j6ZFP8VCxEZnkfKFuJWOeO7lz5PbnbrijExs4K9ro7AvuJYLB4vh3Wp+cwV/4MXjJtJzThTnbrmZzFXqRks=
X-Received: by 2002:a1f:2849:: with SMTP id o70mr17112084vko.35.1638470503418;
 Thu, 02 Dec 2021 10:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20211201215127.23550-1-sergio.paracuellos@gmail.com>
 <20211201215127.23550-3-sergio.paracuellos@gmail.com> <d243a90d-25b2-a65f-b69d-af7497db8742@roeck-us.net>
 <CAMhs-H_i7aFeqf4EBtzdL0SKgKrseZGpVU-ytvangpeCMVTmFw@mail.gmail.com>
 <9401e88b-de5a-dd2a-7e82-f3657ea86e8f@roeck-us.net> <CAMhs-H8vw48RkpFz+rqvoPqDPpkaHdn60j6SdbDJHTNTTp7Fcg@mail.gmail.com>
 <c70584d5-8efd-6b3e-aab5-c8161f39931b@roeck-us.net>
In-Reply-To: <c70584d5-8efd-6b3e-aab5-c8161f39931b@roeck-us.net>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 2 Dec 2021 19:41:31 +0100
Message-ID: <CAMhs-H98sDT3g6nmxpz+07L7gs8Bi0gpPSEXJA1q5ecucihyog@mail.gmail.com>
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

On Thu, Dec 2, 2021 at 6:02 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 12/2/21 7:50 AM, Sergio Paracuellos wrote:
> > Hi Guenter,
> >
> > On Thu, Dec 2, 2021 at 4:06 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On 12/2/21 12:29 AM, Sergio Paracuellos wrote:
> >>> Hi Guenter,
> >>>
> >>> On Wed, Dec 1, 2021 at 11:17 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>>>
> >>>> On 12/1/21 1:51 PM, Sergio Paracuellos wrote:
> >>>>> PCI core code call 'pcibios_root_bridge_prepare()' function inside function
> >>>>> 'pci_register_host_bridge()'. This point is very good way to properly enter
> >>>>> into this MIPS ralink specific code to properly setup I/O coherency units
> >>>>> with PCI memory addresses.
> >>>>>
> >>>>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> >>>>> ---
> >>>>>     arch/mips/ralink/mt7621.c | 30 ++++++++++++++++++++++++++++++
> >>>>>     1 file changed, 30 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
> >>>>> index bd71f5b14238..7649416c1cd7 100644
> >>>>> --- a/arch/mips/ralink/mt7621.c
> >>>>> +++ b/arch/mips/ralink/mt7621.c
> >>>>> @@ -10,6 +10,7 @@
> >>>>>     #include <linux/slab.h>
> >>>>>     #include <linux/sys_soc.h>
> >>>>>     #include <linux/memblock.h>
> >>>>> +#include <linux/pci.h>
> >>>>>
> >>>>>     #include <asm/bootinfo.h>
> >>>>>     #include <asm/mipsregs.h>
> >>>>> @@ -22,6 +23,35 @@
> >>>>>
> >>>>>     static void *detect_magic __initdata = detect_memory_region;
> >>>>>
> >>>>> +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> >>>>> +{
> >>>>> +     struct resource_entry *entry;
> >>>>> +     resource_size_t mask;
> >>>>> +
> >>>>> +     entry = resource_list_first_type(&bridge->windows, IORESOURCE_MEM);
> >>>>> +     if (!entry) {
> >>>>> +             pr_err("Cannot get memory resource\n");
> >>>>> +             return -EINVAL;
> >>>>> +     }
> >>>>> +
> >>>>> +     if (mips_cps_numiocu(0)) {
> >>>>> +             /*
> >>>>> +              * FIXME: hardware doesn't accept mask values with 1s after
> >>>>> +              * 0s (e.g. 0xffef), so it would be great to warn if that's
> >>>>> +              * about to happen
> >>>>> +              */ > +         mask = ~(entry->res->end - entry->res->start);
> >>>>> +
> >>>>
> >>>> Try something like this:
> >>>>                   WARN_ON((mask != ~0UL && BIT(ffz(mask)) - 1 != mask);
> >>>
> >>> Thanks for the tip. The following works for me:
> >>>
> >>>                     WARN_ON(mask != ~0UL && ~(BIT(__ffs(mask)) - 1) != mask);
> >>
> >> Are you sure ? __ffs() returns the first bit set, which isn't useful
> >> for this test.
> >
> > My mask is calculated as follows:
> >   mask = ~(entry->res->end - entry->res->start);
> >
> > Where for normal memory resource:
> >   - entry->res->end = 0x6fffffff;
> >   - entry->res->start = 0x60000000;
> >
> > So I end up with a mask: 0xf0000000.
> >
> > So applying ~(BIT(__ffs(mask)) - 1) I get a good '0xf0000000' for this
> > particular case which looks correct.
> >
> > Suppose an invalid case with the mask being 0xffef0000.
> >
> > Applying ~(BIT(__ffs(mask)) - 1) will be 0xffff0000 which will trigger
> > the WARN_ON since 0xffff0000 != 0xffef0000
> >
> > So I think this is correct... Am I missing something?
> >
>
> Your description says "hardware doesn't accept mask values with 1s after 0s
> (e.g. 0xffef)". 0xf0000000 has 1s after 0s.
>
> Your version works (I think) as long as the upper mask bits are all 1s.
> It will fail, for example, if the mask value is 0xf000000 and
> sizeof(long) == 8. Your test is the equivalent of "no mask value
> with 0s after 1s", assuming that sizeof(resource_size_t) == sizeof(long).
> As far as I can see with test code, it fails if sizeof(resource_size_t)
> != sizeof(long). Also, it returns an error if mask == 0. I guess that is
> a corner case, but it would be interesting to know if it is theoretically
> valid.

Thanks a lot for the clear explanation. I was assuming MIPS ralink
arch so sizeof(long) and sizeof(resource_size_t) are equal and upper
mask bits are all 1s. But you are right, my version will fail if this
sizeof(long) were eight.

>
> I _think_ the following works even if sizeof(resource_size_t) != sizeof(long).
>
>         WARN_ON(mask && BIT(ffz(~mask)) - 1 != ~mask);

This works for me also and looks like it does the right thing for any
case, thanks.

>
> or, alternatively, something like
>
>         mask2 = entry->res->end - entry->res->start;
>         mask = ~mask2;
>         WARN_ON(mask && BIT(ffz(mask2)) - 1 != mask2);
>
> though that looks a bit weird.

Agreed, using two variables here looks weird also for me.

Best regards,
    Sergio Paracuellos

>
> Thanks,
> Guenter
>
> > Thanks,
> >      Sergio Paracuellos
> >>
> >> Guenter
> >>
> >>>
> >>> I will send this as a different patch, though.
> >>>
> >>> Best regards,
> >>>       Sergio Paracuellos
> >>>
> >>>>
> >>>>> +             write_gcr_reg1_base(entry->res->start);
> >>>>> +             write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
> >>>>> +             pr_info("PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
> >>>>> +                     (unsigned long long)read_gcr_reg1_base(),
> >>>>> +                     (unsigned long long)read_gcr_reg1_mask());
> >>>>> +     }
> >>>>> +
> >>>>> +     return 0;
> >>>>> +}
> >>>>> +
> >>>>>     phys_addr_t mips_cpc_default_phys_base(void)
> >>>>>     {
> >>>>>         panic("Cannot detect cpc address");
> >>>>>
> >>>>
> >>
>
