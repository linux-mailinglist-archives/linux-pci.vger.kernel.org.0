Return-Path: <linux-pci+bounces-17809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F799E607D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 23:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE4A16A7AF
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 22:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BDE1C878E;
	Thu,  5 Dec 2024 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+7kMcVS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B312E1BD51B
	for <linux-pci@vger.kernel.org>; Thu,  5 Dec 2024 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437451; cv=none; b=NeyjecKux006XKh9UbytcpofwHH9js4keEjw/s7EKuiB59sY9/BrvahjmaGjkG3Nr4iye8xFV7liaxEZ3ZUcqE4v7kLONUYQK095RSwcOx5GnGAWTQgv64GynGY+sKGnVCIYvM8ZGcmDbxkA2KOWu3INgsAeO0OvV32O/0Ye4RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437451; c=relaxed/simple;
	bh=+k2d4np08krIYuCxOkZ6CLhFSEDzFgxDvVHfbkVQxM0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gMniPYkW1qMWOkrmijsipBnvnzw00H1F8wOR9GNwnhaoLyrUODX6jGT1ylF0LrPnESCvR+hppPb7cZqohHjk3k1WV591WpPgtIQg02ItN/Wmzdnix960wVkFzuBUMs4Up/UWmbKXzZdGOwLqmxS9dyryJs6YSRoWCUOpokPpJKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+7kMcVS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733437450; x=1764973450;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+k2d4np08krIYuCxOkZ6CLhFSEDzFgxDvVHfbkVQxM0=;
  b=C+7kMcVS66idWI+OLxambHIqE5KvpWjSZxPJpX7r5hUZZ1bXbTGgnfEt
   0C9KCrumwbKkVAU3K92EGA+XzRWwgJPb7LyjzCA8SFnLT4rjhiydtn571
   OAIHDHIf1RE7p1ckPqvXKGIUwSPRSdf3gLiqBDlne6yJjRgj6+u8vJdgk
   AwxpS5RZ3BaPxbQiSybuuLn8I78xJkL6GJFNIOr843G7hNS+l20W/b6Xw
   qgjvw25Jj0zV/t07UWri9aeZ6lizWeQE81L431dpFJ/GpZkp5gmGQPGeQ
   6+xOoB/TzsItQrkaTjuERMxdVOhLFvkZ4a+aoh4bkfiB/Km1aGmExDKAK
   w==;
X-CSE-ConnectionGUID: AZIxBQ60T1yg5BOuXCnefg==
X-CSE-MsgGUID: xJEW+3AiRdyMHUVy7NztcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="44802861"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="44802861"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:24:09 -0800
X-CSE-ConnectionGUID: gWJd4ZfXQZqK7NOQbyptaw==
X-CSE-MsgGUID: Jivy9iZaSfKJttcDIFw1KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="99301844"
Received: from kcaccard-desk.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.108.178])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:24:10 -0800
Subject: [PATCH 09/11] PCI/IDE: Report available IDE streams
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>,
 Xu Yilun <yilun.xu@linux.intel.com>, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org
Date: Thu, 05 Dec 2024 14:24:08 -0800
Message-ID: <173343744869.1074769.12345445223792172558.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
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
host-bridges supports is a platform specific detail. Provide
pci_set_nr_ide_streams() as a generic facility for either platform TSM
drivers, or in the future PCI core native IDE, to report the number
available streams. After invoking pci_set_nr_ide_streams() an
"available_secure_streams" attribute appears in PCI Host Bridge sysfs to
convey how many streams are available for IDE establishment.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 .../ABI/testing/sysfs-devices-pci-host-bridge      |   11 +++++
 drivers/pci/ide.c                                  |   46 ++++++++++++++++++++
 drivers/pci/pci.h                                  |    3 +
 drivers/pci/probe.c                                |   11 ++++-
 include/linux/pci.h                                |    9 ++++
 5 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
index 15dafb46b176..1a3249f20e48 100644
--- a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
+++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
@@ -26,3 +26,14 @@ Description:
 		streams can be returned to the available secure streams pool by
 		invoking the tsm/disconnect flow. The link points to the
 		endpoint PCI device at domain:DDDDD bus:BB device:DD function:F.
+
+What:		pciDDDDD:BB/available_secure_streams
+Date:		December, 2024
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) When a host-bridge has root ports that support PCIe IDE
+		(link encryption and integrity protection) there may be a
+		limited number of streams that can be used for establishing new
+		secure links. This attribute decrements upon secure link setup,
+		and increments upon secure link teardown. The in-use stream
+		count is determined by counting stream symlinks.
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index c37f35f0d2c0..0abc19b341ab 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -75,8 +75,54 @@ void pci_ide_init(struct pci_dev *pdev)
 	pdev->nr_ide_mem = nr_ide_mem;
 }
 
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
+		bitmap_weight(hb->ide_stream_ids, PCI_IDE_SEL_CTL_ID_MAX + 1);
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
+void pci_set_nr_ide_streams(struct pci_host_bridge *hb, int nr)
+{
+	hb->nr_ide_streams = nr;
+	sysfs_update_group(&hb->dev.kobj, &pci_ide_attr_group);
+}
+EXPORT_SYMBOL_NS_GPL(pci_set_nr_ide_streams, PCI_IDE);
+
 void pci_init_host_bridge_ide(struct pci_host_bridge *hb)
 {
+	hb->nr_ide_streams = -1;
 	hb->ide_stream_res =
 		DEFINE_RES_MEM_NAMED(0, 0, "IDE Address Association");
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b267fabfd542..76f18b07e081 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -466,11 +466,14 @@ static inline void pci_npem_remove(struct pci_dev *dev) { }
 #ifdef CONFIG_PCI_IDE
 void pci_ide_init(struct pci_dev *dev);
 void pci_init_host_bridge_ide(struct pci_host_bridge *bridge);
+extern struct attribute_group pci_ide_attr_group;
+#define PCI_IDE_ATTR_GROUP (&pci_ide_attr_group)
 #else
 static inline void pci_ide_init(struct pci_dev *dev) { }
 static inline void pci_init_host_bridge_ide(struct pci_host_bridge *bridge)
 {
 }
+#define PCI_IDE_ATTR_GROUP NULL
 #endif
 
 #ifdef CONFIG_PCI_TSM
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 667faa18ced2..a85ad3b28028 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -589,6 +589,16 @@ static void pci_release_host_bridge_dev(struct device *dev)
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
@@ -622,7 +632,6 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 		return NULL;
 
 	pci_init_host_bridge(bridge);
-	bridge->dev.release = pci_release_host_bridge_dev;
 
 	return bridge;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5d9fc498bc70..eae3d11710db 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -604,6 +604,7 @@ struct pci_host_bridge {
 #ifdef CONFIG_PCI_IDE			/* track IDE stream id allocation */
 	DECLARE_BITMAP(ide_stream_ids, PCI_IDE_SEL_CTL_ID_MAX + 1);
 	struct resource ide_stream_res; /* track ide stream address association */
+	int nr_ide_streams;
 #endif
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
@@ -654,6 +655,14 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 				 void (*release_fn)(struct pci_host_bridge *),
 				 void *release_data);
 
+#ifdef CONFIG_PCI_IDE
+void pci_set_nr_ide_streams(struct pci_host_bridge *hb, int nr);
+#else
+static inline void pci_set_nr_ide_streams(struct pci_host_bridge *hb, int nr)
+{
+}
+#endif
+
 int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
 
 #define PCI_REGION_FLAG_MASK	0x0fU	/* These bits of resource flags tell us the PCI region flags */


