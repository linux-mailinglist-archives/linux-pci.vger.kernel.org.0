Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D962D4C35
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 21:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgLIUvZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 15:51:25 -0500
Received: from halon.esss.lu.se ([194.47.240.54]:51950 "EHLO halon.esss.lu.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgLIUvZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Dec 2020 15:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ess.eu; s=dec2019;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:from;
        bh=Tjm3FkicaED3MPgsW+Ngd3BkwOE6yQExScaHa4hPP/U=;
        b=d27pRZFBxnl1vk23jbMkGxnfdukFk1zzDQSQ1whNzOXYfksXWynuKOATMOZt+oejU+tmvAPi9uAu8
         iSRQdY5jSsUBNlHernGtaPu/j+IZYMttHrX4eNExi8UYiWwIMiIZgl8K66yaNOGR1OQKwOeAaJaDoI
         LF1ilQo8BUfoqzdJpJ141KUc5KTuE3xsDWkzAiiRqHZOLuRUpedwF85Xpkf8xMR9rhdX1QHBmK6mC5
         fh1fhk4jZwIUhUJAhXDalEQ/VZSxbjKQgaJgwjP8W8LphXG4EhZ+0u8XTAHJfsVOI3qVp7wpNTb3J/
         GDEtP+0RvZ8H00uW7YT56uBMK3McrZQ==
Received: from mail.esss.lu.se (it-exch16-4.esss.lu.se [10.0.42.134])
        by halon.esss.lu.se (Halon) with ESMTPS
        id 239ae6fc-3a60-11eb-93c8-005056a66d10;
        Wed, 09 Dec 2020 21:50:15 +0100 (CET)
Received: from [192.168.0.9] (194.47.241.248) by it-exch16-4.esss.lu.se
 (10.0.42.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 9 Dec 2020
 21:50:18 +0100
Subject: Re: Recovering from AER: Uncorrected (Fatal) error
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20201209174009.GA2532473@bjorn-Precision-5520>
From:   Hinko Kocevar <hinko.kocevar@ess.eu>
Message-ID: <d1ad4c01-ce73-dcc0-99b1-5fe45a984800@ess.eu>
Date:   Wed, 9 Dec 2020 21:50:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201209174009.GA2532473@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [194.47.241.248]
X-ClientProxiedBy: it-exch16-4.esss.lu.se (10.0.42.134) To
 it-exch16-4.esss.lu.se (10.0.42.134)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn!

On 12/9/20 6:40 PM, Bjorn Helgaas wrote:
> [non-standard email quoting below, ">" for both my text and Hinko's,
> see https://en.wikipedia.org/wiki/Posting_style#Interleaved_style]
> 

Apologies. Probably due to the web MUA I used. Hopefully this will be 
better now.


> On Wed, Dec 09, 2020 at 10:02:10AM +0000, Hinko Kocevar wrote:
>> ________________________________________
>> From: Bjorn Helgaas <helgaas@kernel.org>
>> Sent: Friday, December 4, 2020 11:38 PM
>> To: Hinko Kocevar
>> Cc: linux-pci@vger.kernel.org
>> Subject: Re: Recovering from AER: Uncorrected (Fatal) error
>>
>> On Fri, Dec 04, 2020 at 12:52:18PM +0000, Hinko Kocevar wrote:
>>> Hi,
>>>
>>> I'm trying to figure out how to recover from Uncorrected (Fatal) error that is seen by the PCI root on a CPU PCIe controller:
>>>
>>> Dec  1 02:16:37 bd-cpu18 kernel: pcieport 0000:00:01.0: AER: Uncorrected (Fatal) error received: id=0008
>>> Dec  1 02:16:37 bd-cpu18 kernel: pcieport 0000:00:01.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, id=0008(Requester ID)
>>> Dec  1 02:16:37 bd-cpu18 kernel: pcieport 0000:00:01.0:   device [8086:1901] error status/mask=00004000/00000000
>>> Dec  1 02:16:37 bd-cpu18 kernel: pcieport 0000:00:01.0:    [14] Completion Timeout     (First)
>>>
>>> This is the complete PCI device tree that I'm working with:
>>>
>>> $ sudo /usr/local/bin/pcicrawler -t
>>> 00:01.0 root_port, "J6B2", slot 1, device present, speed 8GT/s, width x8
>>>   ├─01:00.0 upstream_port, PLX Technology, Inc. (10b5), device 8725
>>>   │  ├─02:01.0 downstream_port, slot 1, device present, power: Off, speed 8GT/s, width x4
>>>   │  │  └─03:00.0 upstream_port, PLX Technology, Inc. (10b5) PEX 8748 48-Lane, 12-Port PCI Express Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (8748)
>>>   │  │     ├─04:00.0 downstream_port, slot 10, power: Off
>>>   │  │     ├─04:01.0 downstream_port, slot 4, device present, power: Off, speed 8GT/s, width x4
>>>   │  │     │  └─06:00.0 endpoint, Research Centre Juelich (1796), device 0024
>>>   │  │     ├─04:02.0 downstream_port, slot 9, power: Off
>>>   │  │     ├─04:03.0 downstream_port, slot 3, device present, power: Off, speed 8GT/s, width x4
>>>   │  │     │  └─08:00.0 endpoint, Research Centre Juelich (1796), device 0024
>>>   │  │     ├─04:08.0 downstream_port, slot 5, device present, power: Off, speed 8GT/s, width x4
>>>   │  │     │  └─09:00.0 endpoint, Research Centre Juelich (1796), device 0024
>>>   │  │     ├─04:09.0 downstream_port, slot 11, power: Off
>>>   │  │     ├─04:0a.0 downstream_port, slot 6, device present, power: Off, speed 8GT/s, width x4
>>>   │  │     │  └─0b:00.0 endpoint, Research Centre Juelich (1796), device 0024
>>>   │  │     ├─04:0b.0 downstream_port, slot 12, power: Off
>>>   │  │     ├─04:10.0 downstream_port, slot 8, power: Off
>>>   │  │     ├─04:11.0 downstream_port, slot 2, device present, power: Off, speed 2.5GT/s, width x1
>>>   │  │     │  └─0e:00.0 endpoint, Xilinx Corporation (10ee), device 7011
>>>   │  │     └─04:12.0 downstream_port, slot 7, power: Off
>>>   │  ├─02:02.0 downstream_port, slot 2
>>>   │  ├─02:08.0 downstream_port, slot 8
>>>   │  ├─02:09.0 downstream_port, slot 9, power: Off
>>>   │  └─02:0a.0 downstream_port, slot 10
>>>   ├─01:00.1 endpoint, PLX Technology, Inc. (10b5), device 87d0
>>>   ├─01:00.2 endpoint, PLX Technology, Inc. (10b5), device 87d0
>>>   ├─01:00.3 endpoint, PLX Technology, Inc. (10b5), device 87d0
>>>   └─01:00.4 endpoint, PLX Technology, Inc. (10b5), device 87d0
>>>
>>> 00:01.0 is on a CPU board, The 03:00.0 and everything below that is
>>> not on a CPU board (working with a micro TCA system here). I'm
>>> working with FPGA based devices seen as endpoints here.  After the
>>> error all the endpoints in the above list are not able to talk to
>>> CPU anymore; register reads return 0xFFFFFFFF. At the same time PCI
>>> config space looks sane and accessible for those devices.
>>
>> This could be caused by a reset.  We probably do a secondary bus reset
>> on the Root Port, which resets all the devices below it.  After the
>> reset, config space of those downstream devices would be accessible,
>> but the PCI_COMMAND register may be cleared which means the device
>> wouldn't respond to MMIO reads.
>>
>> After adding some printk()'s to the PCIe code that deals with the reset, I can see that the pci_bus_error_reset() calls the pci_bus_reset() due to bus slots list check for empty returns true. So the the secondary bus is being reset.
>>
>> None of this explains the original problem of the Completion Timeout,
>> of course.  The error source of 0x8 (00:01.0) is the root port, which
>> makes sense if it issued a request transaction and never got the
>> completion.  The root port *should* log the header of the request and
>> we should print it, but it looks like we didn't.  "lspci -vv" of the
>> device would show whether it's capable of this logging.
>>
>> I'm mostly concerned about the fact that the secondary bus is
>> rendered useless after the reset/recovery. AIUI, this should not
>> happen.
> 
> It should not.  The secondary bus should still work after the reset.


I was hoping to hear that!


> 
>> After upgrading my pciutils I get a bit more output from lspci -vv for the Root port. It seems it is capable of logging the errors:
>>
>>          Capabilities: [1c0 v1] Advanced Error Reporting
>>                  UESta:  DLP- SDES- TLP- FCP- CmpltTO+ CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>                  UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>                  UESvrt: DLP+ SDES- TLP- FCP- CmpltTO+ CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>>                  CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>>                  CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>>                  AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
>>                          MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>>                  HeaderLog: 00000000 00000001 00000002 00000003
>>                  RootCmd: CERptEn+ NFERptEn+ FERptEn+
>>                  RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>>                           FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
>>                  ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0008
>>
>> The above was provoked with the aer-inject of the same error as seen in initial report, with bogus 'HEADER_LOG 0 1 2 3'.
>>
>> Dec  9 10:25:19 bd-cpu18 kernel: pcieport 0000:00:01.0: aer_inject: Injecting errors 00000000/00004000 into device 0000:00:01.0
>> Dec  9 10:25:19 bd-cpu18 kernel: pcieport 0000:00:01.0: AER: Uncorrected (Fatal) error received: 0000:00:01.0
>> Dec  9 10:25:19 bd-cpu18 kernel: pcieport 0000:00:01.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Requester ID)
>> Dec  9 10:25:19 bd-cpu18 kernel: pcieport 0000:00:01.0:   device [8086:1901] error status/mask=00004000/00000000
>> Dec  9 10:25:19 bd-cpu18 kernel: pcieport 0000:00:01.0:    [14] CmpltTO
>> Dec  9 10:25:19 bd-cpu18 kernel: mrf-pci 0000:0e:00.0: [aer_error_detected] called .. state=2
>>
>>
>> Question: would using different (real?) HEADER_LOG values affect the recovery behaviour?
> 
> No, it shouldn't.  I'm pretty sure we only print those values and they
> don't influence behavior at all.
> 
>>> How can I debug this further? I'm getting the "I/O to channel is
>>> blocked" (pci_channel_io_frozen) state reported to the the endpoint
>>> devices I provide driver for.  Is there any way of telling if the
>>> PCI switch devices between 00:01.0 ... 06:00.0 have all recovered ;
>>> links up and running and similar? Is this information provided by
>>> the Linux kernel somehow?
>>>
>>> For reference, I've experimented with AER inject and my tests showed
>>> that if the same type of error is injected in any other PCI device
>>> in the path 01:00.0 ... 06:00.0, IOW not into 00:01.0, the link is
>>> recovered successfully, and I can continue working with the endpoint
>>> devices. In those cases the "I/O channel is in normal state"
>>> (pci_channel_io_normal) state was reported; only error injection
>>> into 00:01.0 reports pci_channel_io_frozen state. Recovery code in
>>> the endpoint drivers I maintain is just calling the
>>> pci_cleanup_aer_uncorrect_error_status() in error handler resume()
>>> callback.
>>>
>>> FYI, this is on 3.10.0-1160.6.1.el7.x86_64.debug CentOS7 kernel
>>> which I believe is quite old. At the moment I can not use newer
>>> kernel, but would be prepared to take that step if told that it
>>> would help.
>>
>> It's really not practical for us to help debug a v3.10-based kernel;
>> that's over seven years old and AER handling has changed significantly
>> since then.  Also, CentOS is a distro kernel and includes many changes
>> on top of the v3.10 upstream kernel.  Those changes might be
>> theoretically open-source, but as a practical matter, the distro is a
>> better place to start for support of their kernel.
>>
>> I followed your advice and started using kernel 5.9.12; hope this is recent enough.
>>
>> With that kernel I see a bit of different behavior than with the
>> 3.10 earlier. Configuration access to the devices on the secondary
>> bus is not OK; all 0xFFFFFFFF. This is what I see after the error
>> was injected into the root port 00:01.0 and secondary bus reset was
>> made as part of recovery:
>>
>> 00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor PCIe Controller (x16) (rev 05) (prog-if 00 [Normal decode])
>> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>> 	Latency: 0, Cache Line Size: 64 bytes
>> 01:00.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca) (prog-if 00 [Normal decode])
>> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>> 	Interrupt: pin A routed to IRQ 128
>> 02:01.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ff) (prog-if ff)
>> 	!!! Unknown header type 7f
>> 	Kernel driver in use: pcieport
>>
>> 03:00.0 PCI bridge: PLX Technology, Inc. PEX 8748 48-Lane, 12-Port PCI Express Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (rev ff) (prog-if ff)
>> 	!!! Unknown header type 7f
>> 	Kernel driver in use: pcieport
>>
>> 04:11.0 PCI bridge: PLX Technology, Inc. PEX 8748 48-Lane, 12-Port PCI Express Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (rev ff) (prog-if ff)
>> 	!!! Unknown header type 7f
>> 	Kernel driver in use: pcieport
>>
>> 0e:00.0 Signal processing controller: Xilinx Corporation Device 7011 (rev ff) (prog-if ff)
>> 	!!! Unknown header type 7f
>> 	Kernel driver in use: mrf-pci
>>
>> The return code from aer_root_reset() is PCI_ERS_RESULT_RECOVERED.
>> How come that the 01:00.0 upstream port PCI_COMMAND register is
>> cleared? I guess that explains why the rest of the devices in the
>> chain down to the endpoint at 0e:00.0 are rendered useless.
>>
>> Then, as part of having fun, I made the pci_bus_error_reset() *NOT*
>> do the actual reset of the secondary by just returning 0 before the
>> call to the pci_bus_reset(). In this case no bus reset is done,
>> obviously, and MMIO access to my endpoint(s) is working just fine
>> after the error was injected into the root port; as if nothing
>> happened.
>>
>> Is it expected that in cases of seeing this type of error the
>> secondary bus would be in this kind of state? It looks to me that
>> the problem is not with my endpoints but with the PCIe switch on the
>> CPU board (01:00.0 <--> 02:0?.0).
> 
> Hmm.  Yeah, I don't see anything in the path that would restore the
> 01:00.0 config space, which seems like a problem.  Probably its
> secondary/subordinate bus registers and window registers get reset to
> 0 ("lspci -vv" would show that) so config/mem/io space below it is
> accessible.

