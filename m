Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D351441617C
	for <lists+linux-pci@lfdr.de>; Thu, 23 Sep 2021 16:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241783AbhIWO5C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Sep 2021 10:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241735AbhIWO5B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Sep 2021 10:57:01 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7947C061574;
        Thu, 23 Sep 2021 07:55:29 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id az15so6803199vsb.8;
        Thu, 23 Sep 2021 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bvTv2ajxriCYjP0mYei7lj4bkhbVM0Fvo1NAnUQDicE=;
        b=nNHY8AxyQGcwCktAMim89qjhecxp6BsaVnOR80AcdZTQO+bORXjNSvYV8K6eWOrtWL
         CttjnX6k341fXjKejoyK58xjoUgD5fRtdav/nbp+GzmRGimTDCFkTuV2+zizDWuuNHUc
         q8byLF7fmW0FEn2+gnwfwvX4B/jlDRLKRAxRjKSPbGDSTfsP9Gp3dn895iCBrELyBxtH
         S9XN1JsuZ29FZrdlxZdbCdoTE148dOnRQksCjv4Ckrxycp0Q6ZLJ0KIYx2IwUh6ZA51Q
         uDMAZoIWgYkA+Kbbd3lOz/AXMa0BgqgH6MlOoYir/a4nTPg+6yekTueHIThipZrvGLZr
         l7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvTv2ajxriCYjP0mYei7lj4bkhbVM0Fvo1NAnUQDicE=;
        b=5vrw6P/Kd2Tp8eyTUFUEoa05/Byth9ucfX8wejXQgYB2wwrybvScf4yYvDfGc8swZg
         Z4BQVbz9QTgwPNGuF05fdITyLyy+//p8hsVs7HMZdG6207YU/si92Yp/sPIq21xbPg84
         kfpLJovP/LsHyIKSIaUjBLIUvjWDE9N/573L6dhqNawXfs6Z5FfhJ6J6ebZZnN/dvAiB
         xN1xVj3FdEa81VE/FZEiMfLH5uQd3yC8dsFSgZpkOcDsfF0gba7w5brbQQ5riRvUlsfI
         AGZWSDgz1Xi8xMtt+En7uI9IvcGKV8jl3c3OYrMCc2ZB679DZnK3R+JTSFc1P5AgxpjK
         JjSA==
X-Gm-Message-State: AOAM532+L18wS0MFQQ8XEw+225ikXIV2v/FroBVXppkZQC9a8kzR7On8
        upL+aRy73ygIFeKBTp5ZW28/hsp8COmLmO4/k6JTTbvToDY=
X-Google-Smtp-Source: ABdhPJxw3EKdt9xPpXWJdIzuOCstA5NGxvXgvDrjsD9iZhVAIl0tB8PP+m4ANpB2HbJFkqBDaBekfrNitIsmO6VRqPE=
X-Received: by 2002:a67:3204:: with SMTP id y4mr4378863vsy.28.1632408928878;
 Thu, 23 Sep 2021 07:55:28 -0700 (PDT)
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
 <CAMhs-H8fRnLavLfdw7jZO0tb8rWqdF81cGHhYT6gGp4UY1gChg@mail.gmail.com> <CAK8P3a2MJO--xmAZ_71h1QQ5_b8WXgyo-=LaT7r7yMMBUHoPfQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2MJO--xmAZ_71h1QQ5_b8WXgyo-=LaT7r7yMMBUHoPfQ@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 23 Sep 2021 16:55:17 +0200
Message-ID: <CAMhs-H_xdkpinyj-Y1u==ievpGWZ2Ze-_U7aCUcfu0=NKBq2xQ@mail.gmail.com>
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

