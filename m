Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 186B01818AD
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 13:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgCKMrN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 08:47:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54399 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbgCKMrJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 08:47:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id n8so1931927wmc.4
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2020 05:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DVwcU8zMkbBCBeDrHNdhEC1RvSG6OG5A+AegDdk4FZg=;
        b=urRlNUx8hO97E3/ithv5W/xzktVGqA1nV8O5fFz7ObhKvbEb2aNkJgJoKBpnVdphl4
         5KBtdCKu/sgivS/hsjhVd9Sr/X1Un9ZKJ87q0cEtnZScW1Pc4HHzlnmW0o+AbOz4ueP5
         zyiCCpfL8vGbdiD9DgrSXZ7XaFDisGxPx0ysInpR3PAK89famZ8K8Fj1an2TBiXDAYaE
         fG3FqhhJJeNEsHKKygqVfcWKtxEwUnRFtGqa5ACIlECBWpovqJEGF/dZ+xZf9pivDmhr
         lMwE+AWqy9HFztiZU7KrWfM0WAPgUIHsjlIQ7vDYMmjWMwOOE+sv6p+UcxnGShNeQvLg
         e2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DVwcU8zMkbBCBeDrHNdhEC1RvSG6OG5A+AegDdk4FZg=;
        b=Og4XM+SfxH/2kMpsRmZpG09sjD43yoNHJ38R/3PAFfjQbZcUY/UsO5cLB2cq5N5zIT
         X7LTdGWZfw1bkGxDcqw60Cwb9EZrf3VcHaJJ6NLKXPdhpikukt9PNE6i/+zp6lkcLyd6
         2ZyJBXqZuihareM/5op/QjRbHdqqn/yT+F86hy1ajUKsPMcezK6Tfhk02HHs1SXC2qUP
         ey5mxeBeb63p7lunU0mRsbzWcejNcRYiX6ES9Xtf/vy80VcyBH+ULqes/LTXNjZVfSg7
         lV7ZO2ttinYPAXiYtdsCMII5Q8Obch2KqS6GiFDOgoUDKboE4bsxJeW37T9WGvYM4/mH
         wAYg==
X-Gm-Message-State: ANhLgQ33slvcF0D5PCsp13rtv4PuVd9MkQ/4rWvCLtc+kpzOeGJo/tJ8
        qnkMYmfPSjxw5Hv1P90HOgJLLw==
X-Google-Smtp-Source: ADFU+vsyF4i09IJC6n7a05lkPoLiRARiHxJM+vYgxp5oWnXx/+N85xAu8rhEuiSrwLrfj5KAr4l3Ag==
X-Received: by 2002:a05:600c:4114:: with SMTP id j20mr603263wmi.58.1583930826931;
        Wed, 11 Mar 2020 05:47:06 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id c2sm8380020wma.39.2020.03.11.05.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 05:47:06 -0700 (PDT)
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
Subject: [PATCH v2 09/11] ACPI/IORT: Drop ATS fwspec flag
Date:   Wed, 11 Mar 2020 13:45:04 +0100
Message-Id: <20200311124506.208376-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311124506.208376-1-jean-philippe@linaro.org>
References: <20200311124506.208376-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that the ats_supported flag is in the host bridge structure where it
belongs, we can remove it from the per-device fwspec structure.

Acked-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/arm64/iort.c | 11 -----------
 include/linux/iommu.h     |  4 ----
 2 files changed, 15 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index d99d7f5b51e1..f634641b3699 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -924,14 +924,6 @@ static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
 	return ret;
 }
 
-static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
-{
-	struct acpi_iort_root_complex *pci_rc;
-
-	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
-	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
-}
-
 static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
 			    u32 streamid)
 {
@@ -1026,9 +1018,6 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 		info.node = node;
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     iort_pci_iommu_init, &info);
-
-		if (!err && iort_pci_rc_supports_ats(node))
-			dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
 	} else {
 		int i = 0;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d1b5f4d98569..1739f8a7a4b4 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -589,15 +589,11 @@ struct iommu_fwspec {
 	const struct iommu_ops	*ops;
 	struct fwnode_handle	*iommu_fwnode;
 	void			*iommu_priv;
-	u32			flags;
 	u32			num_pasid_bits;
 	unsigned int		num_ids;
 	u32			ids[1];
 };
 
-/* ATS is supported */
-#define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
-
 /**
  * struct iommu_sva - handle to a device-mm bond
  */
-- 
2.25.1

