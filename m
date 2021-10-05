Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A702423153
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 22:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhJEUN0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 16:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230198AbhJEUN0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 16:13:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC8B060F4B;
        Tue,  5 Oct 2021 20:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633464695;
        bh=+/lmVuORwvCBOfPp/mgSHvs/dh2gIiLo9CdUJoTuZIs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=di9aAfq4m9R1JKQzWLbaplpfjchAuRfYHg0X9ATgtObXKaJ5pJ4kGhZWl1cmlbDBZ
         cix8msThdAuvC6OwDUl2WYqcdgaz+j/3wCTG1GX7pNAD7q6oqGpHs8LnSwnwY+Cp0R
         ph+V8JeQdfkk99Qn9qY7MBTIhuU/o02z+9e2CIW5OCJG0FTtykedjxaae8lZNXwlwU
         MBK9k0qfGxOMZhQ7lcWRqJjyEPGQF95Sb2n8VWka6VhnuQ4xGVxYVKnuEsVLtgx9mR
         U204IUyqnOj8lXSySEe7zW8PWBbYxSN56HY05SVrw6LXvrVuCbLbPPCB5nRtB5QB/r
         bHfrPMfG7yyBA==
Date:   Tue, 5 Oct 2021 15:11:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kelvin.Cao@microchip.com
Cc:     kurt.schwemmer@microsemi.com, bhelgaas@google.com,
        kelvincao@outlook.com, logang@deltatee.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
Message-ID: <20211005201133.GA1113701@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690d2d34fe8d1d11959cdbe9c00ba48ff01d9c3.camel@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 04, 2021 at 08:51:06PM +0000, Kelvin.Cao@microchip.com wrote:
> On Sat, 2021-10-02 at 10:11 -0500, Bjorn Helgaas wrote:
> > On Fri, Oct 01, 2021 at 11:49:18PM +0000, Kelvin.Cao@microchip.com
> > wrote:
> > > On Fri, 2021-10-01 at 14:29 -0600, Logan Gunthorpe wrote:
> > > > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > > > know the content is safe
> > > > 
> > > > On 2021-10-01 2:18 p.m., Bjorn Helgaas wrote:
> > > > > On Fri, Sep 24, 2021 at 11:08:38AM +0000, 
> > > > > kelvin.cao@microchip.com
> > > > > wrote:
> > > > > > From: Kelvin Cao <kelvin.cao@microchip.com>
> > > > > > 
> > > > > > After a firmware hard reset, MRPC command executions,
> > > > > > which are based on the PCI BAR (which Microchip refers to
> > > > > > as GAS) read/write, will hang indefinitely. This is
> > > > > > because after a reset, the host will fail all GAS reads
> > > > > > (get all 1s), in which case the driver won't get a valid
> > > > > > MRPC status.
> > > > > 
> > > > > Trying to write a merge commit log for this, but having a
> > > > > hard time summarizing it.  It sounds like it covers both
> > > > > Switchtec-specific (firmware and MRPC commands) and generic
> > > > > PCIe behavior (MMIO read failures).
> > > > > 
> > > > > This has something to do with a firmware hard reset.  What
> > > > > is that?  Is that like a firmware reboot?  A device reset,
> > > > > e.g., FLR or secondary bus reset, that causes a firmware
> > > > > reboot?  A device reset initiated by firmware?
> > > 
> > > A firmware reset can be triggered by a reset command issued to
> > > the firmware to reboot it.
> > 
> > So I guess this reset command was issued by the driver?
>
> Yes, the reset command can be issued by a userspace utility to the
> firmware via the driver. In some other cases, user can also issue
> the reset command, via a sideband interface (like UART), to the
> firmware. 

OK, thanks.  That means CRS is not a factor here because this is not
an FLR or similar reset.

