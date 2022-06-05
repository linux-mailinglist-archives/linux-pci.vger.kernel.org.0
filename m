Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358D753D8F1
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jun 2022 02:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242798AbiFEAvb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Jun 2022 20:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242941AbiFEAv3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Jun 2022 20:51:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8663B4EF4C;
        Sat,  4 Jun 2022 17:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654390276; x=1685926276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VO7OkVTMZXD0Q9b4mN9pM4uOMvXLwa3xIOSX97GLVCM=;
  b=kgf3MVeqxpvIgXUafxON4MpK4ImzRYHuUYbaI9hO1XD6xn5xDF34xdM+
   7qzIFEc6tlrXfP/aFmaYfEJzrzTLaMutnslyMAP78GDdXtoCg+RcUUuhF
   DGIZQETkk/+ZXvXbGl6ZSXGzzUaIRHc+ser9glRvtnFq/c0sFlRvKHVAL
   G0HANXS6WlKWlVnSVjXvYF6yY62jgbMG6RmaZPgEwmwgjdYCmc5UM+Z5v
   p0+xv4uq/hjmjIrsJG0UZ/2EG+qWz0wRWw5gqhmUCjPiiEF3cMzq06lCq
   YPvebdAT0wtZLRtY6cOObITxxH1uV1oqKOyNgIGEInIrMTwekvR8D8EJH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="276538633"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="276538633"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 17:51:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="531516507"
Received: from aftome-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.107.207])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 17:51:15 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben@bwidawsk.net>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH V10 6/9] cxl/port: Read CDAT table
Date:   Sat,  4 Jun 2022 17:50:46 -0700
Message-Id: <20220605005049.2155874-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220605005049.2155874-1-ira.weiny@intel.com>
References: <20220605005049.2155874-1-ira.weiny@intel.com>
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The OS will need CDAT data from CXL devices to properly set up
interleave sets.  Currently this is supported through a DOE mailbox
which supports CDAT.

Cache the CDAT data for later parsing.  Provide a sysfs binary attribute
to allow dumping of the CDAT.

Binary dumping is modeled on /sys/firmware/ACPI/tables/

The ability to dump this table will be very useful for emulation of real
devices once they become available as QEMU CXL type 3 device emulation will
be able to load this file in.

This does not support table updates at runtime. It will always provide
whatever was there when first cached. Handling of table updates can be
implemented later.

Finally create a complete list of DOE defines within cdat.h for code
wishing to decode the CDAT table.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
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
 drivers/cxl/cdat.h     |  99 ++++++++++++++++++++++++++++++
 drivers/cxl/core/pci.c | 136 ++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxl.h      |   3 +
 drivers/cxl/cxlpci.h   |   1 +
 drivers/cxl/port.c     |  50 +++++++++++++++
 5 files changed, 287 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cxl/cdat.h

diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
new file mode 100644
index 000000000000..f5193a6a51fe
--- /dev/null
+++ b/drivers/cxl/cdat.h
@@ -0,0 +1,99 @@
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
+/* Device Scoped Memory Affinity Structure */
+#define CDAT_DSMAS_DW1_DSMAD_HANDLE	0x000000ff
+#define CDAT_DSMAS_DW1_FLAGS		0x0000ff00
+#define CDAT_DSMAS_DPA_OFFSET(entry) ((u64)((entry)[3]) << 32 | (entry)[2])
+#define CDAT_DSMAS_DPA_LEN(entry) ((u64)((entry)[5]) << 32 | (entry)[4])
+#define CDAT_DSMAS_NON_VOLATILE(flags)  ((flags & 0x04) >> 2)
+
+/* Device Scoped Latency and Bandwidth Information Structure */
+#define CDAT_DSLBIS_DW1_HANDLE		0x000000ff
+#define CDAT_DSLBIS_DW1_FLAGS		0x0000ff00
+#define CDAT_DSLBIS_DW1_DATA_TYPE	0x00ff0000
+#define CDAT_DSLBIS_BASE_UNIT(entry) ((u64)((entry)[3]) << 32 | (entry)[2])
+#define CDAT_DSLBIS_DW4_ENTRY_0		0x0000ffff
+#define CDAT_DSLBIS_DW4_ENTRY_1		0xffff0000
+#define CDAT_DSLBIS_DW5_ENTRY_2		0x0000ffff
+
+/* Device Scoped Memory Side Cache Information Structure */
+#define CDAT_DSMSCIS_DW1_HANDLE		0x000000ff
+#define CDAT_DSMSCIS_MEMORY_SIDE_CACHE_SIZE(entry) \
+	((u64)((entry)[3]) << 32 | (entry)[2])
+#define CDAT_DSMSCIS_DW4_MEMORY_SIDE_CACHE_ATTRS 0xffffffff
+
+/* Device Scoped Initiator Structure */
+#define CDAT_DSIS_DW1_FLAGS		0x000000ff
+#define CDAT_DSIS_DW1_HANDLE		0x0000ff00
+
+/* Device Scoped EFI Memory Type Structure */
+#define CDAT_DSEMTS_DW1_HANDLE		0x000000ff
+#define CDAT_DSEMTS_DW1_EFI_MEMORY_TYPE_ATTR	0x0000ff00
+#define CDAT_DSEMTS_DPA_OFFSET(entry)	((u64)((entry)[3]) << 32 | (entry)[2])
+#define CDAT_DSEMTS_DPA_LENGTH(entry)	((u64)((entry)[5]) << 32 | (entry)[4])
+
+/* Switch Scoped Latency and Bandwidth Information Structure */
+#define CDAT_SSLBIS_DW1_DATA_TYPE	0x000000ff
+#define CDAT_SSLBIS_BASE_UNIT(entry)	((u64)((entry)[3]) << 32 | (entry)[2])
+#define CDAT_SSLBIS_ENTRY_PORT_X(entry, i) ((entry)[4 + (i) * 2] & 0x0000ffff)
+#define CDAT_SSLBIS_ENTRY_PORT_Y(entry, i) (((entry)[4 + (i) * 2] & 0xffff0000) >> 16)
+#define CDAT_SSLBIS_ENTRY_LAT_OR_BW(entry, i) ((entry)[4 + (i) * 2 + 1] & 0x0000ffff)
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
index d814d8317975..76fa8382b3c7 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -9,8 +9,7 @@
 #include <cxlmem.h>
 #include <cxl.h>
 #include "core.h"
