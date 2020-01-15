Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C032613C1C5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 13:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgAOMxb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 07:53:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54761 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgAOMxa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2020 07:53:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id b19so17718814wmj.4
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2020 04:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V2gNHDrbsk9ohEf85IxlXIQbuuwolBwZUysOChnAnn0=;
        b=cNUP6NhsdUVgBnVfjD3Jhz4/+A3pBx0OJZsxrVnzOx9W7Jdg3x/X3ld3q4laMAhBZR
         0Qwhk4uj1HQeisUoXKoQ1xQWHTKCtnNGyOnAAWa9RLDznRs2AzmzQXBLozFe7cLQwjG9
         vutpbhV7i2p6taET7Dzy1SvaJiID0jS/M4L4LaSLeZcdjT3jrXo9EEN7Xm0ebRBm6rMU
         v//64gwV/RMNFLxK8ndS9f8QEnfTDVPUAdHn6IAnCKr2qIhNRBTL7rWXLa9PwwltwljI
         W32Bw6k+Q+AZByF11giISGl337YFokdLTonNTlrMWB0Z6sVTfIl6YBN1XlUWKzCY/Ulh
         Qlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V2gNHDrbsk9ohEf85IxlXIQbuuwolBwZUysOChnAnn0=;
        b=hCblI+A9z1tSDcuLi6lV1gdCZzJspOV3SCwnZV3ak9IK8vbo5TbzgbGTm8BWWPTPZl
         zK4hq8W06hdp6OuqeL8S/I379Vw0z2mXXZIRaFpQqPbAynKWqUW9QKGgeki2kPiGFLCG
         4AZIF0bUga/Hb4XclbnaQaLEp2hfgrUb7WRjw3K2hOFbdYxf3+dr7KymACxg/O5hdwIm
         EPXeuIIa6h/cSnlH11zqHNGOSKoE4WfX9VNezElfDVaakwKl26aWxY8zabUAjRuYIw8A
         emSuapMy3Vxc/ngZuLxsKDTbLM9YjJvm8ZwQExE/faX/0u8QLaVgxrpXtDdDSv8+IyBa
         4GIg==
X-Gm-Message-State: APjAAAVKsTpHzuRBhXI3vq0FSIwwPl2p/g5vRbOit5mfPwtmgI8nBEks
        Lauf/M8b8k4kVaTrJXFfJBdZ1beix1U=
X-Google-Smtp-Source: APXvYqzMwxImhwynpdDaKwAiaRqTssEar5/aQ5wgBt/n+ry8r89EuhUII94N4JzZx1c+tdEKt7nRqg==
X-Received: by 2002:a05:600c:220e:: with SMTP id z14mr33458894wml.114.1579092807329;
        Wed, 15 Jan 2020 04:53:27 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d12sm25196171wrp.62.2020.01.15.04.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 04:53:26 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, will@kernel.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com, eric.auger@redhat.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: [PATCH v5 00/13] iommu: Add PASID support to Arm SMMUv3
Date:   Wed, 15 Jan 2020 13:52:26 +0100
Message-Id: <20200115125239.136759-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since v4 [1] I addressed some of Will's comment.

Still missing and will be submitted as follow-up patches:
* write STE.V with WRITE_ONCE() (patch 7)
* batch submission of CD invalidation (patch 7)
* Remove WARN_ON_ONCE() in add_device() (patch 13)
  Pending Robin's input.

So I think patches 1-10 should be good to go, but anything in between
would be good too, and I'll send the rest for 5.7.

Thanks,
Jean

[1] https://lore.kernel.org/linux-iommu/20191219163033.2608177-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (13):
  iommu/arm-smmu-v3: Drop __GFP_ZERO flag from DMA allocation
  dt-bindings: document PASID property for IOMMU masters
  iommu/arm-smmu-v3: Parse PASID devicetree property of platform devices
  ACPI/IORT: Parse SSID property of named component node
  iommu/arm-smmu-v3: Prepare arm_smmu_s1_cfg for SSID support
  iommu/arm-smmu-v3: Add context descriptor tables allocators
  iommu/arm-smmu-v3: Add support for Substream IDs
  iommu/arm-smmu-v3: Propagate ssid_bits
  iommu/arm-smmu-v3: Prepare for handling arm_smmu_write_ctx_desc()
    failure
  iommu/arm-smmu-v3: Add second level of context descriptor table
  iommu/arm-smmu-v3: Improve add_device() error handling
  PCI/ATS: Add PASID stubs
  iommu/arm-smmu-v3: Add support for PCI PASID

 .../devicetree/bindings/iommu/iommu.txt       |   6 +
 drivers/acpi/arm64/iort.c                     |  18 +
 drivers/iommu/arm-smmu-v3.c                   | 464 +++++++++++++++---
 drivers/iommu/of_iommu.c                      |   6 +-
 include/linux/iommu.h                         |   2 +
 include/linux/pci-ats.h                       |   3 +
 6 files changed, 439 insertions(+), 60 deletions(-)

