Return-Path: <linux-pci+bounces-40605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE82C424DC
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 03:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4E518918C1
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 02:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B051E1DF0;
	Sat,  8 Nov 2025 02:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6LE4m8t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF2213E41A;
	Sat,  8 Nov 2025 02:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762569136; cv=none; b=tXOQXHSpBOz5r13Y4sZG088o3ecrdysBkgdI+jJacrKfmeOaFoLbhRu0/wWNB/3YoaWIXgbPwGg+KQNb+exTHum+RLM79VtQyUhHvt4siU3Rl+TgvHjEVqvEYITtnlRMIxsn4bVfTfcMtHSwneSDMkZyqWsGqYlpdj6RBTYgPAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762569136; c=relaxed/simple;
	bh=4PFSerajliqupS2a5xNYcPtqhGnAJHkxq6WyZeB8aCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CS/XJsgTl3S8zrhc7jTf3kwPMTZuVxRBGGnuwxfYINHNTTwwmkmpNDvI7PiHvnGSYKMTELglHA46AcHgTCtQNxjV0beqHKueGTQ+l5qW5THZrPfOMuk2m6gfBd+ey2UaOJS7kLaElZS165fDRnr+cYysx8++r55EHFiVk9x0MvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6LE4m8t; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762569135; x=1794105135;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4PFSerajliqupS2a5xNYcPtqhGnAJHkxq6WyZeB8aCY=;
  b=Z6LE4m8thy4O94xY8weCybuqN+UB6V9G6icySyNo5d0L1wHRgyYbETQm
   Q3L+0t2qFkOUIenQRQ/zdVK5llrkUCQ0ZzsbHOX2HbzF45aDtfVWgYIPx
   4yf5GNTsRKfCRE4jDCo4gNu2eeB/VL8cyebgnC3JPS5mw9nMoq/ufOdbd
   rZJlX40hkrTUwiWrmPWd8OteVs3BdZ1+l7c/AeprCeH7MPCe1aPTDCXfR
   FtoIkHNtQevkAOK3ZPTvY4FrxLs06UOW6MUMBLC6aKZNTVvdI0ukr3c/t
   AADrBMroSmgNqwYWPrrZXa3zOT9Lwt3TXjmtc7z0ZKzAz7nrwX5KqMwQ9
   g==;
X-CSE-ConnectionGUID: ghAHlHyDRLutOhQazH1WtQ==
X-CSE-MsgGUID: Ed1mESHDQv+YtOmTxK4L/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="64874046"
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="64874046"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 18:32:14 -0800
X-CSE-ConnectionGUID: CCbxNs0lS828VFxjak0q2g==
X-CSE-MsgGUID: TNf7zXetSx6PBYtu/7xDqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="193218027"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa004.fm.intel.com with ESMTP; 07 Nov 2025 18:32:12 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: dave.hansen@linux.intel.com,
	peterz@infradead.org
Cc: linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Balbir Singh <balbirs@nvidia.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: [PATCH] x86/kaslr: P2PDMA is one of a class of ZONE_DEVICE-KASLR collisions
Date: Fri,  7 Nov 2025 18:32:15 -0800
Message-ID: <20251108023215.2984031-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")
is too narrow. ZONE_DEVICE, in general, lets any physical address be added
to the direct-map. I.e. not only ACPI hotplug ranges, CXL Memory Windows,
or EFI Specific Purpose Memory, but also any PCI MMIO range for the
CONFIG_DEVICE_PRIVATE and CONFIG_PCI_P2PDMA cases.

A potential path to recover entropy would be to walk ACPI and determine the
limits for hotplug and PCI MMIO before kernel_randomize_memory(). On
smaller systems that could yield some KASLR address bits. This needs
additional investigation to determine if some limited ACPI table scanning
can happen this early without an open coded solution like
arch/x86/boot/compressed/acpi.c needs to deploy.

Cc: Balbir Singh <balbirs@nvidia.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Fixes: 7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/Kconfig |  6 ------
 mm/Kconfig          | 12 ++++++++----
 arch/x86/mm/kaslr.c | 10 +++++-----
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index f94f5d384362..47e466946bed 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -207,12 +207,6 @@ config PCI_P2PDMA
 	  P2P DMA transactions must be between devices behind the same root
 	  port.
 
-	  Enabling this option will reduce the entropy of x86 KASLR memory
-	  regions. For example - on a 46 bit system, the entropy goes down
-	  from 16 bits to 15 bits. The actual reduction in entropy depends
-	  on the physical address bits, on processor features, kernel config
-	  (5 level page table) and physical memory present on the system.
-
 	  If unsure, say N.
 
 config PCI_LABEL
diff --git a/mm/Kconfig b/mm/Kconfig
index 0e26f4fc8717..d17ebcc1a029 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1128,10 +1128,14 @@ config ZONE_DEVICE
 	  Device memory hotplug support allows for establishing pmem,
 	  or other device driver discovered memory regions, in the
 	  memmap. This allows pfn_to_page() lookups of otherwise
-	  "device-physical" addresses which is needed for using a DAX
-	  mapping in an O_DIRECT operation, among other things.
-
-	  If FS_DAX is enabled, then say Y.
+	  "device-physical" addresses which is needed for DAX, PCI_P2PDMA, and
+	  DEVICE_PRIVATE features among others.
+
+	  Enabling this option will reduce the entropy of x86 KASLR memory
+	  regions. For example - on a 46 bit system, the entropy goes down
+	  from 16 bits to 15 bits. The actual reduction in entropy depends
+	  on the physical address bits, on processor features, kernel config
+	  (5 level page table) and physical memory present on the system.
 
 #
 # Helpers to mirror range of the CPU page tables of a process into device page
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 3c306de52fd4..834641c6049a 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -115,12 +115,12 @@ void __init kernel_randomize_memory(void)
 
 	/*
 	 * Adapt physical memory region size based on available memory,
-	 * except when CONFIG_PCI_P2PDMA is enabled. P2PDMA exposes the
-	 * device BAR space assuming the direct map space is large enough
-	 * for creating a ZONE_DEVICE mapping in the direct map corresponding
-	 * to the physical BAR address.
+	 * except when CONFIG_ZONE_DEVICE is enabled. ZONE_DEVICE wants to map
+	 * any physical address into the direct-map. KASLR wants to reliably
+	 * steal some physical address bits. Those design choices are in direct
+	 * conflict.
 	 */
-	if (!IS_ENABLED(CONFIG_PCI_P2PDMA) && (memory_tb < kaslr_regions[0].size_tb))
+	if (!IS_ENABLED(CONFIG_ZONE_DEVICE) && (memory_tb < kaslr_regions[0].size_tb))
 		kaslr_regions[0].size_tb = memory_tb;
 
 	/*

base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
-- 
2.51.0


