Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6938364F7C
	for <lists+linux-pci@lfdr.de>; Tue, 20 Apr 2021 02:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhDTAbZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Apr 2021 20:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhDTAbY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Apr 2021 20:31:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7E8C061763
        for <linux-pci@vger.kernel.org>; Mon, 19 Apr 2021 17:30:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f7-20020a5b0c070000b02904e9a56ee7e7so9609988ybq.9
        for <linux-pci@vger.kernel.org>; Mon, 19 Apr 2021 17:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bNgXJhmUMNU0+evBI0pwLRswhxIcDKwkEWyVTZBRyWM=;
        b=YMyx6nlQLOvFFAbDgx6YNaCaDDXI4bKsmSCOuAGO0YsJJJ59yBJF2nf3HETWFTNjn5
         BDX8iScXDXYTUnWky3x1kXAfYeMLKvBE0YioWYxQGrGa/5UaufNnBWvMq6fTt1h6CQgA
         RhCk3N9uDqyNr/SP43GyVK1rhtZglXDeI8U5CKiZsQBZAh9QBf1SaS9xL4XOX5wV6ECc
         2lGmJLgypOjwWc5ARVrQQeVPGSo32TiWyu7nQKIQxU7IkHVGg7gFusZeYEVGMs+diHcj
         xCd8VWtYTLr+2/fpdiwXbEMRE2Gj9Ax/NuxY6Hle6iO85ghyMZC7W7yUH7yZEdY0ZwPm
         y1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bNgXJhmUMNU0+evBI0pwLRswhxIcDKwkEWyVTZBRyWM=;
        b=PWTueM0S5KNaHVEcmOG4hM0qoQZFnrpyEo9awGY8ctnRs7kKFdHs6Z1gBBHuKvyP5R
         CwmslFlStHh2H3cLBqdh2MBTH3wD3igoqQ7H+nB238dTwu909eAgcBtHRgSziHvDyelS
         fLxTObf5OYgZWHY+GxYgJ40xtT6vGa4qbwarv6spl/dPnhabRpIRPa8QqSPsWaoxre9m
         1aX4Hop+6D/Jgvmgjaq1K+Pr8/vb+R+iQaI1xzcqwLslZgPYIKd+KSs929mldpnuO7WI
         zDA0YzOGwzYKBzSvhh7ZVn6iC+xUgWJTjaq8OGrnrTEhQ1GjHSyWJEyfXEts4/5hwNao
         9CqQ==
X-Gm-Message-State: AOAM531Ph7nMWNC9TQHabnh6syNcKrPq+is1WYN4xmUJidc50iPUmFAN
        nXMmZ3ihKo2Ol94LCueWiItUuRmpJbSV
X-Google-Smtp-Source: ABdhPJzYECDDmH5bXKjr9Mc2Uw3fMf3epk4bPJCmrRAN7UOb1sYVsXXlsZMAhBN08iQSSyEeHiOTuRJlOFYn
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:6933:e454:f68:b2b4])
 (user=rajatja job=sendgmr) by 2002:a25:bb41:: with SMTP id
 b1mr20366575ybk.249.1618878653410; Mon, 19 Apr 2021 17:30:53 -0700 (PDT)
Date:   Mon, 19 Apr 2021 17:30:49 -0700
Message-Id: <20210420003049.1635027-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH] pci: Rename pci_dev->untrusted to pci_dev->external
From:   Rajat Jain <rajatja@google.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current flag name "untrusted" is not correct as it is populated
using the firmware property "external-facing" for the parent ports. In
other words, the firmware only says which ports are external facing, so
the field really identifies the devices as external (vs internal).

