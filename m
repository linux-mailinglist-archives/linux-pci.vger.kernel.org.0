Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C324BA6FB
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 18:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243653AbiBQRUg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 12:20:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243662AbiBQRUf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 12:20:35 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371D22AEDB6;
        Thu, 17 Feb 2022 09:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645118420; x=1676654420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OK7fDA0dBVfpPzOfXSMQgQsi4WNr2mF12B/wyA/rass=;
  b=ZABvaxj7DslL6jMxOSf334QL+kTgRZNDFjzoIALD59gk68AJzdUoEmGo
   jAsZCRXdr1V9Fg4P87Y1Iu8QjMOLLbPLoXByeiEgk5hmAJUnSOtw2jKV1
   tiRYP8JWrFM8gvjkXId7fe0L06GkzHGe3ofjVFus48hs7tHRJYH+2Y9+w
   ZgGpmpipWvLXZmKQaZJuurWu3eYM/+2kK1Plj1fp/L+6hkYTtTR2fI9AK
   kCZYRa50gALf3+8F/WPdS3fRoqtzFa22tDSzBWD+czaBICphXnzE2xlIF
   kpLWSSN6/eXilUrjqFLaeq4dc67m2J+YTRPfGu7kVgoQ8/OYLPMkHLn88
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231549043"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="231549043"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 09:19:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="634903955"
Received: from lmmcwade-mobl2.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.137.203])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 09:19:39 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     patches@lists.linux.dev, Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, nvdimm@lists.linux.dev,
        linux-pci@vger.kernel.org
Subject: [PATCH v5 01/15] cxl/region: Add region creation ABI
Date:   Thu, 17 Feb 2022 09:19:31 -0800
Message-Id: <20220217171931.740926-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217171057.685705-1-ben.widawsky@intel.com>
References: <20220217171057.685705-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
while
region=$(cat /sys/bus/cxl/devices/decoder0.0/create_region)
! echo $region > /sys/bus/cxl/devices/decoder0.0/create_region
do true; done

// Region now exists in sysfs
stat -t /sys/bus/cxl/devices/decoder0.0/$region

// Delete the region, and name
echo $region > /sys/bus/cxl/devices/decoder0.0/delete_region

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

---
Changes since v4:
- Add the missed base attributes addition

---
 Documentation/ABI/testing/sysfs-bus-cxl       |  23 ++
 .../driver-api/cxl/memory-devices.rst         |  11 +
 drivers/cxl/core/Makefile                     |   1 +
 drivers/cxl/core/core.h                       |   3 +
 drivers/cxl/core/port.c                       |  11 +
 drivers/cxl/core/region.c                     | 213 ++++++++++++++++++
 drivers/cxl/cxl.h                             |   5 +
 drivers/cxl/region.h                          |  23 ++
 tools/testing/cxl/Kbuild                      |   1 +
 9 files changed, 291 insertions(+)
 create mode 100644 drivers/cxl/core/region.c
 create mode 100644 drivers/cxl/region.h

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 7c2b846521f3..e5db45ea70ad 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -163,3 +163,26 @@ Description:
 		memory (type-3). The 'target_type' attribute indicates the
 		current setting which may dynamically change based on what
 		memory regions are activated in this decode hierarchy.
+
+What:		/sys/bus/cxl/devices/decoderX.Y/create_region
+Date:		January, 2022
+KernelVersion:	v5.18
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		Write a value of the form 'regionX.Y:Z' to instantiate a new
+		region within the decode range bounded by decoderX.Y. The value
+		written must match the current value returned from reading this
+		attribute. This behavior lets the kernel arbitrate racing
+		attempts to create a region. The thread that fails to write
+		loops and tries the next value. Regions must be created for root
+		decoders, and must subsequently configured and bound to a region
+		driver before they can be used.
+
+What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
+Date:		January, 2022
+KernelVersion:	v5.18
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		Deletes the named region.  The attribute expects a region in the
+		form "regionX.Y:Z". The region's name, allocated by reading
+		create_region, will also be released.
diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index db476bb170b6..66ddc58a21b1 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -362,6 +362,17 @@ CXL Core
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
index 1a50c0fc399c..adfd42370b28 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -9,6 +9,9 @@ extern const struct device_type cxl_nvdimm_type;
 
 extern struct attribute_group cxl_base_attribute_group;
 
