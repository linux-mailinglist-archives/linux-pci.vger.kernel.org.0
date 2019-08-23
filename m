Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A44D9A77B
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2019 08:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404334AbfHWGQR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Aug 2019 02:16:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52379 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404117AbfHWGQQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Aug 2019 02:16:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id o4so7775632wmh.2
        for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2019 23:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=De2t+OnH9MfsoPT9GJMrVsUaBz55+3cJW9rOaEd+Kjs=;
        b=q8gHohWqV2GtAEgYpR0rOaHAvNlud9E0YyOqBFN+R8ZdGQt2nnAy1hxVHPVQkBv0V7
         qQ3968pLuAikdjum7G6rRINSrMbggI1swGbf+CAumBK45QE8D86A/RiLJAXwH3T3QtSj
         KKz9zT+pSH8XvwJ6XSgoS6hY04JVmjMl2fu46T7f2uiHanle5OHz+j8xa81zTvsRXUPF
         /RScxXqx4N1JdWZK1iU/7dClL7OMOZERC1LCRDnOK3PbTMzsHppP2XhMdqSz8YQhx4e6
         JZraDGZXf+jY800Zs2OrSYHFje7mcJ+oV3GI1Hx/S1guGlnLOHocBoh3CtEq/QF6F1oa
         VSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=De2t+OnH9MfsoPT9GJMrVsUaBz55+3cJW9rOaEd+Kjs=;
        b=UtXUQaLADcdr0EQrrH7hHD5oTC1DeRMIbYoYjk0JBIYF38nWB9cx94exi/deSjDbw8
         xTg7dB1+QHJLEdXfL14ThccV5lO93vct2dKnxhup2Y/KzdrGmR47XKQIWzjEIvHz1+Qm
         tYGlyCOsufLc2Zzr+VqLtFllZDAsEagT10Xd8YU4CntJ5VmlP0oR5x4Ef9rQNoobKPN3
         ncUcVxGQrYOYF8lOwrRHXECmU5yDTLKHRJusr7/kzR1e9PHVq4xTA80lUX+t5dFlC9Qt
         UfgXEbd335CgtQFinYVmZfRcfLXyLaaGcFl+rYscURV5Q7X4PDjSVqinpsPACme7LhBw
         IMdA==
X-Gm-Message-State: APjAAAV7541PwQ31OCVNrM2THY+Iz8Tw3jz80f8iSgGByhU4IiakYksQ
        J86bhh4F1TlcO5C0ic7ziIuLNU8R
X-Google-Smtp-Source: APXvYqx+GkFj6s7b0SZ0qrnUghDK0fdzWs8Gu4Ia1y7+xaiuE5qsEPxSkIfC8dw0sPBkPuW1pA2DHw==
X-Received: by 2002:a1c:45:: with SMTP id 66mr3006191wma.40.1566540974162;
        Thu, 22 Aug 2019 23:16:14 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:34d1:4088:cd1d:73a7? (p200300EA8F047C0034D14088CD1D73A7.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:34d1:4088:cd1d:73a7])
        by smtp.googlemail.com with ESMTPSA id c15sm6869666wrb.80.2019.08.22.23.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 23:16:13 -0700 (PDT)
Subject: [PATCH v3 3/4] PCI/ASPM: add sysfs attributes for controlling ASPM
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <9e5ef666-1ef9-709a-cd7a-ca43eeb9e4a4@gmail.com>
Message-ID: <e11c9f6f-a0ee-2f61-4201-25556a7dbcaf@gmail.com>
Date:   Fri, 23 Aug 2019 08:15:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9e5ef666-1ef9-709a-cd7a-ca43eeb9e4a4@gmail.com>
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
---
 Documentation/ABI/testing/sysfs-bus-pci |  13 ++
 drivers/pci/pci-sysfs.c                 |   3 +
 drivers/pci/pci.h                       |   4 +
 drivers/pci/pcie/aspm.c                 | 246 ++++++++++++++++++++++++
 4 files changed, 266 insertions(+)

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
index 793412954..0e76c02e0 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1587,6 +1587,9 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
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
index 149b876c9..0d54cd7c7 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1308,6 +1308,252 @@ void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev)
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
+static ssize_t aspm_l0s_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	return aspm_attr_show_common(dev, attr, buf, ASPM_STATE_L0S);
+}
+
+static ssize_t aspm_l1_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	return aspm_attr_show_common(dev, attr, buf, ASPM_STATE_L1);
+}
+
+static ssize_t aspm_l1_1_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	return aspm_attr_show_common(dev, attr, buf, ASPM_STATE_L1_1);
+}
+
+static ssize_t aspm_l1_2_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	return aspm_attr_show_common(dev, attr, buf, ASPM_STATE_L1_2);
+}
+
+static ssize_t aspm_l1_1_pcipm_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	return aspm_attr_show_common(dev, attr, buf, ASPM_STATE_L1_1_PCIPM);
+}
+
+static ssize_t aspm_l1_2_pcipm_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	return aspm_attr_show_common(dev, attr, buf, ASPM_STATE_L1_2_PCIPM);
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
+	if (state_enable)
+		link->aspm_disable &= ~state;
+	else
+		link->aspm_disable |= state;
+
+	if (link->aspm_disable & ASPM_STATE_L1)
+		link->aspm_disable |= ASPM_STATE_L1SS;
+
+	pcie_config_aspm_link(link, policy_to_aspm_state(link));
+
+	mutex_unlock(&aspm_lock);
+	up_read(&pci_bus_sem);
+
+	return len;
+}
+
+static ssize_t aspm_l0s_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t len)
+{
+	return aspm_attr_store_common(dev, attr, buf, len, ASPM_STATE_L0S);
+}
+
+static ssize_t aspm_l1_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t len)
+{
+	return aspm_attr_store_common(dev, attr, buf, len, ASPM_STATE_L1);
+}
+
+static ssize_t aspm_l1_1_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t len)
+{
+	return aspm_attr_store_common(dev, attr, buf, len, ASPM_STATE_L1_1);
+}
+
+static ssize_t aspm_l1_2_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t len)
+{
+	return aspm_attr_store_common(dev, attr, buf, len, ASPM_STATE_L1_2);
+}
+
+static ssize_t aspm_l1_1_pcipm_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	return aspm_attr_store_common(dev, attr, buf, len,
+				      ASPM_STATE_L1_1_PCIPM);
+}
+
+static ssize_t aspm_l1_2_pcipm_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	return aspm_attr_store_common(dev, attr, buf, len,
+				      ASPM_STATE_L1_2_PCIPM);
+}
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


