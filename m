Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE0516AC7F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 17:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgBXQ7K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 11:59:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35577 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgBXQ7K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 11:59:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so71451wmb.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 08:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8wR4JvjjnPlxADINM207T0IRGzt73ZsNoWPOZadfSNk=;
        b=MVNhbcg8wD57oQ9I2JyLERVR2yKCiLO+U8+KIMgmDXq5uE3Xz17SRqISJlYfd4ir0f
         R4kd49dYtzzGIjmUKtm2Nil6peOKseDxSX6LLgZymQYn3PjxOlFG7DMwufOltiWTpMwW
         nAvv/0bXQehpLWgHnz/JM8FzL1XTmsAaoNNKJDC2OGvlpi33JinznQOQFLaMEP8oSMB6
         p2D8+W5IrG6gxs6dgpvB2oEc9zTKeiWuWpX4iz8pcAiJETSzXOdN8W2cI7+0K3InfFhi
         mhvq6KoZzQD35eEblEKVN/M5SfSNB4cjLRfBZyi4z0D6gsum8FD4M5GXqNy0vqyUQ8Ek
         kgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8wR4JvjjnPlxADINM207T0IRGzt73ZsNoWPOZadfSNk=;
        b=ptsN54sIQlaAiystK9pa+Qih934TCkkhy4p5/r3lLe4fwYv1oZsGpwEIG78QPbdZml
         /urxQHO8QhuCG1665kjfMrRyHpjx2EeTeI5zvxCRrl9/rnri55VXvPa+ZTvTyX2LY1Vq
         1YHG8PqfzoKCDLgVz2fLIbjOh1hmTYTIrtK3L7iTFcBxch/sG+1VN2zuO8a/eRuYXViG
         /7MKeiF46xM8orRFwB04nzqoCqV2e+f5dR9GbdtsGHyvswtkq9PbzNKyb4g2ovf8QQI4
         QkuTZ5izr76s3jaNkkCRCvPFo90oIBbq6rwG3nTQqwFdsDIHreYTog/RYvgmAwpFJCMq
         a4pw==
X-Gm-Message-State: APjAAAWJr0qIQu/XJMfH6yLS97MCC3j6hUpOBAYvAQR6hMXG0dH+kKoE
        CvQpqQBMs81TwEtHycFkjY2A20paPcE=
X-Google-Smtp-Source: APXvYqy5NCQ4cadqxMUKN5tm7gQWKMw6tJ7/zLaq1h3uCOJopLS3L3IpJR06WXC/akjTuCTTeW4gnw==
X-Received: by 2002:a05:600c:54e:: with SMTP id k14mr22152694wmc.115.1582563547735;
        Mon, 24 Feb 2020 08:59:07 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id b10sm19473978wrt.90.2020.02.24.08.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 08:59:07 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, will@kernel.org,
        bhelgaas@google.com
Cc:     joro@8bytes.org, robin.murphy@arm.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org, robh@kernel.org
Subject: [PATCH v2 6/6] iommu/arm-smmu-v3: Batch ATC invalidation commands
Date:   Mon, 24 Feb 2020 17:58:46 +0100
Message-Id: <20200224165846.345993-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224165846.345993-1-jean-philippe@linaro.org>
References: <20200224165846.345993-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rob Herring <robh@kernel.org>

Similar to commit 2af2e72b18b4 ("iommu/arm-smmu-v3: Defer TLB
invalidation until ->iotlb_sync()"), build up a list of ATC invalidation
commands and submit them all at once to the command queue instead of
one-by-one.

As there is only one caller of arm_smmu_atc_inv_master() left, we can
simplify it and avoid passing in struct arm_smmu_cmdq_ent.

Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 12b2a0fa747e..4f0a38dae6db 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2158,17 +2158,16 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 	cmd->atc.size	= log2_span;
 }
 
-static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
-				   struct arm_smmu_cmdq_ent *cmd)
+static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 {
 	int i;
+	struct arm_smmu_cmdq_ent cmd;
 
-	if (!master->ats_enabled)
-		return 0;
+	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
 
 	for (i = 0; i < master->num_sids; i++) {
-		cmd->atc.sid = master->sids[i];
-		arm_smmu_cmdq_issue_cmd(master->smmu, cmd);
+		cmd.atc.sid = master->sids[i];
+		arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
 	}
 
 	return arm_smmu_cmdq_issue_sync(master->smmu);
@@ -2177,10 +2176,11 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 				   int ssid, unsigned long iova, size_t size)
 {
-	int ret = 0;
+	int i;
 	unsigned long flags;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_master *master;
+	struct arm_smmu_cmdq_batch cmds = {};
 
 	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
 		return 0;
@@ -2205,11 +2205,18 @@ static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head)
-		ret |= arm_smmu_atc_inv_master(master, &cmd);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+		if (!master->ats_enabled)
+			continue;
+
+		for (i = 0; i < master->num_sids; i++) {
+			cmd.atc.sid = master->sids[i];
+			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
+		}
+	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	return ret ? -ETIMEDOUT : 0;
+	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
 }
 
 /* IO_PGTABLE API */
@@ -2629,7 +2636,6 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 
 static void arm_smmu_disable_ats(struct arm_smmu_master *master)
 {
-	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_domain *smmu_domain = master->domain;
 
 	if (!master->ats_enabled)
@@ -2641,8 +2647,7 @@ static void arm_smmu_disable_ats(struct arm_smmu_master *master)
 	 * ATC invalidation via the SMMU.
 	 */
 	wmb();
-	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
-	arm_smmu_atc_inv_master(master, &cmd);
+	arm_smmu_atc_inv_master(master);
 	atomic_dec(&smmu_domain->nr_ats_masters);
 }
 
-- 
2.25.0

