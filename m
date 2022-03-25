Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997594E7BAF
	for <lists+linux-pci@lfdr.de>; Sat, 26 Mar 2022 01:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiCYTZn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Mar 2022 15:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCYTZm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Mar 2022 15:25:42 -0400
Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE1C3E394C
        for <linux-pci@vger.kernel.org>; Fri, 25 Mar 2022 11:57:56 -0700 (PDT)
Received: by mail-vs1-f74.google.com with SMTP id m63-20020a677142000000b002fd633f4b85so1892075vsc.9
        for <linux-pci@vger.kernel.org>; Fri, 25 Mar 2022 11:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ls9it47eZWinX53APMUqdqAduomURMCMA1XbEoHFGsQ=;
        b=jf7zMllek1mo+Nas3aa4rEhx43ZQ1waGsvpYfvNgwEiwCCAWoS9SZnLaJXQkmWB2M+
         6ADBWCg++Y/FrbEy+5C39/gGLqcx4snlS9RYWJ/YGs3g5cvd3LI37DJwtxQaZrgvfsIK
         DvPSTDXUlEcNrYFmc342Iei4ddki3i5mmID22YQNV1R2nOMGPMCxIwsMy8+VCjmW1WoK
         11vn7pIxU1GZdIUQWGjR0RiLjnaMUHdJLeEZDc7rkurcAaVlTDWLpuwtdaO89njTL0TV
         nAzkGxoPuCWzeOpRkJsR2dSBMbJCs3QsocLwAqkbEAcMh1p1+uXBZocYUtA08DLgKHTg
         Y5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ls9it47eZWinX53APMUqdqAduomURMCMA1XbEoHFGsQ=;
        b=Z2XTgGhzxaomoQ2WyNznePWxWGTu5MIS1o8n2SnNaLUB2/V/q/B/anFVMHpyiYoU8l
         VK7Y5URaJ+qEwH+ojFNecxzKfKXfrkBKRBZ+inQdd40g8YtzcCh0iBHigq9muCgMXxyu
         vBzSGMRiAkQntUHoPxuuLSp8Qf3fI0aOZFMd+wpT60jJq3ShI7T93QIYMtXiEumRzcsa
         I5vrqwrwkyMqZeGh71jjtHUMiz8+QJc7J+pSl6P/zqaomVPqUWJhMC7HyHYtfeCb6kJL
         lYcq5PURlwOjZ9nIVwUIXnbzVscJt1ON7Pi1Xmn/KYWh7F4GDnCqi40CNpTLYqMi9MNd
         4D+g==
X-Gm-Message-State: AOAM533CfUiy1sMFZRVcy1T4eQQHA5YCwDGidZFw4AsQD8vvDgrbnuhX
        +DNYaHWyLbh+bA53BH42ReF44h+o1yeN
X-Google-Smtp-Source: ABdhPJz4caM2/r37eNH0kp8MNsyvhq+I0iaYEcSsuTjltPrYwKcYHAUtmqHXJObuMsBQf4dmQ6rBvqb9FmsD
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:4cfc:6eaf:38d8:46d6])
 (user=rajatja job=sendgmr) by 2002:a81:36cf:0:b0:2e5:2597:a026 with SMTP id
 d198-20020a8136cf000000b002e52597a026mr12243252ywa.301.1648233976396; Fri, 25
 Mar 2022 11:46:16 -0700 (PDT)
Date:   Fri, 25 Mar 2022 11:46:09 -0700
In-Reply-To: <20220325184609.4059963-1-rajatja@google.com>
Message-Id: <20220325184609.4059963-2-rajatja@google.com>
Mime-Version: 1.0
References: <20220325184609.4059963-1-rajatja@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v5 2/2] PCI: Rename pci_dev->untrusted to pci_dev->untrusted_dma
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
v5: Use "untrusted_dma" as property name, based on feedback.
    Reorder the patches in the series.
v4: Initial version, created based on comments on other patch

 drivers/iommu/dma-iommu.c   | 6 +++---
 drivers/iommu/intel/iommu.c | 2 +-
 drivers/iommu/iommu.c       | 2 +-
 drivers/pci/ats.c           | 2 +-
 drivers/pci/pci-acpi.c      | 2 +-
 drivers/pci/pci.c           | 2 +-
 drivers/pci/probe.c         | 8 ++++----
 drivers/pci/quirks.c        | 2 +-
 include/linux/pci.h         | 5 +++--
 9 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d85d54f2b549..7cbe300fe907 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -497,14 +497,14 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	return ret;
 }
 
