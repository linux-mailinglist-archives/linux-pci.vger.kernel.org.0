Return-Path: <linux-pci+bounces-20581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A440AA23BEE
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 11:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A343A9A8F
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 10:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E692F195FE8;
	Fri, 31 Jan 2025 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JR2zYnUH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440FC199384;
	Fri, 31 Jan 2025 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738318063; cv=none; b=MzvVAHQ8UUacn2AWgTDmokUenn7EEjiZCaiZznngDrBB7QJVyQRpwoPZqJOH1D0WrpwlW+Ho0S8PjzEl1Okvl4mcLNzpiGw+FYDMw5Z5jTgHQTPh4HJTijA2MnSKr7n0T8J0txiQ7OGP2AB8bzli2QlrI0Lh4y7t/ygo6n6s+IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738318063; c=relaxed/simple;
	bh=TCy8y32lLeTrBcJAiK6/xzrk3HwhbH5tSf0/V+bJi2Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kMLbbcvUAJhHznUjq8LzPufiod65WH8dPiykHXJDmqL2HadmvVzOIY55vy6u4B75OcoVYNWkzhQW1V8wtBzEgsE3mzIv2QFbRIRRJXOlIP7DY2lWDlAM8CQVtLwfEUYBjcKxXWxqv/U44aBO66bXPivqudbNJ1d/ihlW8H87I4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JR2zYnUH; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3061513d353so15870061fa.2;
        Fri, 31 Jan 2025 02:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738318058; x=1738922858; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=63qcbzAOiHHetxu0V40pV0L7ggrpCAuQd0Vg9bpxcSw=;
        b=JR2zYnUH+bxv87LKGnVSxUk1+f4SevS539gjLUp08kAC6J/YMT0acPyNFP9hCEJ0cP
         6RambDwevj91u//bYLe/34LLnKxLIZPZ3mULLQMM9Om33ITqYgb3naFTPFbrUXmIhgGd
         2DxldoocwlvRJyWxl4zEY4y+McRG8jMpHz7pgGIp8UplUtVqMXWHl4KXhzQ/U/AUsG3O
         ZJvuWXu0j5d06pvDaD3fqyxKcHubIfJIMO16szGM/o134QU5pzq5IIAUQv23jsoL0yKY
         iGqe5OxDjw1G8rEIblJtKNqcz3JfkCZuwSaAzN9Tqu9V/I+AZB27K9FreO9tOeWGX1WS
         nMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738318058; x=1738922858;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=63qcbzAOiHHetxu0V40pV0L7ggrpCAuQd0Vg9bpxcSw=;
        b=KCVOWD2WCxs8XEj1r16PAbl8VV1zHxKSDbJVwGHgocniJ4VaRNDuOoyNrMrdV3BLrp
         MyIPLWpM0Kfpzut2/1cANGjex6IaUnfvy3aooQqZhPmP/37o+2YY5gJU9GSWvwkhAP21
         ZJsrDmCOQgS4NLFv6ShJ2KtQfuQcCz8uvctlBBT/54YophTbtYM42cGiIG9I2AGMlbzt
         lb7eeIWGbWs3/ssRb1I4Kef/UgOHwSgNHQnmaYvnHMucW2qshAHGWjwffv37uqc+FiUR
         pSAGRisoLAPXdflWOaAN1py8L6vpis4TRQ+JwHdIjqG9++gBjlSoE+VXEX5n8NtAI5Du
         wVSw==
X-Gm-Message-State: AOJu0Yz+OZSeGs3hgaDfB84QS+jucRniznuigeM3iWpK7DdXhzV7sZVi
	nMCEIhmJFv/sypAQ///CxCA5SqZf3s7BpOAW0z3oxp0P73G3eW+zaxyd0sjUxEjn4ohCZz4nnt4
	OBEdSjB+UQ0Ktx8eK5zjWD6rqptPsfnU=
X-Gm-Gg: ASbGncu1zDAUGgqbx51WmQKf0ZAOtHozCVLQgws4DVIxN55XbpaRMrTro/2zsXA+KGP
	HqxUqXWzUIu5jd7FBr/6DDZdoxhs4gEc81CZ/gEknEmeXwk3p+eEbWqkJwXdjQEzEKJTFl8Kn3w
	==
X-Google-Smtp-Source: AGHT+IGYONbeI3FWpwLTpmjONGUGsnHJliw0hCrSi9RdcXN9PUmnQmif7fEx6WYi8UD4c5p1FFZzjA87cHVCJtrmgw0=
X-Received: by 2002:a2e:bc85:0:b0:304:4cec:29f9 with SMTP id
 38308e7fff4ca-3079680fd06mr33229791fa.3.1738318057946; Fri, 31 Jan 2025
 02:07:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naveen Kumar P <naveenkumar.parna@gmail.com>
Date: Fri, 31 Jan 2025 15:37:26 +0530
X-Gm-Features: AWEUYZlicQ61GfbPIhevOyQVJDpr67IECCM7UhlFtlGolq73vplDNMSB_V961g4
Message-ID: <CAMciSVUzFL+myQTTRD-OZRf+o9UUPDE87SzUxQ2cYdjrfd7iHQ@mail.gmail.com>
Subject: Assistance Needed: PCIe Device BAR Reset Issue
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: multipart/mixed; boundary="00000000000059df9b062cfdb68b"

--00000000000059df9b062cfdb68b
Content-Type: multipart/alternative; boundary="00000000000059df9a062cfdb689"

--00000000000059df9a062cfdb689
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Community,

I hope this message finds you well. I am reaching out to seek assistance
with an issue I am experiencing with a PCIe device on my system.

System Details:

PCIe Device: PLDA Device 5555
Kernel Version: 5.4.0-148-generic
Distribution: Ubuntu 20.04.6 LTS

After booting the system, I read the Base Address Register (BAR) of the
PCIe device using the following command:

setpci -s 01:00.0 BASE_ADDRESS_0

Initially, the BAR value is 0xb0400000. However, after some time, reading
from the PCIe device's BAR memory fails and returns 0xffff (PCIe
memory-mapped registers read via the readb(), readw(), and readl() kernel
mode APIs returned 0xff\0xffff\0xffffffff). Upon rechecking the BAR using
the same setpci command, the result is 0x00000000. Additionally, I verified
the BAR0 address using the kernel API pci_resource_start(), and it
exhibited the same behavior.

Steps Taken:

Verified the device status using lspci -vvv -s 01:00.0:
# lspci -vvv -s 01:00.0
01:00.0 RAM memory: PLDA Device 5555
        Subsystem: Device 4000:0000
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at b0400000 (32-bit, non-prefetchable) [virtual]
[size=4M]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [60] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
SlotPowerLimit 0.000W
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq- AuxPwr-
TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x2, ASPM L0s, Exit
Latency L0s unlimited
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s (ok), Width x2 (ok)
                        TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range B, TimeoutDis-,
NROPrPrP-, LTR-
                         10BitTagComp-, 10BitTagReq-, OBFF Not Supported,
ExtFmt-, EETLPPrefix-
                         EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
                         FRS-, TPHComp-, ExtTPHComp-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,
LTR-, OBFF Disabled
                         AtomicOpsCtl: ReqEn-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis+
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Kernel driver in use: M1801 PCI
        Kernel modules: m1801_pci

# lspci -xxx -s 01:00.0
01:00.0 RAM memory: PLDA Device 5555
00: 56 15 55 55 00 00 10 00 00 00 00 05 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
40: 01 48 03 00 08 00 00 00 05 60 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 02 00 c2 8f 00 00 10 28 01 00 21 f4 03 00
70: 00 00 21 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00
90: 20 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


Verified power management settings:

cat /sys/module/pcie_aspm/parameters/policy
Output: [default] performance powersave powersupersave


Request for Assistance: I would appreciate any guidance or suggestions on
how to further debug this issue. Specifically, I am looking for:

Potential causes for the BAR being reset to 0x00000000.
Steps to ensure the device is not being reset or put into a low-power state
unexpectedly.
Any additional diagnostic steps or tools that could help identify the root
cause.
Thank you for your time and assistance.


Best regards,
Naveen

--00000000000059df9a062cfdb689
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Linux Kernel Community,<br><br>I hope this message fi=
nds you well. I am reaching out to seek assistance with an issue I am exper=
iencing with a PCIe device on my system.<br><br>System Details:<br><br>PCIe=
 Device: PLDA Device 5555<br>Kernel Version: 5.4.0-148-generic<br>Distribut=
ion: Ubuntu 20.04.6 LTS<br><div><br></div><div>After booting the system, I =
read the Base Address Register (BAR) of the PCIe device using the following=
 command:<br><br>setpci -s 01:00.0 BASE_ADDRESS_0</div><div><br>Initially, =
the BAR value is 0xb0400000. However, after some time, reading from the PCI=
e device&#39;s BAR memory fails and returns 0xffff (PCIe memory-mapped regi=
sters read via the readb(), readw(), and readl() kernel mode APIs returned =
0xff\0xffff\0xffffffff). Upon rechecking the BAR using the same setpci comm=
and, the result is 0x00000000. Additionally, I verified the BAR0 address us=
ing the kernel API pci_resource_start(), and it exhibited the same behavior=
.</div><div><br></div><div>Steps Taken:<br><br>Verified the device status u=
sing lspci -vvv -s 01:00.0:<br># lspci -vvv -s 01:00.0<br>01:00.0 RAM memor=
y: PLDA Device 5555<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Subsystem: Device 4000:0=
000<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Control: I/O- Mem- BusMaster- SpecCycle-=
 MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &=
gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Interrupt: pin A routed to IRQ 16<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 Region 0: Memory at b0400000 (32-bit, non-prefetchable) [virtual] [=
size=3D4M]<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [40] Power Manageme=
nt version 3<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Fla=
gs: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: D0 NoSoft=
Rst+ PME-Enable- DSel=3D0 DScale=3D0 PME-<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Ca=
pabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit-<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Address: 00000000 =C2=A0Data: 00=
00<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [60] Express (v2) Endpoint,=
 MSI 00<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DevCap: =
MaxPayload 512 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0=
.000W<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DevCtl: Co=
rrErr- NonFatalErr- FatalErr- UnsupReq-<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RlxdOrd+ ExtTag- Phant=
Func- AuxPwr- NoSnoop+<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MaxPayload 128 bytes, MaxReadReq 512 byt=
es<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DevSta: CorrE=
rr+ NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LnkCap: Port #0, Speed 2.5GT/s, W=
idth x2, ASPM L0s, Exit Latency L0s unlimited<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ClockPM- Surpri=
se- LLActRep- BwNot- ASPMOptComp-<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LnkSta: Speed 2.5GT/s (ok), Width=
 x2 (ok)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DevCap2: Completion=
 Timeout: Range B, TimeoutDis-, NROPrPrP-, LTR-<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A010BitTagC=
omp-, 10BitTagReq-, OBFF Not Supported, ExtFmt-, EETLPPrefix-<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0FRS-, TPHComp-, ExtTPHComp-<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AtomicOpsCap=
: 32bit- 64bit- 128bitCAS-<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OB=
FF Disabled<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AtomicOpsCtl: ReqEn-<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LnkCtl2: Target Link Speed: 2.5GT/s, En=
terCompliance- SpeedDis+<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Transmit Margin: Normal Operat=
ing Range, EnterModifiedCompliance- ComplianceSOS-<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Compli=
ance De-emphasis: -6dB<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, E=
qualizationPhase1-<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EqualizationPhase2-, EqualizationPhas=
e3-, LinkEqualizationRequest-<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Kernel driver =
in use: M1801 PCI<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Kernel modules: m1801_pci<=
br></div><div><br></div><div># lspci -xxx -s 01:00.0<br>01:00.0 RAM memory:=
 PLDA Device 5555<br>00: 56 15 55 55 00 00 10 00 00 00 00 05 00 00 00 00<br=
>10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>20: 00 00 00 00 00 =
00 00 00 00 00 00 00 00 40 00 00<br>30: 00 00 00 00 40 00 00 00 00 00 00 00=
 ff 01 00 00<br>40: 01 48 03 00 08 00 00 00 05 60 00 00 00 00 00 00<br>50: =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>60: 10 00 02 00 c2 8f 00=
 00 10 28 01 00 21 f4 03 00<br>70: 00 00 21 00 00 00 00 00 00 00 00 00 00 0=
0 00 00<br>80: 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00<br>90: 20 00=
 01 00 00 00 00 00 00 00 00 00 00 00 00 00<br>a0: 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 00<br>b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00<br>c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>d0: 00 00 00 0=
0 00 00 00 00 00 00 00 00 00 00 00 00<br>e0: 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00<br>f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br=
></div><div><br></div><div><br></div><div>Verified power management setting=
s:<br><br></div><div>cat /sys/module/pcie_aspm/parameters/policy<br>Output:=
 [default] performance powersave powersupersave<br></div><div><br></div><di=
v><br></div><div>Request for Assistance: I would appreciate any guidance or=
 suggestions on how to further debug this issue. Specifically, I am looking=
 for:<br><br>Potential causes for the BAR being reset to 0x00000000.<br>Ste=
ps to ensure the device is not being reset or put into a low-power state un=
expectedly.<br>Any additional diagnostic steps or tools that could help ide=
ntify the root cause.<br>Thank you for your time and assistance.<br><br><br=
>Best regards,=C2=A0</div><div>Naveen<br></div><div><br></div><div><br></di=
v><div><br></div></div>

--00000000000059df9a062cfdb689--
--00000000000059df9b062cfdb68b
Content-Type: application/octet-stream; name=dmesg_log
Content-Disposition: attachment; filename=dmesg_log
Content-Transfer-Encoding: base64
Content-ID: <f_m6kljk330>
X-Attachment-Id: f_m6kljk330

