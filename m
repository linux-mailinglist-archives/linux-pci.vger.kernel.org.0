Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5482F1E4B1E
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 18:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgE0Q4X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 12:56:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:24078 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbgE0Q4X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 May 2020 12:56:23 -0400
IronPort-SDR: tAcCzAGIpsnkk9NM4FHtMZvRNvb6Oaz9rn9nOLHgR8OG0aOfJl5ltbUoPCy77bY4vXdP1EB7va
 14zd7Xhc4pJw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 09:56:22 -0700
IronPort-SDR: ljnwbifSi6tpzAZRS3tJCSTDtQX25lWKO+sp42EQ+RzMLhQIPq+xmCqfGncYN7KLMv6U+22KyH
 DxL7UDXCiPgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400"; 
   d="scan'208";a="302522293"
Received: from jderrick-mobl.amr.corp.intel.com ([10.209.128.69])
  by orsmga008.jf.intel.com with ESMTP; 27 May 2020 09:56:21 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <iommu@lists.linux-foundation.org>
Cc:     <linux-pci@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v1 1/3] iommu/vt-d: Only clear real DMA device's context entries
Date:   Wed, 27 May 2020 10:56:15 -0600
Message-Id: <20200527165617.297470-2-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200527165617.297470-1-jonathan.derrick@intel.com>
References: <20200527165617.297470-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Domain context mapping can encounter issues with sub-devices of a real
DMA device. A sub-device cannot have a valid context entry due to it
potentially aliasing another device's 16-bit ID. It's expected that
sub-devices of the real DMA device uses the real DMA device's requester
when context mapping.

This is an issue when a sub-device is removed where the context entry is
cleared for all aliases. Other sub-devices are still valid, resulting in
those sub-devices being stranded without valid context entries.

The correct approach is to use the real DMA device when programming the
context entries. The insertion path is correct because device_to_iommu()
will return the bus and devfn of the real DMA device. The removal path
needs to only operate on the real DMA device, otherwise the entire
context entry would be cleared for all sub-devices of the real DMA
device.

This patch also adds a helper to determine if a struct device is a
sub-device of a real DMA device.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/iommu/intel-iommu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ff5a30a..1ff45b2 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2500,6 +2500,12 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 					     flags);
 }
 
+static bool dev_is_real_dma_subdevice(struct device *dev)
+{
+	return dev && dev_is_pci(dev) &&
+	       pci_real_dma_dev(to_pci_dev(dev)) != to_pci_dev(dev);
+}
+
 static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 						    int bus, int devfn,
 						    struct device *dev,
@@ -4975,7 +4981,8 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 					PASID_RID2PASID, false);
 
 		iommu_disable_dev_iotlb(info);
-		domain_context_clear(iommu, info->dev);
+		if (!dev_is_real_dma_subdevice(info->dev))
+			domain_context_clear(iommu, info->dev);
 		intel_pasid_free_table(info->dev);
 	}
 
-- 
1.8.3.1

