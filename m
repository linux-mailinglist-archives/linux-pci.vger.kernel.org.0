Return-Path: <linux-pci+bounces-38549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65949BEC413
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 03:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 167924E6B82
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 01:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3045F1FBEB9;
	Sat, 18 Oct 2025 01:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gl7rQ7At"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117AC15624D
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 01:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760752680; cv=none; b=PPONCRUCo27DU2urXyNyUbbdyBDirYOTLnbrJXr3WappZNNPoXIKUGyb0WZCDN413mEdjZx+Iy0YYQ9ZREtUbM/SqdpILa4FapExVerzjXMjdIkT5ryqvkUJujmN4PXZLR2y2iEQkJQudwqoyp0QWGnjx1JDjvFtznJv1kTKIBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760752680; c=relaxed/simple;
	bh=Ho2SHS2E2MVqN9wUGa7rTXnD96uvFgXOxTPBJBIQiTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2NK5s+9V2vc3NYf9XXzRmmHh0WUPGrhcK+gbWPDYfF/HCarn1WTDh0uvs1JpGF7g0gCOy7o8LkxjjAIKFXyH8LvWqo5ARzT/R6f/on4zsbbK2QW145Fki5vo6RksIpwjJsbMbQmeQye3FAI8GsfEdlsrbZPSlmG+5Yxg57lj9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gl7rQ7At; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27c369f898fso35153755ad.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 18:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760752676; x=1761357476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OR7SYwQRtzskkeOXnHRhHVxuRyKmOsqIEhczVOG12Hc=;
        b=Gl7rQ7AtI5nJT8zgocCipM48Pr7NKh1O0WDkO05zU8oMWj0iOQQ2CUx9FOF58aYYqF
         GOcF3vQQzD7ltRweFfc6Sygn1BACZmlU/QT2TOl93b/4FsOG9JRGMMsMmQ66vb2noymU
         heKHMndBvsTLUY/8GFxa9ajvqFbt03hEG8st36wZRpuqB8P6BfkTCAnxup1K+ocQ3dtK
         fwvw3lZ++m+sP9c28FuHucqYSBr8ZFxRwP7WLpTSl56Q0yjy64Fl3Lwa2QmovFTMv7Sh
         klSYE+Je9mnibS10D//kfRTkYPdlQ7zZlfZOIxYCwOhwXfTsvjbCs6JiRmgwo1dWWflX
         c/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760752676; x=1761357476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OR7SYwQRtzskkeOXnHRhHVxuRyKmOsqIEhczVOG12Hc=;
        b=cdIlKMGOfR/glXqQEMO+JnZpP0LZnprxjBZRhqjU5lIz5uB8Y5h4/puw6mK/+jZ9A9
         CjgQ2t4JASZ/zaNXEGzBq1daDV7xxgj/P2RDUB5ojtXtsVZUjs+XGonYZV27vsd/BT/5
         gx2NL5+kyEvG+aGPcygthfY5arkcn2mc5SiDf6qrxLaCbJoaBCfuXK6p1gn4BWBJq5Et
         7V/6eQwjsd1nvRB3wHb8FbP2PdwcJITdjynXbWtKOAvNCBeLeW9zEaE9mGc/p8Nc7VIj
         RgkAjU19H9Vy99ezDNWOASQzhOD5bOpx5AB0iUdWHOFP1byCE5sVfFIgcrPEloNmJMjo
         Sm3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAVLCQ9QMnN6AQKv8S0T1s04Abp+TF7zoax3y1mQ3YXG6KeR5vQWgdHduy6fFcvJ4y8aqhtJe3CLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Ls7zNgy8dX88OKX9l/eDMJTiHzuzcIzoYiqL1oU8IM0JZCGC
	dQdr7/r0J0PQSZtA6cO0o/rpfbc4A8T4Zz8wlT65qnP3jjZwuqCfNylL3U4B5YaJ
X-Gm-Gg: ASbGnctLWHH68XncNo/3xv0+2JUsfxgPjVxvwrtTTReTkGk/DfTfD4Tbp+T3sIEj/wm
	Ld+y98JrldQOPKe6MnF6R99OrcyNGcMfvapk5CgIS6DsrvroreymCqLpJZbXK3n0Rq67cXhujtw
	syWqyI/PltuDDIKKm/WisFLyfYeV8irRdj9zf076VVbNz037bcR+tudfd/ldTyB3hZ776ePHhyT
	Z1HoibKaoE9wu7USGeBZUGZWenw9aX/Q64SJ1DR/bPlKPH6nT21qNAisFKWL6t71LBApGXC64nB
	mkwY2k1WJ9NCJNW5tzvk4ddvlLy86c9e8E05P9HfQwB3wwX01Ugxn6FFRaNl67vlkCzxM78awr7
	82fswM2TOQ90GY+mMETQufFpSraHF8rOtd5qBExmsASudsfy2gszqZamiKUcTyNZMnIz1XsMGQa
	axXFNiPokcoSSrBsZNf80M3Be0Lg==
