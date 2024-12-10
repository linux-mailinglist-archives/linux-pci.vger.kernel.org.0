Return-Path: <linux-pci+bounces-17983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B789EA70F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 05:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D190168C63
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 04:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DE741C6C;
	Tue, 10 Dec 2024 04:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="X49l1crn"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B44613635E
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 04:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803805; cv=none; b=hQkVWh1ssRb07XgPYYikJtEvpziyGurPelBw3w8GN3FCQerHVu85lOFL2GUvq0ISEiq1AQCVnGvHI2xbd/Ok4uVY0sTtXd0pp89CCeTEn8Ln+vBDr0xQhp4QYkAO9Swnky3n31KQJq7Dr8b63kWw69OWBgMytpCQWauOIiIReME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803805; c=relaxed/simple;
	bh=MWfMg/z+yfEbVeaKcwFH7aW564liYJojx0qiVscuLvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ogm7PF5ImfQ6X18XGY6tnT+egd8LWS1MYoPPgCkrorhi9YEUY0tiO2a+HPc8NZhZFu9RDTM/TO/RIGuasUsXU8Px+tntarGW+x99ljFvyvZO7Jb8pUZTsIOZoZx7WcMorfpQynmzj2yiKyunlc7eY39Pu9P+Jbq67wzMDr3eDdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=X49l1crn; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1733803804; x=1765339804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MWfMg/z+yfEbVeaKcwFH7aW564liYJojx0qiVscuLvM=;
  b=X49l1crnGxiNKjX56SDhlyaKU0fVhUkflrW2qKyhfPFJWx7RsNF73PUi
   UJjILlN4laa3Um89r4xAm7NqCxflwA2iF3j9RdJod6XB/a8NzwQLW6ZCP
   172QHtJLPRk4MMdIbgp/ljdjtfqbXiQfebjEJPnx36FFVcr2++DnFQQYf
   tqcH4MXpL46fKDYdr0KnsC8ZcJmo1LCVZm3Qli97BMTKfsuczaXT40LNL
   16bFE2qqNqPsxi/I6b33tx9O2T2lZY+mMUviOVsGSdUOpKgeQyoUUDlTU
   kpiho1g2lEekhh0CHG/mDdpG7tuHU0h//A9xkrDYo3daLOwpo7kB7HdhN
   w==;
X-CSE-ConnectionGUID: f6hiFH78RM2hD9fbBI2EHQ==
X-CSE-MsgGUID: hjO2skBvR/uAo4Mp9alPUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="183163214"
X-IronPort-AV: E=Sophos;i="6.12,221,1728918000"; 
   d="scan'208";a="183163214"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 13:08:52 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id F2F76943EF
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 13:08:49 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id B9DA3D5B2D
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 13:08:49 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 810F02020FA6;
	Tue, 10 Dec 2024 13:08:49 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	kw@linux.com,
	linux-pci@vger.kernel.org
Cc: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v5 2/2] Export Power Budgeting Extended Capability into pci-bus-sysfs
Date: Tue, 10 Dec 2024 13:08:21 +0900
Message-ID: <20241210040826.11402-3-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241210040826.11402-1-kobayashi.da-06@fujitsu.com>
References: <20241210040826.11402-1-kobayashi.da-06@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for PBEC (Power Budgeting Extended Capability) output 
to the PCIe driver. PBEC is defined in the 
PCIe specification(PCIe r6.0, sec 7.8.1) and is
a standard method for obtaining device power consumption information.

Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |  62 ++++++++
 drivers/pci/pci-sysfs.c                 | 179 ++++++++++++++++++++++++
 2 files changed, 241 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 7f63c7e97773..ec417ae20bc1 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -572,3 +572,65 @@ Description:
 		enclosure-specific indications "specific0" to "specific7",
 		hence the corresponding led class devices are unavailable if
 		the DSM interface is used.
