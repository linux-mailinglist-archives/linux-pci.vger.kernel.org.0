Return-Path: <linux-pci+bounces-39222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77782C0413E
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 04:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA584357B8E
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 02:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEF3224AE8;
	Fri, 24 Oct 2025 02:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dX/07ghh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF0F233735
	for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 02:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271466; cv=none; b=JNPyPQklLPw/Mgf5d2F82XJo5l9Cjw2ej0V83AtOb2nW1zOttrIBGaH+mZDlFhjJ3mD8qkQV+sSRbJFoDLptjsQAz9NxsvWEQzZGfd2WsfTzVpFekGngfmCuxaiS6fG2J4P3z9/R504QGvLAxcPOYfTaF1k7NL4ertwxfFH1C3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271466; c=relaxed/simple;
	bh=z0Zvz2jvOtJyELwJABJQkdhaKsjOWLkQyger0LvjmQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8YSSLMQycaQWDKuB+b2cTnSrpVOoojS5fj7Nbr6hmciAN48FkUgxSZUPueSkl8RQOindtLcYpb81LHhwBaMdn7RmvzI01n4v2/Fs25neuJi95dHyQ7224lXVpUOYO2/N8cS2zPi76hkfPDrj5hbe/0Vjgm5Z5uR4jULCJ4x9Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dX/07ghh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761271464; x=1792807464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z0Zvz2jvOtJyELwJABJQkdhaKsjOWLkQyger0LvjmQ0=;
  b=dX/07ghhwCN2G33dzxwI2OZ8PCZovZdNCT4Haraqorr8eNnBZ3MoVNz8
   ybJb5VkfBeGaZvdljcgfkl1unJjciHFQS4vufVRRUhIU9WVcTpMaUZoSE
   bMrcBX0CsTNhfYl232aSp6mmIa4awMh6cMueescJZAZgRnQ8Lzv5J211Y
   y2FetSbk8ja7bTTwHav9hkobtmbN6d8FL9/KE/PiKiWsGlV1ZNe4OSRDY
   uxLN+l1pUJ7Qv01SUp6fEc3oy8ZxlbwYq6C0wXcx0MneMyqaGpfYtR0RP
   IllduJgw17UW35fFpLoMNutRi+hZ0KYxIkq027zrfBH3komW3HOYPqfal
   w==;
X-CSE-ConnectionGUID: rCHFuKPhRReBS1cBet/MhA==
X-CSE-MsgGUID: AN4Qy4FcSpOEopXyhoSjvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67319384"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="67319384"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 19:04:19 -0700
X-CSE-ConnectionGUID: 8HGEO1MjTGGw5nDhThbIDQ==
X-CSE-MsgGUID: 9hdh3SqcQ76N1yAgMhQqhA==
X-ExtLoop1: 1
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa003.fm.intel.com with ESMTP; 23 Oct 2025 19:04:18 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: aik@amd.com,
	yilun.xu@linux.intel.com,
	aneesh.kumar@kernel.org,
	bhelgaas@google.com,
	gregkh@linuxfoundation.org,
	Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v7 8/9] PCI/IDE: Report available IDE streams
Date: Thu, 23 Oct 2025 19:04:17 -0700
Message-ID: <20251024020418.1366664-9-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024020418.1366664-1-dan.j.williams@intel.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
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
 drivers/pci/pci.h                             |  3 +
 include/linux/pci-ide.h                       |  1 +
 drivers/pci/ide.c                             | 69 +++++++++++++++++++
 drivers/pci/probe.c                           | 12 +++-
 5 files changed, 96 insertions(+), 1 deletion(-)

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
index d3f16be40102..8b356dd09105 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -616,9 +616,12 @@ static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
 #ifdef CONFIG_PCI_IDE
 void pci_ide_init(struct pci_dev *dev);
 void pci_ide_init_host_bridge(struct pci_host_bridge *hb);
+extern const struct attribute_group pci_ide_attr_group;
+#define PCI_IDE_ATTR_GROUP (&pci_ide_attr_group)
 #else
 static inline void pci_ide_init(struct pci_dev *dev) { }
 static inline void pci_ide_init_host_bridge(struct pci_host_bridge *hb) { }
+#define PCI_IDE_ATTR_GROUP NULL
 #endif
 
 #ifdef CONFIG_PCI_TSM
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
index 302f7bae6c96..44f62da5e191 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -517,3 +517,72 @@ void pci_ide_init_host_bridge(struct pci_host_bridge *hb)
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
+	if (nr > 256)
+		nr = 256;
+	hb->nr_ide_streams = nr;
+	WARN_ON_ONCE(!ida_is_empty(&hb->ide_stream_ida));
+	sysfs_update_group(&hb->dev.kobj, &pci_ide_attr_group);
+}
+EXPORT_SYMBOL_NS_GPL(pci_ide_set_nr_streams, "PCI_IDE");
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 93fa7ba8dfa6..c5e8a8758e59 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -653,6 +653,16 @@ static void pci_release_host_bridge_dev(struct device *dev)
 	kfree(bridge);
 }
 
+static const struct attribute_group *pci_host_bridge_groups[] = {
+	PCI_IDE_ATTR_GROUP,
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
@@ -672,6 +682,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	bridge->native_dpc = 1;
 	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
 	bridge->native_cxl_error = 1;
+	bridge->dev.type = &pci_host_bridge_type;
 	pci_ide_init_host_bridge(bridge);
 
 	device_initialize(&bridge->dev);
@@ -686,7 +697,6 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 		return NULL;
 
 	pci_init_host_bridge(bridge);
-	bridge->dev.release = pci_release_host_bridge_dev;
 
 	return bridge;
 }
-- 
2.51.0


