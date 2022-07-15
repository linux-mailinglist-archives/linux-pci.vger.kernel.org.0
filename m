Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73C65759CE
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 05:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241366AbiGODFb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 23:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241297AbiGODFD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 23:05:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EA976976;
        Thu, 14 Jul 2022 20:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657854301; x=1689390301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FVsHh87Yo5YlwZX3rffXt8wJY1K3tjVDtjMedpsAFoc=;
  b=PYvP6qcFmb6nSeH3dTxpVZD5pVxelsBzRTgs+XUhrRS3TzioLlWOLCfH
   3hmKMRuvp9btzzsn4d0JCSu4CZ3LkcfYPhAGGUIArvhZ21r1ogtrNGaPx
   cVV3qcHXjl31R/xYxeCaPCUWtuJxVekWxW4nRFx1xJ+972IMMTsLENNa1
   PS8233s2RdVCFT4m9CwxxsZajf/7oI5DJX8gH0qStzer++8aaHNEaILmi
   35bQrAuTzMN/gAOSAzU18tpEWB5YIi5QOywj2/wMOanYUGV3IvT1OQZce
   hhPLd2g/VCe8CHY81u/8VomldXGvJ890PiyP8QI1LmvhaAJejE/0AmDmS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="347366297"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="347366297"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 20:05:00 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="628939292"
Received: from mbordone-mobl.amr.corp.intel.com (HELO localhost) ([10.255.5.217])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 20:04:56 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V14 6/7] cxl/port: Read CDAT table
Date:   Thu, 14 Jul 2022 20:04:23 -0700
Message-Id: <20220715030424.462963-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220715030424.462963-1-ira.weiny@intel.com>
References: <20220715030424.462963-1-ira.weiny@intel.com>
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

From: Ira Weiny <ira.weiny@intel.com>

The OS will need CDAT data from CXL devices to properly set up
interleave sets.  Currently this is supported through a DOE mailbox
which supports CDAT.

Search the DOE mailboxes available, query CDAT data, and cache the data
for later parsing.

Provide a sysfs binary attribute to allow dumping of the CDAT.

Binary dumping is modeled on /sys/firmware/ACPI/tables/

The ability to dump this table will be very useful for emulation of real
devices once they become available as QEMU CXL type 3 device emulation will
be able to load this file in.

This does not support table updates at runtime. It will always provide
whatever was there when first cached. Handling of table updates can be
implemented later.

Finally create a complete list of CDAT defines within cdat.h for code
wishing to decode the CDAT table.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V13:
	Dan:
		Add entry in Documentation/ABI/testing/sysfs-bus-cxl
		Remove table parsing defines.
		s/cdat_sup/cdat_available
		s/cdat_mb/cdat_doe/
		Don't check endpoint in find_cdat_doe()
		Create CDAT_DOE_TASK macro

Changes from V12:
	Fix checking for task.rv for errors
	Ensure no over run of non-DW aligned buffer length's

Changes from V11:
	Adjust for the use of DOE mailbox xarray
	Dan Williams:
		Remove unnecessary get/put device
		Use new BIN_ATTR_ADMIN_RO macro
		Flag that CDAT was supported
			If there is a read error then the CDAT sysfs
			will return a 0 length entry

Changes from V10:
	Ben Widawsky
		Failure to find CDAT should be a debug message not error
		Remove reference to cdat_mb from the port object
	Dropped [PATCH V10 5/9] cxl/port: Find a DOE mailbox which supports
		CDAT
		Iterate the mailboxes for the CDAT one each time.
	Define CXL_DOE_TABLE_ACCESS_LAST_ENTRY and add comment about
		it's use.

Changes from V9:
	Add debugging output
	Jonathan Cameron
		Move read_cdat to port probe by using dev_groups for the
		sysfs attributes.  This avoids issues with using devm
		before the driver is loaded while making sure the CDAT
		binary is available.

Changes from V8:
	Fix length print format
	Incorporate feedback from Jonathan
	Move all this to cxl_port which can help support switches when
	the time comes.

Changes from V6:
	Fix issue with devm use
		Move cached cdat data to cxl_dev_state
	Use new pci_doe_submit_task()
	Ensure the aux driver is locked while processing tasks
	Rebased on cxl-pending

