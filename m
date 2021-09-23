Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEACE4164B5
	for <lists+linux-pci@lfdr.de>; Thu, 23 Sep 2021 19:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241740AbhIWR52 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Sep 2021 13:57:28 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:39621 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242651AbhIWR52 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Sep 2021 13:57:28 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M1qfu-1mRG1S3nku-002Ioo; Thu, 23 Sep 2021 19:55:54 +0200
Received: by mail-wr1-f44.google.com with SMTP id w17so19464893wrv.10;
        Thu, 23 Sep 2021 10:55:54 -0700 (PDT)
X-Gm-Message-State: AOAM533bEzATr1IdWXwyHQ1M1Lr2lEtrDZrUEd0ab0fk+63TNGjJEySU
        DCHccjgboVbzknBIFwnFxnlZX6MUM4l8fYwKCOI=
X-Google-Smtp-Source: ABdhPJyXpwZC9lPvHPDX60+wk/op+ZP9AEHiyK2UI9Ao3BXhdIEJjqz9ikHSNGJKUT1/Ri0eUUY69Y989IR3rozXFyc=
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr6588059wru.336.1632419754494;
 Thu, 23 Sep 2021 10:55:54 -0700 (PDT)
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
 <CAK8P3a2MJO--xmAZ_71h1QQ5_b8WXgyo-=LaT7r7yMMBUHoPfQ@mail.gmail.com> <CAMhs-H_xdkpinyj-Y1u==ievpGWZ2Ze-_U7aCUcfu0=NKBq2xQ@mail.gmail.com>
In-Reply-To: <CAMhs-H_xdkpinyj-Y1u==ievpGWZ2Ze-_U7aCUcfu0=NKBq2xQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 23 Sep 2021 19:55:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0OWyW9Wk0kHXsj_7qTd0fVXQnszzun+HacHeTKYETXhw@mail.gmail.com>
Message-ID: <CAK8P3a0OWyW9Wk0kHXsj_7qTd0fVXQnszzun+HacHeTKYETXhw@mail.gmail.com>
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
X-Provags-ID: V03:K1:bzwPTOj4COHtJGTJO9Ks0856ISmJp9yas5pOlzdHvCJoEJhbHPk
 FClxlwiDxolHQSxbEQq/4U4nlwUuODw3C5SQc4B/m0u5llM+SsAFf0ysZmR/vmhbw72w4LX
 tgZhvj4bf4Dn7byw+dxvZVSV1I5fnLieI8HrUL/NVxO35BzJ/DJWam/ysNPNIGVtYRA/7FQ
 KGPQPoUCg7TjEhBnP3RUA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qO8qOtHJmgA=:hDB9WSf/yzjV0YO2X13ZCT
 g41aB2v5DDQo2b1Xt0NvXja3p5guRGb7JRT06GauVZsbxYH/g8feOIaW612d/EyN19ZGAAK8j
 SuXFwfYzrDLxsgicNdwshF2W4CvLFD6eZW0Rxoe/j0wL86VxCoNPhmi2HBUltxAIigZnopefh
 R6yKnyrPvFk3fYjDCS+eIJR1hO9BMWgORFh33wFPcZ5h9IPldD851I/bKlxMD4xCWbYDRR3rg
 8eiXxae1M/wEAgpm1U04nP0rY7AT5oLW8iAWRCCOVNcJmA+u0BoFzzqwJWxSPTfdsDpZX37cR
 VeEIBNQCICg9eFkx5OptXPoRGUu+OSagxvKBR4IRkRq+mh7WooTbeE0DOaIySXc4tDNM8r+x7
 RZ9pAyiBC7vYFgtAom+iBXxJRi0YrFhoJbfc3FTKGzGnhhi6Cn7u6KmjTttxKLPa0bmf6/bdj
 Q4StswOTqFKRPb+moT6+Gi0aOsM2F7y0Z+84lMvelrPvFcgCj+J6sTx69M0N3lAlopb8qROZT
 gf6cy1EUPIfFiRR2irijuZ75lqk6Y+VXd+ka2y8bOpsSy3ntBkFrGvbcrLPvrVjjQ384Oi0Jq
 4glyHqMUPmdmzdmxTmex7PEGVEa0hsCTbDQTf2wcMIcv5Rbg+axHT7K7gaQf+RVdldiCCx7xt
 rIT/LzA8oIUWS8Bajyv/vx1eeq9YGVtowIbIBSy1NBCBU3jsWCeYADv74evOGmn9KHfKRLFSD
 yfDLRNP0NubD4QZ6QtL7EUYN1b/1uRh4gwAPHQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 23, 2021 at 4:55 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
