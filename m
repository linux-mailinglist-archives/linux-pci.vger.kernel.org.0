Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73B859A77D
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2019 08:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404117AbfHWGQS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Aug 2019 02:16:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52380 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404341AbfHWGQR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Aug 2019 02:16:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id o4so7775725wmh.2
        for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2019 23:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+4Bmc0ZpnjfSfSMfniH/rk4kYcHE1WYcpQwbIq12Y6g=;
        b=EKnboRJv9MdawcXhFG61DfD9ZqGRMGGIugOKe904MDdZxf/03/6VNEPB1KIHQYSdYy
         pAbTsRFuRfwcXaB1DzUHGGKfN9QP2bgxMpbBgGzY2mXxalSDQGOHIhZOJIz8Fp6S6KQM
         5S67IAowAI2dOygmw1+ds2wo2z1JtshGDjgLoxg4eunuPL/r50SUducYowyKyQhJAkP/
         DpKZjTYtddfeZWMRzhGRwJlRxYV6EKyCT2qpewMcLUSAGzjT30h+msRl6DipnwxzYm3i
         mMz+uqdRJVBLJSeS0X5k5PQ0pTiks7AmM4B3OWhmbGIttwaPanhxto68EUPOVLRjOFgF
         CAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+4Bmc0ZpnjfSfSMfniH/rk4kYcHE1WYcpQwbIq12Y6g=;
        b=btRbT5mGzrDXJ2lHPVYEqXySmnFsVMfvASQJ4xoJPTOJP9HdKoK/bkYA/BxY7D4QPy
         vl4NGy5k+iGMncVCJ2HxHCScXswAVJGW2jAw9O0iYLrlzohaOiRqpWjIwTwLNX3a4hO8
         ng+HscHUN1puDXy+C3aozP7HmSIHtupJC5KCi2o8SCsVvUw81z0d6mX2XUmINUXTfMda
         57u6ENBamJ1if76T9tHXprbI0DCrkFma/6WznpPBgunEN+ds/yHVWTWS1bxO74medesZ
         0jeQnXPRXGpl1D8AHxGZVYaURsemzNyiUhKNhsHYBIg5UpZtgiDCbMP0ks4JoWwenJJv
         78rg==
X-Gm-Message-State: APjAAAWn+siqqOhWe4YlQmyEDFkTQzS+R9RWVKc2/C2GQFAV1x7agGY7
        tZA0gXJ7mxUWRvzY5PuLMNLy56gk
X-Google-Smtp-Source: APXvYqwE8TZFlr9ue5SlaE709iOAKQQ7dyLymCbIp6jL8t9YGXVQ02yOm7huAwb7VNgvJ/g1pXlpsA==
X-Received: by 2002:a1c:c1cd:: with SMTP id r196mr3129573wmf.127.1566540975502;
        Thu, 22 Aug 2019 23:16:15 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:34d1:4088:cd1d:73a7? (p200300EA8F047C0034D14088CD1D73A7.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:34d1:4088:cd1d:73a7])
        by smtp.googlemail.com with ESMTPSA id f24sm1584058wmc.25.2019.08.22.23.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 23:16:15 -0700 (PDT)
Subject: [PATCH v3 4/4] PCI/ASPM: remove Kconfig option PCIEASPM_DEBUG and
 related code
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <9e5ef666-1ef9-709a-cd7a-ca43eeb9e4a4@gmail.com>
Message-ID: <5f705952-5a4c-579b-d059-98ff36f62261@gmail.com>
Date:   Fri, 23 Aug 2019 08:15:54 +0200
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
index 0d54cd7c7..8c13a152f 100644
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