Changes from V5:
	Add proper guards around cdat.h
	Split out finding the CDAT DOE mailbox
	Use cxl_cdat to group CDAT data together
	Adjust to use auxiliary_find_device() to find the DOE device
		which supplies the CDAT protocol.
	Rebased to latest
	Remove dev_dbg(length)
	Remove unneeded DOE Table access defines
	Move CXL_DOE_PROTOCOL_TABLE_ACCESS define into this patch where
		it is used

Changes from V4:
	Split this into it's own patch
	Rearchitect this such that the memdev driver calls into the DOE
	driver via the cxl_mem state object.  This allows CDAT data to
	come from any type of cxl_mem object not just PCI DOE.
	Rebase on new struct cxl_dev_state
---
 Documentation/ABI/testing/sysfs-bus-cxl |  10 ++
 drivers/cxl/cdat.h                      |  61 +++++++++
 drivers/cxl/core/pci.c                  | 169 ++++++++++++++++++++++++
 drivers/cxl/cxl.h                       |   5 +
 drivers/cxl/cxlpci.h                    |   1 +
 drivers/cxl/port.c                      |  54 ++++++++
 6 files changed, 300 insertions(+)
 create mode 100644 drivers/cxl/cdat.h

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 1fd5984b6158..6fb6459466f8 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -164,3 +164,13 @@ Description:
 		expander memory (type-3). The 'target_type' attribute indicates
 		the current setting which may dynamically change based on what
 		memory regions are activated in this decode hierarchy.
+
+What:		/sys/bus/cxl/devices/endpointX/CDAT/cdat
+Date:		July, 2022
+KernelVersion:	v5.19
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) If this sysfs entry is not present no DOE mailbox was
+		found to support CDAT data.  If it is present and the length of
+		the data is 0 reading the CDAT data failed.  Otherwise the CDAT
+		data is reported.
diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
new file mode 100644
index 000000000000..67010717ffca
--- /dev/null
+++ b/drivers/cxl/cdat.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __CXL_CDAT_H__
+#define __CXL_CDAT_H__
+
+/*
+ * Coherent Device Attribute table (CDAT)
+ *
+ * Specification available from UEFI.org
+ *
+ * Whilst CDAT is defined as a single table, the access via DOE maiboxes is
+ * done one entry at a time, where the first entry is the header.
+ */
+
+#define CXL_DOE_TABLE_ACCESS_REQ_CODE		0x000000ff
+#define   CXL_DOE_TABLE_ACCESS_REQ_CODE_READ	0
+#define CXL_DOE_TABLE_ACCESS_TABLE_TYPE		0x0000ff00
+#define   CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA	0
+#define CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE	0xffff0000
+#define CXL_DOE_TABLE_ACCESS_LAST_ENTRY		0xffff
+
+/*
+ * CDAT entries are little endian and are read from PCI config space which
+ * is also little endian.
+ * As such, on a big endian system these will have been reversed.
+ * This prevents us from making easy use of packed structures.
+ * Style form pci_regs.h
+ */
+
+#define CDAT_HEADER_LENGTH_DW 4
+#define CDAT_HEADER_LENGTH_BYTES (CDAT_HEADER_LENGTH_DW * sizeof(u32))
+#define CDAT_HEADER_DW0_LENGTH		0xffffffff
+#define CDAT_HEADER_DW1_REVISION	0x000000ff
+#define CDAT_HEADER_DW1_CHECKSUM	0x0000ff00
+/* CDAT_HEADER_DW2_RESERVED	*/
+#define CDAT_HEADER_DW3_SEQUENCE	0xffffffff
+
+/* All structures have a common first DW */
+#define CDAT_STRUCTURE_DW0_TYPE		0x000000ff
+#define   CDAT_STRUCTURE_DW0_TYPE_DSMAS 0
+#define   CDAT_STRUCTURE_DW0_TYPE_DSLBIS 1
+#define   CDAT_STRUCTURE_DW0_TYPE_DSMSCIS 2
+#define   CDAT_STRUCTURE_DW0_TYPE_DSIS 3
+#define   CDAT_STRUCTURE_DW0_TYPE_DSEMTS 4
+#define   CDAT_STRUCTURE_DW0_TYPE_SSLBIS 5
+
+#define CDAT_STRUCTURE_DW0_LENGTH	0xffff0000
+
+#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
+
+/**
+ * struct cxl_cdat - CXL CDAT data
+ *
+ * @table: cache of CDAT table
+ * @length: length of cached CDAT table
+ */
+struct cxl_cdat {
+	void *table;
+	size_t length;
+};
+
+#endif /* !__CXL_CDAT_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 7672789c3225..dd5d1da412ca 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -4,10 +4,12 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
+#include <linux/pci-doe.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
 #include "core.h"
