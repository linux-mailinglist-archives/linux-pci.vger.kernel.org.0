Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8462B24D5FA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 15:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgHUNQY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 09:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgHUNQP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 09:16:15 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC08BC061386
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2020 06:16:13 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w14so889231eds.0
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2020 06:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qIWN2A9Pg6dkinmsu+W9xC580ElUmiDl+mJTFgDdlfk=;
        b=lJXaHRtihKmQ0Z2fAhiSdOZT5NzKnzoSxLejvf96zLb4lOwQTV2Mth4JS8ym05KJfj
         hbZuRDp8ARmG/8/q30QH/hSDRmtTGGlcAihsxtc72ByHW7yYNak+CEcwcMEL71gQ2sJm
         DHN6LUUhbybZNvBQeMbghUQKNhDFO/9WxcYazlqTb7ApD0jzGbGI0b4yvUJpXE+fF6bN
         69U2Fw1Qrm94pB44JFwSqFPgMODwH43iIYsIO0i0faBkkZ1i+TxwuoQIuXkHN0VuU7E3
         IH0FlmWpLAOeeRpFjqrbDLBLyAssqLX6ZOTkwS72nMckwOMlG81tV46gVG/P6PC40tNf
         alrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qIWN2A9Pg6dkinmsu+W9xC580ElUmiDl+mJTFgDdlfk=;
        b=YKGA4j6AW9C7uYFbLpzPkVHbAjkjJTGeRBuzJZETWjC4qk/wNc3g/C0U+HU2LCBQ1Z
         Re3JSfOy2aDhFZ+r4tzAXMo33UfwGNdpR1OtGoDrC+ZL3+TIjVahnVeD1Fx9eS5MNFbb
         j32z88aCCFqvILzDtVkXTPEt67iIvsFEEYVtf5+83YrRvYfU0M1kbY5t9IuP50YQQNtA
         XK1Gkx1mcLxClAMP40CsT7DH/SdzL6dkvcu69rY9FiC8ozQYoTBReVSvCWLEEr0hCIk0
         sC3o1tPG/eDwhp5l6NJLcD1WXdJ7Bw9FCd95US5RVF/A2hQY9ZXWwTNzF5s0Yg5ZQaAK
         KASw==
X-Gm-Message-State: AOAM533bdyd2XyzygI4r2uFDWliBQdyzkTH24lGlrCC8gVhWS9zcKrVK
        AFqtUFvb/2Y4LOkEQcZPyqwoYA==
X-Google-Smtp-Source: ABdhPJzxq1c9JigDVrS42THmZTWZeFAgfMyVfSNwCK+EUYesa8zCQaunBd0jytbwhye3B13DjvZOhA==
X-Received: by 2002:a05:6402:1d92:: with SMTP id dk18mr2705911edb.206.1598015769483;
        Fri, 21 Aug 2020 06:16:09 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id v4sm1299748eje.39.2020.08.21.06.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 06:16:08 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org
Cc:     joro@8bytes.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, eric.auger@redhat.com,
        lorenzo.pieralisi@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 2/6] iommu/virtio: Add topology helpers
Date:   Fri, 21 Aug 2020 15:15:36 +0200
Message-Id: <20200821131540.2801801-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821131540.2801801-1-jean-philippe@linaro.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To support topology description from ACPI and from the builtin
description, add helpers to keep track of I/O topology descriptors.

To ease re-use of the helpers by other drivers and future ACPI
extensions, use the "virt_" prefix rather than "virtio_" when naming
structs and functions.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig                   |   3 +
 drivers/iommu/virtio/Makefile           |   1 +
 drivers/iommu/virtio/topology-helpers.h |  50 ++++++
 include/linux/virt_iommu.h              |  15 ++
 drivers/iommu/virtio/topology-helpers.c | 196 ++++++++++++++++++++++++
 drivers/iommu/virtio/virtio-iommu.c     |   4 +
 MAINTAINERS                             |   1 +
 7 files changed, 270 insertions(+)
 create mode 100644 drivers/iommu/virtio/topology-helpers.h
 create mode 100644 include/linux/virt_iommu.h
 create mode 100644 drivers/iommu/virtio/topology-helpers.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index bef5d75e306b..e29ae50f7100 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -391,4 +391,7 @@ config VIRTIO_IOMMU
 
 	  Say Y here if you intend to run this kernel as a guest.
 
