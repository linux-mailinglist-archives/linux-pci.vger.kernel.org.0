Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1E1A1173A1
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 19:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfLISMH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 13:12:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40243 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfLISME (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2019 13:12:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so287586wmi.5
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2019 10:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jdXrySEgrRfn+Z3Yzn3toiuPjUb15DophWycH8Ax2iM=;
        b=VibxK8E6UtBa3mBQgrNRNTK2Uy5EViAeROXBoZPkWAJV4yfISCkGICxBo48eLIOqXs
         bGV2zZUhEmFM/xw54TAEvQ/cskYCHlSWqlGKC5caVxRSN2qs3f9kL3LSE0UCpe8xd1mC
         6aCOO+L1vYRFsAm+kApqFs2gSfu5v9IQbfaLlokVl9cFoHtjtp7uwACvN65EJwkGDjuk
         lC1yJl11t5IdjXlA/MdgR461khqpf5lcssK2MIuKnK/YnUetoZ6d55ICNswmZ1Pam3eo
         M5BeNC5VwypX2kYYPk4/2g4I3/75MRHusrqAaPbSLILVqeozuANvUyAurMyuQk6BGOd1
         1QUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jdXrySEgrRfn+Z3Yzn3toiuPjUb15DophWycH8Ax2iM=;
        b=TecPnmRMgUFasqxKJxo2w1lmN2QxbDAQ0emdqxkrbZdnIGaoaddPs+0zj3NvRGHPvC
         m4BcpQ4v9Ea9S6XDYkQinqZSh9RPj6/9cC5b7BXJoPCKyjiKzgbzTvkWNZCR2GpigxE0
         BPG7uZwkpK+NbIDlADtyyQU7TE7Ef8KmdAhCXfi20M8hYDSuvpr8oKWeyym0StbKklBr
         FFo1siKAiyDHvRML7wHmhay0aYsCoAW4tYsElrD0LiIH1g+9J/14YR40lojV8TArKyDg
         8PGkOe3xNp9aG47k9nDj/Yr1akQVHXou1Ft1qNhLiq2kY5y9i8EnXEolqYYkNKoPhWcf
         xHyA==
X-Gm-Message-State: APjAAAVIZSZgaZ9mu6GIhVC/5EiboGXYAHBp0kmQ3ORRJmwStHUHSgNj
        fmRFS1P3pHtYO5DNg4y26+rDqhHbFug=
X-Google-Smtp-Source: APXvYqzKY0Spjw9amk9taywIHmgHfBpVJEx9dYQjLXVyXm/cYRHmvbeekPl/e5P3l+lPjG7Irrc6Xg==
X-Received: by 2002:a7b:c956:: with SMTP id i22mr327209wml.65.1575915122599;
        Mon, 09 Dec 2019 10:12:02 -0800 (PST)
Received: from localhost.localdomain (adsl-62-167-101-88.adslplus.ch. [62.167.101.88])
        by smtp.gmail.com with ESMTPSA id h2sm309838wrv.66.2019.12.09.10.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 10:12:02 -0800 (PST)
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
Subject: [PATCH v3 06/13] iommu/arm-smmu-v3: Add context descriptor tables allocators
Date:   Mon,  9 Dec 2019 19:05:07 +0100
Message-Id: <20191209180514.272727-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209180514.272727-1-jean-philippe@linaro.org>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Support for SSID will require allocating context descriptor tables. Move
the context descriptor allocation to separate functions.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 57 ++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index b287e303b1d7..43d6a7ded6e4 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -568,6 +568,7 @@ struct arm_smmu_cd_table {
 struct arm_smmu_s1_cfg {
 	struct arm_smmu_cd_table	table;
 	struct arm_smmu_ctx_desc	cd;
+	u8				s1cdmax;
 };
 
 struct arm_smmu_s2_cfg {
@@ -1455,6 +1456,31 @@ static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
 }
 
 /* Context descriptor manipulation functions */
+static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
+					struct arm_smmu_cd_table *table,
+					size_t num_entries)
+{
+	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
+
+	table->ptr = dmam_alloc_coherent(smmu->dev, size, &table->ptr_dma,
+					 GFP_KERNEL);
+	if (!table->ptr) {
+		dev_warn(smmu->dev,
+			 "failed to allocate context descriptor table\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static void arm_smmu_free_cd_leaf_table(struct arm_smmu_device *smmu,
+					struct arm_smmu_cd_table *table,
+					size_t num_entries)
+{
+	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
+
+	dmam_free_coherent(smmu->dev, size, table->ptr, table->ptr_dma);
+}
+
 static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
 {
 	u64 val = 0;
@@ -1502,6 +1528,23 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
 	cdptr[3] = cpu_to_le64(cfg->cd.mair);
 }
 
+static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+
+	return arm_smmu_alloc_cd_leaf_table(smmu, &cfg->table,
+					    1 << cfg->s1cdmax);
+}
+
+static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+
+	arm_smmu_free_cd_leaf_table(smmu, &cfg->table, 1 << cfg->s1cdmax);
+}
+
 /* Stream table manipulation functions */
 static void
 arm_smmu_write_strtab_l1_desc(__le64 *dst, struct arm_smmu_strtab_l1_desc *desc)
@@ -2145,11 +2188,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
 		if (cfg->table.ptr) {
-			dmam_free_coherent(smmu_domain->smmu->dev,
-					   CTXDESC_CD_DWORDS << 3,
-					   cfg->table.ptr,
-					   cfg->table.ptr_dma);
-
+			arm_smmu_free_cd_tables(smmu_domain);
 			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
 		}
 	} else {
@@ -2173,13 +2212,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (asid < 0)
 		return asid;
 
-	cfg->table.ptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
-					     &cfg->table.ptr_dma, GFP_KERNEL);
-	if (!cfg->table.ptr) {
-		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
-		ret = -ENOMEM;
+	ret = arm_smmu_alloc_cd_tables(smmu_domain);
+	if (ret)
 		goto out_free_asid;
-	}
 
 	cfg->cd.asid	= (u16)asid;
 	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
-- 
2.24.0

