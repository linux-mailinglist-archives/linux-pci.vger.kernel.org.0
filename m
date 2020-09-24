Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293FB277AF2
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 23:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgIXVL7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 17:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXVL7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 17:11:59 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2567C0613CE
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 14:11:59 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id y5so295255otg.5
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 14:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=T2p+2XFe021nybhzhCnts1MZl1jkI/Qj/myVLR60kBE=;
        b=vXR+tT5iLfpaWzci6GIQT8ChvvYPICdW1c6QhZWuCnw6Dhl6mKZG3qOQJRDOkdlqxQ
         gs1zav+9AcdwzMSRKO7ZZ9L/nO/9L83hU9oRjq5KAiABYtmpm9o6Y5C122talVCW6OKE
         GozdoW6fyEFbqIxeZwBC1CsLOynuwVmSIKnxzynGwDy8oyZOdfGJoQhrkm8sCWFUFwWm
         w8hbC7NIYBXhurgE4Ual5fyoQqk858t1DFcAryIbqtRwg5iqvCuzWPwpsenPeFy7Qc9F
         qz5b9riigBt6omoiTm+rZDOXRwwP2FH9RQl572IB1Ziw+FzQg4LgZLcyZ82o/+Z2AZvh
         /ZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=T2p+2XFe021nybhzhCnts1MZl1jkI/Qj/myVLR60kBE=;
        b=bp4lq7wDZxGzoRRPj5+Y6T35ozk1EuN3HkL9VwKOmp/D1A+Nz0EmZJ3shNu3OCBju9
         gmzsOBkJphYg0CWK39SkCjZU6rJRxnYmIuIl91D/unBp7kwLg/9zQm8Pdo/QziS1dlAH
         oAK6/xlSPkO0OBaUfX0eGcRkvtrNq+mcL8L+037MH0wgE2aQRs2A768DbqpkXq3FCX09
         MYAIOfsTRH6vhXuJWyu/sjPk0IyUvBFsxz456mADwSEgDN1DaY/FCJ8Kb96+q4dgJauu
         J5Gep0LKzYIoNUN9yZTzPunHULRQvZw0K2YNdJRwx66N6T/tkZQKbVx3JYVeqXHvyF2r
         PYEA==
X-Gm-Message-State: AOAM532QGGKlO7oowV8hK2hfdiNUaLIkpa9x1n9qfmVvCKRJeigqwo3P
        B2pBCptedne8VFQDTdV7NSrsgRFZxi0=
X-Google-Smtp-Source: ABdhPJxwAAnusTVvOvrU/YxvkCSv3bi8LVsgDTC3kSi8XmU4JUGFt11QYKznVljtfwhVpXSvhqp8AQ==
X-Received: by 2002:a9d:4695:: with SMTP id z21mr755501ote.91.1600981918514;
        Thu, 24 Sep 2020 14:11:58 -0700 (PDT)
Received: from ian.penurio.us ([47.184.24.231])
        by smtp.gmail.com with ESMTPSA id g21sm162893oos.36.2020.09.24.14.11.57
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 14:11:57 -0700 (PDT)
To:     linux-pci@vger.kernel.org
From:   Ian Pilcher <arequipeno@gmail.com>
Subject: NVIDIA Quadro P1000 needs vfio_pci.nointxmask
Message-ID: <cc168bbc-0618-cde6-0003-0a927c1728a8@gmail.com>
Date:   Thu, 24 Sep 2020 16:11:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I have found that my NVIDIA Quadro P1000 GPU requires the
vfio_pci.nointxmask option to function properly.

Here is the lspci output.

