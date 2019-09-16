Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9119DB427E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 22:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfIPUwo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 16:52:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:26116 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfIPUwo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Sep 2019 16:52:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 13:52:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,514,1559545200"; 
   d="scan'208";a="187254868"
Received: from unknown (HELO debian-vmd.lm.intel.com) ([10.232.112.42])
  by fmsmga007.fm.intel.com with ESMTP; 16 Sep 2019 13:52:40 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: vmd: Expose oob management window to users
Date:   Mon, 16 Sep 2019 08:51:28 -0600
Message-Id: <20190916145128.5243-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some VMD devices provide a management window within MEMBAR2 that is used
to communicate out-of-band with child devices. This patch creates a
binary file for interacting with the interface.

OOB Reads/Writes are bounds-checked by sysfs_fs_bin_{read,write}

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
Depends on https://lore.kernel.org/linux-pci/20190916135435.5017-1-jonathan.derrick@intel.com/T/#t

 drivers/pci/controller/vmd.c | 128 ++++++++++++++++++++++++++++++++---
 1 file changed, 117 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a35d3f3996d7..b13954cf9c96 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -33,6 +33,8 @@
 
 #define MB2_SHADOW_OFFSET	0x2000
 #define MB2_SHADOW_SIZE		16
+#define MB2_OOB_WINDOW_OFFSET	0x2010
+#define MB2_OOB_WINDOW_SIZE	128
 
 enum vmd_features {
 	/*
@@ -47,6 +49,12 @@ enum vmd_features {
 	 * bus numbering
 	 */
 	VMD_FEAT_HAS_BUS_RESTRICTIONS	= (1 << 1),
+
+	/*
+	 * Device may provide an out-of-band management interface through a
+	 * read/write window
+	 */
+	VMD_FEAT_HAS_OOB_WINDOW		= (1 << 2),
 };
 
 /*
@@ -101,6 +109,10 @@ struct vmd_dev {
 
 	struct dma_map_ops	dma_ops;
 	struct dma_domain	dma_domain;
+
+	spinlock_t		oob_lock;
+	char __iomem		*oob_addr;
+	struct bin_attribute	*oob_attr;
 };
 
 static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
@@ -543,6 +555,68 @@ static void vmd_detach_resources(struct vmd_dev *vmd)
 	vmd->dev->resource[VMD_MEMBAR2].child = NULL;
 }
 
+static ssize_t vmd_oob_read(struct file *filp, struct kobject *kobj,
+			    struct bin_attribute *attr, char *buf,
+			    loff_t off, size_t count)
+{
+	struct vmd_dev *vmd = attr->private;
+	unsigned long flags;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	spin_lock_irqsave(&vmd->oob_lock, flags);
+	memcpy_fromio(&buf[off], &vmd->oob_addr[off], count);
+	spin_unlock_irqrestore(&vmd->oob_lock, flags);
+
+	return count;
+}
+
+static ssize_t vmd_oob_write(struct file *filp, struct kobject *kobj,
+			     struct bin_attribute *attr, char *buf,
+			     loff_t off, size_t count)
+{
+	struct vmd_dev *vmd = attr->private;
+	unsigned long flags;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	spin_lock_irqsave(&vmd->oob_lock, flags);
+	memcpy_toio(&vmd->oob_addr[off], &buf[off], count);
+	spin_unlock_irqrestore(&vmd->oob_lock, flags);
+
+	return count;
+}
+
+static int vmd_create_oob_file(struct vmd_dev *vmd)
+{
+	struct pci_dev *dev = vmd->dev;
+	struct bin_attribute *oob_attr;
+
+	oob_attr = devm_kzalloc(&vmd->dev->dev, sizeof(*oob_attr), GFP_ATOMIC);
+	if (!oob_attr)
+		return -ENOMEM;
+
+	spin_lock_init(&vmd->oob_lock);
+	sysfs_bin_attr_init(oob_attr);
+	vmd->oob_attr = oob_attr;
+	oob_attr->attr.name = "oob";
+	oob_attr->attr.mode = S_IRUSR | S_IWUSR;
+	oob_attr->size = MB2_OOB_WINDOW_SIZE;
+	oob_attr->read = vmd_oob_read;
+	oob_attr->write = vmd_oob_write;
+	oob_attr->private = (void *)vmd;
+
+	return sysfs_create_bin_file(&dev->dev.kobj, oob_attr);
+}
+
+static void vmd_destroy_oob_file(struct vmd_dev *vmd)
+{
+	if (vmd->oob_attr)
+		sysfs_remove_bin_file(&vmd->dev->dev.kobj, vmd->oob_attr);
+}
+
 /*
  * VMD domains start at 0x10000 to not clash with ACPI _SEG domains.
  * Per ACPI r6.0, sec 6.5.6,  _SEG returns an integer, of which the lower
@@ -570,6 +644,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
 	struct pci_bus *child;
+	int ret;
 
 	/*
 	 * Shadow registers may exist in certain VMD device ids which allow
@@ -579,7 +654,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	 */
 	if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
 		u32 vmlock;
