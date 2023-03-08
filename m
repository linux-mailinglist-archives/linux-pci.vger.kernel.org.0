Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9BE6B0158
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 09:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjCHI1H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 03:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjCHI0p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 03:26:45 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471A2B3E3F
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 00:25:37 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id v11so16947022plz.8
        for <linux-pci@vger.kernel.org>; Wed, 08 Mar 2023 00:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678263934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmQ1DGDCvsim/eUAVVnmehqfX5INB+qOri6n+Xh4b7M=;
        b=ja3pvwxKYsODZWLHJaG2VuZWmNQpfmKYJP163NxY6eZSEtxK9Pc4Bq0jIBeCDGuV1N
         CY+LdyizTnpEyc71oy3N/B0nN+S8NzFYZGtRdJqxM2tMRJRhcBCgUkLMnEhABr8vltUK
         vvE/sQld7z2F4Xa9tX8rREl/yfxv5iuwFDH55VEY/DowuJ78Hb9uW1l/qCQXsM29/wzv
         sY6kzYTDDg7bLhxaAhrK+IeqznVFgpfJ38QiQLj+oz27TLTBTSPWXyVhnUSAu99pxlbb
         77Zw1kFfmY2rrT2zDoaaHjQnh1OW7cf/uXFYxDO6TrJSZNZZdhE/bjhCdEyYjCwZZXY0
         pgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678263934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmQ1DGDCvsim/eUAVVnmehqfX5INB+qOri6n+Xh4b7M=;
        b=hJAoMthSiLCkIPUKjpe5G5C/Whjc4Vu7tDapvDD3rqq2EDm34rrxX7/JobTwoOHOo9
         5DWN+aRbMx8G1ntFNDTqdyQuyih2Ietg3sCM+91vQFaPbdJUa4hnufgMwL381Q+CenAx
         w0iMMKxU3riFzstDn66+bQetJXVwxPhitWdgSzMQOKAT1SqGmyyF2z1knOu/gy8ohVRJ
         sbtsh4O18stZia5+FDo2zKLDjx+qTPx7QOAmPhA8Y+MHWBj5WLaOZ4D3zGZwkqaXLNk+
         i+j+OJndKjZDl2s+0bhMmNdUkwV6S2ZnRthRw8nN5YlYzGzZvayB94X9zqrkOpyrnQ2I
         hJbw==
X-Gm-Message-State: AO0yUKVGEfaF8mWdk1iV3NTXHfRE0JGXZsJgA/HlcvPfUimZvXxQkkP0
        RMurRpWgT6JmdsubklwVtG6i
X-Google-Smtp-Source: AK7set/QaR2G2XDffvu6bwGqGbkv8YMS2BWcFX9/Fcze3BAVHQkdFZbz3JdykduVbrF6ybTn89x5Zg==
X-Received: by 2002:a17:903:2441:b0:19e:85e8:f78d with SMTP id l1-20020a170903244100b0019e85e8f78dmr21386676pls.65.1678263934052;
        Wed, 08 Mar 2023 00:25:34 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b0019aaab3f9d7sm9448086plg.113.2023.03.08.00.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:25:33 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 13/13] PCI: qcom: Add support for SDX55 SoC
Date:   Wed,  8 Mar 2023 13:54:24 +0530
Message-Id: <20230308082424.140224-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230308082424.140224-1-manivannan.sadhasivam@linaro.org>
References: <20230308082424.140224-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for SDX55 SoC reusing the 1.9.0 config. The PCIe controller is
of version 1.10.0 but it is compatible with the 1.9.0 config. This SoC also
requires "sleep" clock which is added as an optional clock in the driver,
since it is not required on other SoCs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index a232b04af048..17dd26cbfd61 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -182,7 +182,7 @@ struct qcom_pcie_resources_2_3_3 {
 
 /* 6 clocks typically, 7 for sm8250 */
 struct qcom_pcie_resources_2_7_0 {
-	struct clk_bulk_data clks[12];
+	struct clk_bulk_data clks[13];
 	int num_clks;
 	struct regulator_bulk_data supplies[2];
 	struct reset_control *pci_reset;
@@ -1208,6 +1208,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	res->clks[idx++].id = "noc_aggr_4";
 	res->clks[idx++].id = "noc_aggr_south_sf";
 	res->clks[idx++].id = "cnoc_qx";
+	res->clks[idx++].id = "sleep";
 
 	num_opt_clks = idx - num_clks;
 	res->num_clks = idx;
@@ -1836,6 +1837,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sc8180x", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sc8280xp", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sdm845", .data = &cfg_2_7_0 },
+	{ .compatible = "qcom,pcie-sdx55", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8150", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8250", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8350", .data = &cfg_1_9_0 },
-- 
2.25.1

