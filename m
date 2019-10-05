Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6CFCC9D0
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2019 14:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfJEMJs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Oct 2019 08:09:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35517 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbfJEMJs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Oct 2019 08:09:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id y21so8218915wmi.0
        for <linux-pci@vger.kernel.org>; Sat, 05 Oct 2019 05:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cJg5BNYgx36rU3i+O8MnkLFHoaynWTce8xtnYdjo5Dk=;
        b=sWjv8jWlJXcyR9SkxTVKGvOZXKi7ZchFEkZH+OmgZK+P+TugmMnSoU0NNGIB1Ybg3P
         4QModicycbsazkxwllkMfjm0d73OaCvnV7f8/TGXzRvOYsFFOtJoxEhhi/FyJnV0urXC
         ifPnHKg+kNqELiqETRQVdfDI6A2MsIJrhM0x3jE8CgW35uP9NJP4ROlh49dLM0DUncgA
         jzqQR+iVdrqyHrcxLLubp60EYZF1X5IqW+ULSyG8Zl/MTAHur8VNvwJqRXg7fTIzJgfT
         EQbD7DqIVlzkogMfaOQNOFvqqXXaDGIWojdNkEz4rtZlSU+qJ5DyZXqTGI1YPTH1OFAY
         2bZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cJg5BNYgx36rU3i+O8MnkLFHoaynWTce8xtnYdjo5Dk=;
        b=L4SpNhDbznIGMHD16R/lszkiwU64lO1jbLE/WmY+qUG9vuUTYF2tzSLwSMNO8pg2NF
         2qo9TL56ZCtK9IY9rtSOd1HZVzw29hG0UdbXGq82r3kdT0F5gpFWkh4MCxiUAd3Q1F6W
         8myenATVBtk+gfGyKLgvTUJZfHjlsA7eiWmaHSsFXlBchqQ9l9Xalg07UqkXLw1B8ZzJ
         DQ+/VAkbsc1FTmocxwJzlBmBHJtGnqaAaiecpK6H4SqbUu8AkuSy9jNeNBVFxGyDAd/+
         ZVomRmi7poB74hkk5DgXtjmQgYUU4FRtRbPUuoJusLgOq+uz0m/DTTG0DHSHH0SpYLl/
         ey0g==
X-Gm-Message-State: APjAAAXdK0BuQbSOHaqX1bcB5B1Pqev/xej/PybR8Bv5Le/wL5lbL+fp
        IzJqGV0BZFJXM1xfNpjOcz1tDidY
X-Google-Smtp-Source: APXvYqzBa16ldBGCi1IOAb/Yb50DdrlMk7gGEjzAhFudraIbdY8eM0HnVe7yRonugyexAyzKGqK4xQ==
X-Received: by 2002:a1c:a404:: with SMTP id n4mr13954906wme.41.1570277383403;
        Sat, 05 Oct 2019 05:09:43 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f26:6400:78ef:16af:4ef6:6109? (p200300EA8F26640078EF16AF4EF66109.dip0.t-ipconnect.de. [2003:ea:8f26:6400:78ef:16af:4ef6:6109])
        by smtp.googlemail.com with ESMTPSA id w9sm16017319wrt.62.2019.10.05.05.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Oct 2019 05:09:42 -0700 (PDT)
Subject: [PATCH v7 4/5] PCI/ASPM: Add sysfs attributes for controlling ASPM
 link states
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <e1c28e25-df18-16e1-3e9f-933f613ea858@gmail.com>
Message-ID: <b1c83f8a-9bf6-eac5-82d0-cf5b90128fbf@gmail.com>
Date:   Sat, 5 Oct 2019 14:07:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e1c28e25-df18-16e1-3e9f-933f613ea858@gmail.com>
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
v7:
- change group name from aspm to link_pm
- control visibility of attributes individually
---
 Documentation/ABI/testing/sysfs-bus-pci |  14 ++
 drivers/pci/pci-sysfs.c                 |   3 +
 drivers/pci/pci.h                       |   4 +
 drivers/pci/pcie/aspm.c                 | 174 ++++++++++++++++++++++++
 4 files changed, 195 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 8bfee557e..c86c8ab00 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -347,3 +347,17 @@ Description:
 		If the device has any Peer-to-Peer memory registered, this
 	        file contains a '1' if the memory has been published for
 		use outside the driver that owns the device.
+
+What:		/sys/bus/pci/devices/.../link_pm/clkpm
+		/sys/bus/pci/devices/.../link_pm/l0s_aspm
+		/sys/bus/pci/devices/.../link_pm/l1_aspm
+		/sys/bus/pci/devices/.../link_pm/l1_1_aspm
+		/sys/bus/pci/devices/.../link_pm/l1_2_aspm
+		/sys/bus/pci/devices/.../link_pm/l1_1_pcipm
+		/sys/bus/pci/devices/.../link_pm/l1_2_pcipm
+Date:		October 2019
+Contact:	Heiner Kallweit <hkallweit1@gmail.com>
+Description:	If ASPM is supported for an endpoint, then these files
+		can be used to disable or enable the individual
+		power management states. Write y/1/on to enable,
+		n/0/off to disable.
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
index 91cfea673..05ea02abf 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -899,6 +899,14 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 	return link;
 }
 
