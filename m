Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91E9486EF6
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 01:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344341AbiAGAiM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 19:38:12 -0500
Received: from mga18.intel.com ([134.134.136.126]:59439 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344112AbiAGAiM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Jan 2022 19:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641515891; x=1673051891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jRAGW40hm+eWujsirYaF4GKLwnQu9VufkUx+C2DxegU=;
  b=nU7q73BGqB3POhgnBLgluffT1SY1QQxg9TRCl6+ae3zjb1Cl1sP8/210
   Se9zGb/Gf09yECoumo0ueZ2ez2rYhV+2h3CTXhoIrDRIQmpEvD0xyQyrK
   aO4kFsbhyq0nTORFZ1/xKGcvLfrCHekyyOPFfiaQhna68bsuL1SwlKT8T
   MczNmFwiVtdfvHlrFS1nxiouuH3j+zejyTWozCfqAhnZMH4vLSyd07aWK
   zV65I8WhQNURRIWe7QkVmWQpX+2A/333KZ4Lfs0SzTg4RQn8lzLsVJ47x
   aADjJWFFgn5EPgIKlHbD4YkmJPUfNolW9WrnDg4/YQgsaygfBeLbCP9Xa
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229582027"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="229582027"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:38:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="471123212"
Received: from elenawei-mobl2.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.138.104])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:38:11 -0800
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
Subject: [PATCH 06/13] cxl/region: Introduce a cxl_region driver
Date:   Thu,  6 Jan 2022 16:37:49 -0800
Message-Id: <20220107003756.806582-7-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107003756.806582-1-ben.widawsky@intel.com>
References: <20220107003756.806582-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The cxl_region driver is responsible for managing the HDM decoder
programming in the CXL topology. Once a region is created it must be
configured and bound to the driver in order to activate it.

The following is a sample of how such controls might work:

region=$(cat /sys/bus/cxl/devices/decoder0.0/create_region)
echo $region > /sys/bus/cxl/devices/decoder0.0/create_region
echo 2 > /sys/bus/cxl/devices/decoder0.0/region0.0:0/interleave
echo $((256<<20)) > /sys/bus/cxl/devices/decoder0.0/region0.0:0/size
echo mem0 > /sys/bus/cxl/devices/decoder0.0/region0.0:0/target0
echo mem1 > /sys/bus/cxl/devices/decoder0.0/region0.0:0/target1
echo region0.0:0 > /sys/bus/cxl/drivers/cxl_region/bind

In order to handle the eventual rise in failure modes of binding a
region, a new trace event is created to help track these failures for
debug and reconfiguration paths in userspace.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 .../driver-api/cxl/memory-devices.rst         |   3 +
 drivers/cxl/Makefile                          |   2 +
 drivers/cxl/core/core.h                       |   1 +
 drivers/cxl/core/port.c                       |  21 +-
 drivers/cxl/core/region.c                     |  25 +-
 drivers/cxl/cxl.h                             |   6 +
 drivers/cxl/region.c                          | 331 ++++++++++++++++++
 drivers/cxl/region.h                          |   4 +
 drivers/cxl/trace.h                           |  45 +++
 9 files changed, 433 insertions(+), 5 deletions(-)
 create mode 100644 drivers/cxl/region.c
 create mode 100644 drivers/cxl/trace.h

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index dc756ed23a3a..6734939b7136 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -73,6 +73,9 @@ CXL Core
 
 CXL Regions
 -----------
+.. kernel-doc:: drivers/cxl/region.c
+   :doc: cxl region
+
 .. kernel-doc:: drivers/cxl/region.h
    :identifiers:
 
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index ce267ef11d93..677a04528b22 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -5,9 +5,11 @@ obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 obj-$(CONFIG_CXL_PORT) += cxl_port.o
+obj-$(CONFIG_CXL_MEM) += cxl_region.o
 
 cxl_mem-y := mem.o
 cxl_pci-y := pci.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o
 cxl_port-y := port.o
+cxl_region-y := region.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1d4d1699b479..bd47e1b59f8b 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -7,6 +7,7 @@
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
 extern const struct device_type cxl_memdev_type;
