Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E31D415A92
	for <lists+linux-pci@lfdr.de>; Thu, 23 Sep 2021 11:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbhIWJJK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Sep 2021 05:09:10 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:55239 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239985AbhIWJJJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Sep 2021 05:09:09 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M3DeV-1mQJtd1Rm9-003eLa; Thu, 23 Sep 2021 11:07:36 +0200
Received: by mail-wr1-f52.google.com with SMTP id d6so14988384wrc.11;
        Thu, 23 Sep 2021 02:07:36 -0700 (PDT)
X-Gm-Message-State: AOAM532OwlixegQ87DTkYLrhI/o+G9odB5cN0mLwXOcFRcXMp7ku4rO1
        F3rLy39nJkWt97bmOveYDYADJwIOooEJ9Gof8lE=
X-Google-Smtp-Source: ABdhPJw02Ym59JthBlWy2+omRXFea233bI9/OcKwe2cstYlMYfujSYUJUn4Jiyk/dDpmx1aXHsbwdLIbdp4hV2OlXgA=
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr3711232wru.336.1632388055871;
 Thu, 23 Sep 2021 02:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210922042041.16326-1-sergio.paracuellos@gmail.com>
 <CAK8P3a2WPOYS7ra_epyZ_bBBpPK8+AgEynK0pKOUZ6ajubcHew@mail.gmail.com>
 <CAMhs-H8EyBmahhLsx+a0aoy+znY=PCm4BT97UBg4xcAy3x2oXg@mail.gmail.com>
 <CAK8P3a0fQZvpNCKF7OUy_krC_YPyigtd5Ak_AMXXpx84HKMswA@mail.gmail.com>
 <CAMhs-H-OCm1p6mTTV6s=vPx7FV8+1UMzx0X00wvXkW=5OgFQBQ@mail.gmail.com>
 <CAK8P3a1iN76A5ahTTQ6rCS4LjKHz8grkNGHGehLJnd0xQSnHXA@mail.gmail.com>
 <CAMhs-H_hZk3hruCaWRjKjUSj6vhVE+JZfk9nT7v1=mcc-H9wnw@mail.gmail.com>
 <CAK8P3a3C0rG_JWWCU6T4B=+j2-+6S6Gq+aw_9e6XeVun9LoF0w@mail.gmail.com> <CAMhs-H8kH7CMXENqDW_6GLTjeMMyk+ynehMmyBr=kFZPFHpM0A@mail.gmail.com>
