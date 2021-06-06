Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9542D39CD9D
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jun 2021 08:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhFFGHR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Jun 2021 02:07:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:28081 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230112AbhFFGHR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Jun 2021 02:07:17 -0400
IronPort-SDR: rgv4/8FbL7PrUCTDyivIFbmnyN88kLYPaSxBEnCgcHBEUIlArV2N936+dHkAtlEqi1KTLhC5VR
 fz4gvwcvGsRQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10006"; a="201463342"
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="201463342"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 23:05:28 -0700
IronPort-SDR: wu+QIUF9eqMdLaFZyOqEzkcrogwg3orAXkQVaQUyp0zUExxBjnPPt1wmX42I8maQgCcnuZ5rB/
 Uid2vR0yhRwQ==
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="448738444"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 23:05:27 -0700
Subject: [PATCH v5 6/6] cxl/acpi: Introduce cxl_decoder objects
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Date:   Sat, 05 Jun 2021 23:05:27 -0700
Message-ID: <162295952770.1109360.877553895768113895.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162295949351.1109360.10329014558746500142.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162295949351.1109360.10329014558746500142.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A cxl_decoder is a child of a cxl_port. It represents a hardware
decoder configuration of an upstream port to one or more of its
downstream ports. The decoder is either represented in standard HDM
decoder registers (see CXL 2.0 section 8.2.5.12 CXL HDM Decoder
Capability Structure), or it is a static decode configuration
communicated by platform firmware (see the CXL Early Discovery Table:
Fixed Memory Window Structure).

The firmware described and hardware described decoders differ slightly
leading to 2 different sub-types of decoders, cxl_decoder_root and
cxl_decoder_switch. At the root level the decode capabilities restrict
what can be mapped beneath them. Mid-level switch decoders are
configured for either acclerator (type-2) or memory-expander (type-3)
operation, but they are otherwise agnostic to the type of memory
(volatile vs persistent) being mapped.

Here is an example topology from a single-ported host-bridge environment
without CFMWS decodes enumerated.

/sys/bus/cxl/devices/root0
├── devtype
├── dport0 -> ../LNXSYSTM:00/LNXSYBUS:00/ACPI0016:00
├── port1
│   ├── decoder1.0
│   │   ├── devtype
│   │   ├── end
│   │   ├── locked
│   │   ├── start
│   │   ├── subsystem -> ../../../../bus/cxl
│   │   ├── target_list
│   │   ├── target_type
│   │   └── uevent
│   ├── devtype
│   ├── dport0 -> ../../pci0000:34/0000:34:00.0
│   ├── subsystem -> ../../../bus/cxl
│   ├── uevent
│   └── uport -> ../../LNXSYSTM:00/LNXSYBUS:00/ACPI0016:00
├── subsystem -> ../../bus/cxl
├── uevent
└── uport -> ../platform/ACPI0017:00

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |   70 ++++++++
 drivers/cxl/acpi.c                      |   21 ++
 drivers/cxl/core.c                      |  265 +++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h                       |   48 ++++++
 4 files changed, 403 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 0cb31b7ad17b..f16f18e77578 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -48,3 +48,73 @@ Description:
 		decode of CXL memory resources.  The 'Y' integer reflects the
 		hardware port unique-id used in the hardware decoder target
 		list.
