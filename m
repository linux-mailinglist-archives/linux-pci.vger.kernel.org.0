Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21169373EFE
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 17:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhEEPyR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 11:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229797AbhEEPyR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 11:54:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D0D36102A;
        Wed,  5 May 2021 15:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620230000;
        bh=1IqzisQrKCry3zuhlGVA9DAmUDQ6Lmyb/6eDqrrSd5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dx4Vx3IS7EQcYaI8hG4qSa186pMuWLX3Zz+TG0xQGg+LusDjgZX4XbZFoucHcH6NW
         /c9qZlJdrYfBnLVLOpkSHXENA7+mGKZrB9BEXTMfY8/n9pLgfuJBIApNulxwvN2aOr
         JR1X0dcND9r4Pja/BEeQ8ETM6ONpPq3jF1ZHr0X0=
Date:   Wed, 5 May 2021 17:53:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: `quirk_usb_handoff_xhci` takes 60 ms with ASM1042
Message-ID: <YJK/bkJpCC+INPo3@kroah.com>
References: <YJKQPJU/KhRx8vuy@kroah.com>
 <20210505154741.GA1304534@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210505154741.GA1304534@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 05, 2021 at 10:47:41AM -0500, Bjorn Helgaas wrote:
> On Wed, May 05, 2021 at 02:31:56PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, May 05, 2021 at 02:15:26PM +0200, Paul Menzel wrote:
> > > Am 05.05.21 um 10:33 schrieb Greg Kroah-Hartman:
> > > > On Wed, May 05, 2021 at 10:27:52AM +0200, Paul Menzel wrote:
> > > > > Am 05.05.21 um 10:11 schrieb Greg Kroah-Hartman:
> 
> > > > > > If the driver is built as a module, there should not be any "hot
> > > > > > path" here as the module is loaded async when the device is
> > > > > > discovered, right?
> > > > >      obj-$(CONFIG_USB_PCI)   += pci-quirks.o
> > > > > 
> > > > > So all quirks are run independently of the USB “variant”
> > > > > (UHCI, OHCI, EHCI, xHCI).
> > > > > 
> > > > > Indeed, this driver is built into the Linux kernel.
> > > > > 
> > > > >      $ grep USB_PCI .config
> > > > >      CONFIG_USB_PCI=y
> > > > > 
> > > > > So, should `pci-quirks.c` be split up to have more fine
> > > > > grained control?
> > > > 
> > > > What control do you need here?
> > > 
> > > Good question, as I do not know the USB spec. I’d say, disabling certain
> > > quirks, or just run them, when the actual driver is loaded.
> > 
> > This is not a "quirk", it is part of how USB works.
> 
> I agree, this doesn't look like a "quirk" in the sense of working
> around a hardware defect; the handoff is just a normal part of
> operating the device.  But can you elaborate on why it must be done
> this way?
> 
> I'm looking at the xHCI r1.2 spec, sec 4.22.1.  It talks about the
> handoff synchronization process and says the OS driver shall use the
> defined protocol to request ownership before it uses the device.  But
> AFAICT there's no specific "early-startup" requirement.
> 
> quirk_usb_handoff_xhci() is in drivers/usb/host/pci-quirks.c, which is
> always built statically and the quirk runs during device enumeration,
> even if the xhcd driver itself is a module.  It looks like we run the
> quirk even if we never load the xhcd driver.
> 
> Why can't we just do the handoff in the xhcd driver probe?

I think, if we don't do the handoff, then the BIOS/firmware tries to
send the OS fake keyboard/mouse commands, and Linux isn't ready for that
as we didn't allow hotplug PS/2 stuff.  But I could be wrong, it's been
a long time since we did that logic.

Someone could try to change this and see :)

> > > > Try changing your BIOS settings to not have "legacy" USB support
> > > > in it, that could cause this transition to go faster, at the
> > > > expense of not being able to use a USB device before Linux
> > > > boots.
> > > 
> > > The firmware of the Asus F2A85-M PRO allows to disable *legacy*
> > > USB support for only the ASMedia ASM1042. And, thank you for the
> > > suggestion, it helped.  `quirk_usb_early_handoff()` does not show
> > > up in the logs now, meaning it’s below 50 ms. And it is well
> > > below: less than one millisecond.
> > > 
> > >     [    0.308343] pci 0000:00:15.1: PCI->APIC IRQ transform: INT A -> IRQ
> > > 16
> > >     [    0.308359] pci 0000:03:00.0: PCI->APIC IRQ transform: INT A -> IRQ
> > > 17
> > >     [    0.308376] pci 0000:03:00.0: hc_init reached
> > >     [    0.308380] pci 0000:03:00.0: second handshake done
> > >     [    0.308384] pci 0000:03:00.0: third handshake done
> > >     [    0.308395] PCI: CLS 64 bytes, default 64
> > >     […]
> > >     [    0.401722] Run /lib/systemd/systemd as init process
> > 
> > Nice!
> > 
> > Go blame your bios vendor now :)
> 
> So the answer is "to make Linux boot faster, flip this BIOS switch
> which means your USB devices no longer work while in BIOS"?
> 
> I can see why this helps (BIOS never claims the xHCI, so OS can
> immediately claim ownership), but it seems like a sub-optimal user
> experience.

Welcome to UEFI :)

thanks,

greg k-h
