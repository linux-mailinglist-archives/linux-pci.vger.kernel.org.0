Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA852E5131
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2019 18:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633042AbfJYQ2R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Oct 2019 12:28:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633030AbfJYQ2Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Oct 2019 12:28:16 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EDEB2084C;
        Fri, 25 Oct 2019 16:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572020895;
        bh=F4aiAi9ADhSGPQCvGinop62RHQp0ZQn5qwx29oeDixA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=2bGYBxw+568mSl8OsguyvePly25AljkkwKgzBxProDmgj+SDk1zHWuc8z0bcWQLR2
         gai7EXWk/RAqIWZcAgHIqlQ9UO4sFJAL1Q5Yf0KUaS8ztRaPNXDkHo+RQbYI6uHfVs
         hYVWQaamwj0t74GtqJOIX2JY8F+VHfhkA4bCHtOY=
Date:   Fri, 25 Oct 2019 11:28:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] PCI: increase D3 delay for AMD Ryzen5/7 XHCI controllers
Message-ID: <20191025162814.GA130180@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD8Lp47HgAi-86ni5WHhZT1-sEd7oJEZUiG6KNU66qpmRCfaXw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 25, 2019 at 03:11:49PM +0800, Daniel Drake wrote:
> On Fri, Oct 25, 2019 at 1:00 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > That's really strange.  Your original message showed:
> >
> >   xhci_hcd 0000:03:00.4: Refused to change power state, currently in D3
> >   xhci_hcd 0000:03:00.4: enabling device (0000 -> 0002)
> >
> > The first line is from pci_raw_set_power_state() reading PCI_PM_CTRL,
> > but we can't tell whether the read failed and we got ~0, or it
> > succeeded and we got something with just the low two bits set.  Can
> > you print out the whole value so we can see what happened?
> >
> > The second line is from pci_enable_resources() reading PCI_COMMAND,
> > and it got *0*, not 0x0403 as you got from the CRS experiment.
> 
> Thanks for persisting here. In more detail:
> 
> pci_pm_resume_noirq
> - pci_pm_default_resume_early
> -- pci_raw_set_power_state(D0)
> 
> At this point, pci_dev_wait() reads PCI_COMMAND to be 0x100403 (32-bit
> read) - so no wait.

Just thinking out loud here: This is before writing PCI_PM_CTRL.  The
device should be in D3hot and 0x100403 is PCI_COMMAND_IO |
PCI_COMMAND_MEMORY | PCI_COMMAND_INTX_DISABLE (and
PCI_STATUS_CAP_LIST), which mostly matches your lspci (it's missing
PCI_COMMAND_MASTER, but maybe that got turned off during suspend).
It's a little strange that PCI_COMMAND_IO is set because 03:00.3 has
no I/O BARs, but maybe that was set by BIOS at boot-time.

> pci_raw_set_power_state writes to PM_CTRL and then reads it back
> with value 0x3.

When you write D0 to PCI_PM_CTRL the device does a soft reset, so
pci_raw_set_power_state() delays before the next access.

When you read PCI_PM_CTRL again, I think you *should* get either
0x0000 (indicating that the device is in D0) or 0xffff (if the read
failed with a Config Request Retry Status (CRS) because the device
wasn't ready yet).

I can't explain why you would read 0x0003 (not 0xffff) from
PCI_PM_CTRL.

What happens if you do a dword read from PCI_VENDOR_ID here (after the
delay but before pci_dev_wait() or reading PCI_PM_CTRL)?

We have CRS "software visibility" enabled, and the expectation in the
spec is that software will read PCI_VENDOR_ID to see whether the
device is ready: 0x0001 means the read got a CRS completion (device
isn't ready), valid Vendor ID means device is ready, and 0xffff
indicates some other error.

pci_dev_wait() reads PCI_COMMAND, not PCI_VENDOR_ID, so maybe there's
some wrinkle in how that's handled.

You might also try changing pci_enable_crs() to disable
PCI_EXP_RTCTL_CRSSVE instead of enabling it to see if that makes any
difference.  CRS SV has kind of a checkered history and I'm a little
dubious about whether it buys us anything.

> >   xhci_hcd 0000:03:00.4: Refused to change power state, currently in D3
> 
> At the point of return from pci_pm_resume_noirq, an extra check I
> added shows that PCI_COMMAND has value 0x403 (16-bit read).

If PCI_COMMAND is non-zero at that point, I think something's wrong.
It should be zero by the time pci_raw_set_power_state() reads
PCI_PM_CTRL after the D3 delay.  By that time, we assume the reset has
happened and the device is in D0uninitialized and fully accessible.

> 35ms later, pci_pm_resume is entered, and I checked that at this
> point, PCI_COMMAND has value 0.
> It then goes on to reach pci_enable_resources().
> >   xhci_hcd 0000:03:00.4: enabling device (0000 -> 0002)
> 
> The change in PCI_COMMAND value is just down to timing.
> At the end of pci_pm_resume_noirq(), if I log PCI_COMMAND, wait 10ms,
> and log PCI_COMMAND again, I see it transition from 0x403 to 0.
> 
> Daniel
