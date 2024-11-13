Return-Path: <linux-pci+bounces-16690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697269C7CDE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BF5284BB0
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 20:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DED320B7F2;
	Wed, 13 Nov 2024 20:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aX/Ke4Ux"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA7C20A5F6
	for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2024 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529345; cv=none; b=CJX0W4g7iLnHnqI4i7cJaHEKL/PBqqAoNR5sw6TZ7eM5+HSCC3/ZvjBKLfMUOzfImk6t80i4+w7OX725fifIaYiXBhVj6f4wMJsrOKlkYMZl8lAbSS7PCzAg1p4KIN4CXpG8kAXFWoZ1st1uqgapBJ1+EdNMHsc4TMQSMDIIkVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529345; c=relaxed/simple;
	bh=p+XmakqwAiwDGIYOiQzEgVOYQaa8EmkYL42DgFDyCTs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WjpBDwLMFxFKKgXlmNp+QDIWCvAg5oV5JjKL5DwHQG3hLwrFBSKp8A0xqDKmdPYdCrIQw6pfwk8p3iUFjwMptR0NIuhVhZnrPIvy1eEQyJDclaHexUMwOXPyusixjEOTpo0KDEnrmyYoB7YgJedwqhTa4ecnPmQCcBPzCOB5S+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jperaza.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aX/Ke4Ux; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jperaza.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e330f65bcd9so1503241276.1
        for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2024 12:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731529342; x=1732134142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O6/kGh6+RuUFesZuETCwx9Qh9Q+yRZLzARLiwYBV/A8=;
        b=aX/Ke4UxyzrKqHliPSzniW7c2WlS4OtW4/buMUZyqQnjEJu7vIc/Wom09pyhkoeW+R
         8TZChRsnt1OGKpmK7YeK17wRKQ59TCjCu9+vky8pomhgxi2bjh6H5EP8ZHKI0zj640W+
         DLe3DwgYu8Y8nTy4Nj0jrnqwIK3I9UY4jVyWedQi9Q6b0skMUBlUw7FsQiuAZ+4xJNNK
         dxdSTiLh43mz4UupqhZqTQmpfRDC5VZJvMjsa3YyrJAdF2lxVwTUs1t2MmDOGK+MsAvL
         /TRTqhNMm3c+P2Jgo/zviB4nFH9I926qLYXch7OpnmLKuxEtIWmyBfoyzxqSOoLNBw9R
         zuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731529342; x=1732134142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O6/kGh6+RuUFesZuETCwx9Qh9Q+yRZLzARLiwYBV/A8=;
        b=YjqgkHIgAbrtJLzV6vOCb1usKnY2O0ZbVtc7tXaR/xGd6m47FOv/etlJNNEBYBkyo7
         ontdXTjF6TMGolDa11+cI6SAXYxbEAwXDNkdF5gvQ/88KO953gDg4wLPxsxxaswRWI+j
         K1bDgcAnsr/fTeCE59dLGQ1pxLReE8ZmZeTSaVeIuahzv3zQ+qAhPO7QyZiOCA68LDIE
         8OpcKEcBy64i7jpuCw3KxN+6qjPoaW+QChqtYjZimEIzstML6ntmlwU/LgoZM3enTMZp
         5S/O2x5llTLj5j+TKR4mOlr+Ibpj7N9m7G1X2FZj3J91cPOfmuRDNtXAC/y8o52C94Mr
         y3TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXywWsroD/1b8XKcXeDCEwk1tux1Bcb7AFl5c182MaYrtoWYdRKZZ0ujfGJ2IoOxQcP51Jso+Oprio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8MC+3xZBrcurS+TOhUwt6KxVLax1rWmIkzlrN72NHFsNpYukU
	CQNvKBxUiR0ox/gtD6GO8GKIx51/tKI/CaVbg4AxBg616hx5Dwh/jCZ6mjkZHukKJ5bb6H/BXKk
	Dl0pFBg==
X-Google-Smtp-Source: AGHT+IEBsYnUG+gqVm568orLvHFqdkgMle0kwsbwdhnl/4zxuRsHxS1zqJfijXNkgtpufHfFipAC0hwuiB5+
X-Received: from jperaza.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:f86])
 (user=jperaza job=sendgmr) by 2002:a25:6888:0:b0:e29:9c5:5fcb with SMTP id
 3f1490d57ef6-e380e241492mr9426276.4.1731529342458; Wed, 13 Nov 2024 12:22:22
 -0800 (PST)
Date: Wed, 13 Nov 2024 20:22:14 +0000
In-Reply-To: <20241113202214.1421739-1-jperaza@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20220426172105.3663170-2-rajatja@google.com> <20241113202214.1421739-1-jperaza@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241113202214.1421739-3-jperaza@google.com>
Subject: [PATCH 2/2] PCI: Rename pci_dev->untrusted to pci_dev->untrusted_dma
From: Joshua Peraza <jperaza@google.com>
To: rajatja@google.com
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, dtor@google.com, 
	dwmw2@infradead.org, gregkh@linuxfoundation.org, helgaas@kernel.org, 
	iommu@lists.linux-foundation.org, jean-philippe@linaro.org, joro@8bytes.org, 
	jsbarnes@google.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	mika.westerberg@linux.intel.com, oohall@gmail.com, pavel@denx.de, 
	rafael.j.wysocki@intel.com, rafael@kernel.org, rajatxjain@gmail.com, 
	will@kernel.org, Joshua Peraza <jperaza@google.com>
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
 drivers/iommu/amd/iommu.c   |  2 +-
 drivers/iommu/dma-iommu.c   | 12 ++++++------
 drivers/iommu/intel/iommu.c |  2 +-
 drivers/iommu/iommu.c       |  2 +-
 drivers/pci/ats.c           |  2 +-
 drivers/pci/pci-acpi.c      |  2 +-
 drivers/pci/pci.c           |  2 +-
 drivers/pci/probe.c         |  8 ++++----
 drivers/pci/quirks.c        |  2 +-
 include/linux/pci.h         |  5 +++--
 10 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8364cd6fa47d..baa86a0744bc 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2777,7 +2777,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
 		return 0;
 
 	/* Always use DMA domain for untrusted device */
