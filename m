Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B94F4C30BD
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 17:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiBXQBX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 11:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiBXQBV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 11:01:21 -0500
Received: from mail-mut.mcl.gg (mail-mut.mcl.gg [IPv6:2a0f:85c1:beef:2011::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63D118462D
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 08:00:38 -0800 (PST)
Message-ID: <d4dd76f4-19e4-c35a-bd46-6e014707402e@mcl.gg>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mcl.gg; s=mail;
        t=1645718431; bh=CLcwHweT7sOIsNqeBnO4OaREcw4Bv2bChFk3WtH5a+M=;
        h=Date:Subject:From:To:References:In-Reply-To;
        b=XSwUHsNRRzy1AQC6B8oQ1iPQfcdZNV2Vd/UWoW8y82niRkwuR3GLTvt2ne2HJCUTZ
         rti0QrUyN0zS32J1k0YBFs6IsAoozF463lj+x8I7MAWEWelpuIz86FY8B/aK9N2jcY
         obbAMuio9SG30ix5UxbVNRMNK65/RRPlPKgSd4xJv/r8qC7VyEhSsbWCzGfIcSTQ2E
         rSWCI9N7ODcfGJJmWRcORmusvo1klzN7ha1kKakrryJlm3KoBWNycshtKZ4NWH31eu
         JDdIQ7uirQcRZOQztFhzZ8rHU+MMSOIdCCffHE/vkL+Cn4GSt58OxrX7Iu54dl0iSZ
         T/gvgfEz/rNSQ==
Date:   Thu, 24 Feb 2022 17:00:30 +0100
MIME-Version: 1.0
Subject: Re: Kernel 5.16.3 and above fails to detect PCIe devices on Turris
 Omnia (Armada 385 / mvebu)
From:   Marcel Menzel <mail@mcl.gg>
To:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
References: <aa149fc8-c108-5f26-7ae6-5ccc845befd3@mcl.gg>
 <a3b5c605-e8ac-1c6d-bbd6-c6fa587535bc@mcl.gg>
In-Reply-To: <a3b5c605-e8ac-1c6d-bbd6-c6fa587535bc@mcl.gg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+linux-pci

Am 24.02.2022 um 14:52 schrieb Marcel Menzel:
> Am 24.02.2022 um 14:09 schrieb Marcel Menzel:
>> Hello,
>>
>> When upgrading from kernel 5.16.2 to a newer version (tried 5.16.3 
>> and 5.16.10 with unchanged .config), the Kernel fails to detect both 
>> my installed mPCIe WiFi cards in my Turris Omnia (newer version, 
>> silver case, GPIO pins installed again).
>> I have two Mediatek MT7915 based cards installed. I also tried with 
>> one Atheros at9k and one ath10k based card, yielding the same result. 
>> On a Kernel version newer than 5.16.2, all cards aren't getting 
>> recognized correctly.
>>
>> Before 5.16.3 I also had to disable PCIe ASPM via boot aragument, 
>> otherwise the WiFi drivers would complain about weird device 
>> behaviors and failing to initialize them, but re-enabling it does not 
>> yield any different results.
>> I am running Arch Linux ARM, but having compiled those kernels for 
>> myself in order to enable the mt76 driver.
>>
>> Looking at the boot log, it seems to be related to failing setting up 
>> PCI BAR space:
>>
>> kernel: mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
>> kernel: pci_bus 0000:00: root bus resource [bus 00-ff]
>> kernel: pci_bus 0000:00: root bus resource [mem 
>> 0xf1080000-0xf1081fff] (bus address [0x00080000-0x00081fff])
>> kernel: pci_bus 0000:00: root bus resource [mem 
>> 0xf1040000-0xf1041fff] (bus address [0x00040000-0x00041fff])
>> kernel: pci_bus 0000:00: root bus resource [mem 
>> 0xf1044000-0xf1045fff] (bus address [0x00044000-0x00045fff])
>> kernel: pci_bus 0000:00: root bus resource [mem 
>> 0xf1048000-0xf1049fff] (bus address [0x00048000-0x00049fff])
>> kernel: pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
>> kernel: pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
>> kernel: pci 0000:00:01.0: [11ab:6820] type 01 class 0x060400
>> kernel: pci 0000:00:02.0: [11ab:6820] type 01 class 0x060400
>> kernel: pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400
>> kernel: PCI: bus0: Fast back to back transfers disabled
>> kernel: pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), 
>> reconfiguring
>> kernel: pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]), 
>> reconfiguring
>> kernel: pci 0000:00:03.0: bridge configuration invalid ([bus 01-00]), 
>> reconfiguring
>> kernel: PCI: bus1: Fast back to back transfers enabled
>> kernel: pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
>> kernel: pci 0000:02:00.0: [11ab:6820] type 00 class 0x058000
>> kernel: pci 0000:02:00.0: reg 0x10: [mem 0xf1000000-0xf10fffff]
>> kernel: pci 0000:02:00.0: reg 0x18: [mem 0x00000000-0x7fffffff]
>> kernel: pci 0000:02:00.0: supports D1 D2
>> kernel: PCI: bus2: Fast back to back transfers disabled
>> kernel: pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
>> kernel: pci 0000:03:00.0: [11ab:6820] type 00 class 0x058000
>> kernel: pci 0000:03:00.0: reg 0x10: [mem 0xf1000000-0xf10fffff]
>> kernel: pci 0000:03:00.0: reg 0x18: [mem 0x00000000-0x7fffffff]
>> kernel: pci 0000:03:00.0: supports D1 D2
>> kernel: PCI: bus3: Fast back to back transfers disabled
>> kernel: pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
>> kernel: pci 0000:00:02.0: BAR 8: no space for [mem size 0xc0000000]
>> kernel: pci 0000:00:02.0: BAR 8: failed to assign [mem size 0xc0000000]
>> kernel: pci 0000:00:03.0: BAR 8: no space for [mem size 0xc0000000]
>> kernel: pci 0000:00:03.0: BAR 8: failed to assign [mem size 0xc0000000]
>> kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
>> kernel: pci 0000:02:00.0: BAR 2: no space for [mem size 0x80000000]
>> kernel: pci 0000:02:00.0: BAR 2: failed to assign [mem size 0x80000000]
>> kernel: pci 0000:02:00.0: BAR 0: no space for [mem size 0x00100000]
>> kernel: pci 0000:02:00.0: BAR 0: failed to assign [mem size 0x00100000]
>> kernel: pci 0000:00:02.0: PCI bridge to [bus 02]
>> kernel: pci 0000:03:00.0: BAR 2: no space for [mem size 0x80000000]
>> kernel: pci 0000:03:00.0: BAR 2: failed to assign [mem size 0x80000000]
>> kernel: pci 0000:03:00.0: BAR 0: no space for [mem size 0x00100000]
>> kernel: pci 0000:03:00.0: BAR 0: failed to assign [mem size 0x00100000]
>> kernel: pci 0000:00:03.0: PCI bridge to [bus 03]
>>
>> lspci -vvv reports:
>>
>> 00:01.0 PCI bridge: Marvell Technology Group Ltd. 88F6820 [Armada 
>> 385] ARM SoC (rev 04) (prog-if 00 [Normal decode])
>>     Device tree node: /sys/firmware/devicetree/base/soc/pcie/pcie@1,0
>>     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
>> ParErr+ Stepping- SERR+ FastB2B- DisINTx-
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>>     I/O behind bridge: 0000f000-00000fff [disabled]
>>     Memory behind bridge: fff00000-000fffff [disabled]
>>     Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
>>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- <SERR- <PERR-
>>     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>     Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
>>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>>             ExtTag- RBE+
>>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
>> TransPend-
>>         LnkCap:    Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, Exit 
>> Latency L0s <256ns, L1 unlimited
>>             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
>>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
>>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>         LnkSta:    Speed 2.5GT/s (downgraded), Width x4 (ok)
>>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>>         RootCap: CRSVisible-
>>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
>> CRSVisible-
>>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
>> NROPrPrP- LTR-
>>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
>> EETLPPrefix-
>>              EmergencyPowerReduction Not Supported, 
>> EmergencyPowerReductionInit-
>>              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- 
>> ARIFwd-
>>              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 
>> OBFF Disabled, ARIFwd-
>>              AtomicOpsCtl: ReqEn- EgressBlck-
>>         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>>              Transmit Margin: Normal Operating Range, 
>> EnterModifiedCompliance- ComplianceSOS-
>>              Compliance De-emphasis: -6dB
>>         LnkSta2: Current De-emphasis Level: -6dB, 
>> EqualizationComplete- EqualizationPhase1-
>>              EqualizationPhase2- EqualizationPhase3- 
>> LinkEqualizationRequest-
>>              Retimer- 2Retimers- CrosslinkRes: unsupported
>>
>> 00:02.0 PCI bridge: Marvell Technology Group Ltd. 88F6820 [Armada 
>> 385] ARM SoC (rev 04) (prog-if 00 [Normal decode])
>>     Device tree node: /sys/firmware/devicetree/base/soc/pcie/pcie@2,0
>>     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
>> ParErr+ Stepping- SERR+ FastB2B- DisINTx-
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>>     I/O behind bridge: 0000f000-00000fff [disabled]
>>     Memory behind bridge: fff00000-000fffff [disabled]
>>     Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
>>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- <SERR- <PERR-
>>     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>     Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
>>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>>             ExtTag- RBE+
>>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
>> TransPend-
>>         LnkCap:    Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
>> Latency L0s <256ns, L1 unlimited
>>             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
>>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>         LnkSta:    Speed 5GT/s (ok), Width x1 (ok)
>>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>>         RootCap: CRSVisible-
>>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
>> CRSVisible-
>>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
>> NROPrPrP- LTR-
>>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
>> EETLPPrefix-
>>              EmergencyPowerReduction Not Supported, 
>> EmergencyPowerReductionInit-
>>              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- 
>> ARIFwd-
>>              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 
>> OBFF Disabled, ARIFwd-
>>              AtomicOpsCtl: ReqEn- EgressBlck-
>>         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>>              Transmit Margin: Normal Operating Range, 
>> EnterModifiedCompliance- ComplianceSOS-
>>              Compliance De-emphasis: -6dB
>>         LnkSta2: Current De-emphasis Level: -6dB, 
>> EqualizationComplete- EqualizationPhase1-
>>              EqualizationPhase2- EqualizationPhase3- 
>> LinkEqualizationRequest-
>>              Retimer- 2Retimers- CrosslinkRes: unsupported
>>
>> 00:03.0 PCI bridge: Marvell Technology Group Ltd. 88F6820 [Armada 
>> 385] ARM SoC (rev 04) (prog-if 00 [Normal decode])
>>     Device tree node: /sys/firmware/devicetree/base/soc/pcie/pcie@3,0
>>     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
>> ParErr+ Stepping- SERR+ FastB2B- DisINTx-
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
>>     I/O behind bridge: 0000f000-00000fff [disabled]
>>     Memory behind bridge: fff00000-000fffff [disabled]
>>     Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
>>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- <SERR- <PERR-
>>     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>     Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
>>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>>             ExtTag- RBE+
>>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
>> TransPend-
>>         LnkCap:    Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
>> Latency L0s <256ns, L1 unlimited
>>             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
>>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>         LnkSta:    Speed 5GT/s (ok), Width x1 (ok)
>>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>>         RootCap: CRSVisible-
>>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
>> CRSVisible-
>>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
>> NROPrPrP- LTR-
>>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
>> EETLPPrefix-
>>              EmergencyPowerReduction Not Supported, 
>> EmergencyPowerReductionInit-
>>              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- 
>> ARIFwd-
>>              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 
>> OBFF Disabled, ARIFwd-
>>              AtomicOpsCtl: ReqEn- EgressBlck-
>>         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>>              Transmit Margin: Normal Operating Range, 
>> EnterModifiedCompliance- ComplianceSOS-
>>              Compliance De-emphasis: -6dB
>>         LnkSta2: Current De-emphasis Level: -6dB, 
>> EqualizationComplete- EqualizationPhase1-
>>              EqualizationPhase2- EqualizationPhase3- 
>> LinkEqualizationRequest-
>>              Retimer- 2Retimers- CrosslinkRes: unsupported
>>
>> 02:00.0 Memory controller: Marvell Technology Group Ltd. 88F6820 
>> [Armada 385] ARM SoC (rev 04)
>>     Subsystem: Marvell Technology Group Ltd. Device 11ab
>>     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
>> ParErr+ Stepping- SERR+ FastB2B- DisINTx-
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Interrupt: pin A routed to IRQ 0
>>     Region 0: Memory at <ignored> (32-bit, non-prefetchable) [disabled]
>>     Capabilities: [40] Power Management version 3
>>         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>     Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>>         Address: 0000000000000000  Data: 0000
>>     Capabilities: [60] Express (v2) Root Port (Slot-), MSI 00
>>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>>             ExtTag- RBE+
>>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
>> TransPend-
>>         LnkCap:    Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
>> Latency L0s <256ns, L1 unlimited
>>             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
>>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>         LnkSta:    Speed 5GT/s (ok), Width x1 (ok)
>>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>>         RootCap: CRSVisible-
>>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
>> CRSVisible-
>>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
>> NROPrPrP- LTR-
>>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
>> EETLPPrefix-
>>              EmergencyPowerReduction Not Supported, 
>> EmergencyPowerReductionInit-
>>              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- 
>> ARIFwd-
>>              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 
>> OBFF Disabled, ARIFwd-
>>              AtomicOpsCtl: ReqEn- EgressBlck-
>>         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>>              Transmit Margin: Normal Operating Range, 
>> EnterModifiedCompliance- ComplianceSOS-
>>              Compliance De-emphasis: -6dB
>>         LnkSta2: Current De-emphasis Level: -6dB, 
>> EqualizationComplete- EqualizationPhase1-
>>              EqualizationPhase2- EqualizationPhase3- 
>> LinkEqualizationRequest-
>>              Retimer- 2Retimers- CrosslinkRes: unsupported
>>     Capabilities: [100 v1] Advanced Error Reporting
>>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>         UESvrt:    DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
>> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
>> AdvNonFatalErr-
>>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
>> AdvNonFatalErr+
>>         AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn- 
>> ECRCChkCap- ECRCChkEn-
>>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>>         HeaderLog: 4a000001 00000004 00000000 c3141579
>>         RootCmd: CERptEn- NFERptEn- FERptEn-
>>         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>>              FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
>>         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
>>
>> 03:00.0 Memory controller: Marvell Technology Group Ltd. 88F6820 
>> [Armada 385] ARM SoC (rev 04)
>>     Subsystem: Marvell Technology Group Ltd. Device 11ab
>>     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
>> ParErr+ Stepping- SERR+ FastB2B- DisINTx-
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Interrupt: pin A routed to IRQ 0
>>     Region 0: Memory at <ignored> (32-bit, non-prefetchable) [disabled]
>>     Capabilities: [40] Power Management version 3
>>         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>     Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>>         Address: 0000000000000000  Data: 0000
>>     Capabilities: [60] Express (v2) Root Port (Slot-), MSI 00
>>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>>             ExtTag- RBE+
>>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
>> TransPend-
>>         LnkCap:    Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
>> Latency L0s <256ns, L1 unlimited
>>             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
>>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>         LnkSta:    Speed 5GT/s (ok), Width x1 (ok)
>>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>>         RootCap: CRSVisible-
>>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
>> CRSVisible-
>>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
>> NROPrPrP- LTR-
>>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
>> EETLPPrefix-
>>              EmergencyPowerReduction Not Supported, 
>> EmergencyPowerReductionInit-
>>              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- 
>> ARIFwd-
>>              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 
>> OBFF Disabled, ARIFwd-
>>              AtomicOpsCtl: ReqEn- EgressBlck-
>>         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>>              Transmit Margin: Normal Operating Range, 
>> EnterModifiedCompliance- ComplianceSOS-
>>              Compliance De-emphasis: -6dB
>>         LnkSta2: Current De-emphasis Level: -6dB, 
>> EqualizationComplete- EqualizationPhase1-
>>              EqualizationPhase2- EqualizationPhase3- 
>> LinkEqualizationRequest-
>>              Retimer- 2Retimers- CrosslinkRes: unsupported
>>     Capabilities: [100 v1] Advanced Error Reporting
>>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>         UESvrt:    DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
>> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
>> AdvNonFatalErr-
>>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
>> AdvNonFatalErr+
>>         AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn- 
>> ECRCChkCap- ECRCChkEn-
>>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>>         HeaderLog: 4a000001 00000004 01000100 c3141579
>>         RootCmd: CERptEn- NFERptEn- FERptEn-
>>         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>>              FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
>>         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
>>
>> Going back to 5.16.2 solves it for me. The boot output:
>>
>> kernel: mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
>> kernel: pci_bus 0000:00: root bus resource [bus 00-ff]
>> kernel: pci_bus 0000:00: root bus resource [mem 
>> 0xf1080000-0xf1081fff] (bus address [0x00080000-0x00081fff])
>> kernel: pci_bus 0000:00: root bus resource [mem 
>> 0xf1040000-0xf1041fff] (bus address [0x00040000-0x00041fff])
>> kernel: pci_bus 0000:00: root bus resource [mem 
>> 0xf1044000-0xf1045fff] (bus address [0x00044000-0x00045fff])
>> kernel: pci_bus 0000:00: root bus resource [mem 
>> 0xf1048000-0xf1049fff] (bus address [0x00048000-0x00049fff])
>> kernel: pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
>> kernel: pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
>> kernel: pci 0000:00:01.0: [11ab:6820] type 01 class 0x060400
>> kernel: pci 0000:00:01.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
>> kernel: pci 0000:00:02.0: [11ab:6820] type 01 class 0x060400
>> kernel: pci 0000:00:02.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
>> kernel: pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400
>> kernel: pci 0000:00:03.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
>> kernel: PCI: bus0: Fast back to back transfers disabled
>> kernel: pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), 
>> reconfiguring
>> kernel: pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]), 
>> reconfiguring
>> kernel: pci 0000:00:03.0: bridge configuration invalid ([bus 00-00]), 
>> reconfiguring
>> kernel: PCI: bus1: Fast back to back transfers enabled
>> kernel: pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
>> kernel: pci 0000:02:00.0: [14c3:7915] type 00 class 0x000280
>> kernel: pci 0000:02:00.0: reg 0x10: [mem 0x00000000-0x000fffff 64bit 
>> pref]
>> kernel: pci 0000:02:00.0: reg 0x18: [mem 0x00000000-0x00003fff 64bit 
>> pref]
>> kernel: pci 0000:02:00.0: reg 0x20: [mem 0x00000000-0x00000fff 64bit 
>> pref]
>> kernel: pci 0000:02:00.0: supports D1 D2
>> kernel: pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>> kernel: PCI: bus2: Fast back to back transfers disabled
>> kernel: pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
>> kernel: pci 0000:03:00.0: [14c3:7915] type 00 class 0x000280
>> kernel: pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x000fffff 64bit 
>> pref]
>> kernel: pci 0000:03:00.0: reg 0x18: [mem 0x00000000-0x00003fff 64bit 
>> pref]
>> kernel: pci 0000:03:00.0: reg 0x20: [mem 0x00000000-0x00000fff 64bit 
>> pref]
>> kernel: pci 0000:03:00.0: supports D1 D2
>> kernel: pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>> kernel: PCI: bus3: Fast back to back transfers disabled
>> kernel: pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
>> kernel: pci 0000:00:02.0: BAR 8: assigned [mem 0xe0000000-0xe01fffff]
>> kernel: pci 0000:00:03.0: BAR 8: assigned [mem 0xe0200000-0xe03fffff]
>> kernel: pci 0000:00:01.0: BAR 6: assigned [mem 0xe0400000-0xe04007ff 
>> pref]
>> kernel: pci 0000:00:02.0: BAR 6: assigned [mem 0xe0500000-0xe05007ff 
>> pref]
>> kernel: pci 0000:00:03.0: BAR 6: assigned [mem 0xe0600000-0xe06007ff 
>> pref]
>> kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
>> kernel: pci 0000:02:00.0: BAR 0: assigned [mem 0xe0000000-0xe00fffff 
>> 64bit pref]
>> kernel: pci 0000:02:00.0: BAR 2: assigned [mem 0xe0100000-0xe0103fff 
>> 64bit pref]
>> kernel: pci 0000:02:00.0: BAR 4: assigned [mem 0xe0104000-0xe0104fff 
>> 64bit pref]
>> kernel: pci 0000:00:02.0: PCI bridge to [bus 02]
>> kernel: pci 0000:00:02.0:   bridge window [mem 0xe0000000-0xe01fffff]
>> kernel: pci 0000:03:00.0: BAR 0: assigned [mem 0xe0200000-0xe02fffff 
>> 64bit pref]
>> kernel: pci 0000:03:00.0: BAR 2: assigned [mem 0xe0300000-0xe0303fff 
>> 64bit pref]
>> kernel: pci 0000:03:00.0: BAR 4: assigned [mem 0xe0304000-0xe0304fff 
>> 64bit pref]
>> kernel: pci 0000:00:03.0: PCI bridge to [bus 03]
>> kernel: pci 0000:00:03.0:   bridge window [mem 0xe0200000-0xe03fffff]
>> kernel: pcieport 0000:00:02.0: enabling device (0140 -> 0142)
>> kernel: pcieport 0000:00:03.0: enabling device (0140 -> 0142)
>> [...]
>> kernel: mt7915e 0000:02:00.0: enabling device (0140 -> 0142)
>> kernel: mt7915e 0000:02:00.0: HW/SW Version: 0x8a108a10, Build Time: 
>> 20211222184017a
>> kernel: mt7915e 0000:02:00.0: WM Firmware Version: ____000000, Build 
>> Time: 20211222184052
>> kernel: mt7915e 0000:02:00.0: WA Firmware Version: DEV_000000, Build 
>> Time: 20211222184111
>> [...]
>> kernel: mt7915e 0000:03:00.0: enabling device (0140 -> 0142)
>> kernel: mt7915e 0000:03:00.0: HW/SW Version: 0x8a108a10, Build Time: 
>> 20211222184017a
>> kernel: mt7915e 0000:03:00.0: WM Firmware Version: ____000000, Build 
>> Time: 20211222184052
>> kernel: mt7915e 0000:03:00.0: WA Firmware Version: DEV_000000, Build 
>> Time: 20211222184111
>>
>> lspci -vvv:
>>
>> 00:01.0 PCI bridge: Marvell Technology Group Ltd. 88F6820 [Armada 
>> 385] ARM SoC (rev 04) (prog-if 00 [Normal decode])
>>     Device tree node: /sys/firmware/devicetree/base/soc/pcie/pcie@1,0
>>     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
>> ParErr+ Stepping- SERR+ FastB2B- DisINTx-
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>>     I/O behind bridge: 0000f000-00000fff [disabled]
>>     Memory behind bridge: fff00000-000fffff [disabled]
>>     Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
>>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- <SERR- <PERR-
>>     Expansion ROM at e0400000 [virtual] [disabled] [size=2K]
>>     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort+ >Reset- FastB2B-
>>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>>             ExtTag- RBE+
>>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
>> TransPend-
>>         LnkCap:    Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, Exit 
>> Latency L0s <256ns, L1 unlimited
>>             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
>>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
>>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>         LnkSta:    Speed 2.5GT/s (downgraded), Width x4 (ok)
>>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
>> Surprise-
>>             Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
>>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
>> HPIrq- LinkChg-
>>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
>> Interlock-
>>             Changed: MRL- PresDet- LinkState-
>>         RootCap: CRSVisible-
>>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
>> CRSVisible-
>>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
>> NROPrPrP- LTR-
>>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
>> EETLPPrefix-
>>              EmergencyPowerReduction Not Supported, 
>> EmergencyPowerReductionInit-
>>              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- 
>> ARIFwd-
>>              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 
>> OBFF Disabled, ARIFwd-
>>              AtomicOpsCtl: ReqEn- EgressBlck-
>>         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>>              Transmit Margin: Normal Operating Range, 
>> EnterModifiedCompliance- ComplianceSOS-
>>              Compliance De-emphasis: -6dB
>>         LnkSta2: Current De-emphasis Level: -6dB, 
>> EqualizationComplete- EqualizationPhase1-
>>              EqualizationPhase2- EqualizationPhase3- 
>> LinkEqualizationRequest-
>>              Retimer- 2Retimers- CrosslinkRes: unsupported
>>
>> 00:02.0 PCI bridge: Marvell Technology Group Ltd. 88F6820 [Armada 
>> 385] ARM SoC (rev 04) (prog-if 00 [Normal decode])
>>     Device tree node: /sys/firmware/devicetree/base/soc/pcie/pcie@2,0
>>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr+ Stepping- SERR+ FastB2B- DisINTx-
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 0, Cache Line Size: 64 bytes
>>     Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>>     I/O behind bridge: 0000f000-00000fff [disabled]
>>     Memory behind bridge: e0000000-e01fffff [size=2M]
>>     Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
>>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- <SERR- <PERR-
>>     Expansion ROM at e0500000 [virtual] [disabled] [size=2K]
>>     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort+ >Reset- FastB2B-
>>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>>             ExtTag- RBE+
>>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
>> TransPend-
>>         LnkCap:    Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
>> Latency L0s <256ns, L1 unlimited
>>             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
>>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>         LnkSta:    Speed 5GT/s (ok), Width x1 (ok)
>>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
>> Surprise-
>>             Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
>>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
>> HPIrq- LinkChg-
>>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
>> Interlock-
>>             Changed: MRL- PresDet- LinkState-
>>         RootCap: CRSVisible-
>>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
>> CRSVisible-
>>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
>> NROPrPrP- LTR-
>>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
>> EETLPPrefix-
>>              EmergencyPowerReduction Not Supported, 
>> EmergencyPowerReductionInit-
>>              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- 
>> ARIFwd-
>>              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 
>> OBFF Disabled, ARIFwd-
>>              AtomicOpsCtl: ReqEn- EgressBlck-
>>         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>>              Transmit Margin: Normal Operating Range, 
>> EnterModifiedCompliance- ComplianceSOS-
>>              Compliance De-emphasis: -6dB
>>         LnkSta2: Current De-emphasis Level: -6dB, 
>> EqualizationComplete- EqualizationPhase1-
>>              EqualizationPhase2- EqualizationPhase3- 
>> LinkEqualizationRequest-
>>              Retimer- 2Retimers- CrosslinkRes: unsupported
>>
>> 00:03.0 PCI bridge: Marvell Technology Group Ltd. 88F6820 [Armada 
>> 385] ARM SoC (rev 04) (prog-if 00 [Normal decode])
>>     Device tree node: /sys/firmware/devicetree/base/soc/pcie/pcie@3,0
>>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr+ Stepping- SERR+ FastB2B- DisINTx-
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 0, Cache Line Size: 64 bytes
>>     Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
>>     I/O behind bridge: 0000f000-00000fff [disabled]
>>     Memory behind bridge: e0200000-e03fffff [size=2M]
>>     Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
>>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- <SERR- <PERR-
>>     Expansion ROM at e0600000 [virtual] [disabled] [size=2K]
>>     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort+ >Reset- FastB2B-
>>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>>         DevCap:    MaxPayload 128 bytes, PhantFunc 0
>>             ExtTag- RBE+
>>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
>> TransPend-
>>         LnkCap:    Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
>> Latency L0s <256ns, L1 unlimited
>>             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
>>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>         LnkSta:    Speed 5GT/s (ok), Width x1 (ok)
>>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
>> Surprise-
>>             Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
>>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
>> HPIrq- LinkChg-
>>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
>> Interlock-
>>             Changed: MRL- PresDet- LinkState-
>>         RootCap: CRSVisible-
>>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
>> CRSVisible-
>>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
>> NROPrPrP- LTR-
>>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
>> EETLPPrefix-
>>              EmergencyPowerReduction Not Supported, 
>> EmergencyPowerReductionInit-
>>              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- 
>> ARIFwd-
>>              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 
>> OBFF Disabled, ARIFwd-
>>              AtomicOpsCtl: ReqEn- EgressBlck-
>>         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>>              Transmit Margin: Normal Operating Range, 
>> EnterModifiedCompliance- ComplianceSOS-
>>              Compliance De-emphasis: -6dB
>>         LnkSta2: Current De-emphasis Level: -6dB, 
>> EqualizationComplete- EqualizationPhase1-
>>              EqualizationPhase2- EqualizationPhase3- 
>> LinkEqualizationRequest-
>>              Retimer- 2Retimers- CrosslinkRes: unsupported
>>
>> 02:00.0 Unclassified device [0002]: MEDIATEK Corp. MT7915E 802.11ax 
>> PCI Express Wireless Network Adapter (prog-if 80)
>>     Subsystem: MEDIATEK Corp. MT7915E 802.11ax PCI Express Wireless 
>> Network Adapter
>>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr+ Stepping- SERR+ FastB2B- DisINTx+
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 0, Cache Line Size: 64 bytes
>>     Interrupt: pin A routed to IRQ 88
>>     Region 0: Memory at e0000000 (64-bit, prefetchable) [size=1M]
>>     Region 2: Memory at e0100000 (64-bit, prefetchable) [size=16K]
>>     Region 4: Memory at e0104000 (64-bit, prefetchable) [size=4K]
>>     Capabilities: [80] Express (v2) Endpoint, MSI 00
>>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
>> <1us, L1 <4us
>>             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
>> SlotPowerLimit 0.000W
>>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>>             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
>> TransPend-
>>         LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
>> Latency L0s <2us, L1 <8us
>>             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
>>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>         LnkSta:    Speed 5GT/s (ok), Width x1 (ok)
>>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>>         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ 
>> NROPrPrP- LTR+
>>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ 
>> EETLPPrefix-
>>              EmergencyPowerReduction Not Supported, 
>> EmergencyPowerReductionInit-
>>              FRS- TPHComp- ExtTPHComp-
>>              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 
>> OBFF Disabled,
>>              AtomicOpsCtl: ReqEn-
>>         LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- 
>> Retimer- 2Retimers- DRS-
>>         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>>              Transmit Margin: Normal Operating Range, 
>> EnterModifiedCompliance- ComplianceSOS-
>>              Compliance De-emphasis: -6dB
>>         LnkSta2: Current De-emphasis Level: -3.5dB, 
>> EqualizationComplete- EqualizationPhase1-
>>              EqualizationPhase2- EqualizationPhase3- 
>> LinkEqualizationRequest-
>>              Retimer- 2Retimers- CrosslinkRes: unsupported
>>     Capabilities: [e0] MSI: Enable+ Count=1/32 Maskable+ 64bit+
>>         Address: 00000000f1020a04  Data: 0f10
>>         Masking: fffffffe  Pending: 00000000
>>     Capabilities: [f8] Power Management version 3
>>         Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
>> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>>     Capabilities: [100 v1] Vendor Specific Information: ID=1556 Rev=1 
>> Len=008 <?>
>>     Capabilities: [108 v1] Latency Tolerance Reporting
>>         Max snoop latency: 0ns
>>         Max no snoop latency: 0ns
>>     Capabilities: [110 v1] L1 PM Substates
>>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
>> L1_PM_Substates+
>>               PortCommonModeRestoreTime=3us PortTPowerOnTime=28us
>>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>>                T_CommonMode=0us LTR1.2_Threshold=0ns
>>         L1SubCtl2: T_PwrOn=10us
>>     Capabilities: [200 v2] Advanced Error Reporting
>>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
>> RxOF- MalfTLP+ ECRC- UnsupReq- ACSViol-
>>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
>> AdvNonFatalErr-
>>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
>> AdvNonFatalErr+
>>         AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn- 
>> ECRCChkCap- ECRCChkEn-
>>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>>         HeaderLog: 00000000 00000000 00000000 00000000
>>     Kernel driver in use: mt7915e
>>     Kernel modules: mt7915e
>>
>> 03:00.0 Unclassified device [0002]: MEDIATEK Corp. MT7915E 802.11ax 
>> PCI Express Wireless Network Adapter (prog-if 80)
>>     Subsystem: MEDIATEK Corp. MT7915E 802.11ax PCI Express Wireless 
>> Network Adapter
>>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr+ Stepping- SERR+ FastB2B- DisINTx+
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Latency: 0, Cache Line Size: 64 bytes
>>     Interrupt: pin A routed to IRQ 90
>>     Region 0: Memory at e0200000 (64-bit, prefetchable) [size=1M]
>>     Region 2: Memory at e0300000 (64-bit, prefetchable) [size=16K]
>>     Region 4: Memory at e0304000 (64-bit, prefetchable) [size=4K]
>>     Capabilities: [80] Express (v2) Endpoint, MSI 00
>>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
>> <1us, L1 <4us
>>             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
>> SlotPowerLimit 0.000W
>>         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
>>             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>>         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
>> TransPend-
>>         LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
>> Latency L0s <2us, L1 <8us
>>             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>>         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
>>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>         LnkSta:    Speed 5GT/s (ok), Width x1 (ok)
>>             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>>         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ 
>> NROPrPrP- LTR+
>>              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ 
>> EETLPPrefix-
>>              EmergencyPowerReduction Not Supported, 
>> EmergencyPowerReductionInit-
>>              FRS- TPHComp- ExtTPHComp-
>>              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 
>> OBFF Disabled,
>>              AtomicOpsCtl: ReqEn-
>>         LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- 
>> Retimer- 2Retimers- DRS-
>>         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>>              Transmit Margin: Normal Operating Range, 
>> EnterModifiedCompliance- ComplianceSOS-
>>              Compliance De-emphasis: -6dB
>>         LnkSta2: Current De-emphasis Level: -3.5dB, 
>> EqualizationComplete- EqualizationPhase1-
>>              EqualizationPhase2- EqualizationPhase3- 
>> LinkEqualizationRequest-
>>              Retimer- 2Retimers- CrosslinkRes: unsupported
>>     Capabilities: [e0] MSI: Enable+ Count=1/32 Maskable+ 64bit+
>>         Address: 00000000f1020a04  Data: 0f11
>>         Masking: fffffffe  Pending: 00000000
>>     Capabilities: [f8] Power Management version 3
>>         Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
>> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>>     Capabilities: [100 v1] Vendor Specific Information: ID=1556 Rev=1 
>> Len=008 <?>
>>     Capabilities: [108 v1] Latency Tolerance Reporting
>>         Max snoop latency: 0ns
>>         Max no snoop latency: 0ns
>>     Capabilities: [110 v1] L1 PM Substates
>>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
>> L1_PM_Substates+
>>               PortCommonModeRestoreTime=3us PortTPowerOnTime=28us
>>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>>                T_CommonMode=0us LTR1.2_Threshold=0ns
>>         L1SubCtl2: T_PwrOn=10us
>>     Capabilities: [200 v2] Advanced Error Reporting
>>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
>> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
>> RxOF- MalfTLP+ ECRC- UnsupReq- ACSViol-
>>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
>> AdvNonFatalErr-
>>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
>> AdvNonFatalErr+
>>         AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn- 
>> ECRCChkCap- ECRCChkEn-
>>             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>>         HeaderLog: 00000000 00000000 00000000 00000000
>>     Kernel driver in use: mt7915e
>>     Kernel modules: mt7915e
>>
>> As I am relatively new im reporting kernel bugs, please tell me if 
>> you need additional information.
>
> Additional information that could be of interest:
>
> .config for all versions:
> https://github.com/archlinuxarm/PKGBUILDs/blob/61950ecea2de28aa48d8348aa049ddb4898b9f1d/core/linux-armv7/config 
>
> with changed "CONFIG_MT7615E=m"
>
> Kernel 5.16.2:
>
> # cat /proc/iomem
> 00000000-7fffffff : System RAM
>   00208000-018fffff : Kernel code
>   01a00000-01c6b7e4 : Kernel data
> e0000000-e7ffffff : PCI MEM
>   e0000000-e01fffff : PCI Bus 0000:02
>     e0000000-e00fffff : 0000:02:00.0
>       e0000000-e00fffff : 0000:02:00.0
>     e0100000-e0103fff : 0000:02:00.0
>     e0104000-e0104fff : 0000:02:00.0
>   e0200000-e03fffff : PCI Bus 0000:03
>     e0200000-e02fffff : 0000:03:00.0
>       e0200000-e02fffff : 0000:03:00.0
>     e0300000-e0303fff : 0000:03:00.0
>     e0304000-e0304fff : 0000:03:00.0
>   e0400000-e04007ff : 0000:00:01.0
>   e0500000-e05007ff : 0000:00:02.0
>   e0600000-e06007ff : 0000:00:03.0
> f1010600-f101064f : f1010600.spi spi@10600
> f1011000-f101101f : f1011000.i2c i2c@11000
> f1012000-f101201f : serial
> f1012100-f101211f : serial
> f1018000-f101801f : f1018000.pinctrl pinctrl@18000
> f1018100-f101813f : f1018100.gpio gpio
> f1018140-f101817f : f1018140.gpio gpio
> f10181c0-f10181c7 : f1018100.gpio pwm
> f10181c8-f10181cf : f1018140.gpio pwm
> f1018300-f10183ff : f1018300.phy comphy
> f1018454-f1018457 : f10d8000.sdhci conf-sdio3
> f1018460-f1018463 : f1018300.phy conf
> f10184a0-f10184ab : f10a3800.rtc rtc-soc
> f1020704-f1020707 : f1020300.watchdog watchdog@20300
> f1020800-f102080f : cpurst@20800
> f1020a00-f1020ccf : interrupt-controller@20a00
> f1021070-f10210c7 : interrupt-controller@20a00
> f1022000-f1022fff : pmsu@22000
> f1030000-f1033fff : f1030000.ethernet ethernet@30000
> f1034000-f1037fff : f1034000.ethernet ethernet@34000
> f1040000-f1041fff : pcie
>   f1040000-f1041fff : soc:pcie pcie@2,0
> f1044000-f1045fff : pcie
>   f1044000-f1045fff : soc:pcie pcie@3,0
> f1048000-f1049fff : pcie
> f1058000-f10584ff : f1058000.usb usb@58000
> f1070000-f1073fff : f1070000.ethernet ethernet@70000
> f1080000-f1081fff : pcie
>   f1080000-f1081fff : soc:pcie pcie@1,0
> f1090000-f109ffff : f1090000.crypto regs
> f10a3800-f10a381f : f10a3800.rtc rtc
> f10a8000-f10a9fff : f10a8000.sata sata@a8000
> f10c8000-f10c80ab : f10c8000.bm bm@c8000
> f10d8000-f10d8fff : f10d8000.sdhci sdhci
> f10e4078-f10e407b : f10e4078.thermal thermal@e8078
> f10f0000-f10f3fff : f10f0000.usb3 usb3@f0000
> f10f8000-f10fbfff : f10f8000.usb3 usb3@f8000
> f1100000-f11007ff : f1100000.sa-sram0 sa-sram0
> f1110000-f11107ff : f1110000.sa-sram1 sa-sram1
> f1200000-f12fffff : f1200000.bm-bppi bm-bppi
> # cat /proc/modules
> esp4 20480 8 - Live 0xbf3ad000
> poly1305_generic 16384 0 - Live 0xbf3a8000
> libpoly1305 16384 1 poly1305_generic, Live 0xbf3a3000
> poly1305_arm 24576 16 - Live 0xbf39c000
> chacha_generic 16384 0 - Live 0xbf397000
> libchacha 16384 1 chacha_generic, Live 0xbf392000
> chacha_neon 32768 8 - Live 0xbf384000
> chacha20poly1305 16384 8 - Live 0xbf37f000
> xfrm_user 40960 2 - Live 0xbf374000
> xfrm_algo 16384 2 esp4,xfrm_user, Live 0xbf36f000
> cmac 16384 1 - Live 0xbf36a000
> aes_arm_bs 24576 4 - Live 0xbf363000
> crypto_simd 16384 1 aes_arm_bs, Live 0xbf35e000
> cryptd 24576 1 crypto_simd, Live 0xbf357000
> ccm 20480 12 - Live 0xbf351000
> pppoe 20480 2 - Live 0xbf34b000
> pppox 16384 1 pppoe, Live 0xbf346000
> ppp_generic 45056 6 pppoe,pppox, Live 0xbf33a000
> slhc 16384 1 ppp_generic, Live 0xbf31e000
> vxlan 69632 0 - Live 0xbf328000
> ip6_udp_tunnel 16384 1 vxlan, Live 0xbf323000
> udp_tunnel 24576 1 vxlan, Live 0xbf317000
> xfrm_interface 20480 0 - Live 0xbf311000
> xfrm6_tunnel 16384 1 xfrm_interface, Live 0xbf308000
> tunnel6 16384 2 xfrm_interface,xfrm6_tunnel, Live 0xbf2ff000
> tunnel4 16384 1 xfrm_interface, Live 0xbf2fa000
> dummy 16384 0 - Live 0xbf2f5000
> veth 32768 0 - Live 0xbf2ec000
> vrf 32768 0 [permanent], Live 0xbf2e3000
> nft_ct 20480 4 - Live 0xbf2dd000
> nft_reject_inet 16384 8 - Live 0xbf2d8000
> nf_reject_ipv4 16384 1 nft_reject_inet, Live 0xbf2d3000
> nf_reject_ipv6 16384 1 nft_reject_inet, Live 0xbf2ce000
> nft_reject 16384 1 nft_reject_inet, Live 0xbf2c9000
> nft_masq 16384 3 - Live 0xbf2c4000
> nft_counter 16384 32 - Live 0xbf2bf000
> nft_chain_nat 16384 1 - Live 0xbf271000
> nf_nat 49152 2 nft_masq,nft_chain_nat, Live 0xbf2b2000
> nf_tables 204800 186 
> nft_ct,nft_reject_inet,nft_reject,nft_masq,nft_counter,nft_chain_nat, 
> Live 0xbf27f000
> 8021q 32768 0 - Live 0xbf276000
> nfnetlink 20480 1 nf_tables, Live 0xbf181000
> garp 16384 1 8021q, Live 0xbf17c000
> mrp 20480 1 8021q, Live 0xbf13c000
> mt7915e 106496 0 - Live 0xbf155000
> mt76 81920 1 mt7915e, Live 0xbf127000
> mac80211 536576 2 mt7915e,mt76, Live 0xbf1ed000
> cfg80211 376832 3 mt7915e,mt76,mac80211, Live 0xbf190000
> tag_dsa 16384 1 - Live 0xbf18b000
> rfkill 32768 2 cfg80211, Live 0xbf173000
> libarc4 16384 1 mac80211, Live 0xbf11d000
> mvneta 61440 0 - Live 0xbf145000
> mvneta_bm 16384 1 mvneta, Live 0xbf10f000
> orion_wdt 16384 2 - Live 0xbf0e6000
> phy_armada38x_comphy 16384 1 - Live 0xbf097000
> uio_pdrv_genirq 16384 0 - Live 0xbf122000
> uio 24576 1 uio_pdrv_genirq, Live 0xbf116000
> sch_fq_codel 20480 18 - Live 0xbf009000
> nf_conntrack 143360 3 nft_ct,nft_masq,nf_nat, Live 0xbf0eb000
> nf_defrag_ipv6 20480 1 nf_conntrack, Live 0xbf0e0000
> nf_defrag_ipv4 16384 1 nf_conntrack, Live 0xbf047000
> marvell_cesa 40960 0 - Live 0xbf08c000
> mv88e6xxx 135168 0 - Live 0xbf0be000
> dsa_core 86016 2 tag_dsa,mv88e6xxx, Live 0xbf0a8000
> hsr 40960 1 dsa_core, Live 0xbf09d000
> bridge 237568 2 mv88e6xxx,dsa_core, Live 0xbf051000
> stp 16384 2 garp,bridge, Live 0xbf04c000
> llc 16384 3 garp,bridge,stp, Live 0xbf042000
> phylink 40960 3 mvneta,mv88e6xxx,dsa_core, Live 0xbf037000
> fuse 122880 1 - Live 0xbf018000
> ip_tables 28672 0 - Live 0xbf010000
> x_tables 32768 1 ip_tables, Live 0xbf000000
> # cat /proc/cpuinfo
> processor    : 0
> model name    : ARMv7 Processor rev 1 (v7l)
> BogoMIPS    : 800.00
> Features    : half thumb fastmult vfp edsp thumbee neon vfpv3 tls vfpd32
> CPU implementer    : 0x41
> CPU architecture: 7
> CPU variant    : 0x4
> CPU part    : 0xc09
> CPU revision    : 1
>
> processor    : 1
> model name    : ARMv7 Processor rev 1 (v7l)
> BogoMIPS    : 800.00
> Features    : half thumb fastmult vfp edsp thumbee neon vfpv3 tls vfpd32
> CPU implementer    : 0x41
> CPU architecture: 7
> CPU variant    : 0x4
> CPU part    : 0xc09
> CPU revision    : 1
>
> Hardware    : Marvell Armada 380/385 (Device Tree)
> Revision    : 0000
> Serial        : 0000000E00007403
> # cat /proc/ioports
> 00001000-000effff : PCI I/O
> # cat /proc/version
> Linux version 5.16.2-2-ARCH (build@mclarmv7build) (gcc (GCC) 10.2.0, 
> GNU ld (GNU Binutils) 2.35) #1 SMP PREEMPT Sat Jan 29 17:10:27 CET 2022
>
> Kernel 5.16.10:
>
> # cat /proc/iomem
> 00000000-7fffffff : System RAM
>   00208000-018fffff : Kernel code
>   01a00000-01c6b8e4 : Kernel data
> e0000000-e7ffffff : PCI MEM
> f1010600-f101064f : f1010600.spi spi@10600
> f1011000-f101101f : f1011000.i2c i2c@11000
> f1012000-f101201f : serial
> f1012100-f101211f : serial
> f1018000-f101801f : f1018000.pinctrl pinctrl@18000
> f1018100-f101813f : f1018100.gpio gpio
> f1018140-f101817f : f1018140.gpio gpio
> f10181c0-f10181c7 : f1018100.gpio pwm
> f10181c8-f10181cf : f1018140.gpio pwm
> f1018300-f10183ff : f1018300.phy comphy
> f1018454-f1018457 : f10d8000.sdhci conf-sdio3
> f1018460-f1018463 : f1018300.phy conf
> f10184a0-f10184ab : f10a3800.rtc rtc-soc
> f1020704-f1020707 : f1020300.watchdog watchdog@20300
> f1020800-f102080f : cpurst@20800
> f1020a00-f1020ccf : interrupt-controller@20a00
> f1021070-f10210c7 : interrupt-controller@20a00
> f1022000-f1022fff : pmsu@22000
> f1030000-f1033fff : f1030000.ethernet ethernet@30000
> f1034000-f1037fff : f1034000.ethernet ethernet@34000
> f1040000-f1041fff : pcie
>   f1040000-f1041fff : soc:pcie pcie@2,0
> f1044000-f1045fff : pcie
>   f1044000-f1045fff : soc:pcie pcie@3,0
> f1048000-f1049fff : pcie
> f1058000-f10584ff : f1058000.usb usb@58000
> f1070000-f1073fff : f1070000.ethernet ethernet@70000
> f1080000-f1081fff : pcie
>   f1080000-f1081fff : soc:pcie pcie@1,0
> f1090000-f109ffff : f1090000.crypto regs
> f10a3800-f10a381f : f10a3800.rtc rtc
> f10a8000-f10a9fff : f10a8000.sata sata@a8000
> f10c8000-f10c80ab : f10c8000.bm bm@c8000
> f10d8000-f10d8fff : f10d8000.sdhci sdhci
> f10e4078-f10e407b : f10e4078.thermal thermal@e8078
> f10f0000-f10f3fff : f10f0000.usb3 usb3@f0000
> f10f8000-f10fbfff : f10f8000.usb3 usb3@f8000
> f1100000-f11007ff : f1100000.sa-sram0 sa-sram0
> f1110000-f11107ff : f1110000.sa-sram1 sa-sram1
> f1200000-f12fffff : f1200000.bm-bppi bm-bppi
> # cat /proc/modules
> esp4 20480 8 - Live 0xbf2d6000
> poly1305_generic 16384 0 - Live 0xbf2d1000
> libpoly1305 16384 1 poly1305_generic, Live 0xbf2bb000
> poly1305_arm 24576 16 - Live 0xbf2ca000
> chacha_generic 16384 0 - Live 0xbf2c5000
> libchacha 16384 1 chacha_generic, Live 0xbf2c0000
> chacha_neon 32768 8 - Live 0xbf2b2000
> chacha20poly1305 16384 8 - Live 0xbf2ad000
> xfrm_user 40960 2 - Live 0xbf2a2000
> xfrm_algo 16384 2 esp4,xfrm_user, Live 0xbf29d000
> pppoe 20480 2 - Live 0xbf297000
> pppox 16384 1 pppoe, Live 0xbf292000
> ppp_generic 45056 6 pppoe,pppox, Live 0xbf286000
> slhc 16384 1 ppp_generic, Live 0xbf26a000
> vxlan 69632 0 - Live 0xbf274000
> ip6_udp_tunnel 16384 1 vxlan, Live 0xbf26f000
> udp_tunnel 24576 1 vxlan, Live 0xbf263000
> xfrm_interface 20480 0 - Live 0xbf25d000
> xfrm6_tunnel 16384 1 xfrm_interface, Live 0xbf254000
> tunnel6 16384 2 xfrm_interface,xfrm6_tunnel, Live 0xbf24b000
> tunnel4 16384 1 xfrm_interface, Live 0xbf246000
> dummy 16384 0 - Live 0xbf241000
> veth 32768 0 - Live 0xbf238000
> vrf 32768 0 [permanent], Live 0xbf22f000
> nft_ct 20480 4 - Live 0xbf229000
> nft_reject_inet 16384 8 - Live 0xbf224000
> nf_reject_ipv4 16384 1 nft_reject_inet, Live 0xbf21f000
> nf_reject_ipv6 16384 1 nft_reject_inet, Live 0xbf21a000
> nft_reject 16384 1 nft_reject_inet, Live 0xbf1d8000
> nft_masq 16384 3 - Live 0xbf1d3000
> nft_counter 16384 32 - Live 0xbf143000
> nft_chain_nat 16384 1 - Live 0xbf164000
> nf_nat 49152 2 nft_masq,nft_chain_nat, Live 0xbf1c6000
> nf_tables 208896 186 
> nft_ct,nft_reject_inet,nft_reject,nft_masq,nft_counter,nft_chain_nat, 
> Live 0xbf1e6000
> nfnetlink 20480 1 nf_tables, Live 0xbf1e0000
> cfg80211 372736 0 - Live 0xbf16a000
> rfkill 32768 2 cfg80211, Live 0xbf15b000
> 8021q 32768 0 - Live 0xbf13a000
> garp 16384 1 8021q, Live 0xbf132000
> mrp 20480 1 8021q, Live 0xbf123000
> tag_dsa 16384 1 - Live 0xbf11e000
> mvneta 61440 0 - Live 0xbf14b000
> orion_wdt 16384 2 - Live 0xbf12d000
> mvneta_bm 16384 1 mvneta, Live 0xbf119000
> phy_armada38x_comphy 16384 1 - Live 0xbf0c7000
> uio_pdrv_genirq 16384 0 - Live 0xbf114000
> uio 24576 1 uio_pdrv_genirq, Live 0xbf098000
> sch_fq_codel 20480 18 - Live 0xbf009000
> nf_conntrack 143360 3 nft_ct,nft_masq,nf_nat, Live 0xbf0f0000
> nf_defrag_ipv6 20480 1 nf_conntrack, Live 0xbf0c1000
> nf_defrag_ipv4 16384 1 nf_conntrack, Live 0xbf048000
> marvell_cesa 40960 0 - Live 0xbf08d000
> mv88e6xxx 139264 0 - Live 0xbf0cd000
> dsa_core 90112 2 tag_dsa,mv88e6xxx, Live 0xbf0aa000
> hsr 40960 1 dsa_core, Live 0xbf09f000
> bridge 237568 2 mv88e6xxx,dsa_core, Live 0xbf052000
> stp 16384 2 garp,bridge, Live 0xbf04d000
> llc 16384 3 garp,bridge,stp, Live 0xbf043000
> phylink 40960 3 mvneta,mv88e6xxx,dsa_core, Live 0xbf038000
> fuse 126976 1 - Live 0xbf018000
> ip_tables 28672 0 - Live 0xbf010000
> x_tables 32768 1 ip_tables, Live 0xbf000000
> # cat /proc/cpuinfo
> processor    : 0
> model name    : ARMv7 Processor rev 1 (v7l)
> BogoMIPS    : 800.00
> Features    : half thumb fastmult vfp edsp thumbee neon vfpv3 tls vfpd32
> CPU implementer    : 0x41
> CPU architecture: 7
> CPU variant    : 0x4
> CPU part    : 0xc09
> CPU revision    : 1
>
> processor    : 1
> model name    : ARMv7 Processor rev 1 (v7l)
> BogoMIPS    : 800.00
> Features    : half thumb fastmult vfp edsp thumbee neon vfpv3 tls vfpd32
> CPU implementer    : 0x41
> CPU architecture: 7
> CPU variant    : 0x4
> CPU part    : 0xc09
> CPU revision    : 1
>
> Hardware    : Marvell Armada 380/385 (Device Tree)
> Revision    : 0000
> Serial        : 0000000E00007403
> # cat /proc/ioports
> 00001000-000effff : PCI I/O
> # cat /proc/version
> Linux version 5.16.10-1-ARCH (build@mclarmv7build) (gcc (GCC) 11.2.0, 
> GNU ld (GNU Binutils) 2.38) #1 SMP PREEMPT Wed Feb 23 14:05:11 CET 2022

Adding linux-pci as this seems to be a problem in the kernel's PCI layer 
as being told on linux-arm-kernel.

>
>> Kind regards,
>>
>> Marcel Menzel
>

