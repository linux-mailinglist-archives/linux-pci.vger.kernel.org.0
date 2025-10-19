Return-Path: <linux-pci+bounces-38649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A42BEDE62
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 07:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485933A3E08
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 05:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F154A1F4CB3;
	Sun, 19 Oct 2025 05:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXLRh5YC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE88E2557A;
	Sun, 19 Oct 2025 05:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760850772; cv=none; b=le9Hq/scpITlda95kkc9o0arzqtDEx6IDz/FnG6L2gfG0GoHojOlnRHoph/sRN3tmZeeFnhwVjvREzN4co91bG05O8kYbMfdAPlTvZTYJ5ol1dq7qVxqGAzifdCstr/s+VVqfc2wyqHyCQOHNdKxoV4nJgPgBALzBDDtwzEqxzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760850772; c=relaxed/simple;
	bh=uD73A2R8BkO2oQ9x4CXSx2f4SDrPL/lVPToaY7si8DM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4Mv8n/Z1fai9SXHSbhGojokgRiXx8Ai/nufFD0M3slCk6VCZNSYXasxS8crDBzloFMsuz5oePCuQ27uen/Q/aqEfdYP3tn/REFzDVBcmSpPlABlyOVPp9dLkv4T35zuppsRYRCWNGeXVyYSqDOXSYSQPm7Ld+7swIxOa9+g2VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXLRh5YC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D65C4CEE7;
	Sun, 19 Oct 2025 05:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760850772;
	bh=uD73A2R8BkO2oQ9x4CXSx2f4SDrPL/lVPToaY7si8DM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NXLRh5YCBOziEn4IHZ7CNXNWJK+JsY1zHwrt2IYGAMsFHdcpyvTdFDOidmpxpQQx/
	 +Z+GAwR8DEiqGhHdkwO2RYMaaNt+xefgniDDoiAJ2CjHlHI2gzpMJKY5NvtVNn6V0Q
	 XTB43Ye333Lfc5cGc6oAS8t5CL4TvzozeRr7ihsuCaYjP9N3zqgaJUnuYkXJk7CajD
	 66lhMWmojFUWdR8T7VynonTnZtL8WWkUatvaFLqLi45TqXYCerxVn6g5SShZzwLwQk
	 lBlGsozfcFBQKMrxlPHfhY6/7pwMk/niFJZfAokQO3WAs/jcR2fJR4OscsXo1Yd9BF
	 ItwJ0VR+rlP1A==
Message-ID: <d0b6105f-744f-40d9-b4b7-1fa645038d0b@kernel.org>
Date: Sun, 19 Oct 2025 00:12:50 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Intel Wireless adapter is not detected until
 suspending to RAM and resuming
To: =?UTF-8?Q?Adri=C3=A0_Vilanova_Mart=C3=ADnez?= <me@avm99963.com>,
 bhelgaas@google.com
Cc: regressions@lists.linux.dev, linux-pci@vger.kernel.org
References: <owewi3sswao4jt5qn3ntm533lvxe3jlovhjbdufq3uedbuztxt@76nft22vboxv>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <owewi3sswao4jt5qn3ntm533lvxe3jlovhjbdufq3uedbuztxt@76nft22vboxv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/18/25 5:01 PM, Adrià Vilanova Martínez wrote:
> Hi,
> 
> My Pixelbook Eve laptop (model C0A) no longer detects the Intel(R) Dual
> Band Wireless-AC 7265 adapter on boot after upgrading the Kernel.
> However, if I suspend to RAM (e.g., closing the laptop lid) and resume
> it, I can use WiFi again and the detection is shown in dmesg.
> 
> After performing a bisection, this is the first commit where the issue
> occurs:
> 
> 4d4c10f763 PCI: Explicitly put devices into D0 when initializing

4d4c10f763 has a known failure that was fixed in 
907a7a2e5bf40c6a359b2f6cc53d6fdca04009e0.

So I'm suspecting a secondary problem has occurred.

Can you repeat your bisection and any time that 4d4c10f763 is present 
but 907a7a2e5bf40c6a359b2f6cc53d6fdca04009e0 isn't, apply it manually?
> 
> Here's the output of dmesg for the latest mainline Kernel I built, where
> I can still reproduce the issue (notice that around second 49 I suspend
> the laptop; also, I've censored some MACs in the log with
> "__CENSORED__"):

One other observation is that iwlwifi didn't even try to probe before 
suspend.  That's a bit odd.  Was it loaded on it's own?  Or was it just 
failing to probe?

