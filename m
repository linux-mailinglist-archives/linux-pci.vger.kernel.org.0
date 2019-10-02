Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80328C8F0D
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2019 18:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfJBQzc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Oct 2019 12:55:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfJBQzc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Oct 2019 12:55:32 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B343D21920;
        Wed,  2 Oct 2019 16:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570035331;
        bh=mu9aCUvfoBSr+JnILargJwqYnhZcLC84bjaOKSwi0gY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=O2fGMdskkKM+/grpEgTLlnQNvgWWTge/oAn6KeeJ5GADni7PuCGSQAeyorRRENpaD
         etZywcmAhPD4cchasHFjMTt6U15ZTRdOkWjZ6Ck2xKuprG/ZDA4pf4oR3kDf6BsYQx
         ygcMKcthiFKbtSniGJAvaF1Jn/q0+D5q/aE3bmKI=
Date:   Wed, 2 Oct 2019 11:55:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] x86/PCI: Remove D0 PME capability on AMD FCH xHCI
Message-ID: <20191002165529.GA14065@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30975CE5-7731-4777-B091-1F15F388D5C7@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 02, 2019 at 01:32:07PM +0800, Kai-Heng Feng wrote:
> On Oct 2, 2019, at 08:07, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Sep 02, 2019 at 10:52:52PM +0800, Kai-Heng Feng wrote:
> >> There's an xHCI device that doesn't wake when a USB 2.0 device gets
> >> plugged to its USB 3.0 port. The driver's own runtime suspend callback
> >> was called, PME# signaling was enabled, but it stays at PCI D0:
> >> 
> >> 00:10.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] FCH USB XHCI Controller [1022:7914] (rev 20) (prog-if 30 [XHCI])
> >>        Subsystem: Dell FCH USB XHCI Controller [1028:087e]
> >>        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> >>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> >>        Interrupt: pin A routed to IRQ 18
> >>        Region 0: Memory at f0b68000 (64-bit, non-prefetchable) [size=8K]
> >>        Capabilities: [50] Power Management version 3
> >>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> >>                Status: D0 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
> >> 
> >> A PCI device can be runtime suspended while still stays at D0 when it
> >> supports D0 PME# and its ACPI _S0W method reports D0. Though plugging
> >> USB 3.0 devices can wakeup the xHCI, it doesn't respond to USB 2.0
> >> devices.
> > 
> > I don't think _S0W and runtime suspend are relevant here.  What *is*
> > relevant is that the device advertises that it can generate PME from
> > D0, and it apparently does not do so.
> 
> Yes that's the case. It doesn't generate PME when USB2.0 or USB1.1
> device gets plugged.

OK, thanks.  I added a stable tag and applied this to pci/misc for v5.5.

> > Table 10 in the xHCI spec r1.0, sec 4.15.2.3, says the xHC should
> > assert PME# if enabled and the port's WCE bit is set.  Did you ever
> > confirm that WCE is set?
> 
> How do I check WCE when xHCI is suspended?  If I want to read WCE
> then I have the resume the device, but after resuming all USB
> devices get enumerated, and checking WCE doesn't matter anymore.

Yeah, that's a problem.  I guess you'd have to inspect or instrument
the driver to ensure WCE is set in that path.  But if you get PME# for
USB3 devices, it seems safe to assume WCE is set.

> > I assume WCE *is* set because plugging in a USB3 device *does*
> > generate a PME#, and I don't see anything in Table 10 that says it
> > would work for USB3 but not USB2.
> 
> It should work on all USB speeds, but it didn't.
> That's why the OEM/ODM use the _S0W workaround on Windows.
> 
> Kai-Heng
> 
> > 
> >> So let's disable D0 PME capability on this device to avoid the issue.
> >> 
> >> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203673
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >> ---
> >> arch/x86/pci/fixup.c | 11 +++++++++++
> >> 1 file changed, 11 insertions(+)
> >> 
> >> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> >> index 527e69b12002..0851a05d092f 100644
> >> --- a/arch/x86/pci/fixup.c
> >> +++ b/arch/x86/pci/fixup.c
> >> @@ -588,6 +588,17 @@ static void pci_fixup_amd_ehci_pme(struct pci_dev *dev)
> >> }
> >> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x7808, pci_fixup_amd_ehci_pme);
> >> 
> >> +/*
> >> + * Device [1022:7914]
> >> + * D0 PME# doesn't get asserted when plugging USB 2.0 device.
> >> + */
> >> +static void pci_fixup_amd_fch_xhci_pme(struct pci_dev *dev)
> >> +{
> >> +	dev_info(&dev->dev, "PME# does not work under D0, disabling it\n");
> > 
> > Use pci_info() as in the rest of the file.

Sorry, this was just wrong.  I was assuming this was for
drivers/pci/quirks.c, where dev_info() has been replaced by
pci_info().  But that's not the case for this file.

> >> +	dev->pme_support &= ~(PCI_PM_CAP_PME_D0 >> PCI_PM_CAP_PME_SHIFT);
> >> +}
> >> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x7914, pci_fixup_amd_fch_xhci_pme);
> >> +
> >> /*
> >>  * Apple MacBook Pro: Avoid [mem 0x7fa00000-0x7fbfffff]
> >>  *
> >> -- 
> >> 2.17.1
> 
