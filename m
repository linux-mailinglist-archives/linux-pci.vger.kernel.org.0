Return-Path: <linux-pci+bounces-39976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E50C27089
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 22:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0A0B189DC99
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 21:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43E331770B;
	Fri, 31 Oct 2025 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8mdKJeb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DF9325718
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761946149; cv=none; b=LHUXqtntSX9Ufafj56y8tTy67UZn4649f5tF6s+Tzvv0G2ffeyi97lRGyP9mh7nO2HvIdy12tJPas5kiszlPM4zVUzFAOnuRwKx1lelY6KyEoZRxtbCPRAH37VDXnbrloEgB8FWf+uq0UDlv6wmS5xOaYDv/9Cdv2u9P0UIrhqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761946149; c=relaxed/simple;
	bh=6TDUN02pliVLJKXLTAEIWvwxi4bV004VGXBfK4GQerM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ev8FB9VXAPQwI8A75pOJ0sIQzWvmQ2eqJ5zeSK902HJBE5MvVi8UOeHA9p3Uaq5PTGnUNWvCGV/4TMMQUBiSmzYxH1ceu38sG8wQCp+dg+3cG75EErR/H/WPZFrZyrxsXe4AiYfOtmhROcdkvmwT8nTsTKXlO+m8P73geojd4q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8mdKJeb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761946148; x=1793482148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6TDUN02pliVLJKXLTAEIWvwxi4bV004VGXBfK4GQerM=;
  b=E8mdKJebBclWL6Ko29kJyEC5KLzlWqZTRQLGxSyxreqNht4WXlFQbYHg
   X+97+ZjLB/tU4OgKaOXtzs6uJfufvaM8BbBJy2KwO4mf+dbm5catgJTi6
   +G5HvUcjm0ZuCPlR72WGwMmUgx5Zpv0bqJO0+p/fPkuWRg1Cxgh1zk+0b
   KgjDii2fBZn3VdqkEm3Kke0AGT4gjIw/d0FWp/hhYBBIWIKye+88mhIly
   08Fh63Zlnskq+KvzY4mH70Py4eZYzkVwj4uXs0EY/gBNtC08OKjx+sbpK
   j7ab3CInyu9Ywn76CO58Ve3M+6fNOFoMbxXj1Bo9lW+D41Gaezoxho21R
   w==;
X-CSE-ConnectionGUID: KXYrYDQ9TMyASkarN8x49g==
X-CSE-MsgGUID: 1786+ttfThupcattBU2Rzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="64002419"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="64002419"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 14:29:00 -0700
X-CSE-ConnectionGUID: GEtiZICWQKalrvqvAkQQ2g==
X-CSE-MsgGUID: 6/XX/7drQ86uMcflJawhwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="216986677"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa002.jf.intel.com with ESMTP; 31 Oct 2025 14:29:00 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-coco@lists.linux.dev,
	gregkh@linuxfoundation.org,
	aik@amd.com,
	aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v8 8/9] PCI/IDE: Report available IDE streams
Date: Fri, 31 Oct 2025 14:29:00 -0700
Message-ID: <20251031212902.2256310-9-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031212902.2256310-1-dan.j.williams@intel.com>
References: <20251031212902.2256310-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The limited number of link-encryption (IDE) streams that a given set of
host bridges supports is a platform specific detail. Provide
pci_ide_init_nr_streams() as a generic facility for either platform TSM
drivers, or PCI core native IDE, to report the number available streams.
After invoking pci_ide_init_nr_streams() an "available_secure_streams"
attribute appears in PCI host bridge sysfs to convey that count.

Introduce a device-type, @pci_host_bridge_type, now that both a release
method and sysfs attribute groups are being specified for all 'struct
pci_host_bridge' instances.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 .../ABI/testing/sysfs-devices-pci-host-bridge | 12 ++++
 drivers/pci/pci.h                             |  1 +
 include/linux/pci-ide.h                       |  1 +
 drivers/pci/ide.c                             | 67 +++++++++++++++++++
 drivers/pci/probe.c                           | 14 +++-
 5 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
index 2c66e5bb2bf8..b91ec3450811 100644
--- a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
+++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
@@ -31,3 +31,15 @@ Description:
 		platform specific pool of stream resources shared by the Root
 		Ports in a host bridge. See /sys/devices/pciDDDD:BB entry for
 		details about the DDDD:BB format.
+
+What:		pciDDDD:BB/available_secure_streams
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) When a host bridge has Root Ports that support PCIe IDE
+		(link encryption and integrity protection) there may be a
+		limited number of Selective IDE Streams that can be used for
+		establishing new end-to-end secure links. This attribute
+		decrements upon secure link setup, and increments upon secure
+		link teardown. The in-use stream count is determined by counting
+		stream symlinks. See /sys/devices/pciDDDD:BB entry for details
+		about the DDDD:BB format.
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d3f16be40102..f6ffe5ee4717 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -616,6 +616,7 @@ static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
 #ifdef CONFIG_PCI_IDE
 void pci_ide_init(struct pci_dev *dev);
 void pci_ide_init_host_bridge(struct pci_host_bridge *hb);
