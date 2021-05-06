Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F61037580A
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbhEFQAk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 12:00:40 -0400
Received: from netrider.rowland.org ([192.131.102.5]:57199 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S235285AbhEFQAi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 May 2021 12:00:38 -0400
Received: (qmail 741677 invoked by uid 1000); 6 May 2021 11:59:39 -0400
Date:   Thu, 6 May 2021 11:59:39 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: `quirk_usb_handoff_xhci` takes 60 ms with ASM1042
Message-ID: <20210506155939.GA738638@rowland.harvard.edu>
References: <YJK/bkJpCC+INPo3@kroah.com>
 <20210506152300.GA1405893@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506152300.GA1405893@bjorn-Precision-5520>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 06, 2021 at 10:23:00AM -0500, Bjorn Helgaas wrote:
> On Wed, May 05, 2021 at 05:53:18PM +0200, Greg Kroah-Hartman wrote:
> > I think, if we don't do the handoff, then the BIOS/firmware tries to
> > send the OS fake keyboard/mouse commands, and Linux isn't ready for that
> > as we didn't allow hotplug PS/2 stuff.  But I could be wrong, it's been
> > a long time since we did that logic.
> 
> I have no idea what "BIOS/firmware sending OS fake keyboard/mouse
> commands" means.  From the OS point of view, does that look like USB
> events that cause PCI interrupts?  PS/2 interrupts?  Are these
> commands caused by the user typing or moving the mouse?  Or does BIOS
> fabricate commands for other reasons?

Think of an old MSDOS operating system without USB support.  The BIOS 
tries to be helpful by translating mouse and keyboard input it receives 
over USB into PS/2 events that the operating system can handle.  
Originally this was done using SMI; now it presumably is still a legacy 
part of UEFI.

> The way you describe it, this *sounds* like a race, where Linux
> mishandles commands that happen before the handoff quirk.  Do you
> remember what happens if BIOS sends a fake command before Linux is
> ready for it?  Unexpected interrupt?

I would be surprised if anybody still knows.  :-)

Perhaps a reasonable experiment would be to boot a kernel with PS/2 
support but not USB support (or at least, without CONFIG_USB_PCI) and 
see what happens when you type on the USB keyboard or move the USB 
mouse.

It might very well turn out that the handoff operation can safely be 
delayed until driver probe time.

Alan Stern
