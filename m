Return-Path: <linux-pci+bounces-18822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3499F86E2
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 22:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82B9116C5B6
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 21:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833BF1509BD;
	Thu, 19 Dec 2024 21:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="W57TEO/r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E73D1A0AFE
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 21:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734643571; cv=none; b=R083uJzsKAegBzEGOaEZBksr3XDqQSf459YmPW1ByIkjVFVEWN7z+uzcVF1V0uPUUPyiC0S1tKh+nrdc4lZSH2fkarGeTK4JsjMGYy+BMi0S0YNlkeHVkd7e36yPAm7Comc+prK2N5ALo6+O1Gs6jstNNDjhtSraEAi+jUEvNxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734643571; c=relaxed/simple;
	bh=x8dPGnzDIrEJ0NlE+NyoTzyQBSXbtS/P3OPcKvL1NoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZhGHaNBLH+7RhtRAwufu/0Aht8o9GQGMMPyDi0+GS+ug6tOdbmEG2uuShvu87RDVlJxcyzkyLh6wKUdKKpT7Lv6KwHDzR3hpPCC0ipv1O6Lgey++N7J35hEfy/sufzhJSL8nVfDML2mVEELzI0v/1DYDDohrliREvqDR+Qxapg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=W57TEO/r; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ef66a7ac14so23957787b3.0
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 13:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1734643567; x=1735248367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rO0Yk6LUKuGZ8zNnbboTRViyFulaBv09kck8y3K58Iw=;
        b=W57TEO/rJVLzcBhlqbMJ8i3QWULtOf882QVDcJ0N7DzhxrjCWQnPc8icAPG2PaDGs0
         dhRsmTNdzlmVuZDjzS6Oqmy20p2m/M7kVYcoNuSbdDTrGOb4WexP2nvKUpuaHKqxeUdn
         GqxUZqftdpRPSjjUz73YoakrIjMezkrNPrNDOveTlCOj5guFwLi1bjlT8ox1oV5JQ9BB
         +cwp7lNsVfgTvsafN2UDHMUFw3wgrOq+z4s4Qcp3VPfIKf4r4/iurGZouZpfnLKxjyBl
         dDVWfcpWWmlU7sMsrJuYAcc2QiwEK39OMy6GxaJ2tmCBs0YN2f8l4HK6Y5ClDmKvYx5G
         UD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734643567; x=1735248367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rO0Yk6LUKuGZ8zNnbboTRViyFulaBv09kck8y3K58Iw=;
        b=Owd/iKXNvObixbLXjNSkLQ9ksBhMqHq9KzQ8yAAvEfo/5Xta20CIUIQfeBYVNgD2Tu
         0l6QJNHBITvAuBFd/Xa8pnTih9j3zBfQpyJb2vpzed2tqPqts/P7+OsW/r7JD+N8F5si
         yPsUeZdTSYIsxRLZY0b+ZjRK9RDi4tjNxWkDi0jkHJNS7LxDYS7/P8lvm1pdQAB31elB
         okOMGNgSgL7JUMj0JbiJ2qzxp+YgKw6+tmf1rtBmzp3PDinPp4jQvJ4gcpAVS+IRaBAb
         Wroo91nu9XLlcCWpArCUVljZnwyw44Pl5zpafSxrXCk140fM0P+aAE4itwqSXz7Z8Tj+
         xZrA==
X-Forwarded-Encrypted: i=1; AJvYcCUBMZnaWqwQ19gP+opNq9UHOILYvwVToEZJKCNseLawWqsnGUQRVrZvOv9PGJT+k5AOaGHLErurMc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKmRvp6v+dQZoVC9dau5I202Eey5s9XhdU+iMT7Mdfc+Zyw29J
	2v3wREMfZvxupOYO87dKt35zqVdkVB/D0N0yhNHC0w67gJchkP29ljcwQhlvMZRX/Wk0h4cV//M
	C95DW2VHBWSKrzBR6e8ZV7usLDDa5ZlS718fMoA==
X-Gm-Gg: ASbGnct0uTh77GSDLaUu1vvu17345/ozE640LMXUZuCOv7gutcBz4XTtEW0cmKPNMij
	OP9IXrEAvj5SernR6nfX1lHY1KoBys49GZ+Bq9g==
