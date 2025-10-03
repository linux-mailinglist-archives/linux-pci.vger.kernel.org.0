Return-Path: <linux-pci+bounces-37520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 046F8BB649C
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 11:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7B81AE01E8
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 09:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088AA28505A;
	Fri,  3 Oct 2025 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="PZpIdR2Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D858527B4E5;
	Fri,  3 Oct 2025 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482138; cv=none; b=ftYxDUawK+auGYxctd99tyh5bKL5LmJZH/MhD11XiEUxVy5+m5s4+Al62zy/D+0YAjRViz6zOwmSU1PkILWUj9MEy8ULdlv5FhShujD9/d2Og5f7v91l5yjNGi6tK/aJ+tl/yNO074KM6IL61wxKMW8PLW65okFeHSM+EFt/r50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482138; c=relaxed/simple;
	bh=fbuf55nZc0A5Jk8cQxMMStl3mJZ8VqE9MP24zvoQpUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQY7yuEEzJODX2i4Hb/alX/FcGWFkoGmLb23uwcqPhohzXaG3jHeWKrWsIADWQ+LMjGtW/m3jJEh08hXSCkkYnvY73qMtznIcvB5PKZNjuLlAO5VxyJ7G8Qgv+xANpOc9Lbh/FWpjANS7BR8jhY4xhGvK96uzw67IR67GB9T7Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=PZpIdR2Y; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759482136; x=1791018136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ViRJy4MQR6VeNiIo5EZJ98n4zWE+Nw0q/T2qMHtTtP0=;
  b=PZpIdR2YJHRpNlt54GxceHh4bIA7/jA2dcqMhjEO3CH1Zo8jcvSHqMyK
   3hPPMBLpsnvGPXOZpY/7Ki7yWAnCKUxCC4hfPTdiZGH5yh7bhIaTHuVLj
   fmGl/L1R/T713kt8Bc6OCYKeNio154AmlV40tmR32bsEVsUBfFvv3+62f
   4YcANPskUlbfJXWU3BXEnjAqeRTra9EjZjxlkVrjEp7CqCtnztlvb7+CQ
   w0HmVsKjx/9T+UeeCjRHyprFNzzvi4LRCdxWgr8lEVma5k0OUUnRN5mYn
   ImkE9JgEK/JyNWTA9iSPimNe1ll6KSmzBAmS02R5CotpcqkAn/jBpx+jA
   w==;
X-CSE-ConnectionGUID: qyaBFtYbQeqL/50QWO6EeA==
X-CSE-MsgGUID: MP4XAZg6TIWmKZnUf88AuA==
X-IronPort-AV: E=Sophos;i="6.18,281,1751241600"; 
   d="scan'208";a="4212724"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 09:02:14 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:2067]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.156:2525] with esmtp (Farcaster)
 id a9e0fec6-f742-42a7-870c-e33a1c45b9f5; Fri, 3 Oct 2025 09:02:14 +0000 (UTC)
X-Farcaster-Flow-ID: a9e0fec6-f742-42a7-870c-e33a1c45b9f5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 3 Oct 2025 09:02:14 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 3 Oct 2025
 09:02:11 +0000
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
Subject: [RFC PATCH 02/13] pci: pcsc: implement basic functionality
Date: Fri, 3 Oct 2025 09:00:38 +0000
Message-ID: <de485efebd203fc0f69aabccd45917b8360ce47a.1759312886.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759312886.git.epetron@amazon.de>
References: <cover.1759312886.git.epetron@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Implement the core functionality of the PCI Configuration Space Cache
using per-device cache nodes attached to struct pci_dev.

Each cache node stores:
- A 256-byte array (4KB for PCIe) representing the configuration space
- A cacheable bitmask indicating which registers can be cached
- A cached bitmask tracking which bytes are currently cached

The implementation attaches cache nodes directly to pci_dev structures
during `pci_device_add()` and removes them during `pci_device_remove()`.

The cache implements a write-invalidate policy where writes are
propagated to the device while invalidating the cache. This design
choice improves robustness and increases the number of cacheable
registers, particularly for operations like BAR sizing which use
write-read sequences to detect read-only bits.

Currently, the cacheable bitmask is zero-initialized,
effectively disabling the cache. This will be changed in the next
commits.

