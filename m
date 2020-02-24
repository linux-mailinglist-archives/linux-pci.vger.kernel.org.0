Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22D9816AEF4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 19:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgBXSY7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 13:24:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50451 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgBXSY6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 13:24:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so324784wmb.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 10:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L4b0/E9FteCzWtJ3m41x7utj4DLNM6J+Wsoo7xEmR/M=;
        b=AaB0/woqy++LPMkoIBZ+m4G2UZnpMtnZvwcO6++TMOA9EU96huOkx2S0UskmT4cEpU
         xMrifrssPWkaFWKgEl2sH4pudtTv9O5xP8UA1tGUign2rkYDTr5uz/QuiZzooFCt1UtE
         rFYtkQKLo4kgyRbPCGQdQ0RkTH5WIdikmyUEt5mlxrO2m5pQuEYSi3SrHoKPrs6ir6C0
         h1xnyNfpSIa1Ci4ubWuYL1OusT1Jg5137L60+g+2IYH6Io8VN2+J8l0BSyTJWIJ6meQH
         bVi7Q64CjqZ4FvWJAUKwwHkRMFvfOpZv/R9jAdlHM31BS2Lo6e6itFaGlBgY5e1Zdzw/
         2HxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L4b0/E9FteCzWtJ3m41x7utj4DLNM6J+Wsoo7xEmR/M=;
        b=YYzsoPLtpOc59t6X3aFXUveW9yNA/tWn1X9bxY6gWVYAf4B8DoezY74CNs1sYsf9DN
         wiJeOqu18WfcF2DsC2eXZOceqzjSxdiWIA9BszwFIZoGsU1kGdT3LdSWsxZEfmJTnYHn
         ldijNOoHmPdLAluED1IvUFq3QP30kGHU6HabvOwoB5CGpmYqrQYQb8j4OCMHNqpo6sJP
         Rc0sRlr+PuEnHoIFNBtzKTkAw9xzkEcZ5c04kOmP7tjOk3fAPXcNHeDZ+2WCFysfewz+
         7HxtY+VL7QJ2vD/+IqDvZUg/FDHcV0Dtqk2pc6BTjy1Vc9niXCB1BLgTTGQBS96as0mI
         73Kw==
X-Gm-Message-State: APjAAAW2ltW8cr9ArbUt+q7UsQhTAGIWnapLMV0DCkBULfXUk6/oyl7Z
        HNK4VyCIScaTUQSbZdzk0pAB/A==
X-Google-Smtp-Source: APXvYqx6ypZ/kM3sOzy1vTskWfaUURVJkjgEhRCiqvXYI27Ek63kaa7GG0Ur7iiefNgxz5pwggvx6A==
X-Received: by 2002:a7b:c249:: with SMTP id b9mr296154wmj.61.1582568697369;
        Mon, 24 Feb 2020 10:24:57 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:24:56 -0800 (PST)
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
Subject: [PATCH v4 25/26] PCI/ATS: Export symbols of PRI functions
Date:   Mon, 24 Feb 2020 19:24:00 +0100
Message-Id: <20200224182401.353359-26-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224182401.353359-1-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SMMUv3 driver uses pci_{enable,disable}_pri() and related
functions. Export those functions to allow the driver to be built as a
module.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/ats.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index bbfd0d42b8b9..fc8fc6fc8bd5 100644
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
2.25.0

