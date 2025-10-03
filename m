Return-Path: <linux-pci+bounces-37529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFCCBB651D
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 11:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9643B3826
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 09:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26016287513;
	Fri,  3 Oct 2025 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="D08sQR5B"
X-Original-To: linux-pci@vger.kernel.org
Received: from iad-out-015.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-015.esa.us-east-1.outbound.mail-perimeter.amazon.com [44.210.169.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C29C1D88D0;
	Fri,  3 Oct 2025 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.210.169.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482366; cv=none; b=HWYitk9QzA5bZO3NTY4CKywoB626DCHXNZhfQRaaKGLLo4U7WqyDHAUh5Kplxr4nCBFdmeahJi3DwSLVsgH7V/LaL7/2nqeQSrrgJ8mQ0CJl+r6UxH/5i3gh6L5fFOKLJDFVL9EbG6dXCCJGq4Dcl0c6hRMZ1Wjuo7g4OSCcSpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482366; c=relaxed/simple;
	bh=793WX9TaObVcbPm3DXqnAdkl4B1gGi6PvrRcBDqGyaw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEvEall0QcNTf7C1PGBgfVXr9hnfMFniBAJocC69AGuHNibbX9NSS2nPLXHbHzzhJGF4NAz3xECK8G5tdWMevrhLK35UESjQDKSvPA1dFvLAEoDk5nuslxNhzhxc7t9wOZlm0pELldgALCvd0wjHiVx6RRk/Tm1LV+mev387wCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=D08sQR5B; arc=none smtp.client-ip=44.210.169.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759482363; x=1791018363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gVBdbL52QjJ3u23Yr50KnrHvSCrn7ewWkkBMTFZNU48=;
  b=D08sQR5Bkz8+JznhJ+oHibJDS4g1qiML9/7jOzws2L+iXYY8h2WcXwQS
   HFjq62GVIXzXF2k3Cq751fzUSbpsbXWcGLXnUsmJqBgPz0wSWIAcG7OcS
   Hbvmvl4yM7O/d06/VOd83e/2mBmd0LxUY0d630ok6KU28VAiBD5Tjo8wl
   gro5sa8XK2b01xRLaUl4XU7mD/uNleNRUw5Nofel4U77L662AE7MrK6ha
   S6nf1ZCy9Y069jIezUpUGQIhLc3OKSOmiIaJdEuHjaJgG7anAtjkYEQ2u
   7yC4g+ERaBc2XwI6Z99kPg01s3KrDyPVsFAnbix7YdAIrBkRf9sTKDxfI
   w==;
X-CSE-ConnectionGUID: tY20QcJhT+yf6CnAGtJfEw==
X-CSE-MsgGUID: 2ClKXQIBRPuNitUyBBVQXQ==
X-IronPort-AV: E=Sophos;i="6.18,312,1751241600"; 
   d="scan'208";a="3274622"
Received: from ip-10-4-10-75.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.10.75])
  by internal-iad-out-015.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 09:06:00 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:49226]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.233:2525] with esmtp (Farcaster)
 id 3fb372fc-dc48-429a-866d-7527114cfbd0; Fri, 3 Oct 2025 09:06:00 +0000 (UTC)
X-Farcaster-Flow-ID: 3fb372fc-dc48-429a-866d-7527114cfbd0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 3 Oct 2025 09:06:00 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 3 Oct 2025
 09:05:57 +0000
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
Subject: [RFC PATCH 11/13] pci: pcsc: Add kexec persistence support via KHO
Date: Fri, 3 Oct 2025 09:00:47 +0000
Message-ID: <c0d251fa9688503e2975bf47b713aa85d62f95a8.1759312886.git.epetron@amazon.de>
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

Add support for preserving PCI Configuration Space Cache (PCSC) data
across kexec operations using the Kexec Handover (KHO) framework. This
allows the cached PCI configuration data to survive kexec, eliminating
the need to re-probe PCI configuration space after kexec, which can
significantly reduce boot time on systems with many PCI devices.