+extern const struct device_type cxl_region_type;
 
 extern struct attribute_group cxl_base_attribute_group;
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index ef3840c50e3e..67f3345d44ef 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <cxlmem.h>
+#include <region.h>
 #include <cxl.h>
 #include <pci.h>
 #include "core.h"
@@ -29,6 +30,8 @@
 static DEFINE_IDA(cxl_port_ida);
 static DEFINE_XARRAY(cxl_root_buses);
 
+static void cxl_decoder_release(struct device *dev);
+
 static bool is_cxl_decoder(struct device *dev);
 
 static int decoder_match(struct device *dev, void *data)
@@ -732,6 +735,7 @@ struct cxl_port *find_cxl_root(struct cxl_memdev *cxlmd)
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
 
 static void cxl_remove_ep(void *data)
 {
@@ -1276,6 +1280,8 @@ static int cxl_device_id(struct device *dev)
 	}
 	if (dev->type == &cxl_memdev_type)
 		return CXL_DEVICE_MEMORY_EXPANDER;
+	if (dev->type == &cxl_region_type)
+		return CXL_DEVICE_REGION;
 	return 0;
 }
 
@@ -1292,10 +1298,21 @@ static int cxl_bus_match(struct device *dev, struct device_driver *drv)
 
 static int cxl_bus_probe(struct device *dev)
 {
-	int rc;
+	int id = cxl_device_id(dev);
+	int rc = -ENODEV;
+
+	if (id == CXL_DEVICE_REGION) {
+		/* Regions cannot bind until parameters are set */
+		struct cxl_region *region = to_cxl_region(dev);
+
+		if (is_cxl_region_configured(region))
+			rc = to_cxl_drv(dev->driver)->probe(dev);
+	} else {
+		rc = to_cxl_drv(dev->driver)->probe(dev);
+	}
 
-	rc = to_cxl_drv(dev->driver)->probe(dev);
 	dev_dbg(dev, "probe: %d\n", rc);
+
 	return rc;
 }
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 26b5ad389cd2..de0514a85cf1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -12,6 +12,8 @@
 #include <cxl.h>
 #include "core.h"
 
+#include "core.h"
+
 /**
  * DOC: cxl core region
  *
@@ -26,10 +28,27 @@ static const struct attribute_group region_interleave_group;
 
 static bool is_region_active(struct cxl_region *region)
 {
-	/* TODO: Regions can't be activated yet. */
-	return false;
+	return region->active;
 }
 
