Return-Path: <linux-pci+bounces-41041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C132C5567E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 03:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016803A66BE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 02:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F762DF71B;
	Thu, 13 Nov 2025 02:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TW/9QY6f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0857C2DFA54
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 02:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000049; cv=none; b=VEFMun7iAK0hxUblaCYsqKbntI7kWi5MjLyVm2vylJEUrKzbHgWsFSN+JiMLcY0/lWIrJ+kOvgqswh/3q3alirkgGzPO6Z9rjXHq7k/2WELf+E7I80mCggv5Wbd8yHr6TYzaDkNGRdy2bphiR4DI+7uXH8s5pUu+CqI+jfbLI6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000049; c=relaxed/simple;
	bh=a4mZrnnIGK2BX4ukNxARTOcLcr2H1TnK8o/Q+d75jbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WX1p1q+yM3IEXOLh74u+cZcJ8+e8m6nVJFYcZSSCH0ZvjRZwKeYBqVoJ/zAfvloqou7R7jz6m9Fe32+lWBcreDy5ufMXp8VkDj3OVKYoc+4oPxeHT0U6NVyDo9ryOgz00VZWM7VD3GBoi7XryBLbXJIX0DEutVJHDOT2WsbOqew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TW/9QY6f; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763000049; x=1794536049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a4mZrnnIGK2BX4ukNxARTOcLcr2H1TnK8o/Q+d75jbA=;
  b=TW/9QY6f4Bm+xBgFkZJItguvVUdgRIzYgVx695d5TxeQ4xsA9RHALBHv
   hKmQL8sCJXpionyByE8ZTXpZHXeIA1O2+Fj5kVK0FAWaINVTioHpCkGM3
   BBjHX2ZfiPFeg26oQUcQkjInTI3XqmlGPorKuJV4CXJMBXy58IAO+v2dQ
   pNckzZloOKLwUtZOTJzmcjepm4QDghgd4BYdNxIpv90nt4BS5NRa7qd61
   e/qj5G0/ze31NAkIbBapDd9NZ5FBe/qlspjN+Y0uCEtnHT4ps1ea2k8xz
   L+Va/u3/kKZdKCRkLP50Il8PLL23IsDVGHoB5MsClfiKX29D0kh3lMa0T
   Q==;
X-CSE-ConnectionGUID: jQxbcyB3SK2jh9sdYCvjww==
X-CSE-MsgGUID: M/vFS37bQ7Gw+DE9cSStRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82471773"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="82471773"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 18:14:05 -0800
X-CSE-ConnectionGUID: qP8VpRT9TMWTtvDPt+VvTA==
X-CSE-MsgGUID: KOQ7OfwyTk+XXqrMnsH1VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="189802498"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa009.fm.intel.com with ESMTP; 12 Nov 2025 18:14:05 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-coco@lists.linux.dev,
	Jonathan.Cameron@huawei.com,
	Alexey Kardashevskiy <aik@amd.com>
Subject: [PATCH v2 5/8] PCI/IDE: Initialize an ID for all IDE streams
Date: Wed, 12 Nov 2025 18:14:43 -0800
Message-ID: <20251113021446.436830-6-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113021446.436830-1-dan.j.williams@intel.com>
References: <20251113021446.436830-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCIe spec defines two types of streams - selective and link.  Each
stream has an ID from the same bucket so a stream ID does not tell the
type.  The spec defines an "enable" bit for every stream and required
stream IDs to be unique among all enabled stream but there is no such
requirement for disabled streams.

However, when IDE_KM is programming keys, an IDE-capable device needs
to know the type of stream being programmed to write it directly to
the hardware as keys are relatively large, possibly many of them and
devices often struggle with keeping around rather big data not being
used.

Walk through all streams on a device and initialise the IDs to some
unique number, both link and selective.

The weakest part of this proposal is the host bridge ide_stream_ids_ida.
Technically, a Stream ID only needs to be unique within a given partner
pair. However, with "anonymous" / unassigned streams there is no convenient
place to track the available ids. Proceed with an ida in the host bridge
for now, but consider moving this tracking to be an ide_stream_ids_ida per
device.

Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/pci.h       |   2 +
 include/linux/pci-ide.h |   6 ++
 include/linux/pci.h     |   1 +
 drivers/pci/ide.c       | 129 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/remove.c    |   1 +
 5 files changed, 139 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f6ffe5ee4717..641c0b53c4e3 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -616,10 +616,12 @@ static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
 #ifdef CONFIG_PCI_IDE
 void pci_ide_init(struct pci_dev *dev);
 void pci_ide_init_host_bridge(struct pci_host_bridge *hb);
+void pci_ide_destroy(struct pci_dev *dev);
 extern const struct attribute_group pci_ide_attr_group;
 #else
 static inline void pci_ide_init(struct pci_dev *dev) { }
 static inline void pci_ide_init_host_bridge(struct pci_host_bridge *hb) { }
