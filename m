Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4427A362959
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245118AbhDPUaN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244843AbhDPUaM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Apr 2021 16:30:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F8F76124B;
        Fri, 16 Apr 2021 20:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618604987;
        bh=b4BDXufcBVHLJMdwRjF00+zGergeAnWG63yCydwVoOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bUnBAnO2zNYUNrKRt+x0hXqmTjQoVZOroTnBOq6sm0nHWK2r0104Sdyjrmlj2gy1U
         wJml00SH+s+menWBXVWGAFWJe224sg6mHdMrdRZtAJk7qtY7DkLcCUEfjvEhbSpRLp
         Jpy3ynT+Z7lFIkccIj5kKzUTgv3I5pCoMWq4kh+cGkE0olZ63sBczCXBrpJ7VTHpxl
         /m8S2cPYMSKtWGyo4YTW+ydGa+3p6UlYjufuaT+L4yKcCLwcqVpnCLYQivbuePVOzR
         DXqBddCkTIuCkb/JohevxqmR/aFy3+/UzpnEa8n7SDLGvyHjm1UR23AIpuPhVN3Zdm
         x/rMki/ELBrAQ==
Date:   Sat, 17 Apr 2021 05:29:41 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: PCIe: can't set Max Payload Size to 256
Message-ID: <20210416202941.GB32082@redsun51.ssa.fujisawa.hgst.com>
References: <20210416173119.d2eq2zetzp5awunj@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210416173119.d2eq2zetzp5awunj@pali>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 16, 2021 at 07:31:19PM +0200, Pali Rohár wrote:
> Hello! I'm getting following error line in dmesg for NVMe disk with
> v5.12-rc7 kernel version:
> 
> [    3.226462] pci 0000:04:00.0: can't set Max Payload Size to 256; if necessary, use "pci=pcie_bus_safe" and report a bug
> 
> lspci output for this NVMe disk is:
> 
> 04:00.0 Non-Volatile memory controller [0108]: Silicon Motion, Inc. Device [126f:2263] (rev 03) (prog-if 02 [NVM Express])
>         Subsystem: Silicon Motion, Inc. Device [126f:2263]
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 55
>         Region 0: Memory at e8000000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [50] MSI: Enable- Count=1/8 Maskable+ 64bit+
>                 Address: 0000000000000000  Data: 0000
>                 Masking: 00000000  Pending: 00000000
>         Capabilities: [70] Express (v2) Endpoint, MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 26.000W
>                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>                 LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM not supported
>                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>                 LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s (downgraded), Width x1 (downgraded)
>                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
>                          10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
>                          EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
>                          FRS- TPHComp- ExtTPHComp-
>                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 10BitTagReq- OBFF Disabled,
>                          AtomicOpsCtl: ReqEn-
>                 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
>                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
>                          EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
>                          Retimer- 2Retimers- CrosslinkRes: unsupported
>         Capabilities: [b0] MSI-X: Enable+ Count=16 Masked-
>                 Vector table: BAR=0 offset=00002000
>                 PBA: BAR=0 offset=00002100
>         Capabilities: [100 v2] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
>                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>                 HeaderLog: 00000000 00000000 00000000 00000000
>         Capabilities: [158 v1] Secondary PCI Express
>                 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
>                 LaneErrStat: 0
>         Capabilities: [178 v1] Latency Tolerance Reporting
>                 Max snoop latency: 0ns
>                 Max no snoop latency: 0ns
>         Capabilities: [180 v1] L1 PM Substates
>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1- L1_PM_Substates+
>                           PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
>                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>                            T_CommonMode=0us
>                 L1SubCtl2: T_PwrOn=10us
>         Kernel driver in use: nvme
> 
> And I cannot understand. Why is kernel trying to set Max Payload Size to
> 256 bytes when NVMe disk in Device Capabilities register presents that
> supports Maximal Payload size only 128 bytes?

The error indicates that the port your nvme pcie device is connected
is not reporting a matching MPS. The kernel will attempt to tune the
port if it's a RP so they match. If you see this error, that means the
RP setting wasn't successful.

If the SSD is connected to a bridge, you'll need to use the kernel
parameter to force retuning the bus.
