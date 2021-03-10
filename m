Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35FE334649
	for <lists+linux-pci@lfdr.de>; Wed, 10 Mar 2021 19:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbhCJSJA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 13:09:00 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2680 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhCJSId (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Mar 2021 13:08:33 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dwg1z1wN4z67nSb;
        Thu, 11 Mar 2021 02:04:07 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Mar 2021 19:08:31 +0100
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Wed, 10 Mar 2021 18:08:30 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Chris Browy <cbrowy@avery-design.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-acpi@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 2/2] cxl/mem: Add CDAT table reading from DOE
Date:   Thu, 11 Mar 2021 02:03:06 +0800
Message-ID: <20210310180306.1588376-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210310180306.1588376-1-Jonathan.Cameron@huawei.com>
References: <20210310180306.1588376-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch simply provides some debug print outs of the entries
at probe time + a sysfs binary attribute to allow dumping of the
whole table.

Binary dumping is modelled on /sys/firmware/ACPI/tables/

The ability to dump this table will be very useful for emulation of
real devices once they become available as QEMU CXL type 3 device
emulation will be able to load this file in.

Open questions:
* No support here for table updates. Worth including these from the
  start, or leave that complexity for later?
* Worth logging the reported info for debug, or is the binary attribute
  sufficient?  Larger open question of whether to expose this info to
  userspace or not left for another day!
* Where to put the CDAT file?  Is it worth a subdirectory?
* What is maximum size of the SSLBIS entry - I haven't quite managed
  to figure that out and this is the record with largest size.
  We could support dynamic allocation of the record size, but it
  would add complexity that seems unnecessary.
  It would not be compliant with the specification for a type 3 memory
  device to report this record anyway so I'm not that worried about this
  for now.  It will become relevant once we have support for reading
  CDAT from CXL switches.
* cdat.h is formatted in a similar style to pci_regs.h on basis that
  it may well be helpful to share this header with userspace tools.
* Move the generic parts of this out to driver/cxl/cdat.c or leave that
  until we have other CXL drivers wishing to use this?

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/cdat.h |  79 ++++++++++++++
 drivers/cxl/cxl.h  |  13 +++
 drivers/cxl/mem.c  | 253 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 344 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
new file mode 100644
index 000000000000..e67b18e02c35
--- /dev/null
+++ b/drivers/cxl/cdat.h
@@ -0,0 +1,79 @@
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
+
+/*
+ * CDAT entries are little endian and are read from PCI config space which
+ * is also little endian.
+ * As such, on a big endian system these will have been reversed.
+ * This prevents us from making easy use of packed structures.
+ * Style form pci_regs.h
+ */
+
+#define CDAT_HEADER_LENGTH_DW 3
+#define CDAT_HEADER_DW0_LENGTH		0xFFFFFFFF
+#define CDAT_HEADER_DW1_REVISION	0x000000FF
+#define CDAT_HEADER_DW1_CHECKSUM	0x0000FF00
+#define CDAT_HEADER_DW2_SEQUENCE	0xFFFFFFFF
+
+/* All structures have a common first DW */
+#define CDAT_STRUCTURE_DW0_TYPE		0x000000FF
+#define   CDAT_STRUCTURE_DW0_TYPE_DSMAS 0
+#define   CDAT_STRUCTURE_DW0_TYPE_DSLBIS 1
+#define   CDAT_STRUCTURE_DW0_TYPE_DSMSCIS 2
+#define   CDAT_STRUCTURE_DW0_TYPE_DSIS 3
+#define   CDAT_STRUCTURE_DW0_TYPE_DSEMTS 4
+#define   CDAT_STRUCTURE_DW0_TYPE_SSLBIS 5
+
+#define CDAT_STRUCTURE_DW0_LENGTH	0xFFFF0000
+
+/* Device Scoped Memory Affinity Structure */
+#define CDAT_DSMAS_DW1_DSMAD_HANDLE	0x000000ff
+#define CDAT_DSMAS_DW1_FLAGS		0x0000ff00
+#define CDAT_DSMAS_DPA_OFFSET(entry) ((u64)((entry)[3]) << 32 | (entry)[2])
+#define CDAT_DSMAS_DPA_LEN(entry) ((u64)((entry)[5]) << 32 | (entry)[4])
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
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6f14838c2d25..2f5a69201fc3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -7,6 +7,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
+#include <linux/pcie-doe.h>
 
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
@@ -57,10 +58,21 @@
 	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
 	 CXLMDEV_RESET_NEEDED_NOT)
 
