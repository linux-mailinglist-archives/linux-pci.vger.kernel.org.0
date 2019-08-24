Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC74E9BEA2
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2019 17:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfHXPmZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Aug 2019 11:42:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38564 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfHXPmY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Aug 2019 11:42:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id m125so11829798wmm.3
        for <linux-pci@vger.kernel.org>; Sat, 24 Aug 2019 08:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NWoGoqro8CaypLIMqchQ1f4Z89IQ/KV52Mxzk09bfd4=;
        b=ReS0yLEcnDtP0ouy6pZLvxxTubok0NrMosFyT3gVm66+WJivSCpHQMDTOwcJb78gMT
         TlfKAx1gSh1xggGvGqNaNVV3UESBpfulSonmjTt15lIAFwUSHtZIadvrT43yMDMDCS3D
         lJpb7o6IO7VA4dGAuXLv7efpiWIo9zT69QeCsJeauhov8XgzKiIE1865L6oK5W7r4miy
         4984QQN/ktXu0rsmA8GnjjsdkL4F+I7XDnvVU4z3+OS+Twrl+qX1OFgajfOmvCaWn/Rv
         5R7pBDTuC5joGW2ckf8dbjkdax+BH6YTSUnDtM8uir925wXI5AS4HXlu9IdJN6B1tYZ/
         Jafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NWoGoqro8CaypLIMqchQ1f4Z89IQ/KV52Mxzk09bfd4=;
        b=G4MDKZ2VRqaveXBsf5aQ4Uae4vaL8Bur+m4v5xmIeYIFAprkxzjJ/RDuCdLkhn4Y0x
         gh4TajuSAspKiZy/Tc3npnb39AS+MgkadXU8AJGIVgBIcO69JK8Zd+ICPnEZkbSL3JQk
         J0vC67LTgnR/I5DtalBn1sHz81iYGnL5iQ4huktdlQBjr0FwWmDqsbsWexGXGXEi5dy+
         1S7mV98XlgCeiNPoerCW/gZM69idj1xFV7lcDP5PrXOI18jQGrpw1bLL3+zC/wpxz+qb
         iGK1gvwgRy2mBGwSM/bUFzxMz28NjfssBk4cUPekYW7+o6cmDE4yV0uc5Lq8jmqWRkqs
         DOCA==
X-Gm-Message-State: APjAAAW2cGOWomZl1fbkOn2kxZhMAjg/6IopDYRaPrw7qbscgn4e9PZh
        CqUoabg/l7QeUH5eldwGFCU8H37o
X-Google-Smtp-Source: APXvYqzStbcXj5djKFsLd4BLRtrurdrRyKc3dfTTjycJ2RppolhkNKpVQwazrWSdA6Fe1rBRcOdIZg==
X-Received: by 2002:a1c:4005:: with SMTP id n5mr11445546wma.166.1566661341693;
        Sat, 24 Aug 2019 08:42:21 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:2069:2121:113c:4840? (p200300EA8F047C0020692121113C4840.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:2069:2121:113c:4840])
        by smtp.googlemail.com with ESMTPSA id e3sm12951073wrs.37.2019.08.24.08.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Aug 2019 08:42:21 -0700 (PDT)
Subject: [PATCH v4 3/4] PCI/ASPM: add sysfs attributes for controlling ASPM
 link states
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <3797de51-0135-07b6-9566-a1ce8cf3f24e@gmail.com>
Message-ID: <36db4d65-9a38-03aa-bad1-22b15ebb06c2@gmail.com>
Date:   Sat, 24 Aug 2019 17:41:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3797de51-0135-07b6-9566-a1ce8cf3f24e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Background of this extension is a problem with the r8169 network driver.
Several combinations of board chipsets and network chip versions have
problems if ASPM is enabled, therefore we have to disable ASPM per default.
However especially on notebooks ASPM can provide significant power-saving,
therefore we want to give users the option to enable ASPM. With the new sysfs
attributes users can control which ASPM link-states are enabled/disabled.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- use a dedicated sysfs attribute per link state
- allow separate control of ASPM and PCI PM L1 sub-states
v3:
- statically allocate the attribute group
- replace snprintf with printf
- base on top of "PCI: Make pcie_downstream_port() available outside of access.c"
v4:
- add call to sysfs_update_group because is_visible callback returns false
  always at file creation time