> 05:00.0 VGA compatible controller: NVIDIA Corporation GP107GL [Quadro P1000] (rev a1) (prog-if 00 [VGA controller])
>         Subsystem: Hewlett-Packard Company Device 11bc
>         Physical Slot: 2
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 32 bytes
>         Interrupt: pin A routed to IRQ 89
>         NUMA node: 0
>         Region 0: Memory at fa000000 (32-bit, non-prefetchable) [size=16M]
>         Region 1: Memory at 383fe0000000 (64-bit, prefetchable) [size=256M]
>         Region 3: Memory at 383ff0000000 (64-bit, prefetchable) [size=32M]
>         Region 5: I/O ports at e000 [size=128]
>         Expansion ROM at fb000000 [disabled] [size=512K]
>         Capabilities: [60] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [68] MSI: Enable+ Count=1/1 Maskable- 64bit+
>                 Address: 00000000fee00a78  Data: 0000
>         Capabilities: [78] Express (v2) Legacy Endpoint, MSI 00
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
>                         ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq-
>                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 256 bytes, MaxReadReq 4096 bytes
>                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
>                 LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <512ns, L1 <16us
>                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s (downgraded), Width x16 (ok)
>                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Range AB, TimeoutDis+, NROPrPrP-, LTR-
>                          10BitTagComp-, 10BitTagReq-, OBFF Via message, ExtFmt-, EETLPPrefix-
>                          EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
>                          FRS-
>                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
>                          AtomicOpsCtl: ReqEn-
>                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, EqualizationPhase1+
>                          EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
>         Capabilities: [100 v1] Virtual Channel
>                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
>                 Arb:    Fixed- WRR32- WRR64- WRR128-
>                 Ctrl:   ArbSelect=Fixed
>                 Status: InProgress-
>                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>                         Status: NegoPending- InProgress-
>         Capabilities: [128 v1] Power Budgeting <?>
>         Capabilities: [420 v2] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>                 AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
>                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>                 HeaderLog: 00000000 00000000 00000000 00000000
>         Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1 Len=024 <?>
>         Capabilities: [900 v1] Secondary PCI Express
>                 LnkCtl3: LnkEquIntrruptEn-, PerformEqu-
>                 LaneErrStat: 0
>         Kernel driver in use: vfio-pci
>         Kernel modules: nouveau
> 00: de 10 b1 1c 07 01 10 00 a1 00 00 03 08 00 80 00
> 10: 00 00 00 fa 0c 00 00 e0 3f 38 00 00 0c 00 00 f0
> 20: 3f 38 00 00 01 e0 00 00 00 00 00 00 3c 10 bc 11
> 30: 00 00 00 fb 60 00 00 00 00 00 00 00 0b 01 00 00
> 40: 3c 10 bc 11 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 01 00 00 00 ce d6 23 00 00 00 00 00
> 60: 01 68 03 00 08 00 00 00 05 78 81 00 78 0a e0 fe
> 70: 00 00 00 00 00 00 00 00 10 00 12 00 e1 8d 68 00
> 80: 37 51 00 00 03 3d 46 00 40 00 01 11 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 13 00 04 00
> a0: 00 00 00 00 0e 00 00 00 03 00 1e 00 00 00 00 00
> b0: 00 00 00 00 09 00 14 01 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 05:00.1 Audio device: NVIDIA Corporation GP107GL High Definition Audio Controller (rev a1)
>         Subsystem: Hewlett-Packard Company Device 11bc
>         Physical Slot: 2
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx+
>         Latency: 0, Cache Line Size: 32 bytes
>         Interrupt: pin B routed to IRQ 17
>         NUMA node: 0
>         Region 0: Memory at fb080000 (32-bit, non-prefetchable) [size=16K]
>         Capabilities: [60] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [78] Express (v2) Endpoint, MSI 00
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
>                         ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 26.000W
>                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq-
>                         RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 256 bytes, MaxReadReq 4096 bytes
>                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
>                 LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <512ns, L1 <4us
>                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>                 LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
>                         ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s (downgraded), Width x16 (ok)
>                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Range AB, TimeoutDis+, NROPrPrP-, LTR-
>                          10BitTagComp-, 10BitTagReq-, OBFF Via message, ExtFmt-, EETLPPrefix-
>                          EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
>                          FRS-, TPHComp-, ExtTPHComp-
>                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
>                          AtomicOpsCtl: ReqEn-
>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>         Capabilities: [100 v2] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>                 AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
>                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>                 HeaderLog: 00000000 00000000 00000000 00000000
>         Kernel driver in use: vfio-pci
>         Kernel modules: snd_hda_intel
> 00: de 10 b9 0f 06 01 18 00 a1 00 03 04 08 00 80 00
> 10: 00 00 08 fb 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 bc 11
> 30: 00 00 00 00 60 00 00 00 00 00 00 00 0a 02 00 00
> 40: 3c 10 bc 11 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 ce d6 23 00 00 00 00 00
> 60: 01 68 03 00 08 00 00 00 05 78 80 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 10 00 02 00 e1 8d 68 00
> 80: 27 51 00 00 03 3d 45 00 43 01 01 11 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 13 00 04 00
> a0: 00 00 00 00 0e 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Without nointxmask, I see the following kernel stack trace, and my
Windows 10 VM locks up when I run Topaz Labs Video Enhance AI.

