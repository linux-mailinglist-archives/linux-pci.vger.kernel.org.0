Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76433416E47
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 10:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244916AbhIXIzQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 04:55:16 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:58615 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244623AbhIXIzQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 04:55:16 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mlejs-1nC8Oq0bru-00ingt; Fri, 24 Sep 2021 10:53:42 +0200
Received: by mail-wr1-f43.google.com with SMTP id t18so25188473wrb.0;
        Fri, 24 Sep 2021 01:53:41 -0700 (PDT)
X-Gm-Message-State: AOAM531iOe9kJ2vjqmruq///xI5DyfBXi5RlmCRogIv2/iMQxWxBirU0
        KFLONE1BtsoSH/GIr2wSY4qraDfMOCd/LNPY1jY=
X-Google-Smtp-Source: ABdhPJyPu1kIql0u17xRVgQRJGaYD/zgnJdUJvEsA5NSxOXpHQrUJVnFrpQxg44ZwAOpD5GkNjOPsUJijumnxYh7HtA=
X-Received: by 2002:a1c:7413:: with SMTP id p19mr868659wmc.98.1632473621615;
 Fri, 24 Sep 2021 01:53:41 -0700 (PDT)
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
 <CAK8P3a0OWyW9Wk0kHXsj_7qTd0fVXQnszzun+HacHeTKYETXhw@mail.gmail.com> <CAMhs-H9xrXgbuwYe2STzuq0aBwj0onJGc0Oka6+pzgoHb0j8rA@mail.gmail.com>
In-Reply-To: <CAMhs-H9xrXgbuwYe2STzuq0aBwj0onJGc0Oka6+pzgoHb0j8rA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 24 Sep 2021 10:53:25 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1AwaSi_J9p4tKwNKxENHhwofDu=Ma=F29ajSmMXoC7RA@mail.gmail.com>
Message-ID: <CAK8P3a1AwaSi_J9p4tKwNKxENHhwofDu=Ma=F29ajSmMXoC7RA@mail.gmail.com>
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
X-Provags-ID: V03:K1:ay4g2+3AJgVOETtusywny6EJchnreCvAVq31S4h/oehRuBJaACo
 C1b6Oc1vju5qQcFJQYYdQFUoLcv97c4naVZDVqv30uDC9zEDzaw1LQzats6VJxgaUmMU7Zs
 wJw/lY5sC3hAj32C0YMQfpYhOOxnBC4zgBiK15Cyf4LziP6GeAxhqVhyg91neuUyJHBfKdA
 lkKGlL5vHfEiavjGSIdPg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WYl4GQ0a/MU=:xiuKBHyLgSKHmKnikUjhMT
 pUX5FfVNi9FT/w4Uw3Z9shzkQutNCBgYRYLGp9HDokR4i3Wwg31f0UpAS+AwqbfMAKeN7Q15N
 5gaQavVm/RSCqpngdxLOup+kDnRqXe58bRS7vkfZ9p6uPSXtV6BCPc9onTGxwM0QmToky1exu
 RXpVjOrgx+FtKNwApN4Or22gneHdQqUOFufEyz2/9XfEC773LTnKNtA76ESo/YUCIGx3U/BVL
 hePvZaUVMJW0F67ZcQu8/Zakle8poZtBzAqePpLRWckMfIV2WnB1Su0ySag1OWQ9763oLy/Cz
 4QFxyemBDlywPXm4tRA7+b6mDwCaNObGXvBnj0pFju1VQUVXG6FajSUtkY8mvMxCZQwlL3UxT
 m2Nd2XSD4Hpk2CZWBxG+oHwN3AToG/WX4pdBkFjAz1RjSwPkqA05NK1XWrX2lWr9lsSiiSGEs
 JZOaBC4DFfk8f3PWAqpNejVgLlxKaml1Y6Fo/yaV3WJOT0wG2VMQd7VOzPyQSdDrqc2tZ0WTK
 dmn3FUemclognK4ylK38C3paq6JPthPez4/ULcLA0dKlK1ITZeffJk8q54FUiKNLcEPBoxSRw
 I+8h8GAc4CC7nPzWgbi2j22NdcHQVgzVC7Yd5EdwR//FWe1Btrw1zzb/Lnu7DLBVvsjjs4PLx
 oQ2ICqxm3NiC497x+hgfxj6+yU7smFxjSnjvIwQITa11QxzmDFZE7pVo88MmBbIrloTVjrEFb
 alNIUJyxhlBgqeUQVjqj7uzCcTD6mSGzdGi3uA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 23, 2021 at 10:33 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
