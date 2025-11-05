Return-Path: <linux-pci+bounces-40308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB06C33E5A
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 05:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC433AA026
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 04:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F3C19AD5C;
	Wed,  5 Nov 2025 04:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMXe+yFx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7374C214A94
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 04:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762315258; cv=none; b=jVpw9IynB+8+gF+I+e4BQmjUdl6bN14+a279xfvbEDvhP7xE/M/buq2d5uhgxK1EdrpfP6cmrOoYmuBeuRL2bm+F5tv+gaXc4RwDytlpoQ6AZK4ow/XO4aXFOsmREGAO7XuXXufwHFumP9/3bQhG1IwjEotuXC7SrpuEhWYlLz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762315258; c=relaxed/simple;
	bh=96V0NhQmHVtGzM4xn7IuAwJ4SxRHsBMzdkCQb2Jzux8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtvEOOG0hc2gaRYhd/YIVDxp1Y1gv5hZyfqRot5DENPqVU2CCXixm94sAC/hez2SiU0FrlBXJwFmHK5l24Bz2fkIej1C6n3nu4oDsHVrPzuugdsaarVRyzwmcdPsyzYLaNLuojiQrkzpj1AYWznLNJTrYRXpdOTjgU6zXrfyqqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DMXe+yFx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762315256; x=1793851256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=96V0NhQmHVtGzM4xn7IuAwJ4SxRHsBMzdkCQb2Jzux8=;
  b=DMXe+yFxa2HM/2THpDF8Y3gRyYga84rS9nUM9vzB49GoHiW0SaX+GpOy
   xxiuEaw3jgxn/2Nf/WOy9GAcDen95t1phdWfO8hfZBJ0QzR3KmzFgM7Vx
   1B8L91vYt94fvPfTn0qxTDWrTpx4yUsgogGXFJrbyVLFad/SYcCqieZRm
   5FqJPZxIyKh779jqy5HatHWYfBEbzGbAeowiaGii6jC1r2S1JU7u3z6TZ
   6aPXmTXforWk0wTpk2daUDZEClHZVm0yo+NFuuyfEzZUwUlioXPt+xOK2
   AWzaTQvqzKSGhzre0vv/2FegOfRdvpve3FmoJxqmXvRUFZd3zOPapYTDd
   A==;
X-CSE-ConnectionGUID: 6pAtJLBsRU+yuwH7vyP60Q==
X-CSE-MsgGUID: 9TnUYUHgRYS2THl1xaYU9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64328834"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64328834"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 20:00:53 -0800
X-CSE-ConnectionGUID: xnamRr+ZRRSdtxJsn/ayrQ==
X-CSE-MsgGUID: Zr3KuuLART+EF9NWshKk/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="224588536"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa001.jf.intel.com with ESMTP; 04 Nov 2025 20:00:52 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-coco@lists.linux.dev,
	bhelgaas@google.com,
	aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com,
	aik@amd.com
Subject: [PATCH 3/6] PCI/IDE: Initialize an ID for all IDE streams
Date: Tue,  4 Nov 2025 20:00:52 -0800
Message-ID: <20251105040055.2832866-4-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105040055.2832866-1-dan.j.williams@intel.com>
References: <20251105040055.2832866-1-dan.j.williams@intel.com>
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
 drivers/pci/ide.c       | 133 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/remove.c    |   1 +
 5 files changed, 143 insertions(+)

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
index 55283c8490e4..40f0be185120 100644
--- a/include/linux/pci-ide.h
+++ b/include/linux/pci-ide.h
@@ -92,6 +92,12 @@ struct pci_ide {
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
index 0a66230e28cf..1a31353dc109 100644
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
index d7fc741f3a26..33b3c54c62a1 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -35,8 +35,54 @@ static int sel_ide_offset(struct pci_dev *pdev,
 				settings->stream_index, pdev->nr_ide_mem);
 }
 
+static bool reserve_stream_index(struct pci_dev *pdev, u8 idx)
+{
+	int ret;
+
+	ret = ida_alloc_range(&pdev->ide_stream_ida, idx, idx, GFP_KERNEL);
+	if (ret < 0)
+		return false;
+	return true;
+}
+
+static bool reserve_stream_id(struct pci_host_bridge *hb, u8 id)
+{
+	int ret;
+
+	ret = ida_alloc_range(&hb->ide_stream_ids_ida, id, id, GFP_KERNEL);
+	if (ret < 0)
+		return false;
+	return true;
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
@@ -83,6 +129,7 @@ void pci_ide_init(struct pci_dev *pdev)
 		int pos = __sel_ide_offset(ide_cap, nr_link_ide, i, nr_ide_mem);
 		int nr_assoc;
 		u32 val;
+		u8 id;
 
 		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CAP, &val);
 
@@ -98,6 +145,51 @@ void pci_ide_init(struct pci_dev *pdev)
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
@@ -301,6 +393,28 @@ void pci_ide_stream_release(struct pci_ide *ide)
 }
 EXPORT_SYMBOL_GPL(pci_ide_stream_release);
 
+struct pci_ide_stream_id {
+	struct pci_host_bridge *hb;
+	u8 stream_id;
+};
+
+static struct pci_ide_stream_id *alloc_stream_id(struct pci_host_bridge *hb,
+						 u8 stream_id,
+						 struct pci_ide_stream_id *sid)
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
@@ -313,6 +427,7 @@ int pci_ide_stream_register(struct pci_ide *ide)
 {
 	struct pci_dev *pdev = ide->pdev;
 	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
+	struct pci_ide_stream_id __sid;
 	u8 ep_stream, rp_stream;
 	int rc;
 
@@ -321,6 +436,13 @@ int pci_ide_stream_register(struct pci_ide *ide)
 		return -ENXIO;
 	}
 
+	struct pci_ide_stream_id *sid __free(free_stream_id) =
+		alloc_stream_id(hb, ide->stream_id, &__sid);
+	if (!sid) {
+		pci_err(pdev, "Setup fail: Stream ID %d in use\n", ide->stream_id);
+		return -EBUSY;
+	}
+
 	ep_stream = ide->partner[PCI_IDE_EP].stream_index;
 	rp_stream = ide->partner[PCI_IDE_RP].stream_index;
 	const char *name __free(kfree) = kasprintf(GFP_KERNEL, "stream%d.%d.%d",
@@ -335,6 +457,9 @@ int pci_ide_stream_register(struct pci_ide *ide)
 
 	ide->name = no_free_ptr(name);
 
+	/* Stream ID reservation recorded in @ide is now successfully registered */
+	retain_and_null_ptr(sid);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_ide_stream_register);
@@ -353,6 +478,7 @@ void pci_ide_stream_unregister(struct pci_ide *ide)
 
 	sysfs_remove_link(&hb->dev.kobj, ide->name);
 	kfree(ide->name);
+	ida_free(&hb->ide_stream_ids_ida, ide->stream_id);
 	ide->name = NULL;
 }
 EXPORT_SYMBOL_GPL(pci_ide_stream_unregister);
@@ -614,6 +740,8 @@ void pci_ide_init_host_bridge(struct pci_host_bridge *hb)
 {
 	hb->nr_ide_streams = 256;
 	ida_init(&hb->ide_stream_ida);
+	ida_init(&hb->ide_stream_ids_ida);
+	reserve_stream_id(hb, PCI_IDE_RESERVED_STREAM_ID);
 }
 
 static ssize_t available_secure_streams_show(struct device *dev,
@@ -682,3 +810,8 @@ void pci_ide_set_nr_streams(struct pci_host_bridge *hb, u16 nr)
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
2.51.0