+config VIRTIO_IOMMU_TOPOLOGY_HELPERS
+	bool
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/virtio/Makefile b/drivers/iommu/virtio/Makefile
index 279368fcc074..b42ad47eac7e 100644
--- a/drivers/iommu/virtio/Makefile
+++ b/drivers/iommu/virtio/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
+obj-$(CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS) += topology-helpers.o
diff --git a/drivers/iommu/virtio/topology-helpers.h b/drivers/iommu/virtio/topology-helpers.h
new file mode 100644
index 000000000000..436ca6a900c5
--- /dev/null
+++ b/drivers/iommu/virtio/topology-helpers.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef TOPOLOGY_HELPERS_H_
+#define TOPOLOGY_HELPERS_H_
+
+#ifdef CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS
+
+/* Identify a device node in the topology */
+struct virt_topo_dev_id {
+	unsigned int			type;
+#define VIRT_TOPO_DEV_TYPE_PCI		1
+#define VIRT_TOPO_DEV_TYPE_MMIO		2
+	union {
+		/* PCI endpoint or range */
+		struct {
+			u16		segment;
+			u16		bdf_start;
+			u16		bdf_end;
+		};
+		/* MMIO region */
+		u64			base;
+	};
+};
+
+/* Specification of an IOMMU */
+struct virt_topo_iommu {
+	struct virt_topo_dev_id		dev_id;
+	struct device			*dev; /* transport device */
+	struct fwnode_handle		*fwnode;
+	struct iommu_ops		*ops;
+	struct list_head		list;
+};
+
+/* Specification of an endpoint */
+struct virt_topo_endpoint {
+	struct virt_topo_dev_id		dev_id;
+	u32				endpoint_id;
+	struct virt_topo_iommu		*viommu;
+	struct list_head		list;
+};
+
+void virt_topo_add_endpoint(struct virt_topo_endpoint *ep);
+void virt_topo_add_iommu(struct virt_topo_iommu *viommu);
+
+void virt_topo_set_iommu_ops(struct device *dev, struct iommu_ops *ops);
+
+#else /* !CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS */
+static inline void virt_topo_set_iommu_ops(struct device *dev, struct iommu_ops *ops)
+{ }
+#endif /* !CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS */
+#endif /* TOPOLOGY_HELPERS_H_ */
diff --git a/include/linux/virt_iommu.h b/include/linux/virt_iommu.h
new file mode 100644
index 000000000000..17d2bd4732e0
--- /dev/null
+++ b/include/linux/virt_iommu.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef VIRT_IOMMU_H_
+#define VIRT_IOMMU_H_
+
+#ifdef CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS
+int virt_dma_configure(struct device *dev);
+
+#else /* !CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS */
+static inline int virt_dma_configure(struct device *dev)
+{
+	/* Don't disturb the normal DMA configuration methods */
+	return 0;
+}
+#endif /* !CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS */
+#endif /* VIRT_IOMMU_H_ */
diff --git a/drivers/iommu/virtio/topology-helpers.c b/drivers/iommu/virtio/topology-helpers.c
new file mode 100644
index 000000000000..8815e3a5d431
--- /dev/null
+++ b/drivers/iommu/virtio/topology-helpers.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/dma-iommu.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/virt_iommu.h>
+
+#include "topology-helpers.h"
+
+static LIST_HEAD(viommus);
+static LIST_HEAD(pci_endpoints);
+static LIST_HEAD(mmio_endpoints);
+static DEFINE_MUTEX(viommus_lock);
+
+static bool virt_topo_device_match(struct device *dev,
+				   struct virt_topo_dev_id *id)
+{
+	if (id->type == VIRT_TOPO_DEV_TYPE_PCI && dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+		u16 dev_id = pci_dev_id(pdev);
+
+		return pci_domain_nr(pdev->bus) == id->segment &&
+			dev_id >= id->bdf_start &&
+			dev_id <= id->bdf_end;
+	} else if (id->type == VIRT_TOPO_DEV_TYPE_MMIO &&
+		   dev_is_platform(dev)) {
+		struct platform_device *plat_dev = to_platform_device(dev);
+		struct resource *mem;
+
+		mem = platform_get_resource(plat_dev, IORESOURCE_MEM, 0);
+		if (!mem)
+			return false;
+		return mem->start == id->base;
+	}
+	return false;
+}
+
+static const struct iommu_ops *virt_iommu_setup(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct virt_topo_iommu *viommu = NULL;
+	struct virt_topo_endpoint *ep;
+	struct pci_dev *pci_dev = NULL;
+	u32 epid;
+	int ret;
+
+	/* Already translated? */
+	if (fwspec && fwspec->ops)
+		return NULL;
+
+	mutex_lock(&viommus_lock);
+	if (dev_is_pci(dev)) {
+		pci_dev = to_pci_dev(dev);
+		list_for_each_entry(ep, &pci_endpoints, list) {
+			if (virt_topo_device_match(dev, &ep->dev_id)) {
+				epid = pci_dev_id(pci_dev) -
+					ep->dev_id.bdf_start +
+					ep->endpoint_id;
+				viommu = ep->viommu;
+				break;
+			}
+		}
+	} else if (dev_is_platform(dev)) {
+		list_for_each_entry(ep, &mmio_endpoints, list) {
+			if (virt_topo_device_match(dev, &ep->dev_id)) {
+				epid = ep->endpoint_id;
+				viommu = ep->viommu;
+				break;
+			}
+		}
+	}
+	mutex_unlock(&viommus_lock);
+	if (!viommu)
+		return NULL;
+
+	/* We're not translating ourselves. */
+	if (virt_topo_device_match(dev, &viommu->dev_id) ||
+	    dev == viommu->dev)
+		return NULL;
+
+	/*
+	 * If we found a PCI range managed by the viommu, we're the one that has
+	 * to request ACS.
+	 */
+	if (pci_dev)
+		pci_request_acs();
+
+	if (!viommu->ops)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	ret = iommu_fwspec_init(dev, viommu->fwnode, viommu->ops);
+	if (ret)
+		return ERR_PTR(ret);
+
+	iommu_fwspec_add_ids(dev, &epid, 1);
+
+	return viommu->ops;
+}
+
+/**
+ * virt_topo_add_endpoint - Register endpoint specification
+ * @ep: the endpoint specification
+ */
+void virt_topo_add_endpoint(struct virt_topo_endpoint *ep)
+{
+	mutex_lock(&viommus_lock);
+	list_add(&ep->list,
+		 ep->dev_id.type == VIRT_TOPO_DEV_TYPE_MMIO ?
+		 &mmio_endpoints : &pci_endpoints);
+	mutex_unlock(&viommus_lock);
+}
+
+/**
+ * virt_topo_add_iommu - Register IOMMU specification
+ * @viommu: the IOMMU specification
+ */
+void virt_topo_add_iommu(struct virt_topo_iommu *viommu)
+{
+	mutex_lock(&viommus_lock);
+	list_add(&viommu->list, &viommus);
+	mutex_unlock(&viommus_lock);
+}
+
+/**
+ * virt_dma_configure - Configure DMA of virtualized devices
+ * @dev: the endpoint
+ *
+ * Setup the DMA and IOMMU ops of a virtual device, for platforms without DT or
+ * ACPI.
+ *
+ * Return: -EPROBE_DEFER if the device is managed by an IOMMU that hasn't been
+ *   probed yet, 0 otherwise
+ */
+int virt_dma_configure(struct device *dev)
+{
+	const struct iommu_ops *iommu_ops;
+
+	iommu_ops = virt_iommu_setup(dev);
+	if (IS_ERR_OR_NULL(iommu_ops)) {
+		int ret = PTR_ERR(iommu_ops);
+
+		if (ret == -EPROBE_DEFER || ret == 0)
+			return ret;
+		dev_err(dev, "error %d while setting up virt IOMMU\n", ret);
+		return 0;
+	}
+
+	/*
+	 * If we have reason to believe the IOMMU driver missed the initial
+	 * add_device callback for dev, replay it to get things in order.
+	 */
+	if (dev->bus && !device_iommu_mapped(dev))
+		iommu_probe_device(dev);
+
+	/* Assume coherent, as well as full 64-bit addresses. */
+#ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
+	arch_setup_dma_ops(dev, 0, ~0ULL, iommu_ops, true);
+#else
+	iommu_setup_dma_ops(dev, 0, ~0ULL);
+#endif
+	return 0;
+}
+
+/**
+ * virt_topo_set_iommu_ops - Set the IOMMU ops of a virtual IOMMU device
+ * @dev: the IOMMU device (transport)
+ * @ops: the new IOMMU ops or NULL
+ *
+ * Setup the iommu_ops associated to an IOMMU, once the driver is loaded
+ * and the device probed.
+ */
+void virt_topo_set_iommu_ops(struct device *dev, struct iommu_ops *ops)
+{
+	struct virt_topo_iommu *viommu;
+
+	mutex_lock(&viommus_lock);
+	list_for_each_entry(viommu, &viommus, list) {
+		/*
+		 * In case the topology driver didn't have a dev handle when
+		 * registering the topology, add it now.
+		 */
+		if (!viommu->dev &&
+		    virt_topo_device_match(dev, &viommu->dev_id))
+			viommu->dev = dev;
+
+		if (viommu->dev == dev) {
+			viommu->ops = ops;
+			viommu->fwnode = ops ? dev->fwnode : NULL;
+			break;
+		}
+	}
+	mutex_unlock(&viommus_lock);
+}
+EXPORT_SYMBOL_GPL(virt_topo_set_iommu_ops);
diff --git a/drivers/iommu/virtio/virtio-iommu.c b/drivers/iommu/virtio/virtio-iommu.c
index b4da396cce60..b371d15f837f 100644
--- a/drivers/iommu/virtio/virtio-iommu.c
+++ b/drivers/iommu/virtio/virtio-iommu.c
@@ -25,6 +25,8 @@
 
 #include <uapi/linux/virtio_iommu.h>
 
+#include "topology-helpers.h"
+
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
@@ -1065,6 +1067,7 @@ static int viommu_probe(struct virtio_device *vdev)
 	if (ret)
 		goto err_free_vqs;
 
+	virt_topo_set_iommu_ops(dev->parent, &viommu_ops);
 	iommu_device_set_ops(&viommu->iommu, &viommu_ops);
 	iommu_device_set_fwnode(&viommu->iommu, parent_dev->fwnode);
 
@@ -1111,6 +1114,7 @@ static void viommu_remove(struct virtio_device *vdev)
 {
 	struct viommu_dev *viommu = vdev->priv;
 
+	virt_topo_set_iommu_ops(vdev->dev.parent, NULL);
 	iommu_device_sysfs_remove(&viommu->iommu);
 	iommu_device_unregister(&viommu->iommu);
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 3602b223c9b2..8fd53c22a0ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18452,6 +18452,7 @@ M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
 L:	virtualization@lists.linux-foundation.org
 S:	Maintained
 F:	drivers/iommu/virtio/
+F:	include/linux/virt_iommu.h
 F:	include/uapi/linux/virtio_iommu.h
 
 VIRTIO MEM DRIVER
-- 
2.28.0

