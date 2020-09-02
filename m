Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D3625B2F1
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 19:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIBRbK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 13:31:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:46678 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgIBRbK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 13:31:10 -0400
IronPort-SDR: w18mnqhiGhjsB6BTS4oux7H6E+yPVWTigLOpntUrbGzjpUfTS0GINfvynYxOIeXCLdBfBDfGOD
 cCRHdVtnA7LQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="154950818"
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; 
   d="scan'208";a="154950818"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 10:31:09 -0700
IronPort-SDR: iboufCExiMkRwxCZvv9JA1JwWVwYv355gMVPE7gw/E2R9tqa+c/tjbiqe63h+2B+fgxp5kgTqr
 yw19mzRBOXhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; 
   d="scan'208";a="334183284"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 02 Sep 2020 10:31:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 47C0FE1; Wed,  2 Sep 2020 20:31:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>, x86@kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/3] swiotlb: Declare swiotlb_late_init_with_default_size() in header
Date:   Wed,  2 Sep 2020 20:31:04 +0300
Message-Id: <20200902173105.38293-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902173105.38293-1-andriy.shevchenko@linux.intel.com>
References: <20200902173105.38293-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Compiler is not happy about one function prototype:

  CC      kernel/dma/swiotlb.o
  kernel/dma/swiotlb.c:275:1: warning: no previous prototype for ‘swiotlb_late_init_with_default_size’ [-Wmissing-prototypes]
  275 | swiotlb_late_init_with_default_size(size_t default_size)
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Since it's used outside of the module, move its declaration to the header
from the user.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no change
 arch/x86/pci/sta2x11-fixup.c | 1 -
 include/linux/swiotlb.h      | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
index c313d784efab..11c0e80b9ed4 100644
--- a/arch/x86/pci/sta2x11-fixup.c
+++ b/arch/x86/pci/sta2x11-fixup.c
@@ -15,7 +15,6 @@
 #include <asm/iommu.h>
 
 #define STA2X11_SWIOTLB_SIZE (4*1024*1024)
-extern int swiotlb_late_init_with_default_size(size_t default_size);
 
 /*
  * We build a list of bus numbers that are under the ConneXt. The
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 046bb94bd4d6..513913ff7486 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -34,6 +34,7 @@ int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
 extern unsigned long swiotlb_nr_tbl(void);
 unsigned long swiotlb_size_or_default(void);
 extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
+extern int swiotlb_late_init_with_default_size(size_t default_size);
 extern void __init swiotlb_update_mem_attributes(void);
 
 /*
-- 
2.28.0

