Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C58489717
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 12:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244549AbiAJLOF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jan 2022 06:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244485AbiAJLMh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jan 2022 06:12:37 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3453C034005
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 03:12:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EE225CE12F2
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 11:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBCCC36AE5;
        Mon, 10 Jan 2022 11:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641813134;
        bh=T+OLgP6ZUCT9cXyxspkgBFms21paBB3f0bcN3WP441U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2HQ7eb3hL5fxniDC2Ht5c7tEPw30NkYV1n45lbEUzGtaoft1phwwiT3FP9Td640d
         1dRmcLPWf13SxflJKCjMEaqz1i3RnLGaa3iRdUD6eY4rK3VKyAqnrsOO95+7R8sdEt
         5T5d8Ag34/lV//a1hvXshu6SdnjaQRhYNqlyhu47Sw0AUEejTck307WBk6rmc/cF6D
         uyFNMlebVROtqofD1p47evE9+xhU3TZK9wToiaQnk6asdqkV9t5j+vsLyQJ5gZWgFy
         4PB+OOsRrbZ8CLeww2QvrsiQrUU4Me49THpcq3MPJme6IVCKNfFYAegvv/VJoMLsjT
         Q2GUW4ofWIdBw==
Received: by pali.im (Postfix)
        id 63106A52; Mon, 10 Jan 2022 12:12:11 +0100 (CET)
Date:   Mon, 10 Jan 2022 12:12:11 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Stefan Roese <sr@denx.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Bharat Kumar Gogada <bharatku@xilinx.com>
Subject: Re: PCIe AER generates no interrupts on host (ZynqMP)
Message-ID: <20220110111211.l6lqmfmyu47dfhjh@pali>
References: <20220107213106.7lvzvdlrfnbyhvbl@pali>
 <20220108031357.GA443744@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220108031357.GA443744@bhelgaas>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 07 January 2022 21:13:57 Bjorn Helgaas wrote:
> On Fri, Jan 07, 2022 at 10:31:06PM +0100, Pali Rohár wrote:
> > On Friday 07 January 2022 14:34:15 Bjorn Helgaas wrote:
> > > On Fri, Jan 07, 2022 at 11:04:58AM +0100, Pali Rohár wrote:
> > > > Hello! You asked me in another email for comments to this email, so I'm
> > > > replying directly to this email...
> > > > 
> > > > On Tuesday 04 January 2022 10:02:18 Stefan Roese wrote:
> > > > > Hi,
> > > > > 
> > > > > I'm trying to get the Kernel PCIe AER infrastructure to work on my
> > > > > ZynqMP based system. E.g. handle the events (correctable, uncorrectable
> > > > > etc). In my current tests, no AER interrupt is generated though. I'm
> > > > > currently using the "surprise down error status" in the uncorrectable
> > > > > error status register of the connected PCIe switch (PLX / Broadcom
> > > > > PEX8718). Here the bit is correctly logged in the PEX switch
> > > > > uncorrectable error status register but no interrupt is generated
> > > > > to the root-port / system. And hence no AER message(s) reported.
> > > 
> > > I think the error should also be logged in the Root Port AER
> > > Capability.  And of course the interrupt enable bits in the Root Error
> > > Command register would have to be set.
> > > 
> > > > > Does any one of you have some ideas on what might be missing? Why are
> > > > > these events not reported to the PCIe rootport driver via IRQ? Might
> > > > > this be a problem of the missing MSI-X support of the ZynqMP? The AER
> > > > > interrupt is connected as legacy IRQ:
> > > > > 
> > > > > cat /proc/interrupts | grep -i aer
> > > > >  58:          0          0          0          0  nwl_pcie:legacy   0 Level
> > > > > PCIe PME, aerdrv
> > > 
> > > I guess this means whatever INTx the Root Port is using is connected
> > > to IRQ 58?  Can you tell whether that INTx works if a device below the
> > > Root Port uses it?  Or whether it is asserted for PMEs?
> > > 
> > > > Error events (correctable, non-fatal and fatal) are reported by PCIe
> > > > devices to the Root Complex via PCIe error messages (Message code of TLP
> > > > is set to Error Message) and not via interrupts. Root Port is then
> > > > responsible to "convert" these PCIe error messages to MSI(X) interrupt
> > > > and report it to the system. According to PCIe spec, AER is supported
> > > > only via MSI(X) interrupts, not legacy INTx.
> > > 
> > > Where does it say that?  PCIe r5.0, sec 6.2.4.1.2 and 6.2.6, both
> > > mention INTx, and the diagram in 6.2.6 even shows possible
> > > platform-specific System Error signaling.
> > 
> > Kernel AER driver is not available when MSI is not supported:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/aer.c?h=v5.15#n112
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/portdrv_core.c?h=v5.15#n224
> > Originally this was my primary indication that AER is MSI(X)-only.
> 
> I think that is broken.  Looks like it was added by 3e77a3f7895e
> ("PCI: Disable AER with pci=nomsi"), which says that with "pci=nomsi",
> we see lost interrupts and lockdep inversions.
> 
> I don't know any more of the history behind that, but I suspect that
> turning off AER in that case just covered up some other Linux issue.

I have same feeling that something different is broken.

And now it reminds me that I was testing AER interrupts about year ago
and when booted kernel with pci=nomsi then AER kernel driver refused
start and I realized that AER is probably MSI-only. I have checked spec
for AER Root Error Status Register and I due to this I probably come to
the conclusion that AER must be MSI-only...

Is kernel going to enable support for AER when MSI is disabled? Or we
let it in current state forever?

> > And my understanding is that AER Root Error Status Register (7.8.4.10)
> > specifies Advanced Error Interrupt Message Number which indicates which
> > MSI(X) interrupt is used. And there is no information about INTx if you
> > enable particular reporting category via AER Root Error Command Register.
> > That is why I was in impression that AER interrupts are MSI-only.
> > 
> > But now I'm looking at 6.2.4.1.2 section and seems that AER can really
> > use INTx. So I was wrong here.
> > 
> > But why then kernel AER driver has check that AER is available only when
> > MSI is enabled? And not available when MSI is disabled?
> 
> Apart from the issue behind 3e77a3f7895e, I think this is just because
> the intersection of platforms that lack MSI and people with enough
> interest in AER is small.
> 
> The interrupt configuration in portdrv is nasty.  Although it looks
> like pcie_init_service_irqs() might now be smart enough to use the
> legacy INTx when MSI is not available.

In last pci-aardvark patches is added support for emulation of AER
interrupt via virtual INTx and we tested that it is working. portdrv
correctly allocates emulated INTx and when this interrupt is triggered
then kernel AER driver see it and log error into dmesg.

So I guess, it probably could work also with real INTx (if implemented
in HW correctly).
