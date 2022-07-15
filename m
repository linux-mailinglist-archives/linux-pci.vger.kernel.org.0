Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378FA575862
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 02:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240954AbiGOAEE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 20:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiGOAED (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 20:04:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24571F2E8;
        Thu, 14 Jul 2022 17:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657843442; x=1689379442;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=86ZN3Qodg4lER5Hi4rU+jkBv0qRvwnJVICGuPoHFcns=;
  b=WEdJ1dDgHr6iQq5D88kXkAtrRN+mmFhLbeWM7NOoT/Mg44pgfFC62kLO
   t/yJtVE+XJehFAKMMYhaIJ9nqt3Syl4H1oTKTMca03bCFRtsBsU4B9im6
   VCbZZas3TNO5wK/IqmtqC8YbFbsauw7lEf2xzOZwFZTfKmn8xSliUGKLB
   Q9cH5qFppSkmdUVqHB0Nl8H04eYxzss5Z+5Is7AFFFp4E0Ay5ejBqLtOp
   /4/NAjAuLzOrdni/0s73ixhZ3ezio9TtmT3AdEjZRrjiOiCoTgSmtsoxZ
   P6R4oDS1VnJRObAesdjtY9OEfaVztRf+8Mc0rsRI3KP7Z3Ni9x5KpNyz7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="266074300"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="266074300"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:02:42 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="623634781"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:02:42 -0700
Subject: [PATCH v2 21/28] cxl/region: Enable the assignment of endpoint
 decoders to regions
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <bwidawsk@kernel.org>, hch@lst.de,
        nvdimm@lists.linux.dev, linux-pci@vger.kernel.org
Date:   Thu, 14 Jul 2022 17:02:41 -0700
Message-ID: <165784336184.1758207.16403282029203949622.stgit@dwillia2-xfh.jf.intel.com>
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

The region provisioning process involves allocating DPA to a set of
endpoint decoders, and HPA plus the region geometry to a region device.
Then the decoder is assigned to the region. At this point several
validation steps can be performed to validate that the decoder is
suitable to participate in the region.

Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |   19 ++
 drivers/cxl/core/core.h                 |    6 +
 drivers/cxl/core/hdm.c                  |   13 +
 drivers/cxl/core/port.c                 |    9 +
 drivers/cxl/core/region.c               |  282 +++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h                       |   11 +
 6 files changed, 338 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 0c6c3da4da5a..94e19e24de8d 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -342,3 +342,22 @@ Description:
 		size attribute, the resulting physical address space determined
 		by the driver is reflected here. It is therefore not useful to
 		read this before writing a value to the size attribute.
+
+
+What:		/sys/bus/cxl/devices/regionZ/target[0..N]
+Date:		May, 2022
+KernelVersion:	v5.20
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RW) Write an endpoint decoder object name to 'targetX' where X
+		is the intended position of the endpoint device in the region
+		interleave and N is the 'interleave_ways' setting for the
+		region. ENXIO is returned if the write results in an impossible
+		to map decode scenario, like the endpoint is unreachable at that
+		position relative to the root decoder interleave. EBUSY is
+		returned if the position in the region is already occupied, or
+		if the region is not in a state to accept interleave
+		configuration changes. EINVAL is returned if the object name is
+		not an endpoint decoder. Once all positions have been
+		successfully written a final validation for decode conflicts is
+		performed before activating the region.
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 29272df7e212..a60ad9f656fd 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -12,9 +12,14 @@ extern struct attribute_group cxl_base_attribute_group;
 #ifdef CONFIG_CXL_REGION
 extern struct device_attribute dev_attr_create_pmem_region;
 extern struct device_attribute dev_attr_delete_region;
+extern struct device_attribute dev_attr_region;
+void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
 #define CXL_REGION_ATTR(x) (&dev_attr_##x.attr)
 #define SET_CXL_REGION_ATTR(x) (&dev_attr_##x.attr),
 #else
+static inline void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
+{
+}
 #define CXL_REGION_ATTR(x) NULL
 #define SET_CXL_REGION_ATTR(x)
 #endif
