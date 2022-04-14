Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E501F501CCC
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 22:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346422AbiDNUfT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 16:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346383AbiDNUfS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 16:35:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F6DAFAD5;
        Thu, 14 Apr 2022 13:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649968369; x=1681504369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2A/nDk54DNLU4Xv/kYeSwcUSn5YoQAcC9glwKkY81MU=;
  b=de3Tzjw+t6kLNC9UQPNYit7TAiulkngwQAGkGDLiPBzVFimcZBak2FFQ
   RbvAySYxcvEMWW2LoRBJ33MDCCvKlC7MMKTU863dFlWwgyXjs8yENIB42
   4IJAiFtBo96A/xDGIpI8RL74XcicSNLctDPQjIAGC83MuwUdJBOPdLQJQ
   YLahw3lAeIFtw0cdxEpCDwGX+3Xf2E7IZPg5pyZy1xgtYG6iNs2fbFZiJ
   ZSZYUKvL0iuaaabKr17rEN9IWlZh752hgMiUtPvc7J9KlBA9Sr4jnuA1+
   eJp/JyC7SBK+bqACJ7dXmPBKPJCZNGQ25DnI+B6Y52mpgoCCZO+L4GfP2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="250323645"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="250323645"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 13:32:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="591319565"
Received: from aimeehax-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.113.132])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 13:32:48 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V8 07/10] cxl/mem: Read CDAT table
Date:   Thu, 14 Apr 2022 13:32:34 -0700
Message-Id: <20220414203237.2198665-8-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414203237.2198665-1-ira.weiny@intel.com>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The OS will need CDAT data from CXL devices to properly set up
interleave sets.  Currently this is supported by a through a DOE mailbox
which supports CDAT.  But any cxl_mem object can provide this data later
if need be, for example for testing.

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
 drivers/cxl/cdat.h        |  97 ++++++++++++++++++++++++
 drivers/cxl/core/memdev.c |  38 ++++++++++
 drivers/cxl/cxlmem.h      |  26 +++++++
 drivers/cxl/cxlpci.h      |   1 +
 drivers/cxl/pci.c         | 153 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 315 insertions(+)
 create mode 100644 drivers/cxl/cdat.h

diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
new file mode 100644
index 000000000000..4722b6bbbaf0
--- /dev/null
+++ b/drivers/cxl/cdat.h
@@ -0,0 +1,97 @@
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
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 1f76b28f9826..9ca5f2f2d308 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -86,6 +86,37 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 	return sysfs_emit(buf, "%#llx\n", len);
 }
 
+static ssize_t CDAT_read(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *bin_attr, char *buf,
+			 loff_t offset, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	if (!cxlds->cdat.table)
+		return 0;
+
+	return memory_read_from_buffer(buf, count, &offset,
+				       cxlds->cdat.table,
+				       cxlds->cdat.length);
+}
+
+static BIN_ATTR_RO(CDAT, 0);
+
+static umode_t cxl_memdev_bin_attr_is_visible(struct kobject *kobj,
+					      struct bin_attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	if ((attr == &bin_attr_CDAT) && cxlds->cdat.table)
+		return 0400;
+
+	return 0;
+}
+
 static struct device_attribute dev_attr_pmem_size =
 	__ATTR(size, 0444, pmem_size_show, NULL);
 
@@ -115,6 +146,11 @@ static struct attribute *cxl_memdev_attributes[] = {
 	NULL,
 };
 
