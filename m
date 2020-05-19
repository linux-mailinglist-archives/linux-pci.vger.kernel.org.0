Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561401D9E70
	for <lists+linux-pci@lfdr.de>; Tue, 19 May 2020 20:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgESSBw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 May 2020 14:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgESSBv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2020 14:01:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39FEC08C5C1
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 11:01:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so448138wru.0
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 11:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zf1iQq48aeXnoidABo6mI0CyWrUAaSL9I3RQkTUgsJ0=;
        b=bCh5A9v5wwtAyAyg/G0FWXi26STNFSt0Kq+GVCzS0vvEnWdW5a9ixLb2d9QmIQezHj
         uFRq+4CDGtZ6QiLSXwJ2xtWoqgXEJrzM7m6m59s69FYbDMwyONPYbc7j2HgVBdfpzcEU
         siZyz1v6XG942Mrxo6QhyLdkW7H52m/Ex+KnZbmy4CYzsMYyvN696YVjApqM1fwMfa81
         dRE8xDIZ/VL3Jli+BtbwcYu0rBerfWqclWj9aPoYNWHf4puC+nRCVvdB7yBnD0WCrbYb
         VgFqYrzB2vlH+2A2cSGkaiDAp31069uOqdqyO0umNmMBbjonD52yN3Zi66t7Hn54fMpJ
         t/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zf1iQq48aeXnoidABo6mI0CyWrUAaSL9I3RQkTUgsJ0=;
        b=Qz1CcFbhfmPUN45zv+BOQKS2a2Ok0tePyId75anwYQZrdGn5dve5vlhv1CljxIC6av
         gwDABemqLWXfU3l0lLAwvcTwds41AJAkiEroCP0dmj1OVT8UwBo1Qam9G/CZLV6Ji3Uu
         3EfPvIv7J3G9LmzX+3zNkmwD6NkadMsOlziEb8SRQcrG80FniNbXSX08pwy35nfjz05f
         QvWQghieDxspmr4da5sfsccR23b/MkcaE2oV0d12b7X7SrNvzJsVI6vA0pWwo9XWi2iW
         kiCSTAPsGhriD4bQtxb/gU7qGdYbMKWDzAAJ5JjWDhCyhPwwe58hi2SfHly+f9GWsi9Y
         YgIg==
X-Gm-Message-State: AOAM5306c74zhOLIeCaKGlVON/hz2VRhgvdWODKykcIv7Hw6eZvuq2B9
        IgOtTcI7yBzs46afc9bX15sZDw==
X-Google-Smtp-Source: ABdhPJx7LRULm4jaifxoCDUqVqIaTFeb2/VBifNGj7dG0DrAp4tCycMsVx1c1WDIHG+KUypLZSHjsA==
X-Received: by 2002:adf:e64c:: with SMTP id b12mr87984wrn.131.1589911309705;
        Tue, 19 May 2020 11:01:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id 1sm510496wmz.13.2020.05.19.11.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:01:49 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v7 07/24] iommu/io-pgtable-arm: Move some definitions to a header
Date:   Tue, 19 May 2020 19:54:45 +0200
Message-Id: <20200519175502.2504091-8-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519175502.2504091-1-jean-philippe@linaro.org>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Extract some of the most generic TCR defines, so they can be reused by
the page table sharing code.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/io-pgtable-arm.h | 30 ++++++++++++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c | 27 ++-------------------------
 MAINTAINERS                    |  3 +--
 3 files changed, 33 insertions(+), 27 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm.h

