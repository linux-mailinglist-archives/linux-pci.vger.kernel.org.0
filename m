Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FE41A86BF
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 19:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391518AbgDNREu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 13:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391553AbgDNREp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2020 13:04:45 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03640C061A10
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d27so6044229wra.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iFQo4eLK0C51ieV33vlbkwWvrpzk0Iu0nUGg4g65CHs=;
        b=JI5QkA97eezOSapi2fPqRY+esAG4E9fuADRTO9KkwAXqshRxQg2LKwGOVpQ8bEJ81f
         7XPxMj7271i5R78HnNq28pZSLk3B7jV9yN0c4/bTfJRpnWpYm9Lt2jtqPzuqS2HV02Z2
         hkq9kvDb8FIDY1FaOeaNgULZXDgiAcMd9YqMGytbbSvWq4fOyoPZG5zIKdYtbwIwjSXa
         /p9Mczkd/c2xupqo0EB5V5OSAvg3O/E1/F5JPD2SgV6IMuTc6+yiI7lkQVerTEvPWxXm
         XspXwZKvxZ42rz0b7zJEQWuYEyF6WUnRsl/SYo5BgSVSgOvKFQDMOtkvWsn7y2Hxn6V5
         9ulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iFQo4eLK0C51ieV33vlbkwWvrpzk0Iu0nUGg4g65CHs=;
        b=sRQums5bLzKUcvvfQCVJJQE7mh13J8z6oUp9mZ9mWXa2w6sNh/YmgTYPoU+cj9mFXC
         MCesAjzsKGxIxeQjv1UrIbvrl0GRFQgN7geQrtmENPO4JZmusiiR3oXfk8uYITJ4KeRi
         frb6Ats8dUVxplj6kNOkjRLd6cc3Lf14VowDJwzPdahQVXCLc3FprlXHpLoK6c3xHue5
         SKCdx497khoQh/2aAUTj4yHLmpEGjQiMUaDVOSdlnzsM2jWawmccXwsyjHj/aomFqVjk
         TCp+SBEw4U8TPTRM/Aq/iLDI3Q39gDj+ipmiVwK0S60J7Epf4zPjaKu+blUppiCON71T
         XM5Q==
X-Gm-Message-State: AGi0PuYNwxZMIg9EIlGRJPVfRUosPIjj4ldj06ZCCMcwCx9ZD3vdgik/
        yn8+Cwc3Cx9nWT//DaYCVQQ8fw==
X-Google-Smtp-Source: APiQypLZa+lawPw64nTDrcMPpw0HQPprW6BlaWllx/hPptH94lEGFoejVXa1lUE2ugeNThH+6x6yTQ==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr23364377wrp.327.1586883883718;
        Tue, 14 Apr 2020 10:04:43 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:04:43 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v5 18/25] iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops
Date:   Tue, 14 Apr 2020 19:02:46 +0200
Message-Id: <20200414170252.714402-19-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

iommu-sva calls us when an mm is modified. Perform the required ATC
invalidations.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v4->v5: more comments
---
 drivers/iommu/arm-smmu-v3.c | 70 ++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 6640c2ac2a7c5..c4bffb14461aa 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2375,6 +2375,20 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
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
@@ -2418,12 +2432,12 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
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
@@ -2934,7 +2948,7 @@ static void arm_smmu_disable_ats(struct arm_smmu_master *master)
 	 * ATC invalidation via the SMMU.
 	 */
 	wmb();
-	arm_smmu_atc_inv_master(master);
+	arm_smmu_atc_inv_master(master, 0);
 	atomic_dec(&smmu_domain->nr_ats_masters);
 }
 
@@ -3131,7 +3145,22 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 static void arm_smmu_mm_invalidate(struct device *dev, int pasid, void *entry,
 				   unsigned long iova, size_t size)
 {
-	/* TODO: Invalidate ATC */
+	int i;
+	struct arm_smmu_cmdq_ent cmd;
+	struct arm_smmu_cmdq_batch cmds = {};
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	if (!master->ats_enabled)
+		return;
+
+	arm_smmu_atc_inv_to_cmd(pasid, iova, size, &cmd);
+
+	for (i = 0; i < master->num_sids; i++) {
+		cmd.atc.sid = master->sids[i];
+		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
+	}
+
+	arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
 }
 
 static int arm_smmu_mm_attach(struct device *dev, int pasid, void *entry,
@@ -3168,26 +3197,43 @@ static void arm_smmu_mm_clear(struct device *dev, int pasid, void *entry)
 	 * for this ASID, so we need to do it manually.
 	 */
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
-
-	/* TODO: invalidate ATC */
+	arm_smmu_atc_inv_domain(smmu_domain, pasid, 0, 0);
 }
 
 static void arm_smmu_mm_detach(struct device *dev, int pasid, void *entry,
 			       bool detach_domain, bool cleared)
 {
 	struct arm_smmu_ctx_desc *cd = entry;
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
-	if (detach_domain) {
+	if (detach_domain)
 		arm_smmu_write_ctx_desc(smmu_domain, pasid, NULL);
 
-		if (!cleared)
-			/* See comment in arm_smmu_mm_clear() */
-			arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
-	}
+	/*
+	 * If we went through clear(), we've already invalidated, and no new TLB
+	 * entry can have been formed.
+	 */
+	if (cleared)
+		return;
+
+	if (detach_domain) {
+		/* See comment in arm_smmu_mm_clear() */
+		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
+		arm_smmu_atc_inv_domain(smmu_domain, pasid, 0, 0);
 
-	/* TODO: invalidate ATC */
+	} else if (master->ats_enabled) {
+		/*
+		 * There are more devices bound with this PASID in this domain,
+		 * so we cannot yet clear the PASID entry, and this device could
+		 * create new ATC entries. Invalidate the ATC for the sake of
+		 * it. On unbinding the last device we'll properly invalidate
+		 * all ATCs in the domain. Alternatively, an early detach_dev()
+		 * on this device will also flush the ATC.
+		 */
+		arm_smmu_atc_inv_master(master, pasid);
+	}
 }
 
 static void *arm_smmu_mm_alloc(struct mm_struct *mm)
-- 
2.26.0