Only field renaming. No functional change intended.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/iommu/dma-iommu.c   |  2 +-
 drivers/iommu/intel/iommu.c |  2 +-
 drivers/iommu/iommu.c       |  2 +-
 drivers/pci/ats.c           |  2 +-
 drivers/pci/pci.c           |  2 +-
 drivers/pci/probe.c         | 12 ++++++------
 drivers/pci/quirks.c        |  2 +-
 include/linux/pci.h         |  9 +--------
 8 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index af765c813cc8..14769c213f30 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -313,7 +313,7 @@ static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
 
 static bool dev_is_untrusted(struct device *dev)
 {
-	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
+	return dev_is_pci(dev) && to_pci_dev(dev)->external;
 }
 
 /**
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ee0932307d64..965cc78e0dde 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5511,7 +5511,7 @@ intel_iommu_domain_get_attr(struct iommu_domain *domain,
  */
 static bool risky_device(struct pci_dev *pdev)
 {
-	if (pdev->untrusted) {
+	if (pdev->external) {
 		pci_info(pdev,
 			 "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted PCI link\n",
 			 pdev->vendor, pdev->device);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d0b0a15dba84..abdedc98f3c0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1482,7 +1482,7 @@ static int iommu_get_def_domain_type(struct device *dev)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 
-	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
+	if (dev_is_pci(dev) && to_pci_dev(dev)->external)
 		return IOMMU_DOMAIN_DMA;
 
 	if (ops->def_domain_type)
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 0d3719407b8b..0d17fb4a15bf 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -42,7 +42,7 @@ bool pci_ats_supported(struct pci_dev *dev)
 	if (!dev->ats_cap)
 		return false;
 
-	return (dev->untrusted == 0);
+	return (dev->external == 0);
 }
 EXPORT_SYMBOL_GPL(pci_ats_supported);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 16a17215f633..ec98892389d7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -886,7 +886,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_UF);
 
 	/* Enable Translation Blocking for external devices */
-	if (dev->external_facing || dev->untrusted)
+	if (dev->external_facing || dev->external)
 		ctrl |= (cap & PCI_ACS_TB);
 
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 953f15abc850..ae4800e82914 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1562,17 +1562,17 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
 	}
 }
 
-static void set_pcie_untrusted(struct pci_dev *dev)
+static void set_pcie_external(struct pci_dev *dev)
 {
 	struct pci_dev *parent;
 
 	/*
-	 * If the upstream bridge is untrusted we treat this device
-	 * untrusted as well.
+	 * If the upstream bridge is external we mark this device
+	 * external as well.
 	 */
 	parent = pci_upstream_bridge(dev);
-	if (parent && (parent->untrusted || parent->external_facing))
-		dev->untrusted = true;
+	if (parent && (parent->external || parent->external_facing))
+		dev->external = true;
 }
 
 /**
@@ -1814,7 +1814,7 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Need to have dev->cfg_size ready */
 	set_pcie_thunderbolt(dev);
 
-	set_pcie_untrusted(dev);
+	set_pcie_external(dev);
 
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3ba9e..1054b7d9ee89 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4942,7 +4942,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_CR);
 	ctrl |= (cap & PCI_ACS_UF);
 
-	if (dev->external_facing || dev->untrusted)
+	if (dev->external_facing || dev->external)
 		ctrl |= (cap & PCI_ACS_TB);
 
 	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 86c799c97b77..a535e2c2b690 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -431,14 +431,7 @@ struct pci_dev {
 	unsigned int	is_hotplug_bridge:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
-	/*
-	 * Devices marked being untrusted are the ones that can potentially
-	 * execute DMA attacks and similar. They are typically connected
-	 * through external ports such as Thunderbolt but not limited to
-	 * that. When an IOMMU is enabled they should be getting full
-	 * mappings to make sure they cannot access arbitrary memory.
-	 */
-	unsigned int	untrusted:1;
+	unsigned int	external:1;             /* Device sits on an external PCI bus */
 	/*
 	 * Info from the platform, e.g., ACPI or device tree, may mark a
 	 * device as "external-facing".  An external-facing device is
-- 
2.31.1.368.gbe11c130af-goog

