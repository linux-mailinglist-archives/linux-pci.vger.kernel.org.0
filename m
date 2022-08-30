Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E677F5A6903
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 18:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiH3Q7g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 12:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiH3Q7S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 12:59:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAF9BFC49
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 09:59:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so12450583pji.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=D+t611tSeFJdlaRBUeL7QdiZitvDcGQkCQ8fo5d53SM=;
        b=kVeAYgVIcvh9Y1/Dc5SFOsOvikyDlpNBLkrRVGrv9gm9jXQGoT7GTinYbkd9qBEZlh
         27DPUG7O9g76tKSxBD2+yCMNRcKC1BMvhZKK1mFmvtu6stdpSzpBatZRP0JnsbNHs8sz
         MCfnUPsSqJyVzSVLyoJTgT5l297iEgGdhSEc/buN8sdJ4owfv7szNB/hbgWt6aTdQwfj
         Wc/Cb4+43iMZ+BY9pOw3FBYRufacY20pShc9kUeKspFB9qKKfbdshFh7cjVpxt0G2FFe
         6uzLFSIST4AAWuWFv56YS1M1boqWV5TKM0QXq6ByQr7owX0Lmz5QPcwKVfgiAklxPkhx
         TT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=D+t611tSeFJdlaRBUeL7QdiZitvDcGQkCQ8fo5d53SM=;
        b=OrQ0axo3XL510p4HwrMbEcLbYHBDESOvCE4O0iC7OekiGI2fiYKoEA6T5uw7yP8lYP
         usvZLOzd2AYJSqz8YAo0x/EU3wifqM/P4s9qgimjLjQIik7kkniXRM4X2B1Itw+ysdXS
         EUtnsXgCiIDSFhc0NXpddJQyXGxEo2S6HDeOxbqqZ/8x/y8xWPkGi5fG72QmtO61gw8C
         1MgCLk10RKpunuARWPuQPSdfSmsnS4Me3VxOjABg2LyNu9UOACQ0FbxU6aEqJ4pj4PgK
         kRo1vtzKHvTiA70NZ8WE6tUg3zU+DW1ce5ERxMtXXt0xUvU4YheIwY+m1nyFoso2bD+B
         +iOQ==
X-Gm-Message-State: ACgBeo1uwChECJoJaSHqN9vkf28YrMegOANhTqEr+odnYAP4dqpBD2V2
        zIx8AXL9zcTaoLLoyF9jqT6r
X-Google-Smtp-Source: AA6agR4ay617XZEn9BSl4rlfvkGED9InOfI+x47WfduM0tt8NjHbGQqa/9iANW/R64Khr/rI84AVgw==
X-Received: by 2002:a17:902:f782:b0:173:1206:cee0 with SMTP id q2-20020a170902f78200b001731206cee0mr21871943pln.130.1661878744651;
        Tue, 30 Aug 2022 09:59:04 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.234])
        by smtp.gmail.com with ESMTPSA id n59-20020a17090a5ac100b001f510175984sm8841261pji.41.2022.08.30.09.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 09:59:04 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 04/11] PCI: qcom-ep: Add eDMA support
Date:   Tue, 30 Aug 2022 22:28:10 +0530
Message-Id: <20220830165817.183571-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830165817.183571-1-manivannan.sadhasivam@linaro.org>
References: <20220830165817.183571-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Qualcomm PCIe Endpoint controllers have the in-built Embedded DMA (eDMA)
peripheral for offloading the data transfer between PCIe bus and memory.

Let's add the support for it by enabling the eDMA IRQ in the driver.
Rest of the functionality will be handled by the eDMA DMA Engine driver.

Since the eDMA on Qualcomm platforms only uses a single IRQ for all
channels, use 1 for edma.nr_irqs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 1e09eca5b3b2..54b927adf60a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -66,6 +66,7 @@
 #define PARF_INT_ALL_PLS_ERR			BIT(15)
 #define PARF_INT_ALL_PME_LEGACY			BIT(16)
 #define PARF_INT_ALL_PLS_PME			BIT(17)
+#define PARF_INT_ALL_EDMA			BIT(22)
 
 /* PARF_BDF_TO_SID_CFG register fields */
 #define PARF_BDF_TO_SID_BYPASS			BIT(0)
@@ -367,7 +368,7 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	writel_relaxed(0, pcie_ep->parf + PARF_INT_ALL_MASK);
 	val = PARF_INT_ALL_LINK_DOWN | PARF_INT_ALL_BME |
 	      PARF_INT_ALL_PM_TURNOFF | PARF_INT_ALL_DSTATE_CHANGE |
-	      PARF_INT_ALL_LINK_UP;
+	      PARF_INT_ALL_LINK_UP | PARF_INT_ALL_EDMA;
 	writel_relaxed(val, pcie_ep->parf + PARF_INT_ALL_MASK);
 
 	ret = dw_pcie_ep_init_complete(&pcie_ep->pci.ep);
@@ -670,6 +671,7 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 	pcie_ep->pci.dev = dev;
 	pcie_ep->pci.ops = &pci_ops;
 	pcie_ep->pci.ep.ops = &pci_ep_ops;
+	pcie_ep->pci.edma.nr_irqs = 1;
 	platform_set_drvdata(pdev, pcie_ep);
 
 	ret = qcom_pcie_ep_get_resources(pdev, pcie_ep);
-- 
2.25.1