> On Thu, Sep 23, 2021 at 7:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Sep 23, 2021 at 4:55 PM Sergio Paracuellos
> >
> > Ok, got it. So the memory space uses a normal zero offset with cpu address
> > equal to bus address, but the I/O space has a rather usual mapping of
> > bus address equal to the window into the mmio space, with an offset of
> > 0x1e160000.
> >
> > The normal way to do this would be map the PCI port range 0-0x10000
> > into CPU address 0x1e160000, like:
> >
> > ranges = <0x02000000 0 0x60000000 0x60000000 0 0x10000000>,  /* pci memory */
> >                <0x01000000 0 0x1e160000 0 0 0x00010000>;
>
> This change as it is got into the same behaviour:
>
> mt7621-pci 1e140000.pcie: host bridge /pcie@1e140000 ranges:
> mt7621-pci 1e140000.pcie:   No bus range found for /pcie@1e140000,
> using [bus 00-ff]
> mt7621-pci 1e140000.pcie:      MEM 0x0060000000..0x006fffffff -> 0x0060000000
> mt7621-pci 1e140000.pcie:       IO 0x0000000000..0x000000ffff -> 0x001e160000
>                                                    ^^^^^^
>                                                     This is the only
> change I appreciate in all the trace with the range change.

Oops, my mistake, I mixed up the CPU address and the PCI address.

The correct notation should be

<0x01000000 0 0  0 0x1e160000 0x00010000>;

i.e. bus address 0 to cpu address 0x1e160000, rather than the other
way around as I wrote it.

> pci 0000:00:02.0: PCI bridge to [bus 03-ff]
> pci 0000:00:02.0:   bridge window [io  0x0000-0x0fff]
> pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff]
> pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff pref]
...
> pci 0000:00:02.0: PCI bridge to [bus 03]
> pci 0000:00:02.0:   bridge window [io  0x2000-0x2fff]
> pci 0000:00:02.0:   bridge window [mem 0x60400000-0x604fffff]
> pci 0000:00:02.0:   bridge window [mem 0x60500000-0x605fffff pref
>
> # cat /proc/ioports
> 00000000-0000ffff : pcie@1e140000
>   00000000-00000fff : PCI Bus 0000:01
>     00000000-0000000f : 0000:01:00.0
>       00000000-0000000f : ahci
>     00000010-00000017 : 0000:01:00.0
...

These are all what I would expect, but that should just be
based on the PCI_IOBASE value, not the mapping behind that.

> > Do you know where that mapping is set up? Is this a hardware setting,
> > or is there a way to change the inbound I/O port ranges to the
> > normal mapping?
>
> The only thing related is the IOBASE register which is the base
> address for the IO space window. Driver code is setting this up to pci
> IO resource start address [0].

So this line:
      pcie_write(pcie, entry->res->start, RALINK_PCI_IOBASE);

That does sound like it is the bus address you are writing, not
the CPU address. Some host bridges allow you to configure both,
some only one of them, but the sensible assumption here would
be that this is the bus address if only one is configurable.

If my assumption is correct here, then you must write the value
that you have read from the DT property, which would be
0x001e160000 or 0 in the two versions of the DT property we
have listed, but in theory any (properly aligned) number ought
to work here, as long as the BAR values, the RALINK_PCI_IOBASE
and the io_offset all agree what it is.

The line just before this is

pcie_write(pcie, 0xffffffff, RALINK_PCI_MEMBASE)

Can you clarify what this does? I would have expected an
identity-map for the memory space, which would mean writing
the third cell from the ranges property (0x60000000)
into this. Is -1 a special value for identity mapping, or does
this register do something else?

          Arnd
