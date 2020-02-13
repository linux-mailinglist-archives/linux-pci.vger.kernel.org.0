Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD4DD15C8C3
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 17:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgBMQwQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 11:52:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38267 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbgBMQwP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2020 11:52:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id a9so7544921wmj.3
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2020 08:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0vxAgnwgCi5tQ5T4tG4I38wvW8TUR4SKTYQ5b+iyeZ4=;
        b=rI28DsCSktD93OGWztli5kHgpw2K88deSfarovudDtCGLfZder9iNg0E10dhs9fZpk
         eFTsc3Fn6EAr9ouNGbiVBRkKPPK69q7RPGGtMBnyQCpqnyYvLAyAZqdIG/GIsLmqRzzi
         12LIcEDQwvb3OQl7giRwQQNgiq+VK/5XXRBsF1abm2y1vArf+0wGRt0YpzwOshhxB9zM
         Ix4415qok1sXN1TmaKBbTV/JM8kQC5iCIQJ1JAAK2NX29bDiYAkyRr6OEhmiVI8n9MLc
         mqbryRMGESOmDUg+tOlIH5s27bZYFv0z5XJC5YvNUltOxU5Eij2jAeBJnEveZ7p4bVI3
         Dzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0vxAgnwgCi5tQ5T4tG4I38wvW8TUR4SKTYQ5b+iyeZ4=;
        b=F/+nn/xlzvzRsi68XERTvsGZAKWuwDAKS6Itl/ycH+uwvgwssVwYxMqiYcWEfQxqDt
         hPp6KDXyFhdnNlbS+r70WckxDl4Q8H5fdROpAkh+xCL3jN2iZpVNMUnjOzJehLBu2m8j
         k3WxDEzJpx8gfIXVdeSu321vEpQ1Aq94CbC3Pn/ke49dZOqDSbYIoABskDhIceT91Uo4
         yQIL0iawYBqacMgIjvFo6UJb/6CEJkcRx0do/576e2RFp70AISXOQJVabKyNDAigtRno
         7EevfqvJYz58ex9S+M5L1tSwwl1CbXQe3HGQ9zeLGZs1JnL5+KPOkIFkvM9hn3dVR4DE
         lwtw==
X-Gm-Message-State: APjAAAXR93pgNzciTV7P+qNs2nWdc+s01a7eJ/sLxxSdyl5048/W/oJe
        CT6+hN/8ciuyFB9rrrO8Ej5k7Q==
X-Google-Smtp-Source: APXvYqya188D5MEbRkey+kBb9V0Qc0uxPc2c2lngtBX0mBG9/xBeCp7D0V/fZbJc3uSzBYe3p4UBoQ==
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr7111336wmk.65.1581612733245;
        Thu, 13 Feb 2020 08:52:13 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y6sm3484807wrl.17.2020.02.13.08.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 08:52:12 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, joro@8bytes.org,
        baolu.lu@linux.intel.com, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     corbet@lwn.net, mark.rutland@arm.com, liviu.dudau@arm.com,
        sudeep.holla@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com
Subject: [PATCH 08/11] iommu/vt-d: Use pci_ats_supported()
Date:   Thu, 13 Feb 2020 17:50:46 +0100
Message-Id: <20200213165049.508908-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213165049.508908-1-jean-philippe@linaro.org>
References: <20200213165049.508908-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_ats_supported() function checks if a device supports ATS and is
allowed to use it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/intel-iommu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 9dc37672bf89..668f1b99111b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1449,8 +1449,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32))
 		info->pri_enabled = 1;
 #endif
-	if (!pdev->untrusted && info->ats_supported &&
-	    pci_ats_page_aligned(pdev) &&
+	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
 	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
 		info->ats_enabled = 1;
 		domain_update_iotlb(info->domain);
@@ -2611,10 +2610,8 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
 
-		if (!pdev->untrusted &&
-		    !pci_ats_disabled() &&
-		    ecap_dev_iotlb_support(iommu->ecap) &&
-		    pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ATS) &&
+		if (ecap_dev_iotlb_support(iommu->ecap) &&
+		    pci_ats_supported(pdev) &&
 		    dmar_find_matched_atsr_unit(pdev))
 			info->ats_supported = 1;
 
-- 
2.25.0