+static void pcie_aspm_update_sysfs_visibility(struct pci_dev *pdev)
+{
+	struct pci_dev *child;
+
+	list_for_each_entry(child, &pdev->subordinate->devices, bus_list)
+		sysfs_update_group(&child->dev.kobj, &aspm_ctrl_attr_group);
+}
+
 /*
  * pcie_aspm_init_link_state: Initiate PCI express link state.
  * It is called after the pcie and its children devices are scanned.
@@ -960,6 +968,9 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 		pcie_set_clkpm(link, policy_to_clkpm_state(link));
 	}
 
+	/* Update visibility of ASPM sysfs attributes */
+	pcie_aspm_update_sysfs_visibility(pdev);
+
 unlock:
 	mutex_unlock(&aspm_lock);
 out:
@@ -1315,6 +1326,169 @@ void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev)
 }
 #endif
 
+static ssize_t aspm_attr_show_common(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf, u8 state)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pcie_link_state *link;
+	bool enabled;
+
+	link = pcie_aspm_get_link(pdev);
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
+				      const char *buf, size_t len, u8 state)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pcie_link_state *link;
+	bool state_enable;
+
+	link = pcie_aspm_get_link(pdev);
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
+static ssize_t _f##_show(struct device *dev,				\
+			 struct device_attribute *attr, char *buf)	\
+{ return aspm_attr_show_common(dev, attr, buf, ASPM_STATE_##_s); }	\
+									\
+static ssize_t _f##_store(struct device *dev,				\
+			  struct device_attribute *attr,		\
+			  const char *buf, size_t len)			\
+{ return aspm_attr_store_common(dev, attr, buf, len, ASPM_STATE_##_s); }
+
+ASPM_ATTR(l0s_aspm, L0S)
+ASPM_ATTR(l1_aspm, L1)
+ASPM_ATTR(l1_1_aspm, L1_1)
+ASPM_ATTR(l1_2_aspm, L1_2)
+ASPM_ATTR(l1_1_pcipm, L1_1_PCIPM)
+ASPM_ATTR(l1_2_pcipm, L1_2_PCIPM)
+
+static ssize_t clkpm_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pcie_link_state *link;
+	int val;
+
+	link = pcie_aspm_get_link(pdev);
+
+	mutex_lock(&aspm_lock);
+	val = link->clkpm_enabled;
+	mutex_unlock(&aspm_lock);
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t clkpm_store(struct device *dev,
+			   struct device_attribute *attr,
+			   const char *buf, size_t len)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pcie_link_state *link;
+	bool state_enable;
+
+	link = pcie_aspm_get_link(pdev);
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
+static DEVICE_ATTR_RW(clkpm);
+static DEVICE_ATTR_RW(l0s_aspm);
+static DEVICE_ATTR_RW(l1_aspm);
+static DEVICE_ATTR_RW(l1_1_aspm);
+static DEVICE_ATTR_RW(l1_2_aspm);
+static DEVICE_ATTR_RW(l1_1_pcipm);
+static DEVICE_ATTR_RW(l1_2_pcipm);
+
+static struct attribute *aspm_ctrl_attrs[] = {
+	&dev_attr_clkpm.attr,
+	&dev_attr_l0s_aspm.attr,
+	&dev_attr_l1_aspm.attr,
+	&dev_attr_l1_1_aspm.attr,
+	&dev_attr_l1_2_aspm.attr,
+	&dev_attr_l1_1_pcipm.attr,
+	&dev_attr_l1_2_pcipm.attr,
+	NULL
+};
+
+static umode_t aspm_ctrl_attrs_are_visible(struct kobject *kobj,
+					   struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pcie_link_state *link = NULL;
+	static const u8 aspm_state_map[] = {
+		ASPM_STATE_L0S,
+		ASPM_STATE_L1,
+		ASPM_STATE_L1_1,
+		ASPM_STATE_L1_2,
+		ASPM_STATE_L1_1_PCIPM,
+		ASPM_STATE_L1_2_PCIPM,
+	};
+
+	if (aspm_disabled)
+		return 0;
+
+	if (pci_is_pcie(pdev))
+		link = pcie_aspm_get_link(pdev);
+
+	if (!link)
+		return 0;
+
+	if (n)
+		return link->aspm_capable & aspm_state_map[n - 1] ? a->mode : 0;
+	else
+		return link->clkpm_capable ? a->mode : 0;
+}
+
+const struct attribute_group aspm_ctrl_attr_group = {
+	.name = "link_pm",
+	.attrs = aspm_ctrl_attrs,
+	.is_visible = aspm_ctrl_attrs_are_visible,
+};
+
 static int __init pcie_aspm_disable(char *str)
 {
 	if (!strcmp(str, "off")) {
-- 
2.23.0


