Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AB01D9E98
	for <lists+linux-pci@lfdr.de>; Tue, 19 May 2020 20:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgESSCF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 May 2020 14:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgESSCF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2020 14:02:05 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7635C08C5C0
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 11:02:03 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k13so426472wrx.3
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 11:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fg8dmjPt1ph2YrEH+2TlM2jE9Xe96yZybVcxaHnAkA0=;
        b=K/TabPRrtSWRAQ8LXcijRuJOve7Tq3nGl34UfEWB0FFTlEq6ZM5hQ39eTft3KR8VFX
         tYj4YAy/8VDecjXA3Nm7axX05bTsbZ0mfsWekrw+XvU7lcpYO5YWjd46wmytl8WW6a+k
         Z//gWmucZD2sLlF6urGmcRdUkCoMDQ/cMlx4drtCEFQ/FhB++ucmI3zsJWWXu1WORVq6
         fSYvtpoQVvNqEKXGhlCwMf9sPLGWN1SdT+y8alAtOYcDh9cMEfbKbOVHb4iMaL35u4Vj
         HU1EqI7zhjzvIkF85VQI5/VV+8/e5baagldL+gSbhByLf6w1ZC6mcq4w3m7E/HM07fC6
         fjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fg8dmjPt1ph2YrEH+2TlM2jE9Xe96yZybVcxaHnAkA0=;
        b=IDmDENI2mWF0a4YZMZpbH8mmUb8McHL62wDZJn4qiAONNobU4ofhIRoEy9HBByVe7e
         zZBpocbdjYBsxR/4DtUDXPqAnj+NLKQZoiWznHviMW/LGXhOAnKzfGLvn7fY+/fK+hmZ
         xPd/gujwAYWg4wRZ9jsD18gBCOnC9VgGFo41Gl6vCT33XC6W4HfUNzbP/Ydmx+fZvSvW
         ydVb8lbRWqSw5mPiSUTIZxT3a/DNPgq9ymEuIMOXmuDi5dYwt3/8CTQ7rMBPXXr7FyBW
         7i55oL9GhDsubXWR4XdGwyAu0VuZn0dvNGa7V6PAhoKxyS+chViXUzA1+loMgupE5i/u
         4nCA==
X-Gm-Message-State: AOAM530q/SlFLmlTmfTrc2VSCzBHw63342+RKuGqbY6f9URSZyf2fJ5d
        QPsOsF2g6cwaG2NQdYQy0syi2A==
X-Google-Smtp-Source: ABdhPJyzkXmiYxNm30l0xsYDmklGny2bG167UWZuisgXBYPv8wqLmD/PLaUZ75RNeRP8Sz1G3zk17w==
X-Received: by 2002:a5d:6388:: with SMTP id p8mr69668wru.369.1589911322694;
        Tue, 19 May 2020 11:02:02 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id 1sm510496wmz.13.2020.05.19.11.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:02:02 -0700 (PDT)
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
Subject: [PATCH v7 18/24] iommu/arm-smmu-v3: Add support for Hardware Translation Table Update
Date:   Tue, 19 May 2020 19:54:56 +0200
Message-Id: <20200519175502.2504091-19-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519175502.2504091-1-jean-philippe@linaro.org>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the SMMU supports it and the kernel was built with HTTU support,
enable hardware update of access and dirty flags. This is essential for
shared page tables, to reduce the number of access faults on the fault
queue. Normal DMA with io-pgtables doesn't currently use the access or
dirty flags.

We can enable HTTU even if CPUs don't support it, because the kernel
always checks for HW dirty bit and updates the PTE flags atomically.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 1386d4d2bc60..6a368218f54c 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -58,6 +58,8 @@
 #define IDR0_ASID16			(1 << 12)
 #define IDR0_ATS			(1 << 10)
 #define IDR0_HYP			(1 << 9)
+#define IDR0_HD				(1 << 7)
+#define IDR0_HA				(1 << 6)
 #define IDR0_BTM			(1 << 5)
 #define IDR0_COHACC			(1 << 4)
 #define IDR0_TTF			GENMASK(3, 2)
@@ -311,6 +313,9 @@
 #define CTXDESC_CD_0_TCR_IPS		GENMASK_ULL(34, 32)
 #define CTXDESC_CD_0_TCR_TBI0		(1ULL << 38)
 
+#define CTXDESC_CD_0_TCR_HA		(1UL << 43)
+#define CTXDESC_CD_0_TCR_HD		(1UL << 42)
+
 #define CTXDESC_CD_0_AA64		(1UL << 41)
 #define CTXDESC_CD_0_S			(1UL << 44)
 #define CTXDESC_CD_0_R			(1UL << 45)
@@ -663,6 +668,8 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_E2H		(1 << 16)
 #define ARM_SMMU_FEAT_BTM		(1 << 17)
 #define ARM_SMMU_FEAT_SVA		(1 << 18)
+#define ARM_SMMU_FEAT_HA		(1 << 19)
+#define ARM_SMMU_FEAT_HD		(1 << 20)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -1718,10 +1725,17 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 		 * this substream's traffic
 		 */
 	} else { /* (1) and (2) */
+		u64 tcr = cd->tcr;
+
 		cdptr[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
 		cdptr[2] = 0;
 		cdptr[3] = cpu_to_le64(cd->mair);
 
+		if (!(smmu->features & ARM_SMMU_FEAT_HD))
+			tcr &= ~CTXDESC_CD_0_TCR_HD;
+		if (!(smmu->features & ARM_SMMU_FEAT_HA))
+			tcr &= ~CTXDESC_CD_0_TCR_HA;
+
 		/*
 		 * STE is live, and the SMMU might read dwords of this CD in any
 		 * order. Ensure that it observes valid values before reading
@@ -1729,7 +1743,7 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 		 */
 		arm_smmu_sync_cd(smmu_domain, ssid, true);
 
-		val = cd->tcr |
+		val = tcr |
 #ifdef __BIG_ENDIAN
 			CTXDESC_CD_0_ENDI |
 #endif
@@ -1958,10 +1972,12 @@ static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
 		return old_cd;
 	}
 
+	/* HA and HD will be filtered out later if not supported by the SMMU */
 	tcr = FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, 64ULL - VA_BITS) |
 	      FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, ARM_LPAE_TCR_RGN_WBWA) |
 	      FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, ARM_LPAE_TCR_RGN_WBWA) |
 	      FIELD_PREP(CTXDESC_CD_0_TCR_SH0, ARM_LPAE_TCR_SH_IS) |
+	      CTXDESC_CD_0_TCR_HA | CTXDESC_CD_0_TCR_HD |
 	      CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
 
 	switch (PAGE_SIZE) {
@@ -4454,6 +4470,12 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 			smmu->features |= ARM_SMMU_FEAT_E2H;
 	}
 
+	if (reg & (IDR0_HA | IDR0_HD)) {
+		smmu->features |= ARM_SMMU_FEAT_HA;
+		if (reg & IDR0_HD)
+			smmu->features |= ARM_SMMU_FEAT_HD;
+	}
+
 	/*
 	 * If the CPU is using VHE, but the SMMU doesn't support it, the SMMU
 	 * will create TLB entries for NH-EL1 world and will miss the
-- 
2.26.2