+extern const struct attribute_group pci_ide_attr_group;
 #else
 static inline void pci_ide_init(struct pci_dev *dev) { }
 static inline void pci_ide_init_host_bridge(struct pci_host_bridge *hb) { }
diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
index e638f9429bf9..85645b0a8620 100644
--- a/include/linux/pci-ide.h
+++ b/include/linux/pci-ide.h
@@ -63,6 +63,7 @@ struct pci_ide {
 	const char *name;
 };
 
+void pci_ide_set_nr_streams(struct pci_host_bridge *hb, u16 nr);
 struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev,
 					    struct pci_ide *ide);
 struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev);
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 7643840738fe..4ae3872589fc 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -514,3 +514,70 @@ void pci_ide_init_host_bridge(struct pci_host_bridge *hb)
 	hb->nr_ide_streams = 256;
 	ida_init(&hb->ide_stream_ida);
 }
+
+static ssize_t available_secure_streams_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct pci_host_bridge *hb = to_pci_host_bridge(dev);
+	int nr = READ_ONCE(hb->nr_ide_streams);
+	int avail = nr;
+
+	if (!nr)
+		return -ENXIO;
+
+	/*
+	 * Yes, this is inefficient and racy, but it is only for occasional
+	 * platform resource surveys. Worst case is bounded to 256 streams.
+	 */
+	for (int i = 0; i < nr; i++)
+		if (ida_exists(&hb->ide_stream_ida, i))
+			avail--;
+	return sysfs_emit(buf, "%d\n", avail);
+}
+static DEVICE_ATTR_RO(available_secure_streams);
+
+static struct attribute *pci_ide_attrs[] = {
+	&dev_attr_available_secure_streams.attr,
+	NULL
+};
+
+static umode_t pci_ide_attr_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_host_bridge *hb = to_pci_host_bridge(dev);
+
+	if (a == &dev_attr_available_secure_streams.attr)
+		if (!hb->nr_ide_streams)
+			return 0;
+
+	return a->mode;
+}
+
+const struct attribute_group pci_ide_attr_group = {
+	.attrs = pci_ide_attrs,
+	.is_visible = pci_ide_attr_visible,
+};
+
+/**
+ * pci_ide_set_nr_streams() - sets size of the pool of IDE Stream resources
+ * @hb: host bridge boundary for the stream pool
+ * @nr: number of streams
+ *
+ * Platform PCI init and/or expert test module use only. Limit IDE
+ * Stream establishment by setting the number of stream resources
+ * available at the host bridge. Platform init code must set this before
+ * the first pci_ide_stream_alloc() call if the platform has less than the
+ * default of 256 streams per host-bridge.
+ *
+ * The "PCI_IDE" symbol namespace is required because this is typically
+ * a detail that is settled in early PCI init. I.e. this export is not
+ * for endpoint drivers.
+ */
+void pci_ide_set_nr_streams(struct pci_host_bridge *hb, u16 nr)
+{
+	hb->nr_ide_streams = min(nr, 256);
+	WARN_ON_ONCE(!ida_is_empty(&hb->ide_stream_ida));
+	sysfs_update_group(&hb->dev.kobj, &pci_ide_attr_group);
+}
+EXPORT_SYMBOL_NS_GPL(pci_ide_set_nr_streams, "PCI_IDE");
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 93fa7ba8dfa6..cfacf5bcd073 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -653,6 +653,18 @@ static void pci_release_host_bridge_dev(struct device *dev)
 	kfree(bridge);
 }
 
+static const struct attribute_group *pci_host_bridge_groups[] = {
+#ifdef CONFIG_PCI_IDE
+	&pci_ide_attr_group,
+#endif
+	NULL
+};
+
+static const struct device_type pci_host_bridge_type = {
+	.groups = pci_host_bridge_groups,
+	.release = pci_release_host_bridge_dev,
+};
+
 static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 {
 	INIT_LIST_HEAD(&bridge->windows);
@@ -672,6 +684,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	bridge->native_dpc = 1;
 	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
 	bridge->native_cxl_error = 1;
+	bridge->dev.type = &pci_host_bridge_type;
 	pci_ide_init_host_bridge(bridge);
 
 	device_initialize(&bridge->dev);
@@ -686,7 +699,6 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 		return NULL;
 
 	pci_init_host_bridge(bridge);
-	bridge->dev.release = pci_release_host_bridge_dev;
 
 	return bridge;
 }
-- 
2.51.0