> ------------[ cut here ]------------
> WARNING: CPU: 4 PID: 2443 at fs/eventfd.c:74 eventfd_signal+0x88/0xa0
> Modules linked in: vhost_net vhost tap vhost_iotlb tun nft_chain_nat 8021q garp mrp stp llc sch_ingress bonding openvswitch nsh nf_conncount nf_na>
> CPU: 4 PID: 2443 Comm: CPU 3/KVM Not tainted 5.8.10-200.fc32.x86_64 #1
> Hardware name: Supermicro SYS-5028D-TN4T/X10SDV-TLN4F, BIOS 2.1 11/22/2019
> RIP: 0010:eventfd_signal+0x88/0xa0
> Code: 03 00 00 00 4c 89 f7 e8 86 17 db ff 65 ff 0d 9f f4 ca 79 4c 89 ee 4c 89 f7 e8 64 8f 7f 00 4c 89 e0 5b 5d 41 5c 41 5d 41 5e c3 <0f> 0b 45 31 >
> RSP: 0018:ffffae7b00767bb0 EFLAGS: 00010286
> RAX: 00000000ffffffff RBX: ffff8d9e2e832800 RCX: 0000000000000004
> RDX: 00000000c8088704 RSI: 0000000000000001 RDI: ffff8d9e2e800700
> RBP: ffffae7b00767c18 R08: ffff8d9be993ca60 R09: 00000000c8088708
> R10: 0000000000000000 R11: 0000000000000190 R12: 0000000000000002
> R13: ffff8d9be94ebb00 R14: ffff8d9be993ca60 R15: ffff8d9be94ebb00
> FS:  00007ff77dffb700(0000) GS:ffff8dac3fb00000(0000) knlGS:0000008efba30000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000225c9548000 CR3: 0000001fcdc6a003 CR4: 00000000003626e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  ioeventfd_write+0x51/0x80 [kvm]
>  __kvm_io_bus_write+0x88/0xb0 [kvm]
>  kvm_io_bus_write+0x43/0x60 [kvm]
>  write_mmio+0x70/0xf0 [kvm]
>  emulator_read_write_onepage+0x11e/0x330 [kvm]
>  emulator_read_write+0xca/0x180 [kvm]
>  segmented_write.isra.0+0x4a/0x60 [kvm]
>  x86_emulate_insn+0x850/0xe60 [kvm]
>  x86_emulate_instruction+0x2c7/0x780 [kvm]
>  ? kvm_io_bus_write+0x43/0x60 [kvm]
>  kvm_arch_vcpu_ioctl_run+0xeb9/0x1770 [kvm]
>  ? pci_user_read_config_dword+0x61/0xd0
>  ? __check_object_size+0x46/0x147
>  kvm_vcpu_ioctl+0x209/0x590 [kvm]
>  ksys_ioctl+0x82/0xc0
>  __x64_sys_ioctl+0x16/0x20
>  do_syscall_64+0x4d/0x90
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7ff7884f73bb
> Code: 0f 1e fa 48 8b 05 dd aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 >
> RSP: 002b:00007ff77dffa668 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 000055650cee0d10 RCX: 00007ff7884f73bb
> RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000000000000001f
> RBP: 00007ff7845d2000 R08: 000055650c42cbf0 R09: 000055650e7399a0
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 000055650c8c6a00
> ---[ end trace 5ce939bd61fb53fe ]---

-- 
========================================================================
                  In Soviet Russia, Google searches you!
========================================================================
