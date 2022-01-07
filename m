Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E88E486EF5
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 01:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344331AbiAGAiM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 19:38:12 -0500
Received: from mga18.intel.com ([134.134.136.126]:59433 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344302AbiAGAiL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Jan 2022 19:38:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641515891; x=1673051891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/syylZOo14vYlDQHHSE6X2vUG3CE228h/UN0o3Wv7+0=;
  b=PWIUDRcIDCa1jnqQdDOi50SKV1RaozOFLLUlrIq8Kib+XgeGgzx4ZlFD
   yj5l3gRBPrLo/YeNcQJCfIAzczeatsTMynrtgLLiVRIOUEPK+tUe/XKmz
   pGOibteo1aWUvqrwGe1UJBEIWp5I5Cm8Y/E8rM0TXoDrJCM9y/zQ+ResT
   qQNs47eTuT2TkeCJJpWEJpXy7+pI4uHrgwggXib2e0INqX5CZBuIOTizu
   s/jlmjVhkrVQC/WMUfzyQ1Go88MqJxIvBUHRdbz+YqGEplkMeWB+rOAYo
   nrDjKGwy+6IVEnGoMGSPWdYzoFh+aR7VfYYNmiEKrvBcmnDevWOsEvkez
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229582023"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="229582023"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:38:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="471123198"
Received: from elenawei-mobl2.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.138.104])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:38:10 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org
Cc:     patches@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 04/13] cxl/region: Introduce concept of region configuration
Date:   Thu,  6 Jan 2022 16:37:47 -0800
Message-Id: <20220107003756.806582-5-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107003756.806582-1-ben.widawsky@intel.com>
References: <20220107003756.806582-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The region creation APIs create a vacant region. Configuring the region
works in the same way as similar subsystems such as devdax. Sysfs attrs
will be provided to allow userspace to configure the region.  Finally
once all configuration is complete, userspace may activate the region.

Introduced here are the most basic attributes needed to configure a
region. Details of these attribute are described in the ABI
Documentation.

A example is provided below:

/sys/bus/cxl/devices/region0.0:0
├── interleave_granularity
├── interleave_ways
├── offset
├── size
├── subsystem -> ../../../../../../bus/cxl
├── target0
├── uevent
└── uuid

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  40 ++++
 drivers/cxl/core/region.c               | 295 ++++++++++++++++++++++++
 2 files changed, 335 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 0fbdd8613654..1a938ad26621 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -159,3 +159,43 @@ Description:
 		region driver before being deleted. The attributes expects a
 		region in the form "regionX.Y:Z". The region's name, allocated
 		by reading create_region, will also be released.
+
+What:		/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/offset
+Date:		November, 2021
+KernelVersion:	v5.17
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) A region resides within an address space that is claimed by
+		a decoder. Region space allocation is handled by the driver, but
+		the offset may be read by userspace tooling in order to
+		determine fragmentation, and available size for new regions.
+
+What:
+/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/{interleave,size,uuid,target[0-15]}
+Date:		November, 2021
+KernelVersion:	v5.17
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RW) Configuring regions requires a minimal set of parameters in
+		order for the subsequent bind operation to succeed. The
+		following parameters are defined:
+
+		==	========================================================
+		interleave_granularity Mandatory. Number of consecutive bytes
+			each device in the interleave set will claim. The
+			possible interleave granularity values are determined by
+			the CXL spec and the participating devices.
+		interleave_ways Mandatory. Number of devices participating in the
+			region. Each device will provide 1/interleave of storage
+			for the region.
+		size	Manadatory. Phsyical address space the region will
+			consume.
+		target  Mandatory. Memory devices are the backing storage for a
+			region. There will be N targets based on the number of
+			interleave ways that the top level decoder is configured
+			for. Each target must be set with a memdev device ie.
+			'mem1'. This attribute only becomes available after
+			setting the 'interleave' attribute.
+		uuid	Optional. A unique identifier for the region. If none is
+			selected, the kernel will create one.
+		==	========================================================
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e3a82f3c118e..26b5ad389cd2 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3,9 +3,12 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/uuid.h>
 #include <linux/idr.h>
 #include <region.h>
