Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9313C373651
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 10:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhEEIe4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 04:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231637AbhEEIez (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 04:34:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 167A16112F;
        Wed,  5 May 2021 08:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620203638;
        bh=T7WhWpBDSvK2RonC3VBugnps8qdhujaF26UAPEuaQ20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vKfo4nIjOv4yx7NDIfQ+6i0iJu97Ctoob9rdboCpQUEaL3NIEQvIV3rPO0227+U48
         7kiHMweWBw9DYcNAmJm3gHjFcwUFIjDWx/tpL8iuUanD1bm+paX0kjmO6diNHOorLL
         H8/9QFJkpoRWXX4iN76x4JxBRw1YXevlzypKAqgg=
Date:   Wed, 5 May 2021 10:33:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: `quirk_usb_handoff_xhci` takes 60 ms with ASM1042
Message-ID: <YJJYdAJvrD3mVeAd@kroah.com>
References: <eed7681d-2bbf-b3a5-4ee3-729b614545bf@molgen.mpg.de>
 <YJJTQzJS/8Loz8kV@kroah.com>
 <e4d36cdd-3998-3ed3-76d9-56541d89a182@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4d36cdd-3998-3ed3-76d9-56541d89a182@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 05, 2021 at 10:27:52AM +0200, Paul Menzel wrote:
> Dear Greg,
> 
> 
> Thank you for the quick reply.
> 
> Am 05.05.21 um 10:11 schrieb Greg Kroah-Hartman:
> > On Wed, May 05, 2021 at 09:57:44AM +0200, Paul Menzel wrote:
> 
> > > On an Asus F2A85-M PRO, BIOS 6601 11/25/2014, with an ASM1042 SuperSpeed USB
> > > Host Controller [1b21:1042], and the xHCI drivers built as modules
> > > 
> > >      CONFIG_USB_XHCI_PCI=m
> > >      CONFIG_USB_XHCI_HCD=m
> > > 
> > > `quirk_usb_handoff_xhci` takes 60 ms, which is 15 % of the time to reaching
> > > `run_init_process()`. I addded some prints, showing the f
> > > 
> > >      [    0.308841] pci 0000:03:00.0: PCI->APIC IRQ transform: INT A -> IRQ 17
> > >      [    0.369858] pci 0000:03:00.0: handshake done with timeout = 0
> > >      [    0.369862] pci 0000:03:00.0: hc_init reached
> > >      [    0.369865] pci 0000:03:00.0: second handshake done
> > >      [    0.369869] pci 0000:03:00.0: third handshake done
> > >      [    0.369909] pci 0000:03:00.0: quirk_usb_early_handoff+0x0/0x670 took 59661 usecs
> > >      […]
> > >      [    0.415223] Run /lib/systemd/systemd as init process
> > > 
> > > Is there a way to optimize this, or move it out “the hot path”?
> > 
> > That's the hardware taking so long, all that function does is make some
> > PCI calls to the device.
> 
> In your experience, do most devices take that long?

No idea, it all depends on the device.  And is 60ms really that long to
initialize the USB controller?  That's a complex beast.

> > If the driver is built as a module, there should not be any "hot
> > path" here as the module is loaded async when the device is
> > discovered, right?
>     obj-$(CONFIG_USB_PCI)   += pci-quirks.o
> 
> So all quirks are run independently of the USB “variant” (UHCI, OHCI, EHCI,
> xHCI).
> 
> Indeed, this driver is built into the Linux kernel.
> 
>     $ grep USB_PCI .config
>     CONFIG_USB_PCI=y
> 
> So, should `pci-quirks.c` be split up to have more fine grained control?

What control do you need here?

And yeah, I see, but this code has to be run at early-startup to match
the USB spec requirements for handing off the USB control from the
BIOS/firmware/whatever, to the kernel.

Try changing your BIOS settings to not have "legacy" USB support in it,
that could cause this transition to go faster, at the expense of not
being able to use a USB device before Linux boots.

And is this really the slowest thing at startup for you that it is the
last thing that needs to be optimized?

> > What is waiting for this module to load in order to cause your init to
> > stall?  Perhaps fix your initramfs logic or build the driver into the
> > kernel itself to take it off of this "load all the modules and wait"
> > path?
> 
> Sorry, for causing some confusion. But as written above, this all happens
> before the initrd is involved.

No problem, I was confused as well :)

thanks,

greg k-h
