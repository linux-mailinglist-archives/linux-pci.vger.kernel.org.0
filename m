Return-Path: <linux-pci+bounces-31327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66835AF6904
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 06:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D991C42A25
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 04:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9487728A726;
	Thu,  3 Jul 2025 04:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak8+sET2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2D328A721;
	Thu,  3 Jul 2025 04:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751515766; cv=none; b=nJJO2hXe0AQ0IMRNlTgvt0WnxyKA9IEJ+u4r74LBRAJCwvdBSRDRPJ3D0uETSHHd08iJGyP8cE3BUkTRWD1/LlCYIpA1ClGeJLdbBVsmcgVrbcopwge3THKTCsokXh8lLk/ZyFRNrlvA9lLkU7HeFFk7iZZDd7+L6lQqYWpdQHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751515766; c=relaxed/simple;
	bh=vocmHEiAb26/20iahKKs0X4175r4MvyXTpR3pdRpyIM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=emGNLZNqgchOC2lFqPQ8RClHNhsQ0Q54Pmu87F8sxK/uFBCXJstPERX1UA6VN9TM1aPmCL4ExIlbB3aTsioQPoKoBW/GAH+FGvYmSLSQD+8Y+Vil0YloImJIgvYmzs/hcjnqkli3lbY1N5WiycADVWBD1HQZBOiflmQ+JF2GcwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ak8+sET2; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6facf4d8e9eso51093406d6.1;
        Wed, 02 Jul 2025 21:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751515763; x=1752120563; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E7oZ2nGJ36w9gpKLnk8Rg0Ahvs5A2HVmMYpCFJMNvpg=;
        b=Ak8+sET2OoJZooI9R3C06C4mNaCBvAZKIIE4ZoLc9C2CKsdJCc6NX+kupuXJB4oYbF
         RujYBf0fyS3feYbiWnq7yu+06m/xQwjDkqP9E+bitO3/L6Dn7ejwo4Ur1aiPzdot9fs9
         LOg4C5Z1mA5DNCIu/aJmZ388GHvI5TcKIb56R6wi85sy3QiQr7Y8JbM6YJ/6WFiFU949
         GBYRVQUEm1YqdT71e28mjJRAX4O5itQPlMGPZmgp41vh/QCgScvUktDwLsOXQEbZ+j4T
         nFJvUPe0QchTeXcKXCVhtWn7X8IdSjsrJ4TOPLQfJIX9nlQbYa8k9UrjxiEUhbsGt4f0
         UoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751515763; x=1752120563;
        h=content-transfer-encoding:organization:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E7oZ2nGJ36w9gpKLnk8Rg0Ahvs5A2HVmMYpCFJMNvpg=;
        b=j6GpQ5mPlmwoaYZXa2P4kB+02HzyE4IzRXKNxNkkBZSkUJ1TR4VxVNbagb31eJ3mpj
         occEcMfdoX8KVISbu95UcBqM1esNV36W+Olax2SMVp1Rt4y0f8tO1bXgOSPC1VVv5T8F
         e0HBOVJEZg3FxydFm1AsGIvEYjTLjttmxMUGvDNKLbAkROfnv2bwGpvGi+3ykfXO8Q4h
         AthC9tBRBI2o1VvMVR6E8Xu4HS/T4YFQH4xlcLCF3we0Eo/pBk1uPTeZe7zOAkroTYW+
         Gk6q0YR7hQWJTm0Bd1hvu2yYAJcTIihIq2aFuaeM/v+gDc2xbF07hdQph2a5DDuXa2eT
         /zGg==
X-Forwarded-Encrypted: i=1; AJvYcCVBo3qZFHFkzP/i89dPhzxuekWDgktX2pXtgyP8f30GwrNlS4rZ45vhknoOtNUi86IkOlz37Fre590=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/QMWdFvV+HysN8OE1Ar5YfptEPTJKcyZk/8xG0YDRV2bbMn7
	UxUU3/vDce1RuF8vYZAUaeByYj6sW5Bqwpyrpt0FwjG5I20zTnjfbmh83wI+kTG8
