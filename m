Return-Path: <linux-pci+bounces-18806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7449F82C0
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 19:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B62B77A3FA8
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 17:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438BF1A255C;
	Thu, 19 Dec 2024 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="HbdPEdm3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40F31946DA
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630910; cv=none; b=boWWDtHDVHdhjEpGmQ6H5Mp5HAWvqVsxjwcXr7kbTQBNl5MRiGMVLwnT24GSU1bCOuVhHAqUNREmE1Sby8kDWvznU0OtmQeTqj0xpR3XZ+CX4eXW4SoGpTBNiDQ4zqCCWTq+JIbZsYMcs+mL5TK21JNRleAxysrcQorgfJqx7fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630910; c=relaxed/simple;
	bh=ODM0C610K/xXLXRiPSxUWOUs3YZRkoc0Jx5JKvFt1Zc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cZBxPhBWrMd7283tO2vakxukrd0X/gAC4TAvI/+NEf8pUz3h3ECiayxLo/p638h/RSVehh8rxTWXOHfjYLUbtsVQ1shELwH3LGC24Ps86hI+SAFj9UFBpgvcXFaB8Yj8fnb0Zg1APLH8Qg/GNmTF3UvF282TLICqwPXpd6YORjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=HbdPEdm3; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6efa1e49ef0so9064487b3.2
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 09:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1734630906; x=1735235706; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lo5qWyFXfhjdWnvO9zttuffbg7ByoeE6Ekf8RdPenOw=;
        b=HbdPEdm3WVXcylxqvjdP8cw3Nan+WbgvnhxOb0Nh7atMQYlOt43SEuQGyzEfgukn0B
         ZKFyPuBNWR0sg42uw1239UyTgTZFeuuysfPjtDQm1WEdXP4y610ouQ2UKq5z1SEITeki
         OXzJ7O0TR3oa1uq2pZ+f3yL1kP2H2Ua3J6PCql6n0ashSAeunueqKqFtleQE1aPhqXjS
         NLn6e5Wyj1fDzhR6GBWWgXXwPblOUIhtENUIYQnK7X4cGOU9uRZVAp5pi2tLK/vq2U7s
         KXinGf7SzGYHs6yVSU3kssGJa1B9kmQef63y9hUTMV9o1ShshDF1MQf5DiLiSBXQNR4z
         uUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734630906; x=1735235706;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lo5qWyFXfhjdWnvO9zttuffbg7ByoeE6Ekf8RdPenOw=;
        b=Eoxmsl5rnOYJP27+l7vXCzIoS4epVgDVQQmboAdCKTUniH1V1hR3KSjHjHFsF/RO5t
         H/rfhLS0aUodOJLJKJeT9a/389+sIrrZC1L2C8aQNRFanyiJ/8nRuoGzpYRfuL70ijnO
         K/r0E3Pj5J2lJmQy8TvIaJaqFoKQnNldgZrlGsHz7iljQEv3KJi2Y9gEZSjm4cmGPCwE
         7ctzmnvvsbE5G4A85I7qqHeA/l8mVWSZOeemgUWTbOE57jfJRfiy33Gp0E9KSUe1Jb0u
         zkeC6cmpy9l6YHf3mq0IXp1m0EMfpz/lsQ6QPe9jaW9y0/xzuYx/EdzFm5H5yjr1ztFW
         sEdw==
X-Gm-Message-State: AOJu0YxumLo0caIs1cbbgol7y/1Hf/hjUjQqaf+GHyTp5IAWmgsjvhIG
	wxeswHoQ3N70KelanQnxDRIb5lDrZJN4S8N3AFF6T0AVcRQEVlB5icH0PDbxb9bvgs7mC0fwGIJ
	Mc9DO1BH221qmGaQsAeqPFavg/6cHRlTA6lzS6m38AxZbdKIZVOpFBg==
X-Gm-Gg: ASbGncur9+7LWaB3Wn9MtZsgsV+prB2hSfmkiHv2e+TFhADpaL2aKEm2Sh134O30a8g
	dr1vVM9nCL5cC9g3NPRCqQNHJCg/RrDOhtoUgfQ==
