Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A554C13C1D8
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 13:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgAOMxj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 07:53:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38507 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgAOMxi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2020 07:53:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id u2so17698147wmc.3
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2020 04:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VkGjwbrGa1wrMcO/KHo5uF2vFnVmce44IDO/Kf1WvcM=;
        b=pq6uZQpsX3gU3Tcd0g31MBx+lVvCLRX8nZbjge2zbaX0o40wceneHPuMBzBFtJbnQL
         rUphD/LvuXhsWoPi1Og8NoDIG7QjYbtE3v8hHk2uxTgndgP2lfnwgtXQ+UZsMAzgPKNE
         6wxRLnJXPFcRyy2v8Krf7yS5doZHoY6lsNnNvZDBYlAoiS23SYnwL89liofvY0J2F/AX
         ZYOl+WxomfHZtKAsdCpkAaCuyZSIRGodHQmCd7TdNUhI+LGOanQE085hqGg/w3JJ2o0b
         I1QBD0/XrJyW23s8DR7txRnM8g1bWYQkQEz7aKlLGCKfhG3uLoGTHeVG9WQmgfSvDZbH
         jWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VkGjwbrGa1wrMcO/KHo5uF2vFnVmce44IDO/Kf1WvcM=;
        b=jnMOFQqrJD0wVMzbl+AT15eNfaAembTWjM8OVmA7SWAzDuK+Xb56FS/TLVJWV++FGV
         BkvJVtvGgNtmQeQXjwIkwDxLfkdZmcbi1Qa9IhvkJTpHxmw/uObZtBctq6hsXLd53fbt
         T/gvZ4JiEZ1PzwILC6r8/UYvNOYEwcNO6sYolD34JVhBjYdEhA7vA7T9qB8eShgnORZa
         30lzzgbyts1TL8Ha+xh5sO6bihcM+wJWOzVQFwOslr90dIKfwPCewIme+CBt3VhvumLP
         s3HKdVKat4wPhYiDIE407zAhaOCxSgnAEmLW1gQ/4u/Nf3ByCKXJdQ6L+zgu02IRJrQ7
         H2RQ==
X-Gm-Message-State: APjAAAX9HiIJGAFZEK7XUavXbRERE7GQ7e0L1aujZIeLDALbhu7RkzI5
        dEDkN2mJ8Y0xtNiZOV6OU7tvRZd6uh4=
X-Google-Smtp-Source: APXvYqxppRXM7W0rog1akfsKD1HDFU2AmK5typwsSWE2NQJlIYz8KU9v6BH6h5H2FeKoNTAxdXO+4Q==
X-Received: by 2002:a1c:7d8b:: with SMTP id y133mr32316515wmc.165.1579092816792;
        Wed, 15 Jan 2020 04:53:36 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d12sm25196171wrp.62.2020.01.15.04.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 04:53:36 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, will@kernel.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com, eric.auger@redhat.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: [PATCH v5 08/13] iommu/arm-smmu-v3: Propagate ssid_bits
Date:   Wed, 15 Jan 2020 13:52:34 +0100
Message-Id: <20200115125239.136759-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115125239.136759-1-jean-philippe@linaro.org>
References: <20200115125239.136759-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that we support substream IDs, initialize s1cdmax with the number of
SSID bits supported by a master and the SMMU.

Context descriptor tables are allocated once for the first master
attached to a domain. Therefore attaching multiple devices with
different SSID sizes is tricky, and we currently don't support it.

As a future improvement it would be nice to at least support attaching a
SSID-capable device to a domain that isn't using SSID, by reallocating
the SSID table. This would allow supporting a SSID-capable device that
is in the same IOMMU group as a bridge, for example. Varying SSID size
is less of a concern, since the PCIe specification "highly recommends"
that devices supporting PASID implement all 20 bits of it.

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 6ab0e93518f6..7b7dea596f60 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2277,6 +2277,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
+				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
@@ -2288,6 +2289,8 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (asid < 0)
 		return asid;
 
+	cfg->s1cdmax = master->ssid_bits;
+
 	ret = arm_smmu_alloc_cd_tables(smmu_domain);
 	if (ret)
 		goto out_free_asid;
@@ -2304,6 +2307,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
+				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int vmid;
@@ -2320,7 +2324,8 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static int arm_smmu_domain_finalise(struct iommu_domain *domain)
+static int arm_smmu_domain_finalise(struct iommu_domain *domain,
+				    struct arm_smmu_master *master)
 {
 	int ret;
 	unsigned long ias, oas;
@@ -2328,6 +2333,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_domain *,
+				 struct arm_smmu_master *,
 				 struct io_pgtable_cfg *);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
@@ -2382,7 +2388,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
+	ret = finalise_stage_fn(smmu_domain, master, &pgtbl_cfg);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
@@ -2535,7 +2541,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain);
+		ret = arm_smmu_domain_finalise(domain, master);
 		if (ret) {
 			smmu_domain->smmu = NULL;
 			goto out_unlock;
@@ -2547,6 +2553,13 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			dev_name(smmu->dev));
 		ret = -ENXIO;
 		goto out_unlock;
+	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
+		   master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
+		dev_err(dev,
+			"cannot attach to incompatible domain (%u SSID bits != %u)\n",
+			smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
+		ret = -EINVAL;
+		goto out_unlock;
 	}
 
 	master->domain = smmu_domain;
-- 
2.24.1

