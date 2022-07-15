Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C625C575858
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 02:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbiGOADR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 20:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiGOADQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 20:03:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC24F72EFA;
        Thu, 14 Jul 2022 17:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657843394; x=1689379394;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z04oSogVTDjrLHlB/Q0crOZsNJSV9cvtjQD48k1or+g=;
  b=L8AK0sm0b1BWdgc4/lizmsV71wHBVGn+BFvdc2OiPZ2DBO+spPz181O3
   eB5Kv5xxtmo5PSg0lVgwTgCUBDUoA8nsQcK2B+upXfqp5VJqlUXagXV57
   XhNcrjg2rVvihpQyCq/+zvKk0SDyVuIhN5KsbBm/ThDWQ1RLlYPAIkbel
   6p9BI5fj6A4df2foZMu7LId3vOOsrQHXqtdl0wLHCq/ObhxsWfz703+vB
   qix8qXuppDCGSExGI16rvhI5ArImN1w0N6SqScnbz5lFTS7CWBGlGUFEB
   7qsrBjqfn3K7tIV1l4tu2osL+p0Xn/Jr4P/hwxSxUq1lWRj5Cha6seHFf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="265450726"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="265450726"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:02:19 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="628897022"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:02:19 -0700
Subject: [PATCH v2 17/28] cxl/region: Add region creation support
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <bwidawsk@kernel.org>, hch@lst.de,
        nvdimm@lists.linux.dev, linux-pci@vger.kernel.org
Date:   Thu, 14 Jul 2022 17:02:19 -0700
Message-ID: <165784333909.1758207.794374602146306032.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Widawsky <bwidawsk@kernel.org>

CXL 2.0 allows for dynamic provisioning of new memory regions (system
physical address resources like "System RAM" and "Persistent Memory").
Whereas DDR and PMEM resources are conveyed statically at boot, CXL
allows for assembling and instantiating new regions from the available
capacity of CXL memory expanders in the system.

Sysfs with an "echo $region_name > $create_region_attribute" interface
is chosen as the mechanism to initiate the provisioning process. This
was chosen over ioctl() and netlink() to keep the configuration
interface entirely in a pseudo-fs interface, and it was chosen over
configfs since, aside from this one creation event, the interface is
read-mostly. I.e. configfs supports cases where an object is designed to
be provisioned each boot, like an iSCSI storage target, and CXL region
creation is mostly for PMEM regions which are created usually once
per-lifetime of a server instance. This is an improvement over nvdimm
that pre-created "seed" devices that tended to confuse users looking to
determine which devices are active and which are idle.

Recall that the major change that CXL brings over previous persistent
memory architectures is the ability to dynamically define new regions.
Compare that to drivers like 'nfit' where the region configuration is
statically defined by platform firmware.

Regions are created as a child of a root decoder that encompasses an
address space with constraints. When created through sysfs, the root
decoder is explicit. When created from an LSA's region structure a root
decoder will possibly need to be inferred by the driver.

Upon region creation through sysfs, a vacant region is created with a
unique name. Regions have a number of attributes that must be configured
before the region can be bound to the driver where HDM decoder program
is completed.

An example of creating a new region:

- Allocate a new region name:
region=$(cat /sys/bus/cxl/devices/decoder0.0/create_pmem_region)

- Create a new region by name:
while
region=$(cat /sys/bus/cxl/devices/decoder0.0/create_pmem_region)
! echo $region > /sys/bus/cxl/devices/decoder0.0/create_pmem_region
do true; done

- Region now exists in sysfs:
stat -t /sys/bus/cxl/devices/decoder0.0/$region

