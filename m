Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE2F33C6DB
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 20:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhCOTcl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 15:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231424AbhCOTcc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Mar 2021 15:32:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 288E064F2F;
        Mon, 15 Mar 2021 19:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615836752;
        bh=uqyDdydnzs/8XIlLVM4w1y/FE2XlDYk4nPR9aubsMg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=odBhi5YL4xHeJ0UUXyMavmrpuNyXphlLuyrKtFjInZGv7SYu6KtrmzT/EKe8CdJlC
         ZhkVSE/+3yS1kjordOAK+PT1JHtv6IdumUzIhqGhEQNG7rT5qPVY3MK94IvgtAdQbF
         7ayGnUnFo9hhHB87KZT95UCMIxYnlnJARuWt8eS9ZaDo9x1gfQ2MOk+wN3iDMVAlNW
         ewC5zlr2HmbA42UmiRE34QQbYHKPFqK/E3jXTWp59V1hOa3BynHe5TsyTZMEf44Wub
         X4KljuBp+vVPkukUwVF0iPeFw6bz79NGtibMA0xsgjuLOjKJnzfhUrNsgxfwhH3Rmv
         nqDGtCZv1EXrA==
Received: by pali.im (Postfix)
        id 8750082E; Mon, 15 Mar 2021 20:32:29 +0100 (CET)
Date:   Mon, 15 Mar 2021 20:32:29 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     =?utf-8?B?UsO2dHRp?= 
        <espressobinboardarmbiantempmailaddress@posteo.de>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Kernel panic caused by plugging in a sata cable on a a
 minipcie-sata board
Message-ID: <20210315193229.iwfytcuosxs4sgwg@pali>
References: <cbbb2496501fed013ccbeba524e8d573@posteo.de>
 <764d43dd2cce9159d6f8a920b0b32a97@posteo.de>
 <20210308095457.4v7dsfjl54tva4sp@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210308095457.4v7dsfjl54tva4sp@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Rötti!

Can you check if that your SATA controller is working fine when is
connected to any other machine, e.g. x86 laptop or desktop?

