Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E18B38E7E3
	for <lists+linux-pci@lfdr.de>; Mon, 24 May 2021 15:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhEXNnl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 09:43:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5761 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbhEXNnl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 May 2021 09:43:41 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpdZy4frpzmkcx;
        Mon, 24 May 2021 21:38:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 21:42:08 +0800
Received: from localhost.localdomain (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 14:42:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        <linux-acpi@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, Fangjian <f.fangjian@huawei.com>,
        <linuxarm@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 3/5] cxl/mem: Add CDAT table reading from DOE
Date:   Mon, 24 May 2021 21:39:36 +0800
Message-ID: <20210524133938.2815206-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210524133938.2815206-1-Jonathan.Cameron@huawei.com>
References: <20210524133938.2815206-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch provides a sysfs binary attribute to allow dumping of the whole
table.

Binary dumping is modeled on /sys/firmware/ACPI/tables/

The ability to dump this table will be very useful for emulation of real
devices once they become available as QEMU CXL type 3 device emulation will
be able to load this file in.

This does not support table updates at runtime. It will always provide
whatever was there when first cached. Handling of table updates can be
implemented later.

Once we have more users, this code can move out to driver/cxl/cdat.c or
similar.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/Kconfig |   1 +
 drivers/cxl/cxl.h   |  21 ++++++
 drivers/cxl/mem.c   | 174 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/mem.h   |   6 ++
 4 files changed, 202 insertions(+)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 97dc4d751651..26cad9fa29f7 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -15,6 +15,7 @@ if CXL_BUS
 
 config CXL_MEM
 	tristate "CXL.mem: Memory Devices"
+	select PCI_DOE
 	help
 	  The CXL.mem protocol allows a device to act as a provider of
 	  "System RAM" and/or "Persistent Memory" that is fully coherent
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index d49e0cb679fa..e649a286aace 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -7,6 +7,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
+#include <linux/pci-doe.h>
 
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
@@ -69,5 +70,25 @@ struct cxl_regs {
 void cxl_setup_device_regs(struct device *dev, void __iomem *base,
 			   struct cxl_device_regs *regs);
 
+/*
+ * Address space properties derived from:
+ * CXL 2.0 8.2.5.12.7 CXL HDM Decoder 0 Control Register
+ */
+#define CXL_ADDRSPACE_RAM   BIT(0)
+#define CXL_ADDRSPACE_PMEM  BIT(1)
+#define CXL_ADDRSPACE_TYPE2 BIT(2)
+#define CXL_ADDRSPACE_TYPE3 BIT(3)
+#define CXL_ADDRSPACE_MASK  GENMASK(3, 0)
+
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
 extern struct bus_type cxl_bus_type;
 #endif /* __CXL_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index c5fdf2c57181..4224d1de311e 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -14,6 +14,7 @@
 #include "pci.h"
 #include "cxl.h"
 #include "mem.h"
+#include "cdat.h"
 
 /**
  * DOC: cxl mem
@@ -926,6 +927,85 @@ static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
 	return 0;
 }
 
+#define CDAT_DOE_REQ(entry_handle)					\
+	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
+		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
+	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_TABLE_TYPE,			\
+		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
+	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
+
+static ssize_t cdat_get_length(struct pci_doe *doe)
+{
+	u32 cdat_request_pl = CDAT_DOE_REQ(0);
+	u32 cdat_response_pl[32];
+	struct pci_doe_exchange ex = {
+		.vid = PCI_DVSEC_VENDOR_ID_CXL,
+		.protocol = CXL_DOE_PROTOCOL_TABLE_ACCESS,
+		.request_pl = &cdat_request_pl,
+		.request_pl_sz = sizeof(cdat_request_pl),
+		.response_pl = cdat_response_pl,
+		.response_pl_sz = sizeof(cdat_response_pl),
+	};
+
+	ssize_t rc;
+
+	rc = pci_doe_exchange_sync(doe, &ex);
+	if (rc < 0)
+		return rc;
+	if (rc < 1)
+		return -EIO;
+
+	return cdat_response_pl[1];
+}
+
+static int cdat_to_buffer(struct pci_doe *doe, u32 *buffer, size_t length)
+{
+	int entry_handle = 0;
+	int rc;
+
+	do {
+		u32 cdat_request_pl = CDAT_DOE_REQ(entry_handle);
+		u32 cdat_response_pl[32];
+		struct pci_doe_exchange ex = {
+			.vid = PCI_DVSEC_VENDOR_ID_CXL,
+			.protocol = CXL_DOE_PROTOCOL_TABLE_ACCESS,
+			.request_pl = &cdat_request_pl,
+			.request_pl_sz = sizeof(cdat_request_pl),
+			.response_pl = cdat_response_pl,
+			.response_pl_sz = sizeof(cdat_response_pl),
+		};
+		size_t entry_dw;
+		u32 *entry;
+
+		rc = pci_doe_exchange_sync(doe, &ex);
+		if (rc < 0)
+			return rc;
+
+		entry = cdat_response_pl + 1;
+		entry_dw = rc / sizeof(u32);
+		/* Skip Header */
+		entry_dw -= 1;
+		entry_dw = min(length / 4, entry_dw);
+		memcpy(buffer, entry, entry_dw * sizeof(u32));
+		length -= entry_dw * sizeof(u32);
+		buffer += entry_dw;
+		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, cdat_response_pl[0]);
+
+	} while (entry_handle != 0xFFFF);
+
+	return 0;
+}
+
+static void cxl_mem_free_irq_vectors(void *data)
+{
+	pci_free_irq_vectors(data);
+}
+
+static void cxl_mem_doe_unregister_all(void *data)
+{
+	pci_doe_unregister_all(data);
+}
+
 static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
 				      u32 reg_hi)
 {
@@ -933,6 +1013,7 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
 	struct cxl_mem *cxlm;
 	void __iomem *regs;
 	u64 offset;
+	int irqs;
 	u8 bar;
 	int rc;
 
@@ -971,6 +1052,44 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
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
+	} else {
+		/*
+		 * Enabling bus mastering could be done within the DOE
+		 * initialization, but as it potentially has other impacts
+		 * keep it within the driver.
+		 */
+		pci_set_master(pdev);
+		rc = devm_add_action_or_reset(dev, cxl_mem_free_irq_vectors,
+					       pdev);
+		if (rc)
+			return NULL;
+	}
+
+	/*
+	 * Find a DOE mailbox that supports CDAT.
+	 * Supporting other DOE protocols will require more complexity.
+	 */
+	rc = pci_doe_register_all(pdev);
+	if (rc < 0)
+		return NULL;
+
+	rc = devm_add_action_or_reset(dev, cxl_mem_doe_unregister_all, pdev);
+	if (rc)
+		return NULL;
+
+	cxlm->table_doe = pci_doe_find(pdev, PCI_DVSEC_VENDOR_ID_CXL,
+				       CXL_DOE_PROTOCOL_TABLE_ACCESS);
+
 	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
 	return cxlm;
 }
