Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFED55745B6
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 09:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbiGNHPH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 03:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236299AbiGNHOG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 03:14:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5613413E21;
        Thu, 14 Jul 2022 00:14:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC1E0B823BC;
        Thu, 14 Jul 2022 07:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34A6C36AE9;
        Thu, 14 Jul 2022 07:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657782841;
        bh=JDIzHheqsTaQVqKyCV+obh5m4mB7xrXVjNUTn/iv8KI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jX1gkXL6arRCic+LBsCBSugqfXf/GxBE8UY0+aj74R6SIypNhWI+w9foYjD2J6THc
         PN87LzYGxqWyyyTPRVyPYHOIP9Bz/vHXwlIE/wF25q0hlty3W8aD5b9IIGdoQ0BILt
         DKTb0NYYGZthsJt7ukcaLHc/29KuPIFpzYg60hNPClwN8o45cmCKdWq4EI0ETBPDLl
         uzpt9TK+KE/OyU/VAmZuz+xpqtF+OviSOFacrNE9E7Q0Rwnf859CalWM3VY92DP571
         D80tNrzJTIdA0jG9dO8VjH89RtoFRPDCV+liz8LQ2hF1hvfN06G4AVcX+OSK4zwaiC
         BDf2ChwWLM1VQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oBt30-0001mD-Ao; Thu, 14 Jul 2022 09:14:06 +0200
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
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 4/8] PCI: qcom: Add support for SC8280XP
Date:   Thu, 14 Jul 2022 09:13:44 +0200
Message-Id: <20220714071348.6792-5-johan+linaro@kernel.org>
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

The SC8280XP platform has seven PCIe controllers: two used with USB4,
two 4-lane, two 2-lane and one 1-lane.

Add a new "qcom,pcie-sc8280xp" compatible string and reuse the 1.9.0
ops.

Note that the SC8280XP controllers need two or three interconnect
clocks to be enabled. Model these as optional clocks to avoid encoding
devicetree data in the PCIe driver.

Note that the same could be done for the SM8450 interconnect clocks and
possibly also for the TBU clocks.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d176c635016b..7a79bec81bba 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -177,7 +177,7 @@ struct qcom_pcie_resources_2_3_3 {
 
 /* 6 clocks typically, 7 for sm8250 */
 struct qcom_pcie_resources_2_7_0 {
-	struct clk_bulk_data clks[9];
+	struct clk_bulk_data clks[12];
 	int num_clks;
 	struct regulator_bulk_data supplies[2];
 	struct reset_control *pci_reset;
@@ -1172,6 +1172,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
+	unsigned int num_clks, num_opt_clks;
 	unsigned int idx;
 	int ret;
 
@@ -1201,9 +1202,20 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	if (pcie->cfg->has_aggre1_clk)
 		res->clks[idx++].id = "aggre1";
 
+	num_clks = idx;
+
+	ret = devm_clk_bulk_get(dev, num_clks, res->clks);
+	if (ret < 0)
+		return ret;
+
+	res->clks[idx++].id = "noc_aggr_4";
+	res->clks[idx++].id = "noc_aggr_south_sf";
+	res->clks[idx++].id = "cnoc_qx";
+
+	num_opt_clks = idx - num_clks;
 	res->num_clks = idx;
 
-	ret = devm_clk_bulk_get(dev, res->num_clks, res->clks);
+	ret = devm_clk_bulk_get_optional(dev, num_opt_clks, res->clks + num_clks);
 	if (ret < 0)
 		return ret;
 
@@ -1622,6 +1634,11 @@ static const struct qcom_pcie_cfg ipq4019_cfg = {
 	.ops = &ops_2_4_0,
 };
 
+static const struct qcom_pcie_cfg sc8280xp_cfg = {
+	.ops = &ops_1_9_0,
+	.has_ddrss_sf_tbu_clk = true,
+};
+
 static const struct qcom_pcie_cfg sdm845_cfg = {
 	.ops = &ops_2_7_0,
 	.has_tbu_clk = true,
@@ -1790,6 +1807,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sm8150", .data = &sm8150_cfg },
 	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
 	{ .compatible = "qcom,pcie-sc8180x", .data = &sc8180x_cfg },
+	{ .compatible = "qcom,pcie-sc8280xp", .data = &sc8280xp_cfg },
 	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &sm8450_pcie0_cfg },
 	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &sm8450_pcie1_cfg },
 	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
-- 
2.35.1

