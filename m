Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE17B1D4B55
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 12:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgEOKsg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 06:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbgEOKsg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2020 06:48:36 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23EDC061A0C
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2020 03:48:35 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g12so2135975wmh.3
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2020 03:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MQtP8fzJz2WKoMPMUWscfluDC7EhkHyxwXwDt+F/8Xo=;
        b=PXoZE6nGzWzeAjrZVC4Q8qDDJTcc+HjmAowWP2rxhAIl1x1saIXWkTrkuPyrwa3NHP
         yrSv8e2Hjy2yjlQ/runzqAADNByuuHASzKQn8JA/1UhZgEWKA+p+jj27buLk3nW/ROpD
         BPr61cO2ih0JqRMJtrloloi8lbgPItEok935Uw5/8hRNcmgMeRL6CftHv+yKS3l+s4WU
         iESxSPLqBjOeOA1KNZ7Y8/xjV9pWdJuANUQ8ZqvPc6wo+18lh8W3H7PofN1Gy/QF9Qth
         9hzcKT3MJdHAOaU/4IZQhzr/TKH/vkQjAFAtWKUVxBt4zMkvFJDnNIrBHa8WoNQEbB+/
         SUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MQtP8fzJz2WKoMPMUWscfluDC7EhkHyxwXwDt+F/8Xo=;
        b=ZBJ/imMPOWYF4qKmFi5xMFPOs9pw4DAQI82WR992zlft0WgTRnUykvvyESqQRgiAyM
         EizO00weJZJlgGefCQhzATpKF37VB8siec88gISPWryqQvQSFMrRURsrcU1K+QaYP6og
         OPdsZr44T2467BLOOIQasfXNfpjn1vgfXX4HbgGucVw33jsA0rpFUxLNzSt28m5QXpbr
         ZNYdnXuw94ObfiAqAXkiLVGOeeE5jSJtyhUEtBg8eilV5dSqWYY7V6RG5yIhxRh07TYr
         8/b1U88YYanEl/2hDD4wBakMcAvs0gOfEEUVmamiamFl/QL97WmwLng+qdUT5qmQ4SDc
         0sxw==
X-Gm-Message-State: AOAM530FgJ44jOnoBdJyvzac1dbt/w/sNeuBhUaYKiD9+jd71U23vX0/
        CDdC6EzGDzLYaj53X5uNicd/AyzGZ14=
X-Google-Smtp-Source: ABdhPJxehzJSSp1pQ/plR94V1b9IyYmarD9UuBiSu3T4yL++xWMNQCc3xOjcNEKwI82yKNouA7z5hw==
X-Received: by 2002:a1c:7e4f:: with SMTP id z76mr3410526wmc.177.1589539714209;
        Fri, 15 May 2020 03:48:34 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id h27sm3510392wrc.46.2020.05.15.03.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:48:33 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        bhelgaas@google.com
Cc:     will@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, ashok.raj@intel.com,
        alex.williamson@redhat.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 4/4] iommu/vt-d: Use pci_ats_supported()
Date:   Fri, 15 May 2020 12:44:02 +0200
Message-Id: <20200515104359.1178606-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515104359.1178606-1-jean-philippe@linaro.org>
References: <20200515104359.1178606-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_ats_supported() helper checks if a device supports ATS and is
allowed to use it. By checking the ATS capability it also integrates the
pci_ats_disabled() check from pci_ats_init(). Simplify the vt-d checks.

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/intel-iommu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0182cff2c7ac75..ed21ce6d123810 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1454,8 +1454,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
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
2.26.2