-		int ret;
 
 		membar2_offset = MB2_SHADOW_OFFSET + MB2_SHADOW_SIZE;
 		ret = pci_read_config_dword(vmd->dev, PCI_REG_VMLOCK, &vmlock);
@@ -614,6 +688,24 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 			vmd->busn_start = 128;
 	}
 
+	/*
+	 * Certain VMD devices provide a window for communicating with child
+	 * devices through a management interface
+	 */
+	if (features & VMD_FEAT_HAS_OOB_WINDOW) {
+		membar2_offset = MB2_OOB_WINDOW_OFFSET + MB2_OOB_WINDOW_SIZE;
+		vmd->oob_addr = devm_ioremap(&vmd->dev->dev,
+					vmd->dev->resource[VMD_MEMBAR2].start +
+					MB2_OOB_WINDOW_OFFSET,
+					MB2_OOB_WINDOW_SIZE);
+		if (!vmd->oob_addr)
+			return -ENOMEM;
+
+		ret = vmd_create_oob_file(vmd);
+		if (ret)
+			return ret;
+	}
+
 	res = &vmd->dev->resource[VMD_CFGBAR];
 	vmd->resources[0] = (struct resource) {
 		.name  = "VMD CFGBAR",
@@ -667,20 +759,26 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	sd->vmd_domain = true;
 	sd->domain = vmd_find_free_domain();
-	if (sd->domain < 0)
-		return sd->domain;
+	if (sd->domain < 0) {
+		ret = sd->domain;
+		goto destroy_oob_file;
+	}
 
 	sd->node = pcibus_to_node(vmd->dev->bus);
 
 	fn = irq_domain_alloc_named_id_fwnode("VMD-MSI", vmd->sysdata.domain);
-	if (!fn)
-		return -ENODEV;
+	if (!fn) {
+		ret = -ENODEV;
+		goto destroy_oob_file;
+	}
 
 	vmd->irq_domain = pci_msi_create_irq_domain(fn, &vmd_msi_domain_info,
 						    x86_vector_domain);
 	irq_domain_free_fwnode(fn);
-	if (!vmd->irq_domain)
-		return -ENODEV;
+	if (!vmd->irq_domain) {
+		ret = -ENODEV;
+		goto destroy_oob_file;
+	}
 
 	pci_add_resource(&resources, &vmd->resources[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
@@ -689,9 +787,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
 				       &vmd_ops, sd, &resources);
 	if (!vmd->bus) {
-		pci_free_resource_list(&resources);
-		irq_domain_remove(vmd->irq_domain);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto remove_irq_domain;
 	}
 
 	vmd_attach_resources(vmd);
@@ -714,6 +811,13 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
 			       "domain"), "Can't create symlink to domain\n");
 	return 0;
+
+remove_irq_domain:
+	pci_free_resource_list(&resources);
+	irq_domain_remove(vmd->irq_domain);
+destroy_oob_file:
+	vmd_destroy_oob_file(vmd);
+	return ret;
 }
 
 static irqreturn_t vmd_irq(int irq, void *data)
@@ -807,6 +911,7 @@ static void vmd_remove(struct pci_dev *dev)
 	struct vmd_dev *vmd = pci_get_drvdata(dev);
 
 	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
+	vmd_destroy_oob_file(vmd);
 	pci_stop_root_bus(vmd->bus);
 	pci_remove_root_bus(vmd->bus);
 	vmd_cleanup_srcu(vmd);
@@ -853,7 +958,8 @@ static const struct pci_device_id vmd_ids[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+				VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				VMD_FEAT_HAS_OOB_WINDOW,},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
-- 
2.20.1

