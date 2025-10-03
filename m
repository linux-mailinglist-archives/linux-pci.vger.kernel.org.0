Return-Path: <linux-pci+bounces-37525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3FBBB64CC
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 11:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D617F344B5D
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 09:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B1D28033C;
	Fri,  3 Oct 2025 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="oJOYB9T4"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75371D88D0;
	Fri,  3 Oct 2025 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482263; cv=none; b=o11o5v44cD/19E+1pkTjFF/4sBf/ygFGhD0iPDDLxmAOChecb8HcfHoGKpt+aCiKNPdc3P3q8Zggupp2A3FoBYvhskMG0SEbgHj9iIs5VcxptXryn7Nt29Jcn5FBknDuoQwcClLfE9lNKz3hp2cyI5+UtWj7WTC72aaHM54mosk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482263; c=relaxed/simple;
	bh=dIoo5Wn/TwilQe/1KY9uprCu5D7mZvUDyVyVfixKjRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n07dATntMXOe3D0t9FTa44gVTOAIC/GuZdEJpHF7Qi5bWL/Lf+KyhaNxJ8Y09YsK8doEprtGEeM9bUmll4r/D5IrRtZxd21DdTE6aLmHSLj14CSf07vDHVmKja+onj+xRPxbB2TSnWRZsidWyCOTgSMnBqy/iMs4Oma/A4cpvpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=oJOYB9T4; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759482261; x=1791018261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P9MVvP96kcAAq5QcR/4ak3wqiSOgfOY+p+dSjZVM698=;
  b=oJOYB9T4d/8mKYT0O/u7u8YCEn4/i4TcdCIBkBzs38dYZLYDU0NJVAh4
   Bl7gTPAzNCGyNm9nYPPdtQnd1mcaYoLzYvt7JJp8dyUKLdX/uFPQHc5gS
   choKP4OHvDEMSRuSMLbuHTHBXDo+N/pBTFIhp0hmBeFuvnXXojJYH5ITc
   YCV8Stl0YekOvRNLB4BJdJCED8gC+s5R/QNuWjVm5pFLrgompFYiEg7I5
   yVHtjElYexZhsKoJ5KIFHs79dvMpgqmvBxzn6Gf9hX76j7uihnt8XWdVW
   8xhKN4PG2bDkjUceJM8XgSMuhpzcH//NLU2qB/CmA2NTPJOj1G2qn1d1/
   w==;
X-CSE-ConnectionGUID: ZxfWATLIREerzXHQdn60hQ==
X-CSE-MsgGUID: UeR53ARTReqAwdtAycqv4Q==
X-IronPort-AV: E=Sophos;i="6.18,312,1751241600"; 
   d="scan'208";a="4024614"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 09:04:19 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:13370]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.156:2525] with esmtp (Farcaster)
 id 2d0a494a-5863-4724-ba7a-105b85049e1a; Fri, 3 Oct 2025 09:04:19 +0000 (UTC)
X-Farcaster-Flow-ID: 2d0a494a-5863-4724-ba7a-105b85049e1a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 3 Oct 2025 09:04:19 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 3 Oct 2025
 09:04:16 +0000
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
Subject: [RFC PATCH 07/13] pci: pcsc: introduce statistic gathering tools
Date: Fri, 3 Oct 2025 09:00:43 +0000
Message-ID: <762a6242ba9688aeb432c738e297cc8d039d0273.1759312886.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759312886.git.epetron@amazon.de>
References: <cover.1759312886.git.epetron@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Introduce optional statistics gathering for the PCI Configuration Space
Cache to measure cache effectiveness and performance impact.

When CONFIG_PCSC_STATS is enabled, the implementation tracks:
- Cache hits and misses
- Uncacheable reads
- Write operations and cache invalidations
- Total reads and hardware reads
- Time spent in cache vs hardware accesses
- Number of Device Resets

Statistics are exposed via /sys/bus/pci/pcsc/stats in a human-readable
format including calculated hit rates and access times in microseconds.

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---
 Documentation/ABI/testing/sysfs-bus-pci-pcsc |   9 +
 drivers/pci/Kconfig                          |   7 +
 drivers/pci/pcsc.c                           | 183 ++++++++++++++++++-
 3 files changed, 196 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-pcsc b/Documentation/ABI/testing/sysfs-bus-pci-pcsc
