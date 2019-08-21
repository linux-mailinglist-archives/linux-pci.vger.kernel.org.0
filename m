Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2E3E98299
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 20:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfHUSTE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 14:19:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34558 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbfHUSTD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2019 14:19:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id s18so2962737wrn.1
        for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2019 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AEaMdgLb8UgLqPg/3neezq3exBpbsmPDtKGbQ3DqIW4=;
        b=vaN1YJTVq/WPgOom7yzXF449wi1CZae+swbCT+jEvZF1PckNHdWNQmS0Fn3dHT903x
         iQc7oC4Ih8r/m80mawYB1SXZQgvb0MIgjfz6IgLl5FAmznuUy2vY7EperXMxq/tL4LcH
         7NjV9pUoE+sU50jEnydHuKLLZO2MYI6xSjH30so4Kxlals3qqNjfoKXzZIHOSvNEW5En
         /a0m6KGBAJ5nFbdmvVZh4iewfQEUtTtKLugiWh1p4pzcJtHstidK1EqvlxLvzJ5eEnKE
         2AIsUO7dsb/SyAtNkVcbHQAqEzGOhfkHTKs+UTd3xPfU9lShivJskT3Mv3HNUW1yKzaK
         8ZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AEaMdgLb8UgLqPg/3neezq3exBpbsmPDtKGbQ3DqIW4=;
        b=MocKMa/9Z6YrneDxvQLWtX7hQuwnBRz9th8pG4qo8aVF+bZEsQRDE0lp8VIWxZVGyL
         qpEDX3efXvuJOPZF+WlGyrQuGDO18c8rwFBLi/sn4+JtNiflLeoFwREnMjnjFugophWB
         5E1UMhBZaaT2PSFloOGVJ2FRuWR51GDk5u14+/WfMG+kB94EV3LZORTC5PjpavmvjP/Z
         rYQC500whjM+axzgjBd6ITwYkAYlnALdW17T/+A96DZNH7LUIkCLMEitluD3n0oJQxjo
         RyDPBPCQWvrsZt9zAMh3pl5amaZGEU6zJBwdRwfztttr/XEPrvmAX1wbk8xIuQmkxjam
         RIsQ==
X-Gm-Message-State: APjAAAUhXVdnhigWgzbEJVSzYMNM2izarlxiHWLt2faQrKeP+zlI7hLs
        XKwM8VuAZcIVqv69fjLXm45kjGKJ
X-Google-Smtp-Source: APXvYqw+SCsb0v/dU9pl0L+umSkQLAVbtvYT+OfdujNwJ1LX95Bq5sLJQNSceI/lDEf9JlsDwmJKdg==
X-Received: by 2002:adf:f48d:: with SMTP id l13mr44890673wro.190.1566411540117;
        Wed, 21 Aug 2019 11:19:00 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:3d5d:5315:9e29:1daf? (p200300EA8F047C003D5D53159E291DAF.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:3d5d:5315:9e29:1daf])
        by smtp.googlemail.com with ESMTPSA id r11sm17140886wrt.84.2019.08.21.11.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 11:18:59 -0700 (PDT)
Subject: [PATCH v2 3/3] PCI/ASPM: add sysfs attributes for controlling ASPM
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <b4b1518a-d0e8-9534-5211-115107e770e1@gmail.com>
Message-ID: <c75fe7ef-5045-fb53-047c-b7b06d4b7fe8@gmail.com>
Date:   Wed, 21 Aug 2019 20:18:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b4b1518a-d0e8-9534-5211-115107e770e1@gmail.com>
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
---
 Documentation/ABI/testing/sysfs-bus-pci |  13 ++
 drivers/pci/pci.h                       |   8 +-
 drivers/pci/pcie/aspm.c                 | 263 +++++++++++++++++++++++-
 3 files changed, 276 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 8bfee557e..38b565c30 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -347,3 +347,16 @@ Description:
 		If the device has any Peer-to-Peer memory registered, this
 	        file contains a '1' if the memory has been published for
 		use outside the driver that owns the device.
