Return-Path: <linux-pci+bounces-38899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D032BBF6D1B
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 15:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5187E188D5B6
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 13:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1744622B8CB;
	Tue, 21 Oct 2025 13:35:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A00033509E
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053757; cv=none; b=RkGUffziZ+yZ6f1DM2vB+LVGft2UbtBEsuNdXuZCUcfbib7Kc+tFkEIpCUFj8aEzhXaJ2f5P9XfOuTwOpqWIxo2gVH2oI9gQw9SvJxql9TJa1l/LkHzR8RZ2fh30eKeesz8WdkjnTqygGHKYsdCFGW/ht2ozxCVs+y+IIEzLk+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053757; c=relaxed/simple;
	bh=fxXGDWDsaXQDKyVNNL/ttb7TurKLyB1MY3degxrOIO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWgad9noBnBlqLrtqG0rSwiVDdtJYYgIepV4LNY5qtXCFzZ0tGD1PPKgAf3x+m1GOqaO9jBbU01h7K6z5iqVU8MzAWimo6rPccYEITMruZHb64nX4RPlFuN0xkQb6h9Zf/fua4LHPMC4HelrPjNrtZHAxzJ1N+zj1oHLZhPBHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avm99963.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avm99963.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47103531eeeso2727635e9.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 06:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761053746; x=1761658546;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CcBw4de97wsLijXjrb6FQtZRBSTtWu3bhcWZlzJd/s=;
        b=g+oePVgLxepTJNkthgwDWGlMM80aAAMU2xN2XPSpTRA2qqQUELoDvvT7tJusprj7cr
         z6SCAKpmyis0zD7M8goGu5qtt4OQodvW1ekrN20Xx9dI/ethI4qI03Kbnd6unbxSJREk
         c887OfZr/B24XRgO9p8OPkBkS4FH/vU4PwlHunB+AsSPrjGCYPpFzUcGw1AsV6tsFStd
         0MWMWu/u39opYuBDtrqwvbVYtb8RlrET/gZ/xMaNzMTIkf5e/hmLRyfoNv8HSsQwJ4oO
         UjgHUtEUnz0HcjbTV789xqARvd+A1a7sjxJM6xTl+I2ijstzBpBX35uoSmYc9EtKbprD
         8WlA==
X-Forwarded-Encrypted: i=1; AJvYcCW54vynAufNBW87PwqdpgswLRZbaV2f3Ouh5nro6+BYotVd/RvzqvpKQ4YiX+CqzYV3klIMg8f2QUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1mxgsig7KVIXa+BN2KLiUKIAc012xm9mBtHhl/fkZShbpqe4+
	y5l7JaCqqMrn0o422DKdmNn+LnLQH3rfAQC9GDcPQi/Nex2qSQYYXIklK3EDyurU6l09UA==
X-Gm-Gg: ASbGncueL3NNnYFw9PfnYRusUx7LbJ/4gw+npFreMRxrfHUaKgkJSZlYijFGhG6eNDY
	Zi8R0/9ihU9NJxKm8IZC4k8YBeHkvalllVpcBHyKaLgjMLT2qJUNodrlbVIf6nEL91/u34PNFwe
	4IPkEdV7scDVY1jTmjhZ9DukAK1hkSEOyQf3w69cyzx9w8qrv5X1lxzLJaMbThg3gxYkkWnn6Nc
	Bxt1twypl48Ou0Z6sRdk7s+C1Hr85Vba+eNZJ3uWu2jH8NtkvyBp6X9jCtIgpYD/+/HWgEcw6TF
	UQwmIAmjcVIGUOm0SSN9EGEH78q1fanXqM0Z3ldka5NTiXrVu8H23JCFw7eo4r0wuFBcyaAXFyc
	KNVe+Fz2nuBwxH/XxVmJP1/G4yZKHyArD/EiMNmlI3gS9T1zKCLjGlWOEQkZlripe3jT7dpOnss
	eJaqGqW25nRdO0NOvIdpvhqP19EcKiyNa141QkZUh9ZvZ9
X-Google-Smtp-Source: AGHT+IH4KuDpVIGE9hg2vOqOMtE9V8+bu3BlmNvM+eo58akTBAfCMw5eUiJZVicVLjPB4k4uXGsJyA==
X-Received: by 2002:a05:600c:8b17:b0:46e:3e63:9a7f with SMTP id 5b1f17b1804b1-4749437b817mr15805325e9.3.1761053745276;
        Tue, 21 Oct 2025 06:35:45 -0700 (PDT)
Received: from pixelbook (181.red-83-42-91.dynamicip.rima-tde.net. [83.42.91.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144239f4sm283107685e9.2.2025.10.21.06.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:35:44 -0700 (PDT)
Date: Tue, 21 Oct 2025 15:35:42 +0200
From: =?utf-8?Q?Adri=C3=A0_Vilanova_Mart=C3=ADnez?= <me@avm99963.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	"Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, regressions@lists.linux.dev, 
	linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] Intel Wireless adapter is not detected until
 suspending to RAM and resuming
Message-ID: <zmkurgnjb4zw7zcg6uucbtvuratxlaau5lvhkgknidpjz7vnb7@dnsyjbrqtvqw>
References: <149b04c5-23d3-4fd8-9724-5b955b645fbb@kernel.org>
 <20251020232510.GA1167305@bhelgaas>
 <aPc4JpVyhCY1Oqd-@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xpdscytg3qlwzotp"
Content-Disposition: inline
In-Reply-To: <aPc4JpVyhCY1Oqd-@wunner.de>
User-Agent: NeoMutt/20250905-dirty


--xpdscytg3qlwzotp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 21, 2025 at 09:37:10AM +0200, Lukas Wunner wrote:
> On Mon, Oct 20, 2025 at 06:25:10PM -0500, Bjorn Helgaas wrote:
> >   [    0.113379] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400 PCIe Root Port
> >   [    0.113403] pci 0000:00:1c.0: PCI bridge to [bus 01]
> >   [    0.113409] pci 0000:00:1c.0:   bridge window [mem 0x91000000-0x910fffff]
> >   [    0.115692] pci 0000:01:00.0: [8086:095a] type 00 class 0x028000 PCIe Endpoint
> >   [    0.115830] pci 0000:01:00.0: BAR 0 [mem 0x91000000-0x91001fff 64bit]
> >   [    0.196539] pcieport 0000:00:1c.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> >   [    0.196802] pcieport 0000:00:1c.0: pciehp: Slot(0): Card not present
> >   [    0.196925] pcieport 0000:00:1c.0: pciehp: Slot(0): Card present
> >   [    0.196927] pcieport 0000:00:1c.0: pciehp: Slot(0): Link Up
> >   [    1.400127] pcieport 0000:00:1c.0: pciehp: Slot(0): No device found
> 
> Does this flap of the Presence Detect State bit also happen with
> 4d4c10f763d7?

Yes, it also happens if I revert 4d4c10f763d7 (except for the "No device
found" line).

And after checking previous boots on journalctl, it also happened when
booting with Kernel 6.15.0 (again except the last line). That version
doesn't have that commit either and I didn't experience the issue there.

> AFAICS, no dmesg output has been provided yet for
> the working case.  It would also be good to have debug output enabled,
> i.e. set CONFIG_DYNAMIC_DEBUG=y and add this to the command line:
> 
>   pciehp.pciehp_debug=1 dyndbg="file drivers/pci/* +p"

Done. You'll find attached:

1) 01_dmesg_with_4d4c10f763d7.log: dmesg for a "non-working" build made
on my last pull of mainline (commit 1c64efcb083c). After booting, I
suspended and resumed the system as well.

2) 02_dmesg_without_4d4c10f763d7.log: dmesg for a "working" build based
on the aforementioned mainline with reverts for commits 4d4c10f763d7 and
0a0829b1fd applied on top of it.

> Does it help if in drivers/pci/hotplug/pciehp_hpc.c:pci_bus_check_dev(),
> the "delay" is initialized to a higher value, say, 5000 instead of 1000?

Unfortunately, no. The issue persists.

Again, thanks everybody for all your help!

--xpdscytg3qlwzotp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="01_dmesg_with_4d4c10f763d7.log"

