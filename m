Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 469F1C40EC
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 21:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfJATTQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 15:19:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39418 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfJATTP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Oct 2019 15:19:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so16884348wrj.6
        for <linux-pci@vger.kernel.org>; Tue, 01 Oct 2019 12:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qTEVgOVACCDBR7OeQb4v4rJNPYXOEZWQLWzy0f/scJQ=;
        b=kk7sRPfrlW+p4+wk815EYqnqQ75jvoYMHU0EOE1l3y7bDFodThrUVYWqhzaK0G7ui+
         7RHuofuX7qo4UnI+W+P7h4/gG8HG06cJtvplOTc0dP6lx90K1uZ1ILXGabLVzq5UXesF
         wS9XGHArck+4N5rbFNUBi5m+FpTwRQL+bYiOJLlyjDGimz1vix2cCFDrOnWtGDh7w0D9
         tUz8LGtT+CX9wyLwcKrpCj0JdceaxOONdzUma7JmDHRtJ2GtEfCT76dTe3MZuyQP8qfk
         Z5HAR12ZX0MZESRIOkz+0H2W8dRHc00ZFtWTuBRORTCAb+4dos/NGRFD798y6yKWBamt
         16tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qTEVgOVACCDBR7OeQb4v4rJNPYXOEZWQLWzy0f/scJQ=;
        b=IagHBqDA+5lhl0BiPE7npRK9/ju6x6yLBKKKC9sj3uwDkbkG4XKtTAwO06+sXhSnW6
         DB3iNpKJdNQG0ZT0FbaFl0ckCcgTD4bF9ptBbFGuZyl0RDO+G4Oz50br5jq4ceXFTjbI
         F2cTWsuLMgRt5GBVb2Iqs12rdY9500zx82nLpDEPjE0WcisGdIqWfVWXH10sB4Ni4+rp
         14mXy11UfhygUnf5niob8DIFFAFcd7X6ZrNr1fjnu5yvfoRbUB7yrqt58lC/k47nwYgI
         VvnTwWZcNgorYeP4CmZxKMU3z1nxPjLuWAOWNHrCcClQ/hhgaAYYNQf/tSvlBHGBdWyG
         uESg==
X-Gm-Message-State: APjAAAUHR2TjjoqeEo+x+w6620S0mDS7OcmM4ZQTI5lERXC60rFs5MV+
        u0TPlRklrOp4djNCSyRcOX6FWL09
X-Google-Smtp-Source: APXvYqw2IICNt/Hp5SexM9L8A5LmtgkNBVRXRt1JcFtXaXWE/jG/kdVvBpd2rVl5nD86XphAB52+xg==
X-Received: by 2002:adf:b1da:: with SMTP id r26mr1772806wra.244.1569957550236;
        Tue, 01 Oct 2019 12:19:10 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f26:6400:ad11:16fb:d8da:de15? (p200300EA8F266400AD1116FBD8DADE15.dip0.t-ipconnect.de. [2003:ea:8f26:6400:ad11:16fb:d8da:de15])
        by smtp.googlemail.com with ESMTPSA id 3sm4854200wmo.22.2019.10.01.12.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 12:19:09 -0700 (PDT)
Subject: [PATCH v6 3/4] PCI/ASPM: Add sysfs attributes for controlling ASPM
 link states
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <0577b966-6290-0685-123d-c675baf97caa@gmail.com>
Message-ID: <09214ca2-422d-45e7-9020-99f66e2ca869@gmail.com>
Date:   Tue, 1 Oct 2019 21:18:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0577b966-6290-0685-123d-c675baf97caa@gmail.com>
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
therefore we want to give users the option to enable ASPM. With the new
sysfs attributes users can control which ASPM link-states are
enabled/disabled.

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
v5:
- rebased to latest pci/next
v6:
- fix style of added documentation and extend it
- don't use term "parent" and rename function to pcie_aspm_get_link
- rename pcie_check_valid_aspm_endpoint to pcie_is_aspm_dev
- enable the sysfs files also selected other port types
- avoid usage of !!
---
 Documentation/ABI/testing/sysfs-bus-pci |  14 ++
 drivers/pci/pci-sysfs.c                 |   7 +
 drivers/pci/pci.h                       |   4 +
 drivers/pci/pcie/aspm.c                 | 194 ++++++++++++++++++++++++
 4 files changed, 219 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 8bfee557e..9aabe8bbf 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -347,3 +347,17 @@ Description:
 		If the device has any Peer-to-Peer memory registered, this
 	        file contains a '1' if the memory has been published for
 		use outside the driver that owns the device.
+
+What:		/sys/bus/pci/devices/.../aspm/aspm_l0s
+		/sys/bus/pci/devices/.../aspm/aspm_l1
+		/sys/bus/pci/devices/.../aspm/aspm_l1_1
+		/sys/bus/pci/devices/.../aspm/aspm_l1_2
+		/sys/bus/pci/devices/.../aspm/aspm_l1_1_pcipm
+		/sys/bus/pci/devices/.../aspm/aspm_l1_2_pcipm
+		/sys/bus/pci/devices/.../aspm/aspm_clkpm
+Date:		September 2019
+Contact:	Heiner Kallweit <hkallweit1@gmail.com>
+Description:	If ASPM is supported for an endpoint, then these files
+		can be used to disable or enable the individual
+		power management states. Write y/1/on to enable,
+		n/0/off to disable.
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
index 3f6947ee3..b2cd21e8c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -667,4 +667,8 @@ static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
 }
 #endif
 
+#ifdef CONFIG_PCIEASPM
+extern const struct attribute_group aspm_ctrl_attr_group;
+#endif
+
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 574f822bf..58c0b069d 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1182,6 +1182,18 @@ static int pcie_aspm_get_policy(char *buffer, const struct kernel_param *kp)
 module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
 	NULL, 0644);
 
+static struct pcie_link_state *pcie_aspm_get_link(struct pci_dev *pdev)
+{
+	struct pci_dev *upstream;
+
+	if (pcie_downstream_port(pdev))
+		upstream = pdev;
+	else
+		upstream = pci_upstream_bridge(pdev);
+
+	return upstream ? upstream->link_state : NULL;
+}
+
 /**
  * pcie_aspm_enabled - Check if PCIe ASPM has been enabled for a device.
  * @pdev: Target device.
@@ -1307,6 +1319,188 @@ void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev)
 }
 #endif
 
+static bool pcie_is_aspm_dev(struct pci_dev *pdev)
+{
+	struct pcie_link_state *link;
+
+	if (!pci_is_pcie(pdev))
+		return false;
+
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ENDPOINT:
+	case PCI_EXP_TYPE_LEG_END:
+	case PCI_EXP_TYPE_UPSTREAM:
+	case PCI_EXP_TYPE_PCI_BRIDGE:
+	case PCI_EXP_TYPE_PCIE_BRIDGE:
+		link = pcie_aspm_get_link(pdev);
+		return link && link->aspm_capable;
+	default:
+		return false;
+	}
+}
+
+static ssize_t aspm_attr_show_common(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf, int state)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pcie_link_state *link;
+	bool enabled;
+
+	link = pcie_aspm_get_link(pdev);
+	if (!link)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&aspm_lock);
+	enabled = link->aspm_enabled & state;
+	mutex_unlock(&aspm_lock);
+
+	return sprintf(buf, "%d\n", enabled ? 1 : 0);
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
+	link = pcie_aspm_get_link(pdev);
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
+	link = pcie_aspm_get_link(pdev);
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
+	link = pcie_aspm_get_link(pdev);
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
+	return pcie_is_aspm_dev(pdev) ? a->mode : 0;
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


