Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAED4247DB
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 22:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbhJFUWK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 16:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239437AbhJFUWK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Oct 2021 16:22:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B30ED6103D;
        Wed,  6 Oct 2021 20:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633551618;
        bh=J6JmypoA5uAZGPt6CNkNVyuZncdg+GjqSiooi4DM/k0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=M8JxJ/GYRh/gW16VuEzq0V2YJfFp7e/tuqqauwkMujEGoTFbTCXnMoT4fZ/gCm+Qn
         BWfiCvNI56Qxy3RGsbgkSSI86aEyv7iqKWHkybA0fqm3x3hmmwwiQmtzIDjM554RmT
         MLtl0uRKcon0E9e3f6Rx5Icwr6gOWdwWw/6t1zZduvImqC9ZM2Bw+v1AqSPzj+QQTG
         ZJHhOGHbUX4FdRemA4xgOl994MFFQvMsSJauBRxhFY8CGMc+cBMD4u8NfNS474zccH
         gD/HgJIHo9Gh0q1A9di7oPyP9xOnzO3x0NaxYNJzh4+VINO1cbhZiJWQA9dyJxG4Gn
         R8fintZebqThw==
Date:   Wed, 6 Oct 2021 15:20:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kelvin.Cao@microchip.com
Cc:     kurt.schwemmer@microsemi.com, bhelgaas@google.com,
        kelvincao@outlook.com, linux-pci@vger.kernel.org,
        logang@deltatee.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