This implementation only supports endpoint devices; bridges and
root complexes are not cached.

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---
 drivers/pci/pci-driver.c |   5 +
 drivers/pci/pcsc.c       | 244 ++++++++++++++++++++++++++++++++++++++-
 drivers/pci/probe.c      |   9 ++
 include/linux/pci.h      |   5 +
 include/linux/pcsc.h     |  38 ++++++
 5 files changed, 299 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 302d61783f6c..7c0cbbd50b32 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -21,6 +21,7 @@
 #include <linux/acpi.h>
 #include <linux/dma-map-ops.h>
 #include <linux/iommu.h>
+#include <linux/pcsc.h>
 #include "pci.h"
 #include "pcie/portdrv.h"
 
@@ -497,7 +498,11 @@ static void pci_device_remove(struct device *dev)
 	 * horrible the crap we have to deal with is when we are awake...
 	 */
 
+ #ifdef CONFIG_PCSC
+	pcsc_remove_device(pci_dev);
+#endif
 	pci_dev_put(pci_dev);
+
 }
 
 static void pci_device_shutdown(struct device *dev)
diff --git a/drivers/pci/pcsc.c b/drivers/pci/pcsc.c
index dec7c51b5cfd..7531217925e8 100644
--- a/drivers/pci/pcsc.c
+++ b/drivers/pci/pcsc.c
@@ -14,9 +14,16 @@
 
  #define pr_fmt(fmt) "PCSC: " fmt
 
+#include <linux/atomic.h>
 #include <linux/pcsc.h>
 
 static bool pcsc_initialised;