+
+What:		/sys/bus/pci/devices/.../power_budget
+Date:		December 2024
+Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
+Description:
+		This file provides information about the PCIe power budget
+		for the device. It is a read-only file that outputs the values
+		of the Power Budgeting Data Register for each power state as a
+		series of 32-bit hexadecimal values. Each line represents a
+		single Power Budgeting Data register entry, containing the
+		power budget for a specific power state.
+
+		The specific interpretation of these values depends on the
+		device and the PCIe specification. Refer to the PCIe
+		specification for detailed information about the Power
+		Budgeting Data register, including the encoding	of power
+		states and the interpretation of Base Power and Data Scale.
+
+What:		/sys/bus/pci/devices/.../power_budget/power_budget_data_select
+Date:		December 2024
+Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
+Description:
+		This is an 8-bit read/write register that selects the DWORD of 
+		power budgeting data that will be displayed in the
+		Power Budgeting Data. The value starts at zero and incrementing
+		the index value selects the next DWORD.
+
+What:		/sys/bus/pci/devices/.../power_budget/power_budget_power
+Date:		December 2024
+Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
+Description:
+		This file provides the power consumption calculated by
+		multiplying the base power by the data scale.
+
+
+What:		/sys/bus/pci/devices/.../power_budget/power_budget_pm_state
+Date:		December 2024
+Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
+Description:
+		This file specifies the power management state of the operating
+		condition.
+
+What:		/sys/bus/pci/devices/.../power_budget/power_budget_pm_substate
+Date:		December 2024
+Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
+Description:
+		This file specifies the power management sub state of the
+		operating condition.
+
+What:		/sys/bus/pci/devices/.../power_budget/power_budget_type
+Date:		December 2024
+Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
+Description:
+		This file specifies the type of the operating condition.
+
+
+What:		/sys/bus/pci/devices/.../power_budget/power_budget_rail
+Date:		December 2024
+Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
+Description:
+		This file Specifies the thermal load or power rail of the
+		operating condition.
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5d0f4db1cab7..89909633ad02 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -238,6 +238,155 @@ static ssize_t current_link_width_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(current_link_width);
 
