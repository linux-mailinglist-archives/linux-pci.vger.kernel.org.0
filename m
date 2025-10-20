Return-Path: <linux-pci+bounces-38749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F6ABF15EB
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 14:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B03A334D21F
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 12:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F273128DC;
	Mon, 20 Oct 2025 12:56:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1362F83DE
	for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964980; cv=none; b=qYxHS9qKtf6adGnK3ggJmGQ5B19gZKvcPWVHnJYJKQK4enLmZlZbq+mJMgtoHf5vPs4ffnW9TRfAi5sHo4UTMWjrrruQOr/QE6f+B3tbJyFpCTp1v8xccc21NZvSuxEI/Jx2RjGwO55tH0Vc5qSyQYBwqRzp8HLNSoG7bR/+3iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964980; c=relaxed/simple;
	bh=/cHiwmvrYaCE8WGF5i1mi3cHezaEtrIoEX2m4DuEtK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULhHdxaWjQHn39Jbxm/Ulmsz/nS8oGsdVhcV4xHp9gOiEU9Yzgnrp4jBsOmT9TTn9JGGeKKTT42KPZ41O8suJy2Al6Pynj7TEHhtFKdoD1eBmelMzOoraCnAODbtRm8qYji5yM1O1o9TdwpMw2Hlh7HU3XbGPrs5/cFOs/TUerU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avm99963.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avm99963.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4711a2fc6fbso632035e9.0
        for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 05:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760964973; x=1761569773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXoZ86NMc4mOsBxnrGrLmkCb/7Ycl+i11wKzihd2YMA=;
        b=jf1EWn9a7wd+1UhlkmY6Ib9BOBw4rLrkYY1pJMwi5wz//nCZDwFnHMPdpg6Q2L33Mp
         1khd+L2nnq5VdyavswTsRuuzjgD6VMwDubKC+5ElcDQmmhPQLTqLO8R+/z6JzXBMA3I7
         Fwxm3+Y0DPTKbNvgXKFqSSONAPUlLWcSEDO7QhqRGy6gZSMFDuyhzMc73VsXAurL5/DX
         XGcpKH+ebmbCwKpsblUO5+kCj0k7CmhF9SvExq5lSY/WZqYH3xJM8vY4f1xKPpTUqKGG
         dVO9QfwdPhm/MuHWPw8feUpKfHC/UDcDpn9xQ/YT30tlQgtDqy/BvIaSB+PUl7vVVl3N
         nLfg==
X-Forwarded-Encrypted: i=1; AJvYcCUgdu3pzh6XxvaE3DR2PUbTa15kqcAyg1Pd6oD3E41hQzj2U4LmVv5Rem79gu+wzyadSERLReCDnQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkQDqHBsIbngL6x5w9vje2zgM5EY7lzaml399FvCSTgpTId5fk
	ZMdvKHe9YRBmkfnDyf9fpfi7Djg92wxB2RClJ/Zu32nfsnCtnymnpI4T
X-Gm-Gg: ASbGnctDW1rEx728/iNK78Qz3DkVQa5rB/XECyhvDoOAPi7isewDJNZhg/esfdIj61b
	YYofb4Sx80W41xWePcZPZM06u8LJGglqo5f5CFstmGwEe8ytFdq5s/uWo0vNirzRYmpgOqAsbU4
	nzvZy2XdpPRGHsR5R9I4csemJ24eHUF3gaJIalGdx+/OWCzAG4UC2KEeXM7MUTkmEn1o4CXWusZ
	EXtEAkWxRrH2PYx7yqIZQ4Lszt38ovVsNw63KN9oX7jm9yl0WweHQgLaEphmV5YHWS0NmzfAT4z
	pjoVnP4JPeDPf+ZPTwxBcxUlrkHAw8LuH6XEEtm7LOPs8SfjR7mejrz+LoAV9qnXdMDuFChgUXt
	M4/gMNxrrtq/bo/tIupdJ75gXHV6uGz3KjfJBqIzgoh/2u8PTslnFIwGDJ532BhV/rXG4d/8a6x
	yMQxaSz5aVWuF051iaNo3Zh9bcuSWaf2Ark7nfGJune1/2
X-Google-Smtp-Source: AGHT+IHuyHIyY1j+iMx/AZvJkKZFIXF6Nwcb6ENutFefl1GU2l91pu9lUnJEmGgj+ImoyITS71Z1MQ==
X-Received: by 2002:a05:600d:61ef:b0:471:1d8e:3c7c with SMTP id 5b1f17b1804b1-4711d8e41a8mr42405045e9.4.1760964973293;
        Mon, 20 Oct 2025 05:56:13 -0700 (PDT)
Received: from pixelbook (181.red-83-42-91.dynamicip.rima-tde.net. [83.42.91.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c82c9sm229592905e9.14.2025.10.20.05.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 05:56:12 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:56:10 +0200
From: =?utf-8?Q?Adri=C3=A0_Vilanova_Mart=C3=ADnez?= <me@avm99963.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: bhelgaas@google.com, regressions@lists.linux.dev, 
	linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] Intel Wireless adapter is not detected until
 suspending to RAM and resuming
Message-ID: <lpntymy3w6ryvyo2trpqkl7i3aibofzqcp7p5jhxjlkse645iq@fepikfj4tcyk>
References: <owewi3sswao4jt5qn3ntm533lvxe3jlovhjbdufq3uedbuztxt@76nft22vboxv>
 <d0b6105f-744f-40d9-b4b7-1fa645038d0b@kernel.org>
 <h6wkxjrkxh3ea5aqexqrx4d6xb2t2xbirvznupnbgro64qytfs@mn2jg2c6owrj>
 <rvep55wtk2q4j46eqcxkfgb2bwijunefyltygfyb44trbzblx2@3ou3jcybjt3p>
 <6b3d282c-b3cd-4979-b26b-ae9b28b9d634@kernel.org>
 <kaieqe37mjmizjv4regyw67z7hwa3ac3k2mwcjsgq2mj7redpm@xsfb4mtyjblf>
 <a08c71e2-18ca-491b-8982-47214a35445b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="x5b7evi746yntaci"
Content-Disposition: inline
In-Reply-To: <a08c71e2-18ca-491b-8982-47214a35445b@kernel.org>


--x5b7evi746yntaci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 19, 2025 at 07:25:08PM -0500, Mario Limonciello wrote:
> Thanks, knowing that pcie_aspm=off helps I think we should compare output
> for:
> 
> # sudo lspci -vvnn

Sure, I'm attaching the outputs of this command for all the scenarios.
There are some differences, so it seems promising.

I'm building the Kernel on the following commits:

- "Kernel without 4d4c10f763 and 907a7a2e5b": 1c64efcb08, applying on
top reverts for these 2 commits. [locally compiled version
6.18.0-rc1-local-reverted-pci-issues-00351-gbbaff7ff47dd]
- "Kernel with 4d4c10f763 and 907a7a2e5b": 1c64efcb08 (last commit I
pulled from mainline last week). [locally compiled version ???]

> In the following cases (all without pcie_aspm=off):
> 
> 1) At bootup; a kernel without 4d4c10f763 and 907a7a2e5b

