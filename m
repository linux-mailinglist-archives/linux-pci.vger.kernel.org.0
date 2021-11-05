Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403D8446B5D
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 00:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhKEXxk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Nov 2021 19:53:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:30588 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232852AbhKEXxk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Nov 2021 19:53:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10159"; a="230724057"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="230724057"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 16:50:59 -0700
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="639954977"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 16:50:59 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 4/5] cxl/mem: Add CDAT table reading from DOE
Date:   Fri,  5 Nov 2021 16:50:55 -0700
Message-Id: <20211105235056.3711389-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20211105235056.3711389-1-ira.weiny@intel.com>
References: <20211105235056.3711389-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Read CDAT raw table data from the cxl_mem state object.  Currently this
is only supported by a PCI CXL object through a DOE mailbox which supports
CDAT.  But any cxl_mem type object can provide this data later if need
be.  For example for testing.

Cache this data for later parsing.  Provide a sysfs binary attribute to
allow dumping of the CDAT.

Binary dumping is modeled on /sys/firmware/ACPI/tables/

The ability to dump this table will be very useful for emulation of real
devices once they become available as QEMU CXL type 3 device emulation will
be able to load this file in.

This does not support table updates at runtime. It will always provide
whatever was there when first cached. Handling of table updates can be
implemented later.

Once there are more users, this code can move out to driver/cxl/cdat.c
or similar.

Finally create a complete list of DOE defines within cdat.h for anyone
wishing to decode the CDAT table.

Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Changes from V4:
	Split this into it's own patch
	Rearchitect this such that the memdev driver calls into the DOE
	driver via the cxl_mem state object.  This allows CDAT data to
	come from any type of cxl_mem object not just PCI DOE.
	Rebase on new struct cxl_dev_state
---
 drivers/cxl/cdat.h        | 81 +++++++++++++++++++++++++++++++++
 drivers/cxl/core/memdev.c | 46 +++++++++++++++++++
 drivers/cxl/cxl.h         |  7 +++
 drivers/cxl/cxlmem.h      | 25 +++++++++++
 drivers/cxl/pci.c         | 94 ++++++++++++++++++++++++++++++++++++++-
 5 files changed, 252 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cxl/cdat.h

diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
new file mode 100644
index 000000000000..ee78eb822166
--- /dev/null
+++ b/drivers/cxl/cdat.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 5341b0ba99a7..c35de9e8298e 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -86,6 +86,35 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 	return sysfs_emit(buf, "%#llx\n", len);
 }
 
+static ssize_t CDAT_read(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *bin_attr, char *buf,
+			 loff_t offset, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+
+	if (!cxlmd->cdat_table)
+		return 0;
+
+	return memory_read_from_buffer(buf, count, &offset,
+				       cxlmd->cdat_table,
+				       cxlmd->cdat_length);
+}
+
+static BIN_ATTR_RO(CDAT, 0);
+
+static umode_t cxl_memdev_bin_attr_is_visible(struct kobject *kobj,
+					      struct bin_attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+
+	if ((attr == &bin_attr_CDAT) && cxlmd->cdat_table)
+		return 0400;
+
+	return 0;
+}
+
 static struct device_attribute dev_attr_pmem_size =
 	__ATTR(size, 0444, pmem_size_show, NULL);
 
