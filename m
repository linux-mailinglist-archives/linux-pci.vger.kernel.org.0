Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263211BFECF
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 16:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgD3Oks (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 10:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728294AbgD3Okr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 10:40:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7E8C08E859
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:47 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u127so2218869wmg.1
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=62jj6X1LyxzprUaI/fsrszNvC/iCvzNFlzOxzXxMTmE=;
        b=y8F2CAh6V2jZZ6B8MaXX8bNU3xhjF6A6xftgKRo5JNfOivZ4u0mxU5xIR4pAdncRts
         6l7bUbk1qPf11fVOJF5ftAX+YvaRJ8cXFwCudw6bxApeZPCZrXZtaaHXtPfThk5Jco3K
         a/O5NV8b14TR6O3KF9WIkjjfc/Gcv12HGrAm6m8EO0m1BeQXzRMZnOhib6MYqbtHBwsT
         sErFA6eMmDmS52FVu+QrR1ltOzaQfn2PJ62g8elC51l52AIXrpu8StMl/Go2TPf2eTs+
         JpTwIf91IA6+h7AHE7yatTK0354lTEslYrLGPhBE1Hb4pA4bdkCtICpgF+meBh7cqw9n
         5sMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=62jj6X1LyxzprUaI/fsrszNvC/iCvzNFlzOxzXxMTmE=;
        b=BawNVf6sW2SfGmMDW5pRsw+e4cibKzxpmxiKVrz4KTZuuUTwBXxjzitr/C1qZ4sETa
         W4JRWORTXQlw0dHfllDL6FpfjmLPLyC3HmFUFfcIV12tafCViByULYAzy/o1xKnOAgr0
         G6nvgNuzLDMuk05o7GKHfqIWEnGJVHxCvoUX90WT1NhyeQ6khEu6yGneo5q0P1I9qwEa
         cO7YtBTnA4IpLTCgJct7ZA+3KbxbjlVOZiI3pActnQIHUKGy6oRpKEwPELL05RkfpPwa
         GTB9kyVfKRrTmktQw1/Xuuo8OWJxcZzAasKWXS7QAV6CAshQWCAPgYdJk+O2m1kXyqAh
         TZHg==
X-Gm-Message-State: AGi0Puas+fmY0Qw59XikLnW/Tfy1FL2HYRwbHCsoVAV7X4Gfhgk1JPui
        nj5TySrw/EokQEgrG90RBjfOwA==
X-Google-Smtp-Source: APiQypKtLi1Ei7GLEgyORO8pAsx6cVgJjSvoyoPjqzURXKE3LoS9Wil8gnTZulxN2y2v3ecbYlihTA==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr3533862wmc.83.1588257646202;
        Thu, 30 Apr 2020 07:40:46 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:40:45 -0700 (PDT)
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
Subject: [PATCH v6 23/25] PCI/ATS: Add PRI stubs
Date:   Thu, 30 Apr 2020 16:34:22 +0200
Message-Id: <20200430143424.2787566-24-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430143424.2787566-1-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
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
index f75c307f346de..e9e266df9b37c 100644
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

