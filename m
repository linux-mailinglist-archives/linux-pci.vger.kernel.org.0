Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87CB513C1D4
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 13:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgAOMxh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 07:53:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34056 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgAOMxg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2020 07:53:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id w5so4684815wmi.1
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2020 04:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=in26yMaZg6abF2yqvUJjPFZYANziWWa0eLADh6G3Ifo=;
        b=KYkxSNqGoykHOtMF+QyweVPd8z8QHaDFJVOOc82qJ9FI/2oPuBi1AFY3YgT9l6pkPL
         ynQwh/VbngNEoEnwC9LmKtcklVpWETBB2Ha8Kd8oI7sx82tx8Udfgc5ZjFjeFwD1/Wuh
         clU032RmX0bz4skodakrFBabzvmrj4eyUSoIpbKPqu5YLQ5MPO9VrstW/PZAR14aI920
         MHgh+jcXHtVnEEms5hTJ3MtiNE3Ffl3TxLuRiYRGWbxq15sDaKrIZU0y8HgNBJxGoKa6
         s2gU7h9se5LnGBCRJKbKaBCC/0VH8TTIhEHK/BWjyF3CwfAMX2My9A7j1V6uDO5lvMEq
         Ginw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=in26yMaZg6abF2yqvUJjPFZYANziWWa0eLADh6G3Ifo=;
        b=aOlp0u4d/OeZOfwPO3nMgoOLsA4nb7LPUKjsBKTIFutacxZpKpjlsO1n7wVh4Gud+f
         yk9Kj41hVV7XdvypI5HvcaqqAHGnQFXQBbzxeJHkyoIySBCgCZFs2qonxDfDBGPymMjC
         VWzTV854qgWdEUslxxu92iFqyAAfGKbSl6C1ZL/SSdufgEPzDOloLeeLd2XbAIRsX8FL
         I9hx8KW70H9r7KREtrk5F6wBWZCN0gumxJf+l26qfiqqk53xyT91HfGMaQLF6kankGBX
         XAYzvSrvT53EU7iTKZynG1o1mCV2Ne0NBK0GqNIJa2GJU271uUp8UuCUMbtKsRBwOYyE
         b/fQ==
X-Gm-Message-State: APjAAAXOlKaKE/vGTfthuqfdrr9zYpURU5LsWAXOvZOH213LEMk07fjp
        uqsrW8BUy/Q69uL7DvhlMvW6qj4wNgQ=
X-Google-Smtp-Source: APXvYqyohJNdvB6MKflgoRReAN7/MUNP/x8LeCEXk7CBOIMa+UpMWhsowT73ysRp4ydr7ualZQdvEg==
X-Received: by 2002:a1c:a702:: with SMTP id q2mr34068062wme.6.1579092814518;
        Wed, 15 Jan 2020 04:53:34 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d12sm25196171wrp.62.2020.01.15.04.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 04:53:34 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, will@kernel.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com, eric.auger@redhat.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: [PATCH v5 06/13] iommu/arm-smmu-v3: Add context descriptor tables allocators
Date:   Wed, 15 Jan 2020 13:52:32 +0100
Message-Id: <20200115125239.136759-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115125239.136759-1-jean-philippe@linaro.org>
References: <20200115125239.136759-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Support for SSID will require allocating context descriptor tables. Move
the context descriptor allocation to separate functions.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 47 +++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e7c7e34d385f..a3438e256bd0 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -563,11 +563,13 @@ struct arm_smmu_ctx_desc {
 struct arm_smmu_ctx_desc_cfg {
 	__le64				*cdtab;
 	dma_addr_t			cdtab_dma;
+	unsigned int			num_l1_ents;
 };
 
 struct arm_smmu_s1_cfg {
 	struct arm_smmu_ctx_desc_cfg	cdcfg;
 	struct arm_smmu_ctx_desc	cd;
+	u8				s1cdmax;
 };
 
 struct arm_smmu_s2_cfg {
@@ -1502,6 +1504,35 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
 	cdptr[3] = cpu_to_le64(cfg->cd.mair);
 }
 
+static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
+{
+	size_t l1size;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &cfg->cdcfg;
+
+	cdcfg->num_l1_ents = 1UL << cfg->s1cdmax;
+	l1size = cdcfg->num_l1_ents * (CTXDESC_CD_DWORDS << 3);
+	cdcfg->cdtab = dmam_alloc_coherent(smmu->dev, l1size, &cdcfg->cdtab_dma,
+					   GFP_KERNEL);
+	if (!cdcfg->cdtab) {
+		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
+	size_t l1size = cdcfg->num_l1_ents * (CTXDESC_CD_DWORDS << 3);
+
+	dmam_free_coherent(smmu->dev, l1size, cdcfg->cdtab, cdcfg->cdtab_dma);
+	cdcfg->cdtab_dma = 0;
+	cdcfg->cdtab = NULL;
+}
+
 /* Stream table manipulation functions */
 static void
 arm_smmu_write_strtab_l1_desc(__le64 *dst, struct arm_smmu_strtab_l1_desc *desc)
@@ -2145,11 +2176,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
 		if (cfg->cdcfg.cdtab) {
-			dmam_free_coherent(smmu_domain->smmu->dev,
-					   CTXDESC_CD_DWORDS << 3,
-					   cfg->cdcfg.cdtab,
-					   cfg->cdcfg.cdtab_dma);
-
+			arm_smmu_free_cd_tables(smmu_domain);
 			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
 		}
 	} else {
@@ -2173,15 +2200,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (asid < 0)
 		return asid;
 
-	cfg->cdcfg.cdtab = dmam_alloc_coherent(smmu->dev,
-					       CTXDESC_CD_DWORDS << 3,
-					       &cfg->cdcfg.cdtab_dma,
-					       GFP_KERNEL);
-	if (!cfg->cdcfg.cdtab) {
-		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
-		ret = -ENOMEM;
+	ret = arm_smmu_alloc_cd_tables(smmu_domain);
+	if (ret)
 		goto out_free_asid;
-	}
 
 	cfg->cd.asid	= (u16)asid;
 	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
-- 
2.24.1

