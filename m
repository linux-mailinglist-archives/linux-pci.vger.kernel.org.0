Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCDE6ADD2D
	for <lists+linux-pci@lfdr.de>; Tue,  7 Mar 2023 12:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCGLWv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 7 Mar 2023 06:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCGLWt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Mar 2023 06:22:49 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811B92137
        for <linux-pci@vger.kernel.org>; Tue,  7 Mar 2023 03:22:46 -0800 (PST)
Received: from pammob ([37.170.0.83]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MzyuS-1qTEah1JVG-00x5QE for
 <linux-pci@vger.kernel.org>; Tue, 07 Mar 2023 12:22:45 +0100
Date:   Tue, 07 Mar 2023 12:22:44 +0100
From:   rec <gael.seibert@gmx.fr>
Subject: The MSI Driver Guide HOWTO
To:     linux-pci@vger.kernel.org
MIME-Version: 1.0
X-Mailer: Balsa 2.6.4
Message-Id: <3EXLGBDE.RHCGXKUL.PVZZRIJ5@4WBK2UU6.UECE5XTY.OLOBOVLW>
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:rdpN/xN8xnVdIyWRSJJSPcex+TEjKZ2Kbs5N17ab1ztVNdfCua1
 1LdlLHg2aZbY4zEwfocbkWxigPgDNlBLBFuDfT6B6bxLQ0NpJQYNBjtl/2/PlagVcgiM5IA
 b8JmFiteOi2a2NmESAwuo8Ge+Tj0CBen8gzKlvPA3i4u6wpGf5Cbexk9TiwJ2xw1Oxv9BTA
 nngp6S9um+gWLo0g7SJCw==
UI-OutboundReport: notjunk:1;M01:P0:GVzm6cCszWo=;nbvfAPsmWN0PcM3YMFkY8e8/tLC
 cOzOh6DazI4c4UbtyYINhCpIJ83TsfU2sXMV8dqED/R+1ljEjiQZ7c69w1Aip11wRDthK/Vgw
 d7vrEJ+iFyWEhzXLhRKBeOiohRrbsdxw5u9tUrzsz2uiBZh/KwWovkETBYu8miRTF+Diby6vV
 urL2uBVfOl+FNl0CYyW2IiKQ7qRwq1e/QEh5RvE8iSRYtfBSha06ihRafLM5xclgSAYZrLQ2e
 NZrSgnl5brt2fWLCpE2TxuU4DRUrEhxlRnnGT/ehnkqD1xQBsQyLyWXw74OpmWnSyEDusKikS
 cE18NJD1hCX/hu7Zof9xcVPDX675pEuzscekEWyvhicqgUcsoW5sBHnmHV4N2IbTWb6Vt5mqx
 oBQzIhA9oSjueTMv95ynG5OfWffygd7z5mR8QV26cNCzgmLgZp0S5SUUU9vAyuZQUlmik3//B
 iXJbpRJLcH7yc2uW/lNQ4ai9jT5W/9fj+XcdbpqDNrpP1YWWOZD1MKBOiuLhXhJyGI6GpYAY9
 Sn/i8r6H661aJmxz0mNtTlXJXdspdMkoxR3oLWDWCYOpMtaTpO5owxgKb4Df++E37rIKM5Te/
 iQ8/vmjwlvwso5rlpLJHRmpSTGzIrT6kdG5BKTQv+RXTHMf/5fgMLmw+gxwGGufuoQowduqrn
 UVoeF2lFeIyeVjvzV79aVQsJmXhHbbpIYJxMq77ehKg//CjOAUaiDZnoFFsRX6fRo17GSAwaa
 Gs3rED1djO2A3S9wH4t80EI7+mwSH/97vskD3Q2MqtyzoVHD7tBZAAFQ88CwfmR96wmlJS2Kj
 rBqBlpQEQj9mgDyu3F/4iHbdBrMP2rlTrSwV1wRuSYFMi1RbuTX9490fniDVqTp1Kr/8+0pwD
 7hqSKbDT6cS/fVW/T897fl0GK6ijGPML1eSqdS4UTKYzxNv0qBx9necAHzAW9LskQ+rkx2/CI
 AAr6LQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi,

Like asked in :  
https://www.kernel.org/doc/html/latest/PCI/msi-howto.html#disabling-msis-globally


00:00.0 Host bridge: Silicon Integrated Systems [SiS] 671MX
     Subsystem: ASUSTeK Computer Inc. 671MX
     Flags: bus master, medium devsel, latency 64
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] PCI-to-PCI bridge  
(prog-if 00 [Normal decode])
     Subsystem: Silicon Integrated Systems [SiS] PCI-to-PCI bridge
     Flags: bus master, fast devsel, latency 0
     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
     I/O behind bridge: d000-dfff [size=4K] [16-bit]
     Memory behind bridge: fa000000-fdefffff [size=63M] [32-bit]
     Prefetchable memory behind bridge: d0000000-dfffffff [size=256M]  
