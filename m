Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAD1818188F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 13:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbgCKMrG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 08:47:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51217 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbgCKMrF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 08:47:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id a132so1947100wme.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2020 05:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FfMBk8SLNbiqvSQTKNw5nVOwT2ukh4ZsyZ4CcWYi0pU=;
        b=kGuexoqbuQJZfLJ6IRVhdgqXT2Li0ISoLXz0HBfWDMtpencXONYJHfL5BMvcPqfGns
         KTLe7/XryQ8otcvTvvBmXsfwat0eWTcx2+S3AY+1GUovN8spX6q7o2ijMrTUu5CI7XZi
         sXSmXpsBNPqNuYtOOjN0yT9WFBfYw8z72+I3JHP780/sn1m+qnJhj57OTTCF5Rl7VNbI
         I7+Cx38sOpBfHpJyAtHR0EJE+EL+xYVzqLpK9UKTABDAepAg9uvq1mm+y1d2lHqjsV/o
         5qIAXn96SgCfw69yQzALEut3rCN9yVu46I16Uc8TUdhIIoc5YfzmjtVW8PyrVvwzibNe
         fBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FfMBk8SLNbiqvSQTKNw5nVOwT2ukh4ZsyZ4CcWYi0pU=;
        b=Qh71p4JonMj6E08VlHTy6JdEZlrPQukhvNl9drAHfyNFB7ZjP3uYP5kw5cmOkeOYPh
         7QhqqpjAsCEv0J13tCyAM7kWQC/U8c3qXailxaWgvFK1Y1OKN9UrSoa3hpA21aEgQgr6
         M3cnR0zqkOkfqjGWWYbHbqTDp/qgiWkLGSMYw1BTKf+BUNLywECyf6O8zNXBAuqTFOF4
         aIQxIAo9rzBLpuwSaHn5z3J9g7CMMLNC8Xu9rA+jkFgJ59bhSWq5lGXXi7Ja6N6Kq+J0
         82mUneYMJPzg1gFHjo1U3WFHl0Z4u18U6x3XMdZvLtY4syv9cKaA1UmVUR3Kdeg4+aMD
         ndEw==
X-Gm-Message-State: ANhLgQ2B4gnyIMG1eUgEQRqLoAWyy5xqxS7YU9S5sFKkGRyxIyYdFLhf
        SQfbscrpgmDNAOsW7tGHdakzyQVohJ4=
X-Google-Smtp-Source: ADFU+vtntOL4brDxmDQGG6xeJrIuadRvitxT9k9QnLoTDiM4xzqU981cVjB7SKKNNlkYOG+EtlWXJA==
X-Received: by 2002:a1c:5443:: with SMTP id p3mr3479986wmi.149.1583930823712;
        Wed, 11 Mar 2020 05:47:03 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id c2sm8380020wma.39.2020.03.11.05.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 05:47:03 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
        joro@8bytes.org, baolu.lu@linux.intel.com, sudeep.holla@arm.com,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     lorenzo.pieralisi@arm.com, corbet@lwn.net, mark.rutland@arm.com,
        liviu.dudau@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 07/11] iommu/arm-smmu-v3: Use pci_ats_supported()
Date:   Wed, 11 Mar 2020 13:45:02 +0100
Message-Id: <20200311124506.208376-8-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311124506.208376-1-jean-philippe@linaro.org>
References: <20200311124506.208376-1-jean-philippe@linaro.org>
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
 drivers/iommu/arm-smmu-v3.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4f0a38dae6db..87ae31ef35a1 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2592,26 +2592,14 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
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
 
-	pdev = to_pci_dev(master->dev);
-	return !pdev->untrusted && pdev->ats_cap;
+	return (smmu->features & ARM_SMMU_FEAT_ATS) && dev_is_pci(dev) &&
+		pci_ats_supported(to_pci_dev(dev));
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
2.25.1

