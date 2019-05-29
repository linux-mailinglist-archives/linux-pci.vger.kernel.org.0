Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B072DB09
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2019 12:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfE2Ktp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 May 2019 06:49:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:55874 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfE2Ktp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 May 2019 06:49:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 03:49:44 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 29 May 2019 03:49:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 9C2CA12C; Wed, 29 May 2019 13:49:42 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Add sysfs attribute for disabling PCIe link to downstream component
Date:   Wed, 29 May 2019 13:49:42 +0300
Message-Id: <20190529104942.74991-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe root and downstream ports have link control register that can be
used disable the link from software. This can be useful for instance
when performing "software" hotplug on systems that do not support real
PCIe/ACPI hotplug.

For example when used with FPGA card we can burn a new FPGA image
without need to reboot the system.

First we remove the FGPA device from Linux PCI stack:

  # echo 1 > /sys/bus/pci/devices/0000:00:01.1/0000:02:00.0/remove

Then we disable the link:

  # echo 1 > /sys/bus/pci/devices/0000:00:01.1/link_disable

By doing this we prevent the kernel from accessing the hardware while we
burn the new FPGA image. Once the new FPGA is burned we can re-enable
the link and rescan the new and possibly different device:

  # echo 0 > /sys/bus/pci/devices/0000:00:01.1/link_disable
  # echo 1 > /sys/bus/pci/devices/0000:00:01.1/rescan

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |  8 +++
 drivers/pci/pci-sysfs.c                 | 65 ++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 8bfee557e50e..c93d6b9ab580 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -324,6 +324,14 @@ Description:
 		This is similar to /sys/bus/pci/drivers_autoprobe, but
 		affects only the VFs associated with a specific PF.
 
+What:		/sys/bus/pci/devices/.../link_disable
+Date:		September 2019
+Contact:	Mika Westerberg <mika.westerberg@linux.intel.com>
+Description:
+		PCIe root and downstream ports have this attribute. Writing
+		1 causes the link to downstream component be disabled.
+		Re-enabling the link happens by writing 0 instead.
+
 What:		/sys/bus/pci/devices/.../p2pmem/size
 Date:		November 2017
 Contact:	Logan Gunthorpe <logang@deltatee.com>
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6d27475e39b2..dfcd21745192 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -218,6 +218,56 @@ static ssize_t current_link_width_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(current_link_width);
 
+static ssize_t link_disable_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	u16 linkctl;
+	int ret;
+
+	ret = pcie_capability_read_word(pci_dev, PCI_EXP_LNKCTL, &linkctl);
+	if (ret)
+		return -EINVAL;
+
+	return sprintf(buf, "%d\n", !!(linkctl & PCI_EXP_LNKCTL_LD));
+}
+
+static ssize_t link_disable_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	u16 linkctl;
+	bool disable;
+	int ret;
+
+	ret = kstrtobool(buf, &disable);
+	if (ret)
+		return ret;
+
+	ret = pcie_capability_read_word(pci_dev, PCI_EXP_LNKCTL, &linkctl);
+	if (ret)
+		return -EINVAL;
+
+	if (disable) {
+		if (linkctl & PCI_EXP_LNKCTL_LD)
+			goto out;
+		linkctl |= PCI_EXP_LNKCTL_LD;
+	} else {
+		if (!(linkctl & PCI_EXP_LNKCTL_LD))
+			goto out;
+		linkctl &= ~PCI_EXP_LNKCTL_LD;
+	}
+
+	ret = pcie_capability_write_word(pci_dev, PCI_EXP_LNKCTL, linkctl);
+	if (ret)
+		return ret;
+
+out:
+	return count;
+}
+static DEVICE_ATTR_RW(link_disable);
+
 static ssize_t secondary_bus_number_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -785,6 +835,7 @@ static struct attribute *pcie_dev_attrs[] = {
 	&dev_attr_current_link_width.attr,
 	&dev_attr_max_link_width.attr,
 	&dev_attr_max_link_speed.attr,
+	&dev_attr_link_disable.attr,
 	NULL,
 };
 
@@ -1656,8 +1707,20 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	if (pci_is_pcie(pdev))
+	if (pci_is_pcie(pdev)) {
+		if (a == &dev_attr_link_disable.attr) {
+			switch (pci_pcie_type(pdev)) {
+			case PCI_EXP_TYPE_ROOT_PORT:
+			case PCI_EXP_TYPE_DOWNSTREAM:
+				break;
+
+			default:
+				return 0;
+			}
+		}
+
 		return a->mode;
+	}
 
 	return 0;
 }
-- 
2.20.1

