Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C77BE776A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 18:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404083AbfJ1RNe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 13:13:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbfJ1RNd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Oct 2019 13:13:33 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE0EC21721;
        Mon, 28 Oct 2019 17:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572282812;
        bh=W/6r8bZv/SOT/EUcs/Mfc1HA5HT8HWW/XhQsqiUGbiY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NoUyehFqslScnj6qU02WmQNdANdT8QLtEVaISc0jsYz8WTmb5ld9xAyH4iGt2GfpK
         cVPuYf0MIB87Vrn5EOOsSgBNT+1GMjsWzYIY14grgJ+0eddIM7kPrC4iBqHeiuC+AA
         GlhaVnrjbBgVE8vwXcmj6pJtJYJ2nwlb9d2gCjwk=
Date:   Mon, 28 Oct 2019 12:13:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Carlo Pisani <carlojpisani@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: Oxford Semiconductor Ltd OX16PCI954 - weird dmesg
Message-ID: <20191028171329.GA104845@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+QBN9C_o8HanAzXpDUN410g2o5+xfx64pbX3_VHVDKcj5N3kA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci -- please "reply-all" so the discussion stays on the
mailing list so everybody can benefit]

On Fri, Oct 25, 2019 at 07:39:14PM +0200, Carlo Pisani wrote:
> > These resources are supplied to the PCI core, probably from DT.  A
> > complete dmesg log would show more.
> 
> Kernel command line: console=ttyS0,9600 gpio=8191 mem=64M
> kmac=00:0C:42:0E:8F:01 board=500r5 boot=1  root=/dev/sda3
> init=/sbin/init msg=hAlloworld
> korina mac = 00:0C:42:0E:8F:01
> PID hash table entries: 256 (order: -2, 1024 bytes)
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 57840K/65536K available (4762K kernel code, 175K rwdata, 816K
> rodata, 188K init, 111K bss, 7696K reserved, 0K cma-reserved)
> NR_IRQS:256
> Initializing IRQ's: 168 out of 256
> calculating r4koff... 000c34f8(799992)
> CPU frequency 400.00 MHz
> clocksource: MIPS: mask: 0xffffffff max_cycles: 0xffffffff,
> max_idle_ns: 9556397797 ns
> sched_clock: 32 bits at 199MHz, resolution 5ns, wraps every 10737525757ns
> Calibrating delay loop... 397.82 BogoMIPS (lpj=795648)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
> max_idle_ns: 7645041785100000 ns
> futex hash table entries: 256 (order: -1, 3072 bytes)
> NET: Registered protocol family 16
> PCI: Initializing PCI
> SCSI subsystem initialized
> libata version 3.00 loaded.
> PCI host bridge to bus 0000:00

I wish we printed something about which host bridge driver we're using
here.  Are you booting with a DT?  If so, can you attach it?

> pci_bus 0000:00: root bus resource [mem 0x50000000-0x5fffffff]
> pci_bus 0000:00: root bus resource [io  0x18800000-0x188fffff]
> pci_bus 0000:00: root bus resource [??? 0x00000000 flags 0x0]
> pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
> pci 0000:00:00.0: [111d:0000] type 00 class 0x000000
> pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x07ffffff pref]
> pci 0000:00:00.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
> pci 0000:00:00.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)