+static atomic_t num_nodes = ATOMIC_INIT(0);
+
+inline bool pcsc_is_initialised(void)
+{
+	return pcsc_initialised;
+}
 
 static int pcsc_add_bus(struct pci_bus *bus)
 {
@@ -103,13 +110,225 @@ int __weak pcsc_hw_config_write(struct pci_bus *bus, unsigned int devfn,
 }
 EXPORT_SYMBOL_GPL(pcsc_hw_config_write);
 
+static inline int _test_bits(int where, int size, const void *addr)
+{
+	int i;
+	int res = 1;
+
+	for (i = 0; i < size; i++)
+		res &= test_bit(where + i, addr);
+	return res;
+}
+
+static int pcsc_is_access_cacheable(struct pci_dev *dev, int where, int size)
+{
+	if (unlikely(!dev || (where + size > PCSC_CFG_SPC_SIZE)))
+		return 0;
+
+	return _test_bits(where, size, dev->pcsc->cachable_bitmask);
+}
+
+static inline bool pcsc_is_cached(struct pci_dev *dev, int where, int size)
+{
+	if (unlikely(!dev || !dev->pcsc || !dev->pcsc->cfg_space ||
+		     (where + size > PCSC_CFG_SPC_SIZE)))
+		return 0;
+
+	return _test_bits(where, size, dev->pcsc->cached_bitmask);
+}
+
+static inline void pcsc_set_cached(struct pci_dev *dev, int where, bool cached)
+{
+	if (WARN_ON(!dev))
+		return;
+
+	if (WARN_ON(where >= PCSC_CFG_SPC_SIZE))
+		return;
+
+	if (cached)
+		set_bit(where, dev->pcsc->cached_bitmask);
+	else
+		clear_bit(where, dev->pcsc->cached_bitmask);
+}
+
+static int pcsc_get_byte(struct pci_dev *dev, int where, u8 *val)
+{
+	if (WARN_ON(!dev || !dev->pcsc || !dev->pcsc->cfg_space))
+		return -EINVAL;
+
+	if (WARN_ON(where >= PCSC_CFG_SPC_SIZE))
+		return -EPERM;
+	*val = dev->pcsc->cfg_space[where];
+	return 0;
+}
+
+static int pcsc_update_byte(struct pci_dev *dev, int where, u8 val)
+{
+	if (WARN_ON(!dev || !dev->pcsc || !dev->pcsc->cfg_space))
+		return -EINVAL;
+
+	if (WARN_ON(where >= PCSC_CFG_SPC_SIZE))
+		return -EPERM;
+	dev->pcsc->cfg_space[where] = val;
+	pcsc_set_cached(dev, where, true);
+
+	return 0;
+}
+
+int pcsc_add_device(struct pci_dev *dev)
+{
+	struct pcsc_node *node;
+	struct pci_bus *bus;
+
+	if (WARN_ON(!dev))
+		return -EINVAL;
+
+	bus = dev->bus;
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	dev->pcsc = node;
+	/* The current version of the PCSC supports only endpoint devices.
+	 * Bridges and RCs are not supported, but we are still creating
+	 * nodes for these devices, as it simplifies the code flow
+	 */
+	if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
+		dev->pcsc->cfg_space = kzalloc(PCSC_CFG_SPC_SIZE, GFP_KERNEL);
+		if (!dev->pcsc->cfg_space)
+			goto err_free_node;
+
+	} else {
+		dev->pcsc->cfg_space = NULL;
+	}
+
+	atomic_inc(&num_nodes);
+	pci_dbg(dev, "PCSC: Created cache node\n");
+
+	return 0;
+
+err_free_node:
+	dev->pcsc = NULL;
+	kfree(node);
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(pcsc_add_device);
+
+int pcsc_remove_device(struct pci_dev *dev)
+{
+	if (WARN_ON(!dev))
+		return -EINVAL;
+
+	pci_dbg(dev, "PCSC: Removing cache node");
+
+	atomic_dec(&num_nodes);
+
+	if (dev->pcsc && dev->pcsc->cfg_space) {
+		kfree(dev->pcsc->cfg_space);
+		kfree(dev->pcsc);
+	}
+	dev->pcsc = NULL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pcsc_remove_device);
+
+/**
+ * pcsc_get_and_insert_multiple - Read multiple bytes from PCI cache or HW
+ * @dev: PCI device to read from
+ * @bus: PCI bus to read from
+ * @devfn: device and function number
+ * @where: offset in config space
+ * @word: pointer to store read value
+ * @size: number of bytes to read (1, 2 or 4)
+ *
+ * Reads consecutive bytes from PCI cache or hardware. If values are not cached,
+ * reads from hardware and inserts into cache.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int pcsc_get_and_insert_multiple(struct pci_dev *dev,
+					struct pci_bus *bus, unsigned int devfn,
+					int where, u32 *word, int size)
+{
+	u32 word_cached = 0;
+	u8 byte_val;
+	int rc, i;
+
+	if (WARN_ON(!dev || !bus || !word))
+		return -EINVAL;
+
+	if (WARN_ON(size != 1 && size != 2 && size != 4))
+		return -EINVAL;
+
+	/* Check bounds */
+	if (where + size > PCSC_CFG_SPC_SIZE)
+		return -EINVAL;
+
+	if (pcsc_is_cached(dev, where, size)) {
+		/* Read bytes from cache and assemble them into word_cached
+		 * in little-endian order (as per PCI spec)
+		 */
+		for (i = 0; i < size; i++) {
+			pcsc_get_byte(dev, where + i, &byte_val);
+			word_cached |= ((u32)byte_val << (i * 8));
+		}
+	} else {
+		rc = pcsc_hw_config_read(bus, devfn, where, size, &word_cached);
+		if (rc) {
+			pci_err(dev,
+				"%s: Failed to read CFG Space where=%d size=%d",
+				__func__, where, size);
+			return rc;
+		}
+
+		/* Extract bytes from word_cached in little-endian order
+		 * and store them in cache.
+		 */
+		for (i = 0; i < size; i++) {
+			byte_val = (word_cached >> (i * 8)) & 0xFF;
+			pcsc_update_byte(dev, where + i, byte_val);
+		}
+	}
+
+	*word = word_cached;
+	return 0;
+}
+
 int pcsc_cached_config_read(struct pci_bus *bus, unsigned int devfn, int where,
 			    int size, u32 *val)
 {
-	if (!pcsc_initialised)
+	int rc;
+	struct pci_dev *dev;
+
+	if (unlikely(!pcsc_is_initialised()))
 		goto read_from_dev;
 
+	if (WARN_ON(!bus || !val || (size != 1 && size != 2 && size != 4) ||
+		    where + size > PCSC_CFG_SPC_SIZE))
+		return -EINVAL;
+
+	dev = pci_get_slot(bus, devfn);
+
+	if (unlikely(!dev || !dev->pcsc))
+		goto read_from_dev;
+
+	if (dev->pcsc->cfg_space &&
+	    pcsc_is_access_cacheable(dev, where, size)) {
+		rc = pcsc_get_and_insert_multiple(dev, bus, devfn, where, val,
+						  size);
+		if (likely(!rc)) {
+			pci_dev_put(dev);
+			return 0;
+		}
+		/* if reading from the cache failed continue and try reading
+		 * from the actual device
+		 */
+	}
 read_from_dev:
+	if (dev)
+		pci_dev_put(dev);
 	return pcsc_hw_config_read(bus, devfn, where, size, val);
 }
 EXPORT_SYMBOL_GPL(pcsc_cached_config_read);
