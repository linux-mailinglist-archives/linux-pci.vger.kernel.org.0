Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F14C126712
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 17:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfLSQbj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 11:31:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38540 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfLSQbi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 11:31:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so6640411wrh.5
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2019 08:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DFKSWV5x7hWib4ywLyYZ2Xpzoe8h6HBPQg/y9idEIyA=;
        b=hH3b80WjL1UfLkeRj1KaYK2xXE9kCJqYv3IfxG/t0piRVkIEPEUriaWxmUbpRUG4Fq
         1k4YH7bs2VDmawOY4Ebix453yuxAxC2sbnROIZRwLQvY7OvLOXgFy/TmXEfK8P7l47eN
         dX7k8lSRFzJO+MKenvWY8EegeAUWz+s7gbOrYX00KG2aT3ygF3N+B7D30eheZ3koHxzj
         uDhVQVW0qwmeuvx00tfSyjjW4lZx7I/dbMTo3eCCRLmzgO3m1oH86DGHt1HFdggdqAHd
         DzIYrIar+5lr7sDIBSRuf4W1WoYmC8U0q2tRT6n3rfDQY1FOLTQqyNkw6XyKGZTogK8O
         81MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFKSWV5x7hWib4ywLyYZ2Xpzoe8h6HBPQg/y9idEIyA=;
        b=jQ0SRwKfmRnBsWPBH3ed+/SKlROOdfxSwMq82rlU6A1m3bdvqg118+6F/rGLG+WIpD
         JYiO4PIuhLAJvzNyDC8F+iAImHlm3d5a9PttaEmwZdxBcT4a2QWGRBB0ZM/tGW+dIbz0
         DoagkSYf54uL2IQ3A6GNKCbI1BYI64kfvAS7mA8AYgAFA8CeZh0G0+zNxkGjfsktncxv
         +pN4foA7dr25VflePLE3V2ydH7YOF/IrhcNQdrJ4SlhHUuqMno2MocqPP9SfxaLWqD33
         lpFV16wMbkSIjufQPKKqRl+i4oh2uIi/b1roT5Bv/2UjbU12wZkK568+xPzySliSUKrk
         lJNg==
X-Gm-Message-State: APjAAAXtQturS6BoA2b1PwJ+uITB4ez/Nbz/MTM/xdUzgvoMxMe/+VSV
        nyqEK7t5dYejaOyF+4n/9U1YOvc3TJw=
X-Google-Smtp-Source: APXvYqyRkRT8Nl9uMCu8TDEXSE0TrK+jCYgWkOFDWo74ajAHonUbBJuugZCeMz0UhO+iHDiRitfiHQ==
X-Received: by 2002:a5d:640d:: with SMTP id z13mr10506261wru.181.1576773096482;
        Thu, 19 Dec 2019 08:31:36 -0800 (PST)
Received: from localhost.localdomain (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
        by smtp.gmail.com with ESMTPSA id u22sm7092068wru.30.2019.12.19.08.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 08:31:36 -0800 (PST)
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
Subject: [PATCH v4 13/13] iommu/arm-smmu-v3: Add support for PCI PASID
Date:   Thu, 19 Dec 2019 17:30:33 +0100
Message-Id: <20191219163033.2608177-14-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219163033.2608177-1-jean-philippe@linaro.org>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
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

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 55 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e62ca80f2f76..8e95ecad4c9a 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2644,6 +2644,53 @@ static void arm_smmu_disable_ats(struct arm_smmu_master *master)
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
@@ -2852,13 +2899,16 @@ static int arm_smmu_add_device(struct device *dev)
 
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
@@ -2871,6 +2921,8 @@ static int arm_smmu_add_device(struct device *dev)
 
 err_unlink:
 	iommu_device_unlink(&smmu->iommu, dev);
+err_disable_pasid:
+	arm_smmu_disable_pasid(master);
 err_free_master:
 	kfree(master);
 	fwspec->iommu_priv = NULL;
@@ -2891,6 +2943,7 @@ static void arm_smmu_remove_device(struct device *dev)
 	arm_smmu_detach_dev(master);
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&smmu->iommu, dev);
+	arm_smmu_disable_pasid(master);
 	kfree(master);
 	iommu_fwspec_free(dev);
 }
-- 
2.24.1

