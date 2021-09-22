Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2043E415200
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 22:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbhIVU45 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 16:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237795AbhIVU4s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Sep 2021 16:56:48 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518ECC061768;
        Wed, 22 Sep 2021 13:55:16 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id 2so2634431uav.1;
        Wed, 22 Sep 2021 13:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+BgGcO6gFQXcEbp81W0SITnzPCJRTfQCooICPiiqUQE=;
        b=TykkEhnHLuHqCUjgNo7m/K/2WUALhSo3dJVfrXWO4Yp+cJajkCzcQMdGv7/YjInJz5
         OH7sV3qcejnEBqefgWXW0QRrVp1hzat3YGOXajYYK8AKthAF710rN1Yz99fyhpXakpMn
         4JGpQYN0pYxZumOC3Wv8Ybts/lDDUaDas5HtfTD3CTM1loZEY15gj7Fb8F+oce3FnsU3
         +SJNQFd7/NxDfts98XLT+82+C95USroJC0rtgn9CIH8fVQF1MJm/2xPFNzUXqKeGTHS5
         71F6hBcorVOh9LK3+k7+ELoZTA+2zSDIlHe7XV6K/62rliRBtvEW6z5VMnAUYOvr6g89
         jrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+BgGcO6gFQXcEbp81W0SITnzPCJRTfQCooICPiiqUQE=;
        b=6saq3g4z4kCugxQZy+TqekLcrObgWAWIXi+myM8uuoJxBnZxe4ytC8kElTR31K28m5
         Uae/AZaINR9yEyxQ///UCixvEG4Q+fSMLKhe/P2egUrZ4uPU/PxiTU0pCl6I3qFWSQc+
         mP8SEenseqQTyuGcBLmkZDQi3EunS2oqzKKgKUPccjUPzyBi8/1AE/U9zNPPGD5QRqGX
         JBnRL18e6BGvSCCAMNJWpW175FIViZ0VLRGVVuoS93oW8DFrWWgp2rYgyxa6Vx9On9lq
         s9mVdKpxgiDb6mKTlIQNzGfSahM9meUDmlZ7eQVv97hfki6Ikh4xbyucr3/sM0c8E6sm
         RrEw==
X-Gm-Message-State: AOAM531z3jF+nk4c2yvdD4xyDnnjsMobUBKoJeCItF5QUMD009XuIy96
        FIdgKkf7vGMeQZzFf5m3mgHwkd+b+Lsamk0jDjzbnbCZXnE=
X-Google-Smtp-Source: ABdhPJxDcGQqN9GCuF5eoxTUNHLefZk5THF4K0AQCUiQ8kbVHEpZo6V88ftTRy/PDIxFAtSe/B0Z7N9xXDHao2bE/zs=
X-Received: by 2002:ab0:54d2:: with SMTP id q18mr1634240uaa.46.1632344115448;
 Wed, 22 Sep 2021 13:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210922042041.16326-1-sergio.paracuellos@gmail.com>
 <CAK8P3a2WPOYS7ra_epyZ_bBBpPK8+AgEynK0pKOUZ6ajubcHew@mail.gmail.com>
 <CAMhs-H8EyBmahhLsx+a0aoy+znY=PCm4BT97UBg4xcAy3x2oXg@mail.gmail.com>
 <CAK8P3a0fQZvpNCKF7OUy_krC_YPyigtd5Ak_AMXXpx84HKMswA@mail.gmail.com>
 <CAMhs-H-OCm1p6mTTV6s=vPx7FV8+1UMzx0X00wvXkW=5OgFQBQ@mail.gmail.com> <CAK8P3a1iN76A5ahTTQ6rCS4LjKHz8grkNGHGehLJnd0xQSnHXA@mail.gmail.com>
In-Reply-To: <CAK8P3a1iN76A5ahTTQ6rCS4LjKHz8grkNGHGehLJnd0xQSnHXA@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 22 Sep 2021 22:55:03 +0200
Message-ID: <CAMhs-H_hZk3hruCaWRjKjUSj6vhVE+JZfk9nT7v1=mcc-H9wnw@mail.gmail.com>
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

On Wed, Sep 22, 2021 at 9:57 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Sep 22, 2021 at 8:40 PM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> > On Wed, Sep 22, 2021 at 8:07 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Wed, Sep 22, 2021 at 7:42 PM Sergio Paracuellos
> > > Ok, thank you for the detailed explanation.
> > >
> > > I suppose you can use the generic infrastructure in asm-generic/io.h
> > > if you "#define PCI_IOBASE mips_io_port_base". In this case, you
> > > should have an architecture specific implementation of
> > > pci_remap_iospace() that assigns mips_io_port_base.
> >
> > No, that is what I tried originally defining PCI_IOBASE as
> > _AC(0xa0000000, UL) [0] which is the same as KSEG1 [1] that ends in
> > 'mips_io_port_base'.
>
> Defining it as KSEG1 would be problematic because that means that
> the Linux-visible port numbers are offset from the bus-visible ones.
>
> You really want PCI_IOBASE to point to the address of port 0.

Do you mean that doing

