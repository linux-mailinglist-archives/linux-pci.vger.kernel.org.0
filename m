Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2BCD106F88
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 12:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfKVKvN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 05:51:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56070 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbfKVKvL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 05:51:11 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so6914164wmb.5
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2019 02:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aC26ZRBFbmYV70jSo1HKJJ7IjzbboDUYJkvkZ3EdYLg=;
        b=vfaDiLT7EtBRsRXW4Zgm+1DrCHnQDwDqHpLwRYu5XOUtKTalNxQZgX9tAqVJjvg7r6
         LgZk39/YvtK71zxYp6NS58JLske+P7l3rl3zVLu4Cd4zeVP6dj9x/ISOAEo7oNTMd6qS
         XolSSPHxVb9lKQ1b0C9qxFbBAHSICl1Ml0n22n6MAt916pi+sExNtOoYjESps6GFd9bR
         4X44ci9NZHVdxQyOXYl2JlVPNX6oEb5vJDoEXR/bRRs30Ozu2Kzy2zOfoPqcWclfwFXe
         eV6DVfH8u652cASKVFeqzXATGvPEHCWbFo1ZDIdOEre3ZuXRUN9ySrOmlpGZ1JnsU6j8
         hX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aC26ZRBFbmYV70jSo1HKJJ7IjzbboDUYJkvkZ3EdYLg=;
        b=XrH9pdK7gkkrq6GHzxQvJnNDo3GLfwMDcHnvNtNmKQp82zkDPBKV0FSGGt08+RYcyL
         oYk2KgjJ8jBnFD70cQB5r5JhbTG09s+WeWHEGGv9hfCDzsaz87NvLgoAJXFl0PZ2GQfH
         wBfBB27P5Mq/bXBCwPUbOpstO+cPoCwFAymtVB/Ab/zjlFzwlYAN7qor723IjoW+y+mf
         UfMKz5yCze6GJ2xGEFIhxMRN6pjkojODSV5wDD4LH5YQ/6BAAGAvIBq+4bQiAOgTYZ+N
         Hu+EbdG6qubmBdUiXPN7OnIe/Uh0TDxT7o1SRCmzYvXIRjDkKZZd5Uo7k5voPjlCHRxk
         9IEg==
X-Gm-Message-State: APjAAAVWWaRD+7BwQvSkz44rBqggWAoJMb5CrE2uQghvnYATSAPlgYPp
        Dk1eMKEjCnMUgtQqwMBDUyHwKg==
X-Google-Smtp-Source: APXvYqwl/JTWkXjvxyNRIC06Ln+WPzSWKoYX/wHiOUMJz/VIl9vQ1AJB5MwhK+htUraqSB9dqnSVcA==
X-Received: by 2002:a7b:c006:: with SMTP id c6mr4006022wmb.52.1574419868455;
        Fri, 22 Nov 2019 02:51:08 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
        by smtp.gmail.com with ESMTPSA id o133sm2088197wmb.4.2019.11.22.02.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 02:51:07 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com,
        mst@redhat.com, jasowang@redhat.com, jacob.jun.pan@intel.com,
        eric.auger@redhat.com, sebastien.boeuf@intel.com,
        kevin.tian@intel.com
Subject: [RFC 13/13] iommu/virtio: Add topology description to
Date:   Fri, 22 Nov 2019 11:50:00 +0100
Message-Id: <20191122105000.800410-14-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some hypervisors don't implement either device-tree or ACPI, but still
need a method to describe the IOMMU topology. Read the virtio-iommu
config early and parse the topology description. Hook into the
dma_setup() callbacks to initialize the IOMMU before probing endpoints.

If the virtio-iommu uses the virtio-pci transport, this will only work
if the PCI root complex is the first device probed. We don't currently
support virtio-mmio.

Initially I tried to generate a fake IORT table and feed it to the IORT
driver, in order to avoid rewriting the whole DMA code, but it wouldn't
work with platform endpoints, which are references to items in the ACPI
table on IORT.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

