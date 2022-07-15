Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DC057586D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 02:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbiGOAEe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 20:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241085AbiGOAEa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 20:04:30 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D359735AE;
        Thu, 14 Jul 2022 17:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657843464; x=1689379464;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U+7MkLAHurf3f2Fjf7LARlOGChHtsfQEBW7wJ4w68qo=;
  b=OUVnTBbepTBnCJz+py4P4RRxVAXMXrRHI9NyPMwvOhuB/LP/rjWDsnA0
   WMLsn1fdMMqjOTnN0LqlyAefLL6DHxWqGujnwKeXt+Xwb3gBDrJbamR85
   9Ti86AjmznbLDFQoODQ/g+EwGxXRxVsm6vRXuB/xMTVw6F5t2b7o8L0QH
   YW3tl3l4B8ya/0Vi0L0mahFaGXMxP7Y3KnZJgJ6GV9Nt/j5/BrjF4/aD5
   TA5+imn9eLKxkFuiagDlK7bxqqSjlGaNCMlDlm+eKGJ5OMVFhSQubHg2L
   VtZoEtg6j61tdhqZ9o7+BNbnb+ZH3zLWFn1kDkp8IW5h+bLimlvhakyBA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="283220513"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="283220513"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:02:31 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="663985220"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:02:30 -0700
Subject: [PATCH v2 19/28] cxl/region: Add interleave geometry attributes
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>, hch@lst.de,
        nvdimm@lists.linux.dev, linux-pci@vger.kernel.org
Date:   Thu, 14 Jul 2022 17:02:30 -0700
Message-ID: <165784335054.1758207.5368288630288141162.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Widawsky <bwidawsk@kernel.org>

Add ABI to allow the number of devices that comprise a region to be
set as well as the interleave granularity for the region.

Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
[djbw: reword changelog]
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://lore.kernel.org/r/20220624041950.559155-11-dan.j.williams@intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |   21 +++++
 drivers/cxl/core/region.c               |  128 +++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h                       |   33 ++++++++
 3 files changed, 182 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 0760b8402c23..bfa42bcc8383 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -292,3 +292,24 @@ Description:
 		(RW) Write a unique identifier for the region. This field must
 		be set for persistent regions and it must not conflict with the
 		UUID of another region.
+
+
+What:		/sys/bus/cxl/devices/regionZ/interleave_granularity
+Date:		May, 2022
+KernelVersion:	v5.20
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RW) Set the number of consecutive bytes each device in the
+		interleave set will claim. The possible interleave granularity
+		values are determined by the CXL spec and the participating
+		devices.
+
+
+What:		/sys/bus/cxl/devices/regionZ/interleave_ways
+Date:		May, 2022
+KernelVersion:	v5.20
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RW) Configures the number of devices participating in the
+		region is set by writing this value. Each device will provide
+		1/interleave_ways of storage for the region.
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 22dccb4702e5..3289caa5d882 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/uuid.h>
 #include <linux/idr.h>
+#include <cxlmem.h>
 #include <cxl.h>
 #include "core.h"
 
@@ -21,6 +22,8 @@
  *
  * Region configuration has ordering constraints. UUID may be set at any time
  * but is only visible for persistent regions.
