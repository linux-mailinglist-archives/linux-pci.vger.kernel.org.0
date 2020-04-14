Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8087E1A86B0
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 19:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388403AbgDNREl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 13:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391390AbgDNREj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2020 13:04:39 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299C4C061A0C
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so14905812wma.4
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XYjzYLucwyMWs5ATd69ukU535fMinAQdw/Sa1FQ9874=;
        b=h9+T4NKlDIuEuOboHRkQ9VM5O6C305HktEqTd1ZjCrXyVdjGXpKMut+cm0j25dz8L8
         qED+RLh1oJwzxEXRlXzbxme6N1keKufeYV9dapDPQtGb3afujRsD37DcAqdUwlABi+kY
         6+AD1XXWqkoRRFGeAhAXRueOoV8MzRbnmuvkLQUNpXIZcveXEGWfkMnnceb6fPbrFvux
         k+IrqpGZ8iqZSSXdseYwd+fkjbxj05n2Va1tkNh5llSnOQ3uPgo2WjZy0jga6vHpGoLM
         ImtsA+n+pkrR86mvRcRxAaM8Z1T/E7yFwFVTV3O3UFgsvbJf2Prxmyrzb1TDgj8KqAPd
         Q+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XYjzYLucwyMWs5ATd69ukU535fMinAQdw/Sa1FQ9874=;
        b=qFqmqnXc7vj4J9ey38bdtLFXJvF5QuU6nGd5y6RpodDe0KrZrn0+TB4FHbY62hrW+p
         xxFXF+xR0oCjsTovfqEotaKDyaBBpGU2JVCr2CIl9wYpY6f++ZSC25UpP89kskEn7r/5
         tqWQ5jZm1QkUn8e23THtC6OdUP0K+Uqoswt3IKH96C8enNRO7lDZN++Gu1Tx07eQ9fVZ
         s5LDhKIrnGBL9y3uO0kZ9+m/WVucpBLvBH2Nzb8fgTnqDOtWnMTSIWy2LINy8Go66Axj
         FfFu+Hio/2yVfWyzzFA8pe4caNPJAvPUEJW3FmqoZAx4od5AIIPA2sSHpveP/cQUb6bE
         cXpw==
X-Gm-Message-State: AGi0PubSVodlzRjDnRlT8g9Kq4K5WKChr5czyNcW/NvK5cK4tHqBf7Mu
        vFko2TBdUa6DjAovx4AIiWIWhA==
X-Google-Smtp-Source: APiQypI7JCLr3IUyR+gNk8YroVsmo+Ju0KwL83AHQIeXPjqzPAV1RnhANqCP4fKquYyiz4/jl6+90g==
X-Received: by 2002:a7b:cc88:: with SMTP id p8mr777259wma.108.1586883876735;
        Tue, 14 Apr 2020 10:04:36 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:04:35 -0700 (PDT)
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
Subject: [PATCH v5 13/25] iommu/arm-smmu-v3: Seize private ASID
Date:   Tue, 14 Apr 2020 19:02:41 +0200
Message-Id: <20200414170252.714402-14-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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
index 09f4f712fb103..8fbc5da133ae4 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -730,6 +730,7 @@ struct arm_smmu_option_prop {
 };
 
 static DEFINE_XARRAY_ALLOC1(asid_xa);
+static DEFINE_SPINLOCK(contexts_lock);
 
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
@@ -1534,6 +1535,17 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
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
@@ -1568,7 +1580,7 @@ static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
 	size_t size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
 
 	l1_desc->l2ptr = dmam_alloc_coherent(smmu->dev, size,
-					     &l1_desc->l2ptr_dma, GFP_KERNEL);
+					     &l1_desc->l2ptr_dma, GFP_ATOMIC);
 	if (!l1_desc->l2ptr) {
 		dev_warn(smmu->dev,
 			 "failed to allocate context descriptor table\n");
@@ -1614,8 +1626,8 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
 	return l1_desc->l2ptr + idx * CTXDESC_CD_DWORDS;
 }
 
-static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
-				   int ssid, struct arm_smmu_ctx_desc *cd)
+static int __arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
+				     int ssid, struct arm_smmu_ctx_desc *cd)
 {
 	/*
 	 * This function handles the following cases:
@@ -1691,6 +1703,17 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
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
@@ -1794,9 +1817,18 @@ static bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd)
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
@@ -1812,11 +1844,31 @@ static struct arm_smmu_ctx_desc *arm_smmu_share_asid(u16 asid)
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
@@ -2407,15 +2459,6 @@ static void arm_smmu_tlb_inv_context(void *cookie)
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
@@ -2423,8 +2466,14 @@ static void arm_smmu_tlb_inv_context(void *cookie)
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
2.26.0

