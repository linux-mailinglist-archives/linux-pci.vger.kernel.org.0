Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4D9C16AECC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 19:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgBXSYn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 13:24:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53540 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgBXSYn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 13:24:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id s10so310546wmh.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 10:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HvIb5a5WLdlhrkNjCFl6MOBB1+T6U04UZ4IR7hmYWK0=;
        b=SPcwqoV7lGB2oL/3/rsAiA0ayQ0NoctvatW9Q7DXlc59+EEY3mjcaCGfm83ITfM1xg
         oxOsFOJhXr4PvY6JgAPnGjaLnN4qG/rvSM79UwAdvo4NXNPWZHmsrbWC6mXO0ONXyqIZ
         9V1XemAMVGTZbBVDgy5MF+XLRcU6ZKpmny66D8SUmskWYbauZ53u9qrnqU1F8VdMyJQQ
         1nMRDnlTnjSOGzjVA95xQ0KtPertnohu0p8Q8xU3RXpS2Exc2DBIOIdgzmvrN8/uyP5b
         /gjNnlQbrFmXL3w0f84TXmo2bcxf6O4VGf5HWxQ3BzRscLJSM+dGNiqtEigtYaMCPc60
         sM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HvIb5a5WLdlhrkNjCFl6MOBB1+T6U04UZ4IR7hmYWK0=;
        b=bRLS8+Ol09fffw9NmzkPng/He6DiIPN5Pl3mkILxSLyUOJeblPUlttYoUNPO0kT3OL
         rQeCJcktwQ8wCs/TU/VE1VuBuFczn5myxsZAF9FZUD7Q8OaliZl4j/LAsw5TIsYREEIj
         BNJq1r362etGVLiZRFb/fGoHEV6BAh1/odkZdgF60+barv1nHn0aNgRTrXOW14q5AtLo
         y2V7rH7qGA6CaXr3yqJfFWDjW940EIrUDgzBD8Wc0mbgvFglBm736Qc9PHz/d9nPWbSh
         CH71whJhhJK4wjR0NmnGKbIyIJpN5qwX8N4Lt5MxJpUMbAppE+eq6yqD/w/XUWM922og
         eraA==
X-Gm-Message-State: APjAAAVPn25/HZ5TF/gY8gPOPzkx/F7YkyyFz+f2eNh7S2kPgbCdYp1e
        uRYiRrDKxaWeNQ1OyJTZrd8Kzw==
X-Google-Smtp-Source: APXvYqznJOIqbRFJKt6oPPVj99H38141DBd5j/HtYxvRfv5tpgtK3N+1x93avzLJhmua44A15FW55Q==
X-Received: by 2002:a1c:2089:: with SMTP id g131mr291161wmg.63.1582568681562;
        Mon, 24 Feb 2020 10:24:41 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:24:41 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
        kevin.tian@intel.com, baolu.lu@linux.intel.com,
        Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, yi.l.liu@intel.com,
        zhangfei.gao@linaro.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH v4 11/26] iommu/arm-smmu-v3: Share process page tables
Date:   Mon, 24 Feb 2020 19:23:46 +0100
Message-Id: <20200224182401.353359-12-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224182401.353359-1-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

With Shared Virtual Addressing (SVA), we need to mirror CPU TTBR, TCR,
MAIR and ASIDs in SMMU contexts. Each SMMU has a single ASID space split
into two sets, shared and private. Shared ASIDs correspond to those
obtained from the arch ASID allocator, and private ASIDs are used for
"classic" map/unmap DMA.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 164 +++++++++++++++++++++++++++++++++++-
 1 file changed, 160 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 7737b70e74cd..3f9adfd1b015 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -22,6 +22,7 @@
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/mmu_context.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -33,6 +34,8 @@
 
 #include <linux/amba/bus.h>
 
+#include "io-pgtable-arm.h"
+
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
 #define IDR0_ST_LVL			GENMASK(28, 27)
@@ -575,6 +578,9 @@ struct arm_smmu_ctx_desc {
 	u64				ttbr;
 	u64				tcr;
 	u64				mair;
+
+	refcount_t			refs;
+	struct mm_struct		*mm;
 };
 
 struct arm_smmu_l1_ctx_desc {
@@ -1639,7 +1645,8 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 #ifdef __BIG_ENDIAN
 			CTXDESC_CD_0_ENDI |
 #endif
-			CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET |
+			CTXDESC_CD_0_R | CTXDESC_CD_0_A |
+			(cd->mm ? 0 : CTXDESC_CD_0_ASET) |
 			CTXDESC_CD_0_AA64 |
 			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
 			CTXDESC_CD_0_V;
@@ -1743,12 +1750,159 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
 	cdcfg->cdtab = NULL;
 }
 
