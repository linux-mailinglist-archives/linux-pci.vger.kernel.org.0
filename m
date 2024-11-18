Return-Path: <linux-pci+bounces-17054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 371899D18F2
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 20:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC67D281C37
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 19:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD3E1E5716;
	Mon, 18 Nov 2024 19:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lLsxmTu2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F761E7658
	for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2024 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731958241; cv=none; b=q827GI8PZzMNpIs0agtT/LCsb9dxrZCxtGANGC3x28hdzqGa84T4XGt7rhYoHPG3CrGdmJSe/PcFtDDfRIL+8NEYYXOY1On/Skrt3biaVO5j2xqfhTEKNa0ifeUp6KzNtoOUfRVyGHl/x6hkhClnGeSLU1kdB2isYA9z+HqqM2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731958241; c=relaxed/simple;
	bh=td9vYL42XQudNEN+8jFo86Viz34b4OIqizRZCdCexg4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HXRCgRPxK1geCdwF+CbeF3CHOcg/Br7r3pJnMw4jIH8KPe6Gj9fTmQGWLTwJtUawgjaqbV0vlS6WTaHAI0Z7mK4JvcTTx7kCDGd34uikn85hQZNxESYmyqlEN0t5TlWmVkViMloREBE5BcdczK6KNItwBYBxedmh2K8leAX8kEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jperaza.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lLsxmTu2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jperaza.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e330f65bcd9so5627176276.1
        for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2024 11:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731958239; x=1732563039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b+pvl25Ke4atXFJeCOh6KmNiscogjhJJHhnkl2/5XRs=;
        b=lLsxmTu2nLMwg1E/8KIbhe4nLuKqkNnkQnaXCUFByXN1tFF4g3qQ0brtR+tvlA5FSn
         LarZ8yHZY1bmq1onXrqmcTRYVVu7HGlcE/v57u9Z9MQO1yxqIFYLDy2ii0453/6GP2/G
         Nagg8h8/zBZdoqnhWhbvAfPv3qAb0FcsmuGmXp1EvqAj5FfzJZfyv4RDtUmPEMYf4oJk
         MawLbtoLFv559xDaTwTEQhpd7sm2IdtGRSDDj9kyNs9jlMyt3dcFHdje4ZNrnxxdebjF
         JAIGVEKTEbpVGRouCoRLHEgLcifRJxc7e46U9Nqbeqa2tb0p5AGnP5DwkKr6KBuZ0kIf
         p9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731958239; x=1732563039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+pvl25Ke4atXFJeCOh6KmNiscogjhJJHhnkl2/5XRs=;
        b=Dpdi3AHOK+TvTURzPFOVYeEzXz7hpU8WYncpMC8tOenO9mjBNqoibEcamHPh8hZqjZ
         e5OcvHMvUcgRXNclBsACSsjFVEtIyR/9n6KEq6YiMLSLMyF2PlG/KXGoe5tP3uzvHOyd
         GLgvtH6pPSd3PjgkHitf65QwsqCTCOYxY7CH1UB7qLP7mgnC/AjrUvR4inf27NBD/+Ih
         LQv/xe/K73nBS3DUIaHYXJaSdQsqRyoOA5sbn7dAgj2IgpQYS/YHntn+rqSRXc4c4ToP
         CIsDDrmeEwCTycAO0smuURcKlKH/Bzbl0XgDuf5GppfcvUhox+/WIMq0HEwTGfvIqLTu
         yewA==
X-Forwarded-Encrypted: i=1; AJvYcCXgi+h6nbgG4Yb6SbksFSsoFYu2hntXVGD5nDf9MVbrakK+zrWYuj2O5lf1ViOdqTypPOpbRLh7ZOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA0kEDzgdkMQLybS75KBkMgk30iu6y2BLd0PAoMuGhYly9jTVw
	fwYd4ZnsSBcxgZ/N+CibvC/l6cvdvSPzmQDz+b1GvC3N5QCIy5Tpp4O6YgsH4KucBFCl1TGKBIg
	BiqMG9A==