I guess the save/restore of the switch registers would be in the core 
PCI(e) code; and not a switch vendor/part specific.

I still have interest in getting this to work. With my limited knowledge 
of the PCI code base, is there anything I could do to help? Is there a 
particular code base area where you expect this should be managed; pci.c 
or pcie/aer.c or maybe hotplug/ source? I can try and tinker with it..


Here is the 'lspci -vv' of the 01:00.0 device at the time after the reset:

01:00.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca) (prog-if 
00 [Normal decode])
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Interrupt: pin A routed to IRQ 128
         Region 0: Memory at df200000 (32-bit, non-prefetchable) 
[virtual] [size=256K]
         Bus: primary=00, secondary=00, subordinate=00, sec-latency=0
         I/O behind bridge: 0000f000-00000fff [disabled]
         Memory behind bridge: fff00000-000fffff [disabled]
         Prefetchable memory behind bridge: 
00000000fff00000-00000000000fffff [disabled]
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA- VGA- VGA16- MAbort- >Reset- 
FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
                 Address: 0000000000000000  Data: 0000
                 Masking: 00000000  Pending: 00000000
         Capabilities: [68] Express (v2) Upstream Port, MSI 00
                 DevCap: MaxPayload 1024 bytes, PhantFunc 0
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ 
SlotPowerLimit 75.000W
                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 128 bytes, MaxReadReq 128 bytes
                 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ 
