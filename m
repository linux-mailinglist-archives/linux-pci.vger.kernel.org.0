Return-Path: <linux-pci+bounces-39035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE77BFCEDA
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 17:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A190A1A0766F
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 15:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E51C34CFCB;
	Wed, 22 Oct 2025 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxaCI1G6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516C332D7D6
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147535; cv=none; b=UDb1G5SQagsVdwcDucpgmEJLev+JOlxMms/bPYrDTuakjaovzon5wMtvrsk5YJcJGsQ45a7rSpPXc2aYgnvq8leVruXCPNRVewTNundaUftJzHJ5pDgjCDlvoNHpzLPpqSxTKK7yUShpq/AQsb3CV+Nb1LknvDlCfkA5RhngHQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147535; c=relaxed/simple;
	bh=XJ3LETjUx7K6WELX9ZBHxZn7BNMSi43BEs7u3dArsVM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PC6k+kJA3V67Zo6Y0NjQIESM30eQj7BqERrSeedKzz+SrOP9yH9KbJNyskFOep3xAFi+yAdznNuOISQ3/eYr2b+CwxWlF/LVYnY8QzeXY2Pe3AoHNMJ8Q/lOTEez0QGxRFuhSUM+W0Mo2faa/UCpPthRr98tYuAgduiDn+WUisM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxaCI1G6; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-592ee9a16adso1690088e87.0
        for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 08:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761147518; x=1761752318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDxWxoGn8SeNAyv4hxl7e4nFF5mtDhvliTxBwaVjjao=;
        b=MxaCI1G6a/wMdwXLnryrvAGTg7ni8PTrv+7ueT7+oH8zUUdHoq4o0MpuknuU+L9GbT
         e9RLasmYv7N+XIjhbCzaTAF8fnaFFBjr9m7qSnTbCH0kXknTXri3ILCKhXkJNEoUWUkV
         XWF0LMUuRenLNnhePhRn3VLxcHLtol6lQBQYE5S/Z6uGJKfa1E2lnLBQaTrb2uPaZM/p
         dTwYknDJRf9Kj9WEBI/35H5M6dte/7sHWy2Q5rgp0eKV2cuNgkiT8cdvLaMHmInxVOJv
         r3Qs71ZVAz6yZ8ewUDne3cxW/AZX/MT1ynlHG0ON9jFGOYT6gGQgULcHcgMmI2ZFRHZA
         TEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761147518; x=1761752318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDxWxoGn8SeNAyv4hxl7e4nFF5mtDhvliTxBwaVjjao=;
        b=fIBGK08NLg5HKBbSdQdRyIi6F8EfKh1vIssbF3kuHdm4im8ENNySmxllNbqgDp1hSe
         iXnyDQTia/UK1frXZmhOW5VfktqSWK4hd2m2iHwgNQjpROYqJYlO0vBFv1KVdClLZDsK
         Srj4pSoAeDEB4/pTOE7QgQJe1zL3amq4A8YlbtlV3COWkeDcGrtNGaZLmLOaUri/6E9n
         m723aazVcRwVaBAZ1/g8egLeFthfKxcv4q75p1xVFbl1gQ4tTzXHI6BiHpVzMqvRgXLJ
         6egucE5OOMf2EqZIPRZXZ14H2bcOlP2Av9krdWwGZdPQ4E5sJw+dyG8xoxeYKqQz412V
         lmrw==
X-Forwarded-Encrypted: i=1; AJvYcCXjVtcg3GJsRijf2qCtgugDLy0QEphDDPJfX/l1sA13INEUVdD1dlX/GrftxPAxRgvj5pn6e+xHwRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3KqacbiODrWLCEuYCgptkg4FHEIWec0hHliTj/ODoToUjLd9N
	UYve1iWcM9/u7UeUAB9rycg9QwhfcD43yxd4DYICRtukJ9dGdQHlhYIb
X-Gm-Gg: ASbGncs5839zEzuekaa0Xvr8DNBouGY6xDifcHG/2jBSWIY9RNMxkIWkVYqzLkrISW/
	tP4zzYxLO8ROgfy3k/ZzBn+///ibmglX3zVTB+zlJ34rt0zVNVl+xDqVCaK1KtKT/aaUInbnuSt
	VzFih2Rtz3iIK7lMB5UxpYbwj/PAv9cIbOiEcTpLALRMPLYf+vL2PD0dGGHcWJelpWxvspcNopC
	Bi/xRuGSqXIQtFNT8KDbg1XipvrYk4ro0/OilTd8+MguznBvLTL2npu/U3dvndAabh3X8A3mMip
	snSDVqWuIYL1alHBDPIWd3n5ak8Vtp+JOahn1z2T9oj/1zwiRuFMNZ7xT3OAPIqOfQcjYyLxkjs
	6If9MKGbTMRl7MWqBJqJQWpk6CWcydu3odtd6HddS77Q1Cgk/7rD/UICrR48whmYE41eYCbvT5P
	zXoNDC8PlKg8uP0cY76tzmcrIhp3s=
X-Google-Smtp-Source: AGHT+IFwJwOnQ+IjfhvY8Fy8p7MIh3zboBIJj9yRtpVOWGfblIyW+DdmJYmLKVgMSaDGx7GMeJWAIQ==
X-Received: by 2002:a2e:a985:0:b0:364:806d:85a6 with SMTP id 38308e7fff4ca-37797a5b10amr67296611fa.33.1761147516982;
        Wed, 22 Oct 2025 08:38:36 -0700 (PDT)
Received: from foxbook (bey128.neoplus.adsl.tpnet.pl. [83.28.36.128])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a9586b38sm37378671fa.45.2025.10.22.08.38.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Oct 2025 08:38:36 -0700 (PDT)
Date: Wed, 22 Oct 2025 17:38:31 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Shyam-sundar.S-k@amd.com, bhelgaas@google.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
 linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux@roeck-us.net, mario.limonciello@amd.com,
 naveenkrishna.chatradhi@amd.com, platform-driver-x86@vger.kernel.org,
 suma.hegde@amd.com, tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH v3 06/12] x86/amd_nb: Use topology info to get AMD node
 count
Message-ID: <20251022173831.671843f4.michal.pecio@gmail.com>
In-Reply-To: <20251022133901.GB7243@yaz-khff2.amd.com>
References: <20250107222847.3300430-7-yazen.ghannam@amd.com>
	<20251022011610.60d0ba6e.michal.pecio@gmail.com>
	<20251022133901.GB7243@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 09:39:01 -0400, Yazen Ghannam wrote:
> Can you please share the full output from dmesg and lspci?
> 
> Also, can you please share the raw CPUID output (cpuid -r)?

Not sure which "cpuid" software you mean?

As for lspci, obviously a single northbridge, no surprises.

00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] RS880 Host Bridge
00:02.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] RS780 PCI to PCI bridge (ext gfx port 0)
00:05.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] RS780/RS880 PCI to PCI bridge (PCIE port 1)
00:07.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] RS780/RS880 PCI to PCI bridge (PCIE port 3)
00:09.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] RS780/RS880 PCI to PCI bridge (PCIE port 4)
00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] (rev 40)
00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
00:12.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
00:13.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
00:13.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 SMBus Controller (rev 41)
00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 Azalia (Intel HDA) (rev 40)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 LPC host controller (rev 40)
00:14.4 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 PCI to PCI Bridge (rev 40)
00:14.5 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI2 Controller
00:16.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
00:16.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h Processor HyperTransport Configuration
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h Processor Address Map
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h Processor DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h Processor Miscellaneous Control
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h Processor Link Control
01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cedar [Radeon HD 5000/6000/7350/8350 Series]
01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Cedar HDMI Audio [Radeon HD 5400/6300/7300 Series]
02:00.0 USB controller: Renesas Technology Corp. uPD720201 USB 3.0 Host Controller (rev 03)
03:00.0 FireWire (IEEE 1394): VIA Technologies, Inc. VT6315 Series Firewire Controller
04:00.0 IDE interface: VIA Technologies, Inc. VT6415 PATA IDE Host Controller
05:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8100/8101L/8139 PCI Fast Ethernet Adapter (rev 10)

