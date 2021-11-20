Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C522E4579F3
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbhKTAGX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:06:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:5719 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236325AbhKTAGN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:06:13 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="214542417"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="214542417"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:03:00 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="496088406"
Received: from jfaistl-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.139.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:03:00 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 20/23] cxl/port: Introduce a port driver
Date:   Fri, 19 Nov 2021 16:02:47 -0800
Message-Id: <20211120000250.1663391-21-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211120000250.1663391-1-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The CXL port driver is responsible for managing the decoder resources
contained within the port. It will also provide APIs that other drivers
will consume for managing these resources.

There are 4 types of ports in a system:
1. Platform port. This is a non-programmable entity. Such a port is
   named rootX. It is enumerated by cxl_acpi in an ACPI based system.
2. Hostbridge port. This ports register access is defined in a platform
   specific way (CHBS for ACPI platforms). It has n downstream ports,
   each of which are known as CXL 2.0 root ports. Once the platform
   specific mechanism to get the offset to the registers is obtained it
   operates just like other CXL components. The enumeration of this
   component is started by cxl_acpi and completed by cxl_port.
3. Switch port. A switch port is similar to a hostbridge port except
   register access is defined in the CXL specification in a platform
   agnostic way. The downstream ports for a switch are simply known as
   downstream ports. The enumeration of these are entirely contained
   within cxl_port.
4. Endpoint port. Endpoint ports are similar to switch ports with the
   exception that they have no downstream ports, only the underlying
   media on the device. The enumeration of these are started by cxl_pci,
   and completed by cxl_port.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

---
Changes since RFCv2:
- Reword commit message tense (Dan)
- Reword commit message
- Drop SOFTDEP since it's not needed yet (Dan)
- Add CONFIG_CXL_PORT (Dan)
- s/CXL_DECODER_F_EN/CXL_DECODER_F_ENABLE (Dan)
- rename cxl_hdm_decoder_ functions to "to_" (Dan)
- remove useless inline (Dan)
- Check endpoint decoder based on dport list instead of driver id (Dan)
- Use range instead of resource per dependent patch change
- Use clever union packing for target list (Dan)
- Only check NULL from devm_cxl_iomap_block (Dan)
- Properly parent the created cxl decoders
- Move bus rescanning from cxl_acpi to here (Dan)
- Remove references to "CFMWS" in core (Dan)
- Use macro to help keep within 80 character lines
---
 .../driver-api/cxl/memory-devices.rst         |   5 +
 drivers/cxl/Kconfig                           |  22 ++
 drivers/cxl/Makefile                          |   2 +
 drivers/cxl/core/bus.c                        |  67 ++++
 drivers/cxl/core/regs.c                       |   6 +-
 drivers/cxl/cxl.h                             |  34 +-
 drivers/cxl/port.c                            | 323 ++++++++++++++++++
 7 files changed, 450 insertions(+), 9 deletions(-)
 create mode 100644 drivers/cxl/port.c

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index 3b8f41395f6b..fbf0393cdddc 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -28,6 +28,11 @@ CXL Memory Device
 .. kernel-doc:: drivers/cxl/pci.c
    :internal:
 
+CXL Port
+--------
+.. kernel-doc:: drivers/cxl/port.c
+   :doc: cxl port
+
 CXL Core
 --------
 .. kernel-doc:: drivers/cxl/cxl.h
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index ef05e96f8f97..3aeb33bba5a3 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -77,4 +77,26 @@ config CXL_PMEM
 	  provisioning the persistent memory capacity of CXL memory expanders.
 
 	  If unsure say 'm'.
+
+config CXL_MEM
+	tristate "CXL.mem: Memory Devices"
+	select CXL_PORT
+	depends on CXL_PCI
+	default CXL_BUS
+	help
+	  The CXL.mem protocol allows a device to act as a provider of "System
+	  RAM" and/or "Persistent Memory" that is fully coherent as if the
+	  memory was attached to the typical CPU memory controller.  This is
+	  known as HDM "Host-managed Device Memory".
+
+	  Say 'y/m' to enable a driver that will attach to CXL.mem devices for
+	  memory expansion and control of HDM. See Chapter 9.13 in the CXL 2.0
+	  specification for a detailed description of HDM.
+
+	  If unsure say 'm'.
+
+
+config CXL_PORT
+	tristate
+
 endif
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index cf07ae6cea17..56fcac2323cb 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -3,7 +3,9 @@ obj-$(CONFIG_CXL_BUS) += core/
 obj-$(CONFIG_CXL_PCI) += cxl_pci.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
