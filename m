Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784F63EC0B4
	for <lists+linux-pci@lfdr.de>; Sat, 14 Aug 2021 07:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbhHNF1L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Aug 2021 01:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237314AbhHNF1L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Aug 2021 01:27:11 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E1FC061757
        for <linux-pci@vger.kernel.org>; Fri, 13 Aug 2021 22:26:43 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso4897014pjh.5
        for <linux-pci@vger.kernel.org>; Fri, 13 Aug 2021 22:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=szedVpv22gAAXNt+NxiXfQDJ2vg4L6FUHMmJ5d58F0A=;
        b=JFAtjuVQ/3To/dvsxvNoSnxhzp8lSwiKTBCZFO8PNDLMPYOUV2F7MiuC1Q7/HTKjH0
         EVnfMQf4jyLw6/e7pGnY50iNxicGGWLq132rLWNWTD0KKC8Szv91p7fmDZeSblrK2mh3
         3Paiz3090DFv2mqZM19I+zfaF10jSGYNN9atjGbTZrs19lCE7TlfVakC/mEuzAw9BsX/
         HeWOUW4B97o08f+LGOAZSc8vwH1GU6uG6A3dXblwwE6e4JsR8CHOwXHOCDD0nQjBWxpJ
         AV+qgy+DFzret+0pzFGGen9vbIGiOqC9JAlpOevzbgW/EfweQgxbUXvuDouIi8m//55R
         n3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=szedVpv22gAAXNt+NxiXfQDJ2vg4L6FUHMmJ5d58F0A=;
        b=PpXAoHrYS88NSB7jgagsiGlFlnBTQchJaVQNO9UfUHsyBvC/jFoY1f6nnyUYyfxdwz
         Ejlmr1Du3MtY1+ysRo9w82iwinxnU62IeiRf3INtUajG7xVC1utmEtsxBQ3BS8gADtox
         eyVm6YfPBxhJ0Ak8NbxuN691MVSAVIAuARYFGG2b5M0/e27PtY+OKEEtJDhUu9bPapJ4
         KhQAamQwb6nS9lJ9UjeqXsEhymVtVJord8+agYjUj5VmcyQ4mWcI/y9eAQjRW3R/c250
         4lDHzcqOeIBOgqwuxhjpCSezHm2AS9so3DS5tj+OrPqbQeK93fX6Xd1cIl3MhEMk27KV
         wP+Q==
X-Gm-Message-State: AOAM533CElIxtmSAUU4emverKYGmrxdwU5Z0OzeOtnjY0KfTEwxnMfxL
        oG9n9GimP/eAS6EbUfrihSBIAjQZvmucZxfcQ7PlCo+aL5mUcQ==
X-Google-Smtp-Source: ABdhPJyJBJ+Y3xwD/Z6i8OMcRWKE/tZwzqakp9LNcySryJ4gB3Hfwr1zAtrTZntoKrH1W04ouou8IG2aHAwTWYGr2sI=
X-Received: by 2002:a17:90a:6888:: with SMTP id a8mr193629pjd.91.1628918802590;
 Fri, 13 Aug 2021 22:26:42 -0700 (PDT)
MIME-Version: 1.0
From:   Rajat Jain <rajatja@google.com>
Date:   Fri, 13 Aug 2021 22:26:06 -0700
Message-ID: <CACK8Z6HLr4tk4UkrzBN7wydDmqk=cqN2a7bQfVdjp9cE_ov_Jw@mail.gmail.com>
Subject: PCIe device (thunderbolt tunneled) runtime suspended while driver
 wants to attach.
To:     linux-pci <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, linux-usb@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mika Westerberg <mika.westerberg@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alex Levin <levinale@google.com>,
        Madhusudanarao Amara 
        <madhusudanarao.amara@intel.corp-partner.google.com>,
        Prashant Malani <pmalani@google.com>,
        "abhijeet.rao@intel.com" <abhijeet.rao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

I'm using Kernel 5.10 and am seeing a regression w.r.t. 5.4 kernel (I
plan to try the latest kernel in some time). I have a thunderbolt SSD
[1]. After the thunderbolt tunnels are created, it shows up as a PCIe
NVME device (behind a PCIe switch internal to the SSD):

