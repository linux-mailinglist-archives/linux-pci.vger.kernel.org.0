Return-Path: <linux-pci+bounces-819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8930C80F912
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 22:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA321C20D6F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 21:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7398C65A9E;
	Tue, 12 Dec 2023 21:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IA6rjAB8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F95D65A84;
	Tue, 12 Dec 2023 21:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3066C433C7;
	Tue, 12 Dec 2023 21:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702415972;
	bh=oWti6B2hluT7CCjS/Eg6sEi+TjyY1oxWXDgmY5tZaQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IA6rjAB8f07IXHyEMQPRZc7h4Iz18ba9PXjsZXw0PW0bMcN1tSptu4EESUP112Rku
	 RoEpI5VWZB4K+qmsd/YmOiUdsRuVFjOIrYmlfV7EfXDIoypo+ntUcrRzWcW3+78vTt
	 so0nwBuPJIz0CpUkWByHwdHHBohGAUL95OdoJKQ7/x3AH5ObTbu3UzlcjHdz838nOt
	 sIWMe/PEHnKPHQ5wDdLFWz+L/XCBV66MAdCSTmbH1DayMDY/JR8DeQ2XrYPVfB2U3+
	 gjLToAkvH+hZ1Xrfnsel0PwF++d/f+r/nPP91vjCCTovlx1qC11uBVtKfHC95V9v32
	 GStWzWtoSkcMA==