AuxPwr- TransPend-
                 LnkCap: Port #0, Speed 8GT/s, Width x8, ASPM L1, Exit 
Latency L1 <4us
                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
                 LnkCtl: ASPM Disabled; Disabled- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 8GT/s (ok), Width x8 (ok)
                         TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
                          10BitTagComp- 10BitTagReq- OBFF Via message, 
ExtFmt- EETLPPrefix-
                          EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
                          FRS-
                          AtomicOpsCap: Routing+ 32bit- 64bit- 128bitCAS-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- 
LTR- OBFF Disabled,
                          AtomicOpsCtl: EgressBlck-
                 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ 
Retimer- 2Retimers- DRS-
                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- 
SpeedDis-
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete+ EqualizationPhase1+
                          EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
                          Retimer- 2Retimers- CrosslinkRes: unsupported
         Capabilities: [a4] Subsystem: PLX Technology, Inc. Device 8725
         Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
         Capabilities: [fb4 v1] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
                 AERCap: First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
         Capabilities: [138 v1] Power Budgeting <?>
         Capabilities: [10c v1] Secondary PCI Express
                 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
                 LaneErrStat: 0
         Capabilities: [148 v1] Virtual Channel
                 Caps:   LPEVC=1 RefClk=100ns PATEntryBits=8
                 Arb:    Fixed- WRR32- WRR64- WRR128-
                 Ctrl:   ArbSelect=Fixed
                 Status: InProgress-
                 VC0:    Caps:   PATOffset=03 MaxTimeSlots=1 RejSnoopTrans-
                         Arb:    Fixed- WRR32- WRR64+ WRR128- TWRR128- 
