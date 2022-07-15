Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0EA57585E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 02:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241061AbiGOADi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 20:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241057AbiGOADg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 20:03:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277A78E;
        Thu, 14 Jul 2022 17:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657843412; x=1689379412;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6FbC1RR76T/PmytpA5zlyKcB5NyXYoCsVXtwPOxu1jw=;
  b=dATmu0ovREQhMaGEGuM75qdTufRbcMfRY4kBWHmlZylwj8pgqXBfU19a
   zDtGNYaV5U6ZxWpmQtynCCv+/rYk08qvSoM8fGFBpZd+HWO4JwZwv4hx5
   4o44KbyTptTmH/8f9jqAgFKqxGEZHozQ7rcOsz/rP2bj2yTvZK4AnhLNV
   yEAPXQWspWZzItbvKNzdQiuH/QunpYZxXmuLSEgnU7zJDm6+Jvikw9x0j
   F+nh7CUW/XkxRcekMYcA66egKd+jDjMTMclO9//kZh37CleKPBRETbLtC
   ZCvJSoKgfleG0XMZWDeg2vUvwVlvfBzIagFtZpppg4Y4eSCe1g46oSNHe
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286800528"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="286800528"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:02:25 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="685766741"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:02:25 -0700
Subject: [PATCH v2 18/28] cxl/region: Add a 'uuid' attribute
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <bwidawsk@kernel.org>, hch@lst.de,
        nvdimm@lists.linux.dev, linux-pci@vger.kernel.org
Date:   Thu, 14 Jul 2022 17:02:24 -0700
Message-ID: <165784334465.1758207.8224025435884752570.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

The process of provisioning a region involves triggering the creation of
a new region object, pouring in the configuration, and then binding that
configured object to the region driver to start its operation. For
persistent memory regions the CXL specification mandates that it
identified by a uuid. Add an ABI for userspace to specify a region's
uuid.

Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
[djbw: simplify locking]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |   10 +++
 drivers/cxl/core/region.c               |  118 +++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h                       |   25 +++++++
 3 files changed, 153 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index b6156a499a5a..0760b8402c23 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -282,3 +282,13 @@ Contact:	linux-cxl@vger.kernel.org
 Description:
 		(WO) Write a string in the form 'regionZ' to delete that region,
 		provided it is currently idle / not bound to a driver.
+
+
+What:		/sys/bus/cxl/devices/regionZ/uuid
+Date:		May, 2022
+KernelVersion:	v5.20
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RW) Write a unique identifier for the region. This field must
+		be set for persistent regions and it must not conflict with the
+		UUID of another region.
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6d2a7aa53379..22dccb4702e5 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -5,6 +5,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/uuid.h>
 #include <linux/idr.h>
 #include <cxl.h>
 #include "core.h"
@@ -17,10 +18,126 @@
  * Memory ranges, Regions represent the active mapped capacity by the HDM
  * Decoder Capability structures throughout the Host Bridges, Switches, and
  * Endpoints in the topology.
+ *
+ * Region configuration has ordering constraints. UUID may be set at any time
+ * but is only visible for persistent regions.
+ */
+
+/*
+ * All changes to the interleave configuration occur with this lock held
+ * for write.
  */
+static DECLARE_RWSEM(cxl_region_rwsem);
 
 static struct cxl_region *to_cxl_region(struct device *dev);
 
+static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region_params *p = &cxlr->params;
+	ssize_t rc;
+
+	rc = down_read_interruptible(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+	rc = sysfs_emit(buf, "%pUb\n", &p->uuid);
+	up_read(&cxl_region_rwsem);
+
+	return rc;
+}
+
+static int is_dup(struct device *match, void *data)
+{
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	uuid_t *uuid = data;
+
+	if (!is_cxl_region(match))
+		return 0;
+
+	lockdep_assert_held(&cxl_region_rwsem);
+	cxlr = to_cxl_region(match);
+	p = &cxlr->params;
+
+	if (uuid_equal(&p->uuid, uuid)) {
+		dev_dbg(match, "already has uuid: %pUb\n", uuid);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region_params *p = &cxlr->params;
+	uuid_t temp;
+	ssize_t rc;
+
+	if (len != UUID_STRING_LEN + 1)
+		return -EINVAL;
+
+	rc = uuid_parse(buf, &temp);
+	if (rc)
+		return rc;
+
+	if (uuid_is_null(&temp))
+		return -EINVAL;
+
+	rc = down_write_killable(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+
+	if (uuid_equal(&p->uuid, &temp))
+		goto out;
+
+	rc = -EBUSY;
+	if (p->state >= CXL_CONFIG_ACTIVE)
+		goto out;
+
+	rc = bus_for_each_dev(&cxl_bus_type, NULL, &temp, is_dup);
+	if (rc < 0)
+		goto out;
+
+	uuid_copy(&p->uuid, &temp);
+out:
+	up_write(&cxl_region_rwsem);
+
+	if (rc)
+		return rc;
+	return len;
+}
+static DEVICE_ATTR_RW(uuid);
+
+static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
+				  int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_DECODER_PMEM)
+		return 0;
+	return a->mode;
+}
+
+static struct attribute *cxl_region_attrs[] = {
+	&dev_attr_uuid.attr,
+	NULL,
+};
+
+static const struct attribute_group cxl_region_group = {
+	.attrs = cxl_region_attrs,
+	.is_visible = cxl_region_visible,
+};
+
+static const struct attribute_group *region_groups[] = {
+	&cxl_base_attribute_group,
+	&cxl_region_group,
+	NULL,
+};
+
 static void cxl_region_release(struct device *dev)
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
@@ -32,6 +149,7 @@ static void cxl_region_release(struct device *dev)
 static const struct device_type cxl_region_type = {
 	.name = "cxl_region",
 	.release = cxl_region_release,
+	.groups = region_groups
 };
 
 bool is_cxl_region(struct device *dev)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c3696e76306a..cf2ece363015 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -295,18 +295,43 @@ struct cxl_root_decoder {
 	struct cxl_switch_decoder cxlsd;
 };
 
+/*
+ * enum cxl_config_state - State machine for region configuration
+ * @CXL_CONFIG_IDLE: Any sysfs attribute can be written freely
+ * @CXL_CONFIG_ACTIVE: All targets have been added the region is now
+ * active
+ */
+enum cxl_config_state {
+	CXL_CONFIG_IDLE,
+	CXL_CONFIG_ACTIVE,
+};
+
+/**
+ * struct cxl_region_params - region settings
+ * @state: allow the driver to lockdown further parameter changes
+ * @uuid: unique id for persistent regions
+ *
+ * State transitions are protected by the cxl_region_rwsem
+ */
+struct cxl_region_params {
+	enum cxl_config_state state;
+	uuid_t uuid;
+};
+
 /**
  * struct cxl_region - CXL region
  * @dev: This region's device
  * @id: This region's id. Id is globally unique across all regions
  * @mode: Endpoint decoder allocation / access mode
  * @type: Endpoint decoder target type
+ * @params: active + config params for the region
  */
 struct cxl_region {
 	struct device dev;
 	int id;
 	enum cxl_decoder_mode mode;
 	enum cxl_decoder_type type;
+	struct cxl_region_params params;
 };
 
 /**

