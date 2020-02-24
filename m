Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 617F316AEC6
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 19:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgBXSYq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 13:24:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53542 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgBXSYp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 13:24:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id s10so310607wmh.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 10:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KHws8PPyeoETs9MQxZkRIDY5PffBS7gRHL2ghOeKyiM=;
        b=J9A0ZfwW2Sg5Oi6rxq36ZRvJqnC+eT7pD0P717DYVO6/HFHQ95x+UxG3pT7JhyRRKq
         CdIF02uk2292tIngupeW/yBbUErtCxYmDRVo6/5y/bkWByPW3bThl1dFBPj02zswj4Jj
         qF1YBh2b5YpZCqRYchpXE+tX4M0bWn5d/yg2DE/0qXgJdRLQn7Jv41Au15O+H858/zQt
         czw8MaqmewR7TtTWraIWi2f/TynY8Vh/Nb1Xohjt8dZw13zDR/5E+o6/8wq/Q/qSoglg
         qTLXTok0ayNKInC5TtlxmZx8bCE3DudSWrwI0IGO3EVxbfrtz46cdYcJcsn41BOBbITL
         /gGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KHws8PPyeoETs9MQxZkRIDY5PffBS7gRHL2ghOeKyiM=;
        b=T/GlYW+v28vuXxkCZ+RtKPAh2fUFCAFjYG+oDahyCtk/sqoWXFBOfPA3zy5LKaywtX
         +/3pwh0Cch4c968vPXYxgDC27yhrzeqPf1epQge79K3vmFWvhgqE/vSA6FN9X3zpXheu
         8YhNvN/MD3E/sErz5dqqSPZLsZJwgzhTi9PgfWbbkj1Qh7jCjqFPwZZya3x9VbDcakwU
         ASo7Mk8nm2etfeH2NzP/2sTWm2jXoUYL5Y+CtqHYBdQvaBvWvfbF90c98jNzgGhrO10A
         JR5zXt1QTCx/GCeeWV3YekQXHbjAY2IMuYE+niV1sLtxPMWx6b1t09sE5PjwNa0xskqP
         XTrw==
X-Gm-Message-State: APjAAAXh3Sf/wTNwOwuu0bjqXT3FgOE30wsMvi/T12nF+C9obpzWlRi2
        iYxlUuJbRFGgM+A0kNMer0iD1g==
X-Google-Smtp-Source: APXvYqynW6kWyhnVaJWymOzWm/6YFP2jaUG27aS/Wip8UJw52RMXIUpjgeRxpypHFTwzOYwt3yNJ4A==
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr345249wmc.36.1582568682671;
        Mon, 24 Feb 2020 10:24:42 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:24:42 -0800 (PST)
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
Subject: [PATCH v4 12/26] iommu/arm-smmu-v3: Seize private ASID
Date:   Mon, 24 Feb 2020 19:23:47 +0100
Message-Id: <20200224182401.353359-13-jean-philippe@linaro.org>
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

The SMMU has a single ASID space, the union of shared and private ASID
sets. This means that the SMMU driver competes with the arch allocator
for ASIDs. Shared ASIDs are those of Linux processes, allocated by the
arch, and contribute in broadcast TLB maintenance. Private ASIDs are
allocated by the SMMU driver and used for "classic" map/unmap DMA. They
require explicit TLB invalidations.

When we pin down an mm_context and get an ASID that is already in use by
the SMMU, it belongs to a private context. We used to simply abort the
bind, but this is unfair to users that would be unable to bind a few
seemingly random processes. Try to allocate a new private ASID for the
context, and make the old ASID shared.

Introduce a new lock to prevent races when rewriting context
descriptors. Unfortunately it has to be a spinlock since we take it
while holding the asid lock, which will be held in non-sleepable context
(freeing ASIDs from an RCU callback).

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 83 +++++++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 3f9adfd1b015..2839527ec9ee 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -717,6 +717,7 @@ struct arm_smmu_option_prop {
 };
 
 static DEFINE_XARRAY_ALLOC1(asid_xa);
+static DEFINE_SPINLOCK(contexts_lock);
 
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
@@ -1513,6 +1514,17 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 }
 
 /* Context descriptor manipulation functions */