+obj-$(CONFIG_CXL_PORT) += cxl_port.o
 
 cxl_pci-y := pci.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o
+cxl_port-y := port.o
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 9e0d7d5d9298..46a06cfe79bd 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -31,6 +31,8 @@ static DECLARE_RWSEM(root_port_sem);
 
 static struct device *cxl_topology_host;
 
+static bool is_cxl_decoder(struct device *dev);
+
 int cxl_register_topology_host(struct device *host)
 {
 	down_write(&topology_host_sem);
@@ -75,6 +77,45 @@ static void put_cxl_topology_host(struct device *dev)
 	up_read(&topology_host_sem);
 }
 
+static int decoder_match(struct device *dev, void *data)
+{
+	struct resource *theirs = (struct resource *)data;
+	struct cxl_decoder *cxld;
+
+	if (!is_cxl_decoder(dev))
+		return 0;
+
+	cxld = to_cxl_decoder(dev);
+	if (theirs->start <= cxld->decoder_range.start &&
+	    theirs->end >= cxld->decoder_range.end)
+		return 1;
+
+	return 0;
+}
+
+static struct cxl_decoder *cxl_find_root_decoder(resource_size_t base,
+						 resource_size_t size)
+{
+	struct cxl_decoder *cxld = NULL;
+	struct device *cxldd;
+	struct device *host;
+	struct resource res = (struct resource){
+		.start = base,
+		.end = base + size - 1,
+	};
+
+	host = get_cxl_topology_host();
+	if (!host)
+		return NULL;
+
+	cxldd = device_find_child(host, &res, decoder_match);
+	if (cxldd)
+		cxld = to_cxl_decoder(cxldd);
+
+	put_cxl_topology_host(host);
+	return cxld;
+}
+
 static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
