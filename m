Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C93417378
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 14:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344387AbhIXM4u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 08:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344632AbhIXMyw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 08:54:52 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6838AC0612AD;
        Fri, 24 Sep 2021 05:46:46 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id 66so5875236vsd.11;
        Fri, 24 Sep 2021 05:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WuP0laZ66Ah8I7V2LTy6RZMaEP9qELs6uptNq8t1B1U=;
        b=Pi1k75MEdIHKAcMkuPq4WdQAUZMHGvGcZNklqUxvwd5kKVOL2USUfcoxibmoVoqTK/
         1vW1/Kbz91ZgteyUt7eVsbnwCuNOXDltN4/AJQjP5f7pLQHdvVTN8MukFZxzCslGmabt
         m5CNrQ2pjNEltbChOJnvxv20SZS9O25NpI08W/BxFllQsojlYdUwxcUh0GGF2jAh4maZ
         D5dNNmblBtvkP7IsSGIo6o7YjuGy0AWI0XEbCJqJSOu0T4L3nxlci6ULQrIzQGkavYO3
         CCxeSyO5BTZSTAFQn622p2GPPICeC0r6Z8Ma5Mf+Yf+DqVipLhdILTkamK5N4mvJ6Vn4
         NB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WuP0laZ66Ah8I7V2LTy6RZMaEP9qELs6uptNq8t1B1U=;
        b=516qfyt/5jchzRKE4txBzgp7t67mWsPKa2VQqae72uTCn07MQGBXMD0CnYeyc3z03C
         RIUAiJGQLy6FqjAgZnob2quLYF9e78MqOumMH/trdOrqA9OHtq+cvjdqdswKYcNFDtH/
         X2r2JEWrfe2QDBf3qZZWyE3EtZtN8eHDCZKIwk/lvtqP9HGaHxQCX8OvI1+IQICVHHoc
         jEU1X6IHH+8TQ6CDNGiw3sdLFexkrm0leF+jEZpw/bMPN1Bt7U4FGOf9+HYNv1oH2+vh
         h1jnUzhEuCJPd7H4Uek4M2FsWjSkYeqxq9xMyjd6/9/vg4sEcyPYkTPsv5Ns49vfqrm3
         jSog==
X-Gm-Message-State: AOAM531QSCAF5LAcYwxVC+6wZzq+3Qhea1W4JCZSpQEM6ZU2KZpO1ouC
        zU5HsYl8oO+921f2uSx2lo+BNWDLz1ZiOA1aFIk=
X-Google-Smtp-Source: ABdhPJxOdfbbhBjwQLmHrKi4ZtqosfKOpZkAdCfkdyJ1bKdymP78anFgyiYS1npnOZP0lUryjK29udWrRGMJh9wxvXY=
X-Received: by 2002:a67:42c2:: with SMTP id p185mr9094529vsa.41.1632487605296;
 Fri, 24 Sep 2021 05:46:45 -0700 (PDT)
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
 <CAMhs-H_wxoJC7ZVnkhXNfAcP-P9BNN99ogszM_iJhErHLq8Rdg@mail.gmail.com> <CAK8P3a3dvhWT=Xq22xTNn_VbX29s3t9wrw1DbffPbWuHxtTTmg@mail.gmail.com>
In-Reply-To: <CAK8P3a3dvhWT=Xq22xTNn_VbX29s3t9wrw1DbffPbWuHxtTTmg@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 24 Sep 2021 14:46:33 +0200
Message-ID: <CAMhs-H9OhXHA3_mq2PSoaPvYCstqqHL7TfL0zf=OFNeFmWVTRQ@mail.gmail.com>
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

