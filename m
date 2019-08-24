Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC489BEA3
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2019 17:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfHXPm0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Aug 2019 11:42:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39111 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfHXPmZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Aug 2019 11:42:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so11293299wra.6
        for <linux-pci@vger.kernel.org>; Sat, 24 Aug 2019 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wa5QIPDWQJ6axAtkVmVG4nVvmhHC/SrPRW3RFzcvIjc=;
        b=cO6uC6Naegsmij9hO8WksDPfhF0oZJjQtq3O9JYZiQsiuMwRp7wFvrTVjSSnufDN7B
         kEah2i2H56k2s9Xt2C6piOpu/U8upGWJy1/Ktwz8ZOjR045YW5XvEaqn8JgBBarhtCw8
         MDrrDB+p8iTGU3TJ1S2kvsuvxyUbs9TryKFmeHdD9n+9KKd2Z95SKr3sQh1DdDO1+sE/
         OvUK7a+gKezGhrUNfYSOK/+O55/AsMKYt6DScnjJfkvZZsN98P7DtiSlfVMxGf0a3m0O
         lJ12klt0b6C8PbeXmUylxNz5XwnHzvU3rqxxLNCiZUXP5/Cmp71sOS9ef4vop/ZAhOOF
         EIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wa5QIPDWQJ6axAtkVmVG4nVvmhHC/SrPRW3RFzcvIjc=;
        b=PHoQ5cupaXXLkQRkKLjiw+plz8O4SKpEZV2e/VlfgerRqXuZ+0kXrBKmPVOHU+pDZZ
         YvuM/IjoimuvGF6hAr38v0mHGuaTguh+gQEvahxhqwpcJGGi0W4Jw6LCVMveTXXpxpZk
         Q4jyaoYip/Xy2LqnXAV4pH6xHenlmL56FiGU2LRDu70x6tau/wBphTwaLkCebsbQp1Qd
         jHgrPx1aJ8TmdYsJnAR23QwiD8lHjnJtxUHFP26MzQOgazNkYthB4poWg2bpyTkSaz6W
         xKW0BMNX/kOMVs2mmDYyHwB4SwS8hnNrQILibx8EOZIyC98jF+NRgr4/DU7Rn7OgIGLx
         zkVw==
X-Gm-Message-State: APjAAAUaqbTyRuGu37NwQhe48tjSZTq8IGHgxwDNvmvtdOLDO9UebkOc
        qdZ4eiCFeBwNNatevumtpydps6h4
X-Google-Smtp-Source: APXvYqwpHiIGNFssH9xbZVjKtavQPQbnKED/LY30UC3dAGBWDah8ajZQDqz7XiXSYQOTs/rUuYCPmQ==
X-Received: by 2002:adf:ffc2:: with SMTP id x2mr11660460wrs.338.1566661342991;
        Sat, 24 Aug 2019 08:42:22 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:2069:2121:113c:4840? (p200300EA8F047C0020692121113C4840.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:2069:2121:113c:4840])
        by smtp.googlemail.com with ESMTPSA id r18sm5070066wmh.6.2019.08.24.08.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Aug 2019 08:42:22 -0700 (PDT)
Subject: [PATCH v4 4/4] PCI/ASPM: remove Kconfig option PCIEASPM_DEBUG and
 related code
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <3797de51-0135-07b6-9566-a1ce8cf3f24e@gmail.com>
Message-ID: <3f53a96e-7f34-2540-f663-bcebf408e0f7@gmail.com>
Date:   Sat, 24 Aug 2019 17:42:06 +0200
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

Now that we have sysfs attributes for enabling/disabling the individual
ASPM link states, this debug code isn't needed any longer.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/pci-sysfs.c  |   3 --
 drivers/pci/pci.h        |   8 ---
 drivers/pci/pcie/Kconfig |   7 ---
 drivers/pci/pcie/aspm.c  | 105 ---------------------------------------
 4 files changed, 123 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 26e36b0d0..8657cdf62 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1330,7 +1330,6 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 	int retval;
 
 	pcie_vpd_create_sysfs_dev_files(dev);
-	pcie_aspm_create_sysfs_dev_files(dev);
 #ifdef CONFIG_PCIEASPM
 	/* update visibility of attributes in this group */
 	sysfs_update_group(&dev->dev.kobj, &aspm_ctrl_attr_group);
@@ -1344,7 +1343,6 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 	return 0;
 
 error:
-	pcie_aspm_remove_sysfs_dev_files(dev);
 	pcie_vpd_remove_sysfs_dev_files(dev);
 	return retval;
 }