+static ssize_t power_budget_data_select_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	int pos;
+	u8 val;
+
+	pos = pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_PWR);
+	if (!pos)
+		return -EINVAL;
+
+	if (kstrtou8(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	pci_write_config_byte(pci_dev, pos + PCI_PWR_DSR, val);
+
+	return count;
+}
+
+static ssize_t power_budget_data_select_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	int pos, err;
+	u8 data;
+
+	pos = pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_PWR);
+	if (!pos)
+		return -EINVAL;
+
+	err = pci_read_config_byte(pci_dev, pos + PCI_PWR_DSR, &data);
+	if (err)
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%u\n", data);
+}
+
+static DEVICE_ATTR_RW(power_budget_data_select);
+
+static ssize_t power_budget_power_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	int pos, err;
+	u32 data;
+	u8 base, scale_up, scale_low, scale;
+
+	pos = pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_PWR);
+	if (!pos)
+		return -EINVAL;
+
+	err = pci_read_config_dword(pci_dev, pos + PCI_PWR_DATA, &data);
+	if (err)
+		return -EINVAL;
+
+	base = PCI_PWR_DATA_BASE(data);
+	scale_up = PCI_PWR_DATA_SCALE_UP(data);
+	scale_low = PCI_PWR_DATA_SCALE(data);
+	scale = scale_up << 2 | scale_low;
+	if (scale == 0 && base >= 0xF0)
+		return sysfs_emit(buf, "%s\n",pci_power_budget_alt_encode_string(data));
+
+	return sysfs_emit(buf, "%u%s\n", base, pci_power_budget_scale_string(scale));
+}
+static DEVICE_ATTR_RO(power_budget_power);
+
+static ssize_t power_budget_pm_state_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	int pos, err;
+	u32 data;
+
+	pos = pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_PWR);
+	if (!pos)
+		return -EINVAL;
+
+	err = pci_read_config_dword(pci_dev, pos + PCI_PWR_DATA, &data);
+	if (err)
+		return -EINVAL;
+
+	return sysfs_emit(buf, "D%u\n", PCI_PWR_DATA_PM_STATE(data));
+}
+static DEVICE_ATTR_RO(power_budget_pm_state);
+
+static ssize_t power_budget_pm_substate_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	int pos, err;
+	u8 substate;
+	u32 data;
+
+	pos = pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_PWR);
+	if (!pos)
+		return -EINVAL;
+
+	err = pci_read_config_dword(pci_dev, pos + PCI_PWR_DATA, &data);
+	if (err)
+		return -EINVAL;
+	
+	substate = PCI_PWR_DATA_PM_SUB(data);
+	if (substate == 0)
+		return sysfs_emit(buf, "Default Sub State\n");
+
+	return sysfs_emit(buf, "Device Specific Sub State\n");
+}
+static DEVICE_ATTR_RO(power_budget_pm_substate);
+
+static ssize_t power_budget_type_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	int pos, err;
+	u32 data;
+
+	pos = pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_PWR);
+	if (!pos)
+		return -EINVAL;
+
+	err = pci_read_config_dword(pci_dev, pos + PCI_PWR_DATA, &data);
+	if (err)
+		return -EINVAL;
+	
+	return sysfs_emit(buf, "%u\n", PCI_PWR_DATA_TYPE(data));
+}
+static DEVICE_ATTR_RO(power_budget_type);
+
+static ssize_t power_budget_rail_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	int pos, err;
+	u32 data;
+
+	pos = pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_PWR);
+	if (!pos)
+		return -EINVAL;
+
+	err = pci_read_config_dword(pci_dev, pos + PCI_PWR_DATA, &data);
+	if (err)
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%s\n", 
+				pci_power_budget_rail_string(PCI_PWR_DATA_RAIL(data)));
+}
+static DEVICE_ATTR_RO(power_budget_rail);
+
 static ssize_t secondary_bus_number_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -636,6 +785,16 @@ static struct attribute *pcie_dev_attrs[] = {
 	NULL,
 };
 
+static struct attribute *pcie_pbec_attrs[] = {
+	&dev_attr_power_budget_data_select.attr,
+	&dev_attr_power_budget_power.attr,
+	&dev_attr_power_budget_pm_state.attr,
+	&dev_attr_power_budget_pm_substate.attr,
+	&dev_attr_power_budget_rail.attr,
+	&dev_attr_power_budget_type.attr,
+	NULL,
+};
+
 static struct attribute *pcibus_attrs[] = {
 	&dev_attr_bus_rescan.attr,
 	&dev_attr_cpuaffinity.attr,
@@ -1610,6 +1769,19 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
 	return 0;
 }
 
+static umode_t pcie_pbec_attrs_are_visible(struct kobject *kobj,
+					  struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (pci_is_pcie(pdev) && 
+		pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PWR))
+		return a->mode;
+
+	return 0;
+}
+
 static const struct attribute_group pci_dev_group = {
 	.attrs = pci_dev_attrs,
 };
@@ -1652,6 +1824,12 @@ static const struct attribute_group pcie_dev_attr_group = {
 	.is_visible = pcie_dev_attrs_are_visible,
 };
 
+static const struct attribute_group pcie_pbec_attr_group = {
+	.name = "power_budget",
+	.attrs = pcie_pbec_attrs,
+	.is_visible = pcie_pbec_attrs_are_visible,
+};
+
 const struct attribute_group *pci_dev_attr_groups[] = {
 	&pci_dev_attr_group,
 	&pci_dev_hp_attr_group,
@@ -1661,6 +1839,7 @@ const struct attribute_group *pci_dev_attr_groups[] = {
 #endif
 	&pci_bridge_attr_group,
 	&pcie_dev_attr_group,
+	&pcie_pbec_attr_group,
 #ifdef CONFIG_PCIEAER
 	&aer_stats_attr_group,
 #endif
-- 
2.45.0


