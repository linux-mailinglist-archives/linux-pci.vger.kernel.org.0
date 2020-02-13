Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44BD415BC74
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 11:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgBMKOv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 05:14:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33102 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729494AbgBMKOv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2020 05:14:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id u6so5948157wrt.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2020 02:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x5dk7qiKtWru6EN2nFzBqe4Wug6V5GV2jfq/LzU0wiw=;
        b=LxfZfpNC9g2Kao3Ca86IBRs1BVelmn8AvrmBdYYcvu/Ke2cjSOzIyL4tYo+CSK06ir
         w3b22BZqfdo7gA4OGIO7IPlmKXPutox8+BQRijvmJOLUFg76kRhQNt87DPJR4X9qAiMM
         +A7sCzIh/nwBLfWMREpCrSBlAqcRv1kBTi7+wkAkOLYjSyYzxvIfzyWCPOhfF2PIoZMr
         68xchnfm0tHysAcpb+CfWLgd+nrsjJ/carvqlZNvfgjhupYg/vPbGHa8oLMduRWowQxN
         SEyTmYq+kC8yFTfIDpTSzTGunUntmDOwNm/FB/pRONEy4RDWQgjDrBAGU67PZ2o+JbRW
         6vGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x5dk7qiKtWru6EN2nFzBqe4Wug6V5GV2jfq/LzU0wiw=;
        b=BuZ4I9FkAHHk3aDNBgjWP5/7YvKwUDRnT4+Ve+51IJF4CKWA9LtYhsIa1e2X3kgcxz
         whSctkGfEGDfF5yycjfv8V4iEr5JK+k1ZVWAwdEHsyVjjh3huhHgbzku4N6ColfcR1Q+
         v0/uzS7wXZNjCZFrJhomifVm/TEOgsbTzORR/vvXgr0LFeiVoR2f1CayqocVvyFUum9D
         c3ViOryfbMYE1DhFYyed9XGNoiOsHJqpTs+d3koHYaKwBYVE+lFnnGS1IQGsOybjQPt8
         Vd53mNo1VnLaaeVWfi8otRmp2oLQjddfoRjBZPAm7T5LkAlgH9mGpMM2+Eau1rIrLcnR
         PXEA==
X-Gm-Message-State: APjAAAUaMHaA71WHzdmn7xuRHWF7nZiUquyLuOCrbwSxbKcsmit1aj7i
        oohhsN9InBwrLB9sIiWOsljv2PgDfdg=
X-Google-Smtp-Source: APXvYqw6o99I0CZZyiTcqdl7ceH4XsBTkQw3w/87dL8LUwOg4DxhwdracytpcV7NsxduI66j7hSHCQ==
X-Received: by 2002:adf:f787:: with SMTP id q7mr20817905wrp.297.1581588887619;
        Thu, 13 Feb 2020 02:14:47 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y131sm2428059wmc.13.2020.02.13.02.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 02:14:47 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, will@kernel.org,
        bhelgaas@google.com
Cc:     joro@8bytes.org, robin.murphy@arm.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org
Subject: [PATCH 4/4] iommu/arm-smmu-v3: Write level-1 descriptors atomically
Date:   Thu, 13 Feb 2020 11:14:35 +0100
Message-Id: <20200213101435.229932-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213101435.229932-1-jean-philippe@linaro.org>
References: <20200213101435.229932-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use WRITE_ONCE() to make sure that the SMMU doesn't read incomplete
stream table descriptors. Refer to the comment about 64-bit accesses,
and add the comment to the equivalent context descriptor code.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 11123fbf22a5..034ad9671b83 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1539,6 +1539,7 @@ static void arm_smmu_write_cd_l1_desc(__le64 *dst,
 	u64 val = (l1_desc->l2ptr_dma & CTXDESC_L1_DESC_L2PTR_MASK) |
 		  CTXDESC_L1_DESC_V;
 
+	/* See comment in arm_smmu_write_ctx_desc() */
 	WRITE_ONCE(*dst, cpu_to_le64(val));
 }
 
@@ -1734,7 +1735,8 @@ arm_smmu_write_strtab_l1_desc(__le64 *dst, struct arm_smmu_strtab_l1_desc *desc)
 	val |= FIELD_PREP(STRTAB_L1_DESC_SPAN, desc->span);
 	val |= desc->l2ptr_dma & STRTAB_L1_DESC_L2PTR_MASK;
 
-	*dst = cpu_to_le64(val);
+	/* See comment in arm_smmu_write_ctx_desc() */
+	WRITE_ONCE(*dst, cpu_to_le64(val));
 }
 
 static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
-- 
2.25.0

