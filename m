Return-Path: <linux-pci+bounces-37531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE43BB650E
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 11:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 139B14EAFA9
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 09:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EA328643E;
	Fri,  3 Oct 2025 09:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="MGMzxOI6"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094A61E9B1C;
	Fri,  3 Oct 2025 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482410; cv=none; b=rIMn5gSwqZfPuFgykZYpUJBpx9mCKda3pqJomnT/KjZEaUSgrkmnf5v3aTOLvI2o219cVBNvPUoFNnxqcrcQR6JEBblPcAVfxJZWbGuXh/LJIx5fa6ctav2Jre/0Yx3i4n3pknO8Bd3H7aiDgvNkpX0A/wSa7bfIiHBpUkIiEvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482410; c=relaxed/simple;
	bh=Sk5cv03ktkOxmsjeIW0yNq34W1bhRxcfm2vUOJlm0k8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxTw2+YvuBaGNk/nvcWHtffP6tA235VQu87PE2GRL9Cn/eC21MARZuK627Kr+sG4Dg5mDgE5HUqf5KG9Ga+wF15UgkOfYsrYQ5lFCrDGH0C1xrt1mQyG02wOqxp62TfL+5Z+JMqL62YjrjMIjRHvbSvju6O6tnYzmIMGudm/AY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=MGMzxOI6; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759482409; x=1791018409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=si+G2wK775Ivi61pXTR8kUWgdomkX6hUkDZOI52TaOk=;
  b=MGMzxOI69WXgSqPi+DoTxJNVQqXFtIkGtFOfP/Km4eFSVk6/dyJiwdnm
   la8aLPiDIs5Lq9huvWZd5euT0RUEbVlN1eVbk6Sfg/XkFfhgElFWE616S
   X+BuReY6pVWDe06Bxx73DtHM2Vsm+DYYNz3EGtbDj+7Btd4A0Yvic9Kl2
   /syWk6ZbCeCuGUr8Z8xXg/vrktOPtstzC87ht7nr1WxKMzL8VVaM1Qobq
   r4sdXNKP/NAZU7SV1CLCsLWRR7j8CW7BBDu9iV0L29d7VDiZmAzjpF5rS
   bL6xL5gxRKSU67jT2oTsxiiz6tPvqCweJUZ+xKi8i4d1ey8w7JyhPWq/K
   A==;
X-CSE-ConnectionGUID: FAzMc7QmQ52PRN7aOvM0Xw==
X-CSE-MsgGUID: sH9cb2wESLy+JvGssX94Bw==
X-IronPort-AV: E=Sophos;i="6.18,312,1751241600"; 
   d="scan'208";a="4090680"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 09:06:48 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:63188]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.171:2525] with esmtp (Farcaster)
 id 3276e722-a2a3-40bc-8626-119d12cd5277; Fri, 3 Oct 2025 09:06:48 +0000 (UTC)
X-Farcaster-Flow-ID: 3276e722-a2a3-40bc-8626-119d12cd5277
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 3 Oct 2025 09:06:48 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 3 Oct 2025
 09:06:45 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson
	<alex.williamson@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, "Vipin
 Sharma" <vipinsh@google.com>, Chris Li <chrisl@kernel.org>, Jason Miu
	<jasonmiu@google.com>, Pratyush Yadav <pratyush@kernel.org>, "Stanislav
 Spassov" <stanspas@amazon.de>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>
Subject: [RFC PATCH 13/13] pci: pcsc: introduce hashtable lookup to speed up restoration
Date: Fri, 3 Oct 2025 09:00:49 +0000
Message-ID: <101c11154d1cdbb0910bb8468f2da150eac15600.1759312886.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759312886.git.epetron@amazon.de>
References: <cover.1759312886.git.epetron@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

During PCSC KHO (Kexec Handover) restoration, the current implementation
searches for each device's saved data by performing a linear traversal
through the FDT (Flattened Device Tree) nodes. This approach requires
examining every node until finding a match, resulting in O(n) complexity
per device lookup. On systems with thousands of PCI devices, this
becomes a significant bottleneck, as restoring all devices requires
O(n^2) operations in total.

