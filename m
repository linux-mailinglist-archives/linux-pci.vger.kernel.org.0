Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09E6C16AC7D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 17:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgBXQ7J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 11:59:09 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36733 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbgBXQ7I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 11:59:08 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so61666wma.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 08:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XLHzcG1rM7CKaHACIaWqlr851SfTiMG1TWiRRSjmhnI=;
        b=cYA2Ki3712y1AnkYyhSFyI0gPtpDlkJM+1q36yhaQXLM5yHq3MpQEGpQGFn5acTJNq
         F0BBJHCxoFTbdxkeT2vlUqDSU2bBZcU0lb8elvwHyd4Vg/zVkkyjhd5+jJVBYTxNoe/1
         T887AvB5daQAFRCqRCHFVryjl79Ik52OOPX76rCW6nsW+PTelLhaY0/XaXm/hm7XJZOT
         bDtyCARPGJe9qEjvAqV4E1zbPS4JHztKZyP48RYwOQ+6UtYGoT41rVTvmBpGTezTRswQ
         jOK+z0mNca9ZAwbWfU/DpnD214mbXaRo45wfSK3F3fh4dc+SQHsQqOySm7gSx2MTFu0R
         hVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XLHzcG1rM7CKaHACIaWqlr851SfTiMG1TWiRRSjmhnI=;
        b=Ly+PtY5GLA1cpZ4NXANWW1DWKFcFp5w9A8tXHI/JJvTn4MYIUBbTAwk0AVJMdFth3E
         lzSDzlgk2GqSYU2Q7mPZHl2lwzB4iv/QfnERbd9GVmlQcHNFaFc7xUvZWlWXvCpqPYkO
         o6Zmc12ETH0/jQ27Xd1hlvu7BSCErGgNTY+H/1nFMvml58vuGkPbBbZkzsTtW8WoP03/
         Y4WbeW6USe9nC8bslTFsNtM4htLeCzRYToxtLUGi5dp5Kk5NqzGymwvv5LpqgYlY5YHk
         gK6+aXlxOOOBA8dyoWJLnM3OnGPBlS4WsGYxQSe5EqTfaTzbzyxpRb6sinwTZMmsH37r
         BF7A==
X-Gm-Message-State: APjAAAW62p7j7ZaBnWnztQvsmXYZSDXjmQOUaNLFx/zzOzybK/rAdmfm
        5EVjG0gjAcgtoiMx2FliUEPOh2xDUDQ=
X-Google-Smtp-Source: APXvYqyAQvDHFPlwol084YtmoxeK9ALvce8BoTf5MrLynyThLVJi07+L0kfZvMdagU1zen+M1p+zPA==
X-Received: by 2002:a7b:c088:: with SMTP id r8mr33668wmh.18.1582563545996;
        Mon, 24 Feb 2020 08:59:05 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id b10sm19473978wrt.90.2020.02.24.08.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 08:59:05 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, will@kernel.org,
        bhelgaas@google.com
Cc:     joro@8bytes.org, robin.murphy@arm.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org, robh@kernel.org
Subject: [PATCH v2 4/6] iommu/arm-smmu-v3: Add command queue batching helpers
Date:   Mon, 24 Feb 2020 17:58:44 +0100
Message-Id: <20200224165846.345993-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224165846.345993-1-jean-philippe@linaro.org>
References: <20200224165846.345993-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As more functions will implement command queue batching, add two helpers
to simplify building a command list.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 068a16d0eabe..beeec366bc41 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -548,6 +548,11 @@ struct arm_smmu_cmdq {
 	atomic_t			lock;
 };
 
+struct arm_smmu_cmdq_batch {
+	u64				cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
+	int				num;
+};
+
 struct arm_smmu_evtq {
 	struct arm_smmu_queue		q;
 	u32				max_stalls;
@@ -1482,6 +1487,24 @@ static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
 	return arm_smmu_cmdq_issue_cmdlist(smmu, NULL, 0, true);
 }
 
+static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
+				    struct arm_smmu_cmdq_batch *cmds,
+				    struct arm_smmu_cmdq_ent *cmd)
+{
+	if (cmds->num == CMDQ_BATCH_ENTRIES) {
+		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, false);
+		cmds->num = 0;
+	}
+	arm_smmu_cmdq_build_cmd(&cmds->cmds[cmds->num * CMDQ_ENT_DWORDS], cmd);
+	cmds->num++;
+}
+
+static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
+				      struct arm_smmu_cmdq_batch *cmds)
+{
+	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
+}
+
 /* Context descriptor manipulation functions */
 static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 			     int ssid, bool leaf)
@@ -2220,10 +2243,9 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
 				   size_t granule, bool leaf,
 				   struct arm_smmu_domain *smmu_domain)
 {
-	u64 cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	unsigned long start = iova, end = iova + size;
-	int i = 0;
+	struct arm_smmu_cmdq_batch cmds = {};
 	struct arm_smmu_cmdq_ent cmd = {
 		.tlbi = {
 			.leaf	= leaf,
@@ -2242,18 +2264,11 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
 	}
 
 	while (iova < end) {
-		if (i == CMDQ_BATCH_ENTRIES) {
-			arm_smmu_cmdq_issue_cmdlist(smmu, cmds, i, false);
-			i = 0;
-		}
-
 		cmd.tlbi.addr = iova;
-		arm_smmu_cmdq_build_cmd(&cmds[i * CMDQ_ENT_DWORDS], &cmd);
+		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
 		iova += granule;
-		i++;
 	}
-
-	arm_smmu_cmdq_issue_cmdlist(smmu, cmds, i, true);
+	arm_smmu_cmdq_batch_submit(smmu, &cmds);
 
 	/*
 	 * Unfortunately, this can't be leaf-only since we may have
-- 
2.25.0

