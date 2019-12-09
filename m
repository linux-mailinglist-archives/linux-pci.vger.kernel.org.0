Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 715791173B6
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 19:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfLISMN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 13:12:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37162 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfLISMI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2019 13:12:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so314864wmf.2
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2019 10:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xn8FsjkMGRUL2lMLPw8XGFWLAlx3AFwuaWxjs2kDLIc=;
        b=anRgbzZW5eiaVyKyK67CNe9yhPSWdxYWkazhUi0/MhlRnM/XyU4K5WfuI0wsdNBpId
         wVSrIhkwmOAUYrNx04LRBaHZXcyx9x6tcSlwG84LPQoIO5DwXUyczD9QuwK//eJS2DmP
         QawcU+YvRsMlbqkwJJPupgry3SWX2VYufGNDpYwcZ9ac29gEPrCyP2aSx1h2ubrQABw/
         +hxiVhyR0+AF3DJOej7effKQl1/zMbYhcmwVVsaRJVgyLOMBDGqpC31WZrQn4k6CZ9yd
         hzYnX8yIIZmAzi2hVYp70apw0Oh4aCDQihbLCZwfllVVfaK0m+gWTtN8EPC6YEYwMBwB
         b7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xn8FsjkMGRUL2lMLPw8XGFWLAlx3AFwuaWxjs2kDLIc=;
        b=qqIGEnZ77X5uJ8jw1F5mXvpWITfhL4TxW5+YqQ9QJ691BPm6xmPwaXBR999XFgS7He
         NPANVVqc0jigkH+WeCNdOXGXHZK5ebspJqsye8RQESL6MnkmXGp5rcM6Z5JIbR8UfZsc
         IJceGxT5awmpEIMOcE2wcbBXMg0cMNuHj9AmZwp+XVM+6cZTDQaDNdAUrWt15D3mBUDP
         DRf2rY8C+r3dG9eYhSIZGNQQzM8zF7Jzzth9+XjYRzN3jiyyZ93EZtRLCla35AVRWRhy
         mp04PlqK+3JgGMe/f/SigjwmfVNN5bq7E3P312VYcWOz77UlWN9NaT9FnADVKYi3zBk5
         ZCNw==
X-Gm-Message-State: APjAAAW6yWQY39nZ/QrvFsw/ga5cN6ivmI+E439VXHtK7FIq/6G7I+Al
        FAMgzJrt+EUeUTEHaSiYrFF9r1wzm6I=
X-Google-Smtp-Source: APXvYqzD7Zae5R710LjfpSHNK7h76GaBcjbIRxZjwSrVgHzJcpI2I4M1YKhu9AfT3gIv6BnKhaBP5Q==
X-Received: by 2002:a7b:cd8a:: with SMTP id y10mr349190wmj.136.1575915125816;
        Mon, 09 Dec 2019 10:12:05 -0800 (PST)
Received: from localhost.localdomain (adsl-62-167-101-88.adslplus.ch. [62.167.101.88])
        by smtp.gmail.com with ESMTPSA id h2sm309838wrv.66.2019.12.09.10.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 10:12:05 -0800 (PST)
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
Subject: [PATCH v3 09/13] iommu/arm-smmu-v3: Handle failure of arm_smmu_write_ctx_desc()
Date:   Mon,  9 Dec 2019 19:05:10 +0100
Message-Id: <20191209180514.272727-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209180514.272727-1-jean-philippe@linaro.org>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Second-level context descriptor tables will be allocated lazily in
arm_smmu_write_ctx_desc(). Help with handling allocation failure by
moving the CD write into arm_smmu_domain_finalise_s1().

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f260abadde6d..fc5119f34187 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2301,8 +2301,15 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
 	cfg->cd.tcr	= pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
+
+	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &cfg->cd);
+	if (ret)
+		goto out_free_tables;
+
 	return 0;
 
+out_free_tables:
+	arm_smmu_free_cd_tables(smmu_domain);
 out_free_asid:
 	arm_smmu_bitmap_free(smmu->asid_map, asid);
 	return ret;
@@ -2569,10 +2576,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
 		master->ats_enabled = arm_smmu_ats_supported(master);
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
-		arm_smmu_write_ctx_desc(smmu_domain, 0,
-					&smmu_domain->s1_cfg.cd);
-
 	arm_smmu_install_ste_for_dev(master);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-- 
2.24.0

