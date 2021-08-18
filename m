Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDD13F0437
	for <lists+linux-pci@lfdr.de>; Wed, 18 Aug 2021 15:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbhHRNEz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Aug 2021 09:04:55 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8040 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbhHRNEw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Aug 2021 09:04:52 -0400
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GqSl80R2jzYqWg;
        Wed, 18 Aug 2021 21:03:48 +0800 (CST)
Received: from SZX1000464847.huawei.com (10.21.59.169) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 18 Aug 2021 21:04:12 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <helgaas@kernel.org>, <hch@infradead.org>, <kw@linux.com>,
        <logang@deltatee.com>, <leon@kernel.org>,
        <linux-pci@vger.kernel.org>, <rajur@chelsio.com>,
        <hverkuil-cisco@xs4all.nl>
CC:     <linux-media@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH V8 4/8] PCI/sysfs: Add a 10-Bit Tag sysfs file PCIe Endpoint devices
Date:   Wed, 18 Aug 2021 21:01:53 +0800
Message-ID: <1629291717-38564-5-git-send-email-liudongdong3@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629291717-38564-1-git-send-email-liudongdong3@huawei.com>
References: <1629291717-38564-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.21.59.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe spec 5.0 r1.0 section 2.2.6.2 says:

  If an Endpoint supports sending Requests to other Endpoints (as
  opposed to host memory), the Endpoint must not send 10-Bit Tag
  Requests to another given Endpoint unless an implementation-specific
  mechanism determines that the Endpoint supports 10-Bit Tag Completer
  capability.

Add a 10bit_tag sysfs file, write 0 to disable 10-Bit Tag Requester
when the driver does not bind the deivce. The typical use case is for
p2pdma when the peer device does not support 10-Bit Tag Completer.
Write 1 to enable 10-Bit Tag Requester when RC supports 10-Bit Tag
Completer capability. The typical use case is for host memory targeted
by DMA Requests. The 10bit_tag file content indicate current status of
10-Bit Tag Requester Enable.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 18 +++++++-
 drivers/pci/pci-sysfs.c                 | 76 +++++++++++++++++++++++++++++++++
 drivers/pci/pci.h                       |  2 +
 drivers/pci/probe.c                     | 14 ++++++
 4 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 793cbb7..759682f 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -139,7 +139,7 @@ Description:
 		binary file containing the Vital Product Data for the
 		device.  It should follow the VPD format defined in
 		PCI Specification 2.1 or 2.2, but users should consider
-		that some devices may have incorrectly formatted data.  
+		that some devices may have incorrectly formatted data.
 		If the underlying VPD has a writable section then the
 		corresponding section of this file will be writable.
 
@@ -407,3 +407,19 @@ Description:
 
 		The file is writable if the PF is bound to a driver that
 		implements ->sriov_set_msix_vec_count().
+
+What:		/sys/bus/pci/devices/.../10bit_tag
+Date:		August 2021
+Contact:	Dongdong Liu <liudongdong3@huawei.com>
+Description:
+		The file will be visible when the device supports 10-Bit Tag
+		Requester. The file is readable, the value indicate current
+		status of 10-Bit Tag Requester Enable.
+		1 - enabled, 0 - disabled.
+
+		The file is also writable, write 0 to disable 10-Bit Tag
+		Requester when the driver does not bind the device. The typical
+		use case is for p2pdma when the peer device does not support
+		10-Bit Tag Completer. Write 1 to enable 10-Bit Tag Requester
+		when RC supports 10-Bit Tag Completer capability. The typical
+		use case is for host memory targeted by DMA Requests.
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5d63df7..52d0757 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -306,6 +306,53 @@ static ssize_t enable_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(enable);
 