@@ -1420,7 +1418,6 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
 {
 	pcie_vpd_remove_sysfs_dev_files(dev);
-	pcie_aspm_remove_sysfs_dev_files(dev);
 	if (dev->reset_fn) {
 		device_remove_file(&dev->dev, &dev_attr_reset);
 		dev->reset_fn = 0;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3908fb23d..9ede6a37a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -532,14 +532,6 @@ static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
 #endif
 
-#ifdef CONFIG_PCIEASPM_DEBUG
-void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
-void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
-#else
-static inline void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev) { }
-static inline void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev) { }
-#endif
-
 #ifdef CONFIG_PCIE_ECRC
 void pcie_set_ecrc_checking(struct pci_dev *dev);
 void pcie_ecrc_get_policy(char *str);
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 362eb8cfa..a2e862d4e 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -79,13 +79,6 @@ config PCIEASPM
 
 	  When in doubt, say Y.
 
-config PCIEASPM_DEBUG
-	bool "Debug PCI Express ASPM"
-	depends on PCIEASPM
-	help
-	  This enables PCI Express ASPM debug support. It will add per-device
-	  interface to control ASPM.
-
 choice
 	prompt "Default ASPM policy"
 	default PCIEASPM_DEFAULT
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 9da4d1432..7a3278011 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1203,111 +1203,6 @@ bool pcie_aspm_enabled(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pcie_aspm_enabled);
 
-#ifdef CONFIG_PCIEASPM_DEBUG
-static ssize_t link_state_show(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct pci_dev *pci_device = to_pci_dev(dev);
-	struct pcie_link_state *link_state = pci_device->link_state;
-
-	return sprintf(buf, "%d\n", link_state->aspm_enabled);
-}
-
-static ssize_t link_state_store(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t n)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct pcie_link_state *link, *root = pdev->link_state->root;
-	u32 state;
-
-	if (aspm_disabled)
-		return -EPERM;
-
-	if (kstrtouint(buf, 10, &state))
-		return -EINVAL;
-	if ((state & ~ASPM_STATE_ALL) != 0)
-		return -EINVAL;
-
-	down_read(&pci_bus_sem);
-	mutex_lock(&aspm_lock);
-	list_for_each_entry(link, &link_list, sibling) {
-		if (link->root != root)
-			continue;
-		pcie_config_aspm_link(link, state);
-	}
-	mutex_unlock(&aspm_lock);
-	up_read(&pci_bus_sem);
-	return n;
-}
-
-static ssize_t clk_ctl_show(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct pci_dev *pci_device = to_pci_dev(dev);
-	struct pcie_link_state *link_state = pci_device->link_state;
-
-	return sprintf(buf, "%d\n", link_state->clkpm_enabled);
-}
-
-static ssize_t clk_ctl_store(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t n)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	bool state;
-
-	if (strtobool(buf, &state))
-		return -EINVAL;
-
-	down_read(&pci_bus_sem);
-	mutex_lock(&aspm_lock);
-	pcie_set_clkpm_nocheck(pdev->link_state, state);
-	mutex_unlock(&aspm_lock);
-	up_read(&pci_bus_sem);
-
-	return n;
-}
-
-static DEVICE_ATTR_RW(link_state);
-static DEVICE_ATTR_RW(clk_ctl);
-
-static char power_group[] = "power";
-void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev)
-{
-	struct pcie_link_state *link_state = pdev->link_state;
-
-	if (!link_state)
-		return;
-
-	if (link_state->aspm_support)
-		sysfs_add_file_to_group(&pdev->dev.kobj,
-			&dev_attr_link_state.attr, power_group);
-	if (link_state->clkpm_capable)
-		sysfs_add_file_to_group(&pdev->dev.kobj,
-			&dev_attr_clk_ctl.attr, power_group);
-}
-
-void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev)
-{
-	struct pcie_link_state *link_state = pdev->link_state;
-
-	if (!link_state)
-		return;
-
-	if (link_state->aspm_support)
-		sysfs_remove_file_from_group(&pdev->dev.kobj,
-			&dev_attr_link_state.attr, power_group);
-	if (link_state->clkpm_capable)
-		sysfs_remove_file_from_group(&pdev->dev.kobj,
-			&dev_attr_clk_ctl.attr, power_group);
-}
-#endif
-
 static struct pcie_link_state *aspm_get_parent_link(struct pci_dev *pdev)
 {
 	struct pci_dev *parent = pdev->bus->self;
-- 
2.23.0