+ * 1. Interleave granularity
+ * 2. Interleave size
  */
 
 /*
@@ -122,8 +125,129 @@ static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
 	return a->mode;
 }
 
+static ssize_t interleave_ways_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region_params *p = &cxlr->params;
+	ssize_t rc;
+
+	rc = down_read_interruptible(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+	rc = sysfs_emit(buf, "%d\n", p->interleave_ways);
+	up_read(&cxl_region_rwsem);
+
+	return rc;
+}
+
+static ssize_t interleave_ways_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region_params *p = &cxlr->params;
+	int rc, val;
+	u8 iw;
+
+	rc = kstrtoint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	rc = ways_to_cxl(val, &iw);
+	if (rc)
+		return rc;
+
+	/*
+	 * Even for x3, x9, and x12 interleaves the region interleave must be a
+	 * power of 2 multiple of the host bridge interleave.
+	 */
+	if (!is_power_of_2(val / cxld->interleave_ways) ||
+	    (val % cxld->interleave_ways)) {
+		dev_dbg(&cxlr->dev, "invalid interleave: %d\n", val);
+		return -EINVAL;
+	}
+
+	rc = down_write_killable(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
+		rc = -EBUSY;
+		goto out;
+	}
+
+	p->interleave_ways = val;
+out:
+	up_write(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+	return len;
+}
+static DEVICE_ATTR_RW(interleave_ways);
+
+static ssize_t interleave_granularity_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region_params *p = &cxlr->params;
+	ssize_t rc;
+
+	rc = down_read_interruptible(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+	rc = sysfs_emit(buf, "%d\n", p->interleave_granularity);
+	up_read(&cxl_region_rwsem);
+
+	return rc;
+}
+
+static ssize_t interleave_granularity_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region_params *p = &cxlr->params;
+	int rc, val;
+	u16 ig;
+
+	rc = kstrtoint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	rc = granularity_to_cxl(val, &ig);
+	if (rc)
+		return rc;
+
+	/* region granularity must be >= root granularity */
+	if (val < cxld->interleave_granularity)
+		return -EINVAL;
+
+	rc = down_write_killable(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
+		rc = -EBUSY;
+		goto out;
+	}
+
+	p->interleave_granularity = val;
+out:
+	up_write(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+	return len;
+}
+static DEVICE_ATTR_RW(interleave_granularity);
+
 static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_uuid.attr,
+	&dev_attr_interleave_ways.attr,
+	&dev_attr_interleave_granularity.attr,
 	NULL,
 };
 
@@ -216,6 +340,8 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 					      enum cxl_decoder_type type)
 {
 	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
 	struct device *dev;
 	int rc;
@@ -223,8 +349,10 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	cxlr = cxl_region_alloc(cxlrd, id);
 	if (IS_ERR(cxlr))
 		return cxlr;
+	p = &cxlr->params;
 	cxlr->mode = mode;
 	cxlr->type = type;
+	p->interleave_granularity = cxld->interleave_granularity;
 
 	dev = &cxlr->dev;
 	rc = dev_set_name(dev, "region%d", id);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index cf2ece363015..a4e65c102bed 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -7,6 +7,7 @@
 #include <linux/libnvdimm.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/log2.h>
 #include <linux/io.h>
 
 /**
@@ -92,6 +93,31 @@ static inline int cxl_to_ways(u8 eniw, unsigned int *val)
 	return 0;
 }
 
+static inline int granularity_to_cxl(int g, u16 *ig)
+{
+	if (g > SZ_16K || g < 256 || !is_power_of_2(g))
+		return -EINVAL;
+	*ig = ilog2(g) - 8;
+	return 0;
+}
+
+static inline int ways_to_cxl(int ways, u8 *iw)
+{
+	if (ways > 16)
+		return -EINVAL;
+	if (is_power_of_2(ways)) {
+		*iw = ilog2(ways);
+		return 0;
+	}
+	if (ways % 3)
+		return -EINVAL;
+	ways /= 3;
+	if (!is_power_of_2(ways))
+		return -EINVAL;
+	*iw = ilog2(ways) + 8;
+	return 0;
+}
+
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
 #define   CXLDEV_CAP_ARRAY_CAP_ID 0
@@ -298,11 +324,14 @@ struct cxl_root_decoder {
 /*
  * enum cxl_config_state - State machine for region configuration
  * @CXL_CONFIG_IDLE: Any sysfs attribute can be written freely
+ * @CXL_CONFIG_INTERLEAVE_ACTIVE: region size has been set, no more
+ * changes to interleave_ways or interleave_granularity
  * @CXL_CONFIG_ACTIVE: All targets have been added the region is now
  * active
  */
 enum cxl_config_state {
 	CXL_CONFIG_IDLE,
+	CXL_CONFIG_INTERLEAVE_ACTIVE,
 	CXL_CONFIG_ACTIVE,
 };
 
@@ -310,12 +339,16 @@ enum cxl_config_state {
  * struct cxl_region_params - region settings
  * @state: allow the driver to lockdown further parameter changes
  * @uuid: unique id for persistent regions
+ * @interleave_ways: number of endpoints in the region
+ * @interleave_granularity: capacity each endpoint contributes to a stripe
  *
  * State transitions are protected by the cxl_region_rwsem
  */
 struct cxl_region_params {
 	enum cxl_config_state state;
 	uuid_t uuid;
+	int interleave_ways;
+	int interleave_granularity;
 };
 
 /**

