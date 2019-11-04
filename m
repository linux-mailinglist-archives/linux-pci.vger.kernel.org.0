Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF1BEE2A6
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2019 15:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfKDOfO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Nov 2019 09:35:14 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:46315 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbfKDOfO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Nov 2019 09:35:14 -0500
Received: by mail-qk1-f176.google.com with SMTP id h15so8068988qka.13
        for <linux-pci@vger.kernel.org>; Mon, 04 Nov 2019 06:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=drgeU6gzooHFR+w87BC5GgrOs57sSFMVMo2CBBgFIX0=;
        b=oyHU2TlY9j6Vzi6aWufRb3V1sPDdXFQ7Kny+HNWLhpzOqpE8QUR4U0Kg6NtvFSE4Id
         njG4yKrhF6aQYCP938aHkzR+vX7GPmKLrR4dh97y6ovTTFav3GHZvC4euNL8n63WQkfQ
         81h8D0iOdZxLxOU2TBppI8IF3+L8+s5h7ZY6dfLEbXNob+mUZ5vQThLi5/CZrnj4dDQr
         xLiaXJRZLg04m05uwDYWhz3Qs/j5axfT865urqwckszKg8ruVhnGKA5ScMfs7O8G1oqV
         PU8gW1aTIRkrjWqqegPaQYZYePUkzt9AiH7+q0f04AGSY580MxT8/mG81KUpcxoc6lkt
         6dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=drgeU6gzooHFR+w87BC5GgrOs57sSFMVMo2CBBgFIX0=;
        b=eG8m/i4nbIapZcuLiPNd9iVVzHVeFOjp14LJF2nr0zXWixaVth20u2EOVOdMSOZr0Z
         KpbFBdIsXGcH1AV5DFOKc0M2niIdp6quGthZUmOoPWUeYKQz0hKnl5PEpIF019pnHAE5
         JN4O41MLabjrBrZ/wjNozE9349iOF0akoQxoF3woXA2haEhoDJ5LHMVT4j4cuXUpyg85
         vNJOofUseBjjRvTXmwiac/Q67uRk3k2GHwdFUlysCtfQmkGlq/cGBAiMQs0OyrwFcCRa
         COiuNEuqoqxJWoB1rWn5mL/WvkCiKn2zVRtIsJ6bNOQvwy9lb4fFlyXiVT7QLmJlDmGr
         UtcQ==
X-Gm-Message-State: APjAAAWYBOxC3O812XGRH6gyz8Rxe3Tt0guvSKKtBxkHVGITLpgEHBAo
        qQnS9CB3983qR0Z0KPu80uYVX+gk5YtQq1NZQTPC93Kc
X-Google-Smtp-Source: APXvYqyDIQ/Cg52e4XvRARF3ose2HbiRv8inVVALlHd/DRPMB+yDCAF+v+YtR5eINeSD07EyUpsDLHggNakJ2JrK4qw=
X-Received: by 2002:a37:a815:: with SMTP id r21mr22451441qke.464.1572878112925;
 Mon, 04 Nov 2019 06:35:12 -0800 (PST)
MIME-Version: 1.0
From:   Ranran <ranshalit@gmail.com>
Date:   Mon, 4 Nov 2019 16:35:00 +0200
Message-ID: <CAJ2oMhJh_itMXcZJ0Qxe1emrRXwYSGmVowm8gqipj6-8i0CNOA@mail.gmail.com>
Subject: FPGA device behaves strangely with Linux
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

I use x86 device with FPGA device.
The FPGA device acts strangely with Linux, while with vother OS on
same HW there is no issue.
The Other PCIe device acts find without any issues.
Doing lspci after reset, sometimes the device appear and other times
not enumerated at all.

After reset it is almost always missing.
Then I force rescan several times, until it appears in lspci:
03:00.0 RAM memory: Xilinx Corporation Default PCIe endpoint ID (rev ff)

After it appears there is still inconsistency when reading
configuration BAR with lspci -vv:
03:00.0 RAM memory: Xilinx Corporation Default PCIe endpoint ID
        Subsystem: Xilinx Corporation Default PCIe endpoint ID
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 255
        Region 0: [virtual] Memory at 91500000 (32-bit,
non-prefetchable) [size=1M]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [58] Express (v1) Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 1, Latency L0s
<64ns, L1 <1us
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+
FLReset- SlotPowerLimit 10.000W
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq-
AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s,
Exit Latency L0s unlimited
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Device Serial Number 00-00-00-00-00-00-00-00

[root@localhost ~]# lspci -xx -s 03:00.00
03:00.0 RAM memory: Xilinx Corporation Default PCIe endpoint ID
00: ee 10 07 00 00 00 10 00 00 00 00 05 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ee 10 07 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00


Other tries of reading (without reseting in between):
=========
03:00.0 RAM memory: Xilinx Corporation Default PCIe endpoint ID (rev
ff) (prog-if ff)
        !!! Unknown header type 7f

root@localhost ~]# lspci -xx -s 03:00.00
03:00.0 RAM memory: Xilinx Corporation Default PCIe endpoint ID (rev ff)
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff


[root@localhost pcimem]# ./pcimem
/sys/bus/pci/devices/0000\:03\:00.0/resource0  0 w*100
/sys/bus/pci/devices/0000:03:00.0/resource0 opened.
Target offset is 0x0, page size is 4096
mmap(0, 4096, 0x3, 0x1, 3, 0x0)
PCI Memory mapped to address 0x7faf91256000.
0x0000: 0xFFFFFFFF
...

The BIOS is also different between Linux and the other OS on same HW.

Any idea what configuration can cause this behavior ?

Thank you,
Ran
