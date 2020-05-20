Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132091DB842
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 17:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgETPcy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 11:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgETPcx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 11:32:53 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342B2C061A0E
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 08:32:52 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id n18so3347864wmj.5
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eyFn3P2XuGvmapYpvmXsfPpBpNlu7lMJiAWRzcy1I5I=;
        b=NvU+y8H/jAu6fTaZt01RqQqQcfHxhpgoN7+p0ux0i2Oq8yrHojsDIuAB1TDQoB7+iq
         ItCOMqP2wSggzqlVIvwuENI+1I2x5hp/8KvEOK36fICyUOgEwdk1sU//8q4oFoHeszEL
         BjRnMOgCnxRQZfH1h/SzPX0XXFn0xr9ecwlyA3hfQ3L1x2hVGSIVAuixez9uag+O1VRD
         8S3YP14a5TWEbLnBlF1XfAlBGpRgTaQFWpOUGdRaSTHZZpZIUudxfyNrbORahZXopfyb
         4eORiSCbkfAw18940CBJ5bBrPzAuTN+maYvUXW9TdE5VklVvU4/z8GEpTB+189e5Em1Q
         8TaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eyFn3P2XuGvmapYpvmXsfPpBpNlu7lMJiAWRzcy1I5I=;
        b=tZoFFJu4pEOWbe0f6CQ1Yf9OiC9+xMYNmLwuM5rVLtEOy578DSzuKb+SNkNErWy+Uh
         kooMzFItC+u2gFb2rvD8XrfJuEyb9yFJSbNkWcuJVuwNM3MesGnRzXgPQJqMPwJjQffn
         9Q0swSMu9LbXM95S1TykzvVlDaBMWrmZ1XZTfwemEBQyWdhY1Dj1+qmrk60vLarFxPlR
         TPUSttt08rbTntGvl2y3qlPjNhdHZBd2dBClL0+oXdV6ySzfKSZrTSdJ0TkaCmgizlRg
         eNIBzYLIxyWorngfNEw10iIWs9DmEVNBeiOONkZktLDzLFnMnuVjwHK4YDaREKfxozn/
         NVeQ==
X-Gm-Message-State: AOAM530c6YSvjMs/e2y1kAoy0Ve22n1mqMDiB1GqVyySnZAXL9LnrOuv
        DualcnRqAAoEA/T6k+arOgcuKVk6EdA=
X-Google-Smtp-Source: ABdhPJwbawWEUkv2F66a8ndXGjiaJL6hn5qsqFZxdvvcUCO97AbeEjdJDdTC3ZxjJG51qbTRERgXqA==
X-Received: by 2002:a1c:9ac3:: with SMTP id c186mr5149217wme.150.1589988770732;
        Wed, 20 May 2020 08:32:50 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id 5sm3395840wmd.19.2020.05.20.08.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 08:32:50 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        bhelgaas@google.com
Cc:     will@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, ashok.raj@intel.com,
        alex.williamson@redhat.com, hch@infradead.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 4/4] iommu/vt-d: Use pci_ats_supported()
Date:   Wed, 20 May 2020 17:22:03 +0200
Message-Id: <20200520152201.3309416-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520152201.3309416-1-jean-philippe@linaro.org>
References: <20200520152201.3309416-1-jean-philippe@linaro.org>
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
index 0182cff2c7ac..ed21ce6d1238 100644
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