X-Google-Smtp-Source: AGHT+IHgc7QKp/u68/J1qOPeU7zXFZgqgEna/uVkN4U8yURYMY2jIRFUbXwHSbiAWgMWuOlCfx3jWC/oSXA4Pnoikl0=
X-Received: by 2002:a05:690c:9a8b:b0:6ef:e572:cd6f with SMTP id
 00721157ae682-6f3e2a87259mr45005767b3.7.1734643567094; Thu, 19 Dec 2024
 13:26:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ+vNU3Q-VBuhUzQYrQ_BYrPM1cdP_i=7ToQk5DR+4MQYE21BQ@mail.gmail.com>
 <Z2SJztEqmr3FEIas@lizhi-Precision-Tower-5810>
In-Reply-To: <Z2SJztEqmr3FEIas@lizhi-Precision-Tower-5810>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 19 Dec 2024 13:25:56 -0800
Message-ID: <CAJ+vNU2wxy6v_2S-0vMnUTb-JnuRnAu7_9Y3tKw+kLMaw314PQ@mail.gmail.com>
Subject: Re: hang on enabling PCI AER for IMX8MP + PI7C9X3G606GP 6-port Gen3 switch
To: Frank Li <Frank.li@nxp.com>
Cc: imx@lists.linux.dev, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 1:02=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Thu, Dec 19, 2024 at 09:54:55AM -0800, Tim Harvey wrote:
> > Greetings,
> >
> > I have a board with an NXP IMX8MP SoC Gen3 PCI host controller
> > connected to a Diodes Inc PI7C9X3G606GP (imx8mp-venice-gw82xx-2x.dts)
> > which hangs during pci enumeration if PCIEAER is enabled.
>
> How to reproduce it? Just enable CONFIG_PCIEAER?
>

Hi Frank,

Correct, enabling CONFIG_PCIEAER produces this hang for me.

Disabling CONFIG_PCIEAER or via cmdline 'pci=3Dnoaer' or by the
following hack resolves it:
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 13b8586924ea..0ba05120cc2a 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -239,7 +239,11 @@ static int pci_enable_pcie_error_reporting(struct
pci_dev *dev)
        if (!pcie_aer_is_native(dev))
                return -EIO;

-       rc =3D pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FL=
AGS);
+       /* do not enable fatal error reporting for PI7C9X3G606GP
upstream port */
+       if (dev->devfn =3D=3D PCI_DEVFN(0, 0) && dev->vendor =3D=3D 0x12d8)
+               rc =3D pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
PCI_EXP_AER_FLAGS & ~PCI_EXP_DEVCTL_FERE);
+       else
+               rc =3D pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
PCI_EXP_AER_FLAGS);
        return pcibios_err_to_errno(rc);
 }

I don't expect this to be an issue with the IMX8MP as much as the
PI7C9X3G606GP switch as we successfully use several other PCIe
switches with the IMX8MP. I provided the lspci results here in case
something was evident from that, like maybe the switch doesn't support
fatal error reporting and it shouldn't be enabled or something (I'm
not sure how to interpret the verbose results of the AER caps).

I've re-created this on all kernels I've tested between 6.6 and 6.12.

Best Regards,

Tim

