Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C3B27122
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2019 22:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfEVUwe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 May 2019 16:52:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729528AbfEVUwe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 May 2019 16:52:34 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B37220675;
        Wed, 22 May 2019 20:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558558353;
        bh=bhpBHeEEilTJAKuT5Mz1T+jvRriCi/QY/aaDhmaV7JI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ouHOrgyYGR6Ej2mSKFz/3tkEsldkGSNiCr50YNVhTymWt2/NSkU5IZLSv5wHzIHey
         yfJCtejVdReX1qKpbB02KMuX1ladLoJjzMV47fSNX14NzIFTNC7O2HJsIfig+Dgxa+
         EdwV7TDs99XEyF6g7uXFcv7KEVI02A4FvjQ/pdmU=
Date:   Wed, 22 May 2019 15:52:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Kai Heng Feng <kai.heng.feng@canonical.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] PCI / PM: Don't runtime suspend when device only
 supports wakeup from D0
Message-ID: <20190522205231.GD79339@google.com>
References: <20190522181157.GC79339@google.com>
 <Pine.LNX.4.44L0.1905221433310.1410-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44L0.1905221433310.1410-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 22, 2019 at 02:39:56PM -0400, Alan Stern wrote:
> On Wed, 22 May 2019, Bjorn Helgaas wrote:
> > On Wed, May 22, 2019 at 11:46:25PM +0800, Kai Heng Feng wrote:
> > > > On May 22, 2019, at 9:48 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Wed, May 22, 2019 at 11:42:14AM +0800, Kai Heng Feng wrote:
> > > >> at 6:23 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >>> On Wed, May 22, 2019 at 12:31:04AM +0800, Kai-Heng Feng wrote:
> > > >>>> There's an xHC device that doesn't wake when a USB device gets plugged
> > > >>>> to its USB port. The driver's own runtime suspend callback was called,
> > > >>>> PME signaling was enabled, but it stays at PCI D0.
> > 
> > > > ...
> > > > And I guess this patch basically means we wouldn't call the driver's
> > > > suspend callback if we're merely going to stay at D0, so the driver
> > > > would have no idea anything happened.  That might match
> > > > Documentation/power/pci.txt better, because it suggests that the
> > > > suspend callback is related to putting a device in a low-power state,
> > > > and D0 is not a low-power state.
> > > 
> > > Yes, the patch is to let the device stay at D0 and don’t run driver’s own
> > > runtime suspend routine.
> > > 
> > > I guess I’ll just proceed to send a V2 with updated commit message?
> > 
> > Now that I understand what "runtime suspended to D0" means, help me
> > understand what's actually wrong.
> 
> Kai's point is that the xhci-hcd driver thinks the device is now in 
> runtime suspend, because the runtime_suspend method has been executed.  
> But in fact the device is still in D0, and as a result, PME signalling 
> may not work correctly.

The device claims to be able to signal PME from D0 (this is from the lspci
in https://bugzilla.kernel.org/show_bug.cgi?id=203673):

  00:10.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB XHCI Controller (rev 20) (prog-if 30 [XHCI])
    Capabilities: [50] Power Management version 3
      Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)

From the xHCI spec r1.0, sec 4.15.2.3, it looks like a connect
detected while in D0 should assert PME# if enabled (and WCE is set).

> On the other hand, it wasn't clear from the patch description whether
> this actually causes a problem on real systems.  The description only
> said that the problem was theoretical.

Kai did say nothing happens when hot-adding a USB device, so I think
there really is a problem.  This should be an obvious problem that
lots of people would trip over, so I expect there should be reports in
launchpad, etc.  I'd really like to have those bread crumbs.  Kai, can
you add a complete dmesg log to the bugzilla?  Hints from the log,
like the platform name, can help find related reports.

> > The PCI core apparently *does* enable PME when we "suspend to D0".
> > But somehow calling the xHCI runtime suspend callback makes the
> > driver unable to notice when the PME is signaled?
> 
> According to Kai, PME signalling doesn't work in D0 -- or at least,
> it is _documented_ not to work in D0 -- even though it is enabled
> and the device claims to support it.

I didn't understand this part.  From a PCI perspective, PME signaling
while in D0 is an optional feature and should work if the device
advertises support for it.  If it doesn't work on this device, we
should have a quirk to indicate that.

But I thought Kai said the device *can* signal PME from D0, but for
some reason we don't handle it correctly if we have called the xHCI
suspend callback.

That's the part I don't understand.  Is this an xHCI driver issue?
Should the suspend callback do something different if we're staying in
D0?  I'm not sure the callback even knows what Dx state we're going
to.

Bjorn
