Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00FE71A3A8B
	for <lists+linux-pci@lfdr.de>; Thu,  9 Apr 2020 21:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgDITcY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 15:32:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:63075 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgDITcX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Apr 2020 15:32:23 -0400
IronPort-SDR: ayrXmS5eNsQ4fiEBf5H4RlK0HBr5IXB67dQXc5XCJXTZ8FrCLSznKfva26jhTVTIA1H2eJW3W4
 jTIcAXmr1R8A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 12:32:22 -0700
IronPort-SDR: NsKuVCbtdb3MPecg44vsYfhNG+3sk53k7GhNkwnAmaiK2NgdQrYz/IiIojtt88S1EBF5L8dG56
 SKSPuxuAsyxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,363,1580803200"; 
   d="scan'208";a="452116453"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.40])
  by fmsmga005.fm.intel.com with ESMTP; 09 Apr 2020 12:32:22 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Daniel Drake <drake@endlessm.com>, <linux@endlessm.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 1/1] iommu/vt-d: use DMA domain for real DMA devices and subdevices
Date:   Thu,  9 Apr 2020 15:17:36 -0400
Message-Id: <20200409191736.6233-2-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200409191736.6233-1-jonathan.derrick@intel.com>
References: <20200409191736.6233-1-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI devices handled by intel-iommu may have a DMA requester on another bus,
such as VMD subdevices needing to use the VMD endpoint.

The real DMA device is now used for the DMA mapping, but one case was missed
earlier: if the VMD device (and hence subdevices too) are under
IOMMU_DOMAIN_IDENTITY, mappings do not work.

Codepaths like intel_map_page() handle the IOMMU_DOMAIN_DMA case by creating an
iommu DMA mapping, and fall back on dma_direct_map_page() for the
IOMMU_DOMAIN_IDENTITY case. However, handling of the IDENTITY case is broken
when intel_page_page() handles a subdevice.

We observe that at iommu attach time, dmar_insert_one_dev_info() for the
subdevices will never set dev->archdata.iommu. This is because that function
uses find_domain() to check if there is already an IOMMU for the device, and
find_domain() then defers to the real DMA device which does have one. Thus
dmar_insert_one_dev_info() returns without assigning dev->archdata.iommu.

Then, later:

1. intel_map_page() checks if an IOMMU mapping is needed by calling
   iommu_need_mapping() on the subdevice. identity_mapping() returns
   false because dev->archdata.iommu is NULL, so this function
   returns false indicating that mapping is needed.
2. __intel_map_single() is called to create the mapping.
3. __intel_map_single() calls find_domain(). This function now returns
   the IDENTITY domain corresponding to the real DMA device.
4. __intel_map_single() calls domain_get_iommu() on this "real" domain.
   A failure is hit and the entire operation is aborted, because this
   codepath is not intended to handle IDENTITY mappings:
       if (WARN_ON(domain->domain.type != IOMMU_DOMAIN_DMA))
                   return NULL;

This becomes problematic if the real DMA device and the subdevices have
different addressing capabilities and some require translation. Instead we can
put the real DMA dev and any subdevices on the DMA domain. This change assigns
subdevices to the DMA domain, and moves the real DMA device to the DMA domain
if necessary.

Reported-by: Daniel Drake <drake@endlessm.com>
Fixes: b0140c69637e ("iommu/vt-d: Use pci_real_dma_dev() for mapping")
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/iommu/intel-iommu.c | 56 ++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ef0a5246700e..b4844a502499 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3049,6 +3049,9 @@ static int device_def_domain_type(struct device *dev)
 		if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
 			return IOMMU_DOMAIN_IDENTITY;
 
+		if (pci_real_dma_dev(pdev) != pdev)
+			return IOMMU_DOMAIN_DMA;
+
 		/*
 		 * We want to start off with all devices in the 1:1 domain, and
 		 * take them out later if we find they can't access all of memory.
@@ -5781,12 +5784,32 @@ static bool intel_iommu_capable(enum iommu_cap cap)
 	return false;
 }
 
+static int intel_iommu_request_dma_domain_for_dev(struct device *dev,
+                                                  struct dmar_domain *domain)
+{
+	int ret;
+
+	ret = iommu_request_dma_domain_for_dev(dev);
+	if (ret) {
+		dmar_remove_one_dev_info(dev);
+		domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
+		if (!get_private_domain_for_dev(dev)) {
+			dev_warn(dev,
+				 "Failed to get a private domain.\n");
+				return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
 static int intel_iommu_add_device(struct device *dev)
 {
 	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
 	struct intel_iommu *iommu;
 	struct iommu_group *group;
+	struct device *real_dev = dev;
 	u8 bus, devfn;
 	int ret;
 
@@ -5810,6 +5833,21 @@ static int intel_iommu_add_device(struct device *dev)
 
 	domain = iommu_get_domain_for_dev(dev);
 	dmar_domain = to_dmar_domain(domain);
+
+	if (dev_is_pci(dev))
+		real_dev = &pci_real_dma_dev(to_pci_dev(dev))->dev;
+
+	if (real_dev != dev) {
+		domain = iommu_get_domain_for_dev(real_dev);
+		if (domain->type != IOMMU_DOMAIN_DMA) {
+			dmar_remove_one_dev_info(real_dev);
+
+			ret = intel_iommu_request_dma_domain_for_dev(real_dev, dmar_domain);
+			if (ret)
+				goto unlink;
+		}
+	}
+
 	if (domain->type == IOMMU_DOMAIN_DMA) {
 		if (device_def_domain_type(dev) == IOMMU_DOMAIN_IDENTITY) {
 			ret = iommu_request_dm_for_dev(dev);
@@ -5823,20 +5861,12 @@ static int intel_iommu_add_device(struct device *dev)
 		}
 	} else {
 		if (device_def_domain_type(dev) == IOMMU_DOMAIN_DMA) {
-			ret = iommu_request_dma_domain_for_dev(dev);
-			if (ret) {
-				dmar_remove_one_dev_info(dev);
-				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
-				if (!get_private_domain_for_dev(dev)) {
-					dev_warn(dev,
-						 "Failed to get a private domain.\n");
-					ret = -ENOMEM;
-					goto unlink;
-				}
+			ret = intel_iommu_request_dma_domain_for_dev(dev, dmar_domain);
+			if (ret)
+				goto unlink;
 
-				dev_info(dev,
-					 "Device uses a private dma domain.\n");
-			}
+			dev_info(dev,
+				 "Device uses a private dma domain.\n");
 		}
 	}
 
-- 
2.18.1

