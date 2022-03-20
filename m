Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D244E1A63
	for <lists+linux-pci@lfdr.de>; Sun, 20 Mar 2022 07:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244805AbiCTGag (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Mar 2022 02:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiCTGaf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Mar 2022 02:30:35 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2B9F1E93
        for <linux-pci@vger.kernel.org>; Sat, 19 Mar 2022 23:29:13 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 9-20020a630509000000b0037c8607d296so5665302pgf.22
        for <linux-pci@vger.kernel.org>; Sat, 19 Mar 2022 23:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pTQSsxIlkBPo9ol3laqZr6EZUg9HnSuNMLdKC6CgJnI=;
        b=MjNuB7pQS36FRtkr5V5HQ/WRzAJjTJaNZlyef+Fh+n7LjwkvvVKkNX/Q6J5fpZVk09
         ZYkvHFhKV7oqaOkZaWEcqIpM/1tOx/M89KLU5fnfXHD8PzEJelNL8HKtf7CVJ06sUI/m
         InDJ/fsiY9s0Xrek4JiYDin4KNtXw07MSlbJNZxH+jH1enMe89LrnSXepc5iDZtznFKo
         O8YMDy2qTgmf/DXxwpMJIGNRitrksR0aXIimCha31KOmsxQ3pT/8xd/dZl/2UaIg+lmH
         9a+zp5ALPKY6YdmelTztpLT8DZD8vSp+wExnojjxWd5Ivoy13ymarFu4zVEVZgTX3PJz
         QlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pTQSsxIlkBPo9ol3laqZr6EZUg9HnSuNMLdKC6CgJnI=;
        b=DgsvJk7Ri5Uw5OP1wQzC3Ew3TFI11KLadTzJFMKmlT8/ZUd49PcgtZNP0XTF056kOd
         28oaQ7P+8C2/npS76pS+kaSfi/gtwWvEwRQR09RGlUfOhMs9pnrZk+dGsLO9RtTg3JWD
         joy0C+nh2etkatBWDNhu2jG6+7RoUBK9U15fHgjiRbzmUkaUwz1MFxHwKblxV5kTFpDE
         oqhHChRdxIgc0ziucnwhnkIYabwR96SCfadrfmBfR1K/Qm20O23RfPmUJKwK7xaks4sb
         qNz/LAwZRzQr+HHqFlSfcGBv2O7dul21K7KrAOn6B8tdl84VmxPuvwClxL3AvTc7p262
         etaA==
X-Gm-Message-State: AOAM5322IiqIU95TI84GiT10oIo3oJ7tDbXC8blmsKDbPTEnjP5WqC9h
        BHdynSlz9fn0L9YKeeK7t+fcnkVvF0Ox
X-Google-Smtp-Source: ABdhPJzEfILg58BTVYLAkOhB8WANcXb+O7vPEIE1o+0VN5WQQxPW2P8F1TlwBt2OfMQyCAK7fRD4vg20Jmji
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:5445:bc31:4f4a:d610])
 (user=rajatja job=sendgmr) by 2002:a17:90a:8b91:b0:1be:db25:eecd with SMTP id
 z17-20020a17090a8b9100b001bedb25eecdmr19986137pjn.10.1647757752500; Sat, 19
 Mar 2022 23:29:12 -0700 (PDT)
Date:   Sat, 19 Mar 2022 23:29:05 -0700
Message-Id: <20220320062907.3272903-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v4 1/2] PCI: Rename "pci_dev->untrusted" to "pci_dev->poses_dma_risk"
From:   Rajat Jain <rajatja@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename the field to make it more clear, that the device can execute DMA
attacks on the system, and thus the system may need protection from
such attacks from this device.

No functional change intended.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v4: Initial version, created based on comments on other patch


 drivers/iommu/dma-iommu.c   | 6 +++---
 drivers/iommu/intel/iommu.c | 2 +-
 drivers/iommu/iommu.c       | 2 +-
 drivers/pci/ats.c           | 2 +-
 drivers/pci/pci.c           | 2 +-
 drivers/pci/probe.c         | 8 ++++----
 drivers/pci/quirks.c        | 2 +-
 include/linux/pci.h         | 5 +++--
 8 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d85d54f2b549..ce10bfa86cf7 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -497,14 +497,14 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	return ret;
 }
 
