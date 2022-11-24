Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBF9636EB6
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 01:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiKXAHh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 19:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKXAHf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 19:07:35 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CDF614F
        for <linux-pci@vger.kernel.org>; Wed, 23 Nov 2022 16:07:33 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id n188so247076iof.8
        for <linux-pci@vger.kernel.org>; Wed, 23 Nov 2022 16:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f93CNSs/bb0duRcRxceAhtecknVBrTpxaSJ0Rte3cDk=;
        b=fnpre3cmjZqZhJB/oiMkXRNq9yCwpe9XuPE1VbfpqNDWqW5wTWdZYW4cdODhgldRv9
         37NH1+eMxNfa7YWNv+poJiL0tIYQFBUVDRtHlHxa2lo6N4kOgDGqWMK2BraynUAWGcfT
         odYeAset59Ga2yt29aoG9F8S8ceoy+HoGFO3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f93CNSs/bb0duRcRxceAhtecknVBrTpxaSJ0Rte3cDk=;
        b=K2/CttzzZG7FE6cuWUe7ooxFyNgKs9Yo2hxE0irw9EeqbdHEybKEi64R+7yEHshGYT
         JfI9l3BAGyP4SVvwzskj+it3jupTD31SZF4vKR8HzL34iA/BP6wN4ABSRBILiz/wFBWU
         7SHEVg8rgv0gaFI3GiIsjuuVdxJXpqMx/+hgUF4Z7L2RLCDbRb1I1uGI1NhJDlryWdlm
         b3xUmE0MAum7Ka4CROVftR9mS87hcyOjxpMlUIIwR/7Jsvx02GajqTvTKygqxaQ96pYb
         Y43Z43YH4tMHot/enU8yQBXpuvyCKXgoHCRd3R5DHffe5d4Uy8Lx8jOzNm41h2oyxW0U
         Tu+w==
X-Gm-Message-State: ANoB5pmAC5PufFd7RBPqaa8SGapSC/lLGQJHbkBshWmxqpPdP7VS0cO6
        NeyNLUGdz8RelFkDn7hkx7WOXA==
X-Google-Smtp-Source: AA0mqf6RkgyNknlsY5xxmtX5cYMwNFeDmH6DPbxSVDT2USA73X9uj0LbCb0tLdq2FA4XYbEjS6DkBg==
X-Received: by 2002:a02:cf35:0:b0:388:cda3:8d72 with SMTP id s21-20020a02cf35000000b00388cda38d72mr51462jar.82.1669248452370;
        Wed, 23 Nov 2022 16:07:32 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id e32-20020a026d60000000b003733e2ce4e8sm6599603jaf.59.2022.11.23.16.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 16:07:31 -0800 (PST)
Date:   Thu, 24 Nov 2022 00:07:31 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, hkallweit1@gmail.com,
        wangxiongfeng2@huawei.com, mika.westerberg@linux.intel.com,
        kai.heng.feng@canonical.com, chris.packham@alliedtelesis.co.nz,
        yangyicong@hisilicon.com, treding@nvidia.com, jonathanh@nvidia.com,
        abhsahu@nvidia.com, sagupta@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Ricky Wu <ricky_wu@realtek.com>,
        Rajat Jain <rajatja@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Victor Ding <victording@google.com>
Subject: Re: [PATCH V1] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Message-ID: <Y361w1uiTPDmA2nM@google.com>
References: <0d8cc8c0-31a1-0290-5aa5-0c7b16db1edb@nvidia.com>
 <20220412225047.GA627910@bhelgaas>
 <Y36UJu4Ho54KBaHF@google.com>
 <695cd29-dd66-e87d-9c67-73f8416b26ef@panix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <695cd29-dd66-e87d-9c67-73f8416b26ef@panix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 23, 2022 at 02:01:59PM -0800, Kenneth R. Crudup wrote:
> 
> For #2, you mean "S3 suspend"?

Yes

> My normally solid machine is hit-or- miss on coming out of S3
> suspend lately but that could be related to me running Linus'
> master.

Interesting. Did this suspend/resume flakiness only (re)appear
recently?

> Should I try out "Dubious Patch #1"? I lose a %age/hr in S3.

If you are seeing high power consumption of the NVMe the patch
might help. On my system it goes from values in the 400mW range
to <10mW in S3. S0 power consumption is also reduced
significantly.

The implementation of the patch is incorrect even for what it
claims to do, but it still has the desired impact on the power
consumption of the Kioxia. Alternatively you could also just
set 'scale' and 'value' to 0 (possibly just 'value' would be
enough) instead of the values set by encode_l12_threshold(),
which is essentially what the patch does.

If messing with LTR_L1.2_THRESHOLD isn't enough for stabilizing
suspend/resume add an msleep of 200ms to the suspend() handler
of your PCIe driver and see if that helps. Not a proper
solution obviously, but could be a good data point, especially
if it helps.