WRR256-
                         Ctrl:   Enable+ ID=0 ArbSelect=WRR64 TC/VC=ff
                         Status: NegoPending- InProgress-
                         Port Arbitration Table <?>
                 VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                         Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- 
WRR256-
                         Ctrl:   Enable- ID=1 ArbSelect=Fixed TC/VC=00
                         Status: NegoPending+ InProgress-
         Capabilities: [e00 v1] Multicast
                 McastCap: MaxGroups 64, ECRCRegen+
                 McastCtl: NumGroups 1, Enable-
                 McastBAR: IndexPos 0, BaseAddr 0000000000000000
                 McastReceiveVec:      0000000000000000
                 McastBlockAllVec:     0000000000000000
                 McastBlockUntransVec: 0000000000000000
                 McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
         Capabilities: [b00 v1] Latency Tolerance Reporting
                 Max snoop latency: 0ns
                 Max no snoop latency: 0ns
         Capabilities: [b70 v1] Vendor Specific Information: ID=0001 
Rev=0 Len=010 <?>
         Kernel driver in use: pcieport


And here is the diff of the lspci of 01:00.0 between the before and 
after the reset:

  01:00.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca) (prog-if 
00 [Normal decode])
-	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
+	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
  	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
-	Latency: 0, Cache Line Size: 64 bytes
  	Interrupt: pin A routed to IRQ 128
