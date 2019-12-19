Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6596F126707
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 17:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfLSQbh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 11:31:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40182 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfLSQbe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 11:31:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so6270475wmi.5
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2019 08:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FClVKTteeYiGIMx90m+9aFZ0WcdcaYLYnXI1Jq7jvMc=;
        b=dVa09UAoV/Ufe3pLZu6gsSLLARiyTwRsvru9uTf5ei5oJX+/gtAaAVOkhB6Wl+vItg
         TLQDPSEubVHdQkFrML0dbihEI/108yo5jOebwu+/At0WJx3L1L+sGTaTjqIqybL22yas
         OzE7dJqFXfUdZ1u/Vdxl8rB3DKI6euddicPI5K7MG87jySSyEqETdUEQDMNkoBQN62Kh
         qLRGwDYmZOkmolNEjFdrvM2nQlY35GiY0PVv0wyeA7wi/oCRRpTrG05kCWphObH7Khac
         eJ58b7LRxC2D/IgcAJpxzCS90HItB5prmBVHbyQDmo2yI/t+64ItLMZuWJpJP//ioSBQ
         tQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FClVKTteeYiGIMx90m+9aFZ0WcdcaYLYnXI1Jq7jvMc=;
        b=cEuC8VlI8t09/ne7kNQT37YcptTQthBwiiLWwUBpReybC12t4K30c4yK0XQuAAdy4M
         /FhsEpW9BceOcjDYKQ+JSZwFXyCUArckqCm252o+a/N+8+jlc1JWfksnhNim1KFPi7K4
         FdBPMwpMrfQAbWK3a/P24FJYlnft8xEhGqmNCE+O96j+Ufo+PmLMi30DQmGErhOgguUX
         Sgy35utviYA/d8gGjfcfFTO1eG3Z76Fw1Y7Uwk2wfZqERxXf/DeyYt5MXIvUI0PW8uHN
         6U2wUfBXBJRzXr2X4L4mxVluPePo5R/tH/VlrNzvmU1jWPJBzolJzW05ZR0Ax0vWB/ZE
         DUhA==
X-Gm-Message-State: APjAAAXBvbUm8OJT/ydxNoT2+Fz+zfHPVU90PnVO3XQrKcgX0rL/H5Ih
        wU9Itg7PExB5O8a9tj/YZK9tQwthrqo=
X-Google-Smtp-Source: APXvYqx/BNzinka8ZodEfXzw2HnQ8ZI2qetrt+VM/mDeUtGONpuIEa7HZoqOPjObFUzkWV2Uz/ez+g==
X-Received: by 2002:a1c:f30e:: with SMTP id q14mr10974894wmq.65.1576773092179;
        Thu, 19 Dec 2019 08:31:32 -0800 (PST)