index ee92bf087816..daf0d06c89c8 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-pcsc
+++ b/Documentation/ABI/testing/sysfs-bus-pci-pcsc
@@ -18,3 +18,12 @@ Description:
 				is utilizing the cache, while when on "0" the
 				system bypasses it. This setting can also be controlled
 parameter.
+
+What:			/sys/bus/pci/pcsc/stats
+Date:			March 2025
+Contact:		Evangelos Petrongonas <epetron@amazon.de>
+Description:
+				PCI Configuration Space Cache (PCSC) if the PCSC
+				Statistics are enabled via the PCSC_STATS
+				configuration option, the statistics can be recovered
+				via reading this sysfs.
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index c26162b58365..9b5275ef2d16 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -50,6 +50,13 @@ config PCSC
 	  intercepts configuration space operations and maintains cached
 	  copies of register values
 
+config PCSC_STATS
+	bool "PCI Configuration Space Cache Statistics"
+	depends on PCSC
+	default n
+	help
+	  This option allows the collection of statistics for the PCSC.
+
 source "drivers/pci/pcie/Kconfig"
 
 config PCI_MSI
diff --git a/drivers/pci/pcsc.c b/drivers/pci/pcsc.c
index 5412dea23446..304239b7ff8a 100644
--- a/drivers/pci/pcsc.c
+++ b/drivers/pci/pcsc.c
@@ -25,9 +25,84 @@ static int __init pcsc_enabled_setup(char *str)
 }
 __setup("pcsc_enabled=", pcsc_enabled_setup);
 
+#ifdef CONFIG_PCSC_STATS
+struct pcsc_stats {
+	/* Operation Counters */
+	unsigned long cache_hits;
+	unsigned long cache_misses;
+	unsigned long uncachable_reads;
+	unsigned long writes;
+	unsigned long cache_invalidations;
+	unsigned long total_reads;
+	unsigned long hw_reads;
+	unsigned long device_resets;
+	u64 total_cache_access_time; /* in milliseconds */
+	u64 total_hw_access_time; /* in milliseconds */
+	u64 hw_access_time_due_to_misses; /* in milliseconds */
+};
+#endif
+
 static bool pcsc_initialised;
 static atomic_t num_nodes = ATOMIC_INIT(0);
 