- simplify code a little
---
 Documentation/ABI/testing/sysfs-bus-pci |  13 ++
 drivers/pci/pci-sysfs.c                 |   7 +
 drivers/pci/pci.h                       |   4 +
 drivers/pci/pcie/aspm.c                 | 184 ++++++++++++++++++++++++
 4 files changed, 208 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 8bfee557e..49249a165 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -347,3 +347,16 @@ Description:
 		If the device has any Peer-to-Peer memory registered, this
 	        file contains a '1' if the memory has been published for
 		use outside the driver that owns the device.
+
+What		/sys/bus/pci/devices/.../aspm/aspm_l0s
+What		/sys/bus/pci/devices/.../aspm/aspm_l1
+What		/sys/bus/pci/devices/.../aspm/aspm_l1_1
+What		/sys/bus/pci/devices/.../aspm/aspm_l1_2
+What		/sys/bus/pci/devices/.../aspm/aspm_l1_1_pcipm
+What		/sys/bus/pci/devices/.../aspm/aspm_l1_2_pcipm
+What		/sys/bus/pci/devices/.../aspm/aspm_clkpm
+date:		August 2019
+Contact:	Heiner Kallweit <hkallweit1@gmail.com>
+Description:	If ASPM is supported for an endpoint, then these files
+		can be used to disable or enable the individual
+		power management states.
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 793412954..26e36b0d0 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1331,6 +1331,10 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 
 	pcie_vpd_create_sysfs_dev_files(dev);
 	pcie_aspm_create_sysfs_dev_files(dev);
+#ifdef CONFIG_PCIEASPM
+	/* update visibility of attributes in this group */
+	sysfs_update_group(&dev->dev.kobj, &aspm_ctrl_attr_group);
+#endif
 
 	if (dev->reset_fn) {
 		retval = device_create_file(&dev->dev, &dev_attr_reset);
@@ -1587,6 +1591,9 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
 	&pcie_dev_attr_group,
 #ifdef CONFIG_PCIEAER
 	&aer_stats_attr_group,
+#endif
+#ifdef CONFIG_PCIEASPM
+	&aspm_ctrl_attr_group,
 #endif
 	NULL,
 };
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 85e9fc14e..3908fb23d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -649,4 +649,8 @@ static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline void pci_aer_clear_device_status(struct pci_dev *dev) { }
 #endif
 
+#ifdef CONFIG_PCIEASPM
+extern const struct attribute_group aspm_ctrl_attr_group;
+#endif
+
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 149b876c9..9da4d1432 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1308,6 +1308,190 @@ void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev)
 }
 #endif
 
