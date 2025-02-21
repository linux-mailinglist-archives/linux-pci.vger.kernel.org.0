Return-Path: <linux-pci+bounces-21941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9795FA3E90F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 01:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C880F19C45BA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 00:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591A32AF19;
	Fri, 21 Feb 2025 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3VVnl1Ck"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518DFA94A
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 00:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740096599; cv=none; b=QehtmBoZx7ZcL9MFvCubE3lMWG25tChtuyhSESrqFyBS54MTGez37RKE6aKpycosfqie8AGdJ4LxaYagIxK6Ji4iufmZc3zLFwN+4N7GOvcZ4q3f3IR2URnnSjr150dAMTbYAFNxmjVXzgHRfhGGPBeMhRsxh2VKQjr+zji6j14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740096599; c=relaxed/simple;
	bh=H7CLOd9P+cV/oFgoj3tgRPPREFdkNw9G3hPEXFK/08U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bN9Sb8BJLX2FZQAOdB1X6U5z0FvOYjFPl0sKpyVN6dS8kKEbbrguKOJdJ8Edf6w/lIjgK1FtkFUolGiJSlOzHQ9I39ZJfiC01rUByXmJZjuKcoPWEijDRPZ9EzL6aHejPivoIqJQ6Y6FHpbhWyCXKZl+Uu7BhYNwR24//NNsC1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jperaza.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3VVnl1Ck; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jperaza.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2217a4bfcc7so33438775ad.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 16:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740096595; x=1740701395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ojWXvAKQJT0srmKWjICWy4oxy7knsPFva3rdHV3YZs=;
        b=3VVnl1Ckv/s43vk8r0nymFqPKwdgOVKTDaxE9hC1vEP4ECsh05jg46tV2okfx8YIR5
         u7+JObf5vY0auIi8hJk25nDdVge3E9xbv8A/aodsJMpbDa7EQ7LLrwUBbXa5gHUBotpb
         1AqarAwUa5Z2Icf1Y8OUB0Obc7u97v/TfGApLU3SbQLIN7whKrSSylbuGuBz2Ck3YeoE
         kD1x5M4Un6E68SC/F736kWyQEW+tMMi57m5Ns7Uzds8FytY1nsiqUalh8L60jAMMnG5Q
         YVNUwC5c1TO+S9sPMXwDILKTEMYGJGUFMX92lw9NQvT0ZXblFJcLBdYCM7o5l0J/7C5w
         uuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740096595; x=1740701395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ojWXvAKQJT0srmKWjICWy4oxy7knsPFva3rdHV3YZs=;
        b=g1D/NA3xRL5a0n+iA1s1FBCNRddMwcOp2Ims8YwIEfioqFcJCqIRdVcl3x+kCU1YeQ
         XkwbaFrz5fsHh/3N5nuJ0A585yRNWIqLH6yWaBgx+HWnboH0a+vceJB7JJ9vIjlXxZgY
         L9KyyvIrTO+xApX+Rh0r4/4ARWsEvlFLSYWD5Foz3xeCcetY1xS2whgU6mGJzMFv4VSe
         j70rgELBa9DfxQe2uMc1e2sALBtpvbgigH3H3Rsg6n2Tih+ViIqeH74Jyd2RRHV3gP20
         Kpl4BG7zb+2P76szewEGFS2wNXTqNghMBgeLTigKnByEPcsrjA8EDhaU8BfXMt0nuK9f
         V/rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxtiJFEusGyFMTBxemuY7YIauCSRP6Gl7nl9h0GdzaixRrdcjR7yZd3vBAd6P1GHW7XDSWOjlWqY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNXjFOhZVeIf60pVz2K/7YNYQ4ocB6YRRqak6qaYjOjqUR9kyH
	MqZ6TLZImbdUbmdkllj/N6Nr9+5FGztCBCU04Ze96rFOybjhKCSG2+YC4TpcMjbzCGPWEzv9FeT
	2T94lGw==
