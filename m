Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566DD417989
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 19:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344522AbhIXRQ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 13:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344388AbhIXRQ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 13:16:59 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8530C061571;
        Fri, 24 Sep 2021 10:15:25 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id k10so10703403vsp.12;
        Fri, 24 Sep 2021 10:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLOVPkbb6ECoKcpkmYSADyBlj3sV6kuH9YGw3xBQ1kM=;
        b=X5jAre5v4H0IAu3qxsXVyeTconJerzwkD8OXX7Bmol7LWy5RSbW8jXExDMUICumvF3
         26ECm6akmiLvnnNaRnUJC5h0MGLIKMTmYfF/jQoAKsAnSdLslu38qWOC+5POKlr54648
         LHEEFTwLCKAcb7CWl6fGOteUUj1zCp+iHAm4NAv27SqXf08NEeDUTJ+4papu1uB41x96
         orz1dtuVz/4C0rGEe299aeRifFIpFsRlfDH/KF27IdU3lBE6Ep+Jj62Fs+O76/muZbIN
         BMlD7CYimjV0uRNmKC3WpU+qM2OpQM30YepnIQibXWvf7LDIPKAfh4yxQZdjaKUznNMV
         G0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLOVPkbb6ECoKcpkmYSADyBlj3sV6kuH9YGw3xBQ1kM=;
        b=Hv3j80dsFD+lyAaxdl6aYcb3TutRP6zR4nd8iOrck7MbU4VN24AxRaWCVXWCbzCgFr
         I2fP/qCIoYGIlG0UZKBRcwkqZ5Fszeiqz8CJLxjHrAqyEyJxcFA3IUjgMZw2NjkP6MNB
         quKKlHQp14td2Z8njaAkUYIUY9nxUEHjtrugWfK9ZZikkuDewR1B8UE1qCWfHGczVVXB
         M9YvBIKmjFwYKvHm6DMS9UaneEmeV+l1do3ITtA2GBNKnJwXIA8KHdo546y2620IMSMf
         YmmXW3PCYG9a9yoYeV7gjLK84d8BpBHaubcTP8Omeghs/S0XfodCzVXwOUxD+Ywu7611
         rMMg==
X-Gm-Message-State: AOAM533Zg6z8Nkl0kX3wmOn6A4Yo0xzBy0p50UpAKW47MIjMrikmzo13
        oyYWXZ4RNIQ/mk/Y9LL6zEEHipXbVF41mnoYx3Y=
X-Google-Smtp-Source: ABdhPJywWiswdk3HK0sfiWAq8uByawS3SPIVWYRjecJkZJkdlnLKrPkGCyZZknqZSOjwngkCRlhpPZL0p4QwElLlmJk=
X-Received: by 2002:a67:42c2:: with SMTP id p185mr10767724vsa.41.1632503724726;
 Fri, 24 Sep 2021 10:15:24 -0700 (PDT)
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
 <CAK8P3a36jiomsqSr0rP8_BL8HwceKvV78bT2Ym+iomSGyYuOGA@mail.gmail.com>
 <CAMhs-H_hGeGZN_-1GhkhD5wahSoJFd+PrEMXx3C7zvJireJ=xg@mail.gmail.com> <CAK8P3a0vFvn_KUQAT8MuOQuopWmiUrSX4bSP0zorjoBJwTTLWA@mail.gmail.com>
In-Reply-To: <CAK8P3a0vFvn_KUQAT8MuOQuopWmiUrSX4bSP0zorjoBJwTTLWA@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 24 Sep 2021 19:15:13 +0200
Message-ID: <CAMhs-H-JKPpWBAURD3NrTtxcXqqB1TM=o4n32+7sjoUYMpZyuQ@mail.gmail.com>
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

Hi Arnd,

