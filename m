Return-Path: <linux-pci+bounces-20514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511C5A216F7
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 04:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0D03A7784
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 03:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC7118B47E;
	Wed, 29 Jan 2025 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrOacMf4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF3B17E019;
	Wed, 29 Jan 2025 03:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738122021; cv=none; b=l1B+OjxIhHcpiOo8oqiDO3VgxRnhtEjDOjtGyBVhj6+XSF2s3vYX+Mw779UeWzzXe3QcLnOK5rm8wmsmAPIuu4wSdu2hMTBwNGWCOwKmiNvK3ViRcSt0tUGc3TVFLjiXQdUWBsMdHcDt5JN5HyuMe+zUT/AzREwNAbjlPtg4k9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738122021; c=relaxed/simple;
	bh=5d8804j0o3ySdiylmnNX/pA/dOJhQjobKfs3r6Bxw70=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WK9+OI299ces9SeFQ8acveSVdTlgngyiaqujIk1toUGlxXw9TTrOkGBH556kU7YbEELzmk7r5ftidPH4gXo/JqwOxE1IbM2Tz0V3dA2Dn+iaJ23a6SmbOmy/KC2AKWCtvyoq9VP+Iulsjv9U5KAvaUbOTr38zhquf3B3hLjS+0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrOacMf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63ACCC4CED3;
	Wed, 29 Jan 2025 03:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738122020;
	bh=5d8804j0o3ySdiylmnNX/pA/dOJhQjobKfs3r6Bxw70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OrOacMf4/D6xxSdp0G5CnRa90uhokTFLhS9ygSLwGXD+so8gzamRTrZa0NpAIQkZ3
	 Gx02dJC3EAGg2kDNs3kyY7wCL+wZSiLFsmnBZdbh5yUOxgLFbDjz+vzX4I3l8IdQCz
	 nn1Qw3Jq/S1tu9X8GOJ3llfYeG4EnM3feFU5vM+oURdOznIyBVZfmAyUZ+koOD0HeR
	 XMJ7eAHNM3N4AHL0ai52U4To2ZjkXFJh5WM/2gY6YQFkv5aRJmlCpFhbkG0s1OAeUK
	 +rZvmLT4mq+tsGUsyVTPRr0rchFe1GJX/JXPJt3LCjjJ1KxlXCKxg+IoF2e2yOBgdg
	 5lEG0GwFE0lUQ==
Date: Tue, 28 Jan 2025 21:40:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
	Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel <xen-devel@lists.xenproject.org>,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org
Subject: Re: Config space access to Mediatek MT7922 doesn't work after device
 reset in Xen PV dom0 (regression, Linux 6.12)
Message-ID: <20250129034018.GA398969@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5mfA32bvEn6yD-C@mail-itl>

