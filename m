Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1342813C1E3
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 13:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgAOMxm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 07:53:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36344 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbgAOMxj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2020 07:53:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so17749028wma.1
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2020 04:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ovlZEJ3MFxMFIeaWjeBxqpybO8xAZBGhmofvDyv09KM=;
        b=aMEN5de52sUoibJjcgOb+6eTx1h6fTv2UQ6WOa5q3Q6KiJA4GEB9NVcvkjp5XTDpw0
         jyrlMPEEviSdgsEwPxnn9Qz4ztTIX7m8d3wu8FrFmUwKiXL+nOjMqWUR5vGtLernKgVK
         Q4R3z+oQjYLX0uQdMrVVaHa5dbQc3Tw0ln21IYTTubylIuPt2K9feenebb5Pze+7i3iH
         72VB4jpBo6CPlpj9BX+uLH0Gq/t5k7z+IV0RzkE2TBQ3QZHc/sNDML1H9dU55iSMdK92
         vuUczV5TEeoRgiZ9py79YvE0UIEZiXLTzJDRV+IIxn6fWVQr8YnXBCTycNdwBzUwU5eM
         OJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ovlZEJ3MFxMFIeaWjeBxqpybO8xAZBGhmofvDyv09KM=;
        b=obeBa6NZPBiKFlJAKtwxEMk0UNi3hizUSAHZ8LsxB6xqVv7+5oOzqMeHtyTqzeYbqZ
         5U4+u0Z0ZhwtsQNxTO4WcvgQhW8OL4mp+MVotX6wHQwbuoMc3Qcsabx4L4S8ssD7Cao8
         3D1+lp1ZACxK3nx7X3bf/+4sf3Qj5unoRMLfSsLtSp1MvwrQ1H/brAtkvaKD7cq3ot7a
         XPT6YBQGJcNPeAyfUkww4wuCvI0dmpAS97f+Yw7xxXHjPZPqjJebMl/b4VNpswNQ+UgO
         uo6Q5sLDtGrh2jsSlEv1gcBctiSFFP0N3pd/AWUX5OPNFwGFiWhHZoN34a9i1ljX8nEk
         lewg==
X-Gm-Message-State: APjAAAX8qcDVNKuC+1ygoTIejaEQh+jbqTwdqQQt03fTUO8ObQ+p+pgz
        vxd9aQzpLKBCaA99bji2TPinW2RKazg=
X-Google-Smtp-Source: APXvYqwvjgPB35BKDw3598B+f3tN02Oa/sBncf4ulCANAV1l9+FYbfBBXQvNAcGYK7F4agxMEERIfA==
X-Received: by 2002:a7b:c4c5:: with SMTP id g5mr33782202wmk.85.1579092817895;
        Wed, 15 Jan 2020 04:53:37 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d12sm25196171wrp.62.2020.01.15.04.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 04:53:37 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, will@kernel.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com, eric.auger@redhat.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: [PATCH v5 09/13] iommu/arm-smmu-v3: Prepare for handling arm_smmu_write_ctx_desc() failure
Date:   Wed, 15 Jan 2020 13:52:35 +0100
Message-Id: <20200115125239.136759-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115125239.136759-1-jean-philippe@linaro.org>
References: <20200115125239.136759-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Second-level context descriptor tables will be allocated lazily in
arm_smmu_write_ctx_desc(). Help with handling allocation failure by
moving the CD write into arm_smmu_domain_finalise_s1().

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 7b7dea596f60..c35863073ab3 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2299,8 +2299,15 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
 	cfg->cd.tcr	= pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
+
+	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &cfg->cd);
+	if (ret)
+		goto out_free_cd_tables;
+
 	return 0;
 
+out_free_cd_tables:
+	arm_smmu_free_cd_tables(smmu_domain);
 out_free_asid:
 	arm_smmu_bitmap_free(smmu->asid_map, asid);
 	return ret;
@@ -2567,10 +2574,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
 		master->ats_enabled = arm_smmu_ats_supported(master);
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
-		arm_smmu_write_ctx_desc(smmu_domain, 0,
-					&smmu_domain->s1_cfg.cd);
-
 	arm_smmu_install_ste_for_dev(master);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-- 
2.24.1