I'm interested to learn about your findings!

m.

> On Wed, 23 Nov 2022, Matthias Kaehlcke wrote:
> 
> > Hi,
> >
> > not sure this is the best thread to reply to, but we are also
> > observing suspend issues with the same Kioxia NVMe on a platform
> > with a Qualcomm sc7280 SoC. The system runs a v5.15 downstream
> > kernel which includes most (post v5.15) ASPM patches from
> > upstream.
> >
> > There are two issues with the Kioxia NVMe:
> >
> > 1. Power consumption is high unless a LTR_L1.2_THRESHOLD of 0ns
> >    is configured (related dubious patch: [1])
> >
> > 2. The system often hangs on resume unless a longer delay is
> >    added in the suspend pass. QC engineers say that the NVMe is
> >    taking so much time to settle in L1ss.
> >
> > Other NVMe models don't exhibit power or suspend issues on this
> > platform, except for one model which also needs a shorter
> > delay during suspend, otherwise the system will hang
> > occasionally upon resume.
> >
> > The second issue could possibly be 'fixed' with a quirk for
> > the Kioxia NVMe model, though it seems the issue is not seen on
> > all platforms, apparently the delay is not needed on Kenny's
> > system.
> >
> > I'm currently a bit at a loss with the first issue. The patch
> > mentioned above claims that the (no-)snoop latencies are
> > involved, which may or may not be true. In this thread I saw
> > Kenny posting 'lspci' output from his (now) working system.
> > I noticed max (no-)snoop values of 3145728ns, which seems to
> > be some sort of default (programmed) max. On my system these
> > values are 0ns, which is the default value of the registers.
> > I tried to set these to 3146us from the kernel to see if that
> > makes a difference, but could only successfully update the max
> > snoop latency, but not non-snoop (maybe this can be only done
> > at early initialization time?). With just the max snoop latency
> > set to 3146us power consumption of the NVMe remains high.
> >
> > The output of lspci from my system is attached.
> >
> > In this thread it was mentioned that possibly a BIOS update
> > fixed the issue Kenny was seeing. What kind of values is
> > the BIOS supposed to adjust (I'm a PCI n00b)?
> >
> > Any suggestions about what else to try?
> >
> > Thanks
> >
> > m.
> >
> > [1] https://patchwork.kernel.org/project/linux-arm-msm/patch/1663315719-21563-1-git-send-email-quic_krichai@quicinc.com/
> >
> > ---
> >
> > 0001:00:00.0 PCI bridge: Qualcomm Device 010b (prog-if 00 [Normal decode])
> > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
> > 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 0
> > 	Interrupt: pin A routed to IRQ 183
> > 	IOMMU group: 0
> > 	Region 0: Memory at 40700000 (32-bit, non-prefetchable) [size=4K]
> > 	Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
> > 	I/O behind bridge: 00001000-00001fff [size=4K]
> > 	Memory behind bridge: 40300000-404fffff [size=2M]
> > 	Prefetchable memory behind bridge: 0000000040500000-00000000406fffff [size=2M]
> > 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> > 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
> > 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> > 	Capabilities: [40] Power Management version 3
> > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> > 	Capabilities: [50] MSI: Enable+ Count=1/32 Maskable+ 64bit+
> > 		Address: 00000000fffff000  Data: 0000
> > 		Masking: fffffffe  Pending: 00000000
> > 	Capabilities: [70] Express (v2) Root Port (Slot+), MSI 00
> > 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
> > 			ExtTag- RBE+
> > 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
> > 			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
> > 			MaxPayload 128 bytes, MaxReadReq 512 bytes
> > 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
> > 		LnkCap:	Port #0, Speed 8GT/s, Width x2, ASPM L0s L1, Exit Latency L0s <1us, L1 <64us
> > 			ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp+
> > 		LnkCtl:	ASPM L0s L1 Enabled; RCB 128 bytes, Disabled- CommClk+
> > 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> > 		LnkSta:	Speed 8GT/s (ok), Width x2 (ok)
> > 			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
> > 		SltCap:	AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ Surprise+
> > 			Slot #0, PowerLimit 0.000W; Interlock+ NoCompl-
> > 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> > 			Control: AttnInd Off, PwrInd Off, Power- Interlock-
> > 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
> > 			Changed: MRL- PresDet- LinkState-
> > 		RootCap: CRSVisible-
> > 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
> > 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> > 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP+ LTR+
> > 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
> > 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
> > 			 FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd-
> > 			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
> > 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled, ARIFwd-
> > 			 AtomicOpsCtl: ReqEn- EgressBlck-
> > 		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
> > 		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
> > 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> > 			 Compliance De-emphasis: -6dB
> > 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ EqualizationPhase1+
> > 			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
> > 			 Retimer- 2Retimers- CrosslinkRes: unsupported
> > 	Capabilities: [100 v2] Advanced Error Reporting
> > 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> > 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> > 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> > 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
> > 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
> > 		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
> > 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
> > 		HeaderLog: 00000000 00000000 00000000 00000000
> > 		RootCmd: CERptEn- NFERptEn- FERptEn-
> > 		RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
> > 			 FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
> > 		ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
> > 	Capabilities: [148 v1] Secondary PCI Express
> > 		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
> > 		LaneErrStat: 0
> > 	Capabilities: [168 v1] Transaction Processing Hints
> > 		No steering table available
> > 	Capabilities: [1fc v1] L1 PM Substates
> > 		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
> > 			  PortCommonModeRestoreTime=70us PortTPowerOnTime=0us
> > 		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > 			   T_CommonMode=70us LTR1.2_Threshold=86016ns
> > 		L1SubCtl2: T_PwrOn=10us
> > 	Kernel driver in use: pcieport
> >
> > 0001:01:00.0 Non-Volatile memory controller: KIOXIA Corporation Device 0001 (prog-if 02 [NVM Express])
> > 	Subsystem: KIOXIA Corporation Device 0001
> > 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> > 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 0
> > 	Interrupt: pin A routed to IRQ 182
> > 	IOMMU group: 0
> > 	Region 0: Memory at 40300000 (64-bit, non-prefetchable) [size=16K]
> > 	Capabilities: [40] Express (v2) Endpoint, MSI 00
> > 		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
> > 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0.000W
> > 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
> > 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
> > 			MaxPayload 128 bytes, MaxReadReq 512 bytes
> > 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
> > 		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <2us, L1 <32us
> > 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
> > 		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes, Disabled- CommClk+
> > 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> > 		LnkSta:	Speed 8GT/s (ok), Width x2 (downgraded)
> > 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> > 		DevCap2: Completion Timeout: Range AB, TimeoutDis+ NROPrPrP- LTR+
> > 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix-
> > 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
> > 			 FRS- TPHComp- ExtTPHComp-
> > 			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> > 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
> > 			 AtomicOpsCtl: ReqEn-
> > 		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
> > 		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
> > 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> > 			 Compliance De-emphasis: -6dB
> > 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ EqualizationPhase1+
> > 			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
> > 			 Retimer- 2Retimers- CrosslinkRes: unsupported
> > 	Capabilities: [80] Power Management version 3
> > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
> > 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> > 	Capabilities: [90] MSI: Enable- Count=1/32 Maskable+ 64bit+
> > 		Address: 0000000000000000  Data: 0000
> > 		Masking: 00000000  Pending: 00000000
> > 	Capabilities: [b0] MSI-X: Enable+ Count=32 Masked-
> > 		Vector table: BAR=0 offset=00002000
> > 		PBA: BAR=0 offset=00003000
> > 	Capabilities: [100 v2] Advanced Error Reporting
> > 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> > 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> > 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> > 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
> > 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
> > 		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
> > 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
> > 		HeaderLog: 00000000 00000000 00000000 00000000
> > 	Capabilities: [150 v1] Virtual Channel
> > 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
> > 		Arb:	Fixed- WRR32- WRR64- WRR128-
> > 		Ctrl:	ArbSelect=Fixed
> > 		Status:	InProgress-
> > 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> > 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> > 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> > 			Status:	NegoPending- InProgress-
> > 	Capabilities: [260 v1] Latency Tolerance Reporting
> > 		Max snoop latency: 0ns
> > 		Max no snoop latency: 0ns
> > 	Capabilities: [300 v1] Secondary PCI Express
> > 		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
> > 		LaneErrStat: 0
> > 	Capabilities: [400 v1] L1 PM Substates
> > 		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
> > 			  PortCommonModeRestoreTime=60us PortTPowerOnTime=10us
> > 		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > 			   T_CommonMode=0us LTR1.2_Threshold=86016ns
> > 		L1SubCtl2: T_PwrOn=10us
> > 	Kernel driver in use: nvme
> >
> >
> > On Tue, Apr 12, 2022 at 05:50:47PM -0500, Bjorn Helgaas wrote:
> > > [+cc Ricky for rtsx_pci ASPM behavior, Rajat, Prasad for L1 SS stuff,
> > > Victor for interest in disabling ASPM during save/restore]
> > >
> > > On Wed, Feb 16, 2022 at 06:41:39PM +0530, Vidya Sagar wrote:
> > > > On 2/16/2022 11:30 AM, Kenneth R. Crudup wrote:
> > > > > On Wed, 16 Feb 2022, Vidya Sagar wrote:
> > > > >
> > > > > > I see that the ASPM-L1 state of Realtek NIC which was in
> > > > > > disabled state before hibernate got enabled after hibernate.
> > > > >
> > > > > That's actually my SD-Card reader; there's a good chance the BIOS
> > > > > does "something" to it at boot time, as it's possible to boot from
> > > > > SD-Card on my laptop.
> > > > >
> > > > > > This patch doesn't do anything to LnkCtl register which has
> > > > > > control for ASPM L1 state.
> > > > >
> > > > > > Could you please check why ASPM L1 got enabled post hibernation?
> > > > >
> > > > > I wouldn't know how to do that; if you're still interested in that
> > > > > let me know what to do to determine that.
> > >
> > > > I would like Bjorn to take a call on it.
> > > > At this point, there are contradictions in observations.
> > >
> > > Remind me what contradictions you see?  I know Kenny saw NVMe errors
> > > on a kernel that included 4257f7e008ea ("PCI/ASPM: Save/restore L1SS
> > > Capability for suspend/resume") in December 2020 [1], and that he did
> > > *not* see those errors on 4257f7e008ea in February 2022 [2].  Is that
> > > what you mean?
> > >
> > > > Just to summarize,
> > > > - The root ports in your laptop don't have support for L1SS
> > > > - With the same old code base with which the errors were observed plus my
> > > > patch on top of it, I see that ASPM-L1 state getting enabled for one of the
> > > > endpoints (Realtek SD-Card reader) after system comes out of hibernation
> > > > even though ASPM-L1 was disabled before the system enter into hibernation.
> > > > No errors are reported now.
> > >
> > > I assume you refer to [2], where on 4257f7e008ea ("PCI/ASPM:
> > > Save/restore L1SS Capability for suspend/resume"), Kenny saw ASPM L1
> > > disabled before hibernate and enabled afterwards:
> > >
> > >   --- pre-hibernate
> > >   +++ post-hibernate
> > >     00:1d.7 PCI bridge [0604]: Intel [8086:34b7]
> > >       Bus: primary=00, secondary=58, subordinate=58
> > > 	LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
> > >     58:00.0 RTS525A PCI Express Card Reader [10ec:525a]
> > >   -     LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
> > >   -             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> > >   +     LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk-
> > >   +             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> > >
> > > Per PCIe r6.0, sec 7.5.3.7, "ASPM L1 must be enabled by software in
> > > the Upstream component on a Link prior to enabling ASPM L1 in the
> > > Downstream component on that Link," so this definitely seems broken,
> > > but wouldn't explain the NVMe issue.
> > >
> > > The PCI core (pcie_config_aspm_link()) always enables L1 in the
> > > upstream component before the downstream one, but 58:00.0 uses the
> > > rtsx_pci driver, which does a lot of its own ASPM fiddling, so my
> > > guess is that it's doing something wrong here.
> > >
> > > > - With the linux-next top of the tree plus my patch, no change in the ASPM
> > > > states and no errors also reported.
> > >
> > > I don't know which report this refers to.
> > >
> > > > This points to BIOS being buggy (both old and new with new one being less
> > > > problematic)
> > >
> > > I agree that a BIOS change between [1] and [2] seems plausible, but I
> > > don't think we can prove that yet.  I'm slightly queasy because while
> > > Kenny may have updated his BIOS, most people will not have.
> > >
> > > I think we should try this patch again with some changes and maybe
> > > some debug logging:
> > >
> > >   - I wonder if we should integrate the LTR, L1 SS, and Link Control
> > >     ASPM restore instead of having them spread around through
> > >     pci_restore_ltr_state(), pci_restore_aspm_l1ss_state(), and
> > >     pci_restore_pcie_state().  Maybe a new pci_restore_aspm() that
> > >     would be called from pci_restore_pcie_state()?
> > >
> > >   - For L1 PM Substates configuration, sec 5.5.4 says that both ports
> > >     must be configured while ASPM L1 is disabled, but I don't think we
> > >     currently guarantee this: we restore all the upstream component
> > >     state first, and we don't know the ASPM state of the downstream
> > >     one.  Maybe we need to:
> > >
> > >       * When restoring upstream component,
> > >           + disable its ASPM
> > >
> > >       * When restoring downstream component,
> > >           + disable its ASPM
> > > 	  + restore upstream component's LTR, L1SS
> > > 	  + restore downstream component's LTR, L1SS
> > > 	  + restore upstream component's ASPM
> > > 	  + restore downstream component's ASPM
> > >
> > >       This seems pretty messy, but seems like what the spec requires.
> > >
> > >     - Add some pci_dbg() logging of all these save/restore values to
> > >       help debug any issues.
> > >
> > > Bjorn
> > >
> > > [1] https://lore.kernel.org/r/20201228040513.GA611645@bjorn-Precision-5520
> > > [2] https://lore.kernel.org/r/3ca14a7-b726-8430-fe61-a3ac183a1088@panix.com
> > >
> >
> >
> 
> -- 
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
