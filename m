Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565551BFEC9
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 16:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgD3Okp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 10:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728284AbgD3Okp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 10:40:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A0DC035494
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g12so2207559wmh.3
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5zUk9NV0nU5TmSz+uWZW+0J3z6ZO8c45bE/F41UldBY=;
        b=hdTx9q9/ZBbgUC8/ufZMC68Zeis9W/RYxXDui8aFftSuMllKim0WGr4wx8hjminehP
         w1g/QaD2kaDN7e4b/Oot4dMemmy6yU9/xYXZzDgPDqvydC0M+3O369m72jEiXRiwoh4Q
         i9sPe28+qOx1cVjOwtZfZAPHopc0wdyPkjIQIMQ2c7FH+MZaoaRXEYOgYTEQXDFsaKUR
         fnu9Ofq0Ad+jqiOB9RX3dVIfO3pE3uTEbw4YMKfVwEHw08Ev0DJweclrvLf+op6gOheV
         b6oa+L4yDKBH7DkfS+f+u0eVik2GiUJxKykIvfc4MOaWRpfZjXdvgAuODWilHbJw3q8r
         Gh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5zUk9NV0nU5TmSz+uWZW+0J3z6ZO8c45bE/F41UldBY=;
        b=VuzMj3PTMJZuPqMHi5cS7Ugwpa0uuB8a1otpXu08rf5TMhpQIfd31U7/2jLsXZL0E2
         dbf+fQJr4/xQHlo9weIbr8MRLNsSUI7kXgeo62E6fx9wme0XsZ34MvfHcL7NGw4r1ihL
         /nwgq/CD3DLddn7HIPtQit+HWieaK7R9oWPIybLSxiPyw06gN0OyDAqIY4Z4ssbXA9g3
         92KgNsgyGzvyvUYDGTef0kd8Jf+XC/Dvndfybqc5Vde7qNGFdIUd/JYC2Ux/yuykK1lU
         5gQWaPRGOnPSP+PlCj3yOl9MDw5szy/dOJDRYK459rE//mO5rwgFR+S2m5PxRcDuPKmL
         J1Ag==
X-Gm-Message-State: AGi0Pua+KF8h9lsA285O865ZWTJUnfb3q84zhTfPjQCbuEvVXiGmiblX
        jwp8DB1uyCWJiKOOfMiYXAyEsg==
X-Google-Smtp-Source: APiQypLYnxQfwV9vUitaM0N+BAtQ0WTyZbQIbMQN53sHeaH1WhNxiOl1IRhWF/dZdB3Dd06HM1dwfw==
X-Received: by 2002:a1c:32c7:: with SMTP id y190mr3503540wmy.13.1588257640161;
        Thu, 30 Apr 2020 07:40:40 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:40:39 -0700 (PDT)
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
Subject: [PATCH v6 18/25] iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops
Date:   Thu, 30 Apr 2020 16:34:17 +0200
Message-Id: <20200430143424.2787566-19-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430143424.2787566-1-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The invalidate_range() notifier is called for any change to the address
space. Perform the required ATC invalidations.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 56 ++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 00e5b69bb81a5..c65937d953b5f 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -742,7 +742,7 @@ struct arm_smmu_mmu_notifier {
 	struct arm_smmu_ctx_desc	*cd;
 	bool				cleared;
 	refcount_t			refs;
-	struct arm_smmu_domain		*domain;
+	struct arm_smmu_domain __rcu	*domain;
 };
 
 #define mn_to_smmu(mn) container_of(mn, struct arm_smmu_mmu_notifier, mn)
@@ -2396,6 +2396,20 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 	size_t inval_grain_shift = 12;
 	unsigned long page_start, page_end;
 
