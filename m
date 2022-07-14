Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3A05745B8
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 09:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbiGNHPI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 03:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbiGNHOG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 03:14:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DDF13E13;
        Thu, 14 Jul 2022 00:14:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B205EB8239C;
        Thu, 14 Jul 2022 07:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF64CC36AFE;
        Thu, 14 Jul 2022 07:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657782842;
        bh=4uwQ+5Sa8/+mZgYRsFMw8TpJuTjXcHgtiGl4eSjuKn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mx4t05BMJdkRRt+/6apv9dXdTEAub3oRxLybyh/5kr9fKf0FhNUdUF7eVuWBZsfUA
         vXZIzD5yBWedVPqP6NTDCv+ZwuTLTdaAF4aJAPb4L6TCOED3k33q+PeXEoJl5Vwitr
         6Rugl7wO4QZC4iJnjBToLKtKTYdenoB1PJ8koLHlSZvKBUxyaS/iJ2a/a1d0MY7i5h
         rFXLgDSqck+ZL10NW108gRXx6b7FDfhedV+owW5xDlwDngsWD563pQ4J+1b/iHZb4z
         LBoTUvwPzLu0DwsoBabl0BwU+gLPKL2HLH2jK9E25bogEAiB8H31RB+lBacxqdtdbd
         VF9EtLEAAg1lg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oBt30-0001mH-GZ; Thu, 14 Jul 2022 09:14:06 +0200
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
Subject: [PATCH v2 6/8] PCI: qcom: Make all optional clocks optional
Date:   Thu, 14 Jul 2022 09:13:46 +0200
Message-Id: <20220714071348.6792-7-johan+linaro@kernel.org>
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

The kernel is not a devicetree validator and does not need to re-encode
information which is already available in the devicetree.

This is specifically true for the optional PCIe clocks, some of which
are really interconnect clocks.

Treat also the 2.7.0 optional clocks as truly optional instead of
maintaining a list of clocks per compatible (including two compatible
strings for the two identical controllers on sm8450) just to validate
the devicetree.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 28 ++++----------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 699cd8b0f38e..1339f05bee65 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -212,10 +212,6 @@ struct qcom_pcie_ops {
 
 struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
-	unsigned int has_tbu_clk:1;
-	unsigned int has_ddrss_sf_tbu_clk:1;
-	unsigned int has_aggre0_clk:1;
-	unsigned int has_aggre1_clk:1;
 };
 
 struct qcom_pcie {
@@ -1193,14 +1189,6 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	res->clks[idx++].id = "bus_master";
 	res->clks[idx++].id = "bus_slave";
 	res->clks[idx++].id = "slave_q2a";
-	if (pcie->cfg->has_tbu_clk)
-		res->clks[idx++].id = "tbu";
-	if (pcie->cfg->has_ddrss_sf_tbu_clk)
-		res->clks[idx++].id = "ddrss_sf_tbu";
-	if (pcie->cfg->has_aggre0_clk)
-		res->clks[idx++].id = "aggre0";
-	if (pcie->cfg->has_aggre1_clk)
-		res->clks[idx++].id = "aggre1";
 
 	num_clks = idx;
 
@@ -1208,6 +1196,10 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	if (ret < 0)
 		return ret;
 
+	res->clks[idx++].id = "tbu";
+	res->clks[idx++].id = "ddrss_sf_tbu";
+	res->clks[idx++].id = "aggre0";
+	res->clks[idx++].id = "aggre1";
 	res->clks[idx++].id = "noc_aggr_4";
 	res->clks[idx++].id = "noc_aggr_south_sf";
 	res->clks[idx++].id = "cnoc_qx";
@@ -1636,17 +1628,14 @@ static const struct qcom_pcie_cfg ipq4019_cfg = {
 
 static const struct qcom_pcie_cfg sa8540p_cfg = {
 	.ops = &ops_1_9_0,
-	.has_ddrss_sf_tbu_clk = true,
 };
 
 static const struct qcom_pcie_cfg sc8280xp_cfg = {
 	.ops = &ops_1_9_0,
-	.has_ddrss_sf_tbu_clk = true,
 };
 
 static const struct qcom_pcie_cfg sdm845_cfg = {
 	.ops = &ops_2_7_0,
-	.has_tbu_clk = true,
 };
 
 static const struct qcom_pcie_cfg sm8150_cfg = {
@@ -1658,31 +1647,22 @@ static const struct qcom_pcie_cfg sm8150_cfg = {
 
 static const struct qcom_pcie_cfg sm8250_cfg = {
 	.ops = &ops_1_9_0,
-	.has_tbu_clk = true,
-	.has_ddrss_sf_tbu_clk = true,
 };
 
 static const struct qcom_pcie_cfg sm8450_pcie0_cfg = {
 	.ops = &ops_1_9_0,
-	.has_ddrss_sf_tbu_clk = true,
-	.has_aggre0_clk = true,
-	.has_aggre1_clk = true,
 };
 
 static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
 	.ops = &ops_1_9_0,
-	.has_ddrss_sf_tbu_clk = true,
-	.has_aggre1_clk = true,
 };
 
 static const struct qcom_pcie_cfg sc7280_cfg = {
 	.ops = &ops_1_9_0,
-	.has_tbu_clk = true,
 };
 
 static const struct qcom_pcie_cfg sc8180x_cfg = {
 	.ops = &ops_1_9_0,
-	.has_tbu_clk = true,
 };
 
 static const struct qcom_pcie_cfg ipq6018_cfg = {
-- 
2.35.1