-	Region 0: Memory at df200000 (32-bit, non-prefetchable) [size=256K]
-	Bus: primary=01, secondary=02, subordinate=13, sec-latency=0
+	Region 0: Memory at df200000 (32-bit, non-prefetchable) [virtual] 
[size=256K]
+	Bus: primary=00, secondary=00, subordinate=00, sec-latency=0
  	I/O behind bridge: 0000f000-00000fff [disabled]
-	Memory behind bridge: df000000-df1fffff [size=2M]
-	Prefetchable memory behind bridge: 0000000090000000-00000000923fffff 
[size=36M]
+	Memory behind bridge: fff00000-000fffff [disabled]
+	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff 
[disabled]
  	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
-	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
+	BridgeCtl: Parity- SERR- NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
  		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
  	Capabilities: [40] Power Management version 3
  		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
  		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
-	Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
-		Address: 00000000fee00338  Data: 0000
-		Masking: 000000ff  Pending: 00000000
+	Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
+		Address: 0000000000000000  Data: 0000
+		Masking: 00000000  Pending: 00000000
  	Capabilities: [68] Express (v2) Upstream Port, MSI 00
  		DevCap:	MaxPayload 1024 bytes, PhantFunc 0
  			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 75.000W
  		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
  			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
-			MaxPayload 256 bytes, MaxReadReq 128 bytes
+			MaxPayload 128 bytes, MaxReadReq 128 bytes
  		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
  		LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM L1, Exit Latency L1 <4us
  			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
@@ -376,7 +375,7 @@
  			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
  			 FRS-
  			 AtomicOpsCap: Routing+ 32bit- 64bit- 128bitCAS-
-		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF 
Disabled,
+		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF 
Disabled,
  			 AtomicOpsCtl: EgressBlck-
  		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
  		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
@@ -402,7 +401,7 @@
  		LaneErrStat: 0
  	Capabilities: [148 v1] Virtual Channel
  		Caps:	LPEVC=1 RefClk=100ns PATEntryBits=8
-		Arb:	Fixed+ WRR32- WRR64- WRR128-
+		Arb:	Fixed- WRR32- WRR64- WRR128-
  		Ctrl:	ArbSelect=Fixed
  		Status:	InProgress-
  		VC0:	Caps:	PATOffset=03 MaxTimeSlots=1 RejSnoopTrans-
@@ -423,20 +422,20 @@
  		McastBlockUntransVec: 0000000000000000
  		McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 0000000000000000
  	Capabilities: [b00 v1] Latency Tolerance Reporting
-		Max snoop latency: 71680ns
-		Max no snoop latency: 71680ns
+		Max snoop latency: 0ns
+		Max no snoop latency: 0ns
  	Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
  	Kernel driver in use: pcieport


Looks like many fields have been zeroed out. Should a bare restoration 
of the previous registers values be enough or does some other magic 
(i.e. calling PCI functions/performing initialization tasks/etc) needs 
to happen to get that port back to sanity?


Thanks!
//hinko


> 
> I didn't have much confidence in our error handling to begin with, and
> it's eroding ;)
> 
> Bjorn
> 
