Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C93B216AEC3
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 19:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgBXSYl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 13:24:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52463 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbgBXSYl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 13:24:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so314525wmc.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 10:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQBZlQXWcV9D5kUq6nU/sNwIcBZzF9eb/NGOMt8k20I=;
        b=eI8yYEK7OL2vRGcpG1JnOgsMhuDCO4FXpzt9iuYs7rxQMKyOhp9KhI6x7vaf9IwPZ/
         kMlSIfxdQt4lS/U4vVf8kxi+HenGZEauzOVE872pbr0e0ieZwNbK4HR43P+vIbiIkTgR
         AF8PX2d3e5ts8X9Qh0BYqeVSmsTe8bm5BUlC8jxx/e59zILlRqOXfDm/mQsDIUPuqxDf
         hsc3maRZYuhQQqz6cSJLqhQ/dmVNWbW/E/G8tYAVuNtffl8+B1msnQ3Z2BW0+KVqWXHV
         3KMq1zSe1xIGVjkKk+tQ8XnwBg/DWJIWVCFiRRrxgiTV3h6Ci5Dkon9FjvCNhrGQPYi9
         5JFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQBZlQXWcV9D5kUq6nU/sNwIcBZzF9eb/NGOMt8k20I=;
        b=RPkXYNvQp3TeW3i9N0HPfYsEqyFga6O1glKkKSHbUV0zvY6negjE/0f/MjGoFu8IEm
         tbBYON6jEZzR8xiaDQHank9Og36JeWdX61hLMAuz1zfHzKvm3CIW2YOW9cNKZiYylutl
         Xg8AYWyyQ3hNx48DWBsn+JWzz7YNJJCZGxn3TSI24CmoVDkDzshCNAh9f0fKHYoPC+8h
         R2uzz/b4CJNkfDfKK23WqopyPW93CMH8e2UiH8x0oYFEzc9+gQdGABIGti/GJDnYAAkO
         uvNe8cS/V9drxd/NjAS0Fn2YW5EKxjrOiAAn9s0WmADYB+s3ThVyQoeedpH7Xd0QjN0F
         EzFQ==
X-Gm-Message-State: APjAAAUhraxtpzx5+9Yx+eTH0FVIfOyQHxVQHEmOK7Uz2TzliQpJ3ufT
        q2MdZ7b0QYhUR0+h3jUdVxCeEA==
X-Google-Smtp-Source: APXvYqy8MSJlJty3XKxuu4hz13wjSc+2uWe+QAIoI4+u4Wyj/t1n6Km8w38KIy+F6OJ89qWYqndYGw==
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr303798wma.89.1582568679409;
        Mon, 24 Feb 2020 10:24:39 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:24:39 -0800 (PST)
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
Subject: [PATCH v4 09/26] iommu/arm-smmu-v3: Manage ASIDs with xarray
Date:   Mon, 24 Feb 2020 19:23:44 +0100
Message-Id: <20200224182401.353359-10-jean-philippe@linaro.org>
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

In preparation for sharing some ASIDs with the CPU, use a global xarray to
store ASIDs and their context. ASID#1 is not reserved, and the ASID
space is global.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 87ae31ef35a1..7737b70e74cd 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -651,7 +651,6 @@ struct arm_smmu_device {
 
 #define ARM_SMMU_MAX_ASIDS		(1 << 16)
 	unsigned int			asid_bits;
-	DECLARE_BITMAP(asid_map, ARM_SMMU_MAX_ASIDS);
 
 #define ARM_SMMU_MAX_VMIDS		(1 << 16)
 	unsigned int			vmid_bits;
@@ -711,6 +710,8 @@ struct arm_smmu_option_prop {
 	const char *prop;
 };
 
+static DEFINE_XARRAY_ALLOC1(asid_xa);
+
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
 	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
@@ -1742,6 +1743,14 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
 	cdcfg->cdtab = NULL;
 }
 
+static void arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd)
+{
+	if (!cd->asid)
+		return;
+
+	xa_erase(&asid_xa, cd->asid);
+}
+
 /* Stream table manipulation functions */
 static void
 arm_smmu_write_strtab_l1_desc(__le64 *dst, struct arm_smmu_strtab_l1_desc *desc)
@@ -2388,10 +2397,9 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
-		if (cfg->cdcfg.cdtab) {
+		if (cfg->cdcfg.cdtab)
 			arm_smmu_free_cd_tables(smmu_domain);
-			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
-		}
+		arm_smmu_free_asid(&cfg->cd);
 	} else {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
 		if (cfg->vmid)
@@ -2406,14 +2414,15 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
-	int asid;
+	u32 asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
-	asid = arm_smmu_bitmap_alloc(smmu->asid_map, smmu->asid_bits);
-	if (asid < 0)
-		return asid;
+	ret = xa_alloc(&asid_xa, &asid, &cfg->cd,
+		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
+	if (ret)
+		return ret;
 
 	cfg->s1cdmax = master->ssid_bits;
 
@@ -2446,7 +2455,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 out_free_cd_tables:
 	arm_smmu_free_cd_tables(smmu_domain);
 out_free_asid:
-	arm_smmu_bitmap_free(smmu->asid_map, asid);
+	arm_smmu_free_asid(&cfg->cd);
 	return ret;
 }
 
-- 
2.25.0

