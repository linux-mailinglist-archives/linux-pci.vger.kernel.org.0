Return-Path: <linux-pci+bounces-22819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EBBA4D4B5
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 08:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02571888EB7
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 07:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318F31FC7C1;
	Tue,  4 Mar 2025 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8/u6zZH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98BE1FC0FC
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072510; cv=none; b=oU8uW2rFUwZyn/yBp8xGTgwm0eC0Fq+zGJVOu9OSmPHGSDNKUMmEuMb3ds3rt1ExC+VW1Eg2gEMIyEGDmmdwPdOdzdFMdMHQaXqeg9a5/LGgk6/ITLlw0ITjd30kwWPPwb9iK+vQ9RqQlFmuzfuOqmzPkm23RGXbtBryNpifCmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072510; c=relaxed/simple;
	bh=AF0NZZENOUtnVb3FwXdmLDRQtK0N2zbBdKaxmxdgQMQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uh/s/WaLuLOjYsaqeyjhL0LqDCuvQ3r63vI3ra9tBkctWvj1+lheCKEB7DaK40A79PqWflcDShFIX1aL4e/c/ghLZftMXv1g1IUX88uLDwlEkOLH15BCJ8snBQad9i4aaTxAwxijgRSVWR2cURNow8wAkWb5xPctxpExWC979ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8/u6zZH; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741072508; x=1772608508;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AF0NZZENOUtnVb3FwXdmLDRQtK0N2zbBdKaxmxdgQMQ=;
  b=J8/u6zZH6lydKo+pNaWferbqIKOCbHiIYvImhB1kdi99bCnlov6Kcf7O
   hmCvHt6PeiMLTkuKrDX5Xe7zOD60o5QYRw8RbZDWEchVI4hbN98PDCwmv
   M34tjGgiZzUNrkI7WNdAhTBUwka+Nc6xqwhjt5b1DoeyON7cZsKs7BtO1
   2QxEF8Kl0XQY8donQvL4f4L+TSkNAG09B2kiVG0exTD+rk1mtKGzMD1/q
   Z+NKqqU8C/LjWESYdNXtRc3Rl+qJmyjd6KrETaOtsEY3Yosi8iIgVJpto
   tUNntGi3LPFNMKLDQDl3cS0ZO0/jNEzt9ENldk7LlyI+Ul0VSe/Diblpy
   g==;
X-CSE-ConnectionGUID: VZDKQ2hvQMmQOsZPv/xSCA==
X-CSE-MsgGUID: PDyu3xeSSwmSRkpI2RYvDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52181333"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="52181333"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:15:08 -0800
X-CSE-ConnectionGUID: 1WjI0byBSYm9ITe+ZINQ+g==
X-CSE-MsgGUID: MP+rY8TBTDultKR4KETq+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123497898"
Received: from inaky-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.109.47])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:15:08 -0800
Subject: [PATCH v2 09/11] PCI/IDE: Report available IDE streams
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>,
 Xu Yilun <yilun.xu@linux.intel.com>, gregkh@linuxfoundation.org,
 linux-pci@vger.kernel.org, aik@amd.com, lukas@wunner.de
Date: Mon, 03 Mar 2025 23:15:07 -0800
Message-ID: <174107250696.1288555.15924775074966673629.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The limited number of link-encryption (IDE) streams that a given set of
host bridges supports is a platform specific detail. Provide
pci_ide_init_nr_streams() as a generic facility for either platform TSM
drivers, or PCI core native IDE, to report the number available streams.
After invoking pci_ide_init_nr_streams() an "available_secure_streams"
attribute appears in PCI host bridge sysfs to convey that count.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 .../ABI/testing/sysfs-devices-pci-host-bridge      |   12 ++++
 drivers/pci/ide.c                                  |   58 ++++++++++++++++++++
 drivers/pci/pci.h                                  |    3 +
 drivers/pci/probe.c                                |   12 ++++
 include/linux/pci.h                                |    8 +++
 5 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
index 51dc9eed9353..4624469e56d4 100644
--- a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
+++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
@@ -20,6 +20,7 @@ What:		pciDDDD:BB/streamH.R.E:DDDD:BB:DD:F
 Date:		December, 2024
 Contact:	linux-pci@vger.kernel.org
 Description:
+<<<<<<< current
 		(RO) When a platform has established a secure connection, PCIe
 		IDE, between two Partner Ports, this symlink appears. The
 		primary function is to account the stream slot / resources
@@ -30,3 +31,14 @@ Description:
 		assigned Selective IDE Stream Register Block in the Root Port
 		and Endpoint, and H represents a platform specific pool of
 		stream resources shared by the Root Ports in a host bridge.
