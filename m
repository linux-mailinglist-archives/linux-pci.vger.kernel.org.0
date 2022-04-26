Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E896650ED30
	for <lists+linux-pci@lfdr.de>; Tue, 26 Apr 2022 02:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239243AbiDZAJ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Apr 2022 20:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiDZAJx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Apr 2022 20:09:53 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3747F1132F1
        for <linux-pci@vger.kernel.org>; Mon, 25 Apr 2022 17:06:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f7ee6bc6ddso33685367b3.1
        for <linux-pci@vger.kernel.org>; Mon, 25 Apr 2022 17:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cwrp6c+6yQjWeAanWYwByt5L1qXZBmxvZVLudkp+yA4=;
        b=CkWTK3FrWc7tiCvZVSVqy6H/mwmZlC8sMUfaNDSuR6ISQOldgWdGVYbR1X4sNYj2mz
         2Y3KuX4BO6mLGtKlfEdITWx39bq14Si3HJe+jKzCi20hxRbLLk49SMJ8H2HMgsWoigJA
         qNZ1JSl8F2bidHDj3HqNM+tlZVOryeCag4Qq9IjvORre9b5ZJVoiAg2BzzMhsiC3xoHU
         ERK+3fCGyA242r9DuSIcFZMkorIH7Kgn1Xw8VILHCSs3NEPFjTAYlbC7pn3g5NCR+RIt
         Ies+chN6RzkmTpzuvOlHu2ubyDLd0PTGNDECDBN82f1nngyfp2VeVo/M2jyTIY88qSYF
         w9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cwrp6c+6yQjWeAanWYwByt5L1qXZBmxvZVLudkp+yA4=;
        b=rkUnHS/cZtLQPtPDsLmb6WKo9PKEz3S4fayyKd1qs2T/wAqA1NTclaSrRlv4I+KVij
         IthwenYnqwifL7t8sxhSUr7VuFyO0cmBj9wSq4RQmiiEDDMvs2WmX0sL5tRcFpum11w/
         GzspDGmrpBvqgkQ+ARi9E+zysnnpV6RiWAsbnhJQZ5QZIML2isaA/5NotH5gFGTTRcmq
         FrRXL2YSm9f9WunzTeK7jOvK+mXoeyQ93MK7W3nqJzaUKb0Ix7vKte439oN3NKBSQ1zm
         VMRLe4uFr5hjKiDlApPL1iZRlVGTGAF/Z+QB0KlgjzJ0VhB19Lmym6/Mhq8NriOWDSGl
         Dqsw==
X-Gm-Message-State: AOAM533tckc7cZ5wmrm5SJLuOFnsKfrEc3NSw1XQAR6v+rh37tXQOIN/
        yWjx7+2zrwQV9mF/C1beE4wI9uEf25bj
X-Google-Smtp-Source: ABdhPJyFE+J9te+rMsUNH2mbMwZ+bBPuUAixlAHALiAHUjzOMrupX/5Js7LMsK5uQMClp7LDWcmxL3otROjH
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:9590:6ed7:be38:9068])
 (user=rajatja job=sendgmr) by 2002:a25:508e:0:b0:648:3cc1:76b5 with SMTP id
 e136-20020a25508e000000b006483cc176b5mr11271557ybb.286.1650931606469; Mon, 25
 Apr 2022 17:06:46 -0700 (PDT)
Date:   Mon, 25 Apr 2022 17:06:40 -0700
In-Reply-To: <20220426000640.3581446-1-rajatja@google.com>
Message-Id: <20220426000640.3581446-2-rajatja@google.com>
Mime-Version: 1.0
References: <20220426000640.3581446-1-rajatja@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v6 2/2] PCI: Rename pci_dev->untrusted to pci_dev->untrusted_dma
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
Cc:     Rajat Jain <rajatja@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
v6: No change in this patch, rebased on top of changes in other patch.
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
index 09f6e1c0f9c0..aeee4be7614d 100644
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
index df5c62ecf942..b88f47391140 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4843,7 +4843,7 @@ static bool intel_iommu_is_attach_deferred(struct device *dev)
  */
 static bool risky_device(struct pci_dev *pdev)
 {
-	if (pdev->untrusted) {
+	if (pdev->untrusted_dma) {
 		pci_info(pdev,
 			 "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted PCI link\n",
 			 pdev->vendor, pdev->device);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f2c45b85b9fc..d8d3133e2947 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1525,7 +1525,7 @@ static int iommu_get_def_domain_type(struct device *dev)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
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
index d7c6ba48486f..7c2784e7e954 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1395,7 +1395,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
 	pci_acpi_set_external_facing(pci_dev);
-	pci_dev->untrusted |= pci_dev_has_dma_property(pci_dev);
+	pci_dev->untrusted_dma |= pci_dev_has_dma_property(pci_dev);
 	pci_acpi_add_edr_notifier(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
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
index 41aeaa235132..583d35968413 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5135,7 +5135,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_CR);
 	ctrl |= (cap & PCI_ACS_UF);
 
-	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
+	if (pci_ats_disabled() || dev->external_facing || dev->untrusted_dma)
 		ctrl |= (cap & PCI_ACS_TB);
 
 	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60adf42460ab..2453a794bdb2 100644
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
2.36.0.rc2.479.g8af0fa9b8e-goog

