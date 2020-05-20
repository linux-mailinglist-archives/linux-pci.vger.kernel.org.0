Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDB41DB841
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 17:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgETPcw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 11:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgETPcv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 11:32:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D9DC05BD43
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 08:32:51 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k13so3626544wrx.3
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 08:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1nOz9oJXJsBp0Pv8EAcijkkig9a/lDsRyH7fIHxuOyo=;
        b=NyfejZCyR749KuE+DWatqT6qWazMYFpQkVMGIdQXHn3J9NmjJ+p1lFrfTPgP0PVC1H
         J8UNAuCs6RSyO3blMwd6v8lsOM3dURZd9wwpYa/wafLuX9jxQrbUpAkNZ9qtjNrsb0GZ
         LgNprtlWLpVp/y9LR+luDthYcxWiTrK/pgxia+qcHs50IrUG8Li1TDTGzxpQ5aEPqDKk
         GZvkHBgYHD/Fwr/1k3LLSVABNaq3XRgGFSVGt6eww19sznOZORIHGMgZTvKpQe+Jf2kg
         shRdICnzO1febMCpv2zSlcrwr61fsX2iokq8z6WZ4PviE/lwxB7hsTooqBrRk+8CEoZG
         K4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1nOz9oJXJsBp0Pv8EAcijkkig9a/lDsRyH7fIHxuOyo=;
        b=Pk2zm2FqjDxNUyfAESXnfgl5GmGef3mNZA51Hal7WuUEYsq+zv/EuFb4DU5jhx5AUS
         qRIQngTbHRIsimSSLsUN6/0Jcn9CYT+RHUVKRsRAqwhe4egwIDnl51a8D57Qg85m3v+V
         bJqeWIPXkdte4dmYBrz132S5bPAM/n29a4sjtsdqXFyQlJfNf2dfqKlpM5gCmBPyZk1h
         emT3ZHSWuGc5nrFVyQeLwQejCFex9PhZyhPUDMMskixo/KP813hc2w6HIat7jGlXg5tz
         Q8YhfRgktHw7X5+kXptXyiE4EFj6jrGTU5BDCCrFt/mzZJ9sLyAiv6p8sXWqFxYN7aFv
         6TbQ==
X-Gm-Message-State: AOAM532GpEhyvBgjGriHUYFiYO36KDYdI7XIQcy+opRLhlJhu1PUzh6b
        QRs2Vq1xT8/oQ8PsxzI4A4ZpdVmPwQA=
X-Google-Smtp-Source: ABdhPJx59HlfNOzaBiKhlFJ/pYv623nu18Wd7KEcgzKhucQcQE/H44ghrIVuFl4DIUQ5qDA5jAQU/g==
X-Received: by 2002:a5d:684f:: with SMTP id o15mr4463346wrw.89.1589988769690;
        Wed, 20 May 2020 08:32:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id 5sm3395840wmd.19.2020.05.20.08.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 08:32:49 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        bhelgaas@google.com
Cc:     will@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, ashok.raj@intel.com,
        alex.williamson@redhat.com, hch@infradead.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 3/4] iommu/arm-smmu-v3: Use pci_ats_supported()
Date:   Wed, 20 May 2020 17:22:02 +0200
Message-Id: <20200520152201.3309416-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520152201.3309416-1-jean-philippe@linaro.org>
References: <20200520152201.3309416-1-jean-philippe@linaro.org>
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
 drivers/iommu/arm-smmu-v3.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 82508730feb7..c5730557dbe3 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2652,26 +2652,20 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 	}
 }
 
-#ifdef CONFIG_PCI_ATS
 static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 {
-	struct pci_dev *pdev;
+	struct device *dev = master->dev;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
-	if (!(smmu->features & ARM_SMMU_FEAT_ATS) || !dev_is_pci(master->dev) ||
-	    !(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS) || pci_ats_disabled())
+	if (!(smmu->features & ARM_SMMU_FEAT_ATS))
 		return false;
 
-	pdev = to_pci_dev(master->dev);
-	return !pdev->untrusted && pdev->ats_cap;
-}
-#else
-static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
-{
-	return false;
+	if (!(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS))
+		return false;
+
+	return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
 }
-#endif
 
 static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 {
-- 
2.26.2

