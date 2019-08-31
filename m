Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B582CA462C
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2019 22:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfHaUVT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 31 Aug 2019 16:21:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51339 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbfHaUVT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Aug 2019 16:21:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id k1so10715119wmi.1
        for <linux-pci@vger.kernel.org>; Sat, 31 Aug 2019 13:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F+t8Cr+q/0B86BI83/P5P4BD0j9yQLctzzA5ry5iyh0=;
        b=G9LasMD4OSya4A6ezPEyB1XX1DPAjIL509nPWWVPeYLwqH+HBVRGLtVyb/XHAB1WYV
         W+RE3g3YQv+pR07XVfoP8ClNtDW9EPIAPDjrUPqF10JpMhCxF/qvvhBydmgADB1/hHDT
         DIy1rDyjG72vZkMWPfuUJb8p20ZxpcuWlCNsh2j6Wh5wZ1+6IqL6HBcaYt+L5Yi20G/c
         b5vw2tHWi/dgCs3fvfsF9XfH4xDsMbgTjZ2+iWOua0LFlnQ30y+QzduT44mFkNrnXiCU
         XC3lbVkNGlo5NgcVCtwekkZp4yfPzwDa4i0MHIZoBMBU+PcdCj0i2waYeE4kESL+H7fy
         yRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F+t8Cr+q/0B86BI83/P5P4BD0j9yQLctzzA5ry5iyh0=;
        b=pW1dluWMMBZbZZI23JWo9Dxq2udk/vufs/7aXqOZhGtb8A3TtneC7+QwoD2REbVa1k
         po1mYg82b7nvyreKzIX7B8VUjTKoDJ6fG61T7suzJweW/eCKt2rNPUrSa/sdEXLVOWyV
         Y7WXVj6k1HLWkoi41oErj8AZlM8Omrlq43ctmsQMaLTycMBA6r7RVGWps21+bXAVw+du
         oO7FnwKb9PA+KPqhsuDu6yOuvw1mKKrxQkVqhMpr6MpTCJ3iURgQqfBhZJyvaGydVWU4
         PVEEhrtLBhNnwcO9qzO2kw5fShLjve3tnh/qj2bTiib7WG/G8ZKDdTr9eHM3UFxVylCk
         rVjA==
X-Gm-Message-State: APjAAAXIkffkP9vWaEEo7wQXMcw6bDIIj42rrq6Hbye15B1xDPjh4Ph1
        TbHoOsJm/XDOu6IvstNcSU6aVA0+
X-Google-Smtp-Source: APXvYqyJYenCe+G514HYd/i42APadbjBPDffiHh14q0LyA5lv7PvKwW6IMFRSRsbMvASD/SIXlveBw==
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr26842615wmi.48.1567282875685;
        Sat, 31 Aug 2019 13:21:15 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:9586:e556:3a4d:c04? (p200300EA8F047C009586E5563A4D0C04.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:9586:e556:3a4d:c04])
        by smtp.googlemail.com with ESMTPSA id k6sm32958223wrg.0.2019.08.31.13.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2019 13:21:15 -0700 (PDT)
Subject: [PATCH v5 3/4] PCI/ASPM: add sysfs attributes for controlling ASPM
 link states
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <c63f507f-7f52-7164-dbc5-07fc18e433b8@gmail.com>
Message-ID: <8783b887-2e30-43f0-d462-96f8fbb18ae2@gmail.com>
Date:   Sat, 31 Aug 2019 22:20:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c63f507f-7f52-7164-dbc5-07fc18e433b8@gmail.com>
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
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
index 868e35109..687240f55 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1315,6 +1315,10 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 
 	pcie_vpd_create_sysfs_dev_files(dev);
 	pcie_aspm_create_sysfs_dev_files(dev);
+#ifdef CONFIG_PCIEASPM
+	/* update visibility of attributes in this group */
+	sysfs_update_group(&dev->dev.kobj, &aspm_ctrl_attr_group);
+#endif
 
 	if (dev->reset_fn) {
 		retval = device_create_file(&dev->dev, &dev_attr_reset);
@@ -1571,6 +1575,9 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
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
index 44b80186d..9dc3e3673 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -659,4 +659,8 @@ static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
 }
 #endif
 
+#ifdef CONFIG_PCIEASPM
+extern const struct attribute_group aspm_ctrl_attr_group;
+#endif
+
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index f044ae4d1..ce3425125 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1287,6 +1287,190 @@ void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev)
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



