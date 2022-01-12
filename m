Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D3848CF3E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 00:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbiALXsH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 18:48:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:13987 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235641AbiALXsF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jan 2022 18:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642031285; x=1673567285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RN9M3F/1IKA4m4L9Hh4iWFeC1JI6OdIzY1su0XKvB4Q=;
  b=C5ZOMHev3aj3UXGkhffSpU1iNrAVyb5eesZOM4vm2HxoULfXUTNpYuaa
   2rrJhFVKcj1dTd1NTcwzyukbaWCWjxuFifvmCLnNo0diVYgwdoL2hEHku
   US91GFfy3o+kwvL2v6Cv99ZX4H+5yx9h00jTua1rP8LouuGEeLcnuNqvY
   eqvzdSGJDFcZW+QHw0T13E4+TzJWe2jySEj026+xzmSv4FZibKwt1hvyR
   c2C1fjS8Yg1Jxq8NzM8Vz65PExt13odkmm971paJglkt4C8Syi9SROzmn
   r5cFLLkmeoqAviI3Q7QSdfWSi+CxB12sY3OpNBx7Ddbeppe50HJwk/Hrf
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="242695326"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="242695326"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:48:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="670324176"
Received: from jmaclean-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.136.131])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:48:04 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-pci@vger.kernel.org
Cc:     patches@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 03/15] cxl/region: Add region creation ABI
Date:   Wed, 12 Jan 2022 15:47:37 -0800
Message-Id: <20220112234749.1965960-4-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112234749.1965960-1-ben.widawsky@intel.com>
References: <20220112234749.1965960-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Regions are created as a child of the decoder that encompasses an
address space with constraints. Regions have a number of attributes that
must be configured before the region can be activated.

The ABI is not meant to be secure, but is meant to avoid accidental
races. As a result, a buggy process may create a region by name that was
allocated by a different process. However, multiple processes which are
trying not to race with each other shouldn't need special
synchronization to do so.

// Allocate a new region name
region=$(cat /sys/bus/cxl/devices/decoder0.0/create_region)

// Create a new region by name
echo $region > /sys/bus/cxl/devices/decoder0.0/create_region

// Region now exists in sysfs
stat -t /sys/bus/cxl/devices/decoder0.0/$region

// Delete the region, and name
echo $region > /sys/bus/cxl/devices/decoder0.0/delete_region

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl       |  23 ++
 .../driver-api/cxl/memory-devices.rst         |  11 +
 drivers/cxl/core/Makefile                     |   1 +
 drivers/cxl/core/core.h                       |   3 +
 drivers/cxl/core/port.c                       |  16 ++
 drivers/cxl/core/region.c                     | 209 ++++++++++++++++++
 drivers/cxl/cxl.h                             |   9 +
 drivers/cxl/region.h                          |  38 ++++
 tools/testing/cxl/Kbuild                      |   1 +
 9 files changed, 311 insertions(+)
 create mode 100644 drivers/cxl/core/region.c
 create mode 100644 drivers/cxl/region.h

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 498ae288e143..0fbdd8613654 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -136,3 +136,26 @@ Description:
 		memory (type-3). The 'target_type' attribute indicates the
 		current setting which may dynamically change based on what
 		memory regions are activated in this decode hierarchy.
+
+What:		/sys/bus/cxl/devices/decoderX.Y/create_region
+Date:		November, 2021
+KernelVersion:	v5.17
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		Creates a new CXL region. Writing a value of the form
+		"regionX.Y:Z" will create a new uninitialized region that will
+		be mapped by the CXL decoderX.Y. Reading from this node will
+		return a newly allocated region name. In order to create a
+		region (writing) you must use a value returned from reading the
+		node. Regions must be subsequently configured and bound to a
+		region driver before they can be used.
+
+What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
+Date:		November, 2021
+KernelVersion:	v5.17
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		Deletes the named region. A region must be unbound from the
+		region driver before being deleted. The attributes expects a
+		region in the form "regionX.Y:Z". The region's name, allocated
+		by reading create_region, will also be released.
diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index e101ef02b547..dc756ed23a3a 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -71,6 +71,17 @@ CXL Core
 .. kernel-doc:: drivers/cxl/core/mbox.c
    :doc: cxl mbox
 
