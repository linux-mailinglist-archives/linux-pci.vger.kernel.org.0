Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70378348667
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 02:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhCYBY0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 21:24:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:52826 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhCYBX4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Mar 2021 21:23:56 -0400
IronPort-SDR: zjhvOEX4ArEMUE2q7M/+Pdj19nAAHPOI2LNQR2eYXcf4gp5BkKqTTm6NRSt3AebBjoc37NLZFp
 dOzQpYpTDh3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="177939654"
X-IronPort-AV: E=Sophos;i="5.81,276,1610438400"; 
   d="scan'208";a="177939654"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 18:23:55 -0700
IronPort-SDR: mlIFwN3AZzX/tpWyhUjCJyzwRdOko1JXeSKbHeEDvT+MbEYcvJvPrMdBKZYahpwlBXEesBrOtB
 b6s4q8Ho6GNA==
X-IronPort-AV: E=Sophos;i="5.81,276,1610438400"; 
   d="scan'208";a="514410313"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 18:23:55 -0700
Subject: [PATCH] PCI: Allow drivers to claim exclusive access to config
 regions
From:   Dan Williams <dan.j.williams@intel.com>
To:     bhelgaas@google.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 24 Mar 2021 18:23:54 -0700
Message-ID: <161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIE Data Object Exchange (DOE) mailbox is a protocol run over
configuration cycles. It assumes one initiator at a time is
reading/writing the data registers. If userspace reads from the response
data payload it may steal data that a kernel driver was expecting to
read. If userspace writes to the request payload it may corrupt the
request a driver was trying to send.

Introduce pci_{request,release}_config_region() for a driver to exclude
the possibility of userspace induced corruption while accessing the DOE
mailbox. Likely there are other configuration state assumptions that a
driver may want to assert are under its exclusive control, so this
capability is not limited to any specific configuration range.

Since writes are targeted and are already prepared for failure the
entire request is failed. The same can not be done for reads as the
device completely disappears from lspci output if any configuration
register in the request is exclusive. Instead skip the actual
configuration cycle on a per-access basis and return all f's as if the
read had failed.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/access.c    |    5 +++--
 drivers/pci/pci-sysfs.c |    3 +++
 drivers/pci/probe.c     |    5 +++++
 include/linux/ioport.h  |    2 ++
 include/linux/pci.h     |   16 ++++++++++++++++
 kernel/resource.c       |   24 +++++++++++-------------
 6 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 46935695cfb9..a6b3cdfbd505 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -225,8 +225,9 @@ int pci_user_read_config_##size						\
 	raw_spin_lock_irq(&pci_lock);				\
 	if (unlikely(dev->block_cfg_access))				\
 		pci_wait_cfg(dev);					\
-	ret = dev->bus->ops->read(dev->bus, dev->devfn,			\
-					pos, sizeof(type), &data);	\
+	if (!resource_is_exclusive(&dev->config_resource, pos, sizeof(type))) \
+		ret = dev->bus->ops->read(dev->bus, dev->devfn,		\
+					  pos, sizeof(type), &data);	\
 	raw_spin_unlock_irq(&pci_lock);				\
 	*val = (type)data;						\
 	return pcibios_err_to_errno(ret);				\
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index f8afd54ca3e1..4ce2831ffadc 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -753,6 +753,9 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 	u8 *data = (u8 *) buf;
 	int ret;
 
+	if (resource_is_exclusive(&dev->config_resource, off, count))
+		return -EBUSY;
+
 	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
 	if (ret)
 		return ret;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 953f15abc850..8fa3a6f38b53 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2240,6 +2240,11 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	INIT_LIST_HEAD(&dev->bus_list);
 	dev->dev.type = &pci_dev_type;
 	dev->bus = pci_bus_get(bus);
+	dev->config_resource = (struct resource) {
+		.name = "PCI Config",
+		.start = 0,
+		.end = -1,
+	};
 
 	return dev;
 }
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 55de385c839c..e1487a892fe7 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -308,6 +308,8 @@ extern void __devm_release_region(struct device *dev, struct resource *parent,
 				  resource_size_t start, resource_size_t n);
 extern int iomem_map_sanity_check(resource_size_t addr, unsigned long size);
 extern bool iomem_is_exclusive(u64 addr);
+extern bool resource_is_exclusive(struct resource *resource, u64 addr,
+				  resource_size_t size);
 
 extern int
 walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 86c799c97b77..d3d78e0df2e7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -401,6 +401,7 @@ struct pci_dev {
 	 */
 	unsigned int	irq;
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
+	struct resource config_resource;	/* driver exclusive config register ranges */
 
 	bool		match_driver;		/* Skip attaching driver */
 
@@ -1330,6 +1331,21 @@ int pci_request_selected_regions(struct pci_dev *, int, const char *);
 int pci_request_selected_regions_exclusive(struct pci_dev *, int, const char *);
 void pci_release_selected_regions(struct pci_dev *, int);
 
+static inline __must_check struct resource *
+pci_request_config_region(struct pci_dev *pdev, unsigned int where,
+			  unsigned int len, const char *name)
+{
+	return __request_region(&pdev->config_resource, where, len, name,
+				IORESOURCE_EXCLUSIVE);
+}
+
+static inline void pci_release_config_region(struct pci_dev *pdev,
+					     unsigned int where,
+					     unsigned int len)
+{
+	__release_region(&pdev->config_resource, where, len);
+}
+
 /* drivers/pci/bus.c */
 void pci_add_resource(struct list_head *resources, struct resource *res);
 void pci_add_resource_offset(struct list_head *resources, struct resource *res,
diff --git a/kernel/resource.c b/kernel/resource.c
index 627e61b0c124..ab1aed06e8b0 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1706,27 +1706,16 @@ static int strict_iomem_checks;
 #endif
 
 /*
- * check if an address is reserved in the iomem resource tree
+ * check if an address is reserved in the @resource tree
  * returns true if reserved, false if not reserved.
  */
-bool iomem_is_exclusive(u64 addr)
+bool resource_is_exclusive(struct resource *p, u64 addr, resource_size_t size)
 {
-	struct resource *p = &iomem_resource;
 	bool err = false;
 	loff_t l;
-	int size = PAGE_SIZE;
-
-	if (!strict_iomem_checks)
-		return false;
-
-	addr = addr & PAGE_MASK;
 
 	read_lock(&resource_lock);
 	for (p = p->child; p ; p = r_next(NULL, p, &l)) {
-		/*
-		 * We can probably skip the resources without
-		 * IORESOURCE_IO attribute?
-		 */
 		if (p->start >= addr + size)
 			break;
 		if (p->end < addr)
@@ -1749,6 +1738,15 @@ bool iomem_is_exclusive(u64 addr)
 	return err;
 }
 
+bool iomem_is_exclusive(u64 addr)
+{
+	if (!strict_iomem_checks)
+		return false;
+
+	return resource_is_exclusive(&iomem_resource, addr & PAGE_MASK,
+				     PAGE_SIZE);
+}
+
 struct resource_entry *resource_list_create_entry(struct resource *res,
 						  size_t extra_size)
 {