+
+What:		/sys/bus/cxl/devices/decoderX.Y
+Date:		June, 2021
+KernelVersion:	v5.14
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		CXL decoder objects are enumerated from either a platform
+		firmware description, or a CXL HDM decoder register set in a
+		PCIe device (see CXL 2.0 section 8.2.5.12 CXL HDM Decoder
+		Capability Structure). The 'X' in decoderX.Y represents the
+		cxl_port container of this decoder, and 'Y' represents the
+		instance id of a given decoder resource.
+
+What:		/sys/bus/cxl/devices/decoderX.Y/{start,end}
+Date:		June, 2021
+KernelVersion:	v5.14
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		The 'start' and 'end' attributes together convey the physical
+		address base and last addressable byte of the decoder's decode
+		window. For decoders of devtype "cxl_decoder_root" the address
+		range is fixed. For decoders of devtype "cxl_decoder_switch" the
+		address is bounded by the decode range of the cxl_port ancestor
+		of the decoder's cxl_port, and dynamically updates based on the
+		active memory regions in that address space.
+
+What:		/sys/bus/cxl/devices/decoderX.Y/locked
+Date:		June, 2021
+KernelVersion:	v5.14
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		CXL HDM decoders have the capability to lock the configuration
+		until the next device reset. For decoders of devtype
+		"cxl_decoder_root" there is no standard facility to unlock them.
+		For decoders of devtype "cxl_decoder_switch" a secondary bus
+		reset, of the PCIe bridge that provides the bus for this
+		decoders uport, unlocks / resets the decoder.
+
+What:		/sys/bus/cxl/devices/decoderX.Y/target_list
+Date:		June, 2021
+KernelVersion:	v5.14
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		Display a comma separated list of the current decoder target
+		configuration. The list is ordered by the current configured
+		interleave order of the decoder's dport instances. Each entry in
+		the list is a dport id.
+
+What:		/sys/bus/cxl/devices/decoderX.Y/cap_{pmem,ram,type2,type3}
+Date:		June, 2021
+KernelVersion:	v5.14
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		When a CXL decoder is of devtype "cxl_decoder_root", it
+		represents a fixed memory window identified by platform
+		firmware. A fixed window may only support a subset of memory
+		types. The 'cap_*' attributes indicate whether persistent
+		memory, volatile memory, accelerator memory, and / or expander
+		memory may be mapped behind this decoder's memory window.
+
+What:		/sys/bus/cxl/devices/decoderX.Y/target_type
+Date:		June, 2021
+KernelVersion:	v5.14
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		When a CXL decoder is of devtype "cxl_decoder_switch", it can
+		optionally decode either accelerator memory (type-2) or expander
+		memory (type-3). The 'target_type' attribute indicates the
+		current setting which may dynamically change based on what
+		memory regions are activated in this decode hierarchy.
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index ec324bf063b8..6f203ba7fc1d 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -70,6 +70,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	struct device *host = root_port->dev.parent;
 	struct acpi_pci_root *pci_root;
 	struct cxl_walk_context ctx;
+	struct cxl_decoder *cxld;
 	struct cxl_port *port;
 
 	if (!bridge)
@@ -94,7 +95,25 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 
 	if (ctx.count == 0)
 		return -ENODEV;
-	return ctx.error;
+	if (ctx.error)
+		return ctx.error;
+
+	/* TODO: Scan CHBCR for HDM Decoder resources */
+
+	/*
+	 * In the single-port host-bridge case there are no HDM decoders
+	 * in the CHBCR and a 1:1 passthrough decode is implied.
+	 */
+	if (ctx.count == 1) {
+		cxld = devm_cxl_add_decoder(host, port, 1, 0, -2, 1, 0,
+					    CXL_DECODER_EXPANDER, 0);
+		if (IS_ERR(cxld))
+			return PTR_ERR(cxld);
+
+		dev_dbg(host, "add: %s\n", dev_name(&cxld->dev));
+	}
+
+	return 0;
 }
 
 static int add_host_bridge_dport(struct device *match, void *arg)
diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index 4418b30cce4f..781efe51f186 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -33,6 +33,168 @@ static struct attribute_group cxl_base_attribute_group = {
 	.attrs = cxl_base_attributes,
 };
 
