Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8E349EFB3
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 01:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344688AbiA1A3J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 19:29:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:64728 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344636AbiA1A26 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jan 2022 19:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643329738; x=1674865738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6lj81oX7B06c7PykM7fTdzFA6ZxKENp6mQB/oDrHmeE=;
  b=AzuT/mwPMtcaxnUDhTb8lKwc3RV1Odre+2Hf0U2cAs70vPWhd5T6r479
   2k1JMUx9CfpIrxT4expBfwAOmQbLXJ6vAz7/BX+PE2KfbhEDHW20ITPaE
   H+hUq3H7y6Vyu9V/g+duqDCFNxds+HOKoN6R5aE2QkI48wqGX2jFjF6Xw
   8BRGMkTdZvXBm17ntqc8VSL3kmggYIM2kLMjNyXR1y68o9Mz0cb1MntCx
   XnqxLFTCFI6W1n/dQQ98tiFZLLctiD+hswLO6S3cqPqVHafZ0N/tF0CDz
   6kSdSkIp3lHhvIy6yiPrwf0WJthuThq7fIXzSShoNXr7osGpJAiil5Uz7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230580002"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="230580002"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:27:23 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="674909604"
Received: from vrao2-mobl1.gar.corp.intel.com (HELO localhost.localdomain) ([10.252.129.6])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:27:23 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     patches@lists.linux.dev, Ben Widawsky <ben.widawsky@intel.com>,
        kernel test robot <lkp@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, nvdimm@lists.linux.dev,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 02/14] cxl/region: Introduce concept of region configuration
Date:   Thu, 27 Jan 2022 16:26:55 -0800
Message-Id: <20220128002707.391076-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128002707.391076-1-ben.widawsky@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
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
Documentation. Sanity checking of configuration parameters are done at
region binding time. This consolidates all such logic in one place,
rather than being strewn across multiple places.

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

Reported-by: kernel test robot <lkp@intel.com> (v2)
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  40 ++++
 drivers/cxl/core/region.c               | 300 ++++++++++++++++++++++++
 2 files changed, 340 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index dcc728458936..50ba5018014d 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -187,3 +187,43 @@ Description:
 		region driver before being deleted. The attributes expects a
 		region in the form "regionX.Y:Z". The region's name, allocated
 		by reading create_region, will also be released.
+
+What:		/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/offset
+Date:		August, 2021
+KernelVersion:	v5.18
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) A region resides within an address space that is claimed by
+		a decoder. Region space allocation is handled by the driver, but
+		the offset may be read by userspace tooling in order to
+		determine fragmentation, and available size for new regions.
+
+What:
+/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/{interleave,size,uuid,target[0-15]}
+Date:		August, 2021
+KernelVersion:	v5.18
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
index 1a448543db0d..3b48e0469fc7 100644
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
 
@@ -18,11 +21,305 @@
  * (programming the hardware) is handled by a separate region driver.
  */
 
