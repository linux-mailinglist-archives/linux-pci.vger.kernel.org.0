Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85B12B05DA
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 14:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgKLNDb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 08:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgKLND0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 08:03:26 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB869C061A4A
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 05:03:25 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c16so5441996wmd.2
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 05:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YNIotbOC7bka5Z9BLnFVmsCtOLB6kJ/rhFA9CsCNoBU=;
        b=QZfgK97B8RvBj1vgMXgdtAlJTXGErNY2MHWaYeZJYcihAKpzxznX+f3QupErxyW+y7
         vl5dFcj/SwiTM7AoiBl8Ekh/VI2I+MV6RRDXOcrbDCGTkeMw66SFzS1DgJvxjcaDuKjk
         2bmfttuRd5KL3r+eSvLlVqZxie8jGCaK6VIEInNDm+bzEK1xUWxTL3t2xMOYv4Bass5p
         gBiBnUXUjVBFvCB1BrWOR56d6TtjFa2TYTFOwxI7fDliFlDQVEIWqgTYl5sIlbDUR1ej
         iCxbPa+0gIBZXHXjDH2ssbGlbO7TSEgUjnx9UYgYtW9ALf/I+qK3xCqik9HnPlfBcF/J
         Vzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YNIotbOC7bka5Z9BLnFVmsCtOLB6kJ/rhFA9CsCNoBU=;
        b=qFzCD50NrhXYUZisazfDgEygzoorGPFsCKWi/s8kXaxT2Nbbqf8j1NggPE/PLm54t8
         mE1j3QBW2a86RvA8Wu4FNDMjn3p7gjELc2GTD8vSzKWpV/B3aKuRFvCAtN82Sp9I79jo
         GggIEntER6WcXFNxZScsuOOlPCsdtozQG/I7nGYi1CDtdcLqRrfkgNUOVUvr+MRIVzvt
         bT/UXIRN5jgQ8vTy+O4CgTbUuT6Sx2i1t6LKui0Q/FDPfpzwL63yGfYvUziS30UcbHE6
         AlCmW9W2IqmkU8TIkpGeoHO0W9nIe4gCMiKgXPq32LwnO/H+oOJY/UhOsUJrOnMXrjD9
         1rbg==
X-Gm-Message-State: AOAM5320fhxgHR0L/beY6LUoL6zZo9kBFR1HU0wQHkrmCBjXpySlIo6e
        LqZjuDyoYpqfsX3nq3zCxTBcJA==
X-Google-Smtp-Source: ABdhPJwEuQSW7wZd81DIymTmLqqJtRteXgrSKTo8T+v6vTfsJF7cOILOIkbIrFkOfcCnh2vnSQXfbA==
X-Received: by 2002:a1c:2586:: with SMTP id l128mr9104219wml.149.1605186204490;
        Thu, 12 Nov 2020 05:03:24 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id m22sm6877508wrb.97.2020.11.12.05.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:03:23 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, baolu.lu@linux.intel.com,
        zhangfei.gao@linaro.org, shameerali.kolothum.thodi@huawei.com,
        vivek.gautam@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v8 7/9] PCI/ATS: Add PRI stubs
Date:   Thu, 12 Nov 2020 13:55:19 +0100
Message-Id: <20201112125519.3987595-8-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201112125519.3987595-1-jean-philippe@linaro.org>
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 include/linux/pci-ats.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index df54cd5b15db..ccfca09fd232 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -30,6 +30,13 @@ int pci_reset_pri(struct pci_dev *pdev);
 int pci_prg_resp_pasid_required(struct pci_dev *pdev);
 bool pci_pri_supported(struct pci_dev *pdev);
 #else
+static inline int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
+{ return -ENODEV; }
+static inline void pci_disable_pri(struct pci_dev *pdev) { }
+static inline int pci_reset_pri(struct pci_dev *pdev)
+{ return -ENODEV; }
+static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
+{ return 0; }
 static inline bool pci_pri_supported(struct pci_dev *pdev)
 { return false; }
 #endif /* CONFIG_PCI_PRI */
-- 
2.29.1

