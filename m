Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F165B33E17A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Mar 2021 23:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhCPWgJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Mar 2021 18:36:09 -0400
Received: from mout01.posteo.de ([185.67.36.65]:34237 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231338AbhCPWgD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Mar 2021 18:36:03 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id BE86616005F
        for <linux-pci@vger.kernel.org>; Tue, 16 Mar 2021 23:36:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1615934161; bh=shQL0Hh/faviduqVNW7sQ4TaD6AfD0EjE8+lKLteVpg=;
        h=Date:From:To:Cc:Subject:From;
        b=NpWwlzw4ost7+wb4/UvW36X/AbXuUIMd3qyqHytz+OdpvAKKSzv1ID612illXfg0j
         G6UX/o95vcMLIothVNKlYCytAdyMcTCwb4N887JehcQmVvONjOqjHX18Nw7mws0jQE
         zaTjM9jshnroZ04dOfyQhJhyh8eTIJQfBCMx6xzRrgkdOx2sqapNcYg/RmUuEhLhPd
         QrbumhNn0wWjWnXMthuF+RcX9JPufX6ftcD4DjxQQpdqjvwBLquNv9Nm1nLT+xjjKa
         9SfaqSUe9NKHRzpqjkLSJVFZz8ecypnv63KefvShZDLJpJasaurQCXOrVzfF4JQHGh
         KNRfOc88PH21A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4F0Smx1qhkz6tm8;
        Tue, 16 Mar 2021 23:36:01 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 16 Mar 2021 23:36:00 +0100
From:   =?UTF-8?Q?R=C3=B6tti?= 
        <espressobinboardarmbiantempmailaddress@posteo.de>
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Kernel panic caused by plugging in a sata cable on a a
 minipcie-sata board
In-Reply-To: <20210315193229.iwfytcuosxs4sgwg@pali>
References: <cbbb2496501fed013ccbeba524e8d573@posteo.de>
 <764d43dd2cce9159d6f8a920b0b32a97@posteo.de>
 <20210308095457.4v7dsfjl54tva4sp@pali>
 <20210315193229.iwfytcuosxs4sgwg@pali>
Message-ID: <131bcfe9750061bf57a6b769212446d7@posteo.de>
X-Sender: espressobinboardarmbiantempmailaddress@posteo.de
User-Agent: Posteo Webmail
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Pali,

I'll check that. That may take a few days because I'll have to organize=20
a x86 device capable of using this controller.
One thing I can say is, that old Kernels have been working in this=20
(ARM-based) setup.
But I'll report back!

Am 15.03.2021 20:32 schrieb Pali Roh=C3=A1r:
> Hello R=C3=B6tti!
>=20
> Can you check if that your SATA controller is working fine when is
> connected to any other machine, e.g. x86 laptop or desktop?
>=20
> On Monday 08 March 2021 10:54:57 Pali Roh=C3=A1r wrote:
>> Adding linux-pci ML to the loop.
>>=20
>> Any idea where can be the issue? Problematic interrupt is triggered=20
>> from
>> the pci-aardvark.c driver. But I guess that issue can be in ahci code.
>>=20
>> On Sunday 07 March 2021 13:38:03 R=C3=B6tti wrote:
>> > Hello everyone,
>> >
>> > I'm sorry, I've been missing some information:
>> >
>> > Here is the output of lspci -nn -vv to correctly identify type of your=
 PCIe
>> > SATA controller:
>> >
>> > 00:00.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [1b4b:=
0100]
>> > (prog-if 00 [Normal decode])
>> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Pa=
rErr-
>> > Stepping- SERR- FastB2B- DisINTx-
>> >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-
>> > <TAbort- <MAbort- >SERR- <PERR- INTx-
>> >         Latency: 0, Cache Line Size: 64 bytes
>> >         Interrupt: pin A routed to IRQ 52
>> >         Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-laten=
cy=3D0
>> >         I/O behind bridge: e9001000-e9001fff [size=3D4K]
>> >         Memory behind bridge: e8000000-e80fffff [size=3D1M]
>> >         Prefetchable memory behind bridge: [disabled]
>> >         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-
>> > <TAbort- <MAbort- <SERR- <PERR-
>> >         Expansion ROM at e8100000 [virtual] [disabled] [size=3D2K]
>> >         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- Fa=
stB2B-
>> >                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>> >         Capabilities: [40] Express (v1) Root Port (Slot-), MSI 00
>> >                 DevCap: MaxPayload 512 bytes, PhantFunc 0
>> >                         ExtTag- RBE+
>> >                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
>> >                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>> >                         MaxPayload 512 bytes, MaxReadReq 512 bytes
>> >                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxP=
wr-
>> > TransPend-
>> >                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,=
 Exit
>> > Latency L0s <128ns, L1 <2us
>> >                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptCom=
p+
>> >                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
>> >                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>> >                 LnkSta: Speed 2.5GT/s (ok), Width x1 (ok)
>> >                         TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMg=
mt-
>> >                 RootCap: CRSVisible-
>> >                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIn=
tEna+
>> > CRSVisible-
>> >                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>> >         Kernel driver in use: pcieport
>> >
>> > 01:00.0 SATA controller [0106]: ASMedia Technology Inc. ASM1062 Serial=
 ATA
>> > Controller [1b21:0612] (rev 02) (prog-if 01 [AHCI 1.0])
>> >         Subsystem: ASMedia Technology Inc. ASM1062 Serial ATA Controll=
er
>> > [1b21:1060]
>> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Pa=
rErr-
>> > Stepping- SERR- FastB2B- DisINTx+
>> >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-
>> > <TAbort- <MAbort- >SERR- <PERR- INTx-
>> >         Latency: 0
>> >         Interrupt: pin A routed to IRQ 53
>> >         Region 0: I/O ports at 1020 [size=3D8]
>> >         Region 1: I/O ports at 1030 [size=3D4]
>> >         Region 2: I/O ports at 1028 [size=3D8]
>> >         Region 3: I/O ports at 1034 [size=3D4]
>> >         Region 4: I/O ports at 1000 [size=3D32]
>> >         Region 5: Memory at e8010000 (32-bit, non-prefetchable) [size=
=3D512]
>> >         Expansion ROM at e8000000 [virtual] [disabled] [size=3D64K]
>> >         Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
>> >                 Address: 7f044770  Data: 0035
>> >         Capabilities: [78] Power Management version 3
>> >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
>> > PME(D0-,D1-,D2-,D3hot-,D3cold-)
>> >                 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 =
PME-
>> >         Capabilities: [80] Express (v2) Legacy Endpoint, MSI 00
>> >                 DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s=
 <1us,
>> > L1 <8us
>> >                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset=
-
>> >                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
>> >                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>> >                         MaxPayload 512 bytes, MaxReadReq 512 bytes
>> >                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxP=
wr-
>> > TransPend-
>> >                 LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM not suppo=
rted
>> >                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptCom=
p-
>> >                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
>> >                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>> >                 LnkSta: Speed 2.5GT/s (downgraded), Width x1 (ok)
>> >                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMg=
mt-
>> >                 DevCap2: Completion Timeout: Range ABC, TimeoutDis+,
>> > NROPrPrP-, LTR-
>> >                          10BitTagComp-, 10BitTagReq-, OBFF Not Support=
ed,
>> > ExtFmt-, EETLPPrefix-
>> >                          EmergencyPowerReduction Not Supported,
>> > EmergencyPowerReductionInit-
>> >                          FRS-
>> >                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>> >                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
,
>> > LTR-, OBFF Disabled
>> >                          AtomicOpsCtl: ReqEn-
>> >                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance-
>> > SpeedDis-
>> >                          Transmit Margin: Normal Operating Range,
>> > EnterModifiedCompliance- ComplianceSOS-
>> >                          Compliance De-emphasis: -6dB
>> >                 LnkSta2: Current De-emphasis Level: -3.5dB,
>> > EqualizationComplete-, EqualizationPhase1-
>> >                          EqualizationPhase2-, EqualizationPhase3-,
>> > LinkEqualizationRequest-
>> >         Capabilities: [100 v1] Virtual Channel
>> >                 Caps:   LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
>> >                 Arb:    Fixed- WRR32- WRR64- WRR128-
>> >                 Ctrl:   ArbSelect=3DFixed
>> >                 Status: InProgress-
>> >                 VC0:    Caps:   PATOffset=3D00 MaxTimeSlots=3D1 RejSno=
opTrans-
>> >                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128-
>> > WRR256-
>> >                         Ctrl:   Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=
=3Dff
>> >                         Status: NegoPending- InProgress-
>> >         Kernel driver in use: ahci
>> >
>> >
>> > Kind regards, R=C3=B6tti!
>> >
>> > Am 27.01.2021 22:27 schrieb R=C3=B6tti:
>> > > Hello everyone,
>> > >
>> > > I own two ESPRESSOBin boards V5.
>> > >
>> > > And to both I attached an XCSOURCE=C2=AE MiniPCIe Sata3.0 AC696 exte=
nsion
>> > > card via MiniPCIe.
>> > >
>> > > This is the link to amazon: https://www.amazon.de/dp/B06XRG2TGV
>> > >
>> > > I tested several images from
>> > > https://www.armbian.com/espressobin/#kernels-archive-all
>> > >
>> > > Tested Kernels 8 weeks ago + the latest two this week:
>> > > - 5.10.09-mvebu64  #21.02.0-hirsute (trunk) <-- works not
>> > > - 5.08.18-mvebu64  #20.11.6-bionic <-- works not
>> > > - 5.08.18-mvebu64  #20.11.3-focal <-- works not
>> > > - 5.08.18-mvebu64  #20.11.3-bionic <-- works not
>> > > - 5.08.06-mvebu64  #20.08.2-focal <-- works not
>> > > - 4.14.135-mvebu64 #19.11.3-bionic <-- works
>> > >
>> > >
>> > > Here is the whole UART-dump:
>> > >
>> > > TIM-1.0
>> > > WTMI-devel-18.12.0-a0a1cb8
>> > > WTMI: system early-init
>> > > SVC REV: 3, CPU VDD voltage: 1.155V
>> > > NOTICE:  Booting Trusted Firmware
>> > > NOTICE:  BL1: v1.5(release):1f8ca7e (Marvell-devel-18.12.2)
>> > > NOTICE:  BL1: Built : 09:48:09, Feb 20 2019
>> > > NOTICE:  BL1: Booting BL2
>> > > NOTICE:  BL2: v1.5(release):1f8ca7e (Marvell-devel-18.12.2)
>> > > NOTICE:  BL2: Built : 09:48:10, Feb 20 2019
>> > > NOTICE:  BL1: Booting BL31
>> > > NOTICE:  BL31: v1.5(release):1f8ca7e (Marvell-devel-18.12.2)
>> > > NOTICE:  BL31: Built : 09:4
>> > >
>> > > U-Boot 2018.03-devel-18.12.3-gc9aa92c-armbian (Feb 20 2019 - 09:45:0=
4
>> > > +0100)
>> > >
>> > > Model: Marvell Armada 3720 Community Board ESPRESSOBin
>> > >        CPU     1000 [MHz]
>> > >        L2      800 [MHz]
>> > >        TClock  200 [MHz]
>> > >        DDR     800 [MHz]
>> > > DRAM:  2 GiB
>> > > Comphy chip #0:
>> > > Comphy-0: USB3          5 Gbps
>> > > Comphy-1: PEX0          2.5 Gbps
>> > > Comphy-2: SATA0         6 Gbps
>> > > Target spinup took 0 ms.
>> > > AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
>> > > flags: ncq led only pmp fbss pio slum part sxs
>> > > PCIE-0: Link up
>> > > MMC:   sdhci@d0000: 0, sdhci@d8000: 1
>> > > Loading Environment from SPI Flash... SF: Detected w25q32dw with pag=
e
>> > > size 256 Bytes, erase size 4 KiB, total 4 MiB
>> > > OK
>> > > Model: Marvell Armada 3720 Community Board ESPRESSOBin
>> > > Net:   eth0: neta@30000 [PRIME]
>> > > Hit any key to stop autoboot:  0
>> > > starting USB...
>> > > USB0:   Register 2000104 NbrPorts 2
>> > > Starting the controller
>> > > USB XHCI 1.00
>> > > USB1:   USB EHCI 1.00
>> > > scanning bus 0 for devices... 1 USB Device(s) found
>> > > scanning bus 1 for devices... 1 USB Device(s) found
>> > >        scanning usb for storage devices... 0 Storage Device(s) found
>> > >
>> > > ## Loading init Ramdisk from Legacy Image at 01100000 ...
>> > >    Image Name:   uInitrd
>> > >    Image Type:   AArch64 Linux RAMDisk Image (gzip compressed)
>> > >    Data Size:    10750023 Bytes =3D 10.3 MiB
>> > >    Load Address: 00000000
>> > >    Entry Point:  00000000
>> > >    Verifying Checksum ... OK
>> > > ## Flattened Device Tree blob at 06000000
>> > >    Booting using the fdt blob at 0x6000000
>> > >    Loading Ramdisk to 7ebea000, end 7f62a847 ... OK
>> > >    Using Device Tree in place at 0000000006000000, end 0000000006005=
9cd
>> > >
>> > > Starting kernel ...
>> > >
>> > > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd03=
4]
>> > > [    0.000000] Linux version 5.8.18-mvebu64 (root@beast)
>> > > (aarch64-linux-gnu-gcc (GNU Toolchain for the A-profile Architecture
>> > > 8.3-2019.03 (arm-rel-8.36)) 8.3.0, GNU ld (GNU Toolchain for the
>> > > A-profile Architecture 8.3-2019.03 (arm-rel-8.36)) 2.32.0.20190321)
>> > > #20.11.3 SMP PREEMPT Fri Dec 11 21:10:52 CET 2020
>> > > [    0.000000] Machine model: Globalscale Marvell ESPRESSOBin Board
>> > > [    0.000000] earlycon: ar3700_uart0 at MMIO 0x00000000d0012000
>> > > (options '')
>> > > [    0.000000] printk: bootconsole [ar3700_uart0] enabled
>> > > Loading, please wait...
>> > > Starting version 245.4-4ubuntu3.3
>> > > Begin: Loading essential drivers ... done.
>> > > Begin: Running /scripts/init-premount ... done.
>> > > Begin: Mounting root file system ... Begin: Running /scripts/local-t=
op
>> > > ... done.
>> > > Begin: Running /scripts/local-premount ... Scanning for Btrfs
>> > > filesystems
>> > > done.
>> > > Begin: Will now check root file system ... fsck from util-linux 2.34
>> > > [/usr/sbin/fsck.ext4 (1) -- /dev/mmcblk0p1] fsck.ext4 -a -C0
>> > > /dev/mmcblk0p1
>> > > /dev/mmcblk0p1: clean, 41739/1828336 files, 439779/7502824 blocks
>> > > done.
>> > > done.
>> > > Begin: Running /scripts/local-bottom ... done.
>> > > Begin: Running /scripts/init-bottom ... done.
>> > > [    3.694604] Internal error: synchronous external abort: 96000210
>> > > [#1] PREEMPT SMP
>> > > [    3.699465] Modules linked in: tag_edsa mv88e6xxx dsa_core bridge
>> > > stp llc phy_mvebu_a3700_comphy
>> > > [    3.708518] CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted
>> > > 5.8.18-mvebu64 #20.11.3
>> > > [    3.716037] Hardware name: Globalscale Marvell ESPRESSOBin Board =
(DT)
>> > > [    3.722685] Workqueue: events free_work
>> > > [    3.726614] pstate: 00000085 (nzcv daIf -PAN -UAO BTYPE=3D--)
>> > > [    3.732352] pc : ahci_single_level_irq_intr+0x1c/0x90
>> > > [    3.737549] lr : __handle_irq_event_percpu+0x5c/0x168
>> > > [    3.742737] sp : ffffffc0113bbd10
>> > > [    3.746142] x29: ffffffc0113bbd10 x28: ffffff807d48b700
>> > > [    3.751608] x27: 0000000000000060 x26: ffffffc010f085e8
>> > > [    3.757073] x25: ffffffc0113075a5 x24: ffffff8079101800
>> > > [    3.762539] x23: 000000000000002d x22: ffffffc0113bbdd4
>> > > [    3.768004] x21: 0000000000000000 x20: ffffffc011465008
>> > > [    3.773470] x19: ffffff8079381600 x18: 0000000000000000
>> > > [    3.778936] x17: 0000000000000000 x16: 0000000000000000
>> > > [    3.784401] x15: 000000d2c010fc50 x14: 0000000000000323
>> > > [    3.789867] x13: 00000000000002d4 x12: 0000000000000000
>> > > [    3.795332] x11: 0000000000000040 x10: ffffffc011282dd8
>> > > [    3.800798] x9 : ffffffc011282dd0 x8 : ffffff807d000270
>> > > [    3.806263] x7 : 0000000000000000 x6 : 0000000000000000
>> > > [    3.811729] x5 : ffffffc06ea93000 x4 : ffffffc0113bbe10
>> > > [    3.817196] x3 : ffffffc06ea93000 x2 : ffffff8079101a80
>> > > [    3.822661] x1 : ffffff8078803e00 x0 : 000000000000002d
>> > > [    3.828126] Call trace:
>> > > [    3.830642]  ahci_single_level_irq_intr+0x1c/0x90
>> > > [    3.835478]  __handle_irq_event_percpu+0x5c/0x168
>> > > [    3.840315]  handle_irq_event_percpu+0x38/0x90
>> > > [    3.844885]  handle_irq_event+0x48/0xe0
>> > > [    3.848828]  handle_simple_irq+0x94/0xd0
>> > > [    3.852860]  generic_handle_irq+0x30/0x48
>> > > [    3.856985]  advk_pcie_irq_handler+0x214/0x240
>> > > [    3.861552]  __handle_irq_event_percpu+0x5c/0x168
>> > > [    3.866389]  handle_irq_event_percpu+0x38/0x90
>> > > [    3.870959]  handle_irq_event+0x48/0xe0
>> > > [    3.874900]  handle_fasteoi_irq+0xb8/0x170
>> > > [    3.879112]  generic_handle_irq+0x30/0x48
>> > > [    3.883234]  __handle_domain_irq+0x64/0xc0
>> > > [    3.887447]  gic_handle_irq+0xc8/0x168
>> > > [    3.891298]  el1_irq+0xb8/0x180
>> > > [    3.894524]  unmap_kernel_range_noflush+0x128/0x188
>> > > [    3.899540]  remove_vm_area+0xac/0xd0
>> > > [    3.903303]  __vunmap+0x48/0x298
>> > > [    3.906618]  free_work+0x44/0x60
>> > > [    3.909937]  process_one_work+0x1e8/0x360
>> > > [    3.914057]  worker_thread+0x44/0x480
>> > > [    3.917820]  kthread+0x154/0x158
>> > > [    3.921135]  ret_from_fork+0x10/0x34
>> > > [    3.924812] Code: a90153f3 f9401022 f9400854 91002294 (b9400293)
>> > > [    3.931087] ---[ end trace 98b323414bb99c99 ]---
>> > > [    3.935829] Kernel panic - not syncing: Fatal exception in interr=
upt
>> > > [    3.942368] SMP: stopping secondary CPUs
>> > > [    3.946403] Kernel Offset: disabled
>> > > [    3.949985] CPU features: 0x240002,2000200c
>> > > [    3.954283] Memory Limit: none
>> > > [    3.957424] ---[ end Kernel panic - not syncing: Fatal exception =
in
>> > > interrupt ]---
>> > >
>> > > The boards boots up if I don't plug in any SATA HDDs into the extens=
ion
>> > > card.
>> > >
>> > > I hope this helps. If you need any other information just let me kno=
w,
>> > > I'm absolutely willing to help. But I have no clue of kernel
>> > > patching/compiling etc. Sorry!
>> > >
>> > > Thank you very, very much in advance! You're doing an awesome job.
>> > >
>> > > Sincerely R=C3=B6tti