+static ssize_t start_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+
+	return sysfs_emit(buf, "%#llx\n", cxld->range.start);
+}
+static DEVICE_ATTR_RO(start);
+
+static ssize_t end_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+
+	return sysfs_emit(buf, "%#llx\n", cxld->range.end);
+}
+static DEVICE_ATTR_RO(end);
+
+#define CXL_DECODER_FLAG_ATTR(name, flag)                            \
+static ssize_t name##_show(struct device *dev,                       \
+			   struct device_attribute *attr, char *buf) \
+{                                                                    \
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);              \
+                                                                     \
+	return sysfs_emit(buf, "%s\n",                               \
+			  (cxld->flags & (flag)) ? "1" : "0");       \
+}                                                                    \
+static DEVICE_ATTR_RO(name)
+
+CXL_DECODER_FLAG_ATTR(cap_pmem, CXL_DECODER_F_PMEM);
+CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
+CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
+CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
+CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
+
+static ssize_t target_type_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+
+	switch (cxld->target_type) {
+	case CXL_DECODER_ACCELERATOR:
+		return sysfs_emit(buf, "accelerator\n");
+	case CXL_DECODER_EXPANDER:
+		return sysfs_emit(buf, "expander\n");
+	}
+	return -ENXIO;
+}
+DEVICE_ATTR_RO(target_type);
+
+static ssize_t target_list_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	ssize_t offset = 0;
+	int i, rc = 0;
+
+	device_lock(dev);
+	for (i = 0; i < cxld->interleave_ways; i++) {
+		struct cxl_dport *dport = cxld->target[i];
+		struct cxl_dport *next = NULL;
+
+		if (!dport)
+			break;
+
+		if (i + 1 < cxld->interleave_ways)
+			next = cxld->target[i + 1];
+		rc = sysfs_emit_at(buf, offset, "%d%s", dport->port_id,
+				   next ? "," : "");
+		if (rc < 0)
+			break;
+		offset += rc;
+	}
+	device_unlock(dev);
+
+	if (rc < 0)
+		return rc;
+
+	rc = sysfs_emit_at(buf, offset, "\n");
+	if (rc < 0)
+		return rc;
+
+	return offset + rc;
+}
+DEVICE_ATTR_RO(target_list);
+
+static struct attribute *cxl_decoder_base_attrs[] = {
+	&dev_attr_start.attr,
+	&dev_attr_end.attr,
+	&dev_attr_locked.attr,
+	&dev_attr_target_list.attr,
+	NULL,
+};
+
+static struct attribute_group cxl_decoder_base_attribute_group = {
+	.attrs = cxl_decoder_base_attrs,
+};
+
+static struct attribute *cxl_decoder_root_attrs[] = {
+	&dev_attr_cap_pmem.attr,
+	&dev_attr_cap_ram.attr,
+	&dev_attr_cap_type2.attr,
+	&dev_attr_cap_type3.attr,
+	NULL,
+};
+
+static struct attribute_group cxl_decoder_root_attribute_group = {
+	.attrs = cxl_decoder_root_attrs,
+};
+
+static const struct attribute_group *cxl_decoder_root_attribute_groups[] = {
+	&cxl_decoder_root_attribute_group,
+	&cxl_decoder_base_attribute_group,
+	&cxl_base_attribute_group,
+	NULL,
+};
+
+static struct attribute *cxl_decoder_switch_attrs[] = {
+	&dev_attr_target_type.attr,
+	NULL,
+};
+
+static struct attribute_group cxl_decoder_switch_attribute_group = {
+	.attrs = cxl_decoder_switch_attrs,
+};
+
+static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
+	&cxl_decoder_switch_attribute_group,
+	&cxl_decoder_base_attribute_group,
+	&cxl_base_attribute_group,
+	NULL,
+};
+
+static void cxl_decoder_release(struct device *dev)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	struct cxl_port *port = to_cxl_port(dev->parent);
+
+	ida_free(&port->decoder_ida, cxld->id);
+	kfree(cxld);
+}
+
+static const struct device_type cxl_decoder_switch_type = {
+	.name = "cxl_decoder_switch",
+	.release = cxl_decoder_release,
+	.groups = cxl_decoder_switch_attribute_groups,
+};
+
+static const struct device_type cxl_decoder_root_type = {
+	.name = "cxl_decoder_root",
+	.release = cxl_decoder_release,
+	.groups = cxl_decoder_root_attribute_groups,
+};
+
+struct cxl_decoder *to_cxl_decoder(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, dev->type->release != cxl_decoder_release,
+			  "not a cxl_decoder device\n"))
+		return NULL;
+	return container_of(dev, struct cxl_decoder, dev);
+}
+
 static void cxl_dport_release(struct cxl_dport *dport)
 {
 	put_device(dport->dport);
@@ -138,6 +300,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 
 	port->uport = uport;
 	port->component_reg_phys = component_reg_phys;
+	ida_init(&port->decoder_ida);
 	INIT_LIST_HEAD(&port->dports);
 
 	device_initialize(dev);
@@ -262,6 +425,108 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
 }
 EXPORT_SYMBOL_GPL(cxl_add_dport);
 
