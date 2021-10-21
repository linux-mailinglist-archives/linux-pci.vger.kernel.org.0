Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADA7435990
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 05:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhJUDyo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 23:54:44 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:50670
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231278AbhJUDym (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Oct 2021 23:54:42 -0400
Received: from HP-EliteBook-840-G7.. (36-229-235-18.dynamic-ip.hinet.net [36.229.235.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A0CEE40D4C;
        Thu, 21 Oct 2021 03:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634788346;
        bh=JROFHqLiUKsECL4FqkIeAj4rpctATb8J7DRYDP4fO6A=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=S+OJPB76OX4ZNn7rP/KW9MICpExtplfb7M9tyiQDLixX7Lqv/8iVkeLpXAwtgNxR7
         E3WPOwyarS1/buYZS0f0+5S8FFJkfHBNz+YOguf+fMVEuXylnd8FV/AqCXa8vnK7nv
         QOlyZ1RDMsDmZwAw6+pgunkNh1pyL1IE5LYVdbBwX2GZPjkfLvsoE1atIl8vF2UOzn
         EYZncxLYMNhMSX1qmhRcELPZxgC/hOlvYcAZF6vXe+6KY46J/T/B1NIlB5vouUeTMN
         AwtdfmlnbnLv3GaiiXp7KmzDaPLMz4h9Ah57jtkK18ZO9fCx3D+l03AC78tMqJsaJl
         FfYnJJRMcI/eA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     hkallweit1@gmail.com, anthony.wong@canonical.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH v2 3/3] PCI/ASPM: Add LTR sysfs attributes
Date:   Thu, 21 Oct 2021 11:51:59 +0800
Message-Id: <20211021035159.1117456-4-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211021035159.1117456-1-kai.heng.feng@canonical.com>
References: <20211021035159.1117456-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sometimes BIOS may not be able to program ASPM and LTR settings, for
instance, the NVMe devices behind Intel VMD bridges. For this case, both
ASPM and LTR have to be enabled to have significant power saving.

Since we still want POLICY_DEFAULT honor the default BIOS ASPM settings,
introduce LTR sysfs knobs so users can set max snoop and max nosnoop
latency manually or via udev rules.

[1] https://github.com/systemd/systemd/pull/17899/
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=209789
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - New patch.

 drivers/pci/pcie/aspm.c | 59 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 1560859ab056..f7dc62936445 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1299,6 +1299,59 @@ static ssize_t clkpm_store(struct device *dev,
 	return len;
 }
 
+static ssize_t ltr_attr_show_common(struct device *dev,
+			  struct device_attribute *attr, char *buf, u8 state)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ltr;
+	u16 val;
+
+	ltr = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
+	if (!ltr)
+		return -EINVAL;
+
+	pci_read_config_word(pdev, ltr + state, &val);
+
+	return sysfs_emit(buf, "0x%0x\n", val);
+}
+
+static ssize_t ltr_attr_store_common(struct device *dev,
+			   struct device_attribute *attr,
+			   const char *buf, size_t len, u8 state)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ltr;
+	u16 val;
+
+	ltr = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
+	if (!ltr)
+		return -EINVAL;
+
+	if (kstrtou16(buf, 16, &val) < 0)
+		return -EINVAL;
+
+	/* LatencyScale is not permitted to be 110 or 111 */
+	if ((val >> 10) > 5)
+		return -EINVAL;
+
+	pci_write_config_word(pdev, ltr + state, val);
+
+	return len;
+}
+
+#define LTR_ATTR(_f, _s)						\
+static ssize_t _f##_show(struct device *dev,				\
+			 struct device_attribute *attr, char *buf)	\
+{ return ltr_attr_show_common(dev, attr, buf, PCI_LTR_##_s); }		\
+									\
+static ssize_t _f##_store(struct device *dev,				\
+			  struct device_attribute *attr,		\
+			  const char *buf, size_t len)			\
+{ return ltr_attr_store_common(dev, attr, buf, len, PCI_LTR_##_s); }
+
+LTR_ATTR(ltr_max_snoop_lat, MAX_SNOOP_LAT);
+LTR_ATTR(ltr_max_nosnoop_lat, MAX_NOSNOOP_LAT);
+
 static DEVICE_ATTR_RW(clkpm);
 static DEVICE_ATTR_RW(l0s_aspm);
 static DEVICE_ATTR_RW(l1_aspm);
@@ -1306,6 +1359,8 @@ static DEVICE_ATTR_RW(l1_1_aspm);
 static DEVICE_ATTR_RW(l1_2_aspm);
 static DEVICE_ATTR_RW(l1_1_pcipm);
 static DEVICE_ATTR_RW(l1_2_pcipm);
+static DEVICE_ATTR_RW(ltr_max_snoop_lat);
+static DEVICE_ATTR_RW(ltr_max_nosnoop_lat);
 
 static struct attribute *aspm_ctrl_attrs[] = {
 	&dev_attr_clkpm.attr,
@@ -1315,6 +1370,8 @@ static struct attribute *aspm_ctrl_attrs[] = {
 	&dev_attr_l1_2_aspm.attr,
 	&dev_attr_l1_1_pcipm.attr,
 	&dev_attr_l1_2_pcipm.attr,
+	&dev_attr_ltr_max_snoop_lat.attr,
+	&dev_attr_ltr_max_nosnoop_lat.attr,
 	NULL
 };
 
@@ -1338,6 +1395,8 @@ static umode_t aspm_ctrl_attrs_are_visible(struct kobject *kobj,
 
 	if (n == 0)
 		return link->clkpm_capable ? a->mode : 0;
+	else if (n == 7 || n == 8)
+		return pdev->ltr_path ? a->mode : 0;
 
 	return link->aspm_capable & aspm_state_map[n - 1] ? a->mode : 0;
 }
-- 
2.32.0