On Fri, Sep 24, 2021 at 7:04 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Sep 24, 2021 at 6:45 PM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> > On Fri, Sep 24, 2021 at 3:28 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Fri, Sep 24, 2021 at 2:46 PM Sergio Paracuellos
> > >
> > > Ok, sounds good. I would still suggest using
> > > "#define PCI_IOBASE mips_io_port_base", so it has the same meaning
> > > as on other architectures (the virtual address of port 0), and replace
> > > the hardcoded base with the CPU address you read from DT to
> > > make that code more portable. As a general rule, DT-enabled drivers
> > > should contain no hardcoded addresses.
> >
> > Yes, it must be cleaned. I was only explaining a possible way to proceed.
>
> Ok
>
> > So, the changes would be:
> > 1) Reverting already added two commits in staging-tree [0] and [1].
> > (two revert patches)
> > 2) Setting PCI_IOBASE to 'mips_io_port_base' so the spaces.h become: (one patch)
> >
> > $ cat arch/mips/include/asm/mach-ralink/spaces.h
> > /* SPDX-License-Identifier: GPL-2.0 */
> > #ifndef __ASM_MACH_RALINK_SPACES_H_
> > #define __ASM_MACH_RALINK_SPACES_H_
> >
> > #define PCI_IOBASE    mips_io_port_base
> > #define PCI_IOSIZE    SZ_16M
> > #define IO_SPACE_LIMIT  (PCI_IOSIZE - 1)
>
> As a minor comment, I would make the PCI_IOSIZE only 64KB in this
> case, unless plan to support ralink/mediatek SoCs that have a multiple
> PCIe domains with distinct 64KB windows.

Ok, I will adjust to SZ_64K , then.

>
> > 3) Change the value written in RALINK_PCI_IOBASE to be sure the value
> > written takes into account address before linux port translation (one
> > patch):
> >
> > pcie_write(pcie, entry->res->start - entry->offset, RALINK_PCI_IOBASE);
>
> ok
>
> > 4) Virtually Map cpu physical address 0x1e160000 and set
> > 'mips_io_port_base' to that virtual address. Something like the
> > following (one patch):
> >
> > static int mt7621_set_io(struct device *dev)
> > {
> >     struct device_node *node = dev->of_node;
> >     struct of_pci_range_parser parser;
> >     struct of_pci_range range;
> >     unsigned long vaddr;
> >     int ret = -EINVAL;
> >
> >     ret = of_pci_range_parser_init(&parser, node);
> >     if (ret)
> >         return ret;
> >
> >     for_each_of_pci_range(&parser, &range) {
> >         switch (range.flags & IORESOURCE_TYPE_BITS) {
> >         case IORESOURCE_IO:
> >             vaddr = (unsigned long)ioremap(range.cpu_addr, range.size);
> >             set_io_port_base(vaddr);
> >             ret = 0;
> >             break;
> >         }
> >     }
> >
> >     return ret;
> > }
>
> This looks like it does the right thing, but conceptually this would belong into
> the mips specific pci_remap_iospace() as we discussed a few emails back,
> not inside the driver. pci_remap_iospace() does get the CPU address
> as an argument, so it just needs to ioremap()/set_io_port_base() it.

Ok, this is what I had in mind, but since this change also needs to
add the #ifdef to the whole 'pci_remap_iospace' function of core apis,
just to be sure that would be a valid approach. Thanks for
clarification.

>
> > And now my concerns:
> > 1) We have to read DT range IO values in the driver and those values
> > will be also parsed by core apis but converting them to linux io
> > ports. Should this be done by the driver or is there a better way to
> > abstract this to don't do things twice?
> > 2) 'set_io_port_base()' function does what we want but it is only
> > mips. We already have the iocu stuff there and the driver is mips
> > anyway, but it is worth to comment this just in case.
>
> I think in both cases the core APIs should do what we need, with the
> change to the mips pci_remap_iospace() I mention. If there is anything
> missing in the core API that you need, we can discuss extending those,
> e.g. to store additional data in the pci_host_bridge structure.

Understood. I'll try to test all of these changes during this weekend
and hopefully send these patches during next week.

Thank you very much for your time and support.

Best regards,
    Sergio Paracuellos

>
>          Arnd
