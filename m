Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FFE5A2E3D
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 20:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344947AbiHZSTy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 14:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344557AbiHZSTx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 14:19:53 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD9013D3D
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 11:19:50 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id m2so2254411pls.4
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 11:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cXVSIoAXy4k6GvjO7JA/nhvOJMAK8QRnMR9+cTCkOGs=;
        b=ulocn9lyYlZ8Z5BhBREmqzLIII00bgmVYDTaYRlZErsDaRssP9hKz8LYXAAo7TWq42
         nhoB+tUB7ngQodY8Ghy1aPup1D9ovGcSt5F26rsCmu04/MSxJZi3ci9Ld8mULOQZ7vbx
         ep3qRU9DV3cxuUjP0cmx1hO4XG04vpLrYHhVAkuGzJ0HXDTO/BSJ3z9YQKEll9hCKtGz
         fztxI5da1vNbeSSVcpgEW7lFlYK9dGnqETzVpgmRlK/z5hmu/kHdE4uHwP5xqdIqWCz2
         EpPjWffgoMfPjDcJmZSBw9ifh8Ww2fypF1ZHdU270eD1lwACYXlFMZ+ip+GEMNje8wLb
         Ib5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cXVSIoAXy4k6GvjO7JA/nhvOJMAK8QRnMR9+cTCkOGs=;
        b=jY0i5qzkqAHljr/wjnWAGf4GMppiLkMEEgsFn5UCzf6kdDrXAjomPZ0Olb9pGnA5Y5
         +ojNDQDnbmz0KQ6KwKKsKv43NG2JdfYs3UeTTPUiU2jJ4xPwIdWGXD5kHlpi2IVhBHUc
         zpJMVVlhQbPgT1ozLjWYLVdz9DsBDa9WsN11NHK3pne5DQ0Azw68/a6clsBD9kqvR+yj
         +KNXLXVbXcQS/T03nt2oUVpGapEsQw62Cb2up8JGoRtG2tvNpa81IsHKa4uBdvt/N5ma
         AL60BTt2ykpng7fJXVtHkUjXT9HCq0+kl2URLjQiB+2Ts+3zJ7x7dgBlHTrXY/12OEaf
         amvQ==
X-Gm-Message-State: ACgBeo2/7kKRq2855nlnnLfp0dOUTeJJJ8+fc1XPbFpPlVGStBNTIZUv
        iMqf1sFdNea7b5yoOJQFqtj7
X-Google-Smtp-Source: AA6agR4kvI2bPAH4c/ATu9os3dN1ZhQKaQ22+2Uj6XB+Gd2aXrv3urLRGG4k8oVGBpstY2Ars9aQVg==
X-Received: by 2002:a17:903:110f:b0:171:3afa:e688 with SMTP id n15-20020a170903110f00b001713afae688mr4758637plh.162.1661537989972;
        Fri, 26 Aug 2022 11:19:49 -0700 (PDT)
Received: from localhost.localdomain ([117.193.214.147])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902b18500b00173368e9dedsm1881868plr.252.2022.08.26.11.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 11:19:49 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 03/11] PCI: qcom-ep: Make use of the cached dev pointer
Date:   Fri, 26 Aug 2022 23:49:15 +0530
Message-Id: <20220826181923.251564-4-manivannan.sadhasivam@linaro.org>
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

In the qcom_pcie_ep_get_resources() function, dev pointer is already
cached in a local variable. So let's make use of it instead of getting
the dev pointer again from pdev struct.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 34c498d581de..1e09eca5b3b2 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -483,7 +483,7 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
 
 	ret = qcom_pcie_ep_get_io_resources(pdev, pcie_ep);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to get io resources %d\n", ret);
+		dev_err(dev, "Failed to get io resources %d\n", ret);
 		return ret;
 	}
 
@@ -505,7 +505,7 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
 	if (IS_ERR(pcie_ep->wake))
 		return PTR_ERR(pcie_ep->wake);
 
-	pcie_ep->phy = devm_phy_optional_get(&pdev->dev, "pciephy");
+	pcie_ep->phy = devm_phy_optional_get(dev, "pciephy");
 	if (IS_ERR(pcie_ep->phy))
 		ret = PTR_ERR(pcie_ep->phy);
 
-- 
2.25.1