And dmesg from a working 6.12 kernel. I cut it at "run init".

[    0.000000] Linux version 6.12.31 (test@localhost) (gcc (GCC) 11.1.0, GNU ld (GNU Binutils) 2.36.1) #3 SMP PREEMPT Mon Jun  2 00:01:52 CEST 2025
[    0.000000] Command line: root=/dev/sda1 ro i8042.direct=1 consoleblank=180 quiet
[    0.000000] KERNEL supported cpus:
[    0.000000]   AMD AuthenticAMD
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009abff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009ac00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e2000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000cff7ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cff80000-0x00000000cff97fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000cff98000-0x00000000cffcffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cffd0000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffa00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000042fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] SMBIOS 2.5 present.
[    0.000000] DMI: System manufacturer System Product Name/M4A88TD-M EVO, BIOS 1801    08/09/2012
[    0.000000] DMI: Memory slots populated: 2/4
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3415.121 MHz processor
[    0.005854] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.005856] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.011810] AGP: No AGP bridge found
[    0.011866] last_pfn = 0x430000 max_arch_pfn = 0x400000000
[    0.011870] MTRR map: 5 entries (3 fixed + 2 variable; max 20), built from 9 variable MTRRs
[    0.011872] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.012975] e820: update [mem 0xd0000000-0xffffffff] usable ==> reserved
[    0.012983] last_pfn = 0xcff98 max_arch_pfn = 0x400000000
[    0.012992] Using GB pages for direct mapping
[    0.013460] ACPI: Early table checksum verification disabled
[    0.013464] ACPI: RSDP 0x00000000000FB570 000024 (v02 ACPIAM)
[    0.013468] ACPI: XSDT 0x00000000CFF80100 00005C (v01 080912 XSDT1703 20120809 MSFT 00000097)
[    0.013472] ACPI: FACP 0x00000000CFF80290 0000F4 (v03 080912 FACP1703 20120809 MSFT 00000097)
[    0.013478] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Gpe0Block: 64/32 (20240827/tbfadt-560)
[    0.013481] ACPI: DSDT 0x00000000CFF80450 00E7B5 (v01 A1581  A1581001 00000001 INTL 20060113)
[    0.013484] ACPI: FACS 0x00000000CFF98000 000040
[    0.013486] ACPI: FACS 0x00000000CFF98000 000040
[    0.013488] ACPI: APIC 0x00000000CFF80390 00007C (v01 080912 APIC1703 20120809 MSFT 00000097)
[    0.013490] ACPI: MCFG 0x00000000CFF80410 00003C (v01 080912 OEMMCFG  20120809 MSFT 00000097)
[    0.013493] ACPI: OEMB 0x00000000CFF98040 000072 (v01 080912 OEMB1703 20120809 MSFT 00000097)
[    0.013495] ACPI: SRAT 0x00000000CFF8F8A0 0000E8 (v01 AMD    FAM_F_10 00000002 AMD  00000001)
[    0.013497] ACPI: HPET 0x00000000CFF8F990 000038 (v01 080912 OEMHPET  20120809 MSFT 00000097)
[    0.013500] ACPI: SSDT 0x00000000CFF8F9D0 00088C (v01 A M I  POWERNOW 00000001 AMD  00000001)
[    0.013502] ACPI: Reserving FACP table memory at [mem 0xcff80290-0xcff80383]
[    0.013503] ACPI: Reserving DSDT table memory at [mem 0xcff80450-0xcff8ec04]
[    0.013504] ACPI: Reserving FACS table memory at [mem 0xcff98000-0xcff9803f]
[    0.013505] ACPI: Reserving FACS table memory at [mem 0xcff98000-0xcff9803f]
[    0.013505] ACPI: Reserving APIC table memory at [mem 0xcff80390-0xcff8040b]
[    0.013506] ACPI: Reserving MCFG table memory at [mem 0xcff80410-0xcff8044b]
[    0.013507] ACPI: Reserving OEMB table memory at [mem 0xcff98040-0xcff980b1]
[    0.013508] ACPI: Reserving SRAT table memory at [mem 0xcff8f8a0-0xcff8f987]
[    0.013509] ACPI: Reserving HPET table memory at [mem 0xcff8f990-0xcff8f9c7]
[    0.013509] ACPI: Reserving SSDT table memory at [mem 0xcff8f9d0-0xcff9025b]
[    0.013544] Zone ranges:
[    0.013545]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.013547]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.013548]   Normal   [mem 0x0000000100000000-0x000000042fffffff]
[    0.013549] Movable zone start for each node
[    0.013550] Early memory node ranges
[    0.013550]   node   0: [mem 0x0000000000001000-0x0000000000099fff]
[    0.013551]   node   0: [mem 0x0000000000100000-0x00000000cff7ffff]
[    0.013552]   node   0: [mem 0x0000000100000000-0x000000042fffffff]
[    0.013554] Initmem setup node 0 [mem 0x0000000000001000-0x000000042fffffff]
[    0.013559] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.013600] On node 0, zone DMA: 102 pages in unavailable ranges
[    0.071857] On node 0, zone Normal: 128 pages in unavailable ranges
[    0.072036] IOAPIC[0]: apic_id 4, version 33, address 0xfec00000, GSI 0-23
[    0.072038] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.072040] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.072043] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.072044] ACPI: HPET id: 0x8300 base: 0xfed00000
[    0.072051] CPU topo: Max. logical packages:   2
[    0.072052] CPU topo: Max. logical dies:       2
[    0.072052] CPU topo: Max. dies per package:   1
[    0.072057] CPU topo: Max. threads per core:   1
[    0.072058] CPU topo: Num. cores per package:     4
[    0.072059] CPU topo: Num. threads per package:   4
[    0.072059] CPU topo: Allowing 4 present CPUs plus 2 hotplug CPUs
[    0.072069] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.072070] PM: hibernation: Registered nosave memory: [mem 0x0009a000-0x000fffff]
[    0.072072] PM: hibernation: Registered nosave memory: [mem 0xcff80000-0xffffffff]
[    0.072074] [mem 0xd0000000-0xff9fffff] available for PCI devices
[    0.072077] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.076569] setup_percpu: NR_CPUS:6 nr_cpumask_bits:6 nr_cpu_ids:6 nr_node_ids:1
[    0.077173] percpu: Embedded 51 pages/cpu s170136 r8192 d30568 u262144
[    0.077178] pcpu-alloc: s170136 r8192 d30568 u262144 alloc=1*2097152
[    0.077181] pcpu-alloc: [0] 0 1 2 3 4 5 - - 
[    0.077196] Kernel command line: root=/dev/sda1 ro i8042.direct=1 consoleblank=180 quiet
[    0.080666] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.082431] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.082458] Built 1 zonelists, mobility grouping on.  Total pages: 4194073
[    0.082460] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.082461] AGP: Checking aperture...
[    0.088412] AGP: No AGP bridge found
[    0.088413] AGP: Node 0: aperture [bus addr 0x8144000000-0x8145ffffff] (32MB)
[    0.088415] Aperture beyond 4GB. Ignoring.
[    0.088416] AGP: Your BIOS doesn't leave an aperture memory hole
[    0.088416] AGP: Please enable the IOMMU option in the BIOS setup
[    0.088416] AGP: This costs you 64MB of RAM
[    0.088418] AGP: Mapping aperture over RAM [mem 0xc8000000-0xcbffffff] (65536KB)
[    0.088420] PM: hibernation: Registered nosave memory: [mem 0xc8000000-0xcbffffff]
[    0.088477] software IO TLB: area num 8.
[    0.181015] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1
[    0.181056] ftrace: allocating 43749 entries in 171 pages
[    0.185632] ftrace: allocated 171 pages with 5 groups
[    0.185756] rcu: Preemptible hierarchical RCU implementation.
[    0.185758]  Trampoline variant of Tasks RCU enabled.
[    0.185758]  Rude variant of Tasks RCU enabled.
[    0.185759] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.185769] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=6.
[    0.185771] RCU Tasks Rude: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=6.
[    0.191060] NR_IRQS: 4352, nr_irqs: 472, preallocated irqs: 16
[    0.191248] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.192374] Console: colour VGA+ 80x25
[    0.192377] printk: legacy console [tty0] enabled
[    0.192400] ACPI: Core revision 20240827
[    0.192486] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.192500] APIC: Switch to symmetric I/O mode setup
[    0.192800] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.197500] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x313a1b4f1ed, max_idle_ns: 440795378328 ns
[    0.197506] Calibrating delay loop (skipped), value calculated using timer frequency.. 6830.24 BogoMIPS (lpj=3415121)
[    0.197526] LVT offset 0 assigned for vector 0xf9
[    0.197530] Last level iTLB entries: 4KB 512, 2MB 16, 4MB 8
[    0.197531] Last level dTLB entries: 4KB 512, 2MB 128, 4MB 64, 1GB 0
[    0.197536] Spectre V1 : Vulnerable: __user pointer sanitization and usercopy barriers only; no swapgs barriers
[    0.197541] x86/fpu: x87 FPU will use FXSAVE
[    0.197909] Freeing SMP alternatives memory: 32K
[    0.197914] pid_max: default: 32768 minimum: 301
[    0.197991] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.198051] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.198507] process: System has AMD C1E erratum E400. Workaround enabled.
[    0.402955] process: Switch to broadcast mode on CPU0
[    0.402961] smpboot: CPU0: AMD Phenom(tm) II X4 965 Processor (family: 0x10, model: 0x4, stepping: 0x3)
[    0.403155] Performance Events: AMD PMU driver.
[    0.403159] ... version:                0
[    0.403160] ... bit width:              48
[    0.403161] ... generic registers:      4
[    0.403161] ... value mask:             0000ffffffffffff
[    0.403162] ... max period:             00007fffffffffff
[    0.403163] ... fixed-purpose events:   0
[    0.403164] ... event mask:             000000000000000f
[    0.403251] signal: max sigframe size: 1440
[    0.403273] rcu: Hierarchical SRCU implementation.
[    0.403274] rcu:     Max phase no-delay instances is 400.
[    0.403316] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[    0.403456] MCE: In-kernel MCE decoding enabled.
[    0.403482] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.403502] smp: Bringing up secondary CPUs ...
[    0.403502] smpboot: x86: Booting SMP configuration:
[    0.403502] .... node  #0, CPUs:      #1 #2 #3
[    0.002233] process: Switch to broadcast mode on CPU1
[    0.002233] process: Switch to broadcast mode on CPU2
[    0.002233] process: Switch to broadcast mode on CPU3
[    0.406552] smp: Brought up 1 node, 4 CPUs
[    0.406552] smpboot: Total of 4 processors activated (27320.96 BogoMIPS)
[    0.407603] Memory: 16318664K/16776292K available (14336K kernel code, 3520K rwdata, 4504K rodata, 1508K init, 1588K bss, 451176K reserved, 0K cma-reserved)
[    0.409171] devtmpfs: initialized
[    0.409171] ACPI: PM: Registering ACPI NVS region [mem 0xcff98000-0xcffcffff] (229376 bytes)
[    0.409171] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.409509] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.409643] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.409716] audit: initializing netlink subsys (disabled)
[    0.409737] audit: type=2000 audit(1761057893.217:1): state=initialized audit_enabled=0 res=1
[    0.409737] thermal_sys: Registered thermal governor 'step_wise'
[    0.409737] cpuidle: using governor ladder
[    0.409737] cpuidle: using governor menu
[    0.409737] node 0 link 0: io port [1000, ffffff]
[    0.409737] TOM: 00000000d0000000 aka 3328M
[    0.409737] Fam 10h mmconf [mem 0xe0000000-0xefffffff]
[    0.409737] node 0 link 0: mmio [a0000, bffff]
[    0.409737] node 0 link 0: mmio [d0000000, dfffffff]
[    0.409737] node 0 link 0: mmio [e0000000, efffffff] ==> none
[    0.409737] node 0 link 0: mmio [f0000000, ffdfffff]
[    0.409737] TOM2: 0000000430000000 aka 17152M
[    0.409737] bus: [bus 00-07] on node 0 link 0
[    0.409737] bus: 00 [io  0x0000-0xffff]
[    0.409737] bus: 00 [mem 0x000a0000-0x000bffff]
[    0.409737] bus: 00 [mem 0xd0000000-0xdfffffff]
[    0.409737] bus: 00 [mem 0xf0000000-0xffffffff]
[    0.409737] bus: 00 [mem 0x430000000-0xfcffffffff]
[    0.409737] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
[    0.409737] PCI: not using ECAM ([mem 0xe0000000-0xefffffff] not reserved)
[    0.409737] PCI: Using configuration type 1 for base access
[    0.409737] PCI: Using configuration type 1 for extended access
[    0.409737] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.412683] ACPI: Added _OSI(Module Device)
[    0.412686] ACPI: Added _OSI(Processor Device)
[    0.412687] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.412688] ACPI: Added _OSI(Processor Aggregator Device)
[    0.417092] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.478842] ACPI: EC: EC started
[    0.478845] ACPI: EC: interrupt blocked
[    0.479028] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.479031] ACPI: \_SB_.PCI0.SBRG.EC0_: Boot DSDT EC used to handle transactions
[    0.479032] ACPI: Interpreter enabled
[    0.479049] ACPI: PM: (supports S0 S1 S3 S4 S5)
[    0.479051] ACPI: Using IOAPIC for interrupt routing
[    0.479070] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
[    0.480225] PCI: ECAM [mem 0xe0000000-0xefffffff] reserved as ACPI motherboard resource
[    0.480237] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.480239] PCI: Using E820 reservations for host bridge windows
[    0.480525] ACPI: Enabled 8 GPEs in block 00 to 1F
[    0.485012] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.485019] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.485072] acpi PNP0A03:00: _OSC: platform does not support [LTR]
[    0.485154] acpi PNP0A03:00: _OSC: OS now controls [PME AER PCIeCapability]
[    0.485262] PCI host bridge to bus 0000:00
[    0.485265] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.485267] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.485269] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.485272] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dffff window]
[    0.485274] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xdfffffff window]
[    0.485275] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfebfffff window]
[    0.485277] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.485291] pci 0000:00:00.0: [1022:9601] type 00 class 0x060000 conventional PCI endpoint
[    0.485375] pci 0000:00:02.0: [1022:9603] type 01 class 0x060400 PCIe Root Port
[    0.485386] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.485389] pci 0000:00:02.0:   bridge window [io  0xb000-0xbfff]
[    0.485391] pci 0000:00:02.0:   bridge window [mem 0xfe700000-0xfe7fffff]
[    0.485395] pci 0000:00:02.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.485401] pci 0000:00:02.0: enabling Extended Tags
[    0.485423] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.485482] pci 0000:00:05.0: [1022:9605] type 01 class 0x060400 PCIe Root Port
[    0.485491] pci 0000:00:05.0: PCI bridge to [bus 02]
[    0.485495] pci 0000:00:05.0:   bridge window [mem 0xfe800000-0xfe8fffff]
[    0.485518] pci 0000:00:05.0: enabling Extended Tags
[    0.485538] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
[    0.485591] pci 0000:00:07.0: [1022:9607] type 01 class 0x060400 PCIe Root Port
[    0.485601] pci 0000:00:07.0: PCI bridge to [bus 03]
[    0.485604] pci 0000:00:07.0:   bridge window [io  0xc000-0xcfff]
[    0.485606] pci 0000:00:07.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.485613] pci 0000:00:07.0: enabling Extended Tags
[    0.485633] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.485685] pci 0000:00:09.0: [1022:9608] type 01 class 0x060400 PCIe Root Port
[    0.485695] pci 0000:00:09.0: PCI bridge to [bus 04]
[    0.485697] pci 0000:00:09.0:   bridge window [io  0xd000-0xdfff]
[    0.485700] pci 0000:00:09.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.485707] pci 0000:00:09.0: enabling Extended Tags
[    0.485727] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    0.485790] pci 0000:00:11.0: [1002:4391] type 00 class 0x010601 conventional PCI endpoint
[    0.485802] pci 0000:00:11.0: BAR 0 [io  0xa000-0xa007]
[    0.485809] pci 0000:00:11.0: BAR 1 [io  0x9000-0x9003]
[    0.485816] pci 0000:00:11.0: BAR 2 [io  0x8000-0x8007]
[    0.485823] pci 0000:00:11.0: BAR 3 [io  0x7000-0x7003]
[    0.485829] pci 0000:00:11.0: BAR 4 [io  0x6000-0x600f]
[    0.485836] pci 0000:00:11.0: BAR 5 [mem 0xfe6ffc00-0xfe6fffff]
[    0.485906] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310 conventional PCI endpoint
[    0.485918] pci 0000:00:12.0: BAR 0 [mem 0xfe6fe000-0xfe6fefff]
[    0.486004] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320 conventional PCI endpoint
[    0.486016] pci 0000:00:12.2: BAR 0 [mem 0xfe6ff800-0xfe6ff8ff]
[    0.486072] pci 0000:00:12.2: supports D1 D2
[    0.486073] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.486125] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310 conventional PCI endpoint
[    0.486138] pci 0000:00:13.0: BAR 0 [mem 0xfe6fd000-0xfe6fdfff]
[    0.486223] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320 conventional PCI endpoint
[    0.486235] pci 0000:00:13.2: BAR 0 [mem 0xfe6ff400-0xfe6ff4ff]
[    0.486291] pci 0000:00:13.2: supports D1 D2
[    0.486292] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.486349] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500 conventional PCI endpoint
[    0.486441] pci 0000:00:14.2: [1002:4383] type 00 class 0x040300 conventional PCI endpoint
[    0.486456] pci 0000:00:14.2: BAR 0 [mem 0xfe6f4000-0xfe6f7fff 64bit]
[    0.486511] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.486559] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100 conventional PCI endpoint
[    0.486662] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401 conventional PCI bridge
[    0.486684] pci 0000:00:14.4: PCI bridge to [bus 05] (subtractive decode)
[    0.486688] pci 0000:00:14.4:   bridge window [io  0xe000-0xefff]
[    0.486691] pci 0000:00:14.4:   bridge window [mem 0xfeb00000-0xfebfffff]
[    0.486744] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310 conventional PCI endpoint
[    0.486756] pci 0000:00:14.5: BAR 0 [mem 0xfe6fc000-0xfe6fcfff]
[    0.486838] pci 0000:00:16.0: [1002:4397] type 00 class 0x0c0310 conventional PCI endpoint
[    0.486850] pci 0000:00:16.0: BAR 0 [mem 0xfe6f3000-0xfe6f3fff]
[    0.486936] pci 0000:00:16.2: [1002:4396] type 00 class 0x0c0320 conventional PCI endpoint
[    0.486949] pci 0000:00:16.2: BAR 0 [mem 0xfe6ff000-0xfe6ff0ff]
[    0.487005] pci 0000:00:16.2: supports D1 D2
[    0.487006] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
[    0.487054] pci 0000:00:18.0: [1022:1200] type 00 class 0x060000 conventional PCI endpoint
[    0.487085] pci 0000:00:18.1: [1022:1201] type 00 class 0x060000 conventional PCI endpoint
[    0.487112] pci 0000:00:18.2: [1022:1202] type 00 class 0x060000 conventional PCI endpoint
[    0.487139] pci 0000:00:18.3: [1022:1203] type 00 class 0x060000 conventional PCI endpoint
[    0.487168] pci 0000:00:18.4: [1022:1204] type 00 class 0x060000 conventional PCI endpoint
[    0.487226] pci 0000:01:00.0: [1002:68f9] type 00 class 0x030000 PCIe Legacy Endpoint
[    0.487238] pci 0000:01:00.0: BAR 0 [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.487246] pci 0000:01:00.0: BAR 2 [mem 0xfe7e0000-0xfe7fffff 64bit]
[    0.487252] pci 0000:01:00.0: BAR 4 [io  0xb000-0xb0ff]
[    0.487262] pci 0000:01:00.0: ROM [mem 0xfe7c0000-0xfe7dffff pref]
[    0.487267] pci 0000:01:00.0: enabling Extended Tags
[    0.487278] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.487302] pci 0000:01:00.0: supports D1 D2
[    0.487358] pci 0000:01:00.1: [1002:aa68] type 00 class 0x040300 PCIe Legacy Endpoint
[    0.487370] pci 0000:01:00.1: BAR 0 [mem 0xfe7bc000-0xfe7bffff 64bit]
[    0.487396] pci 0000:01:00.1: enabling Extended Tags
[    0.487427] pci 0000:01:00.1: supports D1 D2
[    0.487485] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.487543] pci 0000:02:00.0: [1912:0014] type 00 class 0x0c0330 PCIe Endpoint
[    0.487570] pci 0000:02:00.0: BAR 0 [mem 0xfe8fe000-0xfe8fffff 64bit]
[    0.487700] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.487801] pci 0000:00:05.0: PCI bridge to [bus 02]
[    0.487848] pci 0000:03:00.0: [1106:3403] type 00 class 0x0c0010 PCIe Endpoint
[    0.487882] pci 0000:03:00.0: BAR 0 [mem 0xfe9ff800-0xfe9fffff 64bit]
[    0.487896] pci 0000:03:00.0: BAR 2 [io  0xc800-0xc8ff]
[    0.488037] pci 0000:03:00.0: supports D2
[    0.488038] pci 0000:03:00.0: PME# supported from D2 D3hot D3cold
[    0.489527] pci 0000:00:07.0: PCI bridge to [bus 03]
[    0.489587] pci 0000:04:00.0: [1106:0415] type 00 class 0x010185 PCIe Legacy Endpoint
[    0.489613] pci 0000:04:00.0: BAR 0 [io  0xdc00-0xdc07]
[    0.489628] pci 0000:04:00.0: BAR 1 [io  0xd880-0xd883]
[    0.489642] pci 0000:04:00.0: BAR 2 [io  0xd800-0xd807]
[    0.489656] pci 0000:04:00.0: BAR 3 [io  0xd480-0xd483]
[    0.489670] pci 0000:04:00.0: BAR 4 [io  0xd400-0xd40f]
[    0.489697] pci 0000:04:00.0: ROM [mem 0xfeaf0000-0xfeafffff pref]
[    0.489791] pci 0000:04:00.0: supports D1 D2
[    0.489792] pci 0000:04:00.0: PME# supported from D1 D2 D3hot
[    0.491524] pci 0000:00:09.0: PCI bridge to [bus 04]
[    0.491541] pci_bus 0000:05: extended config space not accessible
[    0.491568] pci 0000:05:05.0: [10ec:8139] type 00 class 0x020000 conventional PCI endpoint
[    0.491585] pci 0000:05:05.0: BAR 0 [io  0xe800-0xe8ff]
[    0.491595] pci 0000:05:05.0: BAR 1 [mem 0xfebffc00-0xfebffcff]
[    0.491636] pci 0000:05:05.0: ROM [mem 0xfebe0000-0xfebeffff pref]
[    0.491667] pci 0000:05:05.0: supports D1 D2
[    0.491669] pci 0000:05:05.0: PME# supported from D1 D2 D3hot
[    0.491734] pci 0000:00:14.4: PCI bridge to [bus 05] (subtractive decode)
[    0.491741] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    0.491742] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.491744] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.491746] pci 0000:00:14.4:   bridge window [mem 0x000d0000-0x000dffff window] (subtractive decode)
[    0.491747] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xdfffffff window] (subtractive decode)
[    0.491749] pci 0000:00:14.4:   bridge window [mem 0xf0000000-0xfebfffff window] (subtractive decode)
[    0.491762] pci_bus 0000:00: on NUMA node 0
[    0.492327] ACPI: PCI: Interrupt link LNKA configured for IRQ 5
[    0.492367] ACPI: PCI: Interrupt link LNKB configured for IRQ 11
[    0.492408] ACPI: PCI: Interrupt link LNKC configured for IRQ 10
[    0.492449] ACPI: PCI: Interrupt link LNKD configured for IRQ 9
[    0.492525] ACPI: PCI: Interrupt link LNKE configured for IRQ 3
[    0.492552] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.492578] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.492603] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.492689] ACPI: EC: interrupt unblocked
[    0.492690] ACPI: EC: event unblocked
[    0.492692] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.492694] ACPI: EC: GPE=0xa
[    0.492695] ACPI: \_SB_.PCI0.SBRG.EC0_: Boot DSDT EC initialization complete
[    0.492697] ACPI: \_SB_.PCI0.SBRG.EC0_: EC: Used to handle transactions and events
[    0.492761] SCSI subsystem initialized
[    0.492771] libata version 3.00 loaded.
[    0.492771] ACPI: bus type USB registered
[    0.492771] usbcore: registered new interface driver usbfs
[    0.492771] usbcore: registered new interface driver hub
[    0.492771] usbcore: registered new device driver usb
[    0.492771] EDAC MC: Ver: 3.0.0
[    0.492771] Advanced Linux Sound Architecture Driver Initialized.
[    0.492771] PCI: Using ACPI for IRQ routing
[    0.499137] PCI: pci_cache_line_size set to 64 bytes
[    0.499184] e820: reserve RAM buffer [mem 0x0009ac00-0x0009ffff]
[    0.499186] e820: reserve RAM buffer [mem 0xcff80000-0xcfffffff]
[    0.499277] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.499281] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.500559] clocksource: Switched to clocksource tsc-early
[    0.500645] pnp: PnP ACPI init
[    0.501603] pnp 00:02: [dma 0 disabled]
[    0.501998] pnp 00:04: [dma 0 disabled]
[    0.502103] system 00:05: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.502105] system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.502236] system 00:06: [io  0x04d0-0x04d1] has been reserved
[    0.502238] system 00:06: [io  0x040b] has been reserved
[    0.502240] system 00:06: [io  0x04d6] has been reserved
[    0.502242] system 00:06: [io  0x0c00-0x0c01] has been reserved
[    0.502244] system 00:06: [io  0x0c14] has been reserved
[    0.502245] system 00:06: [io  0x0c50-0x0c51] has been reserved
[    0.502247] system 00:06: [io  0x0c52] has been reserved
[    0.502248] system 00:06: [io  0x0c6c] has been reserved
[    0.502250] system 00:06: [io  0x0c6f] has been reserved
[    0.502251] system 00:06: [io  0x0cd0-0x0cd1] has been reserved
[    0.502253] system 00:06: [io  0x0cd2-0x0cd3] has been reserved
[    0.502254] system 00:06: [io  0x0cd4-0x0cd5] has been reserved
[    0.502256] system 00:06: [io  0x0cd6-0x0cd7] has been reserved
[    0.502257] system 00:06: [io  0x0cd8-0x0cdf] has been reserved
[    0.502259] system 00:06: [io  0x0b00-0x0b3f] has been reserved
[    0.502260] system 00:06: [io  0x0800-0x089f] has been reserved
[    0.502262] system 00:06: [io  0x0b00-0x0b1f] has been reserved
[    0.502263] system 00:06: [io  0x0b20-0x0b3f] has been reserved
[    0.502265] system 00:06: [io  0x0900-0x090f] has been reserved
[    0.502266] system 00:06: [io  0x0910-0x091f] has been reserved
[    0.502268] system 00:06: [io  0xfe00-0xfefe] has been reserved
[    0.502269] system 00:06: [mem 0xffb80000-0xffbfffff] has been reserved
[    0.502271] system 00:06: [mem 0xfec10000-0xfec1001f] has been reserved
[    0.502273] system 00:06: [mem 0xfed40000-0xfed44fff] has been reserved
[    0.502274] system 00:06: [mem 0xfed80000-0xfed80fff] has been reserved
[    0.502383] system 00:07: [io  0x0230-0x023f] has been reserved
[    0.502385] system 00:07: [io  0x0290-0x029f] has been reserved
[    0.502387] system 00:07: [io  0x0300-0x030f] has been reserved
[    0.502388] system 00:07: [io  0x0a30-0x0a3f] has been reserved
[    0.502434] system 00:08: [mem 0xe0000000-0xefffffff] has been reserved
[    0.502503] pnp 00:09: disabling [mem 0x000c0000-0x000cffff] because it overlaps 0000:01:00.0 BAR 6 [mem 0x000c0000-0x000dffff]
[    0.502520] system 00:09: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.502522] system 00:09: [mem 0x000e0000-0x000fffff] could not be reserved
[    0.502524] system 00:09: [mem 0x00100000-0xcfffffff] could not be reserved
[    0.502526] system 00:09: [mem 0xfec00000-0xffffffff] could not be reserved
[    0.502586] pnp: PnP ACPI: found 10 devices
[    0.503936] NET: Registered PF_INET protocol family
[    0.504357] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.506891] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
[    0.506924] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.506930] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.507173] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.507737] TCP: Hash tables configured (established 131072 bind 65536)
[    0.507895] MPTCP token hash table entries: 16384 (order: 6, 393216 bytes, linear)
[    0.507931] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.508003] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.508104] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.508129] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.508133] pci 0000:00:02.0:   bridge window [io  0xb000-0xbfff]
[    0.508137] pci 0000:00:02.0:   bridge window [mem 0xfe700000-0xfe7fffff]
[    0.508139] pci 0000:00:02.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.508142] pci 0000:00:05.0: PCI bridge to [bus 02]
[    0.508145] pci 0000:00:05.0:   bridge window [mem 0xfe800000-0xfe8fffff]
[    0.508148] pci 0000:00:07.0: PCI bridge to [bus 03]
[    0.508150] pci 0000:00:07.0:   bridge window [io  0xc000-0xcfff]
[    0.508152] pci 0000:00:07.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.508156] pci 0000:00:09.0: PCI bridge to [bus 04]
[    0.508157] pci 0000:00:09.0:   bridge window [io  0xd000-0xdfff]
[    0.508159] pci 0000:00:09.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.508163] pci 0000:00:14.4: PCI bridge to [bus 05]
[    0.508165] pci 0000:00:14.4:   bridge window [io  0xe000-0xefff]
[    0.508169] pci 0000:00:14.4:   bridge window [mem 0xfeb00000-0xfebfffff]
[    0.508176] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.508178] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.508179] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.508181] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff window]
[    0.508182] pci_bus 0000:00: resource 8 [mem 0xd0000000-0xdfffffff window]
[    0.508184] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfebfffff window]
[    0.508186] pci_bus 0000:01: resource 0 [io  0xb000-0xbfff]
[    0.508187] pci_bus 0000:01: resource 1 [mem 0xfe700000-0xfe7fffff]
[    0.508189] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.508191] pci_bus 0000:02: resource 1 [mem 0xfe800000-0xfe8fffff]
[    0.508192] pci_bus 0000:03: resource 0 [io  0xc000-0xcfff]
[    0.508194] pci_bus 0000:03: resource 1 [mem 0xfe900000-0xfe9fffff]
[    0.508195] pci_bus 0000:04: resource 0 [io  0xd000-0xdfff]
[    0.508196] pci_bus 0000:04: resource 1 [mem 0xfea00000-0xfeafffff]
[    0.508198] pci_bus 0000:05: resource 0 [io  0xe000-0xefff]
[    0.508199] pci_bus 0000:05: resource 1 [mem 0xfeb00000-0xfebfffff]
[    0.508201] pci_bus 0000:05: resource 4 [io  0x0000-0x0cf7 window]
[    0.508202] pci_bus 0000:05: resource 5 [io  0x0d00-0xffff window]
[    0.508204] pci_bus 0000:05: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.508205] pci_bus 0000:05: resource 7 [mem 0x000d0000-0x000dffff window]
[    0.508207] pci_bus 0000:05: resource 8 [mem 0xd0000000-0xdfffffff window]
[    0.508208] pci_bus 0000:05: resource 9 [mem 0xf0000000-0xfebfffff window]
[    1.266775] pci 0000:00:12.0: quirk_usb_early_handoff+0x0/0x740 took 740732 usecs
[    1.287763] pci 0000:00:13.0: quirk_usb_early_handoff+0x0/0x740 took 20394 usecs
[    1.308766] pci 0000:00:14.5: quirk_usb_early_handoff+0x0/0x740 took 20405 usecs
[    1.329762] pci 0000:00:16.0: quirk_usb_early_handoff+0x0/0x740 took 20494 usecs
[    1.329895] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
[    1.330043] PCI: CLS 64 bytes, default 64
[    1.330276] PCI-DMA: Disabling AGP.
[    1.330349] PCI-DMA: aperture base @ c8000000 size 65536 KB
[    1.330350] PCI-DMA: using GART IOMMU.
[    1.330352] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    1.330998] software IO TLB: tearing down default memory pool
[    1.332134] LVT offset 1 assigned for vector 0x400
[    1.332145] LVT offset 1 assigned
[    1.332248] perf: AMD IBS detected (0x0000001f)
[    1.332271] kvm_amd: Nested Virtualization enabled
[    1.332272] kvm_amd: Nested Paging enabled
[    1.332273] kvm_amd: LBR virtualization supported
[    1.335733] Initialise system trusted keyrings
[    1.335784] workingset: timestamp_bits=62 max_order=22 bucket_order=0
[    1.335835] fuse: init (API version 7.41)
[    1.335911] SGI XFS with ACLs, security attributes, realtime, quota, no debug enabled
[    1.351048] Key type asymmetric registered
[    1.351049] Asymmetric key parser 'x509' registered
[    1.351061] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    1.351062] io scheduler mq-deadline registered
[    1.351066] io scheduler bfq registered
[    1.351983] pcieport 0000:00:02.0: PME: Signaling with IRQ 24
[    1.352064] pcieport 0000:00:05.0: PME: Signaling with IRQ 25
[    1.352166] pcieport 0000:00:07.0: PME: Signaling with IRQ 26
[    1.352264] pcieport 0000:00:09.0: PME: Signaling with IRQ 27
[    1.352376] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.352397] ACPI: button: Power Button [PWRB]
[    1.352420] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.355729] ACPI: button: Power Button [PWRF]
[    1.355808] ACPI: processor limited to max C-state 1
[    1.356185] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.376726] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.377178] Linux agpgart interface v0.103
[    1.377185] ACPI: bus type drm_connector registered
[    1.377190] [drm] radeon kernel modesetting enabled.
[    1.377282] [drm] initializing kernel modesetting (CEDAR 0x1002:0x68F9 0x174B:0xE127 0x00).
[    1.377303] resource: resource sanity check: requesting [mem 0x00000000000c0000-0x00000000000dffff], which spans more than PCI Bus 0000:00 [mem 0x000d0000-0x000dffff window]
[    1.377307] caller pci_map_rom+0x68/0x1d0 mapping multiple BARs
[    1.378358] ATOM BIOS: CEDAR
[    1.378405] radeon 0000:01:00.0: VRAM: 512M 0x0000000000000000 - 0x000000001FFFFFFF (512M used)
[    1.378407] radeon 0000:01:00.0: GTT: 1024M 0x0000000020000000 - 0x000000005FFFFFFF
[    1.378410] [drm] Detected VRAM RAM=512M, BAR=256M
[    1.378412] [drm] RAM width 64bits DDR
[    1.378599] [drm] radeon: 512M of VRAM memory ready
[    1.378601] [drm] radeon: 1024M of GTT memory ready.
[    1.378605] [drm] Loading CEDAR Microcode
[    1.379045] [drm] Internal thermal controller with fan control
[    1.403302] [drm] radeon: dpm initialized
[    1.403985] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    1.404880] [drm] enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0
[    1.421212] [drm] PCIE GART of 1024M enabled (table at 0x000000000014C000).
[    1.421289] radeon 0000:01:00.0: WB enabled
[    1.421291] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000020000c00
[    1.421293] radeon 0000:01:00.0: fence driver on ring 3 use gpu addr 0x0000000020000c0c
[    1.421667] radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 0x000000000005c418
[    1.421776] radeon 0000:01:00.0: radeon: MSI limited to 32-bit
[    1.421814] radeon 0000:01:00.0: radeon: using MSI.
[    1.421832] [drm] radeon: irq initialized.
[    1.437940] [drm] ring test on 0 succeeded in 1 usecs
[    1.437945] [drm] ring test on 3 succeeded in 2 usecs
[    1.625083] [drm] ring test on 5 succeeded in 1 usecs
[    1.625088] [drm] UVD initialized successfully.
[    1.625144] [drm] ib test on ring 0 succeeded in 0 usecs
[    1.625180] [drm] ib test on ring 3 succeeded in 0 usecs
[    1.995319] tsc: Refined TSC clocksource calibration: 3415.203 MHz
[    1.995334] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x313a68d0542, max_idle_ns: 440795381966 ns
[    1.995364] [drm] ib test on ring 5 succeeded
[    1.995485] [drm] Radeon Display Connectors
[    1.995486] [drm] Connector 0:
[    1.995487] [drm]   DVI-I-1
[    1.995488] [drm]   HPD2
[    1.995489] [drm]   DDC: 0x6430 0x6430 0x6434 0x6434 0x6438 0x6438 0x643c 0x643c
[    1.995490] [drm]   Encoders:
[    1.995491] [drm]     DFP1: INTERNAL_UNIPHY1
[    1.995492] [drm]     CRT2: INTERNAL_KLDSCP_DAC2
[    1.995493] [drm] Connector 1:
[    1.995494] [drm]   DVI-I-2
[    1.995494] [drm]   HPD4
[    1.995495] [drm]   DDC: 0x6440 0x6440 0x6444 0x6444 0x6448 0x6448 0x644c 0x644c
[    1.995497] [drm]   Encoders:
[    1.995497] [drm]     DFP2: INTERNAL_UNIPHY
[    1.995498] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    1.998236] clocksource: Switched to clocksource tsc
[    2.002187] [drm] Initialized radeon 2.50.0 for 0000:01:00.0 on minor 0
[    2.048780] [drm] fb mappable at 0xD034D000
[    2.048783] [drm] vram apper at 0xD0000000
[    2.048784] [drm] size 15360000
[    2.048785] [drm] fb depth is 24
[    2.048786] [drm]    pitch is 6400
[    2.080266] Console: switching to colour frame buffer device 150x100
[    2.083609] radeon 0000:01:00.0: [drm] fb0: radeondrmfb frame buffer device
[    2.084617] parport_pc 00:02: reported by Plug and Play ACPI
[    2.084678] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[    2.174721] loop: module loaded
[    2.174771] ahci 0000:00:11.0: version 3.0
[    2.174927] ahci 0000:00:11.0: AHCI vers 0001.0200, 32 command slots, 6 Gbps, SATA mode
[    2.174930] ahci 0000:00:11.0: 6/6 ports implemented (port mask 0x3f)
[    2.174932] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[    2.176432] scsi host0: ahci
[    2.177566] scsi host1: ahci
[    2.178697] scsi host2: ahci
[    2.179874] scsi host3: ahci
[    2.181049] scsi host4: ahci
[    2.182229] scsi host5: ahci
[    2.182275] ata1: SATA max UDMA/133 abar m1024@0xfe6ffc00 port 0xfe6ffd00 irq 19 lpm-pol 0
[    2.182278] ata2: SATA max UDMA/133 abar m1024@0xfe6ffc00 port 0xfe6ffd80 irq 19 lpm-pol 0
[    2.182280] ata3: SATA max UDMA/133 abar m1024@0xfe6ffc00 port 0xfe6ffe00 irq 19 lpm-pol 0
[    2.182282] ata4: SATA max UDMA/133 abar m1024@0xfe6ffc00 port 0xfe6ffe80 irq 19 lpm-pol 0
[    2.182284] ata5: SATA max UDMA/133 abar m1024@0xfe6ffc00 port 0xfe6fff00 irq 19 lpm-pol 0
[    2.182286] ata6: SATA max UDMA/133 abar m1024@0xfe6ffc00 port 0xfe6fff80 irq 19 lpm-pol 0
[    2.182456] tun: Universal TUN/TAP device driver, 1.6
[    2.182642] QUIRK: Enable AMD PLL fix
[    2.182653] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    2.182688] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 1
[    2.182713] ohci-pci 0000:00:12.0: irq 18, io mem 0xfe6fe000
[    2.237408] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.12
[    2.237413] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.237414] usb usb1: Product: OHCI PCI host controller
[    2.237416] usb usb1: Manufacturer: Linux 6.12.31 ohci_hcd
[    2.237417] usb usb1: SerialNumber: 0000:00:12.0
[    2.237530] hub 1-0:1.0: USB hub found
[    2.237537] hub 1-0:1.0: 5 ports detected
[    2.237696] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    2.237725] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 2
[    2.237739] ohci-pci 0000:00:13.0: irq 18, io mem 0xfe6fd000
[    2.292355] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.12
[    2.292359] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.292361] usb usb2: Product: OHCI PCI host controller
[    2.292362] usb usb2: Manufacturer: Linux 6.12.31 ohci_hcd
[    2.292363] usb usb2: SerialNumber: 0000:00:13.0
[    2.292453] hub 2-0:1.0: USB hub found
[    2.292459] hub 2-0:1.0: 5 ports detected
[    2.341415] ehci-pci 0000:00:12.2: EHCI Host Controller
[    2.341467] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 3
[    2.341470] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    2.341478] ehci-pci 0000:00:12.2: debug port 1
[    2.341508] ehci-pci 0000:00:12.2: irq 17, io mem 0xfe6ff800
[    2.347304] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    2.347338] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.12
[    2.347340] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.347342] usb usb3: Product: EHCI Host Controller
[    2.347343] usb usb3: Manufacturer: Linux 6.12.31 ehci_hcd
[    2.347344] usb usb3: SerialNumber: 0000:00:12.2
[    2.347428] hub 3-0:1.0: USB hub found
[    2.347433] hub 3-0:1.0: 5 ports detected
[    2.396331] hub 1-0:1.0: USB hub found
[    2.396339] hub 1-0:1.0: 5 ports detected
[    2.445409] ehci-pci 0000:00:13.2: EHCI Host Controller
[    2.445465] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 4
[    2.445470] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    2.445477] ehci-pci 0000:00:13.2: debug port 1
[    2.445502] ehci-pci 0000:00:13.2: irq 17, io mem 0xfe6ff400
[    2.451304] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    2.451334] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.12
[    2.451336] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.451338] usb usb4: Product: EHCI Host Controller
[    2.451339] usb usb4: Manufacturer: Linux 6.12.31 ehci_hcd
[    2.451340] usb usb4: SerialNumber: 0000:00:13.2
[    2.451424] hub 4-0:1.0: USB hub found
[    2.451429] hub 4-0:1.0: 5 ports detected
[    2.487354] ata1: SATA link down (SStatus 0 SControl 300)
[    2.487393] ata3: SATA link down (SStatus 0 SControl 300)
[    2.487413] ata6: SATA link down (SStatus 0 SControl 300)
[    2.487433] ata4: SATA link down (SStatus 0 SControl 300)
[    2.500282] hub 2-0:1.0: USB hub found
[    2.500290] hub 2-0:1.0: 5 ports detected
[    2.500383] ehci-pci 0000:00:16.2: EHCI Host Controller
[    2.500431] ehci-pci 0000:00:16.2: new USB bus registered, assigned bus number 5
[    2.500435] ehci-pci 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    2.500442] ehci-pci 0000:00:16.2: debug port 1
[    2.500467] ehci-pci 0000:00:16.2: irq 17, io mem 0xfe6ff000
[    2.506296] ehci-pci 0000:00:16.2: USB 2.0 started, EHCI 1.00
[    2.506328] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.12
[    2.506331] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.506332] usb usb5: Product: EHCI Host Controller
[    2.506333] usb usb5: Manufacturer: Linux 6.12.31 ehci_hcd
[    2.506334] usb usb5: SerialNumber: 0000:00:16.2
[    2.506418] hub 5-0:1.0: USB hub found
[    2.506423] hub 5-0:1.0: 4 ports detected
[    2.506515] ohci-pci 0000:00:14.5: OHCI PCI host controller
[    2.506542] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 6
[    2.506556] ohci-pci 0000:00:14.5: irq 18, io mem 0xfe6fc000
[    2.561346] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.12
[    2.561350] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.561351] usb usb6: Product: OHCI PCI host controller
[    2.561352] usb usb6: Manufacturer: Linux 6.12.31 ohci_hcd
[    2.561354] usb usb6: SerialNumber: 0000:00:14.5
[    2.561442] hub 6-0:1.0: USB hub found
[    2.561448] hub 6-0:1.0: 2 ports detected
[    2.561575] ohci-pci 0000:00:16.0: OHCI PCI host controller
[    2.561608] ohci-pci 0000:00:16.0: new USB bus registered, assigned bus number 7
[    2.561625] ohci-pci 0000:00:16.0: irq 18, io mem 0xfe6f3000
[    2.616347] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.12
[    2.616351] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.616352] usb usb7: Product: OHCI PCI host controller
[    2.616354] usb usb7: Manufacturer: Linux 6.12.31 ohci_hcd
[    2.616355] usb usb7: SerialNumber: 0000:00:16.0
[    2.616445] hub 7-0:1.0: USB hub found
[    2.616451] hub 7-0:1.0: 4 ports detected
[    2.616558] usbcore: registered new interface driver usb-storage
[    2.616607] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    2.616609] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    2.616709] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.616769] mousedev: PS/2 mouse device common for all mice
[    2.616833] rtc_cmos 00:01: RTC can wake from S4
[    2.616985] rtc_cmos 00:01: registered as rtc0
[    2.617007] rtc_cmos 00:01: setting system clock to 2025-10-21T14:44:56 UTC (1761057896)
[    2.617030] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    2.617042] i2c_dev: i2c /dev entries driver
[    2.617210] ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B2F (\_SB.PCI0.SBRG.ASOC.SMRG) (20240827/utaddress-204)
[    2.617216] ACPI: OSL: Resource conflict; ACPI support missing from driver?
[    2.617293] it87: Found IT8721F chip at 0x290, revision 3
[    2.617314] ACPI Warning: SystemIO range 0x0000000000000295-0x0000000000000296 conflicts with OpRegion 0x0000000000000290-0x00000000000002AF (\_SB.PCI0.SBRG.SIOR.ECRE) (20240827/utaddress-204)
[    2.617318] ACPI: OSL: Resource conflict; ACPI support missing from driver?
[    2.617425] EDAC MC0: Giving out device to module amd64_edac controller F10h: DEV 0000:00:18.3 (INTERRUPT)
[    2.617427] EDAC amd64: F10h detected (node 0).
[    2.617428] EDAC MC: DCT0 chip selects:
[    2.617429] EDAC amd64: MC: 0:  4096MB 1:  4096MB
[    2.617431] EDAC amd64: MC: 2:     0MB 3:     0MB
[    2.617432] EDAC amd64: MC: 4:     0MB 5:     0MB
[    2.617433] EDAC amd64: MC: 6:     0MB 7:     0MB
[    2.617434] EDAC MC: DCT1 chip selects:
[    2.617434] EDAC amd64: MC: 0:  4096MB 1:  4096MB
[    2.617436] EDAC amd64: MC: 2:     0MB 3:     0MB
[    2.617437] EDAC amd64: MC: 4:     0MB 5:     0MB
[    2.617438] EDAC amd64: MC: 6:     0MB 7:     0MB
[    2.617439] EDAC amd64: using x4 syndromes.
[    2.617446] EDAC PCI0: Giving out device to module amd64_edac controller EDAC PCI controller: DEV 0000:00:18.2 (POLLED)
[    2.617463] hid: raw HID events driver (C) Jiri Kosina
[    2.617486] usbcore: registered new interface driver usbhid
[    2.617487] usbhid: USB HID core driver
[    2.617757] NET: Registered PF_INET6 protocol family
[    2.618049] Segment Routing with IPv6
[    2.618060] In-situ OAM (IOAM) with IPv6
[    2.618076] NET: Registered PF_PACKET protocol family
[    2.618084] Key type dns_resolver registered
[    2.618269] microcode: Current revision: 0x010000b6
[    2.618322] IPI shorthand broadcast: enabled
[    2.620305] sched_clock: Marking stable (2619006365, 1233772)->(2830570426, -210330289)
[    2.620411] snd_hda_intel 0000:01:00.1: bound 0000:01:00.0 (ops 0xffffffff81f1c680)
[    2.620439] Loading compiled-in X.509 certificates
[    2.621419] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input3
[    2.623308] Key type encrypted registered
[    2.623931] acpi_cpufreq: overriding BIOS provided _PSD data
[    2.627347] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC892: line_outs=4 (0x14/0x15/0x16/0x17/0x0) type:line
[    2.627352] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    2.627354] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[    2.627355] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    2.627357] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x11/0x1e
[    2.627358] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    2.627360] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
[    2.627361] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
[    2.627363] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
[    2.634391] input: AT Raw Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    2.641326] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.641347] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.641449] input: HDA ATI SB Rear Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input4
[    2.641482] input: HDA ATI SB Front Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input5
[    2.641512] input: HDA ATI SB Line as /devices/pci0000:00/0000:00:14.2/sound/card0/input6
[    2.641543] input: HDA ATI SB Line Out Front as /devices/pci0000:00/0000:00:14.2/sound/card0/input7
[    2.641576] ata2.00: Model 'INTEL SSDSA2BW600G3D', rev '4PC10362', applying quirks: zeroaftertrim
[    2.641584] input: HDA ATI SB Line Out Surround as /devices/pci0000:00/0000:00:14.2/sound/card0/input8
[    2.641606] ata2.00: ATA-8: INTEL SSDSA2BW600G3D, 4PC10362, max UDMA/133
[    2.641608] ata2.00: 1172123568 sectors, multi 1: LBA48 NCQ (depth 32)
[    2.641629] input: HDA ATI SB Line Out CLFE as /devices/pci0000:00/0000:00:14.2/sound/card0/input9
[    2.641661] input: HDA ATI SB Line Out Side as /devices/pci0000:00/0000:00:14.2/sound/card0/input10
[    2.641696] input: HDA ATI SB Front Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input11
[    2.641911] ata2.00: configured for UDMA/133
[    2.652058] scsi 1:0:0:0: Direct-Access     ATA      INTEL SSDSA2BW60 0362 PQ: 0 ANSI: 5
[    2.652245] ata2.00: Enabling discard_zeroes_data
[    2.652253] sd 1:0:0:0: [sda] 1172123568 512-byte logical blocks: (600 GB/559 GiB)
[    2.652264] sd 1:0:0:0: Attached scsi generic sg0 type 0
[    2.652276] sd 1:0:0:0: [sda] Write Protect is off
[    2.652278] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.652287] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.652316] sd 1:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    2.652468] ata2.00: Enabling discard_zeroes_data
[    2.669702]  sda: sda1 sda4 < sda5 >
[    2.669735] ata5.00: ATA-10: ST4000DM004-2CV104, 0001, max UDMA/133
[    2.669803] sd 1:0:0:0: [sda] Attached SCSI disk
[    2.678838] ata5.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    2.738813] ata5.00: configured for UDMA/133
[    2.738884] scsi 4:0:0:0: Direct-Access     ATA      ST4000DM004-2CV1 0001 PQ: 0 ANSI: 5
[    2.739033] sd 4:0:0:0: Attached scsi generic sg1 type 0
[    2.739051] sd 4:0:0:0: [sdb] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    2.739053] sd 4:0:0:0: [sdb] 4096-byte physical blocks
[    2.739067] sd 4:0:0:0: [sdb] Write Protect is off
[    2.739068] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.739078] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.739091] sd 4:0:0:0: [sdb] Preferred minimum I/O size 4096 bytes
[    2.787626] sd 4:0:0:0: [sdb] Attached SCSI disk