On Thu, Sep 23, 2021 at 3:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
>  ==On Thu, Sep 23, 2021 at 1:09 PM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> > On Thu, Sep 23, 2021 at 11:07 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > ()On Thu, Sep 23, 2021 at 8:36 AM Sergio Paracuellos
> > > <sergio.paracuellos@gmail.com> wrote:
> > > > On Thu, Sep 23, 2021 at 7:51 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > I am not really understanding this yet (I think I need a bit of sleep
> > > > > > time :)), but I will test this tomorrow and come back to you again
> > > > > > with results.
> > > > >
> > > > > Both would let devices access the registers, but they are different
> > > > > regarding the bus translations you have to program into the
> > > > > host bridge, and how to access the hardcoded port numbers.
> > > >
> > > > I have tested this and I get initial invalidid BAR value errors on pci
> > > > bus I/O enumeration an also bad addresses in /proc/ioports in the same
> > > > way I got defining PCI_IOBASE as _AC(0xa0000000, UL):
> > > >
> > > > root@gnubee:~# cat /proc/ioports
> > > > 00000000-0000ffff : pcie@1e140000
> > > >   00000000-00000fff : PCI Bus 0000:01
> > > >     00000000-0000000f : 0000:01:00.0
> > > >       00000000-0000000f : ahci
> > > >     00000010-00000017 : 0000:01:00.0
> > > >       00000010-00000017 : ahci
> > > >     00000018-0000001f : 0000:01:00.0
> > > >       00000018-0000001f : ahci
> > >
> > > Ok, These look good to me now.
> >
> > This is the behaviour we already had with spaces.h [0] without any
> > other change. See also comments of Thomas [1] about this being wrong
> > which at the end are the motivation for this patch series.
> >
> > > > mt7621-pci 1e140000.pcie:       IO 0x001e160000..0x001e16ffff -> 0x001e160000
> > > > LOGIC PIO: PIO TO CPUADDR: ADDR: 0x1e160000 -  addr HW_START:
> > > > 0x1e160000 + RANGE IO: 0x00000000
> >
> > Why is my RANGE IO start transformed here to 0x0? Should not be the
> > one defined in dts 0x001e160000?

>
> Can you show the exact property in your device tree? It sounds like the
> problem is an incorrect entry in the ranges, unless the chip is hardwired
> to the bus address in an unusual way.

Here it is:

ranges = <0x02000000 0 0x60000000 0x60000000 0 0x10000000>,  /* pci memory */
               <0x01000000 0 0x1e160000 0x1e160000 0 0x00010000>;  /*
io space */

>
> > > I think you have to have another #ifdef around the declaration in
> > > this case, or alternatively move the mips definition back to a .c
> > > file and leave only the #define
> >
> > Ok, so the following changes:
> >
> > diff --git a/arch/mips/pci/pci-generic.c b/arch/mips/pci/pci-generic.c
> > index 95b00017886c..ee0e0951b800 100644
> > --- a/arch/mips/pci/pci-generic.c
> > +++ b/arch/mips/pci/pci-generic.c
> > @@ -46,3 +46,9 @@ void pcibios_fixup_bus(struct pci_bus *bus)
> >  {
> >         pci_read_bridge_bases(bus);
> >  }
> > +
> > +int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
> > +{
> > +       mips_io_port_base = phys_addr;
> > +       return 0;
> > +}
> ...
> > These changes got me to the same behaviour that this patch pretends
> > without the ifdef on this patch. But, this behaviour is wrong
> > according to your explanations since I got
> >
> > OF: IO START returned by pci_address_to_pio: 0x1e160000-0x1e16ffff
> >
> > and ioports using this range address and not lower 0x0-0xffff.
> >
> > So all of these changes seem to be invalid: this patch and the already
> > added to staging-tree two ones: [2] and [3], right?
>
> Right, there is probably yet another problem. Patch [2] should
> be harmless here, but patch [3] is wrong as you should not override
> the length of the I/O port window that is in the DT.

Understood and makes sense. If I also set the start address for the
port the length won't be overwritten but I am only setting the end
limit there since I don't have the io range start address in such
early probe part of the driver and makes no sense to hardcode it. That
is the only reason.

>
> > Currently, no. But if they were ideally moved to work in the same way
> > mt7621 would be the same case. Mt7621 is device tree based PCI host
> > bridge driver that uses pci core apis but is still mips since it has
> > to properly set IO coherency units which is a mips thing...
>
> I don't know what those IO coherency units are, but I would think that
> if you have to do some extra things on MIPS but not ARM, then those
> should be done from the common PCI host bridge code and stubbed out
> on architectures that don't need them.

Simple definition here [0]. And we must adjust them in the driver here
[1]. Mips code, yes, but cannot be done in another way. Is related
with address of the memory resource and must be set up. In any other
case the pci subsystem won't work. I initially submitted this driver
from staging to arch/mips but I was told that even though it is mips
code, as it is device tree based and use common pci core apis, it
would be better to move it to 'drivers/pci/controller'. But I still
need the mips specific code for the iocu thing.