@@ -96,6 +125,11 @@ static struct attribute *cxl_memdev_attributes[] = {
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
@@ -108,6 +142,8 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
 
 static struct attribute_group cxl_memdev_attribute_group = {
 	.attrs = cxl_memdev_attributes,
+	.bin_attrs = cxl_memdev_bin_attributes,
+	.is_bin_visible = cxl_memdev_bin_attr_is_visible,
 };
 
 static struct attribute_group cxl_memdev_ram_attribute_group = {
@@ -293,6 +329,16 @@ devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 	if (rc)
 		goto err;
 
+	/* Cache the data early to ensure is_visible() works */
+	if (!cxl_mem_cdat_get_length(cxlds, &cxlmd->cdat_length)) {
+		cxlmd->cdat_table = devm_kzalloc(dev, cxlmd->cdat_length, GFP_KERNEL);
+		if (!cxlmd->cdat_table) {
+			rc = -ENOMEM;
+			goto err;
+		}
+		cxl_mem_cdat_read_table(cxlds, cxlmd->cdat_table, cxlmd->cdat_length);
+	}
+
 	/*
 	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
 	 * needed as this is ordered with cdev_add() publishing the device.
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f1241a7f2b7b..f5dd38c6ce0f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -88,6 +88,13 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 #define CXL_DOE_PROTOCOL_COMPLIANCE 0
 #define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
 
+/* Common to request and response */
+#define CXL_DOE_TABLE_ACCESS_3_CODE GENMASK(7, 0)
+#define   CXL_DOE_TABLE_ACCESS_3_CODE_READ 0
+#define CXL_DOE_TABLE_ACCESS_3_TYPE GENMASK(15, 8)
+#define   CXL_DOE_TABLE_ACCESS_3_TYPE_CDAT 0
+#define CXL_DOE_TABLE_ACCESS_3_ENTRY_HANDLE GENMASK(31, 16)
+
 #define CXL_COMPONENT_REGS() \
 	void __iomem *hdm_decoder
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8d96d009ad90..f6c62cd537bb 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -34,12 +34,16 @@
  * @dev: driver core device object
  * @cdev: char dev core object for ioctl operations
  * @cxlds: The device state backing this device
+ * @cdat_table: cache of CDAT table
+ * @cdat_length: length of cached CDAT table
  * @id: id number of this memdev instance.
  */
 struct cxl_memdev {
 	struct device dev;
 	struct cdev cdev;
 	struct cxl_dev_state *cxlds;
+	void *cdat_table;
+	size_t cdat_length;
 	int id;
 };
 
@@ -97,6 +101,7 @@ struct cxl_mbox_cmd {
  * Currently only memory devices are represented.
  *
  * @dev: The device associated with this CXL state
+ * @cdat_doe: Auxiliary DOE device capabile of reading CDAT
  * @regs: Parsed register blocks
  * @payload_size: Size of space for payload
  *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
@@ -117,6 +122,10 @@ struct cxl_mbox_cmd {
  * @next_volatile_bytes: volatile capacity change pending device reset
  * @next_persistent_bytes: persistent capacity change pending device reset
  * @mbox_send: @dev specific transport for transmitting mailbox commands
+ * @cdat_get_length: @dev specific function for reading the CDAT table length
+ *                   returns -errno if CDAT not supported on this device
+ * @cdat_read_table: @dev specific function for reading the table
+ *                   returns -errno if CDAT not supported on this device
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
  * details on capacity parameters.
@@ -124,6 +133,7 @@ struct cxl_mbox_cmd {
 struct cxl_dev_state {
 	struct device *dev;
 
+	struct pci_doe_dev *cdat_doe;
 	struct cxl_regs regs;
 
 	size_t payload_size;
@@ -146,6 +156,8 @@ struct cxl_dev_state {
 	u64 next_persistent_bytes;
 
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
+	int (*cdat_get_length)(struct cxl_dev_state *cxlds, size_t *length);
+	int (*cdat_read_table)(struct cxl_dev_state *cxlds, u32 *data, size_t length);
 };
 
 enum cxl_opcode {
@@ -264,4 +276,17 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
 struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
 void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
+
+static inline int cxl_mem_cdat_get_length(struct cxl_dev_state *cxlds, size_t *length)
+{
+	if (cxlds->cdat_get_length)
+		return cxlds->cdat_get_length(cxlds, length);
+	return -EOPNOTSUPP;
+}
+static inline int cxl_mem_cdat_read_table(struct cxl_dev_state *cxlds, u32 *data, size_t length)
+{
+	if (cxlds->cdat_read_table)
+		return cxlds->cdat_read_table(cxlds, data, length);
+	return -EOPNOTSUPP;
+}
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index df524b74f1d2..086532a42480 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -11,6 +11,7 @@
 #include "cxlmem.h"
 #include "pci.h"
 #include "cxl.h"
+#include "cdat.h"
 
 /**
  * DOC: cxl pci
@@ -575,17 +576,106 @@ static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
 		if (rc)
 			return rc;
 
-		if (device_attach(&adev->dev) != 1)
+		if (device_attach(&adev->dev) != 1) {
 			dev_err(&adev->dev,
 				"Failed to attach a driver to DOE device %d\n",
 				adev->id);
+			goto next;
+		}
+
+		if (pci_doe_supports_prot(new_dev, PCI_DVSEC_VENDOR_ID_CXL,
+					  CXL_DOE_PROTOCOL_TABLE_ACCESS))
+			cxlds->cdat_doe = new_dev;
 
+next:
 		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DOE);
 	}
 
 	return 0;
 }
 
+#define CDAT_DOE_REQ(entry_handle)					\
+	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
+		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
+	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_TABLE_TYPE,			\
+		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
+	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
+
+static int cxl_cdat_get_length(struct cxl_dev_state *cxlds, size_t *length)
+{
+	struct pci_doe_dev *doe_dev = cxlds->cdat_doe;
+	u32 cdat_request_pl = CDAT_DOE_REQ(0);
+	u32 cdat_response_pl[32];
+	struct pci_doe_exchange ex = {
+		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,
+		.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,
+		.request_pl = &cdat_request_pl,
+		.request_pl_sz = sizeof(cdat_request_pl),
+		.response_pl = cdat_response_pl,
+		.response_pl_sz = sizeof(cdat_response_pl),
+	};
+
+	ssize_t rc;
+
+	rc = pci_doe_exchange_sync(doe_dev, &ex);
+	if (rc < 0)
+		return rc;
+	if (rc < 1)
+		return -EIO;
+
+	*length = cdat_response_pl[1];
+	dev_dbg(cxlds->dev, "CDAT length %zu\n", *length);
+	return 0;
+}
+
+static int cxl_cdat_read_table(struct cxl_dev_state *cxlds, u32 *data, size_t length)
+{
+	struct pci_doe_dev *doe_dev = cxlds->cdat_doe;
+	int entry_handle = 0;
+	int rc;
+
+	do {
+		u32 cdat_request_pl = CDAT_DOE_REQ(entry_handle);
+		u32 cdat_response_pl[32];
+		struct pci_doe_exchange ex = {
+			.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,
+			.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,
+			.request_pl = &cdat_request_pl,
+			.request_pl_sz = sizeof(cdat_request_pl),
+			.response_pl = cdat_response_pl,
+			.response_pl_sz = sizeof(cdat_response_pl),
+		};
+		size_t entry_dw;
+		u32 *entry;
+
+		rc = pci_doe_exchange_sync(doe_dev, &ex);
+		if (rc < 0)
+			return rc;
+
+		entry = cdat_response_pl + 1;
+		entry_dw = rc / sizeof(u32);
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
+	return 0;
+}
+
+static void cxl_setup_cdat(struct cxl_dev_state *cxlds)
+{
+	if (!cxlds->cdat_doe)
+		return;
+
+	cxlds->cdat_get_length = cxl_cdat_get_length;
+	cxlds->cdat_read_table = cxl_cdat_read_table;
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -636,6 +726,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	cxl_setup_cdat(cxlds);
+
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
-- 
2.28.0.rc0.12.gb6a658bd00c9