See 01_lspci_bootup_without_4d4c10f763_907a7a2e5b.txt

> 2) At bootup; a kernel with 4d4c10f763 and 907a7a2e5b

See 02_lspci_bootup_with_4d4c10f763_907a7a2e5b.txt

> 3) After suspend/resume; a kernel without 4d4c10f763 and 907a7a2e5b4

See 03_lspci_after_suspend_resume_without_4d4c10f763_907a7a2e5b.txt

> 4) After suspend/resume; a kernel with 4d4c10f763 and 907a7a2e5b

See 04_lspci_after_suspend_resume_with_4d4c10f763_907a7a2e5b.txt

Again, thank you so much! I really appreciate your help in
troubleshooting this.

PS: I'm trimming the email quotes as per
https://subspace.kernel.org/etiquette.html#trim-your-quotes-when-replying.
I've never done this before and it feels wrong, but it is indeed easier
to follow the conversation if I do this.

--x5b7evi746yntaci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="01_lspci_bootup_without_4d4c10f763_907a7a2e5b.txt"

00:00.0 Host bridge [0600]: Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers [8086:590c] (rev 02)
	Subsystem: Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers [8086:590c]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Intel Capabilities v1
		CapA: Peg60Dis- Peg12Dis+ Peg11Dis+ Peg10Dis+ PeLWUDis+ DmiWidth=x4
		      EccDis+ ForceEccEn- VTdDis- DmiG2Dis+ PegG2Dis+ DDRMaxSize=Unlimited
		      1NDis- CDDis- DDPCDis+ X2APICEn+ PDCDis- IGDis- CDID=0 CRID=2
		      DDROCCAP- OCEn- DDRWrtVrefEn- DDR3LEn+
		CapB: ImguDis- OCbySSKUCap- OCbySSKUEn- SMTCap+ CacheSzCap 0x3
		      SoftBinCap- DDR3MaxFreqWithRef100=Disabled PegG3Dis+
		      PkgTyp- AddGfxEn+ AddGfxCap- PegX16Dis+ DmiG3Dis+ GmmDis-
		      DDR3MaxFreq=2666MHz LPDDR3En+
		CapC: PegG4Dis- DDR4MaxFreq=Unlimited LPDDREn- LPDDR4MaxFreq=0MHz LPDDR4En+
		      QClkGvDis- SgxDis- BClkOC=Disabled IddDis- Pipe3Dis- Gear1MaxFreq=Unlimited
	Kernel driver in use: skl_uncore

00:02.0 VGA compatible controller [0300]: Intel Corporation HD Graphics 615 [8086:591e] (rev 02) (prog-if 00 [VGA controller])
	DeviceName: VGA compatible controller
	Subsystem: Intel Corporation Device [8086:2212]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 126
	Region 0: Memory at cf000000 (64-bit, non-prefetchable) [size=16M]
	Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at ffc0 [size=64]
	Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
	Capabilities: [40] Vendor Specific Information: Intel Capabilities v1
		CapA: Peg60Dis- Peg12Dis+ Peg11Dis+ Peg10Dis+ PeLWUDis+ DmiWidth=x4
		      EccDis+ ForceEccEn- VTdDis- DmiG2Dis+ PegG2Dis+ DDRMaxSize=Unlimited
		      1NDis- CDDis- DDPCDis+ X2APICEn+ PDCDis- IGDis- CDID=0 CRID=2
		      DDROCCAP- OCEn- DDRWrtVrefEn- DDR3LEn+
		CapB: ImguDis- OCbySSKUCap- OCbySSKUEn- SMTCap+ CacheSzCap 0x3
		      SoftBinCap- DDR3MaxFreqWithRef100=Disabled PegG3Dis+
		      PkgTyp- AddGfxEn+ AddGfxCap- PegX16Dis+ DmiG3Dis+ GmmDis-
		      DDR3MaxFreq=2666MHz LPDDR3En+
	Capabilities: [70] Express (v2) Root Complex Integrated Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+ FLReset+ TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
	Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00018  Data: 0000
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Process Address Space ID (PASID)
		PASIDCap: Exec- Priv-, Max PASID Width: 14
		PASIDCtl: Enable- Exec- Priv-
	Capabilities: [200 v1] Address Translation Service (ATS)
		ATSCap:	Invalidate Queue Depth: 00
		ATSCtl:	Enable-, Smallest Translation Unit: 00
	Capabilities: [300 v1] Page Request Interface (PRI)
		PRICtl: Enable- Reset-
		PRISta: RF- UPRGI- Stopped+ PASID+
		Page Request Capacity: 00008000, Page Request Allocation: 00000000
	Kernel driver in use: i915
	Kernel modules: i915

