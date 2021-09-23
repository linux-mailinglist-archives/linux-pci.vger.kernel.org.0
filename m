Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6319B41584A
	for <lists+linux-pci@lfdr.de>; Thu, 23 Sep 2021 08:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbhIWGh6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Sep 2021 02:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbhIWGh4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Sep 2021 02:37:56 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4450C061574;
        Wed, 22 Sep 2021 23:36:25 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id s125so2177695vkd.4;
        Wed, 22 Sep 2021 23:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=25IgOf1O4ZVDx2LprE1oHj1su6SjDD3lXVLj93fp81o=;
        b=Aws9oKc7uPMf4Oxzkp/feQQHWxFXSXmNZjhgUBgEOre/ApbhbHwcxwnkDHVFwL6ZBH
         8pqssne+8upvNj9SOa5y4uwE1JOTARkWbcok9YqzMxX/Ic7GqwoskQMmJABwm/X8J3O4
         v+PF+5r4pY5Z95deAfF0L5YbODnbku5aObGeaOywActTTcHo75IRpELyVv0N1+hyjC2A
         rGTDINGWk04hM9dQwJZSqOy80OLG1NtmfV3nuQC7Obwh1KRMpafmsjdVBLir6raUPCsa
         Gg6lFhoYu6JccQ7pQKE6VyWzo65af0rZzy2eSja9371vrSBNLYW9q/NpGlpy2ueyIMyJ
         yJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=25IgOf1O4ZVDx2LprE1oHj1su6SjDD3lXVLj93fp81o=;
        b=LfDGlLhVCrGAmkc6NjIFC3HoKUXiFjN4P0SDLm1v1p/Zipiue9O+GqBau5lc8o6j8Q
         9Sgn2PVaPs4m5IwYeM2jVWjDWPRHiM0IV4fqOluwgxCH/Wn3Qge9ZmgGR5ooAQhL4fR6
         pafylB/1v+3wpLzKNHJTej3pwF5QHHdnzaHtNjteyQjUu8tCmceaaqJYiOG81g9PQLoB
         1EntnywXqmJvUrzDsZp3Ok+aE9Jpw74swbqxyE+frRBpKrzR64gfxtWiCxuqBIY/MuSd
         cfjZePOB8qsEtOkGJhLyBd9ENbe42soEJm7Iy0WDkItD6f49aaJ8lHBBV8krzPPZWwXB
         Rezg==
X-Gm-Message-State: AOAM531h4N5GoGa/d3+o7+fQR8qqsF0DXf4b1x8kL0qARAJOYQVYdRea
        SmDkHQP2byWdSvJi3HmMXY9qfHDR0mmpCMeI4QI=
X-Google-Smtp-Source: ABdhPJxC5zU4dUCVE508GCNo1eKHjihyte8Vco3i6URbFEo2T6PcI8867izoHmLRdN48GlaG+tgNBmzzt3ZgDG5sZOM=
X-Received: by 2002:a1f:9d09:: with SMTP id g9mr2105070vke.4.1632378984749;
 Wed, 22 Sep 2021 23:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210922042041.16326-1-sergio.paracuellos@gmail.com>
 <CAK8P3a2WPOYS7ra_epyZ_bBBpPK8+AgEynK0pKOUZ6ajubcHew@mail.gmail.com>
 <CAMhs-H8EyBmahhLsx+a0aoy+znY=PCm4BT97UBg4xcAy3x2oXg@mail.gmail.com>
 <CAK8P3a0fQZvpNCKF7OUy_krC_YPyigtd5Ak_AMXXpx84HKMswA@mail.gmail.com>
 <CAMhs-H-OCm1p6mTTV6s=vPx7FV8+1UMzx0X00wvXkW=5OgFQBQ@mail.gmail.com>
 <CAK8P3a1iN76A5ahTTQ6rCS4LjKHz8grkNGHGehLJnd0xQSnHXA@mail.gmail.com>
 <CAMhs-H_hZk3hruCaWRjKjUSj6vhVE+JZfk9nT7v1=mcc-H9wnw@mail.gmail.com> <CAK8P3a3C0rG_JWWCU6T4B=+j2-+6S6Gq+aw_9e6XeVun9LoF0w@mail.gmail.com>