@@ -34,6 +39,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled);
+extern struct rw_semaphore cxl_dpa_rwsem;
 
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 4a0325b02ca4..81645de1064f 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -17,7 +17,7 @@
  * for enumerating these registers and capabilities.
  */
 
-static DECLARE_RWSEM(cxl_dpa_rwsem);
+DECLARE_RWSEM(cxl_dpa_rwsem);
 
 static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			   int *target_map)
@@ -319,6 +319,11 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 		rc = 0;
 		goto out;
 	}
+	if (cxled->cxld.region) {
+		dev_dbg(dev, "decoder assigned to: %s\n",
+			dev_name(&cxled->cxld.region->dev));
+		goto out;
+	}
 	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
 		dev_dbg(dev, "decoder enabled\n");
 		rc = -EBUSY;
@@ -395,6 +400,12 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 	int rc;
 
 	down_write(&cxl_dpa_rwsem);
+	if (cxled->cxld.region) {
+		dev_dbg(dev, "decoder attached to %s\n",
+			dev_name(&cxled->cxld.region->dev));
+		goto out;
+	}
+
 	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
 		dev_dbg(dev, "decoder enabled\n");
 		rc = -EBUSY;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 89672b126b30..bd0673821d28 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -288,6 +288,7 @@ static struct attribute *cxl_decoder_base_attrs[] = {
 	&dev_attr_locked.attr,
 	&dev_attr_interleave_granularity.attr,
 	&dev_attr_interleave_ways.attr,
+	SET_CXL_REGION_ATTR(region)
 	NULL,
 };
 
@@ -1583,6 +1584,7 @@ struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
 	if (!cxled)
 		return ERR_PTR(-ENOMEM);
 
+	cxled->pos = -1;
 	cxld = &cxled->cxld;
 	rc = cxl_decoder_init(port, cxld);
 	if (rc)	 {
@@ -1687,6 +1689,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, CXL);
 
 static void cxld_unregister(void *dev)
 {
+	struct cxl_endpoint_decoder *cxled;
+
+	if (is_endpoint_decoder(dev)) {
+		cxled = to_cxl_endpoint_decoder(dev);
+		cxl_decoder_kill_region(cxled);
+	}
+
 	device_unregister(dev);
 }
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b1e847827c6b..871bfdbb9bc8 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -24,6 +24,7 @@
  * but is only visible for persistent regions.
  * 1. Interleave granularity
  * 2. Interleave size