+#define CXL_DOE_PROTOCOL_COMPLIANCE 0
+#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
+
+/* Common to request and response */
+#define CXL_DOE_TABLE_ACCESS_3_CODE GENMASK(7, 0)
+#define   CXL_DOE_TABLE_ACCESS_3_CODE_READ 0
+#define CXL_DOE_TABLE_ACCESS_3_TYPE GENMASK(15, 8)
+#define   CXL_DOE_TABLE_ACCESS_3_TYPE_CDAT 0
+#define CXL_DOE_TABLE_ACCESS_3_ENTRY_HANDLE GENMASK(31, 16)
+
 struct cxl_memdev;
 /**
  * struct cxl_mem - A CXL memory device
  * @pdev: The PCI device associated with this CXL device.
+ * @doe: Data exchange object mailbox used to read tables.
  * @regs: IO mappings to the device's MMIO
  * @status_regs: CXL 2.0 8.2.8.3 Device Status Registers
  * @mbox_regs: CXL 2.0 8.2.8.4 Mailbox Registers
@@ -75,6 +87,7 @@ struct cxl_memdev;
  */
 struct cxl_mem {
 	struct pci_dev *pdev;
+	struct pcie_doe doe;
 	void __iomem *regs;
 	struct cxl_memdev *cxlmd;
 
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 4597b28aeb3f..71de66bc6c54 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -12,6 +12,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include "pci.h"
 #include "cxl.h"
+#include "cdat.h"
 
 /**
  * DOC: cxl mem
@@ -91,6 +92,11 @@ struct mbox_cmd {
 #define CXL_MBOX_SUCCESS 0
 };
 
+struct doe_table_attr {
+	struct bin_attribute attr;
+	void *table;
+};
+
 /**
  * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
  * @dev: driver core device object
@@ -98,6 +104,7 @@ struct mbox_cmd {
  * @cxlm: pointer to the parent device driver data
  * @ops_active: active user of @cxlm in ops handlers
  * @ops_dead: completion when all @cxlm ops users have exited
+ * @table_attr: attribute used to provide dumping of table
  * @id: id number of this memdev instance.
  */
 struct cxl_memdev {
@@ -106,6 +113,7 @@ struct cxl_memdev {
 	struct cxl_mem *cxlm;
 	struct percpu_ref ops_active;
 	struct completion ops_dead;
+	struct doe_table_attr table_attr;
 	int id;
 };
 
@@ -976,13 +984,165 @@ static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
 	return 0;
 }
 
+#define CDAT_DOE_REQ(entry_handle)					\
+	[0] = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID,		\
+			 PCI_DVSEC_VENDOR_ID_CXL) |			\
+	      FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE,		\
+			   CXL_DOE_PROTOCOL_TABLE_ACCESS),		\
+	[1] = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, 3),	\
+	[2] = FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
+			 CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
+	      FIELD_PREP(CXL_DOE_TABLE_ACCESS_TABLE_TYPE,		\
+			 CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |	\
+	      FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle))
+
+static ssize_t cdat_get_length(struct pcie_doe *doe)
+{
+	u32 cdat_request[3] = {
+		CDAT_DOE_REQ(0),
+	};
+	u32 cdat_response[32];
+	ssize_t rc;
+
+	rc = pcie_doe_exchange(doe, cdat_request, sizeof(cdat_request),
+			       cdat_response, sizeof(cdat_response));
+	if (rc)
+		return rc;
+
+	return cdat_response[3];
+}
+
+static int cdat_to_buffer(struct pcie_doe *doe, u32 *buffer, size_t length)
+{
+	int entry_handle = 0;
+	int rc;
+
+	do {
+		u32 cdat_request[3] = {
+			CDAT_DOE_REQ(entry_handle)
+		};
+		u32 cdat_response[32];
+		size_t entry_dw;
+		u32 *entry;
+
+		rc = pcie_doe_exchange(doe, cdat_request, sizeof(cdat_request),
+				       cdat_response, sizeof(cdat_response));
+		if (rc)
+			return rc;
+
+		entry = cdat_response + CDAT_HEADER_LENGTH_DW;
+
+		entry_dw = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, cdat_response[1]);
+		/* Skip Header */
+		entry_dw -= 3;
+		entry_dw = min(length / 4, entry_dw);
+		memcpy(buffer, entry, entry_dw * sizeof(u32));
+		length -= entry_dw * sizeof(u32);
+		buffer += entry_dw;
+		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, cdat_response[2]);
+	} while (entry_handle != 0xFFFF);
+
+	return 0;
+}
+
+static int cdat_dump(struct pcie_doe *doe)
+{
+	struct pci_dev *dev = doe->pdev;
+	int entry_handle = 0;
+	int rc;
+
+	do {
+		/* Table access is available */
+		u32 cdat_request[3] = {
+			CDAT_DOE_REQ(entry_handle)
+		};
+		u32 cdat_response[32];
+		u32 *entry;
+
+		rc = pcie_doe_exchange(doe, cdat_request, sizeof(cdat_request),
+				       cdat_response, sizeof(cdat_response));
+		if (rc)
+			return rc;
+
+		entry = cdat_response + CDAT_HEADER_LENGTH_DW;
+		if (entry_handle == 0) {
+			pci_info(dev,
+				 "CDAT Header (Length=%u, Revision=%u, Checksum=0x%x, Sequence=%u\n",
+				 entry[0],
+				 FIELD_GET(CDAT_HEADER_DW1_REVISION, entry[1]),
+				 FIELD_GET(CDAT_HEADER_DW1_CHECKSUM, entry[1]),
+				 entry[2]);
+		} else {
+			u8 entry_type = FIELD_GET(CDAT_STRUCTURE_DW0_TYPE, entry[0]);
+
+			switch (entry_type) {
+			case CDAT_STRUCTURE_DW0_TYPE_DSMAS:
+				pci_info(dev,
+					 "CDAT DSMAS (handle=%u flags=0x%x, dpa(0x%llx 0x%llx)\n",
+					 FIELD_GET(CDAT_DSMAS_DW1_DSMAD_HANDLE, entry[1]),
+					 FIELD_GET(CDAT_DSMAS_DW1_FLAGS, entry[1]),
+					 CDAT_DSMAS_DPA_OFFSET(entry),
+					 CDAT_DSMAS_DPA_LEN(entry));
+				break;
+			case CDAT_STRUCTURE_DW0_TYPE_DSLBIS:
+				pci_info(dev,
+					 "CDAT DSLBIS (handle=%u flags=0x%x, ent_base=0x%llx, entry[%u %u %u])\n",
+					 FIELD_GET(CDAT_DSLBIS_DW1_HANDLE, entry[1]),
+					 FIELD_GET(CDAT_DSLBIS_DW1_FLAGS, entry[1]),
+					 CDAT_DSLBIS_BASE_UNIT(entry),
+					 FIELD_GET(CDAT_DSLBIS_DW4_ENTRY_0, entry[4]),
+					 FIELD_GET(CDAT_DSLBIS_DW4_ENTRY_1, entry[4]),
+					 FIELD_GET(CDAT_DSLBIS_DW5_ENTRY_2, entry[5]));
+				break;
+			case CDAT_STRUCTURE_DW0_TYPE_DSMSCIS:
+				pci_info(dev,
+					 "CDAT DSMSCIS (handle=%u sc_size=0x%llx attrs=0x%x)\n",
+					 FIELD_GET(CDAT_DSMSCIS_DW1_HANDLE, entry[1]),
+					 CDAT_DSMSCIS_MEMORY_SIDE_CACHE_SIZE(entry),
+					 FIELD_GET(CDAT_DSMSCIS_DW4_MEMORY_SIDE_CACHE_ATTRS,
+						   entry[4]));
+				break;
+			case CDAT_STRUCTURE_DW0_TYPE_DSIS:
+				pci_info(dev,
+					 "CDAT DSIS (handle=%u flags=0x%x)\n",
+					 FIELD_GET(CDAT_DSIS_DW1_HANDLE, entry[1]),
+					 FIELD_GET(CDAT_DSIS_DW1_FLAGS, entry[1]));
+				break;
+			case CDAT_STRUCTURE_DW0_TYPE_DSEMTS:
+				pci_info(dev,
+					 "CDAT DSEMTS (handle=%u EFI=0x%x dpa(0x%llx 0x%llx)\n",
+					 FIELD_GET(CDAT_DSEMTS_DW1_HANDLE, entry[1]),
+					 FIELD_GET(CDAT_DSEMTS_DW1_EFI_MEMORY_TYPE_ATTR,
+						   entry[1]),
+					 CDAT_DSEMTS_DPA_OFFSET(entry),
+					 CDAT_DSEMTS_DPA_LENGTH(entry));
+				break;
+			case CDAT_STRUCTURE_DW0_TYPE_SSLBIS:
+				pci_info(dev,
+					 "CDAT SSLBIS (type%u ent_base=%llu...)\n",
+					 FIELD_GET(CDAT_SSLBIS_DW1_DATA_TYPE,
+						   entry[1]),
+					 CDAT_SSLBIS_BASE_UNIT(entry));
+				break;
+			}
+		}
+		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
+					 cdat_response[2]);
+	} while (entry_handle != 0xFFFF);
+
+	return 0;
+}
+
 static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
 				      u32 reg_hi)
 {
 	struct device *dev = &pdev->dev;
 	struct cxl_mem *cxlm;
 	void __iomem *regs;
+	bool doe_use_irq;
+	int pos = 0;
 	u64 offset;
+	int irqs;
 	u8 bar;
 	int rc;
 
@@ -1021,6 +1181,44 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
 		return NULL;
 	}
 
