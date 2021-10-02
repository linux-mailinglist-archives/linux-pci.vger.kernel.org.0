Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0556541FCA6
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 17:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhJBPNn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Oct 2021 11:13:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233274AbhJBPNm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 2 Oct 2021 11:13:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DE22611C7;
        Sat,  2 Oct 2021 15:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633187516;
        bh=SbD0pLMeuMsQguP7ZVdU4NgeQOy5CPZuKGaMkAkIfkI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=b46de+QJ1JwnmCWmVBZVR7FuPAC2vA7jEhMPZVEyNrHqD8ZUQX12egjCJvHz5umYb
         oT8r4yvtKDiGvGQvYdFEP3qV4ZKkx9S/6gSQ2/hdpfACn9tU4lKBySXxBPY3IfRhjV
         6zaRd6rQFfccqy6kyPtGN/d3VskGmfVPX5wstU+FBKOJnpz/H0dXegde+daYvSgthv
         8xCGMwczrVuQtSUFPmntJio401eyJS0Oozz/OBHeobizJs9GEYwcR/UoBIdCWeUPuF
         l60oDAuB+ay8bLlWBKNDFs8yxdCwWwCIyKukhLyoMqT7o+lOF8QIGiX1V3Ar9ajnb6
         +TabPgsAhdkLg==
Date:   Sat, 2 Oct 2021 10:11:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kelvin.Cao@microchip.com
Cc:     logang@deltatee.com, kurt.schwemmer@microsemi.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kelvincao@outlook.com
Subject: Re: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
Message-ID: <20211002151153.GA967141@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed856f361ef3ca80e34c4565daffe6e566a8baa3.camel@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 01, 2021 at 11:49:18PM +0000, Kelvin.Cao@microchip.com wrote:
> On Fri, 2021-10-01 at 14:29 -0600, Logan Gunthorpe wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> > 
> > On 2021-10-01 2:18 p.m., Bjorn Helgaas wrote:
> > > On Fri, Sep 24, 2021 at 11:08:38AM +0000, kelvin.cao@microchip.com
> > > wrote:
> > > > From: Kelvin Cao <kelvin.cao@microchip.com>
> > > > 
> > > > After a firmware hard reset, MRPC command executions, which
> > > > are based on the PCI BAR (which Microchip refers to as GAS)
> > > > read/write, will hang indefinitely. This is because after a
> > > > reset, the host will fail all GAS reads (get all 1s), in which
> > > > case the driver won't get a valid MRPC status.
> > > 
> > > Trying to write a merge commit log for this, but having a hard
> > > time summarizing it.  It sounds like it covers both
> > > Switchtec-specific (firmware and MRPC commands) and generic PCIe
> > > behavior (MMIO read failures).
> > > 
> > > This has something to do with a firmware hard reset.  What is
> > > that?  Is that like a firmware reboot?  A device reset, e.g.,
> > > FLR or secondary bus reset, that causes a firmware reboot?  A
> > > device reset initiated by firmware?
>
> A firmware reset can be triggered by a reset command issued to the
> firmware to reboot it.

So I guess this reset command was issued by the driver?

> > > Anyway, apparently when that happens, MMIO reads to the switch
> > > fail (timeout or error completion on PCIe) for a while.  If a
> > > device reset is involved, that much is standard PCIe behavior.
> > > And the driver sees ~0 data from those failed reads.  That's not
> > > part of the PCIe spec, but is typical root complex behavior.
> > > 
> > > But you said the MRPC commands hang indefinitely.  Presumably
> > > MMIO reads would start succeeding eventually when the device
> > > becomes ready, so I don't know how that translates to
> > > "indefinitely."
> > 
> > I suspect Kelvin can expand on this and fix the issue below. But
> > in my experience, the MMIO will read ~0 forever after a firmware
> > reset, until the system is rebooted. Presumably on systems that
> > have good hot plug support they are supposed to recover. Though
> > I've never seen that.
> 
> This is also my observation, all MMIO read will fail (~0 returned)
> until the system is rebooted or a PCI rescan is performed.

This made sense until you said MMIO reads would start working after a
PCI rescan.  A rescan doesn't really do anything special other than
doing config accesses to the device.  Two things come to mind:

1) Rescan does a config read of the Vendor ID, and devices may
respond with "Configuration Request Retry Status" if they are not
ready.  In this event, Linux retries this for a while.  This scenario
doesn't quite fit because it sounds like this is a device-specific
reset initiated by the driver, and CRS is not permited in this case.
PCIe r5.0, sec 2.3.1, says:

  A device Function is explicitly not permitted to return CRS
  following a software-initiated reset (other than an FLR) of the
  device, e.g., by the device's software driver writing to a
  device-specific reset bit.

2) The device may lose its bus and device number configuration after a
reset, so it must capture bus and device numbers from config writes.
I don't think Linux does this explicitly, but a rescan does do config
writes, which could accidentally fix something (PCIe r5.0, sec 2.2.9).

> > The MMIO read that signals the MRPC status always returns ~0 and the
> > userspace request will eventually time out.
> 
> The problem in this case is that, in DMA MRPC mode, the status (in host
> memory) is always initialized to 'in progress', and it's up to the
> firmware to update it to 'done' after the command is executed in the
> firmware. After a firmware reset is performed, the firmware cannot be
> triggered to start a MRPC command, therefore the status in host memory
> remains 'in progress' in the driver, which prevents a MRPC from timing
> out. I should have included this in the message.

I *thought* the problem was that the PCIe Memory Read failed and the
Root Complex fabricated ~0 data to complete the CPU read.  But now I'm
not sure, because it sounds like it might be that the PCIe transaction
succeeds, but it reads data that hasn't been updated by the firmware,
i.e., it reads 'in progress' because firmware hasn't updated it to
'done'.

Bjorn
