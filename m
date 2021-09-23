Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A45415C88
	for <lists+linux-pci@lfdr.de>; Thu, 23 Sep 2021 13:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbhIWLKI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Sep 2021 07:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240448AbhIWLKI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Sep 2021 07:10:08 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296A0C061574;
        Thu, 23 Sep 2021 04:08:37 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id p9so4007530uak.4;
        Thu, 23 Sep 2021 04:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQqpWVviKEj4WJe+MtD7lgXtITrOhqNTLUe13rfLXOw=;
        b=ECLPrBifw/HRgH6y4VH2qefgVYqpODtpiNTq1cp71fncpAp2wGCOS3YY5dkRjB+IZT
         cZO/zCnNKOlu/YZ9IOpVEcbsZcsIYbrDHEfrrv1Sk4TRn4y4Q2zCoxy6j7bJ0WJxGvor
         ohS2ClaF0xfqU0sRjMf1kjGs/H2PUrnk+9ULBwjzrLQ6Ggf7Ul6wqhXeNc3XbBL1vsKo
         pn53L81JeoM+YPcvkTWC4R2BZTU315xEpxtfCWrtuotX2rJytd9obWg1PKLubxq+utt3
         dhpJbZRJs1BxCr2tLZn8qiSKTDAWmPeM5uguqpe0lP90TFyyLoViP9skuGCP2GLuCip4
         lQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQqpWVviKEj4WJe+MtD7lgXtITrOhqNTLUe13rfLXOw=;
        b=LUc3RTiIuteBPCmT0576VzM5lB7xi+cbubm6aI3JPF4TmpHmSBxhIKzJ0hxWDzSbQe
         iRtVuUizkz+O5aeljIpEYKW/Kc4v2H7lZTIXyq4Q9MvRqoaumaulTyLpcNyaZYylNHBj
         iaDJfRTr3WGOkAy7Oh0eNbpeS0UZ1H+Y8SMYHewTbaHWNvw6RUBqL/mLtVX3A8Ji+RrQ
         ysyHBu5L157f6W+ilhsQ5XTsUbhjfWNLDmrLy+XGnlYmr/xmKB8cG9xIWXAvh9f8Uvah
         IgB4fiyYaH0cP2B9ZOwN3kC+UlV60QOJRnS+IaYXjwhIl3J3QfOeGIu5rRnaXU/HO6sX
         4qdQ==
X-Gm-Message-State: AOAM530vOXTamwEgnRog120bl3YEhRgbwXeywuwmyH5Xpln0/Zf3tAxh
        oAPOmLzy5DcWVCx8IgSMBbwTfXytyGnoRY7czanEb/rj1Bw=
X-Google-Smtp-Source: ABdhPJyqVapu68wlw43ccuLek0Ly2cTPU8UlCMtIDIOP/6LzbIxN1lgSmbVGeBEUKIsIGwn1PWv4D+CvIVnzS4o2YvU=
X-Received: by 2002:ab0:72cc:: with SMTP id g12mr3401808uap.98.1632395316177;
 Thu, 23 Sep 2021 04:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210922042041.16326-1-sergio.paracuellos@gmail.com>
 <CAK8P3a2WPOYS7ra_epyZ_bBBpPK8+AgEynK0pKOUZ6ajubcHew@mail.gmail.com>
 <CAMhs-H8EyBmahhLsx+a0aoy+znY=PCm4BT97UBg4xcAy3x2oXg@mail.gmail.com>
 <CAK8P3a0fQZvpNCKF7OUy_krC_YPyigtd5Ak_AMXXpx84HKMswA@mail.gmail.com>
 <CAMhs-H-OCm1p6mTTV6s=vPx7FV8+1UMzx0X00wvXkW=5OgFQBQ@mail.gmail.com>
 <CAK8P3a1iN76A5ahTTQ6rCS4LjKHz8grkNGHGehLJnd0xQSnHXA@mail.gmail.com>
 <CAMhs-H_hZk3hruCaWRjKjUSj6vhVE+JZfk9nT7v1=mcc-H9wnw@mail.gmail.com>
 <CAK8P3a3C0rG_JWWCU6T4B=+j2-+6S6Gq+aw_9e6XeVun9LoF0w@mail.gmail.com>
 <CAMhs-H8kH7CMXENqDW_6GLTjeMMyk+ynehMmyBr=kFZPFHpM0A@mail.gmail.com> <CAK8P3a2WmNsV9fhSEjqwHZAGkwGc9HOurhQsza7JOM2Scts2XQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2WmNsV9fhSEjqwHZAGkwGc9HOurhQsza7JOM2Scts2XQ@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 23 Sep 2021 13:08:24 +0200