+	/*
+	 * An implementation of a cxl type3 device may support an unknown
+	 * number of interrupts. Assume that number is not that large and
+	 * request them all.
+	 */
+	irqs = pci_msix_vec_count(pdev);
+	rc = pci_alloc_irq_vectors(pdev, irqs, irqs, PCI_IRQ_MSIX);
+	if (rc != irqs) {
+		/* No interrupt available - carry on */
+		dev_dbg(dev, "No interrupts available for DOE\n");
+		doe_use_irq = false;
+	} else {
+		/*
+		 * Enabling bus mastering could be done within the DOE
+		 * initialization, but as it potentially has other impacts
+		 * keep it within the driver.
+		 */
+		pci_set_master(pdev);
+		doe_use_irq = true;
+	}
+
+	/*
+	 * Find a DOE mailbox that supports CDAT.
+	 * Supporting other DOE protocols will require more complexity.
+	 */
+	do {
+		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DOE);
+		if (!pos)
+			return NULL;
+
+		pcie_doe_init(&cxlm->doe, pdev, pos, doe_use_irq);
+	} while (pcie_doe_protocol_check(&cxlm->doe, PCI_DVSEC_VENDOR_ID_CXL,
+					 CXL_DOE_PROTOCOL_TABLE_ACCESS));
+
+	rc = cdat_dump(&cxlm->doe);
+	if (rc)
+		return NULL;
+
 	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
 	return cxlm;
 }
