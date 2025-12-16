Return-Path: <linux-pci+bounces-43073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BC1CC0645
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 01:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98FF03013EED
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 00:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DF427BF7D;
	Tue, 16 Dec 2025 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CrzMhdPe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321C526B777;
	Tue, 16 Dec 2025 00:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765846536; cv=none; b=Y/+dG1kY6uFUyfysAdtRfyMv2vTqCKiTWtW+5lkst1iiEIIvDfrLdjUq5rMU4amZ5M1yYWxrDBnI1Vy4r/6aitAhaV9A52BrgnY3cD6mEYVensbwWAYUIiSZsSKDj6L29rCBZzSTydSDgWM/63i/DpOJcxAWVUwGNtcyQbZhq5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765846536; c=relaxed/simple;
	bh=JyMV8IPoO7I2zY1Yvyj9dIsbkueYAbqKbFHBG5CwT0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmDnpP5fAmyRl3vVSRm07aZ5YtGUxBX5cNPYm9D16OlOvKapayDdw7/buG4Il7+f2XzN/QDBOANdjCsZIbfLh84tDI1BYO9EBGpCNoKilFAH/NGK8TIxzEMfZbyzUy2H0Z2wPH3qXwq49s1cDLQUJTUvLn2oXTIZJO6YuIr4+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CrzMhdPe; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765846534; x=1797382534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JyMV8IPoO7I2zY1Yvyj9dIsbkueYAbqKbFHBG5CwT0Q=;
  b=CrzMhdPe3j/WU6M/TgOcuU04x1Nvq/J4G+jfhrTc868pktDdQ1P8Fq09
   81HN4p56V/zIYGWZof2KyqIqZp13T/IkabRqLK/Kr42ozn9spOvtcdnhA
   u86b62+PQG4mI8rbSexkY+GMZESeAtSmxHLZPetZE5b5koyG7VuKi5b+N
   NDL75f9HXgetqq//sG4xfZXlICNKJxPh8cqW4rz/4DNbAhrRQ6wUDeZrA
   x7zIs62D0GlVxjpjv1oomjSYg2+ot15Gzg4T0hu2uo8ghC3tFtmqIZsKh
   E0CFOXIrWMXrfFpJpq6Kehh0yeH3YxbQXkkrLqzEORsLEv+b31uAD8xIV
   w==;
X-CSE-ConnectionGUID: RMsjDk8nTCyZWGZQ0IeGbA==
X-CSE-MsgGUID: 6iAADDCZTvSJ9SE0Pgn/MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="79215477"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="79215477"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 16:55:32 -0800
X-CSE-ConnectionGUID: sFLu+6bLTealsoz5rNy18A==
X-CSE-MsgGUID: e3fTtkFYTCaIOEP6PY86Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="198131528"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa008.fm.intel.com with ESMTP; 15 Dec 2025 16:55:32 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	alison.schofield@intel.com,
	terry.bowman@amd.com,
	alejandro.lucero-palau@amd.com,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	Alejandro Lucero <alucerop@amd.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH v2 2/6] cxl/mem: Arrange for always-synchronous memdev attach
Date: Mon, 15 Dec 2025 16:56:12 -0800
Message-ID: <20251216005616.3090129-3-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251216005616.3090129-1-dan.j.williams@intel.com>
References: <20251216005616.3090129-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for CXL accelerator drivers that have a hard dependency on
CXL capability initialization, arrange for cxl_mem_probe() to always run
synchronous with the device_add() of cxl_memdev instances. I.e.
cxl_mem_driver registration is always complete before the first memdev
creation event.

At present, cxl_pci does not care about the attach state of the cxl_memdev
because all generic memory expansion functionality can be handled by the
cxl_core. For accelerators, however, that driver needs to perform driver
specific initialization if CXL is available, or execute a fallback to PCIe
only operation.

This synchronous attach guarantee is also needed for Soft Reserve Recovery,
which is an effort that needs to assert that devices have had a chance to
attach before making a go / no-go decision on proceeding with CXL subsystem
initialization.

By moving devm_cxl_add_memdev() to cxl_mem.ko it removes async module
loading as one reason that a memdev may not be attached upon return from
devm_cxl_add_memdev().

Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Alejandro Lucero <alucerop@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/Kconfig       |  2 +-
 drivers/cxl/cxlmem.h      |  2 ++
 drivers/cxl/core/memdev.c | 10 +++++++---
 drivers/cxl/mem.c         | 17 +++++++++++++++++
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 48b7314afdb8..f1361ed6a0d4 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -22,6 +22,7 @@ if CXL_BUS
 config CXL_PCI
 	tristate "PCI manageability"
 	default CXL_BUS
+	select CXL_MEM
 	help
 	  The CXL specification defines a "CXL memory device" sub-class in the
 	  PCI "memory controller" base class of devices. Device's identified by
@@ -89,7 +90,6 @@ config CXL_PMEM
 
 config CXL_MEM
 	tristate "CXL: Memory Expansion"
-	depends on CXL_PCI
 	default CXL_BUS
 	help
 	  The CXL.mem protocol allows a device to act as a provider of "System
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c12ab4fc9512..012e68acad34 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -95,6 +95,8 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport_dev);
 }
 
+struct cxl_memdev *__devm_cxl_add_memdev(struct device *host,
+					 struct cxl_dev_state *cxlds);
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlds);
 int devm_cxl_sanitize_setup_notifier(struct device *host,
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 4dff7f44d908..7a4153e1c6a7 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1050,8 +1050,12 @@ static const struct file_operations cxl_memdev_fops = {
 	.llseek = noop_llseek,
 };
 
-struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds)
+/*
+ * Core helper for devm_cxl_add_memdev() that wants to both create a device and
+ * assert to the caller that upon return cxl_mem::probe() has been invoked.
+ */
+struct cxl_memdev *__devm_cxl_add_memdev(struct device *host,
+					 struct cxl_dev_state *cxlds)
 {
 	struct cxl_memdev *cxlmd;
 	struct device *dev;
@@ -1093,7 +1097,7 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 	put_device(dev);
 	return ERR_PTR(rc);
 }
-EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
+EXPORT_SYMBOL_FOR_MODULES(__devm_cxl_add_memdev, "cxl_mem");
 
 static void sanitize_teardown_notifier(void *data)
 {
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 6e6777b7bafb..55883797ab2d 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -201,6 +201,22 @@ static int cxl_mem_probe(struct device *dev)
 	return devm_add_action_or_reset(dev, enable_suspend, NULL);
 }
 
+/**
+ * devm_cxl_add_memdev - Add a CXL memory device
+ * @host: devres alloc/release context and parent for the memdev
+ * @cxlds: CXL device state to associate with the memdev
+ *
+ * Upon return the device will have had a chance to attach to the
+ * cxl_mem driver, but may fail if the CXL topology is not ready
+ * (hardware CXL link down, or software platform CXL root not attached)
+ */
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlds)
+{
+	return __devm_cxl_add_memdev(host, cxlds);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
+
 static ssize_t trigger_poison_list_store(struct device *dev,
 					 struct device_attribute *attr,
 					 const char *buf, size_t len)
@@ -248,6 +264,7 @@ static struct cxl_driver cxl_mem_driver = {
 	.probe = cxl_mem_probe,
 	.id = CXL_DEVICE_MEMORY_EXPANDER,
 	.drv = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 		.dev_groups = cxl_mem_groups,
 	},
 };
-- 
2.51.1