> Frank
>
> >
> > I've tracked this down to the enabling of fatal error reporting
> > (PCI_EXP_DEVCTL_FERE) on the upstream port of the PI7C9X3G606GP. In
> > other words if I mask that bit out of the
> > pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS) call
> > for that device (or disable PCI AER via CONFIG_PCIEAER or pci=3Dnoaer)
> > all is well.
> >
> > Here is what lspci shows for the root complex and the switch upstream p=
ort:
> > # lspci -n
> > 00:00.0 0604: 16c3:abcd (rev 01)
> > 01:00.0 0604: 12d8:c008 (rev 07)
> > 02:01.0 0604: 12d8:c008 (rev 06)
> > 02:02.0 0604: 12d8:c008 (rev 06)
> > 02:03.0 0604: 12d8:c008 (rev 06)
> > 02:04.0 0604: 12d8:c008 (rev 06)
> > 02:05.0 0604: 12d8:c008 (rev 06)
> > 02:06.0 0604: 12d8:c008 (rev 06)
> > 02:07.0 0604: 12d8:c008 (rev 06)
> > 09:00.0 0200: 1055:7430 (rev 11)
> > # lspci -s 00:00.0 -vvv
> > 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> > (prog-if 00 [Normal decode])
> >         Device tree node:
> > /sys/firmware/devicetree/base/soc@0/pcie@33800000/pcie@0,0
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR+ FastB2B- DisINTx+
> >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
-
> > <TAbort- <MAbort- >SERR- <PERR- INTx-
> >         Latency: 0
> >         Interrupt: pin A routed to IRQ 219
> >         Region 0: Memory at 18000000 (32-bit, non-prefetchable) [size=
=3D1M]
> >         Bus: primary=3D00, secondary=3D01, subordinate=3Dff, sec-latenc=
y=3D0
> >         I/O behind bridge: f000-0fff [disabled] [16-bit]
> >         Memory behind bridge: 18100000-182fffff [size=3D2M] [32-bit]
> >         Prefetchable memory behind bridge: fff00000-000fffff [disabled]=
 [32-bit]
