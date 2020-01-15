Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C458213C1EC
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 13:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgAOMxq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 07:53:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55853 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbgAOMxo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2020 07:53:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so17757735wmj.5
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2020 04:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=63OK7+WV2oSpfMtMv7dHdZjSmylnl4RI0WBIjRtCjGI=;
        b=rcRSOzLbYMD9O+ISAliDx8MfCABkYI5R5TCmbME5A+HMyM0rj9pis2bt5k2K31Ush7
         XTRWm+dGRYhisp4xEjHWBRvFocNJu2ERqbdgcL9Rvz+8hIXGrjQMHPwqrEd7BOsWRCfC
         YLHxO7YHfZs/g0ogm/bk3CFCwm6vV2ACaeGUst6R0+FEeGaYnJ7e5fAqOa0T6GfnVINr
         A3nev+evbG74sdaffLcpUhvBbE+hxMO4/bKLh6V2wkKSJQhYHzm9aZ+kcTtN0SuETkh5
         ZaL3HLW68OJmCuxaDSRiCB07t6VeEz+2Nm70rAHxzRxaiEkjv5S9oIwct+NKKTfgdEgX
         40uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=63OK7+WV2oSpfMtMv7dHdZjSmylnl4RI0WBIjRtCjGI=;
        b=Sm3Xz1ZhRXvvboWSFDL6f38H3VaHzvtODe/DgpGh1LPHTWrWzzaBesU1YtsTde2W8U
         Yo44KYjcOktsrZSkyhb1JwOBJU/K165yhGWuuNw6dIrzlYpdNmEyHQSZu09HF3SK0A0H
         31Q0SnKeN0KNDfJFjADfOHo8GkGoi/tM48QcN+y9KvNUoIIS0jImh5qaNk6kqZDk8T7h
         4m9s8W/qOXpUWLhUxO4OF4pkEXMbAB+5DpJQkIBQuACGnWOBpIqUfAWRiK56Fd6vYW+F
         GlDIGFVLEw7lM42xH60CxSM1jwW5TvR8r4lK9R66mIujGcQQkDFyluW3j2iMBWielHvI
         wPHg==
X-Gm-Message-State: APjAAAUrB1Tqm9ZN3pf+ujN1WiVk0G2x5BPS3/gjceZzACDmbU5eA6kn
        OlKZTjzQ5Ubkx56TJ9li2tq/Hv+Ednc=
X-Google-Smtp-Source: APXvYqy211rlSGA/7f48UPTxt4qHpuBdCqMG+TrJdyDkgkot1NRkPQy8mZvmt/WlxkEIur07ZirjyA==
X-Received: by 2002:a7b:c151:: with SMTP id z17mr33478170wmi.137.1579092822380;
        Wed, 15 Jan 2020 04:53:42 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d12sm25196171wrp.62.2020.01.15.04.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 04:53:41 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, will@kernel.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com, eric.auger@redhat.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: [PATCH v5 13/13] iommu/arm-smmu-v3: Add support for PCI PASID
Date:   Wed, 15 Jan 2020 13:52:39 +0100
Message-Id: <20200115125239.136759-14-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115125239.136759-1-jean-philippe@linaro.org>
References: <20200115125239.136759-1-jean-philippe@linaro.org>
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
index b2b7ba9c4e32..f42454512e87 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2634,6 +2634,53 @@ static void arm_smmu_disable_ats(struct arm_smmu_master *master)
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
@@ -2842,13 +2889,23 @@ static int arm_smmu_add_device(struct device *dev)
 
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
@@ -2861,6 +2918,8 @@ static int arm_smmu_add_device(struct device *dev)
 
 err_unlink:
 	iommu_device_unlink(&smmu->iommu, dev);
+err_disable_pasid:
+	arm_smmu_disable_pasid(master);
 err_free_master:
 	kfree(master);
 	fwspec->iommu_priv = NULL;
@@ -2881,6 +2940,7 @@ static void arm_smmu_remove_device(struct device *dev)
 	arm_smmu_detach_dev(master);
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&smmu->iommu, dev);
+	arm_smmu_disable_pasid(master);
 	kfree(master);
 	iommu_fwspec_free(dev);
 }
-- 
2.24.1