[    0.000000] Linux version 6.18.0-rc1-local-00349-g1c64efcb083c (avm99963@pixelbook) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU Binutils) 2.45.0) #27 SMP PREEMPT_DYNAMIC Tue Oct 21 13:57:29 CEST 2025
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-linux-local-bisect root=/dev/mapper/VolGroup00-root rw loglevel=3 quiet cryptdevice=UUID=70c55651-98b6-4a3d-9c6a-9f9e70c23225:cryptroot root=/dev/VolGroup00/root pciehp.pciehp_debug=1 "dyndbg=file drivers/pci/* +p"
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000001000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000779c6fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000779c7000-0x0000000077adafff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000077adb000-0x000000007a259fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a25a000-0x000000007a25cfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007a25d000-0x000000007a7b2fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a7b3000-0x000000007a9b2fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007a9b3000-0x000000007a9c2fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a9c3000-0x000000007a9d7fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007a9d8000-0x000000007a9d8fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a9d9000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000027effffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] efi: EFI v2.7 by EDK II
[    0.000000] efi: SMBIOS=0x7a99a000 SMBIOS 3.0=0x7a998000 ACPI=0x7a9d7000 ACPI 2.0=0x7a9d7014 MEMATTR=0x771ef298 INITRD=0x77799e18 
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: Google Eve/Eve, BIOS MrChromebox-2509.1 10/13/2025
[    0.000000] DMI: Memory slots populated: 2/2
[    0.000000] tsc: Detected 1600.000 MHz processor
[    0.000000] tsc: Detected 1599.960 MHz TSC
[    0.000012] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000014] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000021] last_pfn = 0x27f000 max_arch_pfn = 0x400000000
[    0.000027] MTRR map: 7 entries (3 fixed + 4 variable; max 23), built from 10 variable MTRRs
[    0.000029] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000380] last_pfn = 0x7a9d9 max_arch_pfn = 0x400000000
[    0.008207] Using GB pages for direct mapping
[    0.008719] Secure boot disabled
[    0.008720] RAMDISK: [mem 0x7162f000-0x735bffff]
[    0.008767] ACPI: Early table checksum verification disabled
[    0.008770] ACPI: RSDP 0x000000007A9D7014 000024 (v02 COREv4)
[    0.008774] ACPI: XSDT 0x000000007A9D60E8 00007C (v01 COREv4 COREBOOT 00000000      01000013)
[    0.008780] ACPI: FACP 0x000000007A9D5000 000114 (v06 COREv4 COREBOOT 00000000 CORE 20250404)
[    0.008786] ACPI: DSDT 0x000000007A9D0000 00474F (v02 COREv4 COREBOOT 20110725 INTL 20250404)
[    0.008789] ACPI: FACS 0x000000007A9F1240 000040
[    0.008792] ACPI: SSDT 0x000000007A9CE000 001921 (v02 COREv4 COREBOOT 00000000 CORE 20250404)
[    0.008795] ACPI: MCFG 0x000000007A9CD000 00003C (v01 COREv4 COREBOOT 00000000 CORE 20250404)
[    0.008798] ACPI: TPM2 0x000000007A9CC000 00004C (v04 COREv4 COREBOOT 00000000 CORE 20250404)
[    0.008801] ACPI: LPIT 0x000000007A9CB000 000094 (v00 COREv4 COREBOOT 00000000 CORE 20250404)
[    0.008804] ACPI: APIC 0x000000007A9CA000 000072 (v03 COREv4 COREBOOT 00000000 CORE 20250404)
[    0.008807] ACPI: NHLT 0x000000007A9C9000 000388 (v05 GOOGLE EVEMAX   00000000 CORE 00000000)
[    0.008810] ACPI: DMAR 0x000000007A9C8000 000088 (v01 COREv4 COREBOOT 00000000 CORE 20250404)
[    0.008816] ACPI: DBG2 0x000000007A9C7000 000061 (v00 COREv4 COREBOOT 00000000 CORE 20250404)
[    0.008821] ACPI: HPET 0x000000007A9C6000 000038 (v01 COREv4 COREBOOT 00000000 CORE 20250404)
[    0.008826] ACPI: BGRT 0x000000007A9C5000 000038 (v01 COREv4 EDK2     00000002      01000013)
[    0.008829] ACPI: Reserving FACP table memory at [mem 0x7a9d5000-0x7a9d5113]
[    0.008830] ACPI: Reserving DSDT table memory at [mem 0x7a9d0000-0x7a9d474e]
[    0.008831] ACPI: Reserving FACS table memory at [mem 0x7a9f1240-0x7a9f127f]
[    0.008832] ACPI: Reserving SSDT table memory at [mem 0x7a9ce000-0x7a9cf920]
[    0.008833] ACPI: Reserving MCFG table memory at [mem 0x7a9cd000-0x7a9cd03b]
[    0.008833] ACPI: Reserving TPM2 table memory at [mem 0x7a9cc000-0x7a9cc04b]
[    0.008834] ACPI: Reserving LPIT table memory at [mem 0x7a9cb000-0x7a9cb093]
[    0.008835] ACPI: Reserving APIC table memory at [mem 0x7a9ca000-0x7a9ca071]
[    0.008836] ACPI: Reserving NHLT table memory at [mem 0x7a9c9000-0x7a9c9387]
[    0.008836] ACPI: Reserving DMAR table memory at [mem 0x7a9c8000-0x7a9c8087]
[    0.008837] ACPI: Reserving DBG2 table memory at [mem 0x7a9c7000-0x7a9c7060]
[    0.008838] ACPI: Reserving HPET table memory at [mem 0x7a9c6000-0x7a9c6037]
[    0.008838] ACPI: Reserving BGRT table memory at [mem 0x7a9c5000-0x7a9c5037]
[    0.008962] No NUMA configuration found
[    0.008963] Faking a node at [mem 0x0000000000000000-0x000000027effffff]
[    0.008973] NODE_DATA(0) allocated [mem 0x27efd5280-0x27effffff]
[    0.009199] Zone ranges:
[    0.009199]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.009201]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.009203]   Normal   [mem 0x0000000100000000-0x000000027effffff]
[    0.009204]   Device   empty
[    0.009205] Movable zone start for each node
[    0.009207] Early memory node ranges
[    0.009207]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.009209]   node   0: [mem 0x0000000000100000-0x00000000779c6fff]
[    0.009210]   node   0: [mem 0x0000000077adb000-0x000000007a259fff]
[    0.009211]   node   0: [mem 0x000000007a25d000-0x000000007a7b2fff]
[    0.009212]   node   0: [mem 0x000000007a9b3000-0x000000007a9c2fff]
[    0.009212]   node   0: [mem 0x000000007a9d8000-0x000000007a9d8fff]
[    0.009213]   node   0: [mem 0x0000000100000000-0x000000027effffff]
[    0.009215] Initmem setup node 0 [mem 0x0000000000001000-0x000000027effffff]
[    0.009233] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.009262] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.013620] On node 0, zone DMA32: 276 pages in unavailable ranges
[    0.013633] On node 0, zone DMA32: 3 pages in unavailable ranges
[    0.013640] On node 0, zone DMA32: 512 pages in unavailable ranges
[    0.013641] On node 0, zone DMA32: 21 pages in unavailable ranges
[    0.027647] On node 0, zone Normal: 22055 pages in unavailable ranges
[    0.027702] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.027718] Reserving Intel graphics memory at [mem 0x7c000000-0x7fffffff]
[    0.028047] ACPI: PM-Timer IO Port: 0x1808
[    0.028055] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.028091] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-119
[    0.028097] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.028106] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.028112] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.028113] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.028122] e820: update [mem 0x771ca000-0x771eefff] usable ==> reserved
[    0.028131] TSC deadline timer available
[    0.028136] CPU topo: Max. logical packages:   1
[    0.028137] CPU topo: Max. logical dies:       1
[    0.028137] CPU topo: Max. dies per package:   1
[    0.028142] CPU topo: Max. threads per core:   2
[    0.028143] CPU topo: Num. cores per package:     2
[    0.028143] CPU topo: Num. threads per package:   4
[    0.028144] CPU topo: Allowing 4 present CPUs plus 0 hotplug CPUs
[    0.028157] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.028159] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.028160] PM: hibernation: Registered nosave memory: [mem 0x771ca000-0x771eefff]
[    0.028162] PM: hibernation: Registered nosave memory: [mem 0x779c7000-0x77adafff]
[    0.028163] PM: hibernation: Registered nosave memory: [mem 0x7a25a000-0x7a25cfff]
[    0.028165] PM: hibernation: Registered nosave memory: [mem 0x7a7b3000-0x7a9b2fff]
[    0.028166] PM: hibernation: Registered nosave memory: [mem 0x7a9c3000-0x7a9d7fff]
[    0.028168] PM: hibernation: Registered nosave memory: [mem 0x7a9d9000-0xffffffff]
[    0.028169] [mem 0x80000000-0xffffffff] available for PCI devices
[    0.028170] Booting paravirtualized kernel on bare hardware
[    0.028173] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.035290] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.035655] percpu: Embedded 62 pages/cpu s217088 r8192 d28672 u524288
[    0.035662] pcpu-alloc: s217088 r8192 d28672 u524288 alloc=1*2097152
[    0.035664] pcpu-alloc: [0] 0 1 2 3 
[    0.035684] Kernel command line: BOOT_IMAGE=/vmlinuz-linux-local-bisect root=/dev/mapper/VolGroup00-root rw loglevel=3 quiet cryptdevice=UUID=70c55651-98b6-4a3d-9c6a-9f9e70c23225:cryptroot root=/dev/VolGroup00/root pciehp.pciehp_debug=1 "dyndbg=file drivers/pci/* +p"
[    0.035796] Unknown kernel command line parameters "cryptdevice=UUID=70c55651-98b6-4a3d-9c6a-9f9e70c23225:cryptroot", will be passed to user space.
[    0.035828] random: crng init done
[    0.035829] printk: log buffer data + meta data: 131072 + 458752 = 589824 bytes
[    0.036972] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.037544] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.037628] software IO TLB: area num 4.
[    0.056281] Fallback order for Node 0: 0 
[    0.056284] Built 1 zonelists, mobility grouping on.  Total pages: 2070092
[    0.056285] Policy zone: Normal
[    0.056628] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.081137] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.081160] Kernel/User page tables isolation: enabled
[    0.092694] ftrace: allocating 55181 entries in 216 pages
[    0.092696] ftrace: allocated 216 pages with 4 groups
[    0.092781] Dynamic Preempt: full
[    0.092820] rcu: Preemptible hierarchical RCU implementation.
[    0.092821] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
[    0.092822] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.092823] 	Trampoline variant of Tasks RCU enabled.
[    0.092824] 	Rude variant of Tasks RCU enabled.
[    0.092824] 	Tracing variant of Tasks RCU enabled.
[    0.092825] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.092825] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.092834] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
[    0.092835] RCU Tasks Rude: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
[    0.092837] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
[    0.099274] NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
[    0.099515] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.099789] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.099841] spurious 8259A interrupt: IRQ7.
[    0.099875] Console: colour dummy device 80x25
[    0.099878] printk: legacy console [tty0] enabled
[    0.099924] ACPI: Core revision 20250807
[    0.099996] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.100035] APIC: Switch to symmetric I/O mode setup
[    0.100037] DMAR: Host address width 39
[    0.100039] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.100045] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
[    0.100047] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.100052] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.100054] DMAR: RMRR base: 0x0000007b800000 end: 0x0000007fffffff
[    0.100057] DMAR-IR: IOAPIC id 0 under DRHD base  0xfed91000 IOMMU 1
[    0.100059] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.100060] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.101917] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.101919] x2apic enabled
[    0.101992] APIC: Switched APIC routing to: cluster x2apic
[    0.106056] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x170fff30cc4, max_idle_ns: 440795237869 ns
[    0.106062] Calibrating delay loop (skipped), value calculated using timer frequency.. 3199.92 BogoMIPS (lpj=1599960)
[    0.106092] x86/cpu: SGX disabled or unsupported by BIOS.
[    0.106098] CPU0: Thermal monitoring enabled (TM1)
[    0.106146] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.106147] Last level dTLB entries: 4KB 64, 2MB 32, 4MB 32, 1GB 4
[    0.106152] process: using mwait in idle threads
[    0.106155] mitigations: Enabled attack vectors: user_kernel, user_user, guest_host, guest_guest, SMT mitigations: auto
[    0.106159] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.106161] SRBDS: Mitigation: Microcode
[    0.106163] Spectre V2 : Mitigation: IBRS
[    0.106164] RETBleed: Mitigation: IBRS
[    0.106165] Spectre V2 : User space: Mitigation: STIBP via prctl
[    0.106166] MDS: Mitigation: Clear CPU buffers
[    0.106167] MMIO Stale Data: Mitigation: Clear CPU buffers
[    0.106168] VMSCAPE: Mitigation: IBPB before exit to userspace
[    0.106169] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.106170] Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on context switch and VMEXIT
[    0.106172] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.106184] GDS: Mitigation: Microcode
[    0.106191] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.106193] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.106194] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.106196] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.106197] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.106199] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.106201] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.106203] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.106204] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
[    0.107060] Freeing SMP alternatives memory: 56K
[    0.107060] pid_max: default: 32768 minimum: 301
[    0.107060] LSM: initializing lsm=capability,landlock,lockdown,yama,bpf
[    0.107060] landlock: Up and running.
[    0.107060] Yama: becoming mindful.
[    0.107060] LSM support for eBPF active
[    0.107060] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.107060] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.107060] smpboot: CPU0: Intel(R) Core(TM) i5-7Y57 CPU @ 1.20GHz (family: 0x6, model: 0x8e, stepping: 0x9)
[    0.107060] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.107060] ... version:                   4
[    0.107060] ... bit width:                 48
[    0.107060] ... generic counters:          4
[    0.107060] ... generic bitmap:            000000000000000f
[    0.107060] ... fixed-purpose counters:    3
[    0.107060] ... fixed-purpose bitmap:      0000000000000007
[    0.107060] ... value mask:                0000ffffffffffff
[    0.107060] ... max period:                00007fffffffffff
[    0.107060] ... global_ctrl mask:          000000070000000f
[    0.107060] signal: max sigframe size: 2032
[    0.107060] Estimated ratio of average max frequency by base frequency (times 1024): 1856
[    0.107060] rcu: Hierarchical SRCU implementation.
[    0.107060] rcu: 	Max phase no-delay instances is 400.
[    0.107060] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[    0.107668] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.107719] smp: Bringing up secondary CPUs ...
[    0.107835] smpboot: x86: Booting SMP configuration:
[    0.107837] .... node  #0, CPUs:      #1 #2 #3
[    0.110087] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.110092] MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.
[    0.110093] VMSCAPE: SMT on, STIBP is required for full protection. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/vmscape.html for more details.
[    0.110121] smp: Brought up 1 node, 4 CPUs
[    0.110121] smpboot: Total of 4 processors activated (12799.68 BogoMIPS)
[    0.111124] Memory: 7970244K/8280368K available (19657K kernel code, 2902K rwdata, 10348K rodata, 4624K init, 5140K bss, 297580K reserved, 0K cma-reserved)
[    0.111470] devtmpfs: initialized
[    0.111470] x86/mm: Memory block size: 128MB
[    0.112606] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.112606] posixtimers hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    0.112606] futex hash table entries: 1024 (65536 bytes on 1 NUMA nodes, total 64 KiB, linear).
[    0.112606] pinctrl core: initialized pinctrl subsystem
[    0.113063] PM: RTC time: 12:03:37, date: 2025-10-21
[    0.113598] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.113847] DMA: preallocated 1024 KiB GFP_KERNEL pool for atomic allocations
[    0.113915] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.114003] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.114013] audit: initializing netlink subsys (disabled)
[    0.114072] audit: type=2000 audit(1761048217.008:1): state=initialized audit_enabled=0 res=1
[    0.114181] thermal_sys: Registered thermal governor 'fair_share'
[    0.114183] thermal_sys: Registered thermal governor 'bang_bang'
[    0.114184] thermal_sys: Registered thermal governor 'step_wise'
[    0.114185] thermal_sys: Registered thermal governor 'user_space'
[    0.114186] thermal_sys: Registered thermal governor 'power_allocator'
[    0.114200] cpuidle: using governor ladder
[    0.114204] cpuidle: using governor menu
[    0.114319] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.114420] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
[    0.114438] PCI: Using configuration type 1 for base access
[    0.114607] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.118097] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.118097] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.118097] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.118097] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.118331] raid6: skipped pq benchmark and selected avx2x4
[    0.118334] raid6: using avx2x2 recovery algorithm
[    0.118414] ACPI: Added _OSI(Module Device)
[    0.118416] ACPI: Added _OSI(Processor Device)
[    0.118417] ACPI: Added _OSI(Processor Aggregator Device)
[    0.121756] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.123447] ACPI: EC: EC started
[    0.123447] ACPI: EC: interrupt blocked
[    0.123480] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.123482] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions
[    0.123484] ACPI: Interpreter enabled
[    0.123497] ACPI: PM: (supports S0 S3 S4 S5)
[    0.123499] ACPI: Using IOAPIC for interrupt routing
[    0.123868] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.123870] PCI: Ignoring E820 reservations for host bridge windows
[    0.131499] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.131506] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.131539] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
[    0.132200] PCI host bridge to bus 0000:00
[    0.132205] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.132208] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.132211] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000fffff window]
[    0.132212] pci_bus 0000:00: root bus resource [mem 0x80000000-0xdfffffff window]
[    0.132214] pci_bus 0000:00: root bus resource [mem 0x27f000000-0x7fffffffff window]
[    0.132216] pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7fffff window]
[    0.132218] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.132222] pci_bus 0000:00: scanning bus
[    0.132248] pci 0000:00:00.0: [8086:590c] type 00 class 0x060000 conventional PCI endpoint
[    0.132302] pci 0000:00:00.0: EDR: Notify handler installed
[    0.132377] pci 0000:00:02.0: [8086:591e] type 00 class 0x030000 PCIe Root Complex Integrated Endpoint
[    0.132396] pci 0000:00:02.0: BAR 0 [mem 0xcf000000-0xcfffffff 64bit]
[    0.132399] pci 0000:00:02.0: BAR 2 [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.132401] pci 0000:00:02.0: BAR 4 [io  0xffc0-0xffff]
[    0.132415] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.132453] pci 0000:00:02.0: EDR: Notify handler installed
[    0.132533] pci 0000:00:04.0: [8086:1903] type 00 class 0x118000 conventional PCI endpoint
[    0.132555] pci 0000:00:04.0: BAR 0 [mem 0xceed8000-0xceedffff 64bit]
[    0.132598] pci 0000:00:04.0: EDR: Notify handler installed
[    0.132718] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330 conventional PCI endpoint
[    0.132760] pci 0000:00:14.0: BAR 0 [mem 0xceef0000-0xceefffff 64bit]
[    0.132799] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.132804] pci 0000:00:14.0: PME# disabled
[    0.132827] pci 0000:00:14.0: power state changed by ACPI to D0
[    0.132830] pci 0000:00:14.0: ACPI _REG connect evaluation failed (5)
[    0.132866] pci 0000:00:14.0: EDR: Notify handler installed
[    0.132961] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000 conventional PCI endpoint
[    0.133001] pci 0000:00:14.2: BAR 0 [mem 0xceecf000-0xceecffff 64bit]
[    0.133128] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000 conventional PCI endpoint
[    0.133187] pci 0000:00:15.0: BAR 0 [mem 0xceece000-0xceecefff 64bit]
[    0.133271] pci 0000:00:15.0: EDR: Notify handler installed
[    0.133347] pci 0000:00:15.1: [8086:9d61] type 00 class 0x118000 conventional PCI endpoint
[    0.133407] pci 0000:00:15.1: BAR 0 [mem 0xceecd000-0xceecdfff 64bit]
[    0.133484] pci 0000:00:15.1: EDR: Notify handler installed
[    0.133562] pci 0000:00:15.2: [8086:9d62] type 00 class 0x118000 conventional PCI endpoint
[    0.133621] pci 0000:00:15.2: BAR 0 [mem 0xceecc000-0xceeccfff 64bit]
[    0.133699] pci 0000:00:15.2: EDR: Notify handler installed
[    0.133805] pci 0000:00:19.0: [8086:9d66] type 00 class 0x118000 conventional PCI endpoint
[    0.133863] pci 0000:00:19.0: BAR 0 [mem 0xfe030000-0xfe030fff 64bit]
[    0.133868] pci 0000:00:19.0: BAR 2 [mem 0xceeca000-0xceecafff 64bit]
[    0.133942] pci 0000:00:19.0: EDR: Notify handler installed
[    0.134019] pci 0000:00:19.2: [8086:9d64] type 00 class 0x118000 conventional PCI endpoint
[    0.134080] pci 0000:00:19.2: BAR 0 [mem 0xceec9000-0xceec9fff 64bit]
[    0.134163] pci 0000:00:19.2: EDR: Notify handler installed
[    0.134272] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400 PCIe Root Port
[    0.134296] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.134302] pci 0000:00:1c.0:   bridge window [mem 0xcef00000-0xceffffff]
[    0.134374] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.134378] pci 0000:00:1c.0: PME# disabled
[    0.134434] pci 0000:00:1c.0: EDR: Notify handler installed
[    0.134571] pci 0000:00:1e.0: [8086:9d27] type 00 class 0x118000 conventional PCI endpoint
[    0.134630] pci 0000:00:1e.0: BAR 0 [mem 0xceec8000-0xceec8fff 64bit]
[    0.134635] pci 0000:00:1e.0: BAR 2 [mem 0xceec7000-0xceec7fff 64bit]
[    0.134710] pci 0000:00:1e.0: EDR: Notify handler installed
[    0.134787] pci 0000:00:1e.2: [8086:9d29] type 00 class 0x118000 conventional PCI endpoint
[    0.134846] pci 0000:00:1e.2: BAR 0 [mem 0xceec6000-0xceec6fff 64bit]
[    0.134925] pci 0000:00:1e.2: EDR: Notify handler installed
[    0.135001] pci 0000:00:1e.4: [8086:9d2b] type 00 class 0x080501 conventional PCI endpoint
[    0.135056] pci 0000:00:1e.4: BAR 0 [mem 0xceec5000-0xceec5fff 64bit]
[    0.135112] pci 0000:00:1e.4: power state changed by ACPI to D0
[    0.135115] pci 0000:00:1e.4: ACPI _REG connect evaluation failed (5)
[    0.135190] pci 0000:00:1e.4: EDR: Notify handler installed
[    0.135342] pci 0000:00:1f.0: [8086:9d4b] type 00 class 0x060100 conventional PCI endpoint
[    0.135429] pci 0000:00:1f.0: EDR: Notify handler installed
[    0.135516] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000 conventional PCI endpoint
[    0.135561] pci 0000:00:1f.2: BAR 0 [mem 0xceed4000-0xceed7fff]
[    0.135594] pci 0000:00:1f.2: EDR: Notify handler installed
[    0.135669] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040100 conventional PCI endpoint
[    0.135723] pci 0000:00:1f.3: BAR 0 [mem 0xceed0000-0xceed3fff 64bit]
[    0.135730] pci 0000:00:1f.3: BAR 4 [mem 0xceee0000-0xceeeffff 64bit]
[    0.135774] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.135779] pci 0000:00:1f.3: PME# disabled
[    0.135828] pci 0000:00:1f.3: EDR: Notify handler installed
[    0.135965] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500 conventional PCI endpoint
[    0.136095] pci 0000:00:1f.4: BAR 0 [mem 0xceec3000-0xceec30ff 64bit]
[    0.136106] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.136166] pci 0000:00:1f.4: EDR: Notify handler installed
[    0.136226] pci 0000:00:1f.5: [8086:9d24] type 00 class 0x000000 conventional PCI endpoint
[    0.136274] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.136334] pci_bus 0000:00: fixups for bus
[    0.136338] pci 0000:00:1c.0: scanning [bus 01-01] behind bridge, pass 0
[    0.136535] pci_bus 0000:01: scanning bus
[    0.136679] pci 0000:01:00.0: [8086:095a] type 00 class 0x028000 PCIe Endpoint
[    0.136818] pci 0000:01:00.0: BAR 0 [mem 0xcef00000-0xcef01fff 64bit]
[    0.137116] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.137172] pci 0000:01:00.0: PME# disabled
[    0.137508] pci 0000:01:00.0: EDR: Notify handler installed
[    0.139363] pci_bus 0000:01: fixups for bus
[    0.139365] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.139379] pci_bus 0000:01: bus scan returning with max=01
[    0.139385] pci 0000:00:1c.0: scanning [bus 01-01] behind bridge, pass 1
[    0.139390] pci_bus 0000:00: bus scan returning with max=01
[    0.139776] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
[    0.139859] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.139938] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.140016] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.140098] ACPI: PCI: Interrupt link LNKE configured for IRQ 11
[    0.140177] ACPI: PCI: Interrupt link LNKF configured for IRQ 11
[    0.140255] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
[    0.140333] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
[    0.142005] Low-power S0 idle used by default for system suspend
[    0.142437] ACPI: EC: interrupt unblocked
[    0.142438] ACPI: EC: event unblocked
[    0.142446] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.142447] ACPI: EC: GPE=0x6e
[    0.142449] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC initialization complete
[    0.142451] ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions and events
[    0.142553] iommu: Default domain type: Translated
[    0.142553] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.144213] SCSI subsystem initialized
[    0.144221] libata version 3.00 loaded.
[    0.144221] ACPI: bus type USB registered
[    0.144221] usbcore: registered new interface driver usbfs
[    0.144221] usbcore: registered new interface driver hub
[    0.144221] usbcore: registered new device driver usb
[    0.144221] EDAC MC: Ver: 3.0.0
[    0.144395] efivars: Registered efivars operations
[    0.144395] NetLabel: Initializing
[    0.144395] NetLabel:  domain hash size = 128
[    0.144395] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.144395] NetLabel:  unlabeled traffic allowed by default
[    0.144395] mctp: management component transport protocol core
[    0.144395] NET: Registered PF_MCTP protocol family
[    0.144395] PCI: Using ACPI for IRQ routing
[    0.173939] PCI: pci_cache_line_size set to 64 bytes
[    0.174249] e820: reserve RAM buffer [mem 0x771ca000-0x77ffffff]
[    0.174251] e820: reserve RAM buffer [mem 0x779c7000-0x77ffffff]
[    0.174253] e820: reserve RAM buffer [mem 0x7a25a000-0x7bffffff]
[    0.174254] e820: reserve RAM buffer [mem 0x7a7b3000-0x7bffffff]
[    0.174256] e820: reserve RAM buffer [mem 0x7a9c3000-0x7bffffff]
[    0.174257] e820: reserve RAM buffer [mem 0x7a9d9000-0x7bffffff]
[    0.174258] e820: reserve RAM buffer [mem 0x27f000000-0x27fffffff]
[    0.174294] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.174294] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.174294] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.174294] vgaarb: loaded
[    0.174294] clocksource: Switched to clocksource tsc-early
[    0.174920] VFS: Disk quotas dquot_6.6.0
[    0.174940] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.175036] pnp: PnP ACPI init
[    0.175148] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.175277] system 00:01: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.175280] system 00:01: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.175283] system 00:01: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.175285] system 00:01: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.175287] system 00:01: [mem 0xff000000-0xffffffff] has been reserved
[    0.175289] system 00:01: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.175291] system 00:01: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.175542] system 00:02: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.175582] system 00:03: [io  0x1800-0x18fe] has been reserved
[    0.175638] system 00:05: [io  0x0900-0x09fe] has been reserved
[    0.175675] system 00:06: [io  0x0200] has been reserved
[    0.175677] system 00:06: [io  0x0204] has been reserved
[    0.175679] system 00:06: [io  0x0800-0x087f] has been reserved
[    0.175681] system 00:06: [io  0x0880-0x08ff] has been reserved
[    0.176469] pnp: PnP ACPI: found 8 devices
[    0.182534] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.182598] NET: Registered PF_INET protocol family
[    0.182690] IP idents hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.184109] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
[    0.184137] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.184185] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.184376] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.184610] TCP: Hash tables configured (established 65536 bind 65536)
[    0.184687] MPTCP token hash table entries: 8192 (order: 5, 196608 bytes, linear)
[    0.184747] UDP hash table entries: 4096 (order: 6, 262144 bytes, linear)
[    0.184788] UDP-Lite hash table entries: 4096 (order: 6, 262144 bytes, linear)
[    0.184853] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.184860] NET: Registered PF_XDP protocol family
[    0.184870] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
[    0.184875] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
[    0.184888] pci 0000:00:1c.0: bridge window [mem 0x27f000000-0x27f1fffff 64bit pref]: assigned
[    0.184892] pci 0000:00:1c.0: bridge window [io  0x2000-0x2fff]: assigned
[    0.184896] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.184908] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.184913] pci 0000:00:1c.0:   bridge window [mem 0xcef00000-0xceffffff]
[    0.184916] pci 0000:00:1c.0:   bridge window [mem 0x27f000000-0x27f1fffff 64bit pref]
[    0.184923] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.184925] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.184927] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000fffff window]
[    0.184928] pci_bus 0000:00: resource 7 [mem 0x80000000-0xdfffffff window]
[    0.184930] pci_bus 0000:00: resource 8 [mem 0x27f000000-0x7fffffffff window]
[    0.184932] pci_bus 0000:00: resource 9 [mem 0xfc800000-0xfe7fffff window]
[    0.184934] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.184935] pci_bus 0000:01: resource 1 [mem 0xcef00000-0xceffffff]
[    0.184937] pci_bus 0000:01: resource 2 [mem 0x27f000000-0x27f1fffff 64bit pref]
[    0.185485] PCI: CLS 64 bytes, default 64
[    0.185576] pci 0000:00:1f.1: [8086:9d20] type 00 class 0x058000 conventional PCI endpoint
[    0.185721] pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]
[    0.185829] pci 0000:00:1f.1: vgaarb: pci_notify
[    0.185842] pci 0000:00:1f.1: PME# disabled
[    0.185844] pci 0000:00:1f.1: vgaarb: pci_notify
[    0.185872] pci 0000:00:1f.1: vgaarb: pci_notify
[    0.185878] pci 0000:00:1f.1: device released
[    0.185906] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.185907] software IO TLB: mapped [mem 0x000000006d62f000-0x000000007162f000] (64MB)
[    0.185993] Unpacking initramfs...
[    0.225173] Initialise system trusted keyrings
[    0.225185] Key type blacklist registered
[    0.225284] workingset: timestamp_bits=36 max_order=21 bucket_order=0
[    0.225722] fuse: init (API version 7.45)
[    0.225884] integrity: Platform Keyring initialized
[    0.225889] integrity: Machine keyring initialized
[    0.246797] xor: automatically using best checksumming function   avx       
[    0.246804] Key type asymmetric registered
[    0.246807] Asymmetric key parser 'x509' registered
[    0.246861] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    0.246971] io scheduler mq-deadline registered
[    0.246974] io scheduler kyber registered
[    0.247007] io scheduler bfq registered
[    0.248471] ledtrig-cpu: registered to indicate activity on CPUs
[    0.248523] pciehp: pcie_port_service_register = 0
[    0.248540] pcieport 0000:00:1c.0: vgaarb: pci_notify
[    0.248546] pcieport 0000:00:1c.0: runtime IRQ mapping not provided by arch
[    0.248814] pcieport 0000:00:1c.0: PME: Signaling with IRQ 120
[    0.248940] pcieport 0000:00:1c.0: AER: enabled with IRQ 120
[    0.248985] pcieport 0000:00:1c.0: pciehp: Slot Capabilities      : 0x0004b260
[    0.248988] pcieport 0000:00:1c.0: pciehp: Slot Status            : 0x0048
[    0.248991] pcieport 0000:00:1c.0: pciehp: Slot Control           : 0x0008
[    0.248994] pcieport 0000:00:1c.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.249165] pci_bus 0000:01: dev 00, created physical slot 0
[    0.249247] pcieport 0000:00:1c.0: pciehp: pcie_enable_notification: SLOTCTRL 58 write cmd 1028
[    0.249255] pcieport 0000:00:1c.0: pciehp: pending interrupts 0x0008 from Slot Status
[    0.249263] pcieport 0000:00:1c.0: pciehp: Slot(0): Card not present
[    0.249265] pcieport 0000:00:1c.0: pciehp: pciehp_unconfigure_device: domain:bus:dev = 0000:01:00
[    0.249270] pci 0000:01:00.0: PME# disabled
[    0.249286] pci 0000:01:00.0: vgaarb: pci_notify
[    0.249302] pcieport 0000:00:1c.0: bwctrl: enabled with IRQ 120
[    0.249304] pcieport 0000:00:1c.0: pciehp: pending interrupts 0x0008 from Slot Status
[    0.249335] pcieport 0000:00:1c.0: save config 0x00: 0x9d108086
[    0.249339] pcieport 0000:00:1c.0: save config 0x04: 0x00100507
[    0.249343] pcieport 0000:00:1c.0: save config 0x08: 0x060400f1
[    0.249346] pcieport 0000:00:1c.0: save config 0x0c: 0x00810010
[    0.249349] pcieport 0000:00:1c.0: save config 0x10: 0x00000000
[    0.249352] pcieport 0000:00:1c.0: save config 0x14: 0x00000000
[    0.249356] pcieport 0000:00:1c.0: save config 0x18: 0x00010100
[    0.249359] pcieport 0000:00:1c.0: save config 0x1c: 0x00002020
[    0.249360] pci 0000:01:00.0: EDR: Notify handler removed
[    0.249362] pcieport 0000:00:1c.0: save config 0x20: 0xcef0cef0
[    0.249365] pcieport 0000:00:1c.0: save config 0x24: 0x7f117f01
[    0.249369] pcieport 0000:00:1c.0: save config 0x28: 0x00000002
[    0.249372] pcieport 0000:00:1c.0: save config 0x2c: 0x00000002
[    0.249375] pcieport 0000:00:1c.0: save config 0x30: 0x00000000
[    0.249378] pcieport 0000:00:1c.0: save config 0x34: 0x00000040
[    0.249381] pcieport 0000:00:1c.0: save config 0x38: 0x00000000
[    0.249384] pcieport 0000:00:1c.0: save config 0x3c: 0x001201ff
[    0.249435] pcieport 0000:00:1c.0: vgaarb: pci_notify
[    0.251462] pci 0000:01:00.0: vgaarb: pci_notify
[    0.251493] pci 0000:01:00.0: device released
[    0.251504] pcieport 0000:00:1c.0: pciehp: pciehp_check_link_active: lnk_status = 3011
[    0.251507] pcieport 0000:00:1c.0: pciehp: Slot(0): Card present
[    0.251509] pcieport 0000:00:1c.0: pciehp: Slot(0): Link Up
[    0.251612] ACPI: AC: AC Adapter [AC] (on-line)
[    0.251684] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:06/PNP0C09:00/PNP0C0D:00/input/input0
[    0.251765] ACPI: button: Lid Switch [LID0]
[    0.251820] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.252451] ACPI: button: Power Button [PWRF]
[    0.252585] Monitor-Mwait will be used to enter C-1 state
[    0.252657] Monitor-Mwait will be used to enter C-2 state
[    0.252664] Monitor-Mwait will be used to enter C-3 state
[    0.253226] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.254217] ACPI: battery: Slot [BAT0] (battery present)
[    0.256701] hpet_acpi_add: no address or irqs in _CRS
[    0.256756] Non-volatile memory driver v1.3
[    0.256758] Linux agpgart interface v0.103
[    0.256846] ACPI: bus type drm_connector registered
[    0.257343] xhci_hcd 0000:00:14.0: vgaarb: pci_notify
[    0.257350] xhci_hcd 0000:00:14.0: runtime IRQ mapping not provided by arch
[    0.257515] xhci_hcd 0000:00:14.0: enabling bus mastering
[    0.257523] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.257530] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    0.258646] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000081109810
[    0.258666] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    0.259051] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.259057] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    0.259061] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    0.259120] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.18
[    0.259124] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.259126] usb usb1: Product: xHCI Host Controller
[    0.259129] usb usb1: Manufacturer: Linux 6.18.0-rc1-local-00349-g1c64efcb083c xhci-hcd
[    0.259131] usb usb1: SerialNumber: 0000:00:14.0
[    0.259327] hub 1-0:1.0: USB hub found
[    0.259357] hub 1-0:1.0: 12 ports detected
[    0.259865] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.18
[    0.259869] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.259871] usb usb2: Product: xHCI Host Controller
[    0.259873] usb usb2: Manufacturer: Linux 6.18.0-rc1-local-00349-g1c64efcb083c xhci-hcd
[    0.259875] usb usb2: SerialNumber: 0000:00:14.0
[    0.260042] hub 2-0:1.0: USB hub found
[    0.260066] hub 2-0:1.0: 6 ports detected
[    0.260346] xhci_hcd 0000:00:14.0: vgaarb: pci_notify
[    0.260387] usbcore: registered new interface driver usbserial_generic
[    0.260394] usbserial: USB Serial support registered for generic
[    0.260453] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    0.260457] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    0.260891] i8042: Warning: Keylock active
[    0.261088] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.261279] rtc_cmos 00:04: RTC can wake from S4
[    0.262089] rtc_cmos 00:04: registered as rtc0
[    0.262230] rtc_cmos 00:04: setting system clock to 2025-10-21T12:03:37 UTC (1761048217)
[    0.262275] rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram
[    0.262430] intel_pstate: Intel P-state driver initializing
[    0.262633] intel_pstate: HWP enabled
[    0.262969] simple-framebuffer simple-framebuffer.0: [drm] Registered 1 planes with drm panic
[    0.262972] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 on minor 0
[    0.265765] fbcon: Deferring console take-over
[    0.265784] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
[    0.265888] hid: raw HID events driver (C) Jiri Kosina
[    0.265928] usbcore: registered new interface driver usbhid
[    0.265930] usbhid: USB HID core driver
[    0.266039] drop_monitor: Initializing network drop monitor service
[    0.266167] NET: Registered PF_INET6 protocol family
[    0.267866] Segment Routing with IPv6
[    0.267869] RPL Segment Routing with IPv6
[    0.267879] In-situ OAM (IOAM) with IPv6
[    0.267916] NET: Registered PF_PACKET protocol family
[    0.268364] microcode: Current revision: 0x000000f6
[    0.268449] IPI shorthand broadcast: enabled
[    0.268623] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    0.271264] sched_clock: Marking stable (264005339, 6408038)->(318459398, -48046021)
[    0.271444] registered taskstats version 1
[    0.271585] Loading compiled-in X.509 certificates
[    0.302384] Freeing initrd memory: 32324K
[    0.309228] Loaded X.509 cert 'Build time autogenerated kernel key: 2fba5c546a93aa1945e8ad54c3c146853b40f2c1'
[    0.312484] zswap: loaded using pool zstd
[    0.312548] Demotion targets for Node 0: null
[    0.312852] Key type .fscrypt registered
[    0.312854] Key type fscrypt-provisioning registered
[    0.313164] Btrfs loaded, zoned=yes, fsverity=yes
[    0.313199] Key type big_key registered
[    0.313264] integrity: Loading X.509 certificate: UEFI:db
[    0.313291] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.313293] integrity: Loading X.509 certificate: UEFI:db
[    0.313307] integrity: Loaded X.509 cert 'Microsoft Corporation: Windows UEFI CA 2023: aefc5fbbbe055d8f8daa585473499417ab5a5272'
[    0.313309] integrity: Loading X.509 certificate: UEFI:db
[    0.313323] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.313325] integrity: Loading X.509 certificate: UEFI:db
[    0.313339] integrity: Loaded X.509 cert 'Microsoft UEFI CA 2023: 81aa6b3244c935bce0d6628af39827421e32497d'
[    0.313340] integrity: Loading X.509 certificate: UEFI:db
[    0.316973] integrity: Loaded X.509 cert 'System76 Secure Boot Database Key: 3a7a94cfb9868ddcd29105224b504d54b1f9d238'
[    0.318270] PM:   Magic number: 13:388:77
[    0.318382] RAS: Correctable Errors collector initialized.
[    0.318425] clk: Disabling unused clocks
[    0.319523] Freeing unused decrypted memory: 2036K
[    0.320294] Freeing unused kernel image (initmem) memory: 4624K
[    0.320392] Write protecting the kernel read-only data: 32768k
[    0.320861] Freeing unused kernel image (text/rodata gap) memory: 820K
[    0.321370] Freeing unused kernel image (rodata/data gap) memory: 1940K
[    0.368770] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.368775] rodata_test: all tests were successful
[    0.368777] x86/mm: Checking user space page tables
[    0.402657] pcieport 0000:00:1c.0: pciehp: pending interrupts 0x0108 from Slot Status
[    0.438297] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.438302] Run /init as init process
[    0.438303]   with arguments:
[    0.438305]     /init
[    0.438306]   with environment:
[    0.438307]     HOME=/
[    0.438308]     TERM=linux
[    0.438309]     cryptdevice=UUID=70c55651-98b6-4a3d-9c6a-9f9e70c23225:cryptroot
[    0.516423] usb 1-2: new high-speed USB device number 2 using xhci_hcd
[    0.656956] usb 1-2: New USB device found, idVendor=0bda, idProduct=564b, bcdDevice= 0.06
[    0.656961] usb 1-2: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    0.656963] usb 1-2: Product: WebCamera
[    0.656965] usb 1-2: Manufacturer: Generic
[    0.656967] usb 1-2: SerialNumber: \x07LOE65001063010A7B100DF5AI06BF12000
[    0.740881] sdhci: Secure Digital Host Controller Interface driver
[    0.740886] sdhci: Copyright(c) Pierre Ossman
[    0.746783] intel-spi 0000:00:1f.5: vgaarb: pci_notify
[    0.747216] intel-spi 0000:00:1f.5: runtime IRQ mapping not provided by arch
[    0.748341] intel-spi 0000:00:1f.5: vgaarb: pci_notify
[    0.751456] usb 2-2: new SuperSpeed USB device number 2 using xhci_hcd
[    0.763063] usb 2-2: New USB device found, idVendor=1d5c, idProduct=5001, bcdDevice= 1.00
[    0.763071] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    0.763074] usb 2-2: Product: USB3.0 Hub
[    0.763077] usb 2-2: Manufacturer: Fresco Logic, Inc.
[    0.764064] hub 2-2:1.0: USB hub found
[    0.764094] hub 2-2:1.0: 4 ports detected
[    0.766393] sdhci-pci 0000:00:1e.4: vgaarb: pci_notify
[    0.766401] sdhci-pci 0000:00:1e.4: runtime IRQ mapping not provided by arch
[    0.766405] sdhci-pci 0000:00:1e.4: SDHCI controller found [8086:9d2b] (rev 21)
[    0.768217] mmc0: SDHCI controller on PCI [0000:00:1e.4] using ADMA 64-bit
[    0.768261] sdhci-pci 0000:00:1e.4: vgaarb: pci_notify
[    0.862204] mmc0: new HS400 MMC card at address 0001
[    0.874437] usb 1-3: new full-speed USB device number 3 using xhci_hcd
[    0.924750] sdhci-pci 0000:00:1e.4: save config 0x00: 0x9d2b8086
[    0.924761] sdhci-pci 0000:00:1e.4: save config 0x04: 0x00100006
[    0.924765] sdhci-pci 0000:00:1e.4: save config 0x08: 0x08050121
[    0.924768] sdhci-pci 0000:00:1e.4: save config 0x0c: 0x00800010
[    0.924771] sdhci-pci 0000:00:1e.4: save config 0x10: 0xceec5004
[    0.924774] sdhci-pci 0000:00:1e.4: save config 0x14: 0x00000000
[    0.924777] sdhci-pci 0000:00:1e.4: save config 0x18: 0x00000000
[    0.924780] sdhci-pci 0000:00:1e.4: save config 0x1c: 0x00000000
[    0.924783] sdhci-pci 0000:00:1e.4: save config 0x20: 0x00000000
[    0.924786] sdhci-pci 0000:00:1e.4: save config 0x24: 0x00000000
[    0.924789] sdhci-pci 0000:00:1e.4: save config 0x28: 0x00000000
[    0.924791] sdhci-pci 0000:00:1e.4: save config 0x2c: 0x9d2b8086
[    0.924794] sdhci-pci 0000:00:1e.4: save config 0x30: 0x00000000
[    0.924797] sdhci-pci 0000:00:1e.4: save config 0x34: 0x00000080
[    0.924800] sdhci-pci 0000:00:1e.4: save config 0x38: 0x00000000
[    0.924803] sdhci-pci 0000:00:1e.4: save config 0x3c: 0x000002ff
[    0.924840] sdhci-pci 0000:00:1e.4: ACPI _REG disconnect evaluation failed (5)
[    0.924936] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D3hot
[    0.998599] usb 1-3: New USB device found, idVendor=8087, idProduct=0a2a, bcdDevice= 0.03
[    0.998604] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.111417] usb 1-5: new high-speed USB device number 4 using xhci_hcd
[    1.225418] tsc: Refined TSC clocksource calibration: 1608.000 MHz
[    1.225441] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x172daa3a18b, max_idle_ns: 440795212390 ns
[    1.227411] clocksource: Switched to clocksource tsc
[    1.234791] usb 1-5: New USB device found, idVendor=1d5c, idProduct=5011, bcdDevice= 1.00
[    1.234795] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.234799] usb 1-5: Product: USB2.0 Hub
[    1.234801] usb 1-5: Manufacturer: Fresco Logic, Inc.
[    1.235712] hub 1-5:1.0: USB hub found
[    1.235741] hub 1-5:1.0: 5 ports detected
[    1.302809] usb 2-2.4: new SuperSpeed USB device number 3 using xhci_hcd
[    1.440230] mmcblk0: mmc0:0001 DURM4R 116 GiB
[    1.440430] i915 0000:00:02.0: vgaarb: pci_notify
[    1.440437] i915 0000:00:02.0: runtime IRQ mapping not provided by arch
[    1.440589] i915 0000:00:02.0: [drm] Found kabylake/ulx (device ID 591e) integrated display version 9.00 stepping B0
[    1.443192] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D0
[    1.443197] sdhci-pci 0000:00:1e.4: ACPI _REG connect evaluation failed (5)
[    1.446761]  mmcblk0: p1 p2
[    1.446979] mmcblk0boot0: mmc0:0001 DURM4R 4.00 MiB
[    1.447968] mmcblk0boot1: mmc0:0001 DURM4R 4.00 MiB
[    1.448608] mmcblk0rpmb: mmc0:0001 DURM4R 4.00 MiB, chardev (239:0)
[    1.454414] pci 0000:01:00.0 id reading try 50 times with interval 20 ms to get ffffffff
[    1.454441] pcieport 0000:00:1c.0: pciehp: pciehp_check_link_status: lnk_status = 1011
[    1.454446] pcieport 0000:00:1c.0: pciehp: Slot(0): No device found
[    1.454454] pcieport 0000:00:1c.0: pciehp: pciehp_check_link_active: lnk_status = 1011
[    1.459922] i915 0000:00:02.0: vgaarb: deactivate vga console
[    1.460376] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    1.460381] i915 0000:00:02.0: vgaarb: decoding count now is: 1
[    1.460384] i915 0000:00:02.0: vgaarb: __vga_tryget: 1
[    1.460387] i915 0000:00:02.0: vgaarb: __vga_tryget: owns: 3
[    1.460393] i915 0000:00:02.0: vgaarb: __vga_put
[    1.462017] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
[    1.474407] i915 0000:00:02.0: [drm] Registered 3 planes with drm panic
[    1.474416] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 1
[    1.474603] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    1.474668] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input3
[    1.521319] fbcon: i915drmfb (fb0) is primary device
[    1.521323] fbcon: Deferring console take-over
[    1.521327] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    1.526464] i915 0000:00:02.0: vgaarb: pci_notify
[    1.531431] sdhci-pci 0000:00:1e.4: save config 0x00: 0x9d2b8086
[    1.531442] sdhci-pci 0000:00:1e.4: save config 0x04: 0x00100006
[    1.531446] sdhci-pci 0000:00:1e.4: save config 0x08: 0x08050121
[    1.531449] sdhci-pci 0000:00:1e.4: save config 0x0c: 0x00800010
[    1.531452] sdhci-pci 0000:00:1e.4: save config 0x10: 0xceec5004
[    1.531455] sdhci-pci 0000:00:1e.4: save config 0x14: 0x00000000
[    1.531459] sdhci-pci 0000:00:1e.4: save config 0x18: 0x00000000
[    1.531462] sdhci-pci 0000:00:1e.4: save config 0x1c: 0x00000000
[    1.531465] sdhci-pci 0000:00:1e.4: save config 0x20: 0x00000000
[    1.531468] sdhci-pci 0000:00:1e.4: save config 0x24: 0x00000000
[    1.531471] sdhci-pci 0000:00:1e.4: save config 0x28: 0x00000000
[    1.531473] sdhci-pci 0000:00:1e.4: save config 0x2c: 0x9d2b8086
[    1.531476] sdhci-pci 0000:00:1e.4: save config 0x30: 0x00000000
[    1.531479] sdhci-pci 0000:00:1e.4: save config 0x34: 0x00000080
[    1.531482] sdhci-pci 0000:00:1e.4: save config 0x38: 0x00000000
[    1.531485] sdhci-pci 0000:00:1e.4: save config 0x3c: 0x000002ff
[    1.531506] sdhci-pci 0000:00:1e.4: ACPI _REG disconnect evaluation failed (5)
[    1.531571] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D3hot
[    1.557253] device-mapper: uevent: version 1.0.3
[    1.557330] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
[    1.575657] Key type encrypted registered
[    1.580821] i915 0000:00:02.0: vgaarb: __vga_tryget: 1
[    1.580829] i915 0000:00:02.0: vgaarb: __vga_tryget: owns: 3
[    1.580834] i915 0000:00:02.0: vgaarb: __vga_put
[    1.589824] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D0
[    1.589831] sdhci-pci 0000:00:1e.4: ACPI _REG connect evaluation failed (5)
[    1.589860] usb 2-2.4: New USB device found, idVendor=0b95, idProduct=1790, bcdDevice= 2.00
[    1.589864] usb 2-2.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.589867] usb 2-2.4: Product: AX88179A
[    1.589869] usb 2-2.4: Manufacturer: ASIX
[    1.589870] usb 2-2.4: SerialNumber: 00A0CEC83D617A
[    1.595396] fbcon: Taking over console
[    1.655472] sdhci-pci 0000:00:1e.4: save config 0x00: 0x9d2b8086
[    1.655491] sdhci-pci 0000:00:1e.4: save config 0x04: 0x00100006
[    1.655502] sdhci-pci 0000:00:1e.4: save config 0x08: 0x08050121
[    1.655513] sdhci-pci 0000:00:1e.4: save config 0x0c: 0x00800010
[    1.655518] sdhci-pci 0000:00:1e.4: save config 0x10: 0xceec5004
[    1.655530] sdhci-pci 0000:00:1e.4: save config 0x14: 0x00000000
[    1.655541] sdhci-pci 0000:00:1e.4: save config 0x18: 0x00000000
[    1.655545] sdhci-pci 0000:00:1e.4: save config 0x1c: 0x00000000
[    1.655550] sdhci-pci 0000:00:1e.4: save config 0x20: 0x00000000
[    1.655555] sdhci-pci 0000:00:1e.4: save config 0x24: 0x00000000
[    1.655559] sdhci-pci 0000:00:1e.4: save config 0x28: 0x00000000
[    1.655563] sdhci-pci 0000:00:1e.4: save config 0x2c: 0x9d2b8086
[    1.655567] sdhci-pci 0000:00:1e.4: save config 0x30: 0x00000000
[    1.655570] sdhci-pci 0000:00:1e.4: save config 0x34: 0x00000080
[    1.655574] sdhci-pci 0000:00:1e.4: save config 0x38: 0x00000000
[    1.655578] sdhci-pci 0000:00:1e.4: save config 0x3c: 0x000002ff
[    1.655605] sdhci-pci 0000:00:1e.4: ACPI _REG disconnect evaluation failed (5)
[    1.655696] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D3hot
[    1.701826] Console: switching to colour frame buffer device 150x50
[    1.771537] usb 1-5.5: new high-speed USB device number 5 using xhci_hcd
[    1.856422] usb 1-5.5: New USB device found, idVendor=1d5c, idProduct=5100, bcdDevice= 1.00
[    1.856433] usb 1-5.5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.856438] usb 1-5.5: Product: Generic Billboard Device
[    1.856442] usb 1-5.5: Manufacturer: Fresco Logic, Inc
[    7.765491] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D0
[    7.765497] sdhci-pci 0000:00:1e.4: ACPI _REG connect evaluation failed (5)
[    7.828135] sdhci-pci 0000:00:1e.4: save config 0x00: 0x9d2b8086
[    7.828146] sdhci-pci 0000:00:1e.4: save config 0x04: 0x00100006
[    7.828151] sdhci-pci 0000:00:1e.4: save config 0x08: 0x08050121
[    7.828155] sdhci-pci 0000:00:1e.4: save config 0x0c: 0x00800010
[    7.828159] sdhci-pci 0000:00:1e.4: save config 0x10: 0xceec5004
[    7.828163] sdhci-pci 0000:00:1e.4: save config 0x14: 0x00000000
[    7.828167] sdhci-pci 0000:00:1e.4: save config 0x18: 0x00000000
[    7.828170] sdhci-pci 0000:00:1e.4: save config 0x1c: 0x00000000
[    7.828174] sdhci-pci 0000:00:1e.4: save config 0x20: 0x00000000
[    7.828178] sdhci-pci 0000:00:1e.4: save config 0x24: 0x00000000
[    7.828182] sdhci-pci 0000:00:1e.4: save config 0x28: 0x00000000
[    7.828185] sdhci-pci 0000:00:1e.4: save config 0x2c: 0x9d2b8086
[    7.828189] sdhci-pci 0000:00:1e.4: save config 0x30: 0x00000000
[    7.828193] sdhci-pci 0000:00:1e.4: save config 0x34: 0x00000080
[    7.828197] sdhci-pci 0000:00:1e.4: save config 0x38: 0x00000000
[    7.828200] sdhci-pci 0000:00:1e.4: save config 0x3c: 0x000002ff
[    7.828219] sdhci-pci 0000:00:1e.4: ACPI _REG disconnect evaluation failed (5)
[    7.828292] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D3hot
[    7.882263] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D0
[    7.882270] sdhci-pci 0000:00:1e.4: ACPI _REG connect evaluation failed (5)
[    7.974480] sdhci-pci 0000:00:1e.4: save config 0x00: 0x9d2b8086
[    7.974499] sdhci-pci 0000:00:1e.4: save config 0x04: 0x00100006
[    7.974510] sdhci-pci 0000:00:1e.4: save config 0x08: 0x08050121
[    7.974521] sdhci-pci 0000:00:1e.4: save config 0x0c: 0x00800010
[    7.974526] sdhci-pci 0000:00:1e.4: save config 0x10: 0xceec5004
[    7.974537] sdhci-pci 0000:00:1e.4: save config 0x14: 0x00000000
[    7.974548] sdhci-pci 0000:00:1e.4: save config 0x18: 0x00000000
[    7.974553] sdhci-pci 0000:00:1e.4: save config 0x1c: 0x00000000
[    7.974558] sdhci-pci 0000:00:1e.4: save config 0x20: 0x00000000
[    7.974563] sdhci-pci 0000:00:1e.4: save config 0x24: 0x00000000
[    7.974567] sdhci-pci 0000:00:1e.4: save config 0x28: 0x00000000
[    7.974572] sdhci-pci 0000:00:1e.4: save config 0x2c: 0x9d2b8086
[    7.974577] sdhci-pci 0000:00:1e.4: save config 0x30: 0x00000000
[    7.974582] sdhci-pci 0000:00:1e.4: save config 0x34: 0x00000080
[    7.974593] sdhci-pci 0000:00:1e.4: save config 0x38: 0x00000000
[    7.974598] sdhci-pci 0000:00:1e.4: save config 0x3c: 0x000002ff
[    7.974635] sdhci-pci 0000:00:1e.4: ACPI _REG disconnect evaluation failed (5)
[    7.974739] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D3hot
[    7.977821] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D0
[    7.977832] sdhci-pci 0000:00:1e.4: ACPI _REG connect evaluation failed (5)
[    8.013028] BTRFS: device label data devid 1 transid 97643 /dev/mapper/VolGroup00-root (253:1) scanned by mount (302)
[    8.013583] BTRFS info (device dm-1): first mount of filesystem 300f4e51-7c51-404c-96d9-1b224c97606d
[    8.013601] BTRFS info (device dm-1): using crc32c (crc32c-lib) checksum algorithm
[    8.057268] BTRFS info (device dm-1): enabling ssd optimizations
[    8.057275] BTRFS info (device dm-1): turning on async discard
[    8.057279] BTRFS info (device dm-1): enabling free space tree
[    8.360867] systemd[1]: systemd 258.1-1-arch running in system mode (+PAM +AUDIT -SELINUX +APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINIT +LIBARCHIVE)
[    8.360880] systemd[1]: Detected architecture x86-64.
[    8.361846] systemd[1]: Hostname set to <pixelbook>.
[    8.446295] systemd[1]: bpf-restrict-fs: Failed to load BPF object: No such process
[    8.998034] systemd[1]: Queued start job for default target Graphical Interface.
[    9.015002] systemd[1]: Created slice Slice /system/dirmngr.
[    9.015371] systemd[1]: Created slice Slice /system/getty.
[    9.015736] systemd[1]: Created slice Slice /system/gpg-agent.
[    9.016089] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    9.016472] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    9.016810] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    9.017137] systemd[1]: Created slice Slice /system/keyboxd.
[    9.017524] systemd[1]: Created slice Slice /system/modprobe.
[    9.017853] systemd[1]: Created slice Slice /system/systemd-fsck.
[    9.018105] systemd[1]: Created slice User and Session Slice.
[    9.018171] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    9.018223] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    9.018437] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    9.018480] systemd[1]: Expecting device /dev/disk/by-uuid/8178-5AD1...
[    9.018492] systemd[1]: Reached target Local Encrypted Volumes.
[    9.018509] systemd[1]: Reached target Image Downloads.
[    9.018519] systemd[1]: Reached target Local Integrity Protected Volumes.
[    9.018537] systemd[1]: Reached target Path Units.
[    9.018549] systemd[1]: Reached target Remote File Systems.
[    9.018558] systemd[1]: Reached target Slice Units.
[    9.018585] systemd[1]: Reached target Local Verity Protected Volumes.
[    9.018667] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    9.018742] systemd[1]: Listening on LVM2 poll daemon socket.
[    9.019666] systemd[1]: Listening on Query the User Interactively for a Password.
[    9.020739] systemd[1]: Listening on Process Core Dump Socket.
[    9.021350] systemd[1]: Listening on Credential Encryption/Decryption.
[    9.022247] systemd[1]: Listening on Factory Reset Management.
[    9.022352] systemd[1]: Listening on Journal Socket (/dev/log).
[    9.022497] systemd[1]: Listening on Journal Sockets.
[    9.022590] systemd[1]: TPM PCR Measurements was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    9.022606] systemd[1]: Make TPM PCR Policy was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    9.022681] systemd[1]: Listening on udev Control Socket.
[    9.022733] systemd[1]: Listening on udev Kernel Socket.
[    9.022798] systemd[1]: Listening on udev Varlink Socket.
[    9.022863] systemd[1]: Listening on User Database Manager Socket.
[    9.025610] systemd[1]: Mounting Huge Pages File System...
[    9.026447] systemd[1]: Mounting POSIX Message Queue File System...
[    9.027755] systemd[1]: Mounting Kernel Debug File System...
[    9.028918] systemd[1]: Mounting Kernel Trace File System...
[    9.032034] systemd[1]: Starting Create List of Static Device Nodes...
[    9.033420] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    9.033474] systemd[1]: Load Kernel Module configfs was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!configfs).
[    9.039176] systemd[1]: Mounting Kernel Configuration File System...
[    9.039253] systemd[1]: Load Kernel Module dm_mod was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!dm_mod).
[    9.039324] systemd[1]: Load Kernel Module drm was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!drm).
[    9.039381] systemd[1]: Load Kernel Module fuse was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!fuse).
[    9.041073] systemd[1]: Mounting FUSE Control File System...
[    9.045340] systemd[1]: Starting Load Kernel Module loop...
[    9.045488] systemd[1]: Clear Stale Hibernate Storage Info was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[    9.048820] systemd[1]: Starting Journal Service...
[    9.056832] systemd[1]: Starting Load Kernel Modules...
[    9.056872] systemd[1]: TPM PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    9.058325] systemd[1]: Starting Remount Root and Kernel File Systems...
[    9.058406] systemd[1]: Early TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    9.061797] systemd[1]: Starting Load udev Rules from Credentials...
[    9.066397] systemd[1]: Starting Coldplug All udev Devices...
[    9.066479] loop: module loaded
[    9.070713] systemd[1]: Mounted Huge Pages File System.
[    9.070917] systemd[1]: Mounted POSIX Message Queue File System.
[    9.071109] systemd[1]: Mounted Kernel Debug File System.
[    9.071280] systemd[1]: Mounted Kernel Trace File System.
[    9.071708] systemd[1]: Finished Create List of Static Device Nodes.
[    9.071915] systemd[1]: Mounted Kernel Configuration File System.
[    9.072039] systemd[1]: Mounted FUSE Control File System.
[    9.072270] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    9.072498] systemd[1]: Finished Load Kernel Module loop.
[    9.072994] systemd[1]: Repartition Root Disk was skipped because no trigger condition checks were met.
[    9.078548] systemd[1]: Starting Create Static Device Nodes in /dev gracefully...
[    9.095917] systemd[1]: Finished Load Kernel Modules.
[    9.139072] systemd[1]: Starting Apply Kernel Variables...
[    9.139308] systemd-journald[371]: Collecting audit messages is disabled.
[    9.139554] systemd[1]: Finished Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling.
[    9.154639] systemd[1]: Finished Load udev Rules from Credentials.
[    9.239598] systemd[1]: Started Journal Service.
[    9.267389] BTRFS info (device dm-1 state M): turning on sync discard
[    9.267397] BTRFS info (device dm-1 state M): enabling auto defrag
[    9.267400] BTRFS info (device dm-1 state M): use lzo compression, level 1
[    9.298531] systemd-journald[371]: Received client request to flush runtime journal.
[    9.298947] Adding 2097148k swap on /swap/swapfile.  Priority:-2 extents:2 across:2228220k SS
[   10.116431] sdhci-pci 0000:00:1e.4: save config 0x00: 0x9d2b8086
[   10.116445] sdhci-pci 0000:00:1e.4: save config 0x04: 0x00100006
[   10.116450] sdhci-pci 0000:00:1e.4: save config 0x08: 0x08050121
[   10.116454] sdhci-pci 0000:00:1e.4: save config 0x0c: 0x00800010
[   10.116458] sdhci-pci 0000:00:1e.4: save config 0x10: 0xceec5004
[   10.116462] sdhci-pci 0000:00:1e.4: save config 0x14: 0x00000000
[   10.116466] sdhci-pci 0000:00:1e.4: save config 0x18: 0x00000000
[   10.116470] sdhci-pci 0000:00:1e.4: save config 0x1c: 0x00000000
[   10.116473] sdhci-pci 0000:00:1e.4: save config 0x20: 0x00000000
[   10.116477] sdhci-pci 0000:00:1e.4: save config 0x24: 0x00000000
[   10.116481] sdhci-pci 0000:00:1e.4: save config 0x28: 0x00000000
[   10.116485] sdhci-pci 0000:00:1e.4: save config 0x2c: 0x9d2b8086
[   10.116489] sdhci-pci 0000:00:1e.4: save config 0x30: 0x00000000
[   10.116493] sdhci-pci 0000:00:1e.4: save config 0x34: 0x00000080
[   10.116497] sdhci-pci 0000:00:1e.4: save config 0x38: 0x00000000
[   10.116501] sdhci-pci 0000:00:1e.4: save config 0x3c: 0x000002ff
[   10.116522] sdhci-pci 0000:00:1e.4: ACPI _REG disconnect evaluation failed (5)
[   10.116607] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D3hot
[   10.154459] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D0
[   10.154469] sdhci-pci 0000:00:1e.4: ACPI _REG connect evaluation failed (5)
[   10.411504] intel_pmc_core INT33A1:00:  initialized
[   10.412748] pci 0000:00:04.0: save config 0x00: 0x19038086
[   10.412755] pci 0000:00:04.0: save config 0x04: 0x00900006
[   10.412759] pci 0000:00:04.0: save config 0x08: 0x11800002
[   10.412763] pci 0000:00:04.0: save config 0x0c: 0x00000000
[   10.412766] pci 0000:00:04.0: save config 0x10: 0xceed8004
[   10.412770] pci 0000:00:04.0: save config 0x14: 0x00000000
[   10.412773] pci 0000:00:04.0: save config 0x18: 0x00000000
[   10.412776] pci 0000:00:04.0: save config 0x1c: 0x00000000
[   10.412779] pci 0000:00:04.0: save config 0x20: 0x00000000
[   10.412782] pci 0000:00:04.0: save config 0x24: 0x00000000
[   10.412786] pci 0000:00:04.0: save config 0x28: 0x00000000
[   10.412789] pci 0000:00:04.0: save config 0x2c: 0x19038086
[   10.412792] pci 0000:00:04.0: save config 0x30: 0x00000000
[   10.412795] pci 0000:00:04.0: save config 0x34: 0x00000090
[   10.412798] pci 0000:00:04.0: save config 0x38: 0x00000000
[   10.412801] pci 0000:00:04.0: save config 0x3c: 0x000001ff
[   10.418204] pci 0000:00:00.0: save config 0x00: 0x590c8086
[   10.418213] pci 0000:00:00.0: save config 0x04: 0x00900006
[   10.418218] pci 0000:00:00.0: save config 0x08: 0x06000002
[   10.418221] pci 0000:00:00.0: save config 0x0c: 0x00000000
[   10.418224] pci 0000:00:00.0: save config 0x10: 0x00000000
[   10.418227] pci 0000:00:00.0: save config 0x14: 0x00000000
[   10.418230] pci 0000:00:00.0: save config 0x18: 0x00000000
[   10.418234] pci 0000:00:00.0: save config 0x1c: 0x00000000
[   10.418237] pci 0000:00:00.0: save config 0x20: 0x00000000
[   10.418240] pci 0000:00:00.0: save config 0x24: 0x00000000
[   10.418244] pci 0000:00:00.0: save config 0x28: 0x00000000
[   10.418246] pci 0000:00:00.0: save config 0x2c: 0x590c8086
[   10.418250] pci 0000:00:00.0: save config 0x30: 0x00000000
[   10.418253] pci 0000:00:00.0: save config 0x34: 0x000000e0
[   10.418256] pci 0000:00:00.0: save config 0x38: 0x00000000
[   10.418259] pci 0000:00:00.0: save config 0x3c: 0x00000000
[   10.419367] pci 0000:00:14.2: save config 0x00: 0x9d318086
[   10.419379] pci 0000:00:14.2: save config 0x04: 0x00100006
[   10.419389] pci 0000:00:14.2: save config 0x08: 0x11800021
[   10.419394] pci 0000:00:14.2: save config 0x0c: 0x00000000
[   10.419398] pci 0000:00:14.2: save config 0x10: 0xceecf004
[   10.419402] pci 0000:00:14.2: save config 0x14: 0x00000000
[   10.419406] pci 0000:00:14.2: save config 0x18: 0x00000000
[   10.419426] pci 0000:00:14.2: save config 0x1c: 0x00000000
[   10.419429] pci 0000:00:14.2: save config 0x20: 0x00000000
[   10.419433] pci 0000:00:14.2: save config 0x24: 0x00000000
[   10.419437] pci 0000:00:14.2: save config 0x28: 0x00000000
[   10.419441] pci 0000:00:14.2: save config 0x2c: 0x9d318086
[   10.419445] pci 0000:00:14.2: save config 0x30: 0x00000000
[   10.419448] pci 0000:00:14.2: save config 0x34: 0x00000050
[   10.419452] pci 0000:00:14.2: save config 0x38: 0x00000000
[   10.419456] pci 0000:00:14.2: save config 0x3c: 0x000003ff
[   10.464104] cros_ec_lpcs GOOG0004:00: Chrome EC device registered
[   10.466843] intel_pch_thermal 0000:00:14.2: vgaarb: pci_notify
[   10.466851] intel_pch_thermal 0000:00:14.2: runtime IRQ mapping not provided by arch
[   10.467145] intel_pch_thermal 0000:00:14.2: vgaarb: pci_notify
[   10.525753] input: Tablet Mode Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:06/PNP0C09:00/GOOG0004:00/GOOG0006:00/input/input4
[   10.529824] intel-lpss 0000:00:15.0: vgaarb: pci_notify
[   10.529834] intel-lpss 0000:00:15.0: runtime IRQ mapping not provided by arch
[   10.530000] intel-lpss 0000:00:15.0: enabling Mem-Wr-Inval
[   10.530236] idma64 idma64.0: Found Intel integrated DMA 64-bit
[   10.541010] pci 0000:00:1f.0: save config 0x00: 0x9d4b8086
[   10.541027] pci 0000:00:1f.0: save config 0x04: 0x00000407
[   10.541037] pci 0000:00:1f.0: save config 0x08: 0x06010021
[   10.541042] pci 0000:00:1f.0: save config 0x0c: 0x00800000
[   10.541046] pci 0000:00:1f.0: save config 0x10: 0x00000000
[   10.541050] pci 0000:00:1f.0: save config 0x14: 0x00000000
[   10.541055] pci 0000:00:1f.0: save config 0x18: 0x00000000
[   10.541059] pci 0000:00:1f.0: save config 0x1c: 0x00000000
[   10.541063] pci 0000:00:1f.0: save config 0x20: 0x00000000
[   10.541068] pci 0000:00:1f.0: save config 0x24: 0x00000000
[   10.541071] pci 0000:00:1f.0: save config 0x28: 0x00000000
[   10.541075] pci 0000:00:1f.0: save config 0x2c: 0x9d4b8086
[   10.541079] pci 0000:00:1f.0: save config 0x30: 0x00000000
[   10.541084] pci 0000:00:1f.0: save config 0x34: 0x00000000
[   10.541088] pci 0000:00:1f.0: save config 0x38: 0x00000000
[   10.541092] pci 0000:00:1f.0: save config 0x3c: 0x00000000
[   10.553169] pci 0000:00:1f.2: save config 0x00: 0x9d218086
[   10.553182] pci 0000:00:1f.2: save config 0x04: 0x00000006
[   10.553187] pci 0000:00:1f.2: save config 0x08: 0x05800021
[   10.553192] pci 0000:00:1f.2: save config 0x0c: 0x00800000
[   10.553196] pci 0000:00:1f.2: save config 0x10: 0xceed4000
[   10.553200] pci 0000:00:1f.2: save config 0x14: 0x00000000
[   10.553204] pci 0000:00:1f.2: save config 0x18: 0x00000000
[   10.553208] pci 0000:00:1f.2: save config 0x1c: 0x00000000
[   10.553212] pci 0000:00:1f.2: save config 0x20: 0x00000000
[   10.553216] pci 0000:00:1f.2: save config 0x24: 0x00000000
[   10.553220] pci 0000:00:1f.2: save config 0x28: 0x00000000
[   10.553223] pci 0000:00:1f.2: save config 0x2c: 0x9d218086
[   10.553227] pci 0000:00:1f.2: save config 0x30: 0x00000000
[   10.553231] pci 0000:00:1f.2: save config 0x34: 0x00000000
[   10.553235] pci 0000:00:1f.2: save config 0x38: 0x00000000
[   10.553238] pci 0000:00:1f.2: save config 0x3c: 0x00000000
[   10.565255] intel-lpss 0000:00:15.0: vgaarb: pci_notify
[   10.565277] intel-lpss 0000:00:15.1: vgaarb: pci_notify
[   10.566168] pci 0000:00:1f.4: save config 0x00: 0x9d238086
[   10.566176] pci 0000:00:1f.4: save config 0x04: 0x02800003
[   10.566182] pci 0000:00:1f.4: save config 0x08: 0x0c050021
[   10.566188] pci 0000:00:1f.4: save config 0x0c: 0x00000000
[   10.566194] pci 0000:00:1f.4: save config 0x10: 0xceec3004
[   10.566200] pci 0000:00:1f.4: save config 0x14: 0x00000000
[   10.566205] pci 0000:00:1f.4: save config 0x18: 0x00000000
[   10.566210] pci 0000:00:1f.4: save config 0x1c: 0x00000000
[   10.566216] pci 0000:00:1f.4: save config 0x20: 0x0000efa1
[   10.566222] pci 0000:00:1f.4: save config 0x24: 0x00000000
[   10.566227] pci 0000:00:1f.4: save config 0x28: 0x00000000
[   10.566232] pci 0000:00:1f.4: save config 0x2c: 0x9d238086
[   10.566237] pci 0000:00:1f.4: save config 0x30: 0x00000000
[   10.566242] pci 0000:00:1f.4: save config 0x34: 0x00000000
[   10.566247] pci 0000:00:1f.4: save config 0x38: 0x00000000
[   10.566253] pci 0000:00:1f.4: save config 0x3c: 0x000001ff
[   10.569310] intel-lpss 0000:00:15.1: runtime IRQ mapping not provided by arch
[   10.572401] intel-lpss 0000:00:15.1: enabling Mem-Wr-Inval
[   10.572583] idma64 idma64.1: Found Intel integrated DMA 64-bit
[   10.598480] cr50_i2c i2c-GOOG0005:00: cr50 TPM 2.0 (i2c 0x50 irq 24 id 0x28)
[   10.614914] input: PC Speaker as /devices/platform/pcspkr/input/input5
[   10.643171] skl_uncore 0000:00:00.0: vgaarb: pci_notify
[   10.643182] skl_uncore 0000:00:00.0: runtime IRQ mapping not provided by arch
[   10.643288] skl_uncore 0000:00:00.0: vgaarb: pci_notify
[   10.716892] input: WCOM50C1:00 2D1F:5143 Touchscreen as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input6
[   10.716988] input: WCOM50C1:00 2D1F:5143 as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input7
[   10.717070] input: WCOM50C1:00 2D1F:5143 Stylus as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input8
[   10.717142] input: WCOM50C1:00 2D1F:5143 as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input9
[   10.717240] input: WCOM50C1:00 2D1F:5143 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input10
[   10.717323] hid-generic 0018:2D1F:5143.0001: input,hidraw0: I2C HID v1.00 Mouse [WCOM50C1:00 2D1F:5143] on i2c-WCOM50C1:00
[   10.740295] i801_smbus 0000:00:1f.4: vgaarb: pci_notify
[   10.740306] i801_smbus 0000:00:1f.4: runtime IRQ mapping not provided by arch
[   10.740574] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[   10.740593] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[   10.759361] spi-nor spi0.0: supply vcc not found, using dummy regulator
[   10.760541] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
[   10.760546] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   10.760548] RAPL PMU: hw unit of domain package 2^-14 Joules
[   10.760549] RAPL PMU: hw unit of domain dram 2^-14 Joules
[   10.760550] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[   10.760551] RAPL PMU: hw unit of domain psys 2^-14 Joules
[   10.766219] Creating 1 MTD partitions on "0000:00:1f.5":
[   10.766226] 0x000000000000-0x000001000000 : "BIOS"
[   10.866817] intel-lpss 0000:00:15.1: vgaarb: pci_notify
[   10.866842] intel-lpss 0000:00:15.2: vgaarb: pci_notify
[   10.866860] intel-lpss 0000:00:15.2: runtime IRQ mapping not provided by arch
[   10.867002] intel-lpss 0000:00:15.2: enabling Mem-Wr-Inval
[   10.867220] idma64 idma64.2: Found Intel integrated DMA 64-bit
[   11.013952] input: ACPI0C50:00 18D1:5028 as /devices/pci0000:00/0000:00:15.2/i2c_designware.2/i2c-9/i2c-ACPI0C50:00/0018:18D1:5028.0002/input/input11
[   11.014950] hid-generic 0018:18D1:5028.0002: input,hidraw1: I2C HID v1.00 Device [ACPI0C50:00 18D1:5028] on i2c-ACPI0C50:00
[   11.146437] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[   11.146455] i801_smbus 0000:00:1f.4: vgaarb: pci_notify
[   11.152472] input: keyd virtual keyboard as /devices/virtual/input/input12
[   11.172720] input: keyd virtual pointer as /devices/virtual/input/input13
[   11.385233] intel_rapl_common: Found RAPL domain package
[   11.385238] intel_rapl_common: Found RAPL domain core
[   11.385241] intel_rapl_common: Found RAPL domain uncore
[   11.385243] intel_rapl_common: Found RAPL domain dram
[   11.385244] intel_rapl_common: Found RAPL domain psys
[   11.443877] iTCO_vendor_support: vendor-support=0
[   11.476827] snd_soc_avs 0000:00:1f.3: vgaarb: pci_notify
[   11.476837] snd_soc_avs 0000:00:1f.3: runtime IRQ mapping not provided by arch
[   11.478463] snd_soc_avs 0000:00:1f.3: bound 0000:00:02.0 (ops intel_audio_component_bind_ops [i915])
[   11.478801] snd_soc_avs 0000:00:1f.3: vgaarb: pci_notify
[   11.593204] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
[   11.593361] iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   11.599031] proc_thermal 0000:00:04.0: vgaarb: pci_notify
[   11.601098] proc_thermal 0000:00:04.0: runtime IRQ mapping not provided by arch
[   11.636934] intel_rapl_common: Found RAPL domain package
[   11.636939] intel_rapl_common: Found RAPL domain dram
[   11.637037] proc_thermal 0000:00:04.0: vgaarb: pci_notify
[   11.754417] cros-ec-dev cros-ec-dev.18.auto: CrOS Touchpad MCU detected
[   11.757436] cros-ec-i2c i2c-GOOG0008:00: Chrome EC device registered
[   11.757633] intel-lpss 0000:00:15.2: vgaarb: pci_notify
[   11.757651] intel-lpss 0000:00:19.0: vgaarb: pci_notify
[   11.757657] intel-lpss 0000:00:19.0: runtime IRQ mapping not provided by arch
[   11.757795] intel-lpss 0000:00:19.0: enabling Mem-Wr-Inval
[   11.761606] intel-lpss 0000:00:19.0: save config 0x00: 0x9d668086
[   11.761619] intel-lpss 0000:00:19.0: save config 0x04: 0x00100006
[   11.761623] intel-lpss 0000:00:19.0: save config 0x08: 0x11800021
[   11.761627] intel-lpss 0000:00:19.0: save config 0x0c: 0x00800010
[   11.761631] intel-lpss 0000:00:19.0: save config 0x10: 0xfe030004
[   11.761636] intel-lpss 0000:00:19.0: save config 0x14: 0x00000000
[   11.761640] intel-lpss 0000:00:19.0: save config 0x18: 0xceeca004
[   11.761644] intel-lpss 0000:00:19.0: save config 0x1c: 0x00000000
[   11.761648] intel-lpss 0000:00:19.0: save config 0x20: 0x00000000
[   11.761652] intel-lpss 0000:00:19.0: save config 0x24: 0x00000000
[   11.761656] intel-lpss 0000:00:19.0: save config 0x28: 0x00000000
[   11.761660] intel-lpss 0000:00:19.0: save config 0x2c: 0x9d668086
[   11.761664] intel-lpss 0000:00:19.0: save config 0x30: 0x00000000
[   11.761668] intel-lpss 0000:00:19.0: save config 0x34: 0x00000080
[   11.761672] intel-lpss 0000:00:19.0: save config 0x38: 0x00000000
[   11.761676] intel-lpss 0000:00:19.0: save config 0x3c: 0x000001ff
[   11.761701] intel-lpss 0000:00:19.0: vgaarb: pci_notify
[   11.761717] intel-lpss 0000:00:19.2: vgaarb: pci_notify
[   11.761724] intel-lpss 0000:00:19.2: runtime IRQ mapping not provided by arch
[   11.761881] intel-lpss 0000:00:19.2: enabling Mem-Wr-Inval
[   11.854535] max98927 i2c-MX98927:00: MAX98927 revisionID: 0x42
[   11.862311] max98927 i2c-MX98927:01: MAX98927 revisionID: 0x42
[   11.868230] rt5663 i2c-10EC5663:00: supply avdd not found, using dummy regulator
[   11.868269] rt5663 i2c-10EC5663:00: supply cpvdd not found, using dummy regulator
[   11.948751] mousedev: PS/2 mouse device common for all mice
[   11.950161] intel_tcc_cooling: Programmable TCC Offset detected
[   11.963513] intel-lpss 0000:00:15.0: save config 0x00: 0x9d608086
[   11.963530] intel-lpss 0000:00:15.0: save config 0x04: 0x00100006
[   11.963534] intel-lpss 0000:00:15.0: save config 0x08: 0x11800021
[   11.963539] intel-lpss 0000:00:15.0: save config 0x0c: 0x00800010
[   11.963543] intel-lpss 0000:00:15.0: save config 0x10: 0xceece004
[   11.963547] intel-lpss 0000:00:15.0: save config 0x14: 0x00000000
[   11.963552] intel-lpss 0000:00:15.0: save config 0x18: 0x00000000
[   11.963556] intel-lpss 0000:00:15.0: save config 0x1c: 0x00000000
[   11.963560] intel-lpss 0000:00:15.0: save config 0x20: 0x00000000
[   11.963564] intel-lpss 0000:00:15.0: save config 0x24: 0x00000000
[   11.963568] intel-lpss 0000:00:15.0: save config 0x28: 0x00000000
[   11.963572] intel-lpss 0000:00:15.0: save config 0x2c: 0x9d608086
[   11.963576] intel-lpss 0000:00:15.0: save config 0x30: 0x00000000
[   11.963580] intel-lpss 0000:00:15.0: save config 0x34: 0x00000080
[   11.963584] intel-lpss 0000:00:15.0: save config 0x38: 0x00000000
[   11.963588] intel-lpss 0000:00:15.0: save config 0x3c: 0x000001ff
[   11.994964] ACPI: battery: new hook: cros-charge-control.6.auto
[   12.008340] cros-usbpd-charger cros-usbpd-charger.7.auto: Could not get charger port count
[   12.096652] snd_hda_codec_intelhdmi hdaudioB0D2: creating for HDMI 0 0
[   12.096658] snd_hda_codec_intelhdmi hdaudioB0D2: skipping capture dai for HDMI 0
[   12.096660] snd_hda_codec_intelhdmi hdaudioB0D2: creating for HDMI 1 1
[   12.096662] snd_hda_codec_intelhdmi hdaudioB0D2: skipping capture dai for HDMI 1
[   12.096663] snd_hda_codec_intelhdmi hdaudioB0D2: creating for HDMI 2 2
[   12.096665] snd_hda_codec_intelhdmi hdaudioB0D2: skipping capture dai for HDMI 2
[   12.099096] avs_hdaudio avs_hdaudio.17.auto: ASoC: Parent card not yet available, widget card binding deferred
[   12.099204] avs_hdaudio avs_hdaudio.17.auto: avs_card_late_probe: mapping HDMI converter 1 to PCM 0 (000000007b6ace21)
[   12.099210] avs_hdaudio avs_hdaudio.17.auto: avs_card_late_probe: mapping HDMI converter 2 to PCM 0 (00000000dcc5055d)
[   12.099214] avs_hdaudio avs_hdaudio.17.auto: avs_card_late_probe: mapping HDMI converter 3 to PCM 0 (00000000de02d26f)
[   12.102695] avs_hdaudio avs_hdaudio.17.auto: control 3:0:0:ELD:0 is already present
[   12.102702] snd_hda_codec_intelhdmi hdaudioB0D2: unable to create controls -16
[   12.102706] avs_hdaudio avs_hdaudio.17.auto: ASoC error (-16): at snd_soc_card_late_probe() on AVS HDMI
[   12.102977] avs_hdaudio avs_hdaudio.17.auto: probe with driver avs_hdaudio failed with error -16
[   12.103243] avs_max98927 avs_max98927.14.auto: ASoC: Parent card not yet available, widget card binding deferred
[   12.190014] gpio gpiochip2: Detected name collision for GPIO name 'EC:I2C1_SCL'
[   12.190022] gpio gpiochip2: Detected name collision for GPIO name 'EC:I2C1_SDA'
[   12.190028] gpio gpiochip2: Detected name collision for GPIO name 'EC:ENTERING_RW'
[   12.190031] gpio gpiochip2: Detected name collision for GPIO name 'EC:WP_L'
[   12.300614] cros-ec-activity cros-ec-activity.29.auto: Unknown activity: 2
[   12.345458] sdhci-pci 0000:00:1e.4: save config 0x00: 0x9d2b8086
[   12.345476] sdhci-pci 0000:00:1e.4: save config 0x04: 0x00100006
[   12.345486] sdhci-pci 0000:00:1e.4: save config 0x08: 0x08050121
[   12.345491] sdhci-pci 0000:00:1e.4: save config 0x0c: 0x00800010
[   12.345496] sdhci-pci 0000:00:1e.4: save config 0x10: 0xceec5004
[   12.345500] sdhci-pci 0000:00:1e.4: save config 0x14: 0x00000000
[   12.345505] sdhci-pci 0000:00:1e.4: save config 0x18: 0x00000000
[   12.345509] sdhci-pci 0000:00:1e.4: save config 0x1c: 0x00000000
[   12.345514] sdhci-pci 0000:00:1e.4: save config 0x20: 0x00000000
[   12.345518] sdhci-pci 0000:00:1e.4: save config 0x24: 0x00000000
[   12.345522] sdhci-pci 0000:00:1e.4: save config 0x28: 0x00000000
[   12.345526] sdhci-pci 0000:00:1e.4: save config 0x2c: 0x9d2b8086
[   12.345530] sdhci-pci 0000:00:1e.4: save config 0x30: 0x00000000
[   12.345535] sdhci-pci 0000:00:1e.4: save config 0x34: 0x00000080
[   12.345539] sdhci-pci 0000:00:1e.4: save config 0x38: 0x00000000
[   12.345544] sdhci-pci 0000:00:1e.4: save config 0x3c: 0x000002ff
[   12.345574] sdhci-pci 0000:00:1e.4: ACPI _REG disconnect evaluation failed (5)
[   12.345669] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D3hot
[   12.349845] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D0
[   12.349855] sdhci-pci 0000:00:1e.4: ACPI _REG connect evaluation failed (5)
[   12.396449] i801_smbus 0000:00:1f.4: save config 0x00: 0x9d238086
[   12.396467] i801_smbus 0000:00:1f.4: save config 0x04: 0x02800003
[   12.396478] i801_smbus 0000:00:1f.4: save config 0x08: 0x0c050021
[   12.396484] i801_smbus 0000:00:1f.4: save config 0x0c: 0x00000000
[   12.396489] i801_smbus 0000:00:1f.4: save config 0x10: 0xceec3004
[   12.396495] i801_smbus 0000:00:1f.4: save config 0x14: 0x00000000
[   12.396500] i801_smbus 0000:00:1f.4: save config 0x18: 0x00000000
[   12.396506] i801_smbus 0000:00:1f.4: save config 0x1c: 0x00000000
[   12.396511] i801_smbus 0000:00:1f.4: save config 0x20: 0x0000efa1
[   12.396516] i801_smbus 0000:00:1f.4: save config 0x24: 0x00000000
[   12.396522] i801_smbus 0000:00:1f.4: save config 0x28: 0x00000000
[   12.396527] i801_smbus 0000:00:1f.4: save config 0x2c: 0x9d238086
[   12.396532] i801_smbus 0000:00:1f.4: save config 0x30: 0x00000000
[   12.396537] i801_smbus 0000:00:1f.4: save config 0x34: 0x00000000
[   12.396542] i801_smbus 0000:00:1f.4: save config 0x38: 0x00000000
[   12.396548] i801_smbus 0000:00:1f.4: save config 0x3c: 0x000001ff
[   12.445457] sdhci-pci 0000:00:1e.4: save config 0x00: 0x9d2b8086
[   12.445470] sdhci-pci 0000:00:1e.4: save config 0x04: 0x00100006
[   12.445474] sdhci-pci 0000:00:1e.4: save config 0x08: 0x08050121
[   12.445478] sdhci-pci 0000:00:1e.4: save config 0x0c: 0x00800010
[   12.445481] sdhci-pci 0000:00:1e.4: save config 0x10: 0xceec5004
[   12.445484] sdhci-pci 0000:00:1e.4: save config 0x14: 0x00000000
[   12.445488] sdhci-pci 0000:00:1e.4: save config 0x18: 0x00000000
[   12.445491] sdhci-pci 0000:00:1e.4: save config 0x1c: 0x00000000
[   12.445494] sdhci-pci 0000:00:1e.4: save config 0x20: 0x00000000
[   12.445497] sdhci-pci 0000:00:1e.4: save config 0x24: 0x00000000
[   12.445500] sdhci-pci 0000:00:1e.4: save config 0x28: 0x00000000
[   12.445503] sdhci-pci 0000:00:1e.4: save config 0x2c: 0x9d2b8086
[   12.445506] sdhci-pci 0000:00:1e.4: save config 0x30: 0x00000000
[   12.445509] sdhci-pci 0000:00:1e.4: save config 0x34: 0x00000080
[   12.445513] sdhci-pci 0000:00:1e.4: save config 0x38: 0x00000000
[   12.445516] sdhci-pci 0000:00:1e.4: save config 0x3c: 0x000002ff
[   12.445538] sdhci-pci 0000:00:1e.4: ACPI _REG disconnect evaluation failed (5)
[   12.445607] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D3hot
[   12.458060] Bluetooth: Core ver 2.22
[   12.458101] NET: Registered PF_BLUETOOTH protocol family
[   12.458103] Bluetooth: HCI device and connection manager initialized
[   12.458110] Bluetooth: HCI socket layer initialized
[   12.458114] Bluetooth: L2CAP socket layer initialized
[   12.458122] Bluetooth: SCO socket layer initialized
[   12.460979] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D0
[   12.460989] sdhci-pci 0000:00:1e.4: ACPI _REG connect evaluation failed (5)
[   12.521435] usbcore: registered new interface driver btusb
[   12.532468] Bluetooth: hci0: Legacy ROM 2.x revision 5.0 build 25 week 20 2015
[   12.541602] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
[   12.563857] mc: Linux media interface: v0.10
[   12.616707] videodev: Linux video capture interface: v2.00
[   12.639610] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   12.639616] Bluetooth: BNEP filters: protocol multicast
[   12.639622] Bluetooth: BNEP socket layer initialized
[   12.672470] uvcvideo 1-2:1.0: Found UVC 1.00 device WebCamera (0bda:564b)
[   12.676483] usbcore: registered new interface driver uvcvideo
[   12.722469] usbcore: registered new interface driver cdc_ether
[   12.785441] sdhci-pci 0000:00:1e.4: save config 0x00: 0x9d2b8086
[   12.785457] sdhci-pci 0000:00:1e.4: save config 0x04: 0x00100006
[   12.785462] sdhci-pci 0000:00:1e.4: save config 0x08: 0x08050121
[   12.785466] sdhci-pci 0000:00:1e.4: save config 0x0c: 0x00800010
[   12.785470] sdhci-pci 0000:00:1e.4: save config 0x10: 0xceec5004
[   12.785474] sdhci-pci 0000:00:1e.4: save config 0x14: 0x00000000
[   12.785478] sdhci-pci 0000:00:1e.4: save config 0x18: 0x00000000
[   12.785482] sdhci-pci 0000:00:1e.4: save config 0x1c: 0x00000000
[   12.785486] sdhci-pci 0000:00:1e.4: save config 0x20: 0x00000000
[   12.785490] sdhci-pci 0000:00:1e.4: save config 0x24: 0x00000000
[   12.785493] sdhci-pci 0000:00:1e.4: save config 0x28: 0x00000000
[   12.785497] sdhci-pci 0000:00:1e.4: save config 0x2c: 0x9d2b8086
[   12.785501] sdhci-pci 0000:00:1e.4: save config 0x30: 0x00000000
[   12.785505] sdhci-pci 0000:00:1e.4: save config 0x34: 0x00000080
[   12.785509] sdhci-pci 0000:00:1e.4: save config 0x38: 0x00000000
[   12.785512] sdhci-pci 0000:00:1e.4: save config 0x3c: 0x000002ff
[   12.785538] sdhci-pci 0000:00:1e.4: ACPI _REG disconnect evaluation failed (5)
[   12.785623] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D3hot
[   12.867658] Bluetooth: hci0: Intel BT fw patch 0x43 completed & activated
[   12.923891] Bluetooth: MGMT ver 1.23
[   12.930168] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D0
[   12.930180] sdhci-pci 0000:00:1e.4: ACPI _REG connect evaluation failed (5)
[   12.935015] cdc_ncm 2-2.4:2.0: MAC-Address: __CENSORED__
[   12.935023] cdc_ncm 2-2.4:2.0: setting rx_max = 16384
[   12.943037] NET: Registered PF_ALG protocol family
[   12.947996] cdc_ncm 2-2.4:2.0: setting tx_max = 16384
[   12.958391] cdc_ncm 2-2.4:2.0 eth0: register 'cdc_ncm' at usb-0000:00:14.0-2.4, CDC NCM (NO ZLP), __CENSORED__
[   12.971306] usbcore: registered new interface driver cdc_ncm
[   12.984850] usbcore: registered new interface driver cdc_wdm
[   12.999716] usbcore: registered new interface driver cdc_mbim
[   13.011793] cdc_ncm 2-2.4:2.0 enp0s20f0u2u4c2: renamed from eth0
[   13.171949] sdhci-pci 0000:00:1e.4: save config 0x00: 0x9d2b8086
[   13.171967] sdhci-pci 0000:00:1e.4: save config 0x04: 0x00100006
[   13.171978] sdhci-pci 0000:00:1e.4: save config 0x08: 0x08050121
[   13.171988] sdhci-pci 0000:00:1e.4: save config 0x0c: 0x00800010
[   13.171993] sdhci-pci 0000:00:1e.4: save config 0x10: 0xceec5004
[   13.171998] sdhci-pci 0000:00:1e.4: save config 0x14: 0x00000000
[   13.172003] sdhci-pci 0000:00:1e.4: save config 0x18: 0x00000000
[   13.172007] sdhci-pci 0000:00:1e.4: save config 0x1c: 0x00000000
[   13.172012] sdhci-pci 0000:00:1e.4: save config 0x20: 0x00000000
[   13.172016] sdhci-pci 0000:00:1e.4: save config 0x24: 0x00000000
[   13.172021] sdhci-pci 0000:00:1e.4: save config 0x28: 0x00000000
[   13.172025] sdhci-pci 0000:00:1e.4: save config 0x2c: 0x9d2b8086
[   13.172030] sdhci-pci 0000:00:1e.4: save config 0x30: 0x00000000
[   13.172034] sdhci-pci 0000:00:1e.4: save config 0x34: 0x00000080
[   13.172039] sdhci-pci 0000:00:1e.4: save config 0x38: 0x00000000
[   13.172043] sdhci-pci 0000:00:1e.4: save config 0x3c: 0x000002ff
[   13.172072] sdhci-pci 0000:00:1e.4: ACPI _REG disconnect evaluation failed (5)
[   13.172168] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D3hot
[   13.184271] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D0
[   13.184282] sdhci-pci 0000:00:1e.4: ACPI _REG connect evaluation failed (5)
[   13.187563] avs_rt5663 avs_rt5663.16.auto: ASoC: Parent card not yet available, widget card binding deferred
[   13.188664] rt5663 i2c-10EC5663:00: sysclk < 384 x fs, disable i2s asrc
[   13.188958] input: AVS I2S ALC5663 Headset Jack as /devices/platform/avs_rt5663.16.auto/sound/card2/input16
[   13.198745] avs_rt5514 avs_rt5514.15.auto: ASoC: Parent card not yet available, widget card binding deferred
[   13.202102] intel-lpss 0000:00:19.2: vgaarb: pci_notify
[   13.202152] intel-lpss 0000:00:1e.0: vgaarb: pci_notify
[   13.202167] intel-lpss 0000:00:1e.0: runtime IRQ mapping not provided by arch
[   13.204285] intel-lpss 0000:00:1e.0: enabling Mem-Wr-Inval
[   13.206491] idma64 idma64.5: Found Intel integrated DMA 64-bit
[   13.206794] intel-lpss 0000:00:1e.0: save config 0x00: 0x9d278086
[   13.206814] intel-lpss 0000:00:1e.0: save config 0x04: 0x00100006
[   13.206828] intel-lpss 0000:00:1e.0: save config 0x08: 0x11800021
[   13.206841] intel-lpss 0000:00:1e.0: save config 0x0c: 0x00800010
[   13.206856] intel-lpss 0000:00:1e.0: save config 0x10: 0xceec8004
[   13.206870] intel-lpss 0000:00:1e.0: save config 0x14: 0x00000000
[   13.206883] intel-lpss 0000:00:1e.0: save config 0x18: 0xceec7004
[   13.206897] intel-lpss 0000:00:1e.0: save config 0x1c: 0x00000000
[   13.206910] intel-lpss 0000:00:1e.0: save config 0x20: 0x00000000
[   13.206924] intel-lpss 0000:00:1e.0: save config 0x24: 0x00000000
[   13.206937] intel-lpss 0000:00:1e.0: save config 0x28: 0x00000000
[   13.206951] intel-lpss 0000:00:1e.0: save config 0x2c: 0x9d278086
[   13.206963] intel-lpss 0000:00:1e.0: save config 0x30: 0x00000000
[   13.206976] intel-lpss 0000:00:1e.0: save config 0x34: 0x00000080
[   13.206989] intel-lpss 0000:00:1e.0: save config 0x38: 0x00000000
[   13.207003] intel-lpss 0000:00:1e.0: save config 0x3c: 0x000001ff
[   13.207039] intel-lpss 0000:00:1e.0: vgaarb: pci_notify
[   13.207076] intel-lpss 0000:00:1e.2: vgaarb: pci_notify
[   13.207089] intel-lpss 0000:00:1e.2: runtime IRQ mapping not provided by arch
[   13.207434] intel-lpss 0000:00:1e.2: enabling Mem-Wr-Inval
[   13.207971] idma64 idma64.6: Found Intel integrated DMA 64-bit
[   13.210693] intel-lpss 0000:00:1e.2: save config 0x00: 0x9d298086
[   13.210713] intel-lpss 0000:00:1e.2: save config 0x04: 0x00100006
[   13.210728] intel-lpss 0000:00:1e.2: save config 0x08: 0x11800021
[   13.210741] intel-lpss 0000:00:1e.2: save config 0x0c: 0x00800010
[   13.210754] intel-lpss 0000:00:1e.2: save config 0x10: 0xceec6004
[   13.210767] intel-lpss 0000:00:1e.2: save config 0x14: 0x00000000
[   13.210781] intel-lpss 0000:00:1e.2: save config 0x18: 0x00000000
[   13.210794] intel-lpss 0000:00:1e.2: save config 0x1c: 0x00000000
[   13.210808] intel-lpss 0000:00:1e.2: save config 0x20: 0x00000000
[   13.210821] intel-lpss 0000:00:1e.2: save config 0x24: 0x00000000
[   13.210834] intel-lpss 0000:00:1e.2: save config 0x28: 0x00000000
[   13.210847] intel-lpss 0000:00:1e.2: save config 0x2c: 0x9d298086
[   13.210861] intel-lpss 0000:00:1e.2: save config 0x30: 0x00000000
[   13.210874] intel-lpss 0000:00:1e.2: save config 0x34: 0x00000080
[   13.210888] intel-lpss 0000:00:1e.2: save config 0x38: 0x00000000
[   13.210902] intel-lpss 0000:00:1e.2: save config 0x3c: 0x000003ff
[   13.210968] intel-lpss 0000:00:1e.2: vgaarb: pci_notify
[   13.250443] sdhci-pci 0000:00:1e.4: save config 0x00: 0x9d2b8086
[   13.250459] sdhci-pci 0000:00:1e.4: save config 0x04: 0x00100006
[   13.250467] sdhci-pci 0000:00:1e.4: save config 0x08: 0x08050121
[   13.250475] sdhci-pci 0000:00:1e.4: save config 0x0c: 0x00800010
[   13.250483] sdhci-pci 0000:00:1e.4: save config 0x10: 0xceec5004
[   13.250492] sdhci-pci 0000:00:1e.4: save config 0x14: 0x00000000
[   13.250500] sdhci-pci 0000:00:1e.4: save config 0x18: 0x00000000
[   13.250508] sdhci-pci 0000:00:1e.4: save config 0x1c: 0x00000000
[   13.250517] sdhci-pci 0000:00:1e.4: save config 0x20: 0x00000000
[   13.250525] sdhci-pci 0000:00:1e.4: save config 0x24: 0x00000000
[   13.250536] sdhci-pci 0000:00:1e.4: save config 0x28: 0x00000000
[   13.250544] sdhci-pci 0000:00:1e.4: save config 0x2c: 0x9d2b8086
[   13.250553] sdhci-pci 0000:00:1e.4: save config 0x30: 0x00000000
[   13.250561] sdhci-pci 0000:00:1e.4: save config 0x34: 0x00000080
[   13.250572] sdhci-pci 0000:00:1e.4: save config 0x38: 0x00000000
[   13.250581] sdhci-pci 0000:00:1e.4: save config 0x3c: 0x000002ff
[   13.250642] sdhci-pci 0000:00:1e.4: ACPI _REG disconnect evaluation failed (5)
[   13.250774] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D3hot
[   13.253671] iio iio:device2: Unknown activity: 2
[   13.253684] iio iio:device2: Unknown activity: 2
[   13.253691] iio iio:device2: Unknown activity: 2
[   13.253696] iio iio:device2: Unknown activity: 2
[   13.256785] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D0
[   13.256801] sdhci-pci 0000:00:1e.4: ACPI _REG connect evaluation failed (5)
[   13.319289] dw-apb-uart.3: ttyS4 at MMIO 0xfe030000 (irq = 32, base_baud = 115200) is a 16550A
[   13.326619] dw-apb-uart.5: ttyS5 at MMIO 0xceec8000 (irq = 20, base_baud = 7500000) is a 16550A
[   13.369277] input: WCOM50C1:00 2D1F:5143 as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input17
[   13.369903] input: WCOM50C1:00 2D1F:5143 UNKNOWN as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input18
[   13.370069] input: WCOM50C1:00 2D1F:5143 Stylus as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input19
[   13.370205] input: WCOM50C1:00 2D1F:5143 UNKNOWN as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input20
[   13.370356] input: WCOM50C1:00 2D1F:5143 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input21
[   13.370773] hid-multitouch 0018:2D1F:5143.0001: input,hidraw0: I2C HID v1.00 Mouse [WCOM50C1:00 2D1F:5143] on i2c-WCOM50C1:00
[   13.384216] input: ACPI0C50:00 18D1:5028 as /devices/pci0000:00/0000:00:15.2/i2c_designware.2/i2c-9/i2c-ACPI0C50:00/0018:18D1:5028.0002/input/input22
[   13.384500] hid-multitouch 0018:18D1:5028.0002: input,hidraw1: I2C HID v1.00 Device [ACPI0C50:00 18D1:5028] on i2c-ACPI0C50:00
[   15.642866] xhci_hcd 0000:00:14.0: save config 0x00: 0x9d2f8086
[   15.642891] xhci_hcd 0000:00:14.0: save config 0x04: 0x02900402
[   15.642904] xhci_hcd 0000:00:14.0: save config 0x08: 0x0c033021
[   15.642916] xhci_hcd 0000:00:14.0: save config 0x0c: 0x00800000
[   15.642928] xhci_hcd 0000:00:14.0: save config 0x10: 0xceef0004
[   15.642940] xhci_hcd 0000:00:14.0: save config 0x14: 0x00000000
[   15.642952] xhci_hcd 0000:00:14.0: save config 0x18: 0x00000000
[   15.642964] xhci_hcd 0000:00:14.0: save config 0x1c: 0x00000000
[   15.642975] xhci_hcd 0000:00:14.0: save config 0x20: 0x00000000
[   15.642987] xhci_hcd 0000:00:14.0: save config 0x24: 0x00000000
[   15.642998] xhci_hcd 0000:00:14.0: save config 0x28: 0x00000000
[   15.643010] xhci_hcd 0000:00:14.0: save config 0x2c: 0x00000000
[   15.643021] xhci_hcd 0000:00:14.0: save config 0x30: 0x00000000
[   15.643032] xhci_hcd 0000:00:14.0: save config 0x34: 0x00000070
[   15.643044] xhci_hcd 0000:00:14.0: save config 0x38: 0x00000000
[   15.643056] xhci_hcd 0000:00:14.0: save config 0x3c: 0x000001ff
[   15.643117] xhci_hcd 0000:00:14.0: PME# enabled
[   15.665254] xhci_hcd 0000:00:14.0: power state changed by ACPI to D3hot
[   18.312836] xhci_hcd 0000:00:14.0: power state changed by ACPI to D0
[   18.312853] xhci_hcd 0000:00:14.0: ACPI _REG connect evaluation failed (5)
[   18.313144] xhci_hcd 0000:00:14.0: PME# disabled
[   18.313161] xhci_hcd 0000:00:14.0: enabling bus mastering
[   19.128207] apple 0005:05AC:0256.0003: unknown main item tag 0x0
[   19.128569] input: Apple Wireless Keyboard as /devices/virtual/misc/uhid/0005:05AC:0256.0003/input/input23
[   19.154585] apple 0005:05AC:0256.0003: input,hidraw2: BLUETOOTH HID v0.50 Keyboard [Apple Wireless Keyboard] on __CENSORED__
[   23.953125] input: MX Anywhere 3 Mouse as /devices/virtual/misc/uhid/0005:046D:B025.0004/input/input24
[   23.953534] hid-generic 0005:046D:B025.0004: input,hidraw3: BLUETOOTH HID v0.15 Mouse [MX Anywhere 3] on __CENSORED__
[   24.075559] input: Logitech MX Anywhere 3 as /devices/virtual/misc/uhid/0005:046D:B025.0004/input/input26
[   24.075720] logitech-hidpp-device 0005:046D:B025.0004: input,hidraw3: BLUETOOTH HID v0.15 Mouse [Logitech MX Anywhere 3] on __CENSORED__
[   24.097519] logitech-hidpp-device 0005:046D:B025.0004: HID++ 4.5 device connected.
[   27.022360] Bluetooth: RFCOMM TTY layer initialized
[   27.022375] Bluetooth: RFCOMM socket layer initialized
[   27.022383] Bluetooth: RFCOMM ver 1.11
[   99.375182] PM: suspend entry (deep)
[   99.608488] Filesystems sync: 0.233 seconds
[   99.617759] Freezing user space processes
[   99.619266] Freezing user space processes completed (elapsed 0.001 seconds)
[   99.619277] OOM killer disabled.
[   99.619281] Freezing remaining freezable tasks
[   99.620529] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   99.620556] printk: Suspending console(s) (use no_console_suspend to debug)
[   99.634030] i915 0000:00:02.0: save config 0x00: 0x591e8086
[   99.634044] i915 0000:00:02.0: save config 0x04: 0x00100407
[   99.634051] i915 0000:00:02.0: save config 0x08: 0x03000002
[   99.634059] i915 0000:00:02.0: save config 0x0c: 0x00000010
[   99.634066] i915 0000:00:02.0: save config 0x10: 0xcf000004
[   99.634073] i915 0000:00:02.0: save config 0x14: 0x00000000
[   99.634080] i915 0000:00:02.0: save config 0x18: 0xd000000c
[   99.634087] i915 0000:00:02.0: save config 0x1c: 0x00000000
[   99.634094] i915 0000:00:02.0: save config 0x20: 0x0000ffc1
[   99.634101] i915 0000:00:02.0: save config 0x24: 0x00000000
[   99.634107] i915 0000:00:02.0: save config 0x28: 0x00000000
[   99.634112] i915 0000:00:02.0: save config 0x2c: 0x22128086
[   99.634117] i915 0000:00:02.0: save config 0x30: 0x00000000
[   99.634123] i915 0000:00:02.0: save config 0x34: 0x00000040
[   99.634131] i915 0000:00:02.0: save config 0x38: 0x00000000
[   99.634141] i915 0000:00:02.0: save config 0x3c: 0x000001ff
[  100.392838] pci 0000:00:1f.2: save config 0x00: 0x9d218086
[  100.392839] intel_pch_thermal 0000:00:14.2: save config 0x00: 0x9d318086
[  100.392839] proc_thermal 0000:00:04.0: save config 0x00: 0x19038086
[  100.392865] pci 0000:00:1f.2: save config 0x04: 0x00000006
[  100.392866] proc_thermal 0000:00:04.0: save config 0x04: 0x00900006
[  100.392868] intel_pch_thermal 0000:00:14.2: save config 0x04: 0x00100006
[  100.392873] skl_uncore 0000:00:00.0: save config 0x00: 0x590c8086
[  100.392880] pci 0000:00:1f.2: save config 0x08: 0x05800021
[  100.392881] proc_thermal 0000:00:04.0: save config 0x08: 0x11800002
[  100.392883] intel_pch_thermal 0000:00:14.2: save config 0x08: 0x11800021
[  100.392884] skl_uncore 0000:00:00.0: save config 0x04: 0x00900006
[  100.392894] pci 0000:00:1f.2: save config 0x0c: 0x00800000
[  100.392895] proc_thermal 0000:00:04.0: save config 0x0c: 0x00000000
[  100.392897] intel_pch_thermal 0000:00:14.2: save config 0x0c: 0x00000000
[  100.392898] skl_uncore 0000:00:00.0: save config 0x08: 0x06000002
[  100.392907] pci 0000:00:1f.2: save config 0x10: 0xceed4000
[  100.392909] proc_thermal 0000:00:04.0: save config 0x10: 0xceed8004
[  100.392910] intel_pch_thermal 0000:00:14.2: save config 0x10: 0xceecf004
[  100.392911] skl_uncore 0000:00:00.0: save config 0x0c: 0x00000000
[  100.392921] pci 0000:00:1f.2: save config 0x14: 0x00000000
[  100.392922] proc_thermal 0000:00:04.0: save config 0x14: 0x00000000
[  100.392924] intel_pch_thermal 0000:00:14.2: save config 0x14: 0x00000000
[  100.392925] skl_uncore 0000:00:00.0: save config 0x10: 0x00000000
[  100.392935] pci 0000:00:1f.2: save config 0x18: 0x00000000
[  100.392936] proc_thermal 0000:00:04.0: save config 0x18: 0x00000000
[  100.392937] intel_pch_thermal 0000:00:14.2: save config 0x18: 0x00000000
[  100.392939] skl_uncore 0000:00:00.0: save config 0x14: 0x00000000
[  100.392942] pci 0000:00:1f.2: save config 0x1c: 0x00000000
[  100.392944] proc_thermal 0000:00:04.0: save config 0x1c: 0x00000000
[  100.392945] intel_pch_thermal 0000:00:14.2: save config 0x1c: 0x00000000
[  100.392947] skl_uncore 0000:00:00.0: save config 0x18: 0x00000000
[  100.392950] pci 0000:00:1f.2: save config 0x20: 0x00000000
[  100.392952] proc_thermal 0000:00:04.0: save config 0x20: 0x00000000
[  100.392953] intel_pch_thermal 0000:00:14.2: save config 0x20: 0x00000000
[  100.392954] skl_uncore 0000:00:00.0: save config 0x1c: 0x00000000
[  100.392958] pci 0000:00:1f.2: save config 0x24: 0x00000000
[  100.392959] proc_thermal 0000:00:04.0: save config 0x24: 0x00000000
[  100.392961] intel_pch_thermal 0000:00:14.2: save config 0x24: 0x00000000
[  100.392962] skl_uncore 0000:00:00.0: save config 0x20: 0x00000000
[  100.392971] pci 0000:00:1f.2: save config 0x28: 0x00000000
[  100.392973] proc_thermal 0000:00:04.0: save config 0x28: 0x00000000
[  100.392974] intel_pch_thermal 0000:00:14.2: save config 0x28: 0x00000000
[  100.392976] skl_uncore 0000:00:00.0: save config 0x24: 0x00000000
[  100.392979] pci 0000:00:1f.2: save config 0x2c: 0x9d218086
[  100.392980] proc_thermal 0000:00:04.0: save config 0x2c: 0x19038086
[  100.392982] intel_pch_thermal 0000:00:14.2: save config 0x2c: 0x9d318086
[  100.392983] skl_uncore 0000:00:00.0: save config 0x28: 0x00000000
[  100.392993] pci 0000:00:1f.2: save config 0x30: 0x00000000
[  100.392994] proc_thermal 0000:00:04.0: save config 0x30: 0x00000000
[  100.392995] intel_pch_thermal 0000:00:14.2: save config 0x30: 0x00000000
[  100.392997] skl_uncore 0000:00:00.0: save config 0x2c: 0x590c8086
[  100.393000] pci 0000:00:1f.2: save config 0x34: 0x00000000
[  100.393002] proc_thermal 0000:00:04.0: save config 0x34: 0x00000090
[  100.393003] intel_pch_thermal 0000:00:14.2: save config 0x34: 0x00000050
[  100.393004] skl_uncore 0000:00:00.0: save config 0x30: 0x00000000
[  100.393008] pci 0000:00:1f.2: save config 0x38: 0x00000000
[  100.393009] proc_thermal 0000:00:04.0: save config 0x38: 0x00000000
[  100.393011] intel_pch_thermal 0000:00:14.2: save config 0x38: 0x00000000
[  100.393012] skl_uncore 0000:00:00.0: save config 0x34: 0x000000e0
[  100.393016] pci 0000:00:1f.2: save config 0x3c: 0x00000000
[  100.393017] proc_thermal 0000:00:04.0: save config 0x3c: 0x000001ff
[  100.393019] intel_pch_thermal 0000:00:14.2: save config 0x3c: 0x000003ff
[  100.393020] skl_uncore 0000:00:00.0: save config 0x38: 0x00000000
[  100.393029] skl_uncore 0000:00:00.0: save config 0x3c: 0x00000000
[  100.393186] intel-lpss 0000:00:1e.2: save config 0x00: 0x9d298086
[  100.393188] intel-lpss 0000:00:1e.0: save config 0x00: 0x9d278086
[  100.393189] snd_soc_avs 0000:00:1f.3: save config 0x00: 0x9d718086
[  100.393203] intel-lpss 0000:00:1e.2: save config 0x04: 0x00100006
[  100.393205] snd_soc_avs 0000:00:1f.3: save config 0x04: 0x00100406
[  100.393207] intel-lpss 0000:00:1e.0: save config 0x04: 0x00100006
[  100.393212] intel-lpss 0000:00:1e.2: save config 0x08: 0x11800021
[  100.393214] snd_soc_avs 0000:00:1f.3: save config 0x08: 0x04010021
[  100.393216] intel-lpss 0000:00:1e.0: save config 0x08: 0x11800021
[  100.393220] intel-lpss 0000:00:19.0: save config 0x00: 0x9d668086
[  100.393221] intel-lpss 0000:00:1e.2: save config 0x0c: 0x00800010
[  100.393223] snd_soc_avs 0000:00:1f.3: save config 0x0c: 0x00004010
[  100.393225] intel-lpss 0000:00:1e.0: save config 0x0c: 0x00800010
[  100.393228] intel-lpss 0000:00:19.0: save config 0x04: 0x00100006
[  100.393231] intel-lpss 0000:00:1e.2: save config 0x10: 0xceec6004
[  100.393233] snd_soc_avs 0000:00:1f.3: save config 0x10: 0xceed0004
[  100.393235] intel-lpss 0000:00:1e.0: save config 0x10: 0xceec8004
[  100.393237] intel-lpss 0000:00:19.0: save config 0x08: 0x11800021
[  100.393239] intel-lpss 0000:00:1e.2: save config 0x14: 0x00000000
[  100.393241] snd_soc_avs 0000:00:1f.3: save config 0x14: 0x00000000
[  100.393243] intel-lpss 0000:00:1e.0: save config 0x14: 0x00000000
[  100.393245] intel-lpss 0000:00:19.0: save config 0x0c: 0x00800010
[  100.393247] intel-lpss 0000:00:1e.2: save config 0x18: 0x00000000
[  100.393249] snd_soc_avs 0000:00:1f.3: save config 0x18: 0x00000000
[  100.393252] intel-lpss 0000:00:1e.0: save config 0x18: 0xceec7004
[  100.393254] intel-lpss 0000:00:19.0: save config 0x10: 0xfe030004
[  100.393256] intel-lpss 0000:00:1e.2: save config 0x1c: 0x00000000
[  100.393258] snd_soc_avs 0000:00:1f.3: save config 0x1c: 0x00000000
[  100.393260] intel-lpss 0000:00:1e.0: save config 0x1c: 0x00000000
[  100.393262] intel-lpss 0000:00:19.0: save config 0x14: 0x00000000
[  100.393264] intel-lpss 0000:00:1e.2: save config 0x20: 0x00000000
[  100.393266] snd_soc_avs 0000:00:1f.3: save config 0x20: 0xceee0004
[  100.393268] intel-lpss 0000:00:1e.0: save config 0x20: 0x00000000
[  100.393270] intel-lpss 0000:00:19.0: save config 0x18: 0xceeca004
[  100.393273] intel-lpss 0000:00:1e.2: save config 0x24: 0x00000000
[  100.393274] snd_soc_avs 0000:00:1f.3: save config 0x24: 0x00000000
[  100.393277] intel-lpss 0000:00:1e.0: save config 0x24: 0x00000000
[  100.393279] intel-lpss 0000:00:19.0: save config 0x1c: 0x00000000
[  100.393281] intel-lpss 0000:00:1e.2: save config 0x28: 0x00000000
[  100.393283] snd_soc_avs 0000:00:1f.3: save config 0x28: 0x00000000
[  100.393285] intel-lpss 0000:00:1e.0: save config 0x28: 0x00000000
[  100.393287] intel-lpss 0000:00:19.0: save config 0x20: 0x00000000
[  100.393290] intel-lpss 0000:00:1e.2: save config 0x2c: 0x9d298086
[  100.393292] snd_soc_avs 0000:00:1f.3: save config 0x2c: 0x00000000
[  100.393294] intel-lpss 0000:00:1e.0: save config 0x2c: 0x9d278086
[  100.393296] intel-lpss 0000:00:19.0: save config 0x24: 0x00000000
[  100.393298] intel-lpss 0000:00:1e.2: save config 0x30: 0x00000000
[  100.393300] snd_soc_avs 0000:00:1f.3: save config 0x30: 0x00000000
[  100.393302] intel-lpss 0000:00:1e.0: save config 0x30: 0x00000000
[  100.393304] intel-lpss 0000:00:19.0: save config 0x28: 0x00000000
[  100.393306] intel-lpss 0000:00:1e.2: save config 0x34: 0x00000080
[  100.393308] snd_soc_avs 0000:00:1f.3: save config 0x34: 0x00000050
[  100.393311] intel-lpss 0000:00:1e.0: save config 0x34: 0x00000080
[  100.393313] intel-lpss 0000:00:19.0: save config 0x2c: 0x9d668086
[  100.393315] intel-lpss 0000:00:1e.2: save config 0x38: 0x00000000
[  100.393317] snd_soc_avs 0000:00:1f.3: save config 0x38: 0x00000000
[  100.393319] intel-lpss 0000:00:1e.0: save config 0x38: 0x00000000
[  100.393321] intel-lpss 0000:00:19.0: save config 0x30: 0x00000000
[  100.393323] intel-lpss 0000:00:1e.2: save config 0x3c: 0x000003ff
[  100.393325] snd_soc_avs 0000:00:1f.3: save config 0x3c: 0x000001ff
[  100.393327] intel-lpss 0000:00:1e.0: save config 0x3c: 0x000001ff
[  100.393329] intel-lpss 0000:00:19.0: save config 0x34: 0x00000080
[  100.393342] intel-lpss 0000:00:19.0: save config 0x38: 0x00000000
[  100.393352] intel-lpss 0000:00:19.0: save config 0x3c: 0x000001ff
[  100.393425] intel-lpss 0000:00:19.2: save config 0x00: 0x9d648086
[  100.393445] intel-lpss 0000:00:19.2: save config 0x04: 0x00100006
[  100.393459] intel-lpss 0000:00:19.2: save config 0x08: 0x11800021
[  100.393471] intel-lpss 0000:00:19.2: save config 0x0c: 0x00800010
[  100.393482] intel-lpss 0000:00:19.2: save config 0x10: 0xceec9004
[  100.393493] intel-lpss 0000:00:19.2: save config 0x14: 0x00000000
[  100.393504] intel-lpss 0000:00:19.2: save config 0x18: 0x00000000
[  100.393515] intel-lpss 0000:00:19.2: save config 0x1c: 0x00000000
[  100.393526] intel-lpss 0000:00:19.2: save config 0x20: 0x00000000
[  100.393537] intel-lpss 0000:00:19.2: save config 0x24: 0x00000000
[  100.393548] intel-lpss 0000:00:19.2: save config 0x28: 0x00000000
[  100.393559] intel-lpss 0000:00:19.2: save config 0x2c: 0x9d648086
[  100.393570] intel-lpss 0000:00:19.2: save config 0x30: 0x00000000
[  100.393582] intel-lpss 0000:00:19.2: save config 0x34: 0x00000080
[  100.393592] intel-lpss 0000:00:19.2: save config 0x38: 0x00000000
[  100.393604] intel-lpss 0000:00:19.2: save config 0x3c: 0x000003ff
[  100.405159] proc_thermal 0000:00:04.0: PCI PM: Suspend power state: D3hot
[  100.405160] intel-lpss 0000:00:19.2: PCI PM: Suspend power state: D3hot
[  100.405163] intel_pch_thermal 0000:00:14.2: PCI PM: Suspend power state: D3hot
[  100.405164] intel-lpss 0000:00:1e.2: PCI PM: Suspend power state: D3hot
[  100.405205] snd_soc_avs 0000:00:1f.3: PCI PM: Suspend power state: D3hot
[  100.405269] intel-lpss 0000:00:15.2: save config 0x00: 0x9d628086
[  100.405285] i801_smbus 0000:00:1f.4: save config 0x00: 0x9d238086
[  100.405287] intel-lpss 0000:00:15.2: save config 0x04: 0x00100006
[  100.405301] i801_smbus 0000:00:1f.4: save config 0x04: 0x02800003
[  100.405305] intel-lpss 0000:00:15.2: save config 0x08: 0x11800021
[  100.405304] intel-lpss 0000:00:15.1: save config 0x00: 0x9d618086
[  100.405309] i801_smbus 0000:00:1f.4: save config 0x08: 0x0c050021
[  100.405313] intel-lpss 0000:00:15.2: save config 0x0c: 0x00800010
[  100.405317] i801_smbus 0000:00:1f.4: save config 0x0c: 0x00000000
[  100.405319] intel-lpss 0000:00:15.1: save config 0x04: 0x00100006
[  100.405321] intel-lpss 0000:00:15.2: save config 0x10: 0xceecc004
[  100.405324] i801_smbus 0000:00:1f.4: save config 0x10: 0xceec3004
[  100.405328] intel-lpss 0000:00:15.1: save config 0x08: 0x11800021
[  100.405330] intel-lpss 0000:00:15.2: save config 0x14: 0x00000000
[  100.405333] i801_smbus 0000:00:1f.4: save config 0x14: 0x00000000
[  100.405336] intel-lpss 0000:00:15.1: save config 0x0c: 0x00800010
[  100.405338] intel-lpss 0000:00:15.2: save config 0x18: 0x00000000
[  100.405341] i801_smbus 0000:00:1f.4: save config 0x18: 0x00000000
[  100.405344] intel-lpss 0000:00:15.1: save config 0x10: 0xceecd004
[  100.405346] intel-lpss 0000:00:15.2: save config 0x1c: 0x00000000
[  100.405349] i801_smbus 0000:00:1f.4: save config 0x1c: 0x00000000
[  100.405353] intel-lpss 0000:00:15.1: save config 0x14: 0x00000000
[  100.405354] intel-lpss 0000:00:15.2: save config 0x20: 0x00000000
[  100.405358] i801_smbus 0000:00:1f.4: save config 0x20: 0x0000efa1
[  100.405361] intel-lpss 0000:00:15.1: save config 0x18: 0x00000000
[  100.405363] intel-lpss 0000:00:15.2: save config 0x24: 0x00000000
[  100.405366] i801_smbus 0000:00:1f.4: save config 0x24: 0x00000000
[  100.405369] intel-lpss 0000:00:15.1: save config 0x1c: 0x00000000
[  100.405371] intel-lpss 0000:00:15.2: save config 0x28: 0x00000000
[  100.405373] intel-lpss 0000:00:15.0: save config 0x00: 0x9d608086
[  100.405376] i801_smbus 0000:00:1f.4: save config 0x28: 0x00000000
[  100.405380] intel-lpss 0000:00:15.2: save config 0x2c: 0x9d628086
[  100.405383] intel-lpss 0000:00:15.0: save config 0x04: 0x00100006
[  100.405387] intel-lpss 0000:00:15.1: save config 0x20: 0x00000000
[  100.405387] intel-lpss 0000:00:15.2: save config 0x30: 0x00000000
[  100.405390] intel-lpss 0000:00:15.0: save config 0x08: 0x11800021
[  100.405394] intel-lpss 0000:00:15.1: save config 0x24: 0x00000000
[  100.405394] i801_smbus 0000:00:1f.4: save config 0x2c: 0x9d238086
[  100.405396] intel-lpss 0000:00:15.2: save config 0x34: 0x00000080
[  100.405398] intel-lpss 0000:00:15.0: save config 0x0c: 0x00800010
[  100.405401] intel-lpss 0000:00:15.1: save config 0x28: 0x00000000
[  100.405403] i801_smbus 0000:00:1f.4: save config 0x30: 0x00000000
[  100.405405] intel-lpss 0000:00:15.2: save config 0x38: 0x00000000
[  100.405407] intel-lpss 0000:00:15.0: save config 0x10: 0xceece004
[  100.405423] intel-lpss 0000:00:15.1: save config 0x2c: 0x9d618086
[  100.405424] i801_smbus 0000:00:1f.4: save config 0x34: 0x00000000
[  100.405436] intel-lpss 0000:00:15.0: save config 0x14: 0x00000000
[  100.405438] intel-lpss 0000:00:15.2: save config 0x3c: 0x000003ff
[  100.405440] intel-lpss 0000:00:15.1: save config 0x30: 0x00000000
[  100.405444] i801_smbus 0000:00:1f.4: save config 0x38: 0x00000000
[  100.405446] intel-lpss 0000:00:15.0: save config 0x18: 0x00000000
[  100.405450] intel-lpss 0000:00:15.1: save config 0x34: 0x00000080
[  100.405453] i801_smbus 0000:00:1f.4: save config 0x3c: 0x000001ff
[  100.405457] intel-lpss 0000:00:15.0: save config 0x1c: 0x00000000
[  100.405460] intel-lpss 0000:00:15.1: save config 0x38: 0x00000000
[  100.405466] i801_smbus 0000:00:1f.4: PCI PM: Suspend power state: D0
[  100.405469] intel-lpss 0000:00:15.0: save config 0x20: 0x00000000
[  100.405471] intel-lpss 0000:00:15.1: save config 0x3c: 0x000002ff
[  100.405477] intel-lpss 0000:00:15.0: save config 0x24: 0x00000000
[  100.405486] intel-lpss 0000:00:15.0: save config 0x28: 0x00000000
[  100.405486] intel-lpss 0000:00:19.0: PCI PM: Suspend power state: D3hot
[  100.405492] intel-lpss 0000:00:15.0: save config 0x2c: 0x9d608086
[  100.405496] i915 0000:00:02.0: PCI PM: Suspend power state: D3hot
[  100.405498] intel-lpss 0000:00:15.0: save config 0x30: 0x00000000
[  100.405512] intel-lpss 0000:00:15.0: save config 0x34: 0x00000080
[  100.405514] intel-lpss 0000:00:1e.0: PCI PM: Suspend power state: D3hot
[  100.405525] intel-lpss 0000:00:15.0: save config 0x38: 0x00000000
[  100.405538] intel-lpss 0000:00:15.0: save config 0x3c: 0x000001ff
[  100.405610] xhci_hcd 0000:00:14.0: save config 0x00: 0x9d2f8086
[  100.405624] xhci_hcd 0000:00:14.0: save config 0x04: 0x02900402
[  100.405628] intel-spi 0000:00:1f.5: save config 0x00: 0x9d248086
[  100.405629] sdhci-pci 0000:00:1e.4: save config 0x00: 0x9d2b8086
[  100.405633] xhci_hcd 0000:00:14.0: save config 0x08: 0x0c033021
[  100.405646] xhci_hcd 0000:00:14.0: save config 0x0c: 0x00800000
[  100.405648] sdhci-pci 0000:00:1e.4: save config 0x04: 0x00100006
[  100.405650] intel-spi 0000:00:1f.5: save config 0x04: 0x00000402
[  100.405654] xhci_hcd 0000:00:14.0: save config 0x10: 0xceef0004
[  100.405657] sdhci-pci 0000:00:1e.4: save config 0x08: 0x08050121
[  100.405659] intel-spi 0000:00:1f.5: save config 0x08: 0x00000021
[  100.405662] xhci_hcd 0000:00:14.0: save config 0x14: 0x00000000
[  100.405665] sdhci-pci 0000:00:1e.4: save config 0x0c: 0x00800010
[  100.405667] intel-spi 0000:00:1f.5: save config 0x0c: 0x00000000
[  100.405670] xhci_hcd 0000:00:14.0: save config 0x18: 0x00000000
[  100.405672] sdhci-pci 0000:00:1e.4: save config 0x10: 0xceec5004
[  100.405674] intel-spi 0000:00:1f.5: save config 0x10: 0xfe010000
[  100.405678] xhci_hcd 0000:00:14.0: save config 0x1c: 0x00000000
[  100.405679] sdhci-pci 0000:00:1e.4: save config 0x14: 0x00000000
[  100.405681] intel-spi 0000:00:1f.5: save config 0x14: 0x00000000
[  100.405686] xhci_hcd 0000:00:14.0: save config 0x20: 0x00000000
[  100.405687] sdhci-pci 0000:00:1e.4: save config 0x18: 0x00000000
[  100.405689] intel-spi 0000:00:1f.5: save config 0x18: 0x00000000
[  100.405694] xhci_hcd 0000:00:14.0: save config 0x24: 0x00000000
[  100.405695] sdhci-pci 0000:00:1e.4: save config 0x1c: 0x00000000
[  100.405697] intel-spi 0000:00:1f.5: save config 0x1c: 0x00000000
[  100.405702] xhci_hcd 0000:00:14.0: save config 0x28: 0x00000000
[  100.405703] sdhci-pci 0000:00:1e.4: save config 0x20: 0x00000000
[  100.405705] intel-spi 0000:00:1f.5: save config 0x20: 0x00000000
[  100.405710] xhci_hcd 0000:00:14.0: save config 0x2c: 0x00000000
[  100.405712] sdhci-pci 0000:00:1e.4: save config 0x24: 0x00000000
[  100.405713] intel-spi 0000:00:1f.5: save config 0x24: 0x00000000
[  100.405718] xhci_hcd 0000:00:14.0: save config 0x30: 0x00000000
[  100.405719] sdhci-pci 0000:00:1e.4: save config 0x28: 0x00000000
[  100.405721] intel-spi 0000:00:1f.5: save config 0x28: 0x00000000
[  100.405726] xhci_hcd 0000:00:14.0: save config 0x34: 0x00000070
[  100.405728] sdhci-pci 0000:00:1e.4: save config 0x2c: 0x9d2b8086
[  100.405729] intel-spi 0000:00:1f.5: save config 0x2c: 0x00000000
[  100.405734] xhci_hcd 0000:00:14.0: save config 0x38: 0x00000000
[  100.405736] sdhci-pci 0000:00:1e.4: save config 0x30: 0x00000000
[  100.405738] intel-spi 0000:00:1f.5: save config 0x30: 0x00000000
[  100.405744] xhci_hcd 0000:00:14.0: save config 0x3c: 0x000001ff
[  100.405749] sdhci-pci 0000:00:1e.4: save config 0x34: 0x00000080
[  100.405754] intel-spi 0000:00:1f.5: save config 0x34: 0x00000000
[  100.405764] sdhci-pci 0000:00:1e.4: save config 0x38: 0x00000000
[  100.405769] intel-spi 0000:00:1f.5: save config 0x38: 0x00000000
[  100.405780] sdhci-pci 0000:00:1e.4: save config 0x3c: 0x000002ff
[  100.405784] intel-spi 0000:00:1f.5: save config 0x3c: 0x00000000
[  100.405815] pci 0000:00:1f.0: save config 0x00: 0x9d4b8086
[  100.405825] pci 0000:00:1f.0: save config 0x04: 0x00000407
[  100.405836] pci 0000:00:1f.0: save config 0x08: 0x06010021
[  100.405845] pci 0000:00:1f.0: save config 0x0c: 0x00800000
[  100.405855] pci 0000:00:1f.0: save config 0x10: 0x00000000
[  100.405871] pci 0000:00:1f.0: save config 0x14: 0x00000000
[  100.405882] xhci_hcd 0000:00:14.0: PME# enabled
[  100.405884] sdhci-pci 0000:00:1e.4: ACPI _REG disconnect evaluation failed (5)
[  100.405886] pci 0000:00:1f.0: save config 0x18: 0x00000000
[  100.405896] pci 0000:00:1f.0: save config 0x1c: 0x00000000
[  100.405906] pci 0000:00:1f.0: save config 0x20: 0x00000000
[  100.405916] pci 0000:00:1f.0: save config 0x24: 0x00000000
[  100.405927] pci 0000:00:1f.0: save config 0x28: 0x00000000
[  100.405936] pci 0000:00:1f.0: save config 0x2c: 0x9d4b8086
[  100.405941] pci 0000:00:1f.0: save config 0x30: 0x00000000
[  100.405946] pci 0000:00:1f.0: save config 0x34: 0x00000000
[  100.405956] pci 0000:00:1f.0: save config 0x38: 0x00000000
[  100.405967] pci 0000:00:1f.0: save config 0x3c: 0x00000000
[  100.406433] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D3hot
[  100.406447] sdhci-pci 0000:00:1e.4: PCI PM: Suspend power state: D3hot
[  100.409229] ACPI: EC: interrupt blocked
[  100.409247] pcieport 0000:00:1c.0: save config 0x00: 0x9d108086
[  100.409271] pcieport 0000:00:1c.0: save config 0x04: 0x00100507
[  100.409285] pcieport 0000:00:1c.0: save config 0x08: 0x060400f1
[  100.409298] pcieport 0000:00:1c.0: save config 0x0c: 0x00810010
[  100.409312] pcieport 0000:00:1c.0: save config 0x10: 0x00000000
[  100.409326] pcieport 0000:00:1c.0: save config 0x14: 0x00000000
[  100.409340] pcieport 0000:00:1c.0: save config 0x18: 0x00010100
[  100.409353] pcieport 0000:00:1c.0: save config 0x1c: 0x20002020
[  100.409367] pcieport 0000:00:1c.0: save config 0x20: 0xcef0cef0
[  100.409372] pcieport 0000:00:1c.0: save config 0x24: 0x7f117f01
[  100.409376] pcieport 0000:00:1c.0: save config 0x28: 0x00000002
[  100.409381] pcieport 0000:00:1c.0: save config 0x2c: 0x00000002
[  100.409385] pcieport 0000:00:1c.0: save config 0x30: 0x00000000
[  100.409390] pcieport 0000:00:1c.0: save config 0x34: 0x00000040
[  100.409404] pcieport 0000:00:1c.0: save config 0x38: 0x00000000
[  100.409419] pcieport 0000:00:1c.0: save config 0x3c: 0x001201ff
[  100.409471] pcieport 0000:00:1c.0: PCI PM: Suspend power state: D0
[  100.417527] intel-lpss 0000:00:15.2: PCI PM: Suspend power state: D3hot
[  100.417550] intel-lpss 0000:00:15.0: PCI PM: Suspend power state: D3hot
[  100.417551] intel-lpss 0000:00:15.1: PCI PM: Suspend power state: D3hot
[  100.429134] xhci_hcd 0000:00:14.0: power state changed by ACPI to D3hot
[  100.429157] xhci_hcd 0000:00:14.0: PCI PM: Suspend power state: D3hot
[  100.429262] ACPI: PM: Preparing to enter system sleep state S3
[  100.429441] ACPI: EC: event blocked
[  100.429443] ACPI: EC: EC stopped
[  100.429445] ACPI: PM: Saving platform NVS memory
[  100.429493] Disabling non-boot CPUs ...
[  100.431258] smpboot: CPU 3 is now offline
[  100.434809] smpboot: CPU 2 is now offline
[  100.437398] smpboot: CPU 1 is now offline
[  100.439678] ACPI: PM: Low-level resume complete
[  100.439733] ACPI: EC: EC started
[  100.439733] ACPI: PM: Restoring platform NVS memory
[  100.440448] Enabling non-boot CPUs ...
[  100.440600] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  100.441486] CPU1 is up
[  100.441515] smpboot: Booting Node 0 Processor 2 APIC 0x1
[  100.442556] CPU2 is up
[  100.442584] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  100.443448] CPU3 is up
[  100.445185] ACPI: PM: Waking up from system sleep state S3
[  100.445421] i915 0000:00:02.0: restore config 0x3c: 0x0000010b -> 0x000001ff
[  100.445422] skl_uncore 0000:00:00.0: restore config 0x04: 0x20900006 -> 0x00900006
[  100.445437] i915 0000:00:02.0: restore config 0x04: 0x00100007 -> 0x00100407
[  100.445449] ACPI: EC: interrupt unblocked
[  100.445450] proc_thermal 0000:00:04.0: restore config 0x3c: 0x0000010b -> 0x000001ff
[  100.445460] proc_thermal 0000:00:04.0: restore config 0x04: 0x00900002 -> 0x00900006
[  100.445490] intel_pch_thermal 0000:00:14.2: restore config 0x3c: 0x0000030b -> 0x000003ff
[  100.445602] intel_pch_thermal 0000:00:14.2: restore config 0x04: 0x00100002 -> 0x00100006
[  100.445850] intel-lpss 0000:00:15.1: restore config 0x3c: 0x0000020a -> 0x000002ff
[  100.445865] intel-lpss 0000:00:15.2: restore config 0x3c: 0x0000030b -> 0x000003ff
[  100.445980] intel-spi 0000:00:1f.5: restore config 0x04: 0x00000406 -> 0x00000402
[  100.446150] intel-lpss 0000:00:15.0: restore config 0x3c: 0x0000010b -> 0x000001ff
[  100.446165] intel-lpss 0000:00:19.0: restore config 0x3c: 0x0000010b -> 0x000001ff
[  100.446380] intel-lpss 0000:00:19.2: restore config 0x3c: 0x0000030b -> 0x000003ff
[  100.446422] intel-lpss 0000:00:1e.2: restore config 0x3c: 0x0000030b -> 0x000003ff
[  100.446481] pcieport 0000:00:1c.0: restore config 0x3c: 0x0012010b -> 0x001201ff
[  100.446510] pcieport 0000:00:1c.0: restore config 0x2c: 0xffffffff -> 0x00000002
[  100.446514] intel-lpss 0000:00:1e.0: restore config 0x3c: 0x0000010b -> 0x000001ff
[  100.446519] pcieport 0000:00:1c.0: restore config 0x28: 0xffffffff -> 0x00000002
[  100.446530] pcieport 0000:00:1c.0: restore config 0x24: 0xffe1fff1 -> 0x7f117f01
[  100.446572] pcieport 0000:00:1c.0: restore config 0x1c: 0x0000e0f0 -> 0x20002020
[  100.446674] pcieport 0000:00:1c.0: restore config 0x04: 0x00100106 -> 0x00100507
[  100.446691] intel-lpss 0000:00:1e.0: restore config 0x04: 0x00100002 -> 0x00100006
[  100.446830] i801_smbus 0000:00:1f.4: restore config 0x3c: 0x0000010b -> 0x000001ff
[  100.446951] pci 0000:00:1f.2: restore config 0x04: 0x00000002 -> 0x00000006
[  100.449500] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D0
[  100.449505] sdhci-pci 0000:00:1e.4: ACPI _REG connect evaluation failed (5)
[  100.449518] sdhci-pci 0000:00:1e.4: restore config 0x3c: 0x0000020a -> 0x000002ff
[  100.455904] xhci_hcd 0000:00:14.0: power state changed by ACPI to D0
[  100.455909] xhci_hcd 0000:00:14.0: ACPI _REG connect evaluation failed (5)
[  100.455923] xhci_hcd 0000:00:14.0: restore config 0x3c: 0x0000010b -> 0x000001ff
[  100.455941] xhci_hcd 0000:00:14.0: restore config 0x04: 0x02900002 -> 0x02900402
[  100.456122] snd_soc_avs 0000:00:1f.3: restore config 0x3c: 0x0000010b -> 0x000001ff
[  100.456150] snd_soc_avs 0000:00:1f.3: restore config 0x04: 0x00100006 -> 0x00100406
[  100.457027] i915 0000:00:02.0: vgaarb: __vga_tryget: 1
[  100.457030] i915 0000:00:02.0: vgaarb: __vga_tryget: owns: 3
[  100.457035] i915 0000:00:02.0: vgaarb: __vga_put
[  100.457315] ACPI: EC: event unblocked
[  100.457398] pcieport 0000:00:1c.0: pciehp: pending interrupts 0x0008 from Slot Status
[  100.457424] pcieport 0000:00:1c.0: pciehp: pciehp_check_link_active: lnk_status = 3011
[  100.457427] pcieport 0000:00:1c.0: pciehp: Slot(0): Card present
[  100.457430] pcieport 0000:00:1c.0: pciehp: Slot(0): Link Up
[  100.458574] xhci_hcd 0000:00:14.0: PME# disabled
[  100.458588] xhci_hcd 0000:00:14.0: enabling bus mastering
[  100.579904] pcieport 0000:00:1c.0: pciehp: pciehp_check_link_status: lnk_status = 3011
[  100.579981] pci 0000:01:00.0: [8086:095a] type 00 class 0x028000 PCIe Endpoint
[  100.580088] pci 0000:01:00.0: BAR 0 [mem 0xcef00000-0xcef01fff 64bit]
[  100.580281] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[  100.580291] pci 0000:01:00.0: PME# disabled
[  100.580590] pci 0000:01:00.0: EDR: Notify handler installed
[  100.580939] pci 0000:01:00.0: vgaarb: pci_notify
[  100.581164] pcieport 0000:00:1c.0: distributing available resources
[  100.581175] pci 0000:01:00.0: BAR 0 [mem 0xcef00000-0xcef01fff 64bit]: assigned
[  100.581215] pcieport 0000:00:1c.0: PCI bridge to [bus 01]
[  100.581220] pcieport 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[  100.581228] pcieport 0000:00:1c.0:   bridge window [mem 0xcef00000-0xceffffff]
[  100.581235] pcieport 0000:00:1c.0:   bridge window [mem 0x27f000000-0x27f1fffff 64bit pref]
[  100.711535] OOM killer enabled.
[  100.711539] Restarting tasks: Starting
[  100.715445] Restarting tasks: Done
[  100.715489] random: crng reseeded on system resumption
[  100.733730] PM: suspend exit
[  100.766692] pci 0000:01:00.0: save config 0x00: 0x095a8086
[  100.766702] pci 0000:01:00.0: save config 0x04: 0x00100002
[  100.766708] pci 0000:01:00.0: save config 0x08: 0x028000b9
[  100.766713] pci 0000:01:00.0: save config 0x0c: 0x00000010
[  100.766719] pci 0000:01:00.0: save config 0x10: 0xcef00004
[  100.766725] pci 0000:01:00.0: save config 0x14: 0x00000000
[  100.766730] pci 0000:01:00.0: save config 0x18: 0x00000000
[  100.766735] pci 0000:01:00.0: save config 0x1c: 0x00000000
[  100.766740] pci 0000:01:00.0: save config 0x20: 0x00000000
[  100.766746] pci 0000:01:00.0: save config 0x24: 0x00000000
[  100.766751] pci 0000:01:00.0: save config 0x28: 0x00000000
[  100.766756] pci 0000:01:00.0: save config 0x2c: 0x9e108086
[  100.766761] pci 0000:01:00.0: save config 0x30: 0x00000000
[  100.766766] pci 0000:01:00.0: save config 0x34: 0x000000c8
[  100.766772] pci 0000:01:00.0: save config 0x38: 0x00000000
[  100.766776] pci 0000:01:00.0: save config 0x3c: 0x0000010b
[  100.957223] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[  100.957514] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[  100.958069] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[  100.959158] faux_driver regulatory: Direct firmware load for regulatory.db failed with error -2
[  100.959165] cfg80211: failed to load regulatory.db
[  100.998369] iwlwifi 0000:01:00.0: vgaarb: pci_notify
[  100.998377] iwlwifi 0000:01:00.0: runtime IRQ mapping not provided by arch
[  100.998415] pcieport 0000:00:1c.0: re-enabling LTR
[  100.998936] iwlwifi 0000:01:00.0: enabling bus mastering
[  100.999387] iwlwifi 0000:01:00.0: Detected crf-id 0x0, cnv-id 0x0 wfpm id 0x0
[  100.999398] iwlwifi 0000:01:00.0: PCI dev 095a/9e10, rev=0x210, rfid=0xd55555d5
[  100.999404] iwlwifi 0000:01:00.0: Detected Intel(R) Dual Band Wireless-AC 7265
[  100.999578] iwlwifi 0000:01:00.0: vgaarb: pci_notify
[  101.010678] iwlwifi 0000:01:00.0: Found debug destination: EXTERNAL_DRAM
[  101.010775] iwlwifi 0000:01:00.0: Found debug configuration: 0
[  101.011025] iwlwifi 0000:01:00.0: loaded firmware version 29.9ef079ed.0 7265D-29.ucode op_mode iwlmvm
[  101.179692] pps_core: LinuxPPS API ver. 1 registered
[  101.179698] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[  101.202608] PTP clock support registered
[  101.257815] iwlwifi 0000:01:00.0: Applying debug destination EXTERNAL_DRAM
[  101.258394] iwlwifi 0000:01:00.0: Allocated 0x00400000 bytes for firmware monitor.
[  101.263002] iwlwifi 0000:01:00.0: base HW address: __CENSORED__, OTP minor version: 0x0
[  101.325802] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[  101.335695] iwlwifi 0000:01:00.0 wlp1s0: renamed from wlan0
[  101.355893] iwlwifi 0000:01:00.0: Applying debug destination EXTERNAL_DRAM
[  101.434649] iwlwifi 0000:01:00.0: Applying debug destination EXTERNAL_DRAM
[  101.436703] iwlwifi 0000:01:00.0: FW already configured (0) - re-configuring
[  101.476433] iwlwifi 0000:01:00.0: Applying debug destination EXTERNAL_DRAM
[  101.555460] iwlwifi 0000:01:00.0: Applying debug destination EXTERNAL_DRAM
[  101.557399] iwlwifi 0000:01:00.0: FW already configured (0) - re-configuring
[  104.622300] wlp1s0: authenticate with __CENSORED__ (local address=__CENSORED__)
[  104.623393] wlp1s0: send auth to __CENSORED__ (try 1/3)
[  104.709810] wlp1s0: authenticate with __CENSORED__ (local address=__CENSORED__)
[  104.709828] wlp1s0: send auth to __CENSORED__ (try 1/3)
[  104.785931] wlp1s0: authenticated
[  104.787763] wlp1s0: associate with __CENSORED__ (try 1/3)
[  104.863856] wlp1s0: RX AssocResp from __CENSORED__ (capab=0x1931 status=0 aid=10)
[  104.866423] wlp1s0: associated
[  104.954538] wlp1s0: Limiting TX power to 30 (30 - 0) dBm as advertised by __CENSORED__
[  105.303117] apple 0005:05AC:0256.0005: unknown main item tag 0x0
[  105.305281] input: Apple Wireless Keyboard as /devices/virtual/misc/uhid/0005:05AC:0256.0005/input/input27
[  105.332161] apple 0005:05AC:0256.0005: input,hidraw2: BLUETOOTH HID v0.50 Keyboard [Apple Wireless Keyboard] on __CENSORED__
[  108.307435] input: Logitech MX Anywhere 3 as /devices/virtual/misc/uhid/0005:046D:B025.0006/input/input28
[  108.308324] logitech-hidpp-device 0005:046D:B025.0006: input,hidraw3: BLUETOOTH HID v0.15 Mouse [Logitech MX Anywhere 3] on __CENSORED__
[  108.385985] logitech-hidpp-device 0005:046D:B025.0006: HID++ 4.5 device connected.