@@ -280,6 +321,11 @@ bool is_root_decoder(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(is_root_decoder, CXL);
 
+static bool is_cxl_decoder(struct device *dev)
+{
+	return dev->type->release == cxl_decoder_release;
+}
+
 struct cxl_decoder *to_cxl_decoder(struct device *dev)
 {
 	if (dev_WARN_ONCE(dev, dev->type->release != cxl_decoder_release,
@@ -327,6 +373,7 @@ struct cxl_port *to_cxl_port(struct device *dev)
 		return NULL;
 	return container_of(dev, struct cxl_port, dev);
 }
+EXPORT_SYMBOL_NS_GPL(to_cxl_port, CXL);
 
 struct cxl_dport *cxl_get_root_dport(struct device *dev)
 {
@@ -735,6 +782,24 @@ EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, CXL);
 
 static void cxld_unregister(void *dev)
 {
+	struct cxl_decoder *plat_decoder, *cxld = to_cxl_decoder(dev);
+	resource_size_t base, size;
+
+	if (is_root_decoder(dev)) {
+		device_unregister(dev);
+		return;
+	}
+
+	base = cxld->decoder_range.start;
+	size = range_len(&cxld->decoder_range);
+
+	if (size) {
+		plat_decoder = cxl_find_root_decoder(base, size);
+		if (plat_decoder)
+			__release_region(&plat_decoder->platform_res, base,
+					 size);
+	}
+
 	device_unregister(dev);
 }
 
@@ -789,6 +854,8 @@ static int cxl_device_id(struct device *dev)
 		return CXL_DEVICE_NVDIMM_BRIDGE;
 	if (dev->type == &cxl_nvdimm_type)
 		return CXL_DEVICE_NVDIMM;
+	if (dev->type == &cxl_port_type)
+		return CXL_DEVICE_PORT;
 	return 0;
 }
 
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 41a0245867ea..f191b0c995a7 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -159,9 +159,8 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_probe_device_regs, CXL);
 
-static void __iomem *devm_cxl_iomap_block(struct device *dev,
-					  resource_size_t addr,
-					  resource_size_t length)
+void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
+				   resource_size_t length)
 {
 	void __iomem *ret_val;
 	struct resource *res;
@@ -180,6 +179,7 @@ static void __iomem *devm_cxl_iomap_block(struct device *dev,
 
 	return ret_val;
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, CXL);
 
 int cxl_map_component_regs(struct pci_dev *pdev,
 			   struct cxl_component_regs *regs,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3962a5e6a950..24fa16157d5e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -17,6 +17,9 @@
  * (port-driver, region-driver, nvdimm object-drivers... etc).
  */
 
+/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
+#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
+
 /* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers*/
 #define CXL_CM_OFFSET 0x1000
 #define CXL_CM_CAP_HDR_OFFSET 0x0
@@ -36,11 +39,22 @@
 #define CXL_HDM_DECODER_CAP_OFFSET 0x0
 #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
 #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
-#define CXL_HDM_DECODER0_BASE_LOW_OFFSET 0x10
-#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET 0x14
-#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET 0x18
-#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET 0x1c
-#define CXL_HDM_DECODER0_CTRL_OFFSET 0x20
+#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
+#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
+#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
+#define   CXL_HDM_DECODER_ENABLE BIT(1)
+#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
+#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
+#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
+#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
+#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
+#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
+#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
+#define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
+#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
+#define   CXL_HDM_DECODER0_CTRL_TYPE BIT(12)
+#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
+#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
 
 static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 {
@@ -148,6 +162,8 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 enum cxl_regloc_type;
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
+void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
+				   resource_size_t length);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
@@ -165,7 +181,8 @@ void cxl_unregister_topology_host(struct device *host);
 #define CXL_DECODER_F_TYPE2 BIT(2)
 #define CXL_DECODER_F_TYPE3 BIT(3)
 #define CXL_DECODER_F_LOCK  BIT(4)
-#define CXL_DECODER_F_MASK  GENMASK(4, 0)
+#define CXL_DECODER_F_ENABLE    BIT(5)
+#define CXL_DECODER_F_MASK  GENMASK(5, 0)
 
 enum cxl_decoder_type {
        CXL_DECODER_ACCELERATOR = 2,
@@ -255,6 +272,8 @@ struct cxl_walk_context {
  * @dports: cxl_dport instances referenced by decoders
  * @decoder_ida: allocator for decoder ids
  * @component_reg_phys: component register capability base address (optional)
+ * @rescan_work: worker object for bus rescans after port additions
+ * @data: opaque data with driver specific usage
  */
 struct cxl_port {
 	struct device dev;
@@ -263,6 +282,8 @@ struct cxl_port {
 	struct list_head dports;
 	struct ida decoder_ida;
 	resource_size_t component_reg_phys;
+	struct work_struct rescan_work;
+	void *data;
 };
 
 /**
@@ -325,6 +346,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 
 #define CXL_DEVICE_NVDIMM_BRIDGE	1
 #define CXL_DEVICE_NVDIMM		2
+#define CXL_DEVICE_PORT			3
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
new file mode 100644
index 000000000000..3c03131517af
--- /dev/null
+++ b/drivers/cxl/port.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include "cxlmem.h"
+
+/**
+ * DOC: cxl port
+ *
+ * The port driver implements the set of functionality needed to allow full
+ * decoder enumeration and routing. A CXL port is an abstraction of a CXL
+ * component that implements some amount of CXL decoding of CXL.mem traffic.
+ * As of the CXL 2.0 spec, this includes:
+ *
+ *	.. list-table:: CXL Components w/ Ports
+ *		:widths: 25 25 50
+ *		:header-rows: 1
+ *
+ *		* - component
+ *		  - upstream
+ *		  - downstream
+ *		* - Hostbridge
+ *		  - ACPI0016
+ *		  - root port
+ *		* - Switch
+ *		  - Switch Upstream Port
+ *		  - Switch Downstream Port
+ *		* - Endpoint
+ *		  - Endpoint Port
+ *		  - N/A
+ *
+ * The primary service this driver provides is enumerating HDM decoders and
+ * presenting APIs to other drivers to utilize the decoders.
+ */
+
+static struct workqueue_struct *cxl_port_wq;
+
+struct cxl_port_data {
+	struct cxl_component_regs regs;
+
+	struct port_caps {
+		unsigned int count;
+		unsigned int tc;
+		unsigned int interleave11_8;
+		unsigned int interleave14_12;
+	} caps;
+};
+
+static inline int to_interleave_granularity(u32 ctrl)
+{
+	int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl);
+
+	return 256 << val;
+}
+
+static inline int to_interleave_ways(u32 ctrl)
+{
+	int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl);
+
+	return 1 << val;
+}
+
+static void get_caps(struct cxl_port *port, struct cxl_port_data *cpd)
+{
+	void __iomem *hdm_decoder = cpd->regs.hdm_decoder;
+	struct port_caps *caps = &cpd->caps;
+	u32 hdm_cap;
+
+	hdm_cap = readl(hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
+
+	caps->count = cxl_hdm_decoder_count(hdm_cap);
+	caps->tc = FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
+	caps->interleave11_8 =
+		FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap);
+	caps->interleave14_12 =
+		FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap);
+}
+
+static int map_regs(struct cxl_port *port, void __iomem *crb,
+		    struct cxl_port_data *cpd)
+{
+	struct cxl_register_map map;
+	struct cxl_component_reg_map *comp_map = &map.component_map;
+
+	cxl_probe_component_regs(&port->dev, crb, comp_map);
+	if (!comp_map->hdm_decoder.valid) {
+		dev_err(&port->dev, "HDM decoder registers invalid\n");
+		return -ENXIO;
+	}
+
+	cpd->regs.hdm_decoder = crb + comp_map->hdm_decoder.offset;
+
+	return 0;
+}
+
+static u64 get_decoder_size(void __iomem *hdm_decoder, int n)
+{
+	u32 ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(n));
+
+	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED)
+		return 0;
+
+	return ioread64_hi_lo(hdm_decoder +
+			      CXL_HDM_DECODER0_SIZE_LOW_OFFSET(n));
+}
+
+static bool is_endpoint_port(struct cxl_port *port)
+{
+	/* Endpoints can't be ports... yet! */
+	return false;
+}
+
+static void rescan_ports(struct work_struct *work)
+{
+	if (bus_rescan_devices(&cxl_bus_type))
+		pr_warn("Failed to rescan\n");
+}
+
+/* Minor layering violation */
+static int dvsec_range_used(struct cxl_port *port)
+{
+	struct cxl_endpoint_dvsec_info *info;
+	int i, ret = 0;
+
+	if (!is_endpoint_port(port))
+		return 0;
+
+	info = port->data;
+	for (i = 0; i < info->ranges; i++)
+		if (info->range[i].size)
+			ret |= 1 << i;
+
+	return ret;
+}
+
+static int enumerate_hdm_decoders(struct cxl_port *port,
+				  struct cxl_port_data *portdata)
+{
+	void __iomem *hdm_decoder = portdata->regs.hdm_decoder;
+	bool global_enable;
+	u32 global_ctrl;
+	int i = 0;
+
+	global_ctrl = readl(hdm_decoder + CXL_HDM_DECODER_CTRL_OFFSET);
+	global_enable = global_ctrl & CXL_HDM_DECODER_ENABLE;
+	if (!global_enable) {
+		i = dvsec_range_used(port);
+		if (i) {
+			dev_err(&port->dev,
+				"Couldn't add port because device is using DVSEC range registers\n");
+			return -EBUSY;
+		}
+	}
+
+	for (i = 0; i < portdata->caps.count; i++) {
+		int rc, target_count = portdata->caps.tc;
+		struct cxl_decoder *cxld;
+		int *target_map = NULL;
+		u64 size;
+
+		if (is_endpoint_port(port))
+			target_count = 0;
+
+		cxld = cxl_decoder_alloc(port, target_count);
+		if (IS_ERR(cxld)) {
+			dev_warn(&port->dev,
+				 "Failed to allocate the decoder\n");
+			return PTR_ERR(cxld);
+		}
+
+		cxld->target_type = CXL_DECODER_EXPANDER;
+		cxld->interleave_ways = 1;
+		cxld->interleave_granularity = 0;
+
+		size = get_decoder_size(hdm_decoder, i);
+		if (size != 0) {
+#define decoderN(reg, n) hdm_decoder + CXL_HDM_DECODER0_##reg(n)
+			int temp[CXL_DECODER_MAX_INTERLEAVE];
+			u64 base;
+			u32 ctrl;
+			int j;
+			union {
+				u64 value;
+				char target_id[8];
+			} target_list;
+
+			target_map = temp;
+			ctrl = readl(decoderN(CTRL_OFFSET, i));
+			base = ioread64_hi_lo(decoderN(BASE_LOW_OFFSET, i));
+
+			cxld->decoder_range = (struct range){
+				.start = base,
+				.end = base + size - 1
+			};
+
+			cxld->flags = CXL_DECODER_F_ENABLE;
+			cxld->interleave_ways = to_interleave_ways(ctrl);
+			cxld->interleave_granularity =
+				to_interleave_granularity(ctrl);
+
+			if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl) == 0)
+				cxld->target_type = CXL_DECODER_ACCELERATOR;
+
+			target_list.value = ioread64_hi_lo(decoderN(TL_LOW, i));
+			for (j = 0; j < cxld->interleave_ways; j++)
+				target_map[j] = target_list.target_id[j];
+#undef decoderN
+		}
+
+		rc = cxl_decoder_add_locked(cxld, target_map);
+		if (rc)
+			put_device(&cxld->dev);
+		else
+			rc = cxl_decoder_autoremove(&port->dev, cxld);
+		if (rc)
+			dev_err(&port->dev, "Failed to add decoder\n");
+		else
+			dev_dbg(&cxld->dev, "Added to port %s\n",
+				dev_name(&port->dev));
+	}
+
+	/*
+	 * Turn on global enable now since DVSEC ranges aren't being used and
+	 * we'll eventually want the decoder enabled.
+	 */
+	if (!global_enable) {
+		dev_dbg(&port->dev, "Enabling HDM decode\n");
+		writel(global_ctrl | CXL_HDM_DECODER_ENABLE, hdm_decoder + CXL_HDM_DECODER_CTRL_OFFSET);
+	}
+
+	return 0;
+}
+
+static int cxl_port_probe(struct device *dev)
+{
+	struct cxl_port *port = to_cxl_port(dev);
+	struct cxl_port_data *portdata;
+	void __iomem *crb;
+	int rc;
+
+	if (port->component_reg_phys == CXL_RESOURCE_NONE)
+		return 0;
+
+	portdata = devm_kzalloc(dev, sizeof(*portdata), GFP_KERNEL);
+	if (!portdata)
+		return -ENOMEM;
+
+	crb = devm_cxl_iomap_block(&port->dev, port->component_reg_phys,
+				   CXL_COMPONENT_REG_BLOCK_SIZE);
+	if (!crb) {
+		dev_err(&port->dev, "No component registers mapped\n");
+		return -ENXIO;
+	}
+
+	rc = map_regs(port, crb, portdata);
+	if (rc)
+		return rc;
+
+	get_caps(port, portdata);
+	if (portdata->caps.count == 0) {
+		dev_err(&port->dev, "Spec violation. Caps invalid\n");
+		return -ENXIO;
+	}
+
+	rc = enumerate_hdm_decoders(port, portdata);
+	if (rc) {
+		dev_err(&port->dev, "Couldn't enumerate decoders (%d)\n", rc);
+		return rc;
+	}
+
+	/*
+	 * Bus rescan is done in a workqueue so that we can do so with the
+	 * device lock dropped.
+	 *
+	 * Why do we need to rescan? There is a race between cxl_acpi and
+	 * cxl_mem (which depends on cxl_pci). cxl_mem will only create a port
+	 * if it can establish a path up to a root port, which is enumerated by
+	 * a platform specific driver (ie. cxl_acpi) and bound by this driver.
+	 * While cxl_acpi could do the rescan, it makes sense to be here as
+	 * other platform drivers might require the same functionality.
+	 */
+	INIT_WORK(&port->rescan_work, rescan_ports);
+	queue_work(cxl_port_wq, &port->rescan_work);
+
+	return 0;
+}
+
+static struct cxl_driver cxl_port_driver = {
+	.name = "cxl_port",
+	.probe = cxl_port_probe,
+	.id = CXL_DEVICE_PORT,
+};
+
+static __init int cxl_port_init(void)
+{
+	int rc;
+
+	cxl_port_wq = alloc_ordered_workqueue("cxl_port", 0);
+	if (!cxl_port_wq)
+		return -ENOMEM;
+
+	rc = cxl_driver_register(&cxl_port_driver);
+	if (rc) {
+		destroy_workqueue(cxl_port_wq);
+		return rc;
+	}
+
+	return 0;
+}
+
+static __exit void cxl_port_exit(void)
+{
+	destroy_workqueue(cxl_port_wq);
+	cxl_driver_unregister(&cxl_port_driver);
+}
+
+module_init(cxl_port_init);
+module_exit(cxl_port_exit);
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(CXL);
+MODULE_ALIAS_CXL(CXL_DEVICE_PORT);
-- 
2.34.0

