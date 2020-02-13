Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D23715BC6F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 11:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgBMKOs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 05:14:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44691 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgBMKOs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2020 05:14:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id m16so5892475wrx.11
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2020 02:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L9Q0qcxnkV13c6MhKRP3gkBpAW/Xjj6KTCyBYPPUbo8=;
        b=LiIOnGXo+1V5X4BBKECkUfbWR73U9DnrPU1pNO8cxMgeZIEroezVjURh8NbYtZC3Uq
         7g/McoLvPT54IaXv77TmDcfIz9XkxAJW0y/z+aaNhUtd4yleQcmOkWDjKc+9fIE3IkBi
         RZXmj77XMU7r3GLU5vVtyisnlRaHZmAxriLxL2nbxuw8BT7TE1h96cCAssdBa6IEbqsW
         jOI1Mx55wwplBlekHQLSW1xsreMKFUSXkAPbX95yhKcIdBpMO1v3o67YP/vyON5z8zES
         B6UfwVZ4qNdFptn9nc3ekb8wOL0wtrcKHNjknbmM7g6ZNbKbrXjBehtJ9yCmd0ifVMIL
         BghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L9Q0qcxnkV13c6MhKRP3gkBpAW/Xjj6KTCyBYPPUbo8=;
        b=BggcU9p+Ei9tTIaSQX0nTtMplXxSIVF8hoUTbuiRcZ/Dzu0+BwIXVenAO3qMoePuDH
         o5mip6O95eSYSdlwRF/d6T9vqSwBhV6QnvZXiwPVUlRJsMh/gjEvvCVo/8FRg5/mC9Dh
         SSMqQwbC3ZRPr5TGum+zDS4BK9p/OcwX1qEwVPjmZr/kWyWM089gKvNCX9jCfqmKCHCG
         GAK2TS0DSwK0od8in19/kkAMe1QHSreWRpSu/FX+A9ZrObTXA6gj8567b5OyjGKVUWnY
         3XOGAp/tvQ5qxnfLwR2VTP0NmRa4B9ywptrhlmbUSY3nZstZYFDAan/Cu6NJ2lMtoMxm
         qExw==
X-Gm-Message-State: APjAAAXhkyXfWcF5S3le2rrCuNH++0noZi3UyjbmZrI648Dl+IIbNtP3
        LZ+bI/kD/YrRQUvWEu7fK2qX1N5uiIE=
X-Google-Smtp-Source: APXvYqwSxpKXbSMy45Iflgb/oggW3gSVdZ3l436ykNIVtfT1vHBYjdOvlXejPjzPm37riWjiclruZg==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr20491760wro.310.1581588885858;
        Thu, 13 Feb 2020 02:14:45 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y131sm2428059wmc.13.2020.02.13.02.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 02:14:45 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, will@kernel.org,
        bhelgaas@google.com
Cc:     joro@8bytes.org, robin.murphy@arm.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org
Subject: [PATCH 2/4] iommu/arm-smmu-v3: Add support for PCI PASID
Date:   Thu, 13 Feb 2020 11:14:33 +0100
Message-Id: <20200213101435.229932-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213101435.229932-1-jean-philippe@linaro.org>
References: <20200213101435.229932-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable PASID for PCI devices that support it. Initialize PASID early in
add_device() because it must be enabled before ATS.

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 62 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index aa3ac2a03807..6b76df37025e 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2628,6 +2628,53 @@ static void arm_smmu_disable_ats(struct arm_smmu_master *master)
 	atomic_dec(&smmu_domain->nr_ats_masters);
 }
 
+static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
+{
+	int ret;
+	int features;
+	int num_pasids;
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(master->dev))
+		return -ENODEV;
+
+	pdev = to_pci_dev(master->dev);
+
+	features = pci_pasid_features(pdev);
+	if (features < 0)
+		return features;
+
+	num_pasids = pci_max_pasids(pdev);
+	if (num_pasids <= 0)
+		return num_pasids;
+
+	ret = pci_enable_pasid(pdev, features);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to enable PASID\n");
+		return ret;
+	}
+
+	master->ssid_bits = min_t(u8, ilog2(num_pasids),
+				  master->smmu->ssid_bits);
+	return 0;
+}
+
+static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(master->dev))
+		return;
+
+	pdev = to_pci_dev(master->dev);
+
+	if (!pdev->pasid_enabled)
+		return;
+
+	master->ssid_bits = 0;
+	pci_disable_pasid(pdev);
+}
+
 static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 {
 	unsigned long flags;
@@ -2831,13 +2878,23 @@ static int arm_smmu_add_device(struct device *dev)
 
 	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
 
+	/*
+	 * Note that PASID must be enabled before, and disabled after ATS:
+	 * PCI Express Base 4.0r1.0 - 10.5.1.3 ATS Control Register
+	 *
+	 *   Behavior is undefined if this bit is Set and the value of the PASID
+	 *   Enable, Execute Requested Enable, or Privileged Mode Requested bits
+	 *   are changed.
+	 */
+	arm_smmu_enable_pasid(master);
+
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB))
 		master->ssid_bits = min_t(u8, master->ssid_bits,
 					  CTXDESC_LINEAR_CDMAX);
 
 	ret = iommu_device_link(&smmu->iommu, dev);
 	if (ret)
-		goto err_free_master;
+		goto err_disable_pasid;
 
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group)) {
@@ -2850,6 +2907,8 @@ static int arm_smmu_add_device(struct device *dev)
 
 err_unlink:
 	iommu_device_unlink(&smmu->iommu, dev);
+err_disable_pasid:
+	arm_smmu_disable_pasid(master);
 err_free_master:
 	kfree(master);
 	fwspec->iommu_priv = NULL;
@@ -2870,6 +2929,7 @@ static void arm_smmu_remove_device(struct device *dev)
 	arm_smmu_detach_dev(master);
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&smmu->iommu, dev);
+	arm_smmu_disable_pasid(master);
 	kfree(master);
 	iommu_fwspec_free(dev);
 }
-- 
2.25.0