X-Gm-Gg: ASbGnctkBnUnrxkL829oF4OrxaawJ29U5j3AAYZOd1MC1mjoiWbDZ3UJ2qlXTAWdrm1
	iUZobrI+7LbfjEm5mAGYVLt3JEC+kVubjuLcillCPPxa1uleDVeO2LNMkQY9EiuTXZC371s6bv5
	9v8+W9gss/+zPWFNpJAnNEmmWjGrg6DJYsPADHJFpsC5OURGwbeh7/5xhMdI3Iv8KLe8DkfAD6d
	f+8rJVxfqkK80iThpmlPYQ79/ndB/QlAJIdG9u6tap5360Rc0jS5vJIkA5+KZodiWf+Rki12wav
	9G/fWaBsGlAsT+nHFXFkKflM9rcFxd3kuosRQfPeUB6cITi0d317T6ZQaW+Phrl7Qn5SnsQntwM
	zvA==
X-Google-Smtp-Source: AGHT+IFLiSNl22XvkqseBreV1mhKaIOx1neiuBepJTSM3LUj6WhkVpV1MvnTeJub6waVlW2EKidWfA==
X-Received: by 2002:ad4:5f8c:0:b0:6e8:fbb7:675b with SMTP id 6a1803df08f44-702b1bdb9bemr86929056d6.32.1751515762498;
        Wed, 02 Jul 2025 21:09:22 -0700 (PDT)