--xpdscytg3qlwzotp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="02_dmesg_without_4d4c10f763d7.log"

[    0.000000] Linux version 6.18.0-rc1-local-reverted-pci-issues-00351-gbbaff7ff47dd (avm99963@pixelbook) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU Binutils) 2.45.0) #21 SMP PREEMPT_DYNAMIC Sun Oct 19 13:26:59 CEST 2025
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-linux-local root=/dev/mapper/VolGroup00-root rw loglevel=3 quiet cryptdevice=UUID=70c55651-98b6-4a3d-9c6a-9f9e70c23225:cryptroot root=/dev/VolGroup00/root pciehp.pciehp_debug=1 "dyndbg=file drivers/pci/* +p"
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000001000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000779c6fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000779c7000-0x0000000077adafff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000077adb000-0x000000007a259fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a25a000-0x000000007a25cfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007a25d000-0x000000007a7b2fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a7b3000-0x000000007a9b2fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007a9b3000-0x000000007a9c2fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a9c3000-0x000000007a9d7fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007a9d8000-0x000000007a9d8fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a9d9000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000027effffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] efi: EFI v2.7 by EDK II
[    0.000000] efi: SMBIOS=0x7a99a000 SMBIOS 3.0=0x7a998000 ACPI=0x7a9d7000 ACPI 2.0=0x7a9d7014 MEMATTR=0x777ad018 INITRD=0x777aee18 
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: Google Eve/Eve, BIOS MrChromebox-2509.1 10/13/2025
[    0.000000] DMI: Memory slots populated: 2/2
[    0.000000] tsc: Detected 1600.000 MHz processor
[    0.000000] tsc: Detected 1599.960 MHz TSC
[    0.000011] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000014] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000020] last_pfn = 0x27f000 max_arch_pfn = 0x400000000
[    0.000027] MTRR map: 7 entries (3 fixed + 4 variable; max 23), built from 10 variable MTRRs
[    0.000029] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000377] last_pfn = 0x7a9d9 max_arch_pfn = 0x400000000
[    0.008211] Using GB pages for direct mapping
[    0.008518] Secure boot disabled
[    0.008519] RAMDISK: [mem 0x71632000-0x735c3fff]
[    0.008565] ACPI: Early table checksum verification disabled
[    0.008568] ACPI: RSDP 0x000000007A9D7014 000024 (v02 COREv4)
[    0.008573] ACPI: XSDT 0x000000007A9D60E8 00007C (v01 COREv4 COREBOOT 00000000      01000013)
[    0.008578] ACPI: FACP 0x000000007A9D5000 000114 (v06 COREv4 COREBOOT 00000000 CORE 20250404)
[    0.008585] ACPI: DSDT 0x000000007A9D0000 00474F (v02 COREv4 COREBOOT 20110725 INTL 20250404)
[    0.008588] ACPI: FACS 0x000000007A9F1240 000040
[    0.008591] ACPI: SSDT 0x000000007A9CE000 001921 (v02 COREv4 COREBOOT 00000000 CORE 20250404)
[    0.008594] ACPI: MCFG 0x000000007A9CD000 00003C (v01 COREv4 COREBOOT 00000000 CORE 20250404)
[    0.008597] ACPI: TPM2 0x000000007A9CC000 00004C (v04 COREv4 COREBOOT 00000000 CORE 20250404)
[    0.008600] ACPI: LPIT 0x000000007A9CB000 000094 (v00 COREv4 COREBOOT 00000000 CORE 20250404)
[    0.008603] ACPI: APIC 0x000000007A9CA000 000072 (v03 COREv4 COREBOOT 00000000 CORE 20250404)
[    0.008606] ACPI: NHLT 0x000000007A9C9000 000388 (v05 GOOGLE EVEMAX   00000000 CORE 00000000)
[    0.008609] ACPI: DMAR 0x000000007A9C8000 000088 (v01 COREv4 COREBOOT 00000000 CORE 20250404)
[    0.008612] ACPI: DBG2 0x000000007A9C7000 000061 (v00 COREv4 COREBOOT 00000000 CORE 20250404)
[    0.008615] ACPI: HPET 0x000000007A9C6000 000038 (v01 COREv4 COREBOOT 00000000 CORE 20250404)
[    0.008618] ACPI: BGRT 0x000000007A9C5000 000038 (v01 COREv4 EDK2     00000002      01000013)
[    0.008621] ACPI: Reserving FACP table memory at [mem 0x7a9d5000-0x7a9d5113]
[    0.008622] ACPI: Reserving DSDT table memory at [mem 0x7a9d0000-0x7a9d474e]
[    0.008623] ACPI: Reserving FACS table memory at [mem 0x7a9f1240-0x7a9f127f]
[    0.008624] ACPI: Reserving SSDT table memory at [mem 0x7a9ce000-0x7a9cf920]
[    0.008625] ACPI: Reserving MCFG table memory at [mem 0x7a9cd000-0x7a9cd03b]
[    0.008625] ACPI: Reserving TPM2 table memory at [mem 0x7a9cc000-0x7a9cc04b]
[    0.008626] ACPI: Reserving LPIT table memory at [mem 0x7a9cb000-0x7a9cb093]
[    0.008627] ACPI: Reserving APIC table memory at [mem 0x7a9ca000-0x7a9ca071]
[    0.008628] ACPI: Reserving NHLT table memory at [mem 0x7a9c9000-0x7a9c9387]
[    0.008628] ACPI: Reserving DMAR table memory at [mem 0x7a9c8000-0x7a9c8087]
[    0.008629] ACPI: Reserving DBG2 table memory at [mem 0x7a9c7000-0x7a9c7060]
[    0.008630] ACPI: Reserving HPET table memory at [mem 0x7a9c6000-0x7a9c6037]
[    0.008630] ACPI: Reserving BGRT table memory at [mem 0x7a9c5000-0x7a9c5037]
[    0.008755] No NUMA configuration found
[    0.008755] Faking a node at [mem 0x0000000000000000-0x000000027effffff]
[    0.008765] NODE_DATA(0) allocated [mem 0x27efd5280-0x27effffff]
[    0.009002] Zone ranges:
[    0.009002]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.009004]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.009006]   Normal   [mem 0x0000000100000000-0x000000027effffff]
[    0.009007]   Device   empty
[    0.009008] Movable zone start for each node
[    0.009010] Early memory node ranges
[    0.009011]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.009012]   node   0: [mem 0x0000000000100000-0x00000000779c6fff]
[    0.009013]   node   0: [mem 0x0000000077adb000-0x000000007a259fff]
[    0.009014]   node   0: [mem 0x000000007a25d000-0x000000007a7b2fff]
[    0.009015]   node   0: [mem 0x000000007a9b3000-0x000000007a9c2fff]
[    0.009015]   node   0: [mem 0x000000007a9d8000-0x000000007a9d8fff]
[    0.009016]   node   0: [mem 0x0000000100000000-0x000000027effffff]
[    0.009018] Initmem setup node 0 [mem 0x0000000000001000-0x000000027effffff]
[    0.009024] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.009051] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.013406] On node 0, zone DMA32: 276 pages in unavailable ranges
[    0.013419] On node 0, zone DMA32: 3 pages in unavailable ranges
[    0.013425] On node 0, zone DMA32: 512 pages in unavailable ranges
[    0.013426] On node 0, zone DMA32: 21 pages in unavailable ranges
[    0.027425] On node 0, zone Normal: 22055 pages in unavailable ranges
[    0.027464] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.027480] Reserving Intel graphics memory at [mem 0x7c000000-0x7fffffff]
[    0.027832] ACPI: PM-Timer IO Port: 0x1808
[    0.027840] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.027874] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-119
[    0.027877] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.027879] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.027883] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.027885] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.027893] e820: update [mem 0x771ce000-0x771f2fff] usable ==> reserved
[    0.027902] TSC deadline timer available
[    0.027907] CPU topo: Max. logical packages:   1
[    0.027908] CPU topo: Max. logical dies:       1
[    0.027908] CPU topo: Max. dies per package:   1
[    0.027913] CPU topo: Max. threads per core:   2
[    0.027914] CPU topo: Num. cores per package:     2
[    0.027914] CPU topo: Num. threads per package:   4
[    0.027915] CPU topo: Allowing 4 present CPUs plus 0 hotplug CPUs
[    0.027928] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.027930] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.027931] PM: hibernation: Registered nosave memory: [mem 0x771ce000-0x771f2fff]
[    0.027933] PM: hibernation: Registered nosave memory: [mem 0x779c7000-0x77adafff]
[    0.027934] PM: hibernation: Registered nosave memory: [mem 0x7a25a000-0x7a25cfff]
[    0.027936] PM: hibernation: Registered nosave memory: [mem 0x7a7b3000-0x7a9b2fff]
[    0.027937] PM: hibernation: Registered nosave memory: [mem 0x7a9c3000-0x7a9d7fff]
[    0.027939] PM: hibernation: Registered nosave memory: [mem 0x7a9d9000-0xffffffff]
[    0.027940] [mem 0x80000000-0xffffffff] available for PCI devices
[    0.027941] Booting paravirtualized kernel on bare hardware
[    0.027944] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.035096] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.035444] percpu: Embedded 62 pages/cpu s217088 r8192 d28672 u524288
[    0.035451] pcpu-alloc: s217088 r8192 d28672 u524288 alloc=1*2097152
[    0.035454] pcpu-alloc: [0] 0 1 2 3 
[    0.035482] Kernel command line: BOOT_IMAGE=/vmlinuz-linux-local root=/dev/mapper/VolGroup00-root rw loglevel=3 quiet cryptdevice=UUID=70c55651-98b6-4a3d-9c6a-9f9e70c23225:cryptroot root=/dev/VolGroup00/root pciehp.pciehp_debug=1 "dyndbg=file drivers/pci/* +p"
[    0.035595] Unknown kernel command line parameters "cryptdevice=UUID=70c55651-98b6-4a3d-9c6a-9f9e70c23225:cryptroot", will be passed to user space.
[    0.035627] random: crng init done
[    0.035628] printk: log buffer data + meta data: 131072 + 458752 = 589824 bytes
[    0.036773] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.037357] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.037442] software IO TLB: area num 4.
[    0.056082] Fallback order for Node 0: 0 
[    0.056085] Built 1 zonelists, mobility grouping on.  Total pages: 2070092
[    0.056087] Policy zone: Normal
[    0.056427] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.080863] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.080886] Kernel/User page tables isolation: enabled
[    0.092431] ftrace: allocating 55180 entries in 216 pages
[    0.092433] ftrace: allocated 216 pages with 4 groups
[    0.092520] Dynamic Preempt: full
[    0.092559] rcu: Preemptible hierarchical RCU implementation.
[    0.092560] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
[    0.092561] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.092563] 	Trampoline variant of Tasks RCU enabled.
[    0.092563] 	Rude variant of Tasks RCU enabled.
[    0.092564] 	Tracing variant of Tasks RCU enabled.
[    0.092564] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.092565] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.092586] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
[    0.092588] RCU Tasks Rude: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
[    0.092590] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
[    0.099045] NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
[    0.099287] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.099574] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.099626] spurious 8259A interrupt: IRQ7.
[    0.099660] Console: colour dummy device 80x25
[    0.099663] printk: legacy console [tty0] enabled
[    0.099707] ACPI: Core revision 20250807
[    0.099766] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.099805] APIC: Switch to symmetric I/O mode setup
[    0.099807] DMAR: Host address width 39
[    0.099809] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.099814] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
[    0.099817] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.099823] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.099825] DMAR: RMRR base: 0x0000007b800000 end: 0x0000007fffffff
[    0.099827] DMAR-IR: IOAPIC id 0 under DRHD base  0xfed91000 IOMMU 1
[    0.099829] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.099830] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.101697] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.101700] x2apic enabled
[    0.101773] APIC: Switched APIC routing to: cluster x2apic
[    0.105847] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x170fff30cc4, max_idle_ns: 440795237869 ns
[    0.105854] Calibrating delay loop (skipped), value calculated using timer frequency.. 3199.92 BogoMIPS (lpj=1599960)
[    0.105883] x86/cpu: SGX disabled or unsupported by BIOS.
[    0.105889] CPU0: Thermal monitoring enabled (TM1)
[    0.105936] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.105938] Last level dTLB entries: 4KB 64, 2MB 32, 4MB 32, 1GB 4
[    0.105943] process: using mwait in idle threads
[    0.105946] mitigations: Enabled attack vectors: user_kernel, user_user, guest_host, guest_guest, SMT mitigations: auto
[    0.105950] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.105952] SRBDS: Mitigation: Microcode
[    0.105954] Spectre V2 : Mitigation: IBRS
[    0.105955] RETBleed: Mitigation: IBRS
[    0.105956] Spectre V2 : User space: Mitigation: STIBP via prctl
[    0.105957] MDS: Mitigation: Clear CPU buffers
[    0.105958] MMIO Stale Data: Mitigation: Clear CPU buffers
[    0.105959] VMSCAPE: Mitigation: IBPB before exit to userspace
[    0.105960] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.105961] Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on context switch and VMEXIT
[    0.105963] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.105975] GDS: Mitigation: Microcode
[    0.105981] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.105983] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.105985] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.105986] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.105988] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.105989] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.105991] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.105993] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.105995] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
[    0.106851] Freeing SMP alternatives memory: 56K
[    0.106851] pid_max: default: 32768 minimum: 301
[    0.106851] LSM: initializing lsm=capability,landlock,lockdown,yama,bpf
[    0.106851] landlock: Up and running.
[    0.106851] Yama: becoming mindful.
[    0.106851] LSM support for eBPF active
[    0.106851] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.106851] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.106851] smpboot: CPU0: Intel(R) Core(TM) i5-7Y57 CPU @ 1.20GHz (family: 0x6, model: 0x8e, stepping: 0x9)
[    0.106851] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.106851] ... version:                   4
[    0.106851] ... bit width:                 48
[    0.106851] ... generic counters:          4
[    0.106851] ... generic bitmap:            000000000000000f
[    0.106851] ... fixed-purpose counters:    3
[    0.106851] ... fixed-purpose bitmap:      0000000000000007
[    0.106851] ... value mask:                0000ffffffffffff
[    0.106851] ... max period:                00007fffffffffff
[    0.106851] ... global_ctrl mask:          000000070000000f
[    0.106851] signal: max sigframe size: 2032
[    0.106851] Estimated ratio of average max frequency by base frequency (times 1024): 1856
[    0.106851] rcu: Hierarchical SRCU implementation.
[    0.106851] rcu: 	Max phase no-delay instances is 400.
[    0.106851] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[    0.107450] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.107498] smp: Bringing up secondary CPUs ...
[    0.107617] smpboot: x86: Booting SMP configuration:
[    0.107619] .... node  #0, CPUs:      #1 #2 #3
[    0.109878] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.109883] MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.
[    0.109884] VMSCAPE: SMT on, STIBP is required for full protection. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/vmscape.html for more details.
[    0.109916] smp: Brought up 1 node, 4 CPUs
[    0.109916] smpboot: Total of 4 processors activated (12799.68 BogoMIPS)
[    0.110915] Memory: 7970240K/8280368K available (19657K kernel code, 2902K rwdata, 10348K rodata, 4624K init, 5140K bss, 297584K reserved, 0K cma-reserved)
[    0.111261] devtmpfs: initialized
[    0.111261] x86/mm: Memory block size: 128MB
[    0.112399] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.112399] posixtimers hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    0.112399] futex hash table entries: 1024 (65536 bytes on 1 NUMA nodes, total 64 KiB, linear).
[    0.112399] pinctrl core: initialized pinctrl subsystem
[    0.112854] PM: RTC time: 12:13:30, date: 2025-10-21
[    0.113382] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.113631] DMA: preallocated 1024 KiB GFP_KERNEL pool for atomic allocations
[    0.113700] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.113770] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.113780] audit: initializing netlink subsys (disabled)
[    0.113795] audit: type=2000 audit(1761048810.007:1): state=initialized audit_enabled=0 res=1
[    0.113951] thermal_sys: Registered thermal governor 'fair_share'
[    0.113953] thermal_sys: Registered thermal governor 'bang_bang'
[    0.113954] thermal_sys: Registered thermal governor 'step_wise'
[    0.113955] thermal_sys: Registered thermal governor 'user_space'
[    0.113956] thermal_sys: Registered thermal governor 'power_allocator'
[    0.113970] cpuidle: using governor ladder
[    0.113974] cpuidle: using governor menu
[    0.114102] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.114185] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
[    0.114202] PCI: Using configuration type 1 for base access
[    0.114371] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.117889] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.117889] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.117889] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.117889] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.118120] raid6: skipped pq benchmark and selected avx2x4
[    0.118122] raid6: using avx2x2 recovery algorithm
[    0.118204] ACPI: Added _OSI(Module Device)
[    0.118206] ACPI: Added _OSI(Processor Device)
[    0.118207] ACPI: Added _OSI(Processor Aggregator Device)
[    0.121554] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.123242] ACPI: EC: EC started
[    0.123242] ACPI: EC: interrupt blocked
[    0.123273] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.123276] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions
[    0.123278] ACPI: Interpreter enabled
[    0.123291] ACPI: PM: (supports S0 S3 S4 S5)
[    0.123292] ACPI: Using IOAPIC for interrupt routing
[    0.123666] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.123668] PCI: Ignoring E820 reservations for host bridge windows
[    0.131322] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.131329] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.131362] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
[    0.132041] PCI host bridge to bus 0000:00
[    0.132046] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.132048] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.132051] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000fffff window]
[    0.132053] pci_bus 0000:00: root bus resource [mem 0x80000000-0xdfffffff window]
[    0.132055] pci_bus 0000:00: root bus resource [mem 0x27f000000-0x7fffffffff window]
[    0.132057] pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7fffff window]
[    0.132058] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.132063] pci_bus 0000:00: scanning bus
[    0.132089] pci 0000:00:00.0: [8086:590c] type 00 class 0x060000 conventional PCI endpoint
[    0.132142] pci 0000:00:00.0: EDR: Notify handler installed
[    0.132216] pci 0000:00:02.0: [8086:591e] type 00 class 0x030000 PCIe Root Complex Integrated Endpoint
[    0.132235] pci 0000:00:02.0: BAR 0 [mem 0xcf000000-0xcfffffff 64bit]
[    0.132243] pci 0000:00:02.0: BAR 2 [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.132245] pci 0000:00:02.0: BAR 4 [io  0xffc0-0xffff]
[    0.132260] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.132297] pci 0000:00:02.0: EDR: Notify handler installed
[    0.132376] pci 0000:00:04.0: [8086:1903] type 00 class 0x118000 conventional PCI endpoint
[    0.132398] pci 0000:00:04.0: BAR 0 [mem 0xceed8000-0xceedffff 64bit]
[    0.132439] pci 0000:00:04.0: EDR: Notify handler installed
[    0.132559] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330 conventional PCI endpoint
[    0.132601] pci 0000:00:14.0: BAR 0 [mem 0xceef0000-0xceefffff 64bit]
[    0.132641] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.132647] pci 0000:00:14.0: PME# disabled
[    0.132675] pci 0000:00:14.0: EDR: Notify handler installed
[    0.132768] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000 conventional PCI endpoint
[    0.132808] pci 0000:00:14.2: BAR 0 [mem 0xceecf000-0xceecffff 64bit]
[    0.132926] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000 conventional PCI endpoint
[    0.132985] pci 0000:00:15.0: BAR 0 [mem 0xceece000-0xceecefff 64bit]
[    0.133065] pci 0000:00:15.0: EDR: Notify handler installed
[    0.133141] pci 0000:00:15.1: [8086:9d61] type 00 class 0x118000 conventional PCI endpoint
[    0.133200] pci 0000:00:15.1: BAR 0 [mem 0xceecd000-0xceecdfff 64bit]
[    0.133273] pci 0000:00:15.1: EDR: Notify handler installed
[    0.133352] pci 0000:00:15.2: [8086:9d62] type 00 class 0x118000 conventional PCI endpoint
[    0.133411] pci 0000:00:15.2: BAR 0 [mem 0xceecc000-0xceeccfff 64bit]
[    0.133485] pci 0000:00:15.2: EDR: Notify handler installed
[    0.133592] pci 0000:00:19.0: [8086:9d66] type 00 class 0x118000 conventional PCI endpoint
[    0.133651] pci 0000:00:19.0: BAR 0 [mem 0xfe030000-0xfe030fff 64bit]
[    0.133655] pci 0000:00:19.0: BAR 2 [mem 0xceeca000-0xceecafff 64bit]
[    0.133726] pci 0000:00:19.0: EDR: Notify handler installed
[    0.133803] pci 0000:00:19.2: [8086:9d64] type 00 class 0x118000 conventional PCI endpoint
[    0.133863] pci 0000:00:19.2: BAR 0 [mem 0xceec9000-0xceec9fff 64bit]
[    0.133943] pci 0000:00:19.2: EDR: Notify handler installed
[    0.134051] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400 PCIe Root Port
[    0.134075] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.134082] pci 0000:00:1c.0:   bridge window [mem 0xcef00000-0xceffffff]
[    0.134154] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.134158] pci 0000:00:1c.0: PME# disabled
[    0.134212] pci 0000:00:1c.0: EDR: Notify handler installed
[    0.134351] pci 0000:00:1e.0: [8086:9d27] type 00 class 0x118000 conventional PCI endpoint
[    0.134410] pci 0000:00:1e.0: BAR 0 [mem 0xceec8000-0xceec8fff 64bit]
[    0.134415] pci 0000:00:1e.0: BAR 2 [mem 0xceec7000-0xceec7fff 64bit]
[    0.134487] pci 0000:00:1e.0: EDR: Notify handler installed
[    0.134564] pci 0000:00:1e.2: [8086:9d29] type 00 class 0x118000 conventional PCI endpoint
[    0.134623] pci 0000:00:1e.2: BAR 0 [mem 0xceec6000-0xceec6fff 64bit]
[    0.134699] pci 0000:00:1e.2: EDR: Notify handler installed
[    0.134775] pci 0000:00:1e.4: [8086:9d2b] type 00 class 0x080501 conventional PCI endpoint
[    0.134830] pci 0000:00:1e.4: BAR 0 [mem 0xceec5000-0xceec5fff 64bit]
[    0.134948] pci 0000:00:1e.4: EDR: Notify handler installed
[    0.135100] pci 0000:00:1f.0: [8086:9d4b] type 00 class 0x060100 conventional PCI endpoint
[    0.135186] pci 0000:00:1f.0: EDR: Notify handler installed
[    0.135274] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000 conventional PCI endpoint
[    0.135319] pci 0000:00:1f.2: BAR 0 [mem 0xceed4000-0xceed7fff]
[    0.135352] pci 0000:00:1f.2: EDR: Notify handler installed
[    0.135425] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040100 conventional PCI endpoint
[    0.135480] pci 0000:00:1f.3: BAR 0 [mem 0xceed0000-0xceed3fff 64bit]
[    0.135487] pci 0000:00:1f.3: BAR 4 [mem 0xceee0000-0xceeeffff 64bit]
[    0.135532] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.135536] pci 0000:00:1f.3: PME# disabled
[    0.135582] pci 0000:00:1f.3: EDR: Notify handler installed
[    0.135720] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500 conventional PCI endpoint
[    0.135853] pci 0000:00:1f.4: BAR 0 [mem 0xceec3000-0xceec30ff 64bit]
[    0.135870] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.135930] pci 0000:00:1f.4: EDR: Notify handler installed
[    0.135989] pci 0000:00:1f.5: [8086:9d24] type 00 class 0x000000 conventional PCI endpoint
[    0.136037] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.136097] pci_bus 0000:00: fixups for bus
[    0.136101] pci 0000:00:1c.0: scanning [bus 01-01] behind bridge, pass 0
[    0.136298] pci_bus 0000:01: scanning bus
[    0.136442] pci 0000:01:00.0: [8086:095a] type 00 class 0x028000 PCIe Endpoint
[    0.136581] pci 0000:01:00.0: BAR 0 [mem 0xcef00000-0xcef01fff 64bit]
[    0.136831] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.137904] pci 0000:01:00.0: PME# disabled
[    0.138234] pci 0000:01:00.0: EDR: Notify handler installed
[    0.138942] pci_bus 0000:01: fixups for bus
[    0.138944] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.138959] pci_bus 0000:01: bus scan returning with max=01
[    0.138964] pci 0000:00:1c.0: scanning [bus 01-01] behind bridge, pass 1
[    0.138969] pci_bus 0000:00: bus scan returning with max=01
[    0.139354] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
[    0.139438] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.139516] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.139594] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.139671] ACPI: PCI: Interrupt link LNKE configured for IRQ 11
[    0.139749] ACPI: PCI: Interrupt link LNKF configured for IRQ 11
[    0.139827] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
[    0.139916] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
[    0.141596] Low-power S0 idle used by default for system suspend
[    0.142019] ACPI: EC: interrupt unblocked
[    0.142021] ACPI: EC: event unblocked
[    0.142028] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.142030] ACPI: EC: GPE=0x6e
[    0.142031] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC initialization complete
[    0.142034] ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions and events
[    0.142141] iommu: Default domain type: Translated
[    0.142141] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.143974] SCSI subsystem initialized
[    0.143982] libata version 3.00 loaded.
[    0.143982] ACPI: bus type USB registered
[    0.143982] usbcore: registered new interface driver usbfs
[    0.143982] usbcore: registered new interface driver hub
[    0.143982] usbcore: registered new device driver usb
[    0.143982] EDAC MC: Ver: 3.0.0
[    0.144175] efivars: Registered efivars operations
[    0.144175] NetLabel: Initializing
[    0.144175] NetLabel:  domain hash size = 128
[    0.144175] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.144175] NetLabel:  unlabeled traffic allowed by default
[    0.144175] mctp: management component transport protocol core
[    0.144175] NET: Registered PF_MCTP protocol family
[    0.144175] PCI: Using ACPI for IRQ routing
[    0.173691] PCI: pci_cache_line_size set to 64 bytes
[    0.174040] e820: reserve RAM buffer [mem 0x771ce000-0x77ffffff]
[    0.174042] e820: reserve RAM buffer [mem 0x779c7000-0x77ffffff]
[    0.174044] e820: reserve RAM buffer [mem 0x7a25a000-0x7bffffff]
[    0.174045] e820: reserve RAM buffer [mem 0x7a7b3000-0x7bffffff]
[    0.174047] e820: reserve RAM buffer [mem 0x7a9c3000-0x7bffffff]
[    0.174048] e820: reserve RAM buffer [mem 0x7a9d9000-0x7bffffff]
[    0.174049] e820: reserve RAM buffer [mem 0x27f000000-0x27fffffff]
[    0.174088] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.174088] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.174088] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.174088] vgaarb: loaded
[    0.174088] clocksource: Switched to clocksource tsc-early
[    0.174716] VFS: Disk quotas dquot_6.6.0
[    0.174726] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.174877] pnp: PnP ACPI init
[    0.174990] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.175136] system 00:01: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.175139] system 00:01: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.175141] system 00:01: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.175143] system 00:01: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.175146] system 00:01: [mem 0xff000000-0xffffffff] has been reserved
[    0.175148] system 00:01: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.175150] system 00:01: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.175387] system 00:02: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.175427] system 00:03: [io  0x1800-0x18fe] has been reserved
[    0.175492] system 00:05: [io  0x0900-0x09fe] has been reserved
[    0.175531] system 00:06: [io  0x0200] has been reserved
[    0.175534] system 00:06: [io  0x0204] has been reserved
[    0.175535] system 00:06: [io  0x0800-0x087f] has been reserved
[    0.175537] system 00:06: [io  0x0880-0x08ff] has been reserved
[    0.176254] pnp: PnP ACPI: found 8 devices
[    0.182306] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.182370] NET: Registered PF_INET protocol family
[    0.182452] IP idents hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.183854] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
[    0.183881] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.183928] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.184121] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.184364] TCP: Hash tables configured (established 65536 bind 65536)
[    0.184448] MPTCP token hash table entries: 8192 (order: 5, 196608 bytes, linear)
[    0.184492] UDP hash table entries: 4096 (order: 6, 262144 bytes, linear)
[    0.184534] UDP-Lite hash table entries: 4096 (order: 6, 262144 bytes, linear)
[    0.184600] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.184608] NET: Registered PF_XDP protocol family
[    0.184617] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
[    0.184623] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
[    0.184635] pci 0000:00:1c.0: bridge window [mem 0x27f000000-0x27f1fffff 64bit pref]: assigned
[    0.184638] pci 0000:00:1c.0: bridge window [io  0x2000-0x2fff]: assigned
[    0.184642] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.184654] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.184659] pci 0000:00:1c.0:   bridge window [mem 0xcef00000-0xceffffff]
[    0.184663] pci 0000:00:1c.0:   bridge window [mem 0x27f000000-0x27f1fffff 64bit pref]
[    0.184669] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.184671] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.184673] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000fffff window]
[    0.184675] pci_bus 0000:00: resource 7 [mem 0x80000000-0xdfffffff window]
[    0.184677] pci_bus 0000:00: resource 8 [mem 0x27f000000-0x7fffffffff window]
[    0.184678] pci_bus 0000:00: resource 9 [mem 0xfc800000-0xfe7fffff window]
[    0.184680] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.184682] pci_bus 0000:01: resource 1 [mem 0xcef00000-0xceffffff]
[    0.184684] pci_bus 0000:01: resource 2 [mem 0x27f000000-0x27f1fffff 64bit pref]
[    0.185241] PCI: CLS 64 bytes, default 64
[    0.185296] pci 0000:00:1f.1: [8086:9d20] type 00 class 0x058000 conventional PCI endpoint
[    0.185450] pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]
[    0.185573] pci 0000:00:1f.1: vgaarb: pci_notify
[    0.185586] pci 0000:00:1f.1: PME# disabled
[    0.185589] pci 0000:00:1f.1: vgaarb: pci_notify
[    0.185616] pci 0000:00:1f.1: vgaarb: pci_notify
[    0.185622] pci 0000:00:1f.1: device released
[    0.185649] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.185650] software IO TLB: mapped [mem 0x000000006d632000-0x0000000071632000] (64MB)
[    0.185727] Unpacking initramfs...
[    0.195116] Initialise system trusted keyrings
[    0.195128] Key type blacklist registered
[    0.195232] workingset: timestamp_bits=36 max_order=21 bucket_order=0
[    0.195607] fuse: init (API version 7.45)
[    0.195732] integrity: Platform Keyring initialized
[    0.195735] integrity: Machine keyring initialized
[    0.214587] xor: automatically using best checksumming function   avx       
[    0.214594] Key type asymmetric registered
[    0.214596] Asymmetric key parser 'x509' registered
[    0.214633] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    0.214742] io scheduler mq-deadline registered
[    0.214744] io scheduler kyber registered
[    0.214779] io scheduler bfq registered
[    0.219480] ledtrig-cpu: registered to indicate activity on CPUs
[    0.219526] pciehp: pcie_port_service_register = 0
[    0.219543] pcieport 0000:00:1c.0: vgaarb: pci_notify
[    0.219551] pcieport 0000:00:1c.0: runtime IRQ mapping not provided by arch
[    0.219844] pcieport 0000:00:1c.0: PME: Signaling with IRQ 120
[    0.219995] pcieport 0000:00:1c.0: AER: enabled with IRQ 120
[    0.220041] pcieport 0000:00:1c.0: pciehp: Slot Capabilities      : 0x0004b260
[    0.220045] pcieport 0000:00:1c.0: pciehp: Slot Status            : 0x0048
[    0.220048] pcieport 0000:00:1c.0: pciehp: Slot Control           : 0x0008
[    0.220051] pcieport 0000:00:1c.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.220222] pci_bus 0000:01: dev 00, created physical slot 0
[    0.220308] pcieport 0000:00:1c.0: pciehp: pcie_enable_notification: SLOTCTRL 58 write cmd 1028
[    0.220316] pcieport 0000:00:1c.0: pciehp: pending interrupts 0x0008 from Slot Status
[    0.220322] pcieport 0000:00:1c.0: pciehp: Slot(0): Card not present
[    0.220325] pcieport 0000:00:1c.0: pciehp: pciehp_unconfigure_device: domain:bus:dev = 0000:01:00
[    0.220329] pci 0000:01:00.0: PME# disabled
[    0.220334] pci 0000:01:00.0: vgaarb: pci_notify
[    0.220362] pcieport 0000:00:1c.0: bwctrl: enabled with IRQ 120
[    0.220364] pcieport 0000:00:1c.0: pciehp: pending interrupts 0x0008 from Slot Status
[    0.220388] pcieport 0000:00:1c.0: save config 0x00: 0x9d108086
[    0.220392] pcieport 0000:00:1c.0: save config 0x04: 0x00100507
[    0.220396] pcieport 0000:00:1c.0: save config 0x08: 0x060400f1
[    0.220399] pcieport 0000:00:1c.0: save config 0x0c: 0x00810010
[    0.220403] pcieport 0000:00:1c.0: save config 0x10: 0x00000000
[    0.220406] pcieport 0000:00:1c.0: save config 0x14: 0x00000000
[    0.220409] pcieport 0000:00:1c.0: save config 0x18: 0x00010100
[    0.220413] pcieport 0000:00:1c.0: save config 0x1c: 0x00002020
[    0.220416] pcieport 0000:00:1c.0: save config 0x20: 0xcef0cef0
[    0.220419] pcieport 0000:00:1c.0: save config 0x24: 0x7f117f01
[    0.220419] pci 0000:01:00.0: EDR: Notify handler removed
[    0.220422] pcieport 0000:00:1c.0: save config 0x28: 0x00000002
[    0.220425] pcieport 0000:00:1c.0: save config 0x2c: 0x00000002
[    0.220428] pcieport 0000:00:1c.0: save config 0x30: 0x00000000
[    0.220442] pcieport 0000:00:1c.0: save config 0x34: 0x00000040
[    0.220446] pcieport 0000:00:1c.0: save config 0x38: 0x00000000
[    0.220449] pcieport 0000:00:1c.0: save config 0x3c: 0x001201ff
[    0.220471] pci 0000:01:00.0: vgaarb: pci_notify
[    0.220485] pcieport 0000:00:1c.0: vgaarb: pci_notify
[    0.220513] pci 0000:01:00.0: device released
[    0.220526] pcieport 0000:00:1c.0: pciehp: pciehp_check_link_active: lnk_status = 3011
[    0.220528] pcieport 0000:00:1c.0: pciehp: Slot(0): Card present
[    0.220530] pcieport 0000:00:1c.0: pciehp: Slot(0): Link Up
[    0.220771] ACPI: AC: AC Adapter [AC] (on-line)
[    0.220829] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:06/PNP0C09:00/PNP0C0D:00/input/input0
[    0.220904] ACPI: button: Lid Switch [LID0]
[    0.220966] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.221054] ACPI: button: Power Button [PWRF]
[    0.221243] Monitor-Mwait will be used to enter C-1 state
[    0.221253] Monitor-Mwait will be used to enter C-2 state
[    0.221260] Monitor-Mwait will be used to enter C-3 state
[    0.221674] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.222602] ACPI: battery: Slot [BAT0] (battery present)
[    0.224360] hpet_acpi_add: no address or irqs in _CRS
[    0.224418] Non-volatile memory driver v1.3
[    0.224420] Linux agpgart interface v0.103
[    0.224498] ACPI: bus type drm_connector registered
[    0.225027] xhci_hcd 0000:00:14.0: vgaarb: pci_notify
[    0.225033] xhci_hcd 0000:00:14.0: runtime IRQ mapping not provided by arch
[    0.225201] xhci_hcd 0000:00:14.0: enabling bus mastering
[    0.225209] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.225215] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    0.226349] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000081109810
[    0.226376] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    0.226843] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.226849] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    0.226854] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    0.226915] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.18
[    0.226919] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.226922] usb usb1: Product: xHCI Host Controller
[    0.226924] usb usb1: Manufacturer: Linux 6.18.0-rc1-local-reverted-pci-issues-00351-gbbaff7ff47dd xhci-hcd
[    0.226927] usb usb1: SerialNumber: 0000:00:14.0
[    0.227126] hub 1-0:1.0: USB hub found
[    0.227158] hub 1-0:1.0: 12 ports detected
[    0.227694] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.18
[    0.227698] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.227701] usb usb2: Product: xHCI Host Controller
[    0.227703] usb usb2: Manufacturer: Linux 6.18.0-rc1-local-reverted-pci-issues-00351-gbbaff7ff47dd xhci-hcd
[    0.227706] usb usb2: SerialNumber: 0000:00:14.0
[    0.227859] hub 2-0:1.0: USB hub found
[    0.227883] hub 2-0:1.0: 6 ports detected
[    0.228190] xhci_hcd 0000:00:14.0: vgaarb: pci_notify
[    0.228236] usbcore: registered new interface driver usbserial_generic
[    0.228243] usbserial: USB Serial support registered for generic
[    0.228287] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    0.228290] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    0.228804] i8042: Warning: Keylock active
[    0.229003] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.229241] rtc_cmos 00:04: RTC can wake from S4
[    0.230055] rtc_cmos 00:04: registered as rtc0
[    0.230198] rtc_cmos 00:04: setting system clock to 2025-10-21T12:13:30 UTC (1761048810)
[    0.230246] rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram
[    0.230385] intel_pstate: Intel P-state driver initializing
[    0.230624] intel_pstate: HWP enabled
[    0.230947] simple-framebuffer simple-framebuffer.0: [drm] Registered 1 planes with drm panic
[    0.230951] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 on minor 0
[    0.233888] fbcon: Deferring console take-over
[    0.233894] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
[    0.233999] hid: raw HID events driver (C) Jiri Kosina
[    0.234035] usbcore: registered new interface driver usbhid
[    0.234036] usbhid: USB HID core driver
[    0.234153] drop_monitor: Initializing network drop monitor service
[    0.234312] NET: Registered PF_INET6 protocol family
[    0.234892] Segment Routing with IPv6
[    0.234895] RPL Segment Routing with IPv6
[    0.234903] In-situ OAM (IOAM) with IPv6
[    0.234926] NET: Registered PF_PACKET protocol family
[    0.235354] microcode: Current revision: 0x000000f6
[    0.235434] IPI shorthand broadcast: enabled
[    0.236454] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    0.239286] sched_clock: Marking stable (232001392, 6429519)->(286953898, -48522987)
[    0.239461] registered taskstats version 1
[    0.239778] Loading compiled-in X.509 certificates
[    0.276511] Freeing initrd memory: 32328K
[    0.283322] Loaded X.509 cert 'Build time autogenerated kernel key: 2fba5c546a93aa1945e8ad54c3c146853b40f2c1'
[    0.286531] zswap: loaded using pool zstd
[    0.286707] Demotion targets for Node 0: null
[    0.286987] Key type .fscrypt registered
[    0.286989] Key type fscrypt-provisioning registered
[    0.287290] Btrfs loaded, zoned=yes, fsverity=yes
[    0.287311] Key type big_key registered
[    0.287351] integrity: Loading X.509 certificate: UEFI:db
[    0.287378] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.287379] integrity: Loading X.509 certificate: UEFI:db
[    0.287393] integrity: Loaded X.509 cert 'Microsoft Corporation: Windows UEFI CA 2023: aefc5fbbbe055d8f8daa585473499417ab5a5272'
[    0.287395] integrity: Loading X.509 certificate: UEFI:db
[    0.287421] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.287422] integrity: Loading X.509 certificate: UEFI:db
[    0.287440] integrity: Loaded X.509 cert 'Microsoft UEFI CA 2023: 81aa6b3244c935bce0d6628af39827421e32497d'
[    0.287442] integrity: Loading X.509 certificate: UEFI:db
[    0.291197] integrity: Loaded X.509 cert 'System76 Secure Boot Database Key: 3a7a94cfb9868ddcd29105224b504d54b1f9d238'
[    0.292525] PM:   Magic number: 13:44:229
[    0.292633] RAS: Correctable Errors collector initialized.
[    0.292669] clk: Disabling unused clocks
[    0.293833] Freeing unused decrypted memory: 2036K
[    0.294617] Freeing unused kernel image (initmem) memory: 4624K
[    0.294733] Write protecting the kernel read-only data: 32768k
[    0.295311] Freeing unused kernel image (text/rodata gap) memory: 820K
[    0.295840] Freeing unused kernel image (rodata/data gap) memory: 1940K
[    0.345631] pcieport 0000:00:1c.0: pciehp: pciehp_check_link_status: lnk_status = 3011
[    0.345691] pci 0000:01:00.0: [8086:095a] type 00 class 0x028000 PCIe Endpoint
[    0.345785] pci 0000:01:00.0: BAR 0 [mem 0xcef00000-0xcef01fff 64bit]
[    0.345955] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.345963] pci 0000:01:00.0: PME# disabled
[    0.346181] pci 0000:01:00.0: EDR: Notify handler installed
[    0.346333] pci 0000:01:00.0: vgaarb: pci_notify
[    0.346449] pcieport 0000:00:1c.0: distributing available resources
[    0.346455] pci 0000:01:00.0: BAR 0 [mem 0xcef00000-0xcef01fff 64bit]: assigned
[    0.346474] pcieport 0000:00:1c.0: PCI bridge to [bus 01]
[    0.346477] pcieport 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.346481] pcieport 0000:00:1c.0:   bridge window [mem 0xcef00000-0xceffffff]
[    0.346485] pcieport 0000:00:1c.0:   bridge window [mem 0x27f000000-0x27f1fffff 64bit pref]
[    0.346758] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.346763] rodata_test: all tests were successful
[    0.346765] x86/mm: Checking user space page tables
[    0.392442] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.392447] Run /init as init process
[    0.392449]   with arguments:
[    0.392450]     /init
[    0.392451]   with environment:
[    0.392452]     HOME=/
[    0.392453]     TERM=linux
[    0.392454]     cryptdevice=UUID=70c55651-98b6-4a3d-9c6a-9f9e70c23225:cryptroot
[    0.466449] usb 1-2: new high-speed USB device number 2 using xhci_hcd
[    0.606912] usb 1-2: New USB device found, idVendor=0bda, idProduct=564b, bcdDevice= 0.06
[    0.606921] usb 1-2: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    0.606925] usb 1-2: Product: WebCamera
[    0.606928] usb 1-2: Manufacturer: Generic
[    0.606931] usb 1-2: SerialNumber: \x07LOE65001063010A7B100DF5AI06BF12000
[    0.678194] intel-spi 0000:00:1f.5: vgaarb: pci_notify
[    0.678203] intel-spi 0000:00:1f.5: runtime IRQ mapping not provided by arch
[    0.678850] intel-spi 0000:00:1f.5: vgaarb: pci_notify
[    0.704486] usb 2-2: new SuperSpeed USB device number 2 using xhci_hcd
[    0.712036] sdhci: Secure Digital Host Controller Interface driver
[    0.712041] sdhci: Copyright(c) Pierre Ossman
[    0.716874] usb 2-2: New USB device found, idVendor=1d5c, idProduct=5001, bcdDevice= 1.00
[    0.716882] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    0.716886] usb 2-2: Product: USB3.0 Hub
[    0.716888] usb 2-2: Manufacturer: Fresco Logic, Inc.
[    0.717759] hub 2-2:1.0: USB hub found
[    0.717953] hub 2-2:1.0: 4 ports detected
[    0.730596] sdhci-pci 0000:00:1e.4: vgaarb: pci_notify
[    0.730606] sdhci-pci 0000:00:1e.4: runtime IRQ mapping not provided by arch
[    0.730610] sdhci-pci 0000:00:1e.4: SDHCI controller found [8086:9d2b] (rev 21)
[    0.731522] mmc0: SDHCI controller on PCI [0000:00:1e.4] using ADMA 64-bit
[    0.731543] sdhci-pci 0000:00:1e.4: vgaarb: pci_notify
[    0.827356] mmc0: new HS400 MMC card at address 0001
[    0.832446] usb 1-3: new full-speed USB device number 3 using xhci_hcd
[    0.889445] sdhci-pci 0000:00:1e.4: save config 0x00: 0x9d2b8086
[    0.889451] sdhci-pci 0000:00:1e.4: save config 0x04: 0x00100006
[    0.889454] sdhci-pci 0000:00:1e.4: save config 0x08: 0x08050121
[    0.889458] sdhci-pci 0000:00:1e.4: save config 0x0c: 0x00800010
[    0.889461] sdhci-pci 0000:00:1e.4: save config 0x10: 0xceec5004
[    0.889464] sdhci-pci 0000:00:1e.4: save config 0x14: 0x00000000
[    0.889467] sdhci-pci 0000:00:1e.4: save config 0x18: 0x00000000
[    0.889470] sdhci-pci 0000:00:1e.4: save config 0x1c: 0x00000000
[    0.889473] sdhci-pci 0000:00:1e.4: save config 0x20: 0x00000000
[    0.889476] sdhci-pci 0000:00:1e.4: save config 0x24: 0x00000000
[    0.889479] sdhci-pci 0000:00:1e.4: save config 0x28: 0x00000000
[    0.889482] sdhci-pci 0000:00:1e.4: save config 0x2c: 0x9d2b8086
[    0.889485] sdhci-pci 0000:00:1e.4: save config 0x30: 0x00000000
[    0.889488] sdhci-pci 0000:00:1e.4: save config 0x34: 0x00000080
[    0.889491] sdhci-pci 0000:00:1e.4: save config 0x38: 0x00000000
[    0.889494] sdhci-pci 0000:00:1e.4: save config 0x3c: 0x000002ff
[    0.889535] sdhci-pci 0000:00:1e.4: ACPI _REG disconnect evaluation failed (5)
[    0.889618] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D3hot
[    0.956452] usb 1-3: New USB device found, idVendor=8087, idProduct=0a2a, bcdDevice= 0.03
[    0.956456] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.069438] usb 1-5: new high-speed USB device number 4 using xhci_hcd
[    1.192737] usb 1-5: New USB device found, idVendor=1d5c, idProduct=5011, bcdDevice= 1.00
[    1.192742] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.192745] usb 1-5: Product: USB2.0 Hub
[    1.192748] usb 1-5: Manufacturer: Fresco Logic, Inc.
[    1.193529] hub 1-5:1.0: USB hub found
[    1.193590] hub 1-5:1.0: 5 ports detected
[    1.226438] tsc: Refined TSC clocksource calibration: 1607.999 MHz
[    1.226462] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x172da94f0e2, max_idle_ns: 440795278248 ns
[    1.226482] clocksource: Switched to clocksource tsc
[    1.443079] mmcblk0: mmc0:0001 DURM4R 116 GiB
[    1.443291] i915 0000:00:02.0: vgaarb: pci_notify
[    1.443296] i915 0000:00:02.0: runtime IRQ mapping not provided by arch
[    1.443418] i915 0000:00:02.0: [drm] Found kabylake/ulx (device ID 591e) integrated display version 9.00 stepping B0
[    1.445944] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D0
[    1.445950] sdhci-pci 0000:00:1e.4: ACPI _REG connect evaluation failed (5)
[    1.449225]  mmcblk0: p1 p2
[    1.449452] mmcblk0boot0: mmc0:0001 DURM4R 4.00 MiB
[    1.450077] mmcblk0boot1: mmc0:0001 DURM4R 4.00 MiB
[    1.450663] mmcblk0rpmb: mmc0:0001 DURM4R 4.00 MiB, chardev (239:0)
[    1.462908] i915 0000:00:02.0: vgaarb: deactivate vga console
[    1.463196] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    1.463200] i915 0000:00:02.0: vgaarb: decoding count now is: 1
[    1.463202] i915 0000:00:02.0: vgaarb: __vga_tryget: 1
[    1.463204] i915 0000:00:02.0: vgaarb: __vga_tryget: owns: 3
[    1.463209] i915 0000:00:02.0: vgaarb: __vga_put
[    1.463887] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
[    1.485792] i915 0000:00:02.0: [drm] Registered 3 planes with drm panic
[    1.485796] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 1
[    1.485974] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    1.486038] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input3
[    1.533471] sdhci-pci 0000:00:1e.4: save config 0x00: 0x9d2b8086
[    1.533479] sdhci-pci 0000:00:1e.4: save config 0x04: 0x00100006
[    1.533483] sdhci-pci 0000:00:1e.4: save config 0x08: 0x08050121
[    1.533486] sdhci-pci 0000:00:1e.4: save config 0x0c: 0x00800010
[    1.533489] sdhci-pci 0000:00:1e.4: save config 0x10: 0xceec5004
[    1.533492] sdhci-pci 0000:00:1e.4: save config 0x14: 0x00000000
[    1.533495] sdhci-pci 0000:00:1e.4: save config 0x18: 0x00000000
[    1.533498] sdhci-pci 0000:00:1e.4: save config 0x1c: 0x00000000
[    1.533501] sdhci-pci 0000:00:1e.4: save config 0x20: 0x00000000
[    1.533504] sdhci-pci 0000:00:1e.4: save config 0x24: 0x00000000
[    1.533507] sdhci-pci 0000:00:1e.4: save config 0x28: 0x00000000
[    1.533510] sdhci-pci 0000:00:1e.4: save config 0x2c: 0x9d2b8086
[    1.533513] sdhci-pci 0000:00:1e.4: save config 0x30: 0x00000000
[    1.533516] sdhci-pci 0000:00:1e.4: save config 0x34: 0x00000080
[    1.533519] sdhci-pci 0000:00:1e.4: save config 0x38: 0x00000000
[    1.533522] sdhci-pci 0000:00:1e.4: save config 0x3c: 0x000002ff
[    1.533541] sdhci-pci 0000:00:1e.4: ACPI _REG disconnect evaluation failed (5)
[    1.533582] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D3hot
[    1.553037] fbcon: i915drmfb (fb0) is primary device
[    1.553041] fbcon: Deferring console take-over
[    1.553044] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    1.560614] i915 0000:00:02.0: vgaarb: pci_notify
[    1.590766] device-mapper: uevent: version 1.0.3
[    1.590839] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
[    1.608097] Key type encrypted registered
[    1.622306] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D0
[    1.622313] sdhci-pci 0000:00:1e.4: ACPI _REG connect evaluation failed (5)
[    1.627079] fbcon: Taking over console
[    1.687115] sdhci-pci 0000:00:1e.4: save config 0x00: 0x9d2b8086
[    1.687125] sdhci-pci 0000:00:1e.4: save config 0x04: 0x00100006
[    1.687131] sdhci-pci 0000:00:1e.4: save config 0x08: 0x08050121
[    1.687136] sdhci-pci 0000:00:1e.4: save config 0x0c: 0x00800010
[    1.687140] sdhci-pci 0000:00:1e.4: save config 0x10: 0xceec5004
[    1.687145] sdhci-pci 0000:00:1e.4: save config 0x14: 0x00000000
[    1.687149] sdhci-pci 0000:00:1e.4: save config 0x18: 0x00000000
[    1.687154] sdhci-pci 0000:00:1e.4: save config 0x1c: 0x00000000
[    1.687158] sdhci-pci 0000:00:1e.4: save config 0x20: 0x00000000
[    1.687162] sdhci-pci 0000:00:1e.4: save config 0x24: 0x00000000
[    1.687166] sdhci-pci 0000:00:1e.4: save config 0x28: 0x00000000
[    1.687170] sdhci-pci 0000:00:1e.4: save config 0x2c: 0x9d2b8086
[    1.687175] sdhci-pci 0000:00:1e.4: save config 0x30: 0x00000000
[    1.687179] sdhci-pci 0000:00:1e.4: save config 0x34: 0x00000080
[    1.687183] sdhci-pci 0000:00:1e.4: save config 0x38: 0x00000000
[    1.687187] sdhci-pci 0000:00:1e.4: save config 0x3c: 0x000002ff
[    1.687218] sdhci-pci 0000:00:1e.4: ACPI _REG disconnect evaluation failed (5)
[    1.687296] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D3hot
[    1.712724] Console: switching to colour frame buffer device 150x50
[    1.949909] pcieport 0000:00:1c.0: pciehp: pending interrupts 0x0008 from Slot Status
[    1.949940] pcieport 0000:00:1c.0: AER: Multiple Correctable error message received from 0000:00:1c.0
[    1.949950] pcieport 0000:00:1c.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
[    1.949955] pcieport 0000:00:1c.0:   device [8086:9d10] error status/mask=00000001/00002000
[    1.949960] pcieport 0000:00:1c.0:    [ 0] RxErr                  (First)
[    1.949978] pcieport 0000:00:1c.0: pciehp: Slot(0): Card not present
[    1.949982] pcieport 0000:00:1c.0: pciehp: pciehp_unconfigure_device: domain:bus:dev = 0000:01:00
[    1.949989] pci 0000:01:00.0: PME# disabled
[    1.950008] pci 0000:01:00.0: vgaarb: pci_notify
[    1.950109] pci 0000:01:00.0: EDR: Notify handler removed
[    1.950285] pci 0000:01:00.0: vgaarb: pci_notify
[    1.950316] pci 0000:01:00.0: device released
[    1.950326] pcieport 0000:00:1c.0: pciehp: pciehp_check_link_active: lnk_status = 3011
[    1.950331] pcieport 0000:00:1c.0: pciehp: Slot(0): Card present
[    1.950335] pcieport 0000:00:1c.0: pciehp: Slot(0): Link Up
[    2.073659] pcieport 0000:00:1c.0: pciehp: pciehp_check_link_status: lnk_status = 3011
[    2.073756] pci 0000:01:00.0: [8086:095a] type 00 class 0x028000 PCIe Endpoint
[    2.073871] pci 0000:01:00.0: BAR 0 [mem 0xcef00000-0xcef01fff 64bit]
[    2.074080] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    2.074092] pci 0000:01:00.0: PME# disabled
[    2.074405] pci 0000:01:00.0: EDR: Notify handler installed
[    2.074793] pci 0000:01:00.0: vgaarb: pci_notify
[    2.074969] pcieport 0000:00:1c.0: distributing available resources
[    2.074981] pci 0000:01:00.0: BAR 0 [mem 0xcef00000-0xcef01fff 64bit]: assigned
[    2.075007] pcieport 0000:00:1c.0: PCI bridge to [bus 01]
[    2.075014] pcieport 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    2.075023] pcieport 0000:00:1c.0:   bridge window [mem 0xcef00000-0xceffffff]
[    2.075030] pcieport 0000:00:1c.0:   bridge window [mem 0x27f000000-0x27f1fffff 64bit pref]
[    2.373237] usb 2-2.4: new SuperSpeed USB device number 3 using xhci_hcd
[    2.528631] usb 1-5.5: new high-speed USB device number 6 using xhci_hcd
[    2.613289] usb 1-5.5: New USB device found, idVendor=1d5c, idProduct=5100, bcdDevice= 1.00
[    2.613300] usb 1-5.5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.613306] usb 1-5.5: Product: Generic Billboard Device
[    2.613310] usb 1-5.5: Manufacturer: Fresco Logic, Inc
[    2.659835] usb 2-2.4: New USB device found, idVendor=0b95, idProduct=1790, bcdDevice= 2.00
[    2.659847] usb 2-2.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.659853] usb 2-2.4: Product: AX88179A
[    2.659857] usb 2-2.4: Manufacturer: ASIX
[    2.659861] usb 2-2.4: SerialNumber: 00A0CEC83D617A
[    3.174704] pcieport 0000:00:1c.0: AER: Multiple Correctable error message received from 0000:00:1c.0
[    3.174723] pcieport 0000:00:1c.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
[    3.174731] pcieport 0000:00:1c.0:   device [8086:9d10] error status/mask=00000001/00002000
[    3.174739] pcieport 0000:00:1c.0:    [ 0] RxErr                  (First)
[    5.011546] pcieport 0000:00:1c.0: AER: Multiple Correctable error message received from 0000:00:1c.0
[    5.011557] pcieport 0000:00:1c.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
[    5.011561] pcieport 0000:00:1c.0:   device [8086:9d10] error status/mask=00000001/00002000
[    5.011565] pcieport 0000:00:1c.0:    [ 0] RxErr                  (First)
[    6.208890] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D0
[    6.208895] sdhci-pci 0000:00:1e.4: ACPI _REG connect evaluation failed (5)
[    6.271438] sdhci-pci 0000:00:1e.4: save config 0x00: 0x9d2b8086
[    6.271444] sdhci-pci 0000:00:1e.4: save config 0x04: 0x00100006
[    6.271448] sdhci-pci 0000:00:1e.4: save config 0x08: 0x08050121
[    6.271451] sdhci-pci 0000:00:1e.4: save config 0x0c: 0x00800010
[    6.271454] sdhci-pci 0000:00:1e.4: save config 0x10: 0xceec5004
[    6.271457] sdhci-pci 0000:00:1e.4: save config 0x14: 0x00000000
[    6.271461] sdhci-pci 0000:00:1e.4: save config 0x18: 0x00000000
[    6.271464] sdhci-pci 0000:00:1e.4: save config 0x1c: 0x00000000
[    6.271466] sdhci-pci 0000:00:1e.4: save config 0x20: 0x00000000
[    6.271469] sdhci-pci 0000:00:1e.4: save config 0x24: 0x00000000
[    6.271472] sdhci-pci 0000:00:1e.4: save config 0x28: 0x00000000
[    6.271475] sdhci-pci 0000:00:1e.4: save config 0x2c: 0x9d2b8086
[    6.271478] sdhci-pci 0000:00:1e.4: save config 0x30: 0x00000000
[    6.271481] sdhci-pci 0000:00:1e.4: save config 0x34: 0x00000080
[    6.271484] sdhci-pci 0000:00:1e.4: save config 0x38: 0x00000000
[    6.271487] sdhci-pci 0000:00:1e.4: save config 0x3c: 0x000002ff
[    6.271504] sdhci-pci 0000:00:1e.4: ACPI _REG disconnect evaluation failed (5)
[    6.271543] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D3hot
[    6.330355] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D0
[    6.330361] sdhci-pci 0000:00:1e.4: ACPI _REG connect evaluation failed (5)
[    6.444271] BTRFS: device label data devid 1 transid 97665 /dev/mapper/VolGroup00-root (253:1) scanned by mount (305)
[    6.444931] BTRFS info (device dm-1): first mount of filesystem 300f4e51-7c51-404c-96d9-1b224c97606d
[    6.444947] BTRFS info (device dm-1): using crc32c (crc32c-lib) checksum algorithm
[    6.482503] BTRFS info (device dm-1): enabling ssd optimizations
[    6.482511] BTRFS info (device dm-1): turning on async discard
[    6.482515] BTRFS info (device dm-1): enabling free space tree
[    6.762203] systemd[1]: systemd 258.1-1-arch running in system mode (+PAM +AUDIT -SELINUX +APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINIT +LIBARCHIVE)
[    6.762217] systemd[1]: Detected architecture x86-64.
[    6.763348] systemd[1]: Hostname set to <pixelbook>.
[    6.851105] systemd[1]: bpf-restrict-fs: Failed to load BPF object: No such process
[    7.154863] pcieport 0000:00:1c.0: AER: Multiple Correctable error message received from 0000:00:1c.0
[    7.154877] pcieport 0000:00:1c.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
[    7.154882] pcieport 0000:00:1c.0:   device [8086:9d10] error status/mask=00000001/00002000
[    7.154888] pcieport 0000:00:1c.0:    [ 0] RxErr                  (First)
[    7.400396] systemd[1]: Queued start job for default target Graphical Interface.
[    7.423080] systemd[1]: Created slice Slice /system/dirmngr.
[    7.423493] systemd[1]: Created slice Slice /system/getty.
[    7.423842] systemd[1]: Created slice Slice /system/gpg-agent.
[    7.424195] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    7.424569] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    7.424917] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    7.425265] systemd[1]: Created slice Slice /system/keyboxd.
[    7.425624] systemd[1]: Created slice Slice /system/modprobe.
[    7.425978] systemd[1]: Created slice Slice /system/systemd-fsck.
[    7.426243] systemd[1]: Created slice User and Session Slice.
[    7.426311] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    7.426365] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    7.426586] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    7.426610] systemd[1]: Expecting device /dev/disk/by-uuid/8178-5AD1...
[    7.426623] systemd[1]: Reached target Local Encrypted Volumes.
[    7.426644] systemd[1]: Reached target Image Downloads.
[    7.426654] systemd[1]: Reached target Local Integrity Protected Volumes.
[    7.426676] systemd[1]: Reached target Path Units.
[    7.426688] systemd[1]: Reached target Remote File Systems.
[    7.426700] systemd[1]: Reached target Slice Units.
[    7.426728] systemd[1]: Reached target Local Verity Protected Volumes.
[    7.426817] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    7.426904] systemd[1]: Listening on LVM2 poll daemon socket.
[    7.427853] systemd[1]: Listening on Query the User Interactively for a Password.
[    7.428932] systemd[1]: Listening on Process Core Dump Socket.
[    7.429572] systemd[1]: Listening on Credential Encryption/Decryption.
[    7.430465] systemd[1]: Listening on Factory Reset Management.
[    7.430586] systemd[1]: Listening on Journal Socket (/dev/log).
[    7.430686] systemd[1]: Listening on Journal Sockets.
[    7.431058] systemd[1]: TPM PCR Measurements was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    7.431081] systemd[1]: Make TPM PCR Policy was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    7.431176] systemd[1]: Listening on udev Control Socket.
[    7.431236] systemd[1]: Listening on udev Kernel Socket.
[    7.431308] systemd[1]: Listening on udev Varlink Socket.
[    7.431381] systemd[1]: Listening on User Database Manager Socket.
[    7.434141] systemd[1]: Mounting Huge Pages File System...
[    7.435302] systemd[1]: Mounting POSIX Message Queue File System...
[    7.436575] systemd[1]: Mounting Kernel Debug File System...
[    7.437709] systemd[1]: Mounting Kernel Trace File System...
[    7.448102] systemd[1]: Starting Create List of Static Device Nodes...
[    7.449493] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    7.449546] systemd[1]: Load Kernel Module configfs was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!configfs).
[    7.452871] systemd[1]: Mounting Kernel Configuration File System...
[    7.452947] systemd[1]: Load Kernel Module dm_mod was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!dm_mod).
[    7.453018] systemd[1]: Load Kernel Module drm was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!drm).
[    7.453080] systemd[1]: Load Kernel Module fuse was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!fuse).
[    7.456711] systemd[1]: Mounting FUSE Control File System...
[    7.459317] systemd[1]: Starting Load Kernel Module loop...
[    7.459416] systemd[1]: Clear Stale Hibernate Storage Info was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[    7.463098] systemd[1]: Starting Journal Service...
[    7.472144] systemd[1]: Starting Load Kernel Modules...
[    7.472179] systemd[1]: TPM PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    7.473644] systemd[1]: Starting Remount Root and Kernel File Systems...
[    7.473748] systemd[1]: Early TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    7.475074] systemd[1]: Starting Load udev Rules from Credentials...
[    7.477642] systemd[1]: Starting Coldplug All udev Devices...
[    7.484545] loop: module loaded
[    7.489742] systemd[1]: Mounted Huge Pages File System.
[    7.489960] systemd[1]: Mounted POSIX Message Queue File System.
[    7.490136] systemd[1]: Mounted Kernel Debug File System.
[    7.490300] systemd[1]: Mounted Kernel Trace File System.
[    7.494339] systemd[1]: Finished Create List of Static Device Nodes.
[    7.494686] systemd[1]: Mounted Kernel Configuration File System.
[    7.494846] systemd[1]: Mounted FUSE Control File System.
[    7.495168] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    7.495439] systemd[1]: Finished Load Kernel Module loop.
[    7.497454] systemd[1]: Repartition Root Disk was skipped because no trigger condition checks were met.
[    7.498635] systemd[1]: Starting Create Static Device Nodes in /dev gracefully...
[    7.501962] systemd[1]: Finished Load Kernel Modules.
[    7.506774] systemd[1]: Starting Apply Kernel Variables...
[    7.509152] systemd-journald[374]: Collecting audit messages is disabled.
[    7.513059] BTRFS info (device dm-1 state M): turning on sync discard
[    7.513067] BTRFS info (device dm-1 state M): enabling auto defrag
[    7.513071] BTRFS info (device dm-1 state M): use lzo compression, level 1
[    7.519134] systemd[1]: Finished Remount Root and Kernel File Systems.
[    7.519849] systemd[1]: Finished Load udev Rules from Credentials.
[    7.523087] systemd[1]: Activating swap /swap/swapfile...
[    7.524094] systemd[1]: Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
[    7.532408] systemd[1]: Starting Load/Save OS Random Seed...
[    7.532468] systemd[1]: TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    7.533155] systemd[1]: Finished Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling.
[    7.540775] Adding 2097148k swap on /swap/swapfile.  Priority:-2 extents:2 across:2228220k SS
[    7.541510] systemd[1]: Activated swap /swap/swapfile.
[    7.541906] systemd[1]: Reached target Swaps.
[    7.547621] systemd[1]: Finished Apply Kernel Variables.
[    7.558582] systemd[1]: Starting User Database Manager...
[    7.643533] systemd[1]: Started Journal Service.
[    7.678260] systemd-journald[374]: Received client request to flush runtime journal.
[    8.073484] pcieport 0000:00:1c.0: AER: Multiple Correctable error message received from 0000:00:1c.0
[    8.073504] pcieport 0000:00:1c.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
[    8.073519] pcieport 0000:00:1c.0:   device [8086:9d10] error status/mask=00000001/00002000
[    8.073528] pcieport 0000:00:1c.0:    [ 0] RxErr                  (First)
[    8.497451] sdhci-pci 0000:00:1e.4: save config 0x00: 0x9d2b8086
[    8.497461] sdhci-pci 0000:00:1e.4: save config 0x04: 0x00100006
[    8.497466] sdhci-pci 0000:00:1e.4: save config 0x08: 0x08050121
[    8.497470] sdhci-pci 0000:00:1e.4: save config 0x0c: 0x00800010
[    8.497475] sdhci-pci 0000:00:1e.4: save config 0x10: 0xceec5004
[    8.497479] sdhci-pci 0000:00:1e.4: save config 0x14: 0x00000000
[    8.497483] sdhci-pci 0000:00:1e.4: save config 0x18: 0x00000000
[    8.497487] sdhci-pci 0000:00:1e.4: save config 0x1c: 0x00000000
[    8.497490] sdhci-pci 0000:00:1e.4: save config 0x20: 0x00000000
[    8.497494] sdhci-pci 0000:00:1e.4: save config 0x24: 0x00000000
[    8.497498] sdhci-pci 0000:00:1e.4: save config 0x28: 0x00000000
[    8.497502] sdhci-pci 0000:00:1e.4: save config 0x2c: 0x9d2b8086
[    8.497506] sdhci-pci 0000:00:1e.4: save config 0x30: 0x00000000
[    8.497510] sdhci-pci 0000:00:1e.4: save config 0x34: 0x00000080
[    8.497514] sdhci-pci 0000:00:1e.4: save config 0x38: 0x00000000
[    8.497518] sdhci-pci 0000:00:1e.4: save config 0x3c: 0x000002ff
[    8.497544] sdhci-pci 0000:00:1e.4: ACPI _REG disconnect evaluation failed (5)
[    8.497608] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D3hot
[    8.530026] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D0
[    8.530037] sdhci-pci 0000:00:1e.4: ACPI _REG connect evaluation failed (5)
[    8.842479] cros_ec_lpcs GOOG0004:00: Chrome EC device registered
[    8.851303] intel_pmc_core INT33A1:00:  initialized
[    8.876689] pci 0000:00:04.0: save config 0x00: 0x19038086
[    8.876697] pci 0000:00:04.0: save config 0x04: 0x00900006
[    8.876701] pci 0000:00:04.0: save config 0x08: 0x11800002
[    8.876705] pci 0000:00:04.0: save config 0x0c: 0x00000000
[    8.876708] pci 0000:00:04.0: save config 0x10: 0xceed8004
[    8.876712] pci 0000:00:04.0: save config 0x14: 0x00000000
[    8.876715] pci 0000:00:04.0: save config 0x18: 0x00000000
[    8.876718] pci 0000:00:04.0: save config 0x1c: 0x00000000
[    8.876721] pci 0000:00:04.0: save config 0x20: 0x00000000
[    8.876724] pci 0000:00:04.0: save config 0x24: 0x00000000
[    8.876728] pci 0000:00:04.0: save config 0x28: 0x00000000
[    8.876731] pci 0000:00:04.0: save config 0x2c: 0x19038086
[    8.876734] pci 0000:00:04.0: save config 0x30: 0x00000000
[    8.876737] pci 0000:00:04.0: save config 0x34: 0x00000090
[    8.876741] pci 0000:00:04.0: save config 0x38: 0x00000000
[    8.876744] pci 0000:00:04.0: save config 0x3c: 0x000001ff
[    8.877738] input: Tablet Mode Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:06/PNP0C09:00/GOOG0004:00/GOOG0006:00/input/input4
[    8.878772] pci 0000:00:00.0: save config 0x00: 0x590c8086
[    8.878778] pci 0000:00:00.0: save config 0x04: 0x20900006
[    8.878781] pci 0000:00:00.0: save config 0x08: 0x06000002
[    8.878785] pci 0000:00:00.0: save config 0x0c: 0x00000000
[    8.878788] pci 0000:00:00.0: save config 0x10: 0x00000000
[    8.878792] pci 0000:00:00.0: save config 0x14: 0x00000000
[    8.878795] pci 0000:00:00.0: save config 0x18: 0x00000000
[    8.878798] pci 0000:00:00.0: save config 0x1c: 0x00000000
[    8.878801] pci 0000:00:00.0: save config 0x20: 0x00000000
[    8.878804] pci 0000:00:00.0: save config 0x24: 0x00000000
[    8.878807] pci 0000:00:00.0: save config 0x28: 0x00000000
[    8.878810] pci 0000:00:00.0: save config 0x2c: 0x590c8086
[    8.878813] pci 0000:00:00.0: save config 0x30: 0x00000000
[    8.878817] pci 0000:00:00.0: save config 0x34: 0x000000e0
[    8.878820] pci 0000:00:00.0: save config 0x38: 0x00000000
[    8.878823] pci 0000:00:00.0: save config 0x3c: 0x00000000
[    8.884236] pci 0000:00:14.2: save config 0x00: 0x9d318086
[    8.884245] pci 0000:00:14.2: save config 0x04: 0x00100006
[    8.884250] pci 0000:00:14.2: save config 0x08: 0x11800021
[    8.884255] pci 0000:00:14.2: save config 0x0c: 0x00000000
[    8.884259] pci 0000:00:14.2: save config 0x10: 0xceecf004
[    8.884264] pci 0000:00:14.2: save config 0x14: 0x00000000
[    8.884268] pci 0000:00:14.2: save config 0x18: 0x00000000
[    8.884273] pci 0000:00:14.2: save config 0x1c: 0x00000000
[    8.884277] pci 0000:00:14.2: save config 0x20: 0x00000000
[    8.884282] pci 0000:00:14.2: save config 0x24: 0x00000000
[    8.884286] pci 0000:00:14.2: save config 0x28: 0x00000000
[    8.884290] pci 0000:00:14.2: save config 0x2c: 0x9d318086
[    8.884295] pci 0000:00:14.2: save config 0x30: 0x00000000
[    8.884298] pci 0000:00:14.2: save config 0x34: 0x00000050
[    8.884302] pci 0000:00:14.2: save config 0x38: 0x00000000
[    8.884306] pci 0000:00:14.2: save config 0x3c: 0x000003ff
[    8.901236] pci 0000:00:1f.0: save config 0x00: 0x9d4b8086
[    8.901245] pci 0000:00:1f.0: save config 0x04: 0x00000407
[    8.901250] pci 0000:00:1f.0: save config 0x08: 0x06010021
[    8.901254] pci 0000:00:1f.0: save config 0x0c: 0x00800000
[    8.901259] pci 0000:00:1f.0: save config 0x10: 0x00000000
[    8.901264] pci 0000:00:1f.0: save config 0x14: 0x00000000
[    8.901269] pci 0000:00:1f.0: save config 0x18: 0x00000000
[    8.901273] pci 0000:00:1f.0: save config 0x1c: 0x00000000
[    8.901277] pci 0000:00:1f.0: save config 0x20: 0x00000000
[    8.901282] pci 0000:00:1f.0: save config 0x24: 0x00000000
[    8.901286] pci 0000:00:1f.0: save config 0x28: 0x00000000
[    8.901291] pci 0000:00:1f.0: save config 0x2c: 0x9d4b8086
[    8.901295] pci 0000:00:1f.0: save config 0x30: 0x00000000
[    8.901300] pci 0000:00:1f.0: save config 0x34: 0x00000000
[    8.901304] pci 0000:00:1f.0: save config 0x38: 0x00000000
[    8.901308] pci 0000:00:1f.0: save config 0x3c: 0x00000000
[    8.906196] pci 0000:00:1f.2: save config 0x00: 0x9d218086
[    8.906204] pci 0000:00:1f.2: save config 0x04: 0x00000006
[    8.906209] pci 0000:00:1f.2: save config 0x08: 0x05800021
[    8.906214] pci 0000:00:1f.2: save config 0x0c: 0x00800000
[    8.906218] pci 0000:00:1f.2: save config 0x10: 0xceed4000
[    8.906222] pci 0000:00:1f.2: save config 0x14: 0x00000000
[    8.906226] pci 0000:00:1f.2: save config 0x18: 0x00000000
[    8.906230] pci 0000:00:1f.2: save config 0x1c: 0x00000000
[    8.906234] pci 0000:00:1f.2: save config 0x20: 0x00000000
[    8.906238] pci 0000:00:1f.2: save config 0x24: 0x00000000
[    8.906242] pci 0000:00:1f.2: save config 0x28: 0x00000000
[    8.906246] pci 0000:00:1f.2: save config 0x2c: 0x9d218086
[    8.906250] pci 0000:00:1f.2: save config 0x30: 0x00000000
[    8.906253] pci 0000:00:1f.2: save config 0x34: 0x00000000
[    8.906257] pci 0000:00:1f.2: save config 0x38: 0x00000000
[    8.906261] pci 0000:00:1f.2: save config 0x3c: 0x00000000
[    8.908732] pci 0000:00:1f.4: save config 0x00: 0x9d238086
[    8.908741] pci 0000:00:1f.4: save config 0x04: 0x02800003
[    8.908747] pci 0000:00:1f.4: save config 0x08: 0x0c050021
[    8.908753] pci 0000:00:1f.4: save config 0x0c: 0x00000000
[    8.908758] pci 0000:00:1f.4: save config 0x10: 0xceec3004
[    8.908763] pci 0000:00:1f.4: save config 0x14: 0x00000000
[    8.908769] pci 0000:00:1f.4: save config 0x18: 0x00000000
[    8.908774] pci 0000:00:1f.4: save config 0x1c: 0x00000000
[    8.908779] pci 0000:00:1f.4: save config 0x20: 0x0000efa1
[    8.908784] pci 0000:00:1f.4: save config 0x24: 0x00000000
[    8.908789] pci 0000:00:1f.4: save config 0x28: 0x00000000
[    8.908794] pci 0000:00:1f.4: save config 0x2c: 0x9d238086
[    8.908799] pci 0000:00:1f.4: save config 0x30: 0x00000000
[    8.908804] pci 0000:00:1f.4: save config 0x34: 0x00000000
[    8.908810] pci 0000:00:1f.4: save config 0x38: 0x00000000
[    8.908815] pci 0000:00:1f.4: save config 0x3c: 0x000001ff
[    8.912415] intel_pch_thermal 0000:00:14.2: vgaarb: pci_notify
[    8.912424] intel_pch_thermal 0000:00:14.2: runtime IRQ mapping not provided by arch
[    8.923956] intel_pch_thermal 0000:00:14.2: vgaarb: pci_notify
[    8.933705] pci 0000:01:00.0: save config 0x00: 0x095a8086
[    8.933714] pci 0000:01:00.0: save config 0x04: 0x00100006
[    8.933720] pci 0000:01:00.0: save config 0x08: 0x028000b9
[    8.933725] pci 0000:01:00.0: save config 0x0c: 0x00000010
[    8.933730] pci 0000:01:00.0: save config 0x10: 0xcef00004
[    8.933736] pci 0000:01:00.0: save config 0x14: 0x00000000
[    8.933741] pci 0000:01:00.0: save config 0x18: 0x00000000
[    8.933746] pci 0000:01:00.0: save config 0x1c: 0x00000000
[    8.933751] pci 0000:01:00.0: save config 0x20: 0x00000000
[    8.933756] pci 0000:01:00.0: save config 0x24: 0x00000000
[    8.933761] pci 0000:01:00.0: save config 0x28: 0x00000000
[    8.933766] pci 0000:01:00.0: save config 0x2c: 0x9e108086
[    8.933771] pci 0000:01:00.0: save config 0x30: 0x00000000
[    8.933776] pci 0000:01:00.0: save config 0x34: 0x000000c8
[    8.933781] pci 0000:01:00.0: save config 0x38: 0x00000000
[    8.933786] pci 0000:01:00.0: save config 0x3c: 0x000001ff
[    8.973575] i801_smbus 0000:00:1f.4: vgaarb: pci_notify
[    8.973584] i801_smbus 0000:00:1f.4: runtime IRQ mapping not provided by arch
[    8.973826] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    8.973858] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    8.991970] pcieport 0000:00:1c.0: AER: Multiple Correctable error message received from 0000:00:1c.0
[    8.991979] pcieport 0000:00:1c.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
[    8.991983] pcieport 0000:00:1c.0:   device [8086:9d10] error status/mask=00000001/00002000
[    8.991987] pcieport 0000:00:1c.0:    [ 0] RxErr                  (First)
[    8.996647] intel-lpss 0000:00:15.0: vgaarb: pci_notify
[    8.996655] intel-lpss 0000:00:15.0: runtime IRQ mapping not provided by arch
[    8.997333] intel-lpss 0000:00:15.0: enabling Mem-Wr-Inval
[    8.998077] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    9.008100] intel-lpss 0000:00:15.0: vgaarb: pci_notify
[    9.008128] intel-lpss 0000:00:15.1: vgaarb: pci_notify
[    9.008137] intel-lpss 0000:00:15.1: runtime IRQ mapping not provided by arch
[    9.008305] intel-lpss 0000:00:15.1: enabling Mem-Wr-Inval
[    9.008534] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    9.025219] cr50_i2c i2c-GOOG0005:00: cr50 TPM 2.0 (i2c 0x50 irq 24 id 0x28)
[    9.070420] input: PC Speaker as /devices/platform/pcspkr/input/input5
[    9.153699] input: WCOM50C1:00 2D1F:5143 Touchscreen as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-7/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input6
[    9.154055] input: WCOM50C1:00 2D1F:5143 as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-7/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input7
[    9.154554] input: WCOM50C1:00 2D1F:5143 Stylus as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-7/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input8
[    9.154650] input: WCOM50C1:00 2D1F:5143 as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-7/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input9
[    9.154739] input: WCOM50C1:00 2D1F:5143 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-7/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input10
[    9.154847] hid-generic 0018:2D1F:5143.0001: input,hidraw0: I2C HID v1.00 Mouse [WCOM50C1:00 2D1F:5143] on i2c-WCOM50C1:00
[    9.165476] skl_uncore 0000:00:00.0: vgaarb: pci_notify
[    9.165485] skl_uncore 0000:00:00.0: runtime IRQ mapping not provided by arch
[    9.165606] skl_uncore 0000:00:00.0: vgaarb: pci_notify
[    9.167686] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    9.168043] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    9.168342] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    9.169925] faux_driver regulatory: Direct firmware load for regulatory.db failed with error -2
[    9.169930] cfg80211: failed to load regulatory.db
[    9.331697] intel-lpss 0000:00:15.1: vgaarb: pci_notify
[    9.331726] intel-lpss 0000:00:15.2: vgaarb: pci_notify
[    9.331734] intel-lpss 0000:00:15.2: runtime IRQ mapping not provided by arch
[    9.331878] intel-lpss 0000:00:15.2: enabling Mem-Wr-Inval
[    9.332091] idma64 idma64.2: Found Intel integrated DMA 64-bit
[    9.378445] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[    9.378464] i801_smbus 0000:00:1f.4: vgaarb: pci_notify
[    9.422475] sdhci-pci 0000:00:1e.4: save config 0x00: 0x9d2b8086
[    9.422480] sdhci-pci 0000:00:1e.4: save config 0x04: 0x00100006
[    9.422484] sdhci-pci 0000:00:1e.4: save config 0x08: 0x08050121
[    9.422487] sdhci-pci 0000:00:1e.4: save config 0x0c: 0x00800010
[    9.422490] sdhci-pci 0000:00:1e.4: save config 0x10: 0xceec5004
[    9.422493] sdhci-pci 0000:00:1e.4: save config 0x14: 0x00000000
[    9.422497] sdhci-pci 0000:00:1e.4: save config 0x18: 0x00000000
[    9.422499] sdhci-pci 0000:00:1e.4: save config 0x1c: 0x00000000
[    9.422502] sdhci-pci 0000:00:1e.4: save config 0x20: 0x00000000
[    9.422505] sdhci-pci 0000:00:1e.4: save config 0x24: 0x00000000
[    9.422508] sdhci-pci 0000:00:1e.4: save config 0x28: 0x00000000
[    9.422511] sdhci-pci 0000:00:1e.4: save config 0x2c: 0x9d2b8086
[    9.422514] sdhci-pci 0000:00:1e.4: save config 0x30: 0x00000000
[    9.422517] sdhci-pci 0000:00:1e.4: save config 0x34: 0x00000080
[    9.422520] sdhci-pci 0000:00:1e.4: save config 0x38: 0x00000000
[    9.422522] sdhci-pci 0000:00:1e.4: save config 0x3c: 0x000002ff
[    9.422544] sdhci-pci 0000:00:1e.4: ACPI _REG disconnect evaluation failed (5)
[    9.422589] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D3hot
[    9.438208] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D0
[    9.438214] sdhci-pci 0000:00:1e.4: ACPI _REG connect evaluation failed (5)
[    9.480684] input: ACPI0C50:00 18D1:5028 as /devices/pci0000:00/0000:00:15.2/i2c_designware.2/i2c-9/i2c-ACPI0C50:00/0018:18D1:5028.0002/input/input11
[    9.480773] hid-generic 0018:18D1:5028.0002: input,hidraw1: I2C HID v1.00 Device [ACPI0C50:00 18D1:5028] on i2c-ACPI0C50:00
[    9.482343] input: keyd virtual keyboard as /devices/virtual/input/input12
[    9.509865] input: keyd virtual pointer as /devices/virtual/input/input13
[    9.521786] spi-nor spi0.0: supply vcc not found, using dummy regulator
[    9.537413] Creating 1 MTD partitions on "0000:00:1f.5":
[    9.537420] 0x000000000000-0x000001000000 : "BIOS"
[    9.547305] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
[    9.547310] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    9.547312] RAPL PMU: hw unit of domain package 2^-14 Joules
[    9.547314] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    9.547316] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    9.547318] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    9.572723] iwlwifi 0000:01:00.0: vgaarb: pci_notify
[    9.572734] iwlwifi 0000:01:00.0: runtime IRQ mapping not provided by arch
[    9.575752] iwlwifi 0000:01:00.0: Detected crf-id 0x0, cnv-id 0x0 wfpm id 0x0
[    9.575765] iwlwifi 0000:01:00.0: PCI dev 095a/9e10, rev=0x210, rfid=0xd55555d5
[    9.575772] iwlwifi 0000:01:00.0: Detected Intel(R) Dual Band Wireless-AC 7265
[    9.576459] iwlwifi 0000:01:00.0: vgaarb: pci_notify
[    9.602490] iwlwifi 0000:01:00.0: Found debug destination: EXTERNAL_DRAM
[    9.602498] iwlwifi 0000:01:00.0: Found debug configuration: 0
[    9.605326] iwlwifi 0000:01:00.0: loaded firmware version 29.9ef079ed.0 7265D-29.ucode op_mode iwlmvm
[   10.219647] cros-ec-i2c i2c-GOOG0008:00: Chrome EC device registered
[   10.225480] intel-lpss 0000:00:15.2: vgaarb: pci_notify
[   10.225510] intel-lpss 0000:00:19.0: vgaarb: pci_notify
[   10.225517] intel-lpss 0000:00:19.0: runtime IRQ mapping not provided by arch
[   10.225684] intel-lpss 0000:00:19.0: enabling Mem-Wr-Inval
[   10.225949] intel-lpss 0000:00:19.0: save config 0x00: 0x9d668086
[   10.225954] intel-lpss 0000:00:19.0: save config 0x04: 0x00100006
[   10.225958] intel-lpss 0000:00:19.0: save config 0x08: 0x11800021
[   10.225962] intel-lpss 0000:00:19.0: save config 0x0c: 0x00800010
[   10.225966] intel-lpss 0000:00:19.0: save config 0x10: 0xfe030004
[   10.225970] intel-lpss 0000:00:19.0: save config 0x14: 0x00000000
[   10.225974] intel-lpss 0000:00:19.0: save config 0x18: 0xceeca004
[   10.225977] intel-lpss 0000:00:19.0: save config 0x1c: 0x00000000
[   10.225981] intel-lpss 0000:00:19.0: save config 0x20: 0x00000000
[   10.225985] intel-lpss 0000:00:19.0: save config 0x24: 0x00000000
[   10.225989] intel-lpss 0000:00:19.0: save config 0x28: 0x00000000
[   10.225993] intel-lpss 0000:00:19.0: save config 0x2c: 0x9d668086
[   10.225997] intel-lpss 0000:00:19.0: save config 0x30: 0x00000000
[   10.226001] intel-lpss 0000:00:19.0: save config 0x34: 0x00000080
[   10.226005] intel-lpss 0000:00:19.0: save config 0x38: 0x00000000
[   10.226008] intel-lpss 0000:00:19.0: save config 0x3c: 0x000001ff
[   10.226050] intel-lpss 0000:00:19.0: vgaarb: pci_notify
[   10.226074] intel-lpss 0000:00:19.2: vgaarb: pci_notify
[   10.226092] intel-lpss 0000:00:19.2: runtime IRQ mapping not provided by arch
[   10.226354] intel-lpss 0000:00:19.2: enabling Mem-Wr-Inval
[   10.276883] max98927 i2c-MX98927:00: MAX98927 revisionID: 0x42
[   10.279716] max98927 i2c-MX98927:01: MAX98927 revisionID: 0x42
[   10.279962] rt5663 i2c-10EC5663:00: supply avdd not found, using dummy regulator
[   10.279998] rt5663 i2c-10EC5663:00: supply cpvdd not found, using dummy regulator
[   10.290594] cros-ec-dev cros-ec-dev.2.auto: CrOS Touchpad MCU detected
[   10.290636] iTCO_vendor_support: vendor-support=0
[   10.316601] pps_core: LinuxPPS API ver. 1 registered
[   10.316605] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[   10.339158] PTP clock support registered
[   10.382966] proc_thermal 0000:00:04.0: vgaarb: pci_notify
[   10.382975] proc_thermal 0000:00:04.0: runtime IRQ mapping not provided by arch
[   10.386852] intel_rapl_common: Found RAPL domain package
[   10.386857] intel_rapl_common: Found RAPL domain dram
[   10.386935] proc_thermal 0000:00:04.0: vgaarb: pci_notify
[   10.407558] iwlwifi 0000:01:00.0: Applying debug destination EXTERNAL_DRAM
[   10.408184] iwlwifi 0000:01:00.0: Allocated 0x00400000 bytes for firmware monitor.
[   10.408945] snd_soc_avs 0000:00:1f.3: vgaarb: pci_notify
[   10.408953] snd_soc_avs 0000:00:1f.3: runtime IRQ mapping not provided by arch
[   10.413420] iwlwifi 0000:01:00.0: base HW address: __CENSORED__, OTP minor version: 0x0
[   10.413284] snd_soc_avs 0000:00:1f.3: bound 0000:00:02.0 (ops intel_audio_component_bind_ops [i915])
[   10.415252] snd_soc_avs 0000:00:1f.3: vgaarb: pci_notify
[   10.451123] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
[   10.456788] iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   10.456825] i801_smbus 0000:00:1f.4: save config 0x00: 0x9d238086
[   10.456832] i801_smbus 0000:00:1f.4: save config 0x04: 0x02800003
[   10.456837] i801_smbus 0000:00:1f.4: save config 0x08: 0x0c050021
[   10.456843] i801_smbus 0000:00:1f.4: save config 0x0c: 0x00000000
[   10.456848] i801_smbus 0000:00:1f.4: save config 0x10: 0xceec3004
[   10.456854] i801_smbus 0000:00:1f.4: save config 0x14: 0x00000000
[   10.456859] i801_smbus 0000:00:1f.4: save config 0x18: 0x00000000
[   10.456864] i801_smbus 0000:00:1f.4: save config 0x1c: 0x00000000
[   10.456870] i801_smbus 0000:00:1f.4: save config 0x20: 0x0000efa1
[   10.456875] i801_smbus 0000:00:1f.4: save config 0x24: 0x00000000
[   10.456880] i801_smbus 0000:00:1f.4: save config 0x28: 0x00000000
[   10.456885] i801_smbus 0000:00:1f.4: save config 0x2c: 0x9d238086
[   10.456891] i801_smbus 0000:00:1f.4: save config 0x30: 0x00000000
[   10.456896] i801_smbus 0000:00:1f.4: save config 0x34: 0x00000000
[   10.456901] i801_smbus 0000:00:1f.4: save config 0x38: 0x00000000
[   10.456906] i801_smbus 0000:00:1f.4: save config 0x3c: 0x000001ff
[   10.479561] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[   10.492389] intel_rapl_common: Found RAPL domain package
[   10.492394] intel_rapl_common: Found RAPL domain core
[   10.492396] intel_rapl_common: Found RAPL domain uncore
[   10.492398] intel_rapl_common: Found RAPL domain dram
[   10.492400] intel_rapl_common: Found RAPL domain psys
[   10.527658] mousedev: PS/2 mouse device common for all mice
[   10.559917] intel_tcc_cooling: Programmable TCC Offset detected
[   10.590002] cros-usbpd-charger cros-usbpd-charger.8.auto: Could not get charger port count
[   10.593939] ACPI: battery: new hook: cros-charge-control.7.auto
[   10.656713] iwlwifi 0000:01:00.0 wlp1s0: renamed from wlan0
[   10.669510] Bluetooth: Core ver 2.22
[   10.669544] NET: Registered PF_BLUETOOTH protocol family
[   10.669546] Bluetooth: HCI device and connection manager initialized
[   10.669551] Bluetooth: HCI socket layer initialized
[   10.669554] Bluetooth: L2CAP socket layer initialized
[   10.669559] Bluetooth: SCO socket layer initialized
[   10.679129] avs_max98927 avs_max98927.20.auto: ASoC: Parent card not yet available, widget card binding deferred
[   10.698294] iwlwifi 0000:01:00.0: Applying debug destination EXTERNAL_DRAM
[   10.734409] snd_hda_codec_intelhdmi hdaudioB0D2: creating for HDMI 0 0
[   10.734419] snd_hda_codec_intelhdmi hdaudioB0D2: skipping capture dai for HDMI 0
[   10.734423] snd_hda_codec_intelhdmi hdaudioB0D2: creating for HDMI 1 1
[   10.734427] snd_hda_codec_intelhdmi hdaudioB0D2: skipping capture dai for HDMI 1
[   10.734445] snd_hda_codec_intelhdmi hdaudioB0D2: creating for HDMI 2 2
[   10.734449] snd_hda_codec_intelhdmi hdaudioB0D2: skipping capture dai for HDMI 2
[   10.739687] avs_hdaudio avs_hdaudio.23.auto: ASoC: Parent card not yet available, widget card binding deferred
[   10.739854] avs_hdaudio avs_hdaudio.23.auto: avs_card_late_probe: mapping HDMI converter 1 to PCM 0 (000000009de419c8)
[   10.739869] avs_hdaudio avs_hdaudio.23.auto: avs_card_late_probe: mapping HDMI converter 2 to PCM 0 (00000000abe371b8)
[   10.739873] avs_hdaudio avs_hdaudio.23.auto: avs_card_late_probe: mapping HDMI converter 3 to PCM 0 (0000000003ceb040)
[   10.743543] avs_hdaudio avs_hdaudio.23.auto: control 3:0:0:ELD:0 is already present
[   10.743551] snd_hda_codec_intelhdmi hdaudioB0D2: unable to create controls -16
[   10.743555] avs_hdaudio avs_hdaudio.23.auto: ASoC error (-16): at snd_soc_card_late_probe() on AVS HDMI
[   10.743831] avs_hdaudio avs_hdaudio.23.auto: probe with driver avs_hdaudio failed with error -16
[   10.751481] usbcore: registered new interface driver btusb
[   10.758150] Bluetooth: hci0: Legacy ROM 2.x revision 5.0 build 25 week 20 2015
[   10.759949] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
[   10.775588] iwlwifi 0000:01:00.0: Applying debug destination EXTERNAL_DRAM
[   10.777493] iwlwifi 0000:01:00.0: FW already configured (0) - re-configuring
[   10.777992] gpio gpiochip2: Detected name collision for GPIO name 'EC:I2C1_SCL'
[   10.777998] gpio gpiochip2: Detected name collision for GPIO name 'EC:I2C1_SDA'
[   10.778004] gpio gpiochip2: Detected name collision for GPIO name 'EC:ENTERING_RW'
[   10.778008] gpio gpiochip2: Detected name collision for GPIO name 'EC:WP_L'
[   10.820616] iwlwifi 0000:01:00.0: Applying debug destination EXTERNAL_DRAM
[   10.874244] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   10.874251] Bluetooth: BNEP filters: protocol multicast
[   10.874256] Bluetooth: BNEP socket layer initialized
[   10.898005] iwlwifi 0000:01:00.0: Applying debug destination EXTERNAL_DRAM
[   10.899778] iwlwifi 0000:01:00.0: FW already configured (0) - re-configuring
[   10.904223] cros-ec-activity cros-ec-activity.29.auto: Unknown activity: 2
[   10.999176] mc: Linux media interface: v0.10
[   11.008144] Bluetooth: hci0: Intel BT fw patch 0x43 completed & activated
[   11.058365] videodev: Linux video capture interface: v2.00
[   11.064378] Bluetooth: MGMT ver 1.23
[   11.079816] NET: Registered PF_ALG protocol family
[   11.134238] uvcvideo 1-2:1.0: Found UVC 1.00 device WebCamera (0bda:564b)
[   11.138953] usbcore: registered new interface driver uvcvideo
[   11.295458] sdhci-pci 0000:00:1e.4: save config 0x00: 0x9d2b8086
[   11.295468] sdhci-pci 0000:00:1e.4: save config 0x04: 0x00100006
[   11.295473] sdhci-pci 0000:00:1e.4: save config 0x08: 0x08050121
[   11.295478] sdhci-pci 0000:00:1e.4: save config 0x0c: 0x00800010
[   11.295482] sdhci-pci 0000:00:1e.4: save config 0x10: 0xceec5004
[   11.295486] sdhci-pci 0000:00:1e.4: save config 0x14: 0x00000000
[   11.295490] sdhci-pci 0000:00:1e.4: save config 0x18: 0x00000000
[   11.295493] sdhci-pci 0000:00:1e.4: save config 0x1c: 0x00000000
[   11.295498] sdhci-pci 0000:00:1e.4: save config 0x20: 0x00000000
[   11.295502] sdhci-pci 0000:00:1e.4: save config 0x24: 0x00000000
[   11.295506] sdhci-pci 0000:00:1e.4: save config 0x28: 0x00000000
[   11.295510] sdhci-pci 0000:00:1e.4: save config 0x2c: 0x9d2b8086
[   11.295514] sdhci-pci 0000:00:1e.4: save config 0x30: 0x00000000
[   11.295518] sdhci-pci 0000:00:1e.4: save config 0x34: 0x00000080
[   11.295522] sdhci-pci 0000:00:1e.4: save config 0x38: 0x00000000
[   11.295526] sdhci-pci 0000:00:1e.4: save config 0x3c: 0x000002ff
[   11.295555] sdhci-pci 0000:00:1e.4: ACPI _REG disconnect evaluation failed (5)
[   11.295623] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D3hot
[   11.306458] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D0
[   11.306470] sdhci-pci 0000:00:1e.4: ACPI _REG connect evaluation failed (5)
[   11.332605] usbcore: registered new interface driver cdc_ether
[   11.396690] sdhci-pci 0000:00:1e.4: save config 0x00: 0x9d2b8086
[   11.396700] sdhci-pci 0000:00:1e.4: save config 0x04: 0x00100006
[   11.396705] sdhci-pci 0000:00:1e.4: save config 0x08: 0x08050121
[   11.396709] sdhci-pci 0000:00:1e.4: save config 0x0c: 0x00800010
[   11.396713] sdhci-pci 0000:00:1e.4: save config 0x10: 0xceec5004
[   11.396717] sdhci-pci 0000:00:1e.4: save config 0x14: 0x00000000
[   11.396721] sdhci-pci 0000:00:1e.4: save config 0x18: 0x00000000
[   11.396725] sdhci-pci 0000:00:1e.4: save config 0x1c: 0x00000000
[   11.396729] sdhci-pci 0000:00:1e.4: save config 0x20: 0x00000000
[   11.396732] sdhci-pci 0000:00:1e.4: save config 0x24: 0x00000000
[   11.396736] sdhci-pci 0000:00:1e.4: save config 0x28: 0x00000000
[   11.396740] sdhci-pci 0000:00:1e.4: save config 0x2c: 0x9d2b8086
[   11.396743] sdhci-pci 0000:00:1e.4: save config 0x30: 0x00000000
[   11.396747] sdhci-pci 0000:00:1e.4: save config 0x34: 0x00000080
[   11.396751] sdhci-pci 0000:00:1e.4: save config 0x38: 0x00000000
[   11.396755] sdhci-pci 0000:00:1e.4: save config 0x3c: 0x000002ff
[   11.396799] sdhci-pci 0000:00:1e.4: ACPI _REG disconnect evaluation failed (5)
[   11.396858] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D3hot
[   11.538080] cdc_ncm 2-2.4:2.0: MAC-Address: __CENSORED__
[   11.538091] cdc_ncm 2-2.4:2.0: setting rx_max = 16384
[   11.551250] cdc_ncm 2-2.4:2.0: setting tx_max = 16384
[   11.561605] cdc_ncm 2-2.4:2.0 eth0: register 'cdc_ncm' at usb-0000:00:14.0-2.4, CDC NCM (NO ZLP), __CENSORED__
[   11.572845] usbcore: registered new interface driver cdc_ncm
[   11.576313] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D0
[   11.576324] sdhci-pci 0000:00:1e.4: ACPI _REG connect evaluation failed (5)
[   11.587977] usbcore: registered new interface driver cdc_wdm
[   11.597103] usbcore: registered new interface driver cdc_mbim
[   11.602254] avs_rt5663 avs_rt5663.22.auto: ASoC: Parent card not yet available, widget card binding deferred
[   11.603561] rt5663 i2c-10EC5663:00: sysclk < 384 x fs, disable i2s asrc
[   11.603901] input: AVS I2S ALC5663 Headset Jack as /devices/platform/avs_rt5663.22.auto/sound/card2/input16
[   11.610692] cdc_ncm 2-2.4:2.0 enp0s20f0u2u4c2: renamed from eth0
[   11.616359] avs_rt5514 avs_rt5514.21.auto: ASoC: Parent card not yet available, widget card binding deferred
[   11.624428] intel-lpss 0000:00:19.2: vgaarb: pci_notify
[   11.624503] intel-lpss 0000:00:1e.0: vgaarb: pci_notify
[   11.624547] intel-lpss 0000:00:1e.0: runtime IRQ mapping not provided by arch
[   11.629953] intel-lpss 0000:00:1e.0: enabling Mem-Wr-Inval
[   11.632551] idma64 idma64.5: Found Intel integrated DMA 64-bit
[   11.632828] intel-lpss 0000:00:1e.0: save config 0x00: 0x9d278086
[   11.632842] intel-lpss 0000:00:1e.0: save config 0x04: 0x00100006
[   11.632850] intel-lpss 0000:00:1e.0: save config 0x08: 0x11800021
[   11.632858] intel-lpss 0000:00:1e.0: save config 0x0c: 0x00800010
[   11.632866] intel-lpss 0000:00:1e.0: save config 0x10: 0xceec8004
[   11.632874] intel-lpss 0000:00:1e.0: save config 0x14: 0x00000000
[   11.632882] intel-lpss 0000:00:1e.0: save config 0x18: 0xceec7004
[   11.632890] intel-lpss 0000:00:1e.0: save config 0x1c: 0x00000000
[   11.632897] intel-lpss 0000:00:1e.0: save config 0x20: 0x00000000
[   11.632904] intel-lpss 0000:00:1e.0: save config 0x24: 0x00000000
[   11.632911] intel-lpss 0000:00:1e.0: save config 0x28: 0x00000000
[   11.632918] intel-lpss 0000:00:1e.0: save config 0x2c: 0x9d278086
[   11.632925] intel-lpss 0000:00:1e.0: save config 0x30: 0x00000000
[   11.632932] intel-lpss 0000:00:1e.0: save config 0x34: 0x00000080
[   11.632939] intel-lpss 0000:00:1e.0: save config 0x38: 0x00000000
[   11.632946] intel-lpss 0000:00:1e.0: save config 0x3c: 0x000001ff
[   11.633026] intel-lpss 0000:00:1e.0: vgaarb: pci_notify
[   11.633062] intel-lpss 0000:00:1e.2: vgaarb: pci_notify
[   11.633074] intel-lpss 0000:00:1e.2: runtime IRQ mapping not provided by arch
[   11.633377] intel-lpss 0000:00:1e.2: enabling Mem-Wr-Inval
[   11.639572] idma64 idma64.6: Found Intel integrated DMA 64-bit
[   11.639782] intel-lpss 0000:00:1e.2: vgaarb: pci_notify
[   11.641545] intel-lpss 0000:00:1e.2: save config 0x00: 0x9d298086
[   11.641559] intel-lpss 0000:00:1e.2: save config 0x04: 0x00100006
[   11.641568] intel-lpss 0000:00:1e.2: save config 0x08: 0x11800021
[   11.641576] intel-lpss 0000:00:1e.2: save config 0x0c: 0x00800010
[   11.641583] intel-lpss 0000:00:1e.2: save config 0x10: 0xceec6004
[   11.641591] intel-lpss 0000:00:1e.2: save config 0x14: 0x00000000
[   11.641598] intel-lpss 0000:00:1e.2: save config 0x18: 0x00000000
[   11.641605] intel-lpss 0000:00:1e.2: save config 0x1c: 0x00000000
[   11.641612] intel-lpss 0000:00:1e.2: save config 0x20: 0x00000000
[   11.641619] intel-lpss 0000:00:1e.2: save config 0x24: 0x00000000
[   11.641626] intel-lpss 0000:00:1e.2: save config 0x28: 0x00000000
[   11.641632] intel-lpss 0000:00:1e.2: save config 0x2c: 0x9d298086
[   11.641640] intel-lpss 0000:00:1e.2: save config 0x30: 0x00000000
[   11.641649] intel-lpss 0000:00:1e.2: save config 0x34: 0x00000080
[   11.641657] intel-lpss 0000:00:1e.2: save config 0x38: 0x00000000
[   11.641665] intel-lpss 0000:00:1e.2: save config 0x3c: 0x000003ff
[   11.664474] sdhci-pci 0000:00:1e.4: save config 0x00: 0x9d2b8086
[   11.664490] sdhci-pci 0000:00:1e.4: save config 0x04: 0x00100006
[   11.664500] sdhci-pci 0000:00:1e.4: save config 0x08: 0x08050121
[   11.664510] sdhci-pci 0000:00:1e.4: save config 0x0c: 0x00800010
[   11.664518] sdhci-pci 0000:00:1e.4: save config 0x10: 0xceec5004
[   11.664526] sdhci-pci 0000:00:1e.4: save config 0x14: 0x00000000
[   11.664533] sdhci-pci 0000:00:1e.4: save config 0x18: 0x00000000
[   11.664540] sdhci-pci 0000:00:1e.4: save config 0x1c: 0x00000000
[   11.664547] sdhci-pci 0000:00:1e.4: save config 0x20: 0x00000000
[   11.664554] sdhci-pci 0000:00:1e.4: save config 0x24: 0x00000000
[   11.664560] sdhci-pci 0000:00:1e.4: save config 0x28: 0x00000000
[   11.664567] sdhci-pci 0000:00:1e.4: save config 0x2c: 0x9d2b8086
[   11.664574] sdhci-pci 0000:00:1e.4: save config 0x30: 0x00000000
[   11.664581] sdhci-pci 0000:00:1e.4: save config 0x34: 0x00000080
[   11.664588] sdhci-pci 0000:00:1e.4: save config 0x38: 0x00000000
[   11.664595] sdhci-pci 0000:00:1e.4: save config 0x3c: 0x000002ff
[   11.664632] sdhci-pci 0000:00:1e.4: ACPI _REG disconnect evaluation failed (5)
[   11.664742] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D3hot
[   11.680964] sdhci-pci 0000:00:1e.4: power state changed by ACPI to D0
[   11.680982] sdhci-pci 0000:00:1e.4: ACPI _REG connect evaluation failed (5)
[   11.734480] dw-apb-uart.3: ttyS4 at MMIO 0xfe030000 (irq = 32, base_baud = 115200) is a 16550A
[   11.734971] dw-apb-uart.5: ttyS5 at MMIO 0xceec8000 (irq = 20, base_baud = 7500000) is a 16550A
[   11.821895] input: WCOM50C1:00 2D1F:5143 as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-7/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input17
[   11.822358] input: WCOM50C1:00 2D1F:5143 UNKNOWN as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-7/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input18
[   11.822464] input: WCOM50C1:00 2D1F:5143 Stylus as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-7/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input19
[   11.822613] input: WCOM50C1:00 2D1F:5143 UNKNOWN as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-7/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input20
[   11.822734] input: WCOM50C1:00 2D1F:5143 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-7/i2c-WCOM50C1:00/0018:2D1F:5143.0001/input/input21
[   11.822947] hid-multitouch 0018:2D1F:5143.0001: input,hidraw0: I2C HID v1.00 Mouse [WCOM50C1:00 2D1F:5143] on i2c-WCOM50C1:00
[   11.835608] input: ACPI0C50:00 18D1:5028 as /devices/pci0000:00/0000:00:15.2/i2c_designware.2/i2c-9/i2c-ACPI0C50:00/0018:18D1:5028.0002/input/input22
[   11.835805] hid-multitouch 0018:18D1:5028.0002: input,hidraw1: I2C HID v1.00 Device [ACPI0C50:00 18D1:5028] on i2c-ACPI0C50:00
[   11.876620] iio iio:device4: Unknown activity: 2
[   11.876627] iio iio:device4: Unknown activity: 2
[   11.876631] iio iio:device4: Unknown activity: 2
[   11.876633] iio iio:device4: Unknown activity: 2
[   11.876636] iio iio:device4: Unknown activity: 2
[   11.876639] iio iio:device4: Unknown activity: 2
[   11.876642] iio iio:device4: Unknown activity: 2
[   11.876645] iio iio:device4: Unknown activity: 2
[   11.876647] iio iio:device4: Unknown activity: 2
[   11.876650] iio iio:device4: Unknown activity: 2
[   11.883620] apple 0005:05AC:0256.0003: unknown main item tag 0x0
[   11.883959] input: Apple Wireless Keyboard as /devices/virtual/misc/uhid/0005:05AC:0256.0003/input/input23
[   11.922204] apple 0005:05AC:0256.0003: input,hidraw2: BLUETOOTH HID v0.50 Keyboard [Apple Wireless Keyboard] on __CENSORED__
[   13.965915] wlp1s0: authenticate with __CENSORED__ (local address=__CENSORED__)
[   13.966819] wlp1s0: send auth to __CENSORED__ (try 1/3)
[   14.045452] wlp1s0: authenticate with __CENSORED__ (local address=__CENSORED__)
[   14.045468] wlp1s0: send auth to __CENSORED__ (try 1/3)
[   14.118078] wlp1s0: authenticated
[   14.119474] wlp1s0: associate with __CENSORED__ (try 1/3)
[   14.166054] wlp1s0: RX AssocResp from __CENSORED__ (capab=0x1931 status=0 aid=10)
[   14.176285] wlp1s0: associated
[   14.220782] wlp1s0: Limiting TX power to 30 (30 - 0) dBm as advertised by __CENSORED__
[   16.603977] input: MX Anywhere 3 Mouse as /devices/virtual/misc/uhid/0005:046D:B025.0004/input/input24
[   16.605649] hid-generic 0005:046D:B025.0004: input,hidraw3: BLUETOOTH HID v0.15 Mouse [MX Anywhere 3] on __CENSORED__
[   16.714902] input: Logitech MX Anywhere 3 as /devices/virtual/misc/uhid/0005:046D:B025.0004/input/input26
[   16.716230] logitech-hidpp-device 0005:046D:B025.0004: input,hidraw3: BLUETOOTH HID v0.15 Mouse [Logitech MX Anywhere 3] on __CENSORED__
[   16.737761] logitech-hidpp-device 0005:046D:B025.0004: HID++ 4.5 device connected.
[   20.092331] Bluetooth: RFCOMM TTY layer initialized
[   20.092345] Bluetooth: RFCOMM socket layer initialized
[   20.092350] Bluetooth: RFCOMM ver 1.11

--xpdscytg3qlwzotp--

