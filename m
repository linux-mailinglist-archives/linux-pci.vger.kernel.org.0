Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9631D9E8D
	for <lists+linux-pci@lfdr.de>; Tue, 19 May 2020 20:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgESSCD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 May 2020 14:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgESSCD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2020 14:02:03 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFEBC08C5C0
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 11:02:02 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w64so200981wmg.4
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 11:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NGZBqF0MKtBmW3+eHctFURo6Y3LrBwBhNb0YCIPd+HA=;
        b=GIa5rX/V8vIRUfbiSlnvp1rb1ufNakvQ3BYq7CuxJ+6y04cFET10DnyGSuz8dr3ewS
         JGseTTPXmL7lwcTCfvuDUhqkNilVMaDjuQ//i6hqiluDgcT0daJQF0ZXvlOgKbk9wkOW
         1jRPjJj48+VVv/cC08UVBJb93oXj9wXN1497znOMJqUBmpgLrzIA+Ph396uYjUQPVZbX
         AIaX+B5fwrmyfAF/BmsLI+gJYujooLP1Tp7H/jLQePAYx8ysxfvr0p+lJL0LQfiJWnwA
         B4yKFupzyAMy9bWEGLeMFauoiCf9VF4iQMiMpH4CwZAX+jVasWUxjcfoRlCPBeIBUx3y
         3+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NGZBqF0MKtBmW3+eHctFURo6Y3LrBwBhNb0YCIPd+HA=;
        b=WtIKV0DhkfgUB16tygK2iP3a/3DN8DVH2HWe38XL96hNTQPfKC96Fz3/YVaLdChPij
         NJpVcS+sBPJyvMgUFkk1pNHBJirJw2HuqEnzuhjx80Grmf8a4xPtGWLWb0qywsvbtbf4
         2Zf2+Y3vV4edAN0yCgHXpSoSJjxVOUGNItrW4j0QgNxXKlXWqKqlnJhHtNYYsq4elfMr
         UZ9n8C0o0K/L/vBNrpxnAdeDk3AiOy5o4SFmMaaUj8EKl8XRgTiaIKN439MPR5WXHili
         5vew3FBEFDUZeEagyERYnSe03uDzJUgFPdZy/FcV5Dn2Tjgrs8TdVRUpfvY6pySgo5gS
         YBfw==
X-Gm-Message-State: AOAM533K61IL2fTqhbpTovYnpk5EpD4eXQBg/i+t4V/vlbmgiS/pBahY
        T9VambEUULqdAG2PiOPOjvQjYQ==
X-Google-Smtp-Source: ABdhPJzkEAJ1N27WjhAzpGiM0SWJrYRN6tSSh0kfb4HAwQvH5gMWf60VDilJ/HWg5+gL5FnDijwbkw==
X-Received: by 2002:a1c:49:: with SMTP id 70mr569224wma.184.1589911321556;
        Tue, 19 May 2020 11:02:01 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id 1sm510496wmz.13.2020.05.19.11.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:02:01 -0700 (PDT)
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
Subject: [PATCH v7 17/24] iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops
Date:   Tue, 19 May 2020 19:54:55 +0200
Message-Id: <20200519175502.2504091-18-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519175502.2504091-1-jean-philippe@linaro.org>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
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
v6->v7: invalidate() doesn't need RCU protection anymore.
---
 drivers/iommu/arm-smmu-v3.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 00a9342eed99..1386d4d2bc60 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2392,6 +2392,20 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
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
@@ -2435,12 +2449,12 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
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
@@ -2968,7 +2982,7 @@ static void arm_smmu_disable_ats(struct arm_smmu_master *master)
 	 * ATC invalidation via the SMMU.
 	 */
 	wmb();
-	arm_smmu_atc_inv_master(master);
+	arm_smmu_atc_inv_master(master, 0);
 	atomic_dec(&smmu_domain->nr_ats_masters);
 }
 
@@ -3169,7 +3183,10 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 					 struct mm_struct *mm,
 					 unsigned long start, unsigned long end)
 {
-	/* TODO: invalidate ATS */
+	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
+
+	arm_smmu_atc_inv_domain(smmu_mn->domain, mm->pasid, start,
+				end - start + 1);
 }
 
 static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -3190,7 +3207,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, &invalid_cd);
 
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
-	/* TODO: invalidate ATS */
+	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
 
 	smmu_mn->cleared = true;
 	mutex_unlock(&sva_lock);
@@ -3281,7 +3298,7 @@ void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	 */
 	if (!smmu_mn->cleared) {
 		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
-		/* TODO: invalidate ATS */
+		arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
 	}
 
 	/* Frees smmu_mn */
-- 
2.26.2

