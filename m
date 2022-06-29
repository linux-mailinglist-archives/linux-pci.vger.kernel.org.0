Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B75756022E
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 16:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiF2OMj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 10:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbiF2OMb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 10:12:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DB52F00C;
        Wed, 29 Jun 2022 07:12:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72BDD61EF8;
        Wed, 29 Jun 2022 14:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B76C36AEF;
        Wed, 29 Jun 2022 14:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656511949;
        bh=HMlPrE3X5aQIHuAtwXXyjVkMKPqZ5kosdfNVJMYAnVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VzLmsnnbgwfLcx4UK/ZMBQPZ6Reve8fWaDUJoLX0sTn0epFBiTdnHRNWiF9ObbBN4
         IsUY815sVaubHy31IVlGMlzoKAVoB114aaA97cfz16nXNvBmEHSpC7jX0Hrz/lXAlx
         uCHkoX1iaUlKCtokM1myGWytp4Qj2qCxZLxmZRaz2RISUJN8fK1ncFla7QdlPsMnr4
         CRkejkglO0YeUGe0XWWuWLnHLwoTcF/T/Bzgq97mdq6guog0Sf3EfKfijfxm6XSikS
         fJnyl2xvtJJJeaKQNlgcgDCCIL/Ex+CCJxr6mssZfEz6YFElP3gHFCLr0ZWlIM+Yz1
         bQrSXown037Kg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o6YQf-0004lV-3T; Wed, 29 Jun 2022 16:12:29 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 09/10] PCI: qcom: Clean up IP configurations
Date:   Wed, 29 Jun 2022 16:09:59 +0200
Message-Id: <20220629141000.18111-10-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220629141000.18111-1-johan+linaro@kernel.org>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 85 ++++++++------------------
 1 file changed, 27 insertions(+), 58 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 1a564f624bb1..567601679465 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1433,65 +1433,34 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.config_sid = qcom_pcie_config_sid_sm8250,
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
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
@@ -1603,23 +1572,23 @@ static int qcom_pcie_remove(struct platform_device *pdev)
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
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_pcie_match);
-- 
2.35.1

