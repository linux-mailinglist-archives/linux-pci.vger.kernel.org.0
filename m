Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2211A86E2
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 19:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391584AbgDNRFC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 13:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391490AbgDNREl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2020 13:04:41 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C82C061A0E
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:40 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h2so13796390wmb.4
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WbxTMbV/4pSZQY8//KTZeKZ9tN56Paf1UOPOW4z/8RA=;
        b=EJcosvT8tFkBoFeE83VxfL3JFEp9wWkEoSy/u9HV1nMiRCsFuVEFCg34QhFQ0Ig2kd
         5RlmWmu750PxzLmkcygnohAcg49vEEDeNfjWtg5MKWWP6XFcyM2tj355kGY9uGF4ZAs4
         VBovUW//PIawkzdqzgeX1UNUTp2dC+P5BJ8PDfNxvR5iJK2NKUeVHSGq8m2iRyQCBYUr
         zAMqLF1jFxkHBxRtHTgX8Bt6G/4FEITLfhTi1sJBtKT3dPfkMTCxXA73c5L6GS3LRuAO
         VLIhcAN5rTerG5x4f/Bpu5puRhb3XuwkTyEhwJVJxBMzkVzzIn0g0hmFa9UkKW6yNlQZ
         8rtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WbxTMbV/4pSZQY8//KTZeKZ9tN56Paf1UOPOW4z/8RA=;
        b=rMk3jUPkBT/jiPplYLHFAO7gOROGNiAT4qyARrP7n5zq5YiRb8gFuVgFRTRwpitwUO
         onG8FJX0UsLbGHlvKnZeXQ+XAz26g1nEZGHt5Qruub1PptjIDytxBMV8/FXiQG4RVTbU
         II/PZyizNu++XWAFxymIbxQZ+AZcTQKAifkV0asgfhqQKlAMvotsm/Yq+jOEbDemyBjP
         FBBulFnL3evOiEpeUPpy8nCLgHTU6hDqWkq5gTOs9QrSBmGGHk7/AzwdMP4sowX+uarb
         KPKAOeKtOJmr0HuWDToIM2a+6AaMQQXLtFhe5shvZBMpkIZKN/f3bYDEw2xVKUNfW47V
         TYTA==
X-Gm-Message-State: AGi0PuZfqtaPjZg7qnxZOHdjgm48R9RFqMxfRzztUQqXuNVZXuM6NTCN
        dHY8VDvaKdFQMvhkEHP/AkmnIA==
X-Google-Smtp-Source: APiQypLVdIym/zn6jkDftt+MJ2EfuiypDwrDx/YKm8MzyYUO/W3AgP2uDmxEurb3a37PkHFH7PvBWg==
X-Received: by 2002:a1c:ed18:: with SMTP id l24mr783359wmh.122.1586883879712;
        Tue, 14 Apr 2020 10:04:39 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:04:39 -0700 (PDT)
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
Subject: [PATCH v5 15/25] iommu/arm-smmu-v3: Enable broadcast TLB maintenance
Date:   Tue, 14 Apr 2020 19:02:43 +0200
Message-Id: <20200414170252.714402-16-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SMMUv3 can handle invalidation targeted at TLB entries with shared
ASIDs. If the implementation supports broadcast TLB maintenance, enable it
and keep track of it in a feature bit. The SMMU will then be affected by
inner-shareable TLB invalidations from other agents.

A major side-effect of this change is that stage-2 translation contexts
are now affected by all invalidations by VMID. VMIDs are all shared and
the only ways to prevent over-invalidation, since the stage-2 page tables
are not shared between CPU and SMMU, are to either disable BTM or allocate
different VMIDs. This patch does not address the problem.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v4->v5: bump feature bit
---
 drivers/iommu/arm-smmu-v3.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 21d458d817fc2..e7de8a7459fa4 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -56,6 +56,7 @@
 #define IDR0_ASID16			(1 << 12)
 #define IDR0_ATS			(1 << 10)
 #define IDR0_HYP			(1 << 9)
+#define IDR0_BTM			(1 << 5)
 #define IDR0_COHACC			(1 << 4)
 #define IDR0_TTF			GENMASK(3, 2)
 #define IDR0_TTF_AARCH64		2
@@ -655,6 +656,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_VAX		(1 << 14)
 #define ARM_SMMU_FEAT_RANGE_INV		(1 << 15)
 #define ARM_SMMU_FEAT_E2H		(1 << 16)
+#define ARM_SMMU_FEAT_BTM		(1 << 17)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -3814,11 +3816,14 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	writel_relaxed(reg, smmu->base + ARM_SMMU_CR1);
 
 	/* CR2 (random crap) */
-	reg = CR2_PTM | CR2_RECINVSID;
+	reg = CR2_RECINVSID;
 
 	if (smmu->features & ARM_SMMU_FEAT_E2H)
 		reg |= CR2_E2H;
 
+	if (!(smmu->features & ARM_SMMU_FEAT_BTM))
+		reg |= CR2_PTM;
+
 	writel_relaxed(reg, smmu->base + ARM_SMMU_CR2);
 
 	/* Stream table */
@@ -3929,6 +3934,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 {
 	u32 reg;
 	bool coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;
+	bool vhe = cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN);
 
 	/* IDR0 */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
@@ -3978,10 +3984,19 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	if (reg & IDR0_HYP) {
 		smmu->features |= ARM_SMMU_FEAT_HYP;
-		if (cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN))
+		if (vhe)
 			smmu->features |= ARM_SMMU_FEAT_E2H;
 	}
 
+	/*
+	 * If the CPU is using VHE, but the SMMU doesn't support it, the SMMU
+	 * will create TLB entries for NH-EL1 world and will miss the
+	 * broadcasted TLB invalidations that target EL2-E2H world. Don't enable
+	 * BTM in that case.
+	 */
+	if (reg & IDR0_BTM && (!vhe || reg & IDR0_HYP))
+		smmu->features |= ARM_SMMU_FEAT_BTM;
+
 	/*
 	 * The coherency feature as set by FW is used in preference to the ID
 	 * register, but warn on mismatch.
-- 
2.26.0

