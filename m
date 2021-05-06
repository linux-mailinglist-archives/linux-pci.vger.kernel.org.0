Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE54237567F
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbhEFPYA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235106AbhEFPYA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:24:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9138B6109E;
        Thu,  6 May 2021 15:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620314581;
        bh=sHUTIMTtTpmn2ESx6TFbTaV3tr4wosylb0jOG+PJJRQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E8PD+n0Kd1YVWT2QcItijE2+/6DqGrrlwiH8cFw6DDfcj6/r7d4we/ll8tSDWGzQJ
         tN2IrM1su4D0bWm+8svA8p9N+JbIQNLs/L7j+eKSWUPlbNr+cqc5f8FCNWPcMx6BWY
         Kt3yeqEvkdzZwTPJNk90R6ysRjX85GFmdw+MyRe4G/1SxF3l8AQPRDFB0oX21P0Vfa
         r0m8upXmUf1jcVVPOiSDaBX6US7bC6XwC2XtZaxVW3xh2AaTi0DtihS17xgc+mPuHD
         dEhKUDnZ5l7IUhwocSahM+1wQ/Kg7IeeCzoYaG8Hv2LztxmJOvm+Bo5jHhwK6f9N7P
         rsXQjsHDZcl8g==
Date:   Thu, 6 May 2021 10:23:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: `quirk_usb_handoff_xhci` takes 60 ms with ASM1042
Message-ID: <20210506152300.GA1405893@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YJK/bkJpCC+INPo3@kroah.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 05, 2021 at 05:53:18PM +0200, Greg Kroah-Hartman wrote:
> On Wed, May 05, 2021 at 10:47:41AM -0500, Bjorn Helgaas wrote:
> > On Wed, May 05, 2021 at 02:31:56PM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, May 05, 2021 at 02:15:26PM +0200, Paul Menzel wrote:
> > > > Am 05.05.21 um 10:33 schrieb Greg Kroah-Hartman:
> > > > > On Wed, May 05, 2021 at 10:27:52AM +0200, Paul Menzel wrote:
> > > > > > Am 05.05.21 um 10:11 schrieb Greg Kroah-Hartman:
> > 
> > > > > > > If the driver is built as a module, there should not be any "hot
> > > > > > > path" here as the module is loaded async when the device is
> > > > > > > discovered, right?
> > > > > >      obj-$(CONFIG_USB_PCI)   += pci-quirks.o
> > > > > > 
> > > > > > So all quirks are run independently of the USB “variant”
> > > > > > (UHCI, OHCI, EHCI, xHCI).
> > > > > > 
> > > > > > Indeed, this driver is built into the Linux kernel.
> > > > > > 
> > > > > >      $ grep USB_PCI .config
> > > > > >      CONFIG_USB_PCI=y
> > > > > > 
> > > > > > So, should `pci-quirks.c` be split up to have more fine
> > > > > > grained control?
> > > > > 
> > > > > What control do you need here?
> > > > 
> > > > Good question, as I do not know the USB spec. I’d say,
> > > > disabling certain quirks, or just run them, when the actual
> > > > driver is loaded.
> > > 
> > > This is not a "quirk", it is part of how USB works.
> > 
> > I agree, this doesn't look like a "quirk" in the sense of working
> > around a hardware defect; the handoff is just a normal part of
> > operating the device.  But can you elaborate on why it must be done
> > this way?
> > 
> > I'm looking at the xHCI r1.2 spec, sec 4.22.1.  It talks about the
> > handoff synchronization process and says the OS driver shall use the
> > defined protocol to request ownership before it uses the device.  But
> > AFAICT there's no specific "early-startup" requirement.
> > 
> > quirk_usb_handoff_xhci() is in drivers/usb/host/pci-quirks.c, which is
> > always built statically and the quirk runs during device enumeration,
> > even if the xhcd driver itself is a module.  It looks like we run the
> > quirk even if we never load the xhcd driver.
> > 
> > Why can't we just do the handoff in the xhcd driver probe?
> 
> I think, if we don't do the handoff, then the BIOS/firmware tries to
> send the OS fake keyboard/mouse commands, and Linux isn't ready for that
> as we didn't allow hotplug PS/2 stuff.  But I could be wrong, it's been
> a long time since we did that logic.

I have no idea what "BIOS/firmware sending OS fake keyboard/mouse
commands" means.  From the OS point of view, does that look like USB
events that cause PCI interrupts?  PS/2 interrupts?  Are these
commands caused by the user typing or moving the mouse?  Or does BIOS
fabricate commands for other reasons?

The way you describe it, this *sounds* like a race, where Linux
mishandles commands that happen before the handoff quirk.  Do you
remember what happens if BIOS sends a fake command before Linux is
ready for it?  Unexpected interrupt?

Bjorn
