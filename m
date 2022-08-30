Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4235A690C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 18:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiH3Q7x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 12:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiH3Q7f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 12:59:35 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99B2F72EB
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 09:59:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w2so11753303pld.0
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 09:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=LclRCur2+TmOph0Lw8Vjg5+TpaDfY+BX1hQtzMBpEmo=;
        b=h07RNOiqIlifbVpVHPhKfocZqgUpN4BvEgeIwwO+HVIgjWt+AZh5u8gy7bLTmU5uxJ
         NM7+dPKAfaGu5MM2RzTY1UANAfe1XiFA7G1YRTO0fWNgyOZPYgMa98O0R1K4qu6HI9UX
         MS6Rnea3jJIGCC04cVEMVLRaNQAsGleKSMz5pb1CPwHufS2UQ6CV29dnga0JnQgNIqaA
         Vm5+k48j5mGsQYBuRyNdmTqR0mrGlBQDjPot5rBL/iym1/6RN6lYnHktNMYf3kgnIkU0
         yF+9WQRrUXWx61IGuHeTAWd7IFQcMVfwf+W7t9ly7APLAnL4lVK4HDFz6kgjRmKiSpZL
         ESxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=LclRCur2+TmOph0Lw8Vjg5+TpaDfY+BX1hQtzMBpEmo=;
        b=NLeGfkMsJ+9SLtpUd6pCN6WKlEdXB2hS7d8jb7NbKgUxpLBjzmSmwC1zt2/Ohmc4T1
         gfbaLeaRvmsRKlvH1lSTOzsfwsUznUY3rd+1spr+6xyahy/kULTzWeai8l9VTTLYrU7V
         pEo1yR+SvKOLlY2RzY2PA1WVxOKtfQBjER6DWrrDFKcWkXo+bPl7IcC/q1jZ8rsnJ6EY
         ENtq02rxtp0ICDCRODbkQRye042fMEWO2yWJRquZmRcLrTLhZRWj2NnGGC1olYZjnyRz
         JkgcOjGNULD/rDTUScMGPfcJc3txFejoRBeSSJFVj0lINEXE4mnoUbHE+KseIV9Hb/QG
         W6MA==
X-Gm-Message-State: ACgBeo0auOyexVjyKD1J6I3Jesxh07fyFQGsb1E++5SGnB/eZilO5z/A
        D1WNHYnVwcURBflZ3c3uV00Z
X-Google-Smtp-Source: AA6agR7rYHw3fJyVkM6r7m08BcCDtw/6FDziPykL8Mdo2fq4v4sP4oTJABmGn0nQ4ZViDEeSi+xc4Q==
X-Received: by 2002:a17:902:f651:b0:174:3c03:6be3 with SMTP id m17-20020a170902f65100b001743c036be3mr20369034plg.113.1661878767273;
        Tue, 30 Aug 2022 09:59:27 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.234])
        by smtp.gmail.com with ESMTPSA id n59-20020a17090a5ac100b001f510175984sm8841261pji.41.2022.08.30.09.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 09:59:26 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 08/11] PCI: qcom-ep: Make PERST separation optional
Date:   Tue, 30 Aug 2022 22:28:14 +0530
Message-Id: <20220830165817.183571-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830165817.183571-1-manivannan.sadhasivam@linaro.org>
References: <20220830165817.183571-1-manivannan.sadhasivam@linaro.org>
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

PERST separation is an optional debug feature used to collect the crash
dump from the PCIe endpoint devices by the PCIe host when the endpoint
crashes. This feature keeps the PCIe link up by separating the PCIe IP
block from the SoC reset logic.

Hence, make the property optional in the driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 54ac2fef8b88..4908f08bd90b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -216,8 +216,10 @@ static int qcom_pcie_ep_core_reset(struct qcom_pcie_ep *pcie_ep)
  */
 static void qcom_pcie_ep_configure_tcsr(struct qcom_pcie_ep *pcie_ep)
 {
-	regmap_write(pcie_ep->perst_map, pcie_ep->perst_en, 0);
-	regmap_write(pcie_ep->perst_map, pcie_ep->perst_sep_en, 0);
+	if (pcie_ep->perst_map) {
+		regmap_write(pcie_ep->perst_map, pcie_ep->perst_en, 0);
+		regmap_write(pcie_ep->perst_map, pcie_ep->perst_sep_en, 0);
+	}
 }
 
 static int qcom_pcie_dw_link_up(struct dw_pcie *pci)
@@ -463,8 +465,8 @@ static int qcom_pcie_ep_get_io_resources(struct platform_device *pdev,
 
 	syscon = of_parse_phandle(dev->of_node, "qcom,perst-regs", 0);
 	if (!syscon) {
-		dev_err(dev, "Failed to parse qcom,perst-regs\n");
-		return -EINVAL;
+		dev_dbg(dev, "PERST separation not available\n");
+		return 0;
 	}
 
 	pcie_ep->perst_map = syscon_node_to_regmap(syscon);
-- 
2.25.1

