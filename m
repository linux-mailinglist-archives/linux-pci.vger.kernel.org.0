Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65EBA18188E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 13:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbgCKMrF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 08:47:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41926 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729456AbgCKMrE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 08:47:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id s14so2425873wrt.8
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2020 05:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VY7nWjSoNMWvNd0g+xzvWepeHfbATP8qtCHjDYePPIE=;
        b=bM45cSb5Ozho2TEVIim6lgIlvJ17mCR4C+CsT0Pimx9uxnQtSRpiekb7vk+z4TyBsg
         i7bCTVuOPTtPUnD2gS9GnmKQttH1xBdYZqnq7yaTFWf44UtlBDgeGi2Es8eKBPIPPPDW
         LkYcp3rebBLLDqlaAmYWvqR8k6Z0HKttNv5g+FX0w3DwWT8V2qEp9TbR7xK1Xs2Xfv7w
         rCLokPC198gIy+yenj4tR9bAAp9qsRBLynUJuCnGQmJE3DnkPLxWi3/fYa7x3rTRXbVT
         dl0hIDgEYGiTAMo+9g7A7MoDCl4F6e3beKsqThLrOGkIuYk7YRvTsfD3H2hnQqzrnbmn
         0SjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VY7nWjSoNMWvNd0g+xzvWepeHfbATP8qtCHjDYePPIE=;
        b=bIgM4cwIgiy2yCIwAwNQS6y+3hRhoTY643QWjdkQAZJwcEZBr7+NVMkH5ser6VQeYF
         wwMlpfPzXT0iY2O7VnoIwW7RZxn9FsV91tGon/AtlsUXam9fS3eR7QnDRloXSL+pI7HP
         jlpwkXG/zj8jeM+HkwE38FRJQYhb+9Nks4rlAN3oZ03FXsN3Isp56+MV6+WGSFiAhY0o
         P0x+Jk9MX1eZEzRX6wIbDAhlfvzIuaHaoQLL2+TC33iKCFAX7hayhNNTaPm42zCvu0Qd
         Bc65yzGGZSmbCbrop0UESwMAnN/wna9TeBDESyN86wMIRb1it1CXPKawtW6CB4jFbFuO
         HLmw==
X-Gm-Message-State: ANhLgQ3Y0Ti4bOLrCa5+6LNHWt3U0XFo31+e0+dUzb5aGJ3W5F8cYt9M
        wi4XwThQJMA101VsJ0LKzpka3g==
X-Google-Smtp-Source: ADFU+vvwMGkHBLCwyNQwQal6X/GbzQAYuf8900S7rXGVFBA3Oqi6Q9GIzMLJrx/FlXi4IXLOUR1+0A==
X-Received: by 2002:a5d:6591:: with SMTP id q17mr4218053wru.22.1583930822453;
        Wed, 11 Mar 2020 05:47:02 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id c2sm8380020wma.39.2020.03.11.05.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 05:47:01 -0700 (PDT)
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
Subject: [PATCH v2 06/11] iommu/amd: Use pci_ats_supported()
Date:   Wed, 11 Mar 2020 13:45:01 +0100
Message-Id: <20200311124506.208376-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311124506.208376-1-jean-philippe@linaro.org>
References: <20200311124506.208376-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_ats_supported() function checks if a device supports ATS and is
allowed to use it.  In addition to checking that the device has an ATS
capability and that the global pci=noats is not set
(pci_ats_disabled()), it also checks if a device is untrusted (plugged
into an external-facing port such as thunderbolt).

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/amd_iommu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index aac132bd1ef0..084f0b2e132e 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -291,16 +291,15 @@ static struct iommu_group *acpihid_device_group(struct device *dev)
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
@@ -3040,11 +3039,8 @@ int amd_iommu_device_info(struct pci_dev *pdev,
 
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
2.25.1