Received: from localhost.localdomain (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
        by smtp.gmail.com with ESMTPSA id u22sm7092068wru.30.2019.12.19.08.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 08:31:31 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        eric.auger@redhat.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org
Subject: [PATCH v4 10/13] iommu/arm-smmu-v3: Add second level of context descriptor table
Date:   Thu, 19 Dec 2019 17:30:30 +0100
Message-Id: <20191219163033.2608177-11-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219163033.2608177-1-jean-philippe@linaro.org>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SMMU can support up to 20 bits of SSID. Add a second level of page
tables to accommodate this. Devices that support more than 1024 SSIDs now
have a table of 1024 L1 entries (8kB), pointing to tables of 1024 context
descriptors (64kB), allocated on demand.

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 154 +++++++++++++++++++++++++++++++++---
 1 file changed, 144 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index b825a5639afc..bf106a7b53eb 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -224,6 +224,7 @@
 
 #define STRTAB_STE_0_S1FMT		GENMASK_ULL(5, 4)
 #define STRTAB_STE_0_S1FMT_LINEAR	0
+#define STRTAB_STE_0_S1FMT_64K_L2	2
 #define STRTAB_STE_0_S1CTXPTR_MASK	GENMASK_ULL(51, 6)
 #define STRTAB_STE_0_S1CDMAX		GENMASK_ULL(63, 59)
 
@@ -263,7 +264,20 @@
 
 #define STRTAB_STE_3_S2TTB_MASK		GENMASK_ULL(51, 4)
 
-/* Context descriptor (stage-1 only) */
+/*
+ * Context descriptors.
+ *
+ * Linear: when less than 1024 SSIDs are supported
+ * 2lvl: at most 1024 L1 entries,
+ *       1024 lazy entries per table.
+ */
+#define CTXDESC_SPLIT			10
+#define CTXDESC_L2_ENTRIES		(1 << CTXDESC_SPLIT)
+
+#define CTXDESC_L1_DESC_DWORDS		1
+#define CTXDESC_L1_DESC_VALID		1
+#define CTXDESC_L1_DESC_L2PTR_MASK	GENMASK_ULL(51, 12)
+
 #define CTXDESC_CD_DWORDS		8
 #define CTXDESC_CD_0_TCR_T0SZ		GENMASK_ULL(5, 0)
 #define ARM64_TCR_T0SZ			GENMASK_ULL(5, 0)
@@ -575,7 +589,12 @@ struct arm_smmu_cd_table {
 };
 
 struct arm_smmu_s1_cfg {
-	struct arm_smmu_cd_table	table;
+	/* Leaf tables or linear table */
+	struct arm_smmu_cd_table	*tables;
+	size_t				num_tables;
+	/* First level tables, when two levels are used */
+	__le64				*l1ptr;
+	dma_addr_t			l1ptr_dma;
 	struct arm_smmu_ctx_desc	cd;
 	u8				s1fmt;
 	u8				s1cdmax;
@@ -1521,9 +1540,48 @@ static void arm_smmu_free_cd_leaf_table(struct arm_smmu_device *smmu,
 {
 	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
 
+	if (!table->ptr)
+		return;
 	dmam_free_coherent(smmu->dev, size, table->ptr, table->ptr_dma);
 }
 
+static void arm_smmu_write_cd_l1_desc(__le64 *dst,
+				      struct arm_smmu_cd_table *table)
+{
+	u64 val = (table->ptr_dma & CTXDESC_L1_DESC_L2PTR_MASK) |
+		  CTXDESC_L1_DESC_VALID;
+
+	WRITE_ONCE(*dst, cpu_to_le64(val));
+}
+
+static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
+				   u32 ssid)
+{
+	__le64 *l1ptr;
+	unsigned int idx;
+	struct arm_smmu_cd_table *table;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+
+	if (cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
+		return cfg->tables[0].ptr + ssid * CTXDESC_CD_DWORDS;
+
+	idx = ssid >> CTXDESC_SPLIT;
+	table = &cfg->tables[idx];
+	if (!table->ptr) {
+		if (arm_smmu_alloc_cd_leaf_table(smmu, table,
+						 CTXDESC_L2_ENTRIES))
+			return NULL;
+
+		l1ptr = cfg->l1ptr + idx * CTXDESC_L1_DESC_DWORDS;
+		arm_smmu_write_cd_l1_desc(l1ptr, table);
+		/* An invalid L1CD can be cached */
+		arm_smmu_sync_cd(smmu_domain, ssid, false);
+	}
+	idx = ssid & (CTXDESC_L2_ENTRIES - 1);
+	return table->ptr + idx * CTXDESC_CD_DWORDS;
+}
+
 static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
 {
 	u64 val = 0;
@@ -1556,8 +1614,14 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 	u64 val;
 	bool cd_live;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	__le64 *cdptr = smmu_domain->s1_cfg.table.ptr + ssid *
-			CTXDESC_CD_DWORDS;
+	__le64 *cdptr;
+
+	if (WARN_ON(ssid >= (1 << smmu_domain->s1_cfg.s1cdmax)))
+		return -E2BIG;
+
+	cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
+	if (!cdptr)
+		return -ENOMEM;
 
 	val = le64_to_cpu(cdptr[0]);
 	cd_live = !!(val & CTXDESC_CD_0_V);
@@ -1604,20 +1668,87 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 {
+	int ret;
+	size_t size = 0;
+	size_t max_contexts;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
-	cfg->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
-	return arm_smmu_alloc_cd_leaf_table(smmu, &cfg->table,
-					    1 << cfg->s1cdmax);
+	max_contexts = 1 << cfg->s1cdmax;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
+	    max_contexts <= CTXDESC_L2_ENTRIES) {
+		cfg->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
+		cfg->num_tables = 1;
+	} else {
+		cfg->s1fmt = STRTAB_STE_0_S1FMT_64K_L2;
+		cfg->num_tables = DIV_ROUND_UP(max_contexts,
+					       CTXDESC_L2_ENTRIES);
+
+		size = cfg->num_tables * (CTXDESC_L1_DESC_DWORDS << 3);
+		cfg->l1ptr = dmam_alloc_coherent(smmu->dev, size,
+						 &cfg->l1ptr_dma,
+						 GFP_KERNEL);
+		if (!cfg->l1ptr) {
+			dev_warn(smmu->dev,
+				 "failed to allocate L1 context table\n");
+			return -ENOMEM;
+		}
+	}
+
+	cfg->tables = devm_kzalloc(smmu->dev, sizeof(struct arm_smmu_cd_table) *
+				   cfg->num_tables, GFP_KERNEL);
+	if (!cfg->tables) {
+		ret = -ENOMEM;
+		goto err_free_l1;
+	}
+
+	/*
+	 * Only allocate a leaf table for linear case. With two levels, leaf
+	 * tables are allocated lazily.
+	 */
+	if (cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR) {
+		ret = arm_smmu_alloc_cd_leaf_table(smmu, &cfg->tables[0],
+						   max_contexts);
+		if (ret)
+			goto err_free_tables;
+	}
+
+	return 0;
+
+err_free_tables:
+	devm_kfree(smmu->dev, cfg->tables);
+	cfg->tables = NULL;
+err_free_l1:
+	if (cfg->l1ptr) {
+		dmam_free_coherent(smmu->dev, size, cfg->l1ptr, cfg->l1ptr_dma);
+		cfg->l1ptr = NULL;
+		cfg->l1ptr_dma = 0;
+	}
+	return ret;
 }
 
 static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
 {
+	int i;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+	size_t num_leaf_entries = 1 << cfg->s1cdmax;
+	struct arm_smmu_cd_table *table = cfg->tables;
+
+	if (cfg->l1ptr) {
+		size_t size = cfg->num_tables * (CTXDESC_L1_DESC_DWORDS << 3);
 
-	arm_smmu_free_cd_leaf_table(smmu, &cfg->table, 1 << cfg->s1cdmax);
+		dmam_free_coherent(smmu->dev, size, cfg->l1ptr, cfg->l1ptr_dma);
+		cfg->l1ptr = NULL;
+		cfg->l1ptr_dma = 0;
+		num_leaf_entries = CTXDESC_L2_ENTRIES;
+	}
+
+	for (i = 0; i < cfg->num_tables; i++, table++)
+		arm_smmu_free_cd_leaf_table(smmu, table, num_leaf_entries);
+	devm_kfree(smmu->dev, cfg->tables);
+	cfg->tables = NULL;
 }
 
 /* Stream table manipulation functions */
@@ -1737,6 +1868,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	}
 
 	if (s1_cfg) {
+		dma_addr_t ptr_dma = s1_cfg->l1ptr ? s1_cfg->l1ptr_dma :
+				     s1_cfg->tables[0].ptr_dma;
+
 		BUG_ON(ste_live);
 		dst[1] = cpu_to_le64(
 			 FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
@@ -1749,7 +1883,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
-		val |= (s1_cfg->table.ptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
+		val |= (ptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
 			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
 			FIELD_PREP(STRTAB_STE_0_S1CDMAX, s1_cfg->s1cdmax) |
 			FIELD_PREP(STRTAB_STE_0_S1FMT, s1_cfg->s1fmt);
@@ -2265,7 +2399,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
-		if (cfg->table.ptr) {
+		if (cfg->tables) {
 			arm_smmu_free_cd_tables(smmu_domain);
 			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
 		}
-- 
2.24.1