+static struct pcie_link_state *aspm_get_parent_link(struct pci_dev *pdev)
+{
+	struct pci_dev *parent = pdev->bus->self;
+
+	if (pcie_downstream_port(pdev))
+		parent = pdev;
+
+	return parent ? parent->link_state : NULL;
+}
+
+static bool pcie_check_valid_aspm_endpoint(struct pci_dev *pdev)
+{
+	struct pcie_link_state *link;
+
+	if (!pci_is_pcie(pdev) || pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+		return false;
+
+	link = aspm_get_parent_link(pdev);
+
+	return link && link->aspm_capable;
+}
+
+static ssize_t aspm_attr_show_common(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf, int state)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pcie_link_state *link;
+	int val;
+
+	link = aspm_get_parent_link(pdev);
+	if (!link)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&aspm_lock);
+	val = !!(link->aspm_enabled & state);
+	mutex_unlock(&aspm_lock);
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t aspm_attr_store_common(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t len, int state)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pcie_link_state *link;
+	bool state_enable;
+
+	if (aspm_disabled)
+		return -EPERM;
+
+	link = aspm_get_parent_link(pdev);
+	if (!link)
+		return -EOPNOTSUPP;
+
+	if (!(link->aspm_capable & state))
+		return -EOPNOTSUPP;
+
+	if (strtobool(buf, &state_enable) < 0)
+		return -EINVAL;
+
+	down_read(&pci_bus_sem);
+	mutex_lock(&aspm_lock);
+
+	if (state_enable) {
+		link->aspm_disable &= ~state;
+		/* need to enable L1 for sub-states */
+		if (state & ASPM_STATE_L1SS)
+			link->aspm_disable &= ~ASPM_STATE_L1;
+	} else {
+		link->aspm_disable |= state;
+	}
+
+	pcie_config_aspm_link(link, policy_to_aspm_state(link));
+
+	mutex_unlock(&aspm_lock);
+	up_read(&pci_bus_sem);
+
+	return len;
+}
+
+#define ASPM_ATTR(_f, _s)						\
+static ssize_t aspm_##_f##_show(struct device *dev,			\
+			struct device_attribute *attr, char *buf)	\
+{ return aspm_attr_show_common(dev, attr, buf, ASPM_STATE_##_s); }	\
+									\
+static ssize_t aspm_##_f##_store(struct device *dev,			\
+				 struct device_attribute *attr,		\
+				 const char *buf, size_t len)		\
+{ return aspm_attr_store_common(dev, attr, buf, len, ASPM_STATE_##_s); }
+
+ASPM_ATTR(l0s, L0S)
+ASPM_ATTR(l1, L1)
+ASPM_ATTR(l1_1, L1_1)
+ASPM_ATTR(l1_2, L1_2)
+ASPM_ATTR(l1_1_pcipm, L1_1_PCIPM)
+ASPM_ATTR(l1_2_pcipm, L1_2_PCIPM)
+
+static ssize_t aspm_clkpm_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pcie_link_state *link;
+	int val;
+
+	link = aspm_get_parent_link(pdev);
+	if (!link)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&aspm_lock);
+	val = link->clkpm_enabled;
+	mutex_unlock(&aspm_lock);
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t aspm_clkpm_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t len)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pcie_link_state *link;
+	bool state_enable;
+
+	if (aspm_disabled)
+		return -EPERM;
+
+	link = aspm_get_parent_link(pdev);
+	if (!link)
+		return -EOPNOTSUPP;
+
+	if (!link->clkpm_capable)
+		return -EOPNOTSUPP;
+
+	if (strtobool(buf, &state_enable) < 0)
+		return -EINVAL;
+
+	down_read(&pci_bus_sem);
+	mutex_lock(&aspm_lock);
+
+	link->clkpm_disable = !state_enable;
+	pcie_set_clkpm(link, policy_to_clkpm_state(link));
+
+	mutex_unlock(&aspm_lock);
+	up_read(&pci_bus_sem);
+
+	return len;
+}
+
+static DEVICE_ATTR_RW(aspm_l0s);
+static DEVICE_ATTR_RW(aspm_l1);
+static DEVICE_ATTR_RW(aspm_l1_1);
+static DEVICE_ATTR_RW(aspm_l1_2);
+static DEVICE_ATTR_RW(aspm_l1_1_pcipm);
+static DEVICE_ATTR_RW(aspm_l1_2_pcipm);
+static DEVICE_ATTR_RW(aspm_clkpm);
+
+static struct attribute *aspm_ctrl_attrs[] = {
+	&dev_attr_aspm_l0s.attr,
+	&dev_attr_aspm_l1.attr,
+	&dev_attr_aspm_l1_1.attr,
+	&dev_attr_aspm_l1_2.attr,
+	&dev_attr_aspm_l1_1_pcipm.attr,
+	&dev_attr_aspm_l1_2_pcipm.attr,
+	&dev_attr_aspm_clkpm.attr,
+	NULL
+};
+
+static umode_t aspm_ctrl_attrs_are_visible(struct kobject *kobj,
+					   struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return pcie_check_valid_aspm_endpoint(pdev) ? a->mode : 0;
+}
+
+const struct attribute_group aspm_ctrl_attr_group = {
+	.name = "aspm",
+	.attrs = aspm_ctrl_attrs,
+	.is_visible = aspm_ctrl_attrs_are_visible,
+};
+
 static int __init pcie_aspm_disable(char *str)
 {
 	if (!strcmp(str, "off")) {
-- 
2.23.0


