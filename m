Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BED31266E4
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 17:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfLSQbX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 11:31:23 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38193 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfLSQbX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 11:31:23 -0500
Received: by mail-wm1-f65.google.com with SMTP id u2so6282602wmc.3
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2019 08:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qvpO6T6lCyQjsFcC/B3MAQOfFJPvli4NlBcE8bVnq2o=;
        b=ybmj/yFMV4WPp7svNei7QMmCl8bEZOgf5I1OmMiNuceKiEvs5FOwc+5QNBcmfQrlON
         DofenBUgXZTyi4JhcRiIepGkKcdGY4BtKidQwP7/JHO1FEOJNjzrzX8jKjeJNf5cwrSN
         tS2rRvNKSfBvhZDS+GHaReUR5s84Sru30RnnKkOevGMAjdhnFV1FNoTdrYF5xTS2C5Pz
         pBv91NSiFLc4P/2cJ1BRlji6oxczL+VzlLLYhsrAz88xLoCnUc9XjeqfwlqEjDnliWJA
         9uGe7CZ4PKzluz2OcGmuwW1v9QwotUUAWENXlNB7vZEd8IAreHDTExzizhbd8YlzdFMR
         HnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qvpO6T6lCyQjsFcC/B3MAQOfFJPvli4NlBcE8bVnq2o=;
        b=nvfLWXnjvEKpditRCl9ZaSGvUL8/Pu9NAdIsZOY6JgAj5bj8Ev3AIyDyp/ZNWALJA7
         4a5ZFhGZ8Fvl9tluqz1+roHzknSCGdG1cWhjM6PdcBazpbsfMbw3JOhBoxnH386BhVPg
         MYXD5wIhS1e1JCsSe1JZ4KvrtkJYRk94pgmujU4M838jjmnuWa1/0etzBB56dIFsOOZp
         JeM6yQU9xCoiLDNkVI2ymQfqqP0+fw4Fr0coSGIIxlLeh1oNvst1ZAJa+I/FP0MRtQ8y
         eO5tENDvGArBtiwWRlHcRFlYqEiYDwWsUvWYx+OEu/1IYE7SAR523KihoOMfD8HPWrxC
         XG8w==
X-Gm-Message-State: APjAAAVML0HpaVUrjLkHC5XnLOha8H/ahdD8KndC33Qb6qhVgKIB9B8O
        +ax5kgoZkpOoDheBCVWE+QLBulEZa8Y=
X-Google-Smtp-Source: APXvYqxbh4xLAjFUzI3q0HQZiQKtrGjMkp4J2NYL+c3vK40JxUXhicQB54JCrIL/QmT7sGb7qr24dA==
X-Received: by 2002:a1c:b456:: with SMTP id d83mr10758320wmf.172.1576773080107;
        Thu, 19 Dec 2019 08:31:20 -0800 (PST)
Received: from localhost.localdomain (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
        by smtp.gmail.com with ESMTPSA id u22sm7092068wru.30.2019.12.19.08.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 08:31:19 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        eric.auger@redhat.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org
Subject: [PATCH v4 01/13] iommu/arm-smmu-v3: Drop __GFP_ZERO flag from DMA allocation
Date:   Thu, 19 Dec 2019 17:30:21 +0100
Message-Id: <20191219163033.2608177-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219163033.2608177-1-jean-philippe@linaro.org>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit 518a2f1925c3 ("dma-mapping: zero memory returned from
dma_alloc_*"), dma_alloc_* always initializes memory to zero, so there
is no need to use dma_zalloc_* or pass the __GFP_ZERO flag anymore.

The flag was introduced by commit 04fa26c71be5 ("iommu/arm-smmu: Convert
DMA buffer allocations to the managed API"), since the managed API
didn't provide a dmam_zalloc_coherent() function.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index effe72eb89e7..d4e8b7f8d9f4 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1675,7 +1675,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 
 	desc->span = STRTAB_SPLIT + 1;
 	desc->l2ptr = dmam_alloc_coherent(smmu->dev, size, &desc->l2ptr_dma,
-					  GFP_KERNEL | __GFP_ZERO);
+					  GFP_KERNEL);
 	if (!desc->l2ptr) {
 		dev_err(smmu->dev,
 			"failed to allocate l2 stream table for SID %u\n",
@@ -2161,8 +2161,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 		return asid;
 
 	cfg->cdptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
-					 &cfg->cdptr_dma,
-					 GFP_KERNEL | __GFP_ZERO);
+					 &cfg->cdptr_dma, GFP_KERNEL);
 	if (!cfg->cdptr) {
 		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
 		ret = -ENOMEM;
@@ -2883,7 +2882,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 
 	l1size = cfg->num_l1_ents * (STRTAB_L1_DESC_DWORDS << 3);
 	strtab = dmam_alloc_coherent(smmu->dev, l1size, &cfg->strtab_dma,
-				     GFP_KERNEL | __GFP_ZERO);
+				     GFP_KERNEL);
 	if (!strtab) {
 		dev_err(smmu->dev,
 			"failed to allocate l1 stream table (%u bytes)\n",
@@ -2910,7 +2909,7 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 
 	size = (1 << smmu->sid_bits) * (STRTAB_STE_DWORDS << 3);
 	strtab = dmam_alloc_coherent(smmu->dev, size, &cfg->strtab_dma,
-				     GFP_KERNEL | __GFP_ZERO);
+				     GFP_KERNEL);
 	if (!strtab) {
 		dev_err(smmu->dev,
 			"failed to allocate linear stream table (%u bytes)\n",
-- 
2.24.1