On Fri, Sep 24, 2021 at 1:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Sep 24, 2021 at 12:15 PM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> > On Fri, Sep 24, 2021 at 10:53 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Thu, Sep 23, 2021 at 10:33 PM Sergio Paracuellos
> > >
> > > Oops, my mistake, I mixed up the CPU address and the PCI address.
> > >
> > > The correct notation should be
> > >
> > > <0x01000000 0 0  0 0x1e160000 0x00010000>;
> > >
> > > i.e. bus address 0 to cpu address 0x1e160000, rather than the other
> > > way around as I wrote it.
> >
> > Mmmm... Do you mean <0x01000000 0 0  0x1e160000 0 0x00010000>; instead?
>
> Yes, sorry for getting it wrong again.
>
> > In any case both of them ends up in a similar trace (the one listed
> > here is using your last range as it is):
> >
> > mt7621-pci 1e140000.pcie: host bridge /pcie@1e140000 ranges:
> > mt7621-pci 1e140000.pcie:   No bus range found for /pcie@1e140000,
> > using [bus 00-ff]
> > mt7621-pci 1e140000.pcie:      MEM 0x0060000000..0x006fffffff -> 0x0060000000
> > mt7621-pci 1e140000.pcie:       IO 0x0000000000..0x1e1600000000ffff ->
> > 0x0000000000
> >                                                    ^^^^
> >                                                     This is the part
> > that change between both traces (t7621-pci 1e140000.pcie:       IO
> >
> > 0x001e160000..0x001e16ffff -> 0x0000000000 in the one I have just put
> > above)
>
> Yes, the latter is the expected output.

Perfect, thanks.

>
> > mt7621-pci 1e140000.pcie: Writing 0x0 in RALINK_PCI_IOBASE
> >                                                   ^^^
> >                                                      This is the
> > current value written in bridge register as IOBASE for the window
> > which is IORESOURCE_IO -> res.start address (in both traces).
>
> The value is correct, but strictly speaking this must be the
> raw value from DT, not the translated Linux port number.
>
> As long as io_offset is zero, the two are the same, but if you were
> to use multiple host bridge in the system, or pick a different bus
> address in DT, you can have a nonzero io_offset. I think this means
>
>    pcie_write(pcie, entry->res->start, RALINK_PCI_IOBASE);
>
> should become
>
>    pcie_write(pcie, entry->res->start + entry->offset, RALINK_PCI_IOBASE);
>
> Try setting some other value as the bus address in DT and see if that
> is what gets written to the register.
> (I may have the polarity of offset wrong, so this may need to be '-' instead
> of '+').

Ok, polarity is inverted. Correct one is:

pcie_write(pcie, entry->res->start - entry->offset, RALINK_PCI_IOBASE);

>
> > Also, I noticed that all of these messages have disappeared from the trace:
> >
> > pci 0000:03:00.0: reg 0x20: initial BAR value 0x00000000 invalid
> >
> > and now the first tested value seems to be valid....
>
> This just means that the power-on default value of '0' is now within
> the configured range of 0...fffff. It's still slightly odd that it warns about
> those in the first place if it is going to reassign everything, but that
> should be harmless either way.

I see. Thanks for clarification.

>
> > > If my assumption is correct here, then you must write the value
> > > that you have read from the DT property, which would be
> > > 0x001e160000 or 0 in the two versions of the DT property we
> > > have listed, but in theory any (properly aligned) number ought
> > > to work here, as long as the BAR values, the RALINK_PCI_IOBASE
> > > and the io_offset all agree what it is.
> >
> > RALINK_PCI_IOBASE in that line, is the bridge register you write with
> > value from the IO resource created from DT property, yes. So I guess
> > you meant PCI_IOBASE for ralink in this sentence, right?
> >
> > (Prototype of the function -> static inline void pcie_write(struct
> > mt7621_pcie *pcie, u32 val, u32 reg))
>
> I meant RALINK_PCI_IOBASE. We do need to write both, to clarify:
>
> RALINK_PCI_IOBASE must be set to match the *bus* address in DT,
> so ideally '0', but any value should work as long as these two match.
>
> PCI_IOBASE/mips_io_port_base must be set to the *CPU* address
> in DT, so that must be 0x1e160000, possibly converted from
> physical to a virtual __iomem address (this is where my MIPS
> knowledge ends).

Understood. I have tried the following:

I have added the following at the beggining of the pci host driver to
match what you are describing above:

unsigned long vaddr = (unsigned long)ioremap(PCI_IOBASE, 0x10000);
set_io_port_base(vaddr);

