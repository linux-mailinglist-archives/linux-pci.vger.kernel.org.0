Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8AE15BC71
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 11:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgBMKOt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 05:14:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45381 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729494AbgBMKOt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2020 05:14:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id g3so5895342wrs.12
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2020 02:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y+lM1OggU9vK/FviSwCUPaJKK1SLUZczy02wSxpHTGA=;
        b=ITOJlvKtsqox/MA6KOfSi+vJ4namB81DtZOp6kWDIQxD7b+TlFocFAIVJlOuqeOJLw
         jnAwAYyOuE6iT1yKNsgrNsdlEVUXwo0f3f5XuFfWJeuedyhb6vC8ALBJtqp0b6WqHzE8
         qcrcDhLWP3E8SPA1MNxxhfnEcRr0f1sF8smyS60fScZh4qfp1bR0L2/19nrMx0VVcLtI
         R8R3J4ILmTuTwu4U4gig0mCX91+1y3N5G1JCG1U2azXLUt2MiXV280vRSIQCkl3byt1t
         V4PuXsmwZIfmXYs2bhHjNKBDr/fRVv7wge5cBW1xYX5hvuhkTT1LsLrJ04K0mX/sWEIs
         Z+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y+lM1OggU9vK/FviSwCUPaJKK1SLUZczy02wSxpHTGA=;
        b=BAj7Y6Ua6OyLtvn1MGHiQj0maYayWllboZy4pKc/SvbxH8p4zdqStxTjNhmV5dcmX+
         RnX/ynm9Zr/X4WqDy1KCKk346QpCocvcJ/1quWEyCkwkD3JalZDK3mKH2VS+EBtFxbSe
         92OiVR03I/tOCCQg1v/zqvxUXh2yc5VZ/kWT+aKkwzNOxsAEgr/xV9QrBF7xRZXjO6mS
         G53K1SF03jhtPUe9swrnvkG+rgrW/MVhbiYz6ktdCoZR0nsrdspo+grzjIZxmS3dTEAD
         YWpTJOu7nSsJ+STOCGd4vHKPVuRP4Puk9DwIYtlGPxanQdG49cSlPC5V4JXfeucCk0x0
         VBGg==
X-Gm-Message-State: APjAAAVJ0QbZVlPAO1LZPpiaguLLFyNmJRLd4juwl7WiALcj19Q5e+Zy
        BikPS21tJoP/ud01JA5MVrekCaKdqZw=
X-Google-Smtp-Source: APXvYqyIF3pDX0A+K0urbcmvtOzcjcAguWoWW+hZyO7RemW9wjkDXElnYRLpdtxPkurp4xCvx2E5jQ==
X-Received: by 2002:adf:df90:: with SMTP id z16mr20487511wrl.273.1581588886767;
        Thu, 13 Feb 2020 02:14:46 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y131sm2428059wmc.13.2020.02.13.02.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 02:14:46 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, will@kernel.org,
        bhelgaas@google.com
Cc:     joro@8bytes.org, robin.murphy@arm.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org
Subject: [PATCH 3/4] iommu/arm-smmu-v3: Batch context descriptor invalidation
Date:   Thu, 13 Feb 2020 11:14:34 +0100
Message-Id: <20200213101435.229932-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213101435.229932-1-jean-philippe@linaro.org>
References: <20200213101435.229932-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rather than publishing one command at a time when invalidating a context
descriptor, batch the commands for all SIDs in the domain.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 6b76df37025e..11123fbf22a5 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1487,8 +1487,10 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 			     int ssid, bool leaf)
 {
 	size_t i;
+	int cmdn = 0;
 	unsigned long flags;
 	struct arm_smmu_master *master;
+	u64 cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cmdq_ent cmd = {
 		.opcode	= CMDQ_OP_CFGI_CD,
@@ -1501,13 +1503,19 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
 		for (i = 0; i < master->num_sids; i++) {
+			if (cmdn == CMDQ_BATCH_ENTRIES) {
+				arm_smmu_cmdq_issue_cmdlist(smmu, cmds, cmdn, false);
+				cmdn = 0;
+			}
+
 			cmd.cfgi.sid = master->sids[i];
-			arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+			arm_smmu_cmdq_build_cmd(&cmds[cmdn * CMDQ_ENT_DWORDS], &cmd);
+			cmdn++;
 		}
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	arm_smmu_cmdq_issue_sync(smmu);
+	arm_smmu_cmdq_issue_cmdlist(smmu, cmds, cmdn, true);
 }
 
 static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
-- 
2.25.0

