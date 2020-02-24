Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D65F416AECD
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 19:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgBXSYs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 13:24:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51709 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgBXSYr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 13:24:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id t23so318908wmi.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 10:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CtUhXGlPsIJ68oWTTxDmR3+h0pZJEayRCmYSb70blVo=;
        b=MFGs5MApluTu8IWUQBUgGAvYQlWhw1Qg2i+s50QDE2pYw6MygCWeXQvU/qEk+wfERl
         tPpPnU4HcP6RGBxQuFWSwHBNETP/FPS0qBwIHIkmI3LJOI5RvUK2VhdbyzebuzRIDKRZ
         KcNhdPVk42z7exdHVwlPnaJ/qMMBtfBGKweEvWlXxWjNys3C6A0o0SdGp9EMSAAxIo3H
         NANpUzrLoBK5dZmkPbaQsif1wuvzXYei3gn+ou7YVkO53ACHTmwdLRkdjRAXpY2EzFb+
         1IDZsvUikMU64ttNWS2qFyACSY2bSLQKCbTwGmkKTT8xO9+ZOMvb18lvg+NrPE5G9nsr
         /WWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CtUhXGlPsIJ68oWTTxDmR3+h0pZJEayRCmYSb70blVo=;
        b=BUdP8PTJqui+SPrcgkHiCiSfKCdBzCmZtWnak5tQm9ktUogPZb3BHUdLucDcgs0cCc
         7ztu6qBQtLAeQPnEdBISpP/rNurtNzhRkpM7zF2JdKKkfwB0ngO5hlO0Q2SuriTExzin
         fRe2ly6lSvfQI5DatVq+Jp3Q5M+vQQrucsFqQFD+hlW33xVuN4a81pDRE43C9osnIerq
         qKN5EsL/e8zZnwAiT0y/TToZxDOtuuBPCvqf3pyNRtW7xVDc9XBmuBz8o2tNoZPbvuyj
         CdtIcSC7rrmaRKENg/pEmXeQsADWKi5iFCLKU+6GeyvkgTLv+wGRQCv0a1iaAJ52hR2y
         8LHQ==
X-Gm-Message-State: APjAAAUOFkSWgTs+ilzKWERueKg1BJp/Tyl50ap86ZBaGL9AajIl6yZV
        fQOW31JaXxV8CkimADrN6/zgLw==
X-Google-Smtp-Source: APXvYqxO1XjG5q9pMUD2nep9ZGbytcZIoxc+NEQ3zQomCXOkrENArq99rGCzJfi6OEEwS8GBwWrg4A==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr318402wmj.117.1582568684877;
        Mon, 24 Feb 2020 10:24:44 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:24:44 -0800 (PST)
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
Subject: [PATCH v4 14/26] iommu/arm-smmu-v3: Enable broadcast TLB maintenance
Date:   Mon, 24 Feb 2020 19:23:49 +0100
Message-Id: <20200224182401.353359-15-jean-philippe@linaro.org>
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
 drivers/iommu/arm-smmu-v3.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 77554d89653b..b72b2fdcd21f 100644
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
@@ -642,6 +643,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_STALL_FORCE	(1 << 13)
 #define ARM_SMMU_FEAT_VAX		(1 << 14)
 #define ARM_SMMU_FEAT_E2H		(1 << 15)
+#define ARM_SMMU_FEAT_BTM		(1 << 16)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -3757,11 +3759,14 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
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
@@ -3872,6 +3877,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 {
 	u32 reg;
 	bool coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;
+	bool vhe = cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN);
 
 	/* IDR0 */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
@@ -3921,10 +3927,19 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
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
2.25.0

