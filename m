Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D488575880
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 02:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241097AbiGOAF3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 20:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241114AbiGOAF1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 20:05:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236517390C;
        Thu, 14 Jul 2022 17:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657843524; x=1689379524;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=smKpDNwDgoEnff0IcZhkKXyTjumqxb1p/y234UsFkk0=;
  b=N/5H6a0P+3gC0FJaQRnevY/2JnM1uEmS1qpvwJpTw7k7VASD2GpwR8oN
   8XGphWToXyBMtXd9BuBH0hRqT6cnv1lbl6HukoLm6tCSGZHroQdoE1zCT
   FhBfEsdvI0rr9c/xoHivTwgWAQGme4kCLbMasrY0Rzxyt4v2k0yZVnYlL
   /heNin+K4OPYJJLnDnBcTIGXzc34FfX2xFCuT03hIX75gRqX+h2uaqpLz
   ZAx832CCTqzTMHxY6nZp1LEKrOb52aaZGpPL8JpqcWoAPGLwEI5PDWz6Z
   AIkidXrlsE/qSvnQkdzFgWi0XuFoKfHVx/HXsXM3ARKlqOieC6efD/G/k
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="371978437"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="371978437"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:03:21 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="571303179"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:03:21 -0700
Subject: [PATCH v2 28/28] cxl/region: Introduce cxl_pmem_region objects
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <bwidawsk@kernel.org>, hch@lst.de,
        nvdimm@lists.linux.dev, linux-pci@vger.kernel.org
Date:   Thu, 14 Jul 2022 17:03:21 -0700
Message-ID: <165784340111.1758207.3036498385188290968.stgit@dwillia2-xfh.jf.intel.com>
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

The LIBNVDIMM subsystem is a platform agnostic representation of system
NVDIMM / persistent memory resources. To date, the CXL subsystem's
interaction with LIBNVDIMM has been to register an nvdimm-bridge device
and cxl_nvdimm objects to proxy CXL capabilities into existing LIBNVDIMM
subsystem mechanics.

With regions the approach is the same. Create a new cxl_pmem_region
object to proxy CXL region details into a LIBNVDIMM definition. With
this enabling LIBNVDIMM can partition CXL persistent memory regions with
legacy namespace labels. A follow-on patch will add CXL region label and
CXL namespace label support to persist region configurations across
driver reload / system-reset events.

Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/core.h      |    3 +
 drivers/cxl/core/pmem.c      |    4 -
 drivers/cxl/core/port.c      |    2 
 drivers/cxl/core/region.c    |  142 +++++++++++++++++++++++++
 drivers/cxl/cxl.h            |   36 ++++++
 drivers/cxl/pmem.c           |  238 ++++++++++++++++++++++++++++++++++++++++++
 drivers/nvdimm/region_devs.c |   28 ++++-
 include/linux/libnvdimm.h    |    5 +
 8 files changed, 446 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 391aadf9e7fa..1d8f87be283f 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -13,11 +13,13 @@ extern struct attribute_group cxl_base_attribute_group;
 extern struct device_attribute dev_attr_create_pmem_region;
 extern struct device_attribute dev_attr_delete_region;
 extern struct device_attribute dev_attr_region;
+extern const struct device_type cxl_pmem_region_type;
 extern const struct device_type cxl_region_type;
 void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
 #define CXL_REGION_ATTR(x) (&dev_attr_##x.attr)
 #define CXL_REGION_TYPE(x) (&cxl_region_type)
 #define SET_CXL_REGION_ATTR(x) (&dev_attr_##x.attr),
+#define CXL_PMEM_REGION_TYPE(x) (&cxl_pmem_region_type)
 int cxl_region_init(void);
 void cxl_region_exit(void);
 #else
@@ -34,6 +36,7 @@ static inline void cxl_region_exit(void)
 #define CXL_REGION_ATTR(x) NULL
 #define CXL_REGION_TYPE(x) NULL
 #define SET_CXL_REGION_ATTR(x)
