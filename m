Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2709465F58
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 09:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356108AbhLBIch (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 03:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356096AbhLBIcg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 03:32:36 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF391C061574;
        Thu,  2 Dec 2021 00:29:14 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id i6so54257413uae.6;
        Thu, 02 Dec 2021 00:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/+dV/s3EZ9EtWhdBvNVcj4uqFi9a9Uc5jksYGaROERg=;
        b=FTNSpwBUxmQxlgn75IodgvZDFCtmzjKhGN2geKqj0PyJO0GxBN67wEtUQAmIT6y0DP
         3TpbSbpLeIEadD4YIfrtwgg+oZxz/arCqY4AOm0hiLUA/kLxYz7cc88Sf3A15Z+Czcd3
         cRDGIHdTQefuEd9D7grRDcDeIdYL096lBQpFeyjiYIzhU19VMFuOg9RRIxoRDUFp/oKQ
         Up8F4CFRlDx02fXJiHyeV17j/X9c8yo27UDD/IP9tRwCebE8zQ6rCTp4cdMic4q2uz6S
         mLRiDuTUpdf9Muudhp+9FfVEcnJSL4ppGgk0jRCGehboBJYrA5GlEy4mYM/iKgAIuS4q
         X6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/+dV/s3EZ9EtWhdBvNVcj4uqFi9a9Uc5jksYGaROERg=;
        b=5GZnrazj5UJHwwAWKw+mhG2z8QK223SfO/l0wJQ8COCdicX61oDXj2KU8gZX3oahS0
         ZUdJcwyVM2YkBSj3KSdc0gDwT1cupVyFbMLPnR62cu3ydFT3llUtCX+FWJCrPaF3o/8E
         d0GGKVzwG3p7JMupZ1vTtnMMaERQyMlWQ5J5rS4kqobVuAuaCDxa0nkIHLoHuxQ8CnB+
         d2rvsDZ6us96iBlCcWPlv3PG2lrjNj99exITABfs9hWdRhh7B/14H5KUuvG7JH5TCbGz
         A2Q/6yl2rB+0lgYlrIcD2GX0vaZCCtJZ+pLRepJkuzTRa7b8COtTdsx1Md+J6OxYqHdq
         VfAA==
X-Gm-Message-State: AOAM532poRa5LVEOLUprFxgRKb7Zf51w+C7e7kpGg/SxEVxQG9WzppKl
        F6KvkkS+vLAIJqhM5NJJ3lF3FPNP6xlW64LCVDg=
X-Google-Smtp-Source: ABdhPJycVJmoH+Ss9/0kvDCniGZiyR5GcS3E2GER5QOxKCDh16Ywz5Z+xkpzYl2SDtElqYkX7a9TJoQChNTtHFT4sRU=
X-Received: by 2002:a05:6102:38ce:: with SMTP id k14mr13143796vst.70.1638433753882;
 Thu, 02 Dec 2021 00:29:13 -0800 (PST)
MIME-Version: 1.0
References: <20211201215127.23550-1-sergio.paracuellos@gmail.com>
 <20211201215127.23550-3-sergio.paracuellos@gmail.com> <d243a90d-25b2-a65f-b69d-af7497db8742@roeck-us.net>
In-Reply-To: <d243a90d-25b2-a65f-b69d-af7497db8742@roeck-us.net>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 2 Dec 2021 09:29:02 +0100
Message-ID: <CAMhs-H_i7aFeqf4EBtzdL0SKgKrseZGpVU-ytvangpeCMVTmFw@mail.gmail.com>
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

On Wed, Dec 1, 2021 at 11:17 PM Guenter Roeck <linux@roeck-us.net> wrote:
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
> > +              */ > +         mask = ~(entry->res->end - entry->res->start);
> > +
>
> Try something like this:
>                 WARN_ON((mask != ~0UL && BIT(ffz(mask)) - 1 != mask);

Thanks for the tip. The following works for me:

                  WARN_ON(mask != ~0UL && ~(BIT(__ffs(mask)) - 1) != mask);

I will send this as a different patch, though.

Best regards,
    Sergio Paracuellos

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