+struct cxl_region *to_cxl_region(struct device *dev);
+static const struct attribute_group region_interleave_group;
+
+static bool is_region_active(struct cxl_region *cxlr)
+{
+	/* TODO: Regions can't be activated yet. */
+	return false;
+}
+
+static void remove_target(struct cxl_region *cxlr, int target)
+{
+	struct cxl_memdev *cxlmd;
+
+	cxlmd = cxlr->config.targets[target];
+	if (cxlmd)
+		put_device(&cxlmd->dev);
+	cxlr->config.targets[target] = NULL;
+}
+
+static ssize_t interleave_ways_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	return sysfs_emit(buf, "%d\n", cxlr->config.interleave_ways);
+}
+
+static ssize_t interleave_ways_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	int ret, prev_iw;
+	int val;
+
+	prev_iw = cxlr->config.interleave_ways;
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+	if (ret < 0 || ret > CXL_DECODER_MAX_INTERLEAVE)
+		return -EINVAL;
+
+	cxlr->config.interleave_ways = val;
+
+	ret = sysfs_update_group(&dev->kobj, &region_interleave_group);
+	if (ret < 0)
+		goto err;
+
+	sysfs_notify(&dev->kobj, NULL, "target_interleave");
+
+	while (prev_iw > cxlr->config.interleave_ways)
+		remove_target(cxlr, --prev_iw);
+
+	return len;
+
+err:
+	cxlr->config.interleave_ways = prev_iw;
+	return ret;
+}
+static DEVICE_ATTR_RW(interleave_ways);
+
+static ssize_t interleave_granularity_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	return sysfs_emit(buf, "%d\n", cxlr->config.interleave_granularity);
+}
+
+static ssize_t interleave_granularity_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	int val, ret;
+
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+	cxlr->config.interleave_granularity = val;
+
+	return len;
+}
+static DEVICE_ATTR_RW(interleave_granularity);
+
+static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	resource_size_t offset;
+
+	if (!cxlr->res)
+		return sysfs_emit(buf, "\n");
+
+	offset = cxld->platform_res.start - cxlr->res->start;
+
+	return sysfs_emit(buf, "%pa\n", &offset);
+}
+static DEVICE_ATTR_RO(offset);
+
+static ssize_t size_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	return sysfs_emit(buf, "%llu\n", cxlr->config.size);
+}
+
+static ssize_t size_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	unsigned long long val;
+	ssize_t rc;
+
+	rc = kstrtoull(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	device_lock(&cxlr->dev);
+	if (is_region_active(cxlr))
+		rc = -EBUSY;
+	else
+		cxlr->config.size = val;
+	device_unlock(&cxlr->dev);
+
+	return rc ? rc : len;
+}
+static DEVICE_ATTR_RW(size);
+
+static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	return sysfs_emit(buf, "%pUb\n", &cxlr->config.uuid);
+}
+
+static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	ssize_t rc;
+
+	if (len != UUID_STRING_LEN + 1)
+		return -EINVAL;
+
+	device_lock(&cxlr->dev);
+	if (is_region_active(cxlr))
+		rc = -EBUSY;
+	else
+		rc = uuid_parse(buf, &cxlr->config.uuid);
+	device_unlock(&cxlr->dev);
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
+static size_t show_targetN(struct cxl_region *cxlr, char *buf, int n)
+{
+	int ret;
+
+	device_lock(&cxlr->dev);
+	if (!cxlr->config.targets[n])
+		ret = sysfs_emit(buf, "\n");
+	else
+		ret = sysfs_emit(buf, "%s\n",
+				 dev_name(&cxlr->config.targets[n]->dev));
+	device_unlock(&cxlr->dev);
+
+	return ret;
+}
+
+static size_t set_targetN(struct cxl_region *cxlr, const char *buf, int n,
+			  size_t len)
+{
+	struct device *memdev_dev;
+	struct cxl_memdev *cxlmd;
+
+	device_lock(&cxlr->dev);
+
+	if (len == 1 || cxlr->config.targets[n])
+		remove_target(cxlr, n);
+
+	/* Remove target special case */
+	if (len == 1) {
+		device_unlock(&cxlr->dev);
+		return len;
+	}
+
+	memdev_dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
+	if (!memdev_dev) {
+		device_unlock(&cxlr->dev);
+		return -ENOENT;
+	}
+
+	/* reference to memdev held until target is unset or region goes away */
+
+	cxlmd = to_cxl_memdev(memdev_dev);
+	cxlr->config.targets[n] = cxlmd;
+
+	device_unlock(&cxlr->dev);
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
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	if (n < cxlr->config.interleave_ways)
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
@@ -108,8 +405,11 @@ static void cxl_region_release(struct device *dev)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
 	struct cxl_region *cxlr = to_cxl_region(dev);
+	int i;
 
 	ida_free(&cxld->region_ida, cxlr->id);
+	for (i = 0; i < cxlr->config.interleave_ways; i++)
+		remove_target(cxlr, i);
 	kfree(cxlr);
 }
 
-- 
2.35.0

