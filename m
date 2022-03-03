Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5974CBF66
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 15:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbiCCODU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 09:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbiCCODT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 09:03:19 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CE7320;
        Thu,  3 Mar 2022 06:02:31 -0800 (PST)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K8Xjk4yNqz67XhV;
        Thu,  3 Mar 2022 22:02:18 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 15:02:29 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 14:02:28 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Chris Browy <cbrowy@avery-design.com>,
        <keyrings@vger.kernel.org>, "Bjorn Helgaas" <bjorn@helgaas.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        <dan.j.williams@intel.com>
Subject: [RFC PATCH v2 07/14] cxl/mem: Read CDAT table
Date:   Thu, 3 Mar 2022 13:58:58 +0000
Message-ID: <20220303135905.10420-8-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220303135905.10420-1-Jonathan.Cameron@huawei.com>
References: <20220303135905.10420-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The OS will need CDAT data from the CXL devices to properly set up
interleave sets.

Search the DOE driver/devices attached to the CXL device for one which
supports the CDAT protocol.  If found, read the CDAT data from that
mailbox.

Currently this is only supported by a PCI CXL object through a DOE
mailbox which supports CDAT.  But any cxl_mem type object can provide
this data later if need be.  For example for testing.

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
 drivers/cxl/cdat.h        | 97 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/memdev.c | 56 ++++++++++++++++++++++
 drivers/cxl/cxlmem.h      | 25 ++++++++++
 drivers/cxl/pci.c         | 87 +++++++++++++++++++++++++++++++++++
 4 files changed, 265 insertions(+)

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
index 61029cb7ac62..82e84fac2eca 100644
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
+	if (!cxlmd->cdat.table)
+		return 0;
+
+	return memory_read_from_buffer(buf, count, &offset,
+				       cxlmd->cdat.table,
+				       cxlmd->cdat.length);
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
+	if ((attr == &bin_attr_CDAT) && cxlmd->cdat.table)
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
@@ -276,6 +312,21 @@ static const struct file_operations cxl_memdev_fops = {
 	.llseek = noop_llseek,
 };
 
+static int read_cdat_data(struct cxl_memdev *cxlmd, struct cxl_dev_state *cxlds)
+{
+	struct device *dev = &cxlmd->dev;
+	size_t cdat_length;
+
+	if (cxl_mem_cdat_get_length(cxlds, &cdat_length))
+		return 0;
+
+	cxlmd->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
+	if (!cxlmd->cdat.table)
+		return -ENOMEM;
+	cxlmd->cdat.length = cdat_length;
+	return cxl_mem_cdat_read_table(cxlds, &cxlmd->cdat);
+}
+
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 {
 	struct cxl_memdev *cxlmd;
@@ -292,6 +343,11 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 	if (rc)
 		goto err;
 
+	/* Cache the data early to ensure is_visible() works */
+	rc = read_cdat_data(cxlmd, cxlds);
+	if (rc)
+		goto err;
+
 	/*
 	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
 	 * needed as this is ordered with cdev_add() publishing the device.
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 176228d8c66d..b4209170f4ac 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -5,6 +5,7 @@
 #include <uapi/linux/cxl_mem.h>
 #include <linux/cdev.h>
 #include "cxl.h"
+#include "cdat.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
 #define CXLMDEV_STATUS_OFFSET 0x0
@@ -40,6 +41,7 @@ struct cxl_memdev {
 	struct device dev;
 	struct cdev cdev;
 	struct cxl_dev_state *cxlds;
+	struct cxl_cdat cdat;
 	int id;
 };
 
@@ -118,6 +120,10 @@ struct cxl_mbox_cmd {
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
@@ -148,6 +154,9 @@ struct cxl_dev_state {
 	u64 next_persistent_bytes;
 
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
+	int (*cdat_get_length)(struct cxl_dev_state *cxlds, size_t *length);
+	int (*cdat_read_table)(struct cxl_dev_state *cxlds,
+			       struct cxl_cdat *cdat);
 };
 
 enum cxl_opcode {
@@ -266,4 +275,20 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
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
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index adcabc0bcb38..ebd98a8a310f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -11,6 +11,7 @@
 #include "cxlmem.h"
 #include "pci.h"
 #include "cxl.h"
+#include "cdat.h"
 
 /**
  * DOC: cxl pci
@@ -521,6 +522,90 @@ static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
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
+	return 0;
+}
+
+static int cxl_cdat_read_table(struct cxl_dev_state *cxlds,
+			       struct cxl_cdat *cdat)
+{
+	struct pci_doe_dev *doe_dev = cxlds->cdat_doe;
+	size_t length = cdat->length;
+	u32 *data = cdat->table;
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
+static void cxl_initialize_cdat_callbacks(struct cxl_dev_state *cxlds)
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
@@ -551,6 +636,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	cxl_initialize_cdat_callbacks(cxlds);
+
 	rc = cxl_map_regs(cxlds, &map);
 	if (rc)
 		return rc;
-- 
2.32.0

