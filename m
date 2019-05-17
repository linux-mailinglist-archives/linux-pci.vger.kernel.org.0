Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75A1621CE1
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2019 19:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfEQRxs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 May 2019 13:53:48 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13989 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfEQRxs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2019 13:53:48 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdef5290000>; Fri, 17 May 2019 10:53:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 17 May 2019 10:53:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 17 May 2019 10:53:45 -0700
Received: from [10.25.74.217] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 May
 2019 17:53:39 +0000
Subject: Re: [PATCH V6 02/15] PCI/PME: Export pcie_pme_disable_msi() &
 pcie_pme_no_msi() APIs
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Christoph Hellwig <hch@infradead.org>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190513050626.14991-1-vidyas@nvidia.com>
 <20190513050626.14991-3-vidyas@nvidia.com>
 <20190513072539.GA27708@infradead.org>
 <3a8cea93-2aeb-e5e2-4d56-f0c6449073c3@nvidia.com>
 <20190516133426.GC101793@google.com>
 <bd08ccaa-c6ee-f966-91e4-bcd5d99d5cf2@nvidia.com>
 <20190517132453.GA30700@google.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <ba611a45-9589-8dce-58e1-d99dd463265d@nvidia.com>
Date:   Fri, 17 May 2019 23:23:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517132453.GA30700@google.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558115625; bh=S553ZW6Nijmi8SUtms6x6JKfl27DkEODdk7pag1sbso=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Xul60TJi1MVs+cON0NOpGElEKV54OfMmyV1hp6LiCcAy81On3Kb4S/d9sorNNbvLM
         PApV3g1P/ojfkI2JCzMO7M9twM0Q+DJEaWsXijlafmNXTFqngzj0OBwWNcuVjJCa0o
         p9Sx7MkdWczoyUDZk8XYSwGbRKpA+O/aceo8k6En0MFq10NWgQbnBhAoCHf5M3l87P
         YapBNOuexpS+0fns+OwhBgVVlSrSOG05p41rK7RPYs6zN2QEYJC+MN51qFwd142nAh
         5i3jyv2laOcMkABHG+aXEmPQ7o7zw/lO4bLy4Dl++ufTa4u8rswp9pgXNsKirKqJsk
         kBXNzXg/fENFA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/17/2019 6:54 PM, Bjorn Helgaas wrote:
> On Fri, May 17, 2019 at 01:49:49PM +0530, Vidya Sagar wrote:
>> On 5/16/2019 7:04 PM, Bjorn Helgaas wrote:
>>> On Tue, May 14, 2019 at 09:00:19AM +0530, Vidya Sagar wrote:
>>>> On 5/13/2019 12:55 PM, Christoph Hellwig wrote:
>>>>> On Mon, May 13, 2019 at 10:36:13AM +0530, Vidya Sagar wrote:
>>>>>> Export pcie_pme_disable_msi() & pcie_pme_no_msi() APIs to enable drivers
>>>>>> using these APIs be able to build as loadable modules.
>>>>>
>>>>> But this is a global setting.  If you root port is broken you need
>>>>> a per-rootport quirk instead.
>>>>>
>>>> There is nothing broken in Tegra194 root port as such, rather, this
>>>> is more of software configuration choice and we are going with
>>>> legacy interrupts than MSI interrupts (as Tegra194 doesn't support
>>>> raising PME interrupts through MSI and please note that this doesn't
>>>> mean root port is broken).
>>>
>>> I think the port *is* broken.  PCIe r4.0, sec 6.1.6, says
>>>
>>>     If the Root Port is enabled for edge-triggered interrupt signaling
>>>     using MSI or MSI-X, an interrupt message must be sent every time the
>>>     logical AND of the following conditions transitions from FALSE to
>>>     TRUE:
>>>
>>>       * The associated vector is unmasked (not applicable if MSI does
>>>         not support PVM).
>>>
>>>       * The PME Interrupt Enable bit in the Root Control register is set
>>>         to 1b.
>>>
>>>       * The PME Status bit in the Root Status register is set.
>>>
>>> The Tegra194 root port advertises MSI support, so the above should
>>> apply.
>> I had a discussion with our hardware engineers and we are of the
>> opinion that the root port is not really broken w.r.t MSI as spec
>> doesn't clearly say that if root port advertises MSI support, it
>> must generate MSI interrupts for PME. All that it says is, if MSI is
>> enabled, then MSI should be raised for PME events. Here, by
>> 'enable', we understand that as enabling at hardware level to
>> generate MSI interrupt which is not the case with Tegra194.  In
>> Tegra194, root port is enabled to generate MSI only for hot-plug
>> events and legacy interrupts are used for PME, AER.
> 
> Do you have "lspci -vvxxx" output for the root ports handy?
> 
> If there's some clue in the standard config space that would tell us
> that MSI works for some events but not others, we could make the PCI
> core pay attention it.  That would be the best solution because it
> wouldn't require Tegra-specific code.

Here is the output of 'lspci vvxxx' for one of Tegra194's root ports.

0005:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad0 (rev a1) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 50
	Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
	I/O behind bridge: None
	Memory behind bridge: 40000000-400fffff [size=1M]
	Prefetchable memory behind bridge: None
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 16GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <1us, L1 <64us
			ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt-
		LnkSta:	Speed 5GT/s (downgraded), Width x1 (downgraded)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
		RootCap: CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd-
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [b0] MSI-X: Enable- Count=8 Masked-
		Vector table: BAR=2 offset=00000000
		PBA: BAR=2 offset=00010000
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
		RootCmd: CERptEn+ NFERptEn+ FERptEn+
		RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
			 FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
		ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
	Capabilities: [148 v1] Secondary PCI Express <?>
	Capabilities: [168 v1] Physical Layer 16.0 GT/s <?>
	Capabilities: [190 v1] Lane Margining at the Receiver <?>
	Capabilities: [1c0 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=60us PortTPowerOnTime=40us
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=10us LTR1.2_Threshold=0ns
		L1SubCtl2: T_PwrOn=10us
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0002 Rev=4 Len=100 <?>
	Capabilities: [2d0 v1] Vendor Specific Information: ID=0001 Rev=1 Len=038 <?>
	Capabilities: [308 v1] Data Link Feature <?>
	Capabilities: [314 v1] Precision Time Measurement
		PTMCap: Requester:+ Responder:+ Root:+
		PTMClockGranularity: 16ns
		PTMControl: Enabled:- RootSelected:-
		PTMEffectiveGranularity: Unknown
	Capabilities: [320 v1] Vendor Specific Information: ID=0004 Rev=1 Len=054 <?>
	Kernel driver in use: pcieport
00: de 10 d0 1a 07 01 10 00 a1 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 ff 00 f0 00 00 00
20: 00 40 00 40 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 32 01 02 00
40: 01 50 c3 c9 08 00 00 00 00 00 00 00 00 00 00 00
50: 05 70 80 01 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 10 b0 42 00 01 80 00 00 1f 28 10 00 84 4c 7b 00
80: 40 04 12 f0 00 00 00 00 c0 03 40 00 18 00 01 00
90: 00 00 00 00 1f 0c 01 00 00 04 00 00 1e 00 80 01
a0: 04 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00
b0: 11 00 07 00 02 00 00 00 02 00 01 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

> 
> If this situation requires Tegra-specific code, that becomes an issue
> if you ever want to use the part in an ACPI system because the ACPI
> host bridge driver is generic and there isn't a place to put
> device-specific code.
Thanks for bringing it up. I'll make a note of this and discuss about it internally.

> 
> Bjorn
> 