----
Diff since v4 (large due to structures refactoring):

#diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 8e95ecad4c9a..f42454512e87 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -275,7 +275,7 @@
 #define CTXDESC_L2_ENTRIES		(1 << CTXDESC_SPLIT)

 #define CTXDESC_L1_DESC_DWORDS		1
-#define CTXDESC_L1_DESC_VALID		1
+#define CTXDESC_L1_DESC_V		(1UL << 0)
 #define CTXDESC_L1_DESC_L2PTR_MASK	GENMASK_ULL(51, 12)

 #define CTXDESC_CD_DWORDS		8
@@ -583,18 +583,20 @@ struct arm_smmu_ctx_desc {
 	u64				mair;
 };

-struct arm_smmu_cd_table {
-	__le64				*ptr;
-	dma_addr_t			ptr_dma;
+struct arm_smmu_l1_ctx_desc {
+	__le64				*l2ptr;
+	dma_addr_t			l2ptr_dma;
+};
+
+struct arm_smmu_ctx_desc_cfg {
+	__le64				*cdtab;
+	dma_addr_t			cdtab_dma;
+	struct arm_smmu_l1_ctx_desc	*l1_desc;
+	unsigned int			num_l1_ents;
 };

 struct arm_smmu_s1_cfg {
-	/* Leaf tables or linear table */
-	struct arm_smmu_cd_table	*tables;
-	size_t				num_tables;
-	/* First level tables, when two levels are used */
-	__le64				*l1ptr;
-	dma_addr_t			l1ptr_dma;
+	struct arm_smmu_ctx_desc_cfg	cdcfg;
 	struct arm_smmu_ctx_desc	cd;
 	u8				s1fmt;
 	u8				s1cdmax;
@@ -1519,14 +1521,13 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 }

 static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
-					struct arm_smmu_cd_table *table,
-					size_t num_entries)
+					struct arm_smmu_l1_ctx_desc *l1_desc)
 {
-	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
+	size_t size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);

-	table->ptr = dmam_alloc_coherent(smmu->dev, size, &table->ptr_dma,
-					 GFP_KERNEL);
-	if (!table->ptr) {
+	l1_desc->l2ptr = dmam_alloc_coherent(smmu->dev, size,
+					     &l1_desc->l2ptr_dma, GFP_KERNEL);
+	if (!l1_desc->l2ptr) {
 		dev_warn(smmu->dev,
 			 "failed to allocate context descriptor table\n");
 		return -ENOMEM;
@@ -1534,22 +1535,11 @@ static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
 	return 0;
 }

-static void arm_smmu_free_cd_leaf_table(struct arm_smmu_device *smmu,
-					struct arm_smmu_cd_table *table,
-					size_t num_entries)
-{
-	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
-
-	if (!table->ptr)
-		return;
-	dmam_free_coherent(smmu->dev, size, table->ptr, table->ptr_dma);
-}
-
 static void arm_smmu_write_cd_l1_desc(__le64 *dst,
-				      struct arm_smmu_cd_table *table)
+				      struct arm_smmu_l1_ctx_desc *l1_desc)
 {
-	u64 val = (table->ptr_dma & CTXDESC_L1_DESC_L2PTR_MASK) |
-		  CTXDESC_L1_DESC_VALID;
+	u64 val = (l1_desc->l2ptr_dma & CTXDESC_L1_DESC_L2PTR_MASK) |
+		  CTXDESC_L1_DESC_V;

 	WRITE_ONCE(*dst, cpu_to_le64(val));
 }