X-Google-Smtp-Source: AGHT+IFybVuddM7p6vumMyd0W6qcjGgrhUDr1SZrFs3g1fT5Rf71/ZN2YHRL0nsAQtGNq9I3XiUcY8Ti4Pxs
X-Received: from jperaza.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:f86])
 (user=jperaza job=sendgmr) by 2002:a25:c5d3:0:b0:e30:b89f:e3d with SMTP id
 3f1490d57ef6-e38b76f605emr10686276.1.1731958238885; Mon, 18 Nov 2024 11:30:38
 -0800 (PST)
Date: Mon, 18 Nov 2024 19:30:24 +0000
In-Reply-To: <20241118193024.2695876-1-jperaza@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241118193024.2695876-1-jperaza@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241118193024.2695876-3-jperaza@google.com>
Subject: [PATCH 2/2] PCI: Rename pci_dev->untrusted to pci_dev->requires_dma_protection
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
 drivers/pci/probe.c         |  8 ++++----
 drivers/pci/quirks.c        |  4 ++--
 include/linux/pci.h         |  7 ++++---
 10 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8364cd6fa47d..6bf4944834b2 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2776,8 +2776,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
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
index e860bc9439a2..bcf907604c28 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3134,7 +3134,7 @@ static int __init platform_optin_force_iommu(void)
 
 	/*
 	 * If Intel-IOMMU is disabled by default, we will apply identity
-	 * map for all devices except those marked as being untrusted.
+	 * map for all devices except those marked as requiring DMA protection.
 	 */
 	if (dmar_disabled)
 		iommu_set_default_passthrough(false);
@@ -4228,13 +4228,13 @@ static bool intel_iommu_is_attach_deferred(struct device *dev)
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
index 83c8e617a2c5..0165f1d232b9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1745,10 +1745,9 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
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
index 6afff1f1b143..05aab7c74491 100644
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
index 225a6cd2e9ca..761bc845a7f2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1056,7 +1056,7 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 	caps->ctrl |= (caps->cap & PCI_ACS_UF);
 
 	/* Enable Translation Blocking for external devices and noats */
-	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
+	if (pci_ats_disabled() || dev->external_facing || dev->requires_dma_protection)
 		caps->ctrl |= (caps->cap & PCI_ACS_TB);
 }
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f1615805f5b0..7589a524c9b8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1631,7 +1631,7 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
 		dev->is_thunderbolt = 1;
 }
 
-static void set_pcie_untrusted(struct pci_dev *dev)
+static void pci_set_requires_dma_protection(struct pci_dev *dev)
 {
 	struct pci_dev *parent;
 
@@ -1640,8 +1640,8 @@ static void set_pcie_untrusted(struct pci_dev *dev)
 	 * untrusted as well.
 	 */
 	parent = pci_upstream_bridge(dev);
-	if (parent && (parent->untrusted || parent->external_facing))
-		dev->untrusted = true;
+	if (parent && (parent->requires_dma_protection || parent->external_facing))
+		dev->requires_dma_protection = true;
 }
 
 static void pci_set_removable(struct pci_dev *dev)
@@ -1945,7 +1945,7 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Need to have dev->cfg_size ready */
 	set_pcie_thunderbolt(dev);
 
-	set_pcie_untrusted(dev);
+	pci_set_requires_dma_protection(dev);
 
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index dccb60c1d9cc..cc2f4792e03b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5296,7 +5296,7 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
  * PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF
  *
  * TODO: This quirk also needs to do equivalent of PCI_ACS_TB,
- * if dev->external_facing || dev->untrusted
+ * if dev->external_facing || dev->requires_dma_protection
  */
 static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
 {
@@ -5337,7 +5337,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_CR);
 	ctrl |= (cap & PCI_ACS_UF);
 
-	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
+	if (pci_ats_disabled() || dev->external_facing || dev->requires_dma_protection)
 		ctrl |= (cap & PCI_ACS_TB);
 
 	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..b883539cfd88 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -444,13 +444,14 @@ struct pci_dev {
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
2.47.0.338.g60cca15819-goog