+
+What:		pciDDDD:BB/available_secure_streams
+Date:		December, 2024
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) When a host bridge has Root Ports that support PCIe IDE
+		(link encryption and integrity protection) there may be a
+		limited number of streams that can be used for establishing new
+		secure links. This attribute decrements upon secure link setup,
+		and increments upon secure link teardown. The in-use stream
+		count is determined by counting stream symlinks.
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index b2091f6260e6..0c72985e6a65 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -439,3 +439,61 @@ void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide)
 	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
 }
 EXPORT_SYMBOL_GPL(pci_ide_stream_disable);
+
+static ssize_t available_secure_streams_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct pci_host_bridge *hb = to_pci_host_bridge(dev);
+	int avail;
+
+	if (hb->nr_ide_streams < 0)
+		return -ENXIO;
+
+	avail = hb->nr_ide_streams -
+		bitmap_weight(hb->ide_stream_map, hb->nr_ide_streams);
+	return sysfs_emit(buf, "%d\n", avail);
+}
+static DEVICE_ATTR_RO(available_secure_streams);
+
+static struct attribute *pci_ide_attrs[] = {
+	&dev_attr_available_secure_streams.attr,
+	NULL,
+};
+
+static umode_t pci_ide_attr_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_host_bridge *hb = to_pci_host_bridge(dev);
+
+	if (a == &dev_attr_available_secure_streams.attr)
+		if (hb->nr_ide_streams < 0)
+			return 0;
+
+	return a->mode;
+}
+
+struct attribute_group pci_ide_attr_group = {
+	.attrs = pci_ide_attrs,
+	.is_visible = pci_ide_attr_visible,
+};
+
+/**
+ * pci_init_nr_ide_streams() - size the pool of IDE Stream resources
+ * @hb: host bridge boundary for the stream pool
+ * @nr: number of streams
+ *
+ * Enable IDE Stream establishment by setting the number of stream
+ * resources available at the host bridge. Platform init code must set
+ * this before the first pci_ide_stream_alloc() call.
+ *
+ * The "PCI_IDE" symbol namespace is required because this is typically
+ * a detail that is settled in early PCI init, i.e. only an expert or
+ * test module should consume this export.
+ */
+void pci_ide_init_nr_streams(struct pci_host_bridge *hb, int nr)
+{
+	hb->nr_ide_streams = nr;
+	sysfs_update_group(&hb->dev.kobj, &pci_ide_attr_group);
+}
+EXPORT_SYMBOL_NS_GPL(pci_ide_init_nr_streams, "PCI_IDE");
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b38bdd91e742..6c050eb9a91b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -458,8 +458,11 @@ static inline void pci_npem_remove(struct pci_dev *dev) { }
 
 #ifdef CONFIG_PCI_IDE
 void pci_ide_init(struct pci_dev *dev);
+extern struct attribute_group pci_ide_attr_group;
+#define PCI_IDE_ATTR_GROUP (&pci_ide_attr_group)
 #else
 static inline void pci_ide_init(struct pci_dev *dev) { }
+#define PCI_IDE_ATTR_GROUP NULL
 #endif
 
 #ifdef CONFIG_PCI_TSM
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e1c915629864..a383cc32c84b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -633,6 +633,16 @@ static void pci_release_host_bridge_dev(struct device *dev)
 	kfree(bridge);
 }
 
+static const struct attribute_group *pci_host_bridge_groups[] = {
+	PCI_IDE_ATTR_GROUP,
+	NULL,
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
@@ -652,6 +662,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	bridge->native_dpc = 1;
 	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
 	bridge->native_cxl_error = 1;
+	bridge->dev.type = &pci_host_bridge_type;
 
 	device_initialize(&bridge->dev);
 }
@@ -665,7 +676,6 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 		return NULL;
 
 	pci_init_host_bridge(bridge);
-	bridge->dev.release = pci_release_host_bridge_dev;
 
 	return bridge;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0f9d6aece346..c2f18f31f7a7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -660,6 +660,14 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 				 void (*release_fn)(struct pci_host_bridge *),
 				 void *release_data);
 
+#ifdef CONFIG_PCI_IDE
+void pci_ide_init_nr_streams(struct pci_host_bridge *hb, int nr);
+#else
+static inline void pci_ide_init_nr_streams(struct pci_host_bridge *hb, int nr)
+{
+}
+#endif
+
 int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
 
 #define PCI_REGION_FLAG_MASK	0x0fU	/* These bits of resource flags tell us the PCI region flags */