-static bool dev_is_untrusted(struct device *dev)
+static bool dev_poses_dma_risk(struct device *dev)
 {
-	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
+	return dev_is_pci(dev) && to_pci_dev(dev)->poses_dma_risk;
 }
 
 static bool dev_use_swiotlb(struct device *dev)
 {
-	return IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev);
+	return IS_ENABLED(CONFIG_SWIOTLB) && dev_poses_dma_risk(dev);
 }
 
 /**
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 92fea3fbbb11..2e963a153c71 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5570,7 +5570,7 @@ intel_iommu_enable_nesting(struct iommu_domain *domain)
  */
 static bool risky_device(struct pci_dev *pdev)
 {
-	if (pdev->untrusted) {
+	if (pdev->poses_dma_risk) {
 		pci_info(pdev,
 			 "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted PCI link\n",
 			 pdev->vendor, pdev->device);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8b86406b7162..81433aab0245 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1522,7 +1522,7 @@ static int iommu_get_def_domain_type(struct device *dev)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 
-	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
+	if (dev_is_pci(dev) && to_pci_dev(dev)->poses_dma_risk)
 		return IOMMU_DOMAIN_DMA;
 
 	if (ops->def_domain_type)
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index c967ad6e2626..6390fbeaaa02 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -42,7 +42,7 @@ bool pci_ats_supported(struct pci_dev *dev)
 	if (!dev->ats_cap)
 		return false;
 
-	return (dev->untrusted == 0);
+	return (dev->poses_dma_risk == 0);
 }
 EXPORT_SYMBOL_GPL(pci_ats_supported);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9ecce435fb3f..526d26f2011b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -958,7 +958,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_UF);
 
 	/* Enable Translation Blocking for external devices and noats */
-	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
+	if (pci_ats_disabled() || dev->external_facing || dev->poses_dma_risk)
 		ctrl |= (cap & PCI_ACS_TB);
 
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 17a969942d37..7ae1ed312c47 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1587,7 +1587,7 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
 		dev->is_thunderbolt = 1;
 }
 
-static void set_pcie_untrusted(struct pci_dev *dev)
+static void pci_check_if_dev_poses_dma_risk(struct pci_dev *dev)
 {
 	struct pci_dev *parent;
 
@@ -1596,8 +1596,8 @@ static void set_pcie_untrusted(struct pci_dev *dev)
 	 * untrusted as well.
 	 */
 	parent = pci_upstream_bridge(dev);
-	if (parent && (parent->untrusted || parent->external_facing))
-		dev->untrusted = true;
+	if (parent && (parent->poses_dma_risk || parent->external_facing))
+		dev->poses_dma_risk = true;
 }
 
 static void pci_set_removable(struct pci_dev *dev)
@@ -1862,7 +1862,7 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Need to have dev->cfg_size ready */
 	set_pcie_thunderbolt(dev);
 
-	set_pcie_untrusted(dev);
+	pci_check_if_dev_poses_dma_risk(dev);
 
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d2dd6a6cda60..5c601c6c30bf 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5122,7 +5122,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_CR);
 	ctrl |= (cap & PCI_ACS_UF);
 
-	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
+	if (pci_ats_disabled() || dev->external_facing || dev->poses_dma_risk)
 		ctrl |= (cap & PCI_ACS_TB);
 
 	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 678fecdf6b81..75547fd5587c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -444,13 +444,14 @@ struct pci_dev {
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
 	/*
-	 * Devices marked being untrusted are the ones that can potentially
+	 * Devices marked with "poses_dma_risk" can potentially
 	 * execute DMA attacks and similar. They are typically connected
 	 * through external ports such as Thunderbolt but not limited to
 	 * that. When an IOMMU is enabled they should be getting full
 	 * mappings to make sure they cannot access arbitrary memory.
 	 */
-	unsigned int	untrusted:1;
+	unsigned int	poses_dma_risk:1;
+
 	/*
 	 * Info from the platform, e.g., ACPI or device tree, may mark a
 	 * device as "external-facing".  An external-facing device is
-- 
2.35.1.894.gb6a874cedc-goog