+/*
+ * Most sanity checking is left up to region binding. This does the most basic
+ * check to determine whether or not the core should try probing the driver.
+ */
+bool is_cxl_region_configured(const struct cxl_region *region)
+{
+	/* zero sized regions aren't a thing. */
+	if (region->config.size <= 0)
+		return false;
+
+	/* all regions have at least 1 target */
+	if (!region->config.targets[0])
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(is_cxl_region_configured);
+
 static void remove_target(struct cxl_region *region, int target)
 {
 	struct cxl_memdev *cxlmd;
@@ -311,7 +330,7 @@ static const struct attribute_group *region_groups[] = {
 
 static void cxl_region_release(struct device *dev);
 
-static const struct device_type cxl_region_type = {
+const struct device_type cxl_region_type = {
 	.name = "cxl_region",
 	.release = cxl_region_release,
 	.groups = region_groups
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 79c5781b6173..b318cabfc4a2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -181,6 +181,10 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 #define CXL_DECODER_F_ENABLE    BIT(5)
 #define CXL_DECODER_F_MASK  GENMASK(5, 0)
 
+#define cxl_is_pmem_t3(flags)                                                  \
+	(((flags) & (CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM)) ==             \
+	 (CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM))
+
 enum cxl_decoder_type {
        CXL_DECODER_ACCELERATOR = 2,
        CXL_DECODER_EXPANDER = 3,
@@ -348,6 +352,7 @@ int devm_cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
 		       resource_size_t component_reg_phys);
 struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
 					const struct device *dev);
+struct cxl_port *ep_find_cxl_port(struct cxl_memdev *cxlmd, unsigned int depth);
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
@@ -388,6 +393,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define CXL_DEVICE_PORT			3
 #define CXL_DEVICE_MEMORY_EXPANDER	4
 #define CXL_DEVICE_ROOT			5
+#define CXL_DEVICE_REGION		6
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
new file mode 100644
index 000000000000..9174925b67e3
--- /dev/null
+++ b/drivers/cxl/region.c
@@ -0,0 +1,331 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include "cxlmem.h"
+#include "region.h"
+#include "cxl.h"
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
+/**
+ * DOC: cxl region
+ *
+ * This module implements a region driver that is capable of programming CXL
+ * hardware to setup regions.
+ *
+ * A CXL region encompasses a chunk of host physical address space that may be
+ * consumed by a single device (x1 interleave aka linear) or across multiple
+ * devices (xN interleaved). A region is a child device of a &struct
+ * cxl_decoder. There may be multiple active regions under a single &struct
+ * cxl_decoder. The common case for multiple regions would be several linear,
+ * contiguous regions under a single decoder. Generally, there will be a 1:1
+ * relationship between decoder and region when the region is interleaved.
+ */
+
+#define region_ways(region) ((region)->config.eniw)
+
+static struct cxl_decoder *rootd_from_region(struct cxl_region *r)
+{
+	struct device *d = r->dev.parent;
+
+	if (WARN_ONCE(!is_root_decoder(d), "Corrupt topology for root region\n"))
+		return NULL;
+
+	return to_cxl_decoder(d);
+}
+
+static struct cxl_port *get_hostbridge(const struct cxl_memdev *ep)
+{
+	struct cxl_port *port = ep->port;
+
+	while (!is_cxl_root(port)) {
+		port = to_cxl_port(port->dev.parent);
+		if (port->depth == 1)
+			return port;
+	}
+
+	BUG();
+	return NULL;
+}
+
+static struct cxl_port *get_root_decoder(const struct cxl_memdev *endpoint)
+{
+	struct cxl_port *hostbridge = get_hostbridge(endpoint);
+
+	if (hostbridge)
+		return to_cxl_port(hostbridge->dev.parent);
+
+	return NULL;
+}
+
+/**
+ * sanitize_region() - Check is region is reasonably configured
+ * @region: The region to check
+ *
+ * Determination as to whether or not a region can possibly be configured is
+ * described in CXL Memory Device SW Guide. In order to implement the algorithms
+ * described there, certain more basic configuration parameters must first need
+ * to be validated. That is accomplished by this function.
+ *
+ * Returns 0 if the region is reasonably configured, else returns a negative
+ * error code.
+ */
+static int sanitize_region(const struct cxl_region *region)
+{
+	int i;
+
+	if (dev_WARN_ONCE(&region->dev, !is_cxl_region_configured(region),
+			  "unconfigured regions can't be probed (race?)\n")) {
+		return -ENXIO;
+	}
+
+	if (region->config.size % (SZ_256M * region_ways(region))) {
+		trace_sanitize_failed(region,
+				      "Invalid size. Must be multiple of NIW");
+		return -ENXIO;
+	}
+
+	for (i = 0; i < region_ways(region); i++) {
+		if (!region->config.targets[i]) {
+			trace_sanitize_failed(region,
+					      "Missing memory device target");
+			return -ENXIO;
+		}
+		if (!region->config.targets[i]->dev.driver) {
+			trace_sanitize_failed(region,
+					      "Target isn't CXL.mem capable");
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * allocate_address_space() - Gets address space for the region.
+ * @region: The region that will consume the address space
+ */
+static int allocate_address_space(struct cxl_region *region)
+{
+	/* TODO */
+	return 0;
+}
+
+/**
+ * find_cdat_dsmas() - Find a valid DSMAS for the region
+ * @region: The region
+ */
+static bool find_cdat_dsmas(const struct cxl_region *region)
+{
+	return true;
+}
+
+/**
+ * qtg_match() - Does this CFMWS have desirable QTG for the endpoint
+ * @cfmws: The CFMWS for the region
+ * @endpoint: Endpoint whose QTG is being compared
+ *
+ * Prior to calling this function, the caller should verify that all endpoints
+ * in the region have the same QTG ID.
+ *
+ * Returns true if the QTG ID of the CFMWS matches the endpoint
+ */
+static bool qtg_match(const struct cxl_decoder *cfmws,
+		      const struct cxl_memdev *endpoint)
+{
+	/* TODO: */
+	return true;
+}
+
+/**
+ * region_xhb_config_valid() - determine cross host bridge validity
+ * @cfmws: The CFMWS to check against
+ * @region: The region being programmed
+ *
+ * The algorithm is outlined in 2.13.14 "Verify XHB configuration sequence" of
+ * the CXL Memory Device SW Guide (Rev1p0).
+ *
+ * Returns true if the configuration is valid.
+ */
+static bool region_xhb_config_valid(const struct cxl_region *region,
+				    const struct cxl_decoder *cfmws)
+{
+	/* TODO: */
+	return true;
+}
+
+/**
+ * region_hb_rp_config_valid() - determine root port ordering is correct
+ * @cfmws: CFMWS decoder for this @region
+ * @region: Region to validate
+ *
+ * The algorithm is outlined in 2.13.15 "Verify HB root port configuration
+ * sequence" of the CXL Memory Device SW Guide (Rev1p0).
+ *
+ * Returns true if the configuration is valid.
+ */
+static bool region_hb_rp_config_valid(const struct cxl_region *region,
+				      const struct cxl_decoder *cfmws)
+{
+	/* TODO: */
+	return true;
+}
+
+/**
+ * rootd_contains() - determine if this region can exist in the root decoder
+ * @rootd: CFMWS that potentially decodes to this region
+ * @region: region to be routed by the @rootd
+ */
+static bool rootd_contains(const struct cxl_region *region,
+			   const struct cxl_decoder *rootd)
+{
+	/* TODO: */
+	return true;
+}
+
+static bool rootd_valid(const struct cxl_region *region,
+			const struct cxl_decoder *rootd)
+{
+	const struct cxl_memdev *endpoint = region->config.targets[0];
+
+	if (!qtg_match(rootd, endpoint))
+		return false;
+
+	if (!cxl_is_pmem_t3(rootd->flags))
+		return false;
+
+	if (!region_xhb_config_valid(region, rootd))
+		return false;
+
+	if (!region_hb_rp_config_valid(region, rootd))
+		return false;
+
+	if (!rootd_contains(region, rootd))
+		return false;
+
+	return true;
+}
+
+struct rootd_context {
+	const struct cxl_region *region;
+	struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
+	int count;
+};
+
+static int rootd_match(struct device *dev, void *data)
+{
+	struct rootd_context *ctx = (struct rootd_context *)data;
+	const struct cxl_region *region = ctx->region;
+
+	if (!is_root_decoder(dev))
+		return 0;
+
+	return !!rootd_valid(region, to_cxl_decoder(dev));
+}
+
+/*
+ * This is a roughly equivalent implementation to "Figure 45 - High-level
+ * sequence: Finding CFMWS for region" from the CXL Memory Device SW Guide
+ * Rev1p0.
+ */
+static struct cxl_decoder *find_rootd(const struct cxl_region *region,
+				      const struct cxl_port *root)
+{
+	struct rootd_context ctx;
+	struct device *ret;
+
+	ctx.region = region;
+
+	ret = device_find_child((struct device *)&root->dev, &ctx, rootd_match);
+	if (ret)
+		return to_cxl_decoder(ret);
+
+	return NULL;
+}
+
+static int collect_ep_decoders(const struct cxl_region *region)
+{
+	/* TODO: */
+	return 0;
+}
+
+static int bind_region(const struct cxl_region *region)
+{
+	/* TODO: */
+	return 0;
+}
+
+static int cxl_region_probe(struct device *dev)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+	struct cxl_port *root_port;
+	struct cxl_decoder *rootd, *ours;
+	int ret;
+
+	device_lock_assert(&region->dev);
+
+	if (region->active)
+		return 0;
+
+	if (uuid_is_null(&region->config.uuid))
+		uuid_gen(&region->config.uuid);
+
+	/* TODO: What about volatile, and LSA generated regions? */
+
+	ret = sanitize_region(region);
+	if (ret)
+		return ret;
+
+	ret = allocate_address_space(region);
+	if (ret)
+		return ret;
+
+	if (!find_cdat_dsmas(region))
+		return -ENXIO;
+
+	rootd = rootd_from_region(region);
+	if (!rootd) {
+		dev_err(dev, "Couldn't find root decoder\n");
+		return -ENXIO;
+	}
+
+	if (!rootd_valid(region, rootd)) {
+		dev_err(dev, "Picked invalid rootd\n");
+		return -ENXIO;
+	}
+
+	root_port = get_root_decoder(region->config.targets[0]);
+	ours = find_rootd(region, root_port);
+	if (ours != rootd)
+		dev_warn(dev, "Picked different rootd %s %s\n",
+			 dev_name(&rootd->dev), dev_name(&ours->dev));
+	if (ours)
+		put_device(&ours->dev);
+
+	ret = collect_ep_decoders(region);
+	if (ret)
+		return ret;
+
+	ret = bind_region(region);
+	if (!ret) {
+		region->active = true;
+		trace_region_activated(region, "");
+	}
+
+	return ret;
+}
+
+static struct cxl_driver cxl_region_driver = {
+	.name = "cxl_region",
+	.probe = cxl_region_probe,
+	.id = CXL_DEVICE_REGION,
+};
+module_cxl_driver(cxl_region_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(CXL);
+MODULE_ALIAS_CXL(CXL_DEVICE_REGION);
diff --git a/drivers/cxl/region.h b/drivers/cxl/region.h
index 3e6e5fb35822..97bb3f12f2fc 100644
--- a/drivers/cxl/region.h
+++ b/drivers/cxl/region.h
@@ -13,6 +13,7 @@
  * @id: This regions id. Id is globally unique across all regions.
  * @list: Node in decoder's region list.
  * @res: Resource this region carves out of the platform decode range.
+ * @active: If the region has been activated.
  * @config: HDM decoder program config
  * @config.size: Size of the region determined from LSA or userspace.
  * @config.uuid: The UUID for this region.
@@ -25,6 +26,7 @@ struct cxl_region {
 	int id;
 	struct list_head list;
 	struct resource *res;
+	bool active;
 
 	struct {
 		u64 size;
@@ -35,4 +37,6 @@ struct cxl_region {
 	} config;
 };
 
+bool is_cxl_region_configured(const struct cxl_region *region);
+
 #endif
diff --git a/drivers/cxl/trace.h b/drivers/cxl/trace.h
new file mode 100644
index 000000000000..8f7f471e15b8
--- /dev/null
+++ b/drivers/cxl/trace.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cxl
+
+#if !defined(__CXL_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ)
+#define __CXL_TRACE_H__
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(cxl_region_template,
+
+	TP_PROTO(const struct cxl_region *region, char *status),
+
+	TP_ARGS(region, status),
+
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name(&region->dev))
+		__field(const struct cxl_region *, region)
+		__string(status, status)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name(&region->dev));
+		__entry->region = (const struct cxl_region *)region;
+		__assign_str(status, status);
+	),
+
+	TP_printk("%s: (%s)\n", __get_str(dev_name), __get_str(status))
+);
+
+DEFINE_EVENT(cxl_region_template, region_activated,
+	     TP_PROTO(const struct cxl_region *region, char *status),
+	     TP_ARGS(region, status));
+DEFINE_EVENT(cxl_region_template, sanitize_failed,
+	     TP_PROTO(const struct cxl_region *region, char *status),
+	     TP_ARGS(region, status));
+
+#endif /* if !defined (__CXL_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ) */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../../drivers/cxl
+#define TRACE_INCLUDE_FILE trace
+#include <trace/define_trace.h>
-- 
2.34.1

