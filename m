Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878F41A86AB
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 19:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391339AbgDNREi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 13:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391371AbgDNREg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2020 13:04:36 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24451C061A0E
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:36 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so14905662wma.4
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s1HUs0+2Q+zc8r7u2INxKEDZQ5j1LlQHYTHQkt76NtE=;
        b=K4fkstqAPRERqVtNPbYsutxfsU9hH3mpIKCHec/HOXed4BamcKlHhkuXhGRIkumKp5
         0bWrGZsPu1P2TxKFJXeWCC5M2vw/iWLoTuwASyujA79foklyw7lYhBe9EqFB7VsQfIWW
         JTbVeyhOekx/h7lLAZanFA6Oz5DgfLjv/PIPCARjyTpZMRYEC8qgAeMk8WeF8cHIe49b
         Yoy0Hi20zrX3AcDlDuY3IeiklUkaB18PjR8/T7DXFBcaGG9a1fBe3FBII0KnBu64ccZ4
         WK8QBhqDRWARl0enZCw0TH73lx1LkC8Gd7HkDJojREUTYR7zIdZVXfizyRPAF3QKkbXF
         8LJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s1HUs0+2Q+zc8r7u2INxKEDZQ5j1LlQHYTHQkt76NtE=;
        b=QRF3sQEQtcTs6kP77hPtHRLCKLHyNuRdgZcIuY8kk7jCCpZ6WWRPUMuttF2AhQdpSj
         dZmbjW343NFr1/JWE320aQGALTrL+x8Pw6Z6vvna9rMQqgdazxPSrOrol4SDYvKOScrp
         3jnYTrJpbOjzHciAZdDjafP9INmr6PFnjIkYWy6r5TiFJfr3uEC33N4awNboi2gmQhYn
         XW7iyfXIMQWMwvQuEj3YY3mi7rfbpt8Yr41szCPyluuoECMXEDh72Xy0d2RfUAB0Ful7
         5hTPFBz7gM5KrVxBTd82uK+1aMFMWD1VACLqlbLdg4Lg6Cc+y7HcEMPQ3HhwLuGqTArf
         9TLQ==
X-Gm-Message-State: AGi0PubYEwHnhK4yzR/KlMD/hh+BZ07RpcnLOL9EQmw9d+I6i02I2sj2
        lDamQ7do+SyeNZpFE6OMvDd4Wg==
X-Google-Smtp-Source: APiQypKXCM6f7ZuYUh8Dyj9zYqP8uoDSuKBFCTPu9yhNG4YpLoxQAy4lexGTBWq20UC9ppvHQtp9eA==
X-Received: by 2002:a1c:a553:: with SMTP id o80mr736521wme.159.1586883874768;
        Tue, 14 Apr 2020 10:04:34 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:04:34 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 12/25] iommu/arm-smmu-v3: Share process page tables
Date:   Tue, 14 Apr 2020 19:02:40 +0200
Message-Id: <20200414170252.714402-13-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With Shared Virtual Addressing (SVA), we need to mirror CPU TTBR, TCR,
MAIR and ASIDs in SMMU contexts. Each SMMU has a single ASID space split
into two sets, shared and private. Shared ASIDs correspond to those
obtained from the arch ASID allocator, and private ASIDs are used for
"classic" map/unmap DMA.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 161 +++++++++++++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 96ee60002e85e..09f4f712fb103 100644
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
@@ -587,6 +590,9 @@ struct arm_smmu_ctx_desc {
 	u64				ttbr;
 	u64				tcr;
 	u64				mair;
+
+	refcount_t			refs;
+	struct mm_struct		*mm;
 };
 
 struct arm_smmu_l1_ctx_desc {
@@ -1660,7 +1666,8 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 #ifdef __BIG_ENDIAN
 			CTXDESC_CD_0_ENDI |
 #endif
-			CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET |
+			CTXDESC_CD_0_R | CTXDESC_CD_0_A |
+			(cd->mm ? 0 : CTXDESC_CD_0_ASET) |
 			CTXDESC_CD_0_AA64 |
 			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
 			CTXDESC_CD_0_V;
@@ -1764,12 +1771,156 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
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
+
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
+	case SZ_4K:
+		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_4K);
+		break;
+	case SZ_16K:
+		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_16K);
+		break;
+	case SZ_64K:
+		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_64K);
+		break;
+	default:
+		WARN_ON(1);
+		ret = -EINVAL;
+		goto err_free_asid;
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
 
-	xa_erase(&asid_xa, cd->asid);
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
@@ -2479,6 +2630,8 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
+	arm_smmu_init_cd(&cfg->cd);
+
 	ret = xa_alloc(&asid_xa, &asid, &cfg->cd,
 		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
 	if (ret)
-- 
2.26.0

