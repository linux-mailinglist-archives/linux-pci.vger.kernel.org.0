Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160FB423FEB
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 16:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhJFOVh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 10:21:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231356AbhJFOVg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Oct 2021 10:21:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C40B60EFF;
        Wed,  6 Oct 2021 14:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633529983;
        bh=hcN96N38jd5OMtH94/dTJCYZqlodc1Iq8xYnE522YOI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=J5B2khO2tPlVRC1ROwcg+MaEtpl+YB5CMWd1GT78HSwWe6dky9/GObOoWLmrZ0EjH
         QYXFo78X70FtMki3hhu+0LWn3jhPQuJ/2SyaiqYsMw/Sah+3ModOlFr7FpNV0pCDrz
         Y12qCwO47i9+kjcY3m1ZdV9ejW9fcLwoonv8OltOdWZgTdwZSjxGcAACbklGon/E5j
         EPmxyzxEZqoMuTuQG3Bjg2gkkzIIqSMwAWD2hZPv9qlg7q03booa3TEJpYaVpQ4nc0
         qKfQFGLkA7sT5tdVMkNK0VauKMHTgd9fw0KEztGEydHlRupy/G2zYf6eTCVY52QQrZ
         d3TOA4GRD8/Mg==
Date:   Wed, 6 Oct 2021 09:19:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kelvin.Cao@microchip.com
Cc:     kurt.schwemmer@microsemi.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, kelvincao@outlook.com
Subject: Re: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
Message-ID: <20211006141942.GA1152835@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14d694a3432de04ceb0dd8c4c5635194f44d269c.camel@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 06, 2021 at 05:49:29AM +0000, Kelvin.Cao@microchip.com wrote:
> On Tue, 2021-10-05 at 21:33 -0500, Bjorn Helgaas wrote:
> > On Wed, Oct 06, 2021 at 12:37:02AM +0000, Kelvin.Cao@microchip.com
> > wrote:
> > > On Tue, 2021-10-05 at 15:11 -0500, Bjorn Helgaas wrote:
> > > > On Mon, Oct 04, 2021 at 08:51:06PM +0000, 
> > > > Kelvin.Cao@microchip.com
> > > > wrote:
> > > > > On Sat, 2021-10-02 at 10:11 -0500, Bjorn Helgaas wrote:
> > > > > > I *thought* the problem was that the PCIe Memory Read
> > > > > > failed and the Root Complex fabricated ~0 data to complete
> > > > > > the CPU read.  But now I'm not sure, because it sounds
> > > > > > like it might be that the PCIe transaction succeeds, but
> > > > > > it reads data that hasn't been updated by the firmware,
> > > > > > i.e., it reads 'in progress' because firmware hasn't
> > > > > > updated it to 'done'.
> > > > > 
> > > > > The original message was sort of misleading. After a
> > > > > firmware reset, CPU getting ~0 for the PCIe Memory Read
> > > > > doesn't explain the hang.  In a MRPC execution (DMA MRPC
> > > > > mode), the MRPC status which is located in the host memory,
> > > > > gets initialized by the CPU and updated/finalized by the
> > > > > firmware. In the situation of a firmware reset, any MRPC
> > > > > initiated afterwards will not get the status updated by the
> > > > > firmware per the reason you pointed out above (or similar,
> > > > > to my understanding, firmware can no longer DMA data to host
> > > > > memory in such cases), therefore the MRPC execution will
> > > > > never end.
> > > > 
> > > > I'm glad this makes sense to you, because it still doesn't to
> > > > me.
> > > > 
> > > > check_access() does an MMIO read to something in BAR0.  If
> > > > that read returns ~0, it means either the PCIe Memory Read was
> > > > successful and the Switchtec device supplied ~0 data (maybe
> > > > because firmware has not initialized that part of the BAR) or
> > > > the PCIe Memory Read failed and the root complex fabricated
> > > > the ~0 data.
> > > > 
> > > > I'd like to know which one is happening so we can clarify the
> > > > commit log text about "MRPC command executions hang
> > > > indefinitely" and "host wil fail all GAS reads."  It's not
> > > > clear whether these are PCIe protocol issues or
> > > > driver/firmware interaction issues.
> > > 
> > > I think it's the latter case, the ~0 data was fabricated by the
> > > root complex, as the MMIO read in check_access() always returns
> > > ~0 until a reboot or a rescan happens.
> > 
> > If the root complex fabricates ~0, that means a PCIe transaction
> > failed, i.e., the device didn't respond.  Rescan only does config
> > reads and writes.  Why should that cause the PCIe transactions to
> > magically start working?
> 
> I took a closer look. What I observed was like this. A firmware
> reset cleared some CSR settings including the MSE and MBE bits and
> the Base Address Registers. With a rescan (removing the switch to
> which the management EP was binded from root port and rescan), the
> management EP was re-enumerated and driver was re-probed, so that
> the settings cleared by the firmware reset was properly setup again,
> therefore PCIe transactions start working.

I think what you just said is that 

  - the driver asked the firmware to reset the device

  - the firmware did reset the device, which cleared Memory Space
    Enable

  - nothing restored the device config after the reset, so Memory
    Space Enable remains cleared

  - the driver does MMIO reads to figure out when the reset has
    completed

  - the device doesn't respond to the PCIe Memory Reads because Memory
    Space Enable is cleared

  - the root complex sees a timeout or error completion and fabricates
    ~0 data for the CPU read

  - the driver sees ~0 data from the MMIO read and thinks the device
    or firmware is hung

If that's all true, I think the patch is sort of a band-aid that
doesn't fix the problem at all but only makes the driver's response to
it marginally better.  But the device is still unusable until a rescan
or reboot.

So I think we should drop this patch and do something to restore the
device state after the reset.

Bjorn