+	/*
+	 * ATS and PASID:
+	 *
+	 * If substream_valid is clear, the PCIe TLP is sent without a PASID
+	 * prefix. In that case all ATC entries within the address range are
+	 * invalidated, including those that were requested with a PASID! There
+	 * is no way to invalidate only entries without PASID.
+	 *
+	 * When using STRTAB_STE_1_S1DSS_SSID0 (reserving CD 0 for non-PASID
+	 * traffic), translation requests without PASID create ATC entries
+	 * without PASID, which must be invalidated with substream_valid clear.
+	 * This has the unpleasant side-effect of invalidating all PASID-tagged
+	 * ATC entries within the address range.
+	 */
 	*cmd = (struct arm_smmu_cmdq_ent) {
 		.opcode			= CMDQ_OP_ATC_INV,
 		.substream_valid	= !!ssid,
@@ -2439,12 +2453,12 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 	cmd->atc.size	= log2_span;
 }
 
-static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
+static int arm_smmu_atc_inv_master(struct arm_smmu_master *master, int ssid)
 {
 	int i;
 	struct arm_smmu_cmdq_ent cmd;
 
-	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
+	arm_smmu_atc_inv_to_cmd(ssid, 0, 0, &cmd);
 
 	for (i = 0; i < master->num_sids; i++) {
 		cmd.atc.sid = master->sids[i];
@@ -2958,7 +2972,7 @@ static void arm_smmu_disable_ats(struct arm_smmu_master *master)
 	 * ATC invalidation via the SMMU.
 	 */
 	wmb();
-	arm_smmu_atc_inv_master(master);
+	arm_smmu_atc_inv_master(master, 0);
 	atomic_dec(&smmu_domain->nr_ats_masters);
 }
 
@@ -3187,7 +3201,22 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 					 struct mm_struct *mm,
 					 unsigned long start, unsigned long end)
 {
-	/* TODO: invalidate ATS */
+	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
+	struct arm_smmu_domain *smmu_domain;
+
+	rcu_read_lock();
+	smmu_domain = rcu_dereference(smmu_mn->domain);
+	if (smmu_domain) {
+		/*
+		 * Ensure that mm->pasid is valid. Pairs with the
+		 * smp_store_release() from rcu_assign_pointer() in
+		 * __arm_smmu_sva_bind()
+		 */
+		smp_rmb();
+		arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start,
+					end - start + 1);
+	}
+	rcu_read_unlock();
 }
 
 static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -3201,7 +3230,8 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 		return;
 	}
 
-	smmu_domain = smmu_mn->domain;
+	smmu_domain = rcu_dereference_protected(smmu_mn->domain,
+			lockdep_is_held(&arm_smmu_sva_lock));
 
 	/*
 	 * DMA may still be running. Keep the cd valid but disable
@@ -3210,7 +3240,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, &invalid_cd);
 
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
-	/* TODO: invalidate ATS */
+	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
 
 	smmu_mn->cleared = true;
 	mutex_unlock(&arm_smmu_sva_lock);
@@ -3251,7 +3281,8 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 		return ERR_CAST(mn);
 
 	smmu_mn = mn_to_smmu(mn);
-	if (smmu_mn->domain)
+	if (rcu_dereference_protected(smmu_mn->domain,
+				      lockdep_is_held(&arm_smmu_sva_lock)))
 		refcount_inc(&smmu_mn->refs);
 
 	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
@@ -3277,7 +3308,11 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 
 	bond->sva.dev = dev;
 	list_add(&bond->list, &master->bonds);
-	smmu_mn->domain = smmu_domain;
+	/*
+	 * Initialize domain last, since the invalidate() notifier assumes a
+	 * valid mm->pasid after fetching a valid domain.
+	 */
+	rcu_assign_pointer(smmu_mn->domain, smmu_domain);
 	return &bond->sva;
 
 err_free_pasid:
@@ -3318,7 +3353,8 @@ static void __arm_smmu_sva_unbind(struct iommu_sva *handle)
 		if (!smmu_mn->cleared) {
 			arm_smmu_tlb_inv_asid(smmu_domain->smmu,
 					      smmu_mn->cd->asid);
-			/* TODO: invalidate ATS */
+			arm_smmu_atc_inv_domain(smmu_domain, bond->mm->pasid,
+						0, 0);
 		}
 	}
 
-- 
2.26.2