In-Reply-To: <CAK8P3a3C0rG_JWWCU6T4B=+j2-+6S6Gq+aw_9e6XeVun9LoF0w@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 23 Sep 2021 08:36:13 +0200
Message-ID: <CAMhs-H8kH7CMXENqDW_6GLTjeMMyk+ynehMmyBr=kFZPFHpM0A@mail.gmail.com>
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

On Thu, Sep 23, 2021 at 7:51 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
>  isOn Wed, Sep 22, 2021 at 10:55 PM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> > On Wed, Sep 22, 2021 at 9:57 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Wed, Sep 22, 2021 at 8:40 PM Sergio Paracuellos
> > > <sergio.paracuellos@gmail.com> wrote:
> > > > On Wed, Sep 22, 2021 at 8:07 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > On Wed, Sep 22, 2021 at 7:42 PM Sergio Paracuellos
> > > > > Ok, thank you for the detailed explanation.
> > > > >
> > > > > I suppose you can use the generic infrastructure in asm-generic/io.h
> > > > > if you "#define PCI_IOBASE mips_io_port_base". In this case, you
> > > > > should have an architecture specific implementation of
> > > > > pci_remap_iospace() that assigns mips_io_port_base.
> > > >
> > > > No, that is what I tried originally defining PCI_IOBASE as
> > > > _AC(0xa0000000, UL) [0] which is the same as KSEG1 [1] that ends in
> > > > 'mips_io_port_base'.
> > >
> > > Defining it as KSEG1 would be problematic because that means that
> > > the Linux-visible port numbers are offset from the bus-visible ones.
> > >
> > > You really want PCI_IOBASE to point to the address of port 0.
> >
> > Do you mean that doing
> >
> > #define PCI_IOBASE mips_io_port_base
> >
> > would have different result that doing what I did
> >
> > #define PCI_IOBASE _AC(0xa0000000, UL)
> >
> > ?
> >
> > I am not really understanding this yet (I think I need a bit of sleep
> > time :)), but I will test this tomorrow and come back to you again
> > with results.
>
> Both would let devices access the registers, but they are different
> regarding the bus translations you have to program into the
> host bridge, and how to access the hardcoded port numbers.

I have tested this and I get initial invalidid BAR value errors on pci
bus I/O enumeration an also bad addresses in /proc/ioports in the same
way I got defining PCI_IOBASE as _AC(0xa0000000, UL):

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
root@gnubee:~#

This is the pci boot trace I get doing what you proposed (I have also
added some traces for 'logic_pio_trans_cpuaddr' and
'pci_address_to_pio'):

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index f32fe481b492..529e28aba74b 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -216,6 +218,7 @@ unsigned long logic_pio_trans_cpuaddr(resource_size_t addr)
                        unsigned long cpuaddr;

                        cpuaddr = addr - range->hw_start + range->io_start;
+                       pr_info("PIO TO CPUADDR: ADDR: 0x%x -  addr
HW_START: 0x%08x + RANGE IO: 0x%08x\n", addr, range->hw_start,
range->io_start);

                        rcu_read_unlock();
                        return cpuaddr;

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 1c3257a2d4e3..52b77b5defac 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -298,6 +298,8 @@ int of_pci_range_to_resource(struct of_pci_range *range,
                res->start = range->cpu_addr;
        }
        res->end = res->start + range->size - 1;
+       pr_info("IO START returned by pci_address_to_pio: 0x%x-0x%x\n",
+               res->start, res->end);
        return 0;

 invalid_range:


