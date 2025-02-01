Return-Path: <linux-pci+bounces-20615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB381A247D5
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 10:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846433A5AF3
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 09:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAB025760;
	Sat,  1 Feb 2025 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPfltsev"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBBE632;
	Sat,  1 Feb 2025 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738400620; cv=none; b=Zec7U4lg6wnGjDpS0CwOnH5rUioZeCBy35eHLajXhomJ1vXPyYXGyNxlh3U6JU8+cE3fwKReQUWYlw8c1zLio/O7b25bl0ySOQOuTrFuvAyj/zyGDBvujnHNj5I9igkNtAa4pMxAQesoIMV0wZe/cv3UhSFIzvID+Nsv1fJu+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738400620; c=relaxed/simple;
	bh=dCmznVGGpPhbq7aTQ3oKsuHwb4e+/C/exV6mgmYPB8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SgLHq4A3G8jTKdcFsmQgZvZUu+s0qVkSOgtqXCzUvSUdeeVD12Rxw5iRiHcV/8VJkPfk9a6wiV80YHFR3UBOOG9RFQ5p8skt/qPBa6aui1g6yDEwFVykbekq6xFkQx5ng+SqmRLqKVJl7CQEqfWysrrTrKu/3nkzSDBEIuE0r0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPfltsev; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30613802a6bso27669871fa.1;
        Sat, 01 Feb 2025 01:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738400615; x=1739005415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9yS6i50fsDPXkXU4ztnrfoQWet2zHGrTDpq9W+LdBY=;
        b=CPfltsev4XOXd48EBOcUApS2IDOiT/ooON5/e1ROFkIh6oBL2sR9jbJVLtRkavq8Zj
         LaPOHTLq/jcHSVKYeSTEeJQUtyxT/zbAO28a/1Pogm/fDT+ykrLyxsEc2VZxqzUbxf6J
         WBUpdjDzMgz5fdKcrPSvNMDe8dl6jsJRTtE1MVREx760qT4L4/gRbW9NNgcnCVXK+mkV
         eQLnL3WKLehhXZOpHO3MFs9KH2tdoAwy1epKMnpdbwMaeeJdjbv17iyO0sBIEBbyVmVt
         v0FoQK5yqFA5LnIjomLnvkrHW5uRTtK7YqThPjkZXT/LTa5UVHClJvpvCFvPENcJ2839
         e4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738400615; x=1739005415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9yS6i50fsDPXkXU4ztnrfoQWet2zHGrTDpq9W+LdBY=;
        b=c0BlDJi5oLhJpSY1m7btyCrfRqzcx1dUh1zxMkIwjTGE5eBncd+NBmeGL7JGji7nDJ
         eLpHZlHzwFpTJ4Mxh/vBPKdzOHMlFuQExX+2yKeEbTAAreLnKq8jXqz6zJ9SdjgQHnxm
         2yORVCyCsyD/NdGXc6p2YGhPBGm5EBOtZbHCvlvPUBC/R5iKCyiaoN/lB3HVDilSoSgR
         4BVU+TjqsiAqDFQhxt4lQhpdr7b2qdLMjQmioAwnJIQQzhPXB0xb1R+TMRSS3Xz/owlu
         IsETBQAScynF+mQ3uF2QxQsBls/DHYORc7vbMct6LtPUD7axuDaKQHNqlFO1pqDZ9Jpq
         VsnQ==
X-Gm-Message-State: AOJu0Yw64IrevJyA/EFXC9yzaYG9/dGa58jcn6PTqu6eEOa4/o5iNfUR
	AB6nJEuTWd4bQa8yJ9D7rW7KmyyY3lFpdRg/nBvWD8gbrlWJQLygR30pYAOrQCFo9XWbwsJVquM
	JGhIKOquAIZJZFIUyaOGOvXoCpm1aeC55dQ==
X-Gm-Gg: ASbGncvfD9mmZ+m57/SzJCKEkgH+4dsGfhU8zw45LI2gUbLXy6+Dz1tuur95ix8v2YJ
	6XMvWJu1VBe34rHM3AQN3e4icX3DmjuymP/JaUB/pstSrtIRg9e/EizSDFPUw7D+kF6OWqbX6EQ
	==
X-Google-Smtp-Source: AGHT+IG19bf2TA0IIVd+XMsIRlOrA60uehqCuZOGzORiPqBl0Mhro+mb2mSDopob354gWXP80LDade6/uJqaYpY+2PY=
X-Received: by 2002:a2e:a104:0:b0:306:1397:d5ff with SMTP id
 38308e7fff4ca-307968f8e8fmr57198801fa.22.1738400615109; Sat, 01 Feb 2025
 01:03:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMciSVUzFL+myQTTRD-OZRf+o9UUPDE87SzUxQ2cYdjrfd7iHQ@mail.gmail.com>
