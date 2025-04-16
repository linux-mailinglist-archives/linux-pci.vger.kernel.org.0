Return-Path: <linux-pci+bounces-25993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2CDA8B682
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 12:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32023189C145
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 10:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC2E23BCFD;
	Wed, 16 Apr 2025 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iz4uZJwT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8AC1990A7;
	Wed, 16 Apr 2025 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798414; cv=none; b=LQSJjrhAKFzNGV/kjhB5/UqHHFhIYBMv8k7uexcGh2nxxsyia7keOYSLLmcpHgTy4LuJ5deYNQOVI69LMZXu6oo7lG6mKdAIwB3wS1TApmFY94u5PRWx0EjzdTGM4q1uqtxXhKZFfEP0ofFNtCEkjoHFysfKDaJQBqHCf/HzBBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798414; c=relaxed/simple;
	bh=NOZosTZQNRLfIhdUigV6Uc2Ja/KVt8RifNjrdBYp0Dw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=P6zyE9N3D0UY67HHb8nxiNeSz6qvxYhbM2UkDnA6Iyj36DHMshxbRdQG+DLPS1vYz4Ylznrkppt1iBunTCJqg3s8YGTYyB8P4gETqlUW/zt+e6S8Y/SC2QDu8ThsdjCbvJraaJGt7fbswiiChPRdOq61mKWrr/wjzb8/7d//wu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iz4uZJwT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744798412; x=1776334412;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NOZosTZQNRLfIhdUigV6Uc2Ja/KVt8RifNjrdBYp0Dw=;
  b=Iz4uZJwT64DX21QIDWDLlxig8359YpJFKKYcAy30gaFevTx6sHQgQ8Tb
   MH9qxgPMEgwoI81vgSKPvNMEXMmd5P6dwsKHRlIjg2k3bhOBB3DskCsWx
   O9fVy/3I1/vfa0CBQkt5NeoE0Ek3a+S9JribWrBlfXNKVpwrhjd+90B7G
   zb8e3dPAYzAckhIEOJ/yFIOWvsL0lsKdR9VsWUNd6DlsU5whprRUk0GwJ
   WwSimSKG+WJqD7VVb4Xi3gP+lU1W9jBGnCW3OmbLzYKphgzKlSsrmt2dz
   ObzU0WuLNDJBedQhVXLQna5MVckhkfitn+pO7BcvINZnWL/58Bj6lR7dP
   Q==;
X-CSE-ConnectionGUID: 8RPiZPHORwK3uKtGYjynpw==
X-CSE-MsgGUID: k0QBDLP4QCWavfAyTEf3Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46464674"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="46464674"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 03:13:32 -0700
X-CSE-ConnectionGUID: wAylRwIKRnCNdOef4Kfm8A==
X-CSE-MsgGUID: ZjVBxL4nTLKEX8hWQrFHfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="135586616"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.243])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 03:13:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] x86: Use resource_set_{range,size}() helpers
Date: Wed, 16 Apr 2025 13:13:18 +0300
Message-Id: <20250416101318.7313-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert open coded resource size calculations to use
resource_set_{range,size}() helpers.

While at it, use SZ_* for size parameter which makes the intent of code
more obvious.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/x86/kernel/acpi/boot.c    | 4 ++--
 arch/x86/kernel/amd_nb.c       | 3 +--
 arch/x86/kernel/apic/apic.c    | 3 +--
 arch/x86/kernel/apic/io_apic.c | 3 +--
 arch/x86/kernel/probe_roms.c   | 3 +--
 arch/x86/pci/fixup.c           | 4 ++--
 arch/x86/pci/intel_mid_pci.c   | 2 +-
 7 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index dae6a73be40e..4490cbc01030 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -21,6 +21,7 @@
 #include <linux/pci.h>
 #include <linux/efi-bgrt.h>
 #include <linux/serial_core.h>
+#include <linux/sizes.h>
 #include <linux/pgtable.h>
 
 #include <asm/e820/api.h>
