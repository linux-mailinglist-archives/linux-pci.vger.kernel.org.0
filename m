Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA007F0DBA
	for <lists+linux-pci@lfdr.de>; Mon, 20 Nov 2023 09:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjKTIkx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Nov 2023 03:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjKTIkw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Nov 2023 03:40:52 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D767129
        for <linux-pci@vger.kernel.org>; Mon, 20 Nov 2023 00:40:47 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6bee11456baso3407255b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Nov 2023 00:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700469646; x=1701074446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cA4et5DEe58CvaUPaUoVn2JhyhKCxIJLdzNc+n4DX2I=;
        b=FXqmwKK2EVv6oFkDad7iQc9A3S53jV1tk7MOfvqm2FUJ+pncZHWTXUPhM6875sYCwT
         mYMiq4uLb2fqOTVfqlLPFTw3oJXCIj7yrz6Ss1eQP06zzwIS/xTWNonZGUFh508bYnIF
         cOYxYIm5nh953R7UEfqUsXOxKqeWTKuTUgSnszeI1eYbRYwIHlzaFAO4Z5tGS1ffUrQ7
         pOOx7dvJ7fATTAb7gawGXNZ5Koq2lns7rKHwAN5M39USxiGEyIq4CeognX1oHdSgZs/T
         voy4OXWXw7b0PBE57Tv7kk+3TuH7Ni+OrAfv+XsSOEgcP3nR99rhY67CqVAq9CI/jq+U
         5HYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700469646; x=1701074446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cA4et5DEe58CvaUPaUoVn2JhyhKCxIJLdzNc+n4DX2I=;
        b=rp2EFvWtQc61afF1C+MkJRGnzLTA3gw0heKSmXaOLXIZGd17A1LlCRgVN8zIHfbFxy
         AXK0RmQkdEk/ZA27kZ3hM+YyGwhuqWL5MlIjOnJuYAW04kRQbBHR/BXkQPaL2LFew9ZZ
         z8aXxSSGfKJxf6M3OL1rmI5PX1UxHIBzxexqi51Rxc9/jG6+Xju8nWOoqmsQxXIN1b/e
         gESDK59EbPs7LxkioBV0U9SucDDvhj55t2WqaHPjLgx1aYaptNfx/lZbNVYh4r9DKc2p
         mTPQ+6X1s0InrxVLMy2mfyn/eZVk7vS2W2JpR2hvpEaL7INiVhMdhWZOE0NbWCoCgVVU
         XBiw==
X-Gm-Message-State: AOJu0Yz0ENWRc5hcG0ilX9tZZL7hQD09PqHObNjPzr4dENQq7CaJ0cvK
        Gyck/elTi8equ9dHvnmkJruh
X-Google-Smtp-Source: AGHT+IElVewiVppHRvMO+lPS3lN61OStbKOmnNSX89BRCubPBY4/WTTj8C1eQ+g8SFtw8K29OgPTfQ==
X-Received: by 2002:a05:6a21:9209:b0:174:7f7:d049 with SMTP id tl9-20020a056a21920900b0017407f7d049mr5987907pzb.9.1700469646494;
        Mon, 20 Nov 2023 00:40:46 -0800 (PST)
Received: from localhost.localdomain ([117.248.2.5])
        by smtp.gmail.com with ESMTPSA id e24-20020a62ee18000000b00694ebe2b0d4sm5567019pfi.191.2023.11.20.00.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:40:43 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_bjorande@quicinc.com,
        fancer.lancer@gmail.com, vidyas@nvidia.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 2/2] PCI: designware-ep: Move pci_epc_init_notify() inside dw_pcie_ep_init_complete()
Date:   Mon, 20 Nov 2023 14:10:14 +0530
Message-Id: <20231120084014.108274-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231120084014.108274-1-manivannan.sadhasivam@linaro.org>
References: <20231120084014.108274-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since pci_epc_init_notify() API is getting called right after the
dw_pcie_ep_init_complete() API in the DWC glue drivers, let's move it
inside dw_pcie_ep_init_complete() API as there is no compelling reason to
call it separately.

Co-developed-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 10 ++--------
 drivers/pci/controller/dwc/pcie-designware.h    |  5 -----
 drivers/pci/controller/dwc/pcie-qcom-ep.c       |  2 --
 drivers/pci/controller/dwc/pcie-tegra194.c      |  2 --
 4 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index b1c79cd8e25f..63bb99d1c48f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -22,14 +22,6 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
 
-void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
-{
-	struct pci_epc *epc = ep->epc;
-
-	pci_epc_init_notify(epc);
-}
-EXPORT_SYMBOL_GPL(dw_pcie_ep_init_notify);
-
 struct dw_pcie_ep_func *
 dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
 {
@@ -784,6 +776,8 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 	if (ret)
 		goto err_cleanup;
 
+	pci_epc_init_notify(epc);
+
 	return 0;
 
 err_cleanup:
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 55ff76e3d384..53bf38989eea 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -578,7 +578,6 @@ static inline void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus,
 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep);
-void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
 void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
 int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no);
 int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
@@ -605,10 +604,6 @@ static inline int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 	return 0;
 }
 
-static inline void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
-{
-}
-
 static inline void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 {
 }
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 9e58f055199a..4a8119779a29 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -482,8 +482,6 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	val &= ~PARF_MSTR_AXI_CLK_EN;
 	writel_relaxed(val, pcie_ep->parf + PARF_MHI_CLOCK_RESET_CTRL);
 
-	dw_pcie_ep_init_notify(&pcie_ep->pci.ep);
-
 	/* Enable LTSSM */
 	val = readl_relaxed(pcie_ep->parf + PARF_LTSSM);
 	val |= BIT(8);
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 0fe113598ebb..1126d1f5830c 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1901,8 +1901,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 		goto fail_init_complete;
 	}
 
-	dw_pcie_ep_init_notify(ep);
-
 	/* Program the private control to allow sending LTR upstream */
 	if (pcie->of_data->has_ltr_req_fix) {
 		val = appl_readl(pcie, APPL_LTR_MSG_2);
-- 
2.25.1