00:04.0 Signal processing controller [1180]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem [8086:1903] (rev 02)
	Subsystem: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem [8086:1903]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at ceed8000 (64-bit, non-prefetchable) [size=32K]
	Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [d0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [e0] Vendor Specific Information: Intel Capabilities v1
		CapA: Peg60Dis- Peg12Dis+ Peg11Dis+ Peg10Dis+ PeLWUDis+ DmiWidth=x4
		      EccDis+ ForceEccEn- VTdDis- DmiG2Dis+ PegG2Dis+ DDRMaxSize=Unlimited
		      1NDis- CDDis- DDPCDis+ X2APICEn+ PDCDis- IGDis- CDID=0 CRID=2
		      DDROCCAP- OCEn- DDRWrtVrefEn- DDR3LEn+
		CapB: ImguDis- OCbySSKUCap- OCbySSKUEn- SMTCap+ CacheSzCap 0x3
		      SoftBinCap- DDR3MaxFreqWithRef100=Disabled PegG3Dis+
		      PkgTyp- AddGfxEn+ AddGfxCap- PegX16Dis+ DmiG3Dis+ GmmDis-
		      DDR3MaxFreq=2666MHz LPDDR3En+
	Kernel driver in use: proc_thermal
	Kernel modules: processor_thermal_device_pci_legacy

00:14.0 USB controller [0c03]: Intel Corporation Sunrise Point-LP USB 3.0 xHCI Controller [8086:9d2f] (rev 21) (prog-if 30 [XHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 121
	Region 0: Memory at ceef0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable+ Count=8/8 Maskable- 64bit+
		Address: 00000000fee00318  Data: 0000
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

00:14.2 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Thermal subsystem [8086:9d31] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Thermal subsystem [8086:9d31]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at ceecf000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Kernel driver in use: intel_pch_thermal
	Kernel modules: intel_pch_thermal

00:15.0 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #0 [8086:9d60] (rev 21)
	Subsystem: Intel Corporation 100 Series PCH/Sunrise Point PCH I2C0 [Skylake/Kaby Lake LPSS I2C] [8086:9d60]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at ceece000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:15.1 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #1 [8086:9d61] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #1 [8086:9d61]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at ceecd000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:15.2 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #2 [8086:9d62] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #2 [8086:9d62]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at ceecc000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:19.0 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO UART Controller #2 [8086:9d66] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO UART Controller #2 [8086:9d66]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 32
	Region 0: Memory at fe030000 (64-bit, non-prefetchable) [size=4K]
	Region 2: Memory at ceeca000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:19.2 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #4 [8086:9d64] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #4 [8086:9d64]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 34
	Region 0: Memory at ceec9000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:1c.0 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI Express Root Port #1 [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
	Subsystem: Intel Corporation Sunrise Point-LP PCI Express Root Port #1 [8086:9d10]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 120
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 2000-2fff [size=4K] [16-bit]
	Memory behind bridge: cef00000-ceffffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: 27f000000-27f1fffff [size=2M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), IntMsgNum 0
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+ TEE-IO-
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 8GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+ FltModeDis-
		LnkSta:	Speed 2.5GT/s, Width x1
			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 10W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState-
		RootCap: CRSVisible-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00218  Data: 0000
	Capabilities: [90] Subsystem: Intel Corporation Sunrise Point-LP PCI Express Root Port #1 [8086:9d10]
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO+ CmpltAbrt- UnxCmplt+ RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr- HeaderOF-
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
		RootCmd: CERptEn+ NFERptEn+ FERptEn+
		RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
			 FirstFatal- NonFatalMsg- FatalMsg- IntMsgNum 0
		ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
	Capabilities: [140 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=40us PortTPowerOnTime=44us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=40us LTR1.2_Threshold=106496ns
		L1SubCtl2: T_PwrOn=60us
	Capabilities: [220 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1e.0 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO UART Controller #0 [8086:9d27] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO UART Controller #0 [8086:9d27]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at ceec8000 (64-bit, non-prefetchable) [size=4K]
	Region 2: Memory at ceec7000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:1e.2 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO SPI Controller #0 [8086:9d29] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO SPI Controller #0 [8086:9d29]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 22
	Region 0: Memory at ceec6000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:1e.4 SD Host controller [0805]: Intel Corporation Device [8086:9d2b] (rev 21) (prog-if 01)
	Subsystem: Intel Corporation Device [8086:9d2b]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 21
	Region 0: Memory at ceec5000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: sdhci-pci
	Kernel modules: sdhci_pci

00:1f.0 ISA bridge [0601]: Intel Corporation Device [8086:9d4b] (rev 21)
	Subsystem: Intel Corporation Device [8086:9d4b]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:1f.2 Memory controller [0580]: Intel Corporation Sunrise Point-LP PMC [8086:9d21] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP PMC [8086:9d21]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: Memory at ceed4000 (32-bit, non-prefetchable) [size=16K]

00:1f.3 Multimedia audio controller [0401]: Intel Corporation Sunrise Point-LP HD Audio [8086:9d71] (rev 21)
	DeviceName: Multimedia audio controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 129
	Region 0: Memory at ceed0000 (64-bit, non-prefetchable) [size=16K]
	Region 4: Memory at ceee0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00458  Data: 0000
	Kernel driver in use: snd_soc_avs
	Kernel modules: snd_soc_avs, snd_hda_intel

00:1f.4 SMBus [0c05]: Intel Corporation Sunrise Point-LP SMBus [8086:9d23] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP SMBus [8086:9d23]
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at ceec3000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at efa0 [size=32]
	Kernel driver in use: i801_smbus
	Kernel modules: i2c_i801

00:1f.5 Non-VGA unclassified device [0000]: Intel Corporation Device [8086:9d24] (rev 21)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: Memory at fe010000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: intel-spi
	Kernel modules: spi_intel_pci

01:00.0 Network controller [0280]: Intel Corporation Wireless 7265 [8086:095a] (rev b9)
	Subsystem: Intel Corporation Device [8086:9e10]
	Physical Slot: 0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 127
	Region 0: Memory at cef00000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee002d8  Data: 0000
	Capabilities: [40] Express (v2) Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0W TEE-IO-
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L1, Exit Latency L1 <32us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt- FltModeDis-
		LnkSta:	Speed 2.5GT/s, Width x1
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr- HeaderOF-
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [140 v1] Device Serial Number 28-c6-3f-ff-ff-30-93-5f
	Capabilities: [14c v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Capabilities: [154 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=30us PortTPowerOnTime=60us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=0us LTR1.2_Threshold=106496ns
		L1SubCtl2: T_PwrOn=60us
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi


--x5b7evi746yntaci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="02_lspci_bootup_with_4d4c10f763_907a7a2e5b.txt"

00:00.0 Host bridge [0600]: Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers [8086:590c] (rev 02)
	Subsystem: Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers [8086:590c]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Intel Capabilities v1
		CapA: Peg60Dis- Peg12Dis+ Peg11Dis+ Peg10Dis+ PeLWUDis+ DmiWidth=x4
		      EccDis+ ForceEccEn- VTdDis- DmiG2Dis+ PegG2Dis+ DDRMaxSize=Unlimited
		      1NDis- CDDis- DDPCDis+ X2APICEn+ PDCDis- IGDis- CDID=0 CRID=2
		      DDROCCAP- OCEn- DDRWrtVrefEn- DDR3LEn+
		CapB: ImguDis- OCbySSKUCap- OCbySSKUEn- SMTCap+ CacheSzCap 0x3
		      SoftBinCap- DDR3MaxFreqWithRef100=Disabled PegG3Dis+
		      PkgTyp- AddGfxEn+ AddGfxCap- PegX16Dis+ DmiG3Dis+ GmmDis-
		      DDR3MaxFreq=2666MHz LPDDR3En+
		CapC: PegG4Dis- DDR4MaxFreq=Unlimited LPDDREn- LPDDR4MaxFreq=0MHz LPDDR4En+
		      QClkGvDis- SgxDis- BClkOC=Disabled IddDis- Pipe3Dis- Gear1MaxFreq=Unlimited
	Kernel driver in use: skl_uncore

00:02.0 VGA compatible controller [0300]: Intel Corporation HD Graphics 615 [8086:591e] (rev 02) (prog-if 00 [VGA controller])
	DeviceName: VGA compatible controller
	Subsystem: Intel Corporation Device [8086:2212]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 126
	Region 0: Memory at cf000000 (64-bit, non-prefetchable) [size=16M]
	Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at ffc0 [size=64]
	Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
	Capabilities: [40] Vendor Specific Information: Intel Capabilities v1
		CapA: Peg60Dis- Peg12Dis+ Peg11Dis+ Peg10Dis+ PeLWUDis+ DmiWidth=x4
		      EccDis+ ForceEccEn- VTdDis- DmiG2Dis+ PegG2Dis+ DDRMaxSize=Unlimited
		      1NDis- CDDis- DDPCDis+ X2APICEn+ PDCDis- IGDis- CDID=0 CRID=2
		      DDROCCAP- OCEn- DDRWrtVrefEn- DDR3LEn+
		CapB: ImguDis- OCbySSKUCap- OCbySSKUEn- SMTCap+ CacheSzCap 0x3
		      SoftBinCap- DDR3MaxFreqWithRef100=Disabled PegG3Dis+
		      PkgTyp- AddGfxEn+ AddGfxCap- PegX16Dis+ DmiG3Dis+ GmmDis-
		      DDR3MaxFreq=2666MHz LPDDR3En+
	Capabilities: [70] Express (v2) Root Complex Integrated Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+ FLReset+ TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
	Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00018  Data: 0000
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Process Address Space ID (PASID)
		PASIDCap: Exec- Priv-, Max PASID Width: 14
		PASIDCtl: Enable- Exec- Priv-
	Capabilities: [200 v1] Address Translation Service (ATS)
		ATSCap:	Invalidate Queue Depth: 00
		ATSCtl:	Enable-, Smallest Translation Unit: 00
	Capabilities: [300 v1] Page Request Interface (PRI)
		PRICtl: Enable- Reset-
		PRISta: RF- UPRGI- Stopped+ PASID+
		Page Request Capacity: 00008000, Page Request Allocation: 00000000
	Kernel driver in use: i915
	Kernel modules: i915

00:04.0 Signal processing controller [1180]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem [8086:1903] (rev 02)
	Subsystem: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem [8086:1903]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at ceed8000 (64-bit, non-prefetchable) [size=32K]
	Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [d0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [e0] Vendor Specific Information: Intel Capabilities v1
		CapA: Peg60Dis- Peg12Dis+ Peg11Dis+ Peg10Dis+ PeLWUDis+ DmiWidth=x4
		      EccDis+ ForceEccEn- VTdDis- DmiG2Dis+ PegG2Dis+ DDRMaxSize=Unlimited
		      1NDis- CDDis- DDPCDis+ X2APICEn+ PDCDis- IGDis- CDID=0 CRID=2
		      DDROCCAP- OCEn- DDRWrtVrefEn- DDR3LEn+
		CapB: ImguDis- OCbySSKUCap- OCbySSKUEn- SMTCap+ CacheSzCap 0x3
		      SoftBinCap- DDR3MaxFreqWithRef100=Disabled PegG3Dis+
		      PkgTyp- AddGfxEn+ AddGfxCap- PegX16Dis+ DmiG3Dis+ GmmDis-
		      DDR3MaxFreq=2666MHz LPDDR3En+
	Kernel driver in use: proc_thermal
	Kernel modules: processor_thermal_device_pci_legacy

00:14.0 USB controller [0c03]: Intel Corporation Sunrise Point-LP USB 3.0 xHCI Controller [8086:9d2f] (rev 21) (prog-if 30 [XHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 121
	Region 0: Memory at ceef0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable+ Count=8/8 Maskable- 64bit+
		Address: 00000000fee00318  Data: 0000
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

00:14.2 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Thermal subsystem [8086:9d31] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Thermal subsystem [8086:9d31]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at ceecf000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Kernel driver in use: intel_pch_thermal
	Kernel modules: intel_pch_thermal

00:15.0 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #0 [8086:9d60] (rev 21)
	Subsystem: Intel Corporation 100 Series PCH/Sunrise Point PCH I2C0 [Skylake/Kaby Lake LPSS I2C] [8086:9d60]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at ceece000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:15.1 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #1 [8086:9d61] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #1 [8086:9d61]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at ceecd000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:15.2 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #2 [8086:9d62] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #2 [8086:9d62]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at ceecc000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:19.0 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO UART Controller #2 [8086:9d66] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO UART Controller #2 [8086:9d66]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 32
	Region 0: Memory at fe030000 (64-bit, non-prefetchable) [size=4K]
	Region 2: Memory at ceeca000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:19.2 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #4 [8086:9d64] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #4 [8086:9d64]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 34
	Region 0: Memory at ceec9000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:1c.0 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI Express Root Port #1 [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
	Subsystem: Intel Corporation Sunrise Point-LP PCI Express Root Port #1 [8086:9d10]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 120
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 2000-2fff [size=4K] [16-bit]
	Memory behind bridge: cef00000-ceffffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: 27f000000-27f1fffff [size=2M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), IntMsgNum 0
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+ TEE-IO-
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 8GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+ FltModeDis-
		LnkSta:	Speed 2.5GT/s, Width x1
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 10W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCap: CRSVisible-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
			 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00218  Data: 0000
	Capabilities: [90] Subsystem: Intel Corporation Sunrise Point-LP PCI Express Root Port #1 [8086:9d10]
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO+ CmpltAbrt- UnxCmplt+ RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr- HeaderOF-
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
		RootCmd: CERptEn+ NFERptEn+ FERptEn+
		RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
			 FirstFatal- NonFatalMsg- FatalMsg- IntMsgNum 0
		ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
	Capabilities: [140 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=40us PortTPowerOnTime=44us
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=40us LTR1.2_Threshold=106496ns
		L1SubCtl2: T_PwrOn=60us
	Capabilities: [220 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1e.0 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO UART Controller #0 [8086:9d27] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO UART Controller #0 [8086:9d27]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at ceec8000 (64-bit, non-prefetchable) [size=4K]
	Region 2: Memory at ceec7000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:1e.2 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO SPI Controller #0 [8086:9d29] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO SPI Controller #0 [8086:9d29]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 22
	Region 0: Memory at ceec6000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:1e.4 SD Host controller [0805]: Intel Corporation Device [8086:9d2b] (rev 21) (prog-if 01)
	Subsystem: Intel Corporation Device [8086:9d2b]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 21
	Region 0: Memory at ceec5000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: sdhci-pci
	Kernel modules: sdhci_pci

00:1f.0 ISA bridge [0601]: Intel Corporation Device [8086:9d4b] (rev 21)
	Subsystem: Intel Corporation Device [8086:9d4b]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:1f.2 Memory controller [0580]: Intel Corporation Sunrise Point-LP PMC [8086:9d21] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP PMC [8086:9d21]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: Memory at ceed4000 (32-bit, non-prefetchable) [size=16K]

00:1f.3 Multimedia audio controller [0401]: Intel Corporation Sunrise Point-LP HD Audio [8086:9d71] (rev 21)
	DeviceName: Multimedia audio controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 127
	Region 0: Memory at ceed0000 (64-bit, non-prefetchable) [size=16K]
	Region 4: Memory at ceee0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee002f8  Data: 0000
	Kernel driver in use: snd_soc_avs
	Kernel modules: snd_soc_avs, snd_hda_intel

00:1f.4 SMBus [0c05]: Intel Corporation Sunrise Point-LP SMBus [8086:9d23] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP SMBus [8086:9d23]
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at ceec3000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at efa0 [size=32]
	Kernel driver in use: i801_smbus
	Kernel modules: i2c_i801

00:1f.5 Non-VGA unclassified device [0000]: Intel Corporation Device [8086:9d24] (rev 21)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: Memory at fe010000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: intel-spi
	Kernel modules: spi_intel_pci


--x5b7evi746yntaci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="03_lspci_after_suspend_resume_without_4d4c10f763_907a7a2e5b.txt"

00:00.0 Host bridge [0600]: Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers [8086:590c] (rev 02)
	Subsystem: Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers [8086:590c]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Intel Capabilities v1
		CapA: Peg60Dis- Peg12Dis+ Peg11Dis+ Peg10Dis+ PeLWUDis+ DmiWidth=x4
		      EccDis+ ForceEccEn- VTdDis- DmiG2Dis+ PegG2Dis+ DDRMaxSize=Unlimited
		      1NDis- CDDis- DDPCDis+ X2APICEn+ PDCDis- IGDis- CDID=0 CRID=2
		      DDROCCAP- OCEn- DDRWrtVrefEn- DDR3LEn+
		CapB: ImguDis- OCbySSKUCap- OCbySSKUEn- SMTCap+ CacheSzCap 0x3
		      SoftBinCap- DDR3MaxFreqWithRef100=Disabled PegG3Dis+
		      PkgTyp- AddGfxEn+ AddGfxCap- PegX16Dis+ DmiG3Dis+ GmmDis-
		      DDR3MaxFreq=2666MHz LPDDR3En+
		CapC: PegG4Dis- DDR4MaxFreq=Unlimited LPDDREn- LPDDR4MaxFreq=0MHz LPDDR4En+
		      QClkGvDis- SgxDis- BClkOC=Disabled IddDis- Pipe3Dis- Gear1MaxFreq=Unlimited
	Kernel driver in use: skl_uncore

00:02.0 VGA compatible controller [0300]: Intel Corporation HD Graphics 615 [8086:591e] (rev 02) (prog-if 00 [VGA controller])
	DeviceName: VGA compatible controller
	Subsystem: Intel Corporation Device [8086:2212]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 126
	Region 0: Memory at cf000000 (64-bit, non-prefetchable) [size=16M]
	Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at ffc0 [size=64]
	Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
	Capabilities: [40] Vendor Specific Information: Intel Capabilities v1
		CapA: Peg60Dis- Peg12Dis+ Peg11Dis+ Peg10Dis+ PeLWUDis+ DmiWidth=x4
		      EccDis+ ForceEccEn- VTdDis- DmiG2Dis+ PegG2Dis+ DDRMaxSize=Unlimited
		      1NDis- CDDis- DDPCDis+ X2APICEn+ PDCDis- IGDis- CDID=0 CRID=2
		      DDROCCAP- OCEn- DDRWrtVrefEn- DDR3LEn+
		CapB: ImguDis- OCbySSKUCap- OCbySSKUEn- SMTCap+ CacheSzCap 0x3
		      SoftBinCap- DDR3MaxFreqWithRef100=Disabled PegG3Dis+
		      PkgTyp- AddGfxEn+ AddGfxCap- PegX16Dis+ DmiG3Dis+ GmmDis-
		      DDR3MaxFreq=2666MHz LPDDR3En+
	Capabilities: [70] Express (v2) Root Complex Integrated Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+ FLReset+ TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
	Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00018  Data: 0000
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Process Address Space ID (PASID)
		PASIDCap: Exec- Priv-, Max PASID Width: 14
		PASIDCtl: Enable- Exec- Priv-
	Capabilities: [200 v1] Address Translation Service (ATS)
		ATSCap:	Invalidate Queue Depth: 00
		ATSCtl:	Enable-, Smallest Translation Unit: 00
	Capabilities: [300 v1] Page Request Interface (PRI)
		PRICtl: Enable- Reset-
		PRISta: RF- UPRGI- Stopped+ PASID+
		Page Request Capacity: 00008000, Page Request Allocation: 00000000
	Kernel driver in use: i915
	Kernel modules: i915

00:04.0 Signal processing controller [1180]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem [8086:1903] (rev 02)
	Subsystem: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem [8086:1903]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at ceed8000 (64-bit, non-prefetchable) [size=32K]
	Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [d0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [e0] Vendor Specific Information: Intel Capabilities v1
		CapA: Peg60Dis- Peg12Dis+ Peg11Dis+ Peg10Dis+ PeLWUDis+ DmiWidth=x4
		      EccDis+ ForceEccEn- VTdDis- DmiG2Dis+ PegG2Dis+ DDRMaxSize=Unlimited
		      1NDis- CDDis- DDPCDis+ X2APICEn+ PDCDis- IGDis- CDID=0 CRID=2
		      DDROCCAP- OCEn- DDRWrtVrefEn- DDR3LEn+
		CapB: ImguDis- OCbySSKUCap- OCbySSKUEn- SMTCap+ CacheSzCap 0x3
		      SoftBinCap- DDR3MaxFreqWithRef100=Disabled PegG3Dis+
		      PkgTyp- AddGfxEn+ AddGfxCap- PegX16Dis+ DmiG3Dis+ GmmDis-
		      DDR3MaxFreq=2666MHz LPDDR3En+
	Kernel driver in use: proc_thermal
	Kernel modules: processor_thermal_device_pci_legacy

00:14.0 USB controller [0c03]: Intel Corporation Sunrise Point-LP USB 3.0 xHCI Controller [8086:9d2f] (rev 21) (prog-if 30 [XHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 121
	Region 0: Memory at ceef0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable+ Count=8/8 Maskable- 64bit+
		Address: 00000000fee00318  Data: 0000
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

00:14.2 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Thermal subsystem [8086:9d31] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Thermal subsystem [8086:9d31]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at ceecf000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Kernel driver in use: intel_pch_thermal
	Kernel modules: intel_pch_thermal

00:15.0 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #0 [8086:9d60] (rev 21)
	Subsystem: Intel Corporation 100 Series PCH/Sunrise Point PCH I2C0 [Skylake/Kaby Lake LPSS I2C] [8086:9d60]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at ceece000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:15.1 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #1 [8086:9d61] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #1 [8086:9d61]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at ceecd000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:15.2 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #2 [8086:9d62] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #2 [8086:9d62]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at ceecc000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:19.0 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO UART Controller #2 [8086:9d66] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO UART Controller #2 [8086:9d66]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 32
	Region 0: Memory at fe030000 (64-bit, non-prefetchable) [size=4K]
	Region 2: Memory at ceeca000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:19.2 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #4 [8086:9d64] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #4 [8086:9d64]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 34
	Region 0: Memory at ceec9000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:1c.0 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI Express Root Port #1 [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
	Subsystem: Intel Corporation Sunrise Point-LP PCI Express Root Port #1 [8086:9d10]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 120
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 2000-2fff [size=4K] [16-bit]
	Memory behind bridge: cef00000-ceffffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: 27f000000-27f1fffff [size=2M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), IntMsgNum 0
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+ TEE-IO-
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 8GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+ FltModeDis-
		LnkSta:	Speed 2.5GT/s, Width x1
			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 10W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCap: CRSVisible-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00218  Data: 0000
	Capabilities: [90] Subsystem: Intel Corporation Sunrise Point-LP PCI Express Root Port #1 [8086:9d10]
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO+ CmpltAbrt- UnxCmplt+ RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr- HeaderOF-
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
		RootCmd: CERptEn+ NFERptEn+ FERptEn+
		RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
			 FirstFatal- NonFatalMsg- FatalMsg- IntMsgNum 0
		ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
	Capabilities: [140 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=40us PortTPowerOnTime=44us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=40us LTR1.2_Threshold=106496ns
		L1SubCtl2: T_PwrOn=60us
	Capabilities: [220 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1e.0 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO UART Controller #0 [8086:9d27] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO UART Controller #0 [8086:9d27]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at ceec8000 (64-bit, non-prefetchable) [size=4K]
	Region 2: Memory at ceec7000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:1e.2 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO SPI Controller #0 [8086:9d29] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO SPI Controller #0 [8086:9d29]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 22
	Region 0: Memory at ceec6000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:1e.4 SD Host controller [0805]: Intel Corporation Device [8086:9d2b] (rev 21) (prog-if 01)
	Subsystem: Intel Corporation Device [8086:9d2b]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 21
	Region 0: Memory at ceec5000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: sdhci-pci
	Kernel modules: sdhci_pci

00:1f.0 ISA bridge [0601]: Intel Corporation Device [8086:9d4b] (rev 21)
	Subsystem: Intel Corporation Device [8086:9d4b]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:1f.2 Memory controller [0580]: Intel Corporation Sunrise Point-LP PMC [8086:9d21] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP PMC [8086:9d21]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: Memory at ceed4000 (32-bit, non-prefetchable) [size=16K]

00:1f.3 Multimedia audio controller [0401]: Intel Corporation Sunrise Point-LP HD Audio [8086:9d71] (rev 21)
	DeviceName: Multimedia audio controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 129
	Region 0: Memory at ceed0000 (64-bit, non-prefetchable) [size=16K]
	Region 4: Memory at ceee0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00458  Data: 0000
	Kernel driver in use: snd_soc_avs
	Kernel modules: snd_soc_avs, snd_hda_intel

00:1f.4 SMBus [0c05]: Intel Corporation Sunrise Point-LP SMBus [8086:9d23] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP SMBus [8086:9d23]
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at ceec3000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at efa0 [size=32]
	Kernel driver in use: i801_smbus
	Kernel modules: i2c_i801

00:1f.5 Non-VGA unclassified device [0000]: Intel Corporation Device [8086:9d24] (rev 21)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Region 0: Memory at fe010000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: intel-spi
	Kernel modules: spi_intel_pci

01:00.0 Network controller [0280]: Intel Corporation Wireless 7265 [8086:095a] (rev b9)
	Subsystem: Intel Corporation Device [8086:9e10]
	Physical Slot: 0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 127
	Region 0: Memory at cef00000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee002d8  Data: 0000
	Capabilities: [40] Express (v2) Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0W TEE-IO-
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L1, Exit Latency L1 <32us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt- FltModeDis-
		LnkSta:	Speed 2.5GT/s, Width x1
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr- HeaderOF-
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [140 v1] Device Serial Number 28-c6-3f-ff-ff-30-93-5f
	Capabilities: [14c v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Capabilities: [154 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=30us PortTPowerOnTime=60us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=0us LTR1.2_Threshold=106496ns
		L1SubCtl2: T_PwrOn=60us
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi


--x5b7evi746yntaci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="04_lspci_after_suspend_resume_with_4d4c10f763_907a7a2e5b.txt"

00:00.0 Host bridge [0600]: Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers [8086:590c] (rev 02)
	Subsystem: Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers [8086:590c]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Intel Capabilities v1
		CapA: Peg60Dis- Peg12Dis+ Peg11Dis+ Peg10Dis+ PeLWUDis+ DmiWidth=x4
		      EccDis+ ForceEccEn- VTdDis- DmiG2Dis+ PegG2Dis+ DDRMaxSize=Unlimited
		      1NDis- CDDis- DDPCDis+ X2APICEn+ PDCDis- IGDis- CDID=0 CRID=2
		      DDROCCAP- OCEn- DDRWrtVrefEn- DDR3LEn+
		CapB: ImguDis- OCbySSKUCap- OCbySSKUEn- SMTCap+ CacheSzCap 0x3
		      SoftBinCap- DDR3MaxFreqWithRef100=Disabled PegG3Dis+
		      PkgTyp- AddGfxEn+ AddGfxCap- PegX16Dis+ DmiG3Dis+ GmmDis-
		      DDR3MaxFreq=2666MHz LPDDR3En+
		CapC: PegG4Dis- DDR4MaxFreq=Unlimited LPDDREn- LPDDR4MaxFreq=0MHz LPDDR4En+
		      QClkGvDis- SgxDis- BClkOC=Disabled IddDis- Pipe3Dis- Gear1MaxFreq=Unlimited
	Kernel driver in use: skl_uncore

00:02.0 VGA compatible controller [0300]: Intel Corporation HD Graphics 615 [8086:591e] (rev 02) (prog-if 00 [VGA controller])
	DeviceName: VGA compatible controller
	Subsystem: Intel Corporation Device [8086:2212]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 126
	Region 0: Memory at cf000000 (64-bit, non-prefetchable) [size=16M]
	Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at ffc0 [size=64]
	Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
	Capabilities: [40] Vendor Specific Information: Intel Capabilities v1
		CapA: Peg60Dis- Peg12Dis+ Peg11Dis+ Peg10Dis+ PeLWUDis+ DmiWidth=x4
		      EccDis+ ForceEccEn- VTdDis- DmiG2Dis+ PegG2Dis+ DDRMaxSize=Unlimited
		      1NDis- CDDis- DDPCDis+ X2APICEn+ PDCDis- IGDis- CDID=0 CRID=2
		      DDROCCAP- OCEn- DDRWrtVrefEn- DDR3LEn+
		CapB: ImguDis- OCbySSKUCap- OCbySSKUEn- SMTCap+ CacheSzCap 0x3
		      SoftBinCap- DDR3MaxFreqWithRef100=Disabled PegG3Dis+
		      PkgTyp- AddGfxEn+ AddGfxCap- PegX16Dis+ DmiG3Dis+ GmmDis-
		      DDR3MaxFreq=2666MHz LPDDR3En+
	Capabilities: [70] Express (v2) Root Complex Integrated Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+ FLReset+ TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
	Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00018  Data: 0000
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Process Address Space ID (PASID)
		PASIDCap: Exec- Priv-, Max PASID Width: 14
		PASIDCtl: Enable- Exec- Priv-
	Capabilities: [200 v1] Address Translation Service (ATS)
		ATSCap:	Invalidate Queue Depth: 00
		ATSCtl:	Enable-, Smallest Translation Unit: 00
	Capabilities: [300 v1] Page Request Interface (PRI)
		PRICtl: Enable- Reset-
		PRISta: RF- UPRGI- Stopped+ PASID+
		Page Request Capacity: 00008000, Page Request Allocation: 00000000
	Kernel driver in use: i915
	Kernel modules: i915

00:04.0 Signal processing controller [1180]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem [8086:1903] (rev 02)
	Subsystem: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem [8086:1903]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at ceed8000 (64-bit, non-prefetchable) [size=32K]
	Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [d0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [e0] Vendor Specific Information: Intel Capabilities v1
		CapA: Peg60Dis- Peg12Dis+ Peg11Dis+ Peg10Dis+ PeLWUDis+ DmiWidth=x4
		      EccDis+ ForceEccEn- VTdDis- DmiG2Dis+ PegG2Dis+ DDRMaxSize=Unlimited
		      1NDis- CDDis- DDPCDis+ X2APICEn+ PDCDis- IGDis- CDID=0 CRID=2
		      DDROCCAP- OCEn- DDRWrtVrefEn- DDR3LEn+
		CapB: ImguDis- OCbySSKUCap- OCbySSKUEn- SMTCap+ CacheSzCap 0x3
		      SoftBinCap- DDR3MaxFreqWithRef100=Disabled PegG3Dis+
		      PkgTyp- AddGfxEn+ AddGfxCap- PegX16Dis+ DmiG3Dis+ GmmDis-
		      DDR3MaxFreq=2666MHz LPDDR3En+
	Kernel driver in use: proc_thermal
	Kernel modules: processor_thermal_device_pci_legacy

00:14.0 USB controller [0c03]: Intel Corporation Sunrise Point-LP USB 3.0 xHCI Controller [8086:9d2f] (rev 21) (prog-if 30 [XHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 121
	Region 0: Memory at ceef0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable+ Count=8/8 Maskable- 64bit+
		Address: 00000000fee00318  Data: 0000
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

00:14.2 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Thermal subsystem [8086:9d31] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Thermal subsystem [8086:9d31]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at ceecf000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Kernel driver in use: intel_pch_thermal
	Kernel modules: intel_pch_thermal

00:15.0 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #0 [8086:9d60] (rev 21)
	Subsystem: Intel Corporation 100 Series PCH/Sunrise Point PCH I2C0 [Skylake/Kaby Lake LPSS I2C] [8086:9d60]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at ceece000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:15.1 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #1 [8086:9d61] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #1 [8086:9d61]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at ceecd000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:15.2 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #2 [8086:9d62] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #2 [8086:9d62]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at ceecc000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:19.0 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO UART Controller #2 [8086:9d66] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO UART Controller #2 [8086:9d66]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 32
	Region 0: Memory at fe030000 (64-bit, non-prefetchable) [size=4K]
	Region 2: Memory at ceeca000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:19.2 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #4 [8086:9d64] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #4 [8086:9d64]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 34
	Region 0: Memory at ceec9000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:1c.0 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI Express Root Port #1 [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
	Subsystem: Intel Corporation Sunrise Point-LP PCI Express Root Port #1 [8086:9d10]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 120
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 2000-2fff [size=4K] [16-bit]
	Memory behind bridge: cef00000-ceffffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: 27f000000-27f1fffff [size=2M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), IntMsgNum 0
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+ TEE-IO-
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 8GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+ FltModeDis-
		LnkSta:	Speed 2.5GT/s, Width x1
			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 10W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState-
		RootCap: CRSVisible-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00218  Data: 0000
	Capabilities: [90] Subsystem: Intel Corporation Sunrise Point-LP PCI Express Root Port #1 [8086:9d10]
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO+ CmpltAbrt- UnxCmplt+ RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr- HeaderOF-
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
		RootCmd: CERptEn+ NFERptEn+ FERptEn+
		RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
			 FirstFatal- NonFatalMsg- FatalMsg- IntMsgNum 0
		ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
	Capabilities: [140 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=40us PortTPowerOnTime=44us
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=40us LTR1.2_Threshold=106496ns
		L1SubCtl2: T_PwrOn=60us
	Capabilities: [220 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1e.0 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO UART Controller #0 [8086:9d27] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO UART Controller #0 [8086:9d27]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at ceec8000 (64-bit, non-prefetchable) [size=4K]
	Region 2: Memory at ceec7000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:1e.2 Signal processing controller [1180]: Intel Corporation Sunrise Point-LP Serial IO SPI Controller #0 [8086:9d29] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP Serial IO SPI Controller #0 [8086:9d29]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 22
	Region 0: Memory at ceec6000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:1e.4 SD Host controller [0805]: Intel Corporation Device [8086:9d2b] (rev 21) (prog-if 01)
	Subsystem: Intel Corporation Device [8086:9d2b]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 21
	Region 0: Memory at ceec5000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: sdhci-pci
	Kernel modules: sdhci_pci

00:1f.0 ISA bridge [0601]: Intel Corporation Device [8086:9d4b] (rev 21)
	Subsystem: Intel Corporation Device [8086:9d4b]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:1f.2 Memory controller [0580]: Intel Corporation Sunrise Point-LP PMC [8086:9d21] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP PMC [8086:9d21]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: Memory at ceed4000 (32-bit, non-prefetchable) [size=16K]

00:1f.3 Multimedia audio controller [0401]: Intel Corporation Sunrise Point-LP HD Audio [8086:9d71] (rev 21)
	DeviceName: Multimedia audio controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 127
	Region 0: Memory at ceed0000 (64-bit, non-prefetchable) [size=16K]
	Region 4: Memory at ceee0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee002f8  Data: 0000
	Kernel driver in use: snd_soc_avs
	Kernel modules: snd_soc_avs, snd_hda_intel

00:1f.4 SMBus [0c05]: Intel Corporation Sunrise Point-LP SMBus [8086:9d23] (rev 21)
	Subsystem: Intel Corporation Sunrise Point-LP SMBus [8086:9d23]
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at ceec3000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at efa0 [size=32]
	Kernel driver in use: i801_smbus
	Kernel modules: i2c_i801

00:1f.5 Non-VGA unclassified device [0000]: Intel Corporation Device [8086:9d24] (rev 21)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Region 0: Memory at fe010000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: intel-spi
	Kernel modules: spi_intel_pci

01:00.0 Network controller [0280]: Intel Corporation Wireless 7265 [8086:095a] (rev b9)
	Subsystem: Intel Corporation Device [8086:9e10]
	Physical Slot: 0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 129
	Region 0: Memory at cef00000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee004b8  Data: 0000
	Capabilities: [40] Express (v2) Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0W TEE-IO-
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L1, Exit Latency L1 <32us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt- FltModeDis-
		LnkSta:	Speed 2.5GT/s, Width x1
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr- HeaderOF-
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [140 v1] Device Serial Number 28-c6-3f-ff-ff-30-93-5f
	Capabilities: [14c v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Capabilities: [154 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=30us PortTPowerOnTime=60us
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=0us LTR1.2_Threshold=106496ns
		L1SubCtl2: T_PwrOn=60us
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi


--x5b7evi746yntaci--