Message-ID: <20211006202016.GA1178025@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70abccd6144d8eac461866355e3a6963b3fb3fe7.camel@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 06, 2021 at 07:00:55PM +0000, Kelvin.Cao@microchip.com wrote:
> On Wed, 2021-10-06 at 09:19 -0500, Bjorn Helgaas wrote:
> > On Wed, Oct 06, 2021 at 05:49:29AM +0000, Kelvin.Cao@microchip.com
> > wrote:
> > > On Tue, 2021-10-05 at 21:33 -0500, Bjorn Helgaas wrote:
> > > > On Wed, Oct 06, 2021 at 12:37:02AM +0000, 
> > > > Kelvin.Cao@microchip.com
> > > > wrote:
> > > > > On Tue, 2021-10-05 at 15:11 -0500, Bjorn Helgaas wrote:
> > > > > > On Mon, Oct 04, 2021 at 08:51:06PM +0000,
> > > > > > Kelvin.Cao@microchip.com
> > > > > > wrote:
> > > > > > > On Sat, 2021-10-02 at 10:11 -0500, Bjorn Helgaas wrote:
> > > > > > > > I *thought* the problem was that the PCIe Memory Read
> > > > > > > > failed and the Root Complex fabricated ~0 data to
> > > > > > > > complete
> > > > > > > > the CPU read.  But now I'm not sure, because it sounds
> > > > > > > > like it might be that the PCIe transaction succeeds, but
> > > > > > > > it reads data that hasn't been updated by the firmware,
> > > > > > > > i.e., it reads 'in progress' because firmware hasn't
> > > > > > > > updated it to 'done'.
> > > > > > > 
> > > > > > > The original message was sort of misleading. After a
> > > > > > > firmware reset, CPU getting ~0 for the PCIe Memory Read
> > > > > > > doesn't explain the hang.  In a MRPC execution (DMA MRPC
> > > > > > > mode), the MRPC status which is located in the host memory,
> > > > > > > gets initialized by the CPU and updated/finalized by the
> > > > > > > firmware. In the situation of a firmware reset, any MRPC
> > > > > > > initiated afterwards will not get the status updated by the
> > > > > > > firmware per the reason you pointed out above (or similar,
> > > > > > > to my understanding, firmware can no longer DMA data to
> > > > > > > host
> > > > > > > memory in such cases), therefore the MRPC execution will
> > > > > > > never end.
> > > > > > 
> > > > > > I'm glad this makes sense to you, because it still doesn't to
> > > > > > me.
> > > > > > 
> > > > > > check_access() does an MMIO read to something in BAR0.  If
> > > > > > that read returns ~0, it means either the PCIe Memory Read
> > > > > > was
> > > > > > successful and the Switchtec device supplied ~0 data (maybe
> > > > > > because firmware has not initialized that part of the BAR) or
> > > > > > the PCIe Memory Read failed and the root complex fabricated
> > > > > > the ~0 data.
> > > > > > 
> > > > > > I'd like to know which one is happening so we can clarify the
> > > > > > commit log text about "MRPC command executions hang
> > > > > > indefinitely" and "host wil fail all GAS reads."  It's not
> > > > > > clear whether these are PCIe protocol issues or
> > > > > > driver/firmware interaction issues.
> > > > > 
> > > > > I think it's the latter case, the ~0 data was fabricated by the
> > > > > root complex, as the MMIO read in check_access() always returns
> > > > > ~0 until a reboot or a rescan happens.
> > > > 
> > > > If the root complex fabricates ~0, that means a PCIe transaction
> > > > failed, i.e., the device didn't respond.  Rescan only does config
> > > > reads and writes.  Why should that cause the PCIe transactions to
> > > > magically start working?
> > > 
> > > I took a closer look. What I observed was like this. A firmware
> > > reset cleared some CSR settings including the MSE and MBE bits and
> > > the Base Address Registers. With a rescan (removing the switch to
> > > which the management EP was binded from root port and rescan), the
> > > management EP was re-enumerated and driver was re-probed, so that
> > > the settings cleared by the firmware reset was properly setup
> > > again,
> > > therefore PCIe transactions start working.
> > 
> > I think what you just said is that
> > 
> >   - the driver asked the firmware to reset the device
> > 
> >   - the firmware did reset the device, which cleared Memory Space
> >     Enable
> > 
> >   - nothing restored the device config after the reset, so Memory
> >     Space Enable remains cleared
> > 
> >   - the driver does MMIO reads to figure out when the reset has
> >     completed
> > 
> >   - the device doesn't respond to the PCIe Memory Reads because
> > Memory
> >     Space Enable is cleared
> > 
> >   - the root complex sees a timeout or error completion and
> > fabricates
> >     ~0 data for the CPU read
> > 
> >   - the driver sees ~0 data from the MMIO read and thinks the device
> >     or firmware is hung
> > 
> > If that's all true, I think the patch is sort of a band-aid that
> > doesn't fix the problem at all but only makes the driver's response
> > to
> > it marginally better.  But the device is still unusable until a
> > rescan
> > or reboot.
> > 
> > So I think we should drop this patch and do something to restore the
> > device state after the reset.
> 
> Do you mean we should do something at the driver level to automatically
> try to restore the device state after the reset? I was thinking it's up
> to the user to make the call to restore the device state or take other
> actions, so that returning an error code from MRPC to indicate what
> happened would be good enough for the driver. 

It sounds like this is a completely predictable situation.  Why would
you want manual user intervention?

I'm pretty sure there are drivers that save state *before* the reset
and restore it afterwards.

> Can you possibly shed light on what might be a reasonable way to
> restore the device state in the driver if applicable? I was just doing
> it by leveraging the remove and rescan interfaces in the sysfs.
> 
> That's all true. I lean towards keeping the patch as I think making the
> response better under the following situations might not be bad.
> 
>   - The firmware reset case, as we discussed. I'd think it's still
> useful for users to get a fast error return which indicates something
> bad happened and some actions need to be taken either to abort or try
> to recover. In this case, we are assuming that a firmware reset will
> boot the firmware successfully.

So wait, you mean you just intentionally ask the firmware to reset,
knowing that the device will be unusable until the user reboots or
does a manual rescan?  And the way to improve this is for the driver
to report an error to the user instead of hanging?  I *guess* that
might be some sort of improvement, but seems like a pretty small one.

>   - The firwmare crashes and doesn't respond, which normally is the
> reason for users to issue a firmware reset command to try to recover it
> via either the driver or a sideband interface. The firmware may not be
> able to recover by a reset in some extream situations like hardware
> errors, so that an error return is probably all the users can get
> before another level of recovery happens.
> 
> So I'd think this patch is still making the driver better in some way.
> 
> Kelvin
> 