+#define CXL_PMEM_REGION_TYPE(x) NULL
 #endif
 
 struct cxl_send_command;
diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index bec7cfb54ebf..1d12a8206444 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -62,9 +62,9 @@ static int match_nvdimm_bridge(struct device *dev, void *data)
 	return is_cxl_nvdimm_bridge(dev);
 }
 
-struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_nvdimm *cxl_nvd)
+struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct device *start)
 {
-	struct cxl_port *port = find_cxl_root(&cxl_nvd->dev);
+	struct cxl_port *port = find_cxl_root(start);
 	struct device *dev;
 
 	if (!port)
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 194003525397..af65491d878b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -44,6 +44,8 @@ static int cxl_device_id(struct device *dev)
 		return CXL_DEVICE_NVDIMM_BRIDGE;
 	if (dev->type == &cxl_nvdimm_type)
 		return CXL_DEVICE_NVDIMM;
+	if (dev->type == CXL_PMEM_REGION_TYPE())
+		return CXL_DEVICE_PMEM_REGION;
 	if (is_cxl_port(dev)) {
 		if (is_cxl_root(to_cxl_port(dev)))
 			return CXL_DEVICE_ROOT;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 20871bdb6858..23d1a34077be 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1644,6 +1644,139 @@ static ssize_t delete_region_store(struct device *dev,
 }
 DEVICE_ATTR_WO(delete_region);
 
+static void cxl_pmem_region_release(struct device *dev)
+{
+	struct cxl_pmem_region *cxlr_pmem = to_cxl_pmem_region(dev);
+	int i;
+
+	for (i = 0; i < cxlr_pmem->nr_mappings; i++) {
+		struct cxl_memdev *cxlmd = cxlr_pmem->mapping[i].cxlmd;
+
+		put_device(&cxlmd->dev);
+	}
+
+	kfree(cxlr_pmem);
+}
+
+static const struct attribute_group *cxl_pmem_region_attribute_groups[] = {
+	&cxl_base_attribute_group,
+	NULL,
+};
+
+const struct device_type cxl_pmem_region_type = {
+	.name = "cxl_pmem_region",
+	.release = cxl_pmem_region_release,
+	.groups = cxl_pmem_region_attribute_groups,
+};
+
+bool is_cxl_pmem_region(struct device *dev)
+{
+	return dev->type == &cxl_pmem_region_type;
+}
+EXPORT_SYMBOL_NS_GPL(is_cxl_pmem_region, CXL);
+
+struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, !is_cxl_pmem_region(dev),
+			  "not a cxl_pmem_region device\n"))
+		return NULL;
+	return container_of(dev, struct cxl_pmem_region, dev);
+}
+EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, CXL);
+
+static struct lock_class_key cxl_pmem_region_key;
+
+static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_pmem_region *cxlr_pmem;
+	struct device *dev;
+	int i;
+
+	down_read(&cxl_region_rwsem);
+	if (p->state != CXL_CONFIG_COMMIT) {
+		cxlr_pmem = ERR_PTR(-ENXIO);
+		goto out;
+	}
+
+	cxlr_pmem = kzalloc(struct_size(cxlr_pmem, mapping, p->nr_targets),
+			    GFP_KERNEL);
+	if (!cxlr_pmem) {
+		cxlr_pmem = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	cxlr_pmem->hpa_range.start = p->res->start;
+	cxlr_pmem->hpa_range.end = p->res->end;
+
+	/* Snapshot the region configuration underneath the cxl_region_rwsem */
+	cxlr_pmem->nr_mappings = p->nr_targets;
+	for (i = 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+		struct cxl_pmem_region_mapping *m = &cxlr_pmem->mapping[i];
+
+		m->cxlmd = cxlmd;
+		get_device(&cxlmd->dev);
+		m->start = cxled->dpa_res->start;
+		m->size = resource_size(cxled->dpa_res);
+		m->position = i;
+	}
+
+	dev = &cxlr_pmem->dev;
+	cxlr_pmem->cxlr = cxlr;
+	device_initialize(dev);
+	lockdep_set_class(&dev->mutex, &cxl_pmem_region_key);
+	device_set_pm_not_required(dev);
+	dev->parent = &cxlr->dev;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_pmem_region_type;
+out:
+	up_read(&cxl_region_rwsem);
+
+	return cxlr_pmem;
+}
+
+static void cxlr_pmem_unregister(void *dev)
+{
+	device_unregister(dev);
+}
+
+/**
+ * devm_cxl_add_pmem_region() - add a cxl_region-to-nd_region bridge
+ * @cxlr: parent CXL region for this pmem region bridge device
+ *
+ * Return: 0 on success negative error code on failure.
+ */
+static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
+{
+	struct cxl_pmem_region *cxlr_pmem;
+	struct device *dev;
+	int rc;
+
+	cxlr_pmem = cxl_pmem_region_alloc(cxlr);
+	if (IS_ERR(cxlr_pmem))
+		return PTR_ERR(cxlr_pmem);
+
+	dev = &cxlr_pmem->dev;
+	rc = dev_set_name(dev, "pmem_region%d", cxlr->id);
+	if (rc)
+		goto err;
+
+	rc = device_add(dev);
+	if (rc)
+		goto err;
+
+	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
+		dev_name(dev));
+
+	return devm_add_action_or_reset(&cxlr->dev, cxlr_pmem_unregister, dev);
+
+err:
+	put_device(dev);
+	return rc;
+}
+
 static int cxl_region_probe(struct device *dev)
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
@@ -1667,7 +1800,14 @@ static int cxl_region_probe(struct device *dev)
 	 */
 	up_read(&cxl_region_rwsem);
 