Message-ID: <CAMhs-H8fRnLavLfdw7jZO0tb8rWqdF81cGHhYT6gGp4UY1gChg@mail.gmail.com>
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

On Thu, Sep 23, 2021 at 11:07 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> ()On Thu, Sep 23, 2021 at 8:36 AM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> > On Thu, Sep 23, 2021 at 7:51 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > I am not really understanding this yet (I think I need a bit of sleep
> > > > time :)), but I will test this tomorrow and come back to you again
> > > > with results.
> > >
> > > Both would let devices access the registers, but they are different
> > > regarding the bus translations you have to program into the
> > > host bridge, and how to access the hardcoded port numbers.
> >
> > I have tested this and I get initial invalidid BAR value errors on pci
> > bus I/O enumeration an also bad addresses in /proc/ioports in the same
> > way I got defining PCI_IOBASE as _AC(0xa0000000, UL):
> >
> > root@gnubee:~# cat /proc/ioports
> > 00000000-0000ffff : pcie@1e140000
> >   00000000-00000fff : PCI Bus 0000:01
> >     00000000-0000000f : 0000:01:00.0
> >       00000000-0000000f : ahci
> >     00000010-00000017 : 0000:01:00.0
> >       00000010-00000017 : ahci
> >     00000018-0000001f : 0000:01:00.0
> >       00000018-0000001f : ahci
>
> Ok, These look good to me now.

This is the behaviour we already had with spaces.h [0] without any
other change. See also comments of Thomas [1] about this being wrong
which at the end are the motivation for this patch series.

> > mt7621-pci 1e140000.pcie:       IO 0x001e160000..0x001e16ffff -> 0x001e160000
> > LOGIC PIO: PIO TO CPUADDR: ADDR: 0x1e160000 -  addr HW_START:
> > 0x1e160000 + RANGE IO: 0x00000000

Why is my RANGE IO start transformed here to 0x0? Should not be the
one defined in dts 0x001e160000?

> > OF: IO START returned by pci_address_to_pio: 0x0-0xffff
> > mt7621-pci 1e140000.pcie: PCIE0 enabled
> > mt7621-pci 1e140000.pcie: PCIE1 enabled
> > mt7621-pci 1e140000.pcie: PCIE2 enabled
> > mt7621-pci 1e140000.pcie: PCI coherence region base: 0x60000000,
> > mask/settings: 0xf0000002
> > mt7621-pci 1e140000.pcie: PCI host bridge to bus 0000:00
> > pci_bus 0000:00: root bus resource [bus 00-ff]
> > pci_bus 0000:00: root bus resource [mem 0x60000000-0x6fffffff]
> > pci_bus 0000:00: root bus resource [io  0x0000-0xffff] (bus address
> > [0x1e160000-0x1e16ffff])
> >
> > This other one (correct behaviour AFAICS) is what I get with this
> > patch series setting IO_SPACE_LIMIT and ifdef to avoid the remapping:
> >
> > mt7621-pci 1e140000.pcie:       IO 0x001e160000..0x001e16ffff -> 0x001e160000
> > OF: IO START returned by pci_address_to_pio: 0x1e160000-0x1e16ffff
>
> While these look wrong, the output should be in the 0-0ffff range.
> I suppose you have set an incorrect io_offset now.

