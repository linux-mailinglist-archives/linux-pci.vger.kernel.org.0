Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 393B5CC9CF
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2019 14:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfJEMJr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Oct 2019 08:09:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50358 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfJEMJr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Oct 2019 08:09:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id 5so8224958wmg.0
        for <linux-pci@vger.kernel.org>; Sat, 05 Oct 2019 05:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fPOwJXP7eu2TBWO+OVyu9GToqz4RTMNIKoPIeY2boJ8=;
        b=WX1ams1farKQxkx27ruJ0SG7V21a328YgNx3d0y9B+EhR2WNCfOHxmIYiwGs+czRKv
         wqfRoKXxfntrPFhsMt/lY2pjGbL2PGvVGdItaLPpEx+omwBM8RqWz8/MbHxFTXdyX+vc
         ANVYVvI8UbtsG5JPZc5/cDZqSJ0X7LrkLzMjjd31x0F4AiTfT54Zsezr/xvqAPWPWE8R
         Yo8wJXAMPVE+W/Oxcs6ADxckihNe+oFoiVzw6SscTxRSuBMhUUolRHwtxdeCXHT9CHsg
         lo+5wWY6YuTDU9PJalsMLNReoYhICCAhQ5O0ZfRw+2K3Z2CO0ztA3dxfC9CWIc0miwhe
         SW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fPOwJXP7eu2TBWO+OVyu9GToqz4RTMNIKoPIeY2boJ8=;
        b=KbX2RhQ2MKIPFQ98qexHE8aclR/lYbqxk46nTKnG40jSVlNzydQ3Fufaz/LzHC6DJn
         9FB5UNtoyQhbAtwIX8JeSQnzKt8RTBNBPGPbKn0gMWH+VusJkTbpHReAxGWP9syDfWrz
         M3qNdXj2SMPgaMf/9JFptI6h6EdDkftti7ubd8JqYJakWzrAwIIgRgUb0I11RLRo40Tz
         E30DxXsYKqMtZHQ1GfgEO2HCbbd7VLShGRfDjx/XFWKLc22E+zw3Qja8kfbAAVj8S6q9
         pa59NOazFKmeaNljU8NJ2QBliyRGsDpZB0VWf50+21PdXrOITqnjlxm3JdYd1GJFU5Ad
         XX+w==
X-Gm-Message-State: APjAAAWthbvIDjvtN54yHxKUISZzndPg+xDIhv5lMcrm0TrcApEd8EP1
        zBo/L1HsdbCgn3homXFdE7J6zCWX
X-Google-Smtp-Source: APXvYqzWDf0RZ7HYnWgRb/uBPs8Z+gu4ufbCtSEZg8rlOR5axnVcGM6gxFda8rAVNVhAIM0Vp+AshA==
X-Received: by 2002:a05:600c:141:: with SMTP id w1mr14086691wmm.75.1570277384470;
        Sat, 05 Oct 2019 05:09:44 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f26:6400:78ef:16af:4ef6:6109? (p200300EA8F26640078EF16AF4EF66109.dip0.t-ipconnect.de. [2003:ea:8f26:6400:78ef:16af:4ef6:6109])
        by smtp.googlemail.com with ESMTPSA id n8sm12898684wma.7.2019.10.05.05.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Oct 2019 05:09:44 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v7 5/5] PCI/ASPM: Remove Kconfig option PCIEASPM_DEBUG and
 related code
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <e1c28e25-df18-16e1-3e9f-933f613ea858@gmail.com>
Message-ID: <ec935d8e-c084-3938-f1d1-748617596b25@gmail.com>
Date:   Sat, 5 Oct 2019 14:08:52 +0200
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

Now that we have sysfs attributes for enabling/disabling the individual
ASPM link states, this debug code isn't needed any longer. Removing this
debug code has been discussed for quite some time, see e.g. [0].

[0] https://lore.kernel.org/lkml/20180727202619.GD173328@bhelgaas-glaptop.roam.corp.google.com/

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v6:
- add discussion link to commit message
---
 drivers/pci/pci-sysfs.c  |   3 --
 drivers/pci/pci.h        |   8 ---
 drivers/pci/pcie/Kconfig |   7 ---
 drivers/pci/pcie/aspm.c  | 105 ---------------------------------------
 4 files changed, 123 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 0e76c02e0..92bf1b1ce 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1330,7 +1330,6 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 	int retval;
 
 	pcie_vpd_create_sysfs_dev_files(dev);
-	pcie_aspm_create_sysfs_dev_files(dev);
 
 	if (dev->reset_fn) {
 		retval = device_create_file(&dev->dev, &dev_attr_reset);
@@ -1340,7 +1339,6 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 	return 0;
 
 error:
-	pcie_aspm_remove_sysfs_dev_files(dev);
 	pcie_vpd_remove_sysfs_dev_files(dev);
 	return retval;
 }
@@ -1416,7 +1414,6 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
 {
 	pcie_vpd_remove_sysfs_dev_files(dev);
-	pcie_aspm_remove_sysfs_dev_files(dev);
 	if (dev->reset_fn) {
 		device_remove_file(&dev->dev, &dev_attr_reset);
 		dev->reset_fn = 0;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b2cd21e8c..ae231e3cd 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -541,14 +541,6 @@ static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
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
index 05ea02abf..896299a6b 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1221,111 +1221,6 @@ bool pcie_aspm_enabled(struct pci_dev *pdev)
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
 static ssize_t aspm_attr_show_common(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf, u8 state)
-- 
2.23.0