---
Note that we only call virt_dma_configure() if the host didn't provide
either DT or ACPI method. If you want to test this with QEMU, you'll
need to manually disable the acpi_dma_configure() part in pci-driver.c
---
 drivers/base/platform.c               |   3 +
 drivers/iommu/Kconfig                 |   9 +
 drivers/iommu/Makefile                |   1 +
 drivers/iommu/virtio-iommu-topology.c | 410 ++++++++++++++++++++++++++
 drivers/iommu/virtio-iommu.c          |   3 +
 drivers/pci/pci-driver.c              |   3 +
 include/linux/virtio_iommu.h          |  18 ++
 include/uapi/linux/virtio_iommu.h     |  26 ++
 8 files changed, 473 insertions(+)
 create mode 100644 drivers/iommu/virtio-iommu-topology.c
 create mode 100644 include/linux/virtio_iommu.h

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index b230beb6ccb4..70b12c8ef2fb 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -27,6 +27,7 @@
 #include <linux/limits.h>
 #include <linux/property.h>
 #include <linux/kmemleak.h>
+#include <linux/virtio_iommu.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -1257,6 +1258,8 @@ int platform_dma_configure(struct device *dev)
 	} else if (has_acpi_companion(dev)) {
 		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
 		ret = acpi_dma_configure(dev, attr);
+	} else if (IS_ENABLED(CONFIG_VIRTIO_IOMMU_TOPOLOGY)) {
+		ret = virt_dma_configure(dev);
 	}
 
 	return ret;
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e6eb4f238d1a..d02c0d36019d 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -486,4 +486,13 @@ config VIRTIO_IOMMU
 
 	  Say Y here if you intend to run this kernel as a guest.
 
