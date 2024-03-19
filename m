Return-Path: <linux-pci+bounces-4890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6743087F873
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 08:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808A61C21AF6
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 07:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12B2535A3;
	Tue, 19 Mar 2024 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hd5c3IRj"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FF952F95
	for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710833714; cv=none; b=VeDJopq2krRjVIbREsloNunZO98f9ISnXVETgzqyWEx3D7MHwzM9grgqsIt5ZYoL1ya1QUguFgb7jV51pf+zEwYisCvujXF3WeDcb50DkEhkPPpR/fEcVuJKarVTLNN9nrzrA5q68neI3QDSSuQ2hdEjkCqNqfF16cPiM0gtcbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710833714; c=relaxed/simple;
	bh=AEHt6DNVmDMM/VlnumtZ/9fQPumVBgKRRPOTqiSfvK8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XMB+At5pg4dGf3tgralPN4BCUix3qGaS277r5QzDPH4GWzd+eateRj6RFgQqliYZXmdUyfHUl3tDWQXEExWPbdHrgw8z+a5TdOJrmMNrhc6UMLQVC7LPATlBkvimqnG4E9y9cnbLYBH1hKpfFMPlU/bwJ86iRx70W6/EPJttDts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hd5c3IRj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710833711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=jmgQ3u9vQfk+4SqS0vchYJd/LFseBm0YbDSuWQrSN5A=;
	b=hd5c3IRjvshbEq12QSeVhq3VprHxR6ZlYXH6nVhVl+a5lDYMobk7NKQwYqM1BaNJJ09fD0
	RMT0gMunG+/vjOylxrlfw1vzITGnOBKTMeUKQVL/Moj2u1Q2a4qEIvrxx5Ak0qIguodejG
	jqh4sMjWPwodqd+aRoqxmRNHk4P9MO0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-fW56Q98GPoSSqA230tI7Ow-1; Tue, 19 Mar 2024 03:35:09 -0400
X-MC-Unique: fW56Q98GPoSSqA230tI7Ow-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-29e09df31d0so2357291a91.0
        for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 00:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710833708; x=1711438508;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jmgQ3u9vQfk+4SqS0vchYJd/LFseBm0YbDSuWQrSN5A=;
        b=vw5FqWJMS6NJUGLQLyHZV5TLayUaGhw2PisztChG98z2N/CYXj0sm1cOlLf/0IVA8x
         ndXVopmYbosWdn2DQ4EXvburSWTL6sFMiGyeLykUMpf18ygMLOVu4nWW46waTGSalFzJ
         P+uqrQ5WyR6if6Ota4PcpFWFdmAjuS5WhnkgXEtS1Glwy49+6/27kiXum3auCWwzbIak
         vo/qQYL8m318dftZALBuEXwIbBg1z8vbfXZp66AnN9oSl1RdjUxv1chrZMmiCAcVrW1K
         mFRBPjuIerL1Dx667XA7GCXy3tN4Sr40qCzxBfpYgHbPoCGvuEyHx7Ae8BZhHXq2DzsJ
         IB9g==
X-Gm-Message-State: AOJu0YyThbw7qEt0EbLZKKlIU/rLtUsHPAN6V9dSL8MEscCrVLvTunWq
	g/bBIQd4lZEpER2XCBZp1VkrKxGEbArTU6mlg1EehSAF8eDis0tzNkc9sjwrk+oQavVwrKl4I3C
	LVE0aVNGcFHn1bmCcV4qmFl6pXOKBTofpSkhkjwFfLUI6qJTATXULoSkM5N/fXzED2BZhi7H9lq
	Z7nrXrnvhur8LVaF43qc2foOU5rF3akhUYltmYQBC/8ADcdg==
X-Received: by 2002:a17:90a:c78c:b0:29d:df16:1b2e with SMTP id gn12-20020a17090ac78c00b0029ddf161b2emr2774556pjb.9.1710833708497;
        Tue, 19 Mar 2024 00:35:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFYza1ZeIHJDT2P6ocJscHx4PFf2ruYoF5xnPllboE9ETH+lB8kClMdVFS04gfYhsKNcp7EiX4PMqi03ip1rI=
