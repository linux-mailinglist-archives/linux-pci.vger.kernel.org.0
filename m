Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5F31D4B53
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 12:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgEOKsd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 06:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgEOKsd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2020 06:48:33 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9556C061A0C
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2020 03:48:32 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k12so1835947wmj.3
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2020 03:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=guIyIxw2Cj+e2cp6UNPEu5aERqphnHRHK0daLjNZEtg=;
        b=P6/7hIE4DwjSbFHn0gUenOd7tQIjElNY44np4Xp3owXyeiZ5/eDrsF2jXhN1HFtXI9
         mzI4y6p5DgU2UcrYdlCXB96VGS31EbpJJbdZ9F86VezeEZeC0/al4dI1yjpzsPObxXFq
         bH1rMvZMRi2LIS/5qWwon90KoCmlhOIT8yk6ptHFuyroaHqPfVbNWqX4o+QJrImdJg1K
         yVQAnTXoaK5haWRQFRYea+uFgN4n5RLlto9awJagAWmH0iE5BZWxjLgcRKzajZy0eLZ/
         94povR05970KSOg2HzI7zF8fn1cxzEnzDPqenijZflhH7uWaKOz7YHkN5wHpu/4kyjB0
         AxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=guIyIxw2Cj+e2cp6UNPEu5aERqphnHRHK0daLjNZEtg=;
        b=Y7x74rfzZXorIHmwj9OH1scnpdBpUz6HSXJhV8X+CuhAb4VMyZVmtbfDiV0un0Yaqy
         B+ly+j5DZP8o12ViFRGOT1Zodc+hIctAOZQ2QOuSjdLR/CVQg7iLHzN7su8wOZInbUmN
         U9H2n4vRb0lJfW+3Ac6PBQgAgZf7e90yVSqWwWkgfQCUCRDmACvsVrWPNlsOVFl3wmaQ
         yCguTwcZWePCKljfNXItRN49+AnFptvQF8jm0xkQAzeoGFR37/TGwB8HU/i6KIW3OVOs
         icCe0x55qx7O+Q2gVDNiVVwT6ttmQebm7suosqxxO9yw71HX0q0MtiLyqUXbahGNrhX2
         i6Qw==
X-Gm-Message-State: AOAM531tPpye0+sB0ai4bBnw63pUsZIPX/GW+XSRUIrskeUoFRYqiIn5
        9TrpIYnVqToc4h6QcY7elK2XyDXA/wU=
X-Google-Smtp-Source: ABdhPJwOoccKW1cdQKZVyETbXOshCl3JLZVuvoDXSwsZotxA+Esgngps5B0KVjlnEG+HNrZiI1lhug==
X-Received: by 2002:a1c:1d12:: with SMTP id d18mr3248638wmd.109.1589539711093;
        Fri, 15 May 2020 03:48:31 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id h27sm3510392wrc.46.2020.05.15.03.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:48:30 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        bhelgaas@google.com
Cc:     will@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, ashok.raj@intel.com,
        alex.williamson@redhat.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 2/4] iommu/amd: Use pci_ats_supported()
Date:   Fri, 15 May 2020 12:44:00 +0200
Message-Id: <20200515104359.1178606-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515104359.1178606-1-jean-philippe@linaro.org>
References: <20200515104359.1178606-1-jean-philippe@linaro.org>
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

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/amd_iommu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1dc3718560d0e8..8b7a9e811d33a6 100644
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