-
-#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
+#include "cdat.h"
 
 /**
  * DOC: cxl core pci
@@ -493,3 +492,136 @@ void cxl_cache_cdat_mb(struct cxl_port *port)
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cache_cdat_mb, CXL);
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
+static int cxl_cdat_get_length(struct cxl_port *port, size_t *length)
+{
+	u32 cdat_request_pl = CDAT_DOE_REQ(0);
+	u32 cdat_response_pl[32];
+	DECLARE_COMPLETION_ONSTACK(c);
+	struct pci_doe_task task = {
+		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,
+		.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,
+		.request_pl = &cdat_request_pl,
+		.request_pl_sz = sizeof(cdat_request_pl),
+		.response_pl = cdat_response_pl,
+		.response_pl_sz = sizeof(cdat_response_pl),
+		.complete = cxl_doe_task_complete,
+		.private = &c,
+	};
+	int rc = 0;
+
+	if (!port->cdat_mb) {
+		dev_err(&port->dev, "No CDAT mailbox\n");
+		return -EIO;
+	}
+
+	rc = pci_doe_submit_task(port->cdat_mb, &task);
+	if (rc < 0) {
+		dev_err(&port->dev, "DOE submit failed: %d", rc);
+		return rc;
+	}
+	wait_for_completion(&c);
+
+	if (task.rv < 1)
+		return -EIO;
+
+	*length = cdat_response_pl[1];
+	dev_dbg(&port->dev, "CDAT length %zu\n", *length);
+
+	return rc;
+}
+
+static int cxl_cdat_read_table(struct cxl_port *port,
+			       struct cxl_cdat *cdat)
+{
+	size_t length = cdat->length;
+	u32 *data = cdat->table;
+	int entry_handle = 0;
+	int rc = 0;
+
+	if (!port->cdat_mb) {
+		dev_err(&port->dev, "No CDAT mailbox\n");
+		return -EIO;
+	}
+
+	do {
+		u32 cdat_request_pl = CDAT_DOE_REQ(entry_handle);
+		u32 cdat_response_pl[32];
+		DECLARE_COMPLETION_ONSTACK(c);
+		struct pci_doe_task task = {
+			.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,
+			.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,
+			.request_pl = &cdat_request_pl,
+			.request_pl_sz = sizeof(cdat_request_pl),
+			.response_pl = cdat_response_pl,
+			.response_pl_sz = sizeof(cdat_response_pl),
+			.complete = cxl_doe_task_complete,
+			.private = &c,
+		};
+		size_t entry_dw;
+		u32 *entry;
+
+		rc = pci_doe_submit_task(port->cdat_mb, &task);
+		if (rc < 0) {
+			dev_err(&port->dev, "DOE submit failed: %d", rc);
+			return rc;
+		}
+		wait_for_completion(&c);
+
+		entry = cdat_response_pl + 1;
+		entry_dw = task.rv / sizeof(u32);
+		/* Skip Header */
+		entry_dw -= 1;
+		entry_dw = min(length / 4, entry_dw);
+		memcpy(data, entry, entry_dw * sizeof(u32));
+		length -= entry_dw * sizeof(u32);
+		data += entry_dw;
+		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, cdat_response_pl[0]);
+
+	} while (entry_handle != 0xFFFF);
+
+	return rc;
+}
+
+void read_cdat_data(struct cxl_port *port)
+{
+	struct device *dev = &port->dev;
+	size_t cdat_length;
+	int ret;
+
+	if (cxl_cdat_get_length(port, &cdat_length))
+		return;
+
+	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
+	if (!port->cdat.table) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	port->cdat.length = cdat_length;
+	ret = cxl_cdat_read_table(port, &port->cdat);
+	if (ret) {
+		devm_kfree(dev, port->cdat.table);
+		port->cdat.table = NULL;
+		port->cdat.length = 0;
+		ret = -EIO;
+		goto error;
+	}
+
+	return;
+error:
+	dev_err(dev, "CDAT data read error (%d)\n", ret);
+}
+EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0a86be589ffc..531b77d296c7 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
+#include "cdat.h"
 
 /**
  * DOC: cxl objects
@@ -268,6 +269,7 @@ struct cxl_nvdimm {
  * @dead: last ep has been removed, force port re-creation
  * @depth: How deep this port is relative to the root. depth 0 is the root.
  * @cdat_mb: Mailbox which supports the CDAT protocol
+ * @cdat: Cached CDAT data
  */
 struct cxl_port {
 	struct device dev;
@@ -280,6 +282,7 @@ struct cxl_port {
 	bool dead;
 	unsigned int depth;
 	struct pci_doe_mb *cdat_mb;
+	struct cxl_cdat cdat;
 };
 
 /**
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index ddbb8b77752e..71009a167a92 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -75,4 +75,5 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
 void cxl_cache_cdat_mb(struct cxl_port *port);
+void read_cdat_data(struct cxl_port *port);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 04f3d1fc6e07..fdff20cf79e6 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -50,6 +50,8 @@ static int cxl_port_probe(struct device *dev)
 		return PTR_ERR(cxlhdm);
 
 	cxl_cache_cdat_mb(port);
+	/* Cache the data early to ensure is_visible() works */
+	read_cdat_data(port);
 
 	if (is_cxl_endpoint(port)) {
 		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
@@ -80,10 +82,58 @@ static int cxl_port_probe(struct device *dev)
 	return 0;
 }
 
+static ssize_t cdat_read(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *bin_attr, char *buf,
+			 loff_t offset, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_port *port = to_cxl_port(dev);
+
+	if (!port->cdat.table)
+		return 0;
+
+	return memory_read_from_buffer(buf, count, &offset,
+				       port->cdat.table,
+				       port->cdat.length);
+}
+
+static BIN_ATTR_RO(cdat, 0);
+
+static umode_t cxl_port_bin_attr_is_visible(struct kobject *kobj,
+					      struct bin_attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_port *port = to_cxl_port(dev);
+
+	if ((attr == &bin_attr_cdat) && port->cdat.table)
+		return 0400;
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
2.35.1

