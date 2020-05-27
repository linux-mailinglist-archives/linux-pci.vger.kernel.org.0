Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C222C1E4B1F
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 18:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbgE0Q4Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 12:56:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:24081 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgE0Q4Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 May 2020 12:56:24 -0400
IronPort-SDR: zEet3UX0ylBGBhmhZF+sV/6A6bP3+AFWFHi3q67YbS/C3cPrPud8ifQDBwlozbIw1wgSJ+0H+Y
 yGkXapcXy1vQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 09:56:23 -0700
IronPort-SDR: +fxzajnotclfoyaC6dDc/CwJPCUD8o/zmAlac5GDz+x+/VtC6DOnvJo1lK77l1hxjuI1oWM8oz
 iLWPPAlA2Aew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400"; 
   d="scan'208";a="302522306"
Received: from jderrick-mobl.amr.corp.intel.com ([10.209.128.69])
  by orsmga008.jf.intel.com with ESMTP; 27 May 2020 09:56:23 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <iommu@lists.linux-foundation.org>
Cc:     <linux-pci@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v1 3/3] iommu/vt-d: Remove real DMA lookup in find_domain
Date:   Wed, 27 May 2020 10:56:17 -0600
Message-Id: <20200527165617.297470-4-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200527165617.297470-1-jonathan.derrick@intel.com>
References: <20200527165617.297470-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

By removing the real DMA indirection in find_domain(), we can allow
sub-devices of a real DMA device to have their own valid
device_domain_info. The dmar lookup and context entry removal paths have
been fixed to account for sub-devices.

Fixes: 2b0140c69637 ("iommu/vt-d: Use pci_real_dma_dev() for mapping")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207575
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/iommu/intel-iommu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6d39b9b..5767882 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2436,9 +2436,6 @@ struct dmar_domain *find_domain(struct device *dev)
 	if (unlikely(attach_deferred(dev) || iommu_dummy(dev)))
 		return NULL;
 
-	if (dev_is_pci(dev))
-		dev = &pci_real_dma_dev(to_pci_dev(dev))->dev;
-
 	/* No lock here, assumes no domain exit in normal case */
 	info = get_domain_info(dev);
 	if (likely(info))
-- 
1.8.3.1

