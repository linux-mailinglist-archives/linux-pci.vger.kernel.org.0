Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38E1B16AED8
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 19:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgBXSYw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 13:24:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39230 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbgBXSYw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 13:24:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so2769256wrn.6
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 10:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZmUwfBE2Jvvg1hKUoqTW1Tzu3Hjef3qChRCYp/V+4z4=;
        b=fxvvkF/Z32DjH84285DNlIPhJoi0kRLNJoxVIH7KOt2EDK83vWJJdX2p0ctjcP0+gm
         qisx9YvSxt+OhX+CZ8obez7cElrie6GQHcCW1oQ4UQb93k576+N2gpVIEqJVr9bohALT
         6riHGDBI9q5MffRpe8+xohDweiZ/qUWIrGYHsajhyVDmsdv3l8uSOo5T9POpRTIIiapz
         FvwthMPXu+xQ8cHZx0EbY0+ZszexexopCdlk5+7lw+f4/+AQcZADd2kews00jYTIZqws
         RHpE2hpFC9DfAMDCdZxJmKNinpQ8YtMpz5/fZkrtYGwf+p++YWkknqDYg95TBwEvcHpE
         JJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZmUwfBE2Jvvg1hKUoqTW1Tzu3Hjef3qChRCYp/V+4z4=;
        b=gqIVU5j5uQmrwU5csrjIU3p5UWGIl6gNSUJfIOGQBKXLDJWTkn5dYHutUuATfrsTTv
         TkVM5SkAeo6OSXgjNQINfM9U9o+2VPRoB6cWlO4vnxJkFH5yqomXTGzaN56sAbp0b6tO
         XliX4LysYXNr+CEu3Wwb1pBoT4G5Ky9EMVOvFaYF59tVHS8ESqXPWiuimBykW7QT4+os
         xvtWhZ+6IJZPamwke2OidhPMcwtmgyTtiJhfeXUZCyiAlx64y+12YxKwKTD7XCPT4rCK
         8cKUX66ApGW5RbEwwdIgoT5F3rDl0QhLI33PZkyE0yRKfGowpyBYID4t7GVJQ2/P3p2F
         ip9Q==
X-Gm-Message-State: APjAAAVwf7J6AlWoMqytIno03+Rynwzg2TlhQqef8iYdYPM2ykj8RNyZ
        oNS+9oQqqLqRIe1Lmnm4yAUYoA==
X-Google-Smtp-Source: APXvYqybBiQ3Y5uECJkf6wnUNdgrSmLMTNXn6Wwg6bg+H52TrB4b+jy0fSf/fGsZzyfFNyePzPdLuA==
X-Received: by 2002:adf:df90:: with SMTP id z16mr66588301wrl.273.1582568689235;
        Mon, 24 Feb 2020 10:24:49 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:24:48 -0800 (PST)
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
Subject: [PATCH v4 18/26] iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops
Date:   Mon, 24 Feb 2020 19:23:53 +0100
Message-Id: <20200224182401.353359-19-jean-philippe@linaro.org>
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

The core calls us when an mm is modified. Perform the required ATC
invalidations.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 44 ++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 3973f7222864..95b4caceae1a 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2354,6 +2354,20 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 	size_t inval_grain_shift = 12;
 	unsigned long page_start, page_end;
 
+	/*
+	 * ATS and PASID:
+	 *
+	 * If substream_valid is clear, the PCIe TLP is sent without a PASID
+	 * prefix. In that case all ATC entries within the address range are
+	 * invalidated, including those that were requested with a PASID! There
+	 * is no way to invalidate only entries without PASID.
+	 *
+	 * When using STRTAB_STE_1_S1DSS_SSID0 (reserving CD 0 for non-PASID
+	 * traffic), translation requests without PASID create ATC entries
+	 * without PASID, which must be invalidated with substream_valid clear.
+	 * This has the unpleasant side-effect of invalidating all PASID-tagged
+	 * ATC entries within the address range.
+	 */
 	*cmd = (struct arm_smmu_cmdq_ent) {
 		.opcode			= CMDQ_OP_ATC_INV,
 		.substream_valid	= !!ssid,
@@ -2397,12 +2411,12 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 	cmd->atc.size	= log2_span;
 }
 
-static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
+static int arm_smmu_atc_inv_master(struct arm_smmu_master *master, int ssid)
 {
 	int i;
 	struct arm_smmu_cmdq_ent cmd;
 
-	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
+	arm_smmu_atc_inv_to_cmd(ssid, 0, 0, &cmd);
 
 	for (i = 0; i < master->num_sids; i++) {
 		cmd.atc.sid = master->sids[i];
@@ -2874,7 +2888,7 @@ static void arm_smmu_disable_ats(struct arm_smmu_master *master)
 	 * ATC invalidation via the SMMU.
 	 */
 	wmb();
-	arm_smmu_atc_inv_master(master);
+	arm_smmu_atc_inv_master(master, 0);
 	atomic_dec(&smmu_domain->nr_ats_masters);
 }
 
@@ -3065,7 +3079,22 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 static void arm_smmu_mm_invalidate(struct device *dev, int pasid, void *entry,
 				   unsigned long iova, size_t size)
 {
-	/* TODO: Invalidate ATC */
+	int i;
+	struct arm_smmu_cmdq_ent cmd;
+	struct arm_smmu_cmdq_batch cmds = {};
+	struct arm_smmu_master *master = dev_to_master(dev);
+
+	if (!master->ats_enabled)
+		return;
+
+	arm_smmu_atc_inv_to_cmd(pasid, iova, size, &cmd);
+
+	for (i = 0; i < master->num_sids; i++) {
+		cmd.atc.sid = master->sids[i];
+		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
+	}
+
+	arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
 }
 
 static int arm_smmu_mm_attach(struct device *dev, int pasid, void *entry,
@@ -3089,6 +3118,7 @@ static void arm_smmu_mm_detach(struct device *dev, int pasid, void *entry,
 			       bool detach_domain)
 {
 	struct arm_smmu_ctx_desc *cd = entry;
+	struct arm_smmu_master *master = dev_to_master(dev);
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
@@ -3102,9 +3132,11 @@ static void arm_smmu_mm_detach(struct device *dev, int pasid, void *entry,
 		 * invalidation.
 		 */
 		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
-	}
+		arm_smmu_atc_inv_domain(smmu_domain, pasid, 0, 0);
 
-	/* TODO: invalidate ATC */
+	} else if (master->ats_enabled) {
+		arm_smmu_atc_inv_master(master, pasid);
+	}
 }
 
 static void *arm_smmu_mm_alloc(struct mm_struct *mm)
-- 
2.25.0

