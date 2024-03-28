Return-Path: <linux-pci+bounces-5353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769CC890866
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 19:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2893F292376
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 18:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BD4136E01;
	Thu, 28 Mar 2024 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gC2eiEeO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15301CF9A
	for <linux-pci@vger.kernel.org>; Thu, 28 Mar 2024 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711650950; cv=none; b=C5oAL2tj6+bQDITkH3BMTReZszlJtTeULhxrpnyUM49WfTC6DrPuRHI8NKIO4LMounfBHn3wNwqmUjkBndsLpo2j+anIH+jjSKobro3IXahuZvNTG5/hdhGGjKOK3tbGzNXgZYLEq6H7RkgqtruwZIJ/Ph/tGoCCbUoGYk4984M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711650950; c=relaxed/simple;
	bh=iLrEPB+5fU9F1qjc333b8sqZ5yJuXVogRhNNU1xtFQc=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6UNZ+FGRcaOEHwNSTohQT+CTzNTMctNyf+yJS9riHBh3Tl7U+QxwCVaBObA5ch2UGHcq6PoTURrgnd3VyZ/4biF7d/oFqYgKXUCqn5MsoF+hwFsGmYIEF7wxBfrCZU3O473oC/5VnQYA4zy2prJ4/ZYdS3/Qe7g5wJpxI4ZosA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gC2eiEeO; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=3iqmzdauw5dizhfxw6f6oczsau.protonmail; t=1711650938; x=1711910138;
	bh=h6ehau0PffhsLY5il9mr/+zmzmgkRB4owQoSHWA/Vjk=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gC2eiEeO7bYr+BXxeww9/GyDUnAfevwM6VAARFpMnuFdy7vVf+TbYF/PFvCWCTgEp
	 Kc78fa499vXgHc/3RoHuJedtwiFYCee9sL5dR9p3AjsizC6WJdir7pH3h1WLOEx397
	 fdGxMxSUQWHHYcYKhGAmVfreQe12tUm4qyy+YUCW+KhRmbUlwI8R9SaWcJdZHfLvs8
	 0aWN00O4VokPgeqtzGVUSrftrw3cYrxMnUk9MdsV1lkpnf2no6xvb7erMu91JpXMO8
	 mBeLJAN+N0X1mQDhNwyCF89ircwfwPP8Iu6+FOCjTllnP2NUFT2tT87h0NHcp09IPf
	 W/qPjtO+Sl/uA==
Date: Thu, 28 Mar 2024 18:35:29 +0000
To: helgaas@kernel.org, o-takashi@sakamocchi.jp, linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
From: "edmund.raile" <edmund.raile@proton.me>
Subject: Re: [PATCH v2] PCI: Mark LSI FW643 to avoid bus reset
Message-ID: <kodgse5nq6gqor6iaf5s4qo2h7mfykbor34ewtkjvcgh4iraq5@7fxn3rdch2sl>
In-Reply-To: <20240326131858.GA140624@workstation.local>
References: <20240325012135.36861-1-o-takashi@sakamocchi.jp> <20240325144149.GA1432902@bhelgaas> <20240326131858.GA140624@workstation.local>
Feedback-ID: 45198251:user:proton
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

So Bjorn Helgaas beat me to it,

I'm monitoring kernel messages with
```
sudo journalctl --system -f
```

Indeed all that is necessary to generate the trace from the patch is to unb=
ind the FW643 from ohci on my system (unpatched kernel):
```
su -c 'echo -n "0000:03:00.0" > /sys/bus/pci/drivers/firewire_ohci/unbind'
```

In combination with the kernel parameters intel_iommu=3Don iommu=3Dpt, I ca=
n then bind it to vfio-pci
```
su -c 'echo -n "0000:03:00.0" > /sys/bus/pci/drivers/vfio-pci/bind'
```

