Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230C94EBA8E
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 08:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243133AbiC3GHM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 02:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237573AbiC3GHL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 02:07:11 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEF311172
        for <linux-pci@vger.kernel.org>; Tue, 29 Mar 2022 23:05:26 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id c11so16729701pgu.11
        for <linux-pci@vger.kernel.org>; Tue, 29 Mar 2022 23:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9rRIzAIP5eGuRDw6o8WhSv85kaxuVbm/ru1cUzA6Npc=;
        b=ENqdUNRwB5jhcWW7uTcCi/TshHS/DU8oxd0XvPunsF8U+/YjrYokrGqOcPTsyXOPtV
         069o6a9K99Zi/84zJlhWwSKYCa/F/gcS58FyHObBrP91TRyUi3Gn8eoTMsKnESTBY6LY
         2OFzFXHUmR6SEXAB+dlKnufqwSmG0mIGbIEtVkmYiY7ikCGzEcKpvi4s4tbDtnFz5hF5
         IFW/TkVckk2Ljdy8a/9Lirvyzo9o0fL7OxH6zB8ueror1Md8YVrep24887/bD/Bq7VB6
         VVn+M2s5utpSkj0UJaZdY/EelM0lvpHnPEmDR6GTsERCOcvO23myIS/mMQP4LIf7TFJk
         G3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9rRIzAIP5eGuRDw6o8WhSv85kaxuVbm/ru1cUzA6Npc=;
        b=fdmOM6u/CPC4qtKQr3sab9tDp/0tkfCXJjrpRcixI++Ml8kQTMxTlBl9ugFaemiOV5
         MAKx+1dp5BndUUmUpksR78Pr2uRHdGlpGpFhmtWx8tY4cVPiml5I5UbNuNUoPNjdoy2O
         py9XwDQeKeqwnNs7Xcs0nBJm8BqJYFyH9sm68lqUCOrB/eDhP+ryeWLkM6QvqKMUIE8W
         Vd5WiT84YRF580vETMIOEfBTMadyT7DPefsrmAHYNl/rXgDxQgNdTHwOxHKuTXwQPMco
         jIZa4fb0juqsuNPkGig+AHy5W5zWRz7UWjF9g6aTO3rcOB/J2ihIAh8okoroU8ZHZmNO
         kjzA==
X-Gm-Message-State: AOAM531Q72M2385zyQVkY/dzcTrwTVxFQHcUJCilCEnmLPJQMZgqTr6z
        CIrWzTJMcy492pyDYGzQsoMZ
X-Google-Smtp-Source: ABdhPJx5ed69KV8MoSwXkLzdgQpzMv4hewlfXKyFbqAJmd4vrUsdtCEZi5z62nKuCnLlut8S3Xo3Yw==
X-Received: by 2002:a63:1b51:0:b0:37f:fc7e:7669 with SMTP id b17-20020a631b51000000b0037ffc7e7669mr4883239pgm.244.1648620326309;
        Tue, 29 Mar 2022 23:05:26 -0700 (PDT)
Received: from localhost.localdomain ([117.217.187.61])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004f1111c66afsm24016764pfl.148.2022.03.29.23.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 23:05:25 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, bhelgaas@google.com, robh@kernel.org,
        lorenzo.pieralisi@arm.com
Cc:     kw@linux.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH] PCI: designware-ep: Move DBI access to init_complete if notifier is used
Date:   Wed, 30 Mar 2022 11:35:15 +0530
Message-Id: <20220330060515.22328-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For controllers supporting the CORE_INIT notifier, the resources are
supposed to be enabled in the init_complete function. Currently,
these controllers are enabling the resources during probe time due to
the DBI access happens in dw_pcie_ep_init().

This creates the dependency with the host PCIe controller since the
resource enablement like PHY depends on host PCIe to be up. For the
standalone endpoint usecase, this would never work. So let's move all DBI
access to init_complete function if CORE_INIT notifier is used. For the
controllers those doesn't support this notifier, this change is a NO-OP.

Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Om Prakash Singh <omp@nvidia.com>
Cc: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 138 ++++++++++++------
 drivers/pci/controller/dwc/pcie-designware.h  |   1 +
 2 files changed, 94 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 0eda8236c125..fb2bf4bf5ba0 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -636,6 +636,63 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
 	return 0;
 }
 