- Delete the region, and name:
echo $region > /sys/bus/cxl/devices/decoder0.0/delete_region

Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
[djbw: simplify locking, reword changelog]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl         |   25 +++
 Documentation/driver-api/cxl/memory-devices.rst |   11 +
 drivers/cxl/Kconfig                             |    5 +
 drivers/cxl/core/Makefile                       |    1 
 drivers/cxl/core/core.h                         |   10 +
 drivers/cxl/core/port.c                         |   39 ++++
 drivers/cxl/core/region.c                       |  201 +++++++++++++++++++++++
 drivers/cxl/cxl.h                               |   18 ++
 tools/testing/cxl/Kbuild                        |    1 
 9 files changed, 311 insertions(+)
 create mode 100644 drivers/cxl/core/region.c

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 0362ae98218e..b6156a499a5a 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -257,3 +257,28 @@ Description:
 		to the next target in the interleave at address N +
 		interleave_granularity (assuming N is aligned to
 		interleave_granularity).
+
+
+What:		/sys/bus/cxl/devices/decoderX.Y/create_pmem_region
+Date:		May, 2022
+KernelVersion:	v5.20
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RW) Write a string in the form 'regionZ' to start the process
+		of defining a new persistent memory region (interleave-set)
+		within the decode range bounded by root decoder 'decoderX.Y'.
+		The value written must match the current value returned from
+		reading this attribute. An atomic compare exchange operation is
+		done on write to assign the requested id to a region and
+		allocate the region-id for the next creation attempt. EBUSY is
+		returned if the region name written does not match the current
+		cached value.
+
+
+What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
+Date:		May, 2022
+KernelVersion:	v5.20
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) Write a string in the form 'regionZ' to delete that region,
+		provided it is currently idle / not bound to a driver.
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
 
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index f64e3984689f..aa2728de419e 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -102,4 +102,9 @@ config CXL_SUSPEND
 	def_bool y
 	depends on SUSPEND && CXL_MEM
 
+config CXL_REGION
+	bool
+	default CXL_BUS
+	select MEMREGION
+
 endif
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 9d35085d25af..79c7257f4107 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -10,3 +10,4 @@ cxl_core-y += memdev.o
 cxl_core-y += mbox.o
 cxl_core-y += pci.o
 cxl_core-y += hdm.o
+cxl_core-$(CONFIG_CXL_REGION) += region.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 5551b82b2da0..29272df7e212 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -9,6 +9,16 @@ extern const struct device_type cxl_nvdimm_type;
 
 extern struct attribute_group cxl_base_attribute_group;
 
+#ifdef CONFIG_CXL_REGION
+extern struct device_attribute dev_attr_create_pmem_region;
+extern struct device_attribute dev_attr_delete_region;
+#define CXL_REGION_ATTR(x) (&dev_attr_##x.attr)
+#define SET_CXL_REGION_ATTR(x) (&dev_attr_##x.attr),
+#else
+#define CXL_REGION_ATTR(x) NULL
+#define SET_CXL_REGION_ATTR(x)
+#endif
+
 struct cxl_send_command;
 struct cxl_mem_query_commands;
 int cxl_query_cmd(struct cxl_memdev *cxlmd,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 4907db798ad9..89672b126b30 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/memregion.h>
 #include <linux/workqueue.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
@@ -300,11 +301,35 @@ static struct attribute *cxl_decoder_root_attrs[] = {
 	&dev_attr_cap_type2.attr,
 	&dev_attr_cap_type3.attr,
 	&dev_attr_target_list.attr,
+	SET_CXL_REGION_ATTR(create_pmem_region)
+	SET_CXL_REGION_ATTR(delete_region)
 	NULL,
 };
 
+static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
+{
+	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
+
+	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
+}
+
+static umode_t cxl_root_decoder_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
+
+	if (a == CXL_REGION_ATTR(create_pmem_region) && !can_create_pmem(cxlrd))
+		return 0;
+
+	if (a == CXL_REGION_ATTR(delete_region) && !can_create_pmem(cxlrd))
+		return 0;
+
+	return a->mode;
+}
+
 static struct attribute_group cxl_decoder_root_attribute_group = {
 	.attrs = cxl_decoder_root_attrs,
+	.is_visible = cxl_root_decoder_visible,
 };
 
 static const struct attribute_group *cxl_decoder_root_attribute_groups[] = {
@@ -387,6 +412,8 @@ static void cxl_root_decoder_release(struct device *dev)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
 
+	if (atomic_read(&cxlrd->region_id) >= 0)
+		memregion_free(atomic_read(&cxlrd->region_id));
 	__cxl_decoder_release(&cxlrd->cxlsd.cxld);
 	kfree(cxlrd);
 }
