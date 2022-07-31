Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F50258601E
	for <lists+linux-pci@lfdr.de>; Sun, 31 Jul 2022 19:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiGaRbw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 Jul 2022 13:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiGaRbv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 31 Jul 2022 13:31:51 -0400
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 31 Jul 2022 10:31:49 PDT
Received: from outgoing.selfhost.de (mordac.selfhost.de [82.98.82.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F687642B
        for <linux-pci@vger.kernel.org>; Sun, 31 Jul 2022 10:31:49 -0700 (PDT)
Received: (qmail 14361 invoked from network); 31 Jul 2022 17:25:07 -0000
Received: from unknown (HELO mailhost.afaics.de) (postmaster@xqrsonfo.mail.selfhost.de@62.158.103.127)
  by mailout.selfhost.de with ESMTPA; 31 Jul 2022 17:25:07 -0000
Received: from [10.42.100.14] (cecil.afaics.de [10.42.100.14])
        by marvin.afaics.de (OpenSMTPD) with ESMTP id 48dcd561;
        Sun, 31 Jul 2022 19:25:06 +0200 (CEST)
Message-ID: <4013c5d1-5b47-ae2f-1071-17a7b13a3dbe@afaics.de>
Date:   Sun, 31 Jul 2022 19:25:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Content-Language: en-US
From:   Harald Dunkel <harri@afaics.de>
To:     linux-pci@vger.kernel.org
Subject: problem on reboot: pcieport 0000:00:1c:0: pciehp: Slot(0): No link
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi folks,

setup:
	kernel 5.18.14 (built from git)
	Qnap TS-559 Pro II, 4*3.5 HDD + 1 SSD, /boot is on USB stick
	Intel(R) Atom(TM) CPU D525
	Debian Sid

On a reboot after some runtime my Qnap TS-559 Pro II shuts down cleanly, but
after the kernel and initrd are loaded again it writes an endless stream of
messages to the console

pcieport 0000:00:1c:0: pciehp: Slot(0): Card present
pcieport 0000:00:1c:0: pciehp: Slot(0): No link
pcieport 0000:00:1c:0: pciehp: Slot(0): Card present
pcieport 0000:00:1c:0: pciehp: Slot(0): No link
pcieport 0000:00:1c:0: pciehp: Slot(0): Card present
pcieport 0000:00:1c:0: pciehp: Slot(0): No link
pcieport 0000:00:1c:0: pciehp: Slot(0): Card present
pcieport 0000:00:1c:0: pciehp: Slot(0): No link
pcieport 0000:00:1c:0: pciehp: Slot(0): Card present
pcieport 0000:00:1c:0: pciehp: Slot(0): No link
pcieport 0000:00:1c:0: pciehp: Slot(0): Card present
pcieport 0000:00:1c:0: pciehp: Slot(0): No link

Appr. 2 lines per second. I get an emergency console to login, but it
is garbled.

If I wait a few minutes to let the qnap cool down it boots again.

# lspci
00:00.0 Host bridge: Intel Corporation Atom Processor D4xx/D5xx/N4xx/N5xx DMI Bridge (rev 02)
00:02.0 VGA compatible controller: Intel Corporation Atom Processor D4xx/D5xx/N4xx/N5xx Integrated Graphics Controller (rev 02)
00:02.1 Display controller: Intel Corporation Atom Processor D4xx/D5xx/N4xx/N5xx Integrated Graphics Controller (rev 02)
00:1a.0 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #4 (rev 02)
00:1a.1 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #5 (rev 02)
00:1a.2 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #6 (rev 02)
00:1a.7 USB controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI Controller #2 (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port 1 (rev 02)
00:1c.1 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port 2 (rev 02)
00:1c.2 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port 3 (rev 02)
00:1c.3 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port 4 (rev 02)
00:1c.4 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port 5 (rev 02)
00:1c.5 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port 6 (rev 02)
00:1d.0 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #1 (rev 02)
00:1d.1 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #2 (rev 02)
00:1d.2 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #3 (rev 02)
00:1d.7 USB controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI Controller #1 (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 92)
00:1f.0 ISA bridge: Intel Corporation 82801IR (ICH9R) LPC Interface Controller (rev 02)
00:1f.2 SATA controller: Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 6 port SATA Controller [AHCI mode] (rev 02)
00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (rev 02)
01:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9125 PCIe SATA 6.0 Gb/s controller (rev 11)
02:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9125 PCIe SATA 6.0 Gb/s controller (rev 11)
03:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9125 PCIe SATA 6.0 Gb/s controller (rev 11)
04:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
05:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
06:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host Controller (rev 03)

# lscpu
Architecture:           x86_64
      CPU op-mode(s):       32-bit, 64-bit
      Address sizes:        36 bits physical, 48 bits virtual
      Byte Order:           Little Endian
CPU(s):                 4
      On-line CPU(s) list:  0-3
Vendor ID:              GenuineIntel
      BIOS Vendor ID:       Intel
      Model name:           Intel(R) Atom(TM) CPU D525   @ 1.80GHz
        BIOS Model name:    Intel(R) Atom(TM) CPU D525   @ 1.80GHz               To Be Filled By O.E.M. CPU @ 1.8GHz
        BIOS CPU family:    43
        CPU family:         6
        Model:              28
        Thread(s) per core: 2
        Core(s) per socket: 2
        Socket(s):          1
        Stepping:           10
        BogoMIPS:           3591.07
        Flags:              fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm const
                            ant_tsc arch_perfmon pebs bts nopl cpuid aperfmperf pni dtes64 monitor ds_cpl tm2 ssse3 cx16 xtpr pdcm movbe lahf_lm dtherm
Caches (sum of all):
      L1d:                  48 KiB (2 instances)
      L1i:                  64 KiB (2 instances)
      L2:                   1 MiB (2 instances)
NUMA:
      NUMA node(s):         1
      NUMA node0 CPU(s):    0-3
Vulnerabilities:
      Itlb multihit:        Not affected
      L1tf:                 Not affected
      Mds:                  Not affected
      Meltdown:             Not affected
      Mmio stale data:      Not affected
      Retbleed:             Not affected
      Spec store bypass:    Not affected
      Spectre v1:           Not affected
      Spectre v2:           Not affected
      Srbds:                Not affected
      Tsx async abort:      Not affected


Every helpful hint is highly appreciated.

Harri
