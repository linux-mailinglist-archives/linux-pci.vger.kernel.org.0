Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5329268356
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 06:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgINEBn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 00:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgINEBn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Sep 2020 00:01:43 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54BB020771;
        Mon, 14 Sep 2020 04:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600056102;
        bh=jk+PCbt7HlNNfe20bof51qGGd+SbO43t8Bj1FAQ4l64=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nVcCpO7PRWCqvmVODgIuANzcGAMoqu0hOnPJN0aaRXzpckws57xqZLtRQFli0H9mJ
         Bh1yqaf2RCgVkZ4kguGUJCPRQQTT8j/zgVHBe9hvYVBQVMAB5Iu8JUNATx8eMXKSPY
         /qzextUADe4eMCI9bcHXg1n4wGXOUPwQVkZMT8Xc=
Date:   Sun, 13 Sep 2020 23:01:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: Add L1 link state fix into data abort hook
Message-ID: <20200914040140.GA1237003@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f2451d-720d-1bd9-7628-6a9171f799d3@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 14, 2020 at 03:36:08AM +0200, Marek Vasut wrote:
> On 9/13/20 7:22 PM, Bjorn Helgaas wrote:
> 
> [...]
> 
> >> The R-Car PCIe controller is capable of handling L0s/L1 link states.
> >> While the controller can enter and exit L0s link state, and exit L1
> >> link state, without any additional action from the driver, to enter
> >> L1 link state, the driver must complete the link state transition by
> >> issuing additional commands to the controller.
> > 
> > So IIUC an R-Car Root Port can't enter L1 without help from the
> > driver?  That *sounds* like a hardware defect, since ASPM is supposed
> > to be "hardware-autonomous" once configured.
> 
> The driver needs to complete the switch from L0 to L1 link state, yes.
> 
> >> The problem is, this transition is not atomic. The controller sets
> >> PMEL1RX bit in PMSR register upon reception of PM_ENTER_L1 DLLP from
> >> the PCIe card, but then the controller enters some sort of inbetween
> >> state. The driver must detect this condition and complete the link
> >> state transition, by setting L1IATN bit in PMCTLR and waiting for
> >> the link state transition to complete.
> >>
> >> If a PCIe access happens inside of this window, where the controller
> >> is inbetween L0 and L1 link states, the access generates a fault and
> >> the ARM 'imprecise external abort' handler is invoked.
> > 
> > Let me see if I understand this.
> > 
> >   1) Endpoint sends PM_ENTER_L1
> >   2) R-Car Root Port receives PM_ENTER_L1, sets PMEL1RX
> >   3) R-Car driver does something to complete transition to L1
> > 
> > And if the Endpoint driver does an MMIO access between 2) and 3), it
> > causes an external abort?
> 
> Yes, because the link is in this inbetween state. So you need 3) to
> complete that transition.
> 
> > I couldn't find anything in the R-Car driver today that completes the
> > transition to L1.
> 
> That's because this patch adds it.

So with this patch, we finish the transition to L1 and immediately
return to L0.  That must mean that even in this in-between state we
save some power?

And the link may stay in that in-between state indefinitely, until the
CPU does an MMIO access or the device initiates a DMA?  But it will
never spend any time in L1 because the link never actually *gets* to
L1 until some event that will take it back to L0 occurs?

> > And the MMIO access will immediately bring the link back to L0, won't
> > it?
> 
> Yes
> 
> > Is there any benefit to L1 at all for this Root Port?  If it can't
> > enter L1 and just stays in the in-between state until some event that
> > will bring it *out* of L1, maybe we just need a quirk to stop
> > advertising support for L1 in the first place.
> 
> Power saving I would say.
> 
> >> Just like other PCI controller drivers, here we hook the fault handler,
> >> perform the fixup to help the controller enter L1 link state, and then
> >> restart the instruction which triggered the fault. Since the controller
> >> is in L1 link state now, the link can exit from L1 link state to L0 and
> >> successfully complete the access.
> >>
> >> Note that this fixup is applicable only to Aarch32 R-Car controllers,
> >> the Aarch64 R-Car perform the same fixup in TFA, see TFA commit
> >> 0969397f2 ("rcar_gen3: plat: Prevent PCIe hang during L1X config access")
> > 
> > TFA?  This doesn't seem to be an upstream Linux commit; can you give a
> > more specific reference?
> 
> This is the Trusted Firmware from ARM, in this case it behaves similar
> to ACPI. See e.g.:
> 
> https://github.com/ARM-software/arm-trusted-firmware/commit/0969397f295621aa26b3d14b76dd397d22be58bf

Thanks for that; please include it in the commit log for the next
version.

Bjorn
