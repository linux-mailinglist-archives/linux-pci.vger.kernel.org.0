Return-Path: <linux-pci+bounces-13646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3501998A36F
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 14:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4141F20D6B
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 12:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D33817E003;
	Mon, 30 Sep 2024 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGnuqRuy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8C018DF98
	for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2024 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700591; cv=none; b=mlakNNfGj/BO0P6Rh+wSSZkR5tNlNm3X0W9f/vVCK/owPDlRi64mpYenhLOGaLsnh9+xLlI5HA/tHj2yCF4WiTz10D/cRAi/ts8GK5/bcb9rtI/78AnoweT13bo7V5WIcDtXX8MzabvUGqkFy369JOZIFeO48CLjM1Ehfogg7gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700591; c=relaxed/simple;
	bh=wLXNbN73sOhWwWIDRZPUXB5RxBY3n+t39KgLqyLwU1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=psw6gz5vTcEDu5rzaC+18vYm09UdhI2esPK7/a38X/E6nyNFFR6HF97MJkxX3LM3yoVAGk6xXNJ484/6oaMGScB7hx2vAIOp9Lc/7as40vfHz4qDErG/jA5yEwjMYaT7Bi8iEz/WWDW6wKYyfNmwiuBNf2flqpzCWV8chkmTCAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGnuqRuy; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e255b5e0deso17508397b3.0
        for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2024 05:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727700589; x=1728305389; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VFNaEeYq2WZppClE27eC2SWT7ybymyjySBqpXKI3ZGk=;
        b=AGnuqRuyapMP8+YWWsA4q1xinnaidCYEi28v4rIT4mKFfEEUGYFX8Rw/1DuiTA1Y2U
         izD2lotYlgVR8N5kPH1bckqCjEqbSxgPiI/0TJCaX0tTqzyAAT6R+blaPy62pCBEHKf1
         wzJRgOIcUqILDqxO/ao0RQ8r4JgBoHCG1pVXfnDRbSIXkKqMKCbzVfXtuScIjC/O9BjF
         I4cRT3NECX6W0GOM1a7AqLo1kKWmCDBSbIZMbmJCpfAkTJ+wTs0VWPklq2O1kWtzEPJx
         Vq0RWBiAlCmyEkVsxOpeuq76FVjg1GChdjlZpsspTdpksv7uaJ9RxjZC4afsw3laKxn9
         etrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727700589; x=1728305389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFNaEeYq2WZppClE27eC2SWT7ybymyjySBqpXKI3ZGk=;
        b=o2O5sfROK2xI25TZgFcIElJQweYnWsc5gtMGgci+cbUXX9T0HCKXLWHo+QdNfXnyOL
         wFeK31rl6y2eKiq+Rl6xKuEQR7EzEYOV3wwUNPImxR/qn9H7osy+0GFga4BQuIR77e6a
         OGsERQOMXwZOcUWo7X4DCREXkLuKguCBH5DaHl/7uJRlP1iyq9M7w16O9ZRUxyDm/V7M
         afYGAZtFn9oofqHKVOH03uekTwRyicmBwtt9om4hHXDz+ir9mmhRU2Nuv3046fOLlyA3
         QnODXuLAuEGGKH4X+oPr9i1bkmpuqRv+jXaBeta1/gC3T5Mu9KVzf+hCmZwOB0/fOMVS
         /rvw==
X-Gm-Message-State: AOJu0YwXN2y+84jO/QpKBfAmBBeqVwgJYFp5BeYmGPJrz4u3AQ2Jx273
	ODkIOktei3SOdV8f8lx2U/SveGe+JIA1TSg37qHwAD4aEp0YSCZCHuee9P8727DmUmxX/iyHJQq
	hsrkv349eKH8QEqPjbv3mSMdZD0o=
X-Google-Smtp-Source: AGHT+IGIOQcTC5xitV6E8uDYa1PXgA8O9Or8aKqBqRzBOJlSBn9re+jxhMPmNaAY4rFykZ8gF3dv3Oda4NurF260v0s=
X-Received: by 2002:a05:690c:6482:b0:6e2:5d2:3426 with SMTP id
 00721157ae682-6e22ed8041emr111588897b3.4.1727700588570; Mon, 30 Sep 2024
 05:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALfBBTthgTJKZ+49rW7XKDp2xP6pDhSqPAgDsxczV_s00-Ov1A@mail.gmail.com>
 <20240927171722.GA84699@bhelgaas> <CALfBBTsmKYf5FT-pxLfM-C1EgdrKKhQU43OhMDBz2ZPtKcxaLQ@mail.gmail.com>