> > > > > Anyway, apparently when that happens, MMIO reads to the switch
> > > > > fail (timeout or error completion on PCIe) for a while.  If a
> > > > > device reset is involved, that much is standard PCIe behavior.
> > > > > And the driver sees ~0 data from those failed reads.  That's
> > > > > not
> > > > > part of the PCIe spec, but is typical root complex behavior.
> > > > > 
> > > > > But you said the MRPC commands hang indefinitely.  Presumably
> > > > > MMIO reads would start succeeding eventually when the device
> > > > > becomes ready, so I don't know how that translates to
> > > > > "indefinitely."
> > > > 
> > > > I suspect Kelvin can expand on this and fix the issue below. But
> > > > in my experience, the MMIO will read ~0 forever after a firmware
> > > > reset, until the system is rebooted. Presumably on systems that
> > > > have good hot plug support they are supposed to recover. Though
> > > > I've never seen that.
> > > 
> > > This is also my observation, all MMIO read will fail (~0 returned)
> > > until the system is rebooted or a PCI rescan is performed.
> > 
> > This made sense until you said MMIO reads would start working after a
> > PCI rescan.  A rescan doesn't really do anything special other than
> > doing config accesses to the device.  Two things come to mind:
> > 
> > 1) Rescan does a config read of the Vendor ID, and devices may
> > respond with "Configuration Request Retry Status" if they are not
> > ready.  In this event, Linux retries this for a while.  This scenario
> > doesn't quite fit because it sounds like this is a device-specific
> > reset initiated by the driver, and CRS is not permited in this case.
> > PCIe r5.0, sec 2.3.1, says:
> > 
> >   A device Function is explicitly not permitted to return CRS
> >   following a software-initiated reset (other than an FLR) of the
> >   device, e.g., by the device's software driver writing to a
> >   device-specific reset bit.
> > 
> > 2) The device may lose its bus and device number configuration
> > after a reset, so it must capture bus and device numbers from
> > config writes.  I don't think Linux does this explicitly, but a
> > rescan does do config writes, which could accidentally fix
> > something (PCIe r5.0, sec 2.2.9).
> 
> Thanks Bjorn. It makes perfect sense!
> > 
> > > > The MMIO read that signals the MRPC status always returns ~0
> > > > and the userspace request will eventually time out.
> > > 
> > > The problem in this case is that, in DMA MRPC mode, the status
> > > (in host memory) is always initialized to 'in progress', and
> > > it's up to the firmware to update it to 'done' after the command
> > > is executed in the firmware. After a firmware reset is
> > > performed, the firmware cannot be triggered to start a MRPC
> > > command, therefore the status in host memory remains 'in
> > > progress' in the driver, which prevents a MRPC from timing out.
> > > I should have included this in the message.
> > 
> > I *thought* the problem was that the PCIe Memory Read failed and
> > the Root Complex fabricated ~0 data to complete the CPU read.  But
> > now I'm not sure, because it sounds like it might be that the PCIe
> > transaction succeeds, but it reads data that hasn't been updated
> > by the firmware, i.e., it reads 'in progress' because firmware
> > hasn't updated it to 'done'.
> 
> The original message was sort of misleading. After a firmware reset,
> CPU getting ~0 for the PCIe Memory Read doesn't explain the hang. In
> a MRPC execution (DMA MRPC mode), the MRPC status which is located
> in the host memory, gets initialized by the CPU and
> updated/finalized by the firmware. In the situation of a firmware
> reset, any MRPC initiated afterwards will not get the status updated
> by the firmware per the reason you pointed out above (or similar, to
> my understanding, firmware can no longer DMA data to host memory in
> such cases), therefore the MRPC execution will never end.

I'm glad this makes sense to you, because it still doesn't to me.

check_access() does an MMIO read to something in BAR0.  If that read
returns ~0, it means either the PCIe Memory Read was successful and
the Switchtec device supplied ~0 data (maybe because firmware has not
initialized that part of the BAR) or the PCIe Memory Read failed and
the root complex fabricated the ~0 data.

I'd like to know which one is happening so we can clarify the commit
log text about "MRPC command executions hang indefinitely" and "host
wil fail all GAS reads."  It's not clear whether these are PCIe
protocol issues or driver/firmware interaction issues.

Bjorn