> On Thu, Sep 23, 2021 at 3:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > > > mt7621-pci 1e140000.pcie:       IO 0x001e160000..0x001e16ffff -> 0x001e160000
> > > > > LOGIC PIO: PIO TO CPUADDR: ADDR: 0x1e160000 -  addr HW_START:
> > > > > 0x1e160000 + RANGE IO: 0x00000000
> > >
> > > Why is my RANGE IO start transformed here to 0x0? Should not be the
> > > one defined in dts 0x001e160000?
>
> >
> > Can you show the exact property in your device tree? It sounds like the
> > problem is an incorrect entry in the ranges, unless the chip is hardwired
> > to the bus address in an unusual way.
>
> Here it is:
>
> ranges = <0x02000000 0 0x60000000 0x60000000 0 0x10000000>,  /* pci memory */
>                <0x01000000 0 0x1e160000 0x1e160000 0 0x00010000>;  /*
> io space */

Ok, got it. So the memory space uses a normal zero offset with cpu address
equal to bus address, but the I/O space has a rather usual mapping of
bus address equal to the window into the mmio space, with an offset of
0x1e160000.

The normal way to do this would be map the PCI port range 0-0x10000
into CPU address 0x1e160000, like:

ranges = <0x02000000 0 0x60000000 0x60000000 0 0x10000000>,  /* pci memory */
               <0x01000000 0 0x1e160000 0 0 0x00010000>;

Do you know where that mapping is set up? Is this a hardware setting,
or is there a way to change the inbound I/O port ranges to the
normal mapping?

> > > Currently, no. But if they were ideally moved to work in the same way
> > > mt7621 would be the same case. Mt7621 is device tree based PCI host
> > > bridge driver that uses pci core apis but is still mips since it has
> > > to properly set IO coherency units which is a mips thing...
> >
> > I don't know what those IO coherency units are, but I would think that
> > if you have to do some extra things on MIPS but not ARM, then those
> > should be done from the common PCI host bridge code and stubbed out
> > on architectures that don't need them.
>
> Simple definition here [0]. And we must adjust them in the driver here
> [1]. Mips code, yes, but cannot be done in another way. Is related
> with address of the memory resource and must be set up. In any other
> case the pci subsystem won't work. I initially submitted this driver
> from staging to arch/mips but I was told that even though it is mips
> code, as it is device tree based and use common pci core apis, it
> would be better to move it to 'drivers/pci/controller'. But I still
> need the mips specific code for the iocu thing.

It does sound like this could be reworked into an architecture
specific helper that is defined for MIPS but just an empty stub
for everything else. Or you can just have an #ifdef in your
driver to at least enable compile-testing it on other architecture
if not completely sharing it with others. This is certainly a less
important point compared to the I/O port mapping.

> > It is possible that the hardware (or bootloader) designers
> > misunderstood what the window is about, and hardcoded it so
> > that the port number on the bus is the same as the physical
> > address as seen from the CPU. If this is the case and you
> > can't change it to a sane value, you have to put the 1:1
> > translation into the DT and would actually get the strange
> > port numbers 0x1e161000-0x1e16100f from that nonzero offset.
>
> Yes, and that pci_add_resource_offset() is called inside
> devm_of_pci_get_host_bridge_resources() after parsing the ranges and
> storing them as resources.  To calculate that offset passed around,
> subtracts: res->start - range.pci_addr [2], so looking into my ranges
> my offset should be zero. And I have added a trace just to confirm and
> there are zero:
>
> mt7621-pci 1e140000.pcie:      MEM 0x0060000000..0x006fffffff -> 0x0060000000
> OF: IO START returned by pci_address_to_pio: 0x60000000-0x6fffffff
> PCI: OF: OFFSET -> RES START 0x60000000 - PCI ADDRESS 0x60000000 -> 0x0
> mt7621-pci 1e140000.pcie:       IO 0x001e160000..0x001e16ffff -> 0x001e160000
> OF: IO START returned by pci_address_to_pio: 0x1e160000-0x1e16ffff
> PCI: OF: OFFSET -> RES START 0x1e160000 - PCI ADDRESS 0x1e160000 -> 0x0
>
> But if I define PCI_IOBASE I get my I/O range start set to zero but
> also the offset?? Why this substract is not getting '0x1e160000' as
> offset here?
>
> LOGIC PIO: PIO TO CPUADDR: ADDR: 0x1e160000 -  addr HW_START:
> 0x1e160000 + RANGE IO: 0x00000000
> OF: IO START returned by pci_address_to_pio: 0x0-0xffff
> PCI: OF: OFFSET -> RES START 0x0 - PCI ADDRESS 0x1e160000 -> 0x0

I'm not completely following what each of the numbers in your log refer
to.  The main thing you still need is to have the hardware set up
so it matches the ranges property, and the io_offset matching that.

With PCI_IOBASE=0x1e160000, there are two possible ways this
can work:

a) according to the ranges property you listed above:
    linux port numbers 0-0xffff, pci port numbers 0x1e160000-0x1e16ffff,
    io_offset=0x1e160000 (possibly negative that number, I can never
    keep track)

b) the normal way with the ranges according to my reply above, works only
    if the hardware mapping window can be reprogrammed that way:
    linux port numbers 0-0xffff, pci port numbers 0-0xffff,
    io_offset=0

         Arnd
