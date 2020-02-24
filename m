Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 564F416AEBD
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 19:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgBXSYk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 13:24:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42489 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgBXSYj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 13:24:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id p18so7933598wre.9
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 10:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6tqcdrj1xZvDcY7k2ZzEJzD20ZqgKnIoPLeb93yl2Xc=;
        b=aDvzZHPt9iVEQwZJj1vud5mf/cCAG1jb3PpU0tPKkgnq9edj9bpqrHE6Eoktch/Wxe
         YkevW7vtCQ7o4zxdCRdqv7yvITCgSxf6H6szEOP+F3WE5Ip0NrJp+tBFY4ii8waFp1+G
         g6F0duX+U/X1mGeZhsHnDiBNc6YigoXnE6IXag4W7ySDFxe6VvcC+ni71ci5R9yuXX8R
         EIF3HXiiGiaQ+0ZIc7OclYDsNN6BvIE7UZlNby1PK/lZ5772P8Uf8yq5xCyAqHI7MCxu
         HvKguxhEpuIXgThDOS+/Ngh5iwPVr2umzGovygvcHO1ZCp3TmC3j/q2drow2O6jsDj8S
         bnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6tqcdrj1xZvDcY7k2ZzEJzD20ZqgKnIoPLeb93yl2Xc=;
        b=phncNy54b4lPncHc8WGZPCPoX8zSF+cKFB7c26E6lripsfog3m7LDqsibsdsLwEBIE
         CUplRRBU52pjljQyBuQB07b0x/vFnaeJk+zRhnpflPcxm7X2vZ3Q9yuttu1KLOiaVTz+
         YF+1GEvcoudoxAXtk8EVNuL1Q06Kmc+DdVSJGJKgHLTPlJ3dwyDcsNUEvVhgfAV9e1IV
         orYXSd6kNzZK3XHf98rEUKidHPoOY1JnsoXgYUcsqxkeeJ9gLkw9jFk3niXJ8MOso8G5
         gCy+e9xJGIaihfx2IRM3Uxq42F3B/J1mSNdGY/X/P54ub96dnyNOo9PpK7ssKCkBOFEC
         qx/A==
X-Gm-Message-State: APjAAAXSPIPNwAcpG36U+e1XzoCyohOuwSyXHAUiZTd1+9ZUnaufUIIU
        CQDZqhExsAZjeTKpGM/ODjTOkA==
X-Google-Smtp-Source: APXvYqweDyVog+lllJdgzOC5yFjqb0Y6Z6mnJXgAaaIz7bHvgd5fr5XnnlJkWPmoF4mmrIHnKf7dfA==
X-Received: by 2002:adf:fec4:: with SMTP id q4mr9813505wrs.368.1582568678393;
        Mon, 24 Feb 2020 10:24:38 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:24:38 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
        kevin.tian@intel.com, baolu.lu@linux.intel.com,
        Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, yi.l.liu@intel.com,
        zhangfei.gao@linaro.org
Subject: [PATCH v4 08/26] iommu/io-pgtable-arm: Move some definitions to a header
Date:   Mon, 24 Feb 2020 19:23:43 +0100
Message-Id: <20200224182401.353359-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224182401.353359-1-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
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
 drivers/iommu/io-pgtable-arm.c | 27 ++-------------------------
 drivers/iommu/io-pgtable-arm.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 25 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm.h

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 983b08477e64..75782b525c2f 100644
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
-- 
2.25.0

