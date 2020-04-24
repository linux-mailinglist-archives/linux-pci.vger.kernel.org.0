Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AF31B6F9A
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 10:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgDXINl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 04:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgDXINl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 04:13:41 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98F592074F;
        Fri, 24 Apr 2020 08:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587716020;
        bh=234Na+uhfv5cAwLUqSR3UJZEwNhLSqoXTeBHWCKylCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d7MpF0kUuzOF/RMwe6ODRsIAM8dZ/B1nNe6lfBOhUxGHVQ1nZh5SRafc0y2yDlRKT
         KtL/jpGhk1JHWb/YKhBbh8oz73CgPGKsipbY4ev9wOhZktkbKhiz3H7SsOmsUj3y3S
         PQD2sp27CBu4v6FF6v1UNOrmbFZrIxekKfC/dtwg=
Received: by pali.im (Postfix)
        id 314C882E; Fri, 24 Apr 2020 10:13:38 +0200 (CEST)
Date:   Fri, 24 Apr 2020 10:13:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 4/9] PCI: aardvark: issue PERST via GPIO
Message-ID: <20200424081338.j6v64vcx3okipomx@pali>
References: <20200423222312.5ghfmxcxnb2l5xtz@pali>
 <20200423224025.GA250713@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200423224025.GA250713@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 23 April 2020 17:40:25 Bjorn Helgaas wrote:
> On Fri, Apr 24, 2020 at 12:23:12AM +0200, Pali Rohár wrote:
> > On Thursday 23 April 2020 17:17:14 Bjorn Helgaas wrote:
> > > On Thu, Apr 23, 2020 at 09:02:02PM +0200, Pali Rohár wrote:
> > > > On Thursday 23 April 2020 13:41:51 Bjorn Helgaas wrote:
> > > > > [+cc Rob]
> > > > > 
> > > > > On Tue, Apr 21, 2020 at 01:16:56PM +0200, Marek Behún wrote:
> > > > > > From: Pali Rohár <pali@kernel.org>
> > > > > > 
> > > > > > Add support for issuing PERST via GPIO specified in 'reset-gpios'
> > > > > > property (as described in PCI device tree bindings).
> > > > > > 
> > > > > > Some buggy cards (e.g. Compex WLE900VX or WLE1216) are not detected
> > > > > > after reboot when PERST is not issued during driver initialization.
> > > > > 
> > > > > Does this slot support hotplug?
> > > > 
> > > > I have no idea. I have not heard that anybody tried hotplugging cards
> > > > with this aardvark pcie controller at runtime.
> > > > 
> > > > This patch fixes initialization only at boot time when cards were
> > > > plugged prior powering board on.
> > > > 
> > > > > If so, I don't think this fix will help the hot-add case, will it?
> > > > 
> > > > I even do not know if aardvark HW supports it. And if yes, I think it is
> > > > unimplemented and/or broken.
> > > > 
> > > > In documentation there is some interrupt register which could signal it,
> > > > but I it is not used by kernel's pci-aardvark.c driver.
> > > 
> > > "lspci -vv" will show you whether the hardware claims to support it,
> > > e.g.,
> > > 
> > >   00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port #1
> > >     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> > >       SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> > > 
> > > If the right combination of bits are set there, pciehp will claim the
> > > port and support hotplug.
> > 
> > aardvark controller does not have pci bridge on bus. Kernel aardvark
> > driver uses pci_bridge_emul_init() for registering emulated pci bridge.
> > 
> > Is hotplug flag from that emulated pci bridge relevant here?
> 
> I doubt it.

In case you are interested, here is output for that emulated pci bridge:

# lspci -vv -s 00:00.0
00:00.0 PCI bridge: Marvell Technology Group Ltd. Device 0100 (prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 44
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: None
        Memory behind bridge: e8000000-e82fffff [size=3M]
        Prefetchable memory behind bridge: None
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        [virtual] Expansion ROM at e8300000 [disabled] [size=2K]
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v1) Root Port (Slot-), MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 256 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <128ns, L1 <2us
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Kernel driver in use: pcieport

There is no "SltCap" line in lspci output.