In-Reply-To: <CAMhs-H8kH7CMXENqDW_6GLTjeMMyk+ynehMmyBr=kFZPFHpM0A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 23 Sep 2021 11:07:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2WmNsV9fhSEjqwHZAGkwGc9HOurhQsza7JOM2Scts2XQ@mail.gmail.com>
Message-ID: <CAK8P3a2WmNsV9fhSEjqwHZAGkwGc9HOurhQsza7JOM2Scts2XQ@mail.gmail.com>
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
X-Provags-ID: V03:K1:EI1qVFztvs+UMxa32vglsL3nwIKf4VCJ7JKtt+urFuH29VeuAKJ
 0K0iZ6/wsJEvOLT4COT1uPMNZK8/tfYkedZDp560XVhCpyh2gxTCfSWhp7QwNfGjF2X8z1T
 F7bvol1/Bo/r9mSMUM3pccrR8zvDUXSd9pJMs4PbRRCbLUMfqhcU04rTN6JIwiuk5sBu0xB
 TFzVNwDOn2oVYPuX7aDXg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kMvUb7KObPk=:H0GKPhAsY3vbIbiBRRK24f
 IBl18SfcPLLSrNhmzPOnbh7XmdReO5FbYIIimjg1lsFt/+mqXZVHHeu3T3rOaLe4H1GIOXIOi
 2scMjl2I/UR7Hae9XXxQVN1zyYEIAoA6W2q5p5P4BPepSlUPsj5gBeRTzXhVna6cpU4+ATnvX
 vlckDUpfZ4CuOmO1mbBM+WMGvyD2NB4dTyIUQiDdvXzR8wEey8fA8OHKCkvwm2cvf5OYF3hMp
 4B2yUKQMb2Qyyif4JyOq0sMe34AT3nWnh017RLlP/FN+LL3Uz+bBoDnZBclrVWRTqwMpVdxqs
 WbKg9mSqSgmdjuiycLkp2T8WV4KWmIo3go/V3M8ZOJkO4He4EE8Fsuuty70wzcMxYXT8+zIu2
 QmIJtQ5rG1R0If6Q38xyGeLbYHQNKZtEUAbqsW7vJVHXzutAp6HS+nPzP8hoZoMnNLV6x8YYe
 QRuQXWVFuQiZmfdmqygeknNkAtd74A4gpacfSbbEqxQwqhYOBIuFfHp1ZcT47IUXGg5uK1WCK
 CqjzbYz2lc2dNycye9Uf03BjUB9WQ/b/zYUhwusQFNT8FVE3Du1D0w0PEUdhGwA7gGXOVyINs
 WPwpt3/MZF+EUYY5ZhmHWkXkyHgugTM3ZZIr/RYjIxN2drAwINrF9zesaqM+jO/+FkQhLJthI
 FnmliKhbgGLLboQi7U3MutLSdcBpCf4cKu88neyqdM00YWJ0j6j+ESZsPB6rPRWTK+0bTKl6p
 cnU/iSNj4z3ICfOzSmbCxVe8TUfSJ+4pBf2M4g==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

()On Thu, Sep 23, 2021 at 8:36 AM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
> On Thu, Sep 23, 2021 at 7:51 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > I am not really understanding this yet (I think I need a bit of sleep
> > > time :)), but I will test this tomorrow and come back to you again
> > > with results.
> >
> > Both would let devices access the registers, but they are different
> > regarding the bus translations you have to program into the
> > host bridge, and how to access the hardcoded port numbers.
>
> I have tested this and I get initial invalidid BAR value errors on pci
> bus I/O enumeration an also bad addresses in /proc/ioports in the same
> way I got defining PCI_IOBASE as _AC(0xa0000000, UL):
>
> root@gnubee:~# cat /proc/ioports
> 00000000-0000ffff : pcie@1e140000
>   00000000-00000fff : PCI Bus 0000:01
>     00000000-0000000f : 0000:01:00.0
>       00000000-0000000f : ahci
>     00000010-00000017 : 0000:01:00.0
>       00000010-00000017 : ahci
>     00000018-0000001f : 0000:01:00.0
>       00000018-0000001f : ahci

Ok, These look good to me now.

> mt7621-pci 1e140000.pcie:       IO 0x001e160000..0x001e16ffff -> 0x001e160000
> LOGIC PIO: PIO TO CPUADDR: ADDR: 0x1e160000 -  addr HW_START:
> 0x1e160000 + RANGE IO: 0x00000000
> OF: IO START returned by pci_address_to_pio: 0x0-0xffff
> mt7621-pci 1e140000.pcie: PCIE0 enabled
> mt7621-pci 1e140000.pcie: PCIE1 enabled
> mt7621-pci 1e140000.pcie: PCIE2 enabled
> mt7621-pci 1e140000.pcie: PCI coherence region base: 0x60000000,
> mask/settings: 0xf0000002
> mt7621-pci 1e140000.pcie: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [bus 00-ff]
> pci_bus 0000:00: root bus resource [mem 0x60000000-0x6fffffff]
> pci_bus 0000:00: root bus resource [io  0x0000-0xffff] (bus address
> [0x1e160000-0x1e16ffff])
>
> This other one (correct behaviour AFAICS) is what I get with this
> patch series setting IO_SPACE_LIMIT and ifdef to avoid the remapping:
>
> mt7621-pci 1e140000.pcie:       IO 0x001e160000..0x001e16ffff -> 0x001e160000
> OF: IO START returned by pci_address_to_pio: 0x1e160000-0x1e16ffff

