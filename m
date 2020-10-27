Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8FF29C103
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 18:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1811620AbgJ0RUs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 13:20:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1818458AbgJ0RUM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 13:20:12 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FC1120657;
        Tue, 27 Oct 2020 17:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603819208;
        bh=KPGvRmDQFrloy0JrwhhPC3zypSCgFFqkP9bCpnt8Cno=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=arUwdyaw5Zgg08kOexxrzi+IiTt//+J7fMjctnEpDBFGdFUuy66wcJuVMjv9j7u7/
         3DAE/o60DWM9bVQ2SxM0StxqxZwBXcc9m8Egfwur+6bTN9RuNs/0YZJI0lMb5VOXBq
         O/frqlZrpqlpgAr+rb7Qz17O+r0atEuoC6OmTlnI=
Date:   Tue, 27 Oct 2020 12:20:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        vtolkm@googlemail.com
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <20201027172006.GA186901@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87imavwu7b.fsf@toke.dk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc vtolkm]

On Tue, Oct 27, 2020 at 04:43:20PM +0100, Toke Høiland-Jørgensen wrote:
> Hi everyone
> 
> I'm trying to get a mainline kernel to run on my Turris Omnia, and am
> having some trouble getting the PCI bus to work correctly. Specifically,
> I'm running a 5.10-rc1 kernel (torvalds/master as of this moment), with
> the resource request fix[0] applied on top.
> 
> The kernel boots fine, and the patch in [0] makes the PCI devices show
> up. But I'm still getting initialisation errors like these:
> 
> [    1.632709] pci 0000:01:00.0: BAR 0: error updating (0xe0000004 != 0xffffffff)
> [    1.632714] pci 0000:01:00.0: BAR 0: error updating (high 0x000000 != 0xffffffff)
> [    1.632745] pci 0000:02:00.0: BAR 0: error updating (0xe0200004 != 0xffffffff)
> [    1.632750] pci 0000:02:00.0: BAR 0: error updating (high 0x000000 != 0xffffffff)
> 
> and the WiFi drivers fail to initialise with what appears to me to be
> errors related to the bus rather than to the drivers themselves:
> 
> [    3.509878] ath: phy0: Mac Chip Rev 0xfffc0.f is not supported by this driver
> [    3.517049] ath: phy0: Unable to initialize hardware; initialization status: -95
> [    3.524473] ath9k 0000:01:00.0: Failed to initialize device
> [    3.530081] ath9k: probe of 0000:01:00.0 failed with error -95
> [    3.536012] ath10k_pci 0000:02:00.0: of_irq_parse_pci: failed with rc=134
> [    3.543049] pci 0000:00:02.0: enabling device (0140 -> 0142)
> [    3.548735] ath10k_pci 0000:02:00.0: can't change power state from D3hot to D0 (config space inaccessible)
> [    3.588592] ath10k_pci 0000:02:00.0: failed to wake up device : -110
> [    3.595098] ath10k_pci: probe of 0000:02:00.0 failed with error -110
> 
> lspci looks OK, though:
> 
> # lspci
> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
> 00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
> 01:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Network Adapter (PCI-Express) (rev 01)
> 02:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac Wireless Network Adapter (rev ff)
> 
> Does anyone have any clue what could be going on here? Is this a bug, or
> did I miss something in my config or other initialisation? I've tried
> with both the stock u-boot distributed with the board, and with an
> upstream u-boot from latest master; doesn't seem to make any different.

Can you try turning off CONFIG_PCIEASPM?  We had a similar recent
report at https://bugzilla.kernel.org/show_bug.cgi?id=209833 but I
don't think we have a fix yet.