+static int dw_pcie_iatu_config(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct device *dev = pci->dev;
+	void *addr;
+
+	dw_pcie_iatu_detect(pci);
+
+	ep->ib_window_map = devm_kcalloc(dev,
+					 BITS_TO_LONGS(pci->num_ib_windows),
+					 sizeof(long),
+					 GFP_KERNEL);
+	if (!ep->ib_window_map)
+		return -ENOMEM;
+
+	ep->ob_window_map = devm_kcalloc(dev,
+					 BITS_TO_LONGS(pci->num_ob_windows),
+					 sizeof(long),
+					 GFP_KERNEL);
+	if (!ep->ob_window_map)
+		return -ENOMEM;
+
+	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
+			    GFP_KERNEL);
+	if (!addr)
+		return -ENOMEM;
+
+	ep->outbound_addr = addr;
+
+	return 0;
+}
+
+static int dw_pcie_ep_func_init(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_pcie_ep_func *ep_func;
+	struct pci_epc *epc = ep->epc;
+	struct device *dev = pci->dev;
+	u8 func_no;
+
+	for (func_no = 0; func_no < epc->max_functions; func_no++) {
+		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
+		if (!ep_func)
+			return -ENOMEM;
+
+		ep_func->func_no = func_no;
+		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
+							      PCI_CAP_ID_MSI);
+		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
+							       PCI_CAP_ID_MSIX);
+
+		list_add_tail(&ep_func->list, &ep->func_list);
+	}
+
+	return 0;
+}
+
 int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -643,7 +700,22 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 	unsigned int nbars;
 	u8 hdr_type;
 	u32 reg;
-	int i;
+	int ret, i;
+
+	if (ep->core_init_notifier) {
+		ret = dw_pcie_iatu_config(ep);
+		if (ret)
+			return ret;
+	}
+
+	if (ep->core_init_notifier) {
+		ret = dw_pcie_ep_func_init(ep);
+		if (ret)
+			return ret;
+
+		if (ep->ops->ep_init)
+			ep->ops->ep_init(ep);
+	}
 
 	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
 		   PCI_HEADER_TYPE_MASK;
@@ -677,8 +749,6 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	int ret;
-	void *addr;
-	u8 func_no;
 	struct resource *res;
 	struct pci_epc *epc;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -686,7 +756,12 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
 	const struct pci_epc_features *epc_features;
-	struct dw_pcie_ep_func *ep_func;
+
+	if (ep->ops->get_features) {
+		epc_features = ep->ops->get_features(ep);
+		if (epc_features->core_init_notifier)
+			ep->core_init_notifier = true;
+	}
 
 	INIT_LIST_HEAD(&ep->func_list);
 
@@ -708,7 +783,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		}
 	}
 
-	dw_pcie_iatu_detect(pci);
+	if (!ep->core_init_notifier) {
+		ret = dw_pcie_iatu_config(ep);
+		if (ret)
+			return ret;
+	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
 	if (!res)
@@ -717,26 +796,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	ep->phys_base = res->start;
 	ep->addr_size = resource_size(res);
 
-	ep->ib_window_map = devm_kcalloc(dev,
-					 BITS_TO_LONGS(pci->num_ib_windows),
-					 sizeof(long),
-					 GFP_KERNEL);
-	if (!ep->ib_window_map)
-		return -ENOMEM;
-
-	ep->ob_window_map = devm_kcalloc(dev,
-					 BITS_TO_LONGS(pci->num_ob_windows),
-					 sizeof(long),
-					 GFP_KERNEL);
-	if (!ep->ob_window_map)
-		return -ENOMEM;
-
-	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
-			    GFP_KERNEL);
-	if (!addr)
-		return -ENOMEM;
-	ep->outbound_addr = addr;
-
 	if (pci->link_gen < 1)
 		pci->link_gen = of_pci_get_max_link_speed(np);
 
@@ -753,23 +812,15 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	if (ret < 0)
 		epc->max_functions = 1;
 
-	for (func_no = 0; func_no < epc->max_functions; func_no++) {
-		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
-		if (!ep_func)
-			return -ENOMEM;
-
-		ep_func->func_no = func_no;
-		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
-							      PCI_CAP_ID_MSI);
-		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
-							       PCI_CAP_ID_MSIX);
+	if (!ep->core_init_notifier) {
+		ret = dw_pcie_ep_func_init(ep);
+		if (ret)
+			return ret;
 
-		list_add_tail(&ep_func->list, &ep->func_list);
+		if (ep->ops->ep_init)
+			ep->ops->ep_init(ep);
 	}
 
-	if (ep->ops->ep_init)
-		ep->ops->ep_init(ep);
-
 	ret = pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
 			       ep->page_size);
 	if (ret < 0) {
@@ -784,12 +835,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		return -ENOMEM;
 	}
 
-	if (ep->ops->get_features) {
-		epc_features = ep->ops->get_features(ep);
-		if (epc_features->core_init_notifier)
-			return 0;
-	}
+	if (!ep->core_init_notifier)
+		return dw_pcie_ep_init_complete(ep);
 
-	return dw_pcie_ep_init_complete(ep);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 7d6e9b7576be..aadb14159df7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -242,6 +242,7 @@ struct dw_pcie_ep {
 	void __iomem		*msi_mem;
 	phys_addr_t		msi_mem_phys;
 	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
+	bool			core_init_notifier;
 };
 
 struct dw_pcie_ops {
-- 
2.25.1