Well, here I am only using IO_SPACE_LIMIT set to 0x1fffffff and no
PCI_IOBASE defined and skipping the remap with this patch, so the
address listed in the dts range is returned as it is. Thus the range
'0x1e160000-0x1e16ffff'.

>
> > diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
> > index 6f48649201c5..9a8ca258c68b 100644
> > --- a/arch/mips/include/asm/pci.h
> > +++ b/arch/mips/include/asm/pci.h
> > @@ -20,6 +20,12 @@
> >  #include <linux/list.h>
> >  #include <linux/of.h>
> >
> > +#define pci_remap_iospace pci_remap_iospace
> > +static inline int pci_remap_iospace(const struct resource *res,
> > phys_addr_t phys_addr)
> > +{
> > +       return 0;
> > +}
> >
> > And then in the PCI core code do something like this?
>
> This is not sufficient: pci_remap_iospace() has to tell the architecture
> code where the start of the I/O space is, which normally means
> ioremapping it, and in your case would mean setting the
> mips_io_port_base variable to phys_addr.

Understood.

>
> > But since this 'pci_remap_iospace' is already defined in
> > 'include/linux/pci.h' and is not static at all the compiler complains
> > about doing such a thing. What am I missing here?
>
> I think you have to have another #ifdef around the declaration in
> this case, or alternatively move the mips definition back to a .c
> file and leave only the #define

Ok, so the following changes:

diff --git a/arch/mips/pci/pci-generic.c b/arch/mips/pci/pci-generic.c
index 95b00017886c..ee0e0951b800 100644
--- a/arch/mips/pci/pci-generic.c
+++ b/arch/mips/pci/pci-generic.c
@@ -46,3 +46,9 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 {
        pci_read_bridge_bases(bus);
 }
+
+int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
+{
+       mips_io_port_base = phys_addr;
+       return 0;
+}

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e578d34095e9..8db76c3a4f67 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4044,6 +4044,7 @@ unsigned long __weak
pci_address_to_pio(phys_addr_t address)
  * architectures that have memory mapped IO functions defined (and the
  * PCI_IOBASE value defined) should call this function.
  */
+#ifndef pci_remap_iospace
 int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 {
 #if defined(PCI_IOBASE) && defined(CONFIG_MMU)
@@ -4067,6 +4068,7 @@ int pci_remap_iospace(const struct resource
*res, phys_addr_t phys_addr)
 #endif
 }
 EXPORT_SYMBOL(pci_remap_iospace);
+#endif

diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 6f48649201c5..ac89354af651 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -20,6 +20,8 @@
 #include <linux/list.h>
 #include <linux/of.h>

+#define pci_remap_iospace pci_remap_iospace
+
 #ifdef CONFIG_PCI_DRIVERS_LEGACY

These changes got me to the same behaviour that this patch pretends
without the ifdef on this patch. But, this behaviour is wrong
according to your explanations since I got

OF: IO START returned by pci_address_to_pio: 0x1e160000-0x1e16ffff

and ioports using this range address and not lower 0x0-0xffff.

So all of these changes seem to be invalid: this patch and the already
added to staging-tree two ones: [2] and [3], right?

>
> > > This is particularly important since we want the host bridge driver
> > > to be portable. If you set up the mapping differently between e.g.
> > > mt7621 and mt7623, they are not able to use the same driver
> > > code for setting pci_host_bridge->io_offset and for programming
> > > the inbound translation registers.
> >
> > mt7621 is only mips, mt7623 is arm based SoC. They cannot use the same
> > driver at all. mt7620 or mt7628 which have drivers which are in
> > 'arch/mips/pci' using legacy pci code would use and would be tried to
> > be ported to share the driver with mt7621 but those are also only mips
> > and the I/O addresses for all of them are similar and have I/O higher
> > than 0xffff as mt7621 has.
>
> That was my point: the driver should never care what the I/O addresses
> are, so as long as it gets the addresses from DT and passes them into
> generic kernel interfaces, it must do the right thing on both MIPS and ARM.
>
> The mt7620/28/80/88 driver is obviously not portable because it does
> not attempt to be a generic PCI host bridge driver.

