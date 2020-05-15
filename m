Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32671D4B54
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 12:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgEOKsf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 06:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgEOKse (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2020 06:48:34 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E69C061A0C
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2020 03:48:34 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so2135876wmh.3
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2020 03:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a6JIJM0/qnszNf/C3W1cfcENgwZD3tV9sE5r5AxKEdg=;
        b=dkOgLaKZgNbakPSRP7Xg1d2JPezWp8Wzc1IN+YzL2ukDlFUygw/oa6EQT8M2XqlTCz
         ITuN9QV0ywXV4ofR0kNh80z4tPGwVKsquc97eBK0CNEg2BYVNSMTj1o2Yb6UmqWBZjlr
         emzsm96xD2Kux4hLaBarRZQBAp3yJfXZIivFaOPGiHJuYf54/TcIl8cjoir+CegBn4h5
         AUVDdqHMF39wOISbc3FOzNe14afan4JQcxWpHPjxTLLpCXVr5MCCJeKyux6V/PE1Vq06
         Yw2WLEGTT679r7+OHD3vu1UOAOa/JxgOgbnXPMPb4TRcdsa2DVkMDiz0+9UOx0d5UhRT
         +32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a6JIJM0/qnszNf/C3W1cfcENgwZD3tV9sE5r5AxKEdg=;
        b=rp+aDNRvVu9OQkhSumPt7tGyRR8J7UJbyq1PdI/q4h4Z3GzdkU4k4UXwXejMnrUzsZ
         1piq5w1F3fBY59zOO1PHW6sev7vYsrprDJgz0CfyV1w5gpY3ArrQaZcyn1PCWT4mz9Uf
         5TsVK2ixNZV9E2OQK+7s4YlFg8218PYUQeQ94v3AzLRrc4EtwO18RBfdGY0j0V2zYGQp
         pkZ9OFArxsv+VPiWaFLAM38+9m41xOQs7RHdFMCVX5BfPUKnUv4MION728CRzcwKKOXS
         0D0S8oA2E09V+oSjUJPsbZaAivyoJ1gyQGsfsOqPaU6Vj5+ELp43q23WV09Iu9CLchAd
         PGGA==
X-Gm-Message-State: AOAM531SFLApNq6nMq3fimsz6zYPAAKYvdqDVvSBn1qXLcs8QYnRFcMb
        Nncs9PSVOsEeNMuDrRAKJx30kJ+5xUE=
X-Google-Smtp-Source: ABdhPJzAXq9W8ciuEA3yi7eG0GjsyM8zeMTSGluCiWiblbXlc1dMrCYhmrkIsv/zARo7bX3QPoZVEA==
X-Received: by 2002:a7b:c205:: with SMTP id x5mr3518890wmi.135.1589539712724;
        Fri, 15 May 2020 03:48:32 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id h27sm3510392wrc.46.2020.05.15.03.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:48:32 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        bhelgaas@google.com
Cc:     will@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, ashok.raj@intel.com,
        alex.williamson@redhat.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 3/4] iommu/arm-smmu-v3: Use pci_ats_supported()
Date:   Fri, 15 May 2020 12:44:01 +0200
Message-Id: <20200515104359.1178606-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515104359.1178606-1-jean-philippe@linaro.org>
References: <20200515104359.1178606-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The new pci_ats_supported() function checks if a device supports ATS and
is allowed to use it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
I dropped the Ack because I slightly changed the patch to keep the
fwspec check, since last version:
https://lore.kernel.org/linux-iommu/20200311124506.208376-8-jean-philippe@linaro.org/
---
 drivers/iommu/arm-smmu-v3.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 82508730feb7a1..39b935e86ab203 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2652,26 +2652,16 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 	}
 }
 
-#ifdef CONFIG_PCI_ATS
 static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 {
-	struct pci_dev *pdev;
+	struct device *dev = master->dev;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
-
-	if (!(smmu->features & ARM_SMMU_FEAT_ATS) || !dev_is_pci(master->dev) ||
-	    !(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS) || pci_ats_disabled())
-		return false;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
-	pdev = to_pci_dev(master->dev);
-	return !pdev->untrusted && pdev->ats_cap;
+	return (smmu->features & ARM_SMMU_FEAT_ATS) &&
+		!(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS) &&
+		dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
 }
-#else
-static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
-{
-	return false;
-}
-#endif
 
 static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 {
-- 
2.26.2