diff --git a/drivers/iommu/io-pgtable-arm.h b/drivers/iommu/io-pgtable-arm.h
new file mode 100644
index 000000000000..ba7cfdf7afa0
--- /dev/null
+++ b/drivers/iommu/io-pgtable-arm.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef IO_PGTABLE_ARM_H_
+#define IO_PGTABLE_ARM_H_
+
+#define ARM_LPAE_TCR_TG0_4K		0
+#define ARM_LPAE_TCR_TG0_64K		1
+#define ARM_LPAE_TCR_TG0_16K		2
+
+#define ARM_LPAE_TCR_TG1_16K		1
+#define ARM_LPAE_TCR_TG1_4K		2
+#define ARM_LPAE_TCR_TG1_64K		3
+
+#define ARM_LPAE_TCR_SH_NS		0
+#define ARM_LPAE_TCR_SH_OS		2
+#define ARM_LPAE_TCR_SH_IS		3
+
+#define ARM_LPAE_TCR_RGN_NC		0
+#define ARM_LPAE_TCR_RGN_WBWA		1
+#define ARM_LPAE_TCR_RGN_WT		2
+#define ARM_LPAE_TCR_RGN_WB		3
+
+#define ARM_LPAE_TCR_PS_32_BIT		0x0ULL
+#define ARM_LPAE_TCR_PS_36_BIT		0x1ULL
+#define ARM_LPAE_TCR_PS_40_BIT		0x2ULL
+#define ARM_LPAE_TCR_PS_42_BIT		0x3ULL
+#define ARM_LPAE_TCR_PS_44_BIT		0x4ULL
+#define ARM_LPAE_TCR_PS_48_BIT		0x5ULL
+#define ARM_LPAE_TCR_PS_52_BIT		0x6ULL
+
+#endif /* IO_PGTABLE_ARM_H_ */
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 04fbd4bf0ff9..f71a2eade04a 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -20,6 +20,8 @@
 
 #include <asm/barrier.h>
 
+#include "io-pgtable-arm.h"
+
 #define ARM_LPAE_MAX_ADDR_BITS		52
 #define ARM_LPAE_S2_MAX_CONCAT_PAGES	16
 #define ARM_LPAE_MAX_LEVELS		4
@@ -100,23 +102,6 @@
 #define ARM_LPAE_PTE_MEMATTR_DEV	(((arm_lpae_iopte)0x1) << 2)
 
 /* Register bits */
-#define ARM_LPAE_TCR_TG0_4K		0
-#define ARM_LPAE_TCR_TG0_64K		1
-#define ARM_LPAE_TCR_TG0_16K		2
-
-#define ARM_LPAE_TCR_TG1_16K		1
-#define ARM_LPAE_TCR_TG1_4K		2
-#define ARM_LPAE_TCR_TG1_64K		3
-
-#define ARM_LPAE_TCR_SH_NS		0
-#define ARM_LPAE_TCR_SH_OS		2
-#define ARM_LPAE_TCR_SH_IS		3
-
-#define ARM_LPAE_TCR_RGN_NC		0
-#define ARM_LPAE_TCR_RGN_WBWA		1
-#define ARM_LPAE_TCR_RGN_WT		2
-#define ARM_LPAE_TCR_RGN_WB		3
-
 #define ARM_LPAE_VTCR_SL0_MASK		0x3
 
 #define ARM_LPAE_TCR_T0SZ_SHIFT		0
@@ -124,14 +109,6 @@
 #define ARM_LPAE_VTCR_PS_SHIFT		16
 #define ARM_LPAE_VTCR_PS_MASK		0x7
 
-#define ARM_LPAE_TCR_PS_32_BIT		0x0ULL
-#define ARM_LPAE_TCR_PS_36_BIT		0x1ULL
-#define ARM_LPAE_TCR_PS_40_BIT		0x2ULL
-#define ARM_LPAE_TCR_PS_42_BIT		0x3ULL
-#define ARM_LPAE_TCR_PS_44_BIT		0x4ULL
-#define ARM_LPAE_TCR_PS_48_BIT		0x5ULL
-#define ARM_LPAE_TCR_PS_52_BIT		0x6ULL
-
 #define ARM_LPAE_MAIR_ATTR_SHIFT(n)	((n) << 3)
 #define ARM_LPAE_MAIR_ATTR_MASK		0xff
 #define ARM_LPAE_MAIR_ATTR_DEVICE	0x04
diff --git a/MAINTAINERS b/MAINTAINERS
index ecc0749810b0..4ff7b9a5bb7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1463,8 +1463,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/iommu/arm,smmu*
 F:	drivers/iommu/arm-smmu*
-F:	drivers/iommu/io-pgtable-arm-v7s.c
-F:	drivers/iommu/io-pgtable-arm.c
+F:	drivers/iommu/io-pgtable-arm*
 
 ARM SUB-ARCHITECTURES
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.26.2

