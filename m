Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6BF44FD82
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 04:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbhKODid (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Nov 2021 22:38:33 -0500
Received: from angie.orcam.me.uk ([78.133.224.34]:37536 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbhKODiU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Nov 2021 22:38:20 -0500
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 9098D92009D; Mon, 15 Nov 2021 04:35:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 8A59092009C;
        Mon, 15 Nov 2021 03:35:23 +0000 (GMT)
Date:   Mon, 15 Nov 2021 03:35:23 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
cc:     u-boot@lists.denx.de, linux-pci@vger.kernel.org,
        Stefan Roese <sr@denx.de>, Simon Glass <sjg@chromium.org>,
        Phil Sutter <phil@nwl.cc>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Tom Rini <trini@konsulko.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Subject: Re: [PATCH] pci: Work around PCIe link training failures
In-Reply-To: <20211114192853.dj7mcc7sxtwaj3of@pali>
Message-ID: <alpine.DEB.2.21.2111142118280.19625@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2111140303040.19625@angie.orcam.me.uk> <20211114154152.kmabs4k3gdrzlzke@pali> <alpine.DEB.2.21.2111141655120.19625@angie.orcam.me.uk> <20211114192853.dj7mcc7sxtwaj3of@pali>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,

> >  Well, this code checks for non-zero lnkcap2 first and ignores it if it's 
> > zero, so I believe it does the right thing.  Have I missed anything?
> 
> I'm reading spec again and I'm not sure now. It has following section:
> 
>   For software to determine the supported Link speeds for components
>   where the Link Capabilities 2 register is either not implemented, or
>   the value of its Supported Link Speeds Vector is 0000000b, software
>   can read bits 3:0 of the Link Capabilities register (now defined to be
>   the Max Link Speed field), and interpret the value as follows:
>     0001b 2.5 GT/s Link speed supported
>     0010b 5.0 GT/s and 2.5 GT/s Link speeds supported

 This is consistent with speeds defined with PCIe rev. 2.0, which is the 
last revision not to define the Link Capabilities 2 register.

> I'm not sure how it should be interpreted, but my assumption is that
> empty lnkcap2 implicates that only 5GT/s or 2.5GT/s speeds are supported
> and therefore trying higher should not be done...

 I can see no ambiguity here.

 The Link Capabilities register always defines the maximum speed supported 
and given that there is no speed masking defined for PCIe rev. 2.0 and 
below all speeds up to the maximum must be always supported with hardware 
compliant to these specification revisions.

 As from PCIe rev. 3.0 the Link Capabilities 2 register provides support 
for speed masking and therefore not all speeds below the maximum given by 
the Link Capabilities register must be supported with hardware compliant 
to this and higher specification revisions.

> Also in spec is following note:
> 
>   It is strongly encouraged that software primarily utilize the
>   Supported Link Speeds Vector instead of the Max Link Speed field.
> 
> So based on this note, iteration should be done via lnkcap2 bits instead
> of lnkcap speed.

 I believe my code does iterate over lnkcap2 bits already, because speed 
encodings that correspond to those lnkcap2 bits that are zero are skipped.

> >  It could be done in Linux in addition to U-Boot, although I think doing 
> > that in the firmware is more important, especially as there could be a 
> > boot device downstream such a switch.  And depending on the platform Linux 
> > does not always reassign buses, so a user intervention (i.e. an explicitly 
> > added kernel parameter) would have to be required.
> 
> It is important to have it in both components (U-Boot and Linux). For
> example native PCIe controller drivers in linux kernel as a first thing
> do complete reset of controller together with connected devices. So
> whatever do U-Boot is completely lost. And important is that Linux
> kernel drivers should not depend on some bootloader configuration. And
> note that your patch implements this workaround in CONFIG_PCI_PNP code,
> so if board disable this option, workaround is not applied.

 Well, everything is not Linux.  The lone Unmatched board can run at least 
FreeBSD or Haiku right now, and it is only one of the numerous machines 
supported by U-Boot.  A piece of code in Linux will not help other OSes.

 Also as I noted not all Linux platforms discard the firmware settings 
with PCI/e devices, let alone bring them to their power-on defaults; this 
certainly does not happen with the Unmatched or I couldn't have benefitted 
with this change of mine proposed or earlier hacks with poking at the 
relevant registers from the U-Boot command line.  So in my scenario this 
fix surely qualifies as good enough.  Interestingly Linux does notice the 
clamp imposed by my change with the offending link:

pci 0000:05:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x1 link at 0000:02:03.0 (capable of 8.000 Gb/s with 5.0 GT/s PCIe x2 link)

(the x1 vs x2 limitation is imposed by wiring one lane only in the Delock 
device in the first place; then I wired it to a single-lane M.2 connector 
of the Unmatched).

 That said I'm not opposed to porting this code to Linux, I have certainly 
contributed infinitely more code to Linux than I did to U-Boot.  It is 
just that my resources are limited, so I need to cautiously allocate them.  
I have other priorities, the Unmatched box is in my remote lab and I am 
only going to have physical access to it this week only.  The next 
opportunity may be next year at the earliest.  And I dare not reflashing 
U-Boot remotely so as not to lose access with a broken build because I 
need the machine for other purposes like GCC verification.

 So I'd rather focus on getting the change right for U-Boot now, while I 
am here.  If we agree on the way to move forward with this code, then I 
can look into porting this stuff to Linux, as I can surely add another 
kernel image to boot the system from remotely in a safe manner.

> >  And these are generic PCIe switches, they could be anywhere and with the 
> > weird combinations of hardware interfaces available now (e.g. PCI-PCIe 
> > bridge adapters or M.2 to regular PCIe slot adapters) virtually any 
> > combination is possible.
> > 
> >  E.g. I have a 1997-vintage dual Pentium MMX box (82439HX host bridge; 
> > [8086:1250]) with PCIe devices, although it does require a lot of Linux 
> > interventions to cope with its firmware limitations.  NB I plan to add 
> > some NVMe storage to that box, and I believe the ASM2824 has been used in 
> > some M.2 carrier boards meant for NVMe devices.
> 
> Hm... now thinking about your patch... and if it is general, applied to
> all devices, should it also be applied to any type of downstream port?
> 
> Meaning also for root ports, or PCIe port of PCI/X to PCIe bridge (I
> guess that such old platforms with only PCI host bridge without PCIe
> could be affected too if you connect PCIe card via PCI/X to PCIe bridge
> and then this bridge to host PCI slot).

 I guess so.  I considered root ports, but somehow it did not occur to me 
that they can be wired directly to slots (any sane manufacturer would get 
their onboard devices sorted), which of course they can.  I forgot about 
the PCI/PCI-X to PCI Express bridges though.  Thanks for the suggestion.

 As this is a trivial change to make I'll post an update, but I will wait 
till the end of the day or so so as to let people who do this stuff as a 
part of their dayjob have a chance to give feedback.

> >  As I noted ASMedia declined to comment, so it's hard to say if the cause 
> > has been nailed correctly and which devices if any, beyond [1b21:2824], 
> > are affected.
> 
> Yea, we do not know... And because we know that there is lot of broken
> HW which works with current version, we need to be very careful when
> introducing some workaround which is called on every hardware.
> 
> For example something similar like in your patch was implemented in
> Marvell SerDes U-Boot driver, which controls physical layer (so on place
> where nobody would expect touching higher layer code). Just this code
> did not touched retrain link bit... And so it could not have worked and
> was recently removed in patch series:
> https://lore.kernel.org/u-boot/20210924205922.25432-1-marek.behun@nic.cz/

 Sure, which is why this change tries hard to be conservative and checks 
multiple conditions to make sure a link is in trouble before it pokes at 
it.  If you suspect that these checks may be insufficient, then I'm open 
to further suggestions.

 NB I forgot to mention in the change description and I can add it in v2 
that the rate of the speed oscillation/link training with the ASM2824 is 
34-35 times per second.  So it's quite a lengthy process.

> I'm not saying that I'm opposing this patch. Just I would like see how
> is this issue will be fixed in kernel as kernel general workaround would
> affect lot of more devices. And so solution accepted by kernel project
> should be perfectly fine also for smaller project like U-Boot.

 Well, as far as I'm concerned I'd propose a functional equivalent that 
has been merely mechanically adapted to Linux internal interfaces (though 
busy-looping for extended periods with interrupts disabled, which is what 
is needed here, may be problematic in Linux or indeed any OS, unlike with 
the firmware; maybe PCI enumeration is early enough for that not to matter 
in reality though).

 Again, thanks for your input.

  Maciej