X-Received: by 2002:a17:90a:c78c:b0:29d:df16:1b2e with SMTP id
 gn12-20020a17090ac78c00b0029ddf161b2emr2774516pjb.9.1710833707572; Tue, 19
 Mar 2024 00:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Changhui Zhong <czhong@redhat.com>
Date: Tue, 19 Mar 2024 15:34:56 +0800
Message-ID: <CAGVVp+WyM-ce=c1L4p2EZfvLyxYZSHFkxKLad1TXXyNdVn1KYg@mail.gmail.com>
Subject: [bug report] WARNING: CPU: 0 PID: 226 at drivers/pci/pci.c:2236 pci_disable_device+0xf4/0x100
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
branch: master
commit HEAD:b3603fcb79b1036acae10602bffc4855a4b9af80

dmesg log:
Rebooting.
[  292.644951] {1}[Hardware Error]: Hardware error from APEI Generic
Hardware Error Source: 5
[  292.644955] {1}[Hardware Error]: event severity: fatal
[  292.644958] {1}[Hardware Error]:  Error 0, type: fatal
[  292.644959] {1}[Hardware Error]:   section_type: PCIe error
[  292.644960] {1}[Hardware Error]:   port_type: 0, PCIe end point
[  292.644962] {1}[Hardware Error]:   version: 3.0
[  292.644963] {1}[Hardware Error]:   command: 0x0002, status: 0x0010
[  292.644964] {1}[Hardware Error]:   device_id: 0000:01:00.1
[  292.644966] {1}[Hardware Error]:   slot: 0
[  292.644967] {1}[Hardware Error]:   secondary_bus: 0x00
[  292.644968] {1}[Hardware Error]:   vendor_id: 0x14e4, device_id: 0x165f
[  292.644969] {1}[Hardware Error]:   class_code: 020000
[  292.644971] {1}[Hardware Error]:   aer_uncor_status: 0x00100000,
aer_uncor_mask: 0x00010000
[  292.644972] {1}[Hardware Error]:   aer_uncor_severity: 0x000ef030
[  292.644973] {1}[Hardware Error]:   TLP Header: 40000001 0000020f
90028090 00000000
[  292.644976] Kernel panic - not syncing: Fatal hardware error!
[  292.644978] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0+ #1
[  292.644981] Hardware name: Dell Inc. PowerEdge R640/0X45NX, BIOS
2.19.1 06/04/2023
[  292.644982] Call Trace:
[  292.644984]  <NMI>
[  292.644985]  panic+0x32b/0x350
[  292.644995]  __ghes_panic+0x69/0x70
[  292.645000]  ghes_in_nmi_queue_one_entry.constprop.0+0x1d9/0x2b0
[  292.645005]  ghes_notify_nmi+0x59/0xd0
[  292.645007]  nmi_handle+0x5b/0x150
[  292.645014]  default_do_nmi+0x40/0x100
[  292.645017]  exc_nmi+0x100/0x180
[  292.645019]  end_repeat_nmi+0xf/0x53
[  292.645023] RIP: 0010:intel_idle+0x59/0xa0
[  292.645028] Code: d2 48 89 d1 65 48 8b 05 55 21 73 70 0f 01 c8 48
8b 00 a8 08 75 14 66 90 0f 00 2d 2e 00 43 00 b9 01 00 00 00 48 89 f0
0f 01 c9 <65> 48 8b 05 2f 21 73 70 f0 80 60 02 df f0 83 44 24 fc 00 48
8b 00
[  292.645030] RSP: 0018:ffffffff90403e48 EFLAGS: 00000046
[  292.645032] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000001
[  292.645034] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff93d22fa3ffa0
[  292.645035] RBP: ffff93d22fa3ffa0 R08: 0000000000000002 R09: 00000000fffffffd
[  292.645036] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff908bbf60
[  292.645037] R13: ffffffff908bc048 R14: 0000000000000002 R15: 0000000000000000
[  292.645040]  ? intel_idle+0x59/0xa0
[  292.645043]  ? intel_idle+0x59/0xa0
[  292.645046]  </NMI>
[  292.645046]  <TASK>
[  292.645047]  cpuidle_enter_state+0x7d/0x410
[  292.645050]  cpuidle_enter+0x29/0x40
[  292.645054]  cpuidle_idle_call+0xf8/0x160
[  292.645060]  do_idle+0x7a/0xe0
[  292.645062]  cpu_startup_entry+0x25/0x30
[  292.645065]  rest_init+0xcc/0xd0
[  292.645068]  start_kernel+0x325/0x400
[  292.645072]  x86_64_start_reservations+0x14/0x30
[  292.645076]  x86_64_start_kernel+0xed/0xf0
[  292.645079]  common_startup_64+0x13e/0x141
[  292.645084]  </TASK>
[  292.645101] Kernel Offset: 0xdc00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)


