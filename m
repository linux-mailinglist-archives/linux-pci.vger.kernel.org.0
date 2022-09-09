Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E725B3356
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 11:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiIIJOv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 05:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiIIJOr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 05:14:47 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A0DCE1B
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 02:14:45 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id l12so1067928ljg.9
        for <linux-pci@vger.kernel.org>; Fri, 09 Sep 2022 02:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5MyxjEhSqcQYv9oqAAjUG7kWOklie0I2GmKRB8jIEeU=;
        b=fJYTUukRypDeg6Hp0oxgJLj2ZwZGJi7eAzLJWAyo5M2SyhpbAofQcr9qpuhGESurzs
         ujsll6x9ELeV0mJ/z9bnvRQ03rG9v+KG95DbMWRqiWX4nzJLAS2zScSx1lEhwRjbbHUW
         yCo36lQdjM1VkoWECRHA/WBfNN4NqUYpFOGmJB0LqjnfqdLEZdt8Yu4xz4WPaGqYsvnu
         0VTx15WkH2hzvyjeaW19+6ju7AtRimGbXfhXugavEgAZgQR9IxI7fW1cLRG2Le4uNsWW
         DfxjV652kquTDWxXw2aFZODIFqq1xLX1lLUSjYhlbIyXLQVUOAHtLX1Y7XB8BJC8IpO+
         JnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5MyxjEhSqcQYv9oqAAjUG7kWOklie0I2GmKRB8jIEeU=;
        b=wxOnmJbyL/BYZYRBPWRgWf1w76z+d0Y6ZxdgB0M7Z2dWyrDW3AW2wwexkbw1plRXi+
         mLhzOna1CdIKciGY5q98mhXlj4SGrUh5iKQzBMRE3UToeAkbB09YHLhfRkd/GsGPE/WG
         j+cxNK/b4xdrcsDOI7FaGLhQjuGKkQtEt5GJ3CgGgY0P87SRROYDam4kjZJIhBiCi/Dp
         B1kDqhRB/tQt07yvdqegINWJlGtGLykIXQj4gAUO9t8/oCcMhnXL3HVTVeRYFAyr4dLI
         JWrW8e9wARiC/6/J04gDbo81e6DyiWxV3eL4AJN0bTzSyrbNsnfvu8wKsV2bC8mKIJ2u
         ik2A==
X-Gm-Message-State: ACgBeo3p/XzWa38HwgUNXJe+Gw7Mf59eABaOtSqD5ZIrkhSlFqlOsl2L
        uN49s+z/tg3dTk8jfvK12islzA==
X-Google-Smtp-Source: AA6agR6xzToALUoWmSk6vOlrNi+UWb5/PMWZz2w0OYejPJNkD1XLY3D6JlDolP1r0m7jkF5+Aqp1bA==
X-Received: by 2002:a2e:be9e:0:b0:261:b228:ed8b with SMTP id a30-20020a2ebe9e000000b00261b228ed8bmr3635536ljr.226.1662714884653;
        Fri, 09 Sep 2022 02:14:44 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z26-20020a2e4c1a000000b0026acbb6ed1asm201615lja.66.2022.09.09.02.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 02:14:43 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 9/9] PCI: qcom-ep: Setup PHY to work in EP mode
Date:   Fri,  9 Sep 2022 12:14:33 +0300
Message-Id: <20220909091433.3715981-10-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220909091433.3715981-1-dmitry.baryshkov@linaro.org>
References: <20220909091433.3715981-1-dmitry.baryshkov@linaro.org>
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

Call phy_set_mode_ext() to notify the PHY driver that the PHY is being
used in the EP mode.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index ec99116ad05c..e2a1c3c7f599 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -240,6 +240,10 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 	if (ret)
 		goto err_disable_clk;
 
+	ret = phy_set_mode_ext(pcie_ep->phy, PHY_MODE_PCIE, PHY_SUBMODE_PCIE_EP);
+	if (ret)
+		goto err_phy_exit;
+
 	ret = phy_power_on(pcie_ep->phy);
 	if (ret)
 		goto err_phy_exit;
-- 
2.35.1

