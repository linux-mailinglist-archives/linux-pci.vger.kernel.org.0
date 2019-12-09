Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2041173BC
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 19:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLISMP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 13:12:15 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54424 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfLISMM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2019 13:12:12 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so316734wmj.4
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2019 10:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Jy95GpXuB41eeo4n20teyNgd1G2nU5TuzFz1RfMDZA=;
        b=MvHltTFkWGnrY2RUUt/dkF3Te3Whrbc5t+ayM4vXT51tU64XLFPJZeJU7Rli1Vf0Ax
         hqS2UxEW9ClFH/C9XrzEr2ISfSb2/DQPOTNtSg8rBwgnkIQrmd7o3zsY10EXytPjJW4p
         VQgHTBbnYhCCnZIG20X0WxqxtbVVbn8QwQwr7Kn+Mai3Ph0GzDMPahspuwZEBICeBzLp
         56w+i2kRwO3y6jjuJm2+8rbFTC2GmVr5SlimgDOMcJeSYHprSnF8MBRjj2QRpqWzgO0f
         0dN5Ceof6Xt2msBg9iqmuzRsGtLXZB26nHNoTNxMUJ6RT0YTPHabBPX4JyCNCGSaoLpA
         Yyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Jy95GpXuB41eeo4n20teyNgd1G2nU5TuzFz1RfMDZA=;
        b=HF0oDLB7j6xBcH/5d/IYfe00LmPxRP0uY9WqaSlYtG1FxHgD19KEwyV2gbmXChf2HI
         XIIECQ5zapMcHSu5cwnQw0gENurueWpsWwqWy0cAtMWV3QrPB2WM9rscbwjIOz/jO2O7
         lVIrcjDIOdrMW7BTuX4pEBnA1gEUhEHHre26IbZmLwUR1pL0GFzeOUu8kubFEwfni+Sm
         yEgYsumW3llKMKvDV1LiYdYR1nXfun6Rwcha0xLqbOheL3VHOIaXFpRfZnnETu54Z5Wy
         90hu8dOEanZ8F0XEy8NYXgDaIV1fzc5of5ABHM9+QpmuFfnX/tfAHLmqn9QnU9iIAw+2
         TNmw==
X-Gm-Message-State: APjAAAXpyJgusGNjtfQu0EXrd6KqdifQ+bqJ3iwtK3mvx0c++Yk02NYG
        g21TwsJcB2GU4LuX6FwFVwLfIT99pEc=
X-Google-Smtp-Source: APXvYqylVFnRvdvLixal4Q3cy0W6VJujhofHAjOUp0aq238Lb6IrKsPfaqIAO1IPAYia08slwPs1QA==
X-Received: by 2002:a05:600c:2c42:: with SMTP id r2mr393464wmg.8.1575915130505;
        Mon, 09 Dec 2019 10:12:10 -0800 (PST)
Received: from localhost.localdomain (adsl-62-167-101-88.adslplus.ch. [62.167.101.88])
        by smtp.gmail.com with ESMTPSA id h2sm309838wrv.66.2019.12.09.10.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 10:12:09 -0800 (PST)
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
Subject: [PATCH v3 13/13] iommu/arm-smmu-v3: Add support for PCI PASID
Date:   Mon,  9 Dec 2019 19:05:14 +0100
Message-Id: <20191209180514.272727-14-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209180514.272727-1-jean-philippe@linaro.org>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable PASID for PCI devices that support it. Since the SSID tables are
allocated by arm_smmu_attach_dev(), PASID has to be enabled early enough.
arm_smmu_dev_feature_enable() would be too late, since by that time the
main DMA domain has already been attached. Do it in add_device() instead.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 51 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d20a79108f8a..cde7af39681c 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2643,6 +2643,49 @@ static void arm_smmu_disable_ats(struct arm_smmu_master *master)
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
+		return -ENODEV;
+
+	num_pasids = pci_max_pasids(pdev);
+	if (num_pasids <= 0)
+		return -ENODEV;
+
+	ret = pci_enable_pasid(pdev, features);
+	if (!ret)
+		master->ssid_bits = min_t(u8, ilog2(num_pasids),
+					  master->smmu->ssid_bits);
+	return ret;
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
@@ -2851,13 +2894,16 @@ static int arm_smmu_add_device(struct device *dev)
 
 	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
 
+	/* Note that PASID must be enabled before, and disabled after ATS */
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
@@ -2870,6 +2916,8 @@ static int arm_smmu_add_device(struct device *dev)
 
 err_unlink:
 	iommu_device_unlink(&smmu->iommu, dev);
+err_disable_pasid:
+	arm_smmu_disable_pasid(master);
 err_free_master:
 	kfree(master);
 	fwspec->iommu_priv = NULL;
@@ -2890,6 +2938,7 @@ static void arm_smmu_remove_device(struct device *dev)
 	arm_smmu_detach_dev(master);
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&smmu->iommu, dev);
+	arm_smmu_disable_pasid(master);
 	kfree(master);
 	iommu_fwspec_free(dev);
 }
-- 
2.24.0