+
+What		/sys/bus/pci/devices/.../power/aspm_l0s
+What		/sys/bus/pci/devices/.../power/aspm_l1
+What		/sys/bus/pci/devices/.../power/aspm_l1_1
+What		/sys/bus/pci/devices/.../power/aspm_l1_2
+What		/sys/bus/pci/devices/.../power/aspm_l1_1_pcipm
+What		/sys/bus/pci/devices/.../power/aspm_l1_2_pcipm
+What		/sys/bus/pci/devices/.../power/aspm_clkpm
+date:		August 2019
+Contact:	Heiner Kallweit <hkallweit1@gmail.com>
+Description:	If ASPM is supported for an endpoint, then these files
+		can be used to disable or enable the individual
+		power management states.
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3f126f808..e51c91f38 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -525,17 +525,13 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
 void pcie_aspm_pm_state_change(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
+void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
+void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
-#endif
-
-#ifdef CONFIG_PCIEASPM_DEBUG
-void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
-void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
-#else
 static inline void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev) { }
 static inline void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev) { }
 #endif
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 149b876c9..e7dfcd1bd 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1275,38 +1275,297 @@ static ssize_t clk_ctl_store(struct device *dev,
 
 static DEVICE_ATTR_RW(link_state);
 static DEVICE_ATTR_RW(clk_ctl);
+#endif
+
+static const char power_group[] = "power";
+
+static struct pcie_link_state *aspm_get_parent_link(struct pci_dev *pdev)
+{
+	struct pci_dev *parent = pdev->bus->self;
+
+	if (pdev->has_secondary_link)
+		parent = pdev;
+
+	return parent ? parent->link_state : NULL;
+}
+
+static bool pcie_check_valid_aspm_endpoint(struct pci_dev *pdev)
+{
+	struct pcie_link_state *link;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
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
+	return snprintf(buf, PAGE_SIZE, "%d\n", val);
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
+	return snprintf(buf, PAGE_SIZE, "%d\n", val);
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
 
-static char power_group[] = "power";
 void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link_state = pdev->link_state;
 
+	if (pcie_check_valid_aspm_endpoint(pdev)) {
+		sysfs_add_file_to_group(&pdev->dev.kobj,
+			&dev_attr_aspm_l0s.attr, power_group);
+		sysfs_add_file_to_group(&pdev->dev.kobj,
+			&dev_attr_aspm_l1.attr, power_group);
+		sysfs_add_file_to_group(&pdev->dev.kobj,
+			&dev_attr_aspm_l1_1.attr, power_group);
+		sysfs_add_file_to_group(&pdev->dev.kobj,
+			&dev_attr_aspm_l1_2.attr, power_group);
+		sysfs_add_file_to_group(&pdev->dev.kobj,
+			&dev_attr_aspm_l1_1_pcipm.attr, power_group);
+		sysfs_add_file_to_group(&pdev->dev.kobj,
+			&dev_attr_aspm_l1_2_pcipm.attr, power_group);
+		sysfs_add_file_to_group(&pdev->dev.kobj,
+			&dev_attr_aspm_clkpm.attr, power_group);
+	}
+
 	if (!link_state)
 		return;
 
+#ifdef CONFIG_PCIEASPM_DEBUG
 	if (link_state->aspm_support)
 		sysfs_add_file_to_group(&pdev->dev.kobj,
 			&dev_attr_link_state.attr, power_group);
 	if (link_state->clkpm_capable)
 		sysfs_add_file_to_group(&pdev->dev.kobj,
 			&dev_attr_clk_ctl.attr, power_group);
+#endif
 }
 
 void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link_state = pdev->link_state;
 
+	if (pcie_check_valid_aspm_endpoint(pdev)) {
+		sysfs_remove_file_from_group(&pdev->dev.kobj,
+			&dev_attr_aspm_l0s.attr, power_group);
+		sysfs_remove_file_from_group(&pdev->dev.kobj,
+			&dev_attr_aspm_l1.attr, power_group);
+		sysfs_remove_file_from_group(&pdev->dev.kobj,
+			&dev_attr_aspm_l1_1.attr, power_group);
+		sysfs_remove_file_from_group(&pdev->dev.kobj,
+			&dev_attr_aspm_l1_2.attr, power_group);
+		sysfs_remove_file_from_group(&pdev->dev.kobj,
+			&dev_attr_aspm_l1_1_pcipm.attr, power_group);
+		sysfs_remove_file_from_group(&pdev->dev.kobj,
+			&dev_attr_aspm_l1_2_pcipm.attr, power_group);
+		sysfs_remove_file_from_group(&pdev->dev.kobj,
+			&dev_attr_aspm_clkpm.attr, power_group);
+	}
+
 	if (!link_state)
 		return;
 
+#ifdef CONFIG_PCIEASPM_DEBUG
 	if (link_state->aspm_support)
 		sysfs_remove_file_from_group(&pdev->dev.kobj,
 			&dev_attr_link_state.attr, power_group);
 	if (link_state->clkpm_capable)
 		sysfs_remove_file_from_group(&pdev->dev.kobj,
 			&dev_attr_clk_ctl.attr, power_group);
-}
 #endif
+}
 
 static int __init pcie_aspm_disable(char *str)
 {
-- 
2.23.0


