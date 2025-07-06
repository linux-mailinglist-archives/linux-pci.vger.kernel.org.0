Return-Path: <linux-pci+bounces-31573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 123ACAFA2C5
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jul 2025 04:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B681898B08
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jul 2025 02:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6409615746E;
	Sun,  6 Jul 2025 02:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGkjqvja"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB081F61C;
	Sun,  6 Jul 2025 02:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751769853; cv=none; b=Pcy3OlFwQqw36H/Gim/WloyoypXqm7WYageCFYW/wNCT5K2N9sdJQdYaBAMLAj0Gznvkza+PiO3gvkSHvAvpkgAwgnmGO6ZTwR+Gc3OINNnuybDWQS7ySjk7YbFyjm9GRucJLq9savZvznvTcIe8eH809Nr6O0ySHYdJ1CJkK6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751769853; c=relaxed/simple;
	bh=kPhPxO6CQAAjkhi9+7ztpHTZxEeBvMwyP2GxFayShh4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=H7pBLvdTkuPVwbZ0D4PZZEFRWOPQrFKh/lnrHwk4oqrYOJ1R0whkyGwF7+QaGEoLYBMBxI06T+6qaZajPPddhCK7Vp/wvBdzeySEukQD9uaENLRgEkWqnTx/vgrIpuOVRuRijwUcE4zX78O+0SszVQGOnV2O6lfDEowLYeAJRjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGkjqvja; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fae04a3795so25350326d6.3;
        Sat, 05 Jul 2025 19:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751769847; x=1752374647; darn=vger.kernel.org;
        h=in-reply-to:content-language:organization:from:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hr9eZVG8+QL4b3xpkOsBCeTS/d4UoFeaVFb96HD7Ryk=;
        b=FGkjqvjaECg07f5kO/pDCFsyt/TMC2jn1wCREGOvK0A6zncLTDOu2oSohUz6YrEtXQ
         8mLe+uOLLD4YFAojJmqJLhukAdil3/wafjWhTFmhjYXEi5YOd9nuKo5oN9OmCxAyi6s9
         PBSrViRu5/pHSJ5tN8x1ITHYmO3jkQ3GrnMfBts1PwCso1tbIsOav3fVzDvvyJgYIpv7
         8p92nxeIcxw4wOn1BjhqL22HQiaJdjuZg1QaboinDgc9aha0RkhFw71UDIiPMiGygYIn
         tx/I9MRpnHD5JzTfVwX4FU1Ue1XrswP5/5lQBAQAJmfdlkpW51elIXyafgWLUdsgMsuc
         fVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751769847; x=1752374647;
        h=in-reply-to:content-language:organization:from:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hr9eZVG8+QL4b3xpkOsBCeTS/d4UoFeaVFb96HD7Ryk=;
        b=tO2Hdqxo+b6CmEmwy28sTC8uQkROKNC05yTBOXDD0m6e6iLBxQR1XAs/bTAd0wDq1y
         qZUBsVeq+9cazosrs0ixeBT7h/OcZNsYEHStvV/9UMhgIaEySYhpua+2TIkbEWCArHB8
         HzFzm/29FNX7e/1tKWlWzgOD3D0HUJfkMjOfCU/g0jD8H5wUWgOGKbVeyomfhxjPnHGi
         HXDu2cYwn5fCps/UYdxQ5FbDVzlFfxbBVnWS8FeMQRSGrS+dbxxW9iu7+CCM1/wJnF2t
         3HT54kNGFBVScQhmf8FHurKMZFts7thdLpW2LqMBP742oBt1Q2kG3RxTUXhgZEhjZnwj
         A8/w==
X-Forwarded-Encrypted: i=1; AJvYcCUgJw0KrK+vOaJp9PYB3Sswc8JZp2YvwbRtTRINq9DiYXlNt/2MgDhEXNUoI0lzU0npe/HRgaxvLvqI@vger.kernel.org, AJvYcCVIaIY/DRjKjjtKrWXOcY2Jz3Df8U1ixKD7SPjsjA0NVg2/gU0yGxJMaLCQzi7bVxGtn3w7eZROXdtcLFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFupM5a5+EuHC7VNGj8+p1gY26SMXxqU1AQFpRMyZDxrvuffuc
	rK5NguSyToDLGPg4GaqrgrwnMdW4NVjwh+m3XQbREdYN+Wb8wQOO2Vg1
X-Gm-Gg: ASbGncvhuwFMTQLW3QJJkEsiWrPL46KHWrHrR9wwYs7LpL9NkI1mFm8nhrH77k3it4O
	4ox3lmIqRQkXp/1+a7QXcFIoDgi8xHQfP7gMnvVIQMICr2geBJibRo1sZE4gNHAv5uWn6pJZAzD
	5kPVltRZ9+HOADvKhKaN4yY0dwoeTARceUeN9+64HBww7KVduGwMztcWOpj2Ad44tiSOV8JTj7d
	2PKrwi+TCGUjcMIKETPeOTTnYoitZyfr/5iN67RYrDK63DsLPBe3tlWfpkCvwr/jh+5UCXHrQg+
	XmFl24v+SI6qDt0O33jhFqVQAOIvKkm/BRASbXElMdwvGodwD3Sv+P+75QiusFJKjk8=
X-Google-Smtp-Source: AGHT+IGbYxBHvxh4k2TXQFCQ5qZ4BelYd0nd+aHyRarRCw2C14eyRyZPMV9RnylAFcIG064FcB5gTA==
X-Received: by 2002:a05:6214:3c8b:b0:6fa:bd77:3501 with SMTP id 6a1803df08f44-702d169581amr57275876d6.11.1751769846959;
        Sat, 05 Jul 2025 19:44:06 -0700 (PDT)