On Wed, Jan 29, 2025 at 04:22:43AM +0100, Marek Marczykowski-Górecki wrote:
> On Tue, Jan 28, 2025 at 09:03:15PM -0600, Bjorn Helgaas wrote:
> > On Wed, Jan 29, 2025 at 03:10:49AM +0100, Marek Marczykowski-Górecki wrote:
> > > On Tue, Jan 28, 2025 at 07:15:26PM -0600, Bjorn Helgaas wrote:
> > > > On Fri, Jan 17, 2025 at 01:05:30PM +0100, Marek Marczykowski-Górecki wrote:
> > > > > After updating PV dom0 to Linux 6.12, The Mediatek MT7922 device reports
> > > > > all 0xff when accessing its config space. This happens only after device
> > > > > reset (which is also triggered when binding the device to the
> > > > > xen-pciback driver).
> > > > 
> > > > Thanks for the report and for all the debugging you've already done!
> > > > 
> > > > > Reproducer:
> > > > > 
> > > > >     # lspci -xs 01:00.0
> > > > >     01:00.0 Network controller: MEDIATEK Corp. MT7922 802.11ax PCI Express Wireless Network Adapter
> > > > >     00: c3 14 16 06 00 00 10 00 00 00 80 02 10 00 00 00
> > > > >     ...
> > > > >     # echo 1 > /sys/bus/pci/devices/0000:01:00.0/reset
> > > > >     # lspci -xs 01:00.0
> > > > >     01:00.0 Network controller: MEDIATEK Corp. MT7922 802.11ax PCI Express Wireless Network Adapter
> > > > >     00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > > >
> > > > > The same operation done on Linux 6.12 running without Xen works fine.
> > > > > 
> > > > > git bisect points at:
> > > > > 
> > > > >     commit d591f6804e7e1310881c9224d72247a2b65039af
> > > > >     Author: Bjorn Helgaas <bhelgaas@google.com>
> > > > >     Date:   Tue Aug 27 18:48:46 2024 -0500
> > > > > 
> > > > >     PCI: Wait for device readiness with Configuration RRS
> > > > > 
> > > > > part of that commit:
> > > > > @@ -1311,9 +1320,15 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
> > > > >                         return -ENOTTY;
> > > > >                 }
> > > > >  
> > > > > -               pci_read_config_dword(dev, PCI_COMMAND, &id);
> > > > > -               if (!PCI_POSSIBLE_ERROR(id))
> > > > > -                       break;
> > > > > +               if (root && root->config_crs_sv) {
> > > > > +                       pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
> > > > > +                       if (!pci_bus_crs_vendor_id(id))
> > > > > +                               break;
> > > > > +               } else {
> > > > > +                       pci_read_config_dword(dev, PCI_COMMAND, &id);
> > > > > +                       if (!PCI_POSSIBLE_ERROR(id))
> > > > > +                               break;
> > > > > +               }
> > > > >  
> > > > >     
> > > > > Adding some debugging, the PCI_VENDOR_ID read in pci_dev_wait() returns
> > > > > initially 0xffffffff. If I extend the condition with
> > > > > "&& !PCI_POSSIBLE_ERROR(id)", then the issue disappear. But reading the
> > > > > patch description, it would break VF.
> > > > > I'm not sure where the issue is, but given it breaks only when running
> > > > > with Xen, I guess something is wrong with "Configuration RRS Software
> > > > > Visibility" in that case.
> > > > 
> > > > I'm missing something.  If you get 0xffffffff, that is not the 0x0001
> > > > Vendor ID, so pci_dev_wait() should exit immediately.  
> > > 
> > > I'm not sure what is going on there either, but my _guess_ is that the
> > > loop exits too early due to the above. And it makes some further actions
> > > to fail.
> > 
> > When RRS SV is enabled, reading PCI_VENDOR_ID should always return
> > 0x0001 (if the device isn't ready and responds with RRS status) or the
> > valid Vendor ID.  I don't think it should ever return 0xffff (unless
> > the device is powered off, unplugged, or broken, of course).
> 
> Maybe it isn't really enabled when Xen is involved?
> By looking at lspci of the bridge for this device, I do see RootCtl: ...
> CRSVisible+, but maybe there is something else needed too?

As far as I know, CRSVisible+ is all that's needed to enable this, and
Linux always enables it if it's supported [3]