-static void arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd)
+static void arm_smmu_init_cd(struct arm_smmu_ctx_desc *cd)
 {
+	refcount_set(&cd->refs, 1);
+}
+
+static bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd)
+{
+	bool free;
+	struct arm_smmu_ctx_desc *old_cd;
+
 	if (!cd->asid)
-		return;
+		return false;
+
+	xa_lock(&asid_xa);
+	free = refcount_dec_and_test(&cd->refs);
+	if (free) {
+		old_cd = __xa_erase(&asid_xa, cd->asid);
+		WARN_ON(old_cd != cd);
+	}
+	xa_unlock(&asid_xa);
+	return free;
+}
+
+static struct arm_smmu_ctx_desc *arm_smmu_share_asid(u16 asid)
+{
+	struct arm_smmu_ctx_desc *cd;
+
+	cd = xa_load(&asid_xa, asid);
+	if (!cd)
+		return NULL;
 
-	xa_erase(&asid_xa, cd->asid);
+	if (cd->mm) {
+		/*
+		 * It's pretty common to find a stale CD when doing unbind-bind,
+		 * given that the release happens after a RCU grace period.
+		 * arm_smmu_free_asid() hasn't gone through yet, so reuse it.
+		 */
+		refcount_inc(&cd->refs);
+		return cd;
+	}
+
+	/*
+	 * Ouch, ASID is already in use for a private cd.
+	 * TODO: seize it.
+	 */
+	return ERR_PTR(-EEXIST);
+}
+
+__maybe_unused
+static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
+{
+	u16 asid;
+	int ret = 0;
+	u64 tcr, par, reg;
+	struct arm_smmu_ctx_desc *cd;
+	struct arm_smmu_ctx_desc *old_cd = NULL;
+
+	asid = mm_context_get(mm);
+	if (!asid)
+		return ERR_PTR(-ESRCH);
+
+	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
+	if (!cd) {
+		ret = -ENOMEM;
+		goto err_put_context;
+	}
+
+	arm_smmu_init_cd(cd);
+
+	xa_lock(&asid_xa);
+	old_cd = arm_smmu_share_asid(asid);
+	if (!old_cd) {
+		old_cd = __xa_store(&asid_xa, asid, cd, GFP_ATOMIC);
+		/*
+		 * Keep error, clear valid pointers. If there was an old entry
+		 * it has been moved already by arm_smmu_share_asid().
+		 */
+		old_cd = ERR_PTR(xa_err(old_cd));
+		cd->asid = asid;
+	}
+	xa_unlock(&asid_xa);
+
+	if (IS_ERR(old_cd)) {
+		ret = PTR_ERR(old_cd);
+		goto err_free_cd;
+	} else if (old_cd) {
+		if (WARN_ON(old_cd->mm != mm)) {
+			ret = -EINVAL;
+			goto err_free_cd;
+		}
+		kfree(cd);
+		mm_context_put(mm);
+		return old_cd;
+	}
+
+	tcr = FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, 64ULL - VA_BITS) |
+	      FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, ARM_LPAE_TCR_RGN_WBWA) |
+	      FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, ARM_LPAE_TCR_RGN_WBWA) |
+	      FIELD_PREP(CTXDESC_CD_0_TCR_SH0, ARM_LPAE_TCR_SH_IS) |
+	      CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
+
+	switch (PAGE_SIZE) {
+		case SZ_4K:
+			tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0,
+					  ARM_LPAE_TCR_TG0_4K);
+			break;
+		case SZ_16K:
+			tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0,
+					  ARM_LPAE_TCR_TG0_16K);
+			break;
+		case SZ_64K:
+			tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0,
+					  ARM_LPAE_TCR_TG0_64K);
+			break;
+		default:
+			WARN_ON(1);
+			ret = -EINVAL;
+			goto err_free_asid;
+	}
+
+	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	par = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
+	tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_IPS, par);
+
+	cd->ttbr = virt_to_phys(mm->pgd);
+	cd->tcr = tcr;
+	/*
+	 * MAIR value is pretty much constant and global, so we can just get it
+	 * from the current CPU register
+	 */
+	cd->mair = read_sysreg(mair_el1);
+
+	cd->mm = mm;
+
+	return cd;
+
+err_free_asid:
+	arm_smmu_free_asid(cd);
+err_free_cd:
+	kfree(cd);
+err_put_context:
+	mm_context_put(mm);
+	return ERR_PTR(ret);
+}
+
+__maybe_unused
+static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
+{
+	if (arm_smmu_free_asid(cd)) {
+		/* Unpin ASID */
+		mm_context_put(cd->mm);
+		kfree(cd);
+	}
 }
 
 /* Stream table manipulation functions */
@@ -2419,6 +2573,8 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
+	arm_smmu_init_cd(&cfg->cd);
+
 	ret = xa_alloc(&asid_xa, &asid, &cfg->cd,
 		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
 	if (ret)
-- 
2.25.0