+static struct bin_attribute *cxl_memdev_bin_attributes[] = {
+	&bin_attr_CDAT,
+	NULL,
+};
+
 static struct attribute *cxl_memdev_pmem_attributes[] = {
 	&dev_attr_pmem_size.attr,
 	NULL,
@@ -136,6 +172,8 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
 static struct attribute_group cxl_memdev_attribute_group = {
 	.attrs = cxl_memdev_attributes,
 	.is_visible = cxl_memdev_visible,
+	.bin_attrs = cxl_memdev_bin_attributes,
+	.is_bin_visible = cxl_memdev_bin_attr_is_visible,
 };
 
 static struct attribute_group cxl_memdev_ram_attribute_group = {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 0dc6988afb30..8bf058c8d31f 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -5,6 +5,7 @@
 #include <uapi/linux/cxl_mem.h>
 #include <linux/cdev.h>
 #include "cxl.h"
+#include "cdat.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
 #define CXLMDEV_STATUS_OFFSET 0x0
@@ -169,6 +170,7 @@ struct cxl_endpoint_dvsec_info {
  *
  * @dev: The device associated with this CXL state
  * @cdat_doe: Auxiliary DOE device capabile of reading CDAT
+ * @cdat: Cached CDAT data
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @payload_size: Size of space for payload
@@ -194,6 +196,10 @@ struct cxl_endpoint_dvsec_info {
  * @serial: PCIe Device Serial Number
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  * @wait_media_ready: @dev specific method to await media ready
+ * @cdat_get_length: @dev specific function for reading the CDAT table length
+ *                   returns -errno if CDAT not supported on this device
+ * @cdat_read_table: @dev specific function for reading the table
+ *                   returns -errno if CDAT not supported on this device
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
  * details on capacity parameters.
@@ -202,6 +208,7 @@ struct cxl_dev_state {
 	struct device *dev;
 
 	struct cxl_doe_dev *cdat_doe;
+	struct cxl_cdat cdat;
 	struct cxl_regs regs;
 	int cxl_dvsec;
 
@@ -230,6 +237,9 @@ struct cxl_dev_state {
 
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
 	int (*wait_media_ready)(struct cxl_dev_state *cxlds);
+	int (*cdat_get_length)(struct cxl_dev_state *cxlds, size_t *length);
+	int (*cdat_read_table)(struct cxl_dev_state *cxlds,
+			       struct cxl_cdat *cdat);
 };
 
 enum cxl_opcode {
@@ -374,4 +384,20 @@ struct cxl_hdm {
 	unsigned int interleave_mask;
 	struct cxl_port *port;
 };
+
+static inline int cxl_mem_cdat_get_length(struct cxl_dev_state *cxlds, size_t *length)
+{
+	if (cxlds->cdat_get_length)
+		return cxlds->cdat_get_length(cxlds, length);
+	return -EOPNOTSUPP;
+}
+
+static inline int cxl_mem_cdat_read_table(struct cxl_dev_state *cxlds,
+					  struct cxl_cdat *cdat)
+{
+	if (cxlds->cdat_read_table)
+		return cxlds->cdat_read_table(cxlds, cdat);
+	return -EOPNOTSUPP;
+}
+
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 821fe05e8289..aa8c6ef93000 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -4,6 +4,7 @@
 #define __CXL_PCI_H__
 #include <linux/auxiliary_bus.h>
 #include <linux/pci.h>
+#include <linux/pci-doe.h>
 #include "cxl.h"
 
 #define CXL_MEMORY_PROGIF	0x10
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 622cac925262..aecb327911a0 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -13,6 +13,7 @@
 #include "cxlmem.h"
 #include "cxlpci.h"
 #include "cxl.h"
+#include "cdat.h"
 
 /**
  * DOC: cxl pci
@@ -780,6 +781,151 @@ static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
 	return 0;
 }
 
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
+static int cxl_cdat_get_length(struct cxl_dev_state *cxlds, size_t *length)
+{
+	struct cxl_doe_dev *doe_dev = cxlds->cdat_doe;
+	struct cxl_doe_drv_state *doe_ds;
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
+	doe_ds = cxl_pci_doe_get_drv(doe_dev);
+	if (!doe_ds) {
+		rc = -EIO;
+		goto release_driver;
+	}
+
+	rc = pci_doe_submit_task(doe_ds->doe_mb, &task);
+	if (rc < 0) {
+		dev_err(cxlds->dev, "DOE submit failed: %d", rc);
+		goto release_driver;
+	}
+	wait_for_completion(&c);
+
+	if (task.rv < 1) {
+		rc = -EIO;
+		goto release_driver;
+	}
+
+	*length = cdat_response_pl[1];
+	dev_dbg(cxlds->dev, "CDAT length %lu\n", *length);
+
+release_driver:
+	cxl_pci_doe_put_drv(doe_dev);
+	return rc;
+}
+
+static int cxl_cdat_read_table(struct cxl_dev_state *cxlds,
+			       struct cxl_cdat *cdat)
+{
+	struct cxl_doe_dev *doe_dev = cxlds->cdat_doe;
+	struct cxl_doe_drv_state *doe_ds;
+	size_t length = cdat->length;
+	u32 *data = cdat->table;
+	int entry_handle = 0;
+	int rc = 0;
+
+	doe_ds = cxl_pci_doe_get_drv(doe_dev);
+	if (!doe_ds) {
+		rc = -EIO;
+		goto release_driver;
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
+		rc = pci_doe_submit_task(doe_ds->doe_mb, &task);
+		if (rc < 0) {
+			dev_err(cxlds->dev, "DOE submit failed: %d", rc);
+			goto release_driver;
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
+release_driver:
+	cxl_pci_doe_put_drv(doe_dev);
+	return rc;
+}
+
+static void cxl_initialize_cdat_callbacks(struct cxl_dev_state *cxlds)
+{
+	if (!cxlds->cdat_doe)
+		return;
+
+	cxlds->cdat_get_length = cxl_cdat_get_length;
+	cxlds->cdat_read_table = cxl_cdat_read_table;
+}
+
+static int read_cdat_data(struct cxl_dev_state *cxlds)
+{
+	struct device *dev = cxlds->dev;
+	size_t cdat_length;
+	int ret;
+
+	if (cxl_mem_cdat_get_length(cxlds, &cdat_length))
+		return 0;
+
+	cxlds->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
+	if (!cxlds->cdat.table)
+		return -ENOMEM;
+	cxlds->cdat.length = cdat_length;
+	ret = cxl_mem_cdat_read_table(cxlds, &cxlds->cdat);
+	if (ret) {
+		devm_kfree(dev, cxlds->cdat.table);
+		cxlds->cdat.table = NULL;
+		cxlds->cdat.length = 0;
+	}
+	return ret;
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -850,6 +996,13 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	cxl_initialize_cdat_callbacks(cxlds);
+
+	/* Cache the data early to ensure is_visible() works */
+	rc = read_cdat_data(cxlds);
+	if (rc)
+		dev_err(&pdev->dev, "CDAT data read error (%d)\n", rc);
+
 	cxl_dvsec_ranges(cxlds);
 
 	cxlmd = devm_cxl_add_memdev(cxlds);
-- 
2.35.1

