Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4951E4B1D
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 18:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgE0Q4Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 12:56:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:24076 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgE0Q4X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 May 2020 12:56:23 -0400
IronPort-SDR: ep3o264UgtZuiAHDDBTxPb9tfB70vkW6/riUeX7/be7DWoTbzotuUQoM/+GXNf/lxOZ8ffHJZY
 sWdejBjiUBRA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 09:56:22 -0700
IronPort-SDR: RqmHfxYy8/LbxXwmLvdQBUf3l+FxLpr7XnwFVqArBcCm2GmEJ7S1hV1rS8DTLVRtwbYdckTLWa
 SPB6jkPEwAAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400"; 
   d="scan'208";a="302522300"
Received: from jderrick-mobl.amr.corp.intel.com ([10.209.128.69])
  by orsmga008.jf.intel.com with ESMTP; 27 May 2020 09:56:22 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <iommu@lists.linux-foundation.org>
Cc:     <linux-pci@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v1 2/3] iommu/vt-d: Allocate domain info for real DMA sub-devices
Date:   Wed, 27 May 2020 10:56:16 -0600
Message-Id: <20200527165617.297470-3-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200527165617.297470-1-jonathan.derrick@intel.com>
References: <20200527165617.297470-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sub-devices of a real DMA device might exist on a separate segment than
the real DMA device and its IOMMU. These devices should still have a
valid device_domain_info, but the current dma alias model won't
allocate info for the subdevice.

This patch adds a segment member to struct device_domain_info and uses
the sub-device's BDF so that these sub-devices won't alias to other
devices.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/iommu/intel-iommu.c | 19 +++++++++++++++----
 include/linux/intel-iommu.h |  1 +
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 1ff45b2..6d39b9b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2463,7 +2463,7 @@ static void do_deferred_attach(struct device *dev)
 	struct device_domain_info *info;
 
 	list_for_each_entry(info, &device_domain_list, global)
-		if (info->iommu->segment == segment && info->bus == bus &&
+		if (info->segment == segment && info->bus == bus &&
 		    info->devfn == devfn)
 			return info;
 
@@ -2520,8 +2520,18 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	if (!info)
 		return NULL;
 
-	info->bus = bus;
-	info->devfn = devfn;
+	if (!dev_is_real_dma_subdevice(dev)) {
+		info->bus = bus;
+		info->devfn = devfn;
+		info->segment = iommu->segment;
+	} else {
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		info->bus = pdev->bus->number;
+		info->devfn = pdev->devfn;
+		info->segment = pci_domain_nr(pdev->bus);
+	}
+
 	info->ats_supported = info->pasid_supported = info->pri_supported = 0;
 	info->ats_enabled = info->pasid_enabled = info->pri_enabled = 0;
 	info->ats_qdep = 0;
@@ -2561,7 +2571,8 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 
 	if (!found) {
 		struct device_domain_info *info2;
-		info2 = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
+		info2 = dmar_search_domain_by_dev_info(info->segment, info->bus,
+						       info->devfn);
 		if (info2) {
 			found      = info2->domain;
 			info2->dev = dev;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 21633ce..4100bd2 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -609,6 +609,7 @@ struct device_domain_info {
 	struct list_head auxiliary_domains; /* auxiliary domains
 					     * attached to this device
 					     */
+	u32 segment;		/* PCI segment number */
 	u8 bus;			/* PCI bus number */
 	u8 devfn;		/* PCI devfn number */
 	u16 pfsid;		/* SRIOV physical function source ID */
-- 
1.8.3.1