+#include "cdat.h"
 
 /**
  * DOC: cxl core pci
@@ -452,3 +454,170 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
+
+static struct pci_doe_mb *find_cdat_doe(struct device *uport)
+{
+	struct cxl_memdev *cxlmd;
+	struct cxl_dev_state *cxlds;
+	unsigned long index;
+	void *entry;
+
+	cxlmd = to_cxl_memdev(uport);
+	cxlds = cxlmd->cxlds;
+
+	xa_for_each(&cxlds->doe_mbs, index, entry) {
+		struct pci_doe_mb *cur = entry;
+
+		if (pci_doe_supports_prot(cur, PCI_DVSEC_VENDOR_ID_CXL,
+					  CXL_DOE_PROTOCOL_TABLE_ACCESS))
+			return cur;
+	}
+
+	return NULL;
+}
+
+#define CDAT_DOE_REQ(entry_handle)					\
+	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
+		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
+	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_TABLE_TYPE,			\
+		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
+	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
+
+static void cxl_doe_task_complete(struct pci_doe_task *task)
+{
+	complete(task->private);
+}
+
+#define CDAT_DOE_TASK(req, req_sz, rsp, rsp_sz, comp)	\
+{							\
+	.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,		\
+	.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,	\
+	.request_pl = req,				\
+	.request_pl_sz = req_sz,			\
+	.response_pl = rsp,				\
+	.response_pl_sz = rsp_sz,			\
+	.complete = cxl_doe_task_complete,		\
+	.private = comp,			\
+}
+
+static int cxl_cdat_get_length(struct device *dev,
+			       struct pci_doe_mb *cdat_doe,
+			       size_t *length)
+{
+	u32 cdat_request_pl = CDAT_DOE_REQ(0);
+	u32 cdat_response_pl[32];
+	DECLARE_COMPLETION_ONSTACK(c);
+	struct pci_doe_task task = CDAT_DOE_TASK(&cdat_request_pl,
+						 sizeof(cdat_request_pl),
+						 cdat_response_pl,
+						 sizeof(cdat_response_pl),
+						 &c);
+	int rc;
+
+	rc = pci_doe_submit_task(cdat_doe, &task);
+	if (rc < 0) {
+		dev_err(dev, "DOE submit failed: %d", rc);
+		return rc;
+	}
+	wait_for_completion(&c);
+	if (task.rv < sizeof(u32))
+		return -EIO;
+
+	*length = cdat_response_pl[1];
+	dev_dbg(dev, "CDAT length %zu\n", *length);
+
+	return 0;
+}
+
+static int cxl_cdat_read_table(struct device *dev,
+			       struct pci_doe_mb *cdat_doe,
+			       struct cxl_cdat *cdat)
+{
+	size_t length = cdat->length;
+	u32 *data = cdat->table;
+	int entry_handle = 0;
+
+	do {
+		u32 cdat_request_pl = CDAT_DOE_REQ(entry_handle);
+		u32 cdat_response_pl[32];
+		DECLARE_COMPLETION_ONSTACK(c);
+		struct pci_doe_task task = CDAT_DOE_TASK(&cdat_request_pl,
+							 sizeof(cdat_request_pl),
+							 cdat_response_pl,
+							 sizeof(cdat_response_pl),
+							 &c);
+		size_t entry_dw;
+		u32 *entry;
+		int rc;
+
+		rc = pci_doe_submit_task(cdat_doe, &task);
+		if (rc < 0) {
+			dev_err(dev, "DOE submit failed: %d", rc);
+			return rc;
+		}
+		wait_for_completion(&c);
+		/* 1 DW header + 1 DW data min */
+		if (task.rv < (2 * sizeof(u32)))
+			return -EIO;
+
+		/* Get the CXL table access header entry handle */
+		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
+					 cdat_response_pl[0]);
+		entry = cdat_response_pl + 1;
+		entry_dw = task.rv / sizeof(u32);
+		/* Skip Header */
+		entry_dw -= 1;
+		entry_dw = min(length / sizeof(u32), entry_dw);
+		/* Prevent length < 1 DW from causing a buffer overflow */
+		if (entry_dw) {
+			memcpy(data, entry, entry_dw * sizeof(u32));
+			length -= entry_dw * sizeof(u32);
+			data += entry_dw;
+		}
+	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
+
+	return 0;
+}
+
+/**
+ * read_cdat_data - Read the CDAT data on this port
+ * @port: Port to read data from
+ *
+ * This call will sleep waiting for responses from the DOE mailbox.
+ */
+void read_cdat_data(struct cxl_port *port)
+{
+	static struct pci_doe_mb *cdat_doe;
+	struct device *dev = &port->dev;
+	struct device *uport = port->uport;
+	size_t cdat_length;
+	int rc;
+
+	cdat_doe = find_cdat_doe(uport);
+	if (!cdat_doe) {
+		dev_dbg(dev, "No CDAT mailbox\n");
+		return;
+	}
+
+	port->cdat_available = true;
+
+	if (cxl_cdat_get_length(dev, cdat_doe, &cdat_length)) {
+		dev_dbg(dev, "No CDAT length\n");
+		return;
+	}
+
+	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
+	if (!port->cdat.table)
+		return;
+
+	port->cdat.length = cdat_length;
+	rc = cxl_cdat_read_table(dev, cdat_doe, &port->cdat);
+	if (rc) {
+		/* Don't leave table data allocated on error */
+		devm_kfree(dev, port->cdat.table);
+		port->cdat.table = NULL;
+		port->cdat.length = 0;
+		dev_err(dev, "CDAT data read error\n");
+	}
+}
+EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 570bd9f8141b..64ea8c80b917 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
+#include "cdat.h"
 
 /**
  * DOC: cxl objects
@@ -289,6 +290,8 @@ struct cxl_nvdimm {
  * @component_reg_phys: component register capability base address (optional)
  * @dead: last ep has been removed, force port re-creation
  * @depth: How deep this port is relative to the root. depth 0 is the root.
+ * @cdat: Cached CDAT data
+ * @cdat_available: Should a CDAT attribute be available in sysfs
  */
 struct cxl_port {
 	struct device dev;
@@ -301,6 +304,8 @@ struct cxl_port {
 	resource_size_t component_reg_phys;
 	bool dead;
 	unsigned int depth;
+	struct cxl_cdat cdat;
+	bool cdat_available;
 };
 
 /**
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index fce1c11729c2..eec597dbe763 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -74,4 +74,5 @@ static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
+void read_cdat_data(struct cxl_port *port);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 3cf308f114c4..08b8ac76f87b 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -53,6 +53,9 @@ static int cxl_port_probe(struct device *dev)
 		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
 		struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
+		/* Cache the data early to ensure is_visible() works */
+		read_cdat_data(port);
+
 		get_device(&cxlmd->dev);
 		rc = devm_add_action_or_reset(dev, schedule_detach, cxlmd);
 		if (rc)
@@ -78,10 +81,61 @@ static int cxl_port_probe(struct device *dev)
 	return 0;
 }
 
