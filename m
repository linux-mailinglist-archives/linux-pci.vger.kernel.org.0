Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 963DA12DD5F
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jan 2020 03:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgAAC1C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 21:27:02 -0500
Received: from mga14.intel.com ([192.55.52.115]:65216 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbgAAC1C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Dec 2019 21:27:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2019 18:27:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,381,1571727600"; 
   d="scan'208";a="221068067"
Received: from unknown (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.116.83])
  by orsmga006.jf.intel.com with ESMTP; 31 Dec 2019 18:27:01 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [RFC 2/5] iommu/vt-d: Unlink device if failed to add to group
Date:   Tue, 31 Dec 2019 13:24:20 -0700
Message-Id: <1577823863-3303-3-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1577823863-3303-1-git-send-email-jonathan.derrick@intel.com>
References: <1577823863-3303-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the device fails to be added to the group, make sure to unlink the
reference before returning.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/iommu/intel-iommu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b2526a4..978d502 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5625,8 +5625,10 @@ static int intel_iommu_add_device(struct device *dev)
 
 	group = iommu_group_get_for_dev(dev);
 
-	if (IS_ERR(group))
-		return PTR_ERR(group);
+	if (IS_ERR(group)) {
+		ret = PTR_ERR(group);
+		goto unlink;
+	}
 
 	iommu_group_put(group);
 
@@ -5652,7 +5654,8 @@ static int intel_iommu_add_device(struct device *dev)
 				if (!get_private_domain_for_dev(dev)) {
 					dev_warn(dev,
 						 "Failed to get a private domain.\n");
-					return -ENOMEM;
+					ret = -ENOMEM;
+					goto unlink;
 				}
 
 				dev_info(dev,
@@ -5667,6 +5670,10 @@ static int intel_iommu_add_device(struct device *dev)
 	}
 
 	return 0;
+
+unlink:
+	iommu_device_unlink(&iommu->iommu, dev);
+	return ret;
 }
 
 static void intel_iommu_remove_device(struct device *dev)
-- 
1.8.3.1

