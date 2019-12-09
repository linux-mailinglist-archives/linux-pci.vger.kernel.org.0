Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF9AF11739D
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 19:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLISME (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 13:12:04 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35043 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfLISMD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2019 13:12:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id c20so322626wmb.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2019 10:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4SmIhNyhH1ZvD9U1NbZBEKXRDYfCu5B8DYhEY+IOh7Q=;
        b=zECKqP57s/Ub2s0rdbLBhyBu719hh7rbyeuo5qgFWFCBa1eRCGCT1QxOaAIJVIjeTZ
         2VqbggAid+t9XWWJy9OCVrBHX9dxm2Esz+tJIq+nG+7/5AZMwDRDdthjd7WLShv/827o
         Sr9YZA5n0oo7LsuaHPCrHH5yB2B0peN9X+ufAc+mQtz7XodiQgyuoSTCHrkrzaPeLdfq
         kRS/AgiERRdtwtvWQPv+CHZXZzJl68J3GSnZhqZK1H8GSz7561nNhUSOSbYxBVUdMdpQ
         CXn9XYhNERRZCEGYkJxiTNseY7tBsOwkpa0gMVk9sc2Vl+ligt9r2x3vsr5LkpIjeEfB
         DVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4SmIhNyhH1ZvD9U1NbZBEKXRDYfCu5B8DYhEY+IOh7Q=;
        b=tXZXQxuAWaRuphMJzf0QfeXoBLkX72ogejDA5jxWB9UIjoaajniGAPTLBXBEvpBoMi
         SOLNQiU9BWjIGyiBZhPxeMmwGrZfc9KUavyLfyhukZGk5bppUKx0tFLLkyY9L7yt5ZHS
         IB59E+Op8FX09X+tA8jlDbC3jxAvjR/FhK9MllTElAKod7TEjX6JDXp36P4JnhHetQSE
         ENj1SkH4eyr/2d7TiXRhlV0qaWY+88HK0Xdm9iGHfCiEcvBPpSAm4JuQaJQgeV7fex0h
         CR0mAhBzgaAhKenjzOeaHrHMzYgi97sXL8P918vm4ntCZx86z4hV9s073S9zM6QWSTzf
         pdMw==
X-Gm-Message-State: APjAAAWfccJ2OkUWPgOUsdGyEGjaCC3ZwdarCwBLyt/CXsNG8aGcVfZh
        icqztT89Oj0IIuiVG7JdmLdKDgxrPeY=
X-Google-Smtp-Source: APXvYqy3WfN7DdcofGPnqQTkPmW4bWrAQwoyDmeVrrbNjjd56os+78JBLhrDMEAB/cskG/ngtwLznA==
X-Received: by 2002:a7b:c218:: with SMTP id x24mr309623wmi.149.1575915121541;
        Mon, 09 Dec 2019 10:12:01 -0800 (PST)
Received: from localhost.localdomain (adsl-62-167-101-88.adslplus.ch. [62.167.101.88])
        by smtp.gmail.com with ESMTPSA id h2sm309838wrv.66.2019.12.09.10.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 10:12:01 -0800 (PST)
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
Subject: [PATCH v3 05/13] iommu/arm-smmu-v3: Prepare arm_smmu_s1_cfg for SSID support
Date:   Mon,  9 Dec 2019 19:05:06 +0100
Message-Id: <20191209180514.272727-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209180514.272727-1-jean-philippe@linaro.org>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When adding SSID support to the SMMUv3 driver, we'll need to manipulate
leaf pasid tables and context descriptors. Extract the context
descriptor structure and introduce a new table structure.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 44 +++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 837b4283b4dc..b287e303b1d7 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -553,16 +553,21 @@ struct arm_smmu_strtab_l1_desc {
 	dma_addr_t			l2ptr_dma;
 };
 
+struct arm_smmu_ctx_desc {
+	u16				asid;
+	u64				ttbr;
+	u64				tcr;
+	u64				mair;
+};
+
+struct arm_smmu_cd_table {
+	__le64				*ptr;
+	dma_addr_t			ptr_dma;
+};
+
 struct arm_smmu_s1_cfg {
-	__le64				*cdptr;
-	dma_addr_t			cdptr_dma;
-
-	struct arm_smmu_ctx_desc {
-		u16	asid;
-		u64	ttbr;
-		u64	tcr;
-		u64	mair;
-	}				cd;
+	struct arm_smmu_cd_table	table;
+	struct arm_smmu_ctx_desc	cd;
 };
 
 struct arm_smmu_s2_cfg {
@@ -1471,6 +1476,7 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
 				    struct arm_smmu_s1_cfg *cfg)
 {
 	u64 val;
+	__le64 *cdptr = cfg->table.ptr;
 
 	/*
 	 * We don't need to issue any invalidation here, as we'll invalidate
@@ -1488,12 +1494,12 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
 	if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
 		val |= CTXDESC_CD_0_S;
 
-	cfg->cdptr[0] = cpu_to_le64(val);
+	cdptr[0] = cpu_to_le64(val);
 
 	val = cfg->cd.ttbr & CTXDESC_CD_1_TTB0_MASK;
-	cfg->cdptr[1] = cpu_to_le64(val);
+	cdptr[1] = cpu_to_le64(val);
 
-	cfg->cdptr[3] = cpu_to_le64(cfg->cd.mair);
+	cdptr[3] = cpu_to_le64(cfg->cd.mair);
 }
 
 /* Stream table manipulation functions */
@@ -1624,7 +1630,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
-		val |= (s1_cfg->cdptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
+		val |= (s1_cfg->table.ptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
 			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS);
 	}
 
@@ -2138,11 +2144,11 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
-		if (cfg->cdptr) {
+		if (cfg->table.ptr) {
 			dmam_free_coherent(smmu_domain->smmu->dev,
 					   CTXDESC_CD_DWORDS << 3,
-					   cfg->cdptr,
-					   cfg->cdptr_dma);
+					   cfg->table.ptr,
+					   cfg->table.ptr_dma);
 
 			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
 		}
@@ -2167,9 +2173,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (asid < 0)
 		return asid;
 
-	cfg->cdptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
-					 &cfg->cdptr_dma, GFP_KERNEL);
-	if (!cfg->cdptr) {
+	cfg->table.ptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
+					     &cfg->table.ptr_dma, GFP_KERNEL);
+	if (!cfg->table.ptr) {
 		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
 		ret = -ENOMEM;
 		goto out_free_asid;
-- 
2.24.0