> >         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
-
> > <TAbort- <MAbort- <SERR- <PERR-
> >         Expansion ROM at 18300000 [virtual] [disabled] [size=3D64K]
> >         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- Fas=
tB2B-
> >                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> >         Capabilities: [40] Power Management version 3
> >                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D375mA
> > PME(D0+,D1+,D2-,D3hot+,D3cold+)
> >                 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
> >         Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable+ 64bit+
> >                 Address: 0000000040101000  Data: 0000
> >                 Masking: 00000000  Pending: 00000000
> >         Capabilities: [70] Express (v2) Root Port (Slot-), IntMsgNum 0
> >                 DevCap: MaxPayload 128 bytes, PhantFunc 0
> >                         ExtTag- RBE+ TEE-IO-
> >                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
> >                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
> >                         MaxPayload 128 bytes, MaxReadReq 512 bytes
> >                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> > AuxPwr+ TransPend-
> >                 LnkCap: Port #0, Speed 8GT/s, Width x1, ASPM L0s L1,
> > Exit Latency L0s <1us, L1 unlimited
> >                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp=
+
> >                 LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommCl=
k+
> >                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> >                 LnkSta: Speed 8GT/s, Width x1
> >                         TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgm=
t+
> >                 RootCap: CRSVisible+
> >                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
> > PMEIntEna+ CRSVisible+
> >                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> >                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
> > NROPrPrP+ LTR-
> >                          10BitTagComp- 10BitTagReq- OBFF Not
> > Supported, ExtFmt- EETLPPrefix-
> >                          EmergencyPowerReduction Not Supported,
> > EmergencyPowerReductionInit-
> >                          FRS- LN System CLS Not Supported, TPHComp-
> > ExtTPHComp- ARIFwd-
> >                          AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS=
-
> >                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- =
ARIFwd-
> >                          AtomicOpsCtl: ReqEn- EgressBlck-
> >                          IDOReq- IDOCompl- LTR- EmergencyPowerReduction=
Req-
> >                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
> >                 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink-
> > Retimer- 2Retimers- DRS-
> >                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- Spe=
edDis-
> >                          Transmit Margin: Normal Operating Range,
> > EnterModifiedCompliance- ComplianceSOS-
> >                          Compliance Preset/De-emphasis: -6dB
> > de-emphasis, 0dB preshoot
> >                 LnkSta2: Current De-emphasis Level: -6dB,
> > EqualizationComplete+ EqualizationPhase1+
> >                          EqualizationPhase2+ EqualizationPhase3+
> > LinkEqualizationRequest-
> >                          Retimer- 2Retimers- CrosslinkRes: unsupported
> >         Capabilities: [100 v2] Advanced Error Reporting
> >                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> > UnxCmplt- RxOF- MalfTLP-
> >                         ECRC- UnsupReq- ACSViol- UncorrIntErr-
> > BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
> >                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
> > MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
> >                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> > UnxCmplt- RxOF- MalfTLP-
> >                         ECRC- UnsupReq- ACSViol- UncorrIntErr+
> > BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
> >                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
> > MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
> >                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
> > UnxCmplt- RxOF+ MalfTLP+
> >                         ECRC- UnsupReq- ACSViol- UncorrIntErr+
> > BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
> >                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
> > MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
> >                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> > AdvNonFatalErr- CorrIntErr- HeaderOF-
> >                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> > AdvNonFatalErr+ CorrIntErr+ HeaderOF+
> >                 AERCap: First Error Pointer: 00, ECRCGenCap+
> > ECRCGenEn- ECRCChkCap+ ECRCChkEn-
> >                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLog=
Cap-
> >                 HeaderLog: 00000000 00000000 00000000 00000000
> >                 RootCmd: CERptEn+ NFERptEn+ FERptEn+
> >                 RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
> >                          FirstFatal- NonFatalMsg- FatalMsg- IntMsgNum 0
> >                 ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
> >         Capabilities: [148 v1] Secondary PCI Express
> >                 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
> >                 LaneErrStat: 0
> >         Capabilities: [158 v1] L1 PM Substates
> >                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2-
> > ASPM_L1.1+ L1_PM_Substates+
> >                           PortCommonModeRestoreTime=3D10us PortTPowerOn=
Time=3D10us
> >                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1=
.1-
> >                            T_CommonMode=3D10us
> >                 L1SubCtl2: T_PwrOn=3D10us
> >         Kernel driver in use: pcieport
> > # lspci -s 01:00.0 -vvv
> > 01:00.0 PCI bridge: Pericom Semiconductor Device c008 (rev 07)
> > (prog-if 00 [Normal decode])
> >         Subsystem: Pericom Semiconductor Device c008
> >         Device tree node:
> > /sys/firmware/devicetree/base/soc@0/pcie@33800000/pcie@0,0/pcie@0,0
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B- DisINTx-
> >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
-
> > <TAbort- <MAbort- >SERR- <PERR- INTx-
> >         Latency: 0
> >         Region 0: Memory at 18200000 (32-bit, non-prefetchable) [size=
=3D512K]
> >         Bus: primary=3D01, secondary=3D02, subordinate=3D09, sec-latenc=
y=3D0
> >         I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
> >         Memory behind bridge: 18100000-181fffff [size=3D1M] [32-bit]
> >         Prefetchable memory behind bridge:
> > 00000000fff00000-00000000000fffff [disabled] [64-bit]
> >         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
-
> > <TAbort- <MAbort- <SERR- <PERR-
> >         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- Fas=
tB2B-
> >                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> >         Capabilities: [40] Power Management version 3
> >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> >                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
> >         Capabilities: [48] MSI: Enable- Count=3D1/8 Maskable+ 64bit+
> >                 Address: 0000000000000000  Data: 0000
> >                 Masking: 00000000  Pending: 00000000
> >         Capabilities: [68] Express (v2) Upstream Port, IntMsgNum 0
> >                 DevCap: MaxPayload 512 bytes, PhantFunc 0
> >                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
> > SlotPowerLimit 4W TEE-IO-
> >                 DevCtl: CorrErr+ NonFatalErr+ FatalErr- UnsupReq+
> >                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> >                         MaxPayload 128 bytes, MaxReadReq 128 bytes
> >                 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+
> > AuxPwr- TransPend-
> >                 LnkCap: Port #0, Speed 8GT/s, Width x1, ASPM L1, Exit
> > Latency L1 <1us
> >                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp=
+
> >                 LnkCtl: ASPM Disabled; LnkDisable- CommClk+
> >                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> >                 LnkSta: Speed 8GT/s, Width x1
> >                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgm=
t-
> >                 DevCap2: Completion Timeout: Not Supported,
> > TimeoutDis- NROPrPrP- LTR-
> >                          10BitTagComp- 10BitTagReq- OBFF Not
> > Supported, ExtFmt- EETLPPrefix-
> >                          EmergencyPowerReduction Not Supported,
> > EmergencyPowerReductionInit-
> >                          FRS-
> >                          AtomicOpsCap: Routing+ 32bit- 64bit- 128bitCAS=
-
> >                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> >                          AtomicOpsCtl: EgressBlck-
> >                          IDOReq- IDOCompl- LTR- EmergencyPowerReduction=
Req-
> >                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
> >                 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink-
> > Retimer- 2Retimers- DRS-
> >                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- Spe=
edDis-
> >                          Transmit Margin: Normal Operating Range,
> > EnterModifiedCompliance- ComplianceSOS-
> >                          Compliance Preset/De-emphasis: -6dB
> > de-emphasis, 0dB preshoot
> >                 LnkSta2: Current De-emphasis Level: -6dB,
> > EqualizationComplete+ EqualizationPhase1+
> >                          EqualizationPhase2+ EqualizationPhase3+
> > LinkEqualizationRequest-
> >                          Retimer- 2Retimers- CrosslinkRes: unsupported
> >         Capabilities: [a4] Subsystem: Pericom Semiconductor Device c008
> >         Capabilities: [b0] MSI-X: Enable- Count=3D6 Masked-
> >                 Vector table: BAR=3D0 offset=3D0007f000
> >                 PBA: BAR=3D0 offset=3D0007f080
> >         Capabilities: [100 v1] Advanced Error Reporting
> >                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> > UnxCmplt- RxOF- MalfTLP-
> >                         ECRC- UnsupReq- ACSViol- UncorrIntErr-
> > BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
> >                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
> > MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
> >                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> > UnxCmplt- RxOF- MalfTLP-
> >                         ECRC- UnsupReq- ACSViol- UncorrIntErr+
> > BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
> >                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
> > MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
> >                 UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt-
> > UnxCmplt- RxOF+ MalfTLP+
> >                         ECRC- UnsupReq- ACSViol- UncorrIntErr+
> > BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
> >                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
> > MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
> >                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> > AdvNonFatalErr+ CorrIntErr- HeaderOF-
> >                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> > AdvNonFatalErr+ CorrIntErr+ HeaderOF-
> >                 AERCap: First Error Pointer: 00, ECRCGenCap+
> > ECRCGenEn- ECRCChkCap+ ECRCChkEn-
> >                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLog=
Cap-
> >                 HeaderLog: 00000000 00000000 00000000 00000000
> >         Capabilities: [130 v1] Virtual Channel
> >                 Caps:   LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D4
> >                 Arb:    Fixed- WRR32- WRR64- WRR128-
> >                 Ctrl:   ArbSelect=3DFixed
> >                 Status: InProgress-
> >                 VC0:    Caps:   PATOffset=3D05 MaxTimeSlots=3D64 RejSno=
opTrans-
> >                         Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- W=
RR256-
> >                         Ctrl:   Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=
=3Dff
> >                         Status: NegoPending- InProgress-
> >                         Port Arbitration Table <?>
> >         Capabilities: [1a0 v1] Device Serial Number 08-16-48-96-00-00-1=
2-d8
> >         Capabilities: [1b0 v1] Power Budgeting <?>
> >         Capabilities: [1d0 v1] Multicast
> >                 McastCap: MaxGroups 64, ECRCRegen-
> >                 McastCtl: NumGroups 1, Enable-
> >                 McastBAR: IndexPos 0, BaseAddr 0000000000000000
> >                 McastReceiveVec:      0000000000000000
> >                 McastBlockAllVec:     0000000000000000
> >                 McastBlockUntransVec: 0000000000000000
> >                 McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr
> > 0000000000000000
> >         Capabilities: [210 v1] Secondary PCI Express
> >                 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
> >                 LaneErrStat: 0
> >         Capabilities: [2b0 v1] L1 PM Substates
> >                 L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2-
> > ASPM_L1.1- L1_PM_Substates+
> >                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1=
.1-
> >                 L1SubCtl2:
> >         Capabilities: [300 v1] Vendor Specific Information: ID=3D0000
> > Rev=3D0 Len=3D560 <?>
> >         Kernel driver in use: pcieport
> >
> > Is there anything here or any ideas on what could be the issue here?
> >
> > Best Regards,
> >
> > Tim