+ * 3. Decoder targets
  */
 
 /*
@@ -141,6 +142,8 @@ static ssize_t interleave_ways_show(struct device *dev,
 	return rc;
 }
 
+static const struct attribute_group *get_cxl_region_target_group(void);
+
 static ssize_t interleave_ways_store(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf, size_t len)
@@ -149,7 +152,7 @@ static ssize_t interleave_ways_store(struct device *dev,
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	int rc, val;
+	int rc, val, save;
 	u8 iw;
 
 	rc = kstrtoint(buf, 0, &val);
@@ -178,7 +181,11 @@ static ssize_t interleave_ways_store(struct device *dev,
 		goto out;
 	}
 
+	save = p->interleave_ways;
 	p->interleave_ways = val;
+	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
+	if (rc)
+		p->interleave_ways = save;
 out:
 	up_write(&cxl_region_rwsem);
 	if (rc)
@@ -398,9 +405,262 @@ static const struct attribute_group cxl_region_group = {
 	.is_visible = cxl_region_visible,
 };
 
+static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_endpoint_decoder *cxled;
+	int rc;
+
+	rc = down_read_interruptible(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+
+	if (pos >= p->interleave_ways) {
+		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
+			p->interleave_ways);
+		rc = -ENXIO;
+		goto out;
+	}
+
+	cxled = p->targets[pos];
+	if (!cxled)
+		rc = sysfs_emit(buf, "\n");
+	else
+		rc = sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
+out:
+	up_read(&cxl_region_rwsem);
+
+	return rc;
+}
+
+/*
+ * - Check that the given endpoint is attached to a host-bridge identified
+ *   in the root interleave.
+ */
+static int cxl_region_attach(struct cxl_region *cxlr,
+			     struct cxl_endpoint_decoder *cxled, int pos)
+{
+	struct cxl_region_params *p = &cxlr->params;
+
+	if (cxled->mode == CXL_DECODER_DEAD) {
+		dev_dbg(&cxlr->dev, "%s dead\n", dev_name(&cxled->cxld.dev));
+		return -ENODEV;
+	}
+
+	if (pos >= p->interleave_ways) {
+		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
+			p->interleave_ways);
+		return -ENXIO;
+	}
+
+	if (p->targets[pos] == cxled)
+		return 0;
+
+	if (p->targets[pos]) {
+		struct cxl_endpoint_decoder *cxled_target = p->targets[pos];
+		struct cxl_memdev *cxlmd_target = cxled_to_memdev(cxled_target);
+
+		dev_dbg(&cxlr->dev, "position %d already assigned to %s:%s\n",
+			pos, dev_name(&cxlmd_target->dev),
+			dev_name(&cxled_target->cxld.dev));
+		return -EBUSY;
+	}
+
+	p->targets[pos] = cxled;
+	cxled->pos = pos;
+	p->nr_targets++;
+
+	return 0;
+}
+
+static void cxl_region_detach(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_region *cxlr = cxled->cxld.region;
+	struct cxl_region_params *p;
+
+	lockdep_assert_held_write(&cxl_region_rwsem);
+
+	if (!cxlr)
+		return;
+
+	p = &cxlr->params;
+	get_device(&cxlr->dev);
+
+	if (cxled->pos < 0 || cxled->pos >= p->interleave_ways ||
+	    p->targets[cxled->pos] != cxled) {
+		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+
+		dev_WARN_ONCE(&cxlr->dev, 1, "expected %s:%s at position %d\n",
+			      dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			      cxled->pos);
+		goto out;
+	}
+
+	p->targets[cxled->pos] = NULL;
+	p->nr_targets--;
+
+	/* notify the region driver that one of its targets has deparated */
+	up_write(&cxl_region_rwsem);
+	device_release_driver(&cxlr->dev);
+	down_write(&cxl_region_rwsem);
+out:
+	put_device(&cxlr->dev);
+}
+
+void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
+{
+	down_write(&cxl_region_rwsem);
+	cxled->mode = CXL_DECODER_DEAD;
+	cxl_region_detach(cxled);
+	up_write(&cxl_region_rwsem);
+}
+
+static int attach_target(struct cxl_region *cxlr, const char *decoder, int pos)
+{
+	struct device *dev;
+	int rc;
+
+	dev = bus_find_device_by_name(&cxl_bus_type, NULL, decoder);
+	if (!dev)
+		return -ENODEV;
+
+	if (!is_endpoint_decoder(dev)) {
+		put_device(dev);
+		return -EINVAL;
+	}
+
+	rc = down_write_killable(&cxl_region_rwsem);
+	if (rc)
+		goto out;
+	down_read(&cxl_dpa_rwsem);
+	rc = cxl_region_attach(cxlr, to_cxl_endpoint_decoder(dev), pos);
+	up_read(&cxl_dpa_rwsem);
+	up_write(&cxl_region_rwsem);
+out:
+	put_device(dev);
+	return rc;
+}
+
+static int detach_target(struct cxl_region *cxlr, int pos)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	int rc;
+
+	rc = down_write_killable(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+
+	if (pos >= p->interleave_ways) {
+		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
+			p->interleave_ways);
+		rc = -ENXIO;
+		goto out;
+	}
+
+	if (!p->targets[pos]) {
+		rc = 0;
+		goto out;
+	}
+
+	cxl_region_detach(p->targets[pos]);
+	rc = 0;
+out:
+	up_write(&cxl_region_rwsem);
+	return rc;
+}
+
+static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
+			    size_t len)
+{
+	int rc;
+
+	if (sysfs_streq(buf, "\n"))
+		rc = detach_target(cxlr, pos);
+	else
+		rc = attach_target(cxlr, buf, pos);
+
+	if (rc < 0)
+		return rc;
+	return len;
+}
+
+#define TARGET_ATTR_RW(n)                                              \
+static ssize_t target##n##_show(                                       \
+	struct device *dev, struct device_attribute *attr, char *buf)  \
+{                                                                      \
+	return show_targetN(to_cxl_region(dev), buf, (n));             \
+}                                                                      \
+static ssize_t target##n##_store(struct device *dev,                   \
+				 struct device_attribute *attr,        \
+				 const char *buf, size_t len)          \
+{                                                                      \
+	return store_targetN(to_cxl_region(dev), buf, (n), len);       \
+}                                                                      \
+static DEVICE_ATTR_RW(target##n)
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
+static struct attribute *target_attrs[] = {
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
+static umode_t cxl_region_target_visible(struct kobject *kobj,
+					 struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region_params *p = &cxlr->params;
+
+	if (n < p->interleave_ways)
+		return a->mode;
+	return 0;
+}
+
+static const struct attribute_group cxl_region_target_group = {
+	.attrs = target_attrs,
+	.is_visible = cxl_region_target_visible,
+};
+
+static const struct attribute_group *get_cxl_region_target_group(void)
+{
+	return &cxl_region_target_group;
+}
+
 static const struct attribute_group *region_groups[] = {
 	&cxl_base_attribute_group,
 	&cxl_region_group,
+	&cxl_region_target_group,
 	NULL,
 };
 
@@ -560,6 +820,26 @@ static ssize_t create_pmem_region_store(struct device *dev,
 }
 DEVICE_ATTR_RW(create_pmem_region);
 
+static ssize_t region_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	ssize_t rc;
+
+	rc = down_read_interruptible(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+
+	if (cxld->region)
+		rc = sysfs_emit(buf, "%s\n", dev_name(&cxld->region->dev));
+	else
+		rc = sysfs_emit(buf, "\n");
+	up_read(&cxl_region_rwsem);
+
+	return rc;
+}
+DEVICE_ATTR_RO(region);
+
 static struct cxl_region *
 cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 837bfa67f469..95d74cf425a4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -255,6 +255,7 @@ enum cxl_decoder_type {
  * @interleave_ways: number of cxl_dports in this decode
  * @interleave_granularity: data stride per dport
  * @target_type: accelerator vs expander (type2 vs type3) selector
+ * @region: currently assigned region for this decoder
  * @flags: memory type capabilities and locking
  */
 struct cxl_decoder {
@@ -264,14 +265,20 @@ struct cxl_decoder {
 	int interleave_ways;
 	int interleave_granularity;
 	enum cxl_decoder_type target_type;
+	struct cxl_region *region;
 	unsigned long flags;
 };
 
+/*
+ * CXL_DECODER_DEAD prevents endpoints from being reattached to regions
+ * while cxld_unregister() is running
+ */
 enum cxl_decoder_mode {
 	CXL_DECODER_NONE,
 	CXL_DECODER_RAM,
 	CXL_DECODER_PMEM,
 	CXL_DECODER_MIXED,
+	CXL_DECODER_DEAD,
 };
 
 /**
@@ -280,12 +287,14 @@ enum cxl_decoder_mode {
  * @dpa_res: actively claimed DPA span of this decoder
  * @skip: offset into @dpa_res where @cxld.hpa_range maps
  * @mode: which memory type / access-mode-partition this decoder targets
+ * @pos: interleave position in @cxld.region
  */
 struct cxl_endpoint_decoder {
 	struct cxl_decoder cxld;
 	struct resource *dpa_res;
 	resource_size_t skip;
 	enum cxl_decoder_mode mode;
+	int pos;
 };
 
 /**
@@ -351,6 +360,8 @@ struct cxl_region_params {
 	int interleave_ways;
 	int interleave_granularity;
 	struct resource *res;
+	struct cxl_endpoint_decoder *targets[CXL_DECODER_MAX_INTERLEAVE];
+	int nr_targets;
 };
 
 /**

