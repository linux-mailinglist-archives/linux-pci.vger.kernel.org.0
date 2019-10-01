Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0EBFC40EB
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 21:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfJATTO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 15:19:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34040 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfJATTO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Oct 2019 15:19:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so3241533wmc.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Oct 2019 12:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sBpHlPHDs+05No6H7Sh8xOzzLeAhinV3oAGF4G0X5s4=;
        b=H3yXaDvrv6RYvQnReTs+weWw+NAwamv5dQTi35I7RZ55U82Vi6wESpmS14UBLqeaAT
         lqaePmlX4WALJULgYjfmzVTitMFTbaua43iJFjs6RDc1ammNPKcPTqddRJNNnBqG2RJc
         LImK3cpvnWHnR+FWnF4T7OBlDl59nz5Pbt1or062XVef4bz1qV61A4R1jiBZuYRCzDPW
         OlF1EnaUUKYZkVZwuTrTNheYf9FEZEGeue0XNIIelbgeggr5n+Xqkw0Ecxnl9bBknKMg
         YqGNgoiQMS0GMGsjZzHieD9P5y5Q8Ddm9BLT4DMrocoGc1nPjDjt0JYgJvfXNZf7gJJ/
         QNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sBpHlPHDs+05No6H7Sh8xOzzLeAhinV3oAGF4G0X5s4=;
        b=c+fD6xC9l0yJUlKvAsn6ZCo5JLjiwRVCvRiIjxzC3a3gU6crvHx7hhAecAtnsb04DQ
         HFJiEK1nMiFZgee8W2a0yym++uSlnjxQV5vCnrPoeTQlVMZiN6PZb/uAcgAzKfiwB1NR
         AAxt/HMtvb75+VZR+TKmZUR4TeNfYMOgy2YTze+du3T53knIqREc/TZ2Z/WDXZ3lRBhO
         u66TxMRn+dIFFnhyu60EIwwgiT9DXXtFYYS99GvP1RB6dyENXFCDqpLhDRdNtS0GbIHf
         ub+0QW/b0hIUt1EySy7DTWR/0HFxcubdKdMHnMSzjCw8F8UdwmLREb/seATjOqiW+QFT
         M/Sw==
X-Gm-Message-State: APjAAAX3mnFnBlxRYvhSi2u3KgJoh7Ev/F9/vvXLorOMVQ5lOWQxLAs+
        SZu56VIFTqNCmq8BnbUkLKyHfssB
X-Google-Smtp-Source: APXvYqwBu54q1qmbbv+xjJNb4d89DGHiL3V/vBsffpGqXp68sQFAC/gLuUgwzTRaTCbLjcjVN/9idg==
X-Received: by 2002:a1c:5fd6:: with SMTP id t205mr4965183wmb.124.1569957551286;
        Tue, 01 Oct 2019 12:19:11 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f26:6400:ad11:16fb:d8da:de15? (p200300EA8F266400AD1116FBD8DADE15.dip0.t-ipconnect.de. [2003:ea:8f26:6400:ad11:16fb:d8da:de15])
        by smtp.googlemail.com with ESMTPSA id w125sm7634589wmg.32.2019.10.01.12.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 12:19:10 -0700 (PDT)
Subject: [PATCH v6 4/4] PCI/ASPM: Remove Kconfig option PCIEASPM_DEBUG and
 related code
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <0577b966-6290-0685-123d-c675baf97caa@gmail.com>
Message-ID: <3a0eded8-9d36-2fa8-d665-96b1df880be2@gmail.com>
Date:   Tue, 1 Oct 2019 21:18:54 +0200
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
index 58c0b069d..81510eae5 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1214,111 +1214,6 @@ bool pcie_aspm_enabled(struct pci_dev *pdev)
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
 static bool pcie_is_aspm_dev(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link;
-- 
2.23.0