localhost ~ # lspci -t
-[0000:00]-+-00.0
           +-02.0
           +-04.0
           +-05.0
           +-07.0-[01-2b]--
           +-07.1-[2c-56]--
           +-07.2-[57-81]----00.0-[58-81]----01.0-[59-81]----00.0
<------ NVME (0000:59:00.0)
           +-08.0
           +-0a.0
           +-0d.0
           +-0d.2
           +-0d.3
           +-14.0
           +-14.2
           +-14.3
           +-15.0
           +-15.1
           +-15.2
           +-15.3
           +-16.0
           +-19.0
           +-19.1
           +-1c.0-[82]----00.0
           +-1c.7-[83]----00.0
           +-1d.0-[84]----00.0
           +-1e.0
           +-1e.3
           +-1f.0
           +-1f.3
           \-1f.5
localhost ~ #

The PCI bus enumeration goes through fine, and the PCIe resource
assignment is done correctly as far as I can see:

1423.813513] pcieport 0000:00:07.2: pciehp: Slot(5): Card present
1423.820263] pcieport 0000:00:07.2: pciehp: Slot(5): Link Up
1423.953045] pci 0000:57:00.0: [8086:15da] type 01 class 0x060400
1423.959875] pci 0000:57:00.0: enabling Extended Tags
1423.965653] pci 0000:57:00.0: supports D1 D2
1423.970433] pci 0000:57:00.0: PME# supported from D0 D1 D2 D3hot D3cold
1423.977900] pci 0000:57:00.0: 8.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s PCIe x4 link at 0000:00:07.2 (capable of 31.504
Gb/s with 8.0 GT/s PCIe x4 link)
1423.994843] pci 0000:57:00.0: Adding to iommu group 23
1424.004806] pci 0000:57:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring
1424.013929] pci 0000:58:01.0: [8086:15da] type 01 class 0x060400
1424.020734] pci 0000:58:01.0: enabling Extended Tags
1424.026428] pci 0000:58:01.0: supports D1 D2
1424.031205] pci 0000:58:01.0: PME# supported from D0 D1 D2 D3hot D3cold
1424.038689] pci 0000:58:01.0: Adding to iommu group 24
1424.044651] pci 0000:57:00.0: PCI bridge to [bus 58-81]
1424.050512] pci 0000:57:00.0:   bridge window [io  0x0000-0x0fff]
1424.057344] pci 0000:57:00.0:   bridge window [mem 0x00000000-0x000fffff]
1424.064948] pci 0000:57:00.0:   bridge window [mem
0x00000000-0x000fffff 64bit pref]
1424.073620] pci 0000:58:01.0: bridge configuration invalid ([bus
00-00]), reconfiguring
1424.082742] pci 0000:59:00.0: [144d:a808] type 00 class 0x010802
1424.089506] pci 0000:59:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
1424.097437] pci 0000:59:00.0: 8.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s PCIe x4 link at 0000:00:07.2 (capable of 31.504
Gb/s with 8.0 GT/s PCIe x4 link)
1424.114209] pci 0000:59:00.0: Adding to iommu group 24
1424.122145] udevd[10117]: Process '/sbin/restorecon ' failed with
exit code 255.
1424.124803] pci 0000:58:01.0: PCI bridge to [bus 59-81]
1424.136333] pci 0000:58:01.0:   bridge window [io  0x0000-0x0fff]
1424.143169] pci 0000:58:01.0:   bridge window [mem 0x00000000-0x000fffff]
1424.150774] pci 0000:58:01.0:   bridge window [mem
0x00000000-0x000fffff 64bit pref]
1424.159446] pci_bus 0000:59: busn_res: [bus 59-81] end is updated to 81
1424.166856] pci_bus 0000:58: busn_res: [bus 58-81] end is updated to 81
1424.174272] pci 0000:58:01.0: bridge window [mem
0x00100000-0x001fffff 64bit pref] to [bus 59-81] add_size 100000
add_align 100000
1424.187411] pci 0000:58:01.0: bridge window [mem
0x00100000-0x001fffff] to [bus 59-81] add_size 100000 add_align 100000
1424.199481] pci 0000:57:00.0: bridge window [mem
0x00100000-0x001fffff 64bit pref] to [bus 58-81] add_size 100000
add_align 100000
1424.212609] pci 0000:57:00.0: bridge window [mem
0x00100000-0x001fffff] to [bus 58-81] add_size 100000 add_align 100000
1424.224678] pci 0000:57:00.0: BAR 8: assigned [mem 0xac200000-0xb83fffff]
1424.232269] pci 0000:57:00.0: BAR 9: assigned [mem
0x2b7c00000-0x2d3bfffff 64bit pref]
1424.241127] pci 0000:57:00.0: BAR 7: assigned [io  0x6000-0x7fff]
1424.247944] pci 0000:58:01.0: BAR 8: assigned [mem 0xac200000-0xb83fffff]
1424.255539] pci 0000:58:01.0: BAR 9: assigned [mem
0x2b7c00000-0x2d3bfffff 64bit pref]
1424.264396] pci 0000:58:01.0: BAR 7: assigned [io  0x6000-0x7fff]
1424.271209] pci 0000:59:00.0: BAR 0: assigned [mem
0xac200000-0xac203fff 64bit] <----- assigned
1424.279409] pci 0000:58:01.0: PCI bridge to [bus 59-81]
1424.285263] pci 0000:58:01.0:   bridge window [io  0x6000-0x7fff]
1424.292089] pci 0000:58:01.0:   bridge window [mem 0xac200000-0xb83fffff]
1424.299690] pci 0000:58:01.0:   bridge window [mem
0x2b7c00000-0x2d3bfffff 64bit pref]
1424.308560] pci 0000:57:00.0: PCI bridge to [bus 58-81]
1424.314418] pci 0000:57:00.0:   bridge window [io  0x6000-0x7fff]
1424.321251] pci 0000:57:00.0:   bridge window [mem 0xac200000-0xb83fffff]
1424.328851] pci 0000:57:00.0:   bridge window [mem
0x2b7c00000-0x2d3bfffff 64bit pref]
1424.337720] pcieport 0000:00:07.2: PCI bridge to [bus 57-81]
1424.344062] pcieport 0000:00:07.2:   bridge window [io  0x6000-0x7fff]
1424.351377] pcieport 0000:00:07.2:   bridge window [mem 0xac200000-0xb83fffff]
1424.359455] pcieport 0000:00:07.2:   bridge window [mem
0x2b7c00000-0x2d3bfffff 64bit pref]1424.377279] pcieport 0000:57:00.0:
enabling device (0000 -> 0003)
1424.393001] pcieport 0000:58:01.0: enabling device (0000 -> 0003)
1424.408363] pcieport 0000:58:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl-
MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+
IbPresDis- LLActRep+