+static ssize_t cdat_read(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *bin_attr, char *buf,
+			 loff_t offset, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_port *port = to_cxl_port(dev);
+
+	if (!port->cdat_available)
+		return -ENXIO;
+
+	if (!port->cdat.table)
+		return 0;
+
+	return memory_read_from_buffer(buf, count, &offset,
+				       port->cdat.table,
+				       port->cdat.length);
+}
+
+static BIN_ATTR_ADMIN_RO(cdat, 0);
+
+static umode_t cxl_port_bin_attr_is_visible(struct kobject *kobj,
+					      struct bin_attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_port *port = to_cxl_port(dev);
+
+	if ((attr == &bin_attr_cdat) && port->cdat_available)
+		return attr->attr.mode;
+
+	return 0;
+}
+
+static struct bin_attribute *cxl_cdat_bin_attributes[] = {
+	&bin_attr_cdat,
+	NULL,
+};
+
+static struct attribute_group cxl_cdat_attribute_group = {
+	.name = "CDAT",
+	.bin_attrs = cxl_cdat_bin_attributes,
+	.is_bin_visible = cxl_port_bin_attr_is_visible,
+};
+
+static const struct attribute_group *cxl_port_attribute_groups[] = {
+	&cxl_cdat_attribute_group,
+	NULL,
+};
+
 static struct cxl_driver cxl_port_driver = {
 	.name = "cxl_port",
 	.probe = cxl_port_probe,
 	.id = CXL_DEVICE_PORT,
+	.drv = {
+		.dev_groups = cxl_port_attribute_groups,
+	},
 };
 
 module_cxl_driver(cxl_port_driver);
-- 
2.35.3

