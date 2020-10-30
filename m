Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEB12A0221
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 11:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgJ3KIM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Oct 2020 06:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbgJ3KIM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Oct 2020 06:08:12 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 956032087E;
        Fri, 30 Oct 2020 10:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604052490;
        bh=G752tbtJqV8awnxoaKN7bqlWiohbrlW06ydWXTsgFyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QowPS5uTn2sZv1IQF00LbAq1ZnoLJmCVbaeEds5IdcGgrCvRiUImg5NuBiMsMbE6h
         GNuZq4O6iQyTKjmwffX6+lg6kUzJbFkvemxyD9lc6tVh4zmdnznSyXtKBq70eccPpD
         2rIreRuPGrVdxIHKPonOV7OEGNdwKZsydVLLg/SM=
Received: by pali.im (Postfix)
        id 0D49086D; Fri, 30 Oct 2020 11:08:07 +0100 (CET)
Date:   Fri, 30 Oct 2020 11:08:07 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marek Behun <marek.behun@nic.cz>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        vtolkm@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <20201030100807.74r3vp4kyw44kcwp@pali>
References: <871rhhmgkq.fsf@toke.dk>
 <20201029193022.GA476048@bjorn-Precision-5520>
 <20201029215853.6ccce4e0@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201029215853.6ccce4e0@nic.cz>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Thursday 29 October 2020 21:58:53 Marek Behun wrote:
> On Thu, 29 Oct 2020 14:30:22 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Thu, Oct 29, 2020 at 12:12:21PM +0100, Toke Høiland-Jørgensen wrote:
> > > Pali Rohár <pali@kernel.org> writes:  
> > 
> > > > I have been testing mainline kernel on Turris Omnia with two PCIe
> > > > default cards (WLE200 and WLE900) and it worked fine. But I do not know
> > > > if I had ASPM enabled or not.
> > > >
> > > > So it is working fine for you when CONFIG_PCIEASPM is disabled and whole
> > > > issue is only when CONFIG_PCIEASPM is enabled?  
> > > 
> > > Yup, exactly. And I'm also currently testing with the default WLE200/900
> > > cards... I just tried sticking an MT76-based WiFi card into the third
> > > PCI slot, and that doesn't come up either when I enable PCIEASPM.  
> > 
> > Huh.  So IIUC, the following cases all try to retrain the link and it
> > fails to come up again:
> > 
> >   - aardvark + WLE900VX (see commit 43fc679ced18)

Just to note: aardvark + WLE200 worked fine whatever I did. No
workaround and no patch was needed.

> >   - mvebu + WLE200
> >   - mvebu + WLE900
> >   - mvebu + MT76
> 
> Bjorn, IIRC Pali's patches fix the WLE900VX card for Aardvark (both in
> kernel and in U-Boot).
> IMO mvebu has similar issues. Both these drivers handle the PCIe reset
> signal incorrectly (or at least Aardvark did before Pali's work).
> 
> mvebu is used on Turris Omnia, and our HW guys first solved the WLE900VX
> not working issue by using different capacitors for the SerDeses (this
> was 5 years ago). But after Pali's work on Aardvark I think this could
> also be solved for mvebu driver in software.

Apparently not :-( See below, we cannot control PERST# pin from software
on Turris Omnia.

> BTW the WLE900VX card has problems on many systems, it won't work for
> example on Thinkpad X230. There is a bug on kernel bugzilla reported
> for this.

WLE900VX is really buggy card. During its initialization/reset
W_DISABLE# (pin 20) must be in correct state, otherwise system would
never see this card. This is reason why it does not work in laptops,
sometimes could help double reboot and playing with rfkill state prior
reboot. See reported issue:

https://bugzilla.kernel.org/show_bug.cgi?id=84821#c53

> My opinion is that many drivers do not respect the PCIe specification
> for reset and link training totally correctly (Pali was talking about
> this when he was looking at Aardvark) and that WLE900VX has a bug that
> in combination with those drivers causes the fail. If you look at the
> drivers, they are incompatible in how they handle the reset signal and
> link training.

Seems that aardvark or WLE900VX card (not only this one, but basically
every ath10k tested card, also non-Compex) have problems that when
booting Linux kernel they are in some totally strange state and whatever
I did I was not able to detect them and make link training success. The
only thing which helped was to issue card reset via out of band PERST#
signal.

And here is the main issue with PERST# signal on linux kernel. Basically
every driver issue card reset via PERST# signal for different amount of
time. Something which must be driver and card independent, probably
already documented in PCIe specification. See my email:

https://lore.kernel.org/linux-pci/20200424092546.25p3hdtkehohe3xw@pali/

I was trying to find that minimal reset timeout in specifications, but I
was not able to understand all those details and timeouts defined in
different diagrams. I'm not HW guy. See what was I able to find out:

https://lore.kernel.org/linux-pci/20200507212002.GA32182@bogus/

And my conclusion is here:

https://lore.kernel.org/linux-pci/20200513115940.fiemtnxfqcyqo6ik@pali/

So to finally fix issues with card reset we need somebody who understand
hardware documents and PCIe specifications and can figure out what is
the correct minimal value of delay needed for proper card reset via
PERST# signal. And then fix all PCI controller drivers to use this
value.

In aardvark we have timeout which was enough for my tested cards on
Espressobin and Turris MOX.


And second issue is with link training. What helped me to finally fix
link training for PCIe cards on A3720 with aardvark driver in both
U-Boot and Linux kernel was comment in following commit:

https://git.kernel.org/linus/f4c7d053d7f7

    As required by PCI Express spec a delay for at least 100ms after
    such a reset [fundamental reset by asserted PERST# signal] before
    link training is needed.

In aardvark control register I forcibly disabled link training bit prior
issuing reset via PERST# signal and then I re-enabled it 100ms after
reset was completed.

I have sent aardvark patch which update comment for above requirement:
https://lore.kernel.org/linux-pci/20200924084618.12442-1-pali@kernel.org/

> I am curious what Pali will tell us, he said that he will look into the
> mvebu driver.

If same problem with WLE900 cards is also on A38x SOC (with pci-mvebu
driver) then it would be hard to fix it on Turris Omnia.

On Turris MOX (with aardvark) PERST# pin from card is connected to some
MPP pin on A3720 SOC, which we can control via GPIO. In DTS we have
configured it as "reset-gpios" and therefore aardvark driver can
assert/deassert PERST# for card when needed.

On Turris Omnia (with pci-mvebu) PERST# pin from wifi card is connected
to MCU and it asserts/deasserts this pin only after board reset. Also it
is shared line across all mPCIe slots and also with other peripherals.

So we cannot issue reset via PERST# signal on Turris Omnia. But there
are other ways how to issue fundamental reset, via in band signaling.

But IIRC issuing fundamental reset via in band PCIe bus is done via PCIe
bridge to which is card connected. So second problem, we do not have
PCIe bridge on mvebu platforms, it is just emulated via kernel. Unless
there is some "special" register for issuing fundamental reset we would
not be able to emulate this reset.

Aardvark does not have PCIe bridge too, but in its internal registers
are bits for different types of reset. And when I was trying to use them
nothing happened, nothing helped. Only external reset via PERST# signal
was able to initialize card.

I will look into A38x PCI registers if there is not something which
could help us. But without access to PERST# pin I'm sceptical if we can
do something... Only just hoping that in PCIe ASPM retraining code is a
bug which can be fixed...