And then I'd attach it to a qemu Windows VM using `-device vfio-pci,host=3D=
03:00.0 \`.
The OS finds the firewire card straightaway and the RME FireFace driver con=
nects on booting just like it would when booting the guest on bare metal.

> $ echo 1 > sudo tee -a /sys/devices/pci0000:00/0000:00:01.2/0000:03:00.0/=
0000:04:02.0/0000:06:00.0/reset
> (nothing happens)

Replicating the reset line Takashi sent on my system, there is no error in =
the kernel log but playback doesn't stop either, leading me to believe that=
 permissions of sudo may be insufficient (root-only)?
```
echo 1 > sudo tee -a /sys/devices/pci0000\:00/0000\:00\:1c.1/0000\:03\:00.0=
/reset
```

So instead I ran this:
```
su -c 'echo 1 > /sys/devices/pci0000\:00/0000\:00\:1c.1/0000\:03\:00.0/rese=
t'
```
Playback stopped immediately and could not be resumed.

Then I received this trace:

INFO: task alsa-sink-Firef:4110 blocked for more than 245 seconds.
      Tainted: G        W  OE      6.6.10-1-MANJARO #1
task:alsa-sink-Firef state:D stack:0     pid:4110  ppid:2657   flags:0x0000=
0002
Call Trace:
 <TASK>
 __schedule+0x3e7/0x1410
 ? tlb_batch_pages_flush+0x3d/0x70
 schedule+0x5e/0xd0
 schedule_timeout+0x151/0x160
 wait_for_completion+0x8a/0x160
 fw_run_transaction+0xe5/0x120 [firewire_core d9ff4eaf1ffb23a203d413e851f40=
5323b49fec7]
 ? __pfx_split_transaction_timeout_callback+0x10/0x10 [firewire_core d9ff4e=
af1ffb23a203d413e851f405323b49fec7]
 ? __pfx_transmit_complete_callback+0x10/0x10 [firewire_core d9ff4eaf1ffb23=
a203d413e851f405323b49fec7]
 ? __pfx_transaction_callback+0x10/0x10 [firewire_core d9ff4eaf1ffb23a203d4=
13e851f405323b49fec7]
 snd_fw_transaction+0x70/0x110 [snd_firewire_lib 30b43a591db389bbc6be51459c=
b243ba1fe1e662]
 ff800_finish_session+0x43/0x70 [snd_fireface 5f7f3f556960f4838886792be8e9c=
18aa5089b0a]
 snd_ff_stream_stop_duplex+0x39/0x70 [snd_fireface 5f7f3f556960f4838886792b=
e8e9c18aa5089b0a]
 pcm_hw_free+0x3c/0x50 [snd_fireface 5f7f3f556960f4838886792be8e9c18aa5089b=
0a]
 snd_pcm_common_ioctl+0xe28/0x12b0 [snd_pcm 24933227879438b755ef98bc4844113=
025f38cdf]
 ? __seccomp_filter+0x32c/0x510
 ? __vm_munmap+0xbb/0x150
 snd_pcm_ioctl+0x2e/0x50 [snd_pcm 24933227879438b755ef98bc4844113025f38cdf]
 __x64_sys_ioctl+0x94/0xd0
 do_syscall_64+0x5d/0x90
 ? syscall_exit_to_user_mode+0x2b/0x40
 ? do_syscall_64+0x6c/0x90
 ? do_syscall_64+0x6c/0x90
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Now of course yanking the device from underneath streaming snd_firewire is =
not an intended usecase and I get that this has good cause to produce a tra=
ce but it shows that root privileges are necessary here.

Doing this without running playback yields the same result.

In both instances, I had to REISUO the system as it would keep waiting for =
that thread to finish when shutting down.

When I instead turned the FireFace off, I got this kernel message:
snd_fireface fw1.0: transaction failed: bus reset
snd_fireface fw1.0: transaction failed: bus reset
snd_fireface fw1.0: transaction failed: bus reset
Then running the same command, this time no threads went into D state and s=
tart producing spinlock messages/traces but by that point, BUT I wasn't abl=
e to use the FireFace after powering it back on again.
At least shutdown worked normally this time.

Are there other steps necessary to get the FW643 back working again after t=
his?

System:
MSI PRO Z690-A DDR4(MS-7D25)
StarTech FW800 PCIe card (LSI FW643)

A peculiarity about this system that may or may not be of relevance here:
When rebooting, the FW643 can not be seen by the system any more.
Its root port also won't show up, regardless of slot used.
I have to perform a full shutdown for it to be recognized again.
This behavior is OS-independent, but it never happened on my previous Z68 s=
ystem with this card (or any), there reboot worked as you'd expect.
The original MSI BIOS was buggy in this regard (and many others) in that it=
 would not even recognize the card half the time booting from power-off.
MSI support did not care, said it was an "old device". How they can claim P=
CIe compliance is beyond me.
This is why I'm running Dasharo (coreboot), it always picks up the card fro=
m full power-off and behaves very predictably in other regards.
It might even be an issue with modern Intel since I've read of very similar=
 issues on other manufacturer's Z690 and even Z790 boards (missing PCIe dev=
ices after reboot).
I've learned to live with this as I don't know how to solve it and I'm
stuck on this platform. Should of bought AMD again this time around.

> Can you both collect the output of "sudo lspci -vvv" so we can try to fig=
ure out the difference?
> This is my 1394 OHCI hardware.
```
sudo lspci -vvv
03:00.0 FireWire (IEEE 1394): LSI Corporation FW643 [TrueFire] PCIe 1394b C=
ontroller (rev 08) (prog-if 10 [OHCI])
=09Subsystem: Device 5901:1101
=09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx+
=09Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
=09Latency: 0, Cache Line Size: 64 bytes
=09Interrupt: pin A routed to IRQ 136
=09IOMMU group: 13
=09Region 0: Memory at 50800000 (64-bit, non-prefetchable) [size=3D4K]
=09Capabilities: [44] Power Management version 3
=09=09Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+=
,D3cold+)
=09=09Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME+
=09Capabilities: [4c] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
=09=09Address: 00000000fee00358  Data: 0000
=09Capabilities: [60] Express (v1) Endpoint, MSI 00
=09=09DevCap:=09MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 <64=
us
=09=09=09ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 10W
=09=09DevCtl:=09CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
=09=09=09RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
=09=09=09MaxPayload 256 bytes, MaxReadReq 2048 bytes
=09=09DevSta:=09CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend=
-
=09=09LnkCap:=09Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency=
 L0s <512ns, L1 <64us