+static ssize_t pci_10bit_tag_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	bool enable;
+
+	if (kstrtobool(buf, &enable) < 0)
+		return -EINVAL;
+
+	if (pdev->driver)
+		return -EBUSY;
+
+	if (enable) {
+		if (!pcie_rp_10bit_tag_cmp_supported(pdev))
+			return -EPERM;
+
+		pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2,
+				PCI_EXP_DEVCTL2_10BIT_TAG_REQ_EN);
+	} else {
+		pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2,
+				   PCI_EXP_DEVCTL2_10BIT_TAG_REQ_EN);
+	}
+
+	return count;
+}
+
+static ssize_t pci_10bit_tag_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u16 ctl;
+	int ret;
+
+	ret = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL2, &ctl);
+	if (ret)
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%u\n",
+			  !!(ctl & PCI_EXP_DEVCTL2_10BIT_TAG_REQ_EN));
+}
+
+static struct device_attribute dev_attr_10bit_tag = __ATTR(10bit_tag, 0644,
+							   pci_10bit_tag_show,
+							   pci_10bit_tag_store);
+
 #ifdef CONFIG_NUMA
 static ssize_t numa_node_store(struct device *dev,
 			       struct device_attribute *attr, const char *buf,
@@ -635,6 +682,11 @@ static struct attribute *pcie_dev_attrs[] = {
 	NULL,
 };
 
+static struct attribute *pcie_dev_10bit_tag_attrs[] = {
+	&dev_attr_10bit_tag.attr,
+	NULL,
+};
+
 static struct attribute *pcibus_attrs[] = {
 	&dev_attr_bus_rescan.attr,
 	&dev_attr_cpuaffinity.attr,
@@ -1482,6 +1534,24 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
 	return 0;
 }
 
+static umode_t pcie_dev_10bit_tag_attrs_are_visible(struct kobject *kobj,
+					  struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (pdev->is_virtfn)
+		return 0;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+		return 0;
+
+	if (!(pdev->pcie_devcap2 & PCI_EXP_DEVCAP2_10BIT_TAG_REQ))
+		return 0;
+
+	return a->mode;
+}
+
 static const struct attribute_group pci_dev_group = {
 	.attrs = pci_dev_attrs,
 };
@@ -1521,6 +1591,11 @@ static const struct attribute_group pcie_dev_attr_group = {
 	.is_visible = pcie_dev_attrs_are_visible,
 };
 
+static const struct attribute_group pcie_dev_10bit_tag_attr_group = {
+	.attrs = pcie_dev_10bit_tag_attrs,
+	.is_visible = pcie_dev_10bit_tag_attrs_are_visible,
+};
+
 static const struct attribute_group *pci_dev_attr_groups[] = {
 	&pci_dev_attr_group,
 	&pci_dev_hp_attr_group,
@@ -1530,6 +1605,7 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
 #endif
 	&pci_bridge_attr_group,
 	&pcie_dev_attr_group,
+	&pcie_dev_10bit_tag_attr_group,
 #ifdef CONFIG_PCIEAER
 	&aer_stats_attr_group,
 #endif
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 93dcdd4..dca5aaf 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -244,6 +244,8 @@ struct device *pci_get_host_bridge_device(struct pci_dev *dev);
 void pci_put_host_bridge_device(struct device *dev);
 
 int pci_configure_extended_tags(struct pci_dev *dev, void *ign);
+bool pcie_rp_10bit_tag_cmp_supported(struct pci_dev *dev);
+
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
 				int crs_timeout);
 bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c83245b..f9bc562 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2029,6 +2029,20 @@ static void pci_configure_mps(struct pci_dev *dev)
 		 p_mps, mps, mpss);
 }
 
+bool pcie_rp_10bit_tag_cmp_supported(struct pci_dev *dev)
+{
+	struct pci_dev *root;
+
+	root = pcie_find_root_port(dev);
+	if (!root)
+		return false;
+
+	if (!(root->pcie_devcap2 & PCI_EXP_DEVCAP2_10BIT_TAG_COMP))
+		return false;
+
+	return true;
+}
+
 int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
 {
 	struct pci_host_bridge *host;
-- 
2.7.4

