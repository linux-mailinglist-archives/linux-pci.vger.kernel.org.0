Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9CF5745A4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 09:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbiGNHOH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 03:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbiGNHOE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 03:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6980E64F3;
        Thu, 14 Jul 2022 00:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05DD4609FB;
        Thu, 14 Jul 2022 07:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27AFC36AFF;
        Thu, 14 Jul 2022 07:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657782842;
        bh=UN4n64byzoGo9SIEwjWgWCkf0+DuqlfG433IubklONI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OKr5oA3X/etA07qfZWa1hheL1JRBxijW4X3pIuwsJ+q5nkncc4l8i2KXT8t5NN/Gw
         z1GbGAwalnRWVfuR8YNSftWOtbY29ReYp6ei53YXa+r1jzkoEWrH5U4GVSF+tnHOIg
         drs9TQqSlsxK2mu3XtI7FsMelNU3STtrzPOUjOi0q+lCw2gCDnBdixaAJf/ceyBZyo
         Jjvnw/x1Upm/oufdPTP2PUcvoZn4vYF7TL0aX0TWESv9RnZkB4SPxcB54SA7OUwC+Y
         nycnArhyM/tk25s1OlJmCJGuJzsmBqAOsg6+Rv2FMJQ9L256rZJ1+FYcGvfY9BUVrY
         nliEbgg3rthqA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oBt30-0001mL-Jp; Thu, 14 Jul 2022 09:14:06 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 7/8] PCI: qcom: Clean up IP configurations
Date:   Thu, 14 Jul 2022 09:13:47 +0200
Message-Id: <20220714071348.6792-8-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714071348.6792-1-johan+linaro@kernel.org>
References: <20220714071348.6792-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The various IP versions have different configurations that are encoded
in separate sets of operation callbacks. Currently, there is no need for
also maintaining corresponding sets of data parameters, but it is
conceivable that these may again be found useful (e.g. to implement
minor variations of the operation callbacks).

Rename the default configuration structures after the IP version they
apply to so that they can more easily be reused by different SoCs.

Note that SoC specific configurations can be added later if need arises
(e.g. cfg_sc8280xp).

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 89 +++++++++-----------------
 1 file changed, 29 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 1339f05bee65..8dddb72f8647 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1606,66 +1606,35 @@ static const struct qcom_pcie_ops ops_2_9_0 = {
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
 
-static const struct qcom_pcie_cfg apq8084_cfg = {
+static const struct qcom_pcie_cfg cfg_1_0_0 = {
 	.ops = &ops_1_0_0,
 };
 
-static const struct qcom_pcie_cfg ipq8064_cfg = {
+static const struct qcom_pcie_cfg cfg_1_9_0 = {
+	.ops = &ops_1_9_0,
+};
+
+static const struct qcom_pcie_cfg cfg_2_1_0 = {
 	.ops = &ops_2_1_0,
 };
 
-static const struct qcom_pcie_cfg msm8996_cfg = {
+static const struct qcom_pcie_cfg cfg_2_3_2 = {
 	.ops = &ops_2_3_2,
 };
 
-static const struct qcom_pcie_cfg ipq8074_cfg = {
+static const struct qcom_pcie_cfg cfg_2_3_3 = {
 	.ops = &ops_2_3_3,
 };
 
-static const struct qcom_pcie_cfg ipq4019_cfg = {
+static const struct qcom_pcie_cfg cfg_2_4_0 = {
 	.ops = &ops_2_4_0,
 };
 
-static const struct qcom_pcie_cfg sa8540p_cfg = {
-	.ops = &ops_1_9_0,
-};
-
-static const struct qcom_pcie_cfg sc8280xp_cfg = {
-	.ops = &ops_1_9_0,
-};
-
-static const struct qcom_pcie_cfg sdm845_cfg = {
+static const struct qcom_pcie_cfg cfg_2_7_0 = {
 	.ops = &ops_2_7_0,
 };
 
-static const struct qcom_pcie_cfg sm8150_cfg = {
-	/* sm8150 has qcom IP rev 1.5.0. However 1.5.0 ops are same as
-	 * 1.9.0, so reuse the same.
-	 */
-	.ops = &ops_1_9_0,
-};
-
-static const struct qcom_pcie_cfg sm8250_cfg = {
-	.ops = &ops_1_9_0,
-};
-
-static const struct qcom_pcie_cfg sm8450_pcie0_cfg = {
-	.ops = &ops_1_9_0,
-};
-
-static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
-	.ops = &ops_1_9_0,
-};
-
-static const struct qcom_pcie_cfg sc7280_cfg = {
-	.ops = &ops_1_9_0,
-};
-
-static const struct qcom_pcie_cfg sc8180x_cfg = {
-	.ops = &ops_1_9_0,
-};
-
-static const struct qcom_pcie_cfg ipq6018_cfg = {
+static const struct qcom_pcie_cfg cfg_2_9_0 = {
 	.ops = &ops_2_9_0,
 };
 
@@ -1780,24 +1749,24 @@ static int qcom_pcie_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_pcie_match[] = {
-	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
-	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
-	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &ipq8064_cfg },
-	{ .compatible = "qcom,pcie-apq8064", .data = &ipq8064_cfg },
-	{ .compatible = "qcom,pcie-msm8996", .data = &msm8996_cfg },
-	{ .compatible = "qcom,pcie-ipq8074", .data = &ipq8074_cfg },
-	{ .compatible = "qcom,pcie-ipq4019", .data = &ipq4019_cfg },
-	{ .compatible = "qcom,pcie-qcs404", .data = &ipq4019_cfg },
-	{ .compatible = "qcom,pcie-sa8540p", .data = &sa8540p_cfg },
-	{ .compatible = "qcom,pcie-sdm845", .data = &sdm845_cfg },
-	{ .compatible = "qcom,pcie-sm8150", .data = &sm8150_cfg },
-	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
-	{ .compatible = "qcom,pcie-sc8180x", .data = &sc8180x_cfg },
-	{ .compatible = "qcom,pcie-sc8280xp", .data = &sc8280xp_cfg },
-	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &sm8450_pcie0_cfg },
-	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &sm8450_pcie1_cfg },
-	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
-	{ .compatible = "qcom,pcie-ipq6018", .data = &ipq6018_cfg },
+	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
+	{ .compatible = "qcom,pcie-ipq8064", .data = &cfg_2_1_0 },
+	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
+	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
+	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
+	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
+	{ .compatible = "qcom,pcie-ipq4019", .data = &cfg_2_4_0 },
+	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
+	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sdm845", .data = &cfg_2_7_0 },
+	{ .compatible = "qcom,pcie-sm8150", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sm8250", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sc8180x", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sc8280xp", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-ipq6018", .data = &cfg_2_9_0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_pcie_match);
-- 
2.35.1