mt7621-pci 1e140000.pcie:       IO 0x001e160000..0x001e16ffff -> 0x001e160000
LOGIC PIO: PIO TO CPUADDR: ADDR: 0x1e160000 -  addr HW_START:
0x1e160000 + RANGE IO: 0x00000000
OF: IO START returned by pci_address_to_pio: 0x0-0xffff
mt7621-pci 1e140000.pcie: PCIE0 enabled
mt7621-pci 1e140000.pcie: PCIE1 enabled
mt7621-pci 1e140000.pcie: PCIE2 enabled
mt7621-pci 1e140000.pcie: PCI coherence region base: 0x60000000,
mask/settings: 0xf0000002
mt7621-pci 1e140000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: root bus resource [mem 0x60000000-0x6fffffff]
pci_bus 0000:00: root bus resource [io  0x0000-0xffff] (bus address
[0x1e160000-0x1e16ffff])
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
pci 0000:01:00.0: reg 0x10: initial BAR value 0x00000000 invalid
pci 0000:01:00.0: reg 0x10: [io  size 0x0008]
pci 0000:01:00.0: reg 0x14: initial BAR value 0x00000000 invalid
pci 0000:01:00.0: reg 0x14: [io  size 0x0004]
pci 0000:01:00.0: reg 0x18: initial BAR value 0x00000000 invalid
pci 0000:01:00.0: reg 0x18: [io  size 0x0008]
pci 0000:01:00.0: reg 0x1c: initial BAR value 0x00000000 invalid
pci 0000:01:00.0: reg 0x1c: [io  size 0x0004]
pci 0000:01:00.0: reg 0x20: initial BAR value 0x00000000 invalid
pci 0000:01:00.0: reg 0x20: [io  size 0x0010]
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
pci 0000:02:00.0: reg 0x10: initial BAR value 0x00000000 invalid
pci 0000:02:00.0: reg 0x10: [io  size 0x0008]
pci 0000:02:00.0: reg 0x14: initial BAR value 0x00000000 invalid
pci 0000:02:00.0: reg 0x14: [io  size 0x0004]
pci 0000:02:00.0: reg 0x18: initial BAR value 0x00000000 invalid
pci 0000:02:00.0: reg 0x18: [io  size 0x0008]
pci 0000:02:00.0: reg 0x1c: initial BAR value 0x00000000 invalid
pci 0000:02:00.0: reg 0x1c: [io  size 0x0004]
pci 0000:02:00.0: reg 0x20: initial BAR value 0x00000000 invalid
pci 0000:02:00.0: reg 0x20: [io  size 0x0010]
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
pci 0000:03:00.0: reg 0x10: initial BAR value 0x00000000 invalid
pci 0000:03:00.0: reg 0x10: [io  size 0x0008]
pci 0000:03:00.0: reg 0x14: initial BAR value 0x00000000 invalid
pci 0000:03:00.0: reg 0x14: [io  size 0x0004]
pci 0000:03:00.0: reg 0x18: initial BAR value 0x00000000 invalid
pci 0000:03:00.0: reg 0x18: [io  size 0x0008]
pci 0000:03:00.0: reg 0x1c: initial BAR value 0x00000000 invalid
pci 0000:03:00.0: reg 0x1c: [io  size 0x0004]
pci 0000:03:00.0: reg 0x20: initial BAR value 0x00000000 invalid
pci 0000:03:00.0: reg 0x20: [io  size 0x0010]
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

This other one (correct behaviour AFAICS) is what I get with this
patch series setting IO_SPACE_LIMIT and ifdef to avoid the remapping:

mt7621-pci 1e140000.pcie:       IO 0x001e160000..0x001e16ffff -> 0x001e160000
OF: IO START returned by pci_address_to_pio: 0x1e160000-0x1e16ffff
mt7621-pci 1e140000.pcie: PCIE0 enabled
mt7621-pci 1e140000.pcie: PCIE1 enabled
mt7621-pci 1e140000.pcie: PCIE2 enabled
mt7621-pci 1e140000.pcie: PCI coherence region base: 0x60000000,
mask/settings: 0xf0000002
mt7621-pci 1e140000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: root bus resource [mem 0x60000000-0x6fffffff]
pci_bus 0000:00: root bus resource [io  0x1e160000-0x1e16ffff]
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
pci 0000:00:00.0: BAR 7: assigned [io  0x1e160000-0x1e160fff]
pci 0000:00:01.0: BAR 7: assigned [io  0x1e161000-0x1e161fff]
pci 0000:00:02.0: BAR 7: assigned [io  0x1e162000-0x1e162fff]
pci 0000:01:00.0: BAR 5: assigned [mem 0x60000000-0x600001ff]
pci 0000:01:00.0: BAR 4: assigned [io  0x1e160000-0x1e16000f]
pci 0000:01:00.0: BAR 0: assigned [io  0x1e160010-0x1e160017]
pci 0000:01:00.0: BAR 2: assigned [io  0x1e160018-0x1e16001f]
pci 0000:01:00.0: BAR 1: assigned [io  0x1e160020-0x1e160023]
pci 0000:01:00.0: BAR 3: assigned [io  0x1e160024-0x1e160027]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [io  0x1e160000-0x1e160fff]
pci 0000:00:00.0:   bridge window [mem 0x60000000-0x600fffff]
pci 0000:00:00.0:   bridge window [mem 0x60100000-0x601fffff pref]
pci 0000:02:00.0: BAR 5: assigned [mem 0x60200000-0x602001ff]
pci 0000:02:00.0: BAR 4: assigned [io  0x1e161000-0x1e16100f]
pci 0000:02:00.0: BAR 0: assigned [io  0x1e161010-0x1e161017]
pci 0000:02:00.0: BAR 2: assigned [io  0x1e161018-0x1e16101f]
pci 0000:02:00.0: BAR 1: assigned [io  0x1e161020-0x1e161023]
pci 0000:02:00.0: BAR 3: assigned [io  0x1e161024-0x1e161027]
pci 0000:00:01.0: PCI bridge to [bus 02]
pci 0000:00:01.0:   bridge window [io  0x1e161000-0x1e161fff]
pci 0000:00:01.0:   bridge window [mem 0x60200000-0x602fffff]
pci 0000:00:01.0:   bridge window [mem 0x60300000-0x603fffff pref]
pci 0000:03:00.0: BAR 5: assigned [mem 0x60400000-0x604001ff]
pci 0000:03:00.0: BAR 4: assigned [io  0x1e162000-0x1e16200f]
pci 0000:03:00.0: BAR 0: assigned [io  0x1e162010-0x1e162017]
pci 0000:03:00.0: BAR 2: assigned [io  0x1e162018-0x1e16201f]
pci 0000:03:00.0: BAR 1: assigned [io  0x1e162020-0x1e162023]
pci 0000:03:00.0: BAR 3: assigned [io  0x1e162024-0x1e162027]
pci 0000:00:02.0: PCI bridge to [bus 03]
pci 0000:00:02.0:   bridge window [io  0x1e162000-0x1e162fff]
pci 0000:00:02.0:   bridge window [mem 0x60400000-0x604fffff]
pci 0000:00:02.0:   bridge window [mem 0x60500000-0x605fffff pref]

>
> > > > > pci_remap_iospace() was originally meant as an architecture
> > > > > specific helper, but it moved into generic code after all architectures
> > > > > had the same requirements. If MIPS has different requirements,
> > > > > then it should not be shared.
> > > >
> > > > I see. So, if it can not be shared, would defining 'pci_remap_iospace'
> > > > as 'weak' acceptable? Doing in this way I guess I can redefine the
> > > > symbol for mips to have the same I currently have but without the
> > > > ifdef in the core APIs...
> > >
> > > I would hope to kill off the __weak functions, and prefer using an #ifdef
> > > around the generic implementation. One way to do it is to define
> > > a macro with the same name, such as
> > >
> > > #define pci_remap_iospace pci_remap_iospace
> >
> > I guess this should be defined in arch/mips/include/asm/pci.h?
>
> Yes, that would be a good place for that, possibly next to
> the (static inline) definition.
>
> > > and then use #ifdef around the C function to see if that's already defined.

I don't know if I am following you properly... you mean to define:

diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 6f48649201c5..9a8ca258c68b 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -20,6 +20,12 @@
 #include <linux/list.h>
 #include <linux/of.h>

+#define pci_remap_iospace pci_remap_iospace
+static inline int pci_remap_iospace(const struct resource *res,
phys_addr_t phys_addr)
+{
+       return 0;
+}

