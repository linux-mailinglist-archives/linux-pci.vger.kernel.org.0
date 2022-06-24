Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83008558F95
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 06:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiFXEUQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 00:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiFXEUN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 00:20:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C5F41339;
        Thu, 23 Jun 2022 21:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656044412; x=1687580412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qJOYOhlxmLgSe99rfSeP4YKc+5KJzFUtxXK0PauXKFw=;
  b=jG3l+nAccfyDhFZryJCvmSmCGDewgW5KFV4hv9HDqBoQqSXPdJV2nNF5
   aWTVCid5zcLGCzUvvkQmtdBVkY+pCjtEGAMyGOtrNNO7wY8QQsVTRAgzS
   1lQcaoNY3XmQCazQdoF3JTOl5Rv44pgWqS7E3poUgCtWo6ERWBKhA6OQK
   h0QOUzmv8tizbphlMwL9OHf+EfHxyZ2VbSj4Y85IBg8iiKkkniiYI0FYf
   2ySJkgk7y+42BRveKmaTfKXXCQL6839mUvwD5YQ1+9QSt4u69bu1raY3u
   xSBIR1srmCrp385jcxAmbnv3nyE+gQorK77lSOYargWSlRRUp+d8hyTqw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="367238015"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="367238015"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:12 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="645092929"
Received: from daharell-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.intel.com) ([10.209.66.176])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:12 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, linux-pci@vger.kernel.org,
        patches@lists.linux.dev, hch@lst.de,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 34/46] cxl/region: Add region creation support
Date:   Thu, 23 Jun 2022 21:19:38 -0700
Message-Id: <20220624041950.559155-9-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
per-lifetime of a server instance.

Recall that the major change that CXL brings over previous
persistent memory architectures is the ability to dynamically define new
regions.  Compare that to drivers like 'nfit' where the region
configuration is statically defined by platform firmware.

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
 Documentation/ABI/testing/sysfs-bus-cxl       |  25 +++
 .../driver-api/cxl/memory-devices.rst         |  11 +
 drivers/cxl/Kconfig                           |   5 +
 drivers/cxl/core/Makefile                     |   1 +
 drivers/cxl/core/core.h                       |  12 ++
 drivers/cxl/core/port.c                       |  39 +++-
 drivers/cxl/core/region.c                     | 199 ++++++++++++++++++
 drivers/cxl/cxl.h                             |  18 ++
 tools/testing/cxl/Kbuild                      |   1 +
 9 files changed, 308 insertions(+), 3 deletions(-)
 create mode 100644 drivers/cxl/core/region.c

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 2a4e4163879f..9a4856066631 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -238,3 +238,28 @@ Description:
 		(RO) The number of consecutive bytes of host physical address
 		space this decoder claims at address N before awaint the next
 		address (N + interleave_granularity * intereleave_ways).
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
index 472ec9cb1018..ebe6197fb9b8 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -9,6 +9,18 @@ extern const struct device_type cxl_nvdimm_type;
 
 extern struct attribute_group cxl_base_attribute_group;
 
+#ifdef CONFIG_CXL_REGION
+extern struct device_attribute dev_attr_create_pmem_region;
+extern struct device_attribute dev_attr_delete_region;
+/*
+ * Note must be used at the end of an attribute list, since it
+ * terminates the list in the CONFIG_CXL_REGION=n case.
+ */
+#define CXL_REGION_ATTR(x) (&dev_attr_##x.attr)
+#else
+#define CXL_REGION_ATTR(x) NULL
+#endif
+
 struct cxl_send_command;
 struct cxl_mem_query_commands;
 int cxl_query_cmd(struct cxl_memdev *cxlmd,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 2e56903399c2..c9207ebc3f32 100644
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
+	CXL_REGION_ATTR(create_pmem_region),
+	CXL_REGION_ATTR(delete_region),
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
@@ -387,6 +412,7 @@ static void cxl_root_decoder_release(struct device *dev)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
 
+	memregion_free(atomic_read(&cxlrd->region_id));
 	__cxl_decoder_release(&cxlrd->cxlsd.cxld);
 	kfree(cxlrd);
 }
@@ -1415,6 +1441,7 @@ static struct lock_class_key cxl_decoder_key;
 static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 					     unsigned int nr_targets)
 {
+	struct cxl_root_decoder *cxlrd = NULL;
 	struct cxl_decoder *cxld;
 	struct device *dev;
 	void *alloc;
@@ -1425,16 +1452,20 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 
 	if (nr_targets) {
 		struct cxl_switch_decoder *cxlsd;
-		struct cxl_root_decoder *cxlrd;
 
 		if (is_cxl_root(port)) {
 			alloc = kzalloc(struct_size(cxlrd, cxlsd.target,
 						    nr_targets),
 					GFP_KERNEL);
 			cxlrd = alloc;
-			if (cxlrd)
+			if (cxlrd) {
 				cxlsd = &cxlrd->cxlsd;
-			else
+				atomic_set(&cxlrd->region_id, -1);
+				rc = memregion_alloc(GFP_KERNEL);
+				if (rc < 0)
+					goto err;
+				atomic_set(&cxlrd->region_id, rc);
+			} else
 				cxlsd = NULL;
 		} else {
 			alloc = kzalloc(struct_size(cxlsd, target, nr_targets),
@@ -1490,6 +1521,8 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 
 	return cxld;
 err:
+	if (cxlrd && atomic_read(&cxlrd->region_id) >= 0)
+		memregion_free(atomic_read(&cxlrd->region_id));
 	kfree(alloc);
 	return ERR_PTR(rc);
 }
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
new file mode 100644
index 000000000000..f2a0ead20ca7
--- /dev/null
+++ b/drivers/cxl/core/region.c
@@ -0,0 +1,199 @@
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
+ * @id: memregion id to create
+ * @mode: mode for the endpoint decoders of this region
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
+static struct cxl_region *cxl_find_region_by_name(struct cxl_decoder *cxld,
+						  const char *name)
+{
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
+	struct cxl_port *port = to_cxl_port(dev->parent);
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	struct cxl_region *cxlr;
+
+	cxlr = cxl_find_region_by_name(cxld, buf);
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
index f761cf78cc05..49b73b2e44a9 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -279,13 +279,29 @@ struct cxl_switch_decoder {
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
@@ -434,6 +450,8 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port);
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
-- 
2.36.1