@@ -1559,27 +1549,26 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
 {
 	__le64 *l1ptr;
 	unsigned int idx;
-	struct arm_smmu_cd_table *table;
+	struct arm_smmu_l1_ctx_desc *l1_desc;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;

-	if (cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
-		return cfg->tables[0].ptr + ssid * CTXDESC_CD_DWORDS;
+	if (smmu_domain->s1_cfg.s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
+		return cdcfg->cdtab + ssid * CTXDESC_CD_DWORDS;

 	idx = ssid >> CTXDESC_SPLIT;
-	table = &cfg->tables[idx];
-	if (!table->ptr) {
-		if (arm_smmu_alloc_cd_leaf_table(smmu, table,
-						 CTXDESC_L2_ENTRIES))
+	l1_desc = &cdcfg->l1_desc[idx];
+	if (!l1_desc->l2ptr) {
+		if (arm_smmu_alloc_cd_leaf_table(smmu, l1_desc))
 			return NULL;

-		l1ptr = cfg->l1ptr + idx * CTXDESC_L1_DESC_DWORDS;
-		arm_smmu_write_cd_l1_desc(l1ptr, table);
+		l1ptr = cdcfg->cdtab + idx * CTXDESC_L1_DESC_DWORDS;
+		arm_smmu_write_cd_l1_desc(l1ptr, l1_desc);
 		/* An invalid L1CD can be cached */
 		arm_smmu_sync_cd(smmu_domain, ssid, false);
 	}
 	idx = ssid & (CTXDESC_L2_ENTRIES - 1);
-	return table->ptr + idx * CTXDESC_CD_DWORDS;
+	return l1_desc->l2ptr + idx * CTXDESC_CD_DWORDS;
 }

 static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
@@ -1613,8 +1602,8 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 	 */
 	u64 val;
 	bool cd_live;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	__le64 *cdptr;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;

 	if (WARN_ON(ssid >= (1 << smmu_domain->s1_cfg.s1cdmax)))
 		return -E2BIG;
@@ -1661,6 +1650,15 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 			val |= CTXDESC_CD_0_S;
 	}

+	/*
+	 * The SMMU accesses 64-bit values atomically. See IHI0070Ca 3.21.3
+	 * "Configuration structures and configuration invalidation completion"
+	 *
+	 *   The size of single-copy atomic reads made by the SMMU is
+	 *   IMPLEMENTATION DEFINED but must be at least 64 bits. Any single
+	 *   field within an aligned 64-bit span of a structure can be altered
+	 *   without first making the structure invalid.
+	 */
 	WRITE_ONCE(cdptr[0], cpu_to_le64(val));
 	arm_smmu_sync_cd(smmu_domain, ssid, true);
 	return 0;
@@ -1669,61 +1667,48 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 {
 	int ret;
-	size_t size = 0;
+	size_t l1size;
 	size_t max_contexts;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &cfg->cdcfg;

 	max_contexts = 1 << cfg->s1cdmax;

 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
 	    max_contexts <= CTXDESC_L2_ENTRIES) {
 		cfg->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
-		cfg->num_tables = 1;
+		cdcfg->num_l1_ents = max_contexts;
+
+		l1size = max_contexts * (CTXDESC_CD_DWORDS << 3);
 	} else {
 		cfg->s1fmt = STRTAB_STE_0_S1FMT_64K_L2;
-		cfg->num_tables = DIV_ROUND_UP(max_contexts,
-					       CTXDESC_L2_ENTRIES);
-
-		size = cfg->num_tables * (CTXDESC_L1_DESC_DWORDS << 3);
-		cfg->l1ptr = dmam_alloc_coherent(smmu->dev, size,
-						 &cfg->l1ptr_dma,
-						 GFP_KERNEL);
-		if (!cfg->l1ptr) {
-			dev_warn(smmu->dev,
-				 "failed to allocate L1 context table\n");
+		cdcfg->num_l1_ents = DIV_ROUND_UP(max_contexts,
+						  CTXDESC_L2_ENTRIES);
+
+		cdcfg->l1_desc = devm_kcalloc(smmu->dev, cdcfg->num_l1_ents,
+					      sizeof(*cdcfg->l1_desc),
+					      GFP_KERNEL);
+		if (!cdcfg->l1_desc)
 			return -ENOMEM;
-		}
+
+		l1size = cdcfg->num_l1_ents * (CTXDESC_L1_DESC_DWORDS << 3);
 	}

-	cfg->tables = devm_kzalloc(smmu->dev, sizeof(struct arm_smmu_cd_table) *
-				   cfg->num_tables, GFP_KERNEL);
-	if (!cfg->tables) {
+	cdcfg->cdtab = dmam_alloc_coherent(smmu->dev, l1size, &cdcfg->cdtab_dma,
+					   GFP_KERNEL);
+	if (!cdcfg->cdtab) {
+		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
 		ret = -ENOMEM;
 		goto err_free_l1;
 	}

-	/*
-	 * Only allocate a leaf table for linear case. With two levels, leaf
-	 * tables are allocated lazily.
-	 */
-	if (cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR) {
-		ret = arm_smmu_alloc_cd_leaf_table(smmu, &cfg->tables[0],
-						   max_contexts);
-		if (ret)
-			goto err_free_tables;
-	}
-
 	return 0;

-err_free_tables:
-	devm_kfree(smmu->dev, cfg->tables);
-	cfg->tables = NULL;
 err_free_l1:
-	if (cfg->l1ptr) {
-		dmam_free_coherent(smmu->dev, size, cfg->l1ptr, cfg->l1ptr_dma);
-		cfg->l1ptr = NULL;
-		cfg->l1ptr_dma = 0;
+	if (cdcfg->l1_desc) {
+		devm_kfree(smmu->dev, cdcfg->l1_desc);
+		cdcfg->l1_desc = NULL;
 	}
 	return ret;
 }
@@ -1731,24 +1716,32 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
 {
 	int i;
+	size_t size, l1size;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
-	size_t num_leaf_entries = 1 << cfg->s1cdmax;
-	struct arm_smmu_cd_table *table = cfg->tables;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;

-	if (cfg->l1ptr) {
-		size_t size = cfg->num_tables * (CTXDESC_L1_DESC_DWORDS << 3);
+	if (cdcfg->l1_desc) {
+		size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);

-		dmam_free_coherent(smmu->dev, size, cfg->l1ptr, cfg->l1ptr_dma);
-		cfg->l1ptr = NULL;
-		cfg->l1ptr_dma = 0;
-		num_leaf_entries = CTXDESC_L2_ENTRIES;
+		for (i = 0; i < cdcfg->num_l1_ents; i++) {
+			if (!cdcfg->l1_desc[i].l2ptr)
+				continue;
+
+			dmam_free_coherent(smmu->dev, size,
+					   cdcfg->l1_desc[i].l2ptr,
+					   cdcfg->l1_desc[i].l2ptr_dma);
+		}
+		devm_kfree(smmu->dev, cdcfg->l1_desc);
+		cdcfg->l1_desc = NULL;
+
+		l1size = cdcfg->num_l1_ents * (CTXDESC_L1_DESC_DWORDS << 3);
+	} else {
+		l1size = cdcfg->num_l1_ents * (CTXDESC_CD_DWORDS << 3);
 	}

-	for (i = 0; i < cfg->num_tables; i++, table++)
-		arm_smmu_free_cd_leaf_table(smmu, table, num_leaf_entries);
-	devm_kfree(smmu->dev, cfg->tables);
-	cfg->tables = NULL;
+	dmam_free_coherent(smmu->dev, l1size, cdcfg->cdtab, cdcfg->cdtab_dma);
+	cdcfg->cdtab_dma = 0;
+	cdcfg->cdtab = NULL;
 }

 /* Stream table manipulation functions */
@@ -1868,9 +1861,6 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	}

 	if (s1_cfg) {
-		dma_addr_t ptr_dma = s1_cfg->l1ptr ? s1_cfg->l1ptr_dma :
-				     s1_cfg->tables[0].ptr_dma;
-
 		BUG_ON(ste_live);
 		dst[1] = cpu_to_le64(
 			 FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
@@ -1883,7 +1873,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);

-		val |= (ptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
+		val |= (s1_cfg->cdcfg.cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
 			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
 			FIELD_PREP(STRTAB_STE_0_S1CDMAX, s1_cfg->s1cdmax) |
 			FIELD_PREP(STRTAB_STE_0_S1FMT, s1_cfg->s1fmt);
@@ -2399,7 +2389,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;

-		if (cfg->tables) {
+		if (cfg->cdcfg.cdtab) {
 			arm_smmu_free_cd_tables(smmu_domain);
 			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
 		}
@@ -2438,11 +2428,11 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,

 	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &cfg->cd);
 	if (ret)
-		goto out_free_tables;
+		goto out_free_cd_tables;

 	return 0;

-out_free_tables:
+out_free_cd_tables:
 	arm_smmu_free_cd_tables(smmu_domain);
 out_free_asid:
 	arm_smmu_bitmap_free(smmu->asid_map, asid);
@@ -2899,7 +2889,14 @@ static int arm_smmu_add_device(struct device *dev)

 	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);

-	/* Note that PASID must be enabled before, and disabled after ATS */
+	/*
+	 * Note that PASID must be enabled before, and disabled after ATS:
+	 * PCI Express Base 4.0r1.0 - 10.5.1.3 ATS Control Register
+	 *
+	 *   Behavior is undefined if this bit is Set and the value of the PASID
+	 *   Enable, Execute Requested Enable, or Privileged Mode Requested bits
+	 *   are changed.
+	 */
 	arm_smmu_enable_pasid(master);

 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB))



