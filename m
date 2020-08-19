Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C6C24A4AF
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 19:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgHSRNm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 13:13:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:35400 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbgHSRNg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 13:13:36 -0400
IronPort-SDR: wa+uhQpXzJbG10+YVoFTOkBkAtBNgWhf7M/llT002SWe1kpqBbsw0q3a8dALcD8RqjcB9Ui5JK
 HSigTbxbWopQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="216686422"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="216686422"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 10:13:35 -0700
IronPort-SDR: 3A+sVwkuPT1XN1/VIy6fBQmcFY7T0BTJGgNrvrT4TqVKC0FSsnyQxAj6ku0Yn9RIfOycfRsOsL
 +2ZPmAAThvaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="310843027"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 19 Aug 2020 10:13:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5C9EA26A; Wed, 19 Aug 2020 20:13:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>, x86@kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] swiotlb: Use %pa to print phys_addr_t variables
Date:   Wed, 19 Aug 2020 20:13:24 +0300
Message-Id: <20200819171326.35931-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is an extension to a %p to print phys_addr_t type of variables.
Use it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/dma/swiotlb.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c19379fabd20..676ccf0e49d3 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -165,17 +165,14 @@ unsigned long swiotlb_size_or_default(void)
 
 void swiotlb_print_info(void)
 {
-	unsigned long bytes = io_tlb_nslabs << IO_TLB_SHIFT;
+	unsigned long mb = (io_tlb_nslabs << IO_TLB_SHIFT) >> 20;
 
 	if (no_iotlb_memory) {
 		pr_warn("No low mem\n");
 		return;
 	}
 
-	pr_info("mapped [mem %#010llx-%#010llx] (%luMB)\n",
-	       (unsigned long long)io_tlb_start,
-	       (unsigned long long)io_tlb_end,
-	       bytes >> 20);
+	pr_info("mapped [mem %pa-%pa] (%luMB)\n", &io_tlb_start, &io_tlb_end, mb);
 }
 
 /*
-- 
2.28.0