+static void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
+{
+	struct arm_smmu_cmdq_ent cmd = {
+		.opcode = CMDQ_OP_TLBI_NH_ASID,
+		.tlbi.asid = asid,
+	};
+
+	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+	arm_smmu_cmdq_issue_sync(smmu);
+}
+
 static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 			     int ssid, bool leaf)
 {
@@ -1547,7 +1559,7 @@ static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
 	size_t size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
 
 	l1_desc->l2ptr = dmam_alloc_coherent(smmu->dev, size,
-					     &l1_desc->l2ptr_dma, GFP_KERNEL);
+					     &l1_desc->l2ptr_dma, GFP_ATOMIC);
 	if (!l1_desc->l2ptr) {
 		dev_warn(smmu->dev,
 			 "failed to allocate context descriptor table\n");
@@ -1593,8 +1605,8 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
 	return l1_desc->l2ptr + idx * CTXDESC_CD_DWORDS;
 }
 
-static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
-				   int ssid, struct arm_smmu_ctx_desc *cd)
+static int __arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
+				     int ssid, struct arm_smmu_ctx_desc *cd)
 {
 	/*
 	 * This function handles the following cases:
@@ -1670,6 +1682,17 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
+static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
+				   int ssid, struct arm_smmu_ctx_desc *cd)
+{
+	int ret;
+
+	spin_lock(&contexts_lock);
+	ret = __arm_smmu_write_ctx_desc(smmu_domain, ssid, cd);
+	spin_unlock(&contexts_lock);
+	return ret;
+}
+
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 {
 	int ret;
@@ -1773,9 +1796,18 @@ static bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd)
 	return free;
 }
 
+/*
+ * Try to reserve this ASID in the SMMU. If it is in use, try to steal it from
+ * the private entry. Careful here, we may be modifying the context tables of
+ * another SMMU!
+ */
 static struct arm_smmu_ctx_desc *arm_smmu_share_asid(u16 asid)
 {
+	int ret;
+	u32 new_asid;
 	struct arm_smmu_ctx_desc *cd;
+	struct arm_smmu_device *smmu;
+	struct arm_smmu_domain *smmu_domain;
 
 	cd = xa_load(&asid_xa, asid);
 	if (!cd)
@@ -1791,11 +1823,31 @@ static struct arm_smmu_ctx_desc *arm_smmu_share_asid(u16 asid)
 		return cd;
 	}
 
+	smmu_domain = container_of(cd, struct arm_smmu_domain, s1_cfg.cd);
+	smmu = smmu_domain->smmu;
+
+	/*
+	 * Race with unmap: TLB invalidations will start targeting the new ASID,
+	 * which isn't assigned yet. We'll do an invalidate-all on the old ASID
+	 * later, so it doesn't matter.
+	 */
+	ret = __xa_alloc(&asid_xa, &new_asid, cd,
+			 XA_LIMIT(1, 1 << smmu->asid_bits), GFP_ATOMIC);
+	if (ret)
+		return ERR_PTR(-ENOSPC);
+	cd->asid = new_asid;
+
 	/*
-	 * Ouch, ASID is already in use for a private cd.
-	 * TODO: seize it.
+	 * Update ASID and invalidate CD in all associated masters. There will
+	 * be some overlap between use of both ASIDs, until we invalidate the
+	 * TLB.
 	 */
-	return ERR_PTR(-EEXIST);
+	arm_smmu_write_ctx_desc(smmu_domain, 0, cd);
+
+	/* Invalidate TLB entries previously associated with that context */
+	arm_smmu_tlb_inv_asid(smmu, asid);
+
+	return NULL;
 }
 
 __maybe_unused
@@ -2389,15 +2441,6 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cmdq_ent cmd;
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		cmd.opcode	= CMDQ_OP_TLBI_NH_ASID;
-		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
-		cmd.tlbi.vmid	= 0;
-	} else {
-		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
-		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
-	}
-
 	/*
 	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
 	 * PTEs previously cleared by unmaps on the current CPU not yet visible
@@ -2405,8 +2448,14 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	 * insertion to guarantee those are observed before the TLBI. Do be
 	 * careful, 007.
 	 */
-	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
-	arm_smmu_cmdq_issue_sync(smmu);
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+		arm_smmu_tlb_inv_asid(smmu, smmu_domain->s1_cfg.cd.asid);
+	} else {
+		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
+		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
+		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+		arm_smmu_cmdq_issue_sync(smmu);
+	}
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
 }
 
-- 
2.25.0