Received: from [10.39.1.36] ([24.156.160.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4cccdb4sm37504506d6.46.2025.07.05.19.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jul 2025 19:44:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------WjLRXBtIUKtP7gW328uhL0S5"
Message-ID: <e03b119d-4a27-45a0-8058-3ac7fbee23c7@gmail.com>
Date: Sat, 5 Jul 2025 22:44:03 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: ASPM issues with Radeon Pro WX3100
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250705134201.GA2004436@bhelgaas>
From: Alex Huang <huangalex409@gmail.com>
Organization: Rust Lang
Content-Language: en-CA, en-CA-large
In-Reply-To: <20250705134201.GA2004436@bhelgaas>

This is a multi-part message in MIME format.
--------------WjLRXBtIUKtP7gW328uhL0S5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bjorn,

I have compiled and run a v6.16-rc4 kernel with the patch. The output messages
from journalctl up to systemd loading is attached.

Regards,
Alex H

On 2025-07-05 09:42, Bjorn Helgaas wrote:

> [+cc Kenneth, Alex, Christian, amd-gfx]
>
> On Thu, Jul 03, 2025 at 12:09:20AM -0400, Alex Huang wrote:
>> Hi,
>>
>> Recently, I dug up a Radeon Pro WX3100 and when booting, got a black screen
>> with some complaints of No EDID read and then a `Fatal error during GPU
>> init`. With windows booting fine and an MSI Kombustor run turning out just
>> fine, I would say hardware failure highly unlikely. The logs seem unrelated
>> (although I have attached them anyways), lspci -vvxxx output for the device
>> is also at the end of the email. Also here is lspci -vvxxx for the upstream
>> PCI bridge attached to the GPU.
>>
>> A bisect reveals the offending commit is 0064b0ce85bb ("drm/amd/pm: enable
>> ASPM by default"). The simple fix appears to be setting `amdgpu.aspm=0` in
>> kernel boot parameters. This seemingly is a case of something in the Lenovo
>> ideacentre (specifically the ideacentre 510A-15ARR I found this bug on)
>> incorrectly reporting ASPM availability. I'd think this is a PCI driver
>> issue, but I am by no means an expert here. If this ends up on the wrong
>> mailing list, please do let me know.
>>
>> I also did try enabling/disabling ASPM on the BIOS side to no avail.
>>
>> The bug appears to be systematically existent for many other cards I ended
>> up plugging into the device (thus conclusion as PCI driver issue). And does
>> appear to have an attempt to fix specifically for amdgpu
>> (20220408154447.3519453-1-richard.gong@amd.com) but that never went
>> upstream.
> Hi Alex, thanks very much for reporting and bisecting this issue.  I
> added the author of 0064b0ce85bb and the maintainers of amdgpu.
>
>  From your lspci output, it looks like ASPM L1.2 is enabled for this
> device, and we do have a known PCI core issue with L1.2.  Linux tries
> to configure L1.2 but doesn't have enough information to do it
> correctly.  We don't have a good fix for this yet, but you could try
> the debug patch from here:
>
>    https://lore.kernel.org/r/20250418225527.GA169820@bhelgaas
>
> That patch is based on v6.15-rc1, and it looks like you're running a
> v5.12 kernel, so it likely won't apply directly, but you may be able
> to try a newer kernel or adapt the patch to your v5.12 kernel.
>
> If you do try this out, please collect the complete dmesg log.
>
> Bjorn
>
>> ------------[ cut here ]------------
>> WARNING: CPU: 2 PID: 338 at drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c:1089
>> uvd_v6_0_ring_insert_nop+0x21/0x120 [amdgpu]
>> Modules linked in: amdgpu(+) ath10k_pci ath10k_core snd_hda_codec_realtek
>> snd_hda_codec_generic ath binfmt_misc ledtrig_audio snd_hda_codec_hdmi
>> mac80211 snd>
>> CPU: 2 PID: 338 Comm: systemd-udevd Not tainted 5.12.0-rc7+ #41
>> Hardware name: LENOVO 90J00078US/3706, BIOS O4DKT45A 12/06/2022
>> RIP: 0010:uvd_v6_0_ring_insert_nop+0x21/0x120 [amdgpu]
>> Code: ff ff 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41 55 41 54 41
>> 89 f4 53 48 89 fb f6 87 18 02 00 00 01 0f 84 e7 00 00 00 <0f> 0b 41 d1 ec 0f
>> 84 d5>
>> RSP: 0018:ffff9c75c192f8e8 EFLAGS: 00010202
>> RAX: ffffffffc0b86b10 RBX: ffff8f7f3496e8a8 RCX: 0000000000000010
>> RDX: 000000000000000f RSI: 000000000000000f RDI: ffff8f7f3496e8a8
>> RBP: ffff9c75c192f900 R08: ffff8f8016a985c0 R09: ffff9c75c192f5e0
>> R10: 0000000000000001 R11: 0000000000000001 R12: 000000000000000f
>> R13: 0000000000000000 R14: 0000000000000000 R15: ffff8f7f34960000
>> FS:  00007f29d89df880(0000) GS:ffff8f8016a80000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000056359eef7ca0 CR3: 0000000102574000 CR4: 00000000003506e0
>> Call Trace:
>>   amdgpu_ring_commit+0x3c/0x70 [amdgpu]
>>   uvd_v6_0_ring_test_ring+0xfe/0x180 [amdgpu]
>>   amdgpu_ring_test_helper+0x21/0x80 [amdgpu]
>>   uvd_v6_0_hw_init+0x9c/0x5b0 [amdgpu]
>>   amdgpu_device_init.cold+0xff2/0x1b71 [amdgpu]
>>   ? pci_read_config_word+0x27/0x40
>>   ? do_pci_enable_device+0xd7/0x100
>>   amdgpu_driver_load_kms+0x69/0x280 [amdgpu]
>>   amdgpu_pci_probe+0x12a/0x1b0 [amdgpu]
>>   local_pci_probe+0x48/0x80
>>   pci_device_probe+0x10f/0x1c0
>>   really_probe+0xfb/0x420
>>   driver_probe_device+0xe9/0x160
>>   device_driver_attach+0x5d/0x70
>>   __driver_attach+0x8f/0x150
>>   ? device_driver_attach+0x70/0x70
>>   bus_for_each_dev+0x7e/0xc0
>>   driver_attach+0x1e/0x20
>>   bus_add_driver+0x152/0x1f0
>>   driver_register+0x74/0xd0
>>   __pci_register_driver+0x54/0x60
>>   amdgpu_init+0x77/0x1000 [amdgpu]
>>   ? 0xffffffffc108d000
>>   do_one_initcall+0x48/0x1d0
>>   ? __cond_resched+0x19/0x30
>>   ? kmem_cache_alloc_trace+0x390/0x440
>>   ? do_init_module+0x28/0x260
>>   do_init_module+0x62/0x260
>>   load_module+0x2554/0x2770
>>   __do_sys_finit_module+0xc2/0x120
>>   ? __do_sys_finit_module+0xc2/0x120
>>   __x64_sys_finit_module+0x1a/0x20
>>   do_syscall_64+0x38/0x90
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>> RIP: 0033:0x7f29d900b95d
>> Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7
>> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
>> 73 01>
>> RSP: 002b:00007fff56f4a6a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
>> RAX: ffffffffffffffda RBX: 000055abfb17d7a0 RCX: 00007f29d900b95d
>> RDX: 0000000000000000 RSI: 00007f29d8eebded RDI: 0000000000000018
>> RBP: 0000000000020000 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000018 R11: 0000000000000246 R12: 00007f29d8eebded
>> R13: 0000000000000000 R14: 000055abfb182d90 R15: 000055abfb17d7a0
>> ---[ end trace 5b8e539d0503ff82 ]---
>> amdgpu 0000:01:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring uvd
>> test failed (-110)
>> [drm:amdgpu_device_init.cold [amdgpu]] *ERROR* hw_init of IP block
>> <uvd_v6_0> failed -110
>> amdgpu 0000:01:00.0: amdgpu: amdgpu_device_ip_init failed
>> amdgpu 0000:01:00.0: amdgpu: Fatal error during GPU init
>> ------------[ cut here ]------------
>>
>> 00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 PCIe GPP
>> Bridge [6:0] (prog-if 00 [Normal decode])
>>          Subsystem: Lenovo Raven/Raven2 PCIe GPP Bridge [6:0]
>>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx+
>>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>          Latency: 0, Cache Line Size: 64 bytes
>>          Interrupt: pin ? routed to IRQ 26
>>          IOMMU group: 1
>>          Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>>          I/O behind bridge: f000-ffff [size=4K] [16-bit]
>>          Memory behind bridge: fce00000-fcefffff [size=1M] [32-bit]
>>          Prefetchable memory behind bridge: e0000000-f01fffff [size=258M]
>> [32-bit]
>>          Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
>> <TAbort- <MAbort+ <SERR- <PERR-
>>          BridgeCtl: Parity- SERR+ NoISA- VGA+ VGA16+ MAbort- >Reset- FastB2B-
>>                  PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>          Capabilities: [50] Power Management version 3
>>                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>                  Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>          Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
>>                  DevCap: MaxPayload 512 bytes, PhantFunc 0
>>                          ExtTag+ RBE+
>>                  DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>>                          RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>>                          MaxPayload 256 bytes, MaxReadReq 512 bytes
>>                  DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
>> TransPend-
>>                  LnkCap: Port #0, Speed 8GT/s, Width x8, ASPM L1, Exit
>> Latency L1 <64us
>>                          ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
>>                  LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
>>                          ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>                  LnkSta: Speed 8GT/s, Width x8
>>                          TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt+
>>                  SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
>> Surprise-
>>                          Slot #0, PowerLimit 0W; Interlock- NoCompl+
>>                  SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
>> HPIrq- LinkChg-
>>                          Control: AttnInd Unknown, PwrInd Unknown, Power-
>> Interlock-
>>                  SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
>> Interlock-
>>                          Changed: MRL- PresDet- LinkState+
>>                  RootCap: CRSVisible+
>>                  RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
>> CRSVisible+
>>                  RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>                  DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
>> NROPrPrP- LTR+
>>                           10BitTagComp- 10BitTagReq- OBFF Not Supported,
>> ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
>>                           EmergencyPowerReduction Not Supported,
>> EmergencyPowerReductionInit-
>>                           FRS- LN System CLS Not Supported, TPHComp-
>> ExtTPHComp- ARIFwd+
>>                           AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS-
>>                  DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- LTR-
>> 10BitTagReq- OBFF Disabled, ARIFwd+
>>                           AtomicOpsCtl: ReqEn- EgressBlck-
>>                  LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink-
>> Retimer- 2Retimers- DRS-
>>                  LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance-
>> SpeedDis-
>>                           Transmit Margin: Normal Operating Range,
>> EnterModifiedCompliance- ComplianceSOS-
>>                           Compliance Preset/De-emphasis: -6dB de-emphasis,
>> 0dB preshoot
>>                  LnkSta2: Current De-emphasis Level: -3.5dB,
>> EqualizationComplete+ EqualizationPhase1+
>>                           EqualizationPhase2+ EqualizationPhase3+
>> LinkEqualizationRequest-
>>                           Retimer- 2Retimers- CrosslinkRes: unsupported
>>          Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>                  Address: 00000000fee00000  Data: 0000
>>          Capabilities: [c0] Subsystem: Lenovo Raven/Raven2 PCIe GPP Bridge
>> [6:0]
>>          Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
>>          Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
>> Len=010 <?>
>>          Capabilities: [150 v2] Advanced Error Reporting
>>                  UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>                  UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>                  UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
>> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>>                  CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
>> AdvNonFatalErr-
>>                  CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
>> AdvNonFatalErr+
>>                  AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
>> ECRCChkCap- ECRCChkEn-
>>                          MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>>                  HeaderLog: 00000000 00000000 00000000 00000000
>>                  RootCmd: CERptEn+ NFERptEn+ FERptEn+
>>                  RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>>                           FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
>>                  ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
>>          Capabilities: [270 v1] Secondary PCI Express
>>                  LnkCtl3: LnkEquIntrruptEn- PerformEqu-
>>                  LaneErrStat: 0
>>          Capabilities: [2a0 v1] Access Control Services
>>                  ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
>> UpstreamFwd+ EgressCtrl- DirectTrans+
>>                  ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+
>> UpstreamFwd+ EgressCtrl- DirectTrans-
>>          Capabilities: [370 v1] L1 PM Substates
>>                  L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>> L1_PM_Substates+
>>                            PortCommonModeRestoreTime=0us
>> PortTPowerOnTime=10us
>>                  L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+
>>                             T_CommonMode=0us LTR1.2_Threshold=176128ns
>>                  L1SubCtl2: T_PwrOn=170us
>>          Kernel driver in use: pcieport
>> 00: 22 10 d3 15 07 04 10 00 00 00 04 06 10 00 81 00
>> 10: 00 00 00 00 00 00 00 00 00 01 01 00 f1 f1 00 20
>> 20: e0 fc e0 fc 01 e0 11 f0 00 00 00 00 00 00 00 00
>> 30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 1a 00
>> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 50: 01 58 03 c8 00 00 00 00 10 a0 42 01 22 80 00 00
>> 60: 3f 29 00 00 83 78 73 00 42 00 83 f0 00 00 04 00
>> 70: 00 00 40 01 18 00 01 00 00 00 00 00 bf 09 70 00
>> 80: 26 00 00 00 0e 00 00 00 03 00 1f 00 00 00 00 00
>> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> a0: 05 c0 81 00 00 00 e0 fe 00 00 00 00 00 00 00 00
>> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> c0: 0d c8 00 00 aa 17 06 37 08 00 03 a8 00 00 00 00
>> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>
>> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
>> Lexa XT [Radeon PRO WX 3100] (prog-if 00 [VGA controller])
>>          Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Lexa XT [Radeon
>> PRO WX 3100]
>>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx+
>>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>          Latency: 0, Cache Line Size: 64 bytes
>>          Interrupt: pin A routed to IRQ 49
>>          IOMMU group: 7
>>          Region 0: Memory at e0000000 (64-bit, prefetchable) [size=256M]
>>          Region 2: Memory at f0000000 (64-bit, prefetchable) [size=2M]
>>          Region 4: I/O ports at f000 [size=256]
>>          Region 5: Memory at fce00000 (32-bit, non-prefetchable) [size=256K]
>>          Expansion ROM at 000c0000 [disabled] [size=128K]
>>          Capabilities: [48] Vendor Specific Information: Len=08 <?>
>>          Capabilities: [50] Power Management version 3
>>                  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
>> PME(D0-,D1+,D2+,D3hot+,D3cold+)
>>                  Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>>          Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
>>                  DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us,
>> L1 unlimited
>>                          ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>>                  DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>>                          RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>>                          MaxPayload 256 bytes, MaxReadReq 512 bytes
>>                  DevSta: CorrErr+ NonFatalErr+ FatalErr- UnsupReq+ AuxPwr-
>> TransPend-
>>                  LnkCap: Port #0, Speed 8GT/s, Width x8, ASPM L1, Exit
>> Latency L1 <1us
>>                          ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>>                  LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
>>                          ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>                  LnkSta: Speed 8GT/s, Width x8
>>                          TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>>                  DevCap2: Completion Timeout: Not Supported, TimeoutDis-
>> NROPrPrP- LTR+
>>                           10BitTagComp- 10BitTagReq- OBFF Not Supported,
>> ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
>>                           EmergencyPowerReduction Not Supported,
>> EmergencyPowerReductionInit-
>>                           FRS-
>>                           AtomicOpsCap: 32bit+ 64bit+ 128bitCAS-
>>                  DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
>> 10BitTagReq- OBFF Disabled,
>>                           AtomicOpsCtl: ReqEn+
>>                  LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink-
>> Retimer- 2Retimers- DRS-
>>                  LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance-
>> SpeedDis-
>>                           Transmit Margin: Normal Operating Range,
>> EnterModifiedCompliance- ComplianceSOS-
>>                           Compliance Preset/De-emphasis: -6dB de-emphasis,
>> 0dB preshoot
>>                  LnkSta2: Current De-emphasis Level: -3.5dB,
>> EqualizationComplete+ EqualizationPhase1+
>>                           EqualizationPhase2+ EqualizationPhase3+
>> LinkEqualizationRequest-
>>                           Retimer- 2Retimers- CrosslinkRes: unsupported
>>          Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>                  Address: 00000000fee00000  Data: 0000
>>          Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
>> Len=010 <?>
>>          Capabilities: [150 v2] Advanced Error Reporting
>>                  UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>                  UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>                  UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
>> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>>                  CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
>> AdvNonFatalErr-
>>                  CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
>> AdvNonFatalErr+
>>                  AERCap: First Error Pointer: 14, ECRCGenCap+ ECRCGenEn-
>> ECRCChkCap+ ECRCChkEn-
>>                          MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>>                  HeaderLog: 40001001 0000000f 000a0000 00000000
>>          Capabilities: [200 v1] Physical Resizable BAR
>>                  BAR 0: current size: 256MB, supported: 256MB 512MB 1GB 2GB
>> 4GB
>>          Capabilities: [270 v1] Secondary PCI Express
>>                  LnkCtl3: LnkEquIntrruptEn- PerformEqu-
>>                  LaneErrStat: 0
>>          Capabilities: [2b0 v1] Address Translation Service (ATS)
>>                  ATSCap: Invalidate Queue Depth: 00
>>                  ATSCtl: Enable+, Smallest Translation Unit: 00
>>          Capabilities: [2c0 v1] Page Request Interface (PRI)
>>                  PRICtl: Enable+ Reset-
>>                  PRISta: RF- UPRGI- Stopped+
>>                  Page Request Capacity: 00000020, Page Request Allocation:
>> 00000020
>>          Capabilities: [2d0 v1] Process Address Space ID (PASID)
>>                  PASIDCap: Exec+ Priv+, Max PASID Width: 10
>>                  PASIDCtl: Enable- Exec- Priv-
>>          Capabilities: [320 v1] Latency Tolerance Reporting
>>                  Max snoop latency: 0ns
>>                  Max no snoop latency: 0ns
>>          Capabilities: [328 v1] Alternative Routing-ID Interpretation (ARI)
>>                  ARICap: MFVC- ACS-, Next Function: 1
>>                  ARICtl: MFVC- ACS-, Function Group: 0
>>          Capabilities: [370 v1] L1 PM Substates
>>                  L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>> L1_PM_Substates+
>>                            PortCommonModeRestoreTime=0us
>> PortTPowerOnTime=170us
>>                  L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+
>>                             T_CommonMode=0us LTR1.2_Threshold=176128ns
>>                  L1SubCtl2: T_PwrOn=170us
>>          Kernel driver in use: amdgpu
>>          Kernel modules: amdgpu
>> 00: 02 10 85 69 07 04 10 00 00 00 00 03 10 00 80 00
>> 10: 0c 00 00 e0 00 00 00 00 0c 00 00 f0 00 00 00 00
>> 20: 01 f0 00 00 00 00 e0 fc 00 00 00 00 02 10 0c 0b
>> 30: 00 00 e4 fc 48 00 00 00 00 00 00 00 0b 01 00 00
>> 40: 00 00 00 00 00 00 00 00 09 50 08 00 02 10 0c 0b
>> 50: 01 58 03 f6 08 00 00 00 10 a0 12 00 a1 8f 00 00
>> 60: 3f 29 0b 00 83 08 44 00 42 00 83 10 00 00 00 00
>> 70: 00 00 00 00 00 00 00 00 00 00 00 00 80 09 70 00
>> 80: 40 00 00 00 0e 00 00 00 03 00 1f 00 00 00 00 00
>> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> a0: 05 00 81 00 00 00 e0 fe 00 00 00 00 00 00 00 00
>> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

-- 
Alex Huang | Bootstrap team @ Rust Lang
Email: huangalex409@gmail.com
Cell: (647)-580-8234

--------------WjLRXBtIUKtP7gW328uhL0S5
Content-Type: text/plain; charset=UTF-8; name="journal.txt"
Content-Disposition: attachment; filename="journal.txt"
Content-Transfer-Encoding: base64

a2VybmVsOiBMaW51eCB2ZXJzaW9uIDYuMTYuMC1yYzQrIChyb290QHRlYXBvdC1pZGVhY2Vu
dHJlLTUxMEEtMTVBUlIpIChnY2MgKFVidW50dSAxMy4zLjAtNnVidW50dTJ+MjQuMDQpIDEz
LjMuMCwgR05VIGxkIChHTlUgQmludXRpbHMgZm9yIFVidW50dSkgMi40MikgIzQgU01QIFBS
RUVNUFRfRFlOQU1JQyBTYXQgSnVsICA1IDE2OjM3OjQzIEVEVCAyMDI1Cmtlcm5lbDogQ29t
bWFuZCBsaW5lOiBCT09UX0lNQUdFPS9ib290L3ZtbGludXotNi4xNi4wLXJjNCsgcm9vdD1V
VUlEPWYyMjVlNzE1LTBlNDYtNGFmOS1hZTAyLTlmNzA0YTc4NDJmYSBybyBxdWlldCBzcGxh
c2ggYW1kZ3B1LmFzcG09MCB2dC5oYW5kb2ZmPTcKa2VybmVsOiBLRVJORUwgc3VwcG9ydGVk
IGNwdXM6Cmtlcm5lbDogICBJbnRlbCBHZW51aW5lSW50ZWwKa2VybmVsOiAgIEFNRCBBdXRo
ZW50aWNBTUQKa2VybmVsOiAgIEh5Z29uIEh5Z29uR2VudWluZQprZXJuZWw6ICAgQ2VudGF1
ciBDZW50YXVySGF1bHMKa2VybmVsOiAgIHpoYW94aW4gICBTaGFuZ2hhaQprZXJuZWw6IEJJ
T1MtcHJvdmlkZWQgcGh5c2ljYWwgUkFNIG1hcDoKa2VybmVsOiBCSU9TLWU4MjA6IFttZW0g
MHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAwMDAwMDAwMDA5ZmZmZl0gdXNhYmxlCmtlcm5lbDog
QklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDAwMDBhMDAwMC0weDAwMDAwMDAwMDAwZmZmZmZd
IHJlc2VydmVkCmtlcm5lbDogQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDAwMDEwMDAwMC0w
eDAwMDAwMDAwMDljZmZmZmZdIHVzYWJsZQprZXJuZWw6IEJJT1MtZTgyMDogW21lbSAweDAw
MDAwMDAwMDlkMDAwMDAtMHgwMDAwMDAwMDA5ZmZmZmZmXSByZXNlcnZlZAprZXJuZWw6IEJJ
T1MtZTgyMDogW21lbSAweDAwMDAwMDAwMGEwMDAwMDAtMHgwMDAwMDAwMDBhMWZmZmZmXSB1
c2FibGUKa2VybmVsOiBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDBhMjAwMDAwLTB4MDAw
MDAwMDAwYTIwYWZmZl0gQUNQSSBOVlMKa2VybmVsOiBCSU9TLWU4MjA6IFttZW0gMHgwMDAw
MDAwMDBhMjBiMDAwLTB4MDAwMDAwMDBkYTVjNGZmZl0gdXNhYmxlCmtlcm5lbDogQklPUy1l
ODIwOiBbbWVtIDB4MDAwMDAwMDBkYTVjNTAwMC0weDAwMDAwMDAwZGJhOTlmZmZdIHJlc2Vy
dmVkCmtlcm5lbDogQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDBkYmE5YTAwMC0weDAwMDAw
MDAwZGJiMjBmZmZdIEFDUEkgZGF0YQprZXJuZWw6IEJJT1MtZTgyMDogW21lbSAweDAwMDAw
MDAwZGJiMjEwMDAtMHgwMDAwMDAwMGRiZmYwZmZmXSBBQ1BJIE5WUwprZXJuZWw6IEJJT1Mt
ZTgyMDogW21lbSAweDAwMDAwMDAwZGJmZjEwMDAtMHgwMDAwMDAwMGRjODc4ZmZmXSByZXNl
cnZlZAprZXJuZWw6IEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwZGM4NzkwMDAtMHgwMDAw
MDAwMGRlZmZmZmZmXSB1c2FibGUKa2VybmVsOiBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAw
MGRmMDAwMDAwLTB4MDAwMDAwMDBkZmZmZmZmZl0gcmVzZXJ2ZWQKa2VybmVsOiBCSU9TLWU4
MjA6IFttZW0gMHgwMDAwMDAwMGY4MDAwMDAwLTB4MDAwMDAwMDBmYmZmZmZmZl0gcmVzZXJ2
ZWQKa2VybmVsOiBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGZkMDAwMDAwLTB4MDAwMDAw
MDBmZmZmZmZmZl0gcmVzZXJ2ZWQKa2VybmVsOiBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAw
MTAwMDAwMDAwLTB4MDAwMDAwMDIxZjMzZmZmZl0gdXNhYmxlCmtlcm5lbDogTlggKEV4ZWN1
dGUgRGlzYWJsZSkgcHJvdGVjdGlvbjogYWN0aXZlCmtlcm5lbDogQVBJQzogU3RhdGljIGNh
bGxzIGluaXRpYWxpemVkCmtlcm5lbDogZWZpOiBFRkkgdjIuNyBieSBBbWVyaWNhbiBNZWdh
dHJlbmRzCmtlcm5lbDogZWZpOiBUUE1GaW5hbExvZz0weGRiZmEyMDAwIEFDUEkgMi4wPTB4
ZGJhYmQwMDAgQUNQST0weGRiYWJkMDAwIFNNQklPUz0weGRjNmEzMDAwIFNNQklPUyAzLjA9
MHhkYzZhMjAwMCBNRU1BVFRSPTB4ZDY5ZmIwMTggRVNSVD0weGQ5NTMzYjk4IE1PS3Zhcj0w
eGRjNmQyMDAwIElOSVRSRD0weGQ2OWZlNjk4IFJORz0weGRiYWJjMDE4IFRQTUV2ZW50TG9n
PTB4ZGJhYWYwMTgKa2VybmVsOiByYW5kb206IGNybmcgaW5pdCBkb25lCmtlcm5lbDogZWZp
OiBSZW1vdmUgbWVtMzUzOiBNTUlPIHJhbmdlPVsweGY4MDAwMDAwLTB4ZmJmZmZmZmZdICg2
NE1CKSBmcm9tIGU4MjAgbWFwCmtlcm5lbDogZTgyMDogcmVtb3ZlIFttZW0gMHhmODAwMDAw
MC0weGZiZmZmZmZmXSByZXNlcnZlZAprZXJuZWw6IGVmaTogUmVtb3ZlIG1lbTM1NDogTU1J
TyByYW5nZT1bMHhmZDAwMDAwMC0weGZmZmZmZmZmXSAoNDhNQikgZnJvbSBlODIwIG1hcApr
ZXJuZWw6IGU4MjA6IHJlbW92ZSBbbWVtIDB4ZmQwMDAwMDAtMHhmZmZmZmZmZl0gcmVzZXJ2
ZWQKa2VybmVsOiBTTUJJT1MgMy4yLjAgcHJlc2VudC4Ka2VybmVsOiBETUk6IExFTk9WTyA5
MEowMDA3OFVTLzM3MDYsIEJJT1MgTzRES1Q0NUEgMTIvMDYvMjAyMgprZXJuZWw6IERNSTog
TWVtb3J5IHNsb3RzIHBvcHVsYXRlZDogMi8yCmtlcm5lbDogdHNjOiBGYXN0IFRTQyBjYWxp
YnJhdGlvbiB1c2luZyBQSVQKa2VybmVsOiB0c2M6IERldGVjdGVkIDM1OTMuMTY5IE1IeiBw
cm9jZXNzb3IKa2VybmVsOiBlODIwOiB1cGRhdGUgW21lbSAweDAwMDAwMDAwLTB4MDAwMDBm
ZmZdIHVzYWJsZSA9PT4gcmVzZXJ2ZWQKa2VybmVsOiBlODIwOiByZW1vdmUgW21lbSAweDAw
MGEwMDAwLTB4MDAwZmZmZmZdIHVzYWJsZQprZXJuZWw6IGxhc3RfcGZuID0gMHgyMWYzNDAg
bWF4X2FyY2hfcGZuID0gMHg0MDAwMDAwMDAKa2VybmVsOiBNVFJSIG1hcDogNiBlbnRyaWVz
ICg0IGZpeGVkICsgMiB2YXJpYWJsZTsgbWF4IDIxKSwgYnVpbHQgZnJvbSA5IHZhcmlhYmxl
IE1UUlJzCmtlcm5lbDogeDg2L1BBVDogQ29uZmlndXJhdGlvbiBbMC03XTogV0IgIFdDICBV
Qy0gVUMgIFdCICBXUCAgVUMtIFdUCmtlcm5lbDogZTgyMDogdXBkYXRlIFttZW0gMHhlMDAw
MDAwMC0weGZmZmZmZmZmXSB1c2FibGUgPT0+IHJlc2VydmVkCmtlcm5lbDogbGFzdF9wZm4g
PSAweGRmMDAwIG1heF9hcmNoX3BmbiA9IDB4NDAwMDAwMDAwCmtlcm5lbDogZXNydDogUmVz
ZXJ2aW5nIEVTUlQgc3BhY2UgZnJvbSAweDAwMDAwMDAwZDk1MzNiOTggdG8gMHgwMDAwMDAw
MGQ5NTMzYmY4LgprZXJuZWw6IGU4MjA6IHVwZGF0ZSBbbWVtIDB4ZDk1MzMwMDAtMHhkOTUz
M2ZmZl0gdXNhYmxlID09PiByZXNlcnZlZAprZXJuZWw6IFVzaW5nIEdCIHBhZ2VzIGZvciBk
aXJlY3QgbWFwcGluZwprZXJuZWw6IFNlY3VyZSBib290IGRpc2FibGVkCmtlcm5lbDogUkFN
RElTSzogW21lbSAweGM0ZWIyMDAwLTB4Y2IyNTlmZmZdCmtlcm5lbDogQUNQSTogRWFybHkg
dGFibGUgY2hlY2tzdW0gdmVyaWZpY2F0aW9uIGRpc2FibGVkCmtlcm5lbDogQUNQSTogUlNE
UCAweDAwMDAwMDAwREJBQkQwMDAgMDAwMDI0ICh2MDIgTEVOT1ZPKQprZXJuZWw6IEFDUEk6
IFhTRFQgMHgwMDAwMDAwMERCQUJEMEIwIDAwMDBFNCAodjAxIExFTk9WTyBUQy1PNEQgICAw
MDAwMTJEMCBBTUkgIDAwMDEwMDEzKQprZXJuZWw6IEFDUEk6IEZBQ1AgMHgwMDAwMDAwMERC
QUM5RDM4IDAwMDExNCAodjA2IExFTk9WTyBUQy1PNEQgICAwMDAwMTJEMCBBTUkgIDAwMDEw
MDEzKQprZXJuZWw6IEFDUEk6IERTRFQgMHgwMDAwMDAwMERCQUJEMjI4IDAwQ0IxMCAodjAy
IExFTk9WTyBUQy1PNEQgICAwMDAwMTJEMCBJTlRMIDIwMTIwOTEzKQprZXJuZWw6IEFDUEk6
IEZBQ1MgMHgwMDAwMDAwMERCRkQ3RTAwIDAwMDA0MAprZXJuZWw6IEFDUEk6IEFQSUMgMHgw
MDAwMDAwMERCQUM5RTUwIDAwMDE1RSAodjAzIExFTk9WTyBUQy1PNEQgICAwMDAwMTJEMCBB
TUkgIDAwMDEwMDEzKQprZXJuZWw6IEFDUEk6IEZQRFQgMHgwMDAwMDAwMERCQUM5RkIwIDAw
MDA0NCAodjAxIExFTk9WTyBUQy1PNEQgICAwMDAwMTJEMCBBTUkgIDAwMDEwMDEzKQprZXJu
ZWw6IEFDUEk6IEZJRFQgMHgwMDAwMDAwMERCQUM5RkY4IDAwMDA5QyAodjAxIExFTk9WTyBU
Qy1PNEQgICAwMDAwMTJEMCBBTUkgIDAwMDEwMDEzKQprZXJuZWw6IEFDUEk6IFNTRFQgMHgw
MDAwMDAwMERCQUNBMDk4IDAwMDA2MCAodjAyIExFTk9WTyBUQy1PNEQgICAwMDAwMTJEMCBB
TUkgIDAxMDcyMDA5KQprZXJuZWw6IEFDUEk6IFNTRFQgMHgwMDAwMDAwMERCQUNBMEY4IDAw
NTQxOSAodjAyIExFTk9WTyBUQy1PNEQgICAwMDAwMTJEMCBNU0ZUIDAyMDAwMDAyKQprZXJu
ZWw6IEFDUEk6IFNTRFQgMHgwMDAwMDAwMERCQUNGNTE4IDAwMzc4QSAodjAxIExFTk9WTyBU
Qy1PNEQgICAwMDAwMTJEMCBJTlRMIDIwMTIwOTEzKQprZXJuZWw6IEFDUEk6IE1DRkcgMHgw
MDAwMDAwMERCQUQyQ0E4IDAwMDAzQyAodjAxIExFTk9WTyBUQy1PNEQgICAwMDAwMTJEMCBN
U0ZUIDAwMDEwMDEzKQprZXJuZWw6IEFDUEk6IE1TRE0gMHgwMDAwMDAwMERCQUQyQ0U4IDAw
MDA1NSAodjAzIExFTk9WTyBUQy1PNEQgICAwMDAwMTJEMCBBTUkgIDAwMDEwMDEzKQprZXJu
ZWw6IEFDUEk6IEhQRVQgMHgwMDAwMDAwMERCQUQyRDQwIDAwMDAzOCAodjAxIExFTk9WTyBU
Qy1PNEQgICAwMDAwMTJEMCBBTUkgIDAwMDAwMDA1KQprZXJuZWw6IEFDUEk6IFVFRkkgMHgw
MDAwMDAwMERCQUQyRDc4IDAwMDA0MiAodjAxIExFTk9WTyBUQy1PNEQgICAwMDAwMTJEMCAg
ICAgIDAxMDAwMDEzKQprZXJuZWw6IEFDUEk6IFZGQ1QgMHgwMDAwMDAwMERCQUQyREMwIDAw
RUM4NCAodjAxIExFTk9WTyBUQy1PNEQgICAwMDAwMTJEMCBBTUQgIDMxNTA0RjQ3KQprZXJu
ZWw6IEFDUEk6IEJHUlQgMHgwMDAwMDAwMERCQUUxQTQ4IDAwMDAzOCAodjAxIExFTk9WTyBU
Qy1PNEQgICAwMDAwMTJEMCBBTUkgIDAwMDEwMDEzKQprZXJuZWw6IEFDUEk6IExVRlQgMHgw
MDAwMDAwMERCQUUxQTgwIDAzNDlFMiAodjAxIExFTk9WTyBUQy1PNEQgICAwMDAwMTJEMCBB
TUkgIDAwMDEwMDEzKQprZXJuZWw6IEFDUEk6IFRQTTIgMHgwMDAwMDAwMERCQjE2NDY4IDAw
MDAzOCAodjA0IExFTk9WTyBUQy1PNEQgICAwMDAwMTJEMCBBTUkgIDAwMDAwMDAwKQprZXJu
ZWw6IEFDUEk6IElWUlMgMHgwMDAwMDAwMERCQjE2NEEwIDAwMDBEMCAodjAyIExFTk9WTyBU
Qy1PNEQgICAwMDAwMTJEMCBBTUQgIDAwMDAwMDAwKQprZXJuZWw6IEFDUEk6IFNTRFQgMHgw
MDAwMDAwMERCQjE2NTcwIDAwMDdEQyAodjAxIExFTk9WTyBUQy1PNEQgICAwMDAwMTJEMCBB
TUQgIDAwMDAwMDAxKQprZXJuZWw6IEFDUEk6IENSQVQgMHgwMDAwMDAwMERCQjE2RDUwIDAw
MDgxMCAodjAxIExFTk9WTyBUQy1PNEQgICAwMDAwMTJEMCBBTUQgIDAwMDAwMDAxKQprZXJu
ZWw6IEFDUEk6IENESVQgMHgwMDAwMDAwMERCQjE3NTYwIDAwMDAyOSAodjAxIExFTk9WTyBU
Qy1PNEQgICAwMDAwMTJEMCBBTUQgIDAwMDAwMDAxKQprZXJuZWw6IEFDUEk6IFNTRFQgMHgw
MDAwMDAwMERCQjE3NTkwIDAwMDA1MCAodjAxIExFTk9WTyBUQy1PNEQgICAwMDAwMTJEMCBJ
TlRMIDIwMTIwOTEzKQprZXJuZWw6IEFDUEk6IFNTRFQgMHgwMDAwMDAwMERCQjE3NUUwIDAw
MTBBQyAodjAxIExFTk9WTyBUQy1PNEQgICAwMDAwMTJEMCBJTlRMIDIwMTIwOTEzKQprZXJu
ZWw6IEFDUEk6IFNTRFQgMHgwMDAwMDAwMERCQjE4NjkwIDAwMDUyQyAodjAxIExFTk9WTyBU
Qy1PNEQgICAwMDAwMTJEMCBJTlRMIDIwMTIwOTEzKQprZXJuZWw6IEFDUEk6IFNTRFQgMHgw
MDAwMDAwMERCQjE4QkMwIDAwMUQ0QSAodjAxIExFTk9WTyBUQy1PNEQgICAwMDAwMTJEMCBJ
TlRMIDIwMTIwOTEzKQprZXJuZWw6IEFDUEk6IFdTTVQgMHgwMDAwMDAwMERCQjFBOTEwIDAw
MDAyOCAodjAxIExFTk9WTyBUQy1PNEQgICAwMDAwMTJEMCBBTUkgIDAwMDEwMDEzKQprZXJu
ZWw6IEFDUEk6IFJlc2VydmluZyBGQUNQIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4ZGJhYzlk
MzgtMHhkYmFjOWU0Yl0Ka2VybmVsOiBBQ1BJOiBSZXNlcnZpbmcgRFNEVCB0YWJsZSBtZW1v
cnkgYXQgW21lbSAweGRiYWJkMjI4LTB4ZGJhYzlkMzddCmtlcm5lbDogQUNQSTogUmVzZXJ2
aW5nIEZBQ1MgdGFibGUgbWVtb3J5IGF0IFttZW0gMHhkYmZkN2UwMC0weGRiZmQ3ZTNmXQpr
ZXJuZWw6IEFDUEk6IFJlc2VydmluZyBBUElDIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4ZGJh
YzllNTAtMHhkYmFjOWZhZF0Ka2VybmVsOiBBQ1BJOiBSZXNlcnZpbmcgRlBEVCB0YWJsZSBt
ZW1vcnkgYXQgW21lbSAweGRiYWM5ZmIwLTB4ZGJhYzlmZjNdCmtlcm5lbDogQUNQSTogUmVz
ZXJ2aW5nIEZJRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHhkYmFjOWZmOC0weGRiYWNhMDkz
XQprZXJuZWw6IEFDUEk6IFJlc2VydmluZyBTU0RUIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4
ZGJhY2EwOTgtMHhkYmFjYTBmN10Ka2VybmVsOiBBQ1BJOiBSZXNlcnZpbmcgU1NEVCB0YWJs
ZSBtZW1vcnkgYXQgW21lbSAweGRiYWNhMGY4LTB4ZGJhY2Y1MTBdCmtlcm5lbDogQUNQSTog
UmVzZXJ2aW5nIFNTRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHhkYmFjZjUxOC0weGRiYWQy
Y2ExXQprZXJuZWw6IEFDUEk6IFJlc2VydmluZyBNQ0ZHIHRhYmxlIG1lbW9yeSBhdCBbbWVt
IDB4ZGJhZDJjYTgtMHhkYmFkMmNlM10Ka2VybmVsOiBBQ1BJOiBSZXNlcnZpbmcgTVNETSB0
YWJsZSBtZW1vcnkgYXQgW21lbSAweGRiYWQyY2U4LTB4ZGJhZDJkM2NdCmtlcm5lbDogQUNQ
STogUmVzZXJ2aW5nIEhQRVQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHhkYmFkMmQ0MC0weGRi
YWQyZDc3XQprZXJuZWw6IEFDUEk6IFJlc2VydmluZyBVRUZJIHRhYmxlIG1lbW9yeSBhdCBb
bWVtIDB4ZGJhZDJkNzgtMHhkYmFkMmRiOV0Ka2VybmVsOiBBQ1BJOiBSZXNlcnZpbmcgVkZD
VCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweGRiYWQyZGMwLTB4ZGJhZTFhNDNdCmtlcm5lbDog
QUNQSTogUmVzZXJ2aW5nIEJHUlQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHhkYmFlMWE0OC0w
eGRiYWUxYTdmXQprZXJuZWw6IEFDUEk6IFJlc2VydmluZyBMVUZUIHRhYmxlIG1lbW9yeSBh
dCBbbWVtIDB4ZGJhZTFhODAtMHhkYmIxNjQ2MV0Ka2VybmVsOiBBQ1BJOiBSZXNlcnZpbmcg
VFBNMiB0YWJsZSBtZW1vcnkgYXQgW21lbSAweGRiYjE2NDY4LTB4ZGJiMTY0OWZdCmtlcm5l
bDogQUNQSTogUmVzZXJ2aW5nIElWUlMgdGFibGUgbWVtb3J5IGF0IFttZW0gMHhkYmIxNjRh
MC0weGRiYjE2NTZmXQprZXJuZWw6IEFDUEk6IFJlc2VydmluZyBTU0RUIHRhYmxlIG1lbW9y
eSBhdCBbbWVtIDB4ZGJiMTY1NzAtMHhkYmIxNmQ0Yl0Ka2VybmVsOiBBQ1BJOiBSZXNlcnZp
bmcgQ1JBVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweGRiYjE2ZDUwLTB4ZGJiMTc1NWZdCmtl
cm5lbDogQUNQSTogUmVzZXJ2aW5nIENESVQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHhkYmIx
NzU2MC0weGRiYjE3NTg4XQprZXJuZWw6IEFDUEk6IFJlc2VydmluZyBTU0RUIHRhYmxlIG1l
bW9yeSBhdCBbbWVtIDB4ZGJiMTc1OTAtMHhkYmIxNzVkZl0Ka2VybmVsOiBBQ1BJOiBSZXNl
cnZpbmcgU1NEVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweGRiYjE3NWUwLTB4ZGJiMTg2OGJd
Cmtlcm5lbDogQUNQSTogUmVzZXJ2aW5nIFNTRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHhk
YmIxODY5MC0weGRiYjE4YmJiXQprZXJuZWw6IEFDUEk6IFJlc2VydmluZyBTU0RUIHRhYmxl
IG1lbW9yeSBhdCBbbWVtIDB4ZGJiMThiYzAtMHhkYmIxYTkwOV0Ka2VybmVsOiBBQ1BJOiBS
ZXNlcnZpbmcgV1NNVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweGRiYjFhOTEwLTB4ZGJiMWE5
MzddCmtlcm5lbDogTm8gTlVNQSBjb25maWd1cmF0aW9uIGZvdW5kCmtlcm5lbDogRmFraW5n
IGEgbm9kZSBhdCBbbWVtIDB4MDAwMDAwMDAwMDAwMDAwMC0weDAwMDAwMDAyMWYzM2ZmZmZd
Cmtlcm5lbDogTk9ERV9EQVRBKDApIGFsbG9jYXRlZCBbbWVtIDB4MjFmMzE1NTAwLTB4MjFm
MzNmZmZmXQprZXJuZWw6IFpvbmUgcmFuZ2VzOgprZXJuZWw6ICAgRE1BICAgICAgW21lbSAw
eDAwMDAwMDAwMDAwMDEwMDAtMHgwMDAwMDAwMDAwZmZmZmZmXQprZXJuZWw6ICAgRE1BMzIg
ICAgW21lbSAweDAwMDAwMDAwMDEwMDAwMDAtMHgwMDAwMDAwMGZmZmZmZmZmXQprZXJuZWw6
ICAgTm9ybWFsICAgW21lbSAweDAwMDAwMDAxMDAwMDAwMDAtMHgwMDAwMDAwMjFmMzNmZmZm
XQprZXJuZWw6ICAgRGV2aWNlICAgZW1wdHkKa2VybmVsOiBNb3ZhYmxlIHpvbmUgc3RhcnQg
Zm9yIGVhY2ggbm9kZQprZXJuZWw6IEVhcmx5IG1lbW9yeSBub2RlIHJhbmdlcwprZXJuZWw6
ICAgbm9kZSAgIDA6IFttZW0gMHgwMDAwMDAwMDAwMDAxMDAwLTB4MDAwMDAwMDAwMDA5ZmZm
Zl0Ka2VybmVsOiAgIG5vZGUgICAwOiBbbWVtIDB4MDAwMDAwMDAwMDEwMDAwMC0weDAwMDAw
MDAwMDljZmZmZmZdCmtlcm5lbDogICBub2RlICAgMDogW21lbSAweDAwMDAwMDAwMGEwMDAw
MDAtMHgwMDAwMDAwMDBhMWZmZmZmXQprZXJuZWw6ICAgbm9kZSAgIDA6IFttZW0gMHgwMDAw
MDAwMDBhMjBiMDAwLTB4MDAwMDAwMDBkYTVjNGZmZl0Ka2VybmVsOiAgIG5vZGUgICAwOiBb
bWVtIDB4MDAwMDAwMDBkYzg3OTAwMC0weDAwMDAwMDAwZGVmZmZmZmZdCmtlcm5lbDogICBu
b2RlICAgMDogW21lbSAweDAwMDAwMDAxMDAwMDAwMDAtMHgwMDAwMDAwMjFmMzNmZmZmXQpr
ZXJuZWw6IEluaXRtZW0gc2V0dXAgbm9kZSAwIFttZW0gMHgwMDAwMDAwMDAwMDAxMDAwLTB4
MDAwMDAwMDIxZjMzZmZmZl0Ka2VybmVsOiBPbiBub2RlIDAsIHpvbmUgRE1BOiAxIHBhZ2Vz
IGluIHVuYXZhaWxhYmxlIHJhbmdlcwprZXJuZWw6IE9uIG5vZGUgMCwgem9uZSBETUE6IDk2
IHBhZ2VzIGluIHVuYXZhaWxhYmxlIHJhbmdlcwprZXJuZWw6IE9uIG5vZGUgMCwgem9uZSBE
TUEzMjogNzY4IHBhZ2VzIGluIHVuYXZhaWxhYmxlIHJhbmdlcwprZXJuZWw6IE9uIG5vZGUg
MCwgem9uZSBETUEzMjogMTEgcGFnZXMgaW4gdW5hdmFpbGFibGUgcmFuZ2VzCmtlcm5lbDog
T24gbm9kZSAwLCB6b25lIERNQTMyOiA4ODg0IHBhZ2VzIGluIHVuYXZhaWxhYmxlIHJhbmdl
cwprZXJuZWw6IE9uIG5vZGUgMCwgem9uZSBOb3JtYWw6IDQwOTYgcGFnZXMgaW4gdW5hdmFp
bGFibGUgcmFuZ2VzCmtlcm5lbDogT24gbm9kZSAwLCB6b25lIE5vcm1hbDogMzI2NCBwYWdl
cyBpbiB1bmF2YWlsYWJsZSByYW5nZXMKa2VybmVsOiBBQ1BJOiBQTS1UaW1lciBJTyBQb3J0
OiAweDgwOAprZXJuZWw6IENQVSB0b3BvOiBJZ25vcmluZyBob3QtcGx1Z2dhYmxlIEFQSUMg
SUQgMCBpbiBwcmVzZW50IHBhY2thZ2UuCmtlcm5lbDogQUNQSTogTEFQSUNfTk1JIChhY3Bp
X2lkWzB4ZmZdIGhpZ2ggZWRnZSBsaW50WzB4MV0pCmtlcm5lbDogSU9BUElDWzBdOiBhcGlj
X2lkIDUsIHZlcnNpb24gMzMsIGFkZHJlc3MgMHhmZWMwMDAwMCwgR1NJIDAtMjMKa2VybmVs
OiBJT0FQSUNbMV06IGFwaWNfaWQgNiwgdmVyc2lvbiAzMywgYWRkcmVzcyAweGZlYzAxMDAw
LCBHU0kgMjQtNTUKa2VybmVsOiBBQ1BJOiBJTlRfU1JDX09WUiAoYnVzIDAgYnVzX2lycSAw
IGdsb2JhbF9pcnEgMiBkZmwgZGZsKQprZXJuZWw6IEFDUEk6IElOVF9TUkNfT1ZSIChidXMg
MCBidXNfaXJxIDkgZ2xvYmFsX2lycSA5IGxvdyBsZXZlbCkKa2VybmVsOiBBQ1BJOiBVc2lu
ZyBBQ1BJIChNQURUKSBmb3IgU01QIGNvbmZpZ3VyYXRpb24gaW5mb3JtYXRpb24Ka2VybmVs
OiBBQ1BJOiBIUEVUIGlkOiAweDEwMjI4MjAxIGJhc2U6IDB4ZmVkMDAwMDAKa2VybmVsOiBl
ODIwOiB1cGRhdGUgW21lbSAweGQ3MTc2MDAwLTB4ZDcxYmVmZmZdIHVzYWJsZSA9PT4gcmVz
ZXJ2ZWQKa2VybmVsOiBDUFUgdG9wbzogTWF4LiBsb2dpY2FsIHBhY2thZ2VzOiAgIDEKa2Vy
bmVsOiBDUFUgdG9wbzogTWF4LiBsb2dpY2FsIGRpZXM6ICAgICAgIDEKa2VybmVsOiBDUFUg
dG9wbzogTWF4LiBkaWVzIHBlciBwYWNrYWdlOiAgIDEKa2VybmVsOiBDUFUgdG9wbzogTWF4
LiB0aHJlYWRzIHBlciBjb3JlOiAgIDEKa2VybmVsOiBDUFUgdG9wbzogTnVtLiBjb3JlcyBw
ZXIgcGFja2FnZTogICAgIDQKa2VybmVsOiBDUFUgdG9wbzogTnVtLiB0aHJlYWRzIHBlciBw
YWNrYWdlOiAgIDQKa2VybmVsOiBDUFUgdG9wbzogQWxsb3dpbmcgNCBwcmVzZW50IENQVXMg
cGx1cyAwIGhvdHBsdWcgQ1BVcwprZXJuZWw6IENQVSB0b3BvOiBSZWplY3RlZCBDUFVzIDI4
Cmtlcm5lbDogUE06IGhpYmVybmF0aW9uOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFtt
ZW0gMHgwMDAwMDAwMC0weDAwMDAwZmZmXQprZXJuZWw6IFBNOiBoaWJlcm5hdGlvbjogUmVn
aXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4MDAwYTAwMDAtMHgwMDBmZmZmZl0Ka2Vy
bmVsOiBQTTogaGliZXJuYXRpb246IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAw
eDA5ZDAwMDAwLTB4MDlmZmZmZmZdCmtlcm5lbDogUE06IGhpYmVybmF0aW9uOiBSZWdpc3Rl
cmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHgwYTIwMDAwMC0weDBhMjBhZmZmXQprZXJuZWw6
IFBNOiBoaWJlcm5hdGlvbjogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4ZDcx
NzYwMDAtMHhkNzFiZWZmZl0Ka2VybmVsOiBQTTogaGliZXJuYXRpb246IFJlZ2lzdGVyZWQg
bm9zYXZlIG1lbW9yeTogW21lbSAweGQ5NTMzMDAwLTB4ZDk1MzNmZmZdCmtlcm5lbDogUE06
IGhpYmVybmF0aW9uOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHhkYTVjNTAw
MC0weGRjODc4ZmZmXQprZXJuZWw6IFBNOiBoaWJlcm5hdGlvbjogUmVnaXN0ZXJlZCBub3Nh
dmUgbWVtb3J5OiBbbWVtIDB4ZGYwMDAwMDAtMHhmZmZmZmZmZl0Ka2VybmVsOiBbbWVtIDB4
ZTAwMDAwMDAtMHhmZmZmZmZmZl0gYXZhaWxhYmxlIGZvciBQQ0kgZGV2aWNlcwprZXJuZWw6
IEJvb3RpbmcgcGFyYXZpcnR1YWxpemVkIGtlcm5lbCBvbiBiYXJlIGhhcmR3YXJlCmtlcm5l
bDogY2xvY2tzb3VyY2U6IHJlZmluZWQtamlmZmllczogbWFzazogMHhmZmZmZmZmZiBtYXhf
Y3ljbGVzOiAweGZmZmZmZmZmLCBtYXhfaWRsZV9uczogMTkxMDk2OTk0MDM5MTQxOSBucwpr
ZXJuZWw6IHNldHVwX3BlcmNwdTogTlJfQ1BVUzo4MTkyIG5yX2NwdW1hc2tfYml0czo0IG5y
X2NwdV9pZHM6NCBucl9ub2RlX2lkczoxCmtlcm5lbDogcGVyY3B1OiBFbWJlZGRlZCA4NCBw
YWdlcy9jcHUgczIyMTE4NCByODE5MiBkMTE0Njg4IHU1MjQyODgKa2VybmVsOiBwY3B1LWFs
bG9jOiBzMjIxMTg0IHI4MTkyIGQxMTQ2ODggdTUyNDI4OCBhbGxvYz0xKjIwOTcxNTIKa2Vy
bmVsOiBwY3B1LWFsbG9jOiBbMF0gMCAxIDIgMwprZXJuZWw6IEtlcm5lbCBjb21tYW5kIGxp
bmU6IEJPT1RfSU1BR0U9L2Jvb3Qvdm1saW51ei02LjE2LjAtcmM0KyByb290PVVVSUQ9ZjIy
NWU3MTUtMGU0Ni00YWY5LWFlMDItOWY3MDRhNzg0MmZhIHJvIHF1aWV0IHNwbGFzaCBhbWRn
cHUuYXNwbT0wIHZ0LmhhbmRvZmY9NwprZXJuZWw6IFVua25vd24ga2VybmVsIGNvbW1hbmQg
bGluZSBwYXJhbWV0ZXJzICJzcGxhc2ggQk9PVF9JTUFHRT0vYm9vdC92bWxpbnV6LTYuMTYu
MC1yYzQrIiwgd2lsbCBiZSBwYXNzZWQgdG8gdXNlciBzcGFjZS4Ka2VybmVsOiBwcmludGs6
IGxvZyBidWZmZXIgZGF0YSArIG1ldGEgZGF0YTogMjYyMTQ0ICsgOTE3NTA0ID0gMTE3OTY0
OCBieXRlcwprZXJuZWw6IERlbnRyeSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDEwNDg1
NzYgKG9yZGVyOiAxMSwgODM4ODYwOCBieXRlcywgbGluZWFyKQprZXJuZWw6IElub2RlLWNh
Y2hlIGhhc2ggdGFibGUgZW50cmllczogNTI0Mjg4IChvcmRlcjogMTAsIDQxOTQzMDQgYnl0
ZXMsIGxpbmVhcikKa2VybmVsOiBzb2Z0d2FyZSBJTyBUTEI6IGFyZWEgbnVtIDQuCmtlcm5l
bDogRmFsbGJhY2sgb3JkZXIgZm9yIE5vZGUgMDogMAprZXJuZWw6IEJ1aWx0IDEgem9uZWxp
c3RzLCBtb2JpbGl0eSBncm91cGluZyBvbi4gIFRvdGFsIHBhZ2VzOiAyMDgwMDMyCmtlcm5l
bDogUG9saWN5IHpvbmU6IE5vcm1hbAprZXJuZWw6IG1lbSBhdXRvLWluaXQ6IHN0YWNrOmFs
bCh6ZXJvKSwgaGVhcCBhbGxvYzpvbiwgaGVhcCBmcmVlOm9mZgprZXJuZWw6IFNMVUI6IEhX
YWxpZ249NjQsIE9yZGVyPTAtMywgTWluT2JqZWN0cz0wLCBDUFVzPTQsIE5vZGVzPTEKa2Vy
bmVsOiBmdHJhY2U6IGFsbG9jYXRpbmcgNTU0NzUgZW50cmllcyBpbiAyMjAgcGFnZXMKa2Vy
bmVsOiBmdHJhY2U6IGFsbG9jYXRlZCAyMjAgcGFnZXMgd2l0aCA1IGdyb3VwcwprZXJuZWw6
IER5bmFtaWMgUHJlZW1wdDogdm9sdW50YXJ5Cmtlcm5lbDogcmN1OiBQcmVlbXB0aWJsZSBo
aWVyYXJjaGljYWwgUkNVIGltcGxlbWVudGF0aW9uLgprZXJuZWw6IHJjdTogICAgICAgICBS
Q1UgcmVzdHJpY3RpbmcgQ1BVcyBmcm9tIE5SX0NQVVM9ODE5MiB0byBucl9jcHVfaWRzPTQu
Cmtlcm5lbDogICAgICAgICBUcmFtcG9saW5lIHZhcmlhbnQgb2YgVGFza3MgUkNVIGVuYWJs
ZWQuCmtlcm5lbDogICAgICAgICBSdWRlIHZhcmlhbnQgb2YgVGFza3MgUkNVIGVuYWJsZWQu
Cmtlcm5lbDogICAgICAgICBUcmFjaW5nIHZhcmlhbnQgb2YgVGFza3MgUkNVIGVuYWJsZWQu
Cmtlcm5lbDogcmN1OiBSQ1UgY2FsY3VsYXRlZCB2YWx1ZSBvZiBzY2hlZHVsZXItZW5saXN0
bWVudCBkZWxheSBpcyAxMDAgamlmZmllcy4Ka2VybmVsOiByY3U6IEFkanVzdGluZyBnZW9t
ZXRyeSBmb3IgcmN1X2Zhbm91dF9sZWFmPTE2LCBucl9jcHVfaWRzPTQKa2VybmVsOiBSQ1Ug
VGFza3M6IFNldHRpbmcgc2hpZnQgdG8gMiBhbmQgbGltIHRvIDEgcmN1X3Rhc2tfY2JfYWRq
dXN0PTEgcmN1X3Rhc2tfY3B1X2lkcz00LgprZXJuZWw6IFJDVSBUYXNrcyBSdWRlOiBTZXR0
aW5nIHNoaWZ0IHRvIDIgYW5kIGxpbSB0byAxIHJjdV90YXNrX2NiX2FkanVzdD0xIHJjdV90
YXNrX2NwdV9pZHM9NC4Ka2VybmVsOiBSQ1UgVGFza3MgVHJhY2U6IFNldHRpbmcgc2hpZnQg
dG8gMiBhbmQgbGltIHRvIDEgcmN1X3Rhc2tfY2JfYWRqdXN0PTEgcmN1X3Rhc2tfY3B1X2lk
cz00LgprZXJuZWw6IE5SX0lSUVM6IDUyNDU0NCwgbnJfaXJxczogMTAwMCwgcHJlYWxsb2Nh
dGVkIGlycXM6IDE2Cmtlcm5lbDogcmN1OiBzcmN1X2luaXQ6IFNldHRpbmcgc3JjdV9zdHJ1
Y3Qgc2l6ZXMgYmFzZWQgb24gY29udGVudGlvbi4Ka2VybmVsOiBDb25zb2xlOiBjb2xvdXIg
ZHVtbXkgZGV2aWNlIDgweDI1Cmtlcm5lbDogcHJpbnRrOiBsZWdhY3kgY29uc29sZSBbdHR5
MF0gZW5hYmxlZAprZXJuZWw6IEFDUEk6IENvcmUgcmV2aXNpb24gMjAyNTA0MDQKa2VybmVs
OiBjbG9ja3NvdXJjZTogaHBldDogbWFzazogMHhmZmZmZmZmZiBtYXhfY3ljbGVzOiAweGZm
ZmZmZmZmLCBtYXhfaWRsZV9uczogMTMzNDg0ODczNTA0IG5zCmtlcm5lbDogQVBJQzogU3dp
dGNoIHRvIHN5bW1ldHJpYyBJL08gbW9kZSBzZXR1cAprZXJuZWw6IEFNRC1WaTogVXNpbmcg
Z2xvYmFsIElWSEQgRUZSOjB4NGY3N2VmMjIyOTRhZGEsIEVGUjI6MHgwCmtlcm5lbDogLi5U
SU1FUjogdmVjdG9yPTB4MzAgYXBpYzE9MCBwaW4xPTIgYXBpYzI9LTEgcGluMj0tMQprZXJu
ZWw6IGNsb2Nrc291cmNlOiB0c2MtZWFybHk6IG1hc2s6IDB4ZmZmZmZmZmZmZmZmZmZmZiBt
YXhfY3ljbGVzOiAweDMzY2IxZTNkNDI0LCBtYXhfaWRsZV9uczogNDQwNzk1MzUxMjAxIG5z
Cmtlcm5lbDogQ2FsaWJyYXRpbmcgZGVsYXkgbG9vcCAoc2tpcHBlZCksIHZhbHVlIGNhbGN1
bGF0ZWQgdXNpbmcgdGltZXIgZnJlcXVlbmN5Li4gNzE4Ni4zMyBCb2dvTUlQUyAobHBqPTM1
OTMxNjkpCmtlcm5lbDogQU1EIFplbjEgRElWMCBidWcgZGV0ZWN0ZWQuIERpc2FibGUgU01U
IGZvciBmdWxsIHByb3RlY3Rpb24uCmtlcm5lbDogTFZUIG9mZnNldCAxIGFzc2lnbmVkIGZv
ciB2ZWN0b3IgMHhmOQprZXJuZWw6IExWVCBvZmZzZXQgMiBhc3NpZ25lZCBmb3IgdmVjdG9y
IDB4ZjQKa2VybmVsOiBMYXN0IGxldmVsIGlUTEIgZW50cmllczogNEtCIDEwMjQsIDJNQiAx
MDI0LCA0TUIgNTEyCmtlcm5lbDogTGFzdCBsZXZlbCBkVExCIGVudHJpZXM6IDRLQiAxNTM2
LCAyTUIgMTUzNiwgNE1CIDc2OCwgMUdCIDAKa2VybmVsOiBwcm9jZXNzOiB1c2luZyBtd2Fp
dCBpbiBpZGxlIHRocmVhZHMKa2VybmVsOiBTcGVjdWxhdGl2ZSBTdG9yZSBCeXBhc3M6IE1p
dGlnYXRpb246IFNwZWN1bGF0aXZlIFN0b3JlIEJ5cGFzcyBkaXNhYmxlZCB2aWEgcHJjdGwK
a2VybmVsOiBTcGVjdHJlIFYyIDogTWl0aWdhdGlvbjogUmV0cG9saW5lcwprZXJuZWw6IFJF
VEJsZWVkOiBNaXRpZ2F0aW9uOiB1bnRyYWluZWQgcmV0dXJuIHRodW5rCmtlcm5lbDogU3Bl
Y3RyZSBWMSA6IE1pdGlnYXRpb246IHVzZXJjb3B5L3N3YXBncyBiYXJyaWVycyBhbmQgX191
c2VyIHBvaW50ZXIgc2FuaXRpemF0aW9uCmtlcm5lbDogU3BlY3RyZSBWMiA6IFNwZWN0cmUg
djIgLyBTcGVjdHJlUlNCOiBGaWxsaW5nIFJTQiBvbiBjb250ZXh0IHN3aXRjaCBhbmQgVk1F
WElUCmtlcm5lbDogU3BlY3RyZSBWMiA6IEVuYWJsaW5nIFNwZWN1bGF0aW9uIEJhcnJpZXIg
Zm9yIGZpcm13YXJlIGNhbGxzCmtlcm5lbDogU3BlY3RyZSBWMiA6IG1pdGlnYXRpb246IEVu
YWJsaW5nIGNvbmRpdGlvbmFsIEluZGlyZWN0IEJyYW5jaCBQcmVkaWN0aW9uIEJhcnJpZXIK
a2VybmVsOiB4ODYvZnB1OiBTdXBwb3J0aW5nIFhTQVZFIGZlYXR1cmUgMHgwMDE6ICd4ODcg
ZmxvYXRpbmcgcG9pbnQgcmVnaXN0ZXJzJwprZXJuZWw6IHg4Ni9mcHU6IFN1cHBvcnRpbmcg
WFNBVkUgZmVhdHVyZSAweDAwMjogJ1NTRSByZWdpc3RlcnMnCmtlcm5lbDogeDg2L2ZwdTog
U3VwcG9ydGluZyBYU0FWRSBmZWF0dXJlIDB4MDA0OiAnQVZYIHJlZ2lzdGVycycKa2VybmVs
OiB4ODYvZnB1OiB4c3RhdGVfb2Zmc2V0WzJdOiAgNTc2LCB4c3RhdGVfc2l6ZXNbMl06ICAy
NTYKa2VybmVsOiB4ODYvZnB1OiBFbmFibGVkIHhzdGF0ZSBmZWF0dXJlcyAweDcsIGNvbnRl
eHQgc2l6ZSBpcyA4MzIgYnl0ZXMsIHVzaW5nICdjb21wYWN0ZWQnIGZvcm1hdC4Ka2VybmVs
OiBGcmVlaW5nIFNNUCBhbHRlcm5hdGl2ZXMgbWVtb3J5OiA1MksKa2VybmVsOiBwaWRfbWF4
OiBkZWZhdWx0OiAzMjc2OCBtaW5pbXVtOiAzMDEKa2VybmVsOiBMU006IGluaXRpYWxpemlu
ZyBsc209bG9ja2Rvd24sY2FwYWJpbGl0eSxsYW5kbG9jayx5YW1hLGFwcGFybW9yLGltYSxl
dm0Ka2VybmVsOiBsYW5kbG9jazogVXAgYW5kIHJ1bm5pbmcuCmtlcm5lbDogWWFtYTogYmVj
b21pbmcgbWluZGZ1bC4Ka2VybmVsOiBBcHBBcm1vcjogQXBwQXJtb3IgaW5pdGlhbGl6ZWQK
a2VybmVsOiBNb3VudC1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDE2Mzg0IChvcmRlcjog
NSwgMTMxMDcyIGJ5dGVzLCBsaW5lYXIpCmtlcm5lbDogTW91bnRwb2ludC1jYWNoZSBoYXNo
IHRhYmxlIGVudHJpZXM6IDE2Mzg0IChvcmRlcjogNSwgMTMxMDcyIGJ5dGVzLCBsaW5lYXIp
Cmtlcm5lbDogc21wYm9vdDogQ1BVMDogQU1EIFJ5emVuIDMgMzIwMEcgd2l0aCBSYWRlb24g
VmVnYSBHcmFwaGljcyAoZmFtaWx5OiAweDE3LCBtb2RlbDogMHgxOCwgc3RlcHBpbmc6IDB4
MSkKa2VybmVsOiBQZXJmb3JtYW5jZSBFdmVudHM6IEZhbTE3aCsgY29yZSBwZXJmY3RyLCBB
TUQgUE1VIGRyaXZlci4Ka2VybmVsOiAuLi4gdmVyc2lvbjogICAgICAgICAgICAgICAgMApr
ZXJuZWw6IC4uLiBiaXQgd2lkdGg6ICAgICAgICAgICAgICA0OAprZXJuZWw6IC4uLiBnZW5l
cmljIHJlZ2lzdGVyczogICAgICA2Cmtlcm5lbDogLi4uIHZhbHVlIG1hc2s6ICAgICAgICAg
ICAgIDAwMDBmZmZmZmZmZmZmZmYKa2VybmVsOiAuLi4gbWF4IHBlcmlvZDogICAgICAgICAg
ICAgMDAwMDdmZmZmZmZmZmZmZgprZXJuZWw6IC4uLiBmaXhlZC1wdXJwb3NlIGV2ZW50czog
ICAwCmtlcm5lbDogLi4uIGV2ZW50IG1hc2s6ICAgICAgICAgICAgIDAwMDAwMDAwMDAwMDAw
M2YKa2VybmVsOiBzaWduYWw6IG1heCBzaWdmcmFtZSBzaXplOiAxNzc2Cmtlcm5lbDogcmN1
OiBIaWVyYXJjaGljYWwgU1JDVSBpbXBsZW1lbnRhdGlvbi4Ka2VybmVsOiByY3U6ICAgICAg
ICAgTWF4IHBoYXNlIG5vLWRlbGF5IGluc3RhbmNlcyBpcyA0MDAuCmtlcm5lbDogVGltZXIg
bWlncmF0aW9uOiAxIGhpZXJhcmNoeSBsZXZlbHM7IDggY2hpbGRyZW4gcGVyIGdyb3VwOyAx
IGNyb3Nzbm9kZSBsZXZlbAprZXJuZWw6IE5NSSB3YXRjaGRvZzogRW5hYmxlZC4gUGVybWFu
ZW50bHkgY29uc3VtZXMgb25lIGh3LVBNVSBjb3VudGVyLgprZXJuZWw6IHNtcDogQnJpbmdp
bmcgdXAgc2Vjb25kYXJ5IENQVXMgLi4uCmtlcm5lbDogc21wYm9vdDogeDg2OiBCb290aW5n
IFNNUCBjb25maWd1cmF0aW9uOgprZXJuZWw6IC4uLi4gbm9kZSAgIzAsIENQVXM6ICAgICAg
IzEgIzIgIzMKa2VybmVsOiBzbXA6IEJyb3VnaHQgdXAgMSBub2RlLCA0IENQVXMKa2VybmVs
OiBzbXBib290OiBUb3RhbCBvZiA0IHByb2Nlc3NvcnMgYWN0aXZhdGVkICgyODc0NS4zNSBC
b2dvTUlQUykKa2VybmVsOiBNZW1vcnk6IDc5NDA3NzZLLzgzMjAxMjhLIGF2YWlsYWJsZSAo
MjEwODdLIGtlcm5lbCBjb2RlLCA0NTkySyByd2RhdGEsIDE0MDg4SyByb2RhdGEsIDQ5OTJL
IGluaXQsIDQ1NTZLIGJzcywgMzY1NjQ4SyByZXNlcnZlZCwgMEsgY21hLXJlc2VydmVkKQpr
ZXJuZWw6IGRldnRtcGZzOiBpbml0aWFsaXplZAprZXJuZWw6IHg4Ni9tbTogTWVtb3J5IGJs
b2NrIHNpemU6IDEyOE1CCmtlcm5lbDogQUNQSTogUE06IFJlZ2lzdGVyaW5nIEFDUEkgTlZT
IHJlZ2lvbiBbbWVtIDB4MGEyMDAwMDAtMHgwYTIwYWZmZl0gKDQ1MDU2IGJ5dGVzKQprZXJu
ZWw6IEFDUEk6IFBNOiBSZWdpc3RlcmluZyBBQ1BJIE5WUyByZWdpb24gW21lbSAweGRiYjIx
MDAwLTB4ZGJmZjBmZmZdICg1MDQ2MjcyIGJ5dGVzKQprZXJuZWw6IGNsb2Nrc291cmNlOiBq
aWZmaWVzOiBtYXNrOiAweGZmZmZmZmZmIG1heF9jeWNsZXM6IDB4ZmZmZmZmZmYsIG1heF9p
ZGxlX25zOiAxOTExMjYwNDQ2Mjc1MDAwIG5zCmtlcm5lbDogcG9zaXh0aW1lcnMgaGFzaCB0
YWJsZSBlbnRyaWVzOiAyMDQ4IChvcmRlcjogMywgMzI3NjggYnl0ZXMsIGxpbmVhcikKa2Vy
bmVsOiBmdXRleCBoYXNoIHRhYmxlIGVudHJpZXM6IDEwMjQgKDY1NTM2IGJ5dGVzIG9uIDEg
TlVNQSBub2RlcywgdG90YWwgNjQgS2lCLCBsaW5lYXIpLgprZXJuZWw6IHBpbmN0cmwgY29y
ZTogaW5pdGlhbGl6ZWQgcGluY3RybCBzdWJzeXN0ZW0Ka2VybmVsOiBQTTogUlRDIHRpbWU6
IDIxOjI4OjA2LCBkYXRlOiAyMDI1LTA3LTA1Cmtlcm5lbDogTkVUOiBSZWdpc3RlcmVkIFBG
X05FVExJTksvUEZfUk9VVEUgcHJvdG9jb2wgZmFtaWx5Cmtlcm5lbDogRE1BOiBwcmVhbGxv
Y2F0ZWQgMTAyNCBLaUIgR0ZQX0tFUk5FTCBwb29sIGZvciBhdG9taWMgYWxsb2NhdGlvbnMK
a2VybmVsOiBETUE6IHByZWFsbG9jYXRlZCAxMDI0IEtpQiBHRlBfS0VSTkVMfEdGUF9ETUEg
cG9vbCBmb3IgYXRvbWljIGFsbG9jYXRpb25zCmtlcm5lbDogRE1BOiBwcmVhbGxvY2F0ZWQg
MTAyNCBLaUIgR0ZQX0tFUk5FTHxHRlBfRE1BMzIgcG9vbCBmb3IgYXRvbWljIGFsbG9jYXRp
b25zCmtlcm5lbDogYXVkaXQ6IGluaXRpYWxpemluZyBuZXRsaW5rIHN1YnN5cyAoZGlzYWJs
ZWQpCmtlcm5lbDogYXVkaXQ6IHR5cGU9MjAwMCBhdWRpdCgxNzUxNzUwODg2LjE0NzoxKTog
c3RhdGU9aW5pdGlhbGl6ZWQgYXVkaXRfZW5hYmxlZD0wIHJlcz0xCmtlcm5lbDogdGhlcm1h
bF9zeXM6IFJlZ2lzdGVyZWQgdGhlcm1hbCBnb3Zlcm5vciAnZmFpcl9zaGFyZScKa2VybmVs
OiB0aGVybWFsX3N5czogUmVnaXN0ZXJlZCB0aGVybWFsIGdvdmVybm9yICdiYW5nX2Jhbmcn
Cmtlcm5lbDogdGhlcm1hbF9zeXM6IFJlZ2lzdGVyZWQgdGhlcm1hbCBnb3Zlcm5vciAnc3Rl
cF93aXNlJwprZXJuZWw6IHRoZXJtYWxfc3lzOiBSZWdpc3RlcmVkIHRoZXJtYWwgZ292ZXJu
b3IgJ3VzZXJfc3BhY2UnCmtlcm5lbDogdGhlcm1hbF9zeXM6IFJlZ2lzdGVyZWQgdGhlcm1h
bCBnb3Zlcm5vciAncG93ZXJfYWxsb2NhdG9yJwprZXJuZWw6IGNwdWlkbGU6IHVzaW5nIGdv
dmVybm9yIGxhZGRlcgprZXJuZWw6IGNwdWlkbGU6IHVzaW5nIGdvdmVybm9yIG1lbnUKa2Vy
bmVsOiBhY3BpcGhwOiBBQ1BJIEhvdCBQbHVnIFBDSSBDb250cm9sbGVyIERyaXZlciB2ZXJz
aW9uOiAwLjUKa2VybmVsOiBQQ0k6IEVDQU0gW21lbSAweGY4MDAwMDAwLTB4ZmJmZmZmZmZd
IChiYXNlIDB4ZjgwMDAwMDApIGZvciBkb21haW4gMDAwMCBbYnVzIDAwLTNmXQprZXJuZWw6
IFBDSTogVXNpbmcgY29uZmlndXJhdGlvbiB0eXBlIDEgZm9yIGJhc2UgYWNjZXNzCmtlcm5l
bDoga3Byb2Jlczoga3Byb2JlIGp1bXAtb3B0aW1pemF0aW9uIGlzIGVuYWJsZWQuIEFsbCBr
cHJvYmVzIGFyZSBvcHRpbWl6ZWQgaWYgcG9zc2libGUuCmtlcm5lbDogSHVnZVRMQjogYWxs
b2NhdGlvbiB0b29rIDBtcyB3aXRoIGh1Z2VwYWdlX2FsbG9jYXRpb25fdGhyZWFkcz0xCmtl
cm5lbDogSHVnZVRMQjogcmVnaXN0ZXJlZCAxLjAwIEdpQiBwYWdlIHNpemUsIHByZS1hbGxv
Y2F0ZWQgMCBwYWdlcwprZXJuZWw6IEh1Z2VUTEI6IDE2MzgwIEtpQiB2bWVtbWFwIGNhbiBi
ZSBmcmVlZCBmb3IgYSAxLjAwIEdpQiBwYWdlCmtlcm5lbDogSHVnZVRMQjogcmVnaXN0ZXJl
ZCAyLjAwIE1pQiBwYWdlIHNpemUsIHByZS1hbGxvY2F0ZWQgMCBwYWdlcwprZXJuZWw6IEh1
Z2VUTEI6IDI4IEtpQiB2bWVtbWFwIGNhbiBiZSBmcmVlZCBmb3IgYSAyLjAwIE1pQiBwYWdl
Cmtlcm5lbDogQUNQSTogQWRkZWQgX09TSShNb2R1bGUgRGV2aWNlKQprZXJuZWw6IEFDUEk6
IEFkZGVkIF9PU0koUHJvY2Vzc29yIERldmljZSkKa2VybmVsOiBBQ1BJOiBBZGRlZCBfT1NJ
KFByb2Nlc3NvciBBZ2dyZWdhdG9yIERldmljZSkKa2VybmVsOiBBQ1BJOiA5IEFDUEkgQU1M
IHRhYmxlcyBzdWNjZXNzZnVsbHkgYWNxdWlyZWQgYW5kIGxvYWRlZAprZXJuZWw6IEFDUEk6
IFtGaXJtd2FyZSBCdWddOiBCSU9TIF9PU0koTGludXgpIHF1ZXJ5IGlnbm9yZWQKa2VybmVs
OiBBQ1BJOiBJbnRlcnByZXRlciBlbmFibGVkCmtlcm5lbDogQUNQSTogUE06IChzdXBwb3J0
cyBTMCBTMyBTNCBTNSkKa2VybmVsOiBBQ1BJOiBVc2luZyBJT0FQSUMgZm9yIGludGVycnVw
dCByb3V0aW5nCmtlcm5lbDogUENJOiBVc2luZyBob3N0IGJyaWRnZSB3aW5kb3dzIGZyb20g
QUNQSTsgaWYgbmVjZXNzYXJ5LCB1c2UgInBjaT1ub2NycyIgYW5kIHJlcG9ydCBhIGJ1Zwpr
ZXJuZWw6IFBDSTogVXNpbmcgRTgyMCByZXNlcnZhdGlvbnMgZm9yIGhvc3QgYnJpZGdlIHdp
bmRvd3MKa2VybmVsOiBBQ1BJOiBFbmFibGVkIDIgR1BFcyBpbiBibG9jayAwMCB0byAxRgpr
ZXJuZWw6IEFDUEk6IFBDSSBSb290IEJyaWRnZSBbUENJMF0gKGRvbWFpbiAwMDAwIFtidXMg
MDAtZmZdKQprZXJuZWw6IGFjcGkgUE5QMEEwODowMDogX09TQzogT1Mgc3VwcG9ydHMgW0V4
dGVuZGVkQ29uZmlnIEFTUE0gQ2xvY2tQTSBTZWdtZW50cyBNU0kgRURSIEhQWC1UeXBlM10K
a2VybmVsOiBhY3BpIFBOUDBBMDg6MDA6IF9PU0M6IHBsYXRmb3JtIGRvZXMgbm90IHN1cHBv
cnQgW1NIUENIb3RwbHVnIExUUiBEUENdCmtlcm5lbDogYWNwaSBQTlAwQTA4OjAwOiBfT1ND
OiBPUyBub3cgY29udHJvbHMgW1BDSWVIb3RwbHVnIFBNRSBBRVIgUENJZUNhcGFiaWxpdHld
Cmtlcm5lbDogYWNwaSBQTlAwQTA4OjAwOiBbRmlybXdhcmUgSW5mb106IEVDQU0gW21lbSAw
eGY4MDAwMDAwLTB4ZmJmZmZmZmZdIGZvciBkb21haW4gMDAwMCBbYnVzIDAwLTNmXSBvbmx5
IHBhcnRpYWxseSBjb3ZlcnMgdGhpcyBicmlkZ2UKa2VybmVsOiBQQ0kgaG9zdCBicmlkZ2Ug
dG8gYnVzIDAwMDA6MDAKa2VybmVsOiBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJlc291
cmNlIFtpbyAgMHgwMDAwLTB4MDNhZiB3aW5kb3ddCmtlcm5lbDogcGNpX2J1cyAwMDAwOjAw
OiByb290IGJ1cyByZXNvdXJjZSBbaW8gIDB4MDNlMC0weDBjZjcgd2luZG93XQprZXJuZWw6
IHBjaV9idXMgMDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2UgW2lvICAweDAzYjAtMHgwM2Rm
IHdpbmRvd10Ka2VybmVsOiBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJlc291cmNlIFtp
byAgMHgwZDAwLTB4ZmZmZiB3aW5kb3ddCmtlcm5lbDogcGNpX2J1cyAwMDAwOjAwOiByb290
IGJ1cyByZXNvdXJjZSBbbWVtIDB4MDAwYTAwMDAtMHgwMDBkZmZmZiB3aW5kb3ddCmtlcm5l
bDogcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbbWVtIDB4ZTAwMDAwMDAt
MHhmZWMwMmZmZiB3aW5kb3ddCmtlcm5lbDogcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyBy
ZXNvdXJjZSBbbWVtIDB4ZmVlMDAwMDAtMHhmZmZmZmZmZiB3aW5kb3ddCmtlcm5lbDogcGNp
X2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbYnVzIDAwLWZmXQprZXJuZWw6IHBj
aSAwMDAwOjAwOjAwLjA6IFsxMDIyOjE1ZDBdIHR5cGUgMDAgY2xhc3MgMHgwNjAwMDAgY29u
dmVudGlvbmFsIFBDSSBlbmRwb2ludAprZXJuZWw6IHBjaSAwMDAwOjAwOjAwLjI6IFsxMDIy
OjE1ZDFdIHR5cGUgMDAgY2xhc3MgMHgwODA2MDAgY29udmVudGlvbmFsIFBDSSBlbmRwb2lu
dAprZXJuZWw6IHBjaSAwMDAwOjAwOjAxLjA6IFsxMDIyOjE0NTJdIHR5cGUgMDAgY2xhc3Mg
MHgwNjAwMDAgY29udmVudGlvbmFsIFBDSSBlbmRwb2ludAprZXJuZWw6IHBjaSAwMDAwOjAw
OjAxLjE6IFsxMDIyOjE1ZDNdIHR5cGUgMDEgY2xhc3MgMHgwNjA0MDAgUENJZSBSb290IFBv
cnQKa2VybmVsOiBwY2kgMDAwMDowMDowMS4xOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDFdCmtl
cm5lbDogcGNpIDAwMDA6MDA6MDEuMTogICBicmlkZ2Ugd2luZG93IFtpbyAgMHhmMDAwLTB4
ZmZmZl0Ka2VybmVsOiBwY2kgMDAwMDowMDowMS4xOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAw
eGZjZTAwMDAwLTB4ZmNlZmZmZmZdCmtlcm5lbDogcGNpIDAwMDA6MDA6MDEuMTogICBicmlk
Z2Ugd2luZG93IFttZW0gMHhlMDAwMDAwMC0weGYwMWZmZmZmIDY0Yml0IHByZWZdCmtlcm5l
bDogcGNpIDAwMDA6MDA6MDEuMTogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdCBEM2Nv
bGQKa2VybmVsOiBwY2kgMDAwMDowMDowMS4yOiBbMTAyMjoxNWQzXSB0eXBlIDAxIGNsYXNz
IDB4MDYwNDAwIFBDSWUgUm9vdCBQb3J0Cmtlcm5lbDogcGNpIDAwMDA6MDA6MDEuMjogUENJ
IGJyaWRnZSB0byBbYnVzIDAyXQprZXJuZWw6IHBjaSAwMDAwOjAwOjAxLjI6ICAgYnJpZGdl
IHdpbmRvdyBbaW8gIDB4ZTAwMC0weGVmZmZdCmtlcm5lbDogcGNpIDAwMDA6MDA6MDEuMjog
ICBicmlkZ2Ugd2luZG93IFttZW0gMHhmY2QwMDAwMC0weGZjZGZmZmZmXQprZXJuZWw6IHBj
aSAwMDAwOjAwOjAxLjI6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ZjAzMDAwMDAtMHhmMDNm
ZmZmZiA2NGJpdCBwcmVmXQprZXJuZWw6IHBjaSAwMDAwOjAwOjAxLjI6IGVuYWJsaW5nIEV4
dGVuZGVkIFRhZ3MKa2VybmVsOiBwY2kgMDAwMDowMDowMS4yOiBQTUUjIHN1cHBvcnRlZCBm
cm9tIEQwIEQzaG90IEQzY29sZAprZXJuZWw6IHBjaSAwMDAwOjAwOjAxLjM6IFsxMDIyOjE1
ZDNdIHR5cGUgMDEgY2xhc3MgMHgwNjA0MDAgUENJZSBSb290IFBvcnQKa2VybmVsOiBwY2kg
MDAwMDowMDowMS4zOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDNdCmtlcm5lbDogcGNpIDAwMDA6
MDA6MDEuMzogICBicmlkZ2Ugd2luZG93IFttZW0gMHhmYzYwMDAwMC0weGZjN2ZmZmZmXQpr
ZXJuZWw6IHBjaSAwMDAwOjAwOjAxLjM6IGVuYWJsaW5nIEV4dGVuZGVkIFRhZ3MKa2VybmVs
OiBwY2kgMDAwMDowMDowMS4zOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90IEQzY29s
ZAprZXJuZWw6IHBjaSAwMDAwOjAwOjA4LjA6IFsxMDIyOjE0NTJdIHR5cGUgMDAgY2xhc3Mg
MHgwNjAwMDAgY29udmVudGlvbmFsIFBDSSBlbmRwb2ludAprZXJuZWw6IHBjaSAwMDAwOjAw
OjA4LjE6IFsxMDIyOjE1ZGJdIHR5cGUgMDEgY2xhc3MgMHgwNjA0MDAgUENJZSBSb290IFBv
cnQKa2VybmVsOiBwY2kgMDAwMDowMDowOC4xOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDRdCmtl
cm5lbDogcGNpIDAwMDA6MDA6MDguMTogICBicmlkZ2Ugd2luZG93IFttZW0gMHhmYzgwMDAw
MC0weGZjYmZmZmZmXQprZXJuZWw6IHBjaSAwMDAwOjAwOjA4LjE6IGVuYWJsaW5nIEV4dGVu
ZGVkIFRhZ3MKa2VybmVsOiBwY2kgMDAwMDowMDowOC4xOiBQTUUjIHN1cHBvcnRlZCBmcm9t
IEQwIEQzaG90IEQzY29sZAprZXJuZWw6IHBjaSAwMDAwOjAwOjA4LjI6IFsxMDIyOjE1ZGNd
IHR5cGUgMDEgY2xhc3MgMHgwNjA0MDAgUENJZSBSb290IFBvcnQKa2VybmVsOiBwY2kgMDAw
MDowMDowOC4yOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDVdCmtlcm5lbDogcGNpIDAwMDA6MDA6
MDguMjogICBicmlkZ2Ugd2luZG93IFttZW0gMHhmY2MwMDAwMC0weGZjY2ZmZmZmXQprZXJu
ZWw6IHBjaSAwMDAwOjAwOjA4LjI6IGVuYWJsaW5nIEV4dGVuZGVkIFRhZ3MKa2VybmVsOiBw
Y2kgMDAwMDowMDowOC4yOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90IEQzY29sZApr
ZXJuZWw6IHBjaSAwMDAwOjAwOjE0LjA6IFsxMDIyOjc5MGJdIHR5cGUgMDAgY2xhc3MgMHgw
YzA1MDAgY29udmVudGlvbmFsIFBDSSBlbmRwb2ludAprZXJuZWw6IHBjaSAwMDAwOjAwOjE0
LjM6IFsxMDIyOjc5MGVdIHR5cGUgMDAgY2xhc3MgMHgwNjAxMDAgY29udmVudGlvbmFsIFBD
SSBlbmRwb2ludAprZXJuZWw6IHBjaSAwMDAwOjAwOjE4LjA6IFsxMDIyOjE1ZThdIHR5cGUg
MDAgY2xhc3MgMHgwNjAwMDAgY29udmVudGlvbmFsIFBDSSBlbmRwb2ludAprZXJuZWw6IHBj
aSAwMDAwOjAwOjE4LjE6IFsxMDIyOjE1ZTldIHR5cGUgMDAgY2xhc3MgMHgwNjAwMDAgY29u
dmVudGlvbmFsIFBDSSBlbmRwb2ludAprZXJuZWw6IHBjaSAwMDAwOjAwOjE4LjI6IFsxMDIy
OjE1ZWFdIHR5cGUgMDAgY2xhc3MgMHgwNjAwMDAgY29udmVudGlvbmFsIFBDSSBlbmRwb2lu
dAprZXJuZWw6IHBjaSAwMDAwOjAwOjE4LjM6IFsxMDIyOjE1ZWJdIHR5cGUgMDAgY2xhc3Mg
MHgwNjAwMDAgY29udmVudGlvbmFsIFBDSSBlbmRwb2ludAprZXJuZWw6IHBjaSAwMDAwOjAw
OjE4LjQ6IFsxMDIyOjE1ZWNdIHR5cGUgMDAgY2xhc3MgMHgwNjAwMDAgY29udmVudGlvbmFs
IFBDSSBlbmRwb2ludAprZXJuZWw6IHBjaSAwMDAwOjAwOjE4LjU6IFsxMDIyOjE1ZWRdIHR5
cGUgMDAgY2xhc3MgMHgwNjAwMDAgY29udmVudGlvbmFsIFBDSSBlbmRwb2ludAprZXJuZWw6
IHBjaSAwMDAwOjAwOjE4LjY6IFsxMDIyOjE1ZWVdIHR5cGUgMDAgY2xhc3MgMHgwNjAwMDAg
Y29udmVudGlvbmFsIFBDSSBlbmRwb2ludAprZXJuZWw6IHBjaSAwMDAwOjAwOjE4Ljc6IFsx
MDIyOjE1ZWZdIHR5cGUgMDAgY2xhc3MgMHgwNjAwMDAgY29udmVudGlvbmFsIFBDSSBlbmRw
b2ludAprZXJuZWw6IHBjaSAwMDAwOjAxOjAwLjA6IFsxMDAyOjY5ODVdIHR5cGUgMDAgY2xh
c3MgMHgwMzAwMDAgUENJZSBMZWdhY3kgRW5kcG9pbnQKa2VybmVsOiBwY2kgMDAwMDowMTow
MC4wOiBCQVIgMCBbbWVtIDB4ZTAwMDAwMDAtMHhlZmZmZmZmZiA2NGJpdCBwcmVmXQprZXJu
ZWw6IHBjaSAwMDAwOjAxOjAwLjA6IEJBUiAyIFttZW0gMHhmMDAwMDAwMC0weGYwMWZmZmZm
IDY0Yml0IHByZWZdCmtlcm5lbDogcGNpIDAwMDA6MDE6MDAuMDogQkFSIDQgW2lvICAweGYw
MDAtMHhmMGZmXQprZXJuZWw6IHBjaSAwMDAwOjAxOjAwLjA6IEJBUiA1IFttZW0gMHhmY2Uw
MDAwMC0weGZjZTNmZmZmXQprZXJuZWw6IHBjaSAwMDAwOjAxOjAwLjA6IFJPTSBbbWVtIDB4
ZmNlNDAwMDAtMHhmY2U1ZmZmZiBwcmVmXQprZXJuZWw6IHBjaSAwMDAwOjAxOjAwLjA6IHN1
cHBvcnRzIEQxIEQyCmtlcm5lbDogcGNpIDAwMDA6MDE6MDAuMDogUE1FIyBzdXBwb3J0ZWQg
ZnJvbSBEMSBEMiBEM2hvdCBEM2NvbGQKa2VybmVsOiBwY2kgMDAwMDowMTowMC4xOiBbMTAw
MjphYWUwXSB0eXBlIDAwIGNsYXNzIDB4MDQwMzAwIFBDSWUgTGVnYWN5IEVuZHBvaW50Cmtl
cm5lbDogcGNpIDAwMDA6MDE6MDAuMTogQkFSIDAgW21lbSAweGZjZTYwMDAwLTB4ZmNlNjNm
ZmYgNjRiaXRdCmtlcm5lbDogcGNpIDAwMDA6MDE6MDAuMTogc3VwcG9ydHMgRDEgRDIKa2Vy
bmVsOiBwY2kgMDAwMDowMTowMC4wOiBjYXA6IHBhcmVudCBDTVJUIDB4MDAgY2hpbGQgQ01S
VCAweDAwCmtlcm5lbDogcGNpIDAwMDA6MDE6MDAuMDogY2FwOiBwYXJlbnQgVF9QT1dFUl9P
TiAweDAwMGEgdXNlYyAodmFsIDB4MDUgc2NhbGUgMCkKa2VybmVsOiBwY2kgMDAwMDowMTow
MC4wOiBjYXA6IGNoaWxkICBUX1BPV0VSX09OIDB4MDBhYSB1c2VjICh2YWwgMHgxMSBzY2Fs
ZSAxKQprZXJuZWw6IHBjaSAwMDAwOjAxOjAwLjA6IHRfY29tbW9uX21vZGUgMHgwMCB0X3Bv
d2VyX29uIDB4YWEgbDFfMl90aHJlc2hvbGQgMHgwMGIwCmtlcm5lbDogcGNpIDAwMDA6MDE6
MDAuMDogZW5jb2RlZCBMVFJfTDEuMl9USFJFU0hPTEQgdmFsdWUgMHgwMGFjIHNjYWxlIDIK
a2VybmVsOiBwY2kgMDAwMDowMTowMC4wOiBMMVNTX0NUTDEgMHg0MGFjMDAwMCAocGFyZW50
IDB4MDAwMDAwMGYgY2hpbGQgMHgwMDAwMDAwZikKa2VybmVsOiBwY2kgMDAwMDowMTowMC4w
OiBMMVNTX0NUTDIgMHgwMDAwODkgKHBhcmVudCAweDAwMDAwMDI4IGNoaWxkIDB4MDAwMDAw
MjgpCmtlcm5lbDogcGNpIDAwMDA6MDE6MDAuMDogTDFTU19DVEwxIHBhcmVudCAweDAwMDAw
YSBjaGlsZCAweDAwMDAwYSAoTDEuMiBkaXNhYmxlZCkKa2VybmVsOiBwY2kgMDAwMDowMTow
MC4wOiBMMVNTX0NUTDIgcGFyZW50IDB4MDAwMDg5IGNoaWxkIDB4MDAwMDg5IChUX1BPV0VS
X09OIHVwZGF0ZWQpCmtlcm5lbDogcGNpIDAwMDA6MDE6MDAuMDogTDFTU19DVEwxIHBhcmVu
dCAweDQwYWMwMDBhIChDTVJUIHVwZGF0ZWQpCmtlcm5lbDogcGNpIDAwMDA6MDE6MDAuMDog
TDFTU19DVEwxIHBhcmVudCAweDQwYWMwMDBhIGNoaWxkIDB4NDBhYzAwMGEgKExUUl9MMS4y
X1RIUkVTSE9MRCB1cGRhdGVkKQprZXJuZWw6IHBjaSAwMDAwOjAxOjAwLjA6IEwxU1NfQ1RM
MSBwYXJlbnQgMHg0MGFjMDAwZiBjaGlsZCAweDQwYWMwMDBmIChMMS4yIHJlc3RvcmVkKQpr
ZXJuZWw6IHBjaSAwMDAwOjAwOjAxLjE6IFBDSSBicmlkZ2UgdG8gW2J1cyAwMV0Ka2VybmVs
OiBwY2kgMDAwMDowMjowMC4wOiBbMTBlYzo4MTY4XSB0eXBlIDAwIGNsYXNzIDB4MDIwMDAw
IFBDSWUgRW5kcG9pbnQKa2VybmVsOiBwY2kgMDAwMDowMjowMC4wOiBCQVIgMCBbaW8gIDB4
ZTAwMC0weGUwZmZdCmtlcm5lbDogcGNpIDAwMDA6MDI6MDAuMDogQkFSIDIgW21lbSAweGZj
ZDAwMDAwLTB4ZmNkMDBmZmYgNjRiaXRdCmtlcm5lbDogcGNpIDAwMDA6MDI6MDAuMDogQkFS
IDQgW21lbSAweGYwMzAwMDAwLTB4ZjAzMDNmZmYgNjRiaXQgcHJlZl0Ka2VybmVsOiBwY2kg
MDAwMDowMjowMC4wOiBzdXBwb3J0cyBEMSBEMgprZXJuZWw6IHBjaSAwMDAwOjAyOjAwLjA6
IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDEgRDIgRDNob3QgRDNjb2xkCmtlcm5lbDogcGNp
IDAwMDA6MDA6MDEuMjogUENJIGJyaWRnZSB0byBbYnVzIDAyXQprZXJuZWw6IHBjaSAwMDAw
OjAzOjAwLjA6IFsxNjhjOjAwNDJdIHR5cGUgMDAgY2xhc3MgMHgwMjgwMDAgUENJZSBFbmRw
b2ludAprZXJuZWw6IHBjaSAwMDAwOjAzOjAwLjA6IEJBUiAwIFttZW0gMHhmYzYwMDAwMC0w
eGZjN2ZmZmZmIDY0Yml0XQprZXJuZWw6IHBjaSAwMDAwOjAzOjAwLjA6IFBNRSMgc3VwcG9y
dGVkIGZyb20gRDAgRDNob3QgRDNjb2xkCmtlcm5lbDogcGNpIDAwMDA6MDM6MDAuMDogY2Fw
OiBwYXJlbnQgQ01SVCAweDAwIGNoaWxkIENNUlQgMHgzMgprZXJuZWw6IHBjaSAwMDAwOjAz
OjAwLjA6IGNhcDogcGFyZW50IFRfUE9XRVJfT04gMHgwMDBhIHVzZWMgKHZhbCAweDA1IHNj
YWxlIDApCmtlcm5lbDogcGNpIDAwMDA6MDM6MDAuMDogY2FwOiBjaGlsZCAgVF9QT1dFUl9P
TiAweDAwMGEgdXNlYyAodmFsIDB4MDUgc2NhbGUgMCkKa2VybmVsOiBwY2kgMDAwMDowMzow
MC4wOiB0X2NvbW1vbl9tb2RlIDB4MzIgdF9wb3dlcl9vbiAweDBhIGwxXzJfdGhyZXNob2xk
IDB4MDA0MgprZXJuZWw6IHBjaSAwMDAwOjAzOjAwLjA6IGVuY29kZWQgTFRSX0wxLjJfVEhS
RVNIT0xEIHZhbHVlIDB4MDA0MSBzY2FsZSAyCmtlcm5lbDogcGNpIDAwMDA6MDM6MDAuMDog
TDFTU19DVEwxIDB4NDA0MTMyMDAgKHBhcmVudCAweDYwMDEwMDAwIGNoaWxkIDB4MDAwMDAw
MDApCmtlcm5lbDogcGNpIDAwMDA6MDM6MDAuMDogTDFTU19DVEwyIDB4MDAwMDI4IChwYXJl
bnQgMHgwMDAwMDAyOCBjaGlsZCAweDAwMDAwMDI4KQprZXJuZWw6IHBjaSAwMDAwOjAzOjAw
LjA6IGN1cjogcGFyZW50IENNUlQgMCB1c2VjCmtlcm5lbDogcGNpIDAwMDA6MDM6MDAuMDog
Y3VyOiBwYXJlbnQgTFRSX0wxLjJfVEhSRVNIT0xEIHZhbHVlIDB4MDAwMSBzY2FsZSAzIGRl
Y29kZWQgMHgwMDAwMDA4MDAwIG5zCmtlcm5lbDogcGNpIDAwMDA6MDM6MDAuMDogY3VyOiBj
aGlsZCAgTFRSX0wxLjJfVEhSRVNIT0xEIHZhbHVlIDB4MDAwMCBzY2FsZSAwIGRlY29kZWQg
MHgwMDAwMDAwMDAwIG5zCmtlcm5lbDogcGNpIDAwMDA6MDM6MDAuMDogc2tpcHBpbmcgTDEu
MiBjb25maWcKa2VybmVsOiBwY2kgMDAwMDowMDowMS4zOiBQQ0kgYnJpZGdlIHRvIFtidXMg
MDNdCmtlcm5lbDogcGNpIDAwMDA6MDQ6MDAuMDogWzEwMjI6MTQ1YV0gdHlwZSAwMCBjbGFz
cyAweDEzMDAwMCBQQ0llIExlZ2FjeSBFbmRwb2ludAprZXJuZWw6IHBjaSAwMDAwOjA0OjAw
LjA6IGVuYWJsaW5nIEV4dGVuZGVkIFRhZ3MKa2VybmVsOiBwY2kgMDAwMDowNDowMC4yOiBb
MTAyMjoxNWRmXSB0eXBlIDAwIGNsYXNzIDB4MTA4MDAwIFBDSWUgRW5kcG9pbnQKa2VybmVs
OiBwY2kgMDAwMDowNDowMC4yOiBCQVIgMiBbbWVtIDB4ZmNhMDAwMDAtMHhmY2FmZmZmZl0K
a2VybmVsOiBwY2kgMDAwMDowNDowMC4yOiBCQVIgNSBbbWVtIDB4ZmNiNDgwMDAtMHhmY2I0
OWZmZl0Ka2VybmVsOiBwY2kgMDAwMDowNDowMC4yOiBlbmFibGluZyBFeHRlbmRlZCBUYWdz
Cmtlcm5lbDogcGNpIDAwMDA6MDQ6MDAuMzogWzEwMjI6MTVlMF0gdHlwZSAwMCBjbGFzcyAw
eDBjMDMzMCBQQ0llIEVuZHBvaW50Cmtlcm5lbDogcGNpIDAwMDA6MDQ6MDAuMzogQkFSIDAg
W21lbSAweGZjOTAwMDAwLTB4ZmM5ZmZmZmYgNjRiaXRdCmtlcm5lbDogcGNpIDAwMDA6MDQ6
MDAuMzogZW5hYmxpbmcgRXh0ZW5kZWQgVGFncwprZXJuZWw6IHBjaSAwMDAwOjA0OjAwLjM6
IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDNob3QgRDNjb2xkCmtlcm5lbDogcGNpIDAwMDA6
MDQ6MDAuNDogWzEwMjI6MTVlMV0gdHlwZSAwMCBjbGFzcyAweDBjMDMzMCBQQ0llIEVuZHBv
aW50Cmtlcm5lbDogcGNpIDAwMDA6MDQ6MDAuNDogQkFSIDAgW21lbSAweGZjODAwMDAwLTB4
ZmM4ZmZmZmYgNjRiaXRdCmtlcm5lbDogcGNpIDAwMDA6MDQ6MDAuNDogZW5hYmxpbmcgRXh0
ZW5kZWQgVGFncwprZXJuZWw6IHBjaSAwMDAwOjA0OjAwLjQ6IFBNRSMgc3VwcG9ydGVkIGZy
b20gRDAgRDNob3QgRDNjb2xkCmtlcm5lbDogcGNpIDAwMDA6MDQ6MDAuNTogWzEwMjI6MTVl
Ml0gdHlwZSAwMCBjbGFzcyAweDA0ODAwMCBQQ0llIEVuZHBvaW50Cmtlcm5lbDogcGNpIDAw
MDA6MDQ6MDAuNTogQkFSIDAgW21lbSAweGZjYjAwMDAwLTB4ZmNiM2ZmZmZdCmtlcm5lbDog
cGNpIDAwMDA6MDQ6MDAuNTogZW5hYmxpbmcgRXh0ZW5kZWQgVGFncwprZXJuZWw6IHBjaSAw
MDAwOjA0OjAwLjU6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDNob3QgRDNjb2xkCmtlcm5l
bDogcGNpIDAwMDA6MDQ6MDAuNjogWzEwMjI6MTVlM10gdHlwZSAwMCBjbGFzcyAweDA0MDMw
MCBQQ0llIEVuZHBvaW50Cmtlcm5lbDogcGNpIDAwMDA6MDQ6MDAuNjogQkFSIDAgW21lbSAw
eGZjYjQwMDAwLTB4ZmNiNDdmZmZdCmtlcm5lbDogcGNpIDAwMDA6MDQ6MDAuNjogZW5hYmxp
bmcgRXh0ZW5kZWQgVGFncwprZXJuZWw6IHBjaSAwMDAwOjA0OjAwLjY6IFBNRSMgc3VwcG9y
dGVkIGZyb20gRDAgRDNob3QgRDNjb2xkCmtlcm5lbDogcGNpIDAwMDA6MDA6MDguMTogUENJ
IGJyaWRnZSB0byBbYnVzIDA0XQprZXJuZWw6IHBjaSAwMDAwOjA1OjAwLjA6IFsxMDIyOjc5
MDFdIHR5cGUgMDAgY2xhc3MgMHgwMTA2MDEgUENJZSBFbmRwb2ludAprZXJuZWw6IHBjaSAw
MDAwOjA1OjAwLjA6IEJBUiA1IFttZW0gMHhmY2MwMDAwMC0weGZjYzAwN2ZmXQprZXJuZWw6
IHBjaSAwMDAwOjA1OjAwLjA6IGVuYWJsaW5nIEV4dGVuZGVkIFRhZ3MKa2VybmVsOiBwY2kg
MDAwMDowNTowMC4wOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQzaG90IEQzY29sZAprZXJuZWw6
IHBjaSAwMDAwOjAwOjA4LjI6IFBDSSBicmlkZ2UgdG8gW2J1cyAwNV0Ka2VybmVsOiBBQ1BJ
OiBQQ0k6IEludGVycnVwdCBsaW5rIExOS0EgY29uZmlndXJlZCBmb3IgSVJRIDAKa2VybmVs
OiBBQ1BJOiBQQ0k6IEludGVycnVwdCBsaW5rIExOS0IgY29uZmlndXJlZCBmb3IgSVJRIDAK
a2VybmVsOiBBQ1BJOiBQQ0k6IEludGVycnVwdCBsaW5rIExOS0MgY29uZmlndXJlZCBmb3Ig
SVJRIDAKa2VybmVsOiBBQ1BJOiBQQ0k6IEludGVycnVwdCBsaW5rIExOS0QgY29uZmlndXJl
ZCBmb3IgSVJRIDAKa2VybmVsOiBBQ1BJOiBQQ0k6IEludGVycnVwdCBsaW5rIExOS0UgY29u
ZmlndXJlZCBmb3IgSVJRIDAKa2VybmVsOiBBQ1BJOiBQQ0k6IEludGVycnVwdCBsaW5rIExO
S0YgY29uZmlndXJlZCBmb3IgSVJRIDAKa2VybmVsOiBBQ1BJOiBQQ0k6IEludGVycnVwdCBs
aW5rIExOS0cgY29uZmlndXJlZCBmb3IgSVJRIDAKa2VybmVsOiBBQ1BJOiBQQ0k6IEludGVy
cnVwdCBsaW5rIExOS0ggY29uZmlndXJlZCBmb3IgSVJRIDAKa2VybmVsOiBpb21tdTogRGVm
YXVsdCBkb21haW4gdHlwZTogVHJhbnNsYXRlZAprZXJuZWw6IGlvbW11OiBETUEgZG9tYWlu
IFRMQiBpbnZhbGlkYXRpb24gcG9saWN5OiBsYXp5IG1vZGUKa2VybmVsOiBTQ1NJIHN1YnN5
c3RlbSBpbml0aWFsaXplZAprZXJuZWw6IGxpYmF0YSB2ZXJzaW9uIDMuMDAgbG9hZGVkLgpr
ZXJuZWw6IEFDUEk6IGJ1cyB0eXBlIFVTQiByZWdpc3RlcmVkCmtlcm5lbDogdXNiY29yZTog
cmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciB1c2JmcwprZXJuZWw6IHVzYmNvcmU6
IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgaHViCmtlcm5lbDogdXNiY29yZTog
cmVnaXN0ZXJlZCBuZXcgZGV2aWNlIGRyaXZlciB1c2IKa2VybmVsOiBwcHNfY29yZTogTGlu
dXhQUFMgQVBJIHZlci4gMSByZWdpc3RlcmVkCmtlcm5lbDogcHBzX2NvcmU6IFNvZnR3YXJl
IHZlci4gNS4zLjYgLSBDb3B5cmlnaHQgMjAwNS0yMDA3IFJvZG9sZm8gR2lvbWV0dGkgPGdp
b21ldHRpQGxpbnV4Lml0PgprZXJuZWw6IFBUUCBjbG9jayBzdXBwb3J0IHJlZ2lzdGVyZWQK
a2VybmVsOiBFREFDIE1DOiBWZXI6IDMuMC4wCmtlcm5lbDogZWZpdmFyczogUmVnaXN0ZXJl
ZCBlZml2YXJzIG9wZXJhdGlvbnMKa2VybmVsOiBOZXRMYWJlbDogSW5pdGlhbGl6aW5nCmtl
cm5lbDogTmV0TGFiZWw6ICBkb21haW4gaGFzaCBzaXplID0gMTI4Cmtlcm5lbDogTmV0TGFi
ZWw6ICBwcm90b2NvbHMgPSBVTkxBQkVMRUQgQ0lQU092NCBDQUxJUFNPCmtlcm5lbDogTmV0
TGFiZWw6ICB1bmxhYmVsZWQgdHJhZmZpYyBhbGxvd2VkIGJ5IGRlZmF1bHQKa2VybmVsOiBt
Y3RwOiBtYW5hZ2VtZW50IGNvbXBvbmVudCB0cmFuc3BvcnQgcHJvdG9jb2wgY29yZQprZXJu
ZWw6IE5FVDogUmVnaXN0ZXJlZCBQRl9NQ1RQIHByb3RvY29sIGZhbWlseQprZXJuZWw6IFBD
STogVXNpbmcgQUNQSSBmb3IgSVJRIHJvdXRpbmcKa2VybmVsOiBQQ0k6IHBjaV9jYWNoZV9s
aW5lX3NpemUgc2V0IHRvIDY0IGJ5dGVzCmtlcm5lbDogZTgyMDogcmVzZXJ2ZSBSQU0gYnVm
ZmVyIFttZW0gMHgwOWQwMDAwMC0weDBiZmZmZmZmXQprZXJuZWw6IGU4MjA6IHJlc2VydmUg
UkFNIGJ1ZmZlciBbbWVtIDB4MGEyMDAwMDAtMHgwYmZmZmZmZl0Ka2VybmVsOiBlODIwOiBy
ZXNlcnZlIFJBTSBidWZmZXIgW21lbSAweGQ3MTc2MDAwLTB4ZDdmZmZmZmZdCmtlcm5lbDog
ZTgyMDogcmVzZXJ2ZSBSQU0gYnVmZmVyIFttZW0gMHhkOTUzMzAwMC0weGRiZmZmZmZmXQpr
ZXJuZWw6IGU4MjA6IHJlc2VydmUgUkFNIGJ1ZmZlciBbbWVtIDB4ZGE1YzUwMDAtMHhkYmZm
ZmZmZl0Ka2VybmVsOiBlODIwOiByZXNlcnZlIFJBTSBidWZmZXIgW21lbSAweGRmMDAwMDAw
LTB4ZGZmZmZmZmZdCmtlcm5lbDogZTgyMDogcmVzZXJ2ZSBSQU0gYnVmZmVyIFttZW0gMHgy
MWYzNDAwMDAtMHgyMWZmZmZmZmZdCmtlcm5lbDogcGNpIDAwMDA6MDE6MDAuMDogdmdhYXJi
OiBzZXR0aW5nIGFzIGJvb3QgVkdBIGRldmljZQprZXJuZWw6IHBjaSAwMDAwOjAxOjAwLjA6
IHZnYWFyYjogYnJpZGdlIGNvbnRyb2wgcG9zc2libGUKa2VybmVsOiBwY2kgMDAwMDowMTow
MC4wOiB2Z2FhcmI6IFZHQSBkZXZpY2UgYWRkZWQ6IGRlY29kZXM9aW8rbWVtLG93bnM9bm9u
ZSxsb2Nrcz1ub25lCmtlcm5lbDogdmdhYXJiOiBsb2FkZWQKa2VybmVsOiBocGV0MDogYXQg
TU1JTyAweGZlZDAwMDAwLCBJUlFzIDIsIDgsIDAKa2VybmVsOiBocGV0MDogMyBjb21wYXJh
dG9ycywgMzItYml0IDE0LjMxODE4MCBNSHogY291bnRlcgprZXJuZWw6IGNsb2Nrc291cmNl
OiBTd2l0Y2hlZCB0byBjbG9ja3NvdXJjZSB0c2MtZWFybHkKa2VybmVsOiBWRlM6IERpc2sg
cXVvdGFzIGRxdW90XzYuNi4wCmtlcm5lbDogVkZTOiBEcXVvdC1jYWNoZSBoYXNoIHRhYmxl
IGVudHJpZXM6IDUxMiAob3JkZXIgMCwgNDA5NiBieXRlcykKa2VybmVsOiBBcHBBcm1vcjog
QXBwQXJtb3IgRmlsZXN5c3RlbSBFbmFibGVkCmtlcm5lbDogcG5wOiBQblAgQUNQSSBpbml0
Cmtlcm5lbDogc3lzdGVtIDAwOjAwOiBbbWVtIDB4ZjgwMDAwMDAtMHhmYmZmZmZmZl0gaGFz
IGJlZW4gcmVzZXJ2ZWQKa2VybmVsOiBzeXN0ZW0gMDA6MDE6IFttZW0gMHgxMDAwMDAwMDAw
MDAwIHdpbmRvd10gY291bGQgbm90IGJlIHJlc2VydmVkCmtlcm5lbDogc3lzdGVtIDAwOjAz
OiBbaW8gIDB4MGEwMC0weDBhMGZdIGhhcyBiZWVuIHJlc2VydmVkCmtlcm5lbDogc3lzdGVt
IDAwOjAzOiBbaW8gIDB4MGExMC0weDBhMWZdIGhhcyBiZWVuIHJlc2VydmVkCmtlcm5lbDog
c3lzdGVtIDAwOjAzOiBbaW8gIDB4MGEyMC0weDBhMmZdIGhhcyBiZWVuIHJlc2VydmVkCmtl
cm5lbDogc3lzdGVtIDAwOjAzOiBbaW8gIDB4MGEzMC0weDBhM2ZdIGhhcyBiZWVuIHJlc2Vy
dmVkCmtlcm5lbDogc3lzdGVtIDAwOjAzOiBbaW8gIDB4MGE0MC0weDBhNGZdIGhhcyBiZWVu
IHJlc2VydmVkCmtlcm5lbDogc3lzdGVtIDAwOjAzOiBbaW8gIDB4MGE1MC0weDBhNWZdIGhh
cyBiZWVuIHJlc2VydmVkCmtlcm5lbDogc3lzdGVtIDAwOjAzOiBbaW8gIDB4MGE2MC0weDBh
NmZdIGhhcyBiZWVuIHJlc2VydmVkCmtlcm5lbDogc3lzdGVtIDAwOjAzOiBbaW8gIDB4MGE3
MC0weDBhN2ZdIGhhcyBiZWVuIHJlc2VydmVkCmtlcm5lbDogc3lzdGVtIDAwOjAzOiBbaW8g
IDB4MGE4OC0weDBhOTddIGhhcyBiZWVuIHJlc2VydmVkCmtlcm5lbDogc3lzdGVtIDAwOjAz
OiBbaW8gIDB4MGE5OC0weDBhYTddIGhhcyBiZWVuIHJlc2VydmVkCmtlcm5lbDogc3lzdGVt
IDAwOjA0OiBbaW8gIDB4MDRkMC0weDA0ZDFdIGhhcyBiZWVuIHJlc2VydmVkCmtlcm5lbDog
c3lzdGVtIDAwOjA0OiBbaW8gIDB4MDQwYl0gaGFzIGJlZW4gcmVzZXJ2ZWQKa2VybmVsOiBz
eXN0ZW0gMDA6MDQ6IFtpbyAgMHgwNGQ2XSBoYXMgYmVlbiByZXNlcnZlZAprZXJuZWw6IHN5
c3RlbSAwMDowNDogW2lvICAweDBjMDAtMHgwYzAxXSBoYXMgYmVlbiByZXNlcnZlZAprZXJu
ZWw6IHN5c3RlbSAwMDowNDogW2lvICAweDBjMTRdIGhhcyBiZWVuIHJlc2VydmVkCmtlcm5l
bDogc3lzdGVtIDAwOjA0OiBbaW8gIDB4MGM1MC0weDBjNTFdIGhhcyBiZWVuIHJlc2VydmVk
Cmtlcm5lbDogc3lzdGVtIDAwOjA0OiBbaW8gIDB4MGM1Ml0gaGFzIGJlZW4gcmVzZXJ2ZWQK
a2VybmVsOiBzeXN0ZW0gMDA6MDQ6IFtpbyAgMHgwYzZjXSBoYXMgYmVlbiByZXNlcnZlZApr
ZXJuZWw6IHN5c3RlbSAwMDowNDogW2lvICAweDBjNmZdIGhhcyBiZWVuIHJlc2VydmVkCmtl
cm5lbDogc3lzdGVtIDAwOjA0OiBbaW8gIDB4MGNkMC0weDBjZDFdIGhhcyBiZWVuIHJlc2Vy
dmVkCmtlcm5lbDogc3lzdGVtIDAwOjA0OiBbaW8gIDB4MGNkMi0weDBjZDNdIGhhcyBiZWVu
IHJlc2VydmVkCmtlcm5lbDogc3lzdGVtIDAwOjA0OiBbaW8gIDB4MGNkNC0weDBjZDVdIGhh
cyBiZWVuIHJlc2VydmVkCmtlcm5lbDogc3lzdGVtIDAwOjA0OiBbaW8gIDB4MGNkNi0weDBj
ZDddIGhhcyBiZWVuIHJlc2VydmVkCmtlcm5lbDogc3lzdGVtIDAwOjA0OiBbaW8gIDB4MGNk
OC0weDBjZGZdIGhhcyBiZWVuIHJlc2VydmVkCmtlcm5lbDogc3lzdGVtIDAwOjA0OiBbaW8g
IDB4MDgwMC0weDA4OWZdIGhhcyBiZWVuIHJlc2VydmVkCmtlcm5lbDogc3lzdGVtIDAwOjA0
OiBbaW8gIDB4MGIwMC0weDBiMGZdIGhhcyBiZWVuIHJlc2VydmVkCmtlcm5lbDogc3lzdGVt
IDAwOjA0OiBbaW8gIDB4MGIyMC0weDBiM2ZdIGhhcyBiZWVuIHJlc2VydmVkCmtlcm5lbDog
c3lzdGVtIDAwOjA0OiBbaW8gIDB4MDkwMC0weDA5MGZdIGhhcyBiZWVuIHJlc2VydmVkCmtl
cm5lbDogc3lzdGVtIDAwOjA0OiBbaW8gIDB4MDkxMC0weDA5MWZdIGhhcyBiZWVuIHJlc2Vy
dmVkCmtlcm5lbDogc3lzdGVtIDAwOjA0OiBbbWVtIDB4ZmVjMDAwMDAtMHhmZWMwMGZmZl0g
Y291bGQgbm90IGJlIHJlc2VydmVkCmtlcm5lbDogc3lzdGVtIDAwOjA0OiBbbWVtIDB4ZmVj
MDEwMDAtMHhmZWMwMWZmZl0gY291bGQgbm90IGJlIHJlc2VydmVkCmtlcm5lbDogc3lzdGVt
IDAwOjA0OiBbbWVtIDB4ZmVkYzAwMDAtMHhmZWRjMGZmZl0gaGFzIGJlZW4gcmVzZXJ2ZWQK
a2VybmVsOiBzeXN0ZW0gMDA6MDQ6IFttZW0gMHhmZWUwMDAwMC0weGZlZTAwZmZmXSBoYXMg
YmVlbiByZXNlcnZlZAprZXJuZWw6IHN5c3RlbSAwMDowNDogW21lbSAweGZlZDgwMDAwLTB4
ZmVkOGZmZmZdIGhhcyBiZWVuIHJlc2VydmVkCmtlcm5lbDogc3lzdGVtIDAwOjA0OiBbbWVt
IDB4ZmVjMTAwMDAtMHhmZWMxMGZmZl0gaGFzIGJlZW4gcmVzZXJ2ZWQKa2VybmVsOiBzeXN0
ZW0gMDA6MDQ6IFttZW0gMHhmZjAwMDAwMC0weGZmZmZmZmZmXSBoYXMgYmVlbiByZXNlcnZl
ZAprZXJuZWw6IHBucDogUG5QIEFDUEk6IGZvdW5kIDUgZGV2aWNlcwprZXJuZWw6IGNsb2Nr
c291cmNlOiBhY3BpX3BtOiBtYXNrOiAweGZmZmZmZiBtYXhfY3ljbGVzOiAweGZmZmZmZiwg
bWF4X2lkbGVfbnM6IDIwODU3MDEwMjQgbnMKa2VybmVsOiBORVQ6IFJlZ2lzdGVyZWQgUEZf
SU5FVCBwcm90b2NvbCBmYW1pbHkKa2VybmVsOiBJUCBpZGVudHMgaGFzaCB0YWJsZSBlbnRy
aWVzOiAxMzEwNzIgKG9yZGVyOiA4LCAxMDQ4NTc2IGJ5dGVzLCBsaW5lYXIpCmtlcm5lbDog
dGNwX2xpc3Rlbl9wb3J0YWRkcl9oYXNoIGhhc2ggdGFibGUgZW50cmllczogNDA5NiAob3Jk
ZXI6IDQsIDY1NTM2IGJ5dGVzLCBsaW5lYXIpCmtlcm5lbDogVGFibGUtcGVydHVyYiBoYXNo
IHRhYmxlIGVudHJpZXM6IDY1NTM2IChvcmRlcjogNiwgMjYyMTQ0IGJ5dGVzLCBsaW5lYXIp
Cmtlcm5lbDogVENQIGVzdGFibGlzaGVkIGhhc2ggdGFibGUgZW50cmllczogNjU1MzYgKG9y
ZGVyOiA3LCA1MjQyODggYnl0ZXMsIGxpbmVhcikKa2VybmVsOiBUQ1AgYmluZCBoYXNoIHRh
YmxlIGVudHJpZXM6IDY1NTM2IChvcmRlcjogOSwgMjA5NzE1MiBieXRlcywgbGluZWFyKQpr
ZXJuZWw6IFRDUDogSGFzaCB0YWJsZXMgY29uZmlndXJlZCAoZXN0YWJsaXNoZWQgNjU1MzYg
YmluZCA2NTUzNikKa2VybmVsOiBNUFRDUCB0b2tlbiBoYXNoIHRhYmxlIGVudHJpZXM6IDgx
OTIgKG9yZGVyOiA1LCAxOTY2MDggYnl0ZXMsIGxpbmVhcikKa2VybmVsOiBVRFAgaGFzaCB0
YWJsZSBlbnRyaWVzOiA0MDk2IChvcmRlcjogNiwgMjYyMTQ0IGJ5dGVzLCBsaW5lYXIpCmtl
cm5lbDogVURQLUxpdGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA0MDk2IChvcmRlcjogNiwgMjYy
MTQ0IGJ5dGVzLCBsaW5lYXIpCmtlcm5lbDogTkVUOiBSZWdpc3RlcmVkIFBGX1VOSVgvUEZf
TE9DQUwgcHJvdG9jb2wgZmFtaWx5Cmtlcm5lbDogTkVUOiBSZWdpc3RlcmVkIFBGX1hEUCBw
cm90b2NvbCBmYW1pbHkKa2VybmVsOiBwY2kgMDAwMDowMDowMS4xOiBQQ0kgYnJpZGdlIHRv
IFtidXMgMDFdCmtlcm5lbDogcGNpIDAwMDA6MDA6MDEuMTogICBicmlkZ2Ugd2luZG93IFtp
byAgMHhmMDAwLTB4ZmZmZl0Ka2VybmVsOiBwY2kgMDAwMDowMDowMS4xOiAgIGJyaWRnZSB3
aW5kb3cgW21lbSAweGZjZTAwMDAwLTB4ZmNlZmZmZmZdCmtlcm5lbDogcGNpIDAwMDA6MDA6
MDEuMTogICBicmlkZ2Ugd2luZG93IFttZW0gMHhlMDAwMDAwMC0weGYwMWZmZmZmIDY0Yml0
IHByZWZdCmtlcm5lbDogcGNpIDAwMDA6MDA6MDEuMjogUENJIGJyaWRnZSB0byBbYnVzIDAy
XQprZXJuZWw6IHBjaSAwMDAwOjAwOjAxLjI6ICAgYnJpZGdlIHdpbmRvdyBbaW8gIDB4ZTAw
MC0weGVmZmZdCmtlcm5lbDogcGNpIDAwMDA6MDA6MDEuMjogICBicmlkZ2Ugd2luZG93IFtt
ZW0gMHhmY2QwMDAwMC0weGZjZGZmZmZmXQprZXJuZWw6IHBjaSAwMDAwOjAwOjAxLjI6ICAg
YnJpZGdlIHdpbmRvdyBbbWVtIDB4ZjAzMDAwMDAtMHhmMDNmZmZmZiA2NGJpdCBwcmVmXQpr
ZXJuZWw6IHBjaSAwMDAwOjAwOjAxLjM6IFBDSSBicmlkZ2UgdG8gW2J1cyAwM10Ka2VybmVs
OiBwY2kgMDAwMDowMDowMS4zOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweGZjNjAwMDAwLTB4
ZmM3ZmZmZmZdCmtlcm5lbDogcGNpIDAwMDA6MDA6MDguMTogUENJIGJyaWRnZSB0byBbYnVz
IDA0XQprZXJuZWw6IHBjaSAwMDAwOjAwOjA4LjE6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4
ZmM4MDAwMDAtMHhmY2JmZmZmZl0Ka2VybmVsOiBwY2kgMDAwMDowMDowOC4yOiBQQ0kgYnJp
ZGdlIHRvIFtidXMgMDVdCmtlcm5lbDogcGNpIDAwMDA6MDA6MDguMjogICBicmlkZ2Ugd2lu
ZG93IFttZW0gMHhmY2MwMDAwMC0weGZjY2ZmZmZmXQprZXJuZWw6IHBjaV9idXMgMDAwMDow
MDogcmVzb3VyY2UgNCBbaW8gIDB4MDAwMC0weDAzYWYgd2luZG93XQprZXJuZWw6IHBjaV9i
dXMgMDAwMDowMDogcmVzb3VyY2UgNSBbaW8gIDB4MDNlMC0weDBjZjcgd2luZG93XQprZXJu
ZWw6IHBjaV9idXMgMDAwMDowMDogcmVzb3VyY2UgNiBbaW8gIDB4MDNiMC0weDAzZGYgd2lu
ZG93XQprZXJuZWw6IHBjaV9idXMgMDAwMDowMDogcmVzb3VyY2UgNyBbaW8gIDB4MGQwMC0w
eGZmZmYgd2luZG93XQprZXJuZWw6IHBjaV9idXMgMDAwMDowMDogcmVzb3VyY2UgOCBbbWVt
IDB4MDAwYTAwMDAtMHgwMDBkZmZmZiB3aW5kb3ddCmtlcm5lbDogcGNpX2J1cyAwMDAwOjAw
OiByZXNvdXJjZSA5IFttZW0gMHhlMDAwMDAwMC0weGZlYzAyZmZmIHdpbmRvd10Ka2VybmVs
OiBwY2lfYnVzIDAwMDA6MDA6IHJlc291cmNlIDEwIFttZW0gMHhmZWUwMDAwMC0weGZmZmZm
ZmZmIHdpbmRvd10Ka2VybmVsOiBwY2lfYnVzIDAwMDA6MDE6IHJlc291cmNlIDAgW2lvICAw
eGYwMDAtMHhmZmZmXQprZXJuZWw6IHBjaV9idXMgMDAwMDowMTogcmVzb3VyY2UgMSBbbWVt
IDB4ZmNlMDAwMDAtMHhmY2VmZmZmZl0Ka2VybmVsOiBwY2lfYnVzIDAwMDA6MDE6IHJlc291
cmNlIDIgW21lbSAweGUwMDAwMDAwLTB4ZjAxZmZmZmYgNjRiaXQgcHJlZl0Ka2VybmVsOiBw
Y2lfYnVzIDAwMDA6MDI6IHJlc291cmNlIDAgW2lvICAweGUwMDAtMHhlZmZmXQprZXJuZWw6
IHBjaV9idXMgMDAwMDowMjogcmVzb3VyY2UgMSBbbWVtIDB4ZmNkMDAwMDAtMHhmY2RmZmZm
Zl0Ka2VybmVsOiBwY2lfYnVzIDAwMDA6MDI6IHJlc291cmNlIDIgW21lbSAweGYwMzAwMDAw
LTB4ZjAzZmZmZmYgNjRiaXQgcHJlZl0Ka2VybmVsOiBwY2lfYnVzIDAwMDA6MDM6IHJlc291
cmNlIDEgW21lbSAweGZjNjAwMDAwLTB4ZmM3ZmZmZmZdCmtlcm5lbDogcGNpX2J1cyAwMDAw
OjA0OiByZXNvdXJjZSAxIFttZW0gMHhmYzgwMDAwMC0weGZjYmZmZmZmXQprZXJuZWw6IHBj
aV9idXMgMDAwMDowNTogcmVzb3VyY2UgMSBbbWVtIDB4ZmNjMDAwMDAtMHhmY2NmZmZmZl0K
a2VybmVsOiBwY2kgMDAwMDowMTowMC4xOiBEMCBwb3dlciBzdGF0ZSBkZXBlbmRzIG9uIDAw
MDA6MDE6MDAuMAprZXJuZWw6IHBjaSAwMDAwOjAyOjAwLjA6IENMUyBtaXNtYXRjaCAoNjQg
IT0gMTYwKSwgdXNpbmcgNjQgYnl0ZXMKa2VybmVsOiBwY2kgMDAwMDowNDowMC4zOiBleHRl
bmRpbmcgZGVsYXkgYWZ0ZXIgcG93ZXItb24gZnJvbSBEM2hvdCB0byAyMCBtc2VjCmtlcm5l
bDogcGNpIDAwMDA6MDQ6MDAuNDogZXh0ZW5kaW5nIGRlbGF5IGFmdGVyIHBvd2VyLW9uIGZy
b20gRDNob3QgdG8gMjAgbXNlYwprZXJuZWw6IHBjaSAwMDAwOjAwOjAwLjI6IEFNRC1WaTog
SU9NTVUgcGVyZm9ybWFuY2UgY291bnRlcnMgc3VwcG9ydGVkCmtlcm5lbDogVW5wYWNraW5n
IGluaXRyYW1mcy4uLgprZXJuZWw6IHBjaSAwMDAwOjAwOjAwLjA6IEFkZGluZyB0byBpb21t
dSBncm91cCAwCmtlcm5lbDogcGNpIDAwMDA6MDA6MDEuMDogQWRkaW5nIHRvIGlvbW11IGdy
b3VwIDEKa2VybmVsOiBwY2kgMDAwMDowMDowMS4xOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAg
MgprZXJuZWw6IHBjaSAwMDAwOjAwOjAxLjI6IEFkZGluZyB0byBpb21tdSBncm91cCAzCmtl
cm5lbDogcGNpIDAwMDA6MDA6MDEuMzogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDQKa2VybmVs
OiBwY2kgMDAwMDowMDowOC4wOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgNQprZXJuZWw6IHBj
aSAwMDAwOjAwOjA4LjE6IEFkZGluZyB0byBpb21tdSBncm91cCA1Cmtlcm5lbDogcGNpIDAw
MDA6MDA6MDguMjogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDUKa2VybmVsOiBwY2kgMDAwMDow
MDoxNC4wOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgNgprZXJuZWw6IHBjaSAwMDAwOjAwOjE0
LjM6IEFkZGluZyB0byBpb21tdSBncm91cCA2Cmtlcm5lbDogcGNpIDAwMDA6MDA6MTguMDog
QWRkaW5nIHRvIGlvbW11IGdyb3VwIDcKa2VybmVsOiBwY2kgMDAwMDowMDoxOC4xOiBBZGRp
bmcgdG8gaW9tbXUgZ3JvdXAgNwprZXJuZWw6IHBjaSAwMDAwOjAwOjE4LjI6IEFkZGluZyB0
byBpb21tdSBncm91cCA3Cmtlcm5lbDogcGNpIDAwMDA6MDA6MTguMzogQWRkaW5nIHRvIGlv
bW11IGdyb3VwIDcKa2VybmVsOiBwY2kgMDAwMDowMDoxOC40OiBBZGRpbmcgdG8gaW9tbXUg
Z3JvdXAgNwprZXJuZWw6IHBjaSAwMDAwOjAwOjE4LjU6IEFkZGluZyB0byBpb21tdSBncm91
cCA3Cmtlcm5lbDogcGNpIDAwMDA6MDA6MTguNjogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDcK
a2VybmVsOiBwY2kgMDAwMDowMDoxOC43OiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgNwprZXJu
ZWw6IHBjaSAwMDAwOjAxOjAwLjA6IEFkZGluZyB0byBpb21tdSBncm91cCA4Cmtlcm5lbDog
cGNpIDAwMDA6MDE6MDAuMTogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDgKa2VybmVsOiBwY2kg
MDAwMDowMjowMC4wOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgOQprZXJuZWw6IHBjaSAwMDAw
OjAzOjAwLjA6IEFkZGluZyB0byBpb21tdSBncm91cCAxMAprZXJuZWw6IHBjaSAwMDAwOjA0
OjAwLjA6IEFkZGluZyB0byBpb21tdSBncm91cCA1Cmtlcm5lbDogcGNpIDAwMDA6MDQ6MDAu
MjogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDUKa2VybmVsOiBwY2kgMDAwMDowNDowMC4zOiBB
ZGRpbmcgdG8gaW9tbXUgZ3JvdXAgNQprZXJuZWw6IHBjaSAwMDAwOjA0OjAwLjQ6IEFkZGlu
ZyB0byBpb21tdSBncm91cCA1Cmtlcm5lbDogcGNpIDAwMDA6MDQ6MDAuNTogQWRkaW5nIHRv
IGlvbW11IGdyb3VwIDUKa2VybmVsOiBwY2kgMDAwMDowNDowMC42OiBBZGRpbmcgdG8gaW9t
bXUgZ3JvdXAgNQprZXJuZWw6IHBjaSAwMDAwOjA1OjAwLjA6IEFkZGluZyB0byBpb21tdSBn
cm91cCA1Cmtlcm5lbDogQU1ELVZpOiBFeHRlbmRlZCBmZWF0dXJlcyAoMHg0Zjc3ZWYyMjI5
NGFkYSwgMHgwKTogUFBSIE5YIEdUIElBIEdBIFBDIEdBX3ZBUElDCmtlcm5lbDogQU1ELVZp
OiBJbnRlcnJ1cHQgcmVtYXBwaW5nIGVuYWJsZWQKa2VybmVsOiBBTUQtVmk6IFZpcnR1YWwg
QVBJQyBlbmFibGVkCmtlcm5lbDogUENJLURNQTogVXNpbmcgc29mdHdhcmUgYm91bmNlIGJ1
ZmZlcmluZyBmb3IgSU8gKFNXSU9UTEIpCmtlcm5lbDogc29mdHdhcmUgSU8gVExCOiBtYXBw
ZWQgW21lbSAweDAwMDAwMDAwZDI5YmQwMDAtMHgwMDAwMDAwMGQ2OWJkMDAwXSAoNjRNQikK
a2VybmVsOiBwZXJmL2FtZF9pb21tdTogRGV0ZWN0ZWQgQU1EIElPTU1VICMwICgyIGJhbmtz
LCA0IGNvdW50ZXJzL2JhbmspLgprZXJuZWw6IEluaXRpYWxpc2Ugc3lzdGVtIHRydXN0ZWQg
a2V5cmluZ3MKa2VybmVsOiBLZXkgdHlwZSBibGFja2xpc3QgcmVnaXN0ZXJlZAprZXJuZWw6
IHdvcmtpbmdzZXQ6IHRpbWVzdGFtcF9iaXRzPTM2IG1heF9vcmRlcj0yMSBidWNrZXRfb3Jk
ZXI9MAprZXJuZWw6IHNxdWFzaGZzOiB2ZXJzaW9uIDQuMCAoMjAwOS8wMS8zMSkgUGhpbGxp
cCBMb3VnaGVyCmtlcm5lbDogZnVzZTogaW5pdCAoQVBJIHZlcnNpb24gNy40NCkKa2VybmVs
OiBpbnRlZ3JpdHk6IFBsYXRmb3JtIEtleXJpbmcgaW5pdGlhbGl6ZWQKa2VybmVsOiBpbnRl
Z3JpdHk6IE1hY2hpbmUga2V5cmluZyBpbml0aWFsaXplZAprZXJuZWw6IEtleSB0eXBlIGFz
eW1tZXRyaWMgcmVnaXN0ZXJlZAprZXJuZWw6IEFzeW1tZXRyaWMga2V5IHBhcnNlciAneDUw
OScgcmVnaXN0ZXJlZAprZXJuZWw6IEJsb2NrIGxheWVyIFNDU0kgZ2VuZXJpYyAoYnNnKSBk
cml2ZXIgdmVyc2lvbiAwLjQgbG9hZGVkIChtYWpvciAyNDMpCmtlcm5lbDogaW8gc2NoZWR1
bGVyIG1xLWRlYWRsaW5lIHJlZ2lzdGVyZWQKa2VybmVsOiBsZWR0cmlnLWNwdTogcmVnaXN0
ZXJlZCB0byBpbmRpY2F0ZSBhY3Rpdml0eSBvbiBDUFVzCmtlcm5lbDogcGNpZXBvcnQgMDAw
MDowMDowMS4xOiBQTUU6IFNpZ25hbGluZyB3aXRoIElSUSAyNgprZXJuZWw6IHBjaWVwb3J0
IDAwMDA6MDA6MDEuMTogQUVSOiBlbmFibGVkIHdpdGggSVJRIDI2Cmtlcm5lbDogcGNpZXBv
cnQgMDAwMDowMDowMS4yOiBQTUU6IFNpZ25hbGluZyB3aXRoIElSUSAyNwprZXJuZWw6IHBj
aWVwb3J0IDAwMDA6MDA6MDEuMjogQUVSOiBlbmFibGVkIHdpdGggSVJRIDI3Cmtlcm5lbDog
cGNpZXBvcnQgMDAwMDowMDowMS4zOiBQTUU6IFNpZ25hbGluZyB3aXRoIElSUSAyOAprZXJu
ZWw6IHBjaWVwb3J0IDAwMDA6MDA6MDEuMzogQUVSOiBlbmFibGVkIHdpdGggSVJRIDI4Cmtl
cm5lbDogcGNpZXBvcnQgMDAwMDowMDowOC4xOiBQTUU6IFNpZ25hbGluZyB3aXRoIElSUSAy
OQprZXJuZWw6IHBjaWVwb3J0IDAwMDA6MDA6MDguMjogUE1FOiBTaWduYWxpbmcgd2l0aCBJ
UlEgMzAKa2VybmVsOiBpbnB1dDogUG93ZXIgQnV0dG9uIGFzIC9kZXZpY2VzL0xOWFNZU1RN
OjAwL0xOWFNZQlVTOjAwL1BOUDBDMEM6MDAvaW5wdXQvaW5wdXQwCmtlcm5lbDogQUNQSTog
YnV0dG9uOiBQb3dlciBCdXR0b24gW1BXUkJdCmtlcm5lbDogaW5wdXQ6IFBvd2VyIEJ1dHRv
biBhcyAvZGV2aWNlcy9MTlhTWVNUTTowMC9MTlhQV1JCTjowMC9pbnB1dC9pbnB1dDEKa2Vy
bmVsOiBBQ1BJOiBidXR0b246IFBvd2VyIEJ1dHRvbiBbUFdSRl0Ka2VybmVsOiBNb25pdG9y
LU13YWl0IHdpbGwgYmUgdXNlZCB0byBlbnRlciBDLTEgc3RhdGUKa2VybmVsOiBDb3VsZCBu
b3QgcmV0cmlldmUgcGVyZiBjb3VudGVycyAoLTE5KQprZXJuZWw6IFNlcmlhbDogODI1MC8x
NjU1MCBkcml2ZXIsIDMyIHBvcnRzLCBJUlEgc2hhcmluZyBlbmFibGVkCmtlcm5lbDogTGlu
dXggYWdwZ2FydCBpbnRlcmZhY2UgdjAuMTAzCmtlcm5lbDogcGNpIDAwMDA6MDA6MDAuMjog
UmVzb3VyY2VzIHByZXNlbnQgYmVmb3JlIHByb2JpbmcKa2VybmVsOiBmYmNvbjogVGFraW5n
IG92ZXIgY29uc29sZQprZXJuZWw6IEZyZWVpbmcgaW5pdHJkIG1lbW9yeTogMTAyMDQ4Swpr
ZXJuZWw6IHRwbV9jcmIgTVNGVDAxMDE6MDA6IERpc2FibGluZyBod3JuZwprZXJuZWw6IEFD
UEk6IGJ1cyB0eXBlIGRybV9jb25uZWN0b3IgcmVnaXN0ZXJlZAprZXJuZWw6IGxvb3A6IG1v
ZHVsZSBsb2FkZWQKa2VybmVsOiB0dW46IFVuaXZlcnNhbCBUVU4vVEFQIGRldmljZSBkcml2
ZXIsIDEuNgprZXJuZWw6IFBQUCBnZW5lcmljIGRyaXZlciB2ZXJzaW9uIDIuNC4yCmtlcm5l
bDogeGhjaV9oY2QgMDAwMDowNDowMC4zOiB4SENJIEhvc3QgQ29udHJvbGxlcgprZXJuZWw6
IHhoY2lfaGNkIDAwMDA6MDQ6MDAuMzogbmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWdu
ZWQgYnVzIG51bWJlciAxCmtlcm5lbDogeGhjaV9oY2QgMDAwMDowNDowMC4zOiBoY2MgcGFy
YW1zIDB4MDI3MGZmZTUgaGNpIHZlcnNpb24gMHgxMTAgcXVpcmtzIDB4MDAwNDAwMDg0MDAw
MDAxMAprZXJuZWw6IHhoY2lfaGNkIDAwMDA6MDQ6MDAuMzogeEhDSSBIb3N0IENvbnRyb2xs
ZXIKa2VybmVsOiB4aGNpX2hjZCAwMDAwOjA0OjAwLjM6IG5ldyBVU0IgYnVzIHJlZ2lzdGVy
ZWQsIGFzc2lnbmVkIGJ1cyBudW1iZXIgMgprZXJuZWw6IHhoY2lfaGNkIDAwMDA6MDQ6MDAu
MzogSG9zdCBzdXBwb3J0cyBVU0IgMy4xIEVuaGFuY2VkIFN1cGVyU3BlZWQKa2VybmVsOiB1
c2IgdXNiMTogTmV3IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTFkNmIsIGlkUHJvZHVj
dD0wMDAyLCBiY2REZXZpY2U9IDYuMTYKa2VybmVsOiB1c2IgdXNiMTogTmV3IFVTQiBkZXZp
Y2Ugc3RyaW5nczogTWZyPTMsIFByb2R1Y3Q9MiwgU2VyaWFsTnVtYmVyPTEKa2VybmVsOiB1
c2IgdXNiMTogUHJvZHVjdDogeEhDSSBIb3N0IENvbnRyb2xsZXIKa2VybmVsOiB1c2IgdXNi
MTogTWFudWZhY3R1cmVyOiBMaW51eCA2LjE2LjAtcmM0KyB4aGNpLWhjZAprZXJuZWw6IHVz
YiB1c2IxOiBTZXJpYWxOdW1iZXI6IDAwMDA6MDQ6MDAuMwprZXJuZWw6IGh1YiAxLTA6MS4w
OiBVU0IgaHViIGZvdW5kCmtlcm5lbDogaHViIDEtMDoxLjA6IDQgcG9ydHMgZGV0ZWN0ZWQK
a2VybmVsOiB1c2IgdXNiMjogV2UgZG9uJ3Qga25vdyB0aGUgYWxnb3JpdGhtcyBmb3IgTFBN
IGZvciB0aGlzIGhvc3QsIGRpc2FibGluZyBMUE0uCmtlcm5lbDogdXNiIHVzYjI6IE5ldyBV
U0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRvcj0xZDZiLCBpZFByb2R1Y3Q9MDAwMywgYmNkRGV2
aWNlPSA2LjE2Cmtlcm5lbDogdXNiIHVzYjI6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1m
cj0zLCBQcm9kdWN0PTIsIFNlcmlhbE51bWJlcj0xCmtlcm5lbDogdXNiIHVzYjI6IFByb2R1
Y3Q6IHhIQ0kgSG9zdCBDb250cm9sbGVyCmtlcm5lbDogdXNiIHVzYjI6IE1hbnVmYWN0dXJl
cjogTGludXggNi4xNi4wLXJjNCsgeGhjaS1oY2QKa2VybmVsOiB1c2IgdXNiMjogU2VyaWFs
TnVtYmVyOiAwMDAwOjA0OjAwLjMKa2VybmVsOiBodWIgMi0wOjEuMDogVVNCIGh1YiBmb3Vu
ZAprZXJuZWw6IGh1YiAyLTA6MS4wOiA0IHBvcnRzIGRldGVjdGVkCmtlcm5lbDogeGhjaV9o
Y2QgMDAwMDowNDowMC40OiB4SENJIEhvc3QgQ29udHJvbGxlcgprZXJuZWw6IHhoY2lfaGNk
IDAwMDA6MDQ6MDAuNDogbmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51
bWJlciAzCmtlcm5lbDogeGhjaV9oY2QgMDAwMDowNDowMC40OiBoY2MgcGFyYW1zIDB4MDI2
MGZmZTUgaGNpIHZlcnNpb24gMHgxMTAgcXVpcmtzIDB4MDAwNDAwMDg0MDAwMDAxMAprZXJu
ZWw6IHhoY2lfaGNkIDAwMDA6MDQ6MDAuNDogeEhDSSBIb3N0IENvbnRyb2xsZXIKa2VybmVs
OiB4aGNpX2hjZCAwMDAwOjA0OjAwLjQ6IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2ln
bmVkIGJ1cyBudW1iZXIgNAprZXJuZWw6IHhoY2lfaGNkIDAwMDA6MDQ6MDAuNDogSG9zdCBz
dXBwb3J0cyBVU0IgMy4xIEVuaGFuY2VkIFN1cGVyU3BlZWQKa2VybmVsOiB1c2IgdXNiMzog
TmV3IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTFkNmIsIGlkUHJvZHVjdD0wMDAyLCBi
Y2REZXZpY2U9IDYuMTYKa2VybmVsOiB1c2IgdXNiMzogTmV3IFVTQiBkZXZpY2Ugc3RyaW5n
czogTWZyPTMsIFByb2R1Y3Q9MiwgU2VyaWFsTnVtYmVyPTEKa2VybmVsOiB1c2IgdXNiMzog
UHJvZHVjdDogeEhDSSBIb3N0IENvbnRyb2xsZXIKa2VybmVsOiB1c2IgdXNiMzogTWFudWZh
Y3R1cmVyOiBMaW51eCA2LjE2LjAtcmM0KyB4aGNpLWhjZAprZXJuZWw6IHVzYiB1c2IzOiBT
ZXJpYWxOdW1iZXI6IDAwMDA6MDQ6MDAuNAprZXJuZWw6IGh1YiAzLTA6MS4wOiBVU0IgaHVi
IGZvdW5kCmtlcm5lbDogaHViIDMtMDoxLjA6IDEgcG9ydCBkZXRlY3RlZAprZXJuZWw6IHVz
YiB1c2I0OiBXZSBkb24ndCBrbm93IHRoZSBhbGdvcml0aG1zIGZvciBMUE0gZm9yIHRoaXMg
aG9zdCwgZGlzYWJsaW5nIExQTS4Ka2VybmVsOiB1c2IgdXNiNDogTmV3IFVTQiBkZXZpY2Ug
Zm91bmQsIGlkVmVuZG9yPTFkNmIsIGlkUHJvZHVjdD0wMDAzLCBiY2REZXZpY2U9IDYuMTYK
a2VybmVsOiB1c2IgdXNiNDogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTMsIFByb2R1
Y3Q9MiwgU2VyaWFsTnVtYmVyPTEKa2VybmVsOiB1c2IgdXNiNDogUHJvZHVjdDogeEhDSSBI
b3N0IENvbnRyb2xsZXIKa2VybmVsOiB1c2IgdXNiNDogTWFudWZhY3R1cmVyOiBMaW51eCA2
LjE2LjAtcmM0KyB4aGNpLWhjZAprZXJuZWw6IHVzYiB1c2I0OiBTZXJpYWxOdW1iZXI6IDAw
MDA6MDQ6MDAuNAprZXJuZWw6IGh1YiA0LTA6MS4wOiBVU0IgaHViIGZvdW5kCmtlcm5lbDog
aHViIDQtMDoxLjA6IDEgcG9ydCBkZXRlY3RlZAprZXJuZWw6IGk4MDQyOiBQTlA6IE5vIFBT
LzIgY29udHJvbGxlciBmb3VuZC4Ka2VybmVsOiBpODA0MjogUHJvYmluZyBwb3J0cyBkaXJl
Y3RseS4Ka2VybmVsOiBzZXJpbzogaTgwNDIgS0JEIHBvcnQgYXQgMHg2MCwweDY0IGlycSAx
Cmtlcm5lbDogbW91c2VkZXY6IFBTLzIgbW91c2UgZGV2aWNlIGNvbW1vbiBmb3IgYWxsIG1p
Y2UKa2VybmVsOiBydGNfY21vcyAwMDowMjogUlRDIGNhbiB3YWtlIGZyb20gUzQKa2VybmVs
OiBydGNfY21vcyAwMDowMjogcmVnaXN0ZXJlZCBhcyBydGMwCmtlcm5lbDogcnRjX2Ntb3Mg
MDA6MDI6IHNldHRpbmcgc3lzdGVtIGNsb2NrIHRvIDIwMjUtMDctMDVUMjE6Mjg6MDcgVVRD
ICgxNzUxNzUwODg3KQprZXJuZWw6IHJ0Y19jbW9zIDAwOjAyOiBhbGFybXMgdXAgdG8gb25l
IG1vbnRoLCB5M2ssIDExNCBieXRlcyBudnJhbQprZXJuZWw6IGkyY19kZXY6IGkyYyAvZGV2
IGVudHJpZXMgZHJpdmVyCmtlcm5lbDogZGV2aWNlLW1hcHBlcjogY29yZTogQ09ORklHX0lN
QV9ESVNBQkxFX0hUQUJMRSBpcyBkaXNhYmxlZC4gRHVwbGljYXRlIElNQSBtZWFzdXJlbWVu
dHMgd2lsbCBub3QgYmUgcmVjb3JkZWQgaW4gdGhlIElNQSBsb2cuCmtlcm5lbDogZGV2aWNl
LW1hcHBlcjogdWV2ZW50OiB2ZXJzaW9uIDEuMC4zCmtlcm5lbDogZGV2aWNlLW1hcHBlcjog
aW9jdGw6IDQuNTAuMC1pb2N0bCAoMjAyNS0wNC0yOCkgaW5pdGlhbGlzZWQ6IGRtLWRldmVs
QGxpc3RzLmxpbnV4LmRldgprZXJuZWw6IFtkcm1dIEluaXRpYWxpemVkIHNpbXBsZWRybSAx
LjAuMCBmb3Igc2ltcGxlLWZyYW1lYnVmZmVyLjAgb24gbWlub3IgMAprZXJuZWw6IENvbnNv
bGU6IHN3aXRjaGluZyB0byBjb2xvdXIgZnJhbWUgYnVmZmVyIGRldmljZSAyNDB4NjcKa2Vy
bmVsOiBzaW1wbGUtZnJhbWVidWZmZXIgc2ltcGxlLWZyYW1lYnVmZmVyLjA6IFtkcm1dIGZi
MDogc2ltcGxlZHJtZHJtZmIgZnJhbWUgYnVmZmVyIGRldmljZQprZXJuZWw6IGRyb3BfbW9u
aXRvcjogSW5pdGlhbGl6aW5nIG5ldHdvcmsgZHJvcCBtb25pdG9yIHNlcnZpY2UKa2VybmVs
OiBORVQ6IFJlZ2lzdGVyZWQgUEZfSU5FVDYgcHJvdG9jb2wgZmFtaWx5Cmtlcm5lbDogU2Vn
bWVudCBSb3V0aW5nIHdpdGggSVB2NgprZXJuZWw6IEluLXNpdHUgT0FNIChJT0FNKSB3aXRo
IElQdjYKa2VybmVsOiBORVQ6IFJlZ2lzdGVyZWQgUEZfUEFDS0VUIHByb3RvY29sIGZhbWls
eQprZXJuZWw6IEtleSB0eXBlIGRuc19yZXNvbHZlciByZWdpc3RlcmVkCmtlcm5lbDogeDg2
L2FtZDogUHJldmlvdXMgc3lzdGVtIHJlc2V0IHJlYXNvbiBbMHgwMDA4MDgwMF06IHNvZnR3
YXJlIHdyb3RlIDB4NiB0byByZXNldCBjb250cm9sIHJlZ2lzdGVyIDB4Q0Y5Cmtlcm5lbDog
bWljcm9jb2RlOiBDdXJyZW50IHJldmlzaW9uOiAweDA4MTA4MTAyCmtlcm5lbDogSVBJIHNo
b3J0aGFuZCBicm9hZGNhc3Q6IGVuYWJsZWQKa2VybmVsOiBzY2hlZF9jbG9jazogTWFya2lu
ZyBzdGFibGUgKDcyMTEyMzM0NSwgNDQ3OTA0KS0+KDcyNTg5NTUzNywgLTQzMjQyODgpCmtl
cm5lbDogcmVnaXN0ZXJlZCB0YXNrc3RhdHMgdmVyc2lvbiAxCmtlcm5lbDogTG9hZGluZyBj
b21waWxlZC1pbiBYLjUwOSBjZXJ0aWZpY2F0ZXMKa2VybmVsOiBMb2FkZWQgWC41MDkgY2Vy
dCAnQnVpbGQgdGltZSBhdXRvZ2VuZXJhdGVkIGtlcm5lbCBrZXk6IDYxNWI5NmY3OTNhZjVl
ZjJkZTk4NGE5Y2IxZTA3MmIxNDgzZTQ2MWUnCmtlcm5lbDogRGVtb3Rpb24gdGFyZ2V0cyBm
b3IgTm9kZSAwOiBudWxsCmtlcm5lbDogS2V5IHR5cGUgLmZzY3J5cHQgcmVnaXN0ZXJlZApr
ZXJuZWw6IEtleSB0eXBlIGZzY3J5cHQtcHJvdmlzaW9uaW5nIHJlZ2lzdGVyZWQKa2VybmVs
OiBLZXkgdHlwZSB0cnVzdGVkIHJlZ2lzdGVyZWQKa2VybmVsOiBLZXkgdHlwZSBlbmNyeXB0
ZWQgcmVnaXN0ZXJlZAprZXJuZWw6IEFwcEFybW9yOiBBcHBBcm1vciBzaGEyNTYgcG9saWN5
IGhhc2hpbmcgZW5hYmxlZAprZXJuZWw6IGludGVncml0eTogTG9hZGluZyBYLjUwOSBjZXJ0
aWZpY2F0ZTogVUVGSTpkYgprZXJuZWw6IGludGVncml0eTogTG9hZGVkIFguNTA5IGNlcnQg
J0xlbm92byBVRUZJIENBIDIwMTQ6IDRiOTFhNjg3MzJlYWVmZGQyYzhmZmZmYzZiMDI3ZWMz
NDQ5ZTljOGYnCmtlcm5lbDogaW50ZWdyaXR5OiBMb2FkaW5nIFguNTA5IGNlcnRpZmljYXRl
OiBVRUZJOmRiCmtlcm5lbDogaW50ZWdyaXR5OiBMb2FkZWQgWC41MDkgY2VydCAnVHJ1c3Qg
LSBMZW5vdm8gQ2VydGlmaWNhdGU6IGJjMTljY2Y2ODQ0NmMxOGI0YTA4ZGNlOWIxY2I0ZGVi
JwprZXJuZWw6IGludGVncml0eTogTG9hZGluZyBYLjUwOSBjZXJ0aWZpY2F0ZTogVUVGSTpk
YgprZXJuZWw6IGludGVncml0eTogTG9hZGVkIFguNTA5IGNlcnQgJ01pY3Jvc29mdCBDb3Jw
b3JhdGlvbiBVRUZJIENBIDIwMTE6IDEzYWRiZjQzMDliZDgyNzA5YzhjZDU0ZjMxNmVkNTIy
OTg4YTFiZDQnCmtlcm5lbDogaW50ZWdyaXR5OiBMb2FkaW5nIFguNTA5IGNlcnRpZmljYXRl
OiBVRUZJOmRiCmtlcm5lbDogaW50ZWdyaXR5OiBMb2FkZWQgWC41MDkgY2VydCAnTWljcm9z
b2Z0IFdpbmRvd3MgUHJvZHVjdGlvbiBQQ0EgMjAxMTogYTkyOTAyMzk4ZTE2YzQ5Nzc4Y2Q5
MGY5OWU0ZjlhZTE3YzU1YWY1MycKa2VybmVsOiBMb2FkaW5nIGNvbXBpbGVkLWluIG1vZHVs
ZSBYLjUwOSBjZXJ0aWZpY2F0ZXMKa2VybmVsOiBMb2FkZWQgWC41MDkgY2VydCAnQnVpbGQg
dGltZSBhdXRvZ2VuZXJhdGVkIGtlcm5lbCBrZXk6IDYxNWI5NmY3OTNhZjVlZjJkZTk4NGE5
Y2IxZTA3MmIxNDgzZTQ2MWUnCmtlcm5lbDogaW1hOiBBbGxvY2F0ZWQgaGFzaCBhbGdvcml0
aG06IHNoYTI1NgprZXJuZWw6IGltYTogTm8gYXJjaGl0ZWN0dXJlIHBvbGljaWVzIGZvdW5k
Cmtlcm5lbDogZXZtOiBJbml0aWFsaXNpbmcgRVZNIGV4dGVuZGVkIGF0dHJpYnV0ZXM6Cmtl
cm5lbDogZXZtOiBzZWN1cml0eS5zZWxpbnV4Cmtlcm5lbDogZXZtOiBzZWN1cml0eS5TTUFD
SzY0Cmtlcm5lbDogZXZtOiBzZWN1cml0eS5TTUFDSzY0RVhFQwprZXJuZWw6IGV2bTogc2Vj
dXJpdHkuU01BQ0s2NFRSQU5TTVVURQprZXJuZWw6IGV2bTogc2VjdXJpdHkuU01BQ0s2NE1N
QVAKa2VybmVsOiBldm06IHNlY3VyaXR5LmFwcGFybW9yCmtlcm5lbDogZXZtOiBzZWN1cml0
eS5pbWEKa2VybmVsOiBldm06IHNlY3VyaXR5LmNhcGFiaWxpdHkKa2VybmVsOiBldm06IEhN
QUMgYXR0cnM6IDB4MQprZXJuZWw6IFBNOiAgIE1hZ2ljIG51bWJlcjogMTo1MzY6NDk5Cmtl
cm5lbDogYWNwaV9jcHVmcmVxOiBvdmVycmlkaW5nIEJJT1MgcHJvdmlkZWQgX1BTRCBkYXRh
Cmtlcm5lbDogUkFTOiBDb3JyZWN0YWJsZSBFcnJvcnMgY29sbGVjdG9yIGluaXRpYWxpemVk
LgprZXJuZWw6IGNsazogRGlzYWJsaW5nIHVudXNlZCBjbG9ja3MKa2VybmVsOiBQTTogZ2Vu
cGQ6IERpc2FibGluZyB1bnVzZWQgcG93ZXIgZG9tYWlucwprZXJuZWw6IEZyZWVpbmcgdW51
c2VkIGRlY3J5cHRlZCBtZW1vcnk6IDIwMzZLCmtlcm5lbDogRnJlZWluZyB1bnVzZWQga2Vy
bmVsIGltYWdlIChpbml0bWVtKSBtZW1vcnk6IDQ5OTJLCmtlcm5lbDogV3JpdGUgcHJvdGVj
dGluZyB0aGUga2VybmVsIHJlYWQtb25seSBkYXRhOiAzNjg2NGsKa2VybmVsOiBGcmVlaW5n
IHVudXNlZCBrZXJuZWwgaW1hZ2UgKHRleHQvcm9kYXRhIGdhcCkgbWVtb3J5OiAxNDQwSwpr
ZXJuZWw6IEZyZWVpbmcgdW51c2VkIGtlcm5lbCBpbWFnZSAocm9kYXRhL2RhdGEgZ2FwKSBt
ZW1vcnk6IDI0OEsKa2VybmVsOiB4ODYvbW06IENoZWNrZWQgVytYIG1hcHBpbmdzOiBwYXNz
ZWQsIG5vIFcrWCBwYWdlcyBmb3VuZC4Ka2VybmVsOiBSdW4gL2luaXQgYXMgaW5pdCBwcm9j
ZXNzCmtlcm5lbDogICB3aXRoIGFyZ3VtZW50czoKa2VybmVsOiAgICAgL2luaXQKa2VybmVs
OiAgICAgc3BsYXNoCmtlcm5lbDogICB3aXRoIGVudmlyb25tZW50OgprZXJuZWw6ICAgICBI
T01FPS8Ka2VybmVsOiAgICAgVEVSTT1saW51eAprZXJuZWw6ICAgICBCT09UX0lNQUdFPS9i
b290L3ZtbGludXotNi4xNi4wLXJjNCsKa2VybmVsOiB1c2IgMy0xOiBuZXcgaGlnaC1zcGVl
ZCBVU0IgZGV2aWNlIG51bWJlciAyIHVzaW5nIHhoY2lfaGNkCmtlcm5lbDogdXNiIDEtNDog
bmV3IGhpZ2gtc3BlZWQgVVNCIGRldmljZSBudW1iZXIgMiB1c2luZyB4aGNpX2hjZAprZXJu
ZWw6IEFDUEk6IHZpZGVvOiBWaWRlbyBEZXZpY2UgW1ZHQV0gKG11bHRpLWhlYWQ6IHllcyAg
cm9tOiBubyAgcG9zdDogbm8pCmtlcm5lbDogaW5wdXQ6IFZpZGVvIEJ1cyBhcyAvZGV2aWNl
cy9MTlhTWVNUTTowMC9MTlhTWUJVUzowMC9QTlAwQTA4OjAwL2RldmljZTowMS9MTlhWSURF
TzowMC9pbnB1dC9pbnB1dDMKa2VybmVsOiBBQ1BJOiB2aWRlbzogVmlkZW8gRGV2aWNlIFtW
R0ExXSAobXVsdGktaGVhZDogeWVzICByb206IG5vICBwb3N0OiBubykKa2VybmVsOiBpbnB1
dDogVmlkZW8gQnVzIGFzIC9kZXZpY2VzL0xOWFNZU1RNOjAwL0xOWFNZQlVTOjAwL1BOUDBB
MDg6MDAvZGV2aWNlOjExL0xOWFZJREVPOjAxL2lucHV0L2lucHV0NAprZXJuZWw6IGFoY2kg
MDAwMDowNTowMC4wOiBBSENJIHZlcnMgMDAwMS4wMzAxLCAzMiBjb21tYW5kIHNsb3RzLCA2
IEdicHMsIFNBVEEgbW9kZQprZXJuZWw6IGFoY2kgMDAwMDowNTowMC4wOiAyLzIgcG9ydHMg
aW1wbGVtZW50ZWQgKHBvcnQgbWFzayAweDMpCmtlcm5lbDogYWhjaSAwMDAwOjA1OjAwLjA6
IGZsYWdzOiA2NGJpdCBuY3Egc250ZiBpbGNrIHBtIGxlZCBjbG8gb25seSBwbXAgZmJzIHBp
byBzbHVtIHBhcnQKa2VybmVsOiByODE2OSAwMDAwOjAyOjAwLjAgZXRoMDogUlRMODE2OGcv
ODExMWcsIDZjOjRiOjkwOmU3OmNmOjBiLCBYSUQgNGMwLCBJUlEgNDcKa2VybmVsOiByODE2
OSAwMDAwOjAyOjAwLjAgZXRoMDoganVtYm8gZmVhdHVyZXMgW2ZyYW1lczogOTE5NCBieXRl
cywgdHggY2hlY2tzdW1taW5nOiBrb10Ka2VybmVsOiBzY3NpIGhvc3QwOiBhaGNpCmtlcm5l
bDogc2NzaSBob3N0MTogYWhjaQprZXJuZWw6IGF0YTE6IFNBVEEgbWF4IFVETUEvMTMzIGFi
YXIgbTIwNDhAMHhmY2MwMDAwMCBwb3J0IDB4ZmNjMDAxMDAgaXJxIDQ0IGxwbS1wb2wgMwpr
ZXJuZWw6IGF0YTI6IFNBVEEgbWF4IFVETUEvMTMzIGFiYXIgbTIwNDhAMHhmY2MwMDAwMCBw
b3J0IDB4ZmNjMDAxODAgaXJxIDQ1IGxwbS1wb2wgMwprZXJuZWw6IHI4MTY5IDAwMDA6MDI6
MDAuMCBlbnAyczA6IHJlbmFtZWQgZnJvbSBldGgwCmtlcm5lbDogdXNiIDMtMTogTmV3IFVT
QiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTA1ZTMsIGlkUHJvZHVjdD0wNjEwLCBiY2REZXZp
Y2U9NjAuNTIKa2VybmVsOiB1c2IgMy0xOiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9
MCwgUHJvZHVjdD0xLCBTZXJpYWxOdW1iZXI9MAprZXJuZWw6IHVzYiAzLTE6IFByb2R1Y3Q6
IFVTQjIuMCBIdWIKa2VybmVsOiB1c2IgMS00OiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRW
ZW5kb3I9MDVlMywgaWRQcm9kdWN0PTA2MTAsIGJjZERldmljZT02MC41MgprZXJuZWw6IHVz
YiAxLTQ6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1mcj0wLCBQcm9kdWN0PTEsIFNlcmlh
bE51bWJlcj0wCmtlcm5lbDogdXNiIDEtNDogUHJvZHVjdDogVVNCMi4wIEh1YgprZXJuZWw6
IGh1YiAxLTQ6MS4wOiBVU0IgaHViIGZvdW5kCmtlcm5lbDogaHViIDEtNDoxLjA6IDMgcG9y
dHMgZGV0ZWN0ZWQKa2VybmVsOiBodWIgMy0xOjEuMDogVVNCIGh1YiBmb3VuZAprZXJuZWw6
IGh1YiAzLTE6MS4wOiAzIHBvcnRzIGRldGVjdGVkCmtlcm5lbDogdXNiOiBwb3J0IHBvd2Vy
IG1hbmFnZW1lbnQgbWF5IGJlIHVucmVsaWFibGUKa2VybmVsOiB1c2IgMy0xLjE6IG5ldyBm
dWxsLXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDMgdXNpbmcgeGhjaV9oY2QKa2VybmVsOiB1
c2IgMS00LjM6IG5ldyBoaWdoLXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDMgdXNpbmcgeGhj
aV9oY2QKa2VybmVsOiBhdGExOiBTQVRBIGxpbmsgdXAgNi4wIEdicHMgKFNTdGF0dXMgMTMz
IFNDb250cm9sIDMwMCkKa2VybmVsOiBhdGExLjAwOiBNb2RlbCAnU2Ftc3VuZyBTU0QgODYw
IEVWTyA1MDBHQicsIHJldiAnUlZUMDFCNlEnLCBhcHBseWluZyBxdWlya3M6IG5vbmNxdHJp
bSB6ZXJvYWZ0ZXJ0cmltIG5vbmNxb25hdGkgbm9scG1vbmF0aQprZXJuZWw6IGF0YTI6IFNB
VEEgbGluayB1cCAxLjUgR2JwcyAoU1N0YXR1cyAxMTMgU0NvbnRyb2wgMzAwKQprZXJuZWw6
IGF0YTEuMDA6IHN1cHBvcnRzIERSTSBmdW5jdGlvbnMgYW5kIG1heSBub3QgYmUgZnVsbHkg
YWNjZXNzaWJsZQprZXJuZWw6IGF0YTEuMDA6IEFUQS0xMTogU2Ftc3VuZyBTU0QgODYwIEVW
TyA1MDBHQiwgUlZUMDFCNlEsIG1heCBVRE1BLzEzMwprZXJuZWw6IGF0YTEuMDA6IDk3Njc3
MzE2OCBzZWN0b3JzLCBtdWx0aSAxOiBMQkE0OCBOQ1EgKGRlcHRoIDMyKSwgQUEKa2VybmVs
OiBhdGEyLjAwOiBBVEFQSTogSEwtRFQtU1QgRFZEUkFNIEdVRTFOLCBNRTAzLCBtYXggVURN
QS8xMzMKa2VybmVsOiBhdGEyLjAwOiBjb25maWd1cmVkIGZvciBVRE1BLzEzMwprZXJuZWw6
IGF0YTEuMDA6IEZlYXR1cmVzOiBUcnVzdCBEZXYtU2xlZXAgTkNRLXNuZHJjdgprZXJuZWw6
IGF0YTEuMDA6IHN1cHBvcnRzIERSTSBmdW5jdGlvbnMgYW5kIG1heSBub3QgYmUgZnVsbHkg
YWNjZXNzaWJsZQprZXJuZWw6IGF0YTEuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMTMzCmtl
cm5lbDogc2NzaSAwOjA6MDowOiBEaXJlY3QtQWNjZXNzICAgICBBVEEgICAgICBTYW1zdW5n
IFNTRCA4NjAgIDFCNlEgUFE6IDAgQU5TSTogNQprZXJuZWw6IHNkIDA6MDowOjA6IEF0dGFj
aGVkIHNjc2kgZ2VuZXJpYyBzZzAgdHlwZSAwCmtlcm5lbDogYXRhMS4wMDogRW5hYmxpbmcg
ZGlzY2FyZF96ZXJvZXNfZGF0YQprZXJuZWw6IHNkIDA6MDowOjA6IFtzZGFdIDk3Njc3MzE2
OCA1MTItYnl0ZSBsb2dpY2FsIGJsb2NrczogKDUwMCBHQi80NjYgR2lCKQprZXJuZWw6IHNk
IDA6MDowOjA6IFtzZGFdIFdyaXRlIFByb3RlY3QgaXMgb2ZmCmtlcm5lbDogc2QgMDowOjA6
MDogW3NkYV0gTW9kZSBTZW5zZTogMDAgM2EgMDAgMDAKa2VybmVsOiBzZCAwOjA6MDowOiBb
c2RhXSBXcml0ZSBjYWNoZTogZW5hYmxlZCwgcmVhZCBjYWNoZTogZW5hYmxlZCwgZG9lc24n
dCBzdXBwb3J0IERQTyBvciBGVUEKa2VybmVsOiBzZCAwOjA6MDowOiBbc2RhXSBQcmVmZXJy
ZWQgbWluaW11bSBJL08gc2l6ZSA1MTIgYnl0ZXMKa2VybmVsOiBzY3NpIDE6MDowOjA6IENE
LVJPTSAgICAgICAgICAgIEhMLURULVNUIERWRFJBTSBHVUUxTiAgICAgTUUwMyBQUTogMCBB
TlNJOiA1Cmtlcm5lbDogYXRhMS4wMDogRW5hYmxpbmcgZGlzY2FyZF96ZXJvZXNfZGF0YQpr
ZXJuZWw6ICBzZGE6IHNkYTEgc2RhMiBzZGEzIHNkYTQgc2RhNQprZXJuZWw6IHNkIDA6MDow
OjA6IFtzZGFdIHN1cHBvcnRzIFRDRyBPcGFsCmtlcm5lbDogc2QgMDowOjA6MDogW3NkYV0g
QXR0YWNoZWQgU0NTSSBkaXNrCmtlcm5lbDogdXNiIDEtNC4zOiBOZXcgVVNCIGRldmljZSBm
b3VuZCwgaWRWZW5kb3I9MGJkYSwgaWRQcm9kdWN0PTAxMjksIGJjZERldmljZT0zOS42MApr
ZXJuZWw6IHVzYiAxLTQuMzogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTEsIFByb2R1
Y3Q9MiwgU2VyaWFsTnVtYmVyPTMKa2VybmVsOiB1c2IgMS00LjM6IFByb2R1Y3Q6IFVTQjIu
MC1DUlcKa2VybmVsOiB1c2IgMS00LjM6IE1hbnVmYWN0dXJlcjogR2VuZXJpYwprZXJuZWw6
IHVzYiAxLTQuMzogU2VyaWFsTnVtYmVyOiAyMDEwMDIwMTM5NjAwMDAwMAprZXJuZWw6IHNy
IDE6MDowOjA6IFtzcjBdIHNjc2kzLW1tYyBkcml2ZTogMjR4LzI0eCB3cml0ZXIgZHZkLXJh
bSBjZC9ydyB4YS9mb3JtMiBjZGRhIHRyYXkKa2VybmVsOiBjZHJvbTogVW5pZm9ybSBDRC1S
T00gZHJpdmVyIFJldmlzaW9uOiAzLjIwCmtlcm5lbDogdXNiIDMtMS4xOiBOZXcgVVNCIGRl
dmljZSBmb3VuZCwgaWRWZW5kb3I9MDQ2ZCwgaWRQcm9kdWN0PWM1NDIsIGJjZERldmljZT0g
My4wOAprZXJuZWw6IHVzYiAzLTEuMTogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTEs
IFByb2R1Y3Q9MiwgU2VyaWFsTnVtYmVyPTAKa2VybmVsOiB1c2IgMy0xLjE6IFByb2R1Y3Q6
IFdpcmVsZXNzIFJlY2VpdmVyCmtlcm5lbDogdXNiIDMtMS4xOiBNYW51ZmFjdHVyZXI6IExv
Z2l0ZWNoCmtlcm5lbDogc3IgMTowOjA6MDogQXR0YWNoZWQgc2NzaSBDRC1ST00gc3IwCmtl
cm5lbDogc3IgMTowOjA6MDogQXR0YWNoZWQgc2NzaSBnZW5lcmljIHNnMSB0eXBlIDUKa2Vy
bmVsOiB1c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIHJ0c3hfdXNi
Cmtlcm5lbDogdHNjOiBSZWZpbmVkIFRTQyBjbG9ja3NvdXJjZSBjYWxpYnJhdGlvbjogMzU5
Ni4yMjUgTUh6Cmtlcm5lbDogY2xvY2tzb3VyY2U6IHRzYzogbWFzazogMHhmZmZmZmZmZmZm
ZmZmZmZmIG1heF9jeWNsZXM6IDB4MzNkNjY0ZjdiMGIsIG1heF9pZGxlX25zOiA0NDA3OTUy
NTk1MTEgbnMKa2VybmVsOiBjbG9ja3NvdXJjZTogU3dpdGNoZWQgdG8gY2xvY2tzb3VyY2Ug
dHNjCmtlcm5lbDogaGlkOiByYXcgSElEIGV2ZW50cyBkcml2ZXIgKEMpIEppcmkgS29zaW5h
Cmtlcm5lbDogdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciB1c2Jo
aWQKa2VybmVsOiB1c2JoaWQ6IFVTQiBISUQgY29yZSBkcml2ZXIKa2VybmVsOiBpbnB1dDog
TG9naXRlY2ggV2lyZWxlc3MgUmVjZWl2ZXIgTW91c2UgYXMgL2RldmljZXMvcGNpMDAwMDow
MC8wMDAwOjAwOjA4LjEvMDAwMDowNDowMC40L3VzYjMvMy0xLzMtMS4xLzMtMS4xOjEuMC8w
MDAzOjA0NkQ6QzU0Mi4wMDAxL2lucHV0L2lucHV0NQprZXJuZWw6IGhpZC1nZW5lcmljIDAw
MDM6MDQ2RDpDNTQyLjAwMDE6IGlucHV0LGhpZHJhdzA6IFVTQiBISUQgdjEuMTEgTW91c2Ug
W0xvZ2l0ZWNoIFdpcmVsZXNzIFJlY2VpdmVyXSBvbiB1c2ItMDAwMDowNDowMC40LTEuMS9p
bnB1dDAKa2VybmVsOiB1c2IgMy0xLjI6IG5ldyBmdWxsLXNwZWVkIFVTQiBkZXZpY2UgbnVt
YmVyIDQgdXNpbmcgeGhjaV9oY2QKa2VybmVsOiB1c2IgMy0xLjI6IE5ldyBVU0IgZGV2aWNl
IGZvdW5kLCBpZFZlbmRvcj0wNDZkLCBpZFByb2R1Y3Q9YzUzNCwgYmNkRGV2aWNlPTI5LjAx
Cmtlcm5lbDogdXNiIDMtMS4yOiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MSwgUHJv
ZHVjdD0yLCBTZXJpYWxOdW1iZXI9MAprZXJuZWw6IHVzYiAzLTEuMjogUHJvZHVjdDogVVNC
IFJlY2VpdmVyCmtlcm5lbDogdXNiIDMtMS4yOiBNYW51ZmFjdHVyZXI6IExvZ2l0ZWNoCmtl
cm5lbDogaW5wdXQ6IExvZ2l0ZWNoIFVTQiBSZWNlaXZlciBhcyAvZGV2aWNlcy9wY2kwMDAw
OjAwLzAwMDA6MDA6MDguMS8wMDAwOjA0OjAwLjQvdXNiMy8zLTEvMy0xLjIvMy0xLjI6MS4w
LzAwMDM6MDQ2RDpDNTM0LjAwMDIvaW5wdXQvaW5wdXQ2Cmtlcm5lbDogaGlkLWdlbmVyaWMg
MDAwMzowNDZEOkM1MzQuMDAwMjogaW5wdXQsaGlkcmF3MTogVVNCIEhJRCB2MS4xMSBLZXli
b2FyZCBbTG9naXRlY2ggVVNCIFJlY2VpdmVyXSBvbiB1c2ItMDAwMDowNDowMC40LTEuMi9p
bnB1dDAKa2VybmVsOiBpbnB1dDogTG9naXRlY2ggVVNCIFJlY2VpdmVyIE1vdXNlIGFzIC9k
ZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDowOC4xLzAwMDA6MDQ6MDAuNC91c2IzLzMtMS8z
LTEuMi8zLTEuMjoxLjEvMDAwMzowNDZEOkM1MzQuMDAwMy9pbnB1dC9pbnB1dDcKa2VybmVs
OiBpbnB1dDogTG9naXRlY2ggVVNCIFJlY2VpdmVyIENvbnN1bWVyIENvbnRyb2wgYXMgL2Rl
dmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjA4LjEvMDAwMDowNDowMC40L3VzYjMvMy0xLzMt
MS4yLzMtMS4yOjEuMS8wMDAzOjA0NkQ6QzUzNC4wMDAzL2lucHV0L2lucHV0OAprZXJuZWw6
IGlucHV0OiBMb2dpdGVjaCBVU0IgUmVjZWl2ZXIgU3lzdGVtIENvbnRyb2wgYXMgL2Rldmlj
ZXMvcGNpMDAwMDowMC8wMDAwOjAwOjA4LjEvMDAwMDowNDowMC40L3VzYjMvMy0xLzMtMS4y
LzMtMS4yOjEuMS8wMDAzOjA0NkQ6QzUzNC4wMDAzL2lucHV0L2lucHV0OQprZXJuZWw6IGhp
ZC1nZW5lcmljIDAwMDM6MDQ2RDpDNTM0LjAwMDM6IGlucHV0LGhpZGRldjAsaGlkcmF3Mjog
VVNCIEhJRCB2MS4xMSBNb3VzZSBbTG9naXRlY2ggVVNCIFJlY2VpdmVyXSBvbiB1c2ItMDAw
MDowNDowMC40LTEuMi9pbnB1dDEKa2VybmVsOiB1c2IgMy0xLjM6IG5ldyBmdWxsLXNwZWVk
IFVTQiBkZXZpY2UgbnVtYmVyIDUgdXNpbmcgeGhjaV9oY2QKa2VybmVsOiB1c2IgMy0xLjM6
IE5ldyBVU0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRvcj0wY2YzLCBpZFByb2R1Y3Q9ZTUwMCwg
YmNkRGV2aWNlPSAwLjAxCmtlcm5lbDogdXNiIDMtMS4zOiBOZXcgVVNCIGRldmljZSBzdHJp
bmdzOiBNZnI9MCwgUHJvZHVjdD0wLCBTZXJpYWxOdW1iZXI9MAprZXJuZWw6IGNsb2Nrc291
cmNlOiB0aW1la2VlcGluZyB3YXRjaGRvZyBvbiBDUFUwOiBNYXJraW5nIGNsb2Nrc291cmNl
ICd0c2MnIGFzIHVuc3RhYmxlIGJlY2F1c2UgdGhlIHNrZXcgaXMgdG9vIGxhcmdlOgprZXJu
ZWw6IGNsb2Nrc291cmNlOiAgICAgICAgICAgICAgICAgICAgICAgJ2hwZXQnIHdkX25zZWM6
IDUwNTQwNzk0OSB3ZF9ub3c6IDIyNWVlODQgd2RfbGFzdDogMWI3ODJkYSBtYXNrOiBmZmZm
ZmZmZgprZXJuZWw6IGNsb2Nrc291cmNlOiAgICAgICAgICAgICAgICAgICAgICAgJ3RzYycg
Y3NfbnNlYzogNTA0OTkwMDEwIGNzX25vdzogMTNmNzIxNWE0YyBjc19sYXN0OiAxMzhhZTI4
MzM4IG1hc2s6IGZmZmZmZmZmZmZmZmZmZmYKa2VybmVsOiBjbG9ja3NvdXJjZTogICAgICAg
ICAgICAgICAgICAgICAgIENsb2Nrc291cmNlICd0c2MnIHNrZXdlZCAtNDE3OTM5IG5zICgw
IG1zKSBvdmVyIHdhdGNoZG9nICdocGV0JyBpbnRlcnZhbCBvZiA1MDU0MDc5NDkgbnMgKDUw
NSBtcykKa2VybmVsOiBjbG9ja3NvdXJjZTogICAgICAgICAgICAgICAgICAgICAgICd0c2Mn
IGlzIGN1cnJlbnQgY2xvY2tzb3VyY2UuCmtlcm5lbDogdHNjOiBNYXJraW5nIFRTQyB1bnN0
YWJsZSBkdWUgdG8gY2xvY2tzb3VyY2Ugd2F0Y2hkb2cKa2VybmVsOiBUU0MgZm91bmQgdW5z
dGFibGUgYWZ0ZXIgYm9vdCwgbW9zdCBsaWtlbHkgZHVlIHRvIGJyb2tlbiBCSU9TLiBVc2Ug
J3RzYz11bnN0YWJsZScuCmtlcm5lbDogc2NoZWRfY2xvY2s6IE1hcmtpbmcgdW5zdGFibGUg
KDI1OTQwNTU2NTIsIDQ0NzgzNCk8LSgyNTk4Nzc1NjAyLCAtNDMyNDI4OCkKa2VybmVsOiBj
bG9ja3NvdXJjZTogQ2hlY2tpbmcgY2xvY2tzb3VyY2UgdHNjIHN5bmNocm9uaXphdGlvbiBm
cm9tIENQVSAzIHRvIENQVXMgMC0yLgprZXJuZWw6IGNsb2Nrc291cmNlOiBTd2l0Y2hlZCB0
byBjbG9ja3NvdXJjZSBocGV0Cmtlcm5lbDogW2RybV0gYW1kZ3B1IGtlcm5lbCBtb2Rlc2V0
dGluZyBlbmFibGVkLgprZXJuZWw6IGFtZGdwdTogVmlydHVhbCBDUkFUIHRhYmxlIGNyZWF0
ZWQgZm9yIENQVQprZXJuZWw6IGFtZGdwdTogVG9wb2xvZ3k6IEFkZCBDUFUgbm9kZQprZXJu
ZWw6IGFtZGdwdSAwMDAwOjAxOjAwLjA6IGVuYWJsaW5nIGRldmljZSAoMDAwNiAtPiAwMDA3
KQprZXJuZWw6IFtkcm1dIGluaXRpYWxpemluZyBrZXJuZWwgbW9kZXNldHRpbmcgKFBPTEFS
SVMxMiAweDEwMDI6MHg2OTg1IDB4MTAwMjoweDBCMEMgMHgwMCkuCmtlcm5lbDogW2RybV0g
cmVnaXN0ZXIgbW1pbyBiYXNlOiAweEZDRTAwMDAwCmtlcm5lbDogW2RybV0gcmVnaXN0ZXIg
bW1pbyBzaXplOiAyNjIxNDQKa2VybmVsOiBhbWRncHUgMDAwMDowMTowMC4wOiBhbWRncHU6
IGRldGVjdGVkIGlwIGJsb2NrIG51bWJlciAwIDx2aV9jb21tb24+Cmtlcm5lbDogYW1kZ3B1
IDAwMDA6MDE6MDAuMDogYW1kZ3B1OiBkZXRlY3RlZCBpcCBibG9jayBudW1iZXIgMSA8Z21j
X3Y4XzA+Cmtlcm5lbDogYW1kZ3B1IDAwMDA6MDE6MDAuMDogYW1kZ3B1OiBkZXRlY3RlZCBp
cCBibG9jayBudW1iZXIgMiA8dG9uZ2FfaWg+Cmtlcm5lbDogYW1kZ3B1IDAwMDA6MDE6MDAu
MDogYW1kZ3B1OiBkZXRlY3RlZCBpcCBibG9jayBudW1iZXIgMyA8Z2Z4X3Y4XzA+Cmtlcm5l
bDogYW1kZ3B1IDAwMDA6MDE6MDAuMDogYW1kZ3B1OiBkZXRlY3RlZCBpcCBibG9jayBudW1i
ZXIgNCA8c2RtYV92M18wPgprZXJuZWw6IGFtZGdwdSAwMDAwOjAxOjAwLjA6IGFtZGdwdTog
ZGV0ZWN0ZWQgaXAgYmxvY2sgbnVtYmVyIDUgPHBvd2VycGxheT4Ka2VybmVsOiBhbWRncHUg
MDAwMDowMTowMC4wOiBhbWRncHU6IGRldGVjdGVkIGlwIGJsb2NrIG51bWJlciA2IDxkbT4K
a2VybmVsOiBhbWRncHUgMDAwMDowMTowMC4wOiBhbWRncHU6IGRldGVjdGVkIGlwIGJsb2Nr
IG51bWJlciA3IDx1dmRfdjZfMD4Ka2VybmVsOiBhbWRncHUgMDAwMDowMTowMC4wOiBhbWRn
cHU6IGRldGVjdGVkIGlwIGJsb2NrIG51bWJlciA4IDx2Y2VfdjNfMD4Ka2VybmVsOiBhbWRn
cHUgMDAwMDowMTowMC4wOiBhbWRncHU6IEZldGNoZWQgVkJJT1MgZnJvbSBWRkNUCmtlcm5l
bDogYW1kZ3B1OiBBVE9NIEJJT1M6IDExMy1EMDkxMDEwMC0xMDIKa2VybmVsOiBbZHJtXSBV
VkQgaXMgZW5hYmxlZCBpbiBWTSBtb2RlCmtlcm5lbDogW2RybV0gVVZEIEVOQyBpcyBlbmFi
bGVkIGluIFZNIG1vZGUKa2VybmVsOiBbZHJtXSBWQ0UgZW5hYmxlZCBpbiBWTSBtb2RlCmtl
cm5lbDogbG9naXRlY2gtZGpyZWNlaXZlciAwMDAzOjA0NkQ6QzUzNC4wMDAyOiBoaWRyYXcx
OiBVU0IgSElEIHYxLjExIEtleWJvYXJkIFtMb2dpdGVjaCBVU0IgUmVjZWl2ZXJdIG9uIHVz
Yi0wMDAwOjA0OjAwLjQtMS4yL2lucHV0MAprZXJuZWw6IENvbnNvbGU6IHN3aXRjaGluZyB0
byBjb2xvdXIgZHVtbXkgZGV2aWNlIDgweDI1Cmtlcm5lbDogYW1kZ3B1IDAwMDA6MDE6MDAu
MDogdmdhYXJiOiBkZWFjdGl2YXRlIHZnYSBjb25zb2xlCmtlcm5lbDogYW1kZ3B1IDAwMDA6
MDE6MDAuMDogYW1kZ3B1OiBUcnVzdGVkIE1lbW9yeSBab25lIChUTVopIGZlYXR1cmUgbm90
IHN1cHBvcnRlZAprZXJuZWw6IFtkcm1dIHZtIHNpemUgaXMgNjQgR0IsIDIgbGV2ZWxzLCBi
bG9jayBzaXplIGlzIDEwLWJpdCwgZnJhZ21lbnQgc2l6ZSBpcyA5LWJpdAprZXJuZWw6IGFt
ZGdwdSAwMDAwOjAxOjAwLjA6IGFtZGdwdTogVlJBTTogNDA5Nk0gMHgwMDAwMDBGNDAwMDAw
MDAwIC0gMHgwMDAwMDBGNEZGRkZGRkZGICg0MDk2TSB1c2VkKQprZXJuZWw6IGFtZGdwdSAw
MDAwOjAxOjAwLjA6IGFtZGdwdTogR0FSVDogMjU2TSAweDAwMDAwMEZGMDAwMDAwMDAgLSAw
eDAwMDAwMEZGMEZGRkZGRkYKa2VybmVsOiBbZHJtXSBEZXRlY3RlZCBWUkFNIFJBTT00MDk2
TSwgQkFSPTI1Nk0Ka2VybmVsOiBbZHJtXSBSQU0gd2lkdGggMTI4Yml0cyBHRERSNQprZXJu
ZWw6IFtkcm1dIGFtZGdwdTogNDA5Nk0gb2YgVlJBTSBtZW1vcnkgcmVhZHkKa2VybmVsOiBb
ZHJtXSBhbWRncHU6IDM5MzhNIG9mIEdUVCBtZW1vcnkgcmVhZHkuCmtlcm5lbDogW2RybV0g
R0FSVDogbnVtIGNwdSBwYWdlcyA2NTUzNiwgbnVtIGdwdSBwYWdlcyA2NTUzNgprZXJuZWw6
IFtkcm1dIFBDSUUgR0FSVCBvZiAyNTZNIGVuYWJsZWQgKHRhYmxlIGF0IDB4MDAwMDAwRjQw
MDgwMDAwMCkuCmtlcm5lbDogW2RybV0gQ2hhaW5lZCBJQiBzdXBwb3J0IGVuYWJsZWQhCmtl
cm5lbDogYW1kZ3B1OiBod21ncl9zd19pbml0IHNtdSBiYWNrZWQgaXMgcG9sYXJpczEwX3Nt
dQprZXJuZWw6IFtkcm1dIEZvdW5kIFVWRCBmaXJtd2FyZSBWZXJzaW9uOiAxLjEzMCBGYW1p
bHkgSUQ6IDE2Cmtlcm5lbDogW2RybV0gRm91bmQgVkNFIGZpcm13YXJlIFZlcnNpb246IDUz
LjI2IEJpbmFyeSBJRDogMwprZXJuZWw6IGxvZ2l0ZWNoLWRqcmVjZWl2ZXIgMDAwMzowNDZE
OkM1MzQuMDAwMzogaGlkZGV2MCxoaWRyYXcyOiBVU0IgSElEIHYxLjExIE1vdXNlIFtMb2dp
dGVjaCBVU0IgUmVjZWl2ZXJdIG9uIHVzYi0wMDAwOjA0OjAwLjQtMS4yL2lucHV0MQprZXJu
ZWw6IGFtZGdwdSAwMDAwOjAxOjAwLjA6IGFtZGdwdTogW2RybV0gRGlzcGxheSBDb3JlIHYz
LjIuMzM0IGluaXRpYWxpemVkIG9uIERDRSAxMS4yCmtlcm5lbDogbG9naXRlY2gtZGpyZWNl
aXZlciAwMDAzOjA0NkQ6QzUzNC4wMDAzOiBkZXZpY2Ugb2YgdHlwZSBlUVVBRCBuYW5vIExp
dGUgKDB4MGEpIGNvbm5lY3RlZCBvbiBzbG90IDEKa2VybmVsOiBsb2dpdGVjaC1kanJlY2Vp
dmVyIDAwMDM6MDQ2RDpDNTM0LjAwMDM6IGRldmljZSBvZiB0eXBlIGVRVUFEIG5hbm8gTGl0
ZSAoMHgwYSkgY29ubmVjdGVkIG9uIHNsb3QgMgprZXJuZWw6IGlucHV0OiBMb2dpdGVjaCBX
aXJlbGVzcyBLZXlib2FyZCBQSUQ6NDAyMyBLZXlib2FyZCBhcyAvZGV2aWNlcy9wY2kwMDAw
OjAwLzAwMDA6MDA6MDguMS8wMDAwOjA0OjAwLjQvdXNiMy8zLTEvMy0xLjIvMy0xLjI6MS4x
LzAwMDM6MDQ2RDpDNTM0LjAwMDMvMDAwMzowNDZEOjQwMjMuMDAwNC9pbnB1dC9pbnB1dDEy
Cmtlcm5lbDogaGlkLWdlbmVyaWMgMDAwMzowNDZEOjQwMjMuMDAwNDogaW5wdXQsaGlkcmF3
MzogVVNCIEhJRCB2MS4xMSBLZXlib2FyZCBbTG9naXRlY2ggV2lyZWxlc3MgS2V5Ym9hcmQg
UElEOjQwMjNdIG9uIHVzYi0wMDAwOjA0OjAwLjQtMS4yL2lucHV0MToxCmtlcm5lbDogaW5w
dXQ6IExvZ2l0ZWNoIFdpcmVsZXNzIE1vdXNlIFBJRDo0MDkxIE1vdXNlIGFzIC9kZXZpY2Vz
L3BjaTAwMDA6MDAvMDAwMDowMDowOC4xLzAwMDA6MDQ6MDAuNC91c2IzLzMtMS8zLTEuMi8z
LTEuMjoxLjEvMDAwMzowNDZEOkM1MzQuMDAwMy8wMDAzOjA0NkQ6NDA5MS4wMDA1L2lucHV0
L2lucHV0MTcKa2VybmVsOiBpbnB1dDogTG9naXRlY2ggV2lyZWxlc3MgTW91c2UgUElEOjQw
OTEgQ29uc3VtZXIgQ29udHJvbCBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MDgu
MS8wMDAwOjA0OjAwLjQvdXNiMy8zLTEvMy0xLjIvMy0xLjI6MS4xLzAwMDM6MDQ2RDpDNTM0
LjAwMDMvMDAwMzowNDZEOjQwOTEuMDAwNS9pbnB1dC9pbnB1dDE4Cmtlcm5lbDogaGlkLWdl
bmVyaWMgMDAwMzowNDZEOjQwOTEuMDAwNTogaW5wdXQsaGlkcmF3NDogVVNCIEhJRCB2MS4x
MSBNb3VzZSBbTG9naXRlY2ggV2lyZWxlc3MgTW91c2UgUElEOjQwOTFdIG9uIHVzYi0wMDAw
OjA0OjAwLjQtMS4yL2lucHV0MToyCmtlcm5lbDogW2RybV0gVVZEIGFuZCBVVkQgRU5DIGlu
aXRpYWxpemVkIHN1Y2Nlc3NmdWxseS4Ka2VybmVsOiBpbnB1dDogTG9naXRlY2ggV2lyZWxl
c3MgS2V5Ym9hcmQgUElEOjQwMjMgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjA4
LjEvMDAwMDowNDowMC40L3VzYjMvMy0xLzMtMS4yLzMtMS4yOjEuMS8wMDAzOjA0NkQ6QzUz
NC4wMDAzLzAwMDM6MDQ2RDo0MDIzLjAwMDQvaW5wdXQvaW5wdXQyMgprZXJuZWw6IGxvZ2l0
ZWNoLWhpZHBwLWRldmljZSAwMDAzOjA0NkQ6NDAyMy4wMDA0OiBpbnB1dCxoaWRyYXczOiBV
U0IgSElEIHYxLjExIEtleWJvYXJkIFtMb2dpdGVjaCBXaXJlbGVzcyBLZXlib2FyZCBQSUQ6
NDAyM10gb24gdXNiLTAwMDA6MDQ6MDAuNC0xLjIvaW5wdXQxOjEKa2VybmVsOiBsb2dpdGVj
aC1oaWRwcC1kZXZpY2UgMDAwMzowNDZEOjQwMjMuMDAwNDogSElEKysgMi4wIGRldmljZSBj
b25uZWN0ZWQuCmtlcm5lbDogW2RybV0gVkNFIGluaXRpYWxpemVkIHN1Y2Nlc3NmdWxseS4K
a2VybmVsOiBrZmQga2ZkOiBhbWRncHU6IEFsbG9jYXRlZCAzOTY5MDU2IGJ5dGVzIG9uIGdh
cnQKa2VybmVsOiBrZmQga2ZkOiBhbWRncHU6IFRvdGFsIG51bWJlciBvZiBLRkQgbm9kZXMg
dG8gYmUgY3JlYXRlZDogMQprZXJuZWw6IGFtZGdwdTogVmlydHVhbCBDUkFUIHRhYmxlIGNy
ZWF0ZWQgZm9yIEdQVQprZXJuZWw6IGFtZGdwdTogVG9wb2xvZ3k6IEFkZCBkR1BVIG5vZGUg
WzB4Njk4NToweDEwMDJdCmtlcm5lbDoga2ZkIGtmZDogYW1kZ3B1OiBhZGRlZCBkZXZpY2Ug
MTAwMjo2OTg1Cmtlcm5lbDogYW1kZ3B1IDAwMDA6MDE6MDAuMDogYW1kZ3B1OiBTRSAyLCBT
SCBwZXIgU0UgMSwgQ1UgcGVyIFNIIDUsIGFjdGl2ZV9jdV9udW1iZXIgOAprZXJuZWw6IGFt
ZGdwdSAwMDAwOjAxOjAwLjA6IGFtZGdwdTogVXNpbmcgQkFDTyBmb3IgcnVudGltZSBwbQpr
ZXJuZWw6IFtkcm1dIEluaXRpYWxpemVkIGFtZGdwdSAzLjY0LjAgZm9yIDAwMDA6MDE6MDAu
MCBvbiBtaW5vciAxCmtlcm5lbDogYW1kZ3B1IDAwMDA6MDE6MDAuMDogYW1kZ3B1OiBbZHJt
XSBGYWlsZWQgdG8gc2V0dXAgdmVuZG9yIGluZm9mcmFtZSBvbiBjb25uZWN0b3IgRFAtMjog
LTIyCmtlcm5lbDogZmJjb246IGFtZGdwdWRybWZiIChmYjApIGlzIHByaW1hcnkgZGV2aWNl
Cmtlcm5lbDogQ29uc29sZTogc3dpdGNoaW5nIHRvIGNvbG91ciBmcmFtZSBidWZmZXIgZGV2
aWNlIDI0MHg2NwprZXJuZWw6IGFtZGdwdSAwMDAwOjAxOjAwLjA6IFtkcm1dIGZiMDogYW1k
Z3B1ZHJtZmIgZnJhbWUgYnVmZmVyIGRldmljZQprZXJuZWw6IGlucHV0OiBMb2dpdGVjaCBX
aXJlbGVzcyBNb3VzZSBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MDguMS8wMDAw
OjA0OjAwLjQvdXNiMy8zLTEvMy0xLjIvMy0xLjI6MS4xLzAwMDM6MDQ2RDpDNTM0LjAwMDMv
MDAwMzowNDZEOjQwOTEuMDAwNS9pbnB1dC9pbnB1dDIzCmtlcm5lbDogbG9naXRlY2gtaGlk
cHAtZGV2aWNlIDAwMDM6MDQ2RDo0MDkxLjAwMDU6IGlucHV0LGhpZHJhdzQ6IFVTQiBISUQg
djEuMTEgTW91c2UgW0xvZ2l0ZWNoIFdpcmVsZXNzIE1vdXNlXSBvbiB1c2ItMDAwMDowNDow
MC40LTEuMi9pbnB1dDE6MgprZXJuZWw6IC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0t
LS0tLS0tLQprZXJuZWw6IFdBUk5JTkc6IENQVTogMSBQSUQ6IDM0OCBhdCBkcml2ZXJzL2dw
dS9kcm0vZHJtX2dlbS5jOjI4NiBkcm1fZ2VtX29iamVjdF9oYW5kbGVfcHV0X3VubG9ja2Vk
KzB4YzUvMHgxMDAKa2VybmVsOiBNb2R1bGVzIGxpbmtlZCBpbjogaGlkX2xvZ2l0ZWNoX2hp
ZHBwIGhpZF9sb2dpdGVjaF9kaiBoaWRfZ2VuZXJpYyBhbWRncHUgdXNiaGlkIGhpZCBydHN4
X3VzYl9zZG1tYyBydHN4X3VzYiBhbWR4Y3AgaTJjX2FsZ29fYml0IGRybV90dG1faGVscGVy
IHR0bSBkcm1fZXhlYyBncHVfc2NoZWQgZHJtX3N1YmFsbG9jX2hlbHBlciBkcm1fcGFuZWxf
YmFja2xpZ2h0X3F1aXJrcyBjZWMgcmNfY29yZSBkcm1fYnVkZHkgdmlkZW8gZHJtX2Rpc3Bs
YXlfaGVscGVyIHI4MTY5IGFoY2kgbGliYWhjaSByZWFsdGVrIHdtaQprZXJuZWw6IENQVTog
MSBVSUQ6IDAgUElEOiAzNDggQ29tbTogcGx5bW91dGhkIE5vdCB0YWludGVkIDYuMTYuMC1y
YzQrICM0IFBSRUVNUFQodm9sdW50YXJ5KQprZXJuZWw6IEhhcmR3YXJlIG5hbWU6IExFTk9W
TyA5MEowMDA3OFVTLzM3MDYsIEJJT1MgTzRES1Q0NUEgMTIvMDYvMjAyMgprZXJuZWw6IFJJ
UDogMDAxMDpkcm1fZ2VtX29iamVjdF9oYW5kbGVfcHV0X3VubG9ja2VkKzB4YzUvMHgxMDAK
a2VybmVsOiBDb2RlOiBjYSBmZiBlYiA5YyA0YyA4OSBlNyBlOCA0OSA2NCA2MCAwMCBlYiBk
MCA0OCA4YiA0MyAwOCA0OCA4ZCBiOCBlOCAwNSAwMCAwMCBlOCBhNyA1OCA1YyAwMCBjNyA4
MyBlMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCBlYiA5MCA8MGY+IDBiIDViIDQxIDVjIDVkIDMx
IGMwIDMxIGY2IDMxIGZmIGU5IDZhIGY0IDYwIDAwIDQ4IDhiIDgzIDQwIDAxCmtlcm5lbDog
UlNQOiAwMDE4OmZmZmZkMGE0MDBhM2Y4ZjggRUZMQUdTOiAwMDAxMDI0NgprZXJuZWw6IFJB
WDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IGZmZmY4YTFhOTY3M2MwNDggUkNYOiAwMDAwMDAw
MDAwMDAwMDAwCmtlcm5lbDogUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogMDAwMDAwMDAw
MDAwMDAwMCBSREk6IGZmZmY4YTFhOTY3M2MwNDgKa2VybmVsOiBSQlA6IGZmZmZkMGE0MDBh
M2Y5MDggUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMAprZXJu
ZWw6IFIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAwMDAwMDAwMDAwMDAwMDAgUjEyOiBm
ZmZmOGExYTk2ZTgwMDEwCmtlcm5lbDogUjEzOiAwMDAwMDAwMDAwMDAwMDAxIFIxNDogZmZm
ZjhhMWE5M2U3MDI2OCBSMTU6IDAwMDAwMDAwMDAwMDAwMDEKa2VybmVsOiBGUzogIDAwMDA3
OGYwMmUwZmUwMDAoMDAwMCkgR1M6ZmZmZjhhMWJmOGYzODAwMCgwMDAwKSBrbmxHUzowMDAw
MDAwMDAwMDAwMDAwCmtlcm5lbDogQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDog
MDAwMDAwMDA4MDA1MDAzMwprZXJuZWw6IENSMjogMDAwMDc4ZjAyZTBkMjAwMCBDUjM6IDAw
MDAwMDAxMWIzOTUwMDAgQ1I0OiAwMDAwMDAwMDAwMzUwNmYwCmtlcm5lbDogQ2FsbCBUcmFj
ZToKa2VybmVsOiAgPFRBU0s+Cmtlcm5lbDogIGRybV9nZW1faGFuZGxlX2RlbGV0ZSsweDlk
LzB4MTAwCmtlcm5lbDogID8gX19wZnhfZHJtX21vZGVfZGVzdHJveV9kdW1iX2lvY3RsKzB4
MTAvMHgxMAprZXJuZWw6ICBkcm1fbW9kZV9kZXN0cm95X2R1bWJfaW9jdGwrMHgxZS8weDQw
Cmtlcm5lbDogIGRybV9pb2N0bF9rZXJuZWwrMHhiNy8weDExMAprZXJuZWw6ICBkcm1faW9j
dGwrMHgyZWMvMHg1YjAKa2VybmVsOiAgPyBfX3BmeF9kcm1fbW9kZV9kZXN0cm95X2R1bWJf
aW9jdGwrMHgxMC8weDEwCmtlcm5lbDogIGFtZGdwdV9kcm1faW9jdGwrMHg0Yi8weDkwIFth
bWRncHVdCmtlcm5lbDogIF9feDY0X3N5c19pb2N0bCsweGE1LzB4MTAwCmtlcm5lbDogIHg2
NF9zeXNfY2FsbCsweDExNzgvMHgyNjYwCmtlcm5lbDogIGRvX3N5c2NhbGxfNjQrMHg4MC8w
eDJmMAprZXJuZWw6ICA/IF9fcGZ4X2RybV9tb2RlX3JtZmJfaW9jdGwrMHgxMC8weDEwCmtl
cm5lbDogID8gZHJtX21vZGVfcm1mYl9pb2N0bCsweDEwLzB4MjAKa2VybmVsOiAgPyBkcm1f
aW9jdGxfa2VybmVsKzB4YjcvMHgxMTAKa2VybmVsOiAgPyBfX2NoZWNrX29iamVjdF9zaXpl
KzB4NWEvMHgzMDAKa2VybmVsOiAgPyBfY29weV90b191c2VyKzB4MzEvMHg2MAprZXJuZWw6
ICA/IGRybV9pb2N0bCsweDMyNy8weDViMAprZXJuZWw6ICA/IF9fcGZ4X2RybV9tb2RlX3Jt
ZmJfaW9jdGwrMHgxMC8weDEwCmtlcm5lbDogID8ga3RpbWVfZ2V0X21vbm9fZmFzdF9ucysw
eDNjLzB4ZDAKa2VybmVsOiAgPyBhbWRncHVfZHJtX2lvY3RsKzB4NmQvMHg5MCBbYW1kZ3B1
XQprZXJuZWw6ICA/IF9feDY0X3N5c19pb2N0bCsweGE1LzB4MTAwCmtlcm5lbDogID8gX19f
cHRlX29mZnNldF9tYXArMHgxYy8weDFiMAprZXJuZWw6ICA/IHg2NF9zeXNfY2FsbCsweDEx
NzgvMHgyNjYwCmtlcm5lbDogID8gZG9fc3lzY2FsbF82NCsweGI4LzB4MmYwCmtlcm5lbDog
ID8gY291bnRfbWVtY2dfZXZlbnRzKzB4MTgwLzB4MjAwCmtlcm5lbDogID8gaGFuZGxlX21t
X2ZhdWx0KzB4YmMvMHgzMDAKa2VybmVsOiAgPyBkb191c2VyX2FkZHJfZmF1bHQrMHgxZDIv
MHg4ZDAKa2VybmVsOiAgPyBpcnFlbnRyeV9leGl0X3RvX3VzZXJfbW9kZSsweDJlLzB4MjMw
Cmtlcm5lbDogID8gaXJxZW50cnlfZXhpdCsweDQzLzB4NTAKa2VybmVsOiAgPyBleGNfcGFn
ZV9mYXVsdCsweDhkLzB4MWEwCmtlcm5lbDogIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdm
cmFtZSsweDc2LzB4N2UKa2VybmVsOiBSSVA6IDAwMzM6MHg3OGYwMmUzYjVkZWQKa2VybmVs
OiBDb2RlOiAwNCAyNSAyOCAwMCAwMCAwMCA0OCA4OSA0NSBjOCAzMSBjMCA0OCA4ZCA0NSAx
MCBjNyA0NSBiMCAxMCAwMCAwMCAwMCA0OCA4OSA0NSBiOCA0OCA4ZCA0NSBkMCA0OCA4OSA0
NSBjMCBiOCAxMCAwMCAwMCAwMCAwZiAwNSA8ODk+IGMyIDNkIDAwIGYwIGZmIGZmIDc3IDFh
IDQ4IDhiIDQ1IGM4IDY0IDQ4IDJiIDA0IDI1IDI4IDAwIDAwIDAwCmtlcm5lbDogUlNQOiAw
MDJiOjAwMDA3ZmZmM2Q3MzQxYjAgRUZMQUdTOiAwMDAwMDI0NiBPUklHX1JBWDogMDAwMDAw
MDAwMDAwMDAxMAprZXJuZWw6IFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDA1YTdl
MTMzOTIzYjAgUkNYOiAwMDAwNzhmMDJlM2I1ZGVkCmtlcm5lbDogUkRYOiAwMDAwN2ZmZjNk
NzM0MjRjIFJTSTogMDAwMDAwMDBjMDA0NjRiNCBSREk6IDAwMDAwMDAwMDAwMDAwMGIKa2Vy
bmVsOiBSQlA6IDAwMDA3ZmZmM2Q3MzQyMDAgUjA4OiAwMDAwNWE3ZTEzMzkxNzEwIFIwOTog
MDAwMDAwMDAwMDAwMDAwNwprZXJuZWw6IFIxMDogMDAwMDVhN2UxMzM5MTcxMCBSMTE6IDAw
MDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAwMDAwMGMwMDQ2NGI0Cmtlcm5lbDogUjEzOiAwMDAw
MDAwMDAwMDAwMDBiIFIxNDogMDAwMDc4ZjAyZTRjYWIwMCBSMTU6IDAwMDAwMDAwMDAwMDAw
MDAKa2VybmVsOiAgPC9UQVNLPgprZXJuZWw6IC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAw
MDAwMDAgXS0tLQprZXJuZWw6IEVYVDQtZnMgKHNkYTUpOiBtb3VudGVkIGZpbGVzeXN0ZW0g
ZjIyNWU3MTUtMGU0Ni00YWY5LWFlMDItOWY3MDRhNzg0MmZhIHJvIHdpdGggb3JkZXJlZCBk
YXRhIG1vZGUuIFF1b3RhIG1vZGU6IG5vbmUuCg==

--------------WjLRXBtIUKtP7gW328uhL0S5--