=09=09=09ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
=09=09LnkCtl:=09ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
=09=09=09ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
=09=09LnkSta:=09Speed 2.5GT/s, Width x1
=09=09=09TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
=09Capabilities: [100 v1] Advanced Error Reporting
=09=09UESta:=09DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- Mal=
fTLP- ECRC- UnsupReq- ACSViol-
=09=09UEMsk:=09DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- Mal=
fTLP- ECRC- UnsupReq- ACSViol-
=09=09UESvrt:=09DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Ma=
lfTLP+ ECRC- UnsupReq- ACSViol-
=09=09CESta:=09RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
=09=09CEMsk:=09RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
=09=09AERCap:=09First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+=
 ECRCChkEn-
=09=09=09MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
=09=09HeaderLog: 00000000 00000000 00000000 00000000
=09Capabilities: [140 v1] Virtual Channel
=09=09Caps:=09LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
=09=09Arb:=09Fixed- WRR32- WRR64- WRR128-
=09=09Ctrl:=09ArbSelect=3DFixed
=09=09Status:=09InProgress-
=09=09VC0:=09Caps:=09PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
=09=09=09Arb:=09Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
=09=09=09Ctrl:=09Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
=09=09=09Status:=09NegoPending- InProgress-
=09=09VC1:=09Caps:=09PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
=09=09=09Arb:=09Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
=09=09=09Ctrl:=09Enable- ID=3D0 ArbSelect=3DFixed TC/VC=3D00
=09=09=09Status:=09NegoPending- InProgress-
=09Capabilities: [170 v1] Device Serial Number 00-00-00-00-00-00-00-00
=09Kernel driver in use: firewire_ohci
=09Kernel modules: firewire_ohci
```
This does not change whether I boot patched or unpatched kernel.

> > > Can you collect the output of:
> > >
> > >   $ find /sys/devices -name reset_method | xargs grep .
> Edmund, could you run this command, too?

with patch applied:
```
sudo find /sys/devices -name reset_method | xargs grep .
/sys/devices/pci0000:00/0000:00:1c.0/0000:02:00.0/reset_method:pm bus
/sys/devices/pci0000:00/0000:00:1c.0/reset_method:pm
/sys/devices/pci0000:00/0000:00:1c.1/0000:03:00.0/reset_method:pm
/sys/devices/pci0000:00/0000:00:1c.1/reset_method:pm
/sys/devices/pci0000:00/0000:00:1a.0/0000:01:00.0/reset_method:flr bus
/sys/devices/pci0000:00/0000:00:1a.0/reset_method:pm
/sys/devices/pci0000:00/0000:00:1d.0/reset_method:pm
/sys/devices/pci0000:00/0000:00:1d.0/0000:05:00.0/reset_method:flr bus
/sys/devices/pci0000:00/0000:00:02.0/reset_method:flr pm
/sys/devices/pci0000:00/0000:00:1c.2/reset_method:pm
/sys/devices/pci0000:00/0000:00:1c.2/0000:04:00.0/reset_method:flr bus
```
without applied patch only bus reset method is added, everything else
stays the same:
```
/sys/devices/pci0000:00/0000:00:1c.1/0000:03:00.0/reset_method:pm bus
```

This is the root port it is currently connected to:
```
sudo lspci -vvv
00:1c.1 PCI bridge: Intel Corporation Alder Lake-S PCH PCI Express Root Por=
t #2 (rev 11) (prog-if 00 [Normal decode])
=09Subsystem: Micro-Star International Co., Ltd. [MSI] Alder Lake-S PCH PCI=
 Express Root Port
