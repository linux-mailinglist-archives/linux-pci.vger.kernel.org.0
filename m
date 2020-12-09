Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610412D4CE6
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 22:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbgLIVdJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 16:33:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388097AbgLIVdJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Dec 2020 16:33:09 -0500
Date:   Wed, 9 Dec 2020 15:32:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607549548;
        bh=h0PMQyR/YemmhS46eK73HKO2Jl2ToZkGsE7xgb+ZM8Y=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=rPv3lddxpY3YtX6wLOgdR1b+oo0jyIte84sVI5r/VxiAMoJX/OYYpvPHBDRB4krmj
         JwRd/kqr1M5eU5gV60FmVfhqS7fCXBIO/49VZcjaqUt/Yj5DFhs4d4WGt0tjpbBXua
         OetCzEIocn/NG1C6YTWHf7ApkKptacr5ZYXawUGrrcBZ0O4W3zgL24iGpgsW6gzQit
         3mL0TJJ0HIrhyidNK7CF4FHR/3URaINoKsdX4vkOhrGWHg8c4NsHoOkMy3Ae+rbLBp
         CfdpapzMzq+PDbsa6FEmwr/BPlKP5RATmGmT366c6eIGoPziqLWDnRc4FElY91Q6i+
         L6DtcTKtTgQ0g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hinko Kocevar <hinko.kocevar@ess.eu>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Recovering from AER: Uncorrected (Fatal) error
Message-ID: <20201209213227.GA2544987@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1ad4c01-ce73-dcc0-99b1-5fe45a984800@ess.eu>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 09, 2020 at 09:50:17PM +0100, Hinko Kocevar wrote:
> On 12/9/20 6:40 PM, Bjorn Helgaas wrote:

> > Hmm.  Yeah, I don't see anything in the path that would restore the
> > 01:00.0 config space, which seems like a problem.  Probably its
> > secondary/subordinate bus registers and window registers get reset to
> > 0 ("lspci -vv" would show that) so config/mem/io space below it is
> > accessible.
> 
> I guess the save/restore of the switch registers would be in the core PCI(e)
> code; and not a switch vendor/part specific.
> 
> I still have interest in getting this to work. With my limited knowledge of
> the PCI code base, is there anything I could do to help? Is there a
> particular code base area where you expect this should be managed; pci.c or
> pcie/aer.c or maybe hotplug/ source? I can try and tinker with it..
> 
> 
> Here is the 'lspci -vv' of the 01:00.0 device at the time after the reset:
> 
> 01:00.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca) (prog-if 00
> [Normal decode])
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 128
>         Region 0: Memory at df200000 (32-bit, non-prefetchable) [virtual]
> [size=256K]
>         Bus: primary=00, secondary=00, subordinate=00, sec-latency=0
>         I/O behind bridge: 0000f000-00000fff [disabled]
>         Memory behind bridge: fff00000-000fffff [disabled]
>         Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> [disabled]

Yep, this explains why nothing below the bridge is accessible.
Secondary/subordinate=0 means no config transactions will be
forwarded, and the windows are all disabled, so no MMIO transactions
will be forwarded either.

> Looks like many fields have been zeroed out. Should a bare
> restoration of the previous registers values be enough or does some
> other magic (i.e.  calling PCI functions/performing initialization
> tasks/etc) needs to happen to get that port back to sanity?

Good question.  Documentation/PCI/pci-error-recovery.rst has some
details about the design, including this:

  It is important for the platform to restore the PCI config space to
  the "fresh poweron" state, rather than the "last state". After a
  slot reset, the device driver will almost always use its standard
  device initialization routines, and an unusual config space setup
  may result in hung devices, kernel panics, or silent data
  corruption.

I'm not sure exactly how to interpret that.  It seems like "restoring
to 'fresh poweron' state" is basically just doing a reset, which gives
results like your 01:00.0 device above.  IIUC, we call a driver's
.slot_reset() callback after a reset, and it's supposed to be able to
initialize the device from power-on state.

01:00.0 is a Switch Upstream Port, so portdrv should claim it, and it
looks like pcie_portdrv_slot_reset() should be restoring some state.
But maybe dev->state_saved is false so pci_restore_state() bails out?
Maybe add some printks in that path to see where it's broken?

Bjorn