dev_info(dev, "Setting base to PCI_IOBASE: 0x%x -> mips_io_port_base
0x%lx", PCI_IOBASE, mips_io_port_base);

PCI_IOBASE is the physical cpu address. Hence, 0x1e160000
set_io_port_base sets 'mips_io_port_base' to the virtual address where
'PCI_IOBASE' has been mapped (vaddr).

However, nothing seems to change:

mt7621-pci 1e140000.pcie: Setting base to PCI_IOBASE: 0x1e160000 ->
mips_io_port_base 0xbe160000
                                                ^^^
                                                 This seems aligned
with what you are saying. mips_io_port_base have now a proper virtual
addr for 0x1e160000
mt7621-pci 1e140000.pcie: host bridge /pcie@1e140000 ranges:
mt7621-pci 1e140000.pcie:   No bus range found for /pcie@1e140000,
using [bus 00-ff]
mt7621-pci 1e140000.pcie:      MEM 0x0060000000..0x006fffffff -> 0x0060000000
mt7621-pci 1e140000.pcie:       IO 0x001e160000..0x001e16ffff -> 0x0000000000
mt7621-pci 1e140000.pcie: Writting 0x0 in RALINK_PCI_IOBASE
                                               ^^^
                                               PCI Bus address is zero
and linux port number too, so this also looks good
mt7621-pci 1e140000.pcie: PCIE0 enabled
mt7621-pci 1e140000.pcie: PCIE1 enabled
mt7621-pci 1e140000.pcie: PCIE2 enabled
mt7621-pci 1e140000.pcie: PCI coherence region base: 0x60000000,
mask/settings: 0xf0000002
mt7621-pci 1e140000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: root bus resource [mem 0x60000000-0x6fffffff]
pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
pci 0000:00:00.0: [0e8d:0801] type 01 class 0x060400
pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x7fffffff]
pci 0000:00:00.0: reg 0x14: [mem 0x00000000-0x0000ffff]
pci 0000:00:00.0: supports D1
pci 0000:00:00.0: PME# supported from D0 D1 D3hot
pci 0000:00:01.0: [0e8d:0801] type 01 class 0x060400
pci 0000:00:01.0: reg 0x10: [mem 0x00000000-0x7fffffff]
pci 0000:00:01.0: reg 0x14: [mem 0x00000000-0x0000ffff]
pci 0000:00:01.0: supports D1
pci 0000:00:01.0: PME# supported from D0 D1 D3hot
pci 0000:00:02.0: [0e8d:0801] type 01 class 0x060400
pci 0000:00:02.0: reg 0x10: [mem 0x00000000-0x7fffffff]
pci 0000:00:02.0: reg 0x14: [mem 0x00000000-0x0000ffff]
pci 0000:00:02.0: supports D1
pci 0000:00:02.0: PME# supported from D0 D1 D3hot
pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:01:00.0: [1b21:0611] type 00 class 0x010185
pci 0000:01:00.0: reg 0x10: [io  0x0000-0x0007]
pci 0000:01:00.0: reg 0x14: [io  0x0000-0x0003]
pci 0000:01:00.0: reg 0x18: [io  0x0000-0x0007]
pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x0003]
pci 0000:01:00.0: reg 0x20: [io  0x0000-0x000f]
pci 0000:01:00.0: reg 0x24: [mem 0x00000000-0x000001ff]
pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5
GT/s PCIe x1 link at 0000:00:00.0 (capable of 4.000 Gb/s with 5.0 GT/s
PCIe x1 link)
pci 0000:00:00.0: PCI bridge to [bus 01-ff]
pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
pci 0000:02:00.0: [1b21:0611] type 00 class 0x010185
pci 0000:02:00.0: reg 0x10: [io  0x0000-0x0007]
pci 0000:02:00.0: reg 0x14: [io  0x0000-0x0003]
pci 0000:02:00.0: reg 0x18: [io  0x0000-0x0007]
pci 0000:02:00.0: reg 0x1c: [io  0x0000-0x0003]
pci 0000:02:00.0: reg 0x20: [io  0x0000-0x000f]
pci 0000:02:00.0: reg 0x24: [mem 0x00000000-0x000001ff]
pci 0000:02:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5
GT/s PCIe x1 link at 0000:00:01.0 (capable of 4.000 Gb/s with 5.0 GT/s
PCIe x1 link)
pci 0000:00:01.0: PCI bridge to [bus 02-ff]
pci 0000:00:01.0:   bridge window [io  0x0000-0x0fff]
pci 0000:00:01.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0000:00:01.0:   bridge window [mem 0x00000000-0x000fffff pref]
pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
pci 0000:03:00.0: [1b21:0611] type 00 class 0x010185
pci 0000:03:00.0: reg 0x10: [io  0x0000-0x0007]
pci 0000:03:00.0: reg 0x14: [io  0x0000-0x0003]
pci 0000:03:00.0: reg 0x18: [io  0x0000-0x0007]
pci 0000:03:00.0: reg 0x1c: [io  0x0000-0x0003]
pci 0000:03:00.0: reg 0x20: [io  0x0000-0x000f]
pci 0000:03:00.0: reg 0x24: [mem 0x00000000-0x000001ff]
pci 0000:03:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5
GT/s PCIe x1 link at 0000:00:02.0 (capable of 4.000 Gb/s with 5.0 GT/s
PCIe x1 link)
pci 0000:00:02.0: PCI bridge to [bus 03-ff]
pci 0000:00:02.0:   bridge window [io  0x0000-0x0fff]
pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff pref]
pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
pci 0000:00:00.0: BAR 0: no space for [mem size 0x80000000]
pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x80000000]
pci 0000:00:01.0: BAR 0: no space for [mem size 0x80000000]
pci 0000:00:01.0: BAR 0: failed to assign [mem size 0x80000000]
pci 0000:00:02.0: BAR 0: no space for [mem size 0x80000000]
pci 0000:00:02.0: BAR 0: failed to assign [mem size 0x80000000]
pci 0000:00:00.0: BAR 8: assigned [mem 0x60000000-0x600fffff]
pci 0000:00:00.0: BAR 9: assigned [mem 0x60100000-0x601fffff pref]
pci 0000:00:01.0: BAR 8: assigned [mem 0x60200000-0x602fffff]
pci 0000:00:01.0: BAR 9: assigned [mem 0x60300000-0x603fffff pref]
pci 0000:00:02.0: BAR 8: assigned [mem 0x60400000-0x604fffff]
pci 0000:00:02.0: BAR 9: assigned [mem 0x60500000-0x605fffff pref]
pci 0000:00:00.0: BAR 1: assigned [mem 0x60600000-0x6060ffff]
pci 0000:00:01.0: BAR 1: assigned [mem 0x60610000-0x6061ffff]
pci 0000:00:02.0: BAR 1: assigned [mem 0x60620000-0x6062ffff]
pci 0000:00:00.0: BAR 7: assigned [io  0x0000-0x0fff]
pci 0000:00:01.0: BAR 7: assigned [io  0x1000-0x1fff]
pci 0000:00:02.0: BAR 7: assigned [io  0x2000-0x2fff]
pci 0000:01:00.0: BAR 5: assigned [mem 0x60000000-0x600001ff]
pci 0000:01:00.0: BAR 4: assigned [io  0x0000-0x000f]
pci 0000:01:00.0: BAR 0: assigned [io  0x0010-0x0017]
pci 0000:01:00.0: BAR 2: assigned [io  0x0018-0x001f]
pci 0000:01:00.0: BAR 1: assigned [io  0x0020-0x0023]
pci 0000:01:00.0: BAR 3: assigned [io  0x0024-0x0027]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
pci 0000:00:00.0:   bridge window [mem 0x60000000-0x600fffff]
pci 0000:00:00.0:   bridge window [mem 0x60100000-0x601fffff pref]
pci 0000:02:00.0: BAR 5: assigned [mem 0x60200000-0x602001ff]
pci 0000:02:00.0: BAR 4: assigned [io  0x1000-0x100f]
pci 0000:02:00.0: BAR 0: assigned [io  0x1010-0x1017]
pci 0000:02:00.0: BAR 2: assigned [io  0x1018-0x101f]
pci 0000:02:00.0: BAR 1: assigned [io  0x1020-0x1023]
pci 0000:02:00.0: BAR 3: assigned [io  0x1024-0x1027]
pci 0000:00:01.0: PCI bridge to [bus 02]
pci 0000:00:01.0:   bridge window [io  0x1000-0x1fff]
pci 0000:00:01.0:   bridge window [mem 0x60200000-0x602fffff]
pci 0000:00:01.0:   bridge window [mem 0x60300000-0x603fffff pref]
pci 0000:03:00.0: BAR 5: assigned [mem 0x60400000-0x604001ff]
pci 0000:03:00.0: BAR 4: assigned [io  0x2000-0x200f]
pci 0000:03:00.0: BAR 0: assigned [io  0x2010-0x2017]
pci 0000:03:00.0: BAR 2: assigned [io  0x2018-0x201f]
pci 0000:03:00.0: BAR 1: assigned [io  0x2020-0x2023]
pci 0000:03:00.0: BAR 3: assigned [io  0x2024-0x2027]
pci 0000:00:02.0: PCI bridge to [bus 03]
pci 0000:00:02.0:   bridge window [io  0x2000-0x2fff]
pci 0000:00:02.0:   bridge window [mem 0x60400000-0x604fffff]
pci 0000:00:02.0:   bridge window [mem 0x60500000-0x605fffff pref]