> Just in case, full lspci -vvvs 2.2 (the bridge):
> 
> 
> 00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Phoenix GPP Bridge (prog-if 00 [Normal decode])
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device 1453
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin ? routed to IRQ 102
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
> 	Memory behind bridge: 90b00000-90bfffff [size=1M] [32-bit]
> 	Prefetchable memory behind bridge: 8010900000-80109fffff [size=1M] [32-bit]
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: [50] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [58] Express (v2) Root Port (Slot+), IntMsgNum 0
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> 			ExtTag+ RBE+ TEE-IO-
> 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
> 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 128 bytes, MaxReadReq 512 bytes
> 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
> 		LnkCap:	Port #4, Speed 16GT/s, Width x1, ASPM L1, Exit Latency L1 <64us
> 			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
> 		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
> 			ExtSynch+ ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 5GT/s, Width x1
> 			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
> 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> 			Slot #0, PowerLimit 75W; Interlock- NoCompl+
> 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> 			Changed: MRL- PresDet- LinkState+
> 		RootCap: CRSVisible+
> 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
> 			 10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
> 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
> 			 FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd+
> 			 AtomicOpsCap: Routing+ 32bit+ 64bit+ 128bitCAS-
> 		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- ARIFwd-
> 			 AtomicOpsCtl: ReqEn- EgressBlck-
> 			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
> 			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
> 		LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+ 2Retimers+ DRS-
> 		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
> 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
> 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
> 			 Retimer- 2Retimers- CrosslinkRes: unsupported
> 	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
> 		Address: 00000000fee08000  Data: 4000
> 	Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD] Device 1453
> 	Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
> 	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
> 	Capabilities: [270 v1] Secondary PCI Express
> 		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
> 		LaneErrStat: 0
> 	Capabilities: [2a0 v1] Access Control Services
> 		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans+
> 		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
> 	Capabilities: [370 v1] L1 PM Substates
> 		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
> 			  PortCommonModeRestoreTime=10us PortTPowerOnTime=150us
> 		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> 			   T_CommonMode=10us LTR1.2_Threshold=166912ns
> 		L1SubCtl2: T_PwrOn=150us
> 	Capabilities: [400 v1] Data Link Feature <?>
> 	Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
> 	Capabilities: [440 v1] Lane Margining at the Receiver
> 		PortCap: Uses Driver-
> 		PortSta: MargReady- MargSoftReady-
> 	Kernel driver in use: pcieport
> 
> > > > But the log at
> > > > https://github.com/QubesOS/qubes-issues/issues/9689#issuecomment-2582927149
> > > > says it *doesn't* exit and eventually times out.
> > > 
> > > Note this log is from "working" kernel, so that timeout must be
> > > something else.
> > 
> > I saw it was labeled "NO BUG" but I'm not sure it's labeled correctly
> > since there are no interesting messages from the "BUG PRESENT" part.
> > Awfully funny coincidence if it's unrelated.
> 
> The timeout thing I have seen before, possibly also on a different
> hardware (although I'm not 100% sure), I think it's a different issue.
> 
> > > > And the lspci above shows ~0 data for much of the header, even though
> > > > the device must be ready by then.
> > > > 
> > > > I don't have any good ideas, but since the problem only happens with
> > > > Xen, and it seems to affect more than just the Vendor ID, maybe you
> > > > could instrument xen_pcibk_config_read() and see if there's something
> > > > wonky going on there?
> > > 
> > > This one is used when pcifront (from a different PV VM) is asking pciback
> > > to read something. I see the issue even before starting any other VM and
> > > not even attaching the device to the xen-pciback driver...
> > 
> > The report claims the problem only happens with Xen.  I'm not a Xen
> > person, and I don't know how to find the relevant config accessors.
> > The snippets of kernel messages I see at [1] all mention pciback, so
> > that's my only clue of where to look.  Bottom line, I have no idea
> > what the config accessor path is, and maybe we could learn something
> > by looking at whatever it is.
> 
> AFAIK there are no separate config accessors under Xen dom0, the default
> ones are used. xen-pcifront takes over PCI config space access (and few
> more) only in a domU (and only for PV), when PCI passthrough is used.
> Here, it didn't went that far...
> 
> But then, Xen may intercept such access [2]. If I read it right, it
> should allow all access (is_hardware_domain(dom0)==true, and also the
> device is not on ro_map - otherwise reset wouldn't work at all).

I guess the code at [2] is running in user mode and uses Linux
syscalls for config access?  Is it straceable?

Can you reproduce this without Xen at all?  If so, can you post a
complete dmesg and complete lspci -vv somewhere?

> > [1] https://github.com/QubesOS/qubes-issues/issues/9689#issuecomment-2582927149
> 
> [2] https://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=xen/arch/x86/pv/emul-priv-op.c;h=70150c27227661baa253af8693ff00f2ab640a98;hb=HEAD#l295

[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/probe.c?id=v6.13#n1208

