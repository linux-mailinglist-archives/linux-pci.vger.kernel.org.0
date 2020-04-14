Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D421A86D7
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 19:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391609AbgDNRE6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 13:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391569AbgDNREx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2020 13:04:53 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C6AC061A0C
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:53 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a201so14548622wme.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vE2itLZu3hqvC4LzqU2NUCFx+9C8ab/nGgmunlfocw4=;
        b=GQc1HJySAIFGl4e9JGBFURgN/vl21Fb+oCGY0ghVUDlr5r96ZmZmw/X83yVkMwCMvt
         DVAASgUR/v3/ZKBKl9O60CQVrNvn4oMMVLsH3g9JXWg+IeYIxVCppffgWVDw7kFLs+SL
         qL185/o63pqZqsBw6EgV8XD0/UHJpB1qI+n6vwa7Qv2mwO4fdLqiqOvJiR2hZWZH7Me1
         eoakZAu9sIB1oOiShcxlx+56zauDP7aBZBVxrI01fRfnSKCQXLcXyLhFUPuBdcSxvOTp
         gidl1cZtbaXu5tx9otKpXSBohIzzToXZC0tS5fggLOAxV0+H42kV0oHqDEtXsMF2hNlm
         qwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vE2itLZu3hqvC4LzqU2NUCFx+9C8ab/nGgmunlfocw4=;
        b=CLfiOphawORfSH80Z/UTBGqTpYDmniLN7bGqL+W6DyMvSGgurhu53fYKnMEfo0WW3N
         3Za3CbIbmQ/hx9gfQ8Rucnn5uQ/ZcfyErhRsxpvaBxfpa81rQaTZz4egZ5cJ6/e0MJho
         I9GtEYSN8sfvgXKu/f/6DC8lIOnCc8fV0krheg0ZKZRcvuXTpjfjHCmPbTlAQ9QPMrRw
         l+i8pt7cObpiFs6BYiGAp+PfVRTqf1B7qEeHAB4Cycy1dZM1qLm0NTDjQds83cRcjLRt
         FcBSZir00QFEe+CWjlTsLkbjtJlxR7uCb9lWa2LqkqVM+L2u7iJ+nW1QDIm1VEBuYhlz
         PO+Q==
X-Gm-Message-State: AGi0PuaZv5e9XJUGMWro/8NpC5/D5XH4pACDstTXNr4QemwQxFjJUpX/
        a9dJCcOZ69A3L8ivhACnUH8wAg==
X-Google-Smtp-Source: APiQypIBMdNPHOZOhnCMJH0FJPJY2Rdi+r/VG4B2wmIYz2z44PksUMUJ1Q8ZKmB8ryyXqmfTYJG52Q==
X-Received: by 2002:a1c:3c08:: with SMTP id j8mr814017wma.30.1586883892098;
        Tue, 14 Apr 2020 10:04:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:04:51 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v5 24/25] PCI/ATS: Export PRI functions
Date:   Tue, 14 Apr 2020 19:02:52 +0200
Message-Id: <20200414170252.714402-25-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SMMUv3 driver uses pci_{enable,disable}_pri() and related
functions. Export those functions to allow the driver to be built as a
module.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/ats.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index bbfd0d42b8b97..fc8fc6fc8bd55 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -197,6 +197,7 @@ void pci_pri_init(struct pci_dev *pdev)
 	if (status & PCI_PRI_STATUS_PASID)
 		pdev->pasid_required = 1;
 }
+EXPORT_SYMBOL_GPL(pci_pri_init);
 
 /**
  * pci_enable_pri - Enable PRI capability
@@ -243,6 +244,7 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_enable_pri);
 
 /**
  * pci_disable_pri - Disable PRI capability
@@ -322,6 +324,7 @@ int pci_reset_pri(struct pci_dev *pdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_reset_pri);
 
 /**
  * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
@@ -337,6 +340,7 @@ int pci_prg_resp_pasid_required(struct pci_dev *pdev)
 
 	return pdev->pasid_required;
 }
+EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
-- 
2.26.0