However, the PCIe NVME driver attaches fine only half the time, and
refuses to attach the other 50% of the time:

1424.464958] nvme nvme1: pci function 0000:59:00.0
1424.470366] nvme 0000:59:00.0: enabling device (0000 -> 0002)
1424.477196] nvme nvme1: Removing after probe failure status: -19

Careful examination shows that the probe fails because the register
accesses (in the memory space) made by the driver don't go through
because the BAR register has been zeroed out somehow (lspci info at
the end of the mail). On writing manually the BAR register again using
setpci and re-attaching the driver, it works this time. So essentially
the BAR register loses its value somehow.

My theory is somehow the runtime PM is kicking in the wrong order, or
when it is not supposed to, which is causing the BAR register to be
wiped out. So I enabled the RPM traces via
/sys/kernel/debug/tracing/events/rpm/enable. I noticed that in the
failure scenarios, the PCIe NVME device was apparently runtime
suspended at the time the driver was trying to attach to the device.
In the successful scenarios, I don't see any of the PCIe device in
that device hierarchy being suspended while the enumeration / driver
attach is going on. My questions are:

1) Do I understand it right that I can conclude that the device
59:00.0 was runtime suspended between the following 2 prints in the
tracelog?

<...>-25917   [002] d..1  2612.612591: rpm_return_int:
rpm_suspend+0x4cd/0x514:0000:59:00.0 ret=0
....
<was the device suspended here?>
....
kworker/0:1-15      [000] d..1  2632.059915: rpm_return_int:
rpm_resume+0x392/0x570:0000:59:00.0 ret=0