Date: Tue, 12 Dec 2023 15:19:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	imammedo@redhat.com, mst@redhat.com, rafael@kernel.org,
	lenb@kernel.org, bhelgaas@google.com,
	mika.westerberg@linux.intel.com, boris.ostrovsky@oracle.com,
	joe.jin@oracle.com, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, Fiona Ebner <f.ebner@proxmox.com>,
	Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: [Regression report] commit 40613da52b13 ("PCI: acpiphp: Reassign
 resources on bridge if necessary")
Message-ID: <20231212211930.GA1020759@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c4a446a-b167-11b8-f36f-d3c1b49b42e9@oracle.com>

[+cc Fiona, Thomas]

On Mon, Dec 11, 2023 at 04:14:25PM -0800, Dongli Zhang wrote:
> This is to report a regression caused by commit 40613da52b13 ("PCI: acpiphp:
> Reassign resources on bridge if necessary").
> 
> PCI: acpiphp: Reassign resources on bridge if necessary
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=40613da52b13fb21c5566f10b287e0ca8c12c4e9

Thanks very much for the report and the detailed analysis!

Just for completeness, I'm cc'ing folks from another report that
appears to be the same or very similar issue:
https://lore.kernel.org/r/9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com

There's also a bugzilla with some logs attached:
https://bugzilla.kernel.org/show_bug.cgi?id=218255

#regzbot dup: https://lore.kernel.org/r/9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com

> That patch may reconfigure the mmio resource of the bridge so that to write to
> mmio during PCI hotplug may lose effect.
> 
> Here is how to reproduce the issue.
> 
> 1. Create QEMU (v8.1.0) VM with the below.
> 
> qemu-system-x86_64 -machine pc,accel=kvm \
> -smp 8 -m 8G -cpu host -hda uefi-os.qcow2 \
> -drive if=pflash,format=raw,unit=0,file=OVMF_CODE.fd,readonly \
> -drive if=pflash,format=raw,unit=1,file=OVMF_VARS.fd \
> -kernel mainline-linux/arch/x86_64/boot/bzImage \
> -append "root=/dev/sda2 init=/sbin/init text console=ttyS0 loglevel=7" \
> -serial none -display none -vnc :9 -monitor stdio \
> -net nic -net user,hostfwd=tcp::5027-:22 \
> -device pci-bridge,id=bridge1,bus=pci.0,chassis_nr=2
> 
> We should have CONFIG_SCSI_SCAN_ASYNC=y so that scsi probing happens in another
> thread.
> 
> 2. Hot-add two vhost-scsi PCI devices consecutively.
> 
> (qemu) device_add vhost-scsi-pci,wwpn=naa.5001405324af0985,id=vhost01,bus=bridge1,addr=8
> (qemu) device_add vhost-scsi-pci,wwpn=naa.5001405324af0986,id=vhost02,bus=bridge1,addr=0
> 
> 3. The 1st hot-add succeeds.
> 
> [   44.365111] ACPI: \_SB_.PCI0.S20_.S40_: Device check in hotplug_event()
> [   44.365261] pci 0000:01:08.0: [1af4:1004] type 00 class 0x010000
> [   44.365377] pci 0000:01:08.0: reg 0x10: [io  0x0000-0x003f]
> [   44.365425] pci 0000:01:08.0: reg 0x14: [mem 0x00000000-0x00000fff]
> [   44.365589] pci 0000:01:08.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
> [   44.366479] pci 0000:01:08.0: EDR: Notify handler installed
> [   44.367255] pci 0000:01:08.0: vgaarb: pci_notify
> [   44.367490] pci 0000:00:04.0: BAR 15: assigned [mem 0x800100000-0x8001fffff 64bit pref]
> [   44.367497] pci 0000:01:08.0: BAR 4: assigned [mem 0x800100000-0x800103fff 64bit pref]
> [   44.367579] pci 0000:01:08.0: BAR 1: assigned [mem 0xc1000000-0xc1000fff]
> [   44.367605] pci 0000:01:08.0: BAR 0: assigned [io  0xc000-0xc03f]
> [   44.367638] pci 0000:00:04.0: PCI bridge to [bus 01]
> [   44.367653] pci 0000:00:04.0:   bridge window [io  0xc000-0xcfff]
> [   44.369258] pci 0000:00:04.0:   bridge window [mem 0xc1000000-0xc11fffff]
> [   44.370134] pci 0000:00:04.0:   bridge window [mem 0x800100000-0x8001fffff 64bit pref]
> [   44.372147] virtio-pci 0000:01:08.0: vgaarb: pci_notify
> [   44.372155] virtio-pci 0000:01:08.0: runtime IRQ mapping not provided by arch
> [   44.409717] ACPI: \_SB_.LNKD: Enabled at IRQ 10
> [   44.409781] virtio-pci 0000:01:08.0: enabling device (0000 -> 0003)
> [   44.448742] virtio-pci 0000:01:08.0: enabling bus mastering
> [   44.452982] scsi host2: Virtio SCSI HBA
> [   44.470553] virtio-pci 0000:01:08.0: vgaarb: pci_notify
> [   44.471124] scsi 2:0:1:0: Direct-Access     LIO-ORG  lun1             4.0  PQ: 0 ANSI: 5
> [   44.490102] sd 2:0:1:0: Attached scsi generic sg2 type 0
> [   44.490240] sd 2:0:1:0: [sdb] 262144 512-byte logical blocks: (134 MB/128 MiB)
> [   44.490275] sd 2:0:1:0: [sdb] Write Protect is off
> [   44.490279] sd 2:0:1:0: [sdb] Mode Sense: 43 00 10 08
> [   44.490333] sd 2:0:1:0: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [   44.501807] sd 2:0:1:0: [sdb] Preferred minimum I/O size 512 bytes
> [   44.501812] sd 2:0:1:0: [sdb] Optimal transfer size 8388608 bytes
> [   44.504009] sd 2:0:1:0: [sdb] Attached SCSI disk
> 
> 4. The 2nd hot-add fails. We do not see scsi probing finished.
> 
> [   52.285341] ACPI: \_SB_.PCI0.S20_.S00_: Device check in hotplug_event()
> [   52.285488] pci 0000:01:00.0: [1af4:1004] type 00 class 0x010000
> [   52.285620] pci 0000:01:00.0: reg 0x10: [io  0x0000-0x003f]
> [   52.285668] pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x00000fff]
> [   52.285833] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
> [   52.286687] pci 0000:01:00.0: EDR: Notify handler installed
> [   52.287484] pci 0000:01:00.0: vgaarb: pci_notify
> [   52.287568] pci 0000:01:00.0: BAR 4: assigned [mem 0x800104000-0x800107fff 64bit pref]
> [   52.287650] pci 0000:01:00.0: BAR 1: assigned [mem 0xc1001000-0xc1001fff]
> [   52.287676] pci 0000:01:00.0: BAR 0: assigned [io  0xc040-0xc07f]
> [   52.287701] pci 0000:00:04.0: PCI bridge to [bus 01]
> [   52.287715] pci 0000:00:04.0:   bridge window [io  0xc000-0xcfff]
> [   52.289611] pci 0000:00:04.0:   bridge window [mem 0xc1000000-0xc11fffff]
> [   52.291062] pci 0000:00:04.0:   bridge window [mem 0x800100000-0x8001fffff 64bit pref]
> [   52.294057] virtio-pci 0000:01:00.0: vgaarb: pci_notify
> [   52.294065] virtio-pci 0000:01:00.0: runtime IRQ mapping not provided by arch
> [   52.294083] virtio-pci 0000:01:00.0: enabling device (0000 -> 0003)
> [   52.335305] virtio-pci 0000:01:00.0: enabling bus mastering
> [   52.339810] scsi host3: Virtio SCSI HBA
> [   52.358165] virtio-pci 0000:01:00.0: vgaarb: pci_notify
> [   52.358380] pci 0000:00:04.0: PCI bridge to [bus 01]
> [   52.358398] pci 0000:00:04.0:   bridge window [io  0xc000-0xcfff]
> [   52.358518] scsi 3:0:1:0: Direct-Access     LIO-ORG  lun2             4.0  PQ: 0 ANSI: 5
> [   52.360287] pci 0000:00:04.0:   bridge window [mem 0xc1000000-0xc11fffff]
> [   52.362313] pci 0000:00:04.0:   bridge window [mem 0x800100000-0x8001fffff 64bit pref]
> 
> It is because of the following. To reconfigure the mmio resource of bridge and
> to probe scsi happens at the same time, in different threads.
> 
> [   52.358398] pci 0000:00:04.0:   bridge window [io  0xc000-0xcfff]
> [   52.358518] scsi 3:0:1:0: Direct-Access     LIO-ORG  lun2             4.0  PQ: 0 ANSI: 5
> [   52.360287] pci 0000:00:04.0:   bridge window [mem 0xc1000000-0xc11fffff]
> [   52.362313] pci 0000:00:04.0:   bridge window [mem 0x800100000-0x8001fffff 64bit pref]
> 
> The race starts since line 638.
> 
> 627 static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
> 628 {
> 629         struct resource *res;
> 630         struct pci_bus_region region;
> 631         u32 l, bu, lu;
> 632
> 633         /*
> 634          * Clear out the upper 32 bits of PREF limit.  If
> 635          * PCI_PREF_BASE_UPPER32 was non-zero, this temporarily disables
> 636          * PREF range, which is ok.
> 637          */
> 638         pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, 0);
> 639
> 640         /* Set up PREF base/limit */
> 641         bu = lu = 0;
> 642         res = &bridge->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> 643         pcibios_resource_to_bus(bridge->bus, &region, res);
> 644         if (res->flags & IORESOURCE_PREFETCH) {
> 645                 l = (region.start >> 16) & 0xfff0;
> 646                 l |= region.end & 0xfff00000;
> 647                 if (res->flags & IORESOURCE_MEM_64) {
> 648                         bu = upper_32_bits(region.start);
> 649                         lu = upper_32_bits(region.end);
> 650                 }
> 651                 pci_info(bridge, "  bridge window %pR\n", res);
> 652         } else {
> 653                 l = 0x0000fff0;
> 654         }
> 655         pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, l);
> 656
> 657         /* Set the upper 32 bits of PREF base & limit */
> 658         pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32, bu);
> 659         pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, lu);
> 660 }
> 
> 
> To probe the vhost-scsi and to reconfigure bridge window happen in different
> threads. There is a race between them so that to write to mmio may not work. It
> is called ioeventfd from KVM/QEMU's perspective.
> 
> [0] pci_setup_bridge_mmio_pref
> [0] pci_setup_bridge
> [0] pci_assign_unassigned_bridge_resources
> [0] enable_slot
> [0] acpiphp_check_bridge
> [0] acpiphp_hotplug_notify
> [0] acpi_device_hotplug
> [0] acpi_hotplug_work_fn
> [0] process_one_work
> [0] worker_thread
> [0] kthread
> [0] ret_from_fork
> [0] ret_from_fork_asm
> 
> [0] blk_execute_rq
> [0] scsi_execute_cmd
> [0] scsi_probe_lun
> [0] scsi_probe_and_add_lun
> [0] __scsi_scan_target
> [0] scsi_scan_channel
> [0] scsi_scan_host_selected
> [0] do_scsi_scan_host
> [0] do_scan_async
> [0] async_run_entry_fn
> [0] process_one_work
> [0] worker_thread
> [0] kthread
> [0] ret_from_fork
> 
> 
> Indeed, I am curious if this impacts other PCI devices on this PCI bridge,
> doing mmio (e.g., to kick the doorbell register during that time).
> 
> There used to be similar issue. According to prior commits, we may need to
> touch the bridge window for only once.
> 
> PCI: Probe bridge window attributes once at enumeration-time
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=51c48b310183ab6ba5419edfc6a8de889cc04521
> 
> 
> Thank you very much!
> 
> Dongli Zhang