@@ -1178,6 +1376,55 @@ static void cxlmdev_ops_active_release(struct percpu_ref *ref)
 	complete(&cxlmd->ops_dead);
 }
 
+static ssize_t cdat_table_show(struct file *filp, struct kobject *kobj,
+			       struct bin_attribute *bin_attr, char *buf,
+			       loff_t offset, size_t count)
+{
+	struct doe_table_attr *table_attr =
+		container_of(bin_attr, struct doe_table_attr, attr);
+
+	return memory_read_from_buffer(buf, count, &offset, table_attr->table,
+				       bin_attr->size);
+}
+
+static void cxl_remove_table_sysfs(void *_cxlmd)
+{
+	struct cxl_memdev *cxlmd = _cxlmd;
+	struct device *dev = &cxlmd->dev;
+
+	sysfs_remove_bin_file(&dev->kobj, &cxlmd->table_attr.attr);
+}
+
+static int cxl_add_table_sysfs(struct cxl_memdev *cxlmd)
+{
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+	struct device *dev = &cxlmd->dev;
+	ssize_t cdat_length;
+	int rc;
+
+	cdat_length = cdat_get_length(&cxlm->doe);
+	if (cdat_length < 0)
+		return cdat_length;
+
+	sysfs_attr_init(&cxlmd->table_attr.attr.attr);
+	/* Updates of CDAT are not yet handled so length is fixed. */
+	cxlmd->table_attr.attr.size = cdat_length;
+	cxlmd->table_attr.attr.read = cdat_table_show;
+	cxlmd->table_attr.attr.attr.name = "CDAT";
+	cxlmd->table_attr.attr.attr.mode = 0400;
+	cxlmd->table_attr.table = devm_kzalloc(dev->parent, cdat_length, GFP_KERNEL);
+
+	rc = cdat_to_buffer(&cxlm->doe, cxlmd->table_attr.table, cdat_length);
+	if (rc)
+		return rc;
+
+	rc = sysfs_create_bin_file(&dev->kobj, &cxlmd->table_attr.attr);
+	if (rc)
+		return rc;
+
+	return devm_add_action_or_reset(dev->parent, cxl_remove_table_sysfs, cxlmd);
+}
+
 static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 {
 	struct pci_dev *pdev = cxlm->pdev;
@@ -1221,7 +1468,11 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 	if (rc)
 		goto err_add;
 
-	return devm_add_action_or_reset(dev->parent, cxlmdev_unregister, cxlmd);
+	rc = devm_add_action_or_reset(dev->parent, cxlmdev_unregister, cxlmd);
+	if (rc)
+		return rc;
+
+	return cxl_add_table_sysfs(cxlmd);
 
 err_add:
 	ida_free(&cxl_memdev_ida, cxlmd->id);
-- 
2.19.1