[32-bit]
     Capabilities: <access denied>
     Kernel driver in use: pcieport
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS968 [MuTIOL  
Media IO] (rev 01)
     Flags: bus master, medium devsel, latency 0
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 IDE  
Controller (rev 01) (prog-if 80 [ISA Compatibility mode-only  
controller, supports bus mastering])
     Subsystem: ASUSTeK Computer Inc. 5513 IDE Controller
     Flags: bus master, medium devsel, latency 128
     I/O ports at 01f0 [size=8]
     I/O ports at 03f4
     I/O ports at 0170 [size=8]
     I/O ports at 0374
     I/O ports at fff0 [size=16]
     Capabilities: <access denied>
     Kernel driver in use: pata_sis
     Kernel modules: pata_sis, ata_generic
00:03.0 USB controller: Silicon Integrated Systems [SiS] USB 1.1  
Controller (rev 0f) (prog-if 10 [OHCI])
     Subsystem: ASUSTeK Computer Inc. USB 1.1 Controller
     Flags: bus master, medium devsel, latency 64, IRQ 20
     Memory at f9fff000 (32-bit, non-prefetchable) [size=4K]
     Kernel driver in use: ohci-pci
     Kernel modules: ohci_pci
00:03.1 USB controller: Silicon Integrated Systems [SiS] USB 1.1  
Controller (rev 0f) (prog-if 10 [OHCI])
     Subsystem: ASUSTeK Computer Inc. USB 1.1 Controller
     Flags: bus master, medium devsel, latency 64, IRQ 21
     Memory at f9ffe000 (32-bit, non-prefetchable) [size=4K]
     Kernel driver in use: ohci-pci
     Kernel modules: ohci_pci
00:03.3 USB controller: Silicon Integrated Systems [SiS] USB 2.0  
Controller (prog-if 20 [EHCI])
     Subsystem: ASUSTeK Computer Inc. USB 2.0 Controller
     Flags: bus master, medium devsel, latency 64, IRQ 22
     Memory at f9ffd000 (32-bit, non-prefetchable) [size=4K]
     Capabilities: <access denied>
     Kernel driver in use: ehci-pci
     Kernel modules: ehci_pci
00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] 191  
Gigabit Ethernet Adapter (rev 02)
     Subsystem: ASUSTeK Computer Inc. 191 Gigabit Ethernet Adapter
     Flags: bus master, medium devsel, latency 0, IRQ 19
     Memory at f9ffcc00 (32-bit, non-prefetchable) [size=128]
     I/O ports at cc00 [size=128]
     Capabilities: <access denied>
     Kernel driver in use: sis190
     Kernel modules: sis190
00:05.0 IDE interface: Silicon Integrated Systems [SiS] SATA Controller  
/ IDE mode (rev 03) (prog-if 8f [PCI native mode controller, supports  
both channels switched to ISA compatibility mode, supports bus  
mastering])
     Subsystem: ASUSTeK Computer Inc. SATA Controller / IDE mode
     Flags: bus master, medium devsel, latency 64, IRQ 17
     I/O ports at c800 [size=8]
     I/O ports at c400 [size=4]
     I/O ports at c000 [size=8]
     I/O ports at bc00 [size=4]
     I/O ports at b800 [size=16]
     I/O ports at b400 [size=128]
     Capabilities: <access denied>
     Kernel driver in use: sata_sis
     Kernel modules: sata_sis, ata_generic
00:06.0 PCI bridge: Silicon Integrated Systems [SiS] PCI-to-PCI bridge  
(prog-if 00 [Normal decode])
     Subsystem: Silicon Integrated Systems [SiS] PCI-to-PCI bridge
     Flags: bus master, fast devsel, latency 0
     Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
     I/O behind bridge: [disabled] [32-bit]
     Memory behind bridge: fdf00000-fdffffff [size=1M] [32-bit]
     Prefetchable memory behind bridge: [disabled] [64-bit]
     Capabilities: <access denied>
     Kernel driver in use: pcieport
