Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A952E24D5FD
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 15:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgHUNQ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 09:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbgHUNQQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 09:16:16 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F21C06138B
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2020 06:16:14 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w14so889388eds.0
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2020 06:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NxlhAJ1KOAer/ks+xcHyw//iJAXespq5AefJ6dSktes=;
        b=N+lXLh4HfaQ0PykHmJWAY0wIFAYXmf/kkyLxM6n+tR4lng3Wep0f01oGUHkb3cVCKf
         gFYq/d+EjZ+hkllmQv9OYJ4Rf39hAngnL69AsRS5PXRNowVzwZ7PLFDUw0C/0W89lqgA
         BCIm4CBQFIEAxT5+ERAEH6aCBuytNmJtF1ppIsUMzlQZs0XJ0IZpiduM9cW3MT9h5oUC
         ZmvnjVz4bUwMBR9lKVv5+QrmR9q/q2yMOGYf1NTWWZhWCbU6T7Ln0iMpaG/luqAZE2Fk
         6TTvwj1S+mcCYqM9wYawQ3inV9lJ1qqimzG9Po1gngxKQYiECEmXLXQctrXj+WSTwDPK
         eVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NxlhAJ1KOAer/ks+xcHyw//iJAXespq5AefJ6dSktes=;
        b=kNHacgQ2TOCv1aFl3j5V1Oal7eMzTOcOdz34cXcN2auWp4jppOj7x5J5cT9FpY30Po
         VtODrD77Xor5WNtGfkBA8y9JP7KDOW7sDXZXNOrBx42pU3oXdTBkLtyLf0Zs6SvRUNrP
         PcUXP/0gBrZye4IPcDWbCUyzmP2srtM859eX4P6qDR1HUrEfgEejSl8FzIFtfMvP6970
         qevTVQyRit5zVsEjOP9ET1k4O0UAQY/VG3zfXu+0OdwPKGZT8AvNZo5vtGup/Fh8kqFm
         5l4Op+Cr16/UPJ3Q0RenkOngirY6Tjhg82lX/d/dh8MEMc6joRUBs6JaToIjj/Og3tAG
         Guow==
X-Gm-Message-State: AOAM533VOrrcna2Emoy7VYmkEUoUE8IL1kJBRBxpapTwSDflXV7LmccP
        +77n+bz/QZNYZrSNCyWf6hvQQA==
X-Google-Smtp-Source: ABdhPJyZPNka7zmqI+7SgdHXEjXp0y2ZbjsHxMhgluktwq4n/jUSPkWoqJlR0OsXxAp22OOeuv0G3A==
X-Received: by 2002:aa7:c1ca:: with SMTP id d10mr2750322edp.261.1598015772958;
        Fri, 21 Aug 2020 06:16:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id v4sm1299748eje.39.2020.08.21.06.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 06:16:12 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org
Cc:     joro@8bytes.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, eric.auger@redhat.com,
        lorenzo.pieralisi@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 5/6] iommu/virtio: Support topology description in config space
Date:   Fri, 21 Aug 2020 15:15:39 +0200
Message-Id: <20200821131540.2801801-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821131540.2801801-1-jean-philippe@linaro.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Platforms without device-tree nor ACPI can provide a topology
description embedded into the virtio config space. Parse it.

Use PCI FIXUP to probe the config space early, because we need to
discover the topology before any DMA configuration takes place, and the
virtio driver may be loaded much later. Since we discover the topology
description when probing the PCI hierarchy, the virtual IOMMU cannot
manage other platform devices discovered earlier.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig           |  12 ++
 drivers/iommu/virtio/Makefile   |   1 +
 drivers/iommu/virtio/topology.c | 259 ++++++++++++++++++++++++++++++++
 3 files changed, 272 insertions(+)
 create mode 100644 drivers/iommu/virtio/topology.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e29ae50f7100..98d28fdbc19a 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -394,4 +394,16 @@ config VIRTIO_IOMMU
 config VIRTIO_IOMMU_TOPOLOGY_HELPERS
 	bool
 
+config VIRTIO_IOMMU_TOPOLOGY
+	bool "Handle topology properties from the virtio-iommu"
+	depends on VIRTIO_IOMMU
+	depends on PCI
+	default y
+	select VIRTIO_IOMMU_TOPOLOGY_HELPERS
+	help
+	  Enable early probing of virtio-iommu devices to detect the built-in
+	  topology description.
+
+	  Say Y here if you intend to run this kernel as a guest.
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/virtio/Makefile b/drivers/iommu/virtio/Makefile
index b42ad47eac7e..1eda8ca1cbbf 100644
--- a/drivers/iommu/virtio/Makefile
+++ b/drivers/iommu/virtio/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
+obj-$(CONFIG_VIRTIO_IOMMU_TOPOLOGY) += topology.o
 obj-$(CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS) += topology-helpers.o
