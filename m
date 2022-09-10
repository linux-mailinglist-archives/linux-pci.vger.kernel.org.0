Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247545B4481
	for <lists+linux-pci@lfdr.de>; Sat, 10 Sep 2022 08:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiIJGbk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Sep 2022 02:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiIJGbi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Sep 2022 02:31:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14CDA032F
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 23:31:26 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id o25so6567941wrf.9
        for <linux-pci@vger.kernel.org>; Fri, 09 Sep 2022 23:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cXVSIoAXy4k6GvjO7JA/nhvOJMAK8QRnMR9+cTCkOGs=;
        b=ECw17KQU5fd1P182eWwe2WjK11ZR/ga5Pqas65xaYuWCZ9T07rSRWRFjWbEMINIvm0
         TJyee5BSulo6Hy1KpbwrAPfXW2lA5K/BlGbHTSCiLBUkA+XsLvXYYl8WNaxnXD+sjEF9
         DkkqknpFFfbTmzSXbH4ILRcnWUt6USF3jtxfrcpihrnyBtdstvWU3xGP0axckbD5BSq0
         2Lk5TV4wqFtYsxlz1PkZWe3VpYZylo8hHHkPkMON66ZNYH0tQIaKiEmjDJSjMtrY3Ly1
         5g21PEY/pHjoRwP47YjDm8u7rhfL0TkIBoOzBEsFvKJZNTnh5oHV8SXsECvrR6QyxV5p
         ELYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cXVSIoAXy4k6GvjO7JA/nhvOJMAK8QRnMR9+cTCkOGs=;
        b=mu0EV4rMYN76m08ZEkdzbg4VrilB3tOjzCGB8LPVDfB+0w5DI8z7F//fvPJOxjWT4R
         W1oWgCSDQAnPEYuv+sKznjk33Oc4VkhGF4G+BZznB4voqH2w/COeZ4jMh+hzgykBkYnV
         dJ9rtz31bVSm+JcTLE2Gr6VYr9h6ooTP/nvXTy/v6i+U7bOGqlh0QmB0p1DMXlDhEpW/
         jiCcehAEGJXSu2YZ5D78FfURUzviOPvkMrOrYaSwqTRrcsG+xdRMw6od4KntVmOlDKWC
         /eZEScUMAP7DOiMLFejXIAyvRYqQRXe6yIfHj+Ty3T7zK+IuuJ+6fldAcHlJKrKY70P+
         ySWg==
X-Gm-Message-State: ACgBeo3GYvsc0saLBQrbiQ1poQadKwQOzJ0/mR01LTPOb793q914Pz/c
        JRXZTxvxaEiAQORqp4PcmRfO
X-Google-Smtp-Source: AA6agR7tCTVJQPQAPDEbga2FXfy0GbulLhHpjso7aUkjxDqxt4YyyF60wLA6SQrZqGxmo+pRxuDaTQ==
X-Received: by 2002:adf:f94a:0:b0:225:7383:d755 with SMTP id q10-20020adff94a000000b002257383d755mr9652723wrr.348.1662791486108;
        Fri, 09 Sep 2022 23:31:26 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.47])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c4f9000b003a5c7a942edsm2828122wmq.28.2022.09.09.23.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 23:31:25 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 03/12] PCI: qcom-ep: Make use of the cached dev pointer
Date:   Sat, 10 Sep 2022 12:00:36 +0530
Message-Id: <20220910063045.16648-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
References: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
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

