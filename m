Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9033F1173B1
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 19:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfLISMM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 13:12:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40742 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfLISMK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2019 13:12:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so17267317wrn.7
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2019 10:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uGyyVFFffB+nn3CMqPQEWA9TrF0HCq7Y+C6lEE2R5KI=;
        b=Vf0lYDvNV9KMzOkHoN+NaFsfSZeaXs02L6HdvpcXM+0RGC6y//Ng8WXrrLppABKBcO
         9qQKVPPvYxfd/MZHPmt6BuBK8cE9Sm8vXO6ofg88/fTHZyiOOzizQbut3S8p6FA1PLuJ
         DU/W/0EdRQzbgK4yVOt08FFLMz2dLH9RsfDHu/X3iswziaEeyf6PsVOLvES2HJ0F2C+C
         pA++MmhbJRfXHGVOLu5WWUNYXgfKdjwS6RKGMf01u5YKT5XhcAtSrlcK7elGYBWxHd+0
         BaxW1SUehmNXbw/aM66cKm/YFHDYYDo0Bj8nxZaUhPJFqgFnQ3rDrboMqW31nZzClPqY
         YAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uGyyVFFffB+nn3CMqPQEWA9TrF0HCq7Y+C6lEE2R5KI=;
        b=eDoT4a45UTfjJvm57Aiy3Ne4cLmo7FLIy2eDH7y7IkcivaVxIl243z9Dgf3RyJeufG
         B9GH7AkQIn1Qzzx82k5zgKPePfI2ogMddGQrALdSqfTfKnfa2hG2CyfKfpXlitPoPpVQ
         bvcYBd30Xw/2Y97uli/vLJRXphrAEPHNXycNrKxhOQ0tXydcIypQIH3sMjqCb4ldpSd8
         tUZJUUR+NbsZBeDtsp+PCCg+WuKRYKpJWhDNUHcl64AG0+tvcadYKLWc3WVDru0MCAD4
         cKa4gGvuvFMG/dYWvnuh2sdVjwFI8awqYa9IgDxC9hVbq7fDWAv//fRL9xDq/EbVuJ0a
         tuiA==
X-Gm-Message-State: APjAAAUhTzUJtWYIWtUF+T8Bvdk6CAYo/3ioXhLg3KI8eCP8Wy64KbJu
        +O8PW42ngSQQLMdWUNxjdgJSWqU01BY=
X-Google-Smtp-Source: APXvYqyUVK2x04/8RV+0EjRc7yScE+2P9BnUt7GAN2lZ2bh0T3PIPDVhqSdSCNqbN20O+7BXogSrAQ==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr3653742wrr.226.1575915126873;
        Mon, 09 Dec 2019 10:12:06 -0800 (PST)
Received: from localhost.localdomain (adsl-62-167-101-88.adslplus.ch. [62.167.101.88])
        by smtp.gmail.com with ESMTPSA id h2sm309838wrv.66.2019.12.09.10.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 10:12:06 -0800 (PST)
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
Subject: [PATCH v3 10/13] iommu/arm-smmu-v3: Add second level of context descriptor table
Date:   Mon,  9 Dec 2019 19:05:11 +0100
Message-Id: <20191209180514.272727-11-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209180514.272727-1-jean-philippe@linaro.org>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
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

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 153 +++++++++++++++++++++++++++++++++---
 1 file changed, 143 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index fc5119f34187..52adcdfda58b 100644
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
@@ -575,7 +589,10 @@ struct arm_smmu_cd_table {
 };
 
 struct arm_smmu_s1_cfg {
-	struct arm_smmu_cd_table	table;
+	struct arm_smmu_cd_table	*tables;
+	size_t				num_tables;
+	__le64				*l1ptr;
+	dma_addr_t			l1ptr_dma;
 	struct arm_smmu_ctx_desc	cd;
 	u8				s1fmt;
 	u8				s1cdmax;
@@ -1521,9 +1538,53 @@ static void arm_smmu_free_cd_leaf_table(struct arm_smmu_device *smmu,
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
+	if (cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR) {
+		table = &cfg->tables[0];
+		idx = ssid;
+	} else {
+		idx = ssid >> CTXDESC_SPLIT;
+		if (idx >= cfg->num_tables)
+			return NULL;
+
+		table = &cfg->tables[idx];
+		if (!table->ptr) {
+			if (arm_smmu_alloc_cd_leaf_table(smmu, table,
+							 CTXDESC_L2_ENTRIES))
+				return NULL;
+
+			l1ptr = cfg->l1ptr + idx * CTXDESC_L1_DESC_DWORDS;
+			arm_smmu_write_cd_l1_desc(l1ptr, table);
+			/* An invalid L1CD can be cached */
+			arm_smmu_sync_cd(smmu_domain, ssid, false);
+		}
+		idx = ssid & (CTXDESC_L2_ENTRIES - 1);
+	}
+	return table->ptr + idx * CTXDESC_CD_DWORDS;
+}
+
 static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
 {
 	u64 val = 0;
@@ -1556,8 +1617,10 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 	u64 val;
 	bool cd_live;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	__le64 *cdptr = smmu_domain->s1_cfg.table.ptr + ssid *
-			CTXDESC_CD_DWORDS;
+	__le64 *cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
+
+	if (!cdptr)
+		return -ENOMEM;
 
 	val = le64_to_cpu(cdptr[0]);
 	cd_live = !!(val & CTXDESC_CD_0_V);
@@ -1604,20 +1667,87 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 
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
+	if (!cfg->l1ptr) {
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
@@ -1737,6 +1867,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	}
 
 	if (s1_cfg) {
+		dma_addr_t ptr_dma = s1_cfg->l1ptr ? s1_cfg->l1ptr_dma :
+				     s1_cfg->tables[0].ptr_dma;
+
 		BUG_ON(ste_live);
 		dst[1] = cpu_to_le64(
 			 FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
@@ -1749,7 +1882,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
-		val |= (s1_cfg->table.ptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
+		val |= (ptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
 			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
 			FIELD_PREP(STRTAB_STE_0_S1CDMAX, s1_cfg->s1cdmax) |
 			FIELD_PREP(STRTAB_STE_0_S1FMT, s1_cfg->s1fmt);
@@ -2265,7 +2398,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
-		if (cfg->table.ptr) {
+		if (cfg->tables) {
 			arm_smmu_free_cd_tables(smmu_domain);
 			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
 		}
-- 
2.24.0

