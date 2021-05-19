Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84376388CC7
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 13:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351014AbhESL3X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 07:29:23 -0400
Received: from foss.arm.com ([217.140.110.172]:33236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350681AbhESL3Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 May 2021 07:29:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DBF3101E;
        Wed, 19 May 2021 04:27:56 -0700 (PDT)
Received: from [10.57.66.179] (unknown [10.57.66.179])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBDA53F719;
        Wed, 19 May 2021 04:27:54 -0700 (PDT)
Subject: Re: [BUG] rockpro64: PCI BAR reassignment broken by commit
 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit
 memory addresses")
To:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        heiko.stuebner@theobroma-systems.com, leobras.c@gmail.com,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
References: <7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <01efd004-1c50-25ca-05e4-7e4ef96232e2@arm.com>
Date:   Wed, 19 May 2021 12:27:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[ +linux-pci for visibility ]

On 2021-05-18 10:09, Alexandru Elisei wrote:
> After doing a git bisect I was able to trace the following error when booting my
> rockpro64 v2 (rk3399 SoC) with a PCIE NVME expansion card:
> 
> [..]
> [    0.305183] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
> [    0.305248] rockchip-pcie f8000000.pcie:      MEM 0x00fa000000..0x00fbdfffff ->
> 0x00fa000000
> [    0.305285] rockchip-pcie f8000000.pcie:       IO 0x00fbe00000..0x00fbefffff ->
> 0x00fbe00000
> [    0.306201] rockchip-pcie f8000000.pcie: supply vpcie1v8 not found, using dummy
> regulator
> [    0.306334] rockchip-pcie f8000000.pcie: supply vpcie0v9 not found, using dummy
> regulator
> [    0.373705] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
> [    0.373730] pci_bus 0000:00: root bus resource [bus 00-1f]
> [    0.373751] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff 64bit]
> [    0.373777] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus
> address [0xfbe00000-0xfbefffff])
> [    0.373839] pci 0000:00:00.0: [1d87:0100] type 01 class 0x060400
> [    0.373973] pci 0000:00:00.0: supports D1
> [    0.373992] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> [    0.378518] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]),
> reconfiguring
> [    0.378765] pci 0000:01:00.0: [144d:a808] type 00 class 0x010802
> [    0.378869] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
> [    0.379051] pci 0000:01:00.0: Max Payload Size set to 256 (was 128, max 256)
> [    0.379661] pci 0000:01:00.0: 8.000 Gb/s available PCIe bandwidth, limited by
> 2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe
> x4 link)
> [    0.393269] pci_bus 0000:01: busn_res: [bus 01-1f] end is updated to 01
> [    0.393311] pci 0000:00:00.0: BAR 14: no space for [mem size 0x00100000]
> [    0.393333] pci 0000:00:00.0: BAR 14: failed to assign [mem size 0x00100000]
> [    0.393356] pci 0000:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
> [    0.393375] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64bit]
> [    0.393397] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    0.393839] pcieport 0000:00:00.0: PME: Signaling with IRQ 78
> [    0.394165] pcieport 0000:00:00.0: AER: enabled with IRQ 78
> [..]
> 
> to the commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for
> 64-bit memory addresses").