+#ifdef CONFIG_PCSC_STATS
+struct pcsc_stats pcsc_stats;
+
+static inline void pcsc_count_cache_hit(void)
+{
+	pcsc_stats.cache_hits++;
+	pcsc_stats.total_reads++;
+}
+
+static inline void pcsc_count_cache_miss(void)
+{
+	pcsc_stats.cache_misses++;
+	pcsc_stats.total_reads++;
+	pcsc_stats.hw_reads++;
+}
+
+static inline void pcsc_count_uncachable_read(void)
+{
+	pcsc_stats.uncachable_reads++;
+	pcsc_stats.total_reads++;
+	pcsc_stats.hw_reads++;
+}
+
+static inline void pcsc_count_write(void)
+{
+	pcsc_stats.writes++;
+}
+
+static inline void pcsc_count_cache_invalidation(void)
+{
+	pcsc_stats.cache_invalidations++;
+}
+
+static inline void pcsc_count_device_reset(void)
+{
+	pcsc_stats.device_resets++;
+}
+#else
+static inline void pcsc_count_cache_hit(void)
+{
+}
+static inline void pcsc_count_cache_miss(void)
+{
+}
+static inline void pcsc_count_uncachable_read(void)
+{
+}
+static inline void pcsc_count_write(void)
+{
+}
+static inline void pcsc_count_cache_invalidation(void)
+{
+}
+static inline void pcsc_count_device_reset(void)
+{
+}
+#endif
+
 inline bool pcsc_is_initialised(void)
 {
 	return pcsc_initialised && pcsc_enabled;
@@ -727,6 +802,10 @@ static int pcsc_get_and_insert_multiple(struct pci_dev *dev,
 	u32 word_cached = 0;
 	u8 byte_val;
 	int rc, i;
+#ifdef CONFIG_PCSC_STATS
+	ktime_t start_time;
+	u64 duration;
+#endif
 
 	if (WARN_ON(!dev || !bus || !word))
 		return -EINVAL;
@@ -734,7 +813,6 @@ static int pcsc_get_and_insert_multiple(struct pci_dev *dev,
 	if (WARN_ON(size != 1 && size != 2 && size != 4))
 		return -EINVAL;
 
-	/* Check bounds */
 	if (where + size > PCSC_CFG_SPC_SIZE)
 		return -EINVAL;
 
@@ -746,8 +824,17 @@ static int pcsc_get_and_insert_multiple(struct pci_dev *dev,
 			pcsc_get_byte(dev, where + i, &byte_val);
 			word_cached |= ((u32)byte_val << (i * 8));
 		}
+		pcsc_count_cache_hit();
 	} else {
+#ifdef CONFIG_PCSC_STATS
+		start_time = ktime_get();
+#endif
 		rc = pcsc_hw_config_read(bus, devfn, where, size, &word_cached);
+#ifdef CONFIG_PCSC_STATS
+		duration = ktime_to_ns(ktime_sub(ktime_get(), start_time));
+		pcsc_stats.hw_access_time_due_to_misses += duration;
+		pcsc_stats.total_hw_access_time += duration;
+#endif
 		if (rc) {
 			pci_err(dev,
 				"%s: Failed to read CFG Space where=%d size=%d",
@@ -762,6 +849,7 @@ static int pcsc_get_and_insert_multiple(struct pci_dev *dev,
 			byte_val = (word_cached >> (i * 8)) & 0xFF;
 			pcsc_update_byte(dev, where + i, byte_val);
 		}
+		pcsc_count_cache_miss();
 	}
 
 	*word = word_cached;
@@ -773,6 +861,17 @@ int pcsc_cached_config_read(struct pci_bus *bus, unsigned int devfn, int where,
 {
 	int rc;
 	struct pci_dev *dev;
+#ifdef CONFIG_PCSC_STATS
+	ktime_t hw_start_time;
+	u64 hw_duration;
+#endif
+
+#ifdef CONFIG_PCSC_STATS
+	u64 duration;
+	ktime_t start_time;
+
+	start_time = ktime_get();
+#endif
 
 	if (unlikely(!pcsc_is_initialised()))
 		goto read_from_dev;
@@ -790,6 +889,10 @@ int pcsc_cached_config_read(struct pci_bus *bus, unsigned int devfn, int where,
 	    pcsc_is_access_cacheable(dev, where, size)) {
 		rc = pcsc_get_and_insert_multiple(dev, bus, devfn, where, val,
 						  size);
+#ifdef CONFIG_PCSC_STATS
+		duration = ktime_to_ns(ktime_sub(ktime_get(), start_time));
+		pcsc_stats.total_cache_access_time += duration;
+#endif
 		if (likely(!rc)) {
 			pci_dev_put(dev);
 			return 0;
@@ -797,11 +900,23 @@ int pcsc_cached_config_read(struct pci_bus *bus, unsigned int devfn, int where,
 		/* if reading from the cache failed continue and try reading
 		 * from the actual device
 		 */
+	} else {
+		if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL)
+			pcsc_count_uncachable_read();
 	}
 read_from_dev:
+#ifdef CONFIG_PCSC_STATS
+	hw_start_time = ktime_get();
+#endif
 	if (dev)
 		pci_dev_put(dev);
-	return pcsc_hw_config_read(bus, devfn, where, size, val);
+	rc = pcsc_hw_config_read(bus, devfn, where, size, val);
+#ifdef CONFIG_PCSC_STATS
+	hw_duration = ktime_to_ns(ktime_sub(ktime_get(), hw_start_time));
+	/* Add timing for uncacheable reads */
+	pcsc_stats.total_hw_access_time += hw_duration;
+#endif
+	return rc;
 }
 EXPORT_SYMBOL_GPL(pcsc_cached_config_read);
 
@@ -810,6 +925,11 @@ int pcsc_cached_config_write(struct pci_bus *bus, unsigned int devfn, int where,
 {
 	int i;
 	struct pci_dev *dev;
+	int rc;
+#ifdef CONFIG_PCSC_STATS
+	ktime_t hw_start_time;
+	u64 hw_duration;
+#endif
 
 	if (unlikely(!pcsc_is_initialised()))
 		goto write_to_dev;
@@ -828,12 +948,22 @@ int pcsc_cached_config_write(struct pci_bus *bus, unsigned int devfn, int where,
 		if (pcsc_is_access_cacheable(dev, where, size)) {
 			for (i = 0; i < size; i++)
 				pcsc_set_cached(dev, where + i, false);
+			pcsc_count_cache_invalidation();
 		}
 	}
 write_to_dev:
+	pcsc_count_write();
 	if (dev)
 		pci_dev_put(dev);
-	return pcsc_hw_config_write(bus, devfn, where, size, val);
+#ifdef CONFIG_PCSC_STATS
+	hw_start_time = ktime_get();
+#endif
+	rc = pcsc_hw_config_write(bus, devfn, where, size, val);
+#ifdef CONFIG_PCSC_STATS
+	hw_duration = ktime_to_ns(ktime_sub(ktime_get(), hw_start_time));
+	pcsc_stats.total_hw_access_time += hw_duration;
+#endif
+	return rc;
 }
 EXPORT_SYMBOL_GPL(pcsc_cached_config_write);
 
@@ -851,6 +981,7 @@ int pcsc_device_reset(struct pci_dev *dev)
 	 * some of the HWInt values that are going to remain constant after a reset.
 	 */
 	bitmap_zero(dev->pcsc->cached_bitmask, PCSC_CFG_SPC_SIZE);
+	pcsc_count_device_reset();
 	return 0;
 }
 
@@ -948,8 +1079,50 @@ static ssize_t pcsc_enabled_store(struct kobject *kobj,
 static struct kobj_attribute pcsc_enabled_attribute =
 	__ATTR(enabled, 0644, pcsc_enabled_show, pcsc_enabled_store);
 
+#ifdef CONFIG_PCSC_STATS
+static ssize_t pcsc_stats_show(struct kobject *kobj,
+			       struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(
+		buf,
+		"Cache Hits: %lu\n"
+		"Cache Misses: %lu\n"
+		"Uncachable Reads: %lu\n"
+		"Writes: %lu\n"
+		"Cache Invalidations: %lu\n"
+		"Device Resets: %lu\n"
+		"Total Reads: %lu\n"
+		"Hardware Reads: %lu\n"
+		"Hit Rate: %lu%%\n"
+		"Total Cache Access Time: %llu us\n"
+		"Cache Access Time (without HW reads due to Misses): %llu us\n"
+		"HW Access Time due to misses: %llu us\n"
+		"Total Hardware Access Time: %llu us\n",
+		pcsc_stats.cache_hits, pcsc_stats.cache_misses,
+		pcsc_stats.uncachable_reads, pcsc_stats.writes,
+		pcsc_stats.cache_invalidations, pcsc_stats.device_resets,
+		pcsc_stats.total_reads,
+		pcsc_stats.hw_reads,
+		pcsc_stats.total_reads ?
+			      (pcsc_stats.cache_hits * 100) / pcsc_stats.total_reads :
+			      0,
+		pcsc_stats.total_cache_access_time / 1000,
+		(pcsc_stats.total_cache_access_time -
+		 pcsc_stats.hw_access_time_due_to_misses) /
+			1000,
+		pcsc_stats.hw_access_time_due_to_misses / 1000,
+		pcsc_stats.total_hw_access_time / 1000);
+}
+
+static struct kobj_attribute pcsc_stats_attribute =
+	__ATTR(stats, 0444, pcsc_stats_show, NULL);
+#endif
+
 static struct attribute *pcsc_attrs[] = {
 	&pcsc_enabled_attribute.attr,
+#ifdef CONFIG_PCSC_STATS
+	&pcsc_stats_attribute.attr,
+#endif
 	NULL,
 };
 
@@ -995,6 +1168,10 @@ static int __init pcsc_init(void)
 	/* Try to create sysfs entry, but don't fail if PCI bus isn't ready yet */
 	pcsc_create_sysfs();
 
+#ifdef CONFIG_PCSC_STATS
+	memset(&pcsc_stats, 0, sizeof(pcsc_stats));
+#endif
+
 	pcsc_initialised = true;
 	pr_info("initialised (enabled=%d)\n", pcsc_enabled);
 
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