@@ -1484,6 +1511,18 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 
 	cxld = &cxlsd->cxld;
 	cxld->dev.type = &cxl_decoder_root_type;
+	/*
+	 * cxl_root_decoder_release() special cases negative ids to
+	 * detect memregion_alloc() failures.
+	 */
+	atomic_set(&cxlrd->region_id, -1);
+	rc = memregion_alloc(GFP_KERNEL);
+	if (rc < 0) {
+		put_device(&cxld->dev);
+		return ERR_PTR(rc);
+	}
+
+	atomic_set(&cxlrd->region_id, rc);
 	return cxlrd;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
new file mode 100644
index 000000000000..6d2a7aa53379
--- /dev/null
+++ b/drivers/cxl/core/region.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+#include <linux/memregion.h>
+#include <linux/genalloc.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/idr.h>
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
+static struct cxl_region *to_cxl_region(struct device *dev);
+
+static void cxl_region_release(struct device *dev)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	memregion_free(cxlr->id);
+	kfree(cxlr);
+}
+
+static const struct device_type cxl_region_type = {
+	.name = "cxl_region",
+	.release = cxl_region_release,
+};
+
+bool is_cxl_region(struct device *dev)
+{
+	return dev->type == &cxl_region_type;
+}
+EXPORT_SYMBOL_NS_GPL(is_cxl_region, CXL);
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
+static void unregister_region(void *dev)
+{
+	device_unregister(dev);
+}
+
+static struct lock_class_key cxl_region_key;
+
+static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int id)
+{
+	struct cxl_region *cxlr;
+	struct device *dev;
+
+	cxlr = kzalloc(sizeof(*cxlr), GFP_KERNEL);
+	if (!cxlr) {
+		memregion_free(id);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	dev = &cxlr->dev;
+	device_initialize(dev);
+	lockdep_set_class(&dev->mutex, &cxl_region_key);
+	dev->parent = &cxlrd->cxlsd.cxld.dev;
+	device_set_pm_not_required(dev);
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_region_type;
+	cxlr->id = id;
+
+	return cxlr;
+}
+
+/**
+ * devm_cxl_add_region - Adds a region to a decoder
+ * @cxlrd: root decoder
+ * @id: memregion id to create, or memregion_free() on failure
+ * @mode: mode for the endpoint decoders of this region
+ * @type: select whether this is an expander or accelerator (type-2 or type-3)
+ *
+ * This is the second step of region initialization. Regions exist within an
+ * address space which is mapped by a @cxlrd.
+ *
+ * Return: 0 if the region was added to the @cxlrd, else returns negative error
+ * code. The region will be named "regionZ" where Z is the unique region number.
+ */
+static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
+					      int id,
+					      enum cxl_decoder_mode mode,
+					      enum cxl_decoder_type type)
+{
+	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
+	struct cxl_region *cxlr;
+	struct device *dev;
+	int rc;
+
+	cxlr = cxl_region_alloc(cxlrd, id);
+	if (IS_ERR(cxlr))
+		return cxlr;
+	cxlr->mode = mode;
+	cxlr->type = type;
+
+	dev = &cxlr->dev;
+	rc = dev_set_name(dev, "region%d", id);
+	if (rc)
+		goto err;
+
+	rc = device_add(dev);
+	if (rc)
+		goto err;
+
+	rc = devm_add_action_or_reset(port->uport, unregister_region, cxlr);
+	if (rc)
+		return ERR_PTR(rc);
+
+	dev_dbg(port->uport, "%s: created %s\n",
+		dev_name(&cxlrd->cxlsd.cxld.dev), dev_name(dev));
+	return cxlr;
+
+err:
+	put_device(dev);
+	return ERR_PTR(rc);
+}
+
+static ssize_t create_pmem_region_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
+
+	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
+}
+
+static ssize_t create_pmem_region_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t len)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
+	struct cxl_region *cxlr;
+	unsigned int id, rc;
+
+	rc = sscanf(buf, "region%u\n", &id);
+	if (rc != 1)
+		return -EINVAL;
+
+	rc = memregion_alloc(GFP_KERNEL);
+	if (rc < 0)
+		return rc;
+
+	if (atomic_cmpxchg(&cxlrd->region_id, id, rc) != id) {
+		memregion_free(rc);
+		return -EBUSY;
+	}
+
+	cxlr = devm_cxl_add_region(cxlrd, id, CXL_DECODER_PMEM,
+				   CXL_DECODER_EXPANDER);
+	if (IS_ERR(cxlr))
+		return PTR_ERR(cxlr);
+
+	return len;
+}
+DEVICE_ATTR_RW(create_pmem_region);
+
+static struct cxl_region *
+cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
+{
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct device *region_dev;
+
+	region_dev = device_find_child_by_name(&cxld->dev, name);
+	if (!region_dev)
+		return ERR_PTR(-ENODEV);
+
+	return to_cxl_region(region_dev);
+}
+
+static ssize_t delete_region_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
+	struct cxl_port *port = to_cxl_port(dev->parent);
+	struct cxl_region *cxlr;
+
+	cxlr = cxl_find_region_by_name(cxlrd, buf);
+	if (IS_ERR(cxlr))
+		return PTR_ERR(cxlr);
+
+	devm_release_action(port->uport, unregister_region, cxlr);
+	put_device(&cxlr->dev);
+
+	return len;
+}
+DEVICE_ATTR_WO(delete_region);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a108d5c288ca..c3696e76306a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -286,13 +286,29 @@ struct cxl_switch_decoder {
 /**
  * struct cxl_root_decoder - Static platform CXL address decoder
  * @res: host / parent resource for region allocations
+ * @region_id: region id for next region provisioning event
  * @cxlsd: base cxl switch decoder
  */
 struct cxl_root_decoder {
 	struct resource *res;
+	atomic_t region_id;
 	struct cxl_switch_decoder cxlsd;
 };
 
+/**
+ * struct cxl_region - CXL region
+ * @dev: This region's device
+ * @id: This region's id. Id is globally unique across all regions
+ * @mode: Endpoint decoder allocation / access mode
+ * @type: Endpoint decoder target type
+ */
+struct cxl_region {
+	struct device dev;
+	int id;
+	enum cxl_decoder_mode mode;
+	enum cxl_decoder_type type;
+};
+
 /**
  * enum cxl_nvdimm_brige_state - state machine for managing bus rescans
  * @CXL_NVB_NEW: Set at bridge create and after cxl_pmem_wq is destroyed
@@ -440,6 +456,8 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port);
 int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm);
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
 
+bool is_cxl_region(struct device *dev);
+
 extern struct bus_type cxl_bus_type;
 
 struct cxl_driver {
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 33543231d453..500be85729cc 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -47,6 +47,7 @@ cxl_core-y += $(CXL_CORE_SRC)/memdev.o
 cxl_core-y += $(CXL_CORE_SRC)/mbox.o
 cxl_core-y += $(CXL_CORE_SRC)/pci.o
 cxl_core-y += $(CXL_CORE_SRC)/hdm.o
+cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
 cxl_core-y += config_check.o
 
 obj-m += test/