-static bool dev_is_untrusted(struct device *dev)
+static bool dev_has_untrusted_dma(struct device *dev)
 {
-	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
+	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted_dma;
 }
 
 static bool dev_use_swiotlb(struct device *dev)
 {
-	return IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev);
+	return IS_ENABLED(CONFIG_SWIOTLB) && dev_has_untrusted_dma(dev);
 }
 
 /**
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 92fea3fbbb11..9246b7c9ab46 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5570,7 +5570,7 @@ intel_iommu_enable_nesting(struct iommu_domain *domain)
  */
 static bool risky_device(struct pci_dev *pdev)
 {
-	if (pdev->untrusted) {
+	if (pdev->untrusted_dma) {
 		pci_info(pdev,
 			 "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted PCI link\n",
 			 pdev->vendor, pdev->device);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8b86406b7162..79fb66af2e68 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1522,7 +1522,7 @@ static int iommu_get_def_domain_type(struct device *dev)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 
-	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
+	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted_dma)
 		return IOMMU_DOMAIN_DMA;
 
 	if (ops->def_domain_type)
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index c967ad6e2626..477c16ba9341 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -42,7 +42,7 @@ bool pci_ats_supported(struct pci_dev *dev)
 	if (!dev->ats_cap)
 		return false;
 
-	return (dev->untrusted == 0);
+	return (dev->untrusted_dma == 0);
 }
 EXPORT_SYMBOL_GPL(pci_ats_supported);
 
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 378e05096c52..1d5a284c3661 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1362,7 +1362,7 @@ static void pci_acpi_check_for_dma_protection(struct pci_dev *dev)
 		return;
 
 	if (val)
-		dev->untrusted = 1;
+		dev->untrusted_dma = 1;
 }
 
 void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9ecce435fb3f..1fb0eb8646c8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -958,7 +958,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_UF);
 
 	/* Enable Translation Blocking for external devices and noats */
-	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
+	if (pci_ats_disabled() || dev->external_facing || dev->untrusted_dma)
 		ctrl |= (cap & PCI_ACS_TB);
 
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 17a969942d37..d2a9b26fcede 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1587,7 +1587,7 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
 		dev->is_thunderbolt = 1;
 }
 
-static void set_pcie_untrusted(struct pci_dev *dev)
+static void pci_set_untrusted_dma(struct pci_dev *dev)
 {
 	struct pci_dev *parent;
 
@@ -1596,8 +1596,8 @@ static void set_pcie_untrusted(struct pci_dev *dev)
 	 * untrusted as well.
 	 */
 	parent = pci_upstream_bridge(dev);
-	if (parent && (parent->untrusted || parent->external_facing))
-		dev->untrusted = true;
+	if (parent && (parent->untrusted_dma || parent->external_facing))
+		dev->untrusted_dma = true;
 }
 
 static void pci_set_removable(struct pci_dev *dev)
@@ -1862,7 +1862,7 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Need to have dev->cfg_size ready */
 	set_pcie_thunderbolt(dev);
 
-	set_pcie_untrusted(dev);
+	pci_set_untrusted_dma(dev);
 
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 5f46fed01e6c..7ca3c2cdfb20 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5134,7 +5134,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_CR);
 	ctrl |= (cap & PCI_ACS_UF);
 
-	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
+	if (pci_ats_disabled() || dev->external_facing || dev->untrusted_dma)
 		ctrl |= (cap & PCI_ACS_TB);
 
 	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 678fecdf6b81..b7c5fede0b93 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -444,13 +444,14 @@ struct pci_dev {
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
 	/*
-	 * Devices marked being untrusted are the ones that can potentially
+	 * Devices marked with untrusted_dma are the ones that can potentially
 	 * execute DMA attacks and similar. They are typically connected
 	 * through external ports such as Thunderbolt but not limited to
 	 * that. When an IOMMU is enabled they should be getting full
 	 * mappings to make sure they cannot access arbitrary memory.
 	 */
-	unsigned int	untrusted:1;
+	unsigned int	untrusted_dma:1;
+
 	/*
 	 * Info from the platform, e.g., ACPI or device tree, may mark a
 	 * device as "external-facing".  An external-facing device is
-- 
2.35.1.1021.g381101b075-goog