@@ -940,8 +941,7 @@ static int __init acpi_parse_hpet(struct acpi_table_header *table)
 	snprintf((char *)hpet_res->name, HPET_RESOURCE_NAME_SIZE, "HPET %u",
 		 hpet_tbl->sequence);
 
-	hpet_res->start = hpet_address;
-	hpet_res->end = hpet_address + (1 * 1024) - 1;
+	resource_set_range(hpet_res, hpet_address, SZ_1K);
 
 	return 0;
 }
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 6d12a9b69432..cba336dcb40d 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -164,8 +164,7 @@ struct resource *amd_get_mmconfig_range(struct resource *res)
 			 FAM10H_MMIO_CONF_BUSRANGE_MASK;
 
 	res->flags = IORESOURCE_MEM;
-	res->start = base;
-	res->end = base + (1ULL<<(segn_busn_bits + 20)) - 1;
+	resource_set_range(res, base, 1ULL << (segn_busn_bits + 20));
 	return res;
 }
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 62584a347931..efd3304ecbb3 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2640,8 +2640,7 @@ static int __init lapic_insert_resource(void)
 		return -1;
 
 	/* Put local APIC into the resource map. */
-	lapic_resource.start = apic_mmio_base;
-	lapic_resource.end = lapic_resource.start + PAGE_SIZE - 1;
+	resource_set_range(&lapic_resource, apic_mmio_base, PAGE_SIZE);
 	insert_resource(&iomem_resource, &lapic_resource);
 
 	return 0;
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index eebc360ed1bb..3069885d6421 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2571,8 +2571,7 @@ void __init io_apic_init_mappings(void)
 				__fix_to_virt(idx) + (ioapic_phys & ~PAGE_MASK), ioapic_phys);
 		idx++;
 
-		ioapic_res->start = ioapic_phys;
-		ioapic_res->end = ioapic_phys + IO_APIC_SLOT_SIZE - 1;
+		resource_set_range(ioapic_res, ioapic_phys, IO_APIC_SLOT_SIZE);
 		ioapic_res++;
 	}
 }
diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_roms.c
index cc2c34ba7228..44da85e50c44 100644
--- a/arch/x86/kernel/probe_roms.c
+++ b/arch/x86/kernel/probe_roms.c
@@ -260,8 +260,7 @@ void __init probe_roms(void)
 		if (!length || start + length > upper || !romchecksum(rom, length))
 			continue;
 
-		adapter_rom_resources[i].start = start;
-		adapter_rom_resources[i].end = start + length - 1;
+		resource_set_range(&adapter_rom_resources[i], start, length);
 		request_resource(&iomem_resource, &adapter_rom_resources[i]);
 
 		start = adapter_rom_resources[i++].end & ~2047UL;
diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index efefeb82ab61..94e98e3bf041 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/pci.h>
+#include <linux/sizes.h>
 #include <linux/suspend.h>
 #include <linux/vgaarb.h>
 #include <asm/amd_node.h>
@@ -347,8 +348,7 @@ static void pci_fixup_video(struct pci_dev *pdev)
 			if (res->parent)
 				release_resource(res);
 
-			res->start = 0xC0000;
-			res->end = res->start + 0x20000 - 1;
+			resource_set_range(res, 0xC0000, SZ_128K);
 			res->flags = IORESOURCE_MEM | IORESOURCE_ROM_SHADOW |
 				     IORESOURCE_PCI_FIXED;
 			dev_info(&pdev->dev, "Video device with shadowed ROM at %pR\n",
diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index b433b1753016..5e047e802d5d 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -399,7 +399,7 @@ static void pci_fixed_bar_fixup(struct pci_dev *dev)
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		pci_read_config_dword(dev, offset + 8 + (i * 4), &size);
-		dev->resource[i].end = dev->resource[i].start + size - 1;
+		resource_set_size(&dev->resource[i], size);
 		dev->resource[i].flags |= IORESOURCE_PCI_FIXED;
 	}
 }
-- 
2.39.5