To enable PCSC persistence, the kernel must be built with
CONFIG_PCSC_KHO enabled, which depends on both `CONFIG_PCSC` and
`CONFIG_KEXEC_HANDOVER`. When enabled, persistence can be controlled at
runtime using the 'pcsc_persistence_enabled' kernel parameter. By
default, persistence is disabled, but it can be enabled by passing
'pcsc_persistence_enabled=0' on the kernel command line.

During kexec preparation, the implementation iterates through all PCI
devices and saves the PCSC data for endpoint devices (header type 0). It
creates a Flattened Device Tree (FDT) structure containing device
information and physical addresses of the preserved data. The physical
memory pages containing PCSC data are preserved through KHO, and the FDT
is added to the KHO tree for the new kernel to discover.

After kexec, during PCI device initialization, the implementation checks
if KHO data is available for each device being initialized. If found, it
restores the cached configuration space data, avoiding the need to
re-probe the device. The implementation tracks timing statistics to
measure the performance benefits of this optimization.

Performance metrics are collected and reported, showing both the time
taken to save devices during kexec and the time saved during restore in
the new kernel. This helps quantify the boot time improvements.

The implementation handles error cases gracefully, falling back to
normal PCSC initialization if KHO data is not available or corrupted.
This ensures that the system remains functional even if persistence
cannot be achieved.

The time complexity of this implementation is O(n^2), where n is the
number of restored devices, as for every device the FDT needs to be
traversed again. This will be improved in a future patch

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---
 .../admin-guide/kernel-parameters.txt         |   4 +
 drivers/pci/Kconfig                           |  10 +
 drivers/pci/pcsc.c                            | 389 +++++++++++++++++-
 3 files changed, 386 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 08c7a13f107c..39f71e27df2d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5039,6 +5039,10 @@
 	pcsc_enabled=	[PCSC] enable the use of the PCI Configuration Space
 		Cache (PCSC).
 
+	pcsc_persistence_enabled=	[PCSC] enable the persistence over kexec
+		using KHO of the PCI Configuration Space Cache Data. For more
+		information seen drivers/pci/pcsc.c
+
 	pd_ignore_unused
 			[PM]
 			Keep all power-domains already enabled by bootloader on,
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 9b5275ef2d16..0eb189ad526b 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -57,6 +57,16 @@ config PCSC_STATS
 	help
 	  This option allows the collection of statistics for the PCSC.
 
