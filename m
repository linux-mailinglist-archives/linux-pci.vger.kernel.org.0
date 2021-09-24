Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC9C417914
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 18:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhIXQth (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 12:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhIXQth (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 12:49:37 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D98EC061571;
        Fri, 24 Sep 2021 09:48:04 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id 10so6980894uae.10;
        Fri, 24 Sep 2021 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=giwZx+E798TYJXdpbpvOJGj0RxWfm0yA2hgxQDnq7DI=;
        b=Ve5YKT4w2lsJBa6Bz/fwG18tkcLnE6uQDSLzxCSjhphIpkyIxQurNrR/D46cmdf+0C
         etkT2jTT7SBndRuAJJCRWkMUBbHSkaESoWHcKzJsNHw/T92Ykdty0eO0p2KXtHO4TmQu
         TYEcjxyJvOYVD704tfoGBmJLjjZcYVyvZjOMTrrqZkLGQTdTWb9ly6Fg4lQ9ekoZ/vp7
         B8jDTAE/+8iM45v3UONL+QqJlA+hQRE73Ov/XgFONmlxuV7jEU0r1I8DQc8d+7/nV5mh
         pjs8e0/g+Ka0AAYYXegzAHMr7QrkxkyNmPirFlyinT23aiXIv1xSPV4+YUI0irv5rxC0
         UpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=giwZx+E798TYJXdpbpvOJGj0RxWfm0yA2hgxQDnq7DI=;
        b=EBw5sva8vzaznoLDLV/xm7O5bpYpLtxLnehSsDFcmQ9blsGwCkocMYlwcCesOjgbEj
         lDn1RYs80IlvcO30zGwe5Smo54tk2On0jL2s1D2ze/HT4LdH7GuCjAsou39oNy5rK25i
         SqLJPq7+kmaSIIaIOec2DK5t9YbmnPYErQNF78vWcb6wkSYdGICLOpkiGkgWiIzAu6W7
         hdxNJIrxVtIL+/NEadnlZZrPbfbVDu0JN7c2RQWcMFR3oXXX8RzeKp32e5dj1ULymrWp
         4QBEsgtEKx8SddEXawp/IdWUXTMgxpiuLH47kFSzFcPr9gocG+lGPX/Dilm5GUVpQNqV
         n68A==
X-Gm-Message-State: AOAM5301vN7nNZexfq3yxNHKxN9QFPM6VpoYk4gMmh8iGMAfkTM3xcRx
        w6IBmvrpwzh3TeuG0feM+HopPVengV4dmrHJbD4=
X-Google-Smtp-Source: ABdhPJwZ3s5VLrfiu8QYDjwIsNzYawwIfuuT9Se08RQyrW1TxesGL0/SlGuxGUAeccA1J/wgcwf8/JUpWiGgAbu1mCo=
X-Received: by 2002:ab0:6e94:: with SMTP id b20mr11134562uav.66.1632502083242;
 Fri, 24 Sep 2021 09:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210922042041.16326-1-sergio.paracuellos@gmail.com>
 <CAK8P3a2WPOYS7ra_epyZ_bBBpPK8+AgEynK0pKOUZ6ajubcHew@mail.gmail.com>
 <CAMhs-H8EyBmahhLsx+a0aoy+znY=PCm4BT97UBg4xcAy3x2oXg@mail.gmail.com>
 <CAK8P3a0fQZvpNCKF7OUy_krC_YPyigtd5Ak_AMXXpx84HKMswA@mail.gmail.com>
 <CAMhs-H-OCm1p6mTTV6s=vPx7FV8+1UMzx0X00wvXkW=5OgFQBQ@mail.gmail.com>
 <CAK8P3a1iN76A5ahTTQ6rCS4LjKHz8grkNGHGehLJnd0xQSnHXA@mail.gmail.com>
 <CAMhs-H_hZk3hruCaWRjKjUSj6vhVE+JZfk9nT7v1=mcc-H9wnw@mail.gmail.com>
 <CAK8P3a3C0rG_JWWCU6T4B=+j2-+6S6Gq+aw_9e6XeVun9LoF0w@mail.gmail.com>
 <CAMhs-H8kH7CMXENqDW_6GLTjeMMyk+ynehMmyBr=kFZPFHpM0A@mail.gmail.com>
 <CAK8P3a2WmNsV9fhSEjqwHZAGkwGc9HOurhQsza7JOM2Scts2XQ@mail.gmail.com>
 <CAMhs-H8fRnLavLfdw7jZO0tb8rWqdF81cGHhYT6gGp4UY1gChg@mail.gmail.com>
 <CAK8P3a2MJO--xmAZ_71h1QQ5_b8WXgyo-=LaT7r7yMMBUHoPfQ@mail.gmail.com>
 <CAMhs-H_xdkpinyj-Y1u==ievpGWZ2Ze-_U7aCUcfu0=NKBq2xQ@mail.gmail.com>
 <CAK8P3a0OWyW9Wk0kHXsj_7qTd0fVXQnszzun+HacHeTKYETXhw@mail.gmail.com>
 <CAMhs-H9xrXgbuwYe2STzuq0aBwj0onJGc0Oka6+pzgoHb0j8rA@mail.gmail.com>
 <CAK8P3a1AwaSi_J9p4tKwNKxENHhwofDu=Ma=F29ajSmMXoC7RA@mail.gmail.com>
 <CAMhs-H_wxoJC7ZVnkhXNfAcP-P9BNN99ogszM_iJhErHLq8Rdg@mail.gmail.com>
 <CAK8P3a3dvhWT=Xq22xTNn_VbX29s3t9wrw1DbffPbWuHxtTTmg@mail.gmail.com>
 <CAMhs-H9OhXHA3_mq2PSoaPvYCstqqHL7TfL0zf=OFNeFmWVTRQ@mail.gmail.com>
 <CAK8P3a36jiomsqSr0rP8_BL8HwceKvV78bT2Ym+iomSGyYuOGA@mail.gmail.com> <CAMhs-H_hGeGZN_-1GhkhD5wahSoJFd+PrEMXx3C7zvJireJ=xg@mail.gmail.com>
In-Reply-To: <CAMhs-H_hGeGZN_-1GhkhD5wahSoJFd+PrEMXx3C7zvJireJ=xg@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 24 Sep 2021 18:47:51 +0200
Message-ID: <CAMhs-H_RpNHnbpraujfTGeOsqsUTT5M5bBM0mY3JtDUXHc6-EQ@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: of: Avoid pci_remap_iospace() when PCI_IOBASE not defined
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, gregkh <gregkh@linuxfoundation.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 24, 2021 at 6:45 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> Hi Arnd,
>
> On Fri, Sep 24, 2021 at 3:28 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Fri, Sep 24, 2021 at 2:46 PM Sergio Paracuellos
> > <sergio.paracuellos@gmail.com> wrote:
> > > On Fri, Sep 24, 2021 at 1:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Fri, Sep 24, 2021 at 12:15 PM Sergio Paracuellos
> > >
> > > > I meant RALINK_PCI_IOBASE. We do need to write both, to clarify:
> > > >
> > > > RALINK_PCI_IOBASE must be set to match the *bus* address in DT,
> > > > so ideally '0', but any value should work as long as these two match.
> > > >
> > > > PCI_IOBASE/mips_io_port_base must be set to the *CPU* address
> > > > in DT, so that must be 0x1e160000, possibly converted from
> > > > physical to a virtual __iomem address (this is where my MIPS
> > > > knowledge ends).
> > >
> > > Understood. I have tried the following:
> > >
> > > I have added the following at the beggining of the pci host driver to
> > > match what you are describing above:
> > >
> > > unsigned long vaddr = (unsigned long)ioremap(PCI_IOBASE, 0x10000);
> > > set_io_port_base(vaddr);
> > >
> > > dev_info(dev, "Setting base to PCI_IOBASE: 0x%x -> mips_io_port_base
> > > 0x%lx", PCI_IOBASE, mips_io_port_base);
> > >
> > > PCI_IOBASE is the physical cpu address. Hence, 0x1e160000
> > > set_io_port_base sets 'mips_io_port_base' to the virtual address where
> > > 'PCI_IOBASE' has been mapped (vaddr).
> >
> > Ok, sounds good. I would still suggest using
> > "#define PCI_IOBASE mips_io_port_base", so it has the same meaning
> > as on other architectures (the virtual address of port 0), and replace
> > the hardcoded base with the CPU address you read from DT to
> > make that code more portable. As a general rule, DT-enabled drivers
> > should contain no hardcoded addresses.
>
> Yes, it must be cleaned. I was only explaining a possible way to proceed.
>
> So, the changes would be:
> 1) Reverting already added two commits in staging-tree [0] and [1].

Sorry, forgot to add links:

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=159697474db41732ef3b6c2e8d9395f09d1f659e
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=50fb34eca2944fd67493717c9fbda125336f1655

> (two revert patches)
> 2) Setting PCI_IOBASE to 'mips_io_port_base' so the spaces.h become: (one patch)
>
> $ cat arch/mips/include/asm/mach-ralink/spaces.h
> /* SPDX-License-Identifier: GPL-2.0 */
> #ifndef __ASM_MACH_RALINK_SPACES_H_
> #define __ASM_MACH_RALINK_SPACES_H_
>
> #define PCI_IOBASE    mips_io_port_base
> #define PCI_IOSIZE    SZ_16M
> #define IO_SPACE_LIMIT  (PCI_IOSIZE - 1)
>
> #include <asm/mach-generic/spaces.h>
> #endif
>
> 3) Change the value written in RALINK_PCI_IOBASE to be sure the value
> written takes into account address before linux port translation (one
> patch):
>
> pcie_write(pcie, entry->res->start - entry->offset, RALINK_PCI_IOBASE);
>
> 4) Virtually Map cpu physical address 0x1e160000 and set
> 'mips_io_port_base' to that virtual address. Something like the
> following (one patch):
>
> static int mt7621_set_io(struct device *dev)
> {
>     struct device_node *node = dev->of_node;
>     struct of_pci_range_parser parser;
>     struct of_pci_range range;
>     unsigned long vaddr;
>     int ret = -EINVAL;
>
>     ret = of_pci_range_parser_init(&parser, node);
>     if (ret)
>         return ret;
>
>     for_each_of_pci_range(&parser, &range) {
>         switch (range.flags & IORESOURCE_TYPE_BITS) {
>         case IORESOURCE_IO:
>             vaddr = (unsigned long)ioremap(range.cpu_addr, range.size);
>             set_io_port_base(vaddr);
>             ret = 0;
>             break;
>         }
>     }
>
>     return ret;
> }
>
> static int mt7621_pci_probe(struct platform_device *pdev)
> {
>   ...
>     err = mt7621_set_io(dev);
>     if (err) {
>         dev_err(dev, "error setting io\n");
>         return err;
>     }
> ...
>     return 0;
> }
>
> And now my concerns:
> 1) We have to read DT range IO values in the driver and those values
> will be also parsed by core apis but converting them to linux io
> ports. Should this be done by the driver or is there a better way to
> abstract this to don't do things twice?
> 2) 'set_io_port_base()' function does what we want but it is only
> mips. We already have the iocu stuff there and the driver is mips
> anyway, but it is worth to comment this just in case.
>
> Thoughts?
>
> Thanks in advance for your time.
>
> Best regards,
>     Sergio Paracuellos
>
> >
> > > However, nothing seems to change:
> > >
> > > mt7621-pci 1e140000.pcie: Setting base to PCI_IOBASE: 0x1e160000 ->
> > > mips_io_port_base 0xbe160000
> > >                                                 ^^^
> > >                                                  This seems aligned
> > > with what you are saying. mips_io_port_base have now a proper virtual
> > > addr for 0x1e160000
> >
> > Ok.
> >
> >             Arnd
