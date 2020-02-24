Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A06E16AC7E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 17:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbgBXQ7J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 11:59:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55848 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbgBXQ7I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 11:59:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so31919wmj.5
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 08:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HsNqDpM5GYOb0rP3SKvjSjiXAgrPp7/dDnFzXTvMfm0=;
        b=fxdWSvL7/PlqMuOjCbpoyDK0oOMZfWMx8Bn0sQViiqiE3H2JO3U4xq75c/gD0NU1IB
         5LX+dV8sT5h1EGNCfmF3/Oc4OwWIiPSscSgJ9EdoXDkOLYlFea7GgkHZEKGQ4n3RX2xc
         tE0Z9fTNGrynG92HHnK+qNkjvWnd1/LmhQMR8Wkp+U8ifjROHa1WaQQXNc85lp2jIC+P
         lz56h7v5lvnlEFIVnmE4jx/Q/BDcbY3YEs++7gzkztWZ4dCkTt2gdyf4zasHzdwGusEP
         V4s2WLd6VesfOZIZPnXJjsJsg1FHR6SX/xW3H+Vqf2K7q/htUfeBaETDNaFwfGHo9nb3
         TUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HsNqDpM5GYOb0rP3SKvjSjiXAgrPp7/dDnFzXTvMfm0=;
        b=iPXPj85TnvnhdbFMfG5nUXIM/e6zkjizZpwBJebMs7Hn8wCy15Y1o9CcyTYq+qgT0S
         rQ5xvIZdx7MkYt3MQ5f3Wnmi7Cg1vzlGNvVPJJOmo02rdv7U6sr8bH3y6FPZ9LmZPAo3
         JIDyCbguhYi4lOiUeVzpFnxS6g1N5CUYphc8q4w6gVyPQHJLFFY8Pxcp7bWD08uhn2YT
         FZNJMk5PvHXNaP6KNEyDF06yhz+it9+JSdc9yu/M+3i2rV8n8UNepCriscRfFaNISbD0
         7G+POn/xI/X5lKnIbaoxB8tmVwA3mWeAG4OGiJxDJXz9K0MS7ZviG+4Kheko4rtC25VI
         hTIg==
X-Gm-Message-State: APjAAAWfZU6HYnEpii9dRfZDYcL3m0WFyvANSKf5Pl+Ow3joU+pvDdiV
        tAKBlgcB19lAQqr53BpMkqhAxh8f3+c=
X-Google-Smtp-Source: APXvYqxzLvSxV15TQeDzuS7Vx3zfQgb1/0PPrdplrfLn1QNB4Up5cq5+1azMjxbcKStUM/cjgwhbxA==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr35940wmi.10.1582563546869;
        Mon, 24 Feb 2020 08:59:06 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id b10sm19473978wrt.90.2020.02.24.08.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 08:59:06 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, will@kernel.org,
        bhelgaas@google.com
Cc:     joro@8bytes.org, robin.murphy@arm.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org, robh@kernel.org
Subject: [PATCH v2 5/6] iommu/arm-smmu-v3: Batch context descriptor invalidation
Date:   Mon, 24 Feb 2020 17:58:45 +0100
Message-Id: <20200224165846.345993-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224165846.345993-1-jean-philippe@linaro.org>
References: <20200224165846.345993-1-jean-philippe@linaro.org>
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
 drivers/iommu/arm-smmu-v3.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index beeec366bc41..12b2a0fa747e 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1512,6 +1512,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 	size_t i;
 	unsigned long flags;
 	struct arm_smmu_master *master;
+	struct arm_smmu_cmdq_batch cmds = {};
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cmdq_ent cmd = {
 		.opcode	= CMDQ_OP_CFGI_CD,
@@ -1525,12 +1526,12 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
 		for (i = 0; i < master->num_sids; i++) {
 			cmd.cfgi.sid = master->sids[i];
-			arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
 		}
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	arm_smmu_cmdq_issue_sync(smmu);
+	arm_smmu_cmdq_batch_submit(smmu, &cmds);
 }
 
 static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
-- 
2.25.0