-	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
+	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted_dma)
 		return IOMMU_DOMAIN_DMA;
 
 	/*
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 2a9fa0c8cc00..78b537c23f3c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -598,16 +598,16 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	return ret;
 }
 
-static bool dev_is_untrusted(struct device *dev)
+static bool dev_has_untrusted_dma(struct device *dev)
 {
-	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
+	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted_dma;
 }
 
 static bool dev_use_swiotlb(struct device *dev, size_t size,
 			    enum dma_data_direction dir)
 {
 	return IS_ENABLED(CONFIG_SWIOTLB) &&
-		(dev_is_untrusted(dev) ||
+		(dev_has_untrusted_dma(dev) ||
 		 dma_kmalloc_needs_bounce(dev, size, dir));
 }
 
@@ -620,7 +620,7 @@ static bool dev_use_sg_swiotlb(struct device *dev, struct scatterlist *sg,
 	if (!IS_ENABLED(CONFIG_SWIOTLB))
 		return false;
 
-	if (dev_is_untrusted(dev))
+	if (dev_has_untrusted_dma(dev))
 		return true;
 
 	/*
@@ -1197,7 +1197,7 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		 * swiotlb_tbl_map_single() has initialized the bounce buffer
 		 * proper to the contents of the original memory buffer.
 		 */
-		if (dev_is_untrusted(dev)) {
+		if (dev_has_untrusted_dma(dev)) {
 			size_t start, virt = (size_t)phys_to_virt(phys);
 
 			/* Pre-padding */
@@ -1738,7 +1738,7 @@ size_t iommu_dma_opt_mapping_size(void)
 
 size_t iommu_dma_max_mapping_size(struct device *dev)
 {
-	if (dev_is_untrusted(dev))
+	if (dev_has_untrusted_dma(dev))
 		return swiotlb_max_mapping_size(dev);
 
 	return SIZE_MAX;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e860bc9439a2..42f310d238a6 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4234,7 +4234,7 @@ static bool intel_iommu_is_attach_deferred(struct device *dev)
  */
 static bool risky_device(struct pci_dev *pdev)
 {
-	if (pdev->untrusted) {
+	if (pdev->untrusted_dma) {
 		pci_info(pdev,
 			 "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted PCI link\n",
 			 pdev->vendor, pdev->device);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 83c8e617a2c5..8f436db65b37 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1745,7 +1745,7 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
 		driver_type = iommu_get_def_domain_type(group, gdev->dev,
 							driver_type);
 
-		if (dev_is_pci(gdev->dev) && to_pci_dev(gdev->dev)->untrusted) {
+		if (dev_is_pci(gdev->dev) && to_pci_dev(gdev->dev)->untrusted_dma) {
 			/*
 			 * No ARM32 using systems will set untrusted, it cannot
 			 * work.
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 6afff1f1b143..51f232897c03 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -43,7 +43,7 @@ bool pci_ats_supported(struct pci_dev *dev)
 	if (!dev->ats_cap)
 		return false;
 
-	return (dev->untrusted == 0);
+	return (dev->untrusted_dma == 0);
 }
 EXPORT_SYMBOL_GPL(pci_ats_supported);
 
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a457ae3e811a..12791a2533a9 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1465,7 +1465,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
 	pci_acpi_set_external_facing(pci_dev);
-	pci_dev->untrusted |= pci_dev_has_dma_property(pci_dev);
+	pci_dev->untrusted_dma |= pci_dev_has_dma_property(pci_dev);
 	pci_acpi_add_edr_notifier(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 225a6cd2e9ca..1312df37f2cf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1056,7 +1056,7 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 	caps->ctrl |= (caps->cap & PCI_ACS_UF);
 
 	/* Enable Translation Blocking for external devices and noats */
-	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
+	if (pci_ats_disabled() || dev->external_facing || dev->untrusted_dma)
 		caps->ctrl |= (caps->cap & PCI_ACS_TB);
 }
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f1615805f5b0..065f886db0b4 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1631,7 +1631,7 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
 		dev->is_thunderbolt = 1;
 }
 
-static void set_pcie_untrusted(struct pci_dev *dev)
+static void pci_set_untrusted_dma(struct pci_dev *dev)
 {
 	struct pci_dev *parent;
 
@@ -1640,8 +1640,8 @@ static void set_pcie_untrusted(struct pci_dev *dev)
 	 * untrusted as well.
 	 */
 	parent = pci_upstream_bridge(dev);
-	if (parent && (parent->untrusted || parent->external_facing))
-		dev->untrusted = true;
+	if (parent && (parent->untrusted_dma || parent->external_facing))
+		dev->untrusted_dma = true;
 }
 
 static void pci_set_removable(struct pci_dev *dev)
@@ -1945,7 +1945,7 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Need to have dev->cfg_size ready */
 	set_pcie_thunderbolt(dev);
 
-	set_pcie_untrusted(dev);
+	pci_set_untrusted_dma(dev);
 
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index dccb60c1d9cc..65624f4bbaf0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5337,7 +5337,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_CR);
 	ctrl |= (cap & PCI_ACS_UF);
 
-	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
+	if (pci_ats_disabled() || dev->external_facing || dev->untrusted_dma)
 		ctrl |= (cap & PCI_ACS_TB);
 
 	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..34b53b237077 100644
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
2.47.0.277.g8800431eea-goog