=09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR+ FastB2B- DisINTx+
=09Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
=09Latency: 0, Cache Line Size: 64 bytes
=09Interrupt: pin B routed to IRQ 124
=09IOMMU group: 7
=09Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0
=09I/O behind bridge: f000-0fff [disabled] [16-bit]
=09Memory behind bridge: 50800000-508fffff [size=3D1M] [32-bit]
=09Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [di=
sabled] [64-bit]
=09Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- <SERR- <PERR-
=09BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
=09=09PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
=09Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
=09=09DevCap:=09MaxPayload 256 bytes, PhantFunc 0
=09=09=09ExtTag- RBE+
=09=09DevCtl:=09CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
=09=09=09RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
=09=09=09MaxPayload 256 bytes, MaxReadReq 128 bytes
=09=09DevSta:=09CorrErr+ NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend=
-
=09=09LnkCap:=09Port #2, Speed 8GT/s, Width x1, ASPM not supported
=09=09=09ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
=09=09LnkCtl:=09ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
=09=09=09ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
=09=09LnkSta:=09Speed 2.5GT/s, Width x1
=09=09=09TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
=09=09SltCap:=09AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
=09=09=09Slot #1, PowerLimit 10W; Interlock- NoCompl+
=09=09SltCtl:=09Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- Link=
Chg-
=09=09=09Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
=09=09SltSta:=09Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock=
-
=09=09=09Changed: MRL- PresDet- LinkState+
=09=09RootCap: CRSVisible-
=09=09RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisibl=
e-
=09=09RootSta: PME ReqID 0000, PMEStatus- PMEPending-
=09=09DevCap2: Completion Timeout: Range ABC, TimeoutDis+ NROPrPrP- LTR+
=09=09=09 10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt+ EETLPPrefix+, =
MaxEETLPPrefixes 2
=09=09=09 EmergencyPowerReduction Not Supported, EmergencyPowerReductionIni=
t-
=09=09=09 FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
=09=09=09 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
=09=09DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ 10BitTagR=
eq- OBFF Disabled, ARIFwd-
=09=09=09 AtomicOpsCtl: ReqEn- EgressBlck-
=09=09LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer+ 2Retim=
ers+ DRS-
=09=09LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
=09=09=09 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-=
 ComplianceSOS-
=09=09=09 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
=09=09LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- Equ=
alizationPhase1-
=09=09=09 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
=09=09=09 Retimer- 2Retimers- CrosslinkRes: unsupported
=09Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
=09=09Address: 00000000fee00278  Data: 0000
=09Capabilities: [98] Subsystem: Micro-Star International Co., Ltd. [MSI] A=
lder Lake-S PCH PCI Express Root Port
=09Capabilities: [a0] Power Management version 3
=09=09Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
=09=09Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
=09Capabilities: [100 v1] Advanced Error Reporting
=09=09UESta:=09DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- Mal=
fTLP- ECRC- UnsupReq- ACSViol-
=09=09UEMsk:=09DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- Mal=
fTLP- ECRC- UnsupReq- ACSViol-
=09=09UESvrt:=09DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Ma=
lfTLP+ ECRC- UnsupReq- ACSViol-
=09=09CESta:=09RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
=09=09CEMsk:=09RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
=09=09AERCap:=09First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap-=
 ECRCChkEn-
=09=09=09MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
=09=09HeaderLog: 00000000 00000000 00000000 00000000
=09=09RootCmd: CERptEn+ NFERptEn+ FERptEn+
=09=09RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
=09=09=09 FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
=09=09ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
=09Capabilities: [220 v1] Access Control Services
=09=09ACSCap:=09SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ Egre=
ssCtrl- DirectTrans-
=09=09ACSCtl:=09SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ Egre=
ssCtrl- DirectTrans-
=09Capabilities: [150 v1] Precision Time Measurement
=09=09PTMCap: Requester:- Responder:+ Root:+
=09=09PTMClockGranularity: 4ns
=09=09PTMControl: Enabled:+ RootSelected:+
=09=09PTMEffectiveGranularity: Unknown
=09Capabilities: [a30 v1] Secondary PCI Express
=09=09LnkCtl3: LnkEquIntrruptEn- PerformEqu-
=09=09LaneErrStat: 0
=09Capabilities: [a90 v1] Data Link Feature <?>
=09Kernel driver in use: pcieport
```

`lspci -tv` reveals that it is connected to root port #2:
           +-1c.1-[03]----00.0  LSI Corporation FW643 [TrueFire] PCIe 1394b=
 Controller

I hope this information is of use to you.
Maybe there is a better solution?

Kind regards,
Edmund Raile