> 
> [    0.000000] Linux version 6.18.0-rc1-local-00203-g6f3b6e91f720 (avm99963@pixelbook) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU Binutils) 2.45.0) #4 SMP PREEMPT_DYNAMIC Fri Oct 17 22:17:39 CEST 2025
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-linux-local root=/dev/mapper/VolGroup00-root rw loglevel=3 quiet cryptdevice=UUID=70c55651-98b6-4a3d-9c6a-9f9e70c23225:cryptroot root=/dev/VolGroup00/root
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000001000-0x000000000009ffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007a7bffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000007a7c0000-0x000000007a9c7fff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000007a9c8000-0x000000007a9cffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000007a9d0000-0x000000007a9e4fff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x000000007a9e5000-0x000000007a9e5fff] usable
> [    0.000000] BIOS-e820: [mem 0x000000007a9e6000-0x000000007fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ffbc0000-0x00000000ffbfffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000027effffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] APIC: Static calls initialized
> [    0.000000] efi: EFI v2.7 by EDK II
> [    0.000000] efi: SMBIOS=0x7a8ca000 SMBIOS 3.0=0x7a8c8000 ACPI=0x7a9e4000 ACPI 2.0=0x7a9e4014 MEMATTR=0x7794d018 INITRD=0x7794ee98
> [    0.000000] efi: Remove mem92: MMIO range=[0xffbc0000-0xffbfffff] (0MB) from e820 map
> [    0.000000] e820: remove [mem 0xffbc0000-0xffbfffff] reserved
> [    0.000000] SMBIOS 3.0.0 present.
> [    0.000000] DMI: Google Eve/Eve, BIOS MrChromebox-2408.1 09/14/2024
> [    0.000000] DMI: Memory slots populated: 2/2
> [    0.000000] tsc: Detected 1600.000 MHz processor
> [    0.000000] tsc: Detected 1599.960 MHz TSC
> [    0.000009] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000012] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000017] last_pfn = 0x27f000 max_arch_pfn = 0x400000000
> [    0.000023] MTRR map: 7 entries (3 fixed + 4 variable; max 23), built from 10 variable MTRRs
> [    0.000025] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
> [    0.000418] last_pfn = 0x7a9e6 max_arch_pfn = 0x400000000
> [    0.008228] Using GB pages for direct mapping
> [    0.008466] Secure boot disabled
> [    0.008466] RAMDISK: [mem 0x7180f000-0x7379ffff]
> [    0.008510] ACPI: Early table checksum verification disabled
> [    0.008513] ACPI: RSDP 0x000000007A9E4014 000024 (v02 COREv4)
> [    0.008517] ACPI: XSDT 0x000000007A9E30E8 00007C (v01 COREv4 COREBOOT 00000000      01000013)
> [    0.008529] ACPI: FACP 0x000000007A9E2000 000114 (v06 COREv4 COREBOOT 00000000 CORE 20230628)
> [    0.008535] ACPI: DSDT 0x000000007A9DD000 00470C (v02 COREv4 COREBOOT 20110725 INTL 20230628)
> [    0.008538] ACPI: FACS 0x000000007A9FE240 000040
> [    0.008541] ACPI: SSDT 0x000000007A9DB000 001865 (v02 COREv4 COREBOOT 00000000 CORE 20230628)
> [    0.008544] ACPI: MCFG 0x000000007A9DA000 00003C (v01 COREv4 COREBOOT 00000000 CORE 20230628)
> [    0.008547] ACPI: TPM2 0x000000007A9D9000 00004C (v04 COREv4 COREBOOT 00000000 CORE 20230628)
> [    0.008550] ACPI: LPIT 0x000000007A9D8000 000094 (v00 COREv4 COREBOOT 00000000 CORE 20230628)
> [    0.008553] ACPI: APIC 0x000000007A9D7000 000072 (v03 COREv4 COREBOOT 00000000 CORE 20230628)
> [    0.008556] ACPI: NHLT 0x000000007A9D6000 000388 (v05 GOOGLE EVEMAX   00000000 CORE 00000000)
> [    0.008559] ACPI: DMAR 0x000000007A9D5000 000088 (v01 COREv4 COREBOOT 00000000 CORE 20230628)
> [    0.008562] ACPI: DBG2 0x000000007A9D4000 000061 (v00 COREv4 COREBOOT 00000000 CORE 20230628)
> [    0.008565] ACPI: HPET 0x000000007A9D3000 000038 (v01 COREv4 COREBOOT 00000000 CORE 20230628)
> [    0.008568] ACPI: BGRT 0x000000007A9D2000 000038 (v01 INTEL  EDK2     00000002      01000013)
> [    0.008570] ACPI: Reserving FACP table memory at [mem 0x7a9e2000-0x7a9e2113]
> [    0.008572] ACPI: Reserving DSDT table memory at [mem 0x7a9dd000-0x7a9e170b]
> [    0.008573] ACPI: Reserving FACS table memory at [mem 0x7a9fe240-0x7a9fe27f]
> [    0.008574] ACPI: Reserving SSDT table memory at [mem 0x7a9db000-0x7a9dc864]
> [    0.008574] ACPI: Reserving MCFG table memory at [mem 0x7a9da000-0x7a9da03b]
> [    0.008575] ACPI: Reserving TPM2 table memory at [mem 0x7a9d9000-0x7a9d904b]
> [    0.008576] ACPI: Reserving LPIT table memory at [mem 0x7a9d8000-0x7a9d8093]
> [    0.008577] ACPI: Reserving APIC table memory at [mem 0x7a9d7000-0x7a9d7071]
> [    0.008577] ACPI: Reserving NHLT table memory at [mem 0x7a9d6000-0x7a9d6387]
> [    0.008578] ACPI: Reserving DMAR table memory at [mem 0x7a9d5000-0x7a9d5087]
> [    0.008579] ACPI: Reserving DBG2 table memory at [mem 0x7a9d4000-0x7a9d4060]
> [    0.008580] ACPI: Reserving HPET table memory at [mem 0x7a9d3000-0x7a9d3037]
> [    0.008580] ACPI: Reserving BGRT table memory at [mem 0x7a9d2000-0x7a9d2037]
> [    0.008702] No NUMA configuration found
> [    0.008702] Faking a node at [mem 0x0000000000000000-0x000000027effffff]
> [    0.008712] NODE_DATA(0) allocated [mem 0x27efd5280-0x27effffff]
> [    0.008936] Zone ranges:
> [    0.008937]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.008939]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.008940]   Normal   [mem 0x0000000100000000-0x000000027effffff]
> [    0.008941]   Device   empty
> [    0.008942] Movable zone start for each node
> [    0.008944] Early memory node ranges
> [    0.008945]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
> [    0.008946]   node   0: [mem 0x0000000000100000-0x000000007a7bffff]
> [    0.008947]   node   0: [mem 0x000000007a9c8000-0x000000007a9cffff]
> [    0.008948]   node   0: [mem 0x000000007a9e5000-0x000000007a9e5fff]
> [    0.008949]   node   0: [mem 0x0000000100000000-0x000000027effffff]
> [    0.008951] Initmem setup node 0 [mem 0x0000000000001000-0x000000027effffff]
> [    0.008956] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.008977] On node 0, zone DMA: 96 pages in unavailable ranges
> [    0.011697] On node 0, zone DMA32: 520 pages in unavailable ranges
> [    0.011699] On node 0, zone DMA32: 21 pages in unavailable ranges
> [    0.020519] On node 0, zone Normal: 22042 pages in unavailable ranges
> [    0.020555] On node 0, zone Normal: 4096 pages in unavailable ranges
> [    0.020571] Reserving Intel graphics memory at [mem 0x7c000000-0x7fffffff]
> [    0.020910] ACPI: PM-Timer IO Port: 0x1808
> [    0.020918] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
> [    0.020952] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-119
> [    0.020955] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
> [    0.020957] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.020961] ACPI: Using ACPI (MADT) for SMP configuration information
> [    0.020962] ACPI: HPET id: 0x8086a701 base: 0xfed00000
> [    0.020970] e820: update [mem 0x77382000-0x773a6fff] usable ==> reserved
> [    0.020977] TSC deadline timer available
> [    0.020982] CPU topo: Max. logical packages:   1
> [    0.020983] CPU topo: Max. logical dies:       1
> [    0.020984] CPU topo: Max. dies per package:   1
> [    0.020988] CPU topo: Max. threads per core:   2
> [    0.020989] CPU topo: Num. cores per package:     2
> [    0.020989] CPU topo: Num. threads per package:   4
> [    0.020990] CPU topo: Allowing 4 present CPUs plus 0 hotplug CPUs
> [    0.021000] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.021002] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
> [    0.021004] PM: hibernation: Registered nosave memory: [mem 0x77382000-0x773a6fff]
> [    0.021005] PM: hibernation: Registered nosave memory: [mem 0x7a7c0000-0x7a9c7fff]
> [    0.021006] PM: hibernation: Registered nosave memory: [mem 0x7a9d0000-0x7a9e4fff]
> [    0.021008] PM: hibernation: Registered nosave memory: [mem 0x7a9e6000-0xffffffff]
> [    0.021009] [mem 0x80000000-0xffffffff] available for PCI devices
> [    0.021010] Booting paravirtualized kernel on bare hardware
> [    0.021012] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [    0.027952] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
> [    0.028197] percpu: Embedded 62 pages/cpu s217088 r8192 d28672 u524288
> [    0.028203] pcpu-alloc: s217088 r8192 d28672 u524288 alloc=1*2097152
> [    0.028206] pcpu-alloc: [0] 0 1 2 3
> [    0.028223] Kernel command line: BOOT_IMAGE=/vmlinuz-linux-local root=/dev/mapper/VolGroup00-root rw loglevel=3 quiet cryptdevice=UUID=70c55651-98b6-4a3d-9c6a-9f9e70c23225:cryptroot root=/dev/VolGroup00/root
> [    0.028303] Unknown kernel command line parameters "cryptdevice=UUID=70c55651-98b6-4a3d-9c6a-9f9e70c23225:cryptroot", will be passed to user space.
> [    0.028331] random: crng init done
> [    0.028332] printk: log buffer data + meta data: 131072 + 458752 = 589824 bytes
> [    0.029046] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> [    0.029413] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
> [    0.029491] software IO TLB: area num 4.
> [    0.041091] Fallback order for Node 0: 0
> [    0.041094] Built 1 zonelists, mobility grouping on.  Total pages: 2070376
> [    0.041095] Policy zone: Normal
> [    0.041310] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
> [    0.059117] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.059137] Kernel/User page tables isolation: enabled
> [    0.069313] ftrace: allocating 55182 entries in 216 pages
> [    0.069315] ftrace: allocated 216 pages with 4 groups
> [    0.069395] Dynamic Preempt: full
> [    0.069431] rcu: Preemptible hierarchical RCU implementation.
> [    0.069432] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
> [    0.069433] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
> [    0.069438] 	Trampoline variant of Tasks RCU enabled.
> [    0.069439] 	Rude variant of Tasks RCU enabled.
> [    0.069440] 	Tracing variant of Tasks RCU enabled.
> [    0.069442] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
> [    0.069443] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> [    0.069451] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
> [    0.069452] RCU Tasks Rude: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
> [    0.069454] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
> [    0.075790] NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
> [    0.076025] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.076282] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
> [    0.076332] spurious 8259A interrupt: IRQ7.
> [    0.076365] Console: colour dummy device 80x25
> [    0.076367] printk: legacy console [tty0] enabled
> [    0.076409] ACPI: Core revision 20250807
> [    0.076464] hpet: HPET dysfunctional in PC10. Force disabled.
> [    0.076500] APIC: Switch to symmetric I/O mode setup
> [    0.076502] DMAR: Host address width 39
> [    0.076503] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
> [    0.076509] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
> [    0.076511] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
> [    0.076516] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
> [    0.076518] DMAR: RMRR base: 0x0000007b800000 end: 0x0000007fffffff
> [    0.076521] DMAR-IR: IOAPIC id 0 under DRHD base  0xfed91000 IOMMU 1
> [    0.076523] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
> [    0.076524] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
> [    0.078152] DMAR-IR: Enabled IRQ remapping in x2apic mode
> [    0.078154] x2apic enabled
> [    0.078218] APIC: Switched APIC routing to: cluster x2apic
> [    0.082260] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x170fff30cc4, max_idle_ns: 440795237869 ns
> [    0.082265] Calibrating delay loop (skipped), value calculated using timer frequency.. 3199.92 BogoMIPS (lpj=1599960)
> [    0.082290] x86/cpu: SGX disabled or unsupported by BIOS.
> [    0.082295] CPU0: Thermal monitoring enabled (TM1)
> [    0.082336] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
> [    0.082338] Last level dTLB entries: 4KB 64, 2MB 32, 4MB 32, 1GB 4
> [    0.082342] process: using mwait in idle threads
> [    0.082345] mitigations: Enabled attack vectors: user_kernel, user_user, guest_host, guest_guest, SMT mitigations: auto
> [    0.082350] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
> [    0.082351] SRBDS: Mitigation: Microcode
> [    0.082354] Spectre V2 : Mitigation: IBRS
> [    0.082354] RETBleed: Mitigation: IBRS
> [    0.082355] Spectre V2 : User space: Mitigation: STIBP via prctl
> [    0.082356] MDS: Mitigation: Clear CPU buffers
> [    0.082357] MMIO Stale Data: Mitigation: Clear CPU buffers
> [    0.082358] VMSCAPE: Mitigation: IBPB before exit to userspace
> [    0.082359] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [    0.082360] Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on context switch and VMEXIT
> [    0.082362] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [    0.082375] GDS: Mitigation: Microcode
> [    0.082381] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.082383] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.082384] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.082386] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
> [    0.082387] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
> [    0.082389] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.082391] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
> [    0.082393] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
> [    0.082394] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
> [    0.083263] Freeing SMP alternatives memory: 56K
> [    0.083263] pid_max: default: 32768 minimum: 301
> [    0.083263] LSM: initializing lsm=capability,landlock,lockdown,yama,bpf
> [    0.083263] landlock: Up and running.
> [    0.083263] Yama: becoming mindful.
> [    0.083263] LSM support for eBPF active
> [    0.083263] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
> [    0.083263] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
> [    0.083263] smpboot: CPU0: Intel(R) Core(TM) i5-7Y57 CPU @ 1.20GHz (family: 0x6, model: 0x8e, stepping: 0x9)
> [    0.083263] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
> [    0.083263] ... version:                   4
> [    0.083263] ... bit width:                 48
> [    0.083263] ... generic counters:          4
> [    0.083263] ... generic bitmap:            000000000000000f
> [    0.083263] ... fixed-purpose counters:    3
> [    0.083263] ... fixed-purpose bitmap:      0000000000000007
> [    0.083263] ... value mask:                0000ffffffffffff
> [    0.083263] ... max period:                00007fffffffffff
> [    0.083263] ... global_ctrl mask:          000000070000000f
> [    0.083263] signal: max sigframe size: 2032
> [    0.083263] Estimated ratio of average max frequency by base frequency (times 1024): 1856
> [    0.084576] rcu: Hierarchical SRCU implementation.
> [    0.084577] rcu: 	Max phase no-delay instances is 400.
> [    0.084640] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
> [    0.085138] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    0.085184] smp: Bringing up secondary CPUs ...
> [    0.085291] smpboot: x86: Booting SMP configuration:
> [    0.085293] .... node  #0, CPUs:      #1 #2 #3
> [    0.088290] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
> [    0.088290] MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.
> [    0.088291] VMSCAPE: SMT on, STIBP is required for full protection. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/vmscape.html for more details.
> [    0.088319] smp: Brought up 1 node, 4 CPUs
> [    0.088319] smpboot: Total of 4 processors activated (12799.68 BogoMIPS)
> [    0.089319] Memory: 7971252K/8281504K available (19653K kernel code, 2902K rwdata, 10348K rodata, 4624K init, 5140K bss, 297580K reserved, 0K cma-reserved)
> [    0.089592] devtmpfs: initialized
> [    0.089592] x86/mm: Memory block size: 128MB
> [    0.090708] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    0.090708] posixtimers hash table entries: 2048 (order: 3, 32768 bytes, linear)
> [    0.090708] futex hash table entries: 1024 (65536 bytes on 1 NUMA nodes, total 64 KiB, linear).
> [    0.090708] pinctrl core: initialized pinctrl subsystem
> [    0.090708] PM: RTC time: 21:10:23, date: 2025-10-18
> [    0.091639] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.091859] DMA: preallocated 1024 KiB GFP_KERNEL pool for atomic allocations
> [    0.091917] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
> [    0.091972] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> [    0.091980] audit: initializing netlink subsys (disabled)
> [    0.091993] audit: type=2000 audit(1760821823.009:1): state=initialized audit_enabled=0 res=1
> [    0.091993] thermal_sys: Registered thermal governor 'fair_share'
> [    0.091993] thermal_sys: Registered thermal governor 'bang_bang'
> [    0.091993] thermal_sys: Registered thermal governor 'step_wise'
> [    0.091993] thermal_sys: Registered thermal governor 'user_space'
> [    0.091993] thermal_sys: Registered thermal governor 'power_allocator'
> [    0.091993] cpuidle: using governor ladder
> [    0.091993] cpuidle: using governor menu
> [    0.091993] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.092331] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
> [    0.092347] PCI: Using configuration type 1 for base access
> [    0.092495] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
> [    0.097350] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
> [    0.097350] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
> [    0.097350] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.097350] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> [    0.097521] raid6: skipped pq benchmark and selected avx2x4
> [    0.097524] raid6: using avx2x2 recovery algorithm
> [    0.097601] ACPI: Added _OSI(Module Device)
> [    0.097603] ACPI: Added _OSI(Processor Device)
> [    0.097604] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.100965] ACPI: 2 ACPI AML tables successfully acquired and loaded
> [    0.102809] ACPI: EC: EC started
> [    0.102809] ACPI: EC: interrupt blocked
> [    0.102809] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    0.102809] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions
> [    0.102809] ACPI: Interpreter enabled
> [    0.102809] ACPI: PM: (supports S0 S3 S4 S5)
> [    0.102809] ACPI: Using IOAPIC for interrupt routing
> [    0.103032] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.103034] PCI: Ignoring E820 reservations for host bridge windows
> [    0.110755] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.110761] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> [    0.110795] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
> [    0.111409] PCI host bridge to bus 0000:00
> [    0.111414] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.111416] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.111419] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000fffff window]
> [    0.111421] pci_bus 0000:00: root bus resource [mem 0x80000000-0xdfffffff window]
> [    0.111423] pci_bus 0000:00: root bus resource [mem 0x27f000000-0x7fffffffff window]
> [    0.111425] pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7fffff window]
> [    0.111426] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.111455] pci 0000:00:00.0: [8086:590c] type 00 class 0x060000 conventional PCI endpoint
> [    0.111572] pci 0000:00:02.0: [8086:591e] type 00 class 0x030000 PCIe Root Complex Integrated Endpoint
> [    0.111588] pci 0000:00:02.0: BAR 0 [mem 0x90000000-0x90ffffff 64bit]
> [    0.111591] pci 0000:00:02.0: BAR 2 [mem 0x80000000-0x8fffffff 64bit pref]
> [    0.111594] pci 0000:00:02.0: BAR 4 [io  0x1000-0x103f]
> [    0.111607] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [    0.111713] pci 0000:00:04.0: [8086:1903] type 00 class 0x118000 conventional PCI endpoint
> [    0.111732] pci 0000:00:04.0: BAR 0 [mem 0x91120000-0x91127fff 64bit]
> [    0.111890] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330 conventional PCI endpoint
> [    0.111930] pci 0000:00:14.0: BAR 0 [mem 0x91100000-0x9110ffff 64bit]
> [    0.111968] pci 0000:00:14.0: PME# supported from D3hot D3cold
> [    0.112108] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000 conventional PCI endpoint
> [    0.112147] pci 0000:00:14.2: BAR 0 [mem 0x91130000-0x91130fff 64bit]
> [    0.112263] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000 conventional PCI endpoint
> [    0.112327] pci 0000:00:15.0: BAR 0 [mem 0x91131000-0x91131fff 64bit]
> [    0.112484] pci 0000:00:15.1: [8086:9d61] type 00 class 0x118000 conventional PCI endpoint
> [    0.112542] pci 0000:00:15.1: BAR 0 [mem 0x91132000-0x91132fff 64bit]
> [    0.112694] pci 0000:00:15.2: [8086:9d62] type 00 class 0x118000 conventional PCI endpoint
> [    0.112752] pci 0000:00:15.2: BAR 0 [mem 0x91133000-0x91133fff 64bit]
> [    0.112931] pci 0000:00:19.0: [8086:9d66] type 00 class 0x118000 conventional PCI endpoint
> [    0.112989] pci 0000:00:19.0: BAR 0 [mem 0xfe030000-0xfe030fff 64bit]
> [    0.112994] pci 0000:00:19.0: BAR 2 [mem 0x91135000-0x91135fff 64bit]
> [    0.113141] pci 0000:00:19.2: [8086:9d64] type 00 class 0x118000 conventional PCI endpoint
> [    0.113198] pci 0000:00:19.2: BAR 0 [mem 0x91136000-0x91136fff 64bit]
> [    0.113379] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400 PCIe Root Port
> [    0.113403] pci 0000:00:1c.0: PCI bridge to [bus 01]
> [    0.113409] pci 0000:00:1c.0:   bridge window [mem 0x91000000-0x910fffff]
> [    0.113478] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    0.113669] pci 0000:00:1e.0: [8086:9d27] type 00 class 0x118000 conventional PCI endpoint
> [    0.113727] pci 0000:00:1e.0: BAR 0 [mem 0x91137000-0x91137fff 64bit]
> [    0.113732] pci 0000:00:1e.0: BAR 2 [mem 0x91138000-0x91138fff 64bit]
> [    0.113881] pci 0000:00:1e.2: [8086:9d29] type 00 class 0x118000 conventional PCI endpoint
> [    0.113939] pci 0000:00:1e.2: BAR 0 [mem 0x91139000-0x91139fff 64bit]
> [    0.114092] pci 0000:00:1e.4: [8086:9d2b] type 00 class 0x080501 conventional PCI endpoint
> [    0.114145] pci 0000:00:1e.4: BAR 0 [mem 0x9113a000-0x9113afff 64bit]
> [    0.114415] pci 0000:00:1f.0: [8086:9d4b] type 00 class 0x060100 conventional PCI endpoint
> [    0.114585] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000 conventional PCI endpoint
> [    0.114629] pci 0000:00:1f.2: BAR 0 [mem 0x91128000-0x9112bfff]
> [    0.114731] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040100 conventional PCI endpoint
> [    0.114784] pci 0000:00:1f.3: BAR 0 [mem 0x9112c000-0x9112ffff 64bit]
> [    0.114791] pci 0000:00:1f.3: BAR 4 [mem 0x91110000-0x9111ffff 64bit]
> [    0.114834] pci 0000:00:1f.3: PME# supported from D3hot D3cold
> [    0.115021] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500 conventional PCI endpoint
> [    0.115155] pci 0000:00:1f.4: BAR 0 [mem 0x9113c000-0x9113c0ff 64bit]
> [    0.115166] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
> [    0.115283] pci 0000:00:1f.5: [8086:9d24] type 00 class 0x000000 conventional PCI endpoint
> [    0.115330] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
> [    0.115692] pci 0000:01:00.0: [8086:095a] type 00 class 0x028000 PCIe Endpoint
> [    0.115830] pci 0000:01:00.0: BAR 0 [mem 0x91000000-0x91001fff 64bit]
> [    0.116077] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> [    0.117020] pci 0000:00:1c.0: PCI bridge to [bus 01]
> [    0.117420] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
> [    0.117503] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
> [    0.117581] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
> [    0.117658] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
> [    0.117735] ACPI: PCI: Interrupt link LNKE configured for IRQ 11
> [    0.117813] ACPI: PCI: Interrupt link LNKF configured for IRQ 11
> [    0.117890] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
> [    0.117967] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
> [    0.120047] ACPI: EC: interrupt unblocked
> [    0.120049] ACPI: EC: event unblocked
> [    0.120056] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    0.120057] ACPI: EC: GPE=0x6e
> [    0.120059] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC initialization complete
> [    0.120061] ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions and events
> [    0.120285] iommu: Default domain type: Translated
> [    0.120285] iommu: DMA domain TLB invalidation policy: lazy mode
> [    0.123452] SCSI subsystem initialized
> [    0.124285] libata version 3.00 loaded.
> [    0.124285] ACPI: bus type USB registered
> [    0.124305] usbcore: registered new interface driver usbfs
> [    0.124315] usbcore: registered new interface driver hub
> [    0.124322] usbcore: registered new device driver usb
> [    0.124365] EDAC MC: Ver: 3.0.0
> [    0.124624] efivars: Registered efivars operations
> [    0.124624] NetLabel: Initializing
> [    0.124624] NetLabel:  domain hash size = 128
> [    0.124624] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    0.124624] NetLabel:  unlabeled traffic allowed by default
> [    0.124624] mctp: management component transport protocol core
> [    0.124624] NET: Registered PF_MCTP protocol family
> [    0.124624] PCI: Using ACPI for IRQ routing
> [    0.154247] PCI: pci_cache_line_size set to 64 bytes
> [    0.154633] e820: reserve RAM buffer [mem 0x77382000-0x77ffffff]
> [    0.154636] e820: reserve RAM buffer [mem 0x7a7c0000-0x7bffffff]
> [    0.154637] e820: reserve RAM buffer [mem 0x7a9d0000-0x7bffffff]
> [    0.154639] e820: reserve RAM buffer [mem 0x7a9e6000-0x7bffffff]
> [    0.154640] e820: reserve RAM buffer [mem 0x27f000000-0x27fffffff]
> [    0.154676] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> [    0.154676] pci 0000:00:02.0: vgaarb: bridge control possible
> [    0.154676] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [    0.154676] vgaarb: loaded
> [    0.154676] clocksource: Switched to clocksource tsc-early
> [    0.155273] VFS: Disk quotas dquot_6.6.0
> [    0.155273] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.156159] pnp: PnP ACPI init
> [    0.156288] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
> [    0.156415] system 00:01: [mem 0xfed10000-0xfed17fff] has been reserved
> [    0.156418] system 00:01: [mem 0xfed18000-0xfed18fff] has been reserved
> [    0.156420] system 00:01: [mem 0xfed19000-0xfed19fff] has been reserved
> [    0.156423] system 00:01: [mem 0xfed90000-0xfed93fff] could not be reserved
> [    0.156425] system 00:01: [mem 0xff000000-0xffffffff] has been reserved
> [    0.156427] system 00:01: [mem 0xfee00000-0xfeefffff] has been reserved
> [    0.156429] system 00:01: [mem 0xfed00000-0xfed003ff] has been reserved
> [    0.156665] system 00:02: [mem 0xfed00000-0xfed003ff] has been reserved
> [    0.156706] system 00:03: [io  0x1800-0x18fe] has been reserved
> [    0.156761] system 00:05: [io  0x0900-0x09fe] has been reserved
> [    0.156798] system 00:06: [io  0x0200] has been reserved
> [    0.156801] system 00:06: [io  0x0204] has been reserved
> [    0.156802] system 00:06: [io  0x0800-0x087f] has been reserved
> [    0.156804] system 00:06: [io  0x0880-0x08ff] has been reserved
> [    0.157410] pnp: PnP ACPI: found 8 devices
> [    0.163371] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    0.163445] NET: Registered PF_INET protocol family
> [    0.163545] IP idents hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> [    0.164829] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
> [    0.164880] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
> [    0.164922] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
> [    0.165064] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
> [    0.165271] TCP: Hash tables configured (established 65536 bind 65536)
> [    0.165334] MPTCP token hash table entries: 8192 (order: 5, 196608 bytes, linear)
> [    0.165370] UDP hash table entries: 4096 (order: 6, 262144 bytes, linear)
> [    0.165406] UDP-Lite hash table entries: 4096 (order: 6, 262144 bytes, linear)
> [    0.165460] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    0.165466] NET: Registered PF_XDP protocol family
> [    0.165474] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
> [    0.165478] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
> [    0.165488] pci 0000:00:1c.0: bridge window [mem 0x27f000000-0x27f1fffff 64bit pref]: assigned
> [    0.165491] pci 0000:00:1c.0: bridge window [io  0x2000-0x2fff]: assigned
> [    0.165494] pci 0000:00:1c.0: PCI bridge to [bus 01]
> [    0.165506] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
> [    0.165510] pci 0000:00:1c.0:   bridge window [mem 0x91000000-0x910fffff]
> [    0.165513] pci 0000:00:1c.0:   bridge window [mem 0x27f000000-0x27f1fffff 64bit pref]
> [    0.165519] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    0.165521] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    0.165522] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000fffff window]
> [    0.165524] pci_bus 0000:00: resource 7 [mem 0x80000000-0xdfffffff window]
> [    0.165525] pci_bus 0000:00: resource 8 [mem 0x27f000000-0x7fffffffff window]
> [    0.165527] pci_bus 0000:00: resource 9 [mem 0xfc800000-0xfe7fffff window]
> [    0.165529] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
> [    0.165530] pci_bus 0000:01: resource 1 [mem 0x91000000-0x910fffff]
> [    0.165531] pci_bus 0000:01: resource 2 [mem 0x27f000000-0x27f1fffff 64bit pref]
> [    0.166044] PCI: CLS 64 bytes, default 64
> [    0.166094] pci 0000:00:1f.1: [8086:9d20] type 00 class 0x058000 conventional PCI endpoint
> [    0.166250] pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]
> [    0.166423] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    0.166424] software IO TLB: mapped [mem 0x000000006d80f000-0x000000007180f000] (64MB)
> [    0.166478] Unpacking initramfs...
> [    0.172544] Initialise system trusted keyrings
> [    0.172556] Key type blacklist registered
> [    0.172627] workingset: timestamp_bits=36 max_order=21 bucket_order=0
> [    0.172958] fuse: init (API version 7.45)
> [    0.173070] integrity: Platform Keyring initialized
> [    0.173074] integrity: Machine keyring initialized
> [    0.191994] xor: automatically using best checksumming function   avx
> [    0.192000] Key type asymmetric registered
> [    0.192003] Asymmetric key parser 'x509' registered
> [    0.192035] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
> [    0.192134] io scheduler mq-deadline registered
> [    0.192136] io scheduler kyber registered
> [    0.192168] io scheduler bfq registered
> [    0.196120] ledtrig-cpu: registered to indicate activity on CPUs
> [    0.196393] pcieport 0000:00:1c.0: PME: Signaling with IRQ 120
> [    0.196506] pcieport 0000:00:1c.0: AER: enabled with IRQ 120
> [    0.196539] pcieport 0000:00:1c.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> [    0.196802] pcieport 0000:00:1c.0: pciehp: Slot(0): Card not present
> [    0.196925] pcieport 0000:00:1c.0: pciehp: Slot(0): Card present
> [    0.196927] pcieport 0000:00:1c.0: pciehp: Slot(0): Link Up
> [    0.197253] ACPI: AC: AC Adapter [AC] (on-line)
> [    0.197307] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:06/PNP0C09:00/PNP0C0D:00/input/input0
> [    0.198136] ACPI: button: Lid Switch [LID0]
> [    0.198180] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
> [    0.198229] ACPI: button: Power Button [PWRF]
> [    0.198346] Monitor-Mwait will be used to enter C-1 state
> [    0.198356] Monitor-Mwait will be used to enter C-2 state
> [    0.198364] Monitor-Mwait will be used to enter C-3 state
> [    0.198761] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [    0.200509] ACPI: battery: Slot [BAT0] (battery present)
> [    0.201500] hpet_acpi_add: no address or irqs in _CRS
> [    0.201539] Non-volatile memory driver v1.3
> [    0.201541] Linux agpgart interface v0.103
> [    0.201597] ACPI: bus type drm_connector registered
> [    0.202134] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    0.202141] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
> [    0.203247] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000081109810
> [    0.203575] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    0.203579] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
> [    0.203582] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
> [    0.203628] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.18
> [    0.203630] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    0.203632] usb usb1: Product: xHCI Host Controller
> [    0.203634] usb usb1: Manufacturer: Linux 6.18.0-rc1-local-00203-g6f3b6e91f720 xhci-hcd
> [    0.203636] usb usb1: SerialNumber: 0000:00:14.0
> [    0.203764] hub 1-0:1.0: USB hub found
> [    0.203791] hub 1-0:1.0: 12 ports detected
> [    0.204190] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.18
> [    0.204193] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    0.204195] usb usb2: Product: xHCI Host Controller
> [    0.204197] usb usb2: Manufacturer: Linux 6.18.0-rc1-local-00203-g6f3b6e91f720 xhci-hcd
> [    0.204198] usb usb2: SerialNumber: 0000:00:14.0
> [    0.204291] hub 2-0:1.0: USB hub found
> [    0.204313] hub 2-0:1.0: 6 ports detected
> [    0.204573] usbcore: registered new interface driver usbserial_generic
> [    0.204579] usbserial: USB Serial support registered for generic
> [    0.204610] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
> [    0.204612] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
> [    0.205478] i8042: Warning: Keylock active
> [    0.205738] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    0.205881] rtc_cmos 00:04: RTC can wake from S4
> [    0.206592] rtc_cmos 00:04: registered as rtc0
> [    0.206732] rtc_cmos 00:04: setting system clock to 2025-10-18T21:10:23 UTC (1760821823)
> [    0.206770] rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram
> [    0.206856] intel_pstate: Intel P-state driver initializing
> [    0.207016] intel_pstate: HWP enabled
> [    0.207246] simple-framebuffer simple-framebuffer.0: [drm] Registered 1 planes with drm panic
> [    0.207249] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 on minor 0
> [    0.209363] fbcon: Deferring console take-over
> [    0.209367] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
> [    0.209417] hid: raw HID events driver (C) Jiri Kosina
> [    0.209449] usbcore: registered new interface driver usbhid
> [    0.209451] usbhid: USB HID core driver
> [    0.209537] drop_monitor: Initializing network drop monitor service
> [    0.209632] NET: Registered PF_INET6 protocol family
> [    0.210042] Segment Routing with IPv6
> [    0.210043] RPL Segment Routing with IPv6
> [    0.210051] In-situ OAM (IOAM) with IPv6
> [    0.210074] NET: Registered PF_PACKET protocol family
> [    0.212134] microcode: Current revision: 0x000000f6
> [    0.212136] microcode: Updated early from: 0x000000f4
> [    0.212209] IPI shorthand broadcast: enabled
> [    0.213660] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
> [    0.214998] sched_clock: Marking stable (208002134, 6104162)->(260101971, -45995675)
> [    0.215163] registered taskstats version 1
> [    0.215278] Loading compiled-in X.509 certificates
> [    0.245607] Freeing initrd memory: 32324K
> [    0.252000] Loaded X.509 cert 'Build time autogenerated kernel key: e31fb6d0a47fcad14d2a2827e4b138b36bae4b21'
> [    0.255096] zswap: loaded using pool zstd
> [    0.255271] Demotion targets for Node 0: null
> [    0.255562] Key type .fscrypt registered
> [    0.255564] Key type fscrypt-provisioning registered
> [    0.255822] Btrfs loaded, zoned=yes, fsverity=yes
> [    0.255841] Key type big_key registered
> [    0.255877] integrity: Loading X.509 certificate: UEFI:db
> [    0.255902] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
> [    0.255904] integrity: Loading X.509 certificate: UEFI:db
> [    0.255919] integrity: Loaded X.509 cert 'Microsoft Corporation: Windows UEFI CA 2023: aefc5fbbbe055d8f8daa585473499417ab5a5272'
> [    0.255920] integrity: Loading X.509 certificate: UEFI:db
> [    0.255934] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
> [    0.255935] integrity: Loading X.509 certificate: UEFI:db
> [    0.255948] integrity: Loaded X.509 cert 'Microsoft UEFI CA 2023: 81aa6b3244c935bce0d6628af39827421e32497d'
> [    0.255950] integrity: Loading X.509 certificate: UEFI:db
> [    0.259490] integrity: Loaded X.509 cert 'System76 Secure Boot Database Key: 3a7a94cfb9868ddcd29105224b504d54b1f9d238'
> [    0.260718] PM:   Magic number: 13:223:197
> [    0.260764] acpi PNP0100:00: hash matches
> [    0.260811] RAS: Correctable Errors collector initialized.
> [    0.260843] clk: Disabling unused clocks
> [    0.262016] Freeing unused decrypted memory: 2036K
> [    0.262768] Freeing unused kernel image (initmem) memory: 4624K
> [    0.262870] Write protecting the kernel read-only data: 32768k
> [    0.263286] Freeing unused kernel image (text/rodata gap) memory: 824K
> [    0.263806] Freeing unused kernel image (rodata/data gap) memory: 1940K
> [    0.313739] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    0.313744] rodata_test: all tests were successful
> [    0.313746] x86/mm: Checking user space page tables
> [    0.383969] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    0.383974] Run /init as init process
> [    0.383976]   with arguments:
> [    0.383977]     /init
> [    0.383978]   with environment:
> [    0.383979]     HOME=/
> [    0.383980]     TERM=linux
> [    0.383981]     cryptdevice=UUID=70c55651-98b6-4a3d-9c6a-9f9e70c23225:cryptroot
> [    0.461131] usb 1-2: new high-speed USB device number 2 using xhci_hcd
> [    0.601446] usb 1-2: New USB device found, idVendor=0bda, idProduct=564b, bcdDevice= 0.06
> [    0.601454] usb 1-2: New USB device strings: Mfr=3, Product=1, SerialNumber=2
> [    0.601458] usb 1-2: Product: WebCamera
> [    0.601460] usb 1-2: Manufacturer: Generic
> [    0.601462] usb 1-2: SerialNumber: \x07LOE65001063010A7B100DF5AI06BF12000
> [    0.697154] usb 2-2: new SuperSpeed USB device number 2 using xhci_hcd
> [    0.698951] sdhci: Secure Digital Host Controller Interface driver
> [    0.698958] sdhci: Copyright(c) Pierre Ossman
> [    0.708576] usb 2-2: New USB device found, idVendor=1d5c, idProduct=5001, bcdDevice= 1.00
> [    0.708583] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    0.708586] usb 2-2: Product: USB3.0 Hub
> [    0.708589] usb 2-2: Manufacturer: Fresco Logic, Inc.
> [    0.709438] hub 2-2:1.0: USB hub found
> [    0.710112] hub 2-2:1.0: 4 ports detected
> [    0.719650] sdhci-pci 0000:00:1e.4: SDHCI controller found [8086:9d2b] (rev 21)
> [    0.720149] mmc0: SDHCI controller on PCI [0000:00:1e.4] using ADMA 64-bit
> [    0.816811] mmc0: new HS400 MMC card at address 0001
> [    0.823132] usb 1-3: new full-speed USB device number 3 using xhci_hcd
> [    0.947335] usb 1-3: New USB device found, idVendor=8087, idProduct=0a2a, bcdDevice= 0.03
> [    0.947339] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    1.060112] usb 1-5: new high-speed USB device number 4 using xhci_hcd
> [    1.183476] usb 1-5: New USB device found, idVendor=1d5c, idProduct=5011, bcdDevice= 1.00
> [    1.183481] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    1.183484] usb 1-5: Product: USB2.0 Hub
> [    1.183486] usb 1-5: Manufacturer: Fresco Logic, Inc.
> [    1.184313] hub 1-5:1.0: USB hub found
> [    1.184339] hub 1-5:1.0: 5 ports detected
> [    1.202131] tsc: Refined TSC clocksource calibration: 1608.000 MHz
> [    1.202139] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x172daa3a18b, max_idle_ns: 440795212390 ns
> [    1.202156] clocksource: Switched to clocksource tsc
> [    1.251011] usb 2-2.4: new SuperSpeed USB device number 3 using xhci_hcd
> [    1.400127] pcieport 0000:00:1c.0: pciehp: Slot(0): No device found
> [    1.408639] i915 0000:00:02.0: [drm] Found kabylake/ulx (device ID 591e) integrated display version 9.00 stepping B0
> [    1.413103] mmcblk0: mmc0:0001 DURM4R 116 GiB
> [    1.419538]  mmcblk0: p1 p2
> [    1.419806] mmcblk0boot0: mmc0:0001 DURM4R 4.00 MiB
> [    1.420507] mmcblk0boot1: mmc0:0001 DURM4R 4.00 MiB
> [    1.421061] mmcblk0rpmb: mmc0:0001 DURM4R 4.00 MiB, chardev (239:0)
> [    1.425660] i915 0000:00:02.0: vgaarb: deactivate vga console
> [    1.476640] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [    1.478624] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
> [    1.504648] i915 0000:00:02.0: [drm] Registered 3 planes with drm panic
> [    1.504661] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 1
> [    1.505235] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
> [    1.505472] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input3
> [    1.537542] usb 2-2.4: New USB device found, idVendor=0b95, idProduct=1790, bcdDevice= 2.00
> [    1.537547] usb 2-2.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    1.537551] usb 2-2.4: Product: AX88179A
> [    1.537553] usb 2-2.4: Manufacturer: ASIX
> [    1.537555] usb 2-2.4: SerialNumber: 00A0CEC83D617A
> [    1.548656] fbcon: i915drmfb (fb0) is primary device
> [    1.548661] fbcon: Deferring console take-over
> [    1.548665] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
> [    1.626802] device-mapper: uevent: version 1.0.3
> [    1.626879] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
> [    1.643281] Key type encrypted registered
> [    1.662391] fbcon: Taking over console
> [    1.702574] Console: switching to colour frame buffer device 150x50
> [    1.716119] usb 1-5.5: new high-speed USB device number 5 using xhci_hcd
> [    1.800655] usb 1-5.5: New USB device found, idVendor=1d5c, idProduct=5100, bcdDevice= 1.00
> [    1.800665] usb 1-5.5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    1.800669] usb 1-5.5: Product: Generic Billboard Device
> [    1.800673] usb 1-5.5: Manufacturer: Fresco Logic, Inc
> [    9.381975] BTRFS: device label data devid 1 transid 94512 /dev/mapper/VolGroup00-root (253:1) scanned by mount (302)
> [    9.382550] BTRFS info (device dm-1): first mount of filesystem 300f4e51-7c51-404c-96d9-1b224c97606d
> [    9.382566] BTRFS info (device dm-1): using crc32c (crc32c-lib) checksum algorithm
> [    9.419939] BTRFS info (device dm-1): enabling ssd optimizations
> [    9.419947] BTRFS info (device dm-1): turning on async discard
> [    9.419950] BTRFS info (device dm-1): enabling free space tree
> [    9.702625] systemd[1]: systemd 258.1-1-arch running in system mode (+PAM +AUDIT -SELINUX +APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINIT +LIBARCHIVE)
> [    9.702639] systemd[1]: Detected architecture x86-64.
> [    9.703699] systemd[1]: Hostname set to <pixelbook>.
> [    9.792379] systemd[1]: bpf-restrict-fs: Failed to load BPF object: No such process
> [   10.326434] systemd[1]: Queued start job for default target Graphical Interface.
> [   10.348754] systemd[1]: Created slice Slice /system/dirmngr.
> [   10.349307] systemd[1]: Created slice Slice /system/getty.
> [   10.349761] systemd[1]: Created slice Slice /system/gpg-agent.
> [   10.350258] systemd[1]: Created slice Slice /system/gpg-agent-browser.
> [   10.350580] systemd[1]: Created slice Slice /system/gpg-agent-extra.
> [   10.350900] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
> [   10.351262] systemd[1]: Created slice Slice /system/keyboxd.
> [   10.351587] systemd[1]: Created slice Slice /system/modprobe.
> [   10.351902] systemd[1]: Created slice Slice /system/systemd-fsck.
> [   10.352192] systemd[1]: Created slice User and Session Slice.
> [   10.352256] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
> [   10.352307] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
> [   10.352492] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
> [   10.352513] systemd[1]: Expecting device /dev/disk/by-uuid/8178-5AD1...
> [   10.352525] systemd[1]: Reached target Local Encrypted Volumes.
> [   10.352544] systemd[1]: Reached target Image Downloads.
> [   10.352553] systemd[1]: Reached target Local Integrity Protected Volumes.
> [   10.352569] systemd[1]: Reached target Path Units.
> [   10.352582] systemd[1]: Reached target Remote File Systems.
> [   10.352591] systemd[1]: Reached target Slice Units.
> [   10.352619] systemd[1]: Reached target Local Verity Protected Volumes.
> [   10.352700] systemd[1]: Listening on Device-mapper event daemon FIFOs.
> [   10.352775] systemd[1]: Listening on LVM2 poll daemon socket.
> [   10.353679] systemd[1]: Listening on Query the User Interactively for a Password.
> [   10.354771] systemd[1]: Listening on Process Core Dump Socket.
> [   10.355419] systemd[1]: Listening on Credential Encryption/Decryption.
> [   10.356321] systemd[1]: Listening on Factory Reset Management.
> [   10.356425] systemd[1]: Listening on Journal Socket (/dev/log).
> [   10.356517] systemd[1]: Listening on Journal Sockets.
> [   10.356928] systemd[1]: TPM PCR Measurements was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   10.356950] systemd[1]: Make TPM PCR Policy was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   10.357038] systemd[1]: Listening on udev Control Socket.
> [   10.357098] systemd[1]: Listening on udev Kernel Socket.
> [   10.357203] systemd[1]: Listening on udev Varlink Socket.
> [   10.357271] systemd[1]: Listening on User Database Manager Socket.
> [   10.360041] systemd[1]: Mounting Huge Pages File System...
> [   10.361142] systemd[1]: Mounting POSIX Message Queue File System...
> [   10.362415] systemd[1]: Mounting Kernel Debug File System...
> [   10.363564] systemd[1]: Mounting Kernel Trace File System...
> [   10.367005] systemd[1]: Starting Create List of Static Device Nodes...
> [   10.368390] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
> [   10.368440] systemd[1]: Load Kernel Module configfs was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!configfs).
> [   10.369759] systemd[1]: Mounting Kernel Configuration File System...
> [   10.369840] systemd[1]: Load Kernel Module dm_mod was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!dm_mod).
> [   10.369901] systemd[1]: Load Kernel Module drm was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!drm).
> [   10.369953] systemd[1]: Load Kernel Module fuse was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!fuse).
> [   10.373291] systemd[1]: Mounting FUSE Control File System...
> [   10.376196] systemd[1]: Starting Load Kernel Module loop...
> [   10.376286] systemd[1]: Clear Stale Hibernate Storage Info was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
> [   10.379326] systemd[1]: Starting Journal Service...
> [   10.383688] systemd[1]: Starting Load Kernel Modules...
> [   10.383723] systemd[1]: TPM PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   10.390195] systemd[1]: Starting Remount Root and Kernel File Systems...
> [   10.390317] systemd[1]: Early TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   10.393256] systemd[1]: Starting Load udev Rules from Credentials...
> [   10.395497] systemd[1]: Starting Coldplug All udev Devices...
> [   10.412631] loop: module loaded
> [   10.413076] systemd[1]: Mounted Huge Pages File System.
> [   10.413404] systemd[1]: Mounted POSIX Message Queue File System.
> [   10.413579] systemd[1]: Mounted Kernel Debug File System.
> [   10.413772] systemd[1]: Mounted Kernel Trace File System.
> [   10.414320] systemd[1]: Finished Create List of Static Device Nodes.
> [   10.414646] systemd[1]: Mounted Kernel Configuration File System.
> [   10.414838] systemd[1]: Mounted FUSE Control File System.
> [   10.415343] systemd[1]: modprobe@loop.service: Deactivated successfully.
> [   10.415757] BTRFS info (device dm-1 state M): turning on sync discard
> [   10.415762] BTRFS info (device dm-1 state M): enabling auto defrag
> [   10.415765] BTRFS info (device dm-1 state M): use lzo compression, level 1
> [   10.416174] systemd[1]: Finished Load Kernel Module loop.
> [   10.418448] systemd[1]: Repartition Root Disk was skipped because no trigger condition checks were met.
> [   10.422327] systemd[1]: Starting Create Static Device Nodes in /dev gracefully...
> [   10.426240] systemd[1]: Finished Remount Root and Kernel File Systems.
> [   10.428205] systemd[1]: Finished Load udev Rules from Credentials.
> [   10.429701] systemd[1]: Finished Load Kernel Modules.
> [   10.431501] systemd[1]: Activating swap /swap/swapfile...
> [   10.433097] systemd[1]: Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
> [   10.433401] systemd-journald[369]: Collecting audit messages is disabled.
> [   10.441090] systemd[1]: Starting Load/Save OS Random Seed...
> [   10.445236] systemd[1]: Starting Apply Kernel Variables...
> [   10.445286] systemd[1]: TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   10.449289] Adding 2097148k swap on /swap/swapfile.  Priority:-2 extents:2 across:2228220k SS
> [   10.450570] systemd[1]: Activated swap /swap/swapfile.
> [   10.451011] systemd[1]: Reached target Swaps.
> [   10.455230] systemd[1]: Mounting Temporary Directory /tmp...
> [   10.457185] systemd[1]: Finished Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling.
> [   10.498662] systemd[1]: Started Journal Service.
> [   10.548500] systemd-journald[369]: Received client request to flush runtime journal.
> [   11.450992] cros_ec_lpcs GOOG0004:00: Chrome EC device registered
> [   11.460499] intel_pmc_core INT33A1:00:  initialized
> [   11.492489] input: Tablet Mode Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:06/PNP0C09:00/GOOG0004:00/GOOG0006:00/input/input4
> [   11.561074] idma64 idma64.0: Found Intel integrated DMA 64-bit
> [   11.567530] idma64 idma64.1: Found Intel integrated DMA 64-bit
> [   11.583077] cr50_i2c i2c-GOOG0005:00: cr50 TPM 2.0 (i2c 0x50 irq 24 id 0x28)
> [   11.602439] i801_smbus 0000:00:1f.4: SPD Write Disable is set
> [   11.602457] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
> [   11.622699] input: PC Speaker as /devices/platform/pcspkr/input/input5
> [   11.718329] input: WCOM50C1:00 2D1F:5143 Touchscreen as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input6
> [   11.718435] input: WCOM50C1:00 2D1F:5143 as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input7
> [   11.718527] input: WCOM50C1:00 2D1F:5143 Stylus as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input8
> [   11.718612] input: WCOM50C1:00 2D1F:5143 as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input9
> [   11.720179] input: WCOM50C1:00 2D1F:5143 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input10
> [   11.720680] hid-generic 0018:2D1F:5143.0001: input,hidraw0: I2C HID v1.00 Mouse [WCOM50C1:00 2D1F:5143] on i2c-WCOM50C1:00
> [   11.876421] idma64 idma64.2: Found Intel integrated DMA 64-bit
> [   12.011159] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [   12.030168] input: ACPI0C50:00 18D1:5028 as /devices/pci0000:00/0000:00:15.2/i2c_designware.2/i2c-9/i2c-ACPI0C50:00/0018:18D1:5028.0002/input/input11
> [   12.030247] hid-generic 0018:18D1:5028.0002: input,hidraw1: I2C HID v1.00 Device [ACPI0C50:00 18D1:5028] on i2c-ACPI0C50:00
> [   12.033381] input: keyd virtual keyboard as /devices/virtual/input/input12
> [   12.055649] input: keyd virtual pointer as /devices/virtual/input/input13
> [   12.064322] spi-nor spi0.0: supply vcc not found, using dummy regulator
> [   12.080067] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
> [   12.080073] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> [   12.080075] RAPL PMU: hw unit of domain package 2^-14 Joules
> [   12.080077] RAPL PMU: hw unit of domain dram 2^-14 Joules
> [   12.080079] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> [   12.080079] Creating 1 MTD partitions on "0000:00:1f.5":
> [   12.080081] RAPL PMU: hw unit of domain psys 2^-14 Joules
> [   12.080084] 0x000000000000-0x000001000000 : "BIOS"
> [   12.302847] iTCO_vendor_support: vendor-support=0
> [   12.303291] intel_rapl_common: Found RAPL domain package
> [   12.303295] intel_rapl_common: Found RAPL domain core
> [   12.303297] intel_rapl_common: Found RAPL domain uncore
> [   12.303299] intel_rapl_common: Found RAPL domain dram
> [   12.303301] intel_rapl_common: Found RAPL domain psys
> [   12.359803] mousedev: PS/2 mouse device common for all mice
> [   12.544357] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
> [   12.550433] iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
> [   12.654756] cros-usbpd-charger cros-usbpd-charger.7.auto: Could not get charger port count
> [   12.660535] ACPI: battery: new hook: cros-charge-control.6.auto
> [   12.748126] snd_soc_avs 0000:00:1f.3: bound 0000:00:02.0 (ops intel_audio_component_bind_ops [i915])
> [   12.775124] intel_tcc_cooling: Programmable TCC Offset detected
> [   12.815699] cros-ec-dev cros-ec-dev.19.auto: CrOS Touchpad MCU detected
> [   12.845670] gpio gpiochip2: Detected name collision for GPIO name 'EC:I2C1_SCL'
> [   12.845678] gpio gpiochip2: Detected name collision for GPIO name 'EC:I2C1_SDA'
> [   12.845683] gpio gpiochip2: Detected name collision for GPIO name 'EC:ENTERING_RW'
> [   12.845686] gpio gpiochip2: Detected name collision for GPIO name 'EC:WP_L'
> [   12.885059] intel_rapl_common: Found RAPL domain package
> [   12.885064] intel_rapl_common: Found RAPL domain dram
> [   12.905669] cros-ec-i2c i2c-GOOG0008:00: Chrome EC device registered
> [   12.930053] max98927 i2c-MX98927:00: MAX98927 revisionID: 0x42
> [   12.935170] max98927 i2c-MX98927:01: MAX98927 revisionID: 0x42
> [   12.935406] rt5663 i2c-10EC5663:00: supply avdd not found, using dummy regulator
> [   12.935444] rt5663 i2c-10EC5663:00: supply cpvdd not found, using dummy regulator
> [   12.977054] snd_hda_codec_intelhdmi hdaudioB0D2: creating for HDMI 0 0
> [   12.977061] snd_hda_codec_intelhdmi hdaudioB0D2: skipping capture dai for HDMI 0
> [   12.977064] snd_hda_codec_intelhdmi hdaudioB0D2: creating for HDMI 1 1
> [   12.977067] snd_hda_codec_intelhdmi hdaudioB0D2: skipping capture dai for HDMI 1
> [   12.977070] snd_hda_codec_intelhdmi hdaudioB0D2: creating for HDMI 2 2
> [   12.977073] snd_hda_codec_intelhdmi hdaudioB0D2: skipping capture dai for HDMI 2
> [   12.978185] avs_hdaudio avs_hdaudio.25.auto: ASoC: Parent card not yet available, widget card binding deferred
> [   12.978296] avs_hdaudio avs_hdaudio.25.auto: avs_card_late_probe: mapping HDMI converter 1 to PCM 0 (000000001eda508f)
> [   12.978303] avs_hdaudio avs_hdaudio.25.auto: avs_card_late_probe: mapping HDMI converter 2 to PCM 0 (00000000d43fd9be)
> [   12.978308] avs_hdaudio avs_hdaudio.25.auto: avs_card_late_probe: mapping HDMI converter 3 to PCM 0 (000000001200180a)
> [   12.981090] avs_hdaudio avs_hdaudio.25.auto: control 3:0:0:ELD:0 is already present
> [   12.981097] snd_hda_codec_intelhdmi hdaudioB0D2: unable to create controls -16
> [   12.981100] avs_hdaudio avs_hdaudio.25.auto: ASoC error (-16): at snd_soc_card_late_probe() on AVS HDMI
> [   12.982389] avs_hdaudio avs_hdaudio.25.auto: probe with driver avs_hdaudio failed with error -16
> [   12.984174] avs_max98927 avs_max98927.22.auto: ASoC: Parent card not yet available, widget card binding deferred
> [   13.060994] cros-ec-activity cros-ec-activity.18.auto: Unknown activity: 2
> [   13.385770] Bluetooth: Core ver 2.22
> [   13.385794] NET: Registered PF_BLUETOOTH protocol family
> [   13.385796] Bluetooth: HCI device and connection manager initialized
> [   13.385802] Bluetooth: HCI socket layer initialized
> [   13.385805] Bluetooth: L2CAP socket layer initialized
> [   13.385811] Bluetooth: SCO socket layer initialized
> [   13.417832] usbcore: registered new interface driver btusb
> [   13.427559] Bluetooth: hci0: Legacy ROM 2.x revision 5.0 build 25 week 20 2015
> [   13.436179] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
> [   13.499567] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [   13.499573] Bluetooth: BNEP filters: protocol multicast
> [   13.499579] Bluetooth: BNEP socket layer initialized
> [   13.521388] mc: Linux media interface: v0.10
> [   13.548958] videodev: Linux video capture interface: v2.00
> [   13.577251] uvcvideo 1-2:1.0: Found UVC 1.00 device WebCamera (0bda:564b)
> [   13.581266] usbcore: registered new interface driver uvcvideo
> [   13.777821] Bluetooth: hci0: Intel BT fw patch 0x43 completed & activated
> [   13.834087] Bluetooth: MGMT ver 1.23
> [   13.855319] NET: Registered PF_ALG protocol family
> [   14.076080] usbcore: registered new interface driver cdc_ether
> [   14.232203] avs_rt5663 avs_rt5663.24.auto: ASoC: Parent card not yet available, widget card binding deferred
> [   14.233453] rt5663 i2c-10EC5663:00: sysclk < 384 x fs, disable i2s asrc
> [   14.233776] input: AVS I2S ALC5663 Headset Jack as /devices/platform/avs_rt5663.24.auto/sound/card2/input16
> [   14.243469] avs_rt5514 avs_rt5514.23.auto: ASoC: Parent card not yet available, widget card binding deferred
> [   14.248238] idma64 idma64.5: Found Intel integrated DMA 64-bit
> [   14.249329] idma64 idma64.6: Found Intel integrated DMA 64-bit
> [   14.303841] cdc_ncm 2-2.4:2.0: MAC-Address: __CENSORED__
> [   14.303850] cdc_ncm 2-2.4:2.0: setting rx_max = 16384
> [   14.317617] cdc_ncm 2-2.4:2.0: setting tx_max = 16384
> [   14.329666] cdc_ncm 2-2.4:2.0 eth0: register 'cdc_ncm' at usb-0000:00:14.0-2.4, CDC NCM (NO ZLP), __CENSORED__
> [   14.329829] dw-apb-uart.3: ttyS4 at MMIO 0xfe030000 (irq = 32, base_baud = 115200) is a 16550A
> [   14.335210] dw-apb-uart.5: ttyS5 at MMIO 0x91137000 (irq = 20, base_baud = 7500000) is a 16550A
> [   14.342895] usbcore: registered new interface driver cdc_ncm
> [   14.358054] usbcore: registered new interface driver cdc_wdm
> [   14.366640] usbcore: registered new interface driver cdc_mbim
> [   14.376015] cdc_ncm 2-2.4:2.0 enp0s20f0u2u4c2: renamed from eth0
> [   14.411216] input: WCOM50C1:00 2D1F:5143 as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input17
> [   14.411743] input: WCOM50C1:00 2D1F:5143 UNKNOWN as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input18
> [   14.411874] input: WCOM50C1:00 2D1F:5143 Stylus as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input19
> [   14.412256] input: WCOM50C1:00 2D1F:5143 UNKNOWN as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input20
> [   14.412392] input: WCOM50C1:00 2D1F:5143 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input21
> [   14.414488] hid-multitouch 0018:2D1F:5143.0001: input,hidraw0: I2C HID v1.00 Mouse [WCOM50C1:00 2D1F:5143] on i2c-WCOM50C1:00
> [   14.429082] input: ACPI0C50:00 18D1:5028 as /devices/pci0000:00/0000:00:15.2/i2c_designware.2/i2c-9/i2c-ACPI0C50:00/0018:18D1:5028.0002/input/input22
> [   14.429885] hid-multitouch 0018:18D1:5028.0002: input,hidraw1: I2C HID v1.00 Device [ACPI0C50:00 18D1:5028] on i2c-ACPI0C50:00
> [   21.008293] apple 0005:05AC:0256.0003: unknown main item tag 0x0
> [   21.008478] input: Apple Wireless Keyboard as /devices/virtual/misc/uhid/0005:05AC:0256.0003/input/input23
> [   21.028636] apple 0005:05AC:0256.0003: input,hidraw2: BLUETOOTH HID v0.50 Keyboard [Apple Wireless Keyboard] on __CENSORED__
> [   22.050334] input: MX Anywhere 3 Mouse as /devices/virtual/misc/uhid/0005:046D:B025.0004/input/input24
> [   22.050690] hid-generic 0005:046D:B025.0004: input,hidraw3: BLUETOOTH HID v0.15 Mouse [MX Anywhere 3] on __CENSORED__
> [   22.656665] input: Logitech MX Anywhere 3 as /devices/virtual/misc/uhid/0005:046D:B025.0004/input/input26
> [   22.657467] logitech-hidpp-device 0005:046D:B025.0004: input,hidraw3: BLUETOOTH HID v0.15 Mouse [Logitech MX Anywhere 3] on __CENSORED__
> [   22.690495] logitech-hidpp-device 0005:046D:B025.0004: HID++ 4.5 device connected.
> [   29.314294] Bluetooth: RFCOMM TTY layer initialized
> [   29.314306] Bluetooth: RFCOMM socket layer initialized
> [   29.314311] Bluetooth: RFCOMM ver 1.11
> [   49.334015] PM: suspend entry (deep)
> [   49.468714] Filesystems sync: 0.134 seconds
> [   49.475339] Freezing user space processes
> [   49.476795] Freezing user space processes completed (elapsed 0.001 seconds)
> [   49.476805] OOM killer disabled.
> [   49.476807] Freezing remaining freezable tasks
> [   49.478000] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [   49.478021] printk: Suspending console(s) (use no_console_suspend to debug)
> [   50.276104] ACPI: EC: interrupt blocked
> [   50.295404] ACPI: PM: Preparing to enter system sleep state S3
> [   50.295551] ACPI: EC: event blocked
> [   50.295553] ACPI: EC: EC stopped
> [   50.295555] ACPI: PM: Saving platform NVS memory
> [   50.295582] Disabling non-boot CPUs ...
> [   50.297302] smpboot: CPU 3 is now offline
> [   50.300996] smpboot: CPU 2 is now offline
> [   50.303136] smpboot: CPU 1 is now offline
> [   50.306603] ACPI: PM: Low-level resume complete
> [   50.306657] ACPI: EC: EC started
> [   50.306658] ACPI: PM: Restoring platform NVS memory
> [   50.307382] Enabling non-boot CPUs ...
> [   50.307530] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [   50.311113] CPU1 is up
> [   50.311141] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [   50.312157] CPU2 is up
> [   50.312184] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [   50.313070] CPU3 is up
> [   50.314754] ACPI: PM: Waking up from system sleep state S3
> [   50.315011] ACPI: EC: interrupt unblocked
> [   50.328827] ACPI: EC: event unblocked
> [   50.328910] pcieport 0000:00:1c.0: pciehp: Slot(0): Card present
> [   50.328914] pcieport 0000:00:1c.0: pciehp: Slot(0): Link Up
> [   50.454011] pci 0000:01:00.0: [8086:095a] type 00 class 0x028000 PCIe Endpoint
> [   50.454135] pci 0000:01:00.0: BAR 0 [mem 0x91000000-0x91001fff 64bit]
> [   50.454336] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> [   50.455122] pci 0000:01:00.0: BAR 0 [mem 0x91000000-0x91001fff 64bit]: assigned
> [   50.455147] pcieport 0000:00:1c.0: PCI bridge to [bus 01]
> [   50.455152] pcieport 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
> [   50.455160] pcieport 0000:00:1c.0:   bridge window [mem 0x91000000-0x910fffff]
> [   50.455166] pcieport 0000:00:1c.0:   bridge window [mem 0x27f000000-0x27f1fffff 64bit pref]
> [   50.579629] OOM killer enabled.
> [   50.579633] Restarting tasks: Starting
> [   50.580185] Restarting tasks: Done
> [   50.580236] random: crng reseeded on system resumption
> [   50.597372] PM: suspend exit
> [   50.795876] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [   50.796190] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [   50.796380] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
> [   50.797348] faux_driver regulatory: Direct firmware load for regulatory.db failed with error -2
> [   50.797355] cfg80211: failed to load regulatory.db
> [   50.833621] iwlwifi 0000:01:00.0: Detected crf-id 0x0, cnv-id 0x0 wfpm id 0x0
> [   50.833632] iwlwifi 0000:01:00.0: PCI dev 095a/9e10, rev=0x210, rfid=0xd55555d5
> [   50.833636] iwlwifi 0000:01:00.0: Detected Intel(R) Dual Band Wireless-AC 7265
> [   50.843189] iwlwifi 0000:01:00.0: Found debug destination: EXTERNAL_DRAM
> [   50.843194] iwlwifi 0000:01:00.0: Found debug configuration: 0
> [   50.843413] iwlwifi 0000:01:00.0: loaded firmware version 29.9ef079ed.0 7265D-29.ucode op_mode iwlmvm
> [   51.031523] pps_core: LinuxPPS API ver. 1 registered
> [   51.031528] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [   51.041714] PTP clock support registered
> [   51.085977] iwlwifi 0000:01:00.0: Applying debug destination EXTERNAL_DRAM
> [   51.086515] iwlwifi 0000:01:00.0: Allocated 0x00400000 bytes for firmware monitor.
> [   51.091081] iwlwifi 0000:01:00.0: base HW address: __CENSORED__, OTP minor version: 0x0
> [   51.155876] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
> [   51.162465] iwlwifi 0000:01:00.0 wlp1s0: renamed from wlan0
> [   51.183301] iwlwifi 0000:01:00.0: Applying debug destination EXTERNAL_DRAM
> [   51.261354] iwlwifi 0000:01:00.0: Applying debug destination EXTERNAL_DRAM
> [   51.263324] iwlwifi 0000:01:00.0: FW already configured (0) - re-configuring
> [   51.301497] iwlwifi 0000:01:00.0: Applying debug destination EXTERNAL_DRAM
> [   51.380860] iwlwifi 0000:01:00.0: Applying debug destination EXTERNAL_DRAM
> [   51.382709] iwlwifi 0000:01:00.0: FW already configured (0) - re-configuring
> [   54.105239] apple 0005:05AC:0256.0005: unknown main item tag 0x0
> [   54.106969] input: Apple Wireless Keyboard as /devices/virtual/misc/uhid/0005:05AC:0256.0005/input/input27
> [   54.132208] apple 0005:05AC:0256.0005: input,hidraw2: BLUETOOTH HID v0.50 Keyboard [Apple Wireless Keyboard] on __CENSORED__
> [   54.671095] wlp1s0: authenticate with __CENSORED__ (local address=__CENSORED__)
> [   54.672082] wlp1s0: send auth to __CENSORED__ (try 1/3)
> [   54.793409] wlp1s0: authenticate with __CENSORED__ (local address=__CENSORED__)
> [   54.793426] wlp1s0: send auth to __CENSORED__ (try 1/3)
> [   54.828297] wlp1s0: authenticated
> [   54.830857] wlp1s0: associate with __CENSORED__ (try 1/3)
> [   54.835788] wlp1s0: RX AssocResp from __CENSORED__ (capab=0x1931 status=0 aid=12)
> [   54.838810] wlp1s0: associated
> [   54.865853] wlp1s0: Limiting TX power to 30 (30 - 0) dBm as advertised by __CENSORED__
> [   59.291277] input: Logitech MX Anywhere 3 as /devices/virtual/misc/uhid/0005:046D:B025.0006/input/input28
> [   59.292194] logitech-hidpp-device 0005:046D:B025.0006: input,hidraw3: BLUETOOTH HID v0.15 Mouse [Logitech MX Anywhere 3] on __CENSORED__
> [   59.346946] logitech-hidpp-device 0005:046D:B025.0006: HID++ 4.5 device connected.
> [   63.574660] wlp1s0: deauthenticating from __CENSORED__ by local choice (Reason: 3=DEAUTH_LEAVING)
> [   63.992301] wlp1s0: authenticate with __CENSORED__ (local address=__CENSORED__)
> [   63.993318] wlp1s0: send auth to __CENSORED__ (try 1/3)
> [   64.106845] wlp1s0: authenticate with __CENSORED__ (local address=__CENSORED__)
> [   64.106855] wlp1s0: send auth to __CENSORED__ (try 1/3)
> [   64.246203] wlp1s0: authenticated
> [   64.247826] wlp1s0: associate with __CENSORED__ (try 1/3)
> [   64.249640] wlp1s0: RX AssocResp from __CENSORED__ (capab=0x1811 status=0 aid=15)
> [   64.252431] wlp1s0: associated
> [   68.576098] warning: `ThreadPoolForeg' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211
> [  637.445699] apple 0005:05AC:0256.0007: unknown main item tag 0x0
> [  637.446971] input: Apple Wireless Keyboard as /devices/virtual/misc/uhid/0005:05AC:0256.0007/input/input29
> [  637.473496] apple 0005:05AC:0256.0007: input,hidraw2: BLUETOOTH HID v0.50 Keyboard [Apple Wireless Keyboard] on __CENSORED__
> [ 1411.883331] iio iio:device1: Unknown activity: 2
> 
> I cannot test reverting that change, since that generates conflicts I am
> not sure how to resolve.
> 
> Any help towards fixing this would be very much appreciated.
> 
> Thanks!
> 
> #regzbot introduced: 4d4c10f763
> 