In-Reply-To: <CAMciSVUzFL+myQTTRD-OZRf+o9UUPDE87SzUxQ2cYdjrfd7iHQ@mail.gmail.com>
From: Naveen Kumar P <naveenkumar.parna@gmail.com>
Date: Sat, 1 Feb 2025 14:33:23 +0530
X-Gm-Features: AWEUYZkl7qXY05qxjPCoXgIOxUmznIZ3iFQVpAlxDDtfyd1_72qEIaLGFHWGno0
Message-ID: <CAMciSVXsuW7b=EKwS1mtNpANF+nRmH1-ofvDy6gp0jQ4jSwE+g@mail.gmail.com>
Subject: Re: Assistance Needed: PCIe Device BAR Reset Issue
To: linux-pci@vger.kernel.org, lukas@wunner.de
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Does this indicates that memory space (Mem-) and bus mastering
(BusMaster-) are disabled? Does it suggest the device might have
entered a low-power state?

I see runtime_status as active
#cat /sys/bus/pci/devices/0000\:01\:00.0/power/runtime_status
active


On Fri, Jan 31, 2025 at 3:37=E2=80=AFPM Naveen Kumar P
<naveenkumar.parna@gmail.com> wrote:
>
> Dear Linux Kernel Community,
>
> I hope this message finds you well. I am reaching out to seek assistance =
with an issue I am experiencing with a PCIe device on my system.
>
> System Details:
>
> PCIe Device: PLDA Device 5555
> Kernel Version: 5.4.0-148-generic
> Distribution: Ubuntu 20.04.6 LTS
>
> After booting the system, I read the Base Address Register (BAR) of the P=
CIe device using the following command:
>
> setpci -s 01:00.0 BASE_ADDRESS_0
>
> Initially, the BAR value is 0xb0400000. However, after some time, reading=
 from the PCIe device's BAR memory fails and returns 0xffff (PCIe memory-ma=
pped registers read via the readb(), readw(), and readl() kernel mode APIs =
returned 0xff\0xffff\0xffffffff). Upon rechecking the BAR using the same se=
tpci command, the result is 0x00000000. Additionally, I verified the BAR0 a=
ddress using the kernel API pci_resource_start(), and it exhibited the same=
 behavior.
>
> Steps Taken:
>
> Verified the device status using lspci -vvv -s 01:00.0:
> # lspci -vvv -s 01:00.0
> 01:00.0 RAM memory: PLDA Device 5555
>         Subsystem: Device 4000:0000
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 16
>         Region 0: Memory at b0400000 (32-bit, non-prefetchable) [virtual]=
 [size=3D4M]
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,=
D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME=
-
>         Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit-
>                 Address: 00000000  Data: 0000
>         Capabilities: [60] Express (v2) Endpoint, MSI 00
>                 DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s un=
limited, L1 unlimited
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- S=
lotPowerLimit 0.000W
>                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq- AuxPwr-=
 TransPend-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x2, ASPM L0s, Exit =
Latency L0s unlimited
>                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s (ok), Width x2 (ok)
>                         TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Range B, TimeoutDis-, NROPrP=
rP-, LTR-
>                          10BitTagComp-, 10BitTagReq-, OBFF Not Supported,=
 ExtFmt-, EETLPPrefix-
>                          EmergencyPowerReduction Not Supported, Emergency=
PowerReductionInit-
>                          FRS-, TPHComp-, ExtTPHComp-
>                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, L=
TR-, OBFF Disabled
>                          AtomicOpsCtl: ReqEn-
>                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- Spe=
edDis+
>                          Transmit Margin: Normal Operating Range, EnterMo=
difiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationC=
omplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-, LinkEq=
ualizationRequest-
>         Kernel driver in use: M1801 PCI
>         Kernel modules: m1801_pci
>
> # lspci -xxx -s 01:00.0
> 01:00.0 RAM memory: PLDA Device 5555
> 00: 56 15 55 55 00 00 10 00 00 00 00 05 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
> 40: 01 48 03 00 08 00 00 00 05 60 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 10 00 02 00 c2 8f 00 00 10 28 01 00 21 f4 03 00
> 70: 00 00 21 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00
> 90: 20 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>
> Verified power management settings:
>
> cat /sys/module/pcie_aspm/parameters/policy
> Output: [default] performance powersave powersupersave
>
>
> Request for Assistance: I would appreciate any guidance or suggestions on=
 how to further debug this issue. Specifically, I am looking for:
>
> Potential causes for the BAR being reset to 0x00000000.
> Steps to ensure the device is not being reset or put into a low-power sta=
te unexpectedly.
> Any additional diagnostic steps or tools that could help identify the roo=
t cause.
> Thank you for your time and assistance.
>
>
> Best regards,
> Naveen
>
>
>

