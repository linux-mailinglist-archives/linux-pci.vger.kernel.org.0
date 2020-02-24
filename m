Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5710416AECF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 19:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgBXSYs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 13:24:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39217 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgBXSYr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 13:24:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so2769065wrn.6
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 10:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NRHBKJykpG/l2CLRpIAYf7MF7s3vRHP9YUPKSLfMvLg=;
        b=fv4SMCnvr/ltph2l+C3yE2rK9K4wI8QLF5VnYwdocUe8//ucsgYRR0KK4iM6jBB6zB
         AzMs5Nr0Y9GzZhI8kPpCu6Z6IadvFKIuzmtHmzPpJ09JPCmVdjINhxdGb5rqj35RCjse
         xYohylfBvtq67rXze9BVQXkKxwnp56h/6D6t1S7IO5zLEiT8eS+g5M9gFNoAeE43veUr
         BOh2fCenr+RsobHOcYs7QpSHNIOHukYHR38/0QxKIDen0V/gPdnJz8euUqtTn/QieTo7
         QIjaRtodjoY8zQI/CSRapSnvw4JboLhdQzXsp77NGR7dnk8AbFyZ01aC5whAEWdgbeVT
         h+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRHBKJykpG/l2CLRpIAYf7MF7s3vRHP9YUPKSLfMvLg=;
        b=qP1jdZgYiL2qxgGa4qVabjhHQu0/Lu2ftwFXLzAzzIYyWUuCZlNnJxRQJXtnmBW+sp
         8jg/7EMxvJdnNX1bROo+zx1BZchjMADsXysmTSNYsKHY3WoDiTKnnXK/cUct7NrWZf6C
         9ONKgRVdCaLIi33+1vDzyhTOAXhMBf68AHN5YaOh9YvBC3q3BUkFxFIQnl9gMqD0IgIO
         i7s2eG/wyDqg0pe/bgYvdh6AKaVUvD/sGQzPDaOQZ9ZOlPtZI14TvwltNGKcCJSksfM3
         YvlZpgi4ew2OleTPbAUKI8lkTRZnqNFBmNNM9d8x4Rf65HcqFHGDNWlTOMDdN8A0ca3n
         MF+w==
X-Gm-Message-State: APjAAAWdGyDt18T8nwYRvLhxOCZGYEDiTg6ku+16giGGDG5SzsJRATmX
        /AGv4zZbey36WPySQ4id9nOcyQ==
X-Google-Smtp-Source: APXvYqxd3PKQLrWTH+xuDThNjeJqmjg7tyD5z1KfZrZ7d0GQka2DjspbetTkYKxFAd0IwbQ2IMfIhQ==
X-Received: by 2002:a5d:4a8c:: with SMTP id o12mr65975078wrq.43.1582568685910;
        Mon, 24 Feb 2020 10:24:45 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:24:45 -0800 (PST)
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
Subject: [PATCH v4 15/26] iommu/arm-smmu-v3: Add SVA feature checking
Date:   Mon, 24 Feb 2020 19:23:50 +0100
Message-Id: <20200224182401.353359-16-jean-philippe@linaro.org>
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

Aggregate all sanity-checks for sharing CPU page tables with the SMMU
under a single ARM_SMMU_FEAT_SVA bit. For PCIe SVA, users also need to
check FEAT_ATS and FEAT_PRI. For platform SVA, they will most likely have
to check FEAT_STALLS.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 72 +++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index b72b2fdcd21f..77a846440ba6 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -644,6 +644,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_VAX		(1 << 14)
 #define ARM_SMMU_FEAT_E2H		(1 << 15)
 #define ARM_SMMU_FEAT_BTM		(1 << 16)
+#define ARM_SMMU_FEAT_SVA		(1 << 17)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -3873,6 +3874,74 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	return 0;
 }
 
+static bool arm_smmu_supports_sva(struct arm_smmu_device *smmu)
+{
+	unsigned long reg, fld;
+	unsigned long oas;
+	unsigned long asid_bits;
+
+	u32 feat_mask = ARM_SMMU_FEAT_BTM | ARM_SMMU_FEAT_COHERENCY;
+
+	if ((smmu->features & feat_mask) != feat_mask)
+		return false;
+
+	if (!(smmu->pgsize_bitmap & PAGE_SIZE))
+		return false;
+
+	/*
+	 * Get the smallest PA size of all CPUs (sanitized by cpufeature). We're
+	 * not even pretending to support AArch32 here.
+	 */
+	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	fld = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
+	switch (fld) {
+	case 0x0:
+		oas = 32;
+		break;
+	case 0x1:
+		oas = 36;
+		break;
+	case 0x2:
+		oas = 40;
+		break;
+	case 0x3:
+		oas = 42;
+		break;
+	case 0x4:
+		oas = 44;
+		break;
+	case 0x5:
+		oas = 48;
+		break;
+	case 0x6:
+		oas = 52;
+		break;
+	default:
+		return false;
+	}
+
+	/* abort if MMU outputs addresses greater than what we support. */
+	if (smmu->oas < oas)
+		return false;
+
+	/* We can support bigger ASIDs than the CPU, but not smaller */
+	fld = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_ASID_SHIFT);
+	asid_bits = fld ? 16 : 8;
+	if (smmu->asid_bits < asid_bits)
+		return false;
+
+	/*
+	 * See max_pinned_asids in arch/arm64/mm/context.c. The following is
+	 * generally the maximum number of bindable processes.
+	 */
+	if (IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0))
+		asid_bits--;
+	dev_dbg(smmu->dev, "%d shared contexts\n", (1 << asid_bits) -
+		num_possible_cpus() - 2);
+
+	return true;
+}
+
 static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 {
 	u32 reg;
@@ -4080,6 +4149,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	smmu->ias = max(smmu->ias, smmu->oas);
 
+	if (arm_smmu_supports_sva(smmu))
+		smmu->features |= ARM_SMMU_FEAT_SVA;
+
 	dev_info(smmu->dev, "ias %lu-bit, oas %lu-bit (features 0x%08x)\n",
 		 smmu->ias, smmu->oas, smmu->features);
 	return 0;
-- 
2.25.0

