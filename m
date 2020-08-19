Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042E724A4AD
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 19:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHSRNm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 13:13:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:61619 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgHSRNf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 13:13:35 -0400
IronPort-SDR: eElDblL4C2XhW6MIq3BJWuaeDcFgdhKSrjOBEVr739VW4JDPFq8IFtap/cSM4HPjAV37BaoiFH
 1vTBxraBZJDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="152770357"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="152770357"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 10:13:35 -0700
IronPort-SDR: zImcgjOsEzstPjqa6z3047Z8QGYimMaTtLrxzf1lHSMmc0xZ23uxIQErNlXFn0rwCuTltr2RTR
 12nsUheZTDwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="497313888"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 19 Aug 2020 10:13:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7AA8E371; Wed, 19 Aug 2020 20:13:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>, x86@kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] swiotlb: Mark max_segment with static keyword
Date:   Wed, 19 Aug 2020 20:13:26 +0300
Message-Id: <20200819171326.35931-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819171326.35931-1-andriy.shevchenko@linux.intel.com>
References: <20200819171326.35931-1-andriy.shevchenko@linux.intel.com>
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
 kernel/dma/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 676ccf0e49d3..5afbc50621fe 100644
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

