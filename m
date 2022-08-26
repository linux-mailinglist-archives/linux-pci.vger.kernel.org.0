Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43FD5A2E30
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 20:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345025AbiHZSUn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 14:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345043AbiHZSUW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 14:20:22 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474BC4CA01
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 11:20:16 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id i8-20020a17090a65c800b001fd602afda2so2444660pjs.4
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 11:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=LclRCur2+TmOph0Lw8Vjg5+TpaDfY+BX1hQtzMBpEmo=;
        b=T9SGWQTdEyfQAne25oXT8b+Oh3UmqfibJ2wGfwm8wqwa3+VSVykB17damkom56QlS8
         CRG+sFxcy6UAaQLsoOPsw+KZrN3/gR5jLY4QX5VU5CzG3gEwtQNRHomqfMXRXeflTZrD
         uSI1fWygWyZlhs2CKg1WBJ7aczW8ahirbHuhzO0eNKcwVs3ejcKYDJ6c3AKrm8GgTAfl
         YJ/iJS3sB9nVNXQKnwMrld673GdcUVbnTLubohR6/u4IkB/QzjgPbmwD7PSCUhEA3jKT
         IOGzCKMEAeb0YShJp5/hxwllxNwJgDjcx6+lwvZjfsm/e1KF1xjhiME/xYev8IuBKzCe
         dQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=LclRCur2+TmOph0Lw8Vjg5+TpaDfY+BX1hQtzMBpEmo=;
        b=crjw67fQmK2lbs2VcVJKoFCQlPB/BEIkeGTi01WIiNjcD4HNBmf/5eFaxZG5PPQ2X3
         +6h9vqq1n9ZvzB3PVDon5IpMtXCpdMLwWjd24q8IEcXq6Dqw5UL1bjv2i5OJm4FMy8X8
         FnQi9VUmCI2452D9bWcZddUE3c/wYo93IRZikcOKvawQZLHgBg4LMeBg5zUjiju9JUIZ
         geCL7qyudKEWUxRXVWkmmKNpo294iZkmlYulBTje2AjeHRbx2VjFiJzFee9+Q1SHuPh1
         mt6k4rJ+KGVegX0hdZBY/AdlXz8UJX5Pn2bsebeHEkzBGAJhlQ3Fj1pOOX9eZZSewtvC
         R+wA==
X-Gm-Message-State: ACgBeo0C6LU2LiySdWrkQku5Kij2ElFYgTJj1cLQq40NCrIgNB48yI9u
        ndCj/8vB2dkZbwfbrgR5Ku9N
X-Google-Smtp-Source: AA6agR6SnQB/qzAP6m3kTDBVIuSWB5zPeOc62p4Q3RpoUCk8ToKh2VybfB4VrL0KotoyMUHGDwh98w==
X-Received: by 2002:a17:903:d5:b0:173:3307:bcf with SMTP id x21-20020a17090300d500b0017333070bcfmr4811878plc.87.1661538015749;
        Fri, 26 Aug 2022 11:20:15 -0700 (PDT)
Received: from localhost.localdomain ([117.193.214.147])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902b18500b00173368e9dedsm1881868plr.252.2022.08.26.11.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 11:20:15 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 08/11] PCI: qcom-ep: Make PERST separation optional
Date:   Fri, 26 Aug 2022 23:49:20 +0530
Message-Id: <20220826181923.251564-9-manivannan.sadhasivam@linaro.org>
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

