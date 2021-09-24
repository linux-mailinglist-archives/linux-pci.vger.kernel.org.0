Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B3E41792F
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 19:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244975AbhIXRGF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 13:06:05 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:33959 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244692AbhIXRGE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 13:06:04 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MekKJ-1n2Jxb1LXx-00anFL; Fri, 24 Sep 2021 19:04:30 +0200
Received: by mail-wr1-f42.google.com with SMTP id w29so29369998wra.8;
        Fri, 24 Sep 2021 10:04:30 -0700 (PDT)
X-Gm-Message-State: AOAM533hxEKvGxwIOHFHi64g641R3PM5E5QUV2s0K68KeAgBjs155s57
        dGM4FFoeVPoFHWiKQik3SYEc55a/AJILMX4GLY8=
X-Google-Smtp-Source: ABdhPJwaJphnhOD4t/WEv+GtCKC4b7mcA4tNutssPynbkKmyCqQ+NB4xG4u0quTj4eIC1eQf5sfefSB8p4v/L2r1AwY=
X-Received: by 2002:a5d:6c6f:: with SMTP id r15mr12825177wrz.428.1632503069891;
 Fri, 24 Sep 2021 10:04:29 -0700 (PDT)
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
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 24 Sep 2021 19:04:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0vFvn_KUQAT8MuOQuopWmiUrSX4bSP0zorjoBJwTTLWA@mail.gmail.com>
Message-ID: <CAK8P3a0vFvn_KUQAT8MuOQuopWmiUrSX4bSP0zorjoBJwTTLWA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: of: Avoid pci_remap_iospace() when PCI_IOBASE not defined
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, gregkh <gregkh@linuxfoundation.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:UTGWuu8GjhhN+PPplSs8R6mCLMw89t+nKuNi+Rr2Z3i39yYJJH0
 y3fPVURRXUnw7zWBL1UpMwWdUuLm7gR8Z9MgD2a8ENA8MPiN2zafHqXUArvK5Hjb1iB7UWW
 lVfYitbPPR/bcFm6L9ls0VEbuKk5oYPtyd0GT+XfVfYSGqBXo4phVlcZsqWHO5Cir6cx4Ql
 JZWXmFx8GNz/zGAY2THqw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XgWmjI+crhI=:ScwxSNEbI7yTzsLazO99os
 tYVrFvudllik/9DyE1e6Xj0ZPznG27Yl+fSnUERqMHMIjVGLWEiIv9a8Q6BDHuXnb0kRWj4CV
 bX88XvpcQ8HrNlw1V5QVUOOW/Pm+MqMJWl30M2K8HFlWrmj2bJC8YcCKISBhYNP4tcZtpFmPS
 QAc9FTH0v9uhWhhnpwOwAMmOSpKKonXTD7+d+tWLLVCTBg/8SNCMJAKjUedBebSKWIglX4WGp
 S85Y9XbNbk7gwruxIkOZYymC1gzUpfpKuTqFv8VDGiIlZbu4za+T1SMY2c5iUnou6LTvV0XUk
 jimWRajkESgDxs/k/2PROWkDA07fV0CXEoA8xZ3o/FGBEZIWmW19K4l5NsWTq0XMWnOF85kLa
 MUCZDLcD+PS/6YfaVw7cv0mrvIMuUsRJRWeb7JqcYxA/XeqHya28OYkHQ98AOziHmR2mKDaHI
 APjKOuWBVlZpbQYVgIf3Bhnh2gj3sk1+0WRCpAdRLJiaO9mp8t4XzHxmkdPYEjim3rhSucpTO
 N95PbtTPPbR3jQRTlbI3GPh3uNJ1u5DqJ88ZZcZXPzpwc7rCdCSRw8a5yzF+iIohV04yZAhVY
 XrWwx3uFEW6yoDamtHr+97mo5VhY2htThAKj7p/Ace3NyKM/kWMr2smyjwbqsnVTmnlMKT29x
 udwxtgPEl/589EI2bXyjQSCkrUkCY3+DZgjGmmbwPjRY7g5xGppcL79wDDAky2mYN9RNSzOFl
 CE0cvjXV+9sQduvb6QGge8N6KJ/IxBdyg6sb/R+8p//mQLkLh27jGQY3NUuAHY1DeYVVyh9KD
 nqxYpt2Qf3oUcdr1O/88cTZe7DSECHKD0C1y7PfYnPfwoIZOjyWTVGyNIlrd7Fy0ScadpXBv4
 bWNyRIHFmZ6sopzh4Pqw==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 24, 2021 at 6:45 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
> On Fri, Sep 24, 2021 at 3:28 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Fri, Sep 24, 2021 at 2:46 PM Sergio Paracuellos
> >
> > Ok, sounds good. I would still suggest using
> > "#define PCI_IOBASE mips_io_port_base", so it has the same meaning
> > as on other architectures (the virtual address of port 0), and replace
> > the hardcoded base with the CPU address you read from DT to
> > make that code more portable. As a general rule, DT-enabled drivers
> > should contain no hardcoded addresses.
>
> Yes, it must be cleaned. I was only explaining a possible way to proceed.

Ok

> So, the changes would be:
> 1) Reverting already added two commits in staging-tree [0] and [1].
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

As a minor comment, I would make the PCI_IOSIZE only 64KB in this
case, unless plan to support ralink/mediatek SoCs that have a multiple
PCIe domains with distinct 64KB windows.

> 3) Change the value written in RALINK_PCI_IOBASE to be sure the value
> written takes into account address before linux port translation (one
> patch):
>
> pcie_write(pcie, entry->res->start - entry->offset, RALINK_PCI_IOBASE);

ok

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

This looks like it does the right thing, but conceptually this would belong into
the mips specific pci_remap_iospace() as we discussed a few emails back,
not inside the driver. pci_remap_iospace() does get the CPU address
as an argument, so it just needs to ioremap()/set_io_port_base() it.

> And now my concerns:
> 1) We have to read DT range IO values in the driver and those values
> will be also parsed by core apis but converting them to linux io
> ports. Should this be done by the driver or is there a better way to
> abstract this to don't do things twice?
> 2) 'set_io_port_base()' function does what we want but it is only
> mips. We already have the iocu stuff there and the driver is mips
> anyway, but it is worth to comment this just in case.

I think in both cases the core APIs should do what we need, with the
change to the mips pci_remap_iospace() I mention. If there is anything
missing in the core API that you need, we can discuss extending those,
e.g. to store additional data in the pci_host_bridge structure.

         Arnd