@@ -117,10 +336,31 @@ EXPORT_SYMBOL_GPL(pcsc_cached_config_read);
 int pcsc_cached_config_write(struct pci_bus *bus, unsigned int devfn, int where,
 			     int size, u32 val)
 {
-	if (!pcsc_initialised)
+	int i;
+	struct pci_dev *dev;
+
+	if (unlikely(!pcsc_is_initialised()))
 		goto write_to_dev;
 
+	if (WARN_ON(!bus || (size != 1 && size != 2 && size != 4) ||
+		    where + size > PCSC_CFG_SPC_SIZE))
+		return -EINVAL;
+
+	dev = pci_get_slot(bus, devfn);
+
+	if (unlikely(!dev || !dev->pcsc || !dev->pcsc->cfg_space)) {
+		/* Do not add nodes on arbitrary writes  */
+		goto write_to_dev;
+	} else {
+		/* Mark the cache as dirty */
+		if (pcsc_is_access_cacheable(dev, where, size)) {
+			for (i = 0; i < size; i++)
+				pcsc_set_cached(dev, where + i, false);
+		}
+	}
 write_to_dev:
+	if (dev)
+		pci_dev_put(dev);
 	return pcsc_hw_config_write(bus, devfn, where, size, val);
 }
 EXPORT_SYMBOL_GPL(pcsc_cached_config_write);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 33a186e4bf1e..c231e09e5a6e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -23,6 +23,7 @@
 #include <linux/irqdomain.h>
 #include <linux/pm_runtime.h>
 #include <linux/bitfield.h>
+#include <linux/pcsc.h>
 #include "pci.h"
 
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
@@ -2801,6 +2802,14 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 
 	dev->state_saved = false;
 
+#ifdef CONFIG_PCSC
+	if (likely(pcsc_is_initialised()))
+		if (!dev->pcsc)
+			if (pcsc_add_device(dev))
+				pci_warn(dev,
+					 "Failed to add PCI device to PCSC\n");
+#endif
+
 	pci_init_capabilities(dev);
 
 	/*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b6cbf93db644..e59b585f96bb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -42,6 +42,7 @@
 #include <uapi/linux/pci.h>
 
 #include <linux/pci_ids.h>
+#include <linux/pcsc.h>
 
 #define PCI_STATUS_ERROR_BITS (PCI_STATUS_DETECTED_PARITY  | \
 			       PCI_STATUS_SIG_SYSTEM_ERROR | \
@@ -560,6 +561,10 @@ struct pci_dev {
 	u8		tph_mode;	/* TPH mode */
 	u8		tph_req_type;	/* TPH requester type */
 #endif
+
+#ifdef CONFIG_PCSC
+	struct pcsc_node *pcsc;
+#endif
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
diff --git a/include/linux/pcsc.h b/include/linux/pcsc.h
index 45816eb2b2c8..516d73931608 100644
--- a/include/linux/pcsc.h
+++ b/include/linux/pcsc.h
@@ -9,6 +9,20 @@
 #define _LINUX_PCSC_H
 
 #include <linux/pci.h>
+#include <linux/sizes.h>
+#include <linux/bitmap.h>
+
+#ifdef CONFIG_PCIE_PCSC
+#define PCSC_CFG_SPC_SIZE (4 * SZ_1K)
+#else
+#define PCSC_CFG_SPC_SIZE 256
+#endif
+
+struct pcsc_node {
+	u8 *cfg_space;
+	DECLARE_BITMAP(cachable_bitmask, PCSC_CFG_SPC_SIZE);
+	DECLARE_BITMAP(cached_bitmask, PCSC_CFG_SPC_SIZE);
+};
 
 /**
  * pcsc_hw_config_read - Direct hardware PCI config space read
@@ -83,4 +97,28 @@ int pcsc_cached_config_write(struct pci_bus *bus, unsigned int devfn, int where,
  * Return: 0 on success, negative error code on failure
  */
 int pcsc_inject_bus_ops(struct pci_bus *bus);
+
+/**
+ * pcsc_add_device - Allocate and initialize a new PCSC node
+ * This should only be called once for each device
+ * @dev: PCI device to initialise the cache for
+ *
+ * Returns: 0 on success error code on failure
+ */
+int pcsc_add_device(struct pci_dev *dev);
+
+/**
+ * pcsc_remove_device - Clear up any PCSC data
+ * @dev: PCI device to remove
+ *
+ * Returns: 0 on success, -EINVAL if dev is NULL
+ */
+int pcsc_remove_device(struct pci_dev *dev);
+
+/**
+ * @brief Returns if the PCSC infrastructure is initialised
+ *
+ */
+bool pcsc_is_initialised(void);
+
 #endif /* _LINUX_PCSC_H */
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