WyAgICAwLjAwMDAwMF0gTGludXggdmVyc2lvbiA1LjQuMC0xNDgtZ2VuZXJpYyAoYnVpbGRkQGxj
eTAyLWFtZDY0LTExMikgKGdjYyB2ZXJzaW9uIDkuNC4wIChVYnVudHUgOS40LjAtMXVidW50dTF+
MjAuMDQuMSkpICMxNjUtVWJ1bnR1IFNNUCBUdWUgQXByIDE4IDA4OjUzOjEyIFVUQyAyMDIzIChV
YnVudHUgNS40LjAtMTQ4LjE2NS1nZW5lcmljIDUuNC4yMzEpClsgICAgMC4wMDAwMDBdIENvbW1h
bmQgbGluZTogQk9PVF9JTUFHRT0vdm1saW51ei01LjQuMC0xNDgtZ2VuZXJpYyByb290PS9kZXYv
bWFwcGVyL3ZnMDAtcm9vdHZvbCBybyBxdWlldCBsaWJhdGEuZm9yY2U9bm9uY3EgcGNpPW5vY3Jz
ClsgICAgMC4wMDAwMDBdIEtFUk5FTCBzdXBwb3J0ZWQgY3B1czoKWyAgICAwLjAwMDAwMF0gICBJ
bnRlbCBHZW51aW5lSW50ZWwKWyAgICAwLjAwMDAwMF0gICBBTUQgQXV0aGVudGljQU1EClsgICAg
MC4wMDAwMDBdICAgSHlnb24gSHlnb25HZW51aW5lClsgICAgMC4wMDAwMDBdICAgQ2VudGF1ciBD
ZW50YXVySGF1bHMKWyAgICAwLjAwMDAwMF0gICB6aGFveGluICAgU2hhbmdoYWkgIApbICAgIDAu
MDAwMDAwXSB4ODYvZnB1OiB4ODcgRlBVIHdpbGwgdXNlIEZYU0FWRQpbICAgIDAuMDAwMDAwXSBC
SU9TLXByb3ZpZGVkIHBoeXNpY2FsIFJBTSBtYXA6ClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDog
W21lbSAweDAwMDAwMDAwMDAwMDAwMDAtMHgwMDAwMDAwMDAwMDlkN2ZmXSB1c2FibGUKWyAgICAw
LjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDAwMDA5ZDgwMC0weDAwMDAwMDAwMDAw
OWZmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAw
MDAwZTAwMDAtMHgwMDAwMDAwMDAwMGZmZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9T
LWU4MjA6IFttZW0gMHgwMDAwMDAwMDAwMTAwMDAwLTB4MDAwMDAwMDAxZWZmZmZmZl0gdXNhYmxl
ClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwMWYwMDAwMDAtMHgwMDAw
MDAwMDFmMGZmZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgw
MDAwMDAwMDFmMTAwMDAwLTB4MDAwMDAwMDAxZmZmZmZmZl0gdXNhYmxlClsgICAgMC4wMDAwMDBd
IEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwMjAwMDAwMDAtMHgwMDAwMDAwMDIwMGZmZmZmXSBy
ZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDIwMTAwMDAw
LTB4MDAwMDAwMDA5OTYxNGZmZl0gdXNhYmxlClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21l
bSAweDAwMDAwMDAwOTk2MTUwMDAtMHgwMDAwMDAwMDk5NjQ0ZmZmXSByZXNlcnZlZApbICAgIDAu
MDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDk5NjQ1MDAwLTB4MDAwMDAwMDA5OTY1
NGZmZl0gQUNQSSBkYXRhClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAw
OTk2NTUwMDAtMHgwMDAwMDAwMDk5N2RhZmZmXSBBQ1BJIE5WUwpbICAgIDAuMDAwMDAwXSBCSU9T
LWU4MjA6IFttZW0gMHgwMDAwMDAwMDk5N2RiMDAwLTB4MDAwMDAwMDA5OWFmYmZmZl0gcmVzZXJ2
ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDA5OWFmYzAwMC0weDAw
MDAwMDAwOTlhZmNmZmZdIHVzYWJsZQpbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgw
MDAwMDAwMDk5YWZkMDAwLTB4MDAwMDAwMDA5OWIzZWZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAw
MF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDA5OWIzZjAwMC0weDAwMDAwMDAwOTljYWRmZmZd
IHVzYWJsZQpbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDk5Y2FlMDAw
LTB4MDAwMDAwMDA5OWZmOWZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBb
bWVtIDB4MDAwMDAwMDA5OWZmYTAwMC0weDAwMDAwMDAwOTlmZmZmZmZdIHVzYWJsZQpbICAgIDAu
MDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGUwMDAwMDAwLTB4MDAwMDAwMDBlZmZm
ZmZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDBm
ZWMwMDAwMC0weDAwMDAwMDAwZmVjMDBmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1Mt
ZTgyMDogW21lbSAweDAwMDAwMDAwZmVkMDEwMDAtMHgwMDAwMDAwMGZlZDAxZmZmXSByZXNlcnZl
ZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGZlZDAzMDAwLTB4MDAw
MDAwMDBmZWQwM2ZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4
MDAwMDAwMDBmZWQwODAwMC0weDAwMDAwMDAwZmVkMDhmZmZdIHJlc2VydmVkClsgICAgMC4wMDAw
MDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwZmVkMGMwMDAtMHgwMDAwMDAwMGZlZDBmZmZm
XSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGZlZDFj
MDAwLTB4MDAwMDAwMDBmZWQxY2ZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIw
OiBbbWVtIDB4MDAwMDAwMDBmZWUwMDAwMC0weDAwMDAwMDAwZmVlMDBmZmZdIHJlc2VydmVkClsg
ICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwZmVmMDAwMDAtMHgwMDAwMDAw
MGZlZmZmZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAw
MDAwMGZmYjAwMDAwLTB4MDAwMDAwMDBmZmZmZmZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0g
QklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDEwMDAwMDAwMC0weDAwMDAwMDAxNWZmZmZmZmZdIHVz
YWJsZQpbICAgIDAuMDAwMDAwXSBOWCAoRXhlY3V0ZSBEaXNhYmxlKSBwcm90ZWN0aW9uOiBhY3Rp
dmUKWyAgICAwLjAwMDAwMF0gU01CSU9TIDIuOCBwcmVzZW50LgpbICAgIDAuMDAwMDAwXSBETUk6
IEFETElOSyBUZWNobm9sb2d5IEluYy4gbmFub1gtQlQvVG8gYmUgZmlsbGVkIGJ5IE8uRS5NLiwg
QklPUyBRQzAxIDA5LzEwLzIwMjQKWyAgICAwLjAwMDAwMF0gdHNjOiBEZXRlY3RlZCAxOTE2LjY2
NyBNSHogcHJvY2Vzc29yClsgICAgMC4wMDM3NjddIGU4MjA6IHVwZGF0ZSBbbWVtIDB4MDAwMDAw
MDAtMHgwMDAwMGZmZl0gdXNhYmxlID09PiByZXNlcnZlZApbICAgIDAuMDAzNzcyXSBlODIwOiBy
ZW1vdmUgW21lbSAweDAwMGEwMDAwLTB4MDAwZmZmZmZdIHVzYWJsZQpbICAgIDAuMDAzNzg4XSBs
YXN0X3BmbiA9IDB4MTYwMDAwIG1heF9hcmNoX3BmbiA9IDB4NDAwMDAwMDAwClsgICAgMC4wMDM3
OTRdIE1UUlIgZGVmYXVsdCB0eXBlOiB1bmNhY2hhYmxlClsgICAgMC4wMDM3OTZdIE1UUlIgZml4
ZWQgcmFuZ2VzIGVuYWJsZWQ6ClsgICAgMC4wMDM3OTldICAgMDAwMDAtOUZGRkYgd3JpdGUtYmFj
awpbICAgIDAuMDAzODAyXSAgIEEwMDAwLUJGRkZGIHVuY2FjaGFibGUKWyAgICAwLjAwMzgwNF0g
ICBDMDAwMC1FN0ZGRiB3cml0ZS10aHJvdWdoClsgICAgMC4wMDM4MDddICAgRTgwMDAtRkZGRkYg
d3JpdGUtcHJvdGVjdApbICAgIDAuMDAzODA5XSBNVFJSIHZhcmlhYmxlIHJhbmdlcyBlbmFibGVk
OgpbICAgIDAuMDAzODEyXSAgIDAgYmFzZSAwMDAwMDAwMDAgbWFzayBGODAwMDAwMDAgd3JpdGUt
YmFjawpbICAgIDAuMDAzODE1XSAgIDEgYmFzZSAwODAwMDAwMDAgbWFzayBGRTAwMDAwMDAgd3Jp
dGUtYmFjawpbICAgIDAuMDAzODE4XSAgIDIgYmFzZSAwOUEwMDAwMDAgbWFzayBGRkUwMDAwMDAg
dW5jYWNoYWJsZQpbICAgIDAuMDAzODIxXSAgIDMgYmFzZSAwOUMwMDAwMDAgbWFzayBGRkMwMDAw
MDAgdW5jYWNoYWJsZQpbICAgIDAuMDAzODIzXSAgIDQgYmFzZSAxMDAwMDAwMDAgbWFzayBGODAw
MDAwMDAgd3JpdGUtYmFjawpbICAgIDAuMDAzODI1XSAgIDUgZGlzYWJsZWQKWyAgICAwLjAwMzgy
N10gICA2IGRpc2FibGVkClsgICAgMC4wMDM4MjldICAgNyBkaXNhYmxlZApbICAgIDAuMDAzOTI4
XSB4ODYvUEFUOiBDb25maWd1cmF0aW9uIFswLTddOiBXQiAgV0MgIFVDLSBVQyAgV0IgIFdQICBV
Qy0gV1QgIApbICAgIDAuMDA0MDQwXSB0b3RhbCBSQU0gY292ZXJlZDogNDUxMk0KWyAgICAwLjAw
NTIyN10gRm91bmQgb3B0aW1hbCBzZXR0aW5nIGZvciBtdHJyIGNsZWFuIHVwClsgICAgMC4wMDUy
MjldICBncmFuX3NpemU6IDY0SyAJY2h1bmtfc2l6ZTogNjRLIAludW1fcmVnOiA1ICAJbG9zZSBj
b3ZlciBSQU06IDBHClsgICAgMC4wMDUzMTldIGU4MjA6IHVwZGF0ZSBbbWVtIDB4OWEwMDAwMDAt
MHhmZmZmZmZmZl0gdXNhYmxlID09PiByZXNlcnZlZApbICAgIDAuMDA1MzI2XSBsYXN0X3BmbiA9
IDB4OWEwMDAgbWF4X2FyY2hfcGZuID0gMHg0MDAwMDAwMDAKWyAgICAwLjAxMTcxN10gZm91bmQg
U01QIE1QLXRhYmxlIGF0IFttZW0gMHgwMDBmZDZkMC0weDAwMGZkNmRmXQpbICAgIDAuMDEyMDQy
XSBjaGVjazogU2Nhbm5pbmcgMSBhcmVhcyBmb3IgbG93IG1lbW9yeSBjb3JydXB0aW9uClsgICAg
MC4wMTUyNjhdIFJBTURJU0s6IFttZW0gMHgyZDg3MTAwMC0weDMyYzJmZmZmXQpbICAgIDAuMDE1
MjgyXSBBQ1BJOiBFYXJseSB0YWJsZSBjaGVja3N1bSB2ZXJpZmljYXRpb24gZGlzYWJsZWQKWyAg
ICAwLjAxNTI5MF0gQUNQSTogUlNEUCAweDAwMDAwMDAwMDAwRjA0QTAgMDAwMDI0ICh2MDIgQUxB
U0tBKQpbICAgIDAuMDE1Mjk3XSBBQ1BJOiBYU0RUIDB4MDAwMDAwMDA5OTY0QTA4MCAwMDAwN0Mg
KHYwMSBBTEFTS0EgQSBNIEkgICAgMDEwNzIwMDkgQU1JICAwMDAxMDAxMykKWyAgICAwLjAxNTMx
MF0gQUNQSTogRkFDUCAweDAwMDAwMDAwOTk2NTJGQzAgMDAwMTBDICh2MDUgQUxBU0tBIEEgTSBJ
ICAgIDAxMDcyMDA5IEFNSSAgMDAwMTAwMTMpClsgICAgMC4wMTUzMjBdIEFDUEkgQklPUyBXYXJu
aW5nIChidWcpOiAzMi82NFggbGVuZ3RoIG1pc21hdGNoIGluIEZBRFQvR3BlMEJsb2NrOiAxMjgv
MzIgKDIwMTkwODE2L3RiZmFkdC01NjQpClsgICAgMC4wMTUzMzBdIEFDUEk6IERTRFQgMHgwMDAw
MDAwMDk5NjRBMTg4IDAwOEUzMiAodjAyIEFMQVNLQSBBIE0gSSAgICAwMTA3MjAwOSBJTlRMIDIw
MTIwOTEzKQpbICAgIDAuMDE1MzM4XSBBQ1BJOiBGQUNTIDB4MDAwMDAwMDA5OTdEQUY4MCAwMDAw
NDAKWyAgICAwLjAxNTM0NV0gQUNQSTogQVBJQyAweDAwMDAwMDAwOTk2NTMwRDAgMDAwMDg0ICh2
MDMgQUxBU0tBIEEgTSBJICAgIDAxMDcyMDA5IEFNSSAgMDAwMTAwMTMpClsgICAgMC4wMTUzNTNd
IEFDUEk6IEZQRFQgMHgwMDAwMDAwMDk5NjUzMTU4IDAwMDA0NCAodjAxIEFMQVNLQSBBIE0gSSAg
ICAwMTA3MjAwOSBBTUkgIDAwMDEwMDEzKQpbICAgIDAuMDE1MzYwXSBBQ1BJOiBMUElUIDB4MDAw
MDAwMDA5OTY1MzFBMCAwMDAxMDQgKHYwMSBBTEFTS0EgQSBNIEkgICAgMDAwMDAwMDMgVkxWMiAw
MTAwMDAwRCkKWyAgICAwLjAxNTM2OF0gQUNQSTogTUNGRyAweDAwMDAwMDAwOTk2NTMyQTggMDAw
MDNDICh2MDEgQUxBU0tBIEEgTSBJICAgIDAxMDcyMDA5IE1TRlQgMDAwMDAwOTcpClsgICAgMC4w
MTUzNzVdIEFDUEk6IEhQRVQgMHgwMDAwMDAwMDk5NjUzMkU4IDAwMDAzOCAodjAxIEFMQVNLQSBB
IE0gSSAgICAwMTA3MjAwOSBBTUkuIDAwMDAwMDA1KQpbICAgIDAuMDE1MzgzXSBBQ1BJOiBTU0RU
IDB4MDAwMDAwMDA5OTY1MzMyMCAwMDA3NjMgKHYwMSBQbVJlZiAgQ3B1UG0gICAgMDAwMDMwMDAg
SU5UTCAyMDA2MTEwOSkKWyAgICAwLjAxNTM5MV0gQUNQSTogU1NEVCAweDAwMDAwMDAwOTk2NTNB
ODggMDAwMjkwICh2MDEgUG1SZWYgIENwdTBUc3QgIDAwMDAzMDAwIElOVEwgMjAwNjExMDkpClsg
ICAgMC4wMTUzOTldIEFDUEk6IFNTRFQgMHgwMDAwMDAwMDk5NjUzRDE4IDAwMDE3QSAodjAxIFBt
UmVmICBBcFRzdCAgICAwMDAwMzAwMCBJTlRMIDIwMDYxMTA5KQpbICAgIDAuMDE1NDA3XSBBQ1BJ
OiBVRUZJIDB4MDAwMDAwMDA5OTY1M0U5OCAwMDAwNDIgKHYwMSBBTEFTS0EgQSBNIEkgICAgMDAw
MDAwMDAgICAgICAwMDAwMDAwMCkKWyAgICAwLjAxNTQxNF0gQUNQSTogQ1NSVCAweDAwMDAwMDAw
OTk2NTNFRTAgMDAwMTRDICh2MDAgSU5URUwgIEVESzIgICAgIDAwMDAwMDA1IElOVEwgMjAxMjA2
MjQpClsgICAgMC4wMTU0MjJdIEFDUEk6IFJlc2VydmluZyBGQUNQIHRhYmxlIG1lbW9yeSBhdCBb
bWVtIDB4OTk2NTJmYzAtMHg5OTY1MzBjYl0KWyAgICAwLjAxNTQyNV0gQUNQSTogUmVzZXJ2aW5n
IERTRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg5OTY0YTE4OC0weDk5NjUyZmI5XQpbICAgIDAu
MDE1NDI3XSBBQ1BJOiBSZXNlcnZpbmcgRkFDUyB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDk5N2Rh
ZjgwLTB4OTk3ZGFmYmZdClsgICAgMC4wMTU0MjldIEFDUEk6IFJlc2VydmluZyBBUElDIHRhYmxl
IG1lbW9yeSBhdCBbbWVtIDB4OTk2NTMwZDAtMHg5OTY1MzE1M10KWyAgICAwLjAxNTQzMl0gQUNQ
STogUmVzZXJ2aW5nIEZQRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg5OTY1MzE1OC0weDk5NjUz
MTliXQpbICAgIDAuMDE1NDM0XSBBQ1BJOiBSZXNlcnZpbmcgTFBJVCB0YWJsZSBtZW1vcnkgYXQg
W21lbSAweDk5NjUzMWEwLTB4OTk2NTMyYTNdClsgICAgMC4wMTU0MzddIEFDUEk6IFJlc2Vydmlu
ZyBNQ0ZHIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4OTk2NTMyYTgtMHg5OTY1MzJlM10KWyAgICAw
LjAxNTQzOV0gQUNQSTogUmVzZXJ2aW5nIEhQRVQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg5OTY1
MzJlOC0weDk5NjUzMzFmXQpbICAgIDAuMDE1NDQxXSBBQ1BJOiBSZXNlcnZpbmcgU1NEVCB0YWJs
ZSBtZW1vcnkgYXQgW21lbSAweDk5NjUzMzIwLTB4OTk2NTNhODJdClsgICAgMC4wMTU0NDRdIEFD
UEk6IFJlc2VydmluZyBTU0RUIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4OTk2NTNhODgtMHg5OTY1
M2QxN10KWyAgICAwLjAxNTQ0Nl0gQUNQSTogUmVzZXJ2aW5nIFNTRFQgdGFibGUgbWVtb3J5IGF0
IFttZW0gMHg5OTY1M2QxOC0weDk5NjUzZTkxXQpbICAgIDAuMDE1NDQ5XSBBQ1BJOiBSZXNlcnZp
bmcgVUVGSSB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDk5NjUzZTk4LTB4OTk2NTNlZDldClsgICAg
MC4wMTU0NTFdIEFDUEk6IFJlc2VydmluZyBDU1JUIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4OTk2
NTNlZTAtMHg5OTY1NDAyYl0KWyAgICAwLjAxNTQ3Ml0gQUNQSTogTG9jYWwgQVBJQyBhZGRyZXNz
IDB4ZmVlMDAwMDAKWyAgICAwLjAxNTY4M10gTm8gTlVNQSBjb25maWd1cmF0aW9uIGZvdW5kClsg
ICAgMC4wMTU2ODZdIEZha2luZyBhIG5vZGUgYXQgW21lbSAweDAwMDAwMDAwMDAwMDAwMDAtMHgw
MDAwMDAwMTVmZmZmZmZmXQpbICAgIDAuMDE1NzA2XSBOT0RFX0RBVEEoMCkgYWxsb2NhdGVkIFtt
ZW0gMHgxNWZmZDMwMDAtMHgxNWZmZmRmZmZdClsgICAgMC4wMTY0MDBdIFpvbmUgcmFuZ2VzOgpb
ICAgIDAuMDE2NDAyXSAgIERNQSAgICAgIFttZW0gMHgwMDAwMDAwMDAwMDAxMDAwLTB4MDAwMDAw
MDAwMGZmZmZmZl0KWyAgICAwLjAxNjQwNV0gICBETUEzMiAgICBbbWVtIDB4MDAwMDAwMDAwMTAw
MDAwMC0weDAwMDAwMDAwZmZmZmZmZmZdClsgICAgMC4wMTY0MDhdICAgTm9ybWFsICAgW21lbSAw
eDAwMDAwMDAxMDAwMDAwMDAtMHgwMDAwMDAwMTVmZmZmZmZmXQpbICAgIDAuMDE2NDEwXSAgIERl
dmljZSAgIGVtcHR5ClsgICAgMC4wMTY0MTJdIE1vdmFibGUgem9uZSBzdGFydCBmb3IgZWFjaCBu
b2RlClsgICAgMC4wMTY0MjBdIEVhcmx5IG1lbW9yeSBub2RlIHJhbmdlcwpbICAgIDAuMDE2NDIy
XSAgIG5vZGUgICAwOiBbbWVtIDB4MDAwMDAwMDAwMDAwMTAwMC0weDAwMDAwMDAwMDAwOWNmZmZd
ClsgICAgMC4wMTY0MjVdICAgbm9kZSAgIDA6IFttZW0gMHgwMDAwMDAwMDAwMTAwMDAwLTB4MDAw
MDAwMDAxZWZmZmZmZl0KWyAgICAwLjAxNjQyN10gICBub2RlICAgMDogW21lbSAweDAwMDAwMDAw
MWYxMDAwMDAtMHgwMDAwMDAwMDFmZmZmZmZmXQpbICAgIDAuMDE2NDI5XSAgIG5vZGUgICAwOiBb
bWVtIDB4MDAwMDAwMDAyMDEwMDAwMC0weDAwMDAwMDAwOTk2MTRmZmZdClsgICAgMC4wMTY0MzJd
ICAgbm9kZSAgIDA6IFttZW0gMHgwMDAwMDAwMDk5YWZjMDAwLTB4MDAwMDAwMDA5OWFmY2ZmZl0K
WyAgICAwLjAxNjQzNF0gICBub2RlICAgMDogW21lbSAweDAwMDAwMDAwOTliM2YwMDAtMHgwMDAw
MDAwMDk5Y2FkZmZmXQpbICAgIDAuMDE2NDM2XSAgIG5vZGUgICAwOiBbbWVtIDB4MDAwMDAwMDA5
OWZmYTAwMC0weDAwMDAwMDAwOTlmZmZmZmZdClsgICAgMC4wMTY0MzhdICAgbm9kZSAgIDA6IFtt
ZW0gMHgwMDAwMDAwMTAwMDAwMDAwLTB4MDAwMDAwMDE1ZmZmZmZmZl0KWyAgICAwLjAxNjk5OF0g
WmVyb2VkIHN0cnVjdCBwYWdlIGluIHVuYXZhaWxhYmxlIHJhbmdlczogMjczNTMgcGFnZXMKWyAg
ICAwLjAxNzAwMV0gSW5pdG1lbSBzZXR1cCBub2RlIDAgW21lbSAweDAwMDAwMDAwMDAwMDEwMDAt
MHgwMDAwMDAwMTVmZmZmZmZmXQpbICAgIDAuMDE3MDA2XSBPbiBub2RlIDAgdG90YWxwYWdlczog
MTAyMTIyMwpbICAgIDAuMDE3MDA5XSAgIERNQSB6b25lOiA2NCBwYWdlcyB1c2VkIGZvciBtZW1t
YXAKWyAgICAwLjAxNzAxMV0gICBETUEgem9uZTogMjEgcGFnZXMgcmVzZXJ2ZWQKWyAgICAwLjAx
NzAxM10gICBETUEgem9uZTogMzk5NiBwYWdlcywgTElGTyBiYXRjaDowClsgICAgMC4wMTcxNDld
ICAgRE1BMzIgem9uZTogOTc1MSBwYWdlcyB1c2VkIGZvciBtZW1tYXAKWyAgICAwLjAxNzE1Ml0g
ICBETUEzMiB6b25lOiA2MjQwMTEgcGFnZXMsIExJRk8gYmF0Y2g6NjMKWyAgICAwLjA0MjMzMl0g
ICBOb3JtYWwgem9uZTogNjE0NCBwYWdlcyB1c2VkIGZvciBtZW1tYXAKWyAgICAwLjA0MjMzN10g
ICBOb3JtYWwgem9uZTogMzkzMjE2IHBhZ2VzLCBMSUZPIGJhdGNoOjYzClsgICAgMC4wNTUwOTld
IHg4Ni9ocGV0OiBXaWxsIGRpc2FibGUgdGhlIEhQRVQgZm9yIHRoaXMgcGxhdGZvcm0gYmVjYXVz
ZSBpdCdzIG5vdCByZWxpYWJsZQpbICAgIDAuMDU1MTEwXSBSZXNlcnZpbmcgSW50ZWwgZ3JhcGhp
Y3MgbWVtb3J5IGF0IFttZW0gMHg5YjAwMDAwMC0weDllZmZmZmZmXQpbICAgIDAuMDU1MjA0XSBB
Q1BJOiBQTS1UaW1lciBJTyBQb3J0OiAweDQwOApbICAgIDAuMDU1MjEwXSBBQ1BJOiBMb2NhbCBB
UElDIGFkZHJlc3MgMHhmZWUwMDAwMApbICAgIDAuMDU1MjI2XSBBQ1BJOiBMQVBJQ19OTUkgKGFj
cGlfaWRbMHgwMV0gbG93IGxldmVsIGxpbnRbMHhhMV0pClsgICAgMC4wNTUyMjhdIEFDUEk6IE5N
SSBub3QgY29ubmVjdGVkIHRvIExJTlQgMSEKWyAgICAwLjA1NTIzMF0gQUNQSTogTEFQSUNfTk1J
IChhY3BpX2lkWzB4MDJdIHJlcyBsZXZlbCBsaW50WzB4MjVdKQpbICAgIDAuMDU1MjMyXSBBQ1BJ
OiBOTUkgbm90IGNvbm5lY3RlZCB0byBMSU5UIDEhClsgICAgMC4wNTUyMzRdIEFDUEk6IExBUElD
X05NSSAoYWNwaV9pZFsweDAzXSBoaWdoIGRmbCBsaW50WzB4YWFdKQpbICAgIDAuMDU1MjM1XSBB
Q1BJOiBOTUkgbm90IGNvbm5lY3RlZCB0byBMSU5UIDEhClsgICAgMC4wNTUyMzddIEFDUEk6IExB
UElDX05NSSAoYWNwaV9pZFsweDA0XSBoaWdoIGVkZ2UgbGludFsweGRiXSkKWyAgICAwLjA1NTIz
OV0gQUNQSTogTk1JIG5vdCBjb25uZWN0ZWQgdG8gTElOVCAxIQpbICAgIDAuMDU1MjU0XSBJT0FQ
SUNbMF06IGFwaWNfaWQgMSwgdmVyc2lvbiAzMiwgYWRkcmVzcyAweGZlYzAwMDAwLCBHU0kgMC04
NgpbICAgIDAuMDU1MjU5XSBBQ1BJOiBJTlRfU1JDX09WUiAoYnVzIDAgYnVzX2lycSAwIGdsb2Jh
bF9pcnEgMiBkZmwgZGZsKQpbICAgIDAuMDU1MjYyXSBBQ1BJOiBJTlRfU1JDX09WUiAoYnVzIDAg
YnVzX2lycSA5IGdsb2JhbF9pcnEgOSBoaWdoIGxldmVsKQpbICAgIDAuMDU1MjY2XSBBQ1BJOiBJ
UlEwIHVzZWQgYnkgb3ZlcnJpZGUuClsgICAgMC4wNTUyNjhdIEFDUEk6IElSUTkgdXNlZCBieSBv
dmVycmlkZS4KWyAgICAwLjA1NTI3M10gVXNpbmcgQUNQSSAoTUFEVCkgZm9yIFNNUCBjb25maWd1
cmF0aW9uIGluZm9ybWF0aW9uClsgICAgMC4wNTUyNzZdIEFDUEk6IEhQRVQgaWQ6IDB4ODA4NmEy
MDEgYmFzZTogMHhmZWQwMDAwMApbICAgIDAuMDU1Mjg2XSBUU0MgZGVhZGxpbmUgdGltZXIgYXZh
aWxhYmxlClsgICAgMC4wNTUyODldIHNtcGJvb3Q6IEFsbG93aW5nIDQgQ1BVcywgMCBob3RwbHVn
IENQVXMKWyAgICAwLjA1NTM1OV0gUE06IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAw
eDAwMDAwMDAwLTB4MDAwMDBmZmZdClsgICAgMC4wNTUzNjVdIFBNOiBSZWdpc3RlcmVkIG5vc2F2
ZSBtZW1vcnk6IFttZW0gMHgwMDA5ZDAwMC0weDAwMDlkZmZmXQpbICAgIDAuMDU1MzY3XSBQTTog
UmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4MDAwOWUwMDAtMHgwMDA5ZmZmZl0KWyAg
ICAwLjA1NTM2OF0gUE06IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweDAwMGEwMDAw
LTB4MDAwZGZmZmZdClsgICAgMC4wNTUzNzBdIFBNOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6
IFttZW0gMHgwMDBlMDAwMC0weDAwMGZmZmZmXQpbICAgIDAuMDU1Mzc1XSBQTTogUmVnaXN0ZXJl
ZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4MWYwMDAwMDAtMHgxZjBmZmZmZl0KWyAgICAwLjA1NTM4
MF0gUE06IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweDIwMDAwMDAwLTB4MjAwZmZm
ZmZdClsgICAgMC4wNTUzODVdIFBNOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHg5
OTYxNTAwMC0weDk5NjQ0ZmZmXQpbICAgIDAuMDU1Mzg3XSBQTTogUmVnaXN0ZXJlZCBub3NhdmUg
bWVtb3J5OiBbbWVtIDB4OTk2NDUwMDAtMHg5OTY1NGZmZl0KWyAgICAwLjA1NTM4OV0gUE06IFJl
Z2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweDk5NjU1MDAwLTB4OTk3ZGFmZmZdClsgICAg
MC4wNTUzOTFdIFBNOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHg5OTdkYjAwMC0w
eDk5YWZiZmZmXQpbICAgIDAuMDU1Mzk2XSBQTTogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBb
bWVtIDB4OTlhZmQwMDAtMHg5OWIzZWZmZl0KWyAgICAwLjA1NTQwMV0gUE06IFJlZ2lzdGVyZWQg
bm9zYXZlIG1lbW9yeTogW21lbSAweDk5Y2FlMDAwLTB4OTlmZjlmZmZdClsgICAgMC4wNTU0MDZd
IFBNOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHg5YTAwMDAwMC0weDlhZmZmZmZm
XQpbICAgIDAuMDU1NDA4XSBQTTogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4OWIw
MDAwMDAtMHg5ZWZmZmZmZl0KWyAgICAwLjA1NTQxMF0gUE06IFJlZ2lzdGVyZWQgbm9zYXZlIG1l
bW9yeTogW21lbSAweDlmMDAwMDAwLTB4ZGZmZmZmZmZdClsgICAgMC4wNTU0MTJdIFBNOiBSZWdp
c3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHhlMDAwMDAwMC0weGVmZmZmZmZmXQpbICAgIDAu
MDU1NDE0XSBQTTogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4ZjAwMDAwMDAtMHhm
ZWJmZmZmZl0KWyAgICAwLjA1NTQxNV0gUE06IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21l
bSAweGZlYzAwMDAwLTB4ZmVjMDBmZmZdClsgICAgMC4wNTU0MTddIFBNOiBSZWdpc3RlcmVkIG5v
c2F2ZSBtZW1vcnk6IFttZW0gMHhmZWMwMTAwMC0weGZlZDAwZmZmXQpbICAgIDAuMDU1NDE5XSBQ
TTogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4ZmVkMDEwMDAtMHhmZWQwMWZmZl0K
WyAgICAwLjA1NTQyMV0gUE06IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweGZlZDAy
MDAwLTB4ZmVkMDJmZmZdClsgICAgMC4wNTU0MjNdIFBNOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1v
cnk6IFttZW0gMHhmZWQwMzAwMC0weGZlZDAzZmZmXQpbICAgIDAuMDU1NDI0XSBQTTogUmVnaXN0
ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4ZmVkMDQwMDAtMHhmZWQwN2ZmZl0KWyAgICAwLjA1
NTQyNl0gUE06IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweGZlZDA4MDAwLTB4ZmVk
MDhmZmZdClsgICAgMC4wNTU0MjhdIFBNOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0g
MHhmZWQwOTAwMC0weGZlZDBiZmZmXQpbICAgIDAuMDU1NDMwXSBQTTogUmVnaXN0ZXJlZCBub3Nh
dmUgbWVtb3J5OiBbbWVtIDB4ZmVkMGMwMDAtMHhmZWQwZmZmZl0KWyAgICAwLjA1NTQzMV0gUE06
IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweGZlZDEwMDAwLTB4ZmVkMWJmZmZdClsg
ICAgMC4wNTU0MzNdIFBNOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHhmZWQxYzAw
MC0weGZlZDFjZmZmXQpbICAgIDAuMDU1NDM1XSBQTTogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5
OiBbbWVtIDB4ZmVkMWQwMDAtMHhmZWRmZmZmZl0KWyAgICAwLjA1NTQzN10gUE06IFJlZ2lzdGVy
ZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweGZlZTAwMDAwLTB4ZmVlMDBmZmZdClsgICAgMC4wNTU0
MzldIFBNOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHhmZWUwMTAwMC0weGZlZWZm
ZmZmXQpbICAgIDAuMDU1NDQwXSBQTTogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4
ZmVmMDAwMDAtMHhmZWZmZmZmZl0KWyAgICAwLjA1NTQ0Ml0gUE06IFJlZ2lzdGVyZWQgbm9zYXZl
IG1lbW9yeTogW21lbSAweGZmMDAwMDAwLTB4ZmZhZmZmZmZdClsgICAgMC4wNTU0NDRdIFBNOiBS
ZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHhmZmIwMDAwMC0weGZmZmZmZmZmXQpbICAg
IDAuMDU1NDQ4XSBbbWVtIDB4OWYwMDAwMDAtMHhkZmZmZmZmZl0gYXZhaWxhYmxlIGZvciBQQ0kg
ZGV2aWNlcwpbICAgIDAuMDU1NDUwXSBCb290aW5nIHBhcmF2aXJ0dWFsaXplZCBrZXJuZWwgb24g
YmFyZSBoYXJkd2FyZQpbICAgIDAuMDU1NDU2XSBjbG9ja3NvdXJjZTogcmVmaW5lZC1qaWZmaWVz
OiBtYXNrOiAweGZmZmZmZmZmIG1heF9jeWNsZXM6IDB4ZmZmZmZmZmYsIG1heF9pZGxlX25zOiA3
NjQ1NTE5NjAwMjExNTY4IG5zClsgICAgMC4wNTU0NzRdIHNldHVwX3BlcmNwdTogTlJfQ1BVUzo4
MTkyIG5yX2NwdW1hc2tfYml0czo0IG5yX2NwdV9pZHM6NCBucl9ub2RlX2lkczoxClsgICAgMC4w
NTY0OTBdIHBlcmNwdTogRW1iZWRkZWQgNjAgcGFnZXMvY3B1IHMyMDg4OTYgcjgxOTIgZDI4Njcy
IHU1MjQyODgKWyAgICAwLjA1NjUxMl0gcGNwdS1hbGxvYzogczIwODg5NiByODE5MiBkMjg2NzIg
dTUyNDI4OCBhbGxvYz0xKjIwOTcxNTIKWyAgICAwLjA1NjUxNV0gcGNwdS1hbGxvYzogWzBdIDAg
MSAyIDMgClsgICAgMC4wNTY2MDJdIEJ1aWx0IDEgem9uZWxpc3RzLCBtb2JpbGl0eSBncm91cGlu
ZyBvbi4gIFRvdGFsIHBhZ2VzOiAxMDA1MjQzClsgICAgMC4wNTY2MDRdIFBvbGljeSB6b25lOiBO
b3JtYWwKWyAgICAwLjA1NjYwOF0gS2VybmVsIGNvbW1hbmQgbGluZTogQk9PVF9JTUFHRT0vdm1s
aW51ei01LjQuMC0xNDgtZ2VuZXJpYyByb290PS9kZXYvbWFwcGVyL3ZnMDAtcm9vdHZvbCBybyBx
dWlldCBsaWJhdGEuZm9yY2U9bm9uY3EgcGNpPW5vY3JzClsgICAgMC4wNTgwMzVdIERlbnRyeSBj
YWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDUyNDI4OCAob3JkZXI6IDEwLCA0MTk0MzA0IGJ5dGVz
LCBsaW5lYXIpClsgICAgMC4wNTg3MTZdIElub2RlLWNhY2hlIGhhc2ggdGFibGUgZW50cmllczog
MjYyMTQ0IChvcmRlcjogOSwgMjA5NzE1MiBieXRlcywgbGluZWFyKQpbICAgIDAuMDU4Nzk4XSBt
ZW0gYXV0by1pbml0OiBzdGFjazpvZmYsIGhlYXAgYWxsb2M6b24sIGhlYXAgZnJlZTpvZmYKWyAg
ICAwLjA4MTY3OV0gQ2FsZ2FyeTogZGV0ZWN0aW5nIENhbGdhcnkgdmlhIEJJT1MgRUJEQSBhcmVh
ClsgICAgMC4wODE2ODNdIENhbGdhcnk6IFVuYWJsZSB0byBsb2NhdGUgUmlvIEdyYW5kZSB0YWJs
ZSBpbiBFQkRBIC0gYmFpbGluZyEKWyAgICAwLjExMzQ1M10gTWVtb3J5OiAzODIzMzQwSy80MDg0
ODkySyBhdmFpbGFibGUgKDE0MzM5SyBrZXJuZWwgY29kZSwgMjM5NEsgcndkYXRhLCA5NTA0SyBy
b2RhdGEsIDI3NjRLIGluaXQsIDQ5NDRLIGJzcywgMjYxNTUySyByZXNlcnZlZCwgMEsgY21hLXJl
c2VydmVkKQpbICAgIDAuMTE0MzkwXSBTTFVCOiBIV2FsaWduPTY0LCBPcmRlcj0wLTMsIE1pbk9i
amVjdHM9MCwgQ1BVcz00LCBOb2Rlcz0xClsgICAgMC4xMTQ0NDBdIEtlcm5lbC9Vc2VyIHBhZ2Ug
dGFibGVzIGlzb2xhdGlvbjogZW5hYmxlZApbICAgIDAuMTE0NDc0XSBmdHJhY2U6IGFsbG9jYXRp
bmcgNDQ2NjEgZW50cmllcyBpbiAxNzUgcGFnZXMKWyAgICAwLjE0NDY5OV0gcmN1OiBIaWVyYXJj
aGljYWwgUkNVIGltcGxlbWVudGF0aW9uLgpbICAgIDAuMTQ0NzA0XSByY3U6IAlSQ1UgcmVzdHJp
Y3RpbmcgQ1BVcyBmcm9tIE5SX0NQVVM9ODE5MiB0byBucl9jcHVfaWRzPTQuClsgICAgMC4xNDQ3
MDZdIAlUYXNrcyBSQ1UgZW5hYmxlZC4KWyAgICAwLjE0NDcwOF0gcmN1OiBSQ1UgY2FsY3VsYXRl
ZCB2YWx1ZSBvZiBzY2hlZHVsZXItZW5saXN0bWVudCBkZWxheSBpcyAyNSBqaWZmaWVzLgpbICAg
IDAuMTQ0NzEwXSByY3U6IEFkanVzdGluZyBnZW9tZXRyeSBmb3IgcmN1X2Zhbm91dF9sZWFmPTE2
LCBucl9jcHVfaWRzPTQKWyAgICAwLjE1MzEzNl0gTlJfSVJRUzogNTI0NTQ0LCBucl9pcnFzOiAx
MDI0LCBwcmVhbGxvY2F0ZWQgaXJxczogMTYKWyAgICAwLjE1MzUyMl0gcmFuZG9tOiBjcm5nIGlu
aXQgZG9uZQpbICAgIDAuMTUzNTYxXSBzcHVyaW91cyA4MjU5QSBpbnRlcnJ1cHQ6IElSUTcuClsg
ICAgMC4xNTM1OTBdIENvbnNvbGU6IGNvbG91ciBkdW1teSBkZXZpY2UgODB4MjUKWyAgICAwLjE1
MzU5OF0gcHJpbnRrOiBjb25zb2xlIFt0dHkwXSBlbmFibGVkClsgICAgMC4xNTM2NDZdIEFDUEk6
IENvcmUgcmV2aXNpb24gMjAxOTA4MTYKWyAgICAwLjE1MzgxN10gQVBJQzogU3dpdGNoIHRvIHN5
bW1ldHJpYyBJL08gbW9kZSBzZXR1cApbICAgIDAuMTU0MzY4XSBjbG9ja3NvdXJjZTogdHNjLWVh
cmx5OiBtYXNrOiAweGZmZmZmZmZmZmZmZmZmZmYgbWF4X2N5Y2xlczogMHgzNzQxNTk0ZDM0ZCwg
bWF4X2lkbGVfbnM6IDg4MTU5MDQyMDU2NCBucwpbICAgIDAuMTU0Mzc3XSBDYWxpYnJhdGluZyBk
ZWxheSBsb29wIChza2lwcGVkKSwgdmFsdWUgY2FsY3VsYXRlZCB1c2luZyB0aW1lciBmcmVxdWVu
Y3kuLiAzODMzLjMzIEJvZ29NSVBTIChscGo9NzY2NjY2OCkKWyAgICAwLjE1NDM4Ml0gcGlkX21h
eDogZGVmYXVsdDogMzI3NjggbWluaW11bTogMzAxClsgICAgMC4xNTQ0NjhdIExTTTogU2VjdXJp
dHkgRnJhbWV3b3JrIGluaXRpYWxpemluZwpbICAgIDAuMTU0NDk2XSBZYW1hOiBiZWNvbWluZyBt
aW5kZnVsLgpbICAgIDAuMTU0NTY1XSBBcHBBcm1vcjogQXBwQXJtb3IgaW5pdGlhbGl6ZWQKWyAg
ICAwLjE1NDY1Nl0gTW91bnQtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA4MTkyIChvcmRlcjog
NCwgNjU1MzYgYnl0ZXMsIGxpbmVhcikKWyAgICAwLjE1NDY3N10gTW91bnRwb2ludC1jYWNoZSBo
YXNoIHRhYmxlIGVudHJpZXM6IDgxOTIgKG9yZGVyOiA0LCA2NTUzNiBieXRlcywgbGluZWFyKQpb
ICAgIDAuMTU0NzE0XSAqKiogVkFMSURBVEUgdG1wZnMgKioqClsgICAgMC4xNTUwMjVdICoqKiBW
QUxJREFURSBwcm9jICoqKgpbICAgIDAuMTU1MTU2XSAqKiogVkFMSURBVEUgY2dyb3VwMSAqKioK
WyAgICAwLjE1NTE2MF0gKioqIFZBTElEQVRFIGNncm91cDIgKioqClsgICAgMC4xNTUyNTddIHBy
b2Nlc3M6IHVzaW5nIG13YWl0IGluIGlkbGUgdGhyZWFkcwpbICAgIDAuMTU1MjY0XSBMYXN0IGxl
dmVsIGlUTEIgZW50cmllczogNEtCIDQ4LCAyTUIgMCwgNE1CIDAKWyAgICAwLjE1NTI2Nl0gTGFz
dCBsZXZlbCBkVExCIGVudHJpZXM6IDRLQiAxMjgsIDJNQiAxNiwgNE1CIDE2LCAxR0IgMApbICAg
IDAuMTU1MjczXSBTcGVjdHJlIFYxIDogTWl0aWdhdGlvbjogdXNlcmNvcHkvc3dhcGdzIGJhcnJp
ZXJzIGFuZCBfX3VzZXIgcG9pbnRlciBzYW5pdGl6YXRpb24KWyAgICAwLjE1NTI3N10gU3BlY3Ry
ZSBWMiA6IE1pdGlnYXRpb246IFJldHBvbGluZXMKWyAgICAwLjE1NTI3OF0gU3BlY3RyZSBWMiA6
IFNwZWN0cmUgdjIgLyBTcGVjdHJlUlNCIG1pdGlnYXRpb246IEZpbGxpbmcgUlNCIG9uIGNvbnRl
eHQgc3dpdGNoClsgICAgMC4xNTUyODBdIFNwZWN0cmUgVjIgOiBTcGVjdHJlIHYyIC8gU3BlY3Ry
ZVJTQiA6IEZpbGxpbmcgUlNCIG9uIFZNRVhJVApbICAgIDAuMTU1MjgxXSBTcGVjdHJlIFYyIDog
RW5hYmxpbmcgUmVzdHJpY3RlZCBTcGVjdWxhdGlvbiBmb3IgZmlybXdhcmUgY2FsbHMKWyAgICAw
LjE1NTI4NV0gU3BlY3RyZSBWMiA6IG1pdGlnYXRpb246IEVuYWJsaW5nIGNvbmRpdGlvbmFsIElu
ZGlyZWN0IEJyYW5jaCBQcmVkaWN0aW9uIEJhcnJpZXIKWyAgICAwLjE1NTI4OV0gTURTOiBNaXRp
Z2F0aW9uOiBDbGVhciBDUFUgYnVmZmVycwpbICAgIDAuMTU1MjkxXSBNTUlPIFN0YWxlIERhdGE6
IFVua25vd246IE5vIG1pdGlnYXRpb25zClsgICAgMC4xNTU1NzldIEZyZWVpbmcgU01QIGFsdGVy
bmF0aXZlcyBtZW1vcnk6IDQwSwpbICAgIDAuMTU4MzcyXSBzbXBib290OiBDUFUwOiBJbnRlbChS
KSBBdG9tKFRNKSBDUFUgIEUzODQ1ICBAIDEuOTFHSHogKGZhbWlseTogMHg2LCBtb2RlbDogMHgz
Nywgc3RlcHBpbmc6IDB4OSkKWyAgICAwLjE1ODM3Ml0gUGVyZm9ybWFuY2UgRXZlbnRzOiBQRUJT
IGZtdDIrLCA4LWRlZXAgTEJSLCBTaWx2ZXJtb250IGV2ZW50cywgOC1kZWVwIExCUiwgZnVsbC13
aWR0aCBjb3VudGVycywgSW50ZWwgUE1VIGRyaXZlci4KWyAgICAwLjE1ODM3Ml0gLi4uIHZlcnNp
b246ICAgICAgICAgICAgICAgIDMKWyAgICAwLjE1ODM3Ml0gLi4uIGJpdCB3aWR0aDogICAgICAg
ICAgICAgIDQwClsgICAgMC4xNTgzNzJdIC4uLiBnZW5lcmljIHJlZ2lzdGVyczogICAgICAyClsg
ICAgMC4xNTgzNzJdIC4uLiB2YWx1ZSBtYXNrOiAgICAgICAgICAgICAwMDAwMDBmZmZmZmZmZmZm
ClsgICAgMC4xNTgzNzJdIC4uLiBtYXggcGVyaW9kOiAgICAgICAgICAgICAwMDAwMDA3ZmZmZmZm
ZmZmClsgICAgMC4xNTgzNzJdIC4uLiBmaXhlZC1wdXJwb3NlIGV2ZW50czogICAzClsgICAgMC4x
NTgzNzJdIC4uLiBldmVudCBtYXNrOiAgICAgICAgICAgICAwMDAwMDAwNzAwMDAwMDAzClsgICAg
MC4xNTgzNzJdIHJjdTogSGllcmFyY2hpY2FsIFNSQ1UgaW1wbGVtZW50YXRpb24uClsgICAgMC4x
NTgzNzJdIE5NSSB3YXRjaGRvZzogRW5hYmxlZC4gUGVybWFuZW50bHkgY29uc3VtZXMgb25lIGh3
LVBNVSBjb3VudGVyLgpbICAgIDAuMTU4MzcyXSBzbXA6IEJyaW5naW5nIHVwIHNlY29uZGFyeSBD
UFVzIC4uLgpbICAgIDAuMTU4MzcyXSB4ODY6IEJvb3RpbmcgU01QIGNvbmZpZ3VyYXRpb246Clsg
ICAgMC4xNTgzNzJdIC4uLi4gbm9kZSAgIzAsIENQVXM6ICAgICAgIzEgIzIgIzMKWyAgICAwLjE2
ODcxOF0gc21wOiBCcm91Z2h0IHVwIDEgbm9kZSwgNCBDUFVzClsgICAgMC4xNjg3MThdIHNtcGJv
b3Q6IE1heCBsb2dpY2FsIHBhY2thZ2VzOiAxClsgICAgMC4xNjg3MThdIHNtcGJvb3Q6IFRvdGFs
IG9mIDQgcHJvY2Vzc29ycyBhY3RpdmF0ZWQgKDE1MzMzLjMzIEJvZ29NSVBTKQpbICAgIDAuMTY4
NzE4XSBkZXZ0bXBmczogaW5pdGlhbGl6ZWQKWyAgICAwLjE2ODcxOF0geDg2L21tOiBNZW1vcnkg
YmxvY2sgc2l6ZTogMTI4TUIKWyAgICAwLjE3MTU0Ml0gUE06IFJlZ2lzdGVyaW5nIEFDUEkgTlZT
IHJlZ2lvbiBbbWVtIDB4OTk2NTUwMDAtMHg5OTdkYWZmZl0gKDE1OTc0NDAgYnl0ZXMpClsgICAg
MC4xNzE1NDJdIGNsb2Nrc291cmNlOiBqaWZmaWVzOiBtYXNrOiAweGZmZmZmZmZmIG1heF9jeWNs
ZXM6IDB4ZmZmZmZmZmYsIG1heF9pZGxlX25zOiA3NjQ1MDQxNzg1MTAwMDAwIG5zClsgICAgMC4x
NzE1NDJdIGZ1dGV4IGhhc2ggdGFibGUgZW50cmllczogMTAyNCAob3JkZXI6IDQsIDY1NTM2IGJ5
dGVzLCBsaW5lYXIpClsgICAgMC4xNzE1NDJdIHBpbmN0cmwgY29yZTogaW5pdGlhbGl6ZWQgcGlu
Y3RybCBzdWJzeXN0ZW0KWyAgICAwLjE3MTU0Ml0gUE06IFJUQyB0aW1lOiAwNjoyMzowMCwgZGF0
ZTogMjAyNS0wMS0zMQpbICAgIDAuMTcxNTQyXSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFt
aWx5IDE2ClsgICAgMC4xNzE1NDJdIGF1ZGl0OiBpbml0aWFsaXppbmcgbmV0bGluayBzdWJzeXMg
KGRpc2FibGVkKQpbICAgIDAuMTcxNTQyXSBhdWRpdDogdHlwZT0yMDAwIGF1ZGl0KDE3MzgzMDQ1
ODAuMDE2OjEpOiBzdGF0ZT1pbml0aWFsaXplZCBhdWRpdF9lbmFibGVkPTAgcmVzPTEKWyAgICAw
LjE3MTU0Ml0gRUlTQSBidXMgcmVnaXN0ZXJlZApbICAgIDAuMTcxNTQyXSBjcHVpZGxlOiB1c2lu
ZyBnb3Zlcm5vciBsYWRkZXIKWyAgICAwLjE3MTU0Ml0gY3B1aWRsZTogdXNpbmcgZ292ZXJub3Ig
bWVudQpbICAgIDAuMTcxNTQyXSBBQ1BJOiBidXMgdHlwZSBQQ0kgcmVnaXN0ZXJlZApbICAgIDAu
MTcxNTQyXSBhY3BpcGhwOiBBQ1BJIEhvdCBQbHVnIFBDSSBDb250cm9sbGVyIERyaXZlciB2ZXJz
aW9uOiAwLjUKWyAgICAwLjE3MTU0Ml0gUENJOiBNTUNPTkZJRyBmb3IgZG9tYWluIDAwMDAgW2J1
cyAwMC1mZl0gYXQgW21lbSAweGUwMDAwMDAwLTB4ZWZmZmZmZmZdIChiYXNlIDB4ZTAwMDAwMDAp
ClsgICAgMC4xNzE1NDJdIFBDSTogTU1DT05GSUcgYXQgW21lbSAweGUwMDAwMDAwLTB4ZWZmZmZm
ZmZdIHJlc2VydmVkIGluIEU4MjAKWyAgICAwLjE3MTU0Ml0gUENJOiBVc2luZyBjb25maWd1cmF0
aW9uIHR5cGUgMSBmb3IgYmFzZSBhY2Nlc3MKWyAgICAwLjE3MTY1Nl0gRU5FUkdZX1BFUkZfQklB
UzogU2V0IHRvICdub3JtYWwnLCB3YXMgJ3BlcmZvcm1hbmNlJwpbICAgIDAuMTc4NDUyXSBIdWdl
VExCIHJlZ2lzdGVyZWQgMi4wMCBNaUIgcGFnZSBzaXplLCBwcmUtYWxsb2NhdGVkIDAgcGFnZXMK
WyAgICAwLjE4MjM5OV0gQUNQSTogQWRkZWQgX09TSShNb2R1bGUgRGV2aWNlKQpbICAgIDAuMTgy
NDAyXSBBQ1BJOiBBZGRlZCBfT1NJKFByb2Nlc3NvciBEZXZpY2UpClsgICAgMC4xODI0MDRdIEFD
UEk6IEFkZGVkIF9PU0koMy4wIF9TQ1AgRXh0ZW5zaW9ucykKWyAgICAwLjE4MjQwNl0gQUNQSTog
QWRkZWQgX09TSShQcm9jZXNzb3IgQWdncmVnYXRvciBEZXZpY2UpClsgICAgMC4xODI0MDhdIEFD
UEk6IEFkZGVkIF9PU0koTGludXgtRGVsbC1WaWRlbykKWyAgICAwLjE4MjQxMF0gQUNQSTogQWRk
ZWQgX09TSShMaW51eC1MZW5vdm8tTlYtSERNSS1BdWRpbykKWyAgICAwLjE4MjQxM10gQUNQSTog
QWRkZWQgX09TSShMaW51eC1IUEktSHlicmlkLUdyYXBoaWNzKQpbICAgIDAuMjAzMzE3XSBBQ1BJ
OiA0IEFDUEkgQU1MIHRhYmxlcyBzdWNjZXNzZnVsbHkgYWNxdWlyZWQgYW5kIGxvYWRlZApbICAg
IDAuMjA4NzY5XSBBQ1BJOiBEeW5hbWljIE9FTSBUYWJsZSBMb2FkOgpbICAgIDAuMjA4NzgyXSBB
Q1BJOiBTU0RUIDB4RkZGRjg4QTFEQUFEREMwMCAwMDAzN0EgKHYwMSBQbVJlZiAgQ3B1MElzdCAg
MDAwMDMwMDAgSU5UTCAyMDA2MTEwOSkKWyAgICAwLjIxMDk0Nl0gQUNQSTogRHluYW1pYyBPRU0g
VGFibGUgTG9hZDoKWyAgICAwLjIxMDk1Nl0gQUNQSTogU1NEVCAweEZGRkY4OEExREE4QzEwMDAg
MDAwNDMzICh2MDEgUG1SZWYgIENwdTBDc3QgIDAwMDAzMDAxIElOVEwgMjAwNjExMDkpClsgICAg
MC4yMTI2ODldIEFDUEk6IER5bmFtaWMgT0VNIFRhYmxlIExvYWQ6ClsgICAgMC4yMTI2ODldIEFD
UEk6IFNTRFQgMHhGRkZGODhBMURBOTIxQzAwIDAwMDE1RiAodjAxIFBtUmVmICBBcElzdCAgICAw
MDAwMzAwMCBJTlRMIDIwMDYxMTA5KQpbICAgIDAuMjE1NzIyXSBBQ1BJOiBEeW5hbWljIE9FTSBU
YWJsZSBMb2FkOgpbICAgIDAuMjE1NzMxXSBBQ1BJOiBTU0RUIDB4RkZGRjg4QTFEQThGNDZDMCAw
MDAwOEQgKHYwMSBQbVJlZiAgQXBDc3QgICAgMDAwMDMwMDAgSU5UTCAyMDA2MTEwOSkKWyAgICAw
LjIyMTM3N10gQUNQSTogSW50ZXJwcmV0ZXIgZW5hYmxlZApbICAgIDAuMjIxNDM1XSBBQ1BJOiAo
c3VwcG9ydHMgUzAgUzMgUzQgUzUpClsgICAgMC4yMjE0MzhdIEFDUEk6IFVzaW5nIElPQVBJQyBm
b3IgaW50ZXJydXB0IHJvdXRpbmcKWyAgICAwLjIyMTU1MV0gUENJOiBJZ25vcmluZyBob3N0IGJy
aWRnZSB3aW5kb3dzIGZyb20gQUNQSTsgaWYgbmVjZXNzYXJ5LCB1c2UgInBjaT11c2VfY3JzIiBh
bmQgcmVwb3J0IGEgYnVnClsgICAgMC4yMjI4MTldIEFDUEk6IEVuYWJsZWQgMTMgR1BFcyBpbiBi
bG9jayAwMCB0byAzRgpbICAgIDAuNDUwMTE5XSBBQ1BJOiBQb3dlciBSZXNvdXJjZSBbVVNCQ10g
KG9uKQpbICAgIDAuNDUzNzE2XSBBQ1BJOiBQb3dlciBSZXNvdXJjZSBbUExQRV0gKG9uKQpbICAg
IDAuNDU0NDc5XSBBQ1BJOiBQb3dlciBSZXNvdXJjZSBbUExQRV0gKG9uKQpbICAgIDAuNDU4MTk2
XSBBQ1BJOiBQQ0kgUm9vdCBCcmlkZ2UgW1BDSTBdIChkb21haW4gMDAwMCBbYnVzIDAwLWZmXSkK
WyAgICAwLjQ1ODIxMV0gYWNwaSBQTlAwQTA4OjAwOiBfT1NDOiBPUyBzdXBwb3J0cyBbRXh0ZW5k
ZWRDb25maWcgQVNQTSBDbG9ja1BNIFNlZ21lbnRzIE1TSSBIUFgtVHlwZTNdClsgICAgMC40NTky
OTFdIGFjcGkgUE5QMEEwODowMDogX09TQzogcGxhdGZvcm0gZG9lcyBub3Qgc3VwcG9ydCBbUENJ
ZUhvdHBsdWcgU0hQQ0hvdHBsdWcgUE1FXQpbICAgIDAuNDYwMTU3XSBhY3BpIFBOUDBBMDg6MDA6
IF9PU0M6IE9TIG5vdyBjb250cm9scyBbQUVSIFBDSWVDYXBhYmlsaXR5IExUUl0KWyAgICAwLjQ2
MDc1NF0gYWNwaSBQTlAwQTA4OjAwOiBob3N0IGJyaWRnZSB3aW5kb3cgW2lvICAweDAwNzAtMHgw
MDc3XSAoaWdub3JlZCkKWyAgICAwLjQ2MDc1OF0gYWNwaSBQTlAwQTA4OjAwOiBob3N0IGJyaWRn
ZSB3aW5kb3cgW2lvICAweDBjZjgtMHgwY2ZmXSAoaWdub3JlZCkKWyAgICAwLjQ2MDc2Ml0gYWNw
aSBQTlAwQTA4OjAwOiBob3N0IGJyaWRnZSB3aW5kb3cgW2lvICAweDAwMDAtMHgwMDZmIHdpbmRv
d10gKGlnbm9yZWQpClsgICAgMC40NjA3NjVdIGFjcGkgUE5QMEEwODowMDogaG9zdCBicmlkZ2Ug
d2luZG93IFtpbyAgMHgwMDc4LTB4MGNmNyB3aW5kb3ddIChpZ25vcmVkKQpbICAgIDAuNDYwNzY4
XSBhY3BpIFBOUDBBMDg6MDA6IGhvc3QgYnJpZGdlIHdpbmRvdyBbaW8gIDB4MGQwMC0weGZmZmYg
d2luZG93XSAoaWdub3JlZCkKWyAgICAwLjQ2MDc3MV0gYWNwaSBQTlAwQTA4OjAwOiBob3N0IGJy
aWRnZSB3aW5kb3cgW21lbSAweDAwMGEwMDAwLTB4MDAwYmZmZmYgd2luZG93XSAoaWdub3JlZCkK
WyAgICAwLjQ2MDc3NF0gYWNwaSBQTlAwQTA4OjAwOiBob3N0IGJyaWRnZSB3aW5kb3cgW21lbSAw
eDAwMGMwMDAwLTB4MDAwZGZmZmYgd2luZG93XSAoaWdub3JlZCkKWyAgICAwLjQ2MDc3Nl0gYWNw
aSBQTlAwQTA4OjAwOiBob3N0IGJyaWRnZSB3aW5kb3cgW21lbSAweDAwMGUwMDAwLTB4MDAwZmZm
ZmYgd2luZG93XSAoaWdub3JlZCkKWyAgICAwLjQ2MDc4MF0gYWNwaSBQTlAwQTA4OjAwOiBob3N0
IGJyaWRnZSB3aW5kb3cgW21lbSAweGEwMDAwMDAwLTB4YjBiMTdmZmYgd2luZG93XSAoaWdub3Jl
ZCkKWyAgICAwLjQ2MDc4Ml0gUENJOiByb290IGJ1cyAwMDogdXNpbmcgZGVmYXVsdCByZXNvdXJj
ZXMKWyAgICAwLjQ2MTgyOV0gUENJIGhvc3QgYnJpZGdlIHRvIGJ1cyAwMDAwOjAwClsgICAgMC40
NjE4MzVdIHBjaV9idXMgMDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2UgW2lvICAweDAwMDAtMHhm
ZmZmXQpbICAgIDAuNDYxODM4XSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJlc291cmNlIFtt
ZW0gMHgwMDAwMDAwMC0weGZmZmZmZmZmZl0KWyAgICAwLjQ2MTg0Ml0gcGNpX2J1cyAwMDAwOjAw
OiByb290IGJ1cyByZXNvdXJjZSBbYnVzIDAwLWZmXQpbICAgIDAuNDYxODYzXSBwY2kgMDAwMDow
MDowMC4wOiBbODA4NjowZjAwXSB0eXBlIDAwIGNsYXNzIDB4MDYwMDAwClsgICAgMC40NjIyNjJd
IHBjaSAwMDAwOjAwOjAyLjA6IFs4MDg2OjBmMzFdIHR5cGUgMDAgY2xhc3MgMHgwMzAwMDAKWyAg
ICAwLjQ2MjI3OV0gcGNpIDAwMDA6MDA6MDIuMDogcmVnIDB4MTA6IFttZW0gMHhiMDAwMDAwMC0w
eGIwM2ZmZmZmXQpbICAgIDAuNDYyMjkxXSBwY2kgMDAwMDowMDowMi4wOiByZWcgMHgxODogW21l
bSAweGEwMDAwMDAwLTB4YWZmZmZmZmYgcHJlZl0KWyAgICAwLjQ2MjMwMl0gcGNpIDAwMDA6MDA6
MDIuMDogcmVnIDB4MjA6IFtpbyAgMHhlMDgwLTB4ZTA4N10KWyAgICAwLjQ2MjcwM10gcGNpIDAw
MDA6MDA6MTMuMDogWzgwODY6MGYyM10gdHlwZSAwMCBjbGFzcyAweDAxMDYwMQpbICAgIDAuNDYy
NzI2XSBwY2kgMDAwMDowMDoxMy4wOiByZWcgMHgxMDogW2lvICAweGUwNzAtMHhlMDc3XQpbICAg
IDAuNDYyNzM2XSBwY2kgMDAwMDowMDoxMy4wOiByZWcgMHgxNDogW2lvICAweGUwNjAtMHhlMDYz
XQpbICAgIDAuNDYyNzQ2XSBwY2kgMDAwMDowMDoxMy4wOiByZWcgMHgxODogW2lvICAweGUwNTAt
MHhlMDU3XQpbICAgIDAuNDYyNzU2XSBwY2kgMDAwMDowMDoxMy4wOiByZWcgMHgxYzogW2lvICAw
eGUwNDAtMHhlMDQzXQpbICAgIDAuNDYyNzY1XSBwY2kgMDAwMDowMDoxMy4wOiByZWcgMHgyMDog
W2lvICAweGUwMjAtMHhlMDNmXQpbICAgIDAuNDYyNzc1XSBwY2kgMDAwMDowMDoxMy4wOiByZWcg
MHgyNDogW21lbSAweGIwYjE3MDAwLTB4YjBiMTc3ZmZdClsgICAgMC40NjI4MjldIHBjaSAwMDAw
OjAwOjEzLjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDNob3QKWyAgICAwLjQ2MzE5N10gcGNpIDAw
MDA6MDA6MTQuMDogWzgwODY6MGYzNV0gdHlwZSAwMCBjbGFzcyAweDBjMDMzMApbICAgIDAuNDYz
MjIxXSBwY2kgMDAwMDowMDoxNC4wOiByZWcgMHgxMDogW21lbSAweGIwYjAwMDAwLTB4YjBiMGZm
ZmYgNjRiaXRdClsgICAgMC40NjMyODhdIHBjaSAwMDAwOjAwOjE0LjA6IFBNRSMgc3VwcG9ydGVk
IGZyb20gRDNob3QgRDNjb2xkClsgICAgMC40NjM2NDJdIHBjaSAwMDAwOjAwOjE3LjA6IFs4MDg2
OjBmNTBdIHR5cGUgMDAgY2xhc3MgMHgwODA1MDEKWyAgICAwLjQ2MzY2NV0gcGNpIDAwMDA6MDA6
MTcuMDogcmVnIDB4MTA6IFttZW0gMHhiMGIxNjAwMC0weGIwYjE2ZmZmXQpbICAgIDAuNDYzNjc2
XSBwY2kgMDAwMDowMDoxNy4wOiByZWcgMHgxNDogW21lbSAweGIwYjE1MDAwLTB4YjBiMTVmZmZd
ClsgICAgMC40NjM3NTFdIHBjaSAwMDAwOjAwOjE3LjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAg
RDNob3QKWyAgICAwLjQ2NDIwNV0gcGNpIDAwMDA6MDA6MWEuMDogWzgwODY6MGYxOF0gdHlwZSAw
MCBjbGFzcyAweDEwODAwMApbICAgIDAuNDY0MjM2XSBwY2kgMDAwMDowMDoxYS4wOiByZWcgMHgx
MDogW21lbSAweGIwOTAwMDAwLTB4YjA5ZmZmZmZdClsgICAgMC40NjQyNTBdIHBjaSAwMDAwOjAw
OjFhLjA6IHJlZyAweDE0OiBbbWVtIDB4YjA4MDAwMDAtMHhiMDhmZmZmZl0KWyAgICAwLjQ2NDM1
OF0gcGNpIDAwMDA6MDA6MWEuMDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdApbICAgIDAu
NDY0Nzg5XSBwY2kgMDAwMDowMDoxYi4wOiBbODA4NjowZjA0XSB0eXBlIDAwIGNsYXNzIDB4MDQw
MzAwClsgICAgMC40NjQ4MTddIHBjaSAwMDAwOjAwOjFiLjA6IHJlZyAweDEwOiBbbWVtIDB4YjBi
MTAwMDAtMHhiMGIxM2ZmZiA2NGJpdF0KWyAgICAwLjQ2NDg5Nl0gcGNpIDAwMDA6MDA6MWIuMDog
UE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdCBEM2NvbGQKWyAgICAwLjQ2NTI1Ml0gcGNpIDAw
MDA6MDA6MWMuMDogWzgwODY6MGY0OF0gdHlwZSAwMSBjbGFzcyAweDA2MDQwMApbICAgIDAuNDY1
MzM4XSBwY2kgMDAwMDowMDoxYy4wOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90IEQzY29s
ZApbICAgIDAuNDY1NzEwXSBwY2kgMDAwMDowMDoxYy4yOiBbODA4NjowZjRjXSB0eXBlIDAxIGNs
YXNzIDB4MDYwNDAwClsgICAgMC40NjU3OTRdIHBjaSAwMDAwOjAwOjFjLjI6IFBNRSMgc3VwcG9y
dGVkIGZyb20gRDAgRDNob3QgRDNjb2xkClsgICAgMC40NjYxNTNdIHBjaSAwMDAwOjAwOjFjLjM6
IFs4MDg2OjBmNGVdIHR5cGUgMDEgY2xhc3MgMHgwNjA0MDAKWyAgICAwLjQ2NjIzN10gcGNpIDAw
MDA6MDA6MWMuMzogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdCBEM2NvbGQKWyAgICAwLjQ2
NjYxMF0gcGNpIDAwMDA6MDA6MWYuMDogWzgwODY6MGYxY10gdHlwZSAwMCBjbGFzcyAweDA2MDEw
MApbICAgIDAuNDY3MDQ4XSBwY2kgMDAwMDowMDoxZi4zOiBbODA4NjowZjEyXSB0eXBlIDAwIGNs
YXNzIDB4MGMwNTAwClsgICAgMC40NjcwOTRdIHBjaSAwMDAwOjAwOjFmLjM6IHJlZyAweDEwOiBb
bWVtIDB4YjBiMTQwMDAtMHhiMGIxNDAxZl0KWyAgICAwLjQ2NzE2NV0gcGNpIDAwMDA6MDA6MWYu
MzogcmVnIDB4MjA6IFtpbyAgMHhlMDAwLTB4ZTAxZl0KWyAgICAwLjQ2Nzc0MV0gcGNpIDAwMDA6
MDE6MDAuMDogWzE1NTY6NTU1NV0gdHlwZSAwMCBjbGFzcyAweDA1MDAwMApbICAgIDAuNDY3Nzc2
XSBwY2kgMDAwMDowMTowMC4wOiByZWcgMHgxMDogW21lbSAweGIwNDAwMDAwLTB4YjA3ZmZmZmZd
ClsgICAgMC40Nzg0MTFdIHBjaSAwMDAwOjAwOjFjLjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwMV0K
WyAgICAwLjQ3ODQxOF0gcGNpIDAwMDA6MDA6MWMuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHhi
MDQwMDAwMC0weGIwN2ZmZmZmXQpbICAgIDAuNDc4NTQzXSBwY2kgMDAwMDowMDoxYy4yOiBQQ0kg
YnJpZGdlIHRvIFtidXMgMDJdClsgICAgMC40Nzg3MTddIHBjaSAwMDAwOjAzOjAwLjA6IFs4MDg2
OjE1MzNdIHR5cGUgMDAgY2xhc3MgMHgwMjAwMDAKWyAgICAwLjQ3ODc1N10gcGNpIDAwMDA6MDM6
MDAuMDogcmVnIDB4MTA6IFttZW0gMHhiMGEwMDAwMC0weGIwYTdmZmZmXQpbICAgIDAuNDc4Nzg1
XSBwY2kgMDAwMDowMzowMC4wOiByZWcgMHgxODogW2lvICAweGQwMDAtMHhkMDFmXQpbICAgIDAu
NDc4ODAxXSBwY2kgMDAwMDowMzowMC4wOiByZWcgMHgxYzogW21lbSAweGIwYTgwMDAwLTB4YjBh
ODNmZmZdClsgICAgMC40Nzg5NTJdIHBjaSAwMDAwOjAzOjAwLjA6IFBNRSMgc3VwcG9ydGVkIGZy
b20gRDAgRDNob3QgRDNjb2xkClsgICAgMC40NzkxNzNdIHBjaSAwMDAwOjAwOjFjLjM6IFBDSSBi
cmlkZ2UgdG8gW2J1cyAwM10KWyAgICAwLjQ3OTE3OV0gcGNpIDAwMDA6MDA6MWMuMzogICBicmlk
Z2Ugd2luZG93IFtpbyAgMHhkMDAwLTB4ZGZmZl0KWyAgICAwLjQ3OTE4M10gcGNpIDAwMDA6MDA6
MWMuMzogICBicmlkZ2Ugd2luZG93IFttZW0gMHhiMGEwMDAwMC0weGIwYWZmZmZmXQpbICAgIDMu
NDIzNDA4XSBBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0FdIChJUlFzIDMgNCA1IDYgMTAg
KjExIDEyIDE0IDE1KQpbICAgIDMuNDIzNjgzXSBBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xO
S0JdIChJUlFzIDMgNCA1IDYgMTAgMTEgMTIgMTQgMTUpICowLCBkaXNhYmxlZC4KWyAgICAzLjQy
Mzk1NV0gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktDXSAoSVJRcyAzIDQgNSA2IDEwICox
MSAxMiAxNCAxNSkKWyAgICAzLjQyNDIyOF0gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktE
XSAoSVJRcyAzIDQgNSA2ICoxMCAxMSAxMiAxNCAxNSkKWyAgICAzLjQyNDUwMl0gQUNQSTogUENJ
IEludGVycnVwdCBMaW5rIFtMTktFXSAoSVJRcyAzIDQgNSA2IDEwICoxMSAxMiAxNCAxNSkKWyAg
ICAzLjQyNDc3NF0gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktGXSAoSVJRcyAzIDQgNSA2
IDEwICoxMSAxMiAxNCAxNSkKWyAgICAzLjQyNTA0Nl0gQUNQSTogUENJIEludGVycnVwdCBMaW5r
IFtMTktHXSAoSVJRcyAzIDQgNSA2ICoxMCAxMSAxMiAxNCAxNSkKWyAgICAzLjQyNTMxOV0gQUNQ
STogUENJIEludGVycnVwdCBMaW5rIFtMTktIXSAoSVJRcyAzIDQgNSA2ICoxMCAxMSAxMiAxNCAx
NSkKWyAgICAzLjQyNjU2M10gaW9tbXU6IERlZmF1bHQgZG9tYWluIHR5cGU6IFRyYW5zbGF0ZWQg
ClsgICAgMy40MjY4NzldIFNDU0kgc3Vic3lzdGVtIGluaXRpYWxpemVkClsgICAgMy40MjY4OThd
IGxpYmF0YSB2ZXJzaW9uIDMuMDAgbG9hZGVkLgpbICAgIDMuNDI2ODk4XSBwY2kgMDAwMDowMDow
Mi4wOiB2Z2FhcmI6IHNldHRpbmcgYXMgYm9vdCBWR0EgZGV2aWNlClsgICAgMy40MjY4OThdIHBj
aSAwMDAwOjAwOjAyLjA6IHZnYWFyYjogVkdBIGRldmljZSBhZGRlZDogZGVjb2Rlcz1pbyttZW0s
b3ducz1pbyttZW0sbG9ja3M9bm9uZQpbICAgIDMuNDI2ODk4XSBwY2kgMDAwMDowMDowMi4wOiB2
Z2FhcmI6IGJyaWRnZSBjb250cm9sIHBvc3NpYmxlClsgICAgMy40MjY4OThdIHZnYWFyYjogbG9h
ZGVkClsgICAgMy40MjY4OThdIEFDUEk6IGJ1cyB0eXBlIFVTQiByZWdpc3RlcmVkClsgICAgMy40
MjY4OThdIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgdXNiZnMKWyAg
ICAzLjQyNjg5OF0gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciBodWIK
WyAgICAzLjQyNjg5OF0gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgZGV2aWNlIGRyaXZlciB1c2IK
WyAgICAzLjQyNjg5OF0gcHBzX2NvcmU6IExpbnV4UFBTIEFQSSB2ZXIuIDEgcmVnaXN0ZXJlZApb
ICAgIDMuNDI2ODk4XSBwcHNfY29yZTogU29mdHdhcmUgdmVyLiA1LjMuNiAtIENvcHlyaWdodCAy
MDA1LTIwMDcgUm9kb2xmbyBHaW9tZXR0aSA8Z2lvbWV0dGlAbGludXguaXQ+ClsgICAgMy40MjY4
OThdIFBUUCBjbG9jayBzdXBwb3J0IHJlZ2lzdGVyZWQKWyAgICAzLjQyNjg5OF0gRURBQyBNQzog
VmVyOiAzLjAuMApbICAgIDMuNDI2ODk4XSBQQ0k6IFVzaW5nIEFDUEkgZm9yIElSUSByb3V0aW5n
ClsgICAgMy40MzAyODddIFBDSTogcGNpX2NhY2hlX2xpbmVfc2l6ZSBzZXQgdG8gNjQgYnl0ZXMK
WyAgICAzLjQzMDM0MF0gZTgyMDogcmVzZXJ2ZSBSQU0gYnVmZmVyIFttZW0gMHgwMDA5ZDgwMC0w
eDAwMDlmZmZmXQpbICAgIDMuNDMwMzQzXSBlODIwOiByZXNlcnZlIFJBTSBidWZmZXIgW21lbSAw
eDFmMDAwMDAwLTB4MWZmZmZmZmZdClsgICAgMy40MzAzNDZdIGU4MjA6IHJlc2VydmUgUkFNIGJ1
ZmZlciBbbWVtIDB4OTk2MTUwMDAtMHg5YmZmZmZmZl0KWyAgICAzLjQzMDM0OF0gZTgyMDogcmVz
ZXJ2ZSBSQU0gYnVmZmVyIFttZW0gMHg5OWFmZDAwMC0weDliZmZmZmZmXQpbICAgIDMuNDMwMzUw
XSBlODIwOiByZXNlcnZlIFJBTSBidWZmZXIgW21lbSAweDk5Y2FlMDAwLTB4OWJmZmZmZmZdClsg
ICAgMy40MzAzNTNdIGU4MjA6IHJlc2VydmUgUkFNIGJ1ZmZlciBbbWVtIDB4OWEwMDAwMDAtMHg5
YmZmZmZmZl0KWyAgICAzLjQzMDU5NV0gTmV0TGFiZWw6IEluaXRpYWxpemluZwpbICAgIDMuNDMw
NTk4XSBOZXRMYWJlbDogIGRvbWFpbiBoYXNoIHNpemUgPSAxMjgKWyAgICAzLjQzMDU5OV0gTmV0
TGFiZWw6ICBwcm90b2NvbHMgPSBVTkxBQkVMRUQgQ0lQU092NCBDQUxJUFNPClsgICAgMy40MzA2
MzddIE5ldExhYmVsOiAgdW5sYWJlbGVkIHRyYWZmaWMgYWxsb3dlZCBieSBkZWZhdWx0ClsgICAg
My40MzQ0NDJdIGNsb2Nrc291cmNlOiBTd2l0Y2hlZCB0byBjbG9ja3NvdXJjZSB0c2MtZWFybHkK
WyAgICAzLjQ2NTk4NV0gKioqIFZBTElEQVRFIGJwZiAqKioKWyAgICAzLjQ2NjExOF0gVkZTOiBE
aXNrIHF1b3RhcyBkcXVvdF82LjYuMApbICAgIDMuNDY2MTU0XSBWRlM6IERxdW90LWNhY2hlIGhh
c2ggdGFibGUgZW50cmllczogNTEyIChvcmRlciAwLCA0MDk2IGJ5dGVzKQpbICAgIDMuNDY2MjA2
XSAqKiogVkFMSURBVEUgcmFtZnMgKioqClsgICAgMy40NjYyMTZdICoqKiBWQUxJREFURSBodWdl
dGxiZnMgKioqClsgICAgMy40NjY0NTNdIEFwcEFybW9yOiBBcHBBcm1vciBGaWxlc3lzdGVtIEVu
YWJsZWQKWyAgICAzLjQ2NjUxN10gcG5wOiBQblAgQUNQSSBpbml0ClsgICAgMy40NjY2NTFdIHBu
cCAwMDowMDogUGx1ZyBhbmQgUGxheSBBQ1BJIGRldmljZSwgSURzIFBOUDBiMDAgKGFjdGl2ZSkK
WyAgICAzLjQ2NzAzOV0gc3lzdGVtIDAwOjAxOiBbaW8gIDB4MDY4MC0weDA2OWZdIGhhcyBiZWVu
IHJlc2VydmVkClsgICAgMy40NjcwNDNdIHN5c3RlbSAwMDowMTogW2lvICAweDA0MDAtMHgwNDdm
XSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDMuNDY3MDQ3XSBzeXN0ZW0gMDA6MDE6IFtpbyAgMHgw
NTAwLTB4MDVmZV0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAzLjQ2NzA1MF0gc3lzdGVtIDAwOjAx
OiBbaW8gIDB4MDYwMC0weDA2MWZdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgMy40NjcwNjNdIHN5
c3RlbSAwMDowMTogUGx1ZyBhbmQgUGxheSBBQ1BJIGRldmljZSwgSURzIFBOUDBjMDIgKGFjdGl2
ZSkKWyAgICAzLjQ2NzU4MV0gc3lzdGVtIDAwOjAyOiBbaW8gIDB4MGEwMC0weDBhMGZdIGhhcyBi
ZWVuIHJlc2VydmVkClsgICAgMy40Njc1ODVdIHN5c3RlbSAwMDowMjogW2lvICAweDBhMTAtMHgw
YTFmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDMuNDY3NTk3XSBzeXN0ZW0gMDA6MDI6IFBsdWcg
YW5kIFBsYXkgQUNQSSBkZXZpY2UsIElEcyBQTlAwYzAyIChhY3RpdmUpClsgICAgNi4yMTA1MjBd
IHBucCAwMDowMzogUGx1ZyBhbmQgUGxheSBBQ1BJIGRldmljZSwgSURzIFBOUDA1MDEgKGFjdGl2
ZSkKWyAgICA2LjQxOTE3M10gc3lzdGVtIDAwOjA0OiBbbWVtIDB4ZTAwMDAwMDAtMHhlZmZmZmZm
Zl0gY291bGQgbm90IGJlIHJlc2VydmVkClsgICAgNi40MTkxNzhdIHN5c3RlbSAwMDowNDogW21l
bSAweGZlZDAxMDAwLTB4ZmVkMDFmZmZdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgNi40MTkxODJd
IHN5c3RlbSAwMDowNDogW21lbSAweGZlZDAzMDAwLTB4ZmVkMDNmZmZdIGhhcyBiZWVuIHJlc2Vy
dmVkClsgICAgNi40MTkxODZdIHN5c3RlbSAwMDowNDogW21lbSAweGZlZDA0MDAwLTB4ZmVkMDRm
ZmZdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgNi40MTkxOTBdIHN5c3RlbSAwMDowNDogW21lbSAw
eGZlZDBjMDAwLTB4ZmVkMGZmZmZdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgNi40MTkxOTRdIHN5
c3RlbSAwMDowNDogW21lbSAweGZlZDA4MDAwLTB4ZmVkMDhmZmZdIGhhcyBiZWVuIHJlc2VydmVk
ClsgICAgNi40MTkxOTddIHN5c3RlbSAwMDowNDogW21lbSAweGZlZDFjMDAwLTB4ZmVkMWNmZmZd
IGhhcyBiZWVuIHJlc2VydmVkClsgICAgNi40MTkyMDFdIHN5c3RlbSAwMDowNDogW21lbSAweGZl
ZTAwMDAwLTB4ZmVlZmZmZmZdIGNvdWxkIG5vdCBiZSByZXNlcnZlZApbICAgIDYuNDE5MjA1XSBz
eXN0ZW0gMDA6MDQ6IFttZW0gMHhmZWYwMDAwMC0weGZlZmZmZmZmXSBoYXMgYmVlbiByZXNlcnZl
ZApbICAgIDYuNDE5MjE3XSBzeXN0ZW0gMDA6MDQ6IFBsdWcgYW5kIFBsYXkgQUNQSSBkZXZpY2Us
IElEcyBQTlAwYzAyIChhY3RpdmUpClsgICAgNi40MjAwMDldIHBucDogUG5QIEFDUEk6IGZvdW5k
IDUgZGV2aWNlcwpbICAgIDYuNDI0NzA3XSB0aGVybWFsX3N5czogUmVnaXN0ZXJlZCB0aGVybWFs
IGdvdmVybm9yICdmYWlyX3NoYXJlJwpbICAgIDYuNDI0NzA5XSB0aGVybWFsX3N5czogUmVnaXN0
ZXJlZCB0aGVybWFsIGdvdmVybm9yICdiYW5nX2JhbmcnClsgICAgNi40MjQ3MTJdIHRoZXJtYWxf
c3lzOiBSZWdpc3RlcmVkIHRoZXJtYWwgZ292ZXJub3IgJ3N0ZXBfd2lzZScKWyAgICA2LjQyNDcx
M10gdGhlcm1hbF9zeXM6IFJlZ2lzdGVyZWQgdGhlcm1hbCBnb3Zlcm5vciAndXNlcl9zcGFjZScK
WyAgICA2LjQyNDcxNV0gdGhlcm1hbF9zeXM6IFJlZ2lzdGVyZWQgdGhlcm1hbCBnb3Zlcm5vciAn
cG93ZXJfYWxsb2NhdG9yJwpbICAgIDYuNDI5Mjc0XSBjbG9ja3NvdXJjZTogYWNwaV9wbTogbWFz
azogMHhmZmZmZmYgbWF4X2N5Y2xlczogMHhmZmZmZmYsIG1heF9pZGxlX25zOiAyMDg1NzAxMDI0
IG5zClsgICAgNi40MjkzNjZdIHBjaSAwMDAwOjAwOjFjLjA6IGJyaWRnZSB3aW5kb3cgW2lvICAw
eDEwMDAtMHgwZmZmXSB0byBbYnVzIDAxXSBhZGRfc2l6ZSAxMDAwClsgICAgNi40MjkzNzNdIHBj
aSAwMDAwOjAwOjFjLjA6IGJyaWRnZSB3aW5kb3cgW21lbSAweDAwMTAwMDAwLTB4MDAwZmZmZmYg
NjRiaXQgcHJlZl0gdG8gW2J1cyAwMV0gYWRkX3NpemUgMjAwMDAwIGFkZF9hbGlnbiAxMDAwMDAK
WyAgICA2LjQyOTM3N10gcGNpIDAwMDA6MDA6MWMuMjogYnJpZGdlIHdpbmRvdyBbaW8gIDB4MTAw
MC0weDBmZmZdIHRvIFtidXMgMDJdIGFkZF9zaXplIDEwMDAKWyAgICA2LjQyOTM4Ml0gcGNpIDAw
MDA6MDA6MWMuMjogYnJpZGdlIHdpbmRvdyBbbWVtIDB4MDAxMDAwMDAtMHgwMDBmZmZmZiA2NGJp
dCBwcmVmXSB0byBbYnVzIDAyXSBhZGRfc2l6ZSAyMDAwMDAgYWRkX2FsaWduIDEwMDAwMApbICAg
IDYuNDI5Mzg2XSBwY2kgMDAwMDowMDoxYy4yOiBicmlkZ2Ugd2luZG93IFttZW0gMHgwMDEwMDAw
MC0weDAwMGZmZmZmXSB0byBbYnVzIDAyXSBhZGRfc2l6ZSAyMDAwMDAgYWRkX2FsaWduIDEwMDAw
MApbICAgIDYuNDI5MzkxXSBwY2kgMDAwMDowMDoxYy4zOiBicmlkZ2Ugd2luZG93IFttZW0gMHgw
MDEwMDAwMC0weDAwMGZmZmZmIDY0Yml0IHByZWZdIHRvIFtidXMgMDNdIGFkZF9zaXplIDIwMDAw
MCBhZGRfYWxpZ24gMTAwMDAwClsgICAgNi40Mjk0MTFdIHBjaSAwMDAwOjAwOjFjLjA6IEJBUiAx
NTogYXNzaWduZWQgW21lbSAweDE2MDAwMDAwMC0weDE2MDFmZmZmZiA2NGJpdCBwcmVmXQpbICAg
IDYuNDI5NDE2XSBwY2kgMDAwMDowMDoxYy4yOiBCQVIgMTQ6IGFzc2lnbmVkIFttZW0gMHg5ZjAw
MDAwMC0weDlmMWZmZmZmXQpbICAgIDYuNDI5NDI0XSBwY2kgMDAwMDowMDoxYy4yOiBCQVIgMTU6
IGFzc2lnbmVkIFttZW0gMHgxNjAyMDAwMDAtMHgxNjAzZmZmZmYgNjRiaXQgcHJlZl0KWyAgICA2
LjQyOTQzMl0gcGNpIDAwMDA6MDA6MWMuMzogQkFSIDE1OiBhc3NpZ25lZCBbbWVtIDB4MTYwNDAw
MDAwLTB4MTYwNWZmZmZmIDY0Yml0IHByZWZdClsgICAgNi40Mjk0MzddIHBjaSAwMDAwOjAwOjFj
LjA6IEJBUiAxMzogYXNzaWduZWQgW2lvICAweDEwMDAtMHgxZmZmXQpbICAgIDYuNDI5NDQxXSBw
Y2kgMDAwMDowMDoxYy4yOiBCQVIgMTM6IGFzc2lnbmVkIFtpbyAgMHgyMDAwLTB4MmZmZl0KWyAg
ICA2LjQyOTQ0OF0gcGNpIDAwMDA6MDA6MWMuMDogUENJIGJyaWRnZSB0byBbYnVzIDAxXQpbICAg
IDYuNDI5NDUzXSBwY2kgMDAwMDowMDoxYy4wOiAgIGJyaWRnZSB3aW5kb3cgW2lvICAweDEwMDAt
MHgxZmZmXQpbICAgIDYuNDI5NDU5XSBwY2kgMDAwMDowMDoxYy4wOiAgIGJyaWRnZSB3aW5kb3cg
W21lbSAweGIwNDAwMDAwLTB4YjA3ZmZmZmZdClsgICAgNi40Mjk0NjNdIHBjaSAwMDAwOjAwOjFj
LjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4MTYwMDAwMDAwLTB4MTYwMWZmZmZmIDY0Yml0IHBy
ZWZdClsgICAgNi40Mjk0NjldIHBjaSAwMDAwOjAwOjFjLjI6IFBDSSBicmlkZ2UgdG8gW2J1cyAw
Ml0KWyAgICA2LjQyOTQ3M10gcGNpIDAwMDA6MDA6MWMuMjogICBicmlkZ2Ugd2luZG93IFtpbyAg
MHgyMDAwLTB4MmZmZl0KWyAgICA2LjQyOTQ3OF0gcGNpIDAwMDA6MDA6MWMuMjogICBicmlkZ2Ug
d2luZG93IFttZW0gMHg5ZjAwMDAwMC0weDlmMWZmZmZmXQpbICAgIDYuNDI5NDgyXSBwY2kgMDAw
MDowMDoxYy4yOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDE2MDIwMDAwMC0weDE2MDNmZmZmZiA2
NGJpdCBwcmVmXQpbICAgIDYuNDI5NDg4XSBwY2kgMDAwMDowMDoxYy4zOiBQQ0kgYnJpZGdlIHRv
IFtidXMgMDNdClsgICAgNi40Mjk0OTJdIHBjaSAwMDAwOjAwOjFjLjM6ICAgYnJpZGdlIHdpbmRv
dyBbaW8gIDB4ZDAwMC0weGRmZmZdClsgICAgNi40Mjk0OTddIHBjaSAwMDAwOjAwOjFjLjM6ICAg
YnJpZGdlIHdpbmRvdyBbbWVtIDB4YjBhMDAwMDAtMHhiMGFmZmZmZl0KWyAgICA2LjQyOTUwMV0g
cGNpIDAwMDA6MDA6MWMuMzogICBicmlkZ2Ugd2luZG93IFttZW0gMHgxNjA0MDAwMDAtMHgxNjA1
ZmZmZmYgNjRiaXQgcHJlZl0KWyAgICA2LjQyOTUwOF0gcGNpX2J1cyAwMDAwOjAwOiByZXNvdXJj
ZSA0IFtpbyAgMHgwMDAwLTB4ZmZmZl0KWyAgICA2LjQyOTUxMV0gcGNpX2J1cyAwMDAwOjAwOiBy
ZXNvdXJjZSA1IFttZW0gMHgwMDAwMDAwMC0weGZmZmZmZmZmZl0KWyAgICA2LjQyOTUxNV0gcGNp
X2J1cyAwMDAwOjAxOiByZXNvdXJjZSAwIFtpbyAgMHgxMDAwLTB4MWZmZl0KWyAgICA2LjQyOTUx
OF0gcGNpX2J1cyAwMDAwOjAxOiByZXNvdXJjZSAxIFttZW0gMHhiMDQwMDAwMC0weGIwN2ZmZmZm
XQpbICAgIDYuNDI5NTIxXSBwY2lfYnVzIDAwMDA6MDE6IHJlc291cmNlIDIgW21lbSAweDE2MDAw
MDAwMC0weDE2MDFmZmZmZiA2NGJpdCBwcmVmXQpbICAgIDYuNDI5NTI0XSBwY2lfYnVzIDAwMDA6
MDI6IHJlc291cmNlIDAgW2lvICAweDIwMDAtMHgyZmZmXQpbICAgIDYuNDI5NTI3XSBwY2lfYnVz
IDAwMDA6MDI6IHJlc291cmNlIDEgW21lbSAweDlmMDAwMDAwLTB4OWYxZmZmZmZdClsgICAgNi40
Mjk1MzBdIHBjaV9idXMgMDAwMDowMjogcmVzb3VyY2UgMiBbbWVtIDB4MTYwMjAwMDAwLTB4MTYw
M2ZmZmZmIDY0Yml0IHByZWZdClsgICAgNi40Mjk1MzNdIHBjaV9idXMgMDAwMDowMzogcmVzb3Vy
Y2UgMCBbaW8gIDB4ZDAwMC0weGRmZmZdClsgICAgNi40Mjk1MzZdIHBjaV9idXMgMDAwMDowMzog
cmVzb3VyY2UgMSBbbWVtIDB4YjBhMDAwMDAtMHhiMGFmZmZmZl0KWyAgICA2LjQyOTUzOV0gcGNp
X2J1cyAwMDAwOjAzOiByZXNvdXJjZSAyIFttZW0gMHgxNjA0MDAwMDAtMHgxNjA1ZmZmZmYgNjRi
aXQgcHJlZl0KWyAgICA2LjQyOTg0M10gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAy
ClsgICAgNi40MzAwMTNdIElQIGlkZW50cyBoYXNoIHRhYmxlIGVudHJpZXM6IDY1NTM2IChvcmRl
cjogNywgNTI0Mjg4IGJ5dGVzLCBsaW5lYXIpClsgICAgNi40MzE0MDNdIHRjcF9saXN0ZW5fcG9y
dGFkZHJfaGFzaCBoYXNoIHRhYmxlIGVudHJpZXM6IDIwNDggKG9yZGVyOiAzLCAzMjc2OCBieXRl
cywgbGluZWFyKQpbICAgIDYuNDMxNTU1XSBUQ1AgZXN0YWJsaXNoZWQgaGFzaCB0YWJsZSBlbnRy
aWVzOiAzMjc2OCAob3JkZXI6IDYsIDI2MjE0NCBieXRlcywgbGluZWFyKQpbICAgIDYuNDMxNzkz
XSBUQ1AgYmluZCBoYXNoIHRhYmxlIGVudHJpZXM6IDMyNzY4IChvcmRlcjogNywgNTI0Mjg4IGJ5
dGVzLCBsaW5lYXIpClsgICAgNi40MzE5NTBdIFRDUDogSGFzaCB0YWJsZXMgY29uZmlndXJlZCAo
ZXN0YWJsaXNoZWQgMzI3NjggYmluZCAzMjc2OCkKWyAgICA2LjQzMjA4NV0gVURQIGhhc2ggdGFi
bGUgZW50cmllczogMjA0OCAob3JkZXI6IDQsIDY1NTM2IGJ5dGVzLCBsaW5lYXIpClsgICAgNi40
MzIxNDFdIFVEUC1MaXRlIGhhc2ggdGFibGUgZW50cmllczogMjA0OCAob3JkZXI6IDQsIDY1NTM2
IGJ5dGVzLCBsaW5lYXIpClsgICAgNi40MzIyNzNdIE5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBm
YW1pbHkgMQpbICAgIDYuNDMyMjg1XSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDQ0
ClsgICAgNi40MzIzMDldIHBjaSAwMDAwOjAwOjAyLjA6IFZpZGVvIGRldmljZSB3aXRoIHNoYWRv
d2VkIFJPTSBhdCBbbWVtIDB4MDAwYzAwMDAtMHgwMDBkZmZmZl0KWyAgICA2LjQzMjgyOF0gUENJ
OiBDTFMgNjQgYnl0ZXMsIGRlZmF1bHQgNjQKWyAgICA2LjQzMjk1N10gVHJ5aW5nIHRvIHVucGFj
ayByb290ZnMgaW1hZ2UgYXMgaW5pdHJhbWZzLi4uClsgICAgNy4wMTc5MjNdIEZyZWVpbmcgaW5p
dHJkIG1lbW9yeTogODU3NTZLClsgICAgNy4wMTgwMDhdIFBDSS1ETUE6IFVzaW5nIHNvZnR3YXJl
IGJvdW5jZSBidWZmZXJpbmcgZm9yIElPIChTV0lPVExCKQpbICAgIDcuMDE4MDEyXSBzb2Z0d2Fy
ZSBJTyBUTEI6IG1hcHBlZCBbbWVtIDB4OTU2MTUwMDAtMHg5OTYxNTAwMF0gKDY0TUIpClsgICAg
Ny4wMTgxMTNdIGNsb2Nrc291cmNlOiB0c2M6IG1hc2s6IDB4ZmZmZmZmZmZmZmZmZmZmZiBtYXhf
Y3ljbGVzOiAweDM3NDE1OTRkMzRkLCBtYXhfaWRsZV9uczogODgxNTkwNDIwNTY0IG5zClsgICAg
Ny4wMTgxNDZdIGNsb2Nrc291cmNlOiBTd2l0Y2hlZCB0byBjbG9ja3NvdXJjZSB0c2MKWyAgICA3
LjAxODI0OV0gY2hlY2s6IFNjYW5uaW5nIGZvciBsb3cgbWVtb3J5IGNvcnJ1cHRpb24gZXZlcnkg
NjAgc2Vjb25kcwpbICAgIDcuMDE5Mjc2XSBJbml0aWFsaXNlIHN5c3RlbSB0cnVzdGVkIGtleXJp
bmdzClsgICAgNy4wMTkyOTRdIEtleSB0eXBlIGJsYWNrbGlzdCByZWdpc3RlcmVkClsgICAgNy4w
MTkzODddIHdvcmtpbmdzZXQ6IHRpbWVzdGFtcF9iaXRzPTM2IG1heF9vcmRlcj0yMCBidWNrZXRf
b3JkZXI9MApbICAgIDcuMDIzMDI1XSB6YnVkOiBsb2FkZWQKWyAgICA3LjAyMzk2OV0gc3F1YXNo
ZnM6IHZlcnNpb24gNC4wICgyMDA5LzAxLzMxKSBQaGlsbGlwIExvdWdoZXIKWyAgICA3LjAyNDQ0
Ml0gZnVzZTogaW5pdCAoQVBJIHZlcnNpb24gNy4zMSkKWyAgICA3LjAyNDQ4Nl0gKioqIFZBTElE
QVRFIGZ1c2UgKioqClsgICAgNy4wMjQ0OTBdICoqKiBWQUxJREFURSBmdXNlICoqKgpbICAgIDcu
MDI0NzQ5XSBQbGF0Zm9ybSBLZXlyaW5nIGluaXRpYWxpemVkClsgICAgNy4wMzA5MTldIEtleSB0
eXBlIGFzeW1tZXRyaWMgcmVnaXN0ZXJlZApbICAgIDcuMDMwOTIxXSBBc3ltbWV0cmljIGtleSBw
YXJzZXIgJ3g1MDknIHJlZ2lzdGVyZWQKWyAgICA3LjAzMDk0MF0gQmxvY2sgbGF5ZXIgU0NTSSBn
ZW5lcmljIChic2cpIGRyaXZlciB2ZXJzaW9uIDAuNCBsb2FkZWQgKG1ham9yIDI0NCkKWyAgICA3
LjAzMTAxNF0gaW8gc2NoZWR1bGVyIG1xLWRlYWRsaW5lIHJlZ2lzdGVyZWQKWyAgICA3LjAzMjMy
OF0gc2hwY2hwOiBTdGFuZGFyZCBIb3QgUGx1ZyBQQ0kgQ29udHJvbGxlciBEcml2ZXIgdmVyc2lv
bjogMC40ClsgICAgNy4wMzI0NzFdIGVmaWZiOiBwcm9iaW5nIGZvciBlZmlmYgpbICAgIDcuMDMy
NDkxXSBlZmlmYjogTm8gQkdSVCwgbm90IHNob3dpbmcgYm9vdCBncmFwaGljcwpbICAgIDcuMDMy
NDk0XSBlZmlmYjogZnJhbWVidWZmZXIgYXQgMHhhMDAwMCwgdXNpbmcgNjRrLCB0b3RhbCA2NGsK
WyAgICA3LjAzMjQ5Nl0gZWZpZmI6IG1vZGUgaXMgNjQweDQ4MHgxLCBsaW5lbGVuZ3RoPTgwLCBw
YWdlcz0xClsgICAgNy4wMzI0OTddIGVmaWZiOiBzY3JvbGxpbmc6IHJlZHJhdwpbICAgIDcuMDMy
NTAwXSBlZmlmYjogVHJ1ZWNvbG9yOiBzaXplPTg6ODo4OjgsIHNoaWZ0PTI0OjE2Ojg6MApbICAg
IDcuMDMyNjAwXSBmYmNvbjogRGVmZXJyaW5nIGNvbnNvbGUgdGFrZS1vdmVyClsgICAgNy4wMzI2
MDNdIGZiMDogRUZJIFZHQSBmcmFtZSBidWZmZXIgZGV2aWNlClsgICAgNy4wMzI2MjJdIGludGVs
X2lkbGU6IE1XQUlUIHN1YnN0YXRlczogMHgzMDAwMDIwClsgICAgNy4wMzI2MjRdIGludGVsX2lk
bGU6IHYwLjQuMSBtb2RlbCAweDM3ClsgICAgNy4wMzI5ODZdIGludGVsX2lkbGU6IGxhcGljX3Rp
bWVyX3JlbGlhYmxlX3N0YXRlcyAweGZmZmZmZmZmClsgICAgOC44NjEzNTNdIEFDUEk6IEFDIEFk
YXB0ZXIgW0FEUDFdIChvbi1saW5lKQpbICAgIDguODYxNTE1XSBpbnB1dDogUG93ZXIgQnV0dG9u
IGFzIC9kZXZpY2VzL0xOWFNZU1RNOjAwL0xOWFNZQlVTOjAwL1BOUDBDMEM6MDAvaW5wdXQvaW5w
dXQwClsgICAgOC44NjE2MDFdIEFDUEk6IFBvd2VyIEJ1dHRvbiBbUFdSQl0KWyAgICA4Ljg2MTY4
OV0gaW5wdXQ6IFNsZWVwIEJ1dHRvbiBhcyAvZGV2aWNlcy9MTlhTWVNUTTowMC9MTlhTWUJVUzow
MC9QTlAwQzBFOjAwL2lucHV0L2lucHV0MQpbICAgIDguODYxNzYwXSBBQ1BJOiBTbGVlcCBCdXR0
b24gW1NMUEJdClsgICAgOC44NjE4NDhdIGlucHV0OiBMaWQgU3dpdGNoIGFzIC9kZXZpY2VzL0xO
WFNZU1RNOjAwL0xOWFNZQlVTOjAwL1BOUDBDMEQ6MDAvaW5wdXQvaW5wdXQyClsgICAgOC44NjE5
MTZdIEFDUEk6IExpZCBTd2l0Y2ggW0xJRDBdClsgICAgOC44NjE5OThdIGlucHV0OiBQb3dlciBC
dXR0b24gYXMgL2RldmljZXMvTE5YU1lTVE06MDAvTE5YUFdSQk46MDAvaW5wdXQvaW5wdXQzClsg
ICAgOC44NjIwNjJdIEFDUEk6IFBvd2VyIEJ1dHRvbiBbUFdSRl0KWyAgICA4Ljg3MDIzMF0gU2Vy
aWFsOiA4MjUwLzE2NTUwIGRyaXZlciwgMzIgcG9ydHMsIElSUSBzaGFyaW5nIGVuYWJsZWQKWyAg
ICA4Ljg5MDQ2Ml0gMDA6MDM6IHR0eVMwIGF0IEkvTyAweDNmOCAoaXJxID0gNCwgYmFzZV9iYXVk
ID0gMTE1MjAwKSBpcyBhIDE2NTUwQQpbICAgIDguOTI5ODQ5XSBocGV0OiBudW1iZXIgaXJxcyBk
b2Vzbid0IGFncmVlIHdpdGggbnVtYmVyIG9mIHRpbWVycwpbICAgIDguOTMwMTEwXSBMaW51eCBh
Z3BnYXJ0IGludGVyZmFjZSB2MC4xMDMKWyAgICA5LjE3MDgzOF0gbG9vcDogbW9kdWxlIGxvYWRl
ZApbICAgIDkuMTcxNTQzXSB0dW46IFVuaXZlcnNhbCBUVU4vVEFQIGRldmljZSBkcml2ZXIsIDEu
NgpbICAgIDkuMTcxODQ5XSBQUFAgZ2VuZXJpYyBkcml2ZXIgdmVyc2lvbiAyLjQuMgpbICAgIDku
MTcyNTE1XSBWRklPIC0gVXNlciBMZXZlbCBtZXRhLWRyaXZlciB2ZXJzaW9uOiAwLjMKWyAgICA5
LjE3Mjg2M10gZWhjaV9oY2Q6IFVTQiAyLjAgJ0VuaGFuY2VkJyBIb3N0IENvbnRyb2xsZXIgKEVI
Q0kpIERyaXZlcgpbICAgIDkuMTcyODcxXSBlaGNpLXBjaTogRUhDSSBQQ0kgcGxhdGZvcm0gZHJp
dmVyClsgICAgOS4xNzI5MDRdIGVoY2ktcGxhdGZvcm06IEVIQ0kgZ2VuZXJpYyBwbGF0Zm9ybSBk
cml2ZXIKWyAgICA5LjE3MjkyNV0gb2hjaV9oY2Q6IFVTQiAxLjEgJ09wZW4nIEhvc3QgQ29udHJv
bGxlciAoT0hDSSkgRHJpdmVyClsgICAgOS4xNzI5MzFdIG9oY2ktcGNpOiBPSENJIFBDSSBwbGF0
Zm9ybSBkcml2ZXIKWyAgICA5LjE3Mjk1MF0gb2hjaS1wbGF0Zm9ybTogT0hDSSBnZW5lcmljIHBs
YXRmb3JtIGRyaXZlcgpbICAgIDkuMTcyOTY0XSB1aGNpX2hjZDogVVNCIFVuaXZlcnNhbCBIb3N0
IENvbnRyb2xsZXIgSW50ZXJmYWNlIGRyaXZlcgpbICAgIDkuMTkzMzczXSB4aGNpX2hjZCAwMDAw
OjAwOjE0LjA6IHhIQ0kgSG9zdCBDb250cm9sbGVyClsgICAgOS4xOTMzODldIHhoY2lfaGNkIDAw
MDA6MDA6MTQuMDogbmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciAx
ClsgICAgOS4xOTQ0NjZdIHhoY2lfaGNkIDAwMDA6MDA6MTQuMDogaGNjIHBhcmFtcyAweDIwMDA3
N2MxIGhjaSB2ZXJzaW9uIDB4MTAwIHF1aXJrcyAweDAwMDAwMDAwMDAwMDk4MTAKWyAgICA5LjE5
NDQ3M10geGhjaV9oY2QgMDAwMDowMDoxNC4wOiBjYWNoZSBsaW5lIHNpemUgb2YgNjQgaXMgbm90
IHN1cHBvcnRlZApbICAgIDkuMTk0NzI5XSB4aGNpX2hjZCAwMDAwOjAwOjE0LjA6IHhIQ0kgSG9z
dCBDb250cm9sbGVyClsgICAgOS4xOTQ3MzddIHhoY2lfaGNkIDAwMDA6MDA6MTQuMDogbmV3IFVT
QiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciAyClsgICAgOS4xOTQ3NDRdIHho
Y2lfaGNkIDAwMDA6MDA6MTQuMDogSG9zdCBzdXBwb3J0cyBVU0IgMy4wIFN1cGVyU3BlZWQKWyAg
ICA5LjE5NDgzNl0gdXNiIHVzYjE6IE5ldyBVU0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRvcj0xZDZi
LCBpZFByb2R1Y3Q9MDAwMiwgYmNkRGV2aWNlPSA1LjA0ClsgICAgOS4xOTQ4NDBdIHVzYiB1c2Ix
OiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MywgUHJvZHVjdD0yLCBTZXJpYWxOdW1iZXI9
MQpbICAgIDkuMTk0ODQzXSB1c2IgdXNiMTogUHJvZHVjdDogeEhDSSBIb3N0IENvbnRyb2xsZXIK
WyAgICA5LjE5NDg0Nl0gdXNiIHVzYjE6IE1hbnVmYWN0dXJlcjogTGludXggNS40LjAtMTQ4LWdl
bmVyaWMgeGhjaS1oY2QKWyAgICA5LjE5NDg0OF0gdXNiIHVzYjE6IFNlcmlhbE51bWJlcjogMDAw
MDowMDoxNC4wClsgICAgOS4xOTYxNDNdIGh1YiAxLTA6MS4wOiBVU0IgaHViIGZvdW5kClsgICAg
OS4xOTYxNjVdIGh1YiAxLTA6MS4wOiA2IHBvcnRzIGRldGVjdGVkClsgICAgOS41MDA2NThdIHVz
YiB1c2IyOiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5kb3I9MWQ2YiwgaWRQcm9kdWN0PTAw
MDMsIGJjZERldmljZT0gNS4wNApbICAgIDkuNTAwNjYzXSB1c2IgdXNiMjogTmV3IFVTQiBkZXZp
Y2Ugc3RyaW5nczogTWZyPTMsIFByb2R1Y3Q9MiwgU2VyaWFsTnVtYmVyPTEKWyAgICA5LjUwMDY2
Nl0gdXNiIHVzYjI6IFByb2R1Y3Q6IHhIQ0kgSG9zdCBDb250cm9sbGVyClsgICAgOS41MDA2Njld
IHVzYiB1c2IyOiBNYW51ZmFjdHVyZXI6IExpbnV4IDUuNC4wLTE0OC1nZW5lcmljIHhoY2ktaGNk
ClsgICAgOS41MDA2NzFdIHVzYiB1c2IyOiBTZXJpYWxOdW1iZXI6IDAwMDA6MDA6MTQuMApbICAg
IDkuNTAyNDE5XSBodWIgMi0wOjEuMDogVVNCIGh1YiBmb3VuZApbICAgIDkuNTAyNDQxXSBodWIg
Mi0wOjEuMDogMSBwb3J0IGRldGVjdGVkClsgICAgOS41NjM3ODldIGk4MDQyOiBQTlA6IE5vIFBT
LzIgY29udHJvbGxlciBmb3VuZC4KWyAgICA5LjU2NDU1NV0gbW91c2VkZXY6IFBTLzIgbW91c2Ug
ZGV2aWNlIGNvbW1vbiBmb3IgYWxsIG1pY2UKWyAgICA5LjU2NTc3OF0gcnRjX2Ntb3MgMDA6MDA6
IFJUQyBjYW4gd2FrZSBmcm9tIFM0ClsgICAgOS41NjYxNTNdIHJ0Y19jbW9zIDAwOjAwOiByZWdp
c3RlcmVkIGFzIHJ0YzAKWyAgICA5LjU2NjE5OF0gcnRjX2Ntb3MgMDA6MDA6IGFsYXJtcyB1cCB0
byBvbmUgbW9udGgsIHkzaywgMjQyIGJ5dGVzIG52cmFtClsgICAgOS41NjYyMTRdIGkyYyAvZGV2
IGVudHJpZXMgZHJpdmVyClsgICAgOS41NjYzMjZdIGRldmljZS1tYXBwZXI6IHVldmVudDogdmVy
c2lvbiAxLjAuMwpbICAgIDkuNTY2NTMxXSBkZXZpY2UtbWFwcGVyOiBpb2N0bDogNC40MS4wLWlv
Y3RsICgyMDE5LTA5LTE2KSBpbml0aWFsaXNlZDogZG0tZGV2ZWxAcmVkaGF0LmNvbQpbICAgIDku
NTY2NTkxXSBwbGF0Zm9ybSBlaXNhLjA6IFByb2JpbmcgRUlTQSBidXMgMApbICAgIDkuNTY2NjAx
XSBwbGF0Zm9ybSBlaXNhLjA6IENhbm5vdCBhbGxvY2F0ZSByZXNvdXJjZSBmb3IgRUlTQSBzbG90
IDEKWyAgICA5LjU2NjYwNV0gcGxhdGZvcm0gZWlzYS4wOiBDYW5ub3QgYWxsb2NhdGUgcmVzb3Vy
Y2UgZm9yIEVJU0Egc2xvdCAyClsgICAgOS41NjY2MzRdIHBsYXRmb3JtIGVpc2EuMDogRUlTQTog
RGV0ZWN0ZWQgMCBjYXJkcwpbICAgIDkuNTY2NjQyXSBpbnRlbF9wc3RhdGU6IEludGVsIFAtc3Rh
dGUgZHJpdmVyIGluaXRpYWxpemluZwpbICAgIDkuNTY3ODkyXSBsZWR0cmlnLWNwdTogcmVnaXN0
ZXJlZCB0byBpbmRpY2F0ZSBhY3Rpdml0eSBvbiBDUFVzClsgICAgOS41NjgxNjldIGRyb3BfbW9u
aXRvcjogSW5pdGlhbGl6aW5nIG5ldHdvcmsgZHJvcCBtb25pdG9yIHNlcnZpY2UKWyAgICA5LjU2
ODU3M10gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAxMApbICAgIDkuNTkxMDcwXSBT
ZWdtZW50IFJvdXRpbmcgd2l0aCBJUHY2ClsgICAgOS41OTExMjJdIE5FVDogUmVnaXN0ZXJlZCBw
cm90b2NvbCBmYW1pbHkgMTcKWyAgICA5LjU5MTMyOV0gS2V5IHR5cGUgZG5zX3Jlc29sdmVyIHJl
Z2lzdGVyZWQKWyAgICA5LjU5MjI2OV0gUkFTOiBDb3JyZWN0YWJsZSBFcnJvcnMgY29sbGVjdG9y
IGluaXRpYWxpemVkLgpbICAgIDkuNTkyMzQyXSBtaWNyb2NvZGU6IHNpZz0weDMwNjc5LCBwZj0w
eDEsIHJldmlzaW9uPTB4OTBkClsgICAgOS41OTI0NDVdIG1pY3JvY29kZTogTWljcm9jb2RlIFVw
ZGF0ZSBEcml2ZXI6IHYyLjIuClsgICAgOS41OTI0NTNdIElQSSBzaG9ydGhhbmQgYnJvYWRjYXN0
OiBlbmFibGVkClsgICAgOS41OTI0ODRdIHNjaGVkX2Nsb2NrOiBNYXJraW5nIHN0YWJsZSAoOTU5
MTU1NjgyMSwgODc0OTIwKS0+KDk2MDU5MDQ0MzksIC0xMzQ3MjY5OCkKWyAgICA5LjU5Mjc1MF0g
cmVnaXN0ZXJlZCB0YXNrc3RhdHMgdmVyc2lvbiAxClsgICAgOS41OTI3NzJdIExvYWRpbmcgY29t
cGlsZWQtaW4gWC41MDkgY2VydGlmaWNhdGVzClsgICAgOS41OTQ5NjJdIExvYWRlZCBYLjUwOSBj
ZXJ0ICdCdWlsZCB0aW1lIGF1dG9nZW5lcmF0ZWQga2VybmVsIGtleTogMGUzMzM1YzlhNmU0NmI3
ZTBlNzY0ODZjZjU4NjUxYjBhZTUxMTdlZicKWyAgICA5LjU5Njc4N10gTG9hZGVkIFguNTA5IGNl
cnQgJ0Nhbm9uaWNhbCBMdGQuIExpdmUgUGF0Y2ggU2lnbmluZzogMTRkZjM0ZDFhODdjZjM3NjI1
YWJlYzAzOWVmMmJmNTIxMjQ5Yjk2OScKWyAgICA5LjU5ODYxM10gTG9hZGVkIFguNTA5IGNlcnQg
J0Nhbm9uaWNhbCBMdGQuIEtlcm5lbCBNb2R1bGUgU2lnbmluZzogODhmNzUyZTU2MGExZTA3Mzdl
MzExNjNhNDY2YWQ3YjcwYTg1MGMxOScKWyAgICA5LjU5ODYxNl0gYmxhY2tsaXN0OiBMb2FkaW5n
IGNvbXBpbGVkLWluIHJldm9jYXRpb24gWC41MDkgY2VydGlmaWNhdGVzClsgICAgOS41OTg2Njdd
IExvYWRlZCBYLjUwOSBjZXJ0ICdDYW5vbmljYWwgTHRkLiBTZWN1cmUgQm9vdCBTaWduaW5nOiA2
MTQ4MmFhMjgzMGQwYWIyYWQ1YWYxMGI3MjUwZGE5MDMzZGRjZWYwJwpbICAgIDkuNTk4NzE1XSBM
b2FkZWQgWC41MDkgY2VydCAnQ2Fub25pY2FsIEx0ZC4gU2VjdXJlIEJvb3QgU2lnbmluZyAoMjAx
Nyk6IDI0MmFkZTc1YWM0YTE1ZTUwZDUwYzg0YjBkNDVmZjNlYWU3MDdhMDMnClsgICAgOS41OTg3
NjFdIExvYWRlZCBYLjUwOSBjZXJ0ICdDYW5vbmljYWwgTHRkLiBTZWN1cmUgQm9vdCBTaWduaW5n
IChFU00gMjAxOCk6IDM2NTE4OGMxZDM3NGQ2YjA3YzNjOGYyNDBmOGVmNzIyNDMzZDZhOGInClsg
ICAgOS41OTg4MTZdIExvYWRlZCBYLjUwOSBjZXJ0ICdDYW5vbmljYWwgTHRkLiBTZWN1cmUgQm9v
dCBTaWduaW5nICgyMDE5KTogYzA3NDZmZDZjNWRhM2FlODI3ODY0NjUxYWQ2NmFlNDdmZTI0YjNl
OCcKWyAgICA5LjU5ODg2NF0gTG9hZGVkIFguNTA5IGNlcnQgJ0Nhbm9uaWNhbCBMdGQuIFNlY3Vy
ZSBCb290IFNpZ25pbmcgKDIwMjEgdjEpOiBhOGQ1NGJiYjM4MjVjZmI5NGZhMTNjOWY4YTU5NGEx
OTVjMTA3YjhkJwpbICAgIDkuNTk4OTEwXSBMb2FkZWQgWC41MDkgY2VydCAnQ2Fub25pY2FsIEx0
ZC4gU2VjdXJlIEJvb3QgU2lnbmluZyAoMjAyMSB2Mik6IDRjZjA0Njg5MmQ2ZmQzYzlhNWIwM2Y5
OGQ4NDVmOTA4NTFkYzZhOGMnClsgICAgOS41OTg5NTZdIExvYWRlZCBYLjUwOSBjZXJ0ICdDYW5v
bmljYWwgTHRkLiBTZWN1cmUgQm9vdCBTaWduaW5nICgyMDIxIHYzKTogMTAwNDM3YmI2ZGU2ZTQ2
OWI1ODFlNjFjZDY2YmNlM2VmNGVkNTNhZicKWyAgICA5LjU5OTAwMl0gTG9hZGVkIFguNTA5IGNl
cnQgJ0Nhbm9uaWNhbCBMdGQuIFNlY3VyZSBCb290IFNpZ25pbmcgKFVidW50dSBDb3JlIDIwMTkp
OiBjMWQ1N2I4ZjZiNzQzZjIzZWU0MWY0ZjdlZTI5MmYwNmVlY2FkZmI5JwpbICAgIDkuNTk5MDc3
XSB6c3dhcDogbG9hZGVkIHVzaW5nIHBvb2wgbHpvL3pidWQKWyAgICA5LjU5OTYzNV0gS2V5IHR5
cGUgLl9mc2NyeXB0IHJlZ2lzdGVyZWQKWyAgICA5LjU5OTYzN10gS2V5IHR5cGUgLmZzY3J5cHQg
cmVnaXN0ZXJlZApbICAgIDkuNjIyNDI3XSBLZXkgdHlwZSBiaWdfa2V5IHJlZ2lzdGVyZWQKWyAg
ICA5LjYzNDA5NF0gS2V5IHR5cGUgZW5jcnlwdGVkIHJlZ2lzdGVyZWQKWyAgICA5LjYzNDEwMV0g
QXBwQXJtb3I6IEFwcEFybW9yIHNoYTEgcG9saWN5IGhhc2hpbmcgZW5hYmxlZApbICAgIDkuNjM0
MTMzXSBpbWE6IE5vIFRQTSBjaGlwIGZvdW5kLCBhY3RpdmF0aW5nIFRQTS1ieXBhc3MhClsgICAg
OS42MzQxNDhdIGltYTogQWxsb2NhdGVkIGhhc2ggYWxnb3JpdGhtOiBzaGExClsgICAgOS42MzQx
NjBdIGltYTogTm8gYXJjaGl0ZWN0dXJlIHBvbGljaWVzIGZvdW5kClsgICAgOS42MzQxNzddIGV2
bTogSW5pdGlhbGlzaW5nIEVWTSBleHRlbmRlZCBhdHRyaWJ1dGVzOgpbICAgIDkuNjM0MTc4XSBl
dm06IHNlY3VyaXR5LnNlbGludXgKWyAgICA5LjYzNDE4MF0gZXZtOiBzZWN1cml0eS5TTUFDSzY0
ClsgICAgOS42MzQxODFdIGV2bTogc2VjdXJpdHkuU01BQ0s2NEVYRUMKWyAgICA5LjYzNDE4Ml0g
ZXZtOiBzZWN1cml0eS5TTUFDSzY0VFJBTlNNVVRFClsgICAgOS42MzQxODNdIGV2bTogc2VjdXJp
dHkuU01BQ0s2NE1NQVAKWyAgICA5LjYzNDE4NF0gZXZtOiBzZWN1cml0eS5hcHBhcm1vcgpbICAg
IDkuNjM0MTg1XSBldm06IHNlY3VyaXR5LmltYQpbICAgIDkuNjM0MTg2XSBldm06IHNlY3VyaXR5
LmNhcGFiaWxpdHkKWyAgICA5LjYzNDE4N10gZXZtOiBITUFDIGF0dHJzOiAweDEKWyAgICA5Ljcx
MTcxOF0gUE06ICAgTWFnaWMgbnVtYmVyOiA5Ojc1NTozNjgKWyAgICA5LjcxMjA0Ml0gcnRjX2Nt
b3MgMDA6MDA6IHNldHRpbmcgc3lzdGVtIGNsb2NrIHRvIDIwMjUtMDEtMzFUMDY6MjM6MDkgVVRD
ICgxNzM4MzA0NTg5KQpbICAgIDkuNzU4NjkxXSB1c2IgMS0zOiBuZXcgaGlnaC1zcGVlZCBVU0Ig
ZGV2aWNlIG51bWJlciAyIHVzaW5nIHhoY2lfaGNkClsgICAgOS45MTA4NjJdIHVzYiAxLTM6IE5l
dyBVU0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRvcj0wNGQ4LCBpZFByb2R1Y3Q9MDAwYSwgYmNkRGV2
aWNlPSAxLjAwClsgICAgOS45MTA4NjZdIHVzYiAxLTM6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6
IE1mcj0xLCBQcm9kdWN0PTIsIFNlcmlhbE51bWJlcj0wClsgICAgOS45MTA4NjldIHVzYiAxLTM6
IFByb2R1Y3Q6IFNpbXBsZSBDREMgRGV2aWNlIERlbW8KWyAgICA5LjkxMDg3Ml0gdXNiIDEtMzog
TWFudWZhY3R1cmVyOiBNaWNyb2NoaXAgVGVjaG5vbG9neSBJbmMuClsgICAxMi41NjE3OTZdIGJh
dHRlcnk6IEFDUEk6IEJhdHRlcnkgU2xvdCBbQkFUMV0gKGJhdHRlcnkgYWJzZW50KQpbICAgMTIu
NjAxOTI5XSBGcmVlaW5nIHVudXNlZCBkZWNyeXB0ZWQgbWVtb3J5OiAyMDQwSwpbICAgMTIuNjAz
NzE1XSBGcmVlaW5nIHVudXNlZCBrZXJuZWwgaW1hZ2UgbWVtb3J5OiAyNzY0SwpbICAgMTIuNjAz
OTYwXSBXcml0ZSBwcm90ZWN0aW5nIHRoZSBrZXJuZWwgcmVhZC1vbmx5IGRhdGE6IDI2NjI0awpb
ICAgMTIuNjA1ODY4XSBGcmVlaW5nIHVudXNlZCBrZXJuZWwgaW1hZ2UgbWVtb3J5OiAyMDM2Swpb
ICAgMTIuNjA2OTA0XSBGcmVlaW5nIHVudXNlZCBrZXJuZWwgaW1hZ2UgbWVtb3J5OiA3MzZLClsg
ICAxMi42MzY0MzNdIHg4Ni9tbTogQ2hlY2tlZCBXK1ggbWFwcGluZ3M6IHBhc3NlZCwgbm8gVytY
IHBhZ2VzIGZvdW5kLgpbICAgMTIuNjM2NjAxXSB4ODYvbW06IENoZWNraW5nIHVzZXIgc3BhY2Ug
cGFnZSB0YWJsZXMKWyAgIDEyLjY2NTQzMV0geDg2L21tOiBDaGVja2VkIFcrWCBtYXBwaW5nczog
cGFzc2VkLCBubyBXK1ggcGFnZXMgZm91bmQuClsgICAxMi42NjU0MzhdIFJ1biAvaW5pdCBhcyBp
bml0IHByb2Nlc3MKWyAgIDIwLjA0MTgxMl0gc2RoY2k6IFNlY3VyZSBEaWdpdGFsIEhvc3QgQ29u
dHJvbGxlciBJbnRlcmZhY2UgZHJpdmVyClsgICAyMC4wNDE4MTVdIHNkaGNpOiBDb3B5cmlnaHQo
YykgUGllcnJlIE9zc21hbgpbICAgMjAuMDU1NDc1XSBkY2Egc2VydmljZSBzdGFydGVkLCB2ZXJz
aW9uIDEuMTIuMQpbICAgMjAuMDYyMDA2XSBhaGNpIDAwMDA6MDA6MTMuMDogdmVyc2lvbiAzLjAK
WyAgIDIwLjA2NTA3MF0gaWdiOiBJbnRlbChSKSBHaWdhYml0IEV0aGVybmV0IE5ldHdvcmsgRHJp
dmVyIC0gdmVyc2lvbiA1LjYuMC1rClsgICAyMC4wNjUwNzJdIGlnYjogQ29weXJpZ2h0IChjKSAy
MDA3LTIwMTQgSW50ZWwgQ29ycG9yYXRpb24uClsgICAyMC4wNzE4NzRdIHNkaGNpLXBjaSAwMDAw
OjAwOjE3LjA6IFNESENJIGNvbnRyb2xsZXIgZm91bmQgWzgwODY6MGY1MF0gKHJldiAxMSkKWyAg
IDIwLjA5ODk1NV0gaTgwMV9zbWJ1cyAwMDAwOjAwOjFmLjM6IFNQRCBXcml0ZSBEaXNhYmxlIGlz
IHNldApbICAgMjAuMDk5MDA4XSBpODAxX3NtYnVzIDAwMDA6MDA6MWYuMzogU01CdXMgdXNpbmcg
UENJIGludGVycnVwdApbICAgMjAuMTAwMTQzXSBhaGNpIDAwMDA6MDA6MTMuMDogY29udHJvbGxl
ciBjYW4ndCBkbyBERVZTTFAsIHR1cm5pbmcgb2ZmClsgICAyMC4xMDAyNzldIGFoY2kgMDAwMDow
MDoxMy4wOiBBSENJIDAwMDEuMDMwMCAzMiBzbG90cyAyIHBvcnRzIDMgR2JwcyAweDIgaW1wbCBT
QVRBIG1vZGUKWyAgIDIwLjEwMDI4NF0gYWhjaSAwMDAwOjAwOjEzLjA6IGZsYWdzOiA2NGJpdCBu
Y3EgcG0gbGVkIGNsbyBwaW8gc2x1bSBwYXJ0IGRlc28gClsgICAyMC4xMDExMjhdIGk4MDFfc21i
dXMgMDAwMDowMDoxZi4zOiBCSU9TIGlzIGFjY2Vzc2luZyBTTUJ1cyByZWdpc3RlcnMKWyAgIDIw
LjEwMTEzMl0gaTgwMV9zbWJ1cyAwMDAwOjAwOjFmLjM6IERyaXZlciBTTUJ1cyByZWdpc3RlciBh
Y2Nlc3MgaW5oaWJpdGVkClsgICAyMC4xMDMwMzddIHNjc2kgaG9zdDA6IGFoY2kKWyAgIDIwLjEw
MzczNV0gbW1jMDogU0RIQ0kgY29udHJvbGxlciBvbiBQQ0kgWzAwMDA6MDA6MTcuMF0gdXNpbmcg
QURNQQpbICAgMjAuMTA0MjEyXSBjcnlwdGQ6IG1heF9jcHVfcWxlbiBzZXQgdG8gMTAwMApbICAg
MjAuMTE4NDMyXSBzY3NpIGhvc3QxOiBhaGNpClsgICAyMC4xMTg1OThdIGF0YTE6IERVTU1ZClsg
ICAyMC4xMTg2MDNdIGF0YTI6IFNBVEEgbWF4IFVETUEvMTMzIGFiYXIgbTIwNDhAMHhiMGIxNzAw
MCBwb3J0IDB4YjBiMTcxODAgaXJxIDkxClsgICAyMC4xMjE0MjBdIFNTRSB2ZXJzaW9uIG9mIGdj
bV9lbmMvZGVjIGVuZ2FnZWQuClsgICAyMC4xMzE0NDFdIHBwcyBwcHMwOiBuZXcgUFBTIHNvdXJj
ZSBwdHAwClsgICAyMC4xMzE1NTRdIGlnYiAwMDAwOjAzOjAwLjA6IGFkZGVkIFBIQyBvbiBldGgw
ClsgICAyMC4xMzE1NTddIGlnYiAwMDAwOjAzOjAwLjA6IEludGVsKFIpIEdpZ2FiaXQgRXRoZXJu
ZXQgTmV0d29yayBDb25uZWN0aW9uClsgICAyMC4xMzE1NjFdIGlnYiAwMDAwOjAzOjAwLjA6IGV0
aDA6IChQQ0llOjIuNUdiL3M6V2lkdGggeDEpIDAwOjMwOjY0OmEyOjU5OmFiClsgICAyMC4xMzE2
MDZdIGlnYiAwMDAwOjAzOjAwLjA6IGV0aDA6IFBCQSBObzogMDAwMzAwLTAwMApbICAgMjAuMTMx
NjEwXSBpZ2IgMDAwMDowMzowMC4wOiBVc2luZyBNU0ktWCBpbnRlcnJ1cHRzLiA0IHJ4IHF1ZXVl
KHMpLCA0IHR4IHF1ZXVlKHMpClsgICAyMC4yMTY3ODNdIGNoZWNraW5nIGdlbmVyaWMgKGEwMDAw
IDEwMDAwKSB2cyBodyAoYTAwMDAwMDAgMTAwMDAwMDApClsgICAyMC4yMTY3ODZdIGZiMDogc3dp
dGNoaW5nIHRvIGludGVsZHJtZmIgZnJvbSBFRkkgVkdBClsgICAyMC4yMTY5NzJdIGk5MTUgMDAw
MDowMDowMi4wOiB2Z2FhcmI6IGRlYWN0aXZhdGUgdmdhIGNvbnNvbGUKWyAgIDIwLjIxNzA5Nl0g
W2RybV0gU3VwcG9ydHMgdmJsYW5rIHRpbWVzdGFtcCBjYWNoaW5nIFJldiAyICgyMS4xMC4yMDEz
KS4KWyAgIDIwLjIxNzA5OF0gW2RybV0gRHJpdmVyIHN1cHBvcnRzIHByZWNpc2UgdmJsYW5rIHRp
bWVzdGFtcCBxdWVyeS4KWyAgIDIwLjIzMDU1M10gaTkxNSAwMDAwOjAwOjAyLjA6IHZnYWFyYjog
Y2hhbmdlZCBWR0EgZGVjb2Rlczogb2xkZGVjb2Rlcz1pbyttZW0sZGVjb2Rlcz1pbyttZW06b3du
cz1pbyttZW0KWyAgIDIwLjI1Mzc2OV0gaTkxNSAwMDAwOjAwOjAyLjA6IGVEUC0xOiBFRElEIGlz
IGludmFsaWQ6ClsgICAyMC4yNTM3NzRdIAlbMDBdIEJBRCAgMmEgNzEgZjMgNDIgMDYgYTggNDgg
NGQgNDEgOWEgZWQgNTQgMzcgNmEgNzAgZjgKWyAgIDIwLjI1Mzc3Nl0gCVswMF0gQkFEICAxMSA2
MCA1ZSBhOCA4NyBlNiBmMSAwNiAyZSAxMSBhYiAzZSA4ZCAwYiBjMCBlZgpbICAgMjAuMjUzNzc4
XSAJWzAwXSBCQUQgIGNlIGQzIDAzIDc5IGM4IDJiIGM0IDgzIGY0IDljIDAzIGZkIDBjIDhhIGFj
IGUxClsgICAyMC4yNTM3NzldIAlbMDBdIEJBRCAgNWEgZWUgZTYgOTAgNjQgM2QgNjIgODIgNDMg
NjYgN2EgMWMgMzQgMDMgZWIgM2UKWyAgIDIwLjI1Mzc4MV0gCVswMF0gQkFEICA1YyBkYiA2ZiAw
ZSBkMyAwMiBkYyBiMCAyZSBhMCBiMCAxOCBkOCA3NCA2YSAzYQpbICAgMjAuMjUzNzgyXSAJWzAw
XSBCQUQgIGE5IGQwIDU3IDQ3IDA2IGJhIDZhIDQ2IGMwIGJkIDljIDc4IGJhIGRjIGY1IGNjClsg
ICAyMC4yNTM3ODNdIAlbMDBdIEJBRCAgNDQgMjcgYTcgYmEgMTAgMDUgMjIgZWUgNjUgMDMgNWUg
ODEgNzMgYzMgZTUgNzYKWyAgIDIwLjI1Mzc4NV0gCVswMF0gQkFEICBmYyA2NCA3OSAwNiA5MSA1
OCA1OCA1YyBjMyBkMCBlOCA0ZSA1YyAwOCBjMiAwOQpbICAgMjAuMjU5NDI3XSBbZHJtXSBJbml0
aWFsaXplZCBpOTE1IDEuNi4wIDIwMTkwODIyIGZvciAwMDAwOjAwOjAyLjAgb24gbWlub3IgMApb
ICAgMjAuMjc5MTQ5XSBBQ1BJOiBWaWRlbyBEZXZpY2UgW0dGWDBdIChtdWx0aS1oZWFkOiB5ZXMg
IHJvbTogbm8gIHBvc3Q6IG5vKQpbICAgMjAuMzE0MzQxXSBpbnB1dDogVmlkZW8gQnVzIGFzIC9k
ZXZpY2VzL0xOWFNZU1RNOjAwL0xOWFNZQlVTOjAwL1BOUDBBMDg6MDAvTE5YVklERU86MDAvaW5w
dXQvaW5wdXQ0ClsgICAyMC4zMjI5MjZdIGZiY29uOiBpOTE1ZHJtZmIgKGZiMCkgaXMgcHJpbWFy
eSBkZXZpY2UKWyAgIDIwLjMyMjkyOF0gZmJjb246IERlZmVycmluZyBjb25zb2xlIHRha2Utb3Zl
cgpbICAgMjAuMzIyOTM0XSBpOTE1IDAwMDA6MDA6MDIuMDogZmIwOiBpOTE1ZHJtZmIgZnJhbWUg
YnVmZmVyIGRldmljZQpbICAgMjAuNDM4NzA4XSBhdGEyOiBTQVRBIGxpbmsgdXAgMy4wIEdicHMg
KFNTdGF0dXMgMTIzIFNDb250cm9sIDMwMCkKWyAgIDIwLjQzODkwMl0gYXRhMi4wMDogRk9SQ0U6
IGhvcmthZ2UgbW9kaWZpZWQgKG5vbmNxKQpbICAgMjAuNDM5MDE1XSBhdGEyLjAwOiBBVEEtMTE6
IFNBVEEgU1NELCBTQkZNQjEuMSwgbWF4IFVETUEvMTMzClsgICAyMC40MzkwMTldIGF0YTIuMDA6
IDIzNDQ0MTY0OCBzZWN0b3JzLCBtdWx0aSAxNjogTEJBNDggTkNRIChub3QgdXNlZCkKWyAgIDIw
LjQzOTE5OF0gYXRhMi4wMDogY29uZmlndXJlZCBmb3IgVURNQS8xMzMKWyAgIDIwLjQ0OTk2Ml0g
c2NzaSAxOjA6MDowOiBEaXJlY3QtQWNjZXNzICAgICBBVEEgICAgICBTQVRBIFNTRCAgICAgICAg
IEIxLjEgUFE6IDAgQU5TSTogNQpbICAgMjAuNDUwNTQ1XSBzZCAxOjA6MDowOiBbc2RhXSAyMzQ0
NDE2NDggNTEyLWJ5dGUgbG9naWNhbCBibG9ja3M6ICgxMjAgR0IvMTEyIEdpQikKWyAgIDIwLjQ1
MDU3OV0gc2QgMTowOjA6MDogW3NkYV0gV3JpdGUgUHJvdGVjdCBpcyBvZmYKWyAgIDIwLjQ1MDU4
M10gc2QgMTowOjA6MDogW3NkYV0gTW9kZSBTZW5zZTogMDAgM2EgMDAgMDAKWyAgIDIwLjQ1MDYz
NF0gc2QgMTowOjA6MDogQXR0YWNoZWQgc2NzaSBnZW5lcmljIHNnMCB0eXBlIDAKWyAgIDIwLjQ1
MDY0MV0gc2QgMTowOjA6MDogW3NkYV0gV3JpdGUgY2FjaGU6IGVuYWJsZWQsIHJlYWQgY2FjaGU6
IGVuYWJsZWQsIGRvZXNuJ3Qgc3VwcG9ydCBEUE8gb3IgRlVBClsgICAyMC41MTIyNTldICBzZGE6
IHNkYTEgc2RhMiBzZGEzClsgICAyMC41OTQ4OTNdIHNkIDE6MDowOjA6IFtzZGFdIEF0dGFjaGVk
IFNDU0kgZGlzawpbICAgMjAuNjAyMDUxXSBpZ2IgMDAwMDowMzowMC4wIGVucDNzMDogcmVuYW1l
ZCBmcm9tIGV0aDAKWyAgIDIyLjI1NDc5NF0gcGVyZjogaW50ZXJydXB0IHRvb2sgdG9vIGxvbmcg
KDI4OTcgPiAyNTAwKSwgbG93ZXJpbmcga2VybmVsLnBlcmZfZXZlbnRfbWF4X3NhbXBsZV9yYXRl
IHRvIDY5MDAwClsgICAyMy4zNTQ5NzBdIHJhaWQ2OiBzc2UyeDQgICBnZW4oKSAgMzQ4NCBNQi9z
ClsgICAyMy40MDI5NTRdIHJhaWQ2OiBzc2UyeDQgICB4b3IoKSAgMjEzMiBNQi9zClsgICAyMy40
NTA5NTVdIHJhaWQ2OiBzc2UyeDIgICBnZW4oKSAgMjY4NSBNQi9zClsgICAyMy40OTg5NTVdIHJh
aWQ2OiBzc2UyeDIgICB4b3IoKSAgMjI0MiBNQi9zClsgICAyMy41NDY5NjldIHJhaWQ2OiBzc2Uy
eDEgICBnZW4oKSAgMjYxOCBNQi9zClsgICAyMy41OTQ5NjRdIHJhaWQ2OiBzc2UyeDEgICB4b3Io
KSAgMTkwMCBNQi9zClsgICAyMy41OTQ5NjZdIHJhaWQ2OiB1c2luZyBhbGdvcml0aG0gc3NlMng0
IGdlbigpIDM0ODQgTUIvcwpbICAgMjMuNTk0OTY3XSByYWlkNjogLi4uLiB4b3IoKSAyMTMyIE1C
L3MsIHJtdyBlbmFibGVkClsgICAyMy41OTQ5NjldIHJhaWQ2OiB1c2luZyBzc3NlM3gyIHJlY292
ZXJ5IGFsZ29yaXRobQpbICAgMjMuNTk4MzYzXSB4b3I6IG1lYXN1cmluZyBzb2Z0d2FyZSBjaGVj
a3N1bSBzcGVlZApbICAgMjMuNjM0OTU0XSAgICBwcmVmZXRjaDY0LXNzZTogIDc3NDQuMDAwIE1C
L3NlYwpbICAgMjMuNjc0OTUyXSAgICBnZW5lcmljX3NzZTogIDYxMTEuMDAwIE1CL3NlYwpbICAg
MjMuNjc0OTU1XSB4b3I6IHVzaW5nIGZ1bmN0aW9uOiBwcmVmZXRjaDY0LXNzZSAoNzc0NC4wMDAg
TUIvc2VjKQpbICAgMjMuNjc4MTc0XSBhc3luY190eDogYXBpIGluaXRpYWxpemVkIChhc3luYykK
WyAgIDI0LjA2OTIzN10gQnRyZnMgbG9hZGVkLCBjcmMzMmM9Y3JjMzJjLWludGVsClsgICAyNC4z
MzY5OTZdIGZiY29uOiBUYWtpbmcgb3ZlciBjb25zb2xlClsgICAyNC4zMzgyNzZdIENvbnNvbGU6
IHN3aXRjaGluZyB0byBjb2xvdXIgZnJhbWUgYnVmZmVyIGRldmljZSAxMjh4NDgKWyAgIDI0LjQw
NzYzN10gRVhUNC1mcyAoZG0tMCk6IG1vdW50ZWQgZmlsZXN5c3RlbSB3aXRoIG9yZGVyZWQgZGF0
YSBtb2RlLiBPcHRzOiAobnVsbCkKWyAgIDI1LjQ1NzcxOF0gc3lzdGVtZFsxXTogSW5zZXJ0ZWQg
bW9kdWxlICdhdXRvZnM0JwpbICAgMjUuNTA3NzU3XSBzeXN0ZW1kWzFdOiBzeXN0ZW1kIDI0NS40
LTR1YnVudHUzLjI0IHJ1bm5pbmcgaW4gc3lzdGVtIG1vZGUuICgrUEFNICtBVURJVCArU0VMSU5V
WCArSU1BICtBUFBBUk1PUiArU01BQ0sgK1NZU1ZJTklUICtVVE1QICtMSUJDUllQVFNFVFVQICtH
Q1JZUFQgK0dOVVRMUyArQUNMICtYWiArTFo0ICtTRUNDT01QICtCTEtJRCArRUxGVVRJTFMgK0tN
T0QgK0lETjIgLUlETiArUENSRTIgZGVmYXVsdC1oaWVyYXJjaHk9aHlicmlkKQpbICAgMjUuNTI3
MzE4XSBzeXN0ZW1kWzFdOiBEZXRlY3RlZCBhcmNoaXRlY3R1cmUgeDg2LTY0LgpbICAgMjUuNTUy
OTc3XSBzeXN0ZW1kWzFdOiBTZXQgaG9zdG5hbWUgdG8gPGNhbWRldnN5c21ydHMyZDA1Mzg+Lgpb
ICAgMjYuMzAxMjM1XSBzeXN0ZW1kWzFdOiBDb25maWd1cmF0aW9uIGZpbGUgL3J1bi9zeXN0ZW1k
L3N5c3RlbS9uZXRwbGFuLW92cy1jbGVhbnVwLnNlcnZpY2UgaXMgbWFya2VkIHdvcmxkLWluYWNj
ZXNzaWJsZS4gVGhpcyBoYXMgbm8gZWZmZWN0IGFzIGNvbmZpZ3VyYXRpb24gZGF0YSBpcyBhY2Nl
c3NpYmxlIHZpYSBBUElzIHdpdGhvdXQgcmVzdHJpY3Rpb25zLiBQcm9jZWVkaW5nIGFueXdheS4K
WyAgIDI2LjU3NzAwNV0gc3lzdGVtZFsxXTogQ3JlYXRlZCBzbGljZSBzeXN0ZW0tbW9kcHJvYmUu
c2xpY2UuClsgICAyNi41NzgzMDldIHN5c3RlbWRbMV06IENyZWF0ZWQgc2xpY2Ugc3lzdGVtLXN5
c3RlbWRceDJkZnNjay5zbGljZS4KWyAgIDI2LjU3OTQwNV0gc3lzdGVtZFsxXTogQ3JlYXRlZCBz
bGljZSBVc2VyIGFuZCBTZXNzaW9uIFNsaWNlLgpbICAgMjYuNTc5NTY1XSBzeXN0ZW1kWzFdOiBT
dGFydGVkIG50cC1zeXN0ZW1kLW5ldGlmLnBhdGguClsgICAyNi41Nzk3NjddIHN5c3RlbWRbMV06
IFN0YXJ0ZWQgRm9yd2FyZCBQYXNzd29yZCBSZXF1ZXN0cyB0byBXYWxsIERpcmVjdG9yeSBXYXRj
aC4KWyAgIDI2LjU4MDQxNV0gc3lzdGVtZFsxXTogU2V0IHVwIGF1dG9tb3VudCBBcmJpdHJhcnkg
RXhlY3V0YWJsZSBGaWxlIEZvcm1hdHMgRmlsZSBTeXN0ZW0gQXV0b21vdW50IFBvaW50LgpbICAg
MjYuNTgwNjE3XSBzeXN0ZW1kWzFdOiBSZWFjaGVkIHRhcmdldCBVc2VyIGFuZCBHcm91cCBOYW1l
IExvb2t1cHMuClsgICAyNi41ODA2NzZdIHN5c3RlbWRbMV06IFJlYWNoZWQgdGFyZ2V0IFNsaWNl
cy4KWyAgIDI2LjU4MDcyNV0gc3lzdGVtZFsxXTogUmVhY2hlZCB0YXJnZXQgTW91bnRpbmcgc25h
cHMuClsgICAyNi41ODA3OTJdIHN5c3RlbWRbMV06IFJlYWNoZWQgdGFyZ2V0IFN5c3RlbSBUaW1l
IFNldC4KWyAgIDI2LjU4MTAzNV0gc3lzdGVtZFsxXTogTGlzdGVuaW5nIG9uIERldmljZS1tYXBw
ZXIgZXZlbnQgZGFlbW9uIEZJRk9zLgpbICAgMjYuNTgxMzcwXSBzeXN0ZW1kWzFdOiBMaXN0ZW5p
bmcgb24gTFZNMiBwb2xsIGRhZW1vbiBzb2NrZXQuClsgICAyNi41ODE1NzddIHN5c3RlbWRbMV06
IExpc3RlbmluZyBvbiBtdWx0aXBhdGhkIGNvbnRyb2wgc29ja2V0LgpbICAgMjYuNTgxODgxXSBz
eXN0ZW1kWzFdOiBMaXN0ZW5pbmcgb24gU3lzbG9nIFNvY2tldC4KWyAgIDI2LjU4MjE4MF0gc3lz
dGVtZFsxXTogTGlzdGVuaW5nIG9uIGZzY2sgdG8gZnNja2QgY29tbXVuaWNhdGlvbiBTb2NrZXQu
ClsgICAyNi41ODIzNDldIHN5c3RlbWRbMV06IExpc3RlbmluZyBvbiBpbml0Y3RsIENvbXBhdGli
aWxpdHkgTmFtZWQgUGlwZS4KWyAgIDI2LjU4MzA0NV0gc3lzdGVtZFsxXTogTGlzdGVuaW5nIG9u
IEpvdXJuYWwgQXVkaXQgU29ja2V0LgpbICAgMjYuNTgzMzc5XSBzeXN0ZW1kWzFdOiBMaXN0ZW5p
bmcgb24gSm91cm5hbCBTb2NrZXQgKC9kZXYvbG9nKS4KWyAgIDI2LjU4Mzc3OF0gc3lzdGVtZFsx
XTogTGlzdGVuaW5nIG9uIEpvdXJuYWwgU29ja2V0LgpbICAgMjYuNTg0MzAwXSBzeXN0ZW1kWzFd
OiBMaXN0ZW5pbmcgb24gTmV0d29yayBTZXJ2aWNlIE5ldGxpbmsgU29ja2V0LgpbICAgMjYuNTg0
NjQzXSBzeXN0ZW1kWzFdOiBMaXN0ZW5pbmcgb24gdWRldiBDb250cm9sIFNvY2tldC4KWyAgIDI2
LjU4NDg4MV0gc3lzdGVtZFsxXTogTGlzdGVuaW5nIG9uIHVkZXYgS2VybmVsIFNvY2tldC4KWyAg
IDI2LjU4ODMyMl0gc3lzdGVtZFsxXTogTW91bnRpbmcgSHVnZSBQYWdlcyBGaWxlIFN5c3RlbS4u
LgpbICAgMjYuNTkyMjMyXSBzeXN0ZW1kWzFdOiBNb3VudGluZyBQT1NJWCBNZXNzYWdlIFF1ZXVl
IEZpbGUgU3lzdGVtLi4uClsgICAyNi41OTYzNzldIHN5c3RlbWRbMV06IE1vdW50aW5nIEtlcm5l
bCBEZWJ1ZyBGaWxlIFN5c3RlbS4uLgpbICAgMjYuNjAwNTI0XSBzeXN0ZW1kWzFdOiBNb3VudGlu
ZyBLZXJuZWwgVHJhY2UgRmlsZSBTeXN0ZW0uLi4KWyAgIDI2LjYwNjgyNF0gc3lzdGVtZFsxXTog
U3RhcnRpbmcgSm91cm5hbCBTZXJ2aWNlLi4uClsgICAyNi42MTEwODVdIHN5c3RlbWRbMV06IFN0
YXJ0aW5nIFNldCB0aGUgY29uc29sZSBrZXlib2FyZCBsYXlvdXQuLi4KWyAgIDI2LjYxNTYyNV0g
c3lzdGVtZFsxXTogU3RhcnRpbmcgQ3JlYXRlIGxpc3Qgb2Ygc3RhdGljIGRldmljZSBub2RlcyBm
b3IgdGhlIGN1cnJlbnQga2VybmVsLi4uClsgICAyNi42MTk3MjRdIHN5c3RlbWRbMV06IFN0YXJ0
aW5nIE1vbml0b3Jpbmcgb2YgTFZNMiBtaXJyb3JzLCBzbmFwc2hvdHMgZXRjLiB1c2luZyBkbWV2
ZW50ZCBvciBwcm9ncmVzcyBwb2xsaW5nLi4uClsgICAyNi42MjM2NDZdIHN5c3RlbWRbMV06IFN0
YXJ0aW5nIExvYWQgS2VybmVsIE1vZHVsZSBjaHJvbWVvc19wc3RvcmUuLi4KWyAgIDI2LjYyMzc3
N10gc3lzdGVtZFsxXTogQ29uZGl0aW9uIGNoZWNrIHJlc3VsdGVkIGluIExvYWQgS2VybmVsIE1v
ZHVsZSBkcm0gYmVpbmcgc2tpcHBlZC4KWyAgIDI2LjYyNzY3Ml0gc3lzdGVtZFsxXTogU3RhcnRp
bmcgTG9hZCBLZXJuZWwgTW9kdWxlIGVmaV9wc3RvcmUuLi4KWyAgIDI2LjYzMTc3M10gc3lzdGVt
ZFsxXTogU3RhcnRpbmcgTG9hZCBLZXJuZWwgTW9kdWxlIHBzdG9yZV9ibGsuLi4KWyAgIDI2LjYz
NzcwMF0gc3lzdGVtZFsxXTogU3RhcnRpbmcgTG9hZCBLZXJuZWwgTW9kdWxlIHBzdG9yZV96b25l
Li4uClsgICAyNi42NDE1ODldIHN5c3RlbWRbMV06IFN0YXJ0aW5nIExvYWQgS2VybmVsIE1vZHVs
ZSByYW1vb3BzLi4uClsgICAyNi42NDE3OTVdIHN5c3RlbWRbMV06IENvbmRpdGlvbiBjaGVjayBy
ZXN1bHRlZCBpbiBPcGVuVlN3aXRjaCBjb25maWd1cmF0aW9uIGZvciBjbGVhbnVwIGJlaW5nIHNr
aXBwZWQuClsgICAyNi42NDMxNDRdIHN5c3RlbWRbMV06IENvbmRpdGlvbiBjaGVjayByZXN1bHRl
ZCBpbiBTZXQgVXAgQWRkaXRpb25hbCBCaW5hcnkgRm9ybWF0cyBiZWluZyBza2lwcGVkLgpbICAg
MjYuNjQzMjk1XSBzeXN0ZW1kWzFdOiBDb25kaXRpb24gY2hlY2sgcmVzdWx0ZWQgaW4gRmlsZSBT
eXN0ZW0gQ2hlY2sgb24gUm9vdCBEZXZpY2UgYmVpbmcgc2tpcHBlZC4KWyAgIDI2LjY0ODgzNF0g
c3lzdGVtZFsxXTogU3RhcnRpbmcgTG9hZCBLZXJuZWwgTW9kdWxlcy4uLgpbICAgMjYuNjUyNjI5
XSBzeXN0ZW1kWzFdOiBTdGFydGluZyBSZW1vdW50IFJvb3QgYW5kIEtlcm5lbCBGaWxlIFN5c3Rl
bXMuLi4KWyAgIDI2LjY1NjYzNl0gc3lzdGVtZFsxXTogU3RhcnRpbmcgdWRldiBDb2xkcGx1ZyBh
bGwgRGV2aWNlcy4uLgpbICAgMjYuNjYwODE2XSBzeXN0ZW1kWzFdOiBTdGFydGluZyBVbmNvbXBs
aWNhdGVkIGZpcmV3YWxsLi4uClsgICAyNi42NjY5MzVdIHN5c3RlbWRbMV06IE1vdW50ZWQgSHVn
ZSBQYWdlcyBGaWxlIFN5c3RlbS4KWyAgIDI2LjY2NzQ4OF0gc3lzdGVtZFsxXTogTW91bnRlZCBQ
T1NJWCBNZXNzYWdlIFF1ZXVlIEZpbGUgU3lzdGVtLgpbICAgMjYuNjY3OTMwXSBzeXN0ZW1kWzFd
OiBNb3VudGVkIEtlcm5lbCBEZWJ1ZyBGaWxlIFN5c3RlbS4KWyAgIDI2LjY2ODQyMV0gc3lzdGVt
ZFsxXTogTW91bnRlZCBLZXJuZWwgVHJhY2UgRmlsZSBTeXN0ZW0uClsgICAyNi42NzA4MTddIHN5
c3RlbWRbMV06IEZpbmlzaGVkIENyZWF0ZSBsaXN0IG9mIHN0YXRpYyBkZXZpY2Ugbm9kZXMgZm9y
IHRoZSBjdXJyZW50IGtlcm5lbC4KWyAgIDI2LjY5OTA5NF0gc3lzdGVtZFsxXTogbW9kcHJvYmVA
ZWZpX3BzdG9yZS5zZXJ2aWNlOiBTdWNjZWVkZWQuClsgICAyNi43MDAyODJdIHN5c3RlbWRbMV06
IEZpbmlzaGVkIExvYWQgS2VybmVsIE1vZHVsZSBlZmlfcHN0b3JlLgpbICAgMjYuNzAzNDM3XSBF
WFQ0LWZzIChkbS0wKTogcmUtbW91bnRlZC4gT3B0czogKG51bGwpClsgICAyNi43MDcwNTldIHN5
c3RlbWRbMV06IG1vZHByb2JlQHBzdG9yZV9ibGsuc2VydmljZTogU3VjY2VlZGVkLgpbICAgMjYu
NzA4MjA0XSBzeXN0ZW1kWzFdOiBGaW5pc2hlZCBMb2FkIEtlcm5lbCBNb2R1bGUgcHN0b3JlX2Js
ay4KWyAgIDI2LjcwOTM1NF0gc3lzdGVtZFsxXTogbW9kcHJvYmVAcHN0b3JlX3pvbmUuc2Vydmlj
ZTogU3VjY2VlZGVkLgpbICAgMjYuNzExMzAyXSBzeXN0ZW1kWzFdOiBGaW5pc2hlZCBMb2FkIEtl
cm5lbCBNb2R1bGUgcHN0b3JlX3pvbmUuClsgICAyNi43MTM2ODNdIHN5c3RlbWRbMV06IEZpbmlz
aGVkIFJlbW91bnQgUm9vdCBhbmQgS2VybmVsIEZpbGUgU3lzdGVtcy4KWyAgIDI2LjcxNjExNF0g
c3lzdGVtZFsxXTogRmluaXNoZWQgVW5jb21wbGljYXRlZCBmaXJld2FsbC4KWyAgIDI2LjcxODk0
MF0gc3lzdGVtZFsxXTogQ29uZGl0aW9uIGNoZWNrIHJlc3VsdGVkIGluIFJlYnVpbGQgSGFyZHdh
cmUgRGF0YWJhc2UgYmVpbmcgc2tpcHBlZC4KWyAgIDI2LjcyMjM3N10gc3lzdGVtZFsxXTogU3Rh
cnRpbmcgQ3JlYXRlIFN5c3RlbSBVc2Vycy4uLgpbICAgMjYuNzI1ODU0XSBzeXN0ZW1kWzFdOiBt
b2Rwcm9iZUBjaHJvbWVvc19wc3RvcmUuc2VydmljZTogU3VjY2VlZGVkLgpbICAgMjYuNzI3MjEx
XSBzeXN0ZW1kWzFdOiBGaW5pc2hlZCBMb2FkIEtlcm5lbCBNb2R1bGUgY2hyb21lb3NfcHN0b3Jl
LgpbICAgMjYuNzMxMzg0XSBzeXN0ZW1kWzFdOiBGaW5pc2hlZCBMb2FkIEtlcm5lbCBNb2R1bGVz
LgpbICAgMjYuNzM3MDExXSBzeXN0ZW1kWzFdOiBNb3VudGluZyBGVVNFIENvbnRyb2wgRmlsZSBT
eXN0ZW0uLi4KWyAgIDI2Ljc0MTM4NV0gc3lzdGVtZFsxXTogTW91bnRpbmcgS2VybmVsIENvbmZp
Z3VyYXRpb24gRmlsZSBTeXN0ZW0uLi4KWyAgIDI2Ljc1MDcwN10gc3lzdGVtZFsxXTogU3RhcnRp
bmcgQXBwbHkgS2VybmVsIFZhcmlhYmxlcy4uLgpbICAgMjYuNzU1MTEwXSBzeXN0ZW1kWzFdOiBt
b2Rwcm9iZUByYW1vb3BzLnNlcnZpY2U6IFN1Y2NlZWRlZC4KWyAgIDI2Ljc1NjI1MV0gc3lzdGVt
ZFsxXTogRmluaXNoZWQgTG9hZCBLZXJuZWwgTW9kdWxlIHJhbW9vcHMuClsgICAyNi43NTY5MTVd
IHN5c3RlbWRbMV06IE1vdW50ZWQgRlVTRSBDb250cm9sIEZpbGUgU3lzdGVtLgpbICAgMjYuNzU3
MzM1XSBzeXN0ZW1kWzFdOiBNb3VudGVkIEtlcm5lbCBDb25maWd1cmF0aW9uIEZpbGUgU3lzdGVt
LgpbICAgMjYuNzYzNDE5XSBzeXN0ZW1kWzFdOiBGaW5pc2hlZCBNb25pdG9yaW5nIG9mIExWTTIg
bWlycm9ycywgc25hcHNob3RzIGV0Yy4gdXNpbmcgZG1ldmVudGQgb3IgcHJvZ3Jlc3MgcG9sbGlu
Zy4KWyAgIDI2Ljc4NjYwNV0gc3lzdGVtZFsxXTogRmluaXNoZWQgQ3JlYXRlIFN5c3RlbSBVc2Vy
cy4KWyAgIDI2Ljc5MDI5MV0gc3lzdGVtZFsxXTogU3RhcnRpbmcgQ3JlYXRlIFN0YXRpYyBEZXZp
Y2UgTm9kZXMgaW4gL2Rldi4uLgpbICAgMjYuODU4OTc4XSBzeXN0ZW1kWzFdOiBGaW5pc2hlZCBB
cHBseSBLZXJuZWwgVmFyaWFibGVzLgpbICAgMjYuODgzOTMyXSBzeXN0ZW1kWzFdOiBGaW5pc2hl
ZCBDcmVhdGUgU3RhdGljIERldmljZSBOb2RlcyBpbiAvZGV2LgpbICAgMjYuODg3NzYxXSBzeXN0
ZW1kWzFdOiBTdGFydGluZyB1ZGV2IEtlcm5lbCBEZXZpY2UgTWFuYWdlci4uLgpbICAgMjYuOTA1
Mzk4XSBzeXN0ZW1kWzFdOiBTdGFydGVkIEpvdXJuYWwgU2VydmljZS4KWyAgIDMxLjE0OTkyMV0g
bTE4MDFfcGNpOiBsb2FkaW5nIG91dC1vZi10cmVlIG1vZHVsZSB0YWludHMga2VybmVsLgpbICAg
MzEuMTUwMDIwXSBtMTgwMV9wY2k6IG1vZHVsZSB2ZXJpZmljYXRpb24gZmFpbGVkOiBzaWduYXR1
cmUgYW5kL29yIHJlcXVpcmVkIGtleSBtaXNzaW5nIC0gdGFpbnRpbmcga2VybmVsClsgICAzMS4x
NTEyNjZdIE0xODAxIFBDSTogbXJ0c19wY2lfaW5pdApbICAgMzEuMTUxMjY5XSBNMTgwMSBQQ0k6
IG1ydHNfcGNpX3JlZ2lzdGVyX2NoYXJfZHJpdmVyClsgICAzMS4xNTEzMzFdIE0xODAxIFBDSTog
UHJvYmUgZm9yIFBDSSBEZXYwIG9uIFBDSSBCdXMgMDAwMDowMQpbICAgMzEuMTU0Mjc3XSBNMTgw
MSBQQ0kgMDAwMDowMTowMC4wOiBCQVIwIEAgYjA0MDAwMDAtYjA4MDAwMDAKWyAgIDMxLjE1NDI4
M10gTTE4MDEgUENJIDAwMDA6MDE6MDAuMDogQkFSMSBAIDAwMDAwMDAwLTAwMDAwMDAwClsgICAz
MS4xNTQyODZdIE0xODAxIFBDSSAwMDAwOjAxOjAwLjA6IEJBUjIgQCAwMDAwMDAwMC0wMDAwMDAw
MApbICAgMzEuMTU0Mjg4XSBNMTgwMSBQQ0kgMDAwMDowMTowMC4wOiBCQVIzIEAgMDAwMDAwMDAt
MDAwMDAwMDAKWyAgIDMxLjE1NDI5MV0gTTE4MDEgUENJIDAwMDA6MDE6MDAuMDogQkFSNCBAIDAw
MDAwMDAwLTAwMDAwMDAwClsgICAzMS4xNTQyOTRdIE0xODAxIFBDSSAwMDAwOjAxOjAwLjA6IEJB
UjUgQCAwMDAwMDAwMC0wMDAwMDAwMApbICAgMzEuMTU0MzIxXSBNMTgwMSBQQ0k6IERldjAgb24g
UENJIEJ1cyAwMDAwOjAxIFJlc291cmNlX3N0YXJ0ID0gMHhiMDQwMDAwMCBSZXNvdXJjZV9zaXpl
ID0gMHg0MDAwMDAKWyAgIDMxLjE1NDM1NF0gTTE4MDEgUENJOiBEZXYwIG9uIFBDSSBCdXMgMDAw
MDowMSBTdWJzeXN0ZW0gVmVuZG9yIElEID0gMHg0MDAwClsgICAzMS4xNTQzNTZdIE0xODAxIFBD
STogRGV2MCBvbiBQQ0kgQnVzIDAwMDA6MDEgU3Vic3lzdGVtIERldmljZSBJRCA9IDB4MApbICAg
MzEuMTU0MzU4XSBNMTgwMSBQQ0k6IERldjAgb24gUENJIEJ1cyAwMDAwOjAxIFR1cGxlIEJhc2Ug
QWRkcmVzcyA9IDB4NDAwMApbICAgMzEuMTU0MzY1XSBNMTgwMSBQQ0k6IERldjAgdHVwbGVfb2Zm
c2V0ID0gMjgKWyAgIDMxLjE1NDM2OF0gTTE4MDEgUENJOiBEZXYwIHR1cGxlLT5ob3N0X2ludGVy
ZmFjZV90eXBlID0gMHgyClsgICAzMS4xNTQ0NDFdIE0xODAxIFBDSTogRGV2MCB0dXBsZS0+aG9z
dF9pbnRlcmZhY2VfdHlwZSA9IDB4MwpbICAgMzEuMTU0NDYzXSBNMTgwMSBQQ0k6IERldjAgdHVw
bGUtPmhvc3RfaW50ZXJmYWNlX3R5cGUgPSAweDQKWyAgIDMxLjE1NDQ4NF0gTTE4MDEgUENJOiBE
ZXYwIHR1cGxlLT5ob3N0X2ludGVyZmFjZV90eXBlID0gMHg1ClsgICAzMS4xNTQ1MDVdIE0xODAx
IFBDSTogRGV2MCB0dXBsZS0+aG9zdF9pbnRlcmZhY2VfdHlwZSA9IDB4NgpbICAgMzEuMTU0NTI2
XSBNMTgwMSBQQ0k6IERldjAgdHVwbGUtPmhvc3RfaW50ZXJmYWNlX3R5cGUgPSAweDcKWyAgIDMx
LjE1NDU0N10gTTE4MDEgUENJOiBEZXYwIHR1cGxlLT5ob3N0X2ludGVyZmFjZV90eXBlID0gMHhi
ClsgICAzMS4xNTQ1NjhdIE0xODAxIFBDSTogRGV2MCB0dXBsZS0+aG9zdF9pbnRlcmZhY2VfdHlw
ZSA9IDB4YQpbICAgMzEuMTU0NTg5XSBNMTgwMSBQQ0k6IERldjAgdHVwbGUtPmhvc3RfaW50ZXJm
YWNlX3R5cGUgPSAweDIKWyAgIDMxLjE1NDYxMF0gTTE4MDEgUENJOiBEZXYwIHR1cGxlLT5ob3N0
X2ludGVyZmFjZV90eXBlID0gMHhmClsgICAzMS4xNTQ2MzFdIE0xODAxIFBDSTogRGV2MCB0dXBs
ZS0+aG9zdF9pbnRlcmZhY2VfdHlwZSA9IDB4ZApbICAgMzEuMTU0NjUyXSBNMTgwMSBQQ0k6IERl
djAgdHVwbGUtPmhvc3RfaW50ZXJmYWNlX3R5cGUgPSAweGUKWyAgIDMxLjE1NDY3M10gTTE4MDEg
UENJOiBEZXYwIHR1cGxlLT5ob3N0X2ludGVyZmFjZV90eXBlID0gMHhlClsgICAzMS4xNTQ2OTRd
IE0xODAxIFBDSTogRGV2MCB0dXBsZS0+aG9zdF9pbnRlcmZhY2VfdHlwZSA9IDB4ZQpbICAgMzEu
MTU0NzE1XSBNMTgwMSBQQ0k6IERldjAgdHVwbGUtPmhvc3RfaW50ZXJmYWNlX3R5cGUgPSAweGUK
WyAgIDMxLjE1NDczNl0gTTE4MDEgUENJOiBEZXYwIHR1cGxlLT5ob3N0X2ludGVyZmFjZV90eXBl
ID0gMHgxNwpbICAgMzEuMTU0NzU3XSBNMTgwMSBQQ0k6IERldjAgdHVwbGUtPmhvc3RfaW50ZXJm
YWNlX3R5cGUgPSAweDE3ClsgICAzMS4xNTQ3NzhdIE0xODAxIFBDSTogRGV2MCB0dXBsZS0+aG9z
dF9pbnRlcmZhY2VfdHlwZSA9IDB4ZQpbICAgMzEuMTU0Nzk5XSBNMTgwMSBQQ0k6IERldjAgdHVw
bGUtPmhvc3RfaW50ZXJmYWNlX3R5cGUgPSAweGUKWyAgIDMxLjE1NDgyMF0gTTE4MDEgUENJOiBE
ZXYwIHR1cGxlLT5ob3N0X2ludGVyZmFjZV90eXBlID0gMHgxMApbICAgMzEuMTU0ODQxXSBNMTgw
MSBQQ0k6IERldjAgdHVwbGUtPmhvc3RfaW50ZXJmYWNlX3R5cGUgPSAweDExClsgICAzMS4xNTQ4
NjJdIE0xODAxIFBDSTogRGV2MCB0dXBsZS0+aG9zdF9pbnRlcmZhY2VfdHlwZSA9IDB4MTIKWyAg
IDMxLjE1NDg4M10gTTE4MDEgUENJOiBEZXYwIHR1cGxlLT5ob3N0X2ludGVyZmFjZV90eXBlID0g
MHgxNApbICAgMzEuMTU0OTAzXSBNMTgwMSBQQ0k6IERldjAgdHVwbGUtPmhvc3RfaW50ZXJmYWNl
X3R5cGUgPSAweDE1ClsgICAzMS4xNTQ5MjRdIE0xODAxIFBDSTogRGV2MCB0dXBsZS0+aG9zdF9p
bnRlcmZhY2VfdHlwZSA9IDB4MTYKWyAgIDMxLjE1NDk0NV0gTTE4MDEgUENJOiBEZXYwIHR1cGxl
LT5ob3N0X2ludGVyZmFjZV90eXBlID0gMHgxOApbICAgMzEuMTU0OTY2XSBNMTgwMSBQQ0k6IERl
djAgdHVwbGUtPmhvc3RfaW50ZXJmYWNlX3R5cGUgPSAweDE5ClsgICAzMS4xNTQ5ODddIE0xODAx
IFBDSTogRGV2MCB0dXBsZS0+aG9zdF9pbnRlcmZhY2VfdHlwZSA9IDB4MWEKWyAgIDMxLjE1NTAw
OF0gTTE4MDEgUENJOiBEZXYwIHR1cGxlLT5ob3N0X2ludGVyZmFjZV90eXBlID0gMHgxYgpbICAg
MzEuMTU1MDI5XSBNMTgwMSBQQ0k6IERldjAgdHVwbGUtPmhvc3RfaW50ZXJmYWNlX3R5cGUgPSAw
eDFjClsgICAzMS4xNTUwNTBdIE0xODAxIFBDSTogRGV2MCB0dXBsZS0+aG9zdF9pbnRlcmZhY2Vf
dHlwZSA9IDB4MgpbICAgMzEuMTU1MDY5XSBNMTgwMSBQQ0k6IERldjAgSW50ZXJmYWNlIE1hc2sg
PSAweDFmZjdlY2ZjClsgICAzMS4xNTUwOTJdIE0xODAxIFBDSTogTEFCX0FEQVBURVJfREVURUNU
RUQKWyAgIDMxLjE1NTA5NV0gTTE4MDEgUENJOiBEVVRfREVURUNURUQKWyAgIDMxLjE2MDkzM10g
TTE4MDEgUENJOiBEcml2ZXIgTG9hZGVkIFN1Y2Nlc3NmdWxseQpbICAgMzEuMjgyNzE2XSBjZGNf
YWNtIDEtMzoxLjA6IHR0eUFDTTA6IFVTQiBBQ00gZGV2aWNlClsgICAzMS4yODMwNjNdIHVzYmNv
cmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgY2RjX2FjbQpbICAgMzEuMjgzMDY1
XSBjZGNfYWNtOiBVU0IgQWJzdHJhY3QgQ29udHJvbCBNb2RlbCBkcml2ZXIgZm9yIFVTQiBtb2Rl
bXMgYW5kIElTRE4gYWRhcHRlcnMKWyAgIDMxLjQ5OTk2MF0gaW50ZWxfcmFwbF9jb21tb246IEZv
dW5kIFJBUEwgZG9tYWluIHBhY2thZ2UKWyAgIDMxLjQ5OTk2M10gaW50ZWxfcmFwbF9jb21tb246
IEZvdW5kIFJBUEwgZG9tYWluIGNvcmUKWyAgIDMxLjg4NjUxOV0gQWRkaW5nIDUyNDI4NzZrIHN3
YXAgb24gL2Rldi9tYXBwZXIvdmcwMC1zd2Fwdm9sLiAgUHJpb3JpdHk6LTIgZXh0ZW50czoxIGFj
cm9zczo1MjQyODc2ayBTU0ZTClsgICAzNy4wNzY5NzZdIGFsdWE6IGRldmljZSBoYW5kbGVyIHJl
Z2lzdGVyZWQKWyAgIDM3LjA4MjQ2MF0gZW1jOiBkZXZpY2UgaGFuZGxlciByZWdpc3RlcmVkClsg
ICAzNy4wOTA3MDZdIHJkYWM6IGRldmljZSBoYW5kbGVyIHJlZ2lzdGVyZWQKWyAgIDM3LjQyNDAz
OF0gRVhUNC1mcyAoc2RhMik6IG1vdW50ZWQgZmlsZXN5c3RlbSB3aXRoIG9yZGVyZWQgZGF0YSBt
b2RlLiBPcHRzOiAobnVsbCkKWyAgIDM3LjQyNDA4Ml0gRVhUNC1mcyAoZG0tMSk6IG1vdW50ZWQg
ZmlsZXN5c3RlbSB3aXRoIG9yZGVyZWQgZGF0YSBtb2RlLiBPcHRzOiAobnVsbCkKWyAgIDM3LjU2
MTU5NV0gc3lzdGVtZC1qb3VybmFsZFs0MzNdOiBSZWNlaXZlZCBjbGllbnQgcmVxdWVzdCB0byBm
bHVzaCBydW50aW1lIGpvdXJuYWwuClsgICAzOC4wNjM5OTldIGF1ZGl0OiB0eXBlPTE0MDAgYXVk
aXQoMTczODMwNDYxNy44NDc6Mik6IGFwcGFybW9yPSJTVEFUVVMiIG9wZXJhdGlvbj0icHJvZmls
ZV9sb2FkIiBwcm9maWxlPSJ1bmNvbmZpbmVkIiBuYW1lPSJudmlkaWFfbW9kcHJvYmUiIHBpZD03
MjAgY29tbT0iYXBwYXJtb3JfcGFyc2VyIgpbICAgMzguMDY0MDEwXSBhdWRpdDogdHlwZT0xNDAw
IGF1ZGl0KDE3MzgzMDQ2MTcuODQ3OjMpOiBhcHBhcm1vcj0iU1RBVFVTIiBvcGVyYXRpb249InBy
b2ZpbGVfbG9hZCIgcHJvZmlsZT0idW5jb25maW5lZCIgbmFtZT0ibnZpZGlhX21vZHByb2JlLy9r
bW9kIiBwaWQ9NzIwIGNvbW09ImFwcGFybW9yX3BhcnNlciIKWyAgIDM4LjA2ODU4MF0gYXVkaXQ6
IHR5cGU9MTQwMCBhdWRpdCgxNzM4MzA0NjE3Ljg1MTo0KTogYXBwYXJtb3I9IlNUQVRVUyIgb3Bl
cmF0aW9uPSJwcm9maWxlX2xvYWQiIHByb2ZpbGU9InVuY29uZmluZWQiIG5hbWU9Ii91c3IvYmlu
L21hbiIgcGlkPTcyMyBjb21tPSJhcHBhcm1vcl9wYXJzZXIiClsgICAzOC4wNjg1OTBdIGF1ZGl0
OiB0eXBlPTE0MDAgYXVkaXQoMTczODMwNDYxNy44NTE6NSk6IGFwcGFybW9yPSJTVEFUVVMiIG9w
ZXJhdGlvbj0icHJvZmlsZV9sb2FkIiBwcm9maWxlPSJ1bmNvbmZpbmVkIiBuYW1lPSJtYW5fZmls
dGVyIiBwaWQ9NzIzIGNvbW09ImFwcGFybW9yX3BhcnNlciIKWyAgIDM4LjA2ODU5N10gYXVkaXQ6
IHR5cGU9MTQwMCBhdWRpdCgxNzM4MzA0NjE3Ljg1MTo2KTogYXBwYXJtb3I9IlNUQVRVUyIgb3Bl
cmF0aW9uPSJwcm9maWxlX2xvYWQiIHByb2ZpbGU9InVuY29uZmluZWQiIG5hbWU9Im1hbl9ncm9m
ZiIgcGlkPTcyMyBjb21tPSJhcHBhcm1vcl9wYXJzZXIiClsgICAzOC4wNjk2MDBdIGF1ZGl0OiB0
eXBlPTE0MDAgYXVkaXQoMTczODMwNDYxNy44NTE6Nyk6IGFwcGFybW9yPSJTVEFUVVMiIG9wZXJh
dGlvbj0icHJvZmlsZV9sb2FkIiBwcm9maWxlPSJ1bmNvbmZpbmVkIiBuYW1lPSIvdXNyL2xpYi9z
bmFwZC9zbmFwLWNvbmZpbmUiIHBpZD03MTkgY29tbT0iYXBwYXJtb3JfcGFyc2VyIgpbICAgMzgu
MDY5NjExXSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE3MzgzMDQ2MTcuODUxOjgpOiBhcHBhcm1v
cj0iU1RBVFVTIiBvcGVyYXRpb249InByb2ZpbGVfbG9hZCIgcHJvZmlsZT0idW5jb25maW5lZCIg
bmFtZT0iL3Vzci9saWIvc25hcGQvc25hcC1jb25maW5lLy9tb3VudC1uYW1lc3BhY2UtY2FwdHVy
ZS1oZWxwZXIiIHBpZD03MTkgY29tbT0iYXBwYXJtb3JfcGFyc2VyIgpbICAgMzguMDc1NTQzXSBh
dWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE3MzgzMDQ2MTcuODU5OjkpOiBhcHBhcm1vcj0iU1RBVFVT
IiBvcGVyYXRpb249InByb2ZpbGVfbG9hZCIgcHJvZmlsZT0idW5jb25maW5lZCIgbmFtZT0ibHNi
X3JlbGVhc2UiIHBpZD03MjQgY29tbT0iYXBwYXJtb3JfcGFyc2VyIgpbICAgMzguMDgwODkyXSBh
dWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE3MzgzMDQ2MTcuODYzOjEwKTogYXBwYXJtb3I9IlNUQVRV
UyIgb3BlcmF0aW9uPSJwcm9maWxlX2xvYWQiIHByb2ZpbGU9InVuY29uZmluZWQiIG5hbWU9Ii91
c3Ivc2Jpbi9udHBkIiBwaWQ9NzIyIGNvbW09ImFwcGFybW9yX3BhcnNlciIKWyAgIDM4LjA4MjM2
Nl0gYXVkaXQ6IHR5cGU9MTQwMCBhdWRpdCgxNzM4MzA0NjE3Ljg2MzoxMSk6IGFwcGFybW9yPSJT
VEFUVVMiIG9wZXJhdGlvbj0icHJvZmlsZV9sb2FkIiBwcm9maWxlPSJ1bmNvbmZpbmVkIiBuYW1l
PSIvdXNyL3NiaW4vdGNwZHVtcCIgcGlkPTcyNiBjb21tPSJhcHBhcm1vcl9wYXJzZXIiClsgICA0
NS41MzkyOTNdIGlnYiAwMDAwOjAzOjAwLjAgZW5wM3MwOiBpZ2I6IGVucDNzMCBOSUMgTGluayBp
cyBVcCAxMDAwIE1icHMgRnVsbCBEdXBsZXgsIEZsb3cgQ29udHJvbDogUlgKWyAgIDQ1LjY0NzI5
OV0gSVB2NjogQUREUkNPTkYoTkVUREVWX0NIQU5HRSk6IGVucDNzMDogbGluayBiZWNvbWVzIHJl
YWR5ClsgICA1My4wODQyNjddIGthdWRpdGRfcHJpbnRrX3NrYjogMjEgY2FsbGJhY2tzIHN1cHBy
ZXNzZWQKWyAgIDUzLjA4NDI3MV0gYXVkaXQ6IHR5cGU9MTQwMCBhdWRpdCgxNzM4MzA0NjMyLjg2
NzozMyk6IGFwcGFybW9yPSJERU5JRUQiIG9wZXJhdGlvbj0ib3BlbiIgcHJvZmlsZT0iL3Vzci9z
YmluL250cGQiIG5hbWU9Ii9zbmFwL2Jpbi8iIHBpZD04NTEgY29tbT0ibnRwZCIgcmVxdWVzdGVk
X21hc2s9InIiIGRlbmllZF9tYXNrPSJyIiBmc3VpZD0wIG91aWQ9MApbICAgNTMuMDg0NDExXSBh
dWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE3MzgzMDQ2MzIuODY3OjM0KTogYXBwYXJtb3I9IkRFTklF
RCIgb3BlcmF0aW9uPSJzZW5kbXNnIiBpbmZvPSJGYWlsZWQgbmFtZSBsb29rdXAgLSBkaXNjb25u
ZWN0ZWQgcGF0aCIgZXJyb3I9LTEzIHByb2ZpbGU9Ii91c3Ivc2Jpbi9udHBkIiBuYW1lPSJydW4v
c3lzdGVtZC9qb3VybmFsL2Rldi1sb2ciIHBpZD04NTEgY29tbT0ibnRwZCIgcmVxdWVzdGVkX21h
c2s9InciIGRlbmllZF9tYXNrPSJ3IiBmc3VpZD0wIG91aWQ9MApbICAgNTMuMDg0NjY0XSBhdWRp
dDogdHlwZT0xNDAwIGF1ZGl0KDE3MzgzMDQ2MzIuODY3OjM1KTogYXBwYXJtb3I9IkRFTklFRCIg
b3BlcmF0aW9uPSJzZW5kbXNnIiBpbmZvPSJGYWlsZWQgbmFtZSBsb29rdXAgLSBkaXNjb25uZWN0
ZWQgcGF0aCIgZXJyb3I9LTEzIHByb2ZpbGU9Ii91c3Ivc2Jpbi9udHBkIiBuYW1lPSJydW4vc3lz
dGVtZC9qb3VybmFsL2Rldi1sb2ciIHBpZD04NTEgY29tbT0ibnRwZCIgcmVxdWVzdGVkX21hc2s9
InciIGRlbmllZF9tYXNrPSJ3IiBmc3VpZD0wIG91aWQ9MApbICAgNTMuMDg0NzM2XSBhdWRpdDog
dHlwZT0xNDAwIGF1ZGl0KDE3MzgzMDQ2MzIuODY3OjM2KTogYXBwYXJtb3I9IkRFTklFRCIgb3Bl
cmF0aW9uPSJzZW5kbXNnIiBpbmZvPSJGYWlsZWQgbmFtZSBsb29rdXAgLSBkaXNjb25uZWN0ZWQg
cGF0aCIgZXJyb3I9LTEzIHByb2ZpbGU9Ii91c3Ivc2Jpbi9udHBkIiBuYW1lPSJydW4vc3lzdGVt
ZC9qb3VybmFsL2Rldi1sb2ciIHBpZD04NTEgY29tbT0ibnRwZCIgcmVxdWVzdGVkX21hc2s9Inci
IGRlbmllZF9tYXNrPSJ3IiBmc3VpZD0wIG91aWQ9MApbICAgNTMuMDkwNTA2XSBhdWRpdDogdHlw
ZT0xNDAwIGF1ZGl0KDE3MzgzMDQ2MzIuODc1OjM3KTogYXBwYXJtb3I9IkRFTklFRCIgb3BlcmF0
aW9uPSJzZW5kbXNnIiBpbmZvPSJGYWlsZWQgbmFtZSBsb29rdXAgLSBkaXNjb25uZWN0ZWQgcGF0
aCIgZXJyb3I9LTEzIHByb2ZpbGU9Ii91c3Ivc2Jpbi9udHBkIiBuYW1lPSJydW4vc3lzdGVtZC9q
b3VybmFsL2Rldi1sb2ciIHBpZD04NzMgY29tbT0ibnRwZCIgcmVxdWVzdGVkX21hc2s9InciIGRl
bmllZF9tYXNrPSJ3IiBmc3VpZD0wIG91aWQ9MApbICAgNTMuMTU4OTMxXSBhdWRpdDogdHlwZT0x
NDAwIGF1ZGl0KDE3MzgzMDQ2MzIuOTQzOjM4KTogYXBwYXJtb3I9IkRFTklFRCIgb3BlcmF0aW9u
PSJzZW5kbXNnIiBpbmZvPSJGYWlsZWQgbmFtZSBsb29rdXAgLSBkaXNjb25uZWN0ZWQgcGF0aCIg
ZXJyb3I9LTEzIHByb2ZpbGU9Ii91c3Ivc2Jpbi9udHBkIiBuYW1lPSJydW4vc3lzdGVtZC9qb3Vy
bmFsL2Rldi1sb2ciIHBpZD04NzMgY29tbT0ibnRwZCIgcmVxdWVzdGVkX21hc2s9InciIGRlbmll
ZF9tYXNrPSJ3IiBmc3VpZD0wIG91aWQ9MApbICAgNTMuMTk5NzYxXSBhdWRpdDogdHlwZT0xNDAw
IGF1ZGl0KDE3MzgzMDQ2MzIuOTgzOjM5KTogYXBwYXJtb3I9IkRFTklFRCIgb3BlcmF0aW9uPSJz
ZW5kbXNnIiBpbmZvPSJGYWlsZWQgbmFtZSBsb29rdXAgLSBkaXNjb25uZWN0ZWQgcGF0aCIgZXJy
b3I9LTEzIHByb2ZpbGU9Ii91c3Ivc2Jpbi9udHBkIiBuYW1lPSJydW4vc3lzdGVtZC9qb3VybmFs
L2Rldi1sb2ciIHBpZD04NzMgY29tbT0ibnRwZCIgcmVxdWVzdGVkX21hc2s9InciIGRlbmllZF9t
YXNrPSJ3IiBmc3VpZD0wIG91aWQ9MApbICAgNTMuMTk5ODM3XSBhdWRpdDogdHlwZT0xNDAwIGF1
ZGl0KDE3MzgzMDQ2MzIuOTgzOjQwKTogYXBwYXJtb3I9IkRFTklFRCIgb3BlcmF0aW9uPSJzZW5k
bXNnIiBpbmZvPSJGYWlsZWQgbmFtZSBsb29rdXAgLSBkaXNjb25uZWN0ZWQgcGF0aCIgZXJyb3I9
LTEzIHByb2ZpbGU9Ii91c3Ivc2Jpbi9udHBkIiBuYW1lPSJydW4vc3lzdGVtZC9qb3VybmFsL2Rl
di1sb2ciIHBpZD04NzMgY29tbT0ibnRwZCIgcmVxdWVzdGVkX21hc2s9InciIGRlbmllZF9tYXNr
PSJ3IiBmc3VpZD0wIG91aWQ9MApbICAgNTMuMjA3ODg5XSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0
KDE3MzgzMDQ2MzIuOTkxOjQxKTogYXBwYXJtb3I9IkRFTklFRCIgb3BlcmF0aW9uPSJzZW5kbXNn
IiBpbmZvPSJGYWlsZWQgbmFtZSBsb29rdXAgLSBkaXNjb25uZWN0ZWQgcGF0aCIgZXJyb3I9LTEz
IHByb2ZpbGU9Ii91c3Ivc2Jpbi9udHBkIiBuYW1lPSJydW4vc3lzdGVtZC9qb3VybmFsL2Rldi1s
b2ciIHBpZD04NzMgY29tbT0ibnRwZCIgcmVxdWVzdGVkX21hc2s9InciIGRlbmllZF9tYXNrPSJ3
IiBmc3VpZD0wIG91aWQ9MApbICAgNTMuMjExMzQ1XSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE3
MzgzMDQ2MzIuOTk1OjQyKTogYXBwYXJtb3I9IkRFTklFRCIgb3BlcmF0aW9uPSJzZW5kbXNnIiBp
bmZvPSJGYWlsZWQgbmFtZSBsb29rdXAgLSBkaXNjb25uZWN0ZWQgcGF0aCIgZXJyb3I9LTEzIHBy
b2ZpbGU9Ii91c3Ivc2Jpbi9udHBkIiBuYW1lPSJydW4vc3lzdGVtZC9qb3VybmFsL2Rldi1sb2ci
IHBpZD04NzMgY29tbT0ibnRwZCIgcmVxdWVzdGVkX21hc2s9InciIGRlbmllZF9tYXNrPSJ3IiBm
c3VpZD0wIG91aWQ9MAo=
--00000000000059df9b062cfdb68b--