#define PCI_IOBASE mips_io_port_base

would have different result that doing what I did

#define PCI_IOBASE _AC(0xa0000000, UL)

?

I am not really understanding this yet (I think I need a bit of sleep
time :)), but I will test this tomorrow and come back to you again
with results.

>
> > > pci_remap_iospace() was originally meant as an architecture
> > > specific helper, but it moved into generic code after all architectures
> > > had the same requirements. If MIPS has different requirements,
> > > then it should not be shared.
> >
> > I see. So, if it can not be shared, would defining 'pci_remap_iospace'
> > as 'weak' acceptable? Doing in this way I guess I can redefine the
> > symbol for mips to have the same I currently have but without the
> > ifdef in the core APIs...
>
> I would hope to kill off the __weak functions, and prefer using an #ifdef
> around the generic implementation. One way to do it is to define
> a macro with the same name, such as
>
> #define pci_remap_iospace pci_remap_iospace

I guess this should be defined in arch/mips/include/asm/pci.h?

>
> and then use #ifdef around the C function to see if that's already defined.

I see. That would work, I guess. But I don't really understand why
this approach would be better than this patch changes itself. Looks
more hacky to me. As Bjorn pointed out in a previous version of this
patch [0], this case is the same as the one in
'acpi_pci_root_remap_iospace' and the same approach is used there...

>
> > >
> > > I don't yet understand how you deal with having multiple PCIe
> > > host bridge devices if they have distinct I/O port ranges.
> > > Without remapping to dynamic virtual addresses, does
> > > that mean that every MMIO register between the first and
> > > last PCIe bridge also shows up in /dev/ioport? Or do you
> > > only support port I/O on the first PCIe host bridge?
> >
> > For example, this board is using all available three pci ports [2] and I get:
> >
> > root@gnubee:~# cat /proc/ioports
> > 1e160000-1e16ffff : pcie@1e140000
> >   1e160000-1e160fff : PCI Bus 0000:01
> >     1e160000-1e16000f : 0000:01:00.0
> >       1e160000-1e16000f : ahci
> >     1e160010-1e160017 : 0000:01:00.0
> >       1e160010-1e160017 : ahci
> >     1e160018-1e16001f : 0000:01:00.0
> >       1e160018-1e16001f : ahci
> >     1e160020-1e160023 : 0000:01:00.0
> >       1e160020-1e160023 : ahci
> >     1e160024-1e160027 : 0000:01:00.0
> >       1e160024-1e160027 : ahci
> >   1e161000-1e161fff : PCI Bus 0000:02
> >     1e161000-1e16100f : 0000:02:00.0
> >       1e161000-1e16100f : ahci
> >     1e161010-1e161017 : 0000:02:00.0
> >       1e161010-1e161017 : ahci
> >     1e161018-1e16101f : 0000:02:00.0
> >       1e161018-1e16101f : ahci
> >     1e161020-1e161023 : 0000:02:00.0
> >       1e161020-1e161023 : ahci
> >     1e161024-1e161027 : 0000:02:00.0
> >       1e161024-1e161027 : ahci
> >   1e162000-1e162fff : PCI Bus 0000:03
> >     1e162000-1e16200f : 0000:03:00.0
> >       1e162000-1e16200f : ahci
> >     1e162010-1e162017 : 0000:03:00.0
> >       1e162010-1e162017 : ahci
> >     1e162018-1e16201f : 0000:03:00.0
> >       1e162018-1e16201f : ahci
> >     1e162020-1e162023 : 0000:03:00.0
> >       1e162020-1e162023 : ahci
> >     1e162024-1e162027 : 0000:03:00.0
> >       1e162024-1e162027 : ahci
>
> Ah ok, so there are I/O ports that are at least
> visible (may or may not be accessed by the driver).

Yes, all of them are enumerated on boot and exposed in /proc/ioports.

>
> I only see one host bridge here though, and it has a single
> I/O port range, so maybe all three ports are inside of
> a single PCI domain?

See this cover letter [1] with a fantastic ascii art :) to a better
understanding of this pci topology. Yes, there is one host bridge and
from here three virtual bridges where at most three endpoints can be
connected.

>
> Having high numbers for the I/O ports is definitely a
> problem as I mentioned. Anything that tries to access
> PC-style legacy devices on the low port numbers
> will now directly go on the bus accessing MMIO
> registers that it shouldn't, either causing a CPU exception
> or (worse) undefined behavior from random register
> accesses.

All I/O port addresses for ralink SoCs are in higher addresses than
default IO_SPACE_LIMIT 0xFFFF, that's why we have to also change this
limit together with this patch changes. Nothing to do with this, is an
architectural thing of these SoCs.

Best regards,
     Sergio Paracuellos
>
>        Arnd

[0]: https://lore.kernel.org/linux-staging/CAMhs-H-OJyXs+QViJa5_O3wUGhoupmaW4qvVG8WGjxm1haRj9Q@mail.gmail.com/T/#m9e8e8d3afca908d1e1c57539d5e03dd9f5efd850
[1]: https://www.spinics.net/lists/kernel/msg4085596.html
