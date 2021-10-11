Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0E442979B
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 21:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbhJKTgK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 15:36:10 -0400
Received: from office.oderland.com ([91.201.60.5]:33914 "EHLO
        office.oderland.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhJKTgJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 15:36:09 -0400
Received: from 161.193-180-18.r.oderland.com ([193.180.18.161]:41084 helo=[10.137.0.14])
        by office.oderland.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <josef@oderland.se>)
        id 1ma13n-00DAJy-SY; Mon, 11 Oct 2021 21:34:08 +0200
Message-ID: <c9218eb4-9fc1-28f4-d053-895bab0473d4@oderland.se>
Date:   Mon, 11 Oct 2021 21:34:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:93.0) Gecko/20100101
 Thunderbird/93.0
Subject: Re: [REGRESSION][BISECTED] 5.15-rc1: Broken AHCI on NVIDIA ION
 (MCP79)
Content-Language: en-US
From:   Josef Johansson <josef@oderland.se>
To:     tglx@linutronix.de
Cc:     maz@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com>
 <b023adf9-e21c-59ac-de49-57915c8cede8@oderland.se>
In-Reply-To: <b023adf9-e21c-59ac-de49-57915c8cede8@oderland.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - office.oderland.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oderland.se
X-Get-Message-Sender-Via: office.oderland.com: authenticated_id: josjoh@oderland.se
X-Authenticated-Sender: office.oderland.com: josjoh@oderland.se
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/11/21 20:47, Josef Johansson wrote:
> Hi,
>
> I've got a late regression to this commit as well, but in the GPU area.
> The problem arises when booting it as XEN dom0.
> My hardware is Lenovo P14s Gen1 AMD Ryzen 7 Pro 4750U.
>
> I'm a bit lost myself, and could use some hints how to fix it.
> I should note that this mainly happens when a modeset is done (i think).
> If I wait for 5 minutes the lock eventually releases, but I switch in an
> out between X
> and console it locks again.
>
> [snip]
>
> More can be read over at freedesktop:
> https://gitlab.freedesktop.org/drm/amd/-/issues/1715
>
>
>
> Josef Johansson
>
>
>
Here is a lspci -vvnn for verbosity, I am trying out Marc's first patch
now and
will let you know the result.

00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Renoir
Root Compl
ex [1022:1630]
    Subsystem: Lenovo Device [17aa:5081]
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Renoir IOMMU
[1022:1631
]
    Subsystem: Lenovo Device [17aa:5081]
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Interrupt: pin A routed to IRQ 255
    Capabilities: <access denied>

00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Renoir
PCIe Dummy
 Host Bridge [1022:1632]
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Renoir
PCIe Dummy
 Host Bridge [1022:1632]
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