FWFW, my hunch is that the host bridge advertising no 32-bit memory 
resource, only only a single 64-bit non-prefetchable one (even though 
it's entirely below 4GB) might be a bit weird and tripping something up 
in the resource assignment code. It certainly seems like the thing most 
directly related to the offending commit.

I'd be tempted to try fiddling with that in the DT (i.e. changing 
0x83000000 to 0x82000000 in the PCIe node's "ranges" property) to see if 
it makes any difference. Note that even if it helps, though, I don't 
know whether that's the correct fix or just a bodge around a corner-case 
bug somewhere in the resource code.

Robin.

> For reference, here is the dmesg output when BAR
> reassignment works:
> 
> [..]
> [    0.307381] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
> [    0.307445] rockchip-pcie f8000000.pcie:      MEM 0x00fa000000..0x00fbdfffff ->
> 0x00fa000000
> [    0.307481] rockchip-pcie f8000000.pcie:       IO 0x00fbe00000..0x00fbefffff ->
> 0x00fbe00000
> [    0.308406] rockchip-pcie f8000000.pcie: supply vpcie1v8 not found, using dummy
> regulator
> [    0.308534] rockchip-pcie f8000000.pcie: supply vpcie0v9 not found, using dummy
> regulator
> [    0.374676] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
> [    0.374701] pci_bus 0000:00: root bus resource [bus 00-1f]
> [    0.374723] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff]
> [    0.374746] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus
> address [0xfbe00000-0xfbefffff])
> [    0.374808] pci 0000:00:00.0: [1d87:0100] type 01 class 0x060400
> [    0.374943] pci 0000:00:00.0: supports D1
> [    0.374961] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> [    0.379473] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]),
> reconfiguring
> [    0.379712] pci 0000:01:00.0: [144d:a808] type 00 class 0x010802
> [    0.379815] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
> [    0.379997] pci 0000:01:00.0: Max Payload Size set to 256 (was 128, max 256)
> [    0.380607] pci 0000:01:00.0: 8.000 Gb/s available PCIe bandwidth, limited by
> 2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe
> x4 link)
> [    0.394239] pci_bus 0000:01: busn_res: [bus 01-1f] end is updated to 01
> [    0.394285] pci 0000:00:00.0: BAR 14: assigned [mem 0xfa000000-0xfa0fffff]
> [    0.394312] pci 0000:01:00.0: BAR 0: assigned [mem 0xfa000000-0xfa003fff 64bit]
> [    0.394374] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    0.394395] pci 0000:00:00.0:   bridge window [mem 0xfa000000-0xfa0fffff]
> [    0.394569] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
> [    0.394845] pcieport 0000:00:00.0: PME: Signaling with IRQ 78
> [    0.395153] pcieport 0000:00:00.0: AER: enabled with IRQ 78
> [..]
> 
> And here is the output of lspci when BAR reassignment works:
> 
> # lspci -v
> 00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd RK3399 PCI Express Root
> Port (prog-if 00 [Normal decode])
>      Flags: bus master, fast devsel, latency 0, IRQ 78
>      Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>      I/O behind bridge: 00000000-00000fff [size=4K]
>      Memory behind bridge: fa000000-fa0fffff [size=1M]
>      Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
>      Capabilities: [80] Power Management version 3
>      Capabilities: [90] MSI: Enable+ Count=1/1 Maskable+ 64bit+
>      Capabilities: [b0] MSI-X: Enable- Count=1 Masked-
>      Capabilities: [c0] Express Root Port (Slot+), MSI 00
>      Capabilities: [100] Advanced Error Reporting
>      Capabilities: [274] Transaction Processing Hints
>      Kernel driver in use: pcieport
> lspci: Unable to load libkmod resources: error -2
> 
> 01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD
> Controller SM981/PM981/PM983 (prog-if 02 [NVM Express])
>      Subsystem: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
>      Flags: bus master, fast devsel, latency 0, IRQ 77, NUMA node 0
>      Memory at fa000000 (64-bit, non-prefetchable) [size=16K]
>      Capabilities: [40] Power Management version 3
>      Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>      Capabilities: [70] Express Endpoint, MSI 00
>      Capabilities: [b0] MSI-X: Enable+ Count=33 Masked-
>      Capabilities: [100] Advanced Error Reporting
>      Capabilities: [148] Device Serial Number 00-00-00-00-00-00-00-00
>      Capabilities: [158] Power Budgeting <?>
>      Capabilities: [168] Secondary PCI Express
>      Capabilities: [188] Latency Tolerance Reporting
>      Capabilities: [190] L1 PM Substates
>      Kernel driver in use: nvme
> 
> I can provide more information if needed (the board is sitting on my desk) and I
> can help with testing the fix.
> 
> Thanks,
> 
> Alex
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