+CXL Regions
+-----------
+.. kernel-doc:: drivers/cxl/region.h
+   :identifiers:
+
+.. kernel-doc:: drivers/cxl/core/region.c
+   :doc: cxl core region
+
+.. kernel-doc:: drivers/cxl/core/region.c
+   :identifiers:
+
 External Interfaces
 ===================
 
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 6d37cd78b151..39ce8f2f2373 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_CXL_BUS) += cxl_core.o
 ccflags-y += -I$(srctree)/drivers/cxl
 cxl_core-y := port.o
 cxl_core-y += pmem.o
+cxl_core-y += region.o
 cxl_core-y += regs.o
 cxl_core-y += memdev.o
 cxl_core-y += mbox.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 19d1f9d8ceba..1d4d1699b479 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -10,6 +10,9 @@ extern const struct device_type cxl_memdev_type;
 
 extern struct attribute_group cxl_base_attribute_group;
 
+extern struct device_attribute dev_attr_create_region;
+extern struct device_attribute dev_attr_delete_region;
+
 struct cxl_send_command;
 struct cxl_mem_query_commands;
 int cxl_query_cmd(struct cxl_memdev *cxlmd,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index ecab7cfa88f0..ef3840c50e3e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -196,6 +196,8 @@ static struct attribute_group cxl_decoder_base_attribute_group = {
 };
 
 static struct attribute *cxl_decoder_root_attrs[] = {
+	&dev_attr_create_region.attr,
+	&dev_attr_delete_region.attr,
 	&dev_attr_cap_pmem.attr,
 	&dev_attr_cap_ram.attr,
 	&dev_attr_cap_type2.attr,
@@ -236,11 +238,23 @@ static const struct attribute_group *cxl_decoder_endpoint_attribute_groups[] = {
 	NULL,
 };
 
+static int delete_region(struct device *dev, void *arg)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
+
+	return cxl_delete_region(cxld, dev_name(dev));
+}
+
 static void cxl_decoder_release(struct device *dev)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 	struct cxl_port *port = to_cxl_port(dev->parent);
 
+	device_for_each_child(&cxld->dev, cxld, delete_region);
+
+	dev_WARN_ONCE(dev, !ida_is_empty(&cxld->region_ida),
+		      "Lost track of a region");
+
 	ida_free(&port->decoder_ida, cxld->id);
 	kfree(cxld);
 }
@@ -1021,6 +1035,8 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 	cxld->target_type = CXL_DECODER_EXPANDER;
 	cxld->platform_res = (struct resource)DEFINE_RES_MEM(0, 0);
 
+	ida_init(&cxld->region_ida);
+
 	return cxld;
 err:
 	kfree(cxld);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
