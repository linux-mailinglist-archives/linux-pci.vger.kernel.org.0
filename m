Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24CF9269F9
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2019 20:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfEVSj6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 May 2019 14:39:58 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:56410 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728272AbfEVSj5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 May 2019 14:39:57 -0400
Received: (qmail 10090 invoked by uid 2102); 22 May 2019 14:39:56 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 May 2019 14:39:56 -0400
Date:   Wed, 22 May 2019 14:39:56 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Kai Heng Feng <kai.heng.feng@canonical.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] PCI / PM: Don't runtime suspend when device only supports
 wakeup from D0
In-Reply-To: <20190522181157.GC79339@google.com>
Message-ID: <Pine.LNX.4.44L0.1905221433310.1410-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 22 May 2019, Bjorn Helgaas wrote:

> On Wed, May 22, 2019 at 11:46:25PM +0800, Kai Heng Feng wrote:
> > > On May 22, 2019, at 9:48 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Wed, May 22, 2019 at 11:42:14AM +0800, Kai Heng Feng wrote:
> > >> at 6:23 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >>> On Wed, May 22, 2019 at 12:31:04AM +0800, Kai-Heng Feng wrote:
> > >>>> There's an xHC device that doesn't wake when a USB device gets plugged
> > >>>> to its USB port. The driver's own runtime suspend callback was called,
> > >>>> PME signaling was enabled, but it stays at PCI D0.
> 
> > > ...
> > > And I guess this patch basically means we wouldn't call the driver's
> > > suspend callback if we're merely going to stay at D0, so the driver
> > > would have no idea anything happened.  That might match
> > > Documentation/power/pci.txt better, because it suggests that the
> > > suspend callback is related to putting a device in a low-power state,
> > > and D0 is not a low-power state.
> > 
> > Yes, the patch is to let the device stay at D0 and don’t run driver’s own
> > runtime suspend routine.
> > 
> > I guess I’ll just proceed to send a V2 with updated commit message?
> 
> Now that I understand what "runtime suspended to D0" means, help me
> understand what's actually wrong.

Kai's point is that the xhci-hcd driver thinks the device is now in 
runtime suspend, because the runtime_suspend method has been executed.  
But in fact the device is still in D0, and as a result, PME signalling 
may not work correctly.

On the other hand, it wasn't clear from the patch description whether
this actually causes a problem on real systems.  The description only
said that the problem was theoretical.

> The PCI core apparently *does* enable PME when we "suspend to D0".
> But somehow calling the xHCI runtime suspend callback makes the driver
> unable to notice when the PME is signaled?

According to Kai, PME signalling doesn't work in D0 -- or at least, it
is _documented_ not to work in D0 -- even though it is enabled and the
device claims to support it.

In any case, I don't really see any point in "runtime suspending" a 
device while leaving it in D0.  We might as well just leave it alone.

Alan Stern

