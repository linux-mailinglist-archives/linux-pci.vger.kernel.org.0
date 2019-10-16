Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52353DA1EC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 01:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405788AbfJPXG0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 19:06:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:4571 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390020AbfJPXG0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Oct 2019 19:06:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 16:06:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,305,1566889200"; 
   d="scan'208";a="189833617"
Received: from unknown (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.116.93])
  by orsmga008.jf.intel.com with ESMTP; 16 Oct 2019 16:06:24 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        Pawel Baldysiak <pawel.baldysiak@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dave Fugate <david.fugate@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 2/3] PCI: vmd: Expose VMD details from BIOS
Date:   Wed, 16 Oct 2019 11:04:47 -0600
Message-Id: <1571245488-3549-3-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571245488-3549-1-git-send-email-jonathan.derrick@intel.com>
References: <1571245488-3549-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When some VMDs are enabled and others are not, it's difficult to
determine which IIO stack corresponds to the enabled VMD.

To assist userspace with management tasks, VMD BIOS will write the VMD
instance number and socket number into the first enabled root port's IO
Base/Limit registers prior to OS handoff. VMD driver can capture this
information and expose it to userspace.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 79 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 959c7c7..dbe1bff 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -98,6 +98,8 @@ struct vmd_dev {
 	struct irq_domain	*irq_domain;
 	struct pci_bus		*bus;
 	u8			busn_start;
+	u8			socket_nr;
+	u8			instance_nr;
 
 	struct dma_map_ops	dma_ops;
 	struct dma_domain	dma_domain;
@@ -543,6 +545,74 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 	.write		= vmd_pci_write,
 };
 
+/**
+ * for_each_vmd_root_port - iterate over all enabled VMD Root Ports
+ * @vmd: &struct vmd_dev VMD device descriptor
+ * @rp: int iterator cursor
+ * @temp: u32 temporary value for config read
+ *
+ * VMD Root Ports are located in the VMD PCIe Domain at 00:[0-3].0, and config
+ * space can be determinately accessed through the VMD Config BAR. Because VMD
+ * Root Ports can be individually disabled, it's important to iterate for the
+ * first enabled Root Port as determined by reading the Vendor/Device register.
+ */
+#define for_each_vmd_root_port(vmd, rp, temp)				\
+	for (rp = 0; rp < 4; rp++)					\
+		if (vmd_cfg_read(vmd, 0, PCI_DEVFN(root_port, 0),	\
+				 PCI_VENDOR_ID, 4, &temp) ||		\
+		    temp == 0xffffffff) {} else
+
+static int vmd_parse_domain(struct vmd_dev *vmd)
+{
+	int root_port, ret;
+	u32 temp, iobase;
+
+	vmd->socket_nr = -1;
+	vmd->instance_nr = -1;
+
+	for_each_vmd_root_port(vmd, root_port, temp) {
+		ret = vmd_cfg_read(vmd, 0, PCI_DEVFN(root_port, 0),
+				   PCI_IO_BASE, 2, &iobase);
+		if (ret)
+			return ret;
+
+		vmd->socket_nr = (iobase >> 4) & 0xf;
+		vmd->instance_nr = (iobase >> 14) & 0x3;
+
+		/* First available will be used */
+		break;
+	}
+
+	return 0;
+}
+
+static ssize_t socket_nr_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct vmd_dev *vmd = pci_get_drvdata(pdev);
+
+	return sprintf(buf, "%u\n", vmd->socket_nr);
+}
+static DEVICE_ATTR_RO(socket_nr);
+
+static ssize_t instance_nr_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct vmd_dev *vmd = pci_get_drvdata(pdev);
+
+	return sprintf(buf, "%u\n", vmd->instance_nr);
+}
+static DEVICE_ATTR_RO(instance_nr);
+
+static struct attribute *vmd_dev_attrs[] = {
+	&dev_attr_socket_nr.attr,
+	&dev_attr_instance_nr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(vmd_dev);
+
 static void vmd_attach_resources(struct vmd_dev *vmd)
 {
 	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
@@ -582,6 +652,11 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
 	struct pci_bus *child;
+	int ret;
+
+	ret = vmd_parse_domain(vmd);
+	if (ret)
+		return ret;
 
 	/*
 	 * Shadow registers may exist in certain VMD device ids which allow
@@ -591,7 +666,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	 */
 	if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
 		u32 vmlock;
-		int ret;
 
 		membar2_offset = MB2_SHADOW_OFFSET + MB2_SHADOW_SIZE;
 		ret = pci_read_config_dword(vmd->dev, PCI_REG_VMLOCK, &vmlock);
@@ -876,7 +950,8 @@ static int vmd_resume(struct device *dev)
 	.probe		= vmd_probe,
 	.remove		= vmd_remove,
 	.driver		= {
-		.pm	= &vmd_dev_pm_ops,
+		.pm		= &vmd_dev_pm_ops,
+		.dev_groups	= vmd_dev_groups,
 	},
 };
 module_pci_driver(vmd_drv);
-- 
1.8.3.1

