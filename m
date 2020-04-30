Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615491BFEB8
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 16:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgD3Okh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 10:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728238AbgD3Okg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 10:40:36 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BFFC035494
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:36 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u16so2204687wmc.5
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6E7EOkoBPCqbsXIu3vkCbOjnxtmfKTDoinxuBew3XSc=;
        b=PgNBtasUJDfCwJ+wiciq3ECMRIi7prASOACz5goZtVeKxG3VLXxXqWa0RRBkp1Q2OB
         swIxTh8VulGMoztxfkdRWp3orJORII0ZBf2ye7KDD9SEQAKE65mF8WMxlI1gP5KC0/Ss
         zJq5vfvmHz9edg8x+NjRVM03W0r6LOS6pbFPVfh6/DSCRzSR0ELc4+c1/eghG/RzpL8l
         VhpMgYmnX/ZuXWa8AtHc12gmFCTWRHvwLl8IFdqHwmNF+hJpYl3N/kgcrxVZa2GV5Bl5
         IG37i3NXqBEYKSGM9UPgrw4U/cUlH/ZrXLg+4RJIAtNDHa8evp7HaNp2BvbQeyFQh88P
         mw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6E7EOkoBPCqbsXIu3vkCbOjnxtmfKTDoinxuBew3XSc=;
        b=XC2Tf3kl6wgxF4qpUZBFJHpteTWcWr5t9fZQ2kIBJnOwA3cx0+6tVq/e6NcfLkrllE
         /9ZAI7zJD329G+HZgm4ujssQvotwdkTN0QVRJzAgXP9TGzD154t1b4ltcs3o7utmWkWg
         sGtJifF1N3l1p3MFjvsuEEEYbcrJCCvNl1S60GMF1U/70RHSsAREa1XsvjkLg/NwdKM0
         HwkfFHjZzd+P4z/4nyMNOWWkqWiNWZPiyyooLczjIZRb1KQgHzk4YqOfzGN97AV8UJXj
         QrUTExMJge/ATe9aLwt+ytgsCE2lxmuaaDq9fPfpouRLDvmbMdG5pqes1pxKlOuiTJHq
         xWFg==
X-Gm-Message-State: AGi0PuYlyaa24Y6BNTyzfixNill+WrG+LY3S9S/d5PA+5zDbtZ93agIq
        2fcqe+IOEt0TuMuGU68jtZx9xw==
X-Google-Smtp-Source: APiQypLcTr6KBl+3kl22Fwtcelh0vbNq/9m4ShF50NjZnZujoh1tYHRDA2VuCyozRSAPGGx/xEl9ug==
X-Received: by 2002:a1c:f418:: with SMTP id z24mr3312168wma.122.1588257635132;
        Thu, 30 Apr 2020 07:40:35 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:40:34 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v6 14/25] iommu/arm-smmu-v3: Enable broadcast TLB maintenance
Date:   Thu, 30 Apr 2020 16:34:13 +0200
Message-Id: <20200430143424.2787566-15-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430143424.2787566-1-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
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
 drivers/iommu/arm-smmu-v3.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 3a70d032d4e71..a562c4b243292 100644
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
@@ -3809,11 +3811,14 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
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
@@ -3924,6 +3929,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 {
 	u32 reg;
 	bool coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;
+	bool vhe = cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN);
 
 	/* IDR0 */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
@@ -3973,10 +3979,19 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
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
2.26.2