> [0] https://lore.kernel.org/linux-pci/20201023145252.2691779-1-robh@kernel.org/
> 
> Full dmesg:
> 
> [    1.546457] pci 0000:00:02.0: [11ab:6820] type 01 class 0x060400
> [    1.546469] pci 0000:00:02.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
> [    1.546615] pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400
> [    1.546627] pci 0000:00:03.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
> [    1.547341] PCI: bus0: Fast back to back transfers disabled
> [    1.547349] pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [    1.547356] pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [    1.547363] pci 0000:00:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [    1.547444] pci 0000:01:00.0: [168c:002e] type 00 class 0x028000
> [    1.547466] pci 0000:01:00.0: reg 0x10: [mem 0xe8000000-0xe800ffff 64bit]
> [    1.547576] pci 0000:01:00.0: supports D1
> [    1.547581] pci 0000:01:00.0: PME# supported from D0 D1 D3hot
> [    1.547692] pci 0000:00:01.0: ASPM: current common clock configuration is inconsistent, reconfiguring
> [    1.601932] PCI: bus1: Fast back to back transfers enabled
> [    1.601941] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> [    1.602039] pci 0000:02:00.0: [168c:003c] type 00 class 0x028000
> [    1.602063] pci 0000:02:00.0: reg 0x10: [mem 0xea000000-0xea1fffff 64bit]
> [    1.602096] pci 0000:02:00.0: reg 0x30: [mem 0xea200000-0xea20ffff pref]
> [    1.602174] pci 0000:02:00.0: supports D1 D2
> [    1.602273] pci 0000:00:02.0: ASPM: current common clock configuration is inconsistent, reconfiguring
> [    1.631918] PCI: bus2: Fast back to back transfers enabled
> [    1.631926] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
> [    1.632623] PCI: bus3: Fast back to back transfers enabled
> [    1.632630] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
> [    1.632663] pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xe00fffff]
> [    1.632671] pci 0000:00:02.0: BAR 8: assigned [mem 0xe0200000-0xe04fffff]
> [    1.632679] pci 0000:00:01.0: BAR 6: assigned [mem 0xe0100000-0xe01007ff pref]
> [    1.632687] pci 0000:00:02.0: BAR 6: assigned [mem 0xe0500000-0xe05007ff pref]
> [    1.632694] pci 0000:00:03.0: BAR 6: assigned [mem 0xe0600000-0xe06007ff pref]
> [    1.632701] pci 0000:01:00.0: BAR 0: assigned [mem 0xe0000000-0xe000ffff 64bit]
> [    1.632709] pci 0000:01:00.0: BAR 0: error updating (0xe0000004 != 0xffffffff)
> [    1.632714] pci 0000:01:00.0: BAR 0: error updating (high 0x000000 != 0xffffffff)
> [    1.632720] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    1.632728] pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe00fffff]
> [    1.632737] pci 0000:02:00.0: BAR 0: assigned [mem 0xe0200000-0xe03fffff 64bit]
> [    1.632745] pci 0000:02:00.0: BAR 0: error updating (0xe0200004 != 0xffffffff)
> [    1.632750] pci 0000:02:00.0: BAR 0: error updating (high 0x000000 != 0xffffffff)
> [    1.632757] pci 0000:02:00.0: BAR 6: assigned [mem 0xe0400000-0xe040ffff pref]
> [    1.632762] pci 0000:00:02.0: PCI bridge to [bus 02]
> [    1.632768] pci 0000:00:02.0:   bridge window [mem 0xe0200000-0xe04fffff]
> [    1.632774] pci 0000:00:03.0: PCI bridge to [bus 03]
> [    1.633030] mv_xor f1060800.xor: Marvell shared XOR driver
> [    1.691640] mv_xor f1060800.xor: Marvell XOR (Descriptor Mode): ( xor cpy intr )
> [    1.691756] mv_xor f1060900.xor: Marvell shared XOR driver
> [    1.751635] mv_xor f1060900.xor: Marvell XOR (Descriptor Mode): ( xor cpy intr )
> [    1.769386] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [    1.770240] printk: console [ttyS0] disabled
> [    1.790351] f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 30, base_baud = 15625000) is a 16550A
> [    3.040783] printk: console [ttyS0] enabled
> [    3.065621] f1012100.serial: ttyS1 at MMIO 0xf1012100 (irq = 31, base_baud = 15625000) is a 16550A
> [    3.075329] ahci-mvebu f10a8000.sata: supply ahci not found, using dummy regulator
> [    3.082990] ahci-mvebu f10a8000.sata: supply phy not found, using dummy regulator
> [    3.090499] ahci-mvebu f10a8000.sata: supply target not found, using dummy regulator
> [    3.098335] ahci-mvebu f10a8000.sata: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl platform mode
> [    3.107411] ahci-mvebu f10a8000.sata: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
> [    3.116657] scsi host0: ahci-mvebu
> [    3.120302] scsi host1: ahci-mvebu
> [    3.123825] ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] port 0x100 irq 53
> [    3.131768] ata2: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] port 0x180 irq 53
> [    3.140560] spi-nor spi0.0: s25fl164k (8192 Kbytes)
> [    3.145494] 2 fixed-partitions partitions found on MTD device spi0.0
> [    3.151868] Creating 2 MTD partitions on "spi0.0":
> [    3.156671] 0x000000000000-0x000000100000 : "U-Boot"
> [    3.171461] 0x000000100000-0x000000800000 : "Rescue system"
> [    3.191747] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for information.
> [    3.199597] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> [    3.209859] libphy: Fixed MDIO Bus: probed
> [    3.214141] tun: Universal TUN/TAP device driver, 1.6
> [    3.219584] libphy: orion_mdio_bus: probed
> [    3.224542] mv88e6085 f1072004.mdio-mii:10: switch 0x1760 detected: Marvell 88E6176, revision 1
> [    3.450274] libphy: mv88e6xxx SMI: probed
> [    3.461815] mvneta f1070000.ethernet eth0: Using hardware mac address d8:58:d7:00:4e:98
> [    3.470606] mvneta f1030000.ethernet eth1: Using hardware mac address d8:58:d7:00:4e:96
> [    3.479356] mvneta f1034000.ethernet eth2: Using hardware mac address d8:58:d7:00:4e:97
> [    3.482630] ata1: SATA link down (SStatus 0 SControl 300)
> [    3.487588] pci 0000:00:01.0: enabling device (0140 -> 0142)
> [    3.492831] ata2: SATA link down (SStatus 0 SControl 300)
> [    3.498496] ath9k 0000:01:00.0: enabling device (0000 -> 0002)
> [    3.509878] ath: phy0: Mac Chip Rev 0xfffc0.f is not supported by this driver
> [    3.517049] ath: phy0: Unable to initialize hardware; initialization status: -95
> [    3.524473] ath9k 0000:01:00.0: Failed to initialize device
> [    3.530081] ath9k: probe of 0000:01:00.0 failed with error -95
> [    3.536012] ath10k_pci 0000:02:00.0: of_irq_parse_pci: failed with rc=134
> [    3.543049] pci 0000:00:02.0: enabling device (0140 -> 0142)
> [    3.548735] ath10k_pci 0000:02:00.0: can't change power state from D3hot to D0 (config space inaccessible)
> [    3.588592] ath10k_pci 0000:02:00.0: failed to wake up device : -110
> [    3.595098] ath10k_pci: probe of 0000:02:00.0 failed with error -110
> [    3.601529] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    3.608072] ehci-pci: EHCI PCI platform driver
> [    3.612553] ehci-orion: EHCI orion driver
> [    3.616675] orion-ehci f1058000.usb: EHCI Host Controller
> [    3.622105] orion-ehci f1058000.usb: new USB bus registered, assigned bus number 1
> [    3.629733] orion-ehci f1058000.usb: irq 49, io mem 0xf1058000
> [    3.661261] orion-ehci f1058000.usb: USB 2.0 started, EHCI 1.00
> [    3.667530] hub 1-0:1.0: USB hub found
> [    3.671321] hub 1-0:1.0: 1 port detected
> [    3.675700] xhci-hcd f10f0000.usb3: xHCI Host Controller
> [    3.681034] xhci-hcd f10f0000.usb3: new USB bus registered, assigned bus number 2
> [    3.688599] xhci-hcd f10f0000.usb3: hcc params 0x0a000990 hci version 0x100 quirks 0x0000000000010010
> [    3.697867] xhci-hcd f10f0000.usb3: irq 55, io mem 0xf10f0000
> [    3.703905] hub 2-0:1.0: USB hub found
> [    3.707678] hub 2-0:1.0: 1 port detected
> [    3.711767] xhci-hcd f10f0000.usb3: xHCI Host Controller
> [    3.717096] xhci-hcd f10f0000.usb3: new USB bus registered, assigned bus number 3
> [    3.724621] xhci-hcd f10f0000.usb3: Host supports USB 3.0 SuperSpeed
> [    3.731026] usb usb3: We don't know the algorithms for LPM for this host, disabling LPM.
> [    3.739388] hub 3-0:1.0: USB hub found
> [    3.743167] hub 3-0:1.0: 1 port detected
> [    3.747339] xhci-hcd f10f8000.usb3: xHCI Host Controller
> [    3.752684] xhci-hcd f10f8000.usb3: new USB bus registered, assigned bus number 4
> [    3.760230] xhci-hcd f10f8000.usb3: hcc params 0x0a000990 hci version 0x100 quirks 0x0000000000010010
> [    3.769502] xhci-hcd f10f8000.usb3: irq 56, io mem 0xf10f8000
> [    3.775527] hub 4-0:1.0: USB hub found
> [    3.779298] hub 4-0:1.0: 1 port detected
> [    3.783756] xhci-hcd f10f8000.usb3: xHCI Host Controller
> [    3.789086] xhci-hcd f10f8000.usb3: new USB bus registered, assigned bus number 5
> [    3.796610] xhci-hcd f10f8000.usb3: Host supports USB 3.0 SuperSpeed
> [    3.803012] usb usb5: We don't know the algorithms for LPM for this host, disabling LPM.
> [    3.811375] hub 5-0:1.0: USB hub found
> [    3.815147] hub 5-0:1.0: 1 port detected
> [    3.819312] usbcore: registered new interface driver usb-storage
> [    3.826044] armada38x-rtc f10a3800.rtc: registered as rtc0
> [    3.831632] armada38x-rtc f10a3800.rtc: setting system clock to 2020-10-27T15:31:52 UTC (1603812712)
> [    3.840905] i2c /dev entries driver
> [    3.846565] orion_wdt: Initial timeout 171 sec
> [    3.851350] sdhci: Secure Digital Host Controller Interface driver
> [    3.857544] sdhci: Copyright(c) Pierre Ossman
> [    3.862041] sdhci-pltfm: SDHCI platform and OF driver helper
> [    3.868792] marvell-cesa f1090000.crypto: CESA device successfully registered
> [    3.876106] usbcore: registered new interface driver usbhid
> [    3.881715] usbhid: USB HID core driver
> [    3.885678] GACT probability on
> [    3.888837] Mirror/redirect action on
> [    3.892589] Simple TC action Loaded
> [    3.893793] mmc0: SDHCI controller on f10d8000.sdhci [f10d8000.sdhci] using ADMA
> [    3.896117] u32 classifier
> [    3.906258]     Performance counters on
> [    3.910113]     input device check on
> [    3.913812]     Actions configured
> [    3.917606] NET: Registered protocol family 10
> [    3.922867] Segment Routing with IPv6
> [    3.926605] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> [    3.932956] NET: Registered protocol family 17
> [    3.937500] 8021q: 802.1Q VLAN Support v1.8
> [    3.941850] ThumbEE CPU extension supported.
> [    3.946133] Registering SWP/SWPB emulation handler
> [    3.951024] Loading compiled-in X.509 certificates
> [    3.956916] Btrfs loaded, crc32c=crc32c-generic
> [    3.961872] mv88e6085 f1072004.mdio-mii:10: switch 0x1760 detected: Marvell 88E6176, revision 1
> [    4.027817] mmc0: new high speed MMC card at address 0001
> [    4.033650] mmcblk0: mmc0:0001 H8G4a\x92 7.28 GiB 
> [    4.038323] mmcblk0boot0: mmc0:0001 H8G4a\x92 partition 1 4.00 MiB
> [    4.044421] mmcblk0boot1: mmc0:0001 H8G4a\x92 partition 2 4.00 MiB
> [    4.050457] mmcblk0rpmb: mmc0:0001 H8G4a\x92 partition 3 4.00 MiB, chardev (250:0)
> [    4.059708]  mmcblk0: p1
> [    4.081276] usb 2-1: new high-speed USB device number 2 using xhci-hcd
> [    4.169488] libphy: mv88e6xxx SMI: probed
> [    4.261911] usb-storage 2-1:1.0: USB Mass Storage device detected
> [    4.268229] scsi host2: usb-storage 2-1:1.0
> [    4.816096] mv88e6085 f1072004.mdio-mii:10 lan0 (uninitialized): PHY [mv88e6xxx-1:00] driver [Marvell 88E1540] (irq=70)
> [    4.842702] mv88e6085 f1072004.mdio-mii:10 lan1 (uninitialized): PHY [mv88e6xxx-1:01] driver [Marvell 88E1540] (irq=71)
> [    4.869246] mv88e6085 f1072004.mdio-mii:10 lan2 (uninitialized): PHY [mv88e6xxx-1:02] driver [Marvell 88E1540] (irq=72)
> [    4.895772] mv88e6085 f1072004.mdio-mii:10 lan3 (uninitialized): PHY [mv88e6xxx-1:03] driver [Marvell 88E1540] (irq=73)
> [    4.920733] mv88e6085 f1072004.mdio-mii:10 lan4 (uninitialized): PHY [mv88e6xxx-1:04] driver [Marvell 88E1540] (irq=74)
> [    4.939701] mv88e6085 f1072004.mdio-mii:10: configuring for fixed/rgmii-id link mode
> [    4.950089] mv88e6085 f1072004.mdio-mii:10: Link is Up - 1Gbps/Full - flow control off
> [    4.958047] DSA: tree 0 setup
> [    4.961339] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [    4.970623] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [    4.977231] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
> [    4.985879] cfg80211: failed to load regulatory.db
> [    4.990987] Waiting 2 sec before mounting root device...
> [    5.351539] scsi 2:0:0:0: Direct-Access     General  UDisk            5.00 PQ: 0 ANSI: 2
> [    5.360060] sd 2:0:0:0: [sda] 7987200 512-byte logical blocks: (4.09 GB/3.81 GiB)
> [    5.367691] sd 2:0:0:0: [sda] Write Protect is off
> [    5.372503] sd 2:0:0:0: [sda] Mode Sense: 0b 00 00 08
> [    5.372605] sd 2:0:0:0: [sda] No Caching mode page found
> [    5.377931] sd 2:0:0:0: [sda] Assuming drive cache: write through
> [    5.435076]  sda: sda1
> [    5.438130] sd 2:0:0:0: [sda] Attached SCSI removable disk
> [    7.047873] BTRFS: device fsid 448334b8-1b27-4738-8118-9e70b56b1e58 devid 1 transid 680 /dev/root scanned by swapper/0 (1)
> [    7.059562] BTRFS info (device mmcblk0p1): disk space caching is enabled
> [    7.066294] BTRFS info (device mmcblk0p1): has skinny extents
> [    7.078585] BTRFS info (device mmcblk0p1): enabling ssd optimizations
> [    7.087624] VFS: Mounted root (btrfs filesystem) on device 0:12.
> [    7.094044] devtmpfs: mounted
> [    7.097581] Freeing unused kernel memory: 1024K
> [    7.131431] Run /sbin/init as init process
> [    7.135536]   with arguments:
> [    7.135539]     /sbin/init
> [    7.135541]     earlyprintk
> [    7.135543]   with environment:
> [    7.135545]     HOME=/
> [    7.135548]     TERM=linux
> [    7.220335] random: fast init done
> [    7.650974] systemd[1]: systemd 246.6-1.1-arch running in system mode. (+PAM +AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
> [    7.674141] systemd[1]: Detected architecture arm.
> [    7.752534] systemd[1]: Set hostname to <omnia-arch>.
> [    7.938493] systemd[164]: /usr/lib/systemd/system-generators/systemd-gpt-auto-generator failed with exit status 1.
> [    8.148416] systemd[1]: Queued start job for default target Graphical Interface.
> [    8.156570] random: systemd: uninitialized urandom read (16 bytes read)
> [    8.164923] systemd[1]: Created slice system-getty.slice.
> [    8.201373] random: systemd: uninitialized urandom read (16 bytes read)
> [    8.208682] systemd[1]: Created slice system-modprobe.slice.
> [    8.241347] random: systemd: uninitialized urandom read (16 bytes read)
> [    8.248610] systemd[1]: Created slice system-serial\x2dgetty.slice.
> [    8.281970] systemd[1]: Created slice User and Session Slice.
> [    8.321507] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
> [    8.371436] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
> [    8.421373] systemd[1]: Condition check resulted in Arbitrary Executable File Formats File System Automount Point being skipped.
> [    8.433099] systemd[1]: Reached target Local Encrypted Volumes.
> [    8.481453] systemd[1]: Reached target Paths.
> [    8.521358] systemd[1]: Reached target Remote File Systems.
> [    8.571330] systemd[1]: Reached target Slices.
> [    8.611374] systemd[1]: Reached target Swap.
> [    8.641568] systemd[1]: Listening on Device-mapper event daemon FIFOs.
> [    8.693521] systemd[1]: Listening on Process Core Dump Socket.
> [    8.745061] systemd[1]: Condition check resulted in Journal Audit Socket being skipped.
> [    8.759882] systemd[1]: Listening on Journal Socket (/dev/log).
> [    8.801664] systemd[1]: Listening on Journal Socket.
> [    8.848051] systemd[1]: Listening on Network Service Netlink Socket.
> [    8.892567] systemd[1]: Listening on udev Control Socket.
> [    8.941553] systemd[1]: Listening on udev Kernel Socket.
> [    8.981628] systemd[1]: Condition check resulted in Huge Pages File System being skipped.
> [    8.990034] systemd[1]: Condition check resulted in POSIX Message Queue File System being skipped.
> [    8.999279] systemd[1]: Condition check resulted in Kernel Debug File System being skipped.
> [    9.010575] systemd[1]: Mounting Kernel Trace File System...
> [    9.043918] systemd[1]: Mounting Temporary Directory (/tmp)...
> [    9.081515] systemd[1]: Condition check resulted in Create list of static device nodes for the current kernel being skipped.
> [    9.095686] systemd[1]: Starting Load Kernel Module drm...
> [    9.138063] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
> [    9.148885] systemd[1]: Condition check resulted in Load Kernel Modules being skipped.
> [    9.157149] systemd[1]: Condition check resulted in FUSE Control File System being skipped.
> [    9.165757] systemd[1]: Condition check resulted in Kernel Configuration File System being skipped.
> [    9.177585] systemd[1]: Starting Remount Root and Kernel File Systems...
> [    9.211505] systemd[1]: Condition check resulted in Repartition Root Disk being skipped.
> [    9.222607] systemd[1]: Starting Apply Kernel Variables...
> [    9.264359] systemd[1]: Starting Coldplug All udev Devices...
> [    9.305343] systemd[1]: Mounted Kernel Trace File System.
> [    9.352014] systemd[1]: Mounted Temporary Directory (/tmp).
> [    9.391997] systemd[1]: modprobe@drm.service: Succeeded.
> [    9.398342] systemd[1]: Finished Load Kernel Module drm.
> [    9.436436] systemd[1]: Finished Remount Root and Kernel File Systems.
> [    9.472894] systemd[1]: Finished Apply Kernel Variables.
> [    9.514310] systemd[1]: Condition check resulted in First Boot Wizard being skipped.
> [    9.529349] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
> [    9.540514] systemd[1]: Starting Load/Save Random Seed...
> [    9.561757] systemd[1]: Condition check resulted in Create System Users being skipped.
> [    9.578340] systemd[1]: Starting Create Static Device Nodes in /dev...
> [    9.639784] systemd[1]: Finished Create Static Device Nodes in /dev.
> [    9.692025] systemd[1]: Reached target Local File Systems (Pre).
> [    9.741485] systemd[1]: Condition check resulted in Virtual Machine and Container Storage (Compatibility) being skipped.
> [    9.752637] systemd[1]: Reached target Local File Systems.
> [    9.794672] systemd[1]: Started Entropy Daemon based on the HAVEGE algorithm.
> [    9.831672] systemd[1]: Condition check resulted in Rebuild Dynamic Linker Cache being skipped.
> [    9.844130] systemd[1]: Starting Journal Service...
> [    9.861510] systemd[1]: Condition check resulted in Commit a transient machine-id on disk being skipped.
> [    9.885260] systemd[1]: Starting Rule-based Manager for Device Events and Files...
> [    9.932999] systemd[1]: Finished Coldplug All udev Devices.
> [   10.175983] systemd[1]: Started Journal Service.
> [   11.579842] mvneta f1070000.ethernet eth0: configuring for fixed/rgmii link mode
> [   11.607754] mvneta f1070000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> [   11.787479] mvneta f1034000.ethernet eth2: PHY [f1072004.mdio-mii:01] driver [Marvell 88E1510] (irq=POLL)
> [   11.817734] mvneta f1034000.ethernet eth2: configuring for phy/sgmii link mode
> [   12.102369] BTRFS info (device mmcblk0p1): devid 1 device path /dev/root changed to /dev/mmcblk0p1 scanned by systemd-udevd (194)
> [   13.131291] random: crng init done
> [   13.134710] random: 7 urandom warning(s) missed due to ratelimiting
> [   14.961639] mvneta f1034000.ethernet eth2: Link is Up - 1Gbps/Full - flow control rx/tx
> [   14.969684] IPv6: ADDRCONF(NETDEV_CHANGE): eth2: link becomes ready
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