+config VIRTIO_IOMMU_TOPOLOGY
+	bool "Topology properties for the virtio-iommu"
+	depends on VIRTIO_IOMMU
+	help
+	  Enable early probing of the virtio-iommu device, to detect the
+	  topology description.
+
+	  Say Y here if you intend to run this kernel as a guest.
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 4f405f926e73..6b51c4186ebc 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -35,3 +35,4 @@ obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
+obj-$(CONFIG_VIRTIO_IOMMU_TOPOLOGY) += virtio-iommu-topology.o
diff --git a/drivers/iommu/virtio-iommu-topology.c b/drivers/iommu/virtio-iommu-topology.c
new file mode 100644
index 000000000000..ec22510ace3d
--- /dev/null
+++ b/drivers/iommu/virtio-iommu-topology.c
@@ -0,0 +1,410 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/acpi.h>
+#include <linux/acpi_iort.h>
+#include <linux/dma-iommu.h>
+#include <linux/iommu.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/printk.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_iommu.h>
+#include <linux/virtio_pci.h>
+#include <uapi/linux/virtio_iommu.h>
+
+struct viommu_cap_config {
+	u8 pos; /* PCI capability position */
+	u8 bar;
+	u32 length; /* structure size */
+	u32 offset; /* structure offset within the bar */
+};
+
+struct viommu_spec {
+	struct device		*dev; /* transport device */
+	struct fwnode_handle	*fwnode;
+	struct iommu_ops	*ops;
+	struct list_head	topology;
+	struct list_head	list;
+};
+
+struct viommu_topology {
+	union {
+		struct virtio_iommu_topo_head head;
+		struct virtio_iommu_topo_pci_range pci;
+		struct virtio_iommu_topo_endpoint ep;
+	};
+	/* Index into viommu_spec->topology */
+	struct list_head list;
+};
+
+static LIST_HEAD(viommus);
+static DEFINE_MUTEX(viommus_lock);
+
+#define VPCI_FIELD(field) offsetof(struct virtio_pci_cap, field)
+
+static inline int viommu_find_capability(struct pci_dev *dev, u8 cfg_type,
+					 struct viommu_cap_config *cap)
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
+		cap->pos = pos;
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
+/*
+ * Setup the special virtio PCI capability to read one of the config registers
+ */
+static int viommu_switch_pci_cfg(struct pci_dev *dev, int cfg,
+				 struct viommu_cap_config *cap, u32 length,
+				 u32 offset)
+{
+	offset += cap->offset;
+
+	if (offset + length > cap->offset + cap->length) {
+		dev_warn(&dev->dev,
+			 "read of %d bytes at offset 0x%x overflows cap of size %d\n",
+			 length, offset, cap->length);
+		return -EOVERFLOW;
+	}
+
+	pci_write_config_byte(dev, cfg + VPCI_FIELD(bar), cap->bar);
+	pci_write_config_dword(dev, cfg + VPCI_FIELD(length), length);
+	pci_write_config_dword(dev, cfg + VPCI_FIELD(offset), offset);
+	return 0;
+}
+
+static u32 viommu_cread(struct pci_dev *dev, int cfg,
+			struct viommu_cap_config *cap, u32 length, u32 offset)
+{
+	u8 val8;
+	u16 val16;
+	u32 val32;
+	int out = cfg + sizeof(struct virtio_pci_cap);
+
+	if (viommu_switch_pci_cfg(dev, cfg, cap, length, offset))
+		return 0;
+
+	switch (length) {
+	case 1:
+		pci_read_config_byte(dev, out, &val8);
+		return val8;
+	case 2:
+		pci_read_config_word(dev, out, &val16);
+		return val16;
+	case 4:
+		pci_read_config_dword(dev, out, &val32);
+		return val32;
+	default:
+		WARN_ON(1);
+		return 0;
+	}
+}
+
+static void viommu_cwrite(struct pci_dev *dev, int cfg,
+			  struct viommu_cap_config *cap, u32 length, u32 offset,
+			  u32 val)
+{
+	int out = cfg + sizeof(struct virtio_pci_cap);
+
+	if (viommu_switch_pci_cfg(dev, cfg, cap, length, offset))
+		return;
+
+	switch (length) {
+	case 1:
+		pci_write_config_byte(dev, out, (u8)val);
+		break;
+	case 2:
+		pci_write_config_word(dev, out, (u16)val);
+		break;
+	case 4:
+		pci_write_config_dword(dev, out, val);
+		break;
+	default:
+		WARN_ON(1);
+	}
+}
+
+static int viommu_add_topology(struct viommu_spec *viommu_spec,
+			       struct viommu_topology *cap)
+{
+	struct viommu_topology *new = kmemdup(cap, sizeof(*cap), GFP_KERNEL);
+
+	if (!new)
+		return -ENOMEM;
+
+	mutex_lock(&viommus_lock);
+	list_add(&new->list, &viommu_spec->topology);
+	mutex_unlock(&viommus_lock);
+	return 0;
+}
+
+static int viommu_parse_topology(struct pci_dev *dev, int pci_cfg,
+				 struct viommu_cap_config *dev_cfg)
+{
+	u32 offset;
+	struct viommu_topology cap;
+	struct viommu_spec *viommu_spec;
+	int iter = 0; /* Protects against config loop */
+
+	offset = viommu_cread(dev, pci_cfg, dev_cfg, 2,
+			      offsetof(struct virtio_iommu_config,
+				       topo_offset));
+	if (!offset)
+		return 0;
+
+	viommu_spec = kzalloc(sizeof(*viommu_spec), GFP_KERNEL);
+	if (!viommu_spec)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&viommu_spec->topology);
+	viommu_spec->dev = &dev->dev;
+
+	while (offset >= sizeof(struct virtio_iommu_config) && ++iter < 0x10000) {
+		memset(&cap, 0, sizeof(cap));
+
+		cap.head.type = viommu_cread(dev, pci_cfg, dev_cfg, 2, offset);
+		cap.head.next = viommu_cread(dev, pci_cfg, dev_cfg, 2, offset + 2);
+
+		switch (cap.head.type) {
+		case VIRTIO_IOMMU_TOPO_PCI_RANGE:
+			cap.pci.endpoint_start = viommu_cread(dev, pci_cfg,
+							      dev_cfg, 2, offset
+							      + 4);
+			cap.pci.hierarchy = viommu_cread(dev, pci_cfg, dev_cfg,
+							 2, offset + 8);
+			cap.pci.requester_start = viommu_cread(dev, pci_cfg,
+							       dev_cfg, 2,
+							       offset + 10);
+			cap.pci.requester_end = viommu_cread(dev, pci_cfg,
+							     dev_cfg, 2, offset +
+							     12);
+			dev_info(&dev->dev,
+				 "topology: adding PCI range 0x%x [0x%x:0x%x] -> 0x%x\n",
+				 cap.pci.hierarchy, cap.pci.requester_start,
+				 cap.pci.requester_end, cap.pci.endpoint_start);
+			if (viommu_add_topology(viommu_spec, &cap))
+				return -ENOMEM;
+			break;
+		case VIRTIO_IOMMU_TOPO_ENDPOINT:
+			cap.ep.endpoint = viommu_cread(dev, pci_cfg, dev_cfg, 2,
+						       offset + 4);
+			cap.ep.address = viommu_cread(dev, pci_cfg, dev_cfg, 2,
+						      offset + 8);
+			dev_info(&dev->dev,
+				 "topology: adding endpoint 0x%llx -> 0x%x\n",
+				 cap.ep.address, cap.ep.endpoint);
+			if (viommu_add_topology(viommu_spec, &cap))
+				return -ENOMEM;
+			break;
+		default:
+			dev_warn(&dev->dev, "Unknown topo structure 0x%x\n",
+				 cap.head.type);
+			break;
+		}
+
+		offset = cap.head.next;
+	}
+
+	/* TODO: handle device removal */
+	mutex_lock(&viommus_lock);
+	list_add(&viommu_spec->list, &viommus);
+	mutex_unlock(&viommus_lock);
+
+	return 0;
+}
+
+static void viommu_pci_parse_topology(struct pci_dev *dev)
+{
+	int pos;
+	u32 features;
+	struct viommu_cap_config common = {0};
+	struct viommu_cap_config pci_cfg = {0};
+	struct viommu_cap_config dev_cfg = {0};
+
+	pos = viommu_find_capability(dev, VIRTIO_PCI_CAP_COMMON_CFG, &common);
+	if (!pos) {
+		dev_warn(&dev->dev, "common capability not found\n");
+		return;
+	}
+	pos = viommu_find_capability(dev, VIRTIO_PCI_CAP_DEVICE_CFG, &dev_cfg);
+	if (!pos) {
+		dev_warn(&dev->dev, "device config capability not found\n");
+		return;
+	}
+	pos = viommu_find_capability(dev, VIRTIO_PCI_CAP_PCI_CFG, &pci_cfg);
+	if (!pos) {
+		dev_warn(&dev->dev, "PCI config capability not found\n");
+		return;
+	}
+
+	/* Find out if the device supports topology description */
+	viommu_cwrite(dev, pos, &common, 4,
+		      offsetof(struct virtio_pci_common_cfg,
+			       device_feature_select),
+		      0);
+	features = viommu_cread(dev, pos, &common, 4,
+				offsetof(struct virtio_pci_common_cfg,
+					 device_feature));
+	if (!(features & VIRTIO_IOMMU_F_TOPOLOGY)) {
+		dev_dbg(&dev->dev, "device doesn't have topology description");
+		return;
+	}
+
+	viommu_parse_topology(dev, pos, &dev_cfg);
+}
+
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_REDHAT_QUMRANET, 0x1014,
+			viommu_pci_parse_topology);
+
+static const struct iommu_ops *virt_iommu_setup(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	const struct iommu_ops *viommu_ops = NULL;
+	struct fwnode_handle *viommu_fwnode;
+	struct viommu_spec *viommu_spec;
+	struct viommu_topology *topo;
+	struct pci_dev *pdev = NULL;
+	struct device *viommu_dev;
+	bool found = false;
+	u16 devid;
+	u32 eid;
+	int ret;
+
+	/* Already translated? */
+	if (fwspec && fwspec->ops)
+		return fwspec->ops;
+
+	if (dev_is_pci(dev)) {
+		pdev = to_pci_dev(dev);
+		devid = pci_dev_id(pdev);
+	} else {
+		/* TODO: Do something with devres */
+		return NULL;
+	}
+
+	mutex_lock(&viommus_lock);
+	list_for_each_entry(viommu_spec, &viommus, list) {
+		list_for_each_entry(topo, &viommu_spec->topology, list) {
+			if (pdev &&
+			    topo->head.type == VIRTIO_IOMMU_TOPO_PCI_RANGE &&
+			    pci_domain_nr(pdev->bus) == topo->pci.hierarchy &&
+			    devid >= topo->pci.requester_start &&
+			    devid <= topo->pci.requester_end) {
+				found = true;
+				eid = devid - topo->pci.requester_start +
+					topo->pci.endpoint_start;
+				break;
+			} else if (!pdev) {
+				/* TODO: compare address with devres */
+			}
+		}
+		if (found) {
+			viommu_ops = viommu_spec->ops;
+			viommu_fwnode = viommu_spec->fwnode;
+			viommu_dev = viommu_spec->dev;
+			break;
+		}
+	}
+	mutex_unlock(&viommus_lock);
+	if (!found)
+		return NULL;
+
+	/* We're not translating ourselves, that would be silly. */
+	if (viommu_dev == dev)
+		return NULL;
+
+	if (!viommu_ops)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	ret = iommu_fwspec_init(dev, viommu_fwnode, viommu_ops);
+	if (ret)
+		return ERR_PTR(ret);
+
+	iommu_fwspec_add_ids(dev, &eid, 1);
+
+	return viommu_ops;
+}
+
+/**
+ * virt_dma_configure - Configure DMA of virtualized devices
+ * @dev: the endpoint
+ *
+ * An alternative to the ACPI and DT methods to setup DMA and the IOMMU ops of a
+ * virtual device.
+ *
+ * Return: -EPROBE_DEFER if the IOMMU hasn't been loaded yet, 0 otherwise
+ */
+int virt_dma_configure(struct device *dev)
+{
+	const struct iommu_ops *iommu_ops;
+
+	/* TODO: do we need to mess about with the dma_mask as well? */
+	WARN_ON(!dev->dma_mask);
+
+	iommu_ops = virt_iommu_setup(dev);
+	if (IS_ERR(iommu_ops)) {
+		if (PTR_ERR(iommu_ops) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		iommu_ops = NULL;
+	}
+
+	/*
+	 * If we have reason to believe the IOMMU driver missed the initial
+	 * add_device callback for dev, replay it to get things in order.
+	 */
+	if (iommu_ops && dev->bus && !device_iommu_mapped(dev))
+		iommu_probe_device(dev);
+
+#ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
+	/* Assume coherent, as well as full 64-bit addresses. */
+	arch_setup_dma_ops(dev, 0, ~0UL, iommu_ops, true);
+#else
+	if (iommu_ops)
+		iommu_setup_dma_ops(dev, 0, ~0UL);
+#endif
+	return 0;
+}
+
+/**
+ * virt_set_iommu_ops - Set the IOMMU ops of a virtual IOMMU device
+ *
+ * Setup the iommu_ops associated to a viommu_spec, once the driver is loaded
+ * and the device probed.
+ */
+void virt_set_iommu_ops(struct device *dev, struct iommu_ops *ops)
+{
+	struct viommu_spec *viommu_spec;
+
+	mutex_lock(&viommus_lock);
+	list_for_each_entry(viommu_spec, &viommus, list) {
+		if (viommu_spec->dev == dev) {
+			viommu_spec->ops = ops;
+			viommu_spec->fwnode = ops ? dev->fwnode : NULL;
+			break;
+		}
+	}
+	mutex_unlock(&viommus_lock);
+}
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 9847552faecc..f68ee9615b38 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -22,6 +22,7 @@
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <linux/virtio_ids.h>
+#include <linux/virtio_iommu.h>
 #include <linux/wait.h>
 
 #include <uapi/linux/virtio_iommu.h>
@@ -1134,6 +1135,7 @@ static int viommu_probe(struct virtio_device *vdev)
 	if (ret)
 		goto err_sysfs_remove;
 
+	virt_set_iommu_ops(dev->parent, &viommu_ops);
 	iommu_device_set_ops(&viommu->iommu, &viommu_ops);
 	iommu_device_register(&viommu->iommu);
 
@@ -1182,6 +1184,7 @@ static void viommu_remove(struct virtio_device *vdev)
 	struct viommu_dev *viommu = vdev->priv;
 
 	iommu_device_unregister(&viommu->iommu);
+	virt_set_iommu_ops(vdev->dev.parent, NULL);
 	viommu_clear_fwnode(viommu);
 	iommu_device_sysfs_remove(&viommu->iommu);
 
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index a8124e47bf6e..d9b5e902ad18 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -17,6 +17,7 @@
 #include <linux/suspend.h>
 #include <linux/kexec.h>
 #include <linux/of_device.h>
+#include <linux/virtio_iommu.h>
 #include <linux/acpi.h>
 #include "pci.h"
 #include "pcie/portdrv.h"
@@ -1633,6 +1634,8 @@ static int pci_dma_configure(struct device *dev)
 		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
 
 		ret = acpi_dma_configure(dev, acpi_get_dma_attr(adev));
+	} else if (IS_ENABLED(CONFIG_VIRTIO_IOMMU_TOPOLOGY)) {
+		ret = virt_dma_configure(dev);
 	}
 
 	pci_put_host_bridge_device(bridge);