-	return rc;
+	switch (cxlr->mode) {
+	case CXL_DECODER_PMEM:
+		return devm_cxl_add_pmem_region(cxlr);
+	default:
+		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
+			cxlr->mode);
+		return -ENXIO;
+	}
 }
 
 static struct cxl_driver cxl_region_driver = {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a32093602df9..8a484acbb32d 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -419,6 +419,25 @@ struct cxl_nvdimm {
 	struct device dev;
 	struct cxl_memdev *cxlmd;
 	struct cxl_nvdimm_bridge *bridge;
+	struct cxl_pmem_region *region;
+};
+
+struct cxl_pmem_region_mapping {
+	struct cxl_memdev *cxlmd;
+	struct cxl_nvdimm *cxl_nvd;
+	u64 start;
+	u64 size;
+	int position;
+};
+
+struct cxl_pmem_region {
+	struct device dev;
+	struct cxl_region *cxlr;
+	struct nd_region *nd_region;
+	struct cxl_nvdimm_bridge *bridge;
+	struct range hpa_range;
+	int nr_mappings;
+	struct cxl_pmem_region_mapping mapping[];
 };
 
 /**
@@ -594,6 +613,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define CXL_DEVICE_ROOT			4
 #define CXL_DEVICE_MEMORY_EXPANDER	5
 #define CXL_DEVICE_REGION		6
+#define CXL_DEVICE_PMEM_REGION		7
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
@@ -605,7 +625,21 @@ struct cxl_nvdimm *to_cxl_nvdimm(struct device *dev);
 bool is_cxl_nvdimm(struct device *dev);
 bool is_cxl_nvdimm_bridge(struct device *dev);
 int devm_cxl_add_nvdimm(struct device *host, struct cxl_memdev *cxlmd);
-struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_nvdimm *cxl_nvd);
+struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct device *dev);
+
+#ifdef CONFIG_CXL_REGION
+bool is_cxl_pmem_region(struct device *dev);
+struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
+#else
+static inline bool is_cxl_pmem_region(struct device *dev)
+{
+	return false;
+}
+static inline struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
+{
+	return NULL;
+}
+#endif
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index b271f6e90b91..e69f99a0747d 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -7,6 +7,7 @@
 #include <linux/ndctl.h>
 #include <linux/async.h>
 #include <linux/slab.h>
+#include <linux/nd.h>
 #include "cxlmem.h"
 #include "cxl.h"
 
@@ -27,6 +28,19 @@ static void clear_exclusive(void *cxlds)
 static void unregister_nvdimm(void *nvdimm)
 {
 	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
+	struct cxl_nvdimm_bridge *cxl_nvb = cxl_nvd->bridge;
+	struct cxl_pmem_region *cxlr_pmem;
+
+	device_lock(&cxl_nvb->dev);
+	cxlr_pmem = cxl_nvd->region;
+	dev_set_drvdata(&cxl_nvd->dev, NULL);
+	cxl_nvd->region = NULL;
+	device_unlock(&cxl_nvb->dev);
+
+	if (cxlr_pmem) {
+		device_release_driver(&cxlr_pmem->dev);
+		put_device(&cxlr_pmem->dev);
+	}
 
 	nvdimm_delete(nvdimm);
 	cxl_nvd->bridge = NULL;
@@ -42,7 +56,7 @@ static int cxl_nvdimm_probe(struct device *dev)
 	struct nvdimm *nvdimm;
 	int rc;
 
-	cxl_nvb = cxl_find_nvdimm_bridge(cxl_nvd);
+	cxl_nvb = cxl_find_nvdimm_bridge(dev);
 	if (!cxl_nvb)
 		return -ENXIO;
 
@@ -223,6 +237,21 @@ static int cxl_nvdimm_release_driver(struct device *dev, void *cxl_nvb)
 	return 0;
 }
 
+static int cxl_pmem_region_release_driver(struct device *dev, void *cxl_nvb)
+{
+	struct cxl_pmem_region *cxlr_pmem;
+
+	if (!is_cxl_pmem_region(dev))
+		return 0;
+
+	cxlr_pmem = to_cxl_pmem_region(dev);
+	if (cxlr_pmem->bridge != cxl_nvb)
+		return 0;
+
+	device_release_driver(dev);
+	return 0;
+}
+
 static void offline_nvdimm_bus(struct cxl_nvdimm_bridge *cxl_nvb,
 			       struct nvdimm_bus *nvdimm_bus)
 {
@@ -234,6 +263,8 @@ static void offline_nvdimm_bus(struct cxl_nvdimm_bridge *cxl_nvb,
 	 * nvdimm_bus_unregister() rips the nvdimm objects out from
 	 * underneath them.
 	 */
+	bus_for_each_dev(&cxl_bus_type, NULL, cxl_nvb,
+			 cxl_pmem_region_release_driver);
 	bus_for_each_dev(&cxl_bus_type, NULL, cxl_nvb,
 			 cxl_nvdimm_release_driver);
 	nvdimm_bus_unregister(nvdimm_bus);
@@ -328,6 +359,203 @@ static struct cxl_driver cxl_nvdimm_bridge_driver = {
 	.id = CXL_DEVICE_NVDIMM_BRIDGE,
 };
 
+static int match_cxl_nvdimm(struct device *dev, void *data)
+{
+	return is_cxl_nvdimm(dev);
+}
+
+static void unregister_nvdimm_region(void *nd_region)
+{
+	struct cxl_nvdimm_bridge *cxl_nvb;
+	struct cxl_pmem_region *cxlr_pmem;
+	int i;
+
+	cxlr_pmem = nd_region_provider_data(nd_region);
+	cxl_nvb = cxlr_pmem->bridge;
+	device_lock(&cxl_nvb->dev);
+	for (i = 0; i < cxlr_pmem->nr_mappings; i++) {
+		struct cxl_pmem_region_mapping *m = &cxlr_pmem->mapping[i];
+		struct cxl_nvdimm *cxl_nvd = m->cxl_nvd;
+
+		if (cxl_nvd->region) {
+			put_device(&cxlr_pmem->dev);
+			cxl_nvd->region = NULL;
+		}
+	}
+	device_unlock(&cxl_nvb->dev);
+
+	nvdimm_region_delete(nd_region);
+}
+
+static void cxlr_pmem_remove_resource(void *res)
+{
+	remove_resource(res);
+}
+
+struct cxl_pmem_region_info {
+	u64 offset;
+	u64 serial;
+};
+
+static int cxl_pmem_region_probe(struct device *dev)
+{
+	struct nd_mapping_desc mappings[CXL_DECODER_MAX_INTERLEAVE];
+	struct cxl_pmem_region *cxlr_pmem = to_cxl_pmem_region(dev);
+	struct cxl_region *cxlr = cxlr_pmem->cxlr;
+	struct cxl_pmem_region_info *info = NULL;
+	struct cxl_nvdimm_bridge *cxl_nvb;
+	struct nd_interleave_set *nd_set;
+	struct nd_region_desc ndr_desc;
+	struct cxl_nvdimm *cxl_nvd;
+	struct nvdimm *nvdimm;
+	struct resource *res;
+	int rc, i = 0;
+
+	cxl_nvb = cxl_find_nvdimm_bridge(&cxlr_pmem->mapping[0].cxlmd->dev);
+	if (!cxl_nvb) {
+		dev_dbg(dev, "bridge not found\n");
+		return -ENXIO;
+	}
+	cxlr_pmem->bridge = cxl_nvb;
+
+	device_lock(&cxl_nvb->dev);
+	if (!cxl_nvb->nvdimm_bus) {
+		dev_dbg(dev, "nvdimm bus not found\n");
+		rc = -ENXIO;
+		goto err;
+	}
+
+	memset(&mappings, 0, sizeof(mappings));
+	memset(&ndr_desc, 0, sizeof(ndr_desc));
+
+	res = devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
+	if (!res) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	res->name = "Persistent Memory";
+	res->start = cxlr_pmem->hpa_range.start;
+	res->end = cxlr_pmem->hpa_range.end;
+	res->flags = IORESOURCE_MEM;
+	res->desc = IORES_DESC_PERSISTENT_MEMORY;
+
+	rc = insert_resource(&iomem_resource, res);
+	if (rc)
+		goto err;
+
+	rc = devm_add_action_or_reset(dev, cxlr_pmem_remove_resource, res);
+	if (rc)
+		goto err;
+
+	ndr_desc.res = res;
+	ndr_desc.provider_data = cxlr_pmem;
+
+	ndr_desc.numa_node = memory_add_physaddr_to_nid(res->start);
+	ndr_desc.target_node = phys_to_target_node(res->start);
+	if (ndr_desc.target_node == NUMA_NO_NODE) {
+		ndr_desc.target_node = ndr_desc.numa_node;
+		dev_dbg(&cxlr->dev, "changing target node from %d to %d",
+			NUMA_NO_NODE, ndr_desc.target_node);
+	}
+
+	nd_set = devm_kzalloc(dev, sizeof(*nd_set), GFP_KERNEL);
+	if (!nd_set) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	ndr_desc.memregion = cxlr->id;
+	set_bit(ND_REGION_CXL, &ndr_desc.flags);
+	set_bit(ND_REGION_PERSIST_MEMCTRL, &ndr_desc.flags);
+
+	info = kmalloc_array(cxlr_pmem->nr_mappings, sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	for (i = 0; i < cxlr_pmem->nr_mappings; i++) {
+		struct cxl_pmem_region_mapping *m = &cxlr_pmem->mapping[i];
+		struct cxl_memdev *cxlmd = m->cxlmd;
+		struct cxl_dev_state *cxlds = cxlmd->cxlds;
+		struct device *d;
+
+		d = device_find_child(&cxlmd->dev, NULL, match_cxl_nvdimm);
+		if (!d) {
+			dev_dbg(dev, "[%d]: %s: no cxl_nvdimm found\n", i,
+				dev_name(&cxlmd->dev));
+			rc = -ENODEV;
+			goto err;
+		}
+
+		/* safe to drop ref now with bridge lock held */
+		put_device(d);
+
+		cxl_nvd = to_cxl_nvdimm(d);
+		nvdimm = dev_get_drvdata(&cxl_nvd->dev);
+		if (!nvdimm) {
+			dev_dbg(dev, "[%d]: %s: no nvdimm found\n", i,
+				dev_name(&cxlmd->dev));
+			rc = -ENODEV;
+			goto err;
+		}
+		cxl_nvd->region = cxlr_pmem;
+		get_device(&cxlr_pmem->dev);
+		m->cxl_nvd = cxl_nvd;
+		mappings[i] = (struct nd_mapping_desc) {
+			.nvdimm = nvdimm,
+			.start = m->start,
+			.size = m->size,
+			.position = i,
+		};
+		info[i].offset = m->start;
+		info[i].serial = cxlds->serial;
+	}
+	ndr_desc.num_mappings = cxlr_pmem->nr_mappings;
+	ndr_desc.mapping = mappings;
+
+	/*
+	 * TODO enable CXL labels which skip the need for 'interleave-set cookie'
+	 */
+	nd_set->cookie1 =
+		nd_fletcher64(info, sizeof(*info) * cxlr_pmem->nr_mappings, 0);
+	nd_set->cookie2 = nd_set->cookie1;
+	ndr_desc.nd_set = nd_set;
+
+	cxlr_pmem->nd_region =
+		nvdimm_pmem_region_create(cxl_nvb->nvdimm_bus, &ndr_desc);
+	if (IS_ERR(cxlr_pmem->nd_region)) {
+		rc = PTR_ERR(cxlr_pmem->nd_region);
+		goto err;
+	}
+
+	rc = devm_add_action_or_reset(dev, unregister_nvdimm_region,
+				      cxlr_pmem->nd_region);
+out:
+	kfree(info);
+	device_unlock(&cxl_nvb->dev);
+	put_device(&cxl_nvb->dev);
+
+	return rc;
+
+err:
+	dev_dbg(dev, "failed to create nvdimm region\n");
+	for (i--; i >= 0; i--) {
+		nvdimm = mappings[i].nvdimm;
+		cxl_nvd = nvdimm_provider_data(nvdimm);
+		put_device(&cxl_nvd->region->dev);
+		cxl_nvd->region = NULL;
+	}
+	goto out;
+}
+
+static struct cxl_driver cxl_pmem_region_driver = {
+	.name = "cxl_pmem_region",
+	.probe = cxl_pmem_region_probe,
+	.id = CXL_DEVICE_PMEM_REGION,
+};
+
 /*
  * Return all bridges to the CXL_NVB_NEW state to invalidate any
  * ->state_work referring to the now destroyed cxl_pmem_wq.
@@ -372,8 +600,14 @@ static __init int cxl_pmem_init(void)
 	if (rc)
 		goto err_nvdimm;
 
+	rc = cxl_driver_register(&cxl_pmem_region_driver);
+	if (rc)
+		goto err_region;
+
 	return 0;
 
+err_region:
+	cxl_driver_unregister(&cxl_nvdimm_driver);
 err_nvdimm:
 	cxl_driver_unregister(&cxl_nvdimm_bridge_driver);
 err_bridge:
@@ -383,6 +617,7 @@ static __init int cxl_pmem_init(void)
 
 static __exit void cxl_pmem_exit(void)
 {
+	cxl_driver_unregister(&cxl_pmem_region_driver);
 	cxl_driver_unregister(&cxl_nvdimm_driver);
 	cxl_driver_unregister(&cxl_nvdimm_bridge_driver);
 	destroy_cxl_pmem_wq();
@@ -394,3 +629,4 @@ module_exit(cxl_pmem_exit);
 MODULE_IMPORT_NS(CXL);
 MODULE_ALIAS_CXL(CXL_DEVICE_NVDIMM_BRIDGE);
 MODULE_ALIAS_CXL(CXL_DEVICE_NVDIMM);
+MODULE_ALIAS_CXL(CXL_DEVICE_PMEM_REGION);
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index d976260eca7a..473a71bbd9c9 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -133,7 +133,8 @@ static void nd_region_release(struct device *dev)
 		put_device(&nvdimm->dev);
 	}
 	free_percpu(nd_region->lane);
-	memregion_free(nd_region->id);
+	if (!test_bit(ND_REGION_CXL, &nd_region->flags))
+		memregion_free(nd_region->id);
 	kfree(nd_region);
 }
 
@@ -982,9 +983,14 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 
 	if (!nd_region)
 		return NULL;
-	nd_region->id = memregion_alloc(GFP_KERNEL);
-	if (nd_region->id < 0)
-		goto err_id;
+	/* CXL pre-assigns memregion ids before creating nvdimm regions */
+	if (test_bit(ND_REGION_CXL, &ndr_desc->flags)) {
+		nd_region->id = ndr_desc->memregion;
+	} else {
+		nd_region->id = memregion_alloc(GFP_KERNEL);
+		if (nd_region->id < 0)
+			goto err_id;
+	}
 
 	nd_region->lane = alloc_percpu(struct nd_percpu_lane);
 	if (!nd_region->lane)
@@ -1043,9 +1049,10 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 
 	return nd_region;
 
- err_percpu:
-	memregion_free(nd_region->id);
- err_id:
+err_percpu:
+	if (!test_bit(ND_REGION_CXL, &ndr_desc->flags))
+		memregion_free(nd_region->id);
+err_id:
 	kfree(nd_region);
 	return NULL;
 }
@@ -1068,6 +1075,13 @@ struct nd_region *nvdimm_volatile_region_create(struct nvdimm_bus *nvdimm_bus,
 }
 EXPORT_SYMBOL_GPL(nvdimm_volatile_region_create);
 
+void nvdimm_region_delete(struct nd_region *nd_region)
+{
+	if (nd_region)
+		nd_device_unregister(&nd_region->dev, ND_SYNC);
+}
+EXPORT_SYMBOL_GPL(nvdimm_region_delete);
+
 int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
 {
 	int rc = 0;
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index 0d61e07b6827..c74acfa1a3fe 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -59,6 +59,9 @@ enum {
 	/* Platform provides asynchronous flush mechanism */
 	ND_REGION_ASYNC = 3,
 
+	/* Region was created by CXL subsystem */
+	ND_REGION_CXL = 4,
+
 	/* mark newly adjusted resources as requiring a label update */
 	DPA_RESOURCE_ADJUSTED = 1 << 0,
 };
@@ -122,6 +125,7 @@ struct nd_region_desc {
 	int numa_node;
 	int target_node;
 	unsigned long flags;
+	int memregion;
 	struct device_node *of_node;
 	int (*flush)(struct nd_region *nd_region, struct bio *bio);
 };
@@ -259,6 +263,7 @@ static inline struct nvdimm *nvdimm_create(struct nvdimm_bus *nvdimm_bus,
 			cmd_mask, num_flush, flush_wpq, NULL, NULL, NULL);
 }
 void nvdimm_delete(struct nvdimm *nvdimm);
+void nvdimm_region_delete(struct nd_region *nd_region);
 
 const struct nd_cmd_desc *nd_cmd_dimm_desc(int cmd);
 const struct nd_cmd_desc *nd_cmd_bus_desc(int cmd);