2) Is my understanding correct that any device should NOT be runtime
suspended while a driver is trying to attach to the device? Where is
this ensured (for e.g. for NVMEs)? Is this ensured by the driver core,
or a device driver that is trying to probe a PCI device needs to
ensure this?

3) So all downstream devices of a PCI bridge need to be suspended
before it can be suspended (and vice versa for resume)? In other
words, is ita bug if I notice that a PCI bridge is runtime suspended
while any of its downstream devices are not?

4) Any suggestions for me to try? I have noticed that putting a lot of
debug prints changes the  situation (converts failing case into pass
case) but may be that hints something to do with timing / race
condition?

Thanks,
Rajat

More details:

[1] Product: https://www.amazon.com/gp/product/B07GBTY82P/ref=ppx_yo_dt_b_search_asin_title?ie=UTF8&psc=1

[2] Detailed lspci info for all devices in the PCI chain starting from
root port and ending at end point (in successful case):

00:07.2 PCI bridge: Intel Corporation Device 462f (rev 03) (prog-if 00
[Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin C routed to IRQ 157
Bus: primary=00, secondary=57, subordinate=81, sec-latency=0
I/O behind bridge: 00006000-00007fff [size=8K]
Memory behind bridge: ac200000-b83fffff [size=194M]
Prefetchable memory behind bridge: 00000002b7c00000-00000002d3bfffff [size=448M]
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #4, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L1 <64us
ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+
BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
Slot #5, PowerLimit 0.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Via
WAKE# ARIFwd+
AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-
AtomicOpsCtl: ReqEn- EgressBlck-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee00000  Data: 0000
Capabilities: [90] Subsystem: Intel Corporation Device 7270
Capabilities: [a0] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [100 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
HeaderLog: 00000000 00000000 00000000 00000000
RootCmd: CERptEn+ NFERptEn+ FERptEn+
RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
Capabilities: [220 v1] Access Control Services
ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
EgressCtrl- DirectTrans-
ACSCtl: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
EgressCtrl- DirectTrans-
Capabilities: [a00 v1] Downstream Port Containment
DpcCap: INT Msg #0, RPExt+ PoisonedTLP- SwTrigger- RP PIO Log 0, DL_ActiveErr-
DpcCtl: Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- DL_ActiveErr-
DpcSta: Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO ErrPtr:1f
Source: 0000
Capabilities: [a30 v1] #19
Capabilities: [a90 v1] #25
Capabilities: [ba0 v0] #15
Kernel driver in use: pcieport

57:00.0 PCI bridge: Intel Corporation Device 15da (rev 02) (prog-if 00
[Normal decode])
Physical Slot: 5
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 200
Bus: primary=57, secondary=58, subordinate=81, sec-latency=0
I/O behind bridge: 00006000-00007fff [size=8K]
Memory behind bridge: ac200000-b83fffff [size=194M]
Prefetchable memory behind bridge: 00000002b7c00000-00000002d3bfffff [size=448M]
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [80] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [88] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee12000  Data: 4026
Capabilities: [ac] Subsystem: Samsung Electronics Co Ltd Device a811
Capabilities: [c0] Express (v2) Upstream Port, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 0.000W
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency
L0s <2us, L1 <4us
ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
LnkCtl: ASPM Disabled; Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, OBFF
Not Supported
AtomicOpsCap: Routing-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled
AtomicOpsCtl: EgressBlck-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [100 v1] Device Serial Number 5b-66-34-11-98-c9-a0-00
Capabilities: [200 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
HeaderLog: 00000000 00000000 00000000 00000000
Capabilities: [300 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
Status: NegoPending- InProgress-
Capabilities: [400 v1] Power Budgeting <?>
Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=0d8 <?>
Capabilities: [600 v1] Latency Tolerance Reporting
Max snoop latency: 0ns
Max no snoop latency: 0ns
Capabilities: [700 v1] #19
Kernel driver in use: pcieport


58:01.0 PCI bridge: Intel Corporation Device 15da (rev 02) (prog-if 00
[Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 201
Bus: primary=58, secondary=59, subordinate=81, sec-latency=0
I/O behind bridge: 00006000-00007fff [size=8K]
Memory behind bridge: ac200000-b83fffff [size=194M]
Prefetchable memory behind bridge: 00000002b7c00000-00000002d3bfffff [size=448M]
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [80] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [88] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee14000  Data: 4025
Capabilities: [ac] Subsystem: Samsung Electronics Co Ltd Device a811
Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag+ RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #1, Speed 8GT/s, Width x4, ASPM L0s L1, Exit Latency L0s
<2us, L1 <4us
ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
LnkCtl: ASPM Disabled; Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 8GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
Slot #1, PowerLimit 0.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
Changed: MRL- PresDet- LinkState-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, OBFF
Not Supported ARIFwd-
AtomicOpsCap: Routing-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
Disabled ARIFwd-
AtomicOpsCtl: EgressBlck-
LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -3.5dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+,
EqualizationPhase1+
EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
Capabilities: [100 v1] Device Serial Number 5b-66-34-11-98-c9-a0-00
Capabilities: [200 v1] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP+ Rollover- Timeout- NonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
HeaderLog: 00000000 00000000 00000000 00000000
Capabilities: [300 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
Status: NegoPending- InProgress-
Capabilities: [400 v1] Power Budgeting <?>
Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=0d8 <?>
Capabilities: [700 v1] #19
Kernel driver in use: pcieport

59:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd
Device a808 (prog-if 02 [NVM Express])
Subsystem: Samsung Electronics Co Ltd Device a811
Physical Slot: 1
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 20
Region 0: Memory at ac200000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Capabilities: [70] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0.000W
DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 <64us
ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 8GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Not Supported
AtomicOpsCap: 32bit- 64bit- 128bitCAS-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled
AtomicOpsCtl: ReqEn-
LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+,
EqualizationPhase1+
EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
Capabilities: [b0] MSI-X: Enable+ Count=33 Masked-
Vector table: BAR=0 offset=00003000
PBA: BAR=0 offset=00002000
Capabilities: [100 v2] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
HeaderLog: 00000000 00000000 00000000 00000000
Capabilities: [148 v1] Device Serial Number 00-00-00-00-00-00-00-00
Capabilities: [158 v1] Power Budgeting <?>
Capabilities: [168 v1] #19
Capabilities: [188 v1] Latency Tolerance Reporting
Max snoop latency: 0ns
Max no snoop latency: 0ns
Capabilities: [190 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
 PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
  T_CommonMode=0us LTR1.2_Threshold=0ns
L1SubCtl2: T_PwrOn=10us
Kernel driver in use: nvme

[3] lspci of the NVME PCI end point in the failure case:

localhost ~ # lspci -bvvv -s 59:0.0
59:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd
Device a808 (prog-if 02 [NVM Express])
        Subsystem: Samsung Electronics Co Ltd Device a811
        Physical Slot: 1
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 255
        Region 0: Memory at <unassigned> (64-bit, non-prefetchable)
<------ BAR is cleared!
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
FLReset+ SlotPowerLimit 0.000W
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+
AuxPwr- TransPend-
                LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit
Latency L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 8GT/s, Width x4, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+,
LTR+, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR+, OBFF Disabled
                         AtomicOpsCtl: ReqEn-
                LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+, EqualizationPhase1+
                         EqualizationPhase2+, EqualizationPhase3+,
LinkEqualizationRequest-
        Capabilities: [b0] MSI-X: Enable- Count=33 Masked-
                Vector table: BAR=0 offset=00003000
                PBA: BAR=0 offset=00002000
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+
ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [148 v1] Device Serial Number 00-00-00-00-00-00-00-00
        Capabilities: [158 v1] Power Budgeting <?>
        Capabilities: [168 v1] #19
        Capabilities: [188 v1] Latency Tolerance Reporting
                Max snoop latency: 0ns
                Max no snoop latency: 0ns
        Capabilities: [190 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
ASPM_L1.1+ L1_PM_Substates+
                          PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                           T_CommonMode=0us LTR1.2_Threshold=0ns
                L1SubCtl2: T_PwrOn=10us