This patch replaces the linear search with a hashtable that provides
O(1) lookup performance. During initialization, when KHO restore
data is detected, we build a hashtable by traversing the FDT once and
indexing all device nodes. Each device is keyed by a 32-bit value
combining its PCI domain (16 bits), bus number (8 bits), and device
function (8 bits), ensuring unique identification across the entire
PCI topology.

The hashtable uses 1024 buckets (PCSC_KHO_HASH_BITS=10).
As devices are successfully restored, their entries are removed from the
hashtable, progressively freeing memory. Once all devices have been
restored, the entire hashtable structure is cleaned up.

An additional optimization moves the version compatibility check from
per-device to a single global check during hashtable initialization.
This eliminates redundant version comparisons and simplifies the
restoration logic. Since the hashtable is built once during module
initialization and never modified during lookups, no locking is
required.

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---
 drivers/pci/pcsc.c | 244 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 205 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/pcsc.c b/drivers/pci/pcsc.c
index 8ff91ed24a37..43880b85b3f9 100644
--- a/drivers/pci/pcsc.c
+++ b/drivers/pci/pcsc.c
@@ -22,6 +22,7 @@
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
+#include <linux/hashtable.h>
 
 /* PCSC persistent data version - increment when the cacheability is changed */
 #define PCSC_PERSISTENT_VERSION 1U
@@ -755,8 +756,182 @@ static void infer_cacheability(struct pci_dev *dev)
 }
 
 #ifdef CONFIG_PCSC_KHO
+
+/*
+ * Hash table for O(1) device lookup during restore
+ * Size is chosen to handle systems with up to 4096 devices
+ */
+#define PCSC_KHO_HASH_BITS 10 /* 1024 buckets */
+static DEFINE_HASHTABLE(pcsc_kho_lookup_table, PCSC_KHO_HASH_BITS);
+
+struct pcsc_kho_lookup_entry {
+	struct hlist_node node;
+	u32 key; /* Hash of domain:bus:devfn */
+	int fdt_offset; /* Offset of this device's node in FDT */
+};
+
 static struct page *pcsc_kho_fdt;
 static int pcsc_kho_fdt_order;