# lspci -nn -s 01:00.1
01:00.1 Ethernet controller [0200]: Broadcom Inc. and subsidiaries
NetXtreme BCM5720 Gigabit Ethernet PCIe [14e4:165f]

# lspci -vvv -s 01:00.1
01:00.1 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme
BCM5720 Gigabit Ethernet PCIe
        DeviceName: NIC4
        Subsystem: Broadcom Inc. and subsidiaries Device 4160
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 17
        NUMA node: 0
        Region 0: Memory at 92900000 (64-bit, prefetchable) [size=64K]
        Region 2: Memory at 92910000 (64-bit, prefetchable) [size=64K]
        Region 4: Memory at 92920000 (64-bit, prefetchable) [size=64K]
        Expansion ROM at 90040000 [disabled] [size=256K]
        Capabilities: [48] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
                Product Name: Broadcom NetXtreme Gigabit Ethernet
                Read-only fields:
                        [PN] Part number: BCM95720
                        [MN] Manufacture ID: 1028
                        [V0] Vendor specific: FFV22.61.8
                        [V1] Vendor specific: DSV1028VPDR.VER1.0
                        [V2] Vendor specific: NPY2
                        [V3] Vendor specific: PMT1
                        [V4] Vendor specific: NMVBroadcom Corp
                        [V5] Vendor specific: DTINIC
                        [V6] Vendor specific: DCM3001008d454101008d45
                        [RV] Reserved: checksum good, 233 byte(s) reserved
                End
        Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [a0] MSI-X: Enable+ Count=17 Masked-
                Vector table: BAR=4 offset=00000000
                PBA: BAR=4 offset=00001000
        Capabilities: [ac] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<4us, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
FLReset+ SlotPowerLimit 25.000W
                DevCtl: CorrErr- NonFatalErr+ FatalErr+ UnsupReq+
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop- FLReset-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x2, ASPM not supported
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
                        ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s (ok), Width x2 (ok)
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
NROPrPrP- LTR-
                         10BitTagComp- 10BitTagReq- OBFF Not
Supported, ExtFmt- EETLPPrefix-
                         EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
                         FRS- TPHComp- ExtTPHComp-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 65ms to 210ms,
TimeoutDis- LTR- OBFF Disabled,
                         AtomicOpsCtl: ReqEn-
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete- EqualizationPhase1-
                         EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt+ RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP+ FCP+ CmpltTO+ CmpltAbrt+
UnxCmplt- RxOF+ MalfTLP+ ECRC+ UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
                CEMsk:  RxErr- BadTLP+ BadDLLP+ Rollover+ Timeout+
AdvNonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+
ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 40000001 0000020f 90028090 00000000
        Capabilities: [13c v1] Device Serial Number 00-00-e4-3d-1a-3c-8b-bb
        Capabilities: [150 v1] Power Budgeting <?>
        Capabilities: [160 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
        Kernel driver in use: tg3
        Kernel modules: tg3

Thanks,


