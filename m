Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446E81DB840
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 17:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgETPcw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 11:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgETPcv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 11:32:51 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AC4C061A0F
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 08:32:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id m185so3343645wme.3
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O7DYfmf9DoemFEeuQy4b1/2PVfJbeRti6n+bNE2Muts=;
        b=b1+kAgxlVIFzY855JbBQ3hVSAl1XF23bult0N08r/2anx/2IJpSyiTeLZvTGDFlMJs
         kxW+zFn4vcgsS4r9sUm4EYHwrkZ9Tg0qFyVPFCL4Ei7axkLs8Xz8iu/KwaDwd/0aDTlE
         auKYtUMu+kkUBxYKag7tDHR3M2Epl1b8yJ4t30NwXGMycp09zJuWWSbLyahKlGeMK0Cs
         y05Brx5BCk00/P/o7sIMUghv2YRZfX04PWxdoyZOvIF1FQraoo90+AFMzn9Z/c8ce8Wn
         szoeT1Umh1dlBNMbO49UHz1GVsrUNDFn6l1crMvIp0OP6YT3ZT/DdRc9/k5Ax9bdurLM
         Hevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O7DYfmf9DoemFEeuQy4b1/2PVfJbeRti6n+bNE2Muts=;
        b=qUalaHrzhzP9CVSYQ4+YxiZcCidew/bNNJtMqHtL/C+MYlmbwkx0MJFwIDCuOciDuI
         9XGNG9oKLlo/TelTwt5C2ElK3+tIBeLy6OO2qgnhj+F7v9LHpImFUvEez6luNTTJq8Jr
         ltRLTrs5r4yxkrn50sk45yO9iu7W/z7bFYjSvBD6Q9jnJ+QDgkTfn/HE2LJM9hC7yBVU
         T+DgKBD9ezbyTAPdnKTSJksIXpgj/endvAA7I2kug7lPlCK73CtM4KjepSG+9LT0rHgE
         h+ApEWyGpkBWygxGcE86sXhM0cBReBp3AHKe0w/Xtt0PgerU9Af2HvvfW5YTXrRMyotx
         CWuQ==
X-Gm-Message-State: AOAM532/qn2QZm8sOl9zn4XPMJBQx83JjgwvIDPVpcTFH9DEHRLXHaPt
        Frq0PJEukIMpcQMmCnzfSmZ9U8CO5n4=
X-Google-Smtp-Source: ABdhPJyXoBArE7O2LUY1bsFSdaSpMuGVZxxPnLVHJfCNkRrs/jqFwXfVXYVWBXsafD56aI42j7GbIg==
X-Received: by 2002:a7b:c651:: with SMTP id q17mr4787617wmk.167.1589988768756;
        Wed, 20 May 2020 08:32:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id 5sm3395840wmd.19.2020.05.20.08.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 08:32:48 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        bhelgaas@google.com
Cc:     will@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, ashok.raj@intel.com,
        alex.williamson@redhat.com, hch@infradead.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v2 2/4] iommu/amd: Use pci_ats_supported()
Date:   Wed, 20 May 2020 17:22:01 +0200
Message-Id: <20200520152201.3309416-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520152201.3309416-1-jean-philippe@linaro.org>
References: <20200520152201.3309416-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_ats_supported() function checks if a device supports ATS and is
allowed to use it. In addition to checking that the device has an ATS
capability and that the global pci=noats is not set
(pci_ats_disabled()), it also checks if a device is untrusted.

A device is untrusted if it is plugged into an external-facing port such
as Thunderbolt and could be spoofing an existing device to exploit
weaknesses in the IOMMU configuration. By calling pci_ats_supported() we
keep DTE[I]=0 for untrusted devices and abort transactions with
Pretranslated Addresses.

Reviewed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/amd_iommu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1dc3718560d0..8b7a9e811d33 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -313,16 +313,15 @@ static struct iommu_group *acpihid_device_group(struct device *dev)
 static bool pci_iommuv2_capable(struct pci_dev *pdev)
 {
 	static const int caps[] = {
-		PCI_EXT_CAP_ID_ATS,
 		PCI_EXT_CAP_ID_PRI,
 		PCI_EXT_CAP_ID_PASID,
 	};
 	int i, pos;
 
-	if (pci_ats_disabled())
+	if (!pci_ats_supported(pdev))
 		return false;
 
-	for (i = 0; i < 3; ++i) {
+	for (i = 0; i < 2; ++i) {
 		pos = pci_find_ext_capability(pdev, caps[i]);
 		if (pos == 0)
 			return false;
@@ -3150,11 +3149,8 @@ int amd_iommu_device_info(struct pci_dev *pdev,
 
 	memset(info, 0, sizeof(*info));
 
-	if (!pci_ats_disabled()) {
-		pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ATS);
-		if (pos)
-			info->flags |= AMD_IOMMU_DEVICE_FLAG_ATS_SUP;
-	}
+	if (pci_ats_supported(pdev))
+		info->flags |= AMD_IOMMU_DEVICE_FLAG_ATS_SUP;
 
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
 	if (pos)
-- 
2.26.2

