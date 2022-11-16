Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD94662BE3B
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 13:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiKPMhP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 07:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbiKPMgd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 07:36:33 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E853512ACD
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2022 04:35:25 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bs21so29694286wrb.4
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2022 04:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLfqXM0aecnbmY+E3ZVzxJ/EDoMfSm+5ThELQ5HxHP4=;
        b=pMthEtZS40Fw2KGYx4HIJ7zobuI1+Jo4/izynX3Q3i/nVfa/UNU8o9fCm7H3e/7AYI
         HeDIeNGhIDTW0a9ad3iLlSNchai7mZ73pZYwjtLjnPIjKY98gJ2DaCQs7zPnEVGg+3CP
         Hf1gNsAOWVg44SetmGgmNqGn0w+q3+/2Yu9GipQJGbCe6TDRHNLT5TnWkjbNaA0zSscl
         mgxIPRgBrHPeNJRWKRTFkd/6mr6d7lxQDH6bj+K331w6unHFwmJZq8i9oU6f/CC4JOAO
         HZwFvDR+3iEDmxIJs7dPeCoD4te/l8SY0eWuafQum9kuOuEOar1eHh7i6qfS6jXNrewk
         9iqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLfqXM0aecnbmY+E3ZVzxJ/EDoMfSm+5ThELQ5HxHP4=;
        b=SyWAtHbU7WqyICAsjKQ/iP2xA6IloYZBDgh2BftVg9pTobIpSkAs+9gC7zwnVJUl/Z
         l7p+WSCeIyFTbYrYoQ4jerVCQzOh25aSsq4hjPCJc4eXckjfLCQYxkv1VEICWHFVGPYh
         K2LpC4mbV7ki/ZlF0ved/mBc38FtlteHtcvith64gzoqJWQAi3EE9tSzHS82viSGwX9/
         jkT52Qyj3koVmtaHW9o12bwkQlmpVJrl4hJuvDf1dz4q+v1q78R3ILi5Z2Ghik3U9YoU
         GAPthp2k0l2R0BJ3RZtN6JTbibLDqWLjcSQZitKHGVEqk20Kmnx5nUo/Fm6vJKV/hAsD
         UzJQ==
X-Gm-Message-State: ANoB5platcdOPL4lI5S0yYToTlv6PZqxF5ybRXkGJYKE5Xy0uc5L4F2W
        cB9vjNHjRqhen9JqZNFNePgShg==
X-Google-Smtp-Source: AA0mqf5oJxbAAU/ik3JcpETj5oNiAENwEVvXmLMRiqRs2abELvr4/qDRVQOBcrCeGuicgilmPmIAMQ==
X-Received: by 2002:adf:e384:0:b0:230:e4e7:b191 with SMTP id e4-20020adfe384000000b00230e4e7b191mr13125090wrm.158.1668602124513;
        Wed, 16 Nov 2022 04:35:24 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id d20-20020a1c7314000000b003cfcf9f9d62sm1959925wmb.12.2022.11.16.04.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:35:24 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, kw@linux.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 2/2] pci: dwc: pcie-qcom: Add support for SM8550 PCIEs
Date:   Wed, 16 Nov 2022 14:35:05 +0200
Message-Id: <20221116123505.2760397-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116123505.2760397-1-abel.vesa@linaro.org>
References: <20221116123505.2760397-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add compatibles for both PCIe G4 and G3 found on SM8550.
Also add the cnoc_pcie_sf_axi clock needed by the SM8550.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6ac28ea8d67d..4a62b2500c1d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -181,7 +181,7 @@ struct qcom_pcie_resources_2_3_3 {
 
 /* 6 clocks typically, 7 for sm8250 */
 struct qcom_pcie_resources_2_7_0 {
-	struct clk_bulk_data clks[12];
+	struct clk_bulk_data clks[13];
 	int num_clks;
 	struct regulator_bulk_data supplies[2];
 	struct reset_control *pci_reset;
@@ -1206,6 +1206,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	res->clks[idx++].id = "noc_aggr_4";
 	res->clks[idx++].id = "noc_aggr_south_sf";
 	res->clks[idx++].id = "cnoc_qx";
+	res->clks[idx++].id = "cnoc_pcie_sf_axi";
 
 	num_opt_clks = idx - num_clks;
 	res->num_clks = idx;
@@ -1752,6 +1753,8 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sm8250", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sm8550-pcie0", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sm8550-pcie1", .data = &cfg_1_9_0 },
 	{ }
 };
 
-- 
2.34.1