+static struct cxl_decoder *
+cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
+		  resource_size_t len, int interleave_ways,
+		  int interleave_granularity, enum cxl_decoder_type type,
+		  unsigned long flags)
+{
+	struct cxl_decoder *cxld;
+	struct device *dev;
+	int rc = 0;
+
+	if (interleave_ways < 1)
+		return ERR_PTR(-EINVAL);
+
+	device_lock(&port->dev);
+	if (list_empty(&port->dports))
+		rc = -EINVAL;
+	device_unlock(&port->dev);
+	if (rc)
+		return ERR_PTR(rc);
+
+	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
+	if (!cxld)
+		return ERR_PTR(-ENOMEM);
+
+	rc = ida_alloc(&port->decoder_ida, GFP_KERNEL);
+	if (rc < 0)
+		goto err;
+
+	*cxld = (struct cxl_decoder) {
+		.id = rc,
+		.range = {
+			.start = base,
+			.end = base + len - 1,
+		},
+		.flags = flags,
+		.interleave_ways = interleave_ways,
+		.interleave_granularity = interleave_granularity,
+		.target_type = type,
+	};
+
+	/* handle implied target_list */
+	if (interleave_ways == 1)
+		cxld->target[0] =
+			list_first_entry(&port->dports, struct cxl_dport, list);
+	dev = &cxld->dev;
+	device_initialize(dev);
+	device_set_pm_not_required(dev);
+	dev->parent = &port->dev;
+	dev->bus = &cxl_bus_type;
+
+	/* root ports do not have a cxl_port_type parent */
+	if (port->dev.parent->type == &cxl_port_type)
+		dev->type = &cxl_decoder_switch_type;
+	else
+		dev->type = &cxl_decoder_root_type;
+
+	return cxld;
+err:
+	kfree(cxld);
+	return ERR_PTR(rc);
+}
+
+static void unregister_dev(void *dev)
+{
+	device_unregister(dev);
+}
+
+struct cxl_decoder *
+devm_cxl_add_decoder(struct device *host, struct cxl_port *port, int nr_targets,
+		     resource_size_t base, resource_size_t len,
+		     int interleave_ways, int interleave_granularity,
+		     enum cxl_decoder_type type, unsigned long flags)
+{
+	struct cxl_decoder *cxld;
+	struct device *dev;
+	int rc;
+
+	cxld = cxl_decoder_alloc(port, nr_targets, base, len, interleave_ways,
+				 interleave_granularity, type, flags);
+	if (IS_ERR(cxld))
+		return cxld;
+
+	dev = &cxld->dev;
+	rc = dev_set_name(dev, "decoder%d.%d", port->id, cxld->id);
+	if (rc)
+		goto err;
+
+	rc = device_add(dev);
+	if (rc)
+		goto err;
+
+	rc = devm_add_action_or_reset(host, unregister_dev, dev);
+	if (rc)
+		return ERR_PTR(rc);
+	return cxld;
+
+err:
+	put_device(dev);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_GPL(devm_cxl_add_decoder);
+
 /**
  * cxl_probe_component_regs() - Detect CXL Component register blocks
  * @dev: Host device of the @base mapping
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0b89fcfe728a..f350c92d37d2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -148,6 +148,44 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
 
+/*
+ * cxl_decoder flags that define the type of memory / devices this
+ * decoder supports as well as configuration lock status See "CXL 2.0
+ * 8.2.5.12.7 CXL HDM Decoder 0 Control Register" for details.
+ */
+#define CXL_DECODER_F_RAM   BIT(0)
+#define CXL_DECODER_F_PMEM  BIT(1)
+#define CXL_DECODER_F_TYPE2 BIT(2)
+#define CXL_DECODER_F_TYPE3 BIT(3)
+#define CXL_DECODER_F_LOCK  BIT(4)
+#define CXL_DECODER_F_MASK  GENMASK(4, 0)
+
+enum cxl_decoder_type {
+       CXL_DECODER_ACCELERATOR = 2,
+       CXL_DECODER_EXPANDER = 3,
+};
+
+/**
+ * struct cxl_decoder - CXL address range decode configuration
+ * @range: address range considered by this decoder
+ * @id: kernel device name id
+ * @interleave_ways: number of cxl_dports in this decode
+ * @interleave_granularity: data stride per dport
+ * @target_type: accelerator vs expander (type2 vs type3) selector
+ * @flags: memory type capabilities and locking
+ * @target: active ordered target list in current decoder configuration
+ */
+struct cxl_decoder {
+	struct device dev;
+	int id;
+	struct range range;
+	int interleave_ways;
+	int interleave_granularity;
+	enum cxl_decoder_type target_type;
+	unsigned long flags;
+	struct cxl_dport *target[];
+};
+
 /**
  * struct cxl_port - logical collection of upstream port devices and
  *		     downstream port devices to construct a CXL memory
@@ -156,6 +194,7 @@ int cxl_map_device_regs(struct pci_dev *pdev,
  * @uport: PCI or platform device implementing the upstream port capability
  * @id: id for port device-name
  * @dports: cxl_dport instances referenced by decoders
+ * @decoder_ida: allocator for decoder ids
  * @component_regs_phys: component register capability base address (optional)
  */
 struct cxl_port {
@@ -163,6 +202,7 @@ struct cxl_port {
 	struct device *uport;
 	int id;
 	struct list_head dports;
+	struct ida decoder_ida;
 	resource_size_t component_reg_phys;
 };
 
@@ -189,5 +229,13 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 
 int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
 		  resource_size_t component_reg_phys);
+
+struct cxl_decoder *to_cxl_decoder(struct device *dev);
+struct cxl_decoder *
+devm_cxl_add_decoder(struct device *host, struct cxl_port *port, int nr_targets,
+		     resource_size_t base, resource_size_t len,
+		     int interleave_ways, int interleave_granularity,
+		     enum cxl_decoder_type type, unsigned long flags);
+
 extern struct bus_type cxl_bus_type;
 #endif /* __CXL_H__ */

