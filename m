Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2EF5A2E34
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 20:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345006AbiHZSUM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 14:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344462AbiHZSUE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 14:20:04 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9501D0C2
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 11:19:56 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso8819664pjh.5
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 11:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=D+t611tSeFJdlaRBUeL7QdiZitvDcGQkCQ8fo5d53SM=;
        b=tSXmVZ7TNQtj4sIbTMnfui7rwyfNeFOEV6PlqKEaSFbwF/XI/7FUxJwI+EfbM9rzqM
         1CJMeMLSfZsqbh7HIupNRzcGzjEub2vMtbuW2r6LzVKpDrmpXo8vWgPFpDpRUgjpd7Hz
         tOd1W3QoNb5VZYUVfLgx1aHTnXwOdck8iDDoDxB382l+1sMpJRo2V8Te/0paMLsPEzpt
         RfczCkaLYjg0TNn08w/M3QgpTEGnZXZpFLlLFb5H73UZxxLPvYBldzlsCQyXdN1AK5eA
         wqt+2p8MMV5VGdm7gIX6grYKsFxWq6884ykjzwjZxg8bjzA0aoyEqX20azZM+UJoPH1H
         Xv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=D+t611tSeFJdlaRBUeL7QdiZitvDcGQkCQ8fo5d53SM=;
        b=uuYuuuHd5ePtEoC0jMNKQ5CYMnl7gVFO7/z29oJtTVh6QalhaCdkebnmFqmTeXUeEe
         UYV+ozME3vgQ/q/8LM0xOOU3mYiYSFlfBTGnBCVjJCQ1IVM+CQNf0fUAnkwgGG5hvxu/
         WuE7API6fkA1FUGFycjtLp70DdH7Op/3EPROdfbJ0jNVf1ObKuKDnKbxHLf2UuJfSfct
         elDR3bgydBLBs1gIIRinC8fT5ApA5wCxMIwNtFlmOxnFTrsgAjeiL/k4Tg5jmzeIVp8S
         nOHgwEIyWjoGOgmzgJmmlke7lAeyICKgMJN9og1yF8lPxE5DKFERNtSxJR9C2+d9oYKx
         1fxQ==
X-Gm-Message-State: ACgBeo0H/hqNVFjT3kaBrM4bsPCGWtOPEuPPLrhrpxF+MVBRF/JC0S0b
        SwoNVo+4aPXdQCPZOGAwFB/I
X-Google-Smtp-Source: AA6agR5zQqO62/cvI9WKmj8tKbsbd/T6CfVVEvLn9PQqs8taNQvSrf9yhVa8f+8yXsc7qTWjdX9MSg==
X-Received: by 2002:a17:90a:c242:b0:1fd:7b30:626e with SMTP id d2-20020a17090ac24200b001fd7b30626emr1345051pjx.153.1661537995834;
        Fri, 26 Aug 2022 11:19:55 -0700 (PDT)
Received: from localhost.localdomain ([117.193.214.147])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902b18500b00173368e9dedsm1881868plr.252.2022.08.26.11.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 11:19:54 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 04/11] PCI: qcom-ep: Add eDMA support
Date:   Fri, 26 Aug 2022 23:49:16 +0530
Message-Id: <20220826181923.251564-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
References: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