>
> > > I realize this is very confusing, but there are indeed at least three
> > > address spaces that you must not confuse here:
> > >
> > > a) I/O port numbers as programmed into BAR registers and
> > >     used in PCIe transactions, normally 0 through 0xffff on each
> > >     bus.
> > > b) Linux I/O port numbers as seen from user space, in the range
> > >      from 0 to IO_SPACE_LIMIT, these correspond to the
> > >      bus addresses from a) if io_offset is zero, but could be
> > >      different with a non-zero value passed into
> > >      pci_add_resource_offset() when the region is probed.
> > >      The offset may be different on each pci host bridge.
> >
> > This "offset" is the pci address configured in device tree range,
> > right? This seems the part is not doing properly in my case since all
> > of these changes are needed to at the end got BAR's as
> >
> > pci 0000:02:00.0: BAR 4: assigned [io  0x1e161000-0x1e16100f]
> > pci 0000:02:00.0: BAR 0: assigned [io  0x1e161010-0x1e161017]
> > pci 0000:02:00.0: BAR 2: assigned [io  0x1e161018-0x1e16101f]
> > pci 0000:02:00.0: BAR 1: assigned [io  0x1e161020-0x1e161023]
> > pci 0000:02:00.0: BAR 3: assigned [io  0x1e161024-0x1e161027]
> >
> > which I understand is correct.
>
> The "offset" is between two numbers that can normally both be
> picked freely, so it could literally be anything, but in the most common
> and ideal case, it is zero:
>
> The Linux port number gets assigned when probing the host bridge,
> this is purely a software construct and the first bridge should normally
> get range 0-0xffff, the second bridge gets range 0x10000-0x1ffff
> etc. The code assigning these numbers is rather confusing, and I
> can't even find where it is now...
>
> The port number on the bus is platform specific. In some cases
> you can set it through a register in the pci host bridge, in other
> cases it is fixed to starting at zero. If the address is programmable,
> it can be either set by the firmware or bootloader and passed down
> to the kernel through the DT ranges property, or the ranges can
> contain a suggested value that then has to be programmed by
> the host bridge driver.
>
> If the value is not zero, you should try setting it to zero to get
> an identity mapping against the Linux port numbers, to minimize
> the confusion.
>
> It is possible that the hardware (or bootloader) designers
> misunderstood what the window is about, and hardcoded it so
> that the port number on the bus is the same as the physical
> address as seen from the CPU. If this is the case and you
> can't change it to a sane value, you have to put the 1:1
> translation into the DT and would actually get the strange
> port numbers 0x1e161000-0x1e16100f from that nonzero offset.

Yes, and that pci_add_resource_offset() is called inside
devm_of_pci_get_host_bridge_resources() after parsing the ranges and
storing them as resources.  To calculate that offset passed around,
subtracts: res->start - range.pci_addr [2], so looking into my ranges
my offset should be zero. And I have added a trace just to confirm and
there are zero:

mt7621-pci 1e140000.pcie:      MEM 0x0060000000..0x006fffffff -> 0x0060000000
OF: IO START returned by pci_address_to_pio: 0x60000000-0x6fffffff
PCI: OF: OFFSET -> RES START 0x60000000 - PCI ADDRESS 0x60000000 -> 0x0
mt7621-pci 1e140000.pcie:       IO 0x001e160000..0x001e16ffff -> 0x001e160000
OF: IO START returned by pci_address_to_pio: 0x1e160000-0x1e16ffff
PCI: OF: OFFSET -> RES START 0x1e160000 - PCI ADDRESS 0x1e160000 -> 0x0

But if I define PCI_IOBASE I get my I/O range start set to zero but
also the offset?? Why this substract is not getting '0x1e160000' as
offset here?

LOGIC PIO: PIO TO CPUADDR: ADDR: 0x1e160000 -  addr HW_START:
0x1e160000 + RANGE IO: 0x00000000
OF: IO START returned by pci_address_to_pio: 0x0-0xffff
PCI: OF: OFFSET -> RES START 0x0 - PCI ADDRESS 0x1e160000 -> 0x0


>
> This means you can only use PCI devices that can be
> programmed with high port numbers, but not devices with
> hardcoded legacy ports.

So there is no real sense of having PCI IO working then since this
such devices is unlikely to exist.

>
> > > c) MMIO address used to access ports, offset by PCI_IOBASE
> > >     from the Linux port numbers in b).
> > >     No other registers should be visible between PCI_IOBASE
> > >     and PCI_IOBASE+IO_SPACE_LIMIT
> >
> > mips_io_port_base + offset, right? KSEG1 addresses for mips by default.
>
> no, not the offset. As long as mips_io_port_base==PCI_IOBASE,
> the accessible ports will be between mips_io_port_base and
> mips_io_port_base+0xffff.

Understood, thanks.

Best regards,
    Sergio Paracuellos

>
>          Arnd

[0]; https://www.linux-mips.org/wiki/IO_Coherence_Unit
[1]; https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tree/drivers/staging/mt7621-pci/pci-mt7621.c?h=staging-testing#n211
[2]: https://elixir.bootlin.com/linux/latest/source/drivers/pci/of.c#L401