00:07.0 PCI bridge: Silicon Integrated Systems [SiS] PCI-to-PCI bridge  
(prog-if 00 [Normal decode])
     Subsystem: Silicon Integrated Systems [SiS] PCI-to-PCI bridge
     Flags: bus master, fast devsel, latency 0
     Bus: primary=00, secondary=03, subordinate=06, sec-latency=0
     I/O behind bridge: e000-efff [size=4K] [16-bit]
     Memory behind bridge: fe000000-febfffff [size=12M] [32-bit]
     Prefetchable memory behind bridge: f6000000-f8ffffff [size=48M]  
[32-bit]
     Capabilities: <access denied>
     Kernel driver in use: pcieport
00:0d.0 FireWire (IEEE 1394): Ricoh Co Ltd R5C832 IEEE 1394 Controller  
(rev 05) (prog-if 10 [OHCI])
     Subsystem: ASUSTeK Computer Inc. R5C832 IEEE 1394 Controller
     Flags: bus master, medium devsel, latency 64, IRQ 16
     Memory at f9ffc000 (32-bit, non-prefetchable) [size=2K]
     Capabilities: <access denied>
     Kernel driver in use: firewire_ohci
     Kernel modules: firewire_ohci
00:0d.1 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro  
Host Adapter (rev 22)
     Subsystem: ASUSTeK Computer Inc. R5C822 SD/SDIO/MMC/MS/MSPro Host  
Adapter
     Flags: bus master, medium devsel, latency 64, IRQ 17
     Memory at f9ffc800 (32-bit, non-prefetchable) [size=256]
     Capabilities: <access denied>
     Kernel driver in use: sdhci-pci
     Kernel modules: sdhci_pci
00:0d.2 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host  
Adapter (rev 12)
     Subsystem: ASUSTeK Computer Inc. R5C592 Memory Stick Bus Host  
Adapter
     Flags: bus master, medium devsel, latency 64, IRQ 17
     Memory at f9ff7c00 (32-bit, non-prefetchable) [size=256]
     Capabilities: <access denied>
     Kernel driver in use: r592
     Kernel modules: r592
00:0d.3 System peripheral: Ricoh Co Ltd xD-Picture Card Controller (rev  
12)
     Subsystem: ASUSTeK Computer Inc. xD-Picture Card Controller
     Flags: bus master, medium devsel, latency 64, IRQ 17
     Memory at f9ff7800 (32-bit, non-prefetchable) [size=256]
     Capabilities: <access denied>
     Kernel driver in use: r852
     Kernel modules: r852
00:0f.0 Audio device: Silicon Integrated Systems [SiS] Azalia Audio  
Controller
     Subsystem: ASUSTeK Computer Inc. Azalia Audio Controller
     Flags: bus master, medium devsel, latency 0, IRQ 18
     Memory at f9ff0000 (32-bit, non-prefetchable) [size=16K]
     Capabilities: <access denied>
     Kernel driver in use: snd_hda_intel
     Kernel modules: snd_hda_intel
01:00.0 VGA compatible controller: NVIDIA Corporation G98M [GeForce  
9300M GS] (rev a1) (prog-if 00 [VGA controller])
     Subsystem: ASUSTeK Computer Inc. U6V laptop
     Flags: bus master, fast devsel, latency 0, IRQ 16
     Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
     Memory at d0000000 (64-bit, prefetchable) [size=256M]
     Memory at fa000000 (64-bit, non-prefetchable) [size=32M]
     I/O ports at dc00 [size=128]
     Expansion ROM at 000c0000 [disabled] [size=128K]
     Capabilities: <access denied>
     Kernel driver in use: nouveau
     Kernel modules: nouveau
02:00.0 Network controller: Qualcomm Atheros AR928X Wireless Network  
Adapter (PCI-Express) (rev 01)
     Subsystem: AzureWave AW-NE771 802.11bgn Wireless Mini PCIe Card  
[AR9281]
     Flags: bus master, fast devsel, latency 0, IRQ 16
     Memory at fdff0000 (64-bit, non-prefetchable) [size=64K]
     Capabilities: <access denied>
     Kernel driver in use: ath9k
     Kernel modules: ath9k


Thanks for all.