+config PCSC_KHO
+	bool "PCI Configuration Space Cache persist data over kexec"
+	depends on PCSC
+	depends on KEXEC_HANDOVER
+	default n
+	help
+		This option enables the persistence of the cache data over kexec
+		using Kexec Handover KHO. For more information, check
+		`drivers/pci/pcsc.c'
+
 source "drivers/pci/pcie/Kconfig"
 
 config PCI_MSI
diff --git a/drivers/pci/pcsc.c b/drivers/pci/pcsc.c
index 18d508f76649..0c4ae73744d6 100644
--- a/drivers/pci/pcsc.c
+++ b/drivers/pci/pcsc.c
@@ -17,6 +17,11 @@
 #include <linux/atomic.h>
 #include <linux/pcsc.h>
 #include <linux/sysfs.h>
+#include <linux/kexec_handover.h>
+#include <linux/libfdt.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
 
 static bool pcsc_enabled;
 static int __init pcsc_enabled_setup(char *str)
@@ -25,6 +30,16 @@ static int __init pcsc_enabled_setup(char *str)
 }
 __setup("pcsc_enabled=", pcsc_enabled_setup);
 
+static bool pcsc_persistence_enabled;
+static int __init pcsc_persistence_enabled_setup(char *str)
+{
+	return kstrtobool(str, &pcsc_persistence_enabled) == 0;
+}
+__setup("pcsc_persistence_enabled=", pcsc_persistence_enabled_setup);
+
+#define PCSC_KHO_FDT "pcsc"
+#define PCSC_KHO_NODE_COMPATIBLE "pcsc-v1"
+
 #ifdef CONFIG_PCSC_STATS
 struct pcsc_stats {
 	/* Operation Counters */
@@ -39,6 +54,10 @@ struct pcsc_stats {
 	u64 total_cache_access_time; /* in milliseconds */
 	u64 total_hw_access_time; /* in milliseconds */
 	u64 hw_access_time_due_to_misses; /* in milliseconds */
+#ifdef CONFIG_PCSC_KHO
+	u64 pcsc_kho_total_restore_time_ns;
+	u32 pcsc_kho_restored_device_count;
+#endif
 };
 #endif
 
@@ -82,6 +101,12 @@ static inline void pcsc_count_device_reset(void)
 {
 	pcsc_stats.device_resets++;
 }
+#ifdef CONFIG_PCSC_KHO
+static inline void pcsc_count_restored_devices(void)
+{
+	pcsc_stats.pcsc_kho_restored_device_count++;
+}
+#endif
 #else
 static inline void pcsc_count_cache_hit(void)
 {
@@ -101,6 +126,11 @@ static inline void pcsc_count_cache_invalidation(void)
 static inline void pcsc_count_device_reset(void)
 {
 }
+#ifdef CONFIG_PCSC_KHO
+static inline void pcsc_count_restored_devices(void)
+{
+}
+#endif
 #endif
 
 inline bool pcsc_is_initialised(void)
@@ -721,6 +751,288 @@ static void infer_cacheability(struct pci_dev *dev)
 	}
 }
 
+#ifdef CONFIG_PCSC_KHO
+static struct page *pcsc_kho_fdt;
+static int pcsc_kho_fdt_order;
+
+static int pcsc_kho_save_device(struct pci_dev *dev, void *fdt)
+{
+	char node_name[32];
+	size_t data_size, total_size;
+	u64 data_addr;
+	int err = 0;
+
+	if (!dev->pcsc || !dev->pcsc->data)
+		return 1;
+
+	if (dev->hdr_type != PCI_HEADER_TYPE_NORMAL)
+		return 1;
+
+	/* Create FDT node for this device - node name contains device identifer */
+	snprintf(node_name, sizeof(node_name), "dev_%04x_%02x_%02x_%x",
+		 pci_domain_nr(dev->bus), dev->bus->number,
+		 PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+
+	err = fdt_begin_node(fdt, node_name);
+	if (err) {
+		pci_err(dev, "PCSC: Failed to begin FDT node '%s': %d\n",
+			node_name, err);
+		return err;
+	}
+
+	data_size = sizeof(struct pcsc_data);
+	total_size = PAGE_ALIGN(data_size);
+
+	data_addr = virt_to_phys(dev->pcsc->data);
+	err = kho_preserve_phys(data_addr, total_size);
+	if (err) {
+		pci_err(dev, "PCSC: Failed to preserve data buffer: %d\n", err);
+		return err;
+	}
+
+	err = fdt_property(fdt, "da", &data_addr, sizeof(data_addr));
+	if (err) {
+		pci_err(dev, "PCSC: Failed to set da property: %d\n",
+			err);
+		return err;
+	}
+
+	err = fdt_end_node(fdt);
+	if (err) {
+		pci_err(dev, "PCSC: Failed to end FDT node: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int pcsc_kho_notifier(struct notifier_block *self, unsigned long cmd,
+			     void *v)
+{
+	struct kho_serialization *ser = v;
+	struct pci_dev *dev = NULL;
+	void *fdt;
+	int err = 0;
+	size_t fdt_size;
+	u32 dev_count = 0;
+	u32 eligible_count = 0;
+	u32 saved_count = 0;
+	u32 skipped_count = 0;
+
+	switch (cmd) {
+	case KEXEC_KHO_ABORT:
+		if (pcsc_kho_fdt) {
+			__free_pages(pcsc_kho_fdt, pcsc_kho_fdt_order);
+			pcsc_kho_fdt = NULL;
+		}
+		return NOTIFY_DONE;
+	case KEXEC_KHO_FINALIZE:
+		/* Handled below */
+		break;
+	default:
+		return NOTIFY_BAD;
+	}
+
+#ifdef CONFIG_PCSC_STATS
+	ktime_t start_time = ktime_get();
+#endif
+
+	for_each_pci_dev(dev) {
+		dev_count++;
+		if (dev->pcsc && dev->pcsc->cfg_space &&
+		    dev->hdr_type == PCI_HEADER_TYPE_NORMAL)
+			eligible_count++;
+	}
+
+	pr_info("Total PCI devices: %u, eligible for save: %u\n",
+		dev_count, eligible_count);
+
+	if (eligible_count == 0)
+		return NOTIFY_DONE;
+
+	/* Allocate FDT with size calculation (conservative estimates):
+	 * - Per device: node_name(~20) + node_overhead(~12) + da_property(~20)
+	 *   = ~52 bytes, round up to 64 for alignment/margin
+	 * - Fixed overhead: header(40) + root_node(~40) + strings_table(~30)
+	 * + misc(~32) = ~144 bytes, round up to 256
+	 */
+	fdt_size = PAGE_ALIGN((eligible_count * 64 + 256));
+	pcsc_kho_fdt_order = get_order(fdt_size);
+	pcsc_kho_fdt = alloc_pages(GFP_KERNEL, pcsc_kho_fdt_order);
+	if (!pcsc_kho_fdt) {
+		pr_err("PCSC: Failed to allocate FDT pages (size=%zu, order=%d)\n",
+		       fdt_size, pcsc_kho_fdt_order);
+		return NOTIFY_BAD;
+	}
+
+	fdt = page_to_virt(pcsc_kho_fdt);
+
+	/* Create FDT */
+	err = fdt_create(fdt, fdt_size);
+	if (err) {
+		pr_err("PCSC: Failed to create FDT: %d\n", err);
+		goto error_cleanup;
+	}
+
+	err = fdt_finish_reservemap(fdt);
+	if (err) {
+		pr_err("PCSC: Failed to finish FDT reservemap: %d\n", err);
+		goto error_cleanup;
+	}
+
+	err = fdt_begin_node(fdt, "");
+	if (err) {
+		pr_err("PCSC: Failed to begin root FDT node: %d\n", err);
+		goto error_cleanup;
+	}
+
+	err = fdt_property_string(fdt, "compatible", PCSC_KHO_NODE_COMPATIBLE);
+	if (err) {
+		pr_err("PCSC: Failed to set compatible property: %d\n", err);
+		goto error_cleanup;
+	}
+
+	for_each_pci_dev(dev) {
+		int save_err = pcsc_kho_save_device(dev, fdt);
+
+		if (save_err == 0) {
+			saved_count++;
+		} else if (save_err == 1) {
+			/* Skipped (not eligible) */
+			skipped_count++;
+		} else {
+			pr_err("Failed to save device %04x:%02x:%02x.%d: %d\n",
+			       pci_domain_nr(dev->bus), dev->bus->number,
+			       PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn),
+			       save_err);
+			break;
+		}
+	}
+
+	err = fdt_end_node(fdt);
+	if (err) {
+		pr_err("Failed to end root FDT node: %d\n", err);
+		goto error_cleanup;
+	}
+
+	err = fdt_finish(fdt);
+	if (err) {
+		pr_err("Failed to finish FDT: %d\n", err);
+		goto error_cleanup;
+	}
+
+	int fdt_final_size = fdt_totalsize(fdt);
+	int num_pages = PAGE_ALIGN(fdt_final_size) / PAGE_SIZE;
+
+	err = kho_preserve_phys(page_to_phys(pcsc_kho_fdt),
+				num_pages * PAGE_SIZE);
+	if (err) {
+		pr_err("Failed to preserve FDT pages: %d\n", err);
+		goto error_cleanup;
+	}
+
+	err = kho_add_subtree(ser, PCSC_KHO_FDT, fdt);
+	if (err) {
+		pr_err("Failed to add FDT to KHO tree: %d\n", err);
+		goto error_cleanup;
+	}
+
+#ifdef CONFIG_PCSC_STATS
+	ktime_t end_time = ktime_get();
+	u64 duration_ns = ktime_to_ns(ktime_sub(end_time, start_time));
+	u64 duration_us = duration_ns / 1000;
+
+	pr_info("Saved %u devices to KHO in %llu us (%llu.%03llu ms)\n",
+		saved_count, duration_us, duration_us / 1000,
+		duration_us % 1000);
+#endif
+	return NOTIFY_DONE;
+
+error_cleanup:
+	pr_err("KHO save failed with error %d\n", err);
+	__free_pages(pcsc_kho_fdt, pcsc_kho_fdt_order);
+	pcsc_kho_fdt = NULL;
+	return NOTIFY_BAD;
+}
+
+static struct notifier_block pcsc_kho_nb = {
+	.notifier_call = pcsc_kho_notifier,
+};
+
+static bool pcsc_kho_restore_device(struct pci_dev *dev, const void *fdt,
+				    int node)
+{
+	const struct pcsc_data *preserved_data;
+	const u64 *data_addr;
+	int len;
+
+	data_addr = fdt_getprop(fdt, node, "da", &len);
+	if (!data_addr || len != sizeof(*data_addr))
+		return false;
+
+	preserved_data = phys_to_virt(*data_addr);
+	if (!preserved_data)
+		return false;
+
+
+	dev->pcsc->data = (struct pcsc_data *)preserved_data;
+	dev->pcsc->cachable_bitmask = dev->pcsc->data->cachable_bitmask;
+	dev->pcsc->cached_bitmask = dev->pcsc->data->cached_bitmask;
+	dev->pcsc->cfg_space = dev->pcsc->data->cfg_space;
+
+	return true;
+}
+
+static bool pcsc_kho_check_restore(struct pci_dev *dev)
+{
+	phys_addr_t fdt_phys;
+	const void *fdt;
+	int node, err;
+	bool restored = false;
+	char node_name[32];
+#ifdef CONFIG_PCSC_STATS
+	ktime_t start_time, end_time;
+	u64 duration_ns;
+#endif
+
+	err = kho_retrieve_subtree(PCSC_KHO_FDT, &fdt_phys);
+	if (err) {
+		pci_dbg(dev, "PCSC: kho_retrieve_subtree failed: %d\n", err);
+		return false;
+	}
+
+	fdt = phys_to_virt(fdt_phys);
+	if (fdt_node_check_compatible(fdt, 0, PCSC_KHO_NODE_COMPATIBLE)) {
+		pci_dbg(dev, "PCSC: FDT node not compatible\n");
+		return false;
+	}
+
+#ifdef CONFIG_PCSC_STATS
+	start_time = ktime_get();
+#endif
+
+	snprintf(node_name, sizeof(node_name), "dev_%04x_%02x_%02x_%x",
+		 pci_domain_nr(dev->bus), dev->bus->number,
+		 PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+
+	node = fdt_subnode_offset(fdt, 0, node_name);
+	if (node >= 0)
+		restored = pcsc_kho_restore_device(dev, fdt, node);
+
+#ifdef CONFIG_PCSC_STATS
+	if (restored) {
+		end_time = ktime_get();
+		duration_ns = ktime_to_ns(ktime_sub(end_time, start_time));
+
+		pcsc_stats.pcsc_kho_total_restore_time_ns += duration_ns;
+		pcsc_count_restored_devices();
+	}
+#endif
+
+	return restored;
+}
+#endif
+
 int pcsc_add_device(struct pci_dev *dev)
 {
 	struct pcsc_node *node;
@@ -742,23 +1054,34 @@ int pcsc_add_device(struct pci_dev *dev)
 	 * nodes for these devices, as it simplifies the code flow
 	 */
 	if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
-		/* Allocate contiguous, page aligned data block. This will be
-		 * needed for persisting the data with KHO.
-		 */
-		data_size = sizeof(struct pcsc_data);
-
-		dev->pcsc->data =
-			(struct pcsc_data *)__get_free_pages(
-				GFP_KERNEL | __GFP_ZERO, get_order(data_size));
-		if (!dev->pcsc->data)
+#ifdef CONFIG_PCSC_KHO
+		bool restored = false;
 
-			goto err_free_node;
+		/* Try to restore from KHO first, before any allocation */
+		if (pcsc_persistence_enabled && kho_is_enabled())
+			restored = pcsc_kho_check_restore(dev);
 
-		dev->pcsc->cachable_bitmask = dev->pcsc->data->cachable_bitmask;
-		dev->pcsc->cached_bitmask = dev->pcsc->data->cached_bitmask;
-		dev->pcsc->cfg_space = dev->pcsc->data->cfg_space;
-
-		infer_cacheability(dev);
+		if (!restored) {
+#endif
+			/* Allocate contiguous, page aligned data block. This is
+			 * needed for persisting the data with KHO.
+			 */
+			data_size = sizeof(struct pcsc_data);
+
+			dev->pcsc->data =
+				(struct pcsc_data *)__get_free_pages(
+					GFP_KERNEL | __GFP_ZERO, get_order(data_size));
+			if (!dev->pcsc->data)
+				goto err_free_node;
+
+			dev->pcsc->cachable_bitmask = dev->pcsc->data->cachable_bitmask;
+			dev->pcsc->cached_bitmask = dev->pcsc->data->cached_bitmask;
+			dev->pcsc->cfg_space = dev->pcsc->data->cfg_space;
+
+			infer_cacheability(dev);
+#ifdef CONFIG_PCSC_KHO
+		}
+#endif
 	} else {
 		dev->pcsc->data = NULL;
 		dev->pcsc->cachable_bitmask = NULL;
@@ -1103,7 +1426,9 @@ static struct kobj_attribute pcsc_enabled_attribute =
 static ssize_t pcsc_stats_show(struct kobject *kobj,
 			       struct kobj_attribute *attr, char *buf)
 {
-	return sysfs_emit(
+	ssize_t ret;
+
+	ret = sysfs_emit(
 		buf,
 		"Cache Hits: %lu\n"
 		"Cache Misses: %lu\n"
@@ -1132,6 +1457,20 @@ static ssize_t pcsc_stats_show(struct kobject *kobj,
 			1000,
 		pcsc_stats.hw_access_time_due_to_misses / 1000,
 		pcsc_stats.total_hw_access_time / 1000);
+
+#ifdef CONFIG_PCSC_KHO
+	u64 total_restore_time_us = pcsc_stats.pcsc_kho_total_restore_time_ns / 1000;
+
+	ret += sysfs_emit_at(buf, ret,
+			     "KHO Restore Statistics:\n"
+			     "  Restored Devices: %u\n"
+			     "  Total Restore Time: %llu us\n",
+			     pcsc_stats.pcsc_kho_restored_device_count,
+			     total_restore_time_us);
+
+#endif
+
+	return ret;
 }
 
 static struct kobj_attribute pcsc_stats_attribute =
@@ -1183,6 +1522,10 @@ static void pcsc_create_sysfs(void)
 
 static int __init pcsc_init(void)
 {
+#ifdef CONFIG_PCSC_KHO
+	int ret;
+#endif
+
 	bus_register_notifier(&pci_bus_type, &pcsc_bus_nb);
 
 	/* Try to create sysfs entry, but don't fail if PCI bus isn't ready yet */
@@ -1192,8 +1535,20 @@ static int __init pcsc_init(void)
 	memset(&pcsc_stats, 0, sizeof(pcsc_stats));
 #endif
 
+#ifdef CONFIG_PCSC_KHO
+	/* Register KHO notifier if persistence is enabled */
+	if (pcsc_persistence_enabled && kho_is_enabled()) {
+		ret = register_kho_notifier(&pcsc_kho_nb);
+		if (ret == 0)
+			pr_info("KHO notifier registered successfully\n");
+		else
+			pr_err("Failed to register KHO notifier: %d\n", ret);
+	}
+#endif /* CONFIG_PCSC_KHO */
+
 	pcsc_initialised = true;
-	pr_info("initialised (enabled=%d)\n", pcsc_enabled);
+	pr_info("initialised (enabled=%d, persistence=%d)\n",
+		pcsc_enabled, pcsc_persistence_enabled);
 
 	return 0;
 }
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