Currently, no. But if they were ideally moved to work in the same way
mt7621 would be the same case. Mt7621 is device tree based PCI host
bridge driver that uses pci core apis but is still mips since it has
to properly set IO coherency units which is a mips thing...

>
> > > > All I/O port addresses for ralink SoCs are in higher addresses than
> > > > default IO_SPACE_LIMIT 0xFFFF, that's why we have to also change this
> > > > limit together with this patch changes. Nothing to do with this, is an
> > > > architectural thing of these SoCs.
> > >
> > > I don't understand. What I see above is that the host bridge
> > > has the region 1e160000-1e16ffff registered, so presumably
> > > 1e160000 is actually the start of the window into the host bridge.
> > > If you set PCI_IOBASE to that location, the highest port number
> > > would become 0x2027, which is under 0xffff.
> >
> > But 0x1e160000 is defined in the device tree as the I/O start address
> > of the range and should not be hardcoded anywhere else since other
> > ralink platforms don't use this address as PCI_IOBASE. And yes, 0x2027
> > is the highest port number I get if I initially define PCI_IOBASE also
> > as KSEG1 since at the end is the entry point for I/O in mips (see
> > trace above).
> >
> > Thanks very much for your time and feedback.
>
> 0x1e160000 should not be listed as the I/O start address, it should
> be listed in the 'ranges' property as the MMIO address that the I/O
> window translates into, with the actual port numbers (on the bus)
> being in the low range.
>
> I realize this is very confusing, but there are indeed at least three
> address spaces that you must not confuse here:
>
> a) I/O port numbers as programmed into BAR registers and
>     used in PCIe transactions, normally 0 through 0xffff on each
>     bus.
> b) Linux I/O port numbers as seen from user space, in the range
>      from 0 to IO_SPACE_LIMIT, these correspond to the
>      bus addresses from a) if io_offset is zero, but could be
>      different with a non-zero value passed into
>      pci_add_resource_offset() when the region is probed.
>      The offset may be different on each pci host bridge.

This "offset" is the pci address configured in device tree range,
right? This seems the part is not doing properly in my case since all
of these changes are needed to at the end got BAR's as

pci 0000:02:00.0: BAR 4: assigned [io  0x1e161000-0x1e16100f]
pci 0000:02:00.0: BAR 0: assigned [io  0x1e161010-0x1e161017]
pci 0000:02:00.0: BAR 2: assigned [io  0x1e161018-0x1e16101f]
pci 0000:02:00.0: BAR 1: assigned [io  0x1e161020-0x1e161023]
pci 0000:02:00.0: BAR 3: assigned [io  0x1e161024-0x1e161027]

which I understand is correct.

> c) MMIO address used to access ports, offset by PCI_IOBASE
>     from the Linux port numbers in b).
>     No other registers should be visible between PCI_IOBASE
>     and PCI_IOBASE+IO_SPACE_LIMIT

mips_io_port_base + offset, right? KSEG1 addresses for mips by default.

Thanks for your patience, BTW :)).

Best regards,
    Sergio Paracuellos

>
>           Arnd

[0]: https://elixir.bootlin.com/linux/v5.15-rc2/source/arch/mips/include/asm/mach-ralink/spaces.h
[1]: https://lore.kernel.org/linux-mips/20210729100146.GA8648@alpha.franken.de/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=159697474db41732ef3b6c2e8d9395f09d1f659e
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=50fb34eca2944fd67493717c9fbda125336f1655