X-Google-Smtp-Source: AGHT+IFsbK8JX5UC/bd9sWEP1iulp/l4yrsIlmlO1K6xo+gQF7gsx8ybGU6y0Y51naFRD6Cski0eRbH/AaWZ
X-Received: from pjd13.prod.google.com ([2002:a17:90b:54cd:b0:2fc:d77:541])
 (user=jperaza job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d502:b0:220:f509:686a
 with SMTP id d9443c01a7336-221a10f1e97mr10895095ad.29.1740096595604; Thu, 20
 Feb 2025 16:09:55 -0800 (PST)
Date: Fri, 21 Feb 2025 00:09:41 +0000
In-Reply-To: <20250221000943.973221-1-jperaza@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250221000943.973221-1-jperaza@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250221000943.973221-3-jperaza@google.com>
Subject: [v9 PATCH 2/2] PCI: Rename pci_dev->untrusted to pci_dev->requires_dma_protection
From: Joshua Peraza <jperaza@google.com>
To: gregkh@linuxfoundation.org
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, dtor@google.com, 
	dwmw2@infradead.org, helgaas@kernel.org, iommu@lists.linux-foundation.org, 
	jean-philippe@linaro.org, joro@8bytes.org, jperaza@google.com, 
	jsbarnes@google.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	mika.westerberg@linux.intel.com, oohall@gmail.com, pavel@denx.de, 
	rafael.j.wysocki@intel.com, rafael@kernel.org, rajatja@google.com, 
	rajatxjain@gmail.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Rajat Jain <rajatja@google.com>

Rename the field to make it more clear, that the device can execute DMA
attacks on the system, and thus the system may need protection from
such attacks from this device.

No functional change intended.

Signed-off-by: Rajat Jain <rajatja@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Joshua Peraza <jperaza@google.com>
---
 drivers/iommu/amd/iommu.c   |  3 +--
 drivers/iommu/dma-iommu.c   | 16 ++++++++--------
 drivers/iommu/intel/iommu.c | 10 +++++-----
 drivers/iommu/iommu.c       |  5 ++---
 drivers/pci/ats.c           |  2 +-
 drivers/pci/pci-acpi.c      |  2 +-
 drivers/pci/pci.c           |  2 +-
 drivers/pci/probe.c         | 10 +++++-----
 drivers/pci/quirks.c        |  4 ++--
 include/linux/pci.h         |  7 ++++---
 10 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b48a72bd7b23..5e71c436e283 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2952,8 +2952,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
 	if (!dev_data)
 		return 0;
 
-	/* Always use DMA domain for untrusted device */
-	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
+	if (dev_is_pci(dev) && to_pci_dev(dev)->requires_dma_protection)
 		return IOMMU_DOMAIN_DMA;
 
 	/*
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 2a9fa0c8cc00..1358f98691ab 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -598,16 +598,16 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	return ret;
 }
 
-static bool dev_is_untrusted(struct device *dev)
+static bool dev_requires_dma_protection(struct device *dev)
 {
-	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
+	return dev_is_pci(dev) && to_pci_dev(dev)->requires_dma_protection;
 }
 
 static bool dev_use_swiotlb(struct device *dev, size_t size,
 			    enum dma_data_direction dir)
 {
 	return IS_ENABLED(CONFIG_SWIOTLB) &&
-		(dev_is_untrusted(dev) ||
+		(dev_requires_dma_protection(dev) ||
 		 dma_kmalloc_needs_bounce(dev, size, dir));
 }
 
@@ -620,7 +620,7 @@ static bool dev_use_sg_swiotlb(struct device *dev, struct scatterlist *sg,
 	if (!IS_ENABLED(CONFIG_SWIOTLB))
 		return false;
 
-	if (dev_is_untrusted(dev))
+	if (dev_requires_dma_protection(dev))
 		return true;
 
 	/*
@@ -1192,12 +1192,12 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 			return DMA_MAPPING_ERROR;
 
 		/*
-		 * Untrusted devices should not see padding areas with random
-		 * leftover kernel data, so zero the pre- and post-padding.
+		 * Zero the pre- and post-padding to prevent exposing kernel data to devices
+		 * requiring DMA protection.
 		 * swiotlb_tbl_map_single() has initialized the bounce buffer
 		 * proper to the contents of the original memory buffer.
 		 */
-		if (dev_is_untrusted(dev)) {
+		if (dev_requires_dma_protection(dev)) {
 			size_t start, virt = (size_t)phys_to_virt(phys);
 
 			/* Pre-padding */
@@ -1738,7 +1738,7 @@ size_t iommu_dma_opt_mapping_size(void)
 
 size_t iommu_dma_max_mapping_size(struct device *dev)
 {
-	if (dev_is_untrusted(dev))
+	if (dev_requires_dma_protection(dev))
 		return swiotlb_max_mapping_size(dev);
 
 	return SIZE_MAX;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cc46098f875b..ca72216038f4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2985,7 +2985,7 @@ static int __init platform_optin_force_iommu(void)
 
 	/*
 	 * If Intel-IOMMU is disabled by default, we will apply identity
-	 * map for all devices except those marked as being untrusted.
+	 * map for all devices except those marked as requiring DMA protection.
 	 */
 	if (dmar_disabled)
 		iommu_set_default_passthrough(false);
@@ -4036,13 +4036,13 @@ static bool intel_iommu_is_attach_deferred(struct device *dev)
 }
 
 /*
- * Check that the device does not live on an external facing PCI port that is
- * marked as untrusted. Such devices should not be able to apply quirks and
- * thus not be able to bypass the IOMMU restrictions.
+ * Check that the device does not require DMA protection. Such devices should
+ * not be able to apply quirks and thus not be able to bypass the IOMMU
+ * restrictions.
  */
 static bool risky_device(struct pci_dev *pdev)
 {
-	if (pdev->untrusted) {
+	if (pdev->requires_dma_protection) {
 		pci_info(pdev,
 			 "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted PCI link\n",
 			 pdev->vendor, pdev->device);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 60aed01e54f2..40c1f32ea4e5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1793,10 +1793,9 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
 		driver_type = iommu_get_def_domain_type(group, gdev->dev,
 							driver_type);
 
-		if (dev_is_pci(gdev->dev) && to_pci_dev(gdev->dev)->untrusted) {
+		if (dev_is_pci(gdev->dev) && to_pci_dev(gdev->dev)->requires_dma_protection) {
 			/*
-			 * No ARM32 using systems will set untrusted, it cannot
-			 * work.
+			 * ARM32 systems don't support DMA protection.
 			 */
 			if (WARN_ON(IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)))
 				return -1;
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index c6b266c772c8..e7e3a7e207df 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -43,7 +43,7 @@ bool pci_ats_supported(struct pci_dev *dev)
 	if (!dev->ats_cap)
 		return false;
 
-	return (dev->untrusted == 0);
+	return (dev->requires_dma_protection == 0);
 }
 EXPORT_SYMBOL_GPL(pci_ats_supported);
 
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a457ae3e811a..1713e2856a88 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1465,7 +1465,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
 	pci_acpi_set_external_facing(pci_dev);
-	pci_dev->untrusted |= pci_dev_has_dma_property(pci_dev);
+	pci_dev->requires_dma_protection |= pci_dev_has_dma_property(pci_dev);
 	pci_acpi_add_edr_notifier(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..a3415ad88720 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1055,7 +1055,7 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 	caps->ctrl |= (caps->cap & PCI_ACS_UF);
 
 	/* Enable Translation Blocking for external devices and noats */
-	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
+	if (pci_ats_disabled() || dev->external_facing || dev->requires_dma_protection)
 		caps->ctrl |= (caps->cap & PCI_ACS_TB);
 }
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 246744d8d268..6d0a7a5f8464 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1677,7 +1677,7 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
 		dev->is_thunderbolt = 1;
 }
 
-static void set_pcie_untrusted(struct pci_dev *dev)
+static void pci_set_requires_dma_protection(struct pci_dev *dev)
 {
 	struct pci_dev *parent = pci_upstream_bridge(dev);
 
@@ -1687,14 +1687,14 @@ static void set_pcie_untrusted(struct pci_dev *dev)
 	 * If the upstream bridge is untrusted we treat this device as
 	 * untrusted as well.
 	 */
-	if (parent->untrusted) {
-		dev->untrusted = true;
+	if (parent->requires_dma_protection) {
+		dev->requires_dma_protection = true;
 		return;
 	}
 
 	if (arch_pci_dev_is_removable(dev)) {
 		pci_dbg(dev, "marking as untrusted\n");
-		dev->untrusted = true;
+		dev->requires_dma_protection = true;
 	}
 }
 
@@ -2007,7 +2007,7 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Need to have dev->cfg_size ready */
 	set_pcie_thunderbolt(dev);
 
-	set_pcie_untrusted(dev);
+	pci_set_requires_dma_protection(dev);
 
 	if (pci_is_pcie(dev))
 		dev->supported_speeds = pcie_get_supported_speeds(dev);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 82b21e34c545..99fcf141e8ae 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5299,7 +5299,7 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
  * PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF
  *
  * TODO: This quirk also needs to do equivalent of PCI_ACS_TB,
- * if dev->external_facing || dev->untrusted
+ * if dev->external_facing || dev->requires_dma_protection
  */
 static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
 {
@@ -5340,7 +5340,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_CR);
 	ctrl |= (cap & PCI_ACS_UF);
 
-	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
+	if (pci_ats_disabled() || dev->external_facing || dev->requires_dma_protection)
 		ctrl |= (cap & PCI_ACS_TB);
 
 	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..246ed29ab698 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -453,13 +453,14 @@ struct pci_dev {
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
 	/*
-	 * Devices marked being untrusted are the ones that can potentially
-	 * execute DMA attacks and similar. They are typically connected
+	 * Devices marked with requires_dma_protection are the ones that can
+	 * potentially execute DMA attacks and similar. They are typically connected
 	 * through external ports such as Thunderbolt but not limited to
 	 * that. When an IOMMU is enabled they should be getting full
 	 * mappings to make sure they cannot access arbitrary memory.
 	 */
-	unsigned int	untrusted:1;
+	unsigned int	requires_dma_protection:1;
+
 	/*
 	 * Info from the platform, e.g., ACPI or device tree, may mark a
 	 * device as "external-facing".  An external-facing device is
-- 
2.48.1.601.g30ceb7b040-goog