+static inline void pci_ide_destroy(struct pci_dev *dev) { }
 #endif
 
 #ifdef CONFIG_PCI_TSM
diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
index 93194338e4d0..37a1ad9501b0 100644
--- a/include/linux/pci-ide.h
+++ b/include/linux/pci-ide.h
@@ -97,6 +97,12 @@ struct pci_ide {
 	struct tsm_dev *tsm_dev;
 };
 
+/*
+ * Some devices need help with aliased stream-ids even for idle streams. Use
+ * this id as the "never enabled" place holder.
+ */
+#define PCI_IDE_RESERVED_STREAM_ID 255
+
 void pci_ide_set_nr_streams(struct pci_host_bridge *hb, u16 nr);
 struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev,
 					    struct pci_ide *ide);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ba39ca78b382..52a235c61023 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -619,6 +619,7 @@ struct pci_host_bridge {
 #ifdef CONFIG_PCI_IDE
 	u16 nr_ide_streams; /* Max streams possibly active in @ide_stream_ida */
 	struct ida ide_stream_ida;
+	struct ida ide_stream_ids_ida; /* track unique ids per domain */
 #endif
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index d7fc741f3a26..60c22a6ee322 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -35,8 +35,50 @@ static int sel_ide_offset(struct pci_dev *pdev,
 				settings->stream_index, pdev->nr_ide_mem);
 }
 
+static bool reserve_stream_index(struct pci_dev *pdev, u8 idx)
+{
+	int ret;
+
+	ret = ida_alloc_range(&pdev->ide_stream_ida, idx, idx, GFP_KERNEL);
+	return ret >= 0;
+}
+
+static bool reserve_stream_id(struct pci_host_bridge *hb, u8 id)
+{
+	int ret;
+
+	ret = ida_alloc_range(&hb->ide_stream_ids_ida, id, id, GFP_KERNEL);
+	return ret >= 0;
+}
+
+static bool claim_stream(struct pci_host_bridge *hb, u8 stream_id,
+			 struct pci_dev *pdev, u8 stream_idx)
+{
+	dev_info(&hb->dev, "Stream ID %d active at init\n", stream_id);
+	if (!reserve_stream_id(hb, stream_id)) {
+		dev_info(&hb->dev, "Failed to claim %s Stream ID %d\n",
+			 stream_id == PCI_IDE_RESERVED_STREAM_ID ? "reserved" :
+								   "active",
+			 stream_id);
+		return false;
+	}
+
+	/* No stream index to reserve in the Link IDE case */
+	if (!pdev)
+		return true;
+
+	if (!reserve_stream_index(pdev, stream_idx)) {
+		pci_info(pdev, "Failed to claim active Selective Stream %d\n",
+			 stream_idx);
+		return false;
+	}
+
+	return true;
+}
+
 void pci_ide_init(struct pci_dev *pdev)
 {
+	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
 	u16 nr_link_ide, nr_ide_mem, nr_streams;
 	u16 ide_cap;
 	u32 val;
@@ -83,6 +125,7 @@ void pci_ide_init(struct pci_dev *pdev)
 		int pos = __sel_ide_offset(ide_cap, nr_link_ide, i, nr_ide_mem);
 		int nr_assoc;
 		u32 val;
+		u8 id;
 
 		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CAP, &val);
 
@@ -98,6 +141,51 @@ void pci_ide_init(struct pci_dev *pdev)
 		}
 
 		nr_ide_mem = nr_assoc;
+
+		/*
+		 * Claim Stream IDs and Selective Stream blocks that are already
+		 * active on the device
+		 */
+		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CTL, &val);
+		id = FIELD_GET(PCI_IDE_SEL_CTL_ID, val);
+		if ((val & PCI_IDE_SEL_CTL_EN) &&
+		    !claim_stream(hb, id, pdev, i))
+			return;
+	}
+
+	/* Reserve link stream-ids that are already active on the device */
+	for (u16 i = 0; i < nr_link_ide; ++i) {
+		int pos = ide_cap + PCI_IDE_LINK_STREAM_0 + i * PCI_IDE_LINK_BLOCK_SIZE;
+		u8 id;
+
+		pci_read_config_dword(pdev, pos + PCI_IDE_LINK_CTL_0, &val);
+		id = FIELD_GET(PCI_IDE_LINK_CTL_ID, val);
+		if ((val & PCI_IDE_LINK_CTL_EN) &&
+		    !claim_stream(hb, id, NULL, -1))
+			return;
+	}
+
+	for (u16 i = 0; i < nr_streams; i++) {
+		int pos = __sel_ide_offset(ide_cap, nr_link_ide, i, nr_ide_mem);
+
+		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CAP, &val);
+		if (val & PCI_IDE_SEL_CTL_EN)
+			continue;
+		val &= ~PCI_IDE_SEL_CTL_ID;
+		val |= FIELD_PREP(PCI_IDE_SEL_CTL_ID, PCI_IDE_RESERVED_STREAM_ID);
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
+	}
+
+	for (u16 i = 0; i < nr_link_ide; ++i) {
+		int pos = ide_cap + PCI_IDE_LINK_STREAM_0 +
+			  i * PCI_IDE_LINK_BLOCK_SIZE;
+
+		pci_read_config_dword(pdev, pos, &val);
+		if (val & PCI_IDE_LINK_CTL_EN)
+			continue;
+		val &= ~PCI_IDE_LINK_CTL_ID;
+		val |= FIELD_PREP(PCI_IDE_LINK_CTL_ID, PCI_IDE_RESERVED_STREAM_ID);
+		pci_write_config_dword(pdev, pos, val);
 	}
 
 	pdev->ide_cap = ide_cap;