new file mode 100644
index 000000000000..e3a82f3c118e
--- /dev/null
+++ b/drivers/cxl/core/region.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/idr.h>
+#include <region.h>
+#include <cxl.h>
+#include "core.h"
+
+/**
+ * DOC: cxl core region
+ *
+ * Regions are managed through the Linux device model. Each region instance is a
+ * unique struct device. CXL core provides functionality to create, destroy, and
+ * configure regions. This is all implemented here. Binding a region
+ * (programming the hardware) is handled by a separate region driver.
+ */
+
+static void cxl_region_release(struct device *dev);
+
+static const struct device_type cxl_region_type = {
+	.name = "cxl_region",
+	.release = cxl_region_release,
+};
+
+static ssize_t create_region_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct cxl_port *port = to_cxl_port(dev->parent);
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	int rc;
+
+	if (dev_WARN_ONCE(dev, !is_root_decoder(dev),
+			  "Invalid decoder selected for region.")) {
+		return -ENODEV;
+	}
+
+	rc = ida_alloc(&cxld->region_ida, GFP_KERNEL);
+	if (rc < 0) {
+		dev_err(&cxld->dev, "Couldn't get a new id\n");
+		return rc;
+	}
+
+	return sysfs_emit(buf, "region%d.%d:%d\n", port->id, cxld->id, rc);
+}
+
+static ssize_t create_region_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
+{
+	struct cxl_port *port = to_cxl_port(dev->parent);
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	int decoder_id, port_id, region_id;
+	struct cxl_region *region;
+	ssize_t rc;
+
+	if (sscanf(buf, "region%d.%d:%d", &port_id, &decoder_id, &region_id) != 3)
+		return -EINVAL;
+
+	if (decoder_id != cxld->id)
+		return -EINVAL;
+
+	if (port_id != port->id)
+		return -EINVAL;
+
+	region = cxl_alloc_region(cxld, region_id);
+	if (IS_ERR(region))
+		return PTR_ERR(region);
+
+	rc = cxl_add_region(cxld, region);
+	if (rc) {
+		kfree(region);
+		return rc;
+	}
+
+	return len;
+}
+DEVICE_ATTR_RW(create_region);
+
+static ssize_t delete_region_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	int rc;
+
+	rc = cxl_delete_region(cxld, buf);
+	if (rc)
+		return rc;
+
+	return len;
+}
+DEVICE_ATTR_WO(delete_region);
+
+struct cxl_region *to_cxl_region(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, dev->type != &cxl_region_type,
+			  "not a cxl_region device\n"))
+		return NULL;
+
+	return container_of(dev, struct cxl_region, dev);
+}
+EXPORT_SYMBOL_GPL(to_cxl_region);
+
+static void cxl_region_release(struct device *dev)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
+	struct cxl_region *region = to_cxl_region(dev);
+
+	ida_free(&cxld->region_ida, region->id);
+	kfree(region);
+}
+
+struct cxl_region *cxl_alloc_region(struct cxl_decoder *cxld, int id)
+{
+	struct cxl_region *region;
+
+	region = kzalloc(sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return ERR_PTR(-ENOMEM);
+
+	region->id = id;
+
+	return region;
+}
+
+/**
+ * cxl_add_region - Adds a region to a decoder
+ * @cxld: Parent decoder.
+ * @region: Region to be added to the decoder.
+ *
+ * This is the second step of region initialization. Regions exist within an
+ * address space which is mapped by a @cxld. That @cxld must be a root decoder,
+ * and it enforces constraints upon the region as it is configured.
+ *
+ * Return: 0 if the region was added to the @cxld, else returns negative error
+ * code. The region will be named "regionX.Y.Z" where X is the port, Y is the
+ * decoder id, and Z is the region number.
+ */
+int cxl_add_region(struct cxl_decoder *cxld, struct cxl_region *region)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct device *dev = &region->dev;
+	int rc;
+
+	device_initialize(dev);
+	dev->parent = &cxld->dev;
+	device_set_pm_not_required(dev);
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_region_type;
+	rc = dev_set_name(dev, "region%d.%d:%d", port->id, cxld->id,
+			  region->id);
+	if (rc)
+		goto err;
+
+	rc = device_add(dev);
+	if (rc)
+		goto err;
+
+	dev_dbg(dev, "Added %s to %s\n", dev_name(dev), dev_name(&cxld->dev));
+
+	return 0;
+
+err:
+	put_device(dev);
+	return rc;
+}
+
+static struct cxl_region *cxl_find_region_by_name(struct cxl_decoder *cxld,
+						  const char *name)
+{
+	struct device *region_dev;
+
+	region_dev = device_find_child_by_name(&cxld->dev, name);
+	if (!region_dev)
+		return ERR_PTR(-ENOENT);
+
+	return to_cxl_region(region_dev);
+}
+
+/**
+ * cxl_delete_region - Deletes a region
+ * @cxld: Parent decoder
+ * @region_name: Named region, ie. regionX.Y:Z
+ */
+int cxl_delete_region(struct cxl_decoder *cxld, const char *region_name)
+{
+	struct cxl_region *region;
+
+	device_lock(&cxld->dev);
+
+	region = cxl_find_region_by_name(cxld, region_name);
+	if (IS_ERR(region)) {
+		device_unlock(&cxld->dev);
+		return PTR_ERR(region);
+	}
+
+	dev_dbg(&cxld->dev, "Requested removal of %s from %s\n",
+		dev_name(&region->dev), dev_name(&cxld->dev));
+
+	device_unregister(&region->dev);
+	device_unlock(&cxld->dev);
+
+	put_device(&region->dev);
+
+	return 0;
+}
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6eeb82711443..79c5781b6173 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -202,6 +202,7 @@ enum cxl_decoder_type {
  * @interleave_granularity: data stride per dport
  * @target_type: accelerator vs expander (type2 vs type3) selector
  * @flags: memory type capabilities and locking
+ * @region_ida: allocator for region ids.
  * @nr_targets: number of elements in @target
  * @target: active ordered target list in current decoder configuration
  */
@@ -216,6 +217,7 @@ struct cxl_decoder {
 	int interleave_granularity;
 	enum cxl_decoder_type target_type;
 	unsigned long flags;
+	struct ida region_ida;
 	const int nr_targets;
 	struct cxl_dport *target[];
 };
@@ -315,6 +317,13 @@ struct cxl_ep {
 	struct list_head list;
 };
 
+bool is_cxl_region(struct device *dev);
+struct cxl_region *to_cxl_region(struct device *dev);
+struct cxl_region *cxl_alloc_region(struct cxl_decoder *cxld,
+				    int interleave_ways);
+int cxl_add_region(struct cxl_decoder *cxld, struct cxl_region *region);
+int cxl_delete_region(struct cxl_decoder *cxld, const char *region);
+
 static inline bool is_cxl_root(struct cxl_port *port)
 {
 	return port->uport == port->dev.parent;
diff --git a/drivers/cxl/region.h b/drivers/cxl/region.h
new file mode 100644
index 000000000000..3e6e5fb35822
--- /dev/null
+++ b/drivers/cxl/region.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2021 Intel Corporation. */
+#ifndef __CXL_REGION_H__
+#define __CXL_REGION_H__
+
+#include <linux/uuid.h>
+
+#include "cxl.h"
+
+/**
+ * struct cxl_region - CXL region
+ * @dev: This region's device.
+ * @id: This regions id. Id is globally unique across all regions.
+ * @list: Node in decoder's region list.
+ * @res: Resource this region carves out of the platform decode range.
+ * @config: HDM decoder program config
+ * @config.size: Size of the region determined from LSA or userspace.
+ * @config.uuid: The UUID for this region.
+ * @config.eniw: Number of interleave ways this region is configured for.
+ * @config.ig: Interleave granularity of region
+ * @config.targets: The memory devices comprising the region.
+ */
+struct cxl_region {
+	struct device dev;
+	int id;
+	struct list_head list;
+	struct resource *res;
+
+	struct {
+		u64 size;
+		uuid_t uuid;
+		int eniw;
+		int ig;
+		struct cxl_memdev *targets[CXL_DECODER_MAX_INTERLEAVE];
+	} config;
+};
+
+#endif
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 8b20e34090f7..73735f561c89 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -43,6 +43,7 @@ cxl_core-y += $(CXL_CORE_SRC)/memdev.o
 cxl_core-y += $(CXL_CORE_SRC)/mbox.o
 cxl_core-y += $(CXL_CORE_SRC)/pci.o
 cxl_core-y += $(CXL_CORE_SRC)/hdm.o
+cxl_core-y += $(CXL_CORE_SRC)/region.o
 cxl_core-y += config_check.o
 
 obj-m += test/
-- 
2.34.1