X-Google-Smtp-Source: AGHT+IGr7hQJglqbsDpFuKNKXDwX5ZLNouo1QzwFT/9yJ+YW8LhAuSEzpizcOquH/Jjrr4pzh6sL3g==
X-Received: by 2002:a17:902:d584:b0:290:bd1b:cb3d with SMTP id d9443c01a7336-290c9ce67c0mr74311645ad.27.1760752676182;
        Fri, 17 Oct 2025 18:57:56 -0700 (PDT)
Received: from [10.0.2.15] ([157.50.200.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292469104edsm9666895ad.0.2025.10.17.18.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 18:57:55 -0700 (PDT)
Message-ID: <702c4ad7-508b-42de-9dc3-40e4a0fe7bd7@gmail.com>
Date: Sat, 18 Oct 2025 07:27:50 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: Setup bridge resources earlier
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com, bhelgaas@google.com, kw@linux.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 lucas.demarchi@intel.com, rafael.j.wysocki@intel.com,
 Manivannan Sadhasivam <mani@kernel.org>
References: <20251017185246.GA1040948@bhelgaas>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <20251017185246.GA1040948@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/10/25 00:22, Bjorn Helgaas wrote:
> On Fri, Oct 17, 2025 at 11:52:58PM +0530, Bhanu Seshu Kumar Valluri wrote:
>> Hi,
>>
>> I want to report that this PATCH also break PCI RC port on TI-AM64-EVM.
>>
>> I did git bisect and it pointed to the a43ac325c7cb ("PCI: Set up bridge resources earlier")
>>
>> Happy to help if any testing or logs are required.
> 
> Thanks for the report!  Can you test this patch?
> 
>   https://patch.msgid.link/20251014163602.17138-1-ilpo.jarvinen@linux.intel.com
> 
> That patch is queued up as
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=469276c06aff
> and should appear in v6.18-rc2 on Sunday if all goes well.
> 
> If that doesn't work, let us know and we'll debug this further.

I applied above patch on top of commit f406055cb18c ("Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux")

Did pci rescan and run kselftest (pci_endpoint_test). It is working.

Thanks for the patch.

Happy to help if any testing or logs are required.

[logs are as pasted below]

root@am64xx-evm:~# echo 1 > /sys/bus/pci/rescan
[   37.938991] pci 0000:01:00.0: [104c:b010] type 00 class 0xff0000 PCIe Endpoint
[   37.946384] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x0000ffff]
[   37.952430] pci 0000:01:00.0: BAR 1 [mem 0x00000000-0x000001ff]
[   37.958471] pci 0000:01:00.0: BAR 2 [mem 0x00000000-0x000003ff]
[   37.964499] pci 0000:01:00.0: BAR 3 [mem 0x00000000-0x00003fff]
[   37.970601] pci 0000:01:00.0: BAR 4 [mem 0x00000000-0x0001ffff]
[   37.976673] pci 0000:01:00.0: BAR 5 [mem 0x00000000-0x000fffff]
[   37.983157] pci 0000:01:00.0: supports D1
[   37.987241] pci 0000:01:00.0: PME# supported from D0 D1 D3hot
[   37.999527] pci 0000:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
[   38.010392] pci 0000:01:00.0: ASPM: DT platform, enabling ClockPM
[   38.016760] pcieport 0000:00:00.0: bridge window [mem 0x68100000-0x682fffff]: assigned
[   38.024940] pci 0000:01:00.0: BAR 5 [mem 0x68100000-0x681fffff]: assigned
[   38.031906] pci 0000:01:00.0: BAR 4 [mem 0x68200000-0x6821ffff]: assigned
[   38.038769] pci 0000:01:00.0: BAR 0 [mem 0x68220000-0x6822ffff]: assigned
[   38.045849] pci 0000:01:00.0: BAR 3 [mem 0x68230000-0x68233fff]: assigned
[   38.052804] pci 0000:01:00.0: BAR 2 [mem 0x68234000-0x682343ff]: assigned
[   38.059832] pci 0000:01:00.0: BAR 1 [mem 0x68234400-0x682345ff]: assigned
[   38.067507] pcieport 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
[   38.074329] pci-endpoint-test 0000:01:00.0: enabling device (0000 -> 0002)

--------------------------------------------------------------------------------------------------------

root@am64xx-evm:~# ./pci_endpoint_test -T LEGACY_IRQ_TEST
TAP version 13
1..16
# Starting 16 tests from 10 test cases.
#  RUN           pci_ep_bar.BAR0.BAR_TEST ...
#            OK  pci_ep_bar.BAR0.BAR_TEST
ok 1 pci_ep_bar.BAR0.BAR_TEST
#  RUN           pci_ep_bar.BAR1.BAR_TEST ...
#            OK  pci_ep_bar.BAR1.BAR_TEST
ok 2 pci_ep_bar.BAR1.BAR_TEST
#  RUN           pci_ep_bar.BAR2.BAR_TEST ...
#            OK  pci_ep_bar.BAR2.BAR_TEST
ok 3 pci_ep_bar.BAR2.BAR_TEST
#  RUN           pci_ep_bar.BAR3.BAR_TEST ...
#            OK  pci_ep_bar.BAR3.BAR_TEST
ok 4 pci_ep_bar.BAR3.BAR_TEST
#  RUN           pci_ep_bar.BAR4.BAR_TEST ...
#            OK  pci_ep_bar.BAR4.BAR_TEST
ok 5 pci_ep_bar.BAR4.BAR_TEST
#  RUN           pci_ep_bar.BAR5.BAR_TEST ...
#            OK  pci_ep_bar.BAR5.BAR_TEST
ok 6 pci_ep_bar.BAR5.BAR_TEST
#  RUN           pci_ep_basic.CONSECUTIVE_BAR_TEST ...
#            OK  pci_ep_basic.CONSECUTIVE_BAR_TEST
ok 7 pci_ep_basic.CONSECUTIVE_BAR_TEST
#  RUN           pci_ep_basic.MSI_TEST ...
#            OK  pci_ep_basic.MSI_TEST
ok 8 pci_ep_basic.MSI_TEST
#  RUN           pci_ep_basic.MSIX_TEST ...
#            OK  pci_ep_basic.MSIX_TEST
ok 9 pci_ep_basic.MSIX_TEST
#  RUN           pci_ep_data_transfer.memcpy.READ_TEST ...
#            OK  pci_ep_data_transfer.memcpy.READ_TEST
ok 10 pci_ep_data_transfer.memcpy.READ_TEST
#  RUN           pci_ep_data_transfer.memcpy.WRITE_TEST ...
#            OK  pci_ep_data_transfer.memcpy.WRITE_TEST
ok 11 pci_ep_data_transfer.memcpy.WRITE_TEST
#  RUN           pci_ep_data_transfer.memcpy.COPY_TEST ...
#            OK  pci_ep_data_transfer.memcpy.COPY_TEST
ok 12 pci_ep_data_transfer.memcpy.COPY_TEST
#  RUN           pci_ep_data_transfer.dma.READ_TEST ...
#            OK  pci_ep_data_transfer.dma.READ_TEST
ok 13 pci_ep_data_transfer.dma.READ_TEST
#  RUN           pci_ep_data_transfer.dma.WRITE_TEST ...
#            OK  pci_ep_data_transfer.dma.WRITE_TEST
ok 14 pci_ep_data_transfer.dma.WRITE_TEST
#  RUN           pci_ep_data_transfer.dma.COPY_TEST ...
#            OK  pci_ep_data_transfer.dma.COPY_TEST
ok 15 pci_ep_data_transfer.dma.COPY_TEST
#  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
#            OK  pcie_ep_doorbell.DOORBELL_TEST
ok 16 pcie_ep_doorbell.DOORBELL_TEST
# PASSED: 16 / 16 tests passed.
# Totals: pass:16 fail:0 xfail:0 xpass:0 skip:0 error:0

------------------------------------------------------------------------------------------

root@am64xx-evm:~# lspci -vv
00:00.0 PCI bridge: Texas Instruments Device b010 (prog-if 00 [Normal decode])
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 506
        Region 0: Memory at <unassigned> (64-bit, prefetchable) [disabled]
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: [disabled]
        Memory behind bridge: [disabled]
        Prefetchable memory behind bridge: [disabled]
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [80] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [90] MSI: Enable+ Count=1/1 Maskable+ 64bit+
                Address: 0000000001000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [b0] MSI-X: Enable- Count=1 Masked-
                Vector table: BAR=0 offset=00000000
                PBA: BAR=0 offset=00000008
        Capabilities: [c0] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L1, Exit Latency L1 <8us
                        ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
                LnkSta: Speed 5GT/s (ok), Width x1 (ok)
                        TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt+
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
                        Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Off, PwrInd Off, Power+ Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL+ CmdCplt- PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCap: CRSVisible-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
                         10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
                         EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
                         FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
                         AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled, ARIFwd-
                         AtomicOpsCtl: ReqEn- EgressBlck-
                LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer- 2Retimers- DRS-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
                         EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
                RootCmd: CERptEn+ NFERptEn+ FERptEn+
                RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
                         FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
                ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
        Capabilities: [150 v1] Device Serial Number 00-00-00-00-00-00-00-00
        Capabilities: [300 v1] Secondary PCI Express
                LnkCtl3: LnkEquIntrruptEn- PerformEqu-
                LaneErrStat: 0
        Capabilities: [4c0 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
                VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable- ID=1 ArbSelect=Fixed TC/VC=00
                        Status: NegoPending- InProgress-
                VC2:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable- ID=2 ArbSelect=Fixed TC/VC=00
                        Status: NegoPending- InProgress-
                VC3:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable- ID=3 ArbSelect=Fixed TC/VC=00
                        Status: NegoPending- InProgress-
        Capabilities: [900 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
                          PortCommonModeRestoreTime=255us PortTPowerOnTime=26us
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                           T_CommonMode=255us LTR1.2_Threshold=287744ns
                L1SubCtl2: T_PwrOn=26us
        Capabilities: [a20 v1] Precision Time Measurement
                PTMCap: Requester:- Responder:+ Root:+
                PTMClockGranularity: 4ns
                PTMControl: Enabled:- RootSelected:-
                PTMEffectiveGranularity: Unknown
        Kernel driver in use: pcieport

01:00.0 Unassigned class [ff00]: Texas Instruments Device b010
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 533
        Region 0: Memory at 68220000 (32-bit, non-prefetchable) [size=64K]
        Region 1: Memory at 68234400 (32-bit, non-prefetchable) [size=512]
        Region 2: Memory at 68234000 (32-bit, non-prefetchable) [size=1K]
        Region 3: Memory at 68230000 (32-bit, non-prefetchable) [size=16K]
        Region 4: Memory at 68200000 (32-bit, non-prefetchable) [size=128K]
        Region 5: Memory at 68100000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [80] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [90] MSI: Enable+ Count=32/32 Maskable- 64bit+
                Address: 0000000001000400  Data: 0000
        Capabilities: [b0] MSI-X: Enable- Count=2048 Masked-
                Vector table: BAR=0 offset=00000080
                PBA: BAR=0 offset=00008080
        Capabilities: [c0] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <1us, L1 <1us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0.000W
                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L1, Exit Latency L1 <8us
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s (ok), Width x1 (ok)
                        TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
                         10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
                         EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
                         FRS- TPHComp- ExtTPHComp-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
                         AtomicOpsCtl: ReqEn-
                LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer- 2Retimers- DRS-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
                         EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [150 v1] Device Serial Number 00-00-00-00-00-00-00-00
        Capabilities: [160 v1] Power Budgeting <?>
        Capabilities: [1b8 v1] Latency Tolerance Reporting
                Max snoop latency: 0ns
                Max no snoop latency: 0ns
        Capabilities: [1c0 v1] Dynamic Power Allocation <?>
        Capabilities: [300 v1] Secondary PCI Express
                LnkCtl3: LnkEquIntrruptEn- PerformEqu-
                LaneErrStat: 0
        Capabilities: [400 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
        Capabilities: [440 v1] Process Address Space ID (PASID)
                PASIDCap: Exec+ Priv+, Max PASID Width: 14
                PASIDCtl: Enable- Exec- Priv-
        Capabilities: [4c0 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
                VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable- ID=1 ArbSelect=Fixed TC/VC=00
                        Status: NegoPending- InProgress-
                VC2:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable- ID=2 ArbSelect=Fixed TC/VC=00
                        Status: NegoPending- InProgress-
                VC3:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable- ID=3 ArbSelect=Fixed TC/VC=00
                        Status: NegoPending- InProgress-
        Capabilities: [900 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
                          PortCommonModeRestoreTime=255us PortTPowerOnTime=26us
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                           T_CommonMode=0us LTR1.2_Threshold=287744ns
                L1SubCtl2: T_PwrOn=26us
        Capabilities: [a20 v1] Precision Time Measurement
                PTMCap: Requester:+ Responder:- Root:-
                PTMClockGranularity: Unimplemented
                PTMControl: Enabled:- RootSelected:-
                PTMEffectiveGranularity: Unknown
        Kernel driver in use: pci-endpoint-test

Regards
Bhanu Seshu Kumar Valluri 
> 
>> echo 1 > /sys/bus/pci/rescan
>> [   37.170389] pci 0000:01:00.0: [104c:b010] type 00 class 0xff0000 PCIe Endpoint
>> [   37.177781] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x0000ffff]
>> [   37.183808] pci 0000:01:00.0: BAR 1 [mem 0x00000000-0x000001ff]
>> [   37.189843] pci 0000:01:00.0: BAR 2 [mem 0x00000000-0x000003ff]
>> [   37.195802] pci 0000:01:00.0: BAR 3 [mem 0x00000000-0x00003fff]
>> [   37.201768] pci 0000:01:00.0: BAR 4 [mem 0x00000000-0x0001ffff]
>> [   37.207715] pci 0000:01:00.0: BAR 5 [mem 0x00000000-0x000fffff]
>> [   37.214040] pci 0000:01:00.0: supports D1
>> [   37.218083] pci 0000:01:00.0: PME# supported from D0 D1 D3hot
>> [   37.231890] pci 0000:01:00.0: BAR 5 [mem 0x68100000-0x681fffff]: assigned
>> [   37.242890] pci 0000:01:00.0: BAR 4 [mem size 0x00020000]: can't assign; no space
>> [   37.251216] pci 0000:01:00.0: BAR 4 [mem size 0x00020000]: failed to assign
>> [   37.258309] pci 0000:01:00.0: BAR 0 [mem size 0x00010000]: can't assign; no space
>> [   37.265851] pci 0000:01:00.0: BAR 0 [mem size 0x00010000]: failed to assign
>> [   37.272896] pci 0000:01:00.0: BAR 3 [mem size 0x00004000]: can't assign; no space
>> [   37.280439] pci 0000:01:00.0: BAR 3 [mem size 0x00004000]: failed to assign
>> [   37.287459] pci 0000:01:00.0: BAR 2 [mem size 0x00000400]: can't assign; no space
>> [   37.294986] pci 0000:01:00.0: BAR 2 [mem size 0x00000400]: failed to assign
>> [   37.302011] pci 0000:01:00.0: BAR 1 [mem size 0x00000200]: can't assign; no space
>> [   37.309536] pci 0000:01:00.0: BAR 1 [mem size 0x00000200]: failed to assign
>> [   37.316595] pci 0000:01:00.0: BAR 5 [mem 0x68100000-0x681fffff]: releasing
>> [   37.323541] pci 0000:01:00.0: BAR 5 [mem 0x68100000-0x681fffff]: assigned
>> [   37.330400] pci 0000:01:00.0: BAR 4 [mem size 0x00020000]: can't assign; no space
>> [   37.337956] pci 0000:01:00.0: BAR 4 [mem size 0x00020000]: failed to assign
>> [   37.344960] pci 0000:01:00.0: BAR 0 [mem size 0x00010000]: can't assign; no space
>> [   37.352550] pci 0000:01:00.0: BAR 0 [mem size 0x00010000]: failed to assign
>> [   37.359578] pci 0000:01:00.0: BAR 3 [mem size 0x00004000]: can't assign; no space
>> [   37.367152] pci 0000:01:00.0: BAR 3 [mem size 0x00004000]: failed to assign
>> [   37.374192] pci 0000:01:00.0: BAR 2 [mem size 0x00000400]: can't assign; no space
>> [   37.381709] pci 0000:01:00.0: BAR 2 [mem size 0x00000400]: failed to assign
>> [   37.388720] pci 0000:01:00.0: BAR 1 [mem size 0x00000200]: can't assign; no space
>> [   37.396246] pci 0000:01:00.0: BAR 1 [mem size 0x00000200]: failed to assign
>> [   37.403795] pcieport 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
>> [   37.410513] pci-endpoint-test 0000:01:00.0: enabling device (0000 -> 0002)
>> [   37.417796] pci-endpoint-test 0000:01:00.0: Cannot perform PCI test without BAR0



