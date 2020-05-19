Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3BD1D9E9F
	for <lists+linux-pci@lfdr.de>; Tue, 19 May 2020 20:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgESSCJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 May 2020 14:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbgESSCJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2020 14:02:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8380C08C5C3
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 11:02:08 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id n18so196758wmj.5
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 11:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ItT+TOPL7iHYDvWhuBPZ37dZIwufOCW7iBxWcHWr4y4=;
        b=T73/hci8m0xaQEonuG+UITtUtGVzOJkMhIY/g1SohiFjmbfVK6w59f+mvqGudusgqn
         KgSK+DNf5H/EQw1G/d66b7N0XokxEarYo8OFVIa3yO4z8ZUf4rBHRzAX2fY5L09vHu1Y
         QQzBlmR3/6FRKXAEejV9+0bzWiW/ndlxSsX7EpdL73Qs3tIfuU7JiQ1JABcUgfVkg84v
         /5x6oY+5isr6RrxYXgLgn/rKf2OVXKo+2aaq/oVwR31vmGqGarJEDUl11onJW/3JsSu6
         L760pJcDstfBWOr3+KHNzLdSHCFEX02NpH3IIwq+RgLPlc9O62wk3XBFgwtfUBP2m/Pl
         pXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ItT+TOPL7iHYDvWhuBPZ37dZIwufOCW7iBxWcHWr4y4=;
        b=V3lvI01Yyf2Ujba3Z17qY6SIQbiQIOP2GYIK/Q5QFD5HctgH8N8NbydY8VuXDm59zb
         3xj+sm3dtx7SopEU/Zs2GW1wpZ/7NWBO5ay6nuhhWXYB8mIGTPOCb/KGlW35FZKw19I2
         t0csAloWgiDvhBz7n2ucbAmsz4tXkFKXBh74xWioaVDR5BecCJLouiybdwiwqpRxr9ky
         S+NrCMYsPzP7h76U2ynGcecV1ZUTPYt+imW6DXAfQ/YXKJjWJdi/9Fm+yDCiCyu7l8tK
         wcyyQkEpW9fteBaCSlRLTPiFTDBrXrVG12NjVpIxgFf6sNWKdvFoR3VkRs1ss6Y00AIb
         WbpQ==
X-Gm-Message-State: AOAM533uFxNy2bHn+uv9iG+MQwp1tqyrwjVqXiO3/CnsocHgnJ9HQ1eT
        GJTAIiUaNs8Dpq4fpkmko106nQ==
X-Google-Smtp-Source: ABdhPJyqmxnjyw5ql53tgyxYBbcNmlPhWAlfjLm7SZrRDqOvDmRTlTWmj7mIiYK7YZi2FXhxDTCLEQ==
X-Received: by 2002:a7b:cb96:: with SMTP id m22mr582720wmi.164.1589911327419;
        Tue, 19 May 2020 11:02:07 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id 1sm510496wmz.13.2020.05.19.11.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:02:07 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v7 22/24] PCI/ATS: Add PRI stubs
Date:   Tue, 19 May 2020 19:55:00 +0200
Message-Id: <20200519175502.2504091-23-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519175502.2504091-1-jean-philippe@linaro.org>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SMMUv3 driver, which can be built without CONFIG_PCI, will soon gain
support for PRI.  Partially revert commit c6e9aefbf9db ("PCI/ATS: Remove
unused PRI and PASID stubs") to re-introduce the PRI stubs, and avoid
adding more #ifdefs to the SMMU driver.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/pci-ats.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index f75c307f346d..e9e266df9b37 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -28,6 +28,14 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
 void pci_disable_pri(struct pci_dev *pdev);
 int pci_reset_pri(struct pci_dev *pdev);
 int pci_prg_resp_pasid_required(struct pci_dev *pdev);
+#else /* CONFIG_PCI_PRI */
+static inline int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
+{ return -ENODEV; }
+static inline void pci_disable_pri(struct pci_dev *pdev) { }
+static inline int pci_reset_pri(struct pci_dev *pdev)
+{ return -ENODEV; }
+static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
+{ return 0; }
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
-- 
2.26.2