Received: from [10.39.1.36] ([24.156.160.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44321a706sm1044578485a.81.2025.07.02.21.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 21:09:22 -0700 (PDT)
Message-ID: <d10e4b65-463d-492e-b08a-221dba11500d@gmail.com>
Date: Thu, 3 Jul 2025 00:09:20 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alex Huang <huangalex409@gmail.com>
Subject: BUG: ASPM issues with Radeon Pro WX3100
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Language: en-US
Organization: Rust Lang
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Recently, I dug up a Radeon Pro WX3100 and when booting, got a black 
screen with some complaints of No EDID read and then a `Fatal error 
during GPU init`. With windows booting fine and an MSI Kombustor run 
turning out just fine, I would say hardware failure highly unlikely. The 
logs seem unrelated (although I have attached them anyways), lspci 
-vvxxx output for the device is also at the end of the email. Also here 
is lspci -vvxxx for the upstream PCI bridge attached to the GPU.

A bisect reveals the offending commit is 0064b0ce85bb ("drm/amd/pm: 
enable ASPM by default"). The simple fix appears to be setting 
`amdgpu.aspm=0` in kernel boot parameters. This seemingly is a case of 
something in the Lenovo ideacentre (specifically the ideacentre 
510A-15ARR I found this bug on) incorrectly reporting ASPM availability. 
I'd think this is a PCI driver issue, but I am by no means an expert 
here. If this ends up on the wrong mailing list, please do let me know.

I also did try enabling/disabling ASPM on the BIOS side to no avail.

The bug appears to be systematically existent for many other cards I 
ended up plugging into the device (thus conclusion as PCI driver issue). 
And does appear to have an attempt to fix specifically for amdgpu 
(20220408154447.3519453-1-richard.gong@amd.com) but that never went 
upstream.

I could try fixing this bug if it indeed is a PCI driver bug.

Thanks,
Alex H

PS This is my first message around here, please be nice to me :)


------------[ cut here ]------------
WARNING: CPU: 2 PID: 338 at drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c:1089 
uvd_v6_0_ring_insert_nop+0x21/0x120 [amdgpu]
Modules linked in: amdgpu(+) ath10k_pci ath10k_core 
snd_hda_codec_realtek snd_hda_codec_generic ath binfmt_misc 
ledtrig_audio snd_hda_codec_hdmi mac80211 snd>
CPU: 2 PID: 338 Comm: systemd-udevd Not tainted 5.12.0-rc7+ #41
Hardware name: LENOVO 90J00078US/3706, BIOS O4DKT45A 12/06/2022
RIP: 0010:uvd_v6_0_ring_insert_nop+0x21/0x120 [amdgpu]
Code: ff ff 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41 55 41 54 
41 89 f4 53 48 89 fb f6 87 18 02 00 00 01 0f 84 e7 00 00 00 <0f> 0b 41 
d1 ec 0f 84 d5>
RSP: 0018:ffff9c75c192f8e8 EFLAGS: 00010202
RAX: ffffffffc0b86b10 RBX: ffff8f7f3496e8a8 RCX: 0000000000000010
RDX: 000000000000000f RSI: 000000000000000f RDI: ffff8f7f3496e8a8
RBP: ffff9c75c192f900 R08: ffff8f8016a985c0 R09: ffff9c75c192f5e0
R10: 0000000000000001 R11: 0000000000000001 R12: 000000000000000f
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8f7f34960000
FS:  00007f29d89df880(0000) GS:ffff8f8016a80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056359eef7ca0 CR3: 0000000102574000 CR4: 00000000003506e0
Call Trace:
  amdgpu_ring_commit+0x3c/0x70 [amdgpu]
  uvd_v6_0_ring_test_ring+0xfe/0x180 [amdgpu]
  amdgpu_ring_test_helper+0x21/0x80 [amdgpu]
  uvd_v6_0_hw_init+0x9c/0x5b0 [amdgpu]
  amdgpu_device_init.cold+0xff2/0x1b71 [amdgpu]
  ? pci_read_config_word+0x27/0x40
  ? do_pci_enable_device+0xd7/0x100
  amdgpu_driver_load_kms+0x69/0x280 [amdgpu]
  amdgpu_pci_probe+0x12a/0x1b0 [amdgpu]
  local_pci_probe+0x48/0x80
  pci_device_probe+0x10f/0x1c0
  really_probe+0xfb/0x420
  driver_probe_device+0xe9/0x160
  device_driver_attach+0x5d/0x70
  __driver_attach+0x8f/0x150
  ? device_driver_attach+0x70/0x70
  bus_for_each_dev+0x7e/0xc0
  driver_attach+0x1e/0x20
  bus_add_driver+0x152/0x1f0
  driver_register+0x74/0xd0
  __pci_register_driver+0x54/0x60
  amdgpu_init+0x77/0x1000 [amdgpu]
  ? 0xffffffffc108d000
  do_one_initcall+0x48/0x1d0
  ? __cond_resched+0x19/0x30
  ? kmem_cache_alloc_trace+0x390/0x440
  ? do_init_module+0x28/0x260
  do_init_module+0x62/0x260
  load_module+0x2554/0x2770
  __do_sys_finit_module+0xc2/0x120
  ? __do_sys_finit_module+0xc2/0x120
  __x64_sys_finit_module+0x1a/0x20
  do_syscall_64+0x38/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f29d900b95d
Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 
f0 ff ff 73 01>
RSP: 002b:00007fff56f4a6a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000055abfb17d7a0 RCX: 00007f29d900b95d
RDX: 0000000000000000 RSI: 00007f29d8eebded RDI: 0000000000000018
RBP: 0000000000020000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000018 R11: 0000000000000246 R12: 00007f29d8eebded
R13: 0000000000000000 R14: 000055abfb182d90 R15: 000055abfb17d7a0
---[ end trace 5b8e539d0503ff82 ]---
amdgpu 0000:01:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring 
uvd test failed (-110)
[drm:amdgpu_device_init.cold [amdgpu]] *ERROR* hw_init of IP block 
<uvd_v6_0> failed -110
amdgpu 0000:01:00.0: amdgpu: amdgpu_device_ip_init failed
amdgpu 0000:01:00.0: amdgpu: Fatal error during GPU init
------------[ cut here ]------------

00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 PCIe 
GPP Bridge [6:0] (prog-if 00 [Normal decode])
         Subsystem: Lenovo Raven/Raven2 PCIe GPP Bridge [6:0]
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Interrupt: pin ? routed to IRQ 26
         IOMMU group: 1
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: f000-ffff [size=4K] [16-bit]
         Memory behind bridge: fce00000-fcefffff [size=1M] [32-bit]
         Prefetchable memory behind bridge: e0000000-f01fffff 
[size=258M] [32-bit]
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA+ VGA16+ MAbort- >Reset- 
FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [50] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
                 DevCap: MaxPayload 512 bytes, PhantFunc 0
                         ExtTag+ RBE+
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 256 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- 
AuxPwr- TransPend-
                 LnkCap: Port #0, Speed 8GT/s, Width x8, ASPM L1, Exit 
Latency L1 <64us
                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 8GT/s, Width x8
                         TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt+
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- 
HotPlug- Surprise-
                         Slot #0, PowerLimit 0W; Interlock- NoCompl+
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
                         Control: AttnInd Unknown, PwrInd Unknown, 
Power- Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- 
PresDet+ Interlock-
                         Changed: MRL- PresDet- LinkState+
                 RootCap: CRSVisible+
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- 
PMEIntEna+ CRSVisible+
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ 
NROPrPrP- LTR+
                          10BitTagComp- 10BitTagReq- OBFF Not Supported, 
ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
                          EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
                          FRS- LN System CLS Not Supported, TPHComp- 
ExtTPHComp- ARIFwd+
                          AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS-
                 DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- 
LTR- 10BitTagReq- OBFF Disabled, ARIFwd+
                          AtomicOpsCtl: ReqEn- EgressBlck-
                 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- 
Retimer- 2Retimers- DRS-
                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- 
SpeedDis-
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance Preset/De-emphasis: -6dB 
de-emphasis, 0dB preshoot
                 LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete+ EqualizationPhase1+
                          EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
                          Retimer- 2Retimers- CrosslinkRes: unsupported
         Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
                 Address: 00000000fee00000  Data: 0000
         Capabilities: [c0] Subsystem: Lenovo Raven/Raven2 PCIe GPP 
Bridge [6:0]
         Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
         Capabilities: [100 v1] Vendor Specific Information: ID=0001 
Rev=1 Len=010 <?>
         Capabilities: [150 v2] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
                 AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- 
ECRCChkCap- ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
                 RootCmd: CERptEn+ NFERptEn+ FERptEn+
                 RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
                          FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
                 ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
         Capabilities: [270 v1] Secondary PCI Express
                 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
                 LaneErrStat: 0
         Capabilities: [2a0 v1] Access Control Services
                 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans+
                 ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
         Capabilities: [370 v1] L1 PM Substates
                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ 
ASPM_L1.1+ L1_PM_Substates+
                           PortCommonModeRestoreTime=0us 
PortTPowerOnTime=10us
                 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+
                            T_CommonMode=0us LTR1.2_Threshold=176128ns
                 L1SubCtl2: T_PwrOn=170us
         Kernel driver in use: pcieport
00: 22 10 d3 15 07 04 10 00 00 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f1 f1 00 20
20: e0 fc e0 fc 01 e0 11 f0 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 1a 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 58 03 c8 00 00 00 00 10 a0 42 01 22 80 00 00
60: 3f 29 00 00 83 78 73 00 42 00 83 f0 00 00 04 00
70: 00 00 40 01 18 00 01 00 00 00 00 00 bf 09 70 00
80: 26 00 00 00 0e 00 00 00 03 00 1f 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 05 c0 81 00 00 00 e0 fe 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 0d c8 00 00 aa 17 06 37 08 00 03 a8 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. 
[AMD/ATI] Lexa XT [Radeon PRO WX 3100] (prog-if 00 [VGA controller])
         Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Lexa XT 
[Radeon PRO WX 3100]
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Interrupt: pin A routed to IRQ 49
         IOMMU group: 7
         Region 0: Memory at e0000000 (64-bit, prefetchable) [size=256M]
         Region 2: Memory at f0000000 (64-bit, prefetchable) [size=2M]
         Region 4: I/O ports at f000 [size=256]
         Region 5: Memory at fce00000 (32-bit, non-prefetchable) [size=256K]
         Expansion ROM at 000c0000 [disabled] [size=128K]
         Capabilities: [48] Vendor Specific Information: Len=08 <?>
         Capabilities: [50] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
<4us, L1 unlimited
                         ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 256 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr+ NonFatalErr+ FatalErr- UnsupReq+ 
AuxPwr- TransPend-
                 LnkCap: Port #0, Speed 8GT/s, Width x8, ASPM L1, Exit 
Latency L1 <1us
                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 8GT/s, Width x8
                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
                          10BitTagComp- 10BitTagReq- OBFF Not Supported, 
ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
                          EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
                          FRS-
                          AtomicOpsCap: 32bit+ 64bit+ 128bitCAS-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- 
LTR- 10BitTagReq- OBFF Disabled,
                          AtomicOpsCtl: ReqEn+
                 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- 
Retimer- 2Retimers- DRS-
                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- 
SpeedDis-
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance Preset/De-emphasis: -6dB 
de-emphasis, 0dB preshoot
                 LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete+ EqualizationPhase1+
                          EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
                          Retimer- 2Retimers- CrosslinkRes: unsupported
         Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
                 Address: 00000000fee00000  Data: 0000
         Capabilities: [100 v1] Vendor Specific Information: ID=0001 
Rev=1 Len=010 <?>
         Capabilities: [150 v2] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
                 AERCap: First Error Pointer: 14, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 40001001 0000000f 000a0000 00000000
         Capabilities: [200 v1] Physical Resizable BAR
                 BAR 0: current size: 256MB, supported: 256MB 512MB 1GB 
2GB 4GB
         Capabilities: [270 v1] Secondary PCI Express
                 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
                 LaneErrStat: 0
         Capabilities: [2b0 v1] Address Translation Service (ATS)
                 ATSCap: Invalidate Queue Depth: 00
                 ATSCtl: Enable+, Smallest Translation Unit: 00
         Capabilities: [2c0 v1] Page Request Interface (PRI)
                 PRICtl: Enable+ Reset-
                 PRISta: RF- UPRGI- Stopped+
                 Page Request Capacity: 00000020, Page Request 
Allocation: 00000020
         Capabilities: [2d0 v1] Process Address Space ID (PASID)
                 PASIDCap: Exec+ Priv+, Max PASID Width: 10
                 PASIDCtl: Enable- Exec- Priv-
         Capabilities: [320 v1] Latency Tolerance Reporting
                 Max snoop latency: 0ns
                 Max no snoop latency: 0ns
         Capabilities: [328 v1] Alternative Routing-ID Interpretation (ARI)
                 ARICap: MFVC- ACS-, Next Function: 1
                 ARICtl: MFVC- ACS-, Function Group: 0
         Capabilities: [370 v1] L1 PM Substates
                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ 
ASPM_L1.1+ L1_PM_Substates+
                           PortCommonModeRestoreTime=0us 
PortTPowerOnTime=170us
                 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+
                            T_CommonMode=0us LTR1.2_Threshold=176128ns
                 L1SubCtl2: T_PwrOn=170us
         Kernel driver in use: amdgpu
         Kernel modules: amdgpu
00: 02 10 85 69 07 04 10 00 00 00 00 03 10 00 80 00
10: 0c 00 00 e0 00 00 00 00 0c 00 00 f0 00 00 00 00
20: 01 f0 00 00 00 00 e0 fc 00 00 00 00 02 10 0c 0b
30: 00 00 e4 fc 48 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 00 00 00 00 09 50 08 00 02 10 0c 0b
50: 01 58 03 f6 08 00 00 00 10 a0 12 00 a1 8f 00 00
60: 3f 29 0b 00 83 08 44 00 42 00 83 10 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 80 09 70 00
80: 40 00 00 00 0e 00 00 00 03 00 1f 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 05 00 81 00 00 00 e0 fe 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

