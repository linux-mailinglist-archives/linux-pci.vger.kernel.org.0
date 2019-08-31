Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9AFA462B
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2019 22:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfHaUVR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 31 Aug 2019 16:21:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39628 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfHaUVR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Aug 2019 16:21:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so10171100wra.6
        for <linux-pci@vger.kernel.org>; Sat, 31 Aug 2019 13:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IJgntNFMeDEKUhV8HXAMOPKHkJCV2oBkuZRizPy8vqE=;
        b=SEwkT8bGqEmZ9l2EGDINOqeLjsCQAeHTiJAE/TLVWEugbD4PfvgXWmbQSNp9Uqon1t
         xroe28oMPcijcNfuq64S5bsj7tPjQ3/rdh572PPUIfqxlXUbopow+zs6NJ5xjhWwqqm2
         sXjv3hqF05uF8/YYlzsLDpWqsf6E6PEjb/VgsoV2/FVP25aFPtrKwRG3RZdOQZFKXuSD
         YfBDoc5czuDmQDXA0j7F04Xof8NngVUZJPmR7VY+13FFCH4bKs1hoGP1ui2JgwRmGKAX
         QTWO2mXRiHVSnmQRaKbEyZEvRnPeHp0+YYUqeVAvIV/ZjkJB3tClnIvzWmPGD8VIFN9Z
         G9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IJgntNFMeDEKUhV8HXAMOPKHkJCV2oBkuZRizPy8vqE=;
        b=Obxj/LLsbtlTANo0HxfrppgFllE7qAF5GVRqhbBRW+jQvnxjukXMOBzTkKkg2DMERL
         tb7GqM9yRuwtl49s+6xjmOxz0awwwhNXu0eqMOqMq8w4YKtTn5juV2oCNtNygvrDaMyE
         BMOk0olSZykCjwKRbszCkQSW2Vz6TDoH7cBArvw9pdyPOHJPtXTxwjOCqLeX7iv/c9cj
         4BXq/uT4hOm79pNZ1pmtSo61ZUnuhdo+GRgugHtBLe1e2xCKiuupf3epC+uIdL/lbtWT
         guDrz1zgAhDk+YKkrJJFUidGVLeuOfeH8jCW7Bq9YDxHQivwxTyhqVpv3k6LCBJ/kcc6
         c6Ag==
X-Gm-Message-State: APjAAAVK5bNIVUSBnnc77PQYIsZASB96gDJGlhFWAIGsQ73F329oiKOT
        8mgqcIz3NFpqxL/j/mD1IAghRhXc
X-Google-Smtp-Source: APXvYqzSEkm6Jk4/nD2YVD2Bqqw0IWayyqyGDdIlqpHojD7YvxyeYH0O7w781xkP1SVyOA6HWHGdOA==
X-Received: by 2002:adf:9050:: with SMTP id h74mr26189051wrh.191.1567282874500;
        Sat, 31 Aug 2019 13:21:14 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:9586:e556:3a4d:c04? (p200300EA8F047C009586E5563A4D0C04.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:9586:e556:3a4d:c04])
        by smtp.googlemail.com with ESMTPSA id j20sm18462361wre.65.2019.08.31.13.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2019 13:21:13 -0700 (PDT)
Subject: [PATCH v5 4/4] PCI/ASPM: remove Kconfig option PCIEASPM_DEBUG and
 related code
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <c63f507f-7f52-7164-dbc5-07fc18e433b8@gmail.com>
Message-ID: <4096ba95-b132-fc0d-8516-85352e87d82a@gmail.com>
Date:   Sat, 31 Aug 2019 22:18:28 +0200
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

Now that we have sysfs attributes for enabling/disabling the individual
ASPM link states, this debug code isn't needed any longer.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v5:
- rebased to latest pci/next
---
 drivers/pci/pci-sysfs.c  |   3 --
 drivers/pci/pci.h        |   8 ---
 drivers/pci/pcie/Kconfig |   7 ---
 drivers/pci/pcie/aspm.c  | 105 ---------------------------------------
 4 files changed, 123 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 687240f55..acba3aff0 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1314,7 +1314,6 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 	int retval;
 
 	pcie_vpd_create_sysfs_dev_files(dev);
-	pcie_aspm_create_sysfs_dev_files(dev);
 #ifdef CONFIG_PCIEASPM
 	/* update visibility of attributes in this group */
 	sysfs_update_group(&dev->dev.kobj, &aspm_ctrl_attr_group);
@@ -1328,7 +1327,6 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 	return 0;
 
 error:
-	pcie_aspm_remove_sysfs_dev_files(dev);
 	pcie_vpd_remove_sysfs_dev_files(dev);
 	return retval;
 }
@@ -1404,7 +1402,6 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
 {
 	pcie_vpd_remove_sysfs_dev_files(dev);
-	pcie_aspm_remove_sysfs_dev_files(dev);
 	if (dev->reset_fn) {
 		device_remove_file(&dev->dev, &dev_attr_reset);
 		dev->reset_fn = 0;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9dc3e3673..b3d3da257 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -533,14 +533,6 @@ static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
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
index ce3425125..67a142251 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1182,111 +1182,6 @@ static int pcie_aspm_get_policy(char *buffer, const struct kernel_param *kp)
 module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
 	NULL, 0644);
 
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