In-Reply-To: <CALfBBTsmKYf5FT-pxLfM-C1EgdrKKhQU43OhMDBz2ZPtKcxaLQ@mail.gmail.com>
From: Maverickk 78 <maverickk1778@gmail.com>
Date: Mon, 30 Sep 2024 18:19:37 +0530
Message-ID: <CALfBBTtzhH_Dro+a2OGrz30CAWy7rcAcDNL3hio8EVU3o6+4Hw@mail.gmail.com>
Subject: Re: pcie hotplug driver probe is not getting called
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Update:

Hi Bjorn,

Looks like the pciehp_probe is invoked and the corresponding ISR
(pciehp_isr) is triggered if there is an event, but somehow only
pciehp_isr is traced by ftrace but not the probe function.
Maybe my assumptions of ftrace need correction.

Thanks for the response.

Regards


On Sun, 29 Sept 2024 at 19:29, Maverickk 78 <maverickk1778@gmail.com> wrote:
>
> Hi Bjorn,
>
> I have a switch connecting to the Host bridge, one of the downstream port(02:1.0) on the switch has the slot enabled.
>
> Appended pcie_ports=native along with pciehp.pciehp_force=1 pciehp.pciehp_debug=1  to the cmdline and I see the driver creating symlink to sysfs device node.
>
> Does this mean pciehp can handle the hotplug events? asking this because none of the functions in pciehp_core listed in ftrace?
>
> # uname -a
>
> Linux qemu-01 6.11.0+ #2 SMP PREEMPT_DYNAMIC Sat Sep 28 01:32:57 EEST 2024 x86_64 x86_64 x86_64 GNU/Linux
>
> # cat /proc/cmdline
>
> BOOT_IMAGE=/boot/vmlinuz-6.11.0+ root=UUID=f563804b-1b93-4921-90e1-4114c8111e8f ro ftrace=function_graph ftrace_graph_filter=*pcie* pciehp.pciehp_force=1 pciehp.pciehp_debug=1 pcie_ports=native quite splash crashkernel=512M-:192M vt.handoff=7
>
> # ls -ltr /sys/bus/pci_express/drivers/pciehp
>
> total 0
>
> --w------- 1 root root 4096 Sep 29 16:46 uevent
>
> --w------- 1 root root 4096 Sep 29 16:49 unbind
>
> --w------- 1 root root 4096 Sep 29 16:49 bind
>
> lrwxrwxrwx 1 root root    0 Sep 29 16:49 0000:02:01.0:pcie204 -> ../../../../devices/pci0000:00/0000:00:04.0/0000:01:00.0/0000:02:01.0/0000:02:01.0:pcie204
>
> #
>
>
> # lspci -vv -s 2:1.0
>
> 02:01.0 PCI bridge: Broadcom / LSI Device c040 (rev a0) (prog-if 00 [Normal decode])
>
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
>
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>
>         Latency: 0
>
>         Interrupt: pin ? routed to IRQ 25
>
>         Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
>
>         I/O behind bridge: 00001000-00001fff [size=4K]
>
>         Memory behind bridge: f8000000-f9ffffff [size=32M]
>
>         Prefetchable memory behind bridge: 00000000fe200000-00000000fe3fffff [size=2M]
>
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
>
>         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>
>         Capabilities: [40] Power Management version 3
>
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>
>         Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
>
>                 Address: 00000000fee03000  Data: 0020
>
>                 Masking: 000000fe  Pending: 00000000
>
>         Capabilities: [68] Express (v2) Downstream Port (Slot+), MSI 00
>
>                 DevCap: MaxPayload 512 bytes, PhantFunc 0
>
>                         ExtTag- RBE+
>
>                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>
>                         MaxPayload 512 bytes, MaxReadReq 128 bytes
>
>                 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
>
>                 LnkCap: Port #0, Speed unknown, Width x2, ASPM L1, Exit Latency L1 <32us
>
>                         ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
>
>                 LnkCtl: ASPM Disabled; Disabled- CommClk-
>
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>
>                 LnkSta: Speed 32GT/s (downgraded), Width x2 (ok)
>
>                         TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
>
>                 SltCap: AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ Surprise+
>
>                         Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
>
>                 SltCtl: Enable: AttnBtn+ PwrFlt- MRL- PresDet- CmdCplt+ HPIrq+ LinkChg+
>
>                         Control: AttnInd Off, PwrInd Off, Power+ Interlock-
>
>                 SltSta: Status: AttnBtn- PowerFlt- MRL+ CmdCplt- PresDet- Interlock-
>
>                         Changed: MRL- PresDet- LinkState-
>
>                 DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
>
>                          10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 4
>
>                          EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
>
>                          FRS- ARIFwd+
>
>                          AtomicOpsCap: Routing+
>
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
>
>                          AtomicOpsCtl: EgressBlck-
>
>                 LnkCap2: Supported Link Speeds: RsvdP, Crosslink+ Retimer+ 2Retimers+ DRS+
>
>                 LnkCtl2: Target Link Speed: Unknown, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
>
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>
>                          Compliance De-emphasis: -6dB
>
>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
>
>                          EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
>
>                          Retimer- 2Retimers- CrosslinkRes: Downstream Port, DRS-
>
>                          DownstreamComp: Link Up - Present
>
>         Capabilities: [a4] Subsystem: Broadcom / LSI Device 0144
>
>         Capabilities: [100 v1] Extended Capability ID 0x2f
>
>         Capabilities: [294 v3] Advanced Error Reporting
>
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>
>                 UESvrt: DLP+ SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>
>                 AERCap: First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
>
>                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>
>                 HeaderLog: 00000000 00000000 00000000 00000000
>
>         Capabilities: [138 v1] Power Budgeting <?>
>
>         Capabilities: [db4 v1] Secondary PCI Express
>
>                 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
>
>                 LaneErrStat: 0
>
>         Capabilities: [148 v1] Virtual Channel
>
>                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
>
>                 Arb:    Fixed- WRR32- WRR64- WRR128-
>
>                 Ctrl:   ArbSelect=Fixed
>
>                 Status: InProgress-
>
>                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>
>                         Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>
>                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>
>                         Status: NegoPending- InProgress-
>
>         Capabilities: [af4 v1] Data Link Feature <?>
>
>         Capabilities: [d00 v1] Physical Layer 16.0 GT/s <?>
>
>         Capabilities: [d40 v1] Lane Margining at the Receiver <?>
>
>         Capabilities: [e40 v1] Extended Capability ID 0x2a
>
>         Capabilities: [e70 v1] Extended Capability ID 0x31
>
>         Capabilities: [ec0 v1] Extended Capability ID 0x32
>
>         Capabilities: [a80 v1] Extended Capability ID 0x34
>
>         Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 Len=010 <?>
>
>         Capabilities: [f24 v1] Access Control Services
>
>                 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans+
>
>                 ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
>
>         Capabilities: [b60 v1] Downstream Port Containment
>
>                 DpcCap: INT Msg #0, RPExt- PoisonedTLP+ SwTrigger+ RP PIO Log 0, DL_ActiveErr+
>
>                 DpcCtl: Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- DL_ActiveErr-
>
>                 DpcSta: Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO ErrPtr:00
>
>                 Source: 0000
>
>         Capabilities: [b20 v1] Extended Capability ID 0x2c
>
>         Kernel driver in use: pcieport
>
>
> On Fri, 27 Sept 2024 at 22:47, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> On Fri, Sep 27, 2024 at 08:50:41PM +0530, Maverickk 78 wrote:
>> > Hello
>> >
>> > Debugging a downstream port with slot capabilities indicating hotplug
>> > capability is advertised in pci capability(id =0x10) .
>> >
>> > None of the hotplug driver is getting invoked.
>> >
>> > I assume pciehp_probe should've been called because its associated
>> > with ".port_type = PCIE_ANY_PORT," in the pcie_port_service_driver
>> > structure.
>> >
>> > I assumed SHPC shpc_probe function would be called because the pci_id
>> > table has PCI_CLASS_BRIDGE_PCI_NORMAL, but nothing related to hotplug
>> > drivers is seen in the ftrace or dmesg.
>> >
>> > Tried "pciehp.pciehp_force=1 pciehp.pciehp_debug=1" in the command
>> > line but no luck
>> >
>> > As part of port initialization if the hotplug capability is indicated
>> > in the capability register the hotplug drivers should have been
>> > invoked, but looks like its not the case.
>>
>> I would expect pciehp to work in this case, but there is some
>> negotiation between the OS and the firmware to figure out which
>> owns it.
>>
>> I assume you have CONFIG_PCIEPORTBUS and CONFIG_HOTPLUG_PCI_PCIE
>> enabled?  Can you supply the dmesg log and output of "sudo lspci -vv"?
>>
>> Bjorn

