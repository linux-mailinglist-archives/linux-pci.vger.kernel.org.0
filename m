Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE42373B40
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 14:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhEEMcz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 08:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229559AbhEEMcz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 08:32:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B634610FB;
        Wed,  5 May 2021 12:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620217918;
        bh=MsKWp9ccIDAze8CTabZk6cwbBtX/0svkF43a6fD/xxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tl7HpkeHo9w1Gil2726rR8B/+ODT1Hje8Kc/XovDi0HQuK+Uk6TM5z7QKcIB8lJXJ
         Q2O+iAquRENVN6+TjxzNhbXzqaW0rD9++tWmQEYCMHaz2uaLzHG9XBKeTLQrb1sknX
         5Lo4pCXCHlF1/gn2YDTK9CrPlDPpwHlqwqMCYnpY=
Date:   Wed, 5 May 2021 14:31:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: `quirk_usb_handoff_xhci` takes 60 ms with ASM1042
Message-ID: <YJKQPJU/KhRx8vuy@kroah.com>
References: <eed7681d-2bbf-b3a5-4ee3-729b614545bf@molgen.mpg.de>
 <YJJTQzJS/8Loz8kV@kroah.com>
 <e4d36cdd-3998-3ed3-76d9-56541d89a182@molgen.mpg.de>
 <YJJYdAJvrD3mVeAd@kroah.com>
 <3a5d53db-040a-6806-1d6d-d85ef4ecba54@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a5d53db-040a-6806-1d6d-d85ef4ecba54@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 05, 2021 at 02:15:26PM +0200, Paul Menzel wrote:
> Dear Greg,
> 
> 
> Am 05.05.21 um 10:33 schrieb Greg Kroah-Hartman:
> > On Wed, May 05, 2021 at 10:27:52AM +0200, Paul Menzel wrote:
> 
> > > Am 05.05.21 um 10:11 schrieb Greg Kroah-Hartman:
> > > > On Wed, May 05, 2021 at 09:57:44AM +0200, Paul Menzel wrote:
> > > 
> > > > > On an Asus F2A85-M PRO, BIOS 6601 11/25/2014, with an ASM1042 SuperSpeed USB
> > > > > Host Controller [1b21:1042], and the xHCI drivers built as modules
> > > > > 
> > > > >       CONFIG_USB_XHCI_PCI=m
> > > > >       CONFIG_USB_XHCI_HCD=m
> > > > > 
> > > > > `quirk_usb_handoff_xhci` takes 60 ms, which is 15 % of the time to reaching
> > > > > `run_init_process()`. I addded some prints, showing the f
> > > > > 
> > > > >       [    0.308841] pci 0000:03:00.0: PCI->APIC IRQ transform: INT A -> IRQ 17
> > > > >       [    0.369858] pci 0000:03:00.0: handshake done with timeout = 0
> > > > >       [    0.369862] pci 0000:03:00.0: hc_init reached
> > > > >       [    0.369865] pci 0000:03:00.0: second handshake done
> > > > >       [    0.369869] pci 0000:03:00.0: third handshake done
> > > > >       [    0.369909] pci 0000:03:00.0: quirk_usb_early_handoff+0x0/0x670 took 59661 usecs
> > > > >       […]
> > > > >       [    0.415223] Run /lib/systemd/systemd as init process
> > > > > 
> > > > > Is there a way to optimize this, or move it out “the hot path”?
> > > > 
> > > > That's the hardware taking so long, all that function does is make some
> > > > PCI calls to the device.
> > > 
> > > In your experience, do most devices take that long?
> > 
> > No idea, it all depends on the device.  And is 60ms really that long to
> > initialize the USB controller?
> 
> For the goal of “instant” startup, I’d say yes.
> 
> I also guess, this is all the ASMedia ASM1042 firmware taking so long,
> right?

Probably, yes.  And you proved that below....

> > That's a complex beast.
> 
> I miss the PS/2 controller, which seemed to be simpler for *input* devices
> like keyboard and mouse. (No idea regarding power usage even.)

The PS/2 controller was horrible, even for keyboard and mice.  Many
motherboards and devices were blown up by hot-plugging them.

There's a reason we all came up with USB back in the day, please don't
make us go back to that mess...

> > > > If the driver is built as a module, there should not be any "hot
> > > > path" here as the module is loaded async when the device is
> > > > discovered, right?
> > >      obj-$(CONFIG_USB_PCI)   += pci-quirks.o
> > > 
> > > So all quirks are run independently of the USB “variant” (UHCI, OHCI, EHCI,
> > > xHCI).
> > > 
> > > Indeed, this driver is built into the Linux kernel.
> > > 
> > >      $ grep USB_PCI .config
> > >      CONFIG_USB_PCI=y
> > > 
> > > So, should `pci-quirks.c` be split up to have more fine grained control?
> > 
> > What control do you need here?
> 
> Good question, as I do not know the USB spec. I’d say, disabling certain
> quirks, or just run them, when the actual driver is loaded.

This is not a "quirk", it is part of how USB works.

> > And yeah, I see, but this code has to be run at early-startup to match
> > the USB spec requirements for handing off the USB control from the
> > BIOS/firmware/whatever, to the kernel.
> 
> That makes the second option above a moot point.
> 
> > Try changing your BIOS settings to not have "legacy" USB support in it,
> > that could cause this transition to go faster, at the expense of not
> > being able to use a USB device before Linux boots.
> 
> The firmware of the Asus F2A85-M PRO allows to disable *legacy* USB support
> for only the ASMedia ASM1042. And, thank you for the suggestion, it helped.
> `quirk_usb_early_handoff()` does not show up in the logs now, meaning it’s
> below 50 ms. And it is well below: less than one millisecond.
> 
>     [    0.308343] pci 0000:00:15.1: PCI->APIC IRQ transform: INT A -> IRQ
> 16
>     [    0.308359] pci 0000:03:00.0: PCI->APIC IRQ transform: INT A -> IRQ
> 17
>     [    0.308376] pci 0000:03:00.0: hc_init reached
>     [    0.308380] pci 0000:03:00.0: second handshake done
>     [    0.308384] pci 0000:03:00.0: third handshake done
>     [    0.308395] PCI: CLS 64 bytes, default 64
>     […]
>     [    0.401722] Run /lib/systemd/systemd as init process

Nice!

Go blame your bios vendor now :)

But realize just what is happening here, the hand-off of the USB
hardware from one "owner" to another is not a trivial operation.

Gotta love solutions that don't touch the kernel, thanks for following
up and letting us know.

greg k-h