On Monday 08 March 2021 10:54:57 Pali Rohár wrote:
> Adding linux-pci ML to the loop.
> 
> Any idea where can be the issue? Problematic interrupt is triggered from
> the pci-aardvark.c driver. But I guess that issue can be in ahci code.
> 
> On Sunday 07 March 2021 13:38:03 Rötti wrote:
> > Hello everyone,
> > 
> > I'm sorry, I've been missing some information:
> > 
> > Here is the output of lspci -nn -vv to correctly identify type of your PCIe
> > SATA controller:
> > 
> > 00:00.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [1b4b:0100]
> > (prog-if 00 [Normal decode])
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> > Stepping- SERR- FastB2B- DisINTx-
> >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR- INTx-
> >         Latency: 0, Cache Line Size: 64 bytes
> >         Interrupt: pin A routed to IRQ 52
> >         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> >         I/O behind bridge: e9001000-e9001fff [size=4K]
> >         Memory behind bridge: e8000000-e80fffff [size=1M]
> >         Prefetchable memory behind bridge: [disabled]
> >         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> > <TAbort- <MAbort- <SERR- <PERR-
> >         Expansion ROM at e8100000 [virtual] [disabled] [size=2K]
> >         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
> >                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> >         Capabilities: [40] Express (v1) Root Port (Slot-), MSI 00
> >                 DevCap: MaxPayload 512 bytes, PhantFunc 0
> >                         ExtTag- RBE+
> >                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> >                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> >                         MaxPayload 512 bytes, MaxReadReq 512 bytes
> >                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
> > TransPend-
> >                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> > Latency L0s <128ns, L1 <2us
> >                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
> >                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
> >                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> >                 LnkSta: Speed 2.5GT/s (ok), Width x1 (ok)
> >                         TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
> >                 RootCap: CRSVisible-
> >                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
> > CRSVisible-
> >                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> >         Kernel driver in use: pcieport
> > 
> > 01:00.0 SATA controller [0106]: ASMedia Technology Inc. ASM1062 Serial ATA
> > Controller [1b21:0612] (rev 02) (prog-if 01 [AHCI 1.0])
> >         Subsystem: ASMedia Technology Inc. ASM1062 Serial ATA Controller
> > [1b21:1060]
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> > Stepping- SERR- FastB2B- DisINTx+
> >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR- INTx-
> >         Latency: 0
> >         Interrupt: pin A routed to IRQ 53
> >         Region 0: I/O ports at 1020 [size=8]
> >         Region 1: I/O ports at 1030 [size=4]
> >         Region 2: I/O ports at 1028 [size=8]
> >         Region 3: I/O ports at 1034 [size=4]
> >         Region 4: I/O ports at 1000 [size=32]
> >         Region 5: Memory at e8010000 (32-bit, non-prefetchable) [size=512]
> >         Expansion ROM at e8000000 [virtual] [disabled] [size=64K]
> >         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
> >                 Address: 7f044770  Data: 0035
> >         Capabilities: [78] Power Management version 3
> >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> >         Capabilities: [80] Express (v2) Legacy Endpoint, MSI 00
> >                 DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us,
> > L1 <8us
> >                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> >                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> >                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
> >                         MaxPayload 512 bytes, MaxReadReq 512 bytes
> >                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
> > TransPend-
> >                 LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM not supported
> >                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
> >                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
> >                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> >                 LnkSta: Speed 2.5GT/s (downgraded), Width x1 (ok)
> >                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> >                 DevCap2: Completion Timeout: Range ABC, TimeoutDis+,
> > NROPrPrP-, LTR-
> >                          10BitTagComp-, 10BitTagReq-, OBFF Not Supported,
> > ExtFmt-, EETLPPrefix-
> >                          EmergencyPowerReduction Not Supported,
> > EmergencyPowerReductionInit-
> >                          FRS-
> >                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> >                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,
> > LTR-, OBFF Disabled
> >                          AtomicOpsCtl: ReqEn-
> >                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance-
> > SpeedDis-
> >                          Transmit Margin: Normal Operating Range,
> > EnterModifiedCompliance- ComplianceSOS-
> >                          Compliance De-emphasis: -6dB
> >                 LnkSta2: Current De-emphasis Level: -3.5dB,
> > EqualizationComplete-, EqualizationPhase1-
> >                          EqualizationPhase2-, EqualizationPhase3-,
> > LinkEqualizationRequest-
> >         Capabilities: [100 v1] Virtual Channel
> >                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
> >                 Arb:    Fixed- WRR32- WRR64- WRR128-
> >                 Ctrl:   ArbSelect=Fixed
> >                 Status: InProgress-
> >                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> >                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128-
> > WRR256-
> >                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> >                         Status: NegoPending- InProgress-
> >         Kernel driver in use: ahci
> > 
> > 
> > Kind regards, Rötti!
> > 
> > Am 27.01.2021 22:27 schrieb Rötti:
> > > Hello everyone,
> > > 
> > > I own two ESPRESSOBin boards V5.
> > > 
> > > And to both I attached an XCSOURCE® MiniPCIe Sata3.0 AC696 extension
> > > card via MiniPCIe.
> > > 
> > > This is the link to amazon: https://www.amazon.de/dp/B06XRG2TGV
> > > 
> > > I tested several images from
> > > https://www.armbian.com/espressobin/#kernels-archive-all
> > > 
> > > Tested Kernels 8 weeks ago + the latest two this week:
> > > - 5.10.09-mvebu64  #21.02.0-hirsute (trunk) <-- works not
> > > - 5.08.18-mvebu64  #20.11.6-bionic <-- works not
> > > - 5.08.18-mvebu64  #20.11.3-focal <-- works not
> > > - 5.08.18-mvebu64  #20.11.3-bionic <-- works not
> > > - 5.08.06-mvebu64  #20.08.2-focal <-- works not
> > > - 4.14.135-mvebu64 #19.11.3-bionic <-- works
> > > 
> > > 
> > > Here is the whole UART-dump:
> > > 
> > > TIM-1.0
> > > WTMI-devel-18.12.0-a0a1cb8
> > > WTMI: system early-init
> > > SVC REV: 3, CPU VDD voltage: 1.155V
> > > NOTICE:  Booting Trusted Firmware
> > > NOTICE:  BL1: v1.5(release):1f8ca7e (Marvell-devel-18.12.2)
> > > NOTICE:  BL1: Built : 09:48:09, Feb 20 2019
> > > NOTICE:  BL1: Booting BL2
> > > NOTICE:  BL2: v1.5(release):1f8ca7e (Marvell-devel-18.12.2)
> > > NOTICE:  BL2: Built : 09:48:10, Feb 20 2019
> > > NOTICE:  BL1: Booting BL31
> > > NOTICE:  BL31: v1.5(release):1f8ca7e (Marvell-devel-18.12.2)
> > > NOTICE:  BL31: Built : 09:4
> > > 
> > > U-Boot 2018.03-devel-18.12.3-gc9aa92c-armbian (Feb 20 2019 - 09:45:04
> > > +0100)
> > > 
> > > Model: Marvell Armada 3720 Community Board ESPRESSOBin
> > >        CPU     1000 [MHz]
> > >        L2      800 [MHz]
> > >        TClock  200 [MHz]
> > >        DDR     800 [MHz]
> > > DRAM:  2 GiB
> > > Comphy chip #0:
> > > Comphy-0: USB3          5 Gbps
> > > Comphy-1: PEX0          2.5 Gbps
> > > Comphy-2: SATA0         6 Gbps
> > > Target spinup took 0 ms.
> > > AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
> > > flags: ncq led only pmp fbss pio slum part sxs
> > > PCIE-0: Link up
> > > MMC:   sdhci@d0000: 0, sdhci@d8000: 1
> > > Loading Environment from SPI Flash... SF: Detected w25q32dw with page
> > > size 256 Bytes, erase size 4 KiB, total 4 MiB
> > > OK
> > > Model: Marvell Armada 3720 Community Board ESPRESSOBin
> > > Net:   eth0: neta@30000 [PRIME]
> > > Hit any key to stop autoboot:  0
> > > starting USB...
> > > USB0:   Register 2000104 NbrPorts 2
> > > Starting the controller
> > > USB XHCI 1.00
> > > USB1:   USB EHCI 1.00
> > > scanning bus 0 for devices... 1 USB Device(s) found
> > > scanning bus 1 for devices... 1 USB Device(s) found
> > >        scanning usb for storage devices... 0 Storage Device(s) found
> > > 
> > > ## Loading init Ramdisk from Legacy Image at 01100000 ...
> > >    Image Name:   uInitrd
> > >    Image Type:   AArch64 Linux RAMDisk Image (gzip compressed)
> > >    Data Size:    10750023 Bytes = 10.3 MiB
> > >    Load Address: 00000000
> > >    Entry Point:  00000000
> > >    Verifying Checksum ... OK
> > > ## Flattened Device Tree blob at 06000000
> > >    Booting using the fdt blob at 0x6000000
> > >    Loading Ramdisk to 7ebea000, end 7f62a847 ... OK
> > >    Using Device Tree in place at 0000000006000000, end 00000000060059cd
> > > 
> > > Starting kernel ...
> > > 
> > > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
> > > [    0.000000] Linux version 5.8.18-mvebu64 (root@beast)
> > > (aarch64-linux-gnu-gcc (GNU Toolchain for the A-profile Architecture
> > > 8.3-2019.03 (arm-rel-8.36)) 8.3.0, GNU ld (GNU Toolchain for the
> > > A-profile Architecture 8.3-2019.03 (arm-rel-8.36)) 2.32.0.20190321)
> > > #20.11.3 SMP PREEMPT Fri Dec 11 21:10:52 CET 2020
> > > [    0.000000] Machine model: Globalscale Marvell ESPRESSOBin Board
> > > [    0.000000] earlycon: ar3700_uart0 at MMIO 0x00000000d0012000
> > > (options '')
> > > [    0.000000] printk: bootconsole [ar3700_uart0] enabled
> > > Loading, please wait...
> > > Starting version 245.4-4ubuntu3.3
> > > Begin: Loading essential drivers ... done.
> > > Begin: Running /scripts/init-premount ... done.
> > > Begin: Mounting root file system ... Begin: Running /scripts/local-top
> > > ... done.
> > > Begin: Running /scripts/local-premount ... Scanning for Btrfs
> > > filesystems
> > > done.
> > > Begin: Will now check root file system ... fsck from util-linux 2.34
> > > [/usr/sbin/fsck.ext4 (1) -- /dev/mmcblk0p1] fsck.ext4 -a -C0
> > > /dev/mmcblk0p1
> > > /dev/mmcblk0p1: clean, 41739/1828336 files, 439779/7502824 blocks
> > > done.
> > > done.
> > > Begin: Running /scripts/local-bottom ... done.
> > > Begin: Running /scripts/init-bottom ... done.
> > > [    3.694604] Internal error: synchronous external abort: 96000210
> > > [#1] PREEMPT SMP
> > > [    3.699465] Modules linked in: tag_edsa mv88e6xxx dsa_core bridge
> > > stp llc phy_mvebu_a3700_comphy
> > > [    3.708518] CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted
> > > 5.8.18-mvebu64 #20.11.3
> > > [    3.716037] Hardware name: Globalscale Marvell ESPRESSOBin Board (DT)
> > > [    3.722685] Workqueue: events free_work
> > > [    3.726614] pstate: 00000085 (nzcv daIf -PAN -UAO BTYPE=--)
> > > [    3.732352] pc : ahci_single_level_irq_intr+0x1c/0x90
> > > [    3.737549] lr : __handle_irq_event_percpu+0x5c/0x168
> > > [    3.742737] sp : ffffffc0113bbd10
> > > [    3.746142] x29: ffffffc0113bbd10 x28: ffffff807d48b700
> > > [    3.751608] x27: 0000000000000060 x26: ffffffc010f085e8
> > > [    3.757073] x25: ffffffc0113075a5 x24: ffffff8079101800
> > > [    3.762539] x23: 000000000000002d x22: ffffffc0113bbdd4
> > > [    3.768004] x21: 0000000000000000 x20: ffffffc011465008
> > > [    3.773470] x19: ffffff8079381600 x18: 0000000000000000
> > > [    3.778936] x17: 0000000000000000 x16: 0000000000000000
> > > [    3.784401] x15: 000000d2c010fc50 x14: 0000000000000323
> > > [    3.789867] x13: 00000000000002d4 x12: 0000000000000000
> > > [    3.795332] x11: 0000000000000040 x10: ffffffc011282dd8
> > > [    3.800798] x9 : ffffffc011282dd0 x8 : ffffff807d000270
> > > [    3.806263] x7 : 0000000000000000 x6 : 0000000000000000
> > > [    3.811729] x5 : ffffffc06ea93000 x4 : ffffffc0113bbe10
> > > [    3.817196] x3 : ffffffc06ea93000 x2 : ffffff8079101a80
> > > [    3.822661] x1 : ffffff8078803e00 x0 : 000000000000002d
> > > [    3.828126] Call trace:
> > > [    3.830642]  ahci_single_level_irq_intr+0x1c/0x90
> > > [    3.835478]  __handle_irq_event_percpu+0x5c/0x168
> > > [    3.840315]  handle_irq_event_percpu+0x38/0x90
> > > [    3.844885]  handle_irq_event+0x48/0xe0
> > > [    3.848828]  handle_simple_irq+0x94/0xd0
> > > [    3.852860]  generic_handle_irq+0x30/0x48
> > > [    3.856985]  advk_pcie_irq_handler+0x214/0x240
> > > [    3.861552]  __handle_irq_event_percpu+0x5c/0x168
> > > [    3.866389]  handle_irq_event_percpu+0x38/0x90
> > > [    3.870959]  handle_irq_event+0x48/0xe0
> > > [    3.874900]  handle_fasteoi_irq+0xb8/0x170
> > > [    3.879112]  generic_handle_irq+0x30/0x48
> > > [    3.883234]  __handle_domain_irq+0x64/0xc0
> > > [    3.887447]  gic_handle_irq+0xc8/0x168
> > > [    3.891298]  el1_irq+0xb8/0x180
> > > [    3.894524]  unmap_kernel_range_noflush+0x128/0x188
> > > [    3.899540]  remove_vm_area+0xac/0xd0
> > > [    3.903303]  __vunmap+0x48/0x298
> > > [    3.906618]  free_work+0x44/0x60
> > > [    3.909937]  process_one_work+0x1e8/0x360
> > > [    3.914057]  worker_thread+0x44/0x480
> > > [    3.917820]  kthread+0x154/0x158
> > > [    3.921135]  ret_from_fork+0x10/0x34
> > > [    3.924812] Code: a90153f3 f9401022 f9400854 91002294 (b9400293)
> > > [    3.931087] ---[ end trace 98b323414bb99c99 ]---
> > > [    3.935829] Kernel panic - not syncing: Fatal exception in interrupt
> > > [    3.942368] SMP: stopping secondary CPUs
> > > [    3.946403] Kernel Offset: disabled
> > > [    3.949985] CPU features: 0x240002,2000200c
> > > [    3.954283] Memory Limit: none
> > > [    3.957424] ---[ end Kernel panic - not syncing: Fatal exception in
> > > interrupt ]---
> > > 
> > > The boards boots up if I don't plug in any SATA HDDs into the extension
> > > card.
> > > 
> > > I hope this helps. If you need any other information just let me know,
> > > I'm absolutely willing to help. But I have no clue of kernel
> > > patching/compiling etc. Sorry!
> > > 
> > > Thank you very, very much in advance! You're doing an awesome job.
> > > 
> > > Sincerely Rötti