X-Google-Smtp-Source: AGHT+IEV8JsrvAybZhx5nchKna+1Y0tOlzL4Uuu5RYHOhy7nhoaldNvs40bS9T54d6L2z0FzTWg0Ne9Rary0OrmY/CQ=
X-Received: by 2002:a05:690c:7404:b0:6ee:4eae:5551 with SMTP id
 00721157ae682-6f3f537d703mr4879707b3.21.1734630906204; Thu, 19 Dec 2024
 09:55:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 19 Dec 2024 09:54:55 -0800
Message-ID: <CAJ+vNU3Q-VBuhUzQYrQ_BYrPM1cdP_i=7ToQk5DR+4MQYE21BQ@mail.gmail.com>
Subject: hang on enabling PCI AER for IMX8MP + PI7C9X3G606GP 6-port Gen3 switch
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Greetings,

I have a board with an NXP IMX8MP SoC Gen3 PCI host controller
connected to a Diodes Inc PI7C9X3G606GP (imx8mp-venice-gw82xx-2x.dts)
which hangs during pci enumeration if PCIEAER is enabled.

I've tracked this down to the enabling of fatal error reporting
(PCI_EXP_DEVCTL_FERE) on the upstream port of the PI7C9X3G606GP. In
other words if I mask that bit out of the
pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS) call
for that device (or disable PCI AER via CONFIG_PCIEAER or pci=noaer)
all is well.

Here is what lspci shows for the root complex and the switch upstream port:
# lspci -n
00:00.0 0604: 16c3:abcd (rev 01)
01:00.0 0604: 12d8:c008 (rev 07)
02:01.0 0604: 12d8:c008 (rev 06)
02:02.0 0604: 12d8:c008 (rev 06)
02:03.0 0604: 12d8:c008 (rev 06)
02:04.0 0604: 12d8:c008 (rev 06)
02:05.0 0604: 12d8:c008 (rev 06)
02:06.0 0604: 12d8:c008 (rev 06)
02:07.0 0604: 12d8:c008 (rev 06)
09:00.0 0200: 1055:7430 (rev 11)
# lspci -s 00:00.0 -vvv
00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
(prog-if 00 [Normal decode])
        Device tree node:
/sys/firmware/devicetree/base/soc@0/pcie@33800000/pcie@0,0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 219
        Region 0: Memory at 18000000 (32-bit, non-prefetchable) [size=1M]
        Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
        I/O behind bridge: f000-0fff [disabled] [16-bit]
        Memory behind bridge: 18100000-182fffff [size=2M] [32-bit]
        Prefetchable memory behind bridge: fff00000-000fffff [disabled] [32-bit]
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        Expansion ROM at 18300000 [virtual] [disabled] [size=64K]
        BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA
PME(D0+,D1+,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
                Address: 0000000040101000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [70] Express (v2) Root Port (Slot-), IntMsgNum 0
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+ TEE-IO-
                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 8GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <1us, L1 unlimited
                        ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 8GT/s, Width x1
                        TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt+
                RootCap: CRSVisible+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna+ CRSVisible+
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
NROPrPrP+ LTR-
                         10BitTagComp- 10BitTagReq- OBFF Not
Supported, ExtFmt- EETLPPrefix-
                         EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
                         FRS- LN System CLS Not Supported, TPHComp-
ExtTPHComp- ARIFwd-
                         AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
                         AtomicOpsCtl: ReqEn- EgressBlck-
                         IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
                         10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink-
Retimer- 2Retimers- DRS-
                LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance Preset/De-emphasis: -6dB
de-emphasis, 0dB preshoot
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete+ EqualizationPhase1+
                         EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr-
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr+
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+
                        ECRC- UnsupReq- ACSViol- UncorrIntErr+
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr- CorrIntErr- HeaderOF-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
                AERCap: First Error Pointer: 00, ECRCGenCap+
ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
                RootCmd: CERptEn+ NFERptEn+ FERptEn+
                RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
                         FirstFatal- NonFatalMsg- FatalMsg- IntMsgNum 0
                ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
        Capabilities: [148 v1] Secondary PCI Express
                LnkCtl3: LnkEquIntrruptEn- PerformEqu-
                LaneErrStat: 0
        Capabilities: [158 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2-
ASPM_L1.1+ L1_PM_Substates+
                          PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                           T_CommonMode=10us
                L1SubCtl2: T_PwrOn=10us
        Kernel driver in use: pcieport
# lspci -s 01:00.0 -vvv
01:00.0 PCI bridge: Pericom Semiconductor Device c008 (rev 07)
(prog-if 00 [Normal decode])
        Subsystem: Pericom Semiconductor Device c008
        Device tree node:
/sys/firmware/devicetree/base/soc@0/pcie@33800000/pcie@0,0/pcie@0,0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Region 0: Memory at 18200000 (32-bit, non-prefetchable) [size=512K]
        Bus: primary=01, secondary=02, subordinate=09, sec-latency=0
        I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
        Memory behind bridge: 18100000-181fffff [size=1M] [32-bit]
        Prefetchable memory behind bridge:
00000000fff00000-00000000000fffff [disabled] [64-bit]
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
                Address: 0000000000000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [68] Express (v2) Upstream Port, IntMsgNum 0
                DevCap: MaxPayload 512 bytes, PhantFunc 0
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
SlotPowerLimit 4W TEE-IO-
                DevCtl: CorrErr+ NonFatalErr+ FatalErr- UnsupReq+
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+
AuxPwr- TransPend-
                LnkCap: Port #0, Speed 8GT/s, Width x1, ASPM L1, Exit
Latency L1 <1us
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; LnkDisable- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 8GT/s, Width x1
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported,
TimeoutDis- NROPrPrP- LTR-
                         10BitTagComp- 10BitTagReq- OBFF Not
Supported, ExtFmt- EETLPPrefix-
                         EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
                         FRS-
                         AtomicOpsCap: Routing+ 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                         AtomicOpsCtl: EgressBlck-
                         IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
                         10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink-
Retimer- 2Retimers- DRS-
                LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance Preset/De-emphasis: -6dB
de-emphasis, 0dB preshoot
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete+ EqualizationPhase1+
                         EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [a4] Subsystem: Pericom Semiconductor Device c008
        Capabilities: [b0] MSI-X: Enable- Count=6 Masked-
                Vector table: BAR=0 offset=0007f000
                PBA: BAR=0 offset=0007f080
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr-
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr+
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+
                        ECRC- UnsupReq- ACSViol- UncorrIntErr+
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr- HeaderOF-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr+ HeaderOF-
                AERCap: First Error Pointer: 00, ECRCGenCap+
ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [130 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=4
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=05 MaxTimeSlots=64 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
                        Port Arbitration Table <?>
        Capabilities: [1a0 v1] Device Serial Number 08-16-48-96-00-00-12-d8
        Capabilities: [1b0 v1] Power Budgeting <?>
        Capabilities: [1d0 v1] Multicast
                McastCap: MaxGroups 64, ECRCRegen-
                McastCtl: NumGroups 1, Enable-
                McastBAR: IndexPos 0, BaseAddr 0000000000000000
                McastReceiveVec:      0000000000000000
                McastBlockAllVec:     0000000000000000
                McastBlockUntransVec: 0000000000000000
                McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr
0000000000000000
        Capabilities: [210 v1] Secondary PCI Express
                LnkCtl3: LnkEquIntrruptEn- PerformEqu-
                LaneErrStat: 0
        Capabilities: [2b0 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2-
ASPM_L1.1- L1_PM_Substates+
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                L1SubCtl2:
        Capabilities: [300 v1] Vendor Specific Information: ID=0000
Rev=0 Len=560 <?>
        Kernel driver in use: pcieport

Is there anything here or any ideas on what could be the issue here?

Best Regards,

Tim