diff --git a/include/linux/virtio_iommu.h b/include/linux/virtio_iommu.h
new file mode 100644
index 000000000000..b700256f1063
--- /dev/null
+++ b/include/linux/virtio_iommu.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef VIRTIO_IOMMU_H_
+#define VIRTIO_IOMMU_H_
+
+#if IS_ENABLED(CONFIG_VIRTIO_IOMMU_TOPOLOGY)
+int virt_dma_configure(struct device *dev);
+void virt_set_iommu_ops(struct device *dev, struct iommu_ops *ops);
+#else /* !CONFIG_VIRTIO_IOMMU_TOPOLOGY */
+static inline int virt_dma_configure(struct device *dev)
+{
+	return -ENODEV;
+}
+
+static inline void virt_set_iommu_ops(struct device *dev, struct iommu_ops *ops)
+{ }
+#endif /* !CONFIG_VIRTIO_IOMMU_TOPOLOGY */
+
+#endif /* VIRTIO_IOMMU_H_ */
diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 237e36a280cb..d3b7cd2a076f 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -16,6 +16,7 @@
 #define VIRTIO_IOMMU_F_BYPASS			3
 #define VIRTIO_IOMMU_F_PROBE			4
 #define VIRTIO_IOMMU_F_MMIO			5
+#define VIRTIO_IOMMU_F_TOPOLOGY			6
 
 struct virtio_iommu_range_64 {
 	__le64					start;
@@ -36,6 +37,31 @@ struct virtio_iommu_config {
 	struct virtio_iommu_range_32		domain_range;
 	/* Probe buffer size */
 	__le32					probe_size;
+	/* Offset to the beginning of the topology table */
+	__le16					topo_offset;
+};
+
+struct virtio_iommu_topo_head {
+	__le16					type;
+	__le16					next;
+};
+
+#define VIRTIO_IOMMU_TOPO_PCI_RANGE		0x0
+#define VIRTIO_IOMMU_TOPO_ENDPOINT		0x1
+
+struct virtio_iommu_topo_pci_range {
+	struct virtio_iommu_topo_head		head;
+	__le32					endpoint_start;
+	__le16					hierarchy;
+	__le16					requester_start;
+	__le16					requester_end;
+	__le16					reserved;
+};
+
+struct virtio_iommu_topo_endpoint {
+	struct virtio_iommu_topo_head		head;
+	__le32					endpoint;
+	__le64					address;
 };
 
 /* Request types */
-- 
2.24.0