@@ -301,6 +389,28 @@ void pci_ide_stream_release(struct pci_ide *ide)
 }
 EXPORT_SYMBOL_GPL(pci_ide_stream_release);
 
+struct pci_ide_stream_id {
+	struct pci_host_bridge *hb;
+	u8 stream_id;
+};
+
+static struct pci_ide_stream_id *
+request_stream_id(struct pci_host_bridge *hb, u8 stream_id,
+		  struct pci_ide_stream_id *sid)
+{
+	if (!reserve_stream_id(hb, stream_id))
+		return NULL;
+
+	*sid = (struct pci_ide_stream_id) {
+		.hb = hb,
+		.stream_id = stream_id,
+	};
+
+	return sid;
+}
+DEFINE_FREE(free_stream_id, struct pci_ide_stream_id *,
+	    if (_T) ida_free(&_T->hb->ide_stream_ids_ida, _T->stream_id))
+
 /**
  * pci_ide_stream_register() - Prepare to activate an IDE Stream
  * @ide: IDE settings descriptor
@@ -313,6 +423,7 @@ int pci_ide_stream_register(struct pci_ide *ide)
 {
 	struct pci_dev *pdev = ide->pdev;
 	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
+	struct pci_ide_stream_id __sid;
 	u8 ep_stream, rp_stream;
 	int rc;
 
@@ -321,6 +432,13 @@ int pci_ide_stream_register(struct pci_ide *ide)
 		return -ENXIO;
 	}
 
+	struct pci_ide_stream_id *sid __free(free_stream_id) =
+		request_stream_id(hb, ide->stream_id, &__sid);
+	if (!sid) {
+		pci_err(pdev, "Setup fail: Stream ID %d in use\n", ide->stream_id);
+		return -EBUSY;
+	}
+
 	ep_stream = ide->partner[PCI_IDE_EP].stream_index;
 	rp_stream = ide->partner[PCI_IDE_RP].stream_index;
 	const char *name __free(kfree) = kasprintf(GFP_KERNEL, "stream%d.%d.%d",
@@ -335,6 +453,9 @@ int pci_ide_stream_register(struct pci_ide *ide)
 
 	ide->name = no_free_ptr(name);
 
+	/* Stream ID reservation recorded in @ide is now successfully registered */
+	retain_and_null_ptr(sid);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_ide_stream_register);
@@ -353,6 +474,7 @@ void pci_ide_stream_unregister(struct pci_ide *ide)
 
 	sysfs_remove_link(&hb->dev.kobj, ide->name);
 	kfree(ide->name);
+	ida_free(&hb->ide_stream_ids_ida, ide->stream_id);
 	ide->name = NULL;
 }
 EXPORT_SYMBOL_GPL(pci_ide_stream_unregister);
@@ -614,6 +736,8 @@ void pci_ide_init_host_bridge(struct pci_host_bridge *hb)
 {
 	hb->nr_ide_streams = 256;
 	ida_init(&hb->ide_stream_ida);
+	ida_init(&hb->ide_stream_ids_ida);
+	reserve_stream_id(hb, PCI_IDE_RESERVED_STREAM_ID);
 }
 
 static ssize_t available_secure_streams_show(struct device *dev,
@@ -682,3 +806,8 @@ void pci_ide_set_nr_streams(struct pci_host_bridge *hb, u16 nr)
 	sysfs_update_group(&hb->dev.kobj, &pci_ide_attr_group);
 }
 EXPORT_SYMBOL_NS_GPL(pci_ide_set_nr_streams, "PCI_IDE");
+
+void pci_ide_destroy(struct pci_dev *pdev)
+{
+	ida_destroy(&pdev->ide_stream_ida);
+}
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 803391892c4a..417a9ea59117 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -70,6 +70,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	up_write(&pci_bus_sem);
 
 	pci_doe_destroy(dev);
+	pci_ide_destroy(dev);
 	pcie_aspm_exit_link_state(dev);
 	pci_bridge_d3_update(dev);
 	pci_pwrctrl_unregister(&dev->dev);
-- 
2.51.1