+#include <cxlmem.h>
 #include <cxl.h>
 #include "core.h"
 
@@ -18,11 +21,300 @@
  * (programming the hardware) is handled by a separate region driver.
  */
 
+struct cxl_region *to_cxl_region(struct device *dev);
+static const struct attribute_group region_interleave_group;
+
+static bool is_region_active(struct cxl_region *region)
+{
+	/* TODO: Regions can't be activated yet. */
+	return false;
+}
+
+static void remove_target(struct cxl_region *region, int target)
+{
+	struct cxl_memdev *cxlmd;
+
+	cxlmd = region->config.targets[target];
+	if (cxlmd)
+		put_device(&cxlmd->dev);
+	region->config.targets[target] = NULL;
+}
+
+static ssize_t interleave_ways_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+
+	return sysfs_emit(buf, "%d\n", region->config.eniw);
+}
+
+static ssize_t interleave_ways_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+	int ret, prev_eniw;
+	int val;
+
+	prev_eniw = region->config.eniw;
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+	if (ret < 0 || ret > CXL_DECODER_MAX_INTERLEAVE)
+		return -EINVAL;
+
+	region->config.eniw = val;
+
+	ret = sysfs_update_group(&dev->kobj, &region_interleave_group);
+	if (ret < 0)
+		goto err;
+
+	sysfs_notify(&dev->kobj, NULL, "target_interleave");
+
+	while (prev_eniw > region->config.eniw)
+		remove_target(region, --prev_eniw);
+
+	return len;
+
+err:
+	region->config.eniw = prev_eniw;
+	return ret;
+}
+static DEVICE_ATTR_RW(interleave_ways);
+
+static ssize_t interleave_granularity_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+
+	return sysfs_emit(buf, "%d\n", region->config.ig);
+}
+
+static ssize_t interleave_granularity_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+	int val, ret;
+
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+	region->config.ig = val;
+
+	return len;
+}
+static DEVICE_ATTR_RW(interleave_granularity);
+
+static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+	struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
+
+	if (!region->res)
+		return sysfs_emit(buf, "\n");
+
+	return sysfs_emit(buf, "%#llx\n", cxld->platform_res.start - region->res->start);
+}
+static DEVICE_ATTR_RO(offset);
+
+static ssize_t size_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+
+	return sysfs_emit(buf, "%llu\n", region->config.size);
+}
+
+static ssize_t size_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+	unsigned long long val;
+	ssize_t rc;
+
+	rc = kstrtoull(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	device_lock(&region->dev);
+	if (is_region_active(region))
+		rc = -EBUSY;
+	else
+		region->config.size = val;
+	device_unlock(&region->dev);
+
+	return rc ? rc : len;
+}
+static DEVICE_ATTR_RW(size);
+
+static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+
+	return sysfs_emit(buf, "%pUb\n", &region->config.uuid);
+}
+
+static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+	ssize_t rc;
+
+	if (len != UUID_STRING_LEN + 1)
+		return -EINVAL;
+
+	device_lock(&region->dev);
+	if (is_region_active(region))
+		rc = -EBUSY;
+	else
+		rc = uuid_parse(buf, &region->config.uuid);
+	device_unlock(&region->dev);
+
+	return rc ? rc : len;
+}
+static DEVICE_ATTR_RW(uuid);
+
+static struct attribute *region_attrs[] = {
+	&dev_attr_interleave_ways.attr,
+	&dev_attr_interleave_granularity.attr,
+	&dev_attr_offset.attr,
+	&dev_attr_size.attr,
+	&dev_attr_uuid.attr,
+	NULL,
+};
+
+static const struct attribute_group region_group = {
+	.attrs = region_attrs,
+};
+
+static size_t show_targetN(struct cxl_region *region, char *buf, int n)
+{
+	int ret;
+
+	device_lock(&region->dev);
+	if (!region->config.targets[n])
+		ret = sysfs_emit(buf, "\n");
+	else
+		ret = sysfs_emit(buf, "%s\n",
+				 dev_name(&region->config.targets[n]->dev));
+	device_unlock(&region->dev);
+
+	return ret;
+}
+
+static size_t set_targetN(struct cxl_region *region, const char *buf, int n,
+			  size_t len)
+{
+	struct device *memdev_dev;
+	struct cxl_memdev *cxlmd;
+
+	device_lock(&region->dev);
+
+	if (len == 1 || region->config.targets[n])
+		remove_target(region, n);
+
+	/* Remove target special case */
+	if (len == 1) {
+		device_unlock(&region->dev);
+		return len;
+	}
+
+	memdev_dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
+	if (!memdev_dev)
+		return -ENOENT;
+
+	/* reference to memdev held until target is unset or region goes away */
+
+	cxlmd = to_cxl_memdev(memdev_dev);
+	region->config.targets[n] = cxlmd;
+
+	device_unlock(&region->dev);
+
+	return len;
+}
+
+#define TARGET_ATTR_RW(n)                                                      \
+	static ssize_t target##n##_show(                                       \
+		struct device *dev, struct device_attribute *attr, char *buf)  \
+	{                                                                      \
+		return show_targetN(to_cxl_region(dev), buf, (n));             \
+	}                                                                      \
+	static ssize_t target##n##_store(struct device *dev,                   \
+					 struct device_attribute *attr,        \
+					 const char *buf, size_t len)          \
+	{                                                                      \
+		return set_targetN(to_cxl_region(dev), buf, (n), len);         \
+	}                                                                      \
+	static DEVICE_ATTR_RW(target##n)
+
+TARGET_ATTR_RW(0);
+TARGET_ATTR_RW(1);
+TARGET_ATTR_RW(2);
+TARGET_ATTR_RW(3);
+TARGET_ATTR_RW(4);
+TARGET_ATTR_RW(5);
+TARGET_ATTR_RW(6);
+TARGET_ATTR_RW(7);
+TARGET_ATTR_RW(8);
+TARGET_ATTR_RW(9);
+TARGET_ATTR_RW(10);
+TARGET_ATTR_RW(11);
+TARGET_ATTR_RW(12);
+TARGET_ATTR_RW(13);
+TARGET_ATTR_RW(14);
+TARGET_ATTR_RW(15);
+
+static struct attribute *interleave_attrs[] = {
+	&dev_attr_target0.attr,
+	&dev_attr_target1.attr,
+	&dev_attr_target2.attr,
+	&dev_attr_target3.attr,
+	&dev_attr_target4.attr,
+	&dev_attr_target5.attr,
+	&dev_attr_target6.attr,
+	&dev_attr_target7.attr,
+	&dev_attr_target8.attr,
+	&dev_attr_target9.attr,
+	&dev_attr_target10.attr,
+	&dev_attr_target11.attr,
+	&dev_attr_target12.attr,
+	&dev_attr_target13.attr,
+	&dev_attr_target14.attr,
+	&dev_attr_target15.attr,
+	NULL,
+};
+
+static umode_t visible_targets(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct cxl_region *region = to_cxl_region(dev);
+
+	if (n < region->config.eniw)
+		return a->mode;
+	return 0;
+}
+
+static const struct attribute_group region_interleave_group = {
+	.attrs = interleave_attrs,
+	.is_visible = visible_targets,
+};
+
+static const struct attribute_group *region_groups[] = {
+	&region_group,
+	&region_interleave_group,
+	NULL,
+};
+
 static void cxl_region_release(struct device *dev);
 
 static const struct device_type cxl_region_type = {
 	.name = "cxl_region",
 	.release = cxl_region_release,
+	.groups = region_groups
 };
 
 static ssize_t create_region_show(struct device *dev,
@@ -108,8 +400,11 @@ static void cxl_region_release(struct device *dev)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
 	struct cxl_region *region = to_cxl_region(dev);
+	int i;
 
 	ida_free(&cxld->region_ida, region->id);
+	for (i = 0; i < region->config.eniw; i++)
+		remove_target(region, i);
 	kfree(region);
 }
 
-- 
2.34.1