@@ -1060,6 +1179,31 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 	return sysfs_emit(buf, "%#llx\n", len);
 }
 
+static ssize_t CDAT_read(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *bin_attr, char *buf,
+			 loff_t offset, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+
+	return memory_read_from_buffer(buf, count, &offset, cxlmd->cdat_table,
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
 
@@ -1069,6 +1213,11 @@ static struct attribute *cxl_memdev_attributes[] = {
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
@@ -1081,6 +1230,8 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
 
 static struct attribute_group cxl_memdev_attribute_group = {
 	.attrs = cxl_memdev_attributes,
+	.bin_attrs = cxl_memdev_bin_attributes,
+	.is_bin_visible = cxl_memdev_bin_attr_is_visible,
 };
 
 static struct attribute_group cxl_memdev_ram_attribute_group = {
@@ -1158,6 +1309,25 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm)
 	return ERR_PTR(rc);
 }
 
+static int cxl_cache_cdat_table(struct cxl_memdev *cxlmd)
+{
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+	struct device *dev = &cxlmd->dev;
+	ssize_t cdat_length;
+
+	if (cxlm->table_doe == NULL)
+		return 0;
+
+	cdat_length = cdat_get_length(cxlm->table_doe);
+	if (cdat_length < 0)
+		return cdat_length;
+
+	cxlmd->cdat_length = cdat_length;
+	cxlmd->cdat_table = devm_kzalloc(dev->parent, cdat_length, GFP_KERNEL);
+
+	return cdat_to_buffer(cxlm->table_doe, cxlmd->cdat_table, cxlmd->cdat_length);
+}
+
 static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 {
 	struct cxl_memdev *cxlmd;
@@ -1180,6 +1350,10 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 	 */
 	cxlmd->cxlm = cxlm;
 
+	rc = cxl_cache_cdat_table(cxlmd);
+	if (rc)
+		goto err;
+
 	cdev = &cxlmd->cdev;
 	rc = cdev_device_add(cdev, dev);
 	if (rc)
diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
index 0a3f70316872..fb26155a8fb3 100644
--- a/drivers/cxl/mem.h
+++ b/drivers/cxl/mem.h
@@ -38,12 +38,16 @@
  * @cdev: char dev core object for ioctl operations
  * @cxlm: pointer to the parent device driver data
  * @id: id number of this memdev instance.
+ * @cdat_table: cache of CDAT table
+ * @cdat_length: length of cached CDAT table
  */
 struct cxl_memdev {
 	struct device dev;
 	struct cdev cdev;
 	struct cxl_mem *cxlm;
 	int id;
+	void *cdat_table;
+	size_t cdat_length;
 };
 
 /**
@@ -51,6 +55,7 @@ struct cxl_memdev {
  * @pdev: The PCI device associated with this CXL device.
  * @base: IO mappings to the device's MMIO
  * @cxlmd: Logical memory device chardev / interface
+ * @table_doe: Data exchange object mailbox used to read tables
  * @regs: Parsed register blocks
  * @payload_size: Size of space for payload
  *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
@@ -65,6 +70,7 @@ struct cxl_mem {
 	void __iomem *base;
 	struct cxl_memdev *cxlmd;
 
+	struct pci_doe *table_doe;
 	struct cxl_regs regs;
 
 	size_t payload_size;
-- 
2.19.1