+extern struct device_attribute dev_attr_create_region;
+extern struct device_attribute dev_attr_delete_region;
+
 struct cxl_send_command;
 struct cxl_mem_query_commands;
 int cxl_query_cmd(struct cxl_memdev *cxlmd,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1e785a3affaa..860e91cae29b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -213,6 +213,8 @@ static struct attribute_group cxl_decoder_base_attribute_group = {
 };
 
 static struct attribute *cxl_decoder_root_attrs[] = {
+	&dev_attr_create_region.attr,
+	&dev_attr_delete_region.attr,
 	&dev_attr_cap_pmem.attr,
 	&dev_attr_cap_ram.attr,
 	&dev_attr_cap_type2.attr,
@@ -270,6 +272,8 @@ static void cxl_decoder_release(struct device *dev)
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 	struct cxl_port *port = to_cxl_port(dev->parent);
 
+	ida_free(&cxld->region_ida, cxld->next_region_id);
+	ida_destroy(&cxld->region_ida);
 	ida_free(&port->decoder_ida, cxld->id);
 	kfree(cxld);
 }
@@ -1244,6 +1248,13 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 	cxld->target_type = CXL_DECODER_EXPANDER;
 	cxld->platform_res = (struct resource)DEFINE_RES_MEM(0, 0);
 
+	mutex_init(&cxld->id_lock);
+	ida_init(&cxld->region_ida);
+	rc = ida_alloc(&cxld->region_ida, GFP_KERNEL);
+	if (rc < 0)
+		goto err;
+
+	cxld->next_region_id = rc;
 	return cxld;
 err:
 	kfree(cxld);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
new file mode 100644
index 000000000000..5576952e4aa1
--- /dev/null
+++ b/drivers/cxl/core/region.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
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
+ * CXL Regions represent mapped memory capacity in system physical address
+ * space. Whereas the CXL Root Decoders identify the bounds of potential CXL
+ * Memory ranges, Regions represent the active mapped capacity by the HDM
+ * Decoder Capability structures throughout the Host Bridges, Switches, and
+ * Endpoints in the topology.
+ */
+
+static void cxl_region_release(struct device *dev);
+
+static const struct device_type cxl_region_type = {
+	.name = "cxl_region",
+	.release = cxl_region_release,
+};
+
+static struct cxl_region *to_cxl_region(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, dev->type != &cxl_region_type,
+			  "not a cxl_region device\n"))
+		return NULL;
+
+	return container_of(dev, struct cxl_region, dev);
+}
+
+static struct cxl_region *cxl_region_alloc(struct cxl_decoder *cxld)
+{
+	struct cxl_region *cxlr;
+	struct device *dev;
+
+	cxlr = kzalloc(sizeof(*cxlr), GFP_KERNEL);
+	if (!cxlr)
+		return ERR_PTR(-ENOMEM);
+
+	dev = &cxlr->dev;
+	device_initialize(dev);
+	dev->parent = &cxld->dev;
+	device_set_pm_not_required(dev);
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_region_type;
+
+	return cxlr;
+}
+
+static void unregister_region(void *_cxlr)
+{
+	struct cxl_region *cxlr = _cxlr;
+
+	if (!test_and_set_bit(REGION_DEAD, &cxlr->flags))
+		device_unregister(&cxlr->dev);
+}
+
+/**
+ * devm_cxl_add_region - Adds a region to a decoder
+ * @cxld: Parent decoder.
+ * @cxlr: Region to be added to the decoder.
+ *
+ * This is the second step of region initialization. Regions exist within an
+ * address space which is mapped by a @cxld. That @cxld must be a root decoder,
+ * and it enforces constraints upon the region as it is configured.
+ *
+ * Return: 0 if the region was added to the @cxld, else returns negative error
+ * code. The region will be named "regionX.Y.Z" where X is the port, Y is the
+ * decoder id, and Z is the region number.
+ */
+static struct cxl_region *devm_cxl_add_region(struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct cxl_region *cxlr;
+	struct device *dev;
+	int rc;
+
+	cxlr = cxl_region_alloc(cxld);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	dev = &cxlr->dev;
+
+	cxlr->id = cxld->next_region_id;
+	rc = dev_set_name(dev, "region%d.%d:%d", port->id, cxld->id, cxlr->id);
+	if (rc)
+		goto err_out;
+
+	/* affirm that release will have access to the decoder's region ida  */
+	get_device(&cxld->dev);
+
+	rc = device_add(dev);
+	if (!rc)
+		rc = devm_add_action_or_reset(port->uport, unregister_region,
+					      cxlr);
+	if (rc)
+		goto err_out;
+
+	return cxlr;
+
+err_out:
+	put_device(dev);
+	kfree(cxlr);
+	return ERR_PTR(rc);
+}
+
+static ssize_t create_region_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct cxl_port *port = to_cxl_port(dev->parent);
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+
+	return sysfs_emit(buf, "region%d.%d:%d\n", port->id, cxld->id,
+			  cxld->next_region_id);
+}
+
+static ssize_t create_region_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
+{
+	struct cxl_port *port = to_cxl_port(dev->parent);
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	struct cxl_region *cxlr;
+	int d, p, r, rc = 0;
+
+	if (sscanf(buf, "region%d.%d:%d", &p, &d, &r) != 3)
+		return -EINVAL;
+
+	if (port->id != p || cxld->id != d)
+		return -EINVAL;
+
+	rc = mutex_lock_interruptible(&cxld->id_lock);
+	if (rc)
+		return rc;
+
+	if (cxld->next_region_id != r) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	rc = ida_alloc(&cxld->region_ida, GFP_KERNEL);
+	if (rc < 0) {
+		dev_dbg(dev, "Failed to get next cached id (%d)\n", rc);
+		goto out;
+	}
+
+	cxlr = devm_cxl_add_region(cxld);
+	if (IS_ERR(cxlr)) {
+		rc = PTR_ERR(cxlr);
+		goto out;
+	}
+
+	cxld->next_region_id = rc;
+	dev_dbg(dev, "Created %s\n", dev_name(&cxlr->dev));
+
+out:
+	mutex_unlock(&cxld->id_lock);
+	return rc ? rc : len;
+}
+DEVICE_ATTR_RW(create_region);
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
+static ssize_t delete_region_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
+{
+	struct cxl_port *port = to_cxl_port(dev->parent);
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	struct cxl_region *cxlr;
+
+	cxlr = cxl_find_region_by_name(cxld, buf);
+	if (IS_ERR(cxlr))
+		return PTR_ERR(cxlr);
+
+	/* After this, the region is no longer a child of the decoder. */
+	devm_release_action(port->uport, unregister_region, cxlr);
+
+	/* Release is likely called here, so cxlr is not safe to reference. */
+	put_device(&cxlr->dev);
+	cxlr = NULL;
+
+	dev_dbg(dev, "Deleted %s\n", buf);
+	return len;
+}
+DEVICE_ATTR_WO(delete_region);
+
+static void cxl_region_release(struct device *dev)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	dev_dbg(&cxld->dev, "Releasing %s\n", dev_name(dev));
+	ida_free(&cxld->region_ida, cxlr->id);
+	kfree(cxlr);
+	put_device(&cxld->dev);
+}
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b4047a310340..d5397f7dfcf4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -221,6 +221,8 @@ enum cxl_decoder_type {
  * @target_type: accelerator vs expander (type2 vs type3) selector
  * @flags: memory type capabilities and locking
  * @target_lock: coordinate coherent reads of the target list
+ * @region_ida: allocator for region ids.
+ * @next_region_id: Cached region id for next region.
  * @nr_targets: number of elements in @target
  * @target: active ordered target list in current decoder configuration
  */
@@ -236,6 +238,9 @@ struct cxl_decoder {
 	enum cxl_decoder_type target_type;
 	unsigned long flags;
 	seqlock_t target_lock;
+	struct mutex id_lock;
+	struct ida region_ida;
+	int next_region_id;
 	int nr_targets;
 	struct cxl_dport *target[];
 };
diff --git a/drivers/cxl/region.h b/drivers/cxl/region.h
new file mode 100644
index 000000000000..0016f83bbdfd
--- /dev/null
+++ b/drivers/cxl/region.h
@@ -0,0 +1,23 @@
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
+ * @id: This region's id. Id is globally unique across all regions.
+ * @flags: Flags representing the current state of the region.
+ */
+struct cxl_region {
+	struct device dev;
+	int id;
+	unsigned long flags;
+#define REGION_DEAD 0
+};
+
+#endif
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 82e49ab0937d..3fe6d34e6d59 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -46,6 +46,7 @@ cxl_core-y += $(CXL_CORE_SRC)/memdev.o
 cxl_core-y += $(CXL_CORE_SRC)/mbox.o
 cxl_core-y += $(CXL_CORE_SRC)/pci.o
 cxl_core-y += $(CXL_CORE_SRC)/hdm.o
+cxl_core-y += $(CXL_CORE_SRC)/region.o
 cxl_core-y += config_check.o
 
 obj-m += test/
-- 
2.35.1

