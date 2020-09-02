Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13A925B2F2
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 19:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIBRbL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 13:31:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:18281 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIBRbK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 13:31:10 -0400
IronPort-SDR: u4qlUC5LJ9RzEtC3+OvhQrebW0iAMvsVBEL1EbdE/YD7aIpWtnF0aEYHHWBtYNDTFEAlAGM8DQ
 gy7P0/PGX3rA==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="175492733"
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; 
   d="scan'208";a="175492733"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 10:31:09 -0700
IronPort-SDR: DPPLCodbmkUsNCbKq3Bu2E3FRKLXL5/tkk3jfOScZUh6glejTbX6hhxJeymR4iwnaEQCIN8IL3
 cX7NpIhp/uxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; 
   d="scan'208";a="405224501"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Sep 2020 10:31:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 500C6302; Wed,  2 Sep 2020 20:31:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>, x86@kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/3] swiotlb: Mark max_segment with static keyword
Date:   Wed,  2 Sep 2020 20:31:05 +0300
Message-Id: <20200902173105.38293-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902173105.38293-1-andriy.shevchenko@linux.intel.com>
References: <20200902173105.38293-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sparse is not happy about max_segment declaration:

  CHECK   kernel/dma/swiotlb.c
  kernel/dma/swiotlb.c:96:14: warning: symbol 'max_segment' was not declared. Should it be static?

Mark it static as suggested.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no change
 kernel/dma/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 6499bda8f0b8..465a567678d9 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -93,7 +93,7 @@ static unsigned int io_tlb_index;
  * Max segment that we can provide which (if pages are contingous) will
  * not be bounced (unless SWIOTLB_FORCE is set).
  */
-unsigned int max_segment;
+static unsigned int max_segment;
 
 /*
  * We need to save away the original address corresponding to a mapped entry
-- 
2.28.0