00:02.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Renoir
PCIe GPP Br
idge [1022:1634] (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Interrupt: pin ? routed to IRQ 106
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: [disabled]
    Memory behind bridge: fd900000-fd9fffff [size=1M]
    Prefetchable memory behind bridge: [disabled]
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: <access denied>
    Kernel driver in use: pcieport

00:02.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Renoir
PCIe GPP Br
idge [1022:1634] (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Interrupt: pin ? routed to IRQ 107
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
    I/O behind bridge: 00003000-00003fff [size=4K]
    Memory behind bridge: fd800000-fd8fffff [size=1M]
    Prefetchable memory behind bridge: [disabled]
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: <access denied>
    Kernel driver in use: pcieport

00:02.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Renoir
PCIe GPP Br
idge [1022:1634] (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Interrupt: pin ? routed to IRQ 108
    Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
    I/O behind bridge: 00004000-00004fff [size=4K]
    Memory behind bridge: fd700000-fd7fffff [size=1M]
    Prefetchable memory behind bridge: 0000000c30000000-0000000c301fffff [si
ze=2M]
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: <access denied>
    Kernel driver in use: pcieport

00:02.4 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Renoir
PCIe GPP Br
idge [1022:1634] (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Interrupt: pin ? routed to IRQ 109
    Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
    I/O behind bridge: [disabled]
    Memory behind bridge: fd600000-fd6fffff [size=1M]
    Prefetchable memory behind bridge: [disabled]
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: <access denied>
    Kernel driver in use: pcieport

00:02.6 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Renoir
PCIe GPP Br
idge [1022:1634] (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Interrupt: pin ? routed to IRQ 110
    Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
    I/O behind bridge: 00002000-00002fff [size=4K]
    Memory behind bridge: fd500000-fd5fffff [size=1M]
    Prefetchable memory behind bridge: [disabled]
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: <access denied>
    Kernel driver in use: pcieport

00:02.7 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Renoir
PCIe GPP Br
idge [1022:1634] (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Interrupt: pin ? routed to IRQ 111
    Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
    I/O behind bridge: [disabled]
    Memory behind bridge: fd400000-fd4fffff [size=1M]
    Prefetchable memory behind bridge: [disabled]
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: <access denied>
    Kernel driver in use: pcieport

00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Renoir
PCIe Dummy
 Host Bridge [1022:1632]
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Renoir
Internal PC
Ie GPP Bridge to Bus [1022:1635] (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Interrupt: pin A routed to IRQ 112
    Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
    I/O behind bridge: 00001000-00001fff [size=4K]
    Memory behind bridge: fd000000-fd3fffff [size=4M]
    Prefetchable memory behind bridge: 0000000c60000000-0000000c701fffff [si
ze=258M]
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: <access denied>
    Kernel driver in use: pcieport

00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus
Controller [1
022:790b] (rev 51)
    Subsystem: Lenovo Device [17aa:5081]
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx+
    Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR- INTx-
    Kernel driver in use: piix4_smbus
    Kernel modules: i2c_piix4, sp5100_tco

00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC
Bridge [10
22:790e] (rev 51)
    Subsystem: Lenovo Device [17aa:5081]
    Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Renoir
Device 24:
 Function 0 [1022:1448]
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Renoir
Device 24:
 Function 1 [1022:1449]
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Renoir
Device 24:
 Function 2 [1022:144a]
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Renoir
Device 24:
 Function 3 [1022:144b]
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Kernel driver in use: k10temp
    Kernel modules: k10temp

00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Renoir
Device 24:
 Function 4 [1022:144c]
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Renoir
Device 24:
 Function 5 [1022:144d]
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Renoir
Device 24:
 Function 6 [1022:144e]
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Renoir
Device 24:
 Function 7 [1022:144f]
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

01:00.0 Non-Volatile memory controller [0108]: SK hynix Device
[1c5c:1639] (prog
-if 02 [NVM Express])
    Subsystem: SK hynix Device [1c5c:1639]
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Interrupt: pin A routed to IRQ 36
    NUMA node: 0
    Region 0: Memory at fd900000 (64-bit, non-prefetchable) [size=16K]
    Region 2: Memory at fd905000 (32-bit, non-prefetchable) [size=4K]
    Region 3: Memory at fd904000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: <access denied>
    Kernel driver in use: nvme
    Kernel modules: nvme

02:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8111/8168
/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 0e)
    Subsystem: Lenovo Device [17aa:5081]
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Interrupt: pin A routed to IRQ 40
    Region 0: I/O ports at 3400 [size=256]
    Region 2: Memory at fd814000 (64-bit, non-prefetchable) [size=4K]
    Region 4: Memory at fd800000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: <access denied>
    Kernel driver in use: pciback
    Kernel modules: r8169

02:00.1 Serial controller [0700]: Realtek Semiconductor Co., Ltd.
RTL8111xP UART
 #1 [10ec:816a] (rev 0e) (prog-if 02 [16550])
    Subsystem: Lenovo Device [17aa:5081]
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Interrupt: pin B routed to IRQ 41
    Region 0: I/O ports at 3200 [size=256]
    Region 2: Memory at fd815000 (64-bit, non-prefetchable) [size=4K]
    Region 4: Memory at fd804000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: <access denied>
    Kernel driver in use: serial

02:00.2 Serial controller [0700]: Realtek Semiconductor Co., Ltd.
RTL8111xP UART
 #2 [10ec:816b] (rev 0e) (prog-if 02 [16550])
    Subsystem: Lenovo Device [17aa:5081]
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Interrupt: pin C routed to IRQ 42
    Region 0: I/O ports at 3100 [size=256]
    Region 2: Memory at fd816000 (64-bit, non-prefetchable) [size=4K]
    Region 4: Memory at fd808000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: <access denied>
    Kernel driver in use: serial

02:00.3 IPMI Interface [0c07]: Realtek Semiconductor Co., Ltd. RTL8111xP
IPMI in
terface [10ec:816c] (rev 0e) (prog-if 01 [KCS])
    Subsystem: Lenovo Device [17aa:5081]
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Interrupt: pin D routed to IRQ 255
    Region 0: I/O ports at 3000 [disabled] [size=256]
    Region 2: Memory at fd817000 (64-bit, non-prefetchable) [disabled] [size
=4K]
    Region 4: Memory at fd80c000 (64-bit, non-prefetchable) [disabled] [size
=16K]
    Capabilities: <access denied>
    Kernel modules: ipmi_si

02:00.4 USB controller [0c03]: Realtek Semiconductor Co., Ltd. RTL811x
EHCI host
 controller [10ec:816d] (rev 0e) (prog-if 20 [EHCI])
    Subsystem: Lenovo Device [17aa:5081]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Interrupt: pin D routed to IRQ 114
    Region 0: Memory at fd818000 (32-bit, non-prefetchable) [size=4K]
    Region 2: Memory at fd810000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: <access denied>
    Kernel driver in use: ehci-pci
    Kernel modules: ehci_pci

03:00.0 Network controller [0280]: Intel Corporation Wi-Fi 6 AX200
[8086:2723] (
rev 1a)
    Subsystem: Intel Corporation Device [8086:0080]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Interrupt: pin A routed to IRQ 44
    Region 0: Memory at fd700000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: <access denied>
    Kernel driver in use: pciback
    Kernel modules: iwlwifi

04:00.0 SD Host controller [0805]: Genesys Logic, Inc GL9750 SD Host
Controller
[17a0:9750] (rev 01) (prog-if 01)
    Subsystem: Lenovo Device [17aa:5082]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Interrupt: pin A routed to IRQ 118
    Region 0: Memory at fd600000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: <access denied>
    Kernel driver in use: sdhci-pci
    Kernel modules: sdhci_pci

05:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8111/8168
/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 15)
    Subsystem: Lenovo Device [17aa:5081]
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Interrupt: pin A routed to IRQ 46
    Region 0: I/O ports at 2000 [size=256]
    Region 2: Memory at fd504000 (64-bit, non-prefetchable) [size=4K]
    Region 4: Memory at fd500000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: <access denied>
    Kernel driver in use: pciback
    Kernel modules: r8169

06:00.0 USB controller [0c03]: Renesas Technology Corp. uPD720202 USB
3.0 Host C
ontroller [1912:0015] (rev 02) (prog-if 30 [XHCI])
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Interrupt: pin A routed to IRQ 42
    Region 0: Memory at fd400000 (64-bit, non-prefetchable) [size=8K]
    Capabilities: <access denied>
    Kernel driver in use: xhci_hcd
    Kernel modules: xhci_pci

07:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc.
[AMD/ATI]
 Renoir [1002:1636] (rev d1) (prog-if 00 [VGA controller])
    Subsystem: Lenovo Device [17aa:5099]
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+ <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Interrupt: pin A routed to IRQ 38
    Region 0: Memory at c60000000 (64-bit, prefetchable) [size=256M]
    Region 2: Memory at c70000000 (64-bit, prefetchable) [size=2M]
    Region 4: I/O ports at 1000 [size=256]
    Region 5: Memory at fd300000 (32-bit, non-prefetchable) [size=512K]
    Capabilities: <access denied>
    Kernel driver in use: amdgpu
    Kernel modules: amdgpu

07:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD]
Family
17h (Models 10h-1fh) Platform Security Processor [1022:15df]
    Subsystem: Lenovo Device [17aa:5081]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+ <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Interrupt: pin C routed to IRQ 36
    Region 2: Memory at fd200000 (32-bit, non-prefetchable) [size=1M]
    Region 5: Memory at fd380000 (32-bit, non-prefetchable) [size=8K]
    Capabilities: <access denied>
    Kernel driver in use: ccp
    Kernel modules: ccp

07:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Renoir
USB 3.1
 [1022:1639] (prog-if 30 [XHCI])
    Subsystem: Lenovo Device [17aa:5081]
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Interrupt: pin D routed to IRQ 37
    Region 0: Memory at fd000000 (64-bit, non-prefetchable) [size=1M]
    Capabilities: <access denied>
    Kernel driver in use: pciback
    Kernel modules: xhci_pci

07:00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Renoir
USB 3.1
 [1022:1639] (prog-if 30 [XHCI])
    Subsystem: Lenovo Device [17aa:5081]
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Interrupt: pin A routed to IRQ 38
    Region 0: Memory at fd100000 (64-bit, non-prefetchable) [size=1M]
    Capabilities: <access denied>
    Kernel driver in use: pciback
    Kernel modules: xhci_pci

Regards
- Josef