diff --git a/drivers/iommu/virtio/topology.c b/drivers/iommu/virtio/topology.c
new file mode 100644
index 000000000000..4923eec618b9
--- /dev/null
+++ b/drivers/iommu/virtio/topology.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/io-64-nonatomic-hi-lo.h>
+#include <linux/iopoll.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_pci.h>
+#include <uapi/linux/virtio_config.h>
+#include <uapi/linux/virtio_iommu.h>
+
+#include "topology-helpers.h"
+
+struct viommu_cap_config {
+	u8 bar;
+	u32 length; /* structure size */
+	u32 offset; /* structure offset within the bar */
+};
+
+struct viommu_topo_header {
+	u8 type;
+	u8 reserved;
+	u16 length;
+};
+
+static struct virt_topo_endpoint *
+viommu_parse_node(void __iomem *buf, size_t len)
+{
+	int ret = -EINVAL;
+	union {
+		struct viommu_topo_header hdr;
+		struct virtio_iommu_topo_pci_range pci;
+		struct virtio_iommu_topo_mmio mmio;
+	} __iomem *cfg = buf;
+	struct virt_topo_endpoint *spec;
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return ERR_PTR(-ENOMEM);
+
+	switch (ioread8(&cfg->hdr.type)) {
+	case VIRTIO_IOMMU_TOPO_PCI_RANGE:
+		if (len < sizeof(cfg->pci))
+			goto err_free;
+
+		spec->dev_id.type = VIRT_TOPO_DEV_TYPE_PCI;
+		spec->dev_id.segment = ioread16(&cfg->pci.segment);
+		spec->dev_id.bdf_start = ioread16(&cfg->pci.bdf_start);
+		spec->dev_id.bdf_end = ioread16(&cfg->pci.bdf_end);
+		spec->endpoint_id = ioread32(&cfg->pci.endpoint_start);
+		break;
+	case VIRTIO_IOMMU_TOPO_MMIO:
+		if (len < sizeof(cfg->mmio))
+			goto err_free;
+
+		spec->dev_id.type = VIRT_TOPO_DEV_TYPE_MMIO;
+		spec->dev_id.base = ioread64(&cfg->mmio.address);
+		spec->endpoint_id = ioread32(&cfg->mmio.endpoint);
+		break;
+	default:
+		pr_warn("unhandled format 0x%x\n", ioread8(&cfg->hdr.type));
+		ret = 0;
+		goto err_free;
+	}
+	return spec;
+
+err_free:
+	kfree(spec);
+	return ERR_PTR(ret);
+}
+
+static int viommu_parse_topology(struct device *dev,
+				 struct virtio_iommu_config __iomem *cfg,
+				 size_t max_len)
+{
+	int ret;
+	u16 len;
+	size_t i;
+	LIST_HEAD(endpoints);
+	size_t offset, count;
+	struct virt_topo_iommu *viommu;
+	struct virt_topo_endpoint *ep, *next;
+	struct viommu_topo_header __iomem *cur;
+
+	offset = ioread16(&cfg->topo_config.offset);
+	count = ioread16(&cfg->topo_config.count);
+	if (!offset || !count)
+		return 0;
+
+	viommu = kzalloc(sizeof(*viommu), GFP_KERNEL);
+	if (!viommu)
+		return -ENOMEM;
+
+	viommu->dev = dev;
+
+	for (i = 0; i < count; i++, offset += len) {
+		if (offset + sizeof(*cur) > max_len) {
+			ret = -EOVERFLOW;
+			goto err_free;
+		}
+
+		cur = (void __iomem *)cfg + offset;
+		len = ioread16(&cur->length);
+		if (offset + len > max_len) {
+			ret = -EOVERFLOW;
+			goto err_free;
+		}
+
+		ep = viommu_parse_node((void __iomem *)cur, len);
+		if (!ep) {
+			continue;
+		} else if (IS_ERR(ep)) {
+			ret = PTR_ERR(ep);
+			goto err_free;
+		}
+
+		ep->viommu = viommu;
+		list_add(&ep->list, &endpoints);
+	}
+
+	list_for_each_entry_safe(ep, next, &endpoints, list)
+		/* Moves ep to the helpers list */
+		virt_topo_add_endpoint(ep);
+	virt_topo_add_iommu(viommu);
+
+	return 0;
+err_free:
+	list_for_each_entry_safe(ep, next, &endpoints, list)
+		kfree(ep);
+	kfree(viommu);
+	return ret;
+}
+
+#define VPCI_FIELD(field) offsetof(struct virtio_pci_cap, field)
+
+static inline int viommu_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
+					     struct viommu_cap_config *cap)
+{
+	int pos;
+	u8 bar;
+
+	for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
+	     pos > 0;
+	     pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
+		u8 type;
+
+		pci_read_config_byte(dev, pos + VPCI_FIELD(cfg_type), &type);
+		if (type != cfg_type)
+			continue;
+
+		pci_read_config_byte(dev, pos + VPCI_FIELD(bar), &bar);
+
+		/* Ignore structures with reserved BAR values */
+		if (type != VIRTIO_PCI_CAP_PCI_CFG && bar > 0x5)
+			continue;
+
+		cap->bar = bar;
+		pci_read_config_dword(dev, pos + VPCI_FIELD(length),
+				      &cap->length);
+		pci_read_config_dword(dev, pos + VPCI_FIELD(offset),
+				      &cap->offset);
+
+		return pos;
+	}
+	return 0;
+}
+
+static int viommu_pci_reset(struct virtio_pci_common_cfg __iomem *cfg)
+{
+	u8 status;
+	ktime_t timeout = ktime_add_ms(ktime_get(), 100);
+
+	iowrite8(0, &cfg->device_status);
+	while ((status = ioread8(&cfg->device_status)) != 0 &&
+	       ktime_before(ktime_get(), timeout))
+		msleep(1);
+
+	return status ? -ETIMEDOUT : 0;
+}
+
+static void viommu_pci_parse_topology(struct pci_dev *dev)
+{
+	int ret;
+	u32 features;
+	void __iomem *regs, *common_regs;
+	struct viommu_cap_config cap = {0};
+	struct virtio_pci_common_cfg __iomem *common_cfg;
+
+	/*
+	 * The virtio infrastructure might not be loaded at this point. We need
+	 * to access the BARs ourselves.
+	 */
+	ret = viommu_pci_find_capability(dev, VIRTIO_PCI_CAP_COMMON_CFG, &cap);
+	if (!ret) {
+		pci_warn(dev, "common capability not found\n");
+		return;
+	}
+
+	if (pci_enable_device_mem(dev))
+		return;
+
+	common_regs = pci_iomap(dev, cap.bar, 0);
+	if (!common_regs)
+		return;
+
+	common_cfg = common_regs + cap.offset;
+
+	/* Perform the init sequence before we can read the config */
+	ret = viommu_pci_reset(common_cfg);
+	if (ret < 0) {
+		pci_warn(dev, "unable to reset device\n");
+		goto out_unmap_common;
+	}
+
+	iowrite8(VIRTIO_CONFIG_S_ACKNOWLEDGE, &common_cfg->device_status);
+	iowrite8(VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER,
+		 &common_cfg->device_status);
+
+	/* Find out if the device supports topology description */
+	iowrite32(0, &common_cfg->device_feature_select);
+	features = ioread32(&common_cfg->device_feature);
+
+	if (!(features & BIT(VIRTIO_IOMMU_F_TOPOLOGY))) {
+		pci_dbg(dev, "device doesn't have topology description");
+		goto out_reset;
+	}
+
+	ret = viommu_pci_find_capability(dev, VIRTIO_PCI_CAP_DEVICE_CFG, &cap);
+	if (!ret) {
+		pci_warn(dev, "device config capability not found\n");
+		goto out_reset;
+	}
+
+	regs = pci_iomap(dev, cap.bar, 0);
+	if (!regs)
+		goto out_reset;
+
+	pci_info(dev, "parsing virtio-iommu topology\n");
+	ret = viommu_parse_topology(&dev->dev, regs + cap.offset,
+				    pci_resource_len(dev, 0) - cap.offset);
+	if (ret)
+		pci_warn(dev, "failed to parse topology: %d\n", ret);
+
+	pci_iounmap(dev, regs);
+out_reset:
+	ret = viommu_pci_reset(common_cfg);
+	if (ret)
+		pci_warn(dev, "unable to reset device\n");
+out_unmap_common:
+	pci_iounmap(dev, common_regs);
+}
+
+/*
+ * Catch a PCI virtio-iommu implementation early to get the topology description
+ * before we start probing other endpoints.
+ */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT_QUMRANET, 0x1040 + VIRTIO_ID_IOMMU,
+			viommu_pci_parse_topology);
-- 
2.28.0

