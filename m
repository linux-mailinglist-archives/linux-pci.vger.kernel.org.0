Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2A68BF20D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 13:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfIZLrw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 07:47:52 -0400
Received: from smtp-o-1.desy.de ([131.169.56.154]:40528 "EHLO smtp-o-1.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfIZLrw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Sep 2019 07:47:52 -0400
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
        by smtp-o-1.desy.de (Postfix) with ESMTP id 34824E0151
        for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2019 13:47:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 34824E0151
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1569498470; bh=TmiBiLVY7p7SYbQParuzid8T5ohmLbhtJat2X49bXwE=;
        h=To:From:Date:From;
        b=1o02qVucEgxyKcka3X4acEeroJWJrzGs8Oa3uy7+8k+aBW/ZNnGQMSZi9Qi5DX9ww
         N4iJ7D2eC//iraJn2r7tcitA5S4FuHIFC5O6IhIC2qzB+g+oL6HrNEpG+a60ZSJqhn
         b/vBUokGLxrBNXA8Q1UrhJKozhonkcKxQW2I3yNI=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id 308B51201DA
        for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2019 13:47:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from [131.169.146.36] (mcspetros.desy.de [131.169.146.36])
        by smtp-intra-1.desy.de (Postfix) with ESMTP id 0D3C2C008A
        for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2019 13:47:50 +0200 (CEST)
To:     linux-pci@vger.kernel.org
From:   Ludwig Petrosyan <ludwig.petrosyan@desy.de>
Message-ID: <5a89b964-8a6e-7e6c-b6e4-e81c8d4b65ca@desy.de>
Date:   Thu, 26 Sep 2019 13:47:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear Linux kernel group

We are using MTCA systems with Ubuntu Linux and PCIe as a central bus

We got some problem:

some times the memories of the PCIe endpoints not mapped and the lspci 
gives strange otput:

uname -a : Linux mcscpudev6 4.15.0-45-generic 48~16.04.1-Ubuntu SMP Tue 
Jan 29 18:03:48 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux


lspci  -vvvv -s 05:00.0
05:00.0 Signal processing controller: Xilinx Corporation Device 0088
     Subsystem: Device 3300:0088
     Physical Slot: 4
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 223
     Region 0: Memory at <ignored> (32-bit, non-prefetchable)
     Region 1: Memory at <ignored> (32-bit, non-prefetchable)
     Region 2: Memory at <ignored> (32-bit, non-prefetchable)
     Expansion ROM at 71c00000 [disabled] [size=1M]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee00ef8  Data: 0000
     Capabilities: [60] Express (v1) Endpoint, MSI 00
         DevCap:    MaxPayload 512 bytes, PhantFunc 1, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Exit 
Latency L0s unlimited, L1 unlimited
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
     Capabilities: [100 v1] Device Serial Number 00-00-00-00-00-00-00-00
     Kernel driver in use: pciedev
     Kernel modules: pciedev

but lspci with -H1:

lspci -H1 -vvvv -s 05:00.0
05:00.0 Signal processing controller: Xilinx Corporation Device 0088
     Subsystem: Device 3300:0088
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 10
     Region 0: Memory at d8000000 (32-bit, non-prefetchable)
     Region 1: Memory at d4000000 (32-bit, non-prefetchable)
     Region 2: Memory at dc000000 (32-bit, non-prefetchable)
     Expansion ROM at dd000000 [disabled]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee00ef8  Data: 0000
     Capabilities: [60] Express (v1) Endpoint, MSI 00
         DevCap:    MaxPayload 512 bytes, PhantFunc 1, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Exit 
Latency L0s unlimited, L1 unlimited
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-

adding pci=realloc=off solves with problem.

Is it in general a good idea to use "pci=realloc=off"?

And what the problem? Would some body so kinde to explane what the problem?!


with best regards

Ludwig Petrosyan