And then in the PCI core code do something like this?

--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4044,6 +4044,8 @@ unsigned long __weak
pci_address_to_pio(phys_addr_t address)
  * architectures that have memory mapped IO functions defined (and the
  * PCI_IOBASE value defined) should call this function.
  */
+#ifndef pci_remap_iospace
+#define pci_remap_iospace pci_remap_iospace
 int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 {
 #if defined(PCI_IOBASE) && defined(CONFIG_MMU)
@@ -4067,6 +4069,7 @@ int pci_remap_iospace(const struct resource
*res, phys_addr_t phys_addr)
 #endif
 }
 EXPORT_SYMBOL(pci_remap_iospace);
+#endif

But since this 'pci_remap_iospace' is already defined in
'include/linux/pci.h' and is not static at all the compiler complains
about doing such a thing. What am I missing here?

> >
> > I see. That would work, I guess. But I don't really understand why
> > this approach would be better than this patch changes itself. Looks
> > more hacky to me. As Bjorn pointed out in a previous version of this
> > patch [0], this case is the same as the one in
> > 'acpi_pci_root_remap_iospace' and the same approach is used there...
>
> The acpi_pci_root_remap_iospace() does this because on that code is
> shared with x86 and ia64, where the port numbers are accessed using
> separate instructions that do not translate into MMIO addresses at all.
>
> On MIPS, the port access eventually does translate into MMIO, and
> you need a way to communicate the mapping between the host
> bridge and the architecture specific code.

Thanks for the explanation.

>
> This is particularly important since we want the host bridge driver
> to be portable. If you set up the mapping differently between e.g.
> mt7621 and mt7623, they are not able to use the same driver
> code for setting pci_host_bridge->io_offset and for programming
> the inbound translation registers.

mt7621 is only mips, mt7623 is arm based SoC. They cannot use the same
driver at all. mt7620 or mt7628 which have drivers which are in
'arch/mips/pci' using legacy pci code would use and would be tried to
be ported to share the driver with mt7621 but those are also only mips
and the I/O addresses for all of them are similar and have I/O higher
than 0xffff as mt7621 has.

>
> > > I only see one host bridge here though, and it has a single
> > > I/O port range, so maybe all three ports are inside of
> > > a single PCI domain?
> >
> > See this cover letter [1] with a fantastic ascii art :) to a better
> > understanding of this pci topology. Yes, there is one host bridge and
> > from here three virtual bridges where at most three endpoints can be
> > connected.
>
> Ok, so you don't have the problem I was referring to. A lot of
> SoCs actually have multiple host bridges, but only one root
> port per host bridge, because they are based on licensed IP
> blocks that don't support a normal topology like the one you have.
>
> > > Having high numbers for the I/O ports is definitely a
> > > problem as I mentioned. Anything that tries to access
> > > PC-style legacy devices on the low port numbers
> > > will now directly go on the bus accessing MMIO
> > > registers that it shouldn't, either causing a CPU exception
> > > or (worse) undefined behavior from random register
> > > accesses.
> >
> > All I/O port addresses for ralink SoCs are in higher addresses than
> > default IO_SPACE_LIMIT 0xFFFF, that's why we have to also change this
> > limit together with this patch changes. Nothing to do with this, is an
> > architectural thing of these SoCs.
>
> I don't understand. What I see above is that the host bridge
> has the region 1e160000-1e16ffff registered, so presumably
> 1e160000 is actually the start of the window into the host bridge.
> If you set PCI_IOBASE to that location, the highest port number
> would become 0x2027, which is under 0xffff.

But 0x1e160000 is defined in the device tree as the I/O start address
of the range and should not be hardcoded anywhere else since other
ralink platforms don't use this address as PCI_IOBASE. And yes, 0x2027
is the highest port number I get if I initially define PCI_IOBASE also
as KSEG1 since at the end is the entry point for I/O in mips (see
trace above).

Thanks very much for your time and feedback.

Best regards,
     Sergio Paracuellos
>
>        Arnd
