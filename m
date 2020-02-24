Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8503916AEF1
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 19:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgBXSY6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 13:24:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37574 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgBXSY6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 13:24:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id l5so7323300wrx.4
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 10:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oVPY2SNV/SUayab6VGyitFWrI9RILHKqjSrcDOg3sBg=;
        b=OnFOZtrZEFufL7rTBOmlZ40Hq224mutQ/5o0VAFHjr/9ZW5PBMJ0Y7/GDS3/xR/dnD
         TEsPyQ+iLNysIg1dKsUqwcdOSjQuqzH7iLV5knh5wCpz5/PmbdVT8KcjMEYbg24is9zH
         t6ACUI7hhk9FGQPHZTGMTb2NY4PcnI9R5MLG1z3wtZTl3ODyonISTbNRfmBpEMohHa92
         CKN1L7n6QuxpTjQJxuOJ4Ho23RxS2Njg7SP7AcfdcAfbOXg6vAiEfIa4WG7H9/SStdt+
         Gm1dU1ozzhGu8153BnWCyrRxnsfeTzwGIutPWQZPh3v8U2NHd1wgZo4SDlNKF9ic1rWv
         Y4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oVPY2SNV/SUayab6VGyitFWrI9RILHKqjSrcDOg3sBg=;
        b=CuJp/pVCA2Xc/Ox2PhCiVpzIDzFguP01HLyhQJtFUFEThWcSawc6VUJvcNduYsLHFR
         J5bKetR7ZDnwYm4BnNEt2hVLJPl/R5TuIKGHzD4moQTVmAxIBuEIYJ5wpGS9u6rr34Ci
         eD/75WBh7FGJxl97yHZWTAytdWcrcuBmStoWrTUSkjXkmubxG2ZzQUIHMYV+/hAnVZDy
         XhGX7WfYx4hKUIjwXNCouFNYS/mBOHNvvND8M+3kXQ1X5EsyZ0eXBXKe1SHPMMA0oQLW
         a4aA9+VETJB5mYwoGde0gAF8Golp1SGjECDJpknOCAkx++Mh2R9dAtIvi/810xqXVl3h
         yS5w==
X-Gm-Message-State: APjAAAVtBg1de0gTE+2Ske2MdJHr1a/eTpt+jYKqktO+c+YYWIRHoGCb
        pKGHBTSWuUE6p5yW/DS5c8HiaA==
X-Google-Smtp-Source: APXvYqxjjLnHOC5PFDeOpyj527vO7u0PGvC49hWOgOh7ytPa88sYjcO6Bg19gqIDQUy51J2OFlu0Ew==
X-Received: by 2002:a5d:4c52:: with SMTP id n18mr2796517wrt.403.1582568696322;
        Mon, 24 Feb 2020 10:24:56 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:24:55 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
        kevin.tian@intel.com, baolu.lu@linux.intel.com,
        Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, yi.l.liu@intel.com,
        zhangfei.gao@linaro.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v4 24/26] PCI/ATS: Add PRI stubs
Date:   Mon, 24 Feb 2020 19:23:59 +0100
Message-Id: <20200224182401.353359-25-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224182401.353359-1-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
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

Cc: Bjorn Helgaas <bhelgaas@google.com>
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
2.25.0