It's hard to tell what this 00:00.0 device is.  The Vendor ID 0x111d
is "Microsemi / PMC / IDT" (now owned by Microchip Technology, per
https://pci-ids.ucw.cz/read/PC/111d).

The Device ID of 0x0000 looks invalid (though that's defined by the
vendor, and I think the PCIe spec would allow 0).

The class code is invalid.  Likely the device has configuration
registers for the PCI host bridge.

> pci 0000:00:02.0: [1106:3106] type 00 class 0x020000
> pci 0000:00:02.0: reg 0x10: [io  0x0000-0x00ff]
> pci 0000:00:02.0: reg 0x14: [mem 0x00000000-0x000000ff]
> pci 0000:00:02.0: supports D1 D2
> pci 0000:00:02.0: PME# supported from D1 D2 D3hot D3cold
> pci 0000:00:03.0: [1106:3106] type 00 class 0x020000
> pci 0000:00:03.0: reg 0x10: [io  0x0000-0x00ff]
> pci 0000:00:03.0: reg 0x14: [mem 0x00000000-0x000000ff]
> pci 0000:00:03.0: supports D1 D2
> pci 0000:00:03.0: PME# supported from D1 D2 D3hot D3cold
> pci 0000:00:04.0: [168c:0029] type 00 class 0x028000
> pci 0000:00:04.0: reg 0x10: [mem 0x00000000-0x0000ffff]
> pci 0000:00:04.0: PME# supported from D0 D3hot
> pci 0000:00:05.0: [1415:9501] type 00 class 0x070006
> pci 0000:00:05.0: reg 0x10: [io  0x0000-0x001f]
> pci 0000:00:05.0: reg 0x14: [mem 0x00000000-0x00000fff]
> pci 0000:00:05.0: reg 0x18: [io  0x0000-0x001f]
> pci 0000:00:05.0: reg 0x1c: [mem 0x00000000-0x00000fff]
> pci 0000:00:05.0: supports D2
> pci 0000:00:05.0: PME# supported from D0 D2 D3hot
> pci 0000:00:05.1: [1415:9500] type 00 class 0x000000
> pci 0000:00:05.1: reg 0x10: [io  0x0000-0x0007]
> pci 0000:00:05.1: reg 0x14: [io  0x0000-0x0007]
> pci 0000:00:05.1: reg 0x18: [io  0x0000-0x001f]
> pci 0000:00:05.1: reg 0x1c: [mem 0x00000000-0x00000fff]
> pci 0000:00:05.1: supports D2
> pci 0000:00:05.1: PME# supported from D0 D2 D3hot
> pci 0000:00:0a.0: [1415:9501] type 00 class 0x070006
> pci 0000:00:0a.0: reg 0x10: [io  0x0000-0x001f]
> pci 0000:00:0a.0: reg 0x14: [mem 0x00000000-0x00000fff]
> pci 0000:00:0a.0: reg 0x18: [io  0x0000-0x001f]
> pci 0000:00:0a.0: reg 0x1c: [mem 0x00000000-0x00000fff]
> pci 0000:00:0a.0: supports D2
> pci 0000:00:0a.0: PME# supported from D0 D2 D3hot
> pci 0000:00:0a.1: [1415:9500] type 00 class 0x000000
> pci 0000:00:0a.1: reg 0x10: [io  0x0000-0x0007]
> pci 0000:00:0a.1: reg 0x14: [io  0x0000-0x0007]
> pci 0000:00:0a.1: reg 0x18: [io  0x0000-0x001f]
> pci 0000:00:0a.1: reg 0x1c: [mem 0x00000000-0x00000fff]
> pci 0000:00:0a.1: supports D2
> pci 0000:00:0a.1: PME# supported from D0 D2 D3hot
> pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
> pci 0000:00:04.0: BAR 0: assigned [mem 0x50000000-0x5000ffff]
> pci 0000:00:05.0: BAR 1: assigned [mem 0x50010000-0x50010fff]
> pci 0000:00:05.0: BAR 3: assigned [mem 0x50011000-0x50011fff]
> pci 0000:00:0a.0: BAR 1: assigned [mem 0x50012000-0x50012fff]
> pci 0000:00:0a.0: BAR 3: assigned [mem 0x50013000-0x50013fff]
> pci 0000:00:02.0: BAR 0: assigned [io  0x18800000-0x188000ff]
> pci 0000:00:02.0: BAR 1: assigned [mem 0x50014000-0x500140ff]
> pci 0000:00:03.0: BAR 0: assigned [io  0x18800400-0x188004ff]
> pci 0000:00:03.0: BAR 1: assigned [mem 0x50014100-0x500141ff]
> pci 0000:00:05.0: BAR 0: assigned [io  0x18800800-0x1880081f]
> pci 0000:00:05.0: BAR 2: assigned [io  0x18800820-0x1880083f]
> pci 0000:00:0a.0: BAR 0: assigned [io  0x18800840-0x1880085f]
> pci 0000:00:0a.0: BAR 2: assigned [io  0x18800860-0x1880087f]
> clocksource: Switched to clocksource MIPS
> NET: Registered protocol family 2
> TCP established hash table entries: 1024 (order: 0, 4096 bytes)
> TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
> TCP: Hash tables configured (established 1024 bind 1024)
> UDP hash table entries: 256 (order: 0, 4096 bytes)
> UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
> NET: Registered protocol family 1
> PCI: CLS 16 bytes, default 16
> io scheduler noop registered
> io scheduler deadline registered (default)
> Serial: 8250/16550 driver, 9 ports, IRQ sharing disabled
> serial8250: ttyS0 at MMIO 0x0 (irq = 104, base_baud = 12499875) is a 16550A
> console [ttyS0] enabled
> console [ttyS0] disabled
> serial8250.0: ttyS0 at MMIO 0x0 (irq = 104, base_baud = 12499875) is a 16550A
> console [ttyS0] enabled
> PCI: Enabling device 0000:00:05.0 (0000 -> 0003)
> ttyS1: detected caps 00000700 should be 00000500
> 0000:00:05.0: ttyS1 at I/O 0x18800800 (irq = 143, base_baud = 115200)
> is a 16C950/954
> ttyS2: detected caps 00000700 should be 00000500
> 0000:00:05.0: ttyS2 at I/O 0x18800808 (irq = 143, base_baud = 115200)
> is a 16C950/954
> ttyS3: detected caps 00000700 should be 00000500
> 0000:00:05.0: ttyS3 at I/O 0x18800810 (irq = 143, base_baud = 115200)
> is a 16C950/954
> ttyS4: detected caps 00000700 should be 00000500
> 0000:00:05.0: ttyS4 at I/O 0x18800818 (irq = 143, base_baud = 115200)
> is a 16C950/954
> PCI: Enabling device 0000:00:0a.0 (0000 -> 0003)
> ttyS5: detected caps 00000700 should be 00000500
> 0000:00:0a.0: ttyS5 at I/O 0x18800840 (irq = 140, base_baud = 115200)
> is a 16C950/954
> ttyS6: detected caps 00000700 should be 00000500
> 0000:00:0a.0: ttyS6 at I/O 0x18800848 (irq = 140, base_baud = 115200)
> is a 16C950/954
> ttyS7: detected caps 00000700 should be 00000500
> 0000:00:0a.0: ttyS7 at I/O 0x18800850 (irq = 140, base_baud = 115200)
> is a 16C950/954
> ttyS8: detected caps 00000700 should be 00000500
> 0000:00:0a.0: ttyS8 at I/O 0x18800858 (irq = 140, base_baud = 115200)
> is a 16C950/954
> loop: module loaded
> nbd: registered device at major 43
> null: module loaded
> scsi host0: pata-rb532-cf
> ata1: PATA max PIO4 irq 149
> Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)
> tun: Universal TUN/TAP device driver, 1.6
> tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> ata1.00: CFA: HMS360404D5CF00, DN4OCA2A, max PIO4
> ata1.00: 7999488 sectors, multi 0: LBA
> eth0: korina-0.10 04Mar2008
> via_rhine: v1.10-LK1.5.1 2010-10-09 Written by Donald Becker
> PCI: Enabling device 0000:00:02.0 (0080 -> 0083)
> via-rhine 0000:00:02.0 eth1: VIA Rhine III at 0xc0012000,
> 00:0c:42:0e:8f:02, IRQ 142
> via-rhine 0000:00:02.0 eth1: MII PHY found at address 1, status 0x7869
> advertising 05e1 Link 45e1
> PCI: Enabling device 0000:00:03.0 (0080 -> 0083)
> via-rhine 0000:00:03.0 eth2: VIA Rhine III at 0xc0014100,
> 00:0c:42:0e:8f:03, IRQ 143
> via-rhine 0000:00:03.0 eth2: MII PHY found at address 1, status 0x7869
> advertising 05e1 Link 41e1
> PCI: Enabling device 0000:00:04.0 (0000 -> 0002)
> ath: EEPROM regdomain: 0x809c
> ath: EEPROM indicates we should expect a country code
> ath: doing EEPROM country->regdmn map search
> ath: country maps to regdmn code: 0x52
> ath: Country alpha2 being used: CN
> ath: Regpair used: 0x52
> ata1.00: configured for PIO4
> scsi 0:0:0:0: Direct-Access     ATA      HMS360404D5CF00  CA2A PQ: 0 ANSI: 5
> ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
> ieee80211 phy0: Atheros AR9280 Rev:2 mem=0xc0020000, irq=142
> sd 0:0:0:0: [sda] 7999488 512-byte logical blocks: (4.10 GB/3.81 GiB)
> aoe: AoE v85 initialised.
> rc32434_wdt: Stopped watchdog timer
> rc32434_wdt: Watchdog Timer version 1.0, timer margin: 20 sec
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
> support DPO or FUA
> NET: Registered protocol family 26
> Netfilter messages via NETLINK v0.30.
> nf_conntrack version 0.5.0 (903 buckets, 3612 max)
>  sda: sda1 sda2 sda3
> nf_tables: (c) 2007-2009 Patrick McHardy <kaber@trash.net>
> sd 0:0:0:0: [sda] Attached SCSI removable disk
> nf_tables_compat: (c) 2012 Pablo Neira Ayuso <pablo@netfilter.org>
> xt_time: kernel timezone is -0000
> ip_tables: (C) 2000-2006 Netfilter Core Team
> arp_tables: (C) 2002 David S. Miller
> NET: Registered protocol family 17
> bridge: automatic filtering via arp/ip/ip6tables has been deprecated.
> Update your scripts to load br_netfilter if you need this.
> Bridge firewalling registered
> Ebtables v2.0 registered
> EXT4-fs (sda3): couldn't mount as ext3 due to feature incompatibilities
> EXT4-fs (sda3): INFO: recovery required on readonly filesystem
> EXT4-fs (sda3): write access will be enabled during recovery
> random: nonblocking pool is initialized
> EXT4-fs (sda3): recovery complete
> EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null)
> VFS: Mounted root (ext4 filesystem) readonly on device 8:3.
> Freeing unused kernel memory: 188K
> EXT4-fs (sda3): re-mounted. Opts: (null)
> EXT4-fs (sda3): re-mounted. Opts: (null)
> EXT4-fs (sda3): re-mounted. Opts: (null)
> EXT4-fs (sda3): re-mounted. Opts: (null)
> EXT4-fs (sda3): re-mounted. Opts: (null)
> EXT4-fs (sda3): re-mounted. Opts: (null)
> Adding 117428k swap on /dev/sda2.  Priority:-1 extents:1 across:117428k
> device eth0 entered promiscuous mode
> device eth1 entered promiscuous mode
> device eth2 entered promiscuous mode
> 
> 
> > If you take the cards out, do the lines you mention above change?
> 
> I have to test it. But with the cards out I never experimented a crash
> 
> this is the board
> http://www.downthebunker.com/reloaded/space/viewtopic.php?f=79&t=271
> 
> 
> > What sort of crashes do you see?  I assume it doesn't crash without
> > the cards?
> 
> This rb532 is currently tested this way:
> - two miniPCI Quad-UART installed
> - /dev/ttyS5 attached to a machine which continuously sends messages
> on the serial
> - eth0, eth1, eth1 configured as bridge
> - eth1 attached to a machine which continuously requests TFTP packages
> on the ethernet
> - eth0 attached to the local network, with one ssh section to monitor
> the machine
> - the application minicom does monitor /dev/ttyS5
> 
> the machine looks working properly in a short time, but  within 48h I
> do see weird behaviors, and crashes seem referred to
> - minicom
> - in.tftpd
> 
> do_page_fault(): sending SIGSEGV to in.tftpd for invalid write access
> to 0401a8c8
> epc = 77c7afa4 in libc-2.9.so[77bc9000+160000]
> ra  = 77c7af88 in libc-2.9.so[77bc9000+160000]
> 
> uc-rb532 ~ # CPU 0 Unable to handle kernel paging request at virtual
> address 1040ff60, epc == 8049543c, ra == 80495fe0
> Oops[#1]:
> CPU: 0 PID: 6395 Comm: in.tftpd Not tainted 4.4.197-BlurryFishButt-rb532 #2
> task: 83660588 ti: 80ed4000 task.ti: 80ed4000
> Status: 1810e803        KERNEL EXL IE
> Cause : 30800008 (ExcCode 02)
> BadVA : 1040ff60
> PrId  : 0001800a (MIPS 4Kc)
> Modules linked in:
> Process in.tftpd (pid: 6395, threadinfo=80ed4000, task=83660588, tls=77a57470)

Can you collect the output of "lspci -vvxxx" as root?

If those UARTs are capable of DMA, it's conceivable they could corrupt
something.