+static bool pcsc_kho_lookup_initialized;
+static phys_addr_t pcsc_kho_fdt_phys;
+static const void *pcsc_kho_fdt_virt;
+static bool version_mismatch;
+static atomic_t pcsc_kho_hashtable_entries = ATOMIC_INIT(0);
+static u32 pcsc_kho_initial_hashtable_entries;
+#ifdef CONFIG_PCSC_STATS
+static u64 pcsc_kho_hashtable_build_time_ns;
+#endif
+
+static inline u32 pcsc_kho_device_key(u32 domain, u32 bus, u32 devfn)
+{
+	return (domain << 16) | (bus << 8) | devfn;
+}
+
+static int pcsc_kho_build_lookup_table(const void *fdt)
+{
+	int node;
+	u32 domain, bus, slot, func, devfn;
+	struct pcsc_kho_lookup_entry *entry;
+	u32 key;
+	int count = 0;
+
+	fdt_for_each_subnode(node, fdt, 0) {
+		const char *name = fdt_get_name(fdt, node, NULL);
+
+		if (!name)
+			continue;
+
+		if (sscanf(name, "dev_%x_%x_%x_%x", &domain, &bus, &slot,
+			   &func) != 4)
+			continue;
+
+		devfn = PCI_DEVFN(slot, func);
+		key = pcsc_kho_device_key(domain, bus, devfn);
+
+		entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+		if (!entry)
+			return -ENOMEM;
+
+		entry->key = key;
+		entry->fdt_offset = node;
+
+		hash_add(pcsc_kho_lookup_table, &entry->node, key);
+		count++;
+	}
+
+	atomic_set(&pcsc_kho_hashtable_entries, count);
+	pcsc_kho_initial_hashtable_entries = count;
+	pr_info("Built KHO lookup table with %d entries\n", count);
+	return 0;
+}
+
+static int pcsc_kho_init_lookup(void)
+{
+	int err, len;
+	const u32 *version_ptr;
+	u32 saved_version;
+#ifdef CONFIG_PCSC_STATS
+	ktime_t start_time, end_time;
+#endif
+
+	if (pcsc_kho_lookup_initialized)
+		return 0;
+
+#ifdef CONFIG_PCSC_STATS
+	start_time = ktime_get();
+#endif
+
+	err = kho_retrieve_subtree(PCSC_KHO_FDT, &pcsc_kho_fdt_phys);
+	if (err)
+		return err;
+
+	pcsc_kho_fdt_virt = phys_to_virt(pcsc_kho_fdt_phys);
+	if (fdt_node_check_compatible(pcsc_kho_fdt_virt, 0,
+				      PCSC_KHO_NODE_COMPATIBLE))
+		return -EINVAL;
+
+	/* Check version for all devices */
+	version_ptr = fdt_getprop(pcsc_kho_fdt_virt, 0, "pv", &len);
+	if (version_ptr && len == sizeof(*version_ptr)) {
+		saved_version = *version_ptr;
+		if (saved_version != PCSC_PERSISTENT_VERSION) {
+			version_mismatch = true;
+			pr_info("Version mismatch (saved=%u, current=%u), will re-infer cacheability\n",
+				saved_version, PCSC_PERSISTENT_VERSION);
+		}
+	} else {
+		/* No version found, assume version 0 */
+		version_mismatch = true;
+		pr_info("No version found in restored data, will re-infer cacheability\n");
+	}
+
+	err = pcsc_kho_build_lookup_table(pcsc_kho_fdt_virt);
+	if (err)
+		return err;
+
+#ifdef CONFIG_PCSC_STATS
+	end_time = ktime_get();
+	pcsc_kho_hashtable_build_time_ns =
+		ktime_to_ns(ktime_sub(end_time, start_time));
+#endif
+
+	pcsc_kho_lookup_initialized = true;
+	pr_info("KHO lookup table initialized in %llu us\n",
+#ifdef CONFIG_PCSC_STATS
+		pcsc_kho_hashtable_build_time_ns / 1000
+#else
+		0ULL
+#endif
+	);
+	return 0;
+}
+
+static int pcsc_kho_find_device_node(u32 domain, u32 bus, u32 devfn)
+{
+	u32 key = pcsc_kho_device_key(domain, bus, devfn);
+	struct pcsc_kho_lookup_entry *entry;
+	int offset = -1;
+
+	hash_for_each_possible(pcsc_kho_lookup_table, entry, node, key) {
+		if (entry->key == key) {
+			offset = entry->fdt_offset;
+			break;
+		}
+	}
+
+	return offset;
+}
+
+
+static void pcsc_kho_cleanup_hashtable(void)
+{
+	if (!pcsc_kho_lookup_initialized)
+		return;
+
+	pcsc_kho_lookup_initialized = false;
+	pr_info("KHO hashtable cleaned up - all devices restored\n");
+}
+
+static void pcsc_kho_remove_device_entry(u32 domain, u32 bus, u32 devfn)
+{
+	u32 key = pcsc_kho_device_key(domain, bus, devfn);
+	struct pcsc_kho_lookup_entry *entry;
+	struct hlist_node *tmp;
+
+	hash_for_each_possible_safe(pcsc_kho_lookup_table, entry, tmp, node,
+				    key) {
+		if (entry->key == key) {
+			hash_del(&entry->node);
+			kfree(entry);
+
+			if (atomic_dec_and_test(&pcsc_kho_hashtable_entries))
+				pcsc_kho_cleanup_hashtable();
+
+			break;
+		}
+	}
+}
+
 
 static int pcsc_kho_save_device(struct pci_dev *dev, void *fdt)
 {
@@ -998,56 +1173,31 @@ static bool pcsc_kho_restore_device(struct pci_dev *dev, const void *fdt,
 
 static bool pcsc_kho_check_restore(struct pci_dev *dev)
 {
-	phys_addr_t fdt_phys;
-	const void *fdt;
-	int node, err, len;
+	int node;
 	bool restored = false;
-	bool version_mismatch = false;
-	char node_name[32];
-	const u32 *version_ptr;
-	u32 saved_version;
+	u32 domain, bus_num;
 #ifdef CONFIG_PCSC_STATS
 	ktime_t start_time, end_time;
 	u64 duration_ns;
-#endif
 
-	err = kho_retrieve_subtree(PCSC_KHO_FDT, &fdt_phys);
-	if (err) {
-		pci_dbg(dev, "PCSC: kho_retrieve_subtree failed: %d\n", err);
-		return false;
-	}
+	start_time = ktime_get();
+#endif
 
-	fdt = phys_to_virt(fdt_phys);
-	if (fdt_node_check_compatible(fdt, 0, PCSC_KHO_NODE_COMPATIBLE)) {
-		pci_dbg(dev, "PCSC: FDT node not compatible\n");
+	if (!pcsc_kho_lookup_initialized)
 		return false;
-	}
 
-	version_ptr = fdt_getprop(fdt, 0, "pv", &len);
-	if (version_ptr && len == sizeof(*version_ptr)) {
-		saved_version = *version_ptr;
-		if (saved_version != PCSC_PERSISTENT_VERSION)
-			version_mismatch = true;
-
-	} else {
-		/* No version found, assume version 0 */
-		pci_info(
-			dev,
-			"PCSC: No version found in restored data. Re-infer Cacheability.\n");
-		version_mismatch = true;
-	}
+	domain = pci_domain_nr(dev->bus);
+	bus_num = dev->bus->number;
 
-#ifdef CONFIG_PCSC_STATS
-	start_time = ktime_get();
-#endif
+	node = pcsc_kho_find_device_node(domain, bus_num, dev->devfn);
 
-	snprintf(node_name, sizeof(node_name), "dev_%04x_%02x_%02x_%x",
-		 pci_domain_nr(dev->bus), dev->bus->number,
-		 PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+	if (node >= 0) {
+		restored = pcsc_kho_restore_device(dev, pcsc_kho_fdt_virt, node,
+						   version_mismatch);
 
-	node = fdt_subnode_offset(fdt, 0, node_name);
-	if (node >= 0)
-		restored = pcsc_kho_restore_device(dev, fdt, node, version_mismatch);
+		if (restored)
+			pcsc_kho_remove_device_entry(domain, bus_num, dev->devfn);
+	}
 
 #ifdef CONFIG_PCSC_STATS
 	if (restored) {
@@ -1056,6 +1206,9 @@ static bool pcsc_kho_check_restore(struct pci_dev *dev)
 
 		pcsc_stats.pcsc_kho_total_restore_time_ns += duration_ns;
 		pcsc_count_restored_devices();
+
+		pci_dbg(dev, "PCSC: Restored from KHO in %llu ns\n",
+			duration_ns);
 	}
 #endif
 
@@ -1498,6 +1651,11 @@ static ssize_t pcsc_stats_show(struct kobject *kobj,
 			     pcsc_stats.pcsc_kho_restored_device_count,
 			     total_restore_time_us);
 
+	ret += sysfs_emit_at(buf, ret,
+				"  Hashtable Initial Entries: %u\n"
+				"  Hashtable Build Time: %llu us\n",
+				pcsc_kho_initial_hashtable_entries,
+				pcsc_kho_hashtable_build_time_ns / 1000);
 #endif
 
 	return ret;
@@ -1573,6 +1731,14 @@ static int __init pcsc_init(void)
 			pr_info("KHO notifier registered successfully\n");
 		else
 			pr_err("Failed to register KHO notifier: %d\n", ret);
+
+		ret = pcsc_kho_init_lookup();
+		if (ret == 0)
+			pr_info("KHO lookup table initialized during init\n");
+		else if (ret == -ENOENT)
+			pr_info("No KHO saved data found - fresh boot\n");
+		else
+			pr_err("Failed to initialize KHO lookup table: %d\n", ret);
 	}
 #endif /* CONFIG_PCSC_KHO */
 
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