While these look wrong, the output should be in the 0-0ffff range.
I suppose you have set an incorrect io_offset now.

> diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
> index 6f48649201c5..9a8ca258c68b 100644
> --- a/arch/mips/include/asm/pci.h
> +++ b/arch/mips/include/asm/pci.h
> @@ -20,6 +20,12 @@
>  #include <linux/list.h>
>  #include <linux/of.h>
>
> +#define pci_remap_iospace pci_remap_iospace
> +static inline int pci_remap_iospace(const struct resource *res,
> phys_addr_t phys_addr)
> +{
> +       return 0;
> +}
>
> And then in the PCI core code do something like this?

This is not sufficient: pci_remap_iospace() has to tell the architecture
code where the start of the I/O space is, which normally means
ioremapping it, and in your case would mean setting the
mips_io_port_base variable to phys_addr.

> But since this 'pci_remap_iospace' is already defined in
> 'include/linux/pci.h' and is not static at all the compiler complains
> about doing such a thing. What am I missing here?

I think you have to have another #ifdef around the declaration in
this case, or alternatively move the mips definition back to a .c
file and leave only the #define

> > This is particularly important since we want the host bridge driver
> > to be portable. If you set up the mapping differently between e.g.
> > mt7621 and mt7623, they are not able to use the same driver
> > code for setting pci_host_bridge->io_offset and for programming
> > the inbound translation registers.
>
> mt7621 is only mips, mt7623 is arm based SoC. They cannot use the same
> driver at all. mt7620 or mt7628 which have drivers which are in
> 'arch/mips/pci' using legacy pci code would use and would be tried to
> be ported to share the driver with mt7621 but those are also only mips
> and the I/O addresses for all of them are similar and have I/O higher
> than 0xffff as mt7621 has.

That was my point: the driver should never care what the I/O addresses
are, so as long as it gets the addresses from DT and passes them into
generic kernel interfaces, it must do the right thing on both MIPS and ARM.

The mt7620/28/80/88 driver is obviously not portable because it does
not attempt to be a generic PCI host bridge driver.

> > > All I/O port addresses for ralink SoCs are in higher addresses than
> > > default IO_SPACE_LIMIT 0xFFFF, that's why we have to also change this
> > > limit together with this patch changes. Nothing to do with this, is an
> > > architectural thing of these SoCs.
> >
> > I don't understand. What I see above is that the host bridge
> > has the region 1e160000-1e16ffff registered, so presumably
> > 1e160000 is actually the start of the window into the host bridge.
> > If you set PCI_IOBASE to that location, the highest port number
> > would become 0x2027, which is under 0xffff.
>
> But 0x1e160000 is defined in the device tree as the I/O start address
> of the range and should not be hardcoded anywhere else since other
> ralink platforms don't use this address as PCI_IOBASE. And yes, 0x2027
> is the highest port number I get if I initially define PCI_IOBASE also
> as KSEG1 since at the end is the entry point for I/O in mips (see
> trace above).
>
> Thanks very much for your time and feedback.

0x1e160000 should not be listed as the I/O start address, it should
be listed in the 'ranges' property as the MMIO address that the I/O
window translates into, with the actual port numbers (on the bus)
being in the low range.

I realize this is very confusing, but there are indeed at least three
address spaces that you must not confuse here:

a) I/O port numbers as programmed into BAR registers and
    used in PCIe transactions, normally 0 through 0xffff on each
    bus.
b) Linux I/O port numbers as seen from user space, in the range
     from 0 to IO_SPACE_LIMIT, these correspond to the
     bus addresses from a) if io_offset is zero, but could be
     different with a non-zero value passed into
     pci_add_resource_offset() when the region is probed.
     The offset may be different on each pci host bridge.
c) MMIO address used to access ports, offset by PCI_IOBASE
    from the Linux port numbers in b).
    No other registers should be visible between PCI_IOBASE
    and PCI_IOBASE+IO_SPACE_LIMIT

          Arnd