No changes also here:

root@gnubee:~# cat /proc/ioports
00000000-0000ffff : pcie@1e140000
  00000000-00000fff : PCI Bus 0000:01
    00000000-0000000f : 0000:01:00.0
      00000000-0000000f : ahci
    00000010-00000017 : 0000:01:00.0
      00000010-00000017 : ahci
    00000018-0000001f : 0000:01:00.0
      00000018-0000001f : ahci
    00000020-00000023 : 0000:01:00.0
      00000020-00000023 : ahci
    00000024-00000027 : 0000:01:00.0
      00000024-00000027 : ahci
  00001000-00001fff : PCI Bus 0000:02
    00001000-0000100f : 0000:02:00.0
      00001000-0000100f : ahci
    00001010-00001017 : 0000:02:00.0
      00001010-00001017 : ahci
    00001018-0000101f : 0000:02:00.0
      00001018-0000101f : ahci
    00001020-00001023 : 0000:02:00.0
      00001020-00001023 : ahci
    00001024-00001027 : 0000:02:00.0
      00001024-00001027 : ahci
  00002000-00002fff : PCI Bus 0000:03
    00002000-0000200f : 0000:03:00.0
      00002000-0000200f : ahci
    00002010-00002017 : 0000:03:00.0
      00002010-00002017 : ahci
    00002018-0000201f : 0000:03:00.0
      00002018-0000201f : ahci
    00002020-00002023 : 0000:03:00.0
      00002020-00002023 : ahci
    00002024-00002027 : 0000:03:00.0
      00002024-00002027 : ahci

>
> > > pcie_write(pcie, 0xffffffff, RALINK_PCI_MEMBASE)
> > >
> > > Can you clarify what this does? I would have expected an
> > > identity-map for the memory space, which would mean writing
> > > the third cell from the ranges property (0x60000000)
> > > into this. Is -1 a special value for identity mapping, or does
> > > this register do something else?
> >
> > That was also my understanding at first when I took this code and
> > started playing with it since the register is the base address for the
> > memory space window. Setting the value you pointed out worked for me
> > (and makes sense), but some people seem to have problems with some
> > cards when accessing PCI memory resources. That's the only reason I
> > have maintained the original value but I don't really understand what
> > it means. The same value is used in mt7620 which has a pretty similar
> > topology but with one only virtual bridge behind the host-bridge [0].
> > However there is no documentation for mt7621 PCI subsystem and the one
> > that exists for mt7620 PCI does not clarify much more [1].
>
> Ok, fair enough.
>
>           Arnd

Thanks,
     Sergio Paracuellos
