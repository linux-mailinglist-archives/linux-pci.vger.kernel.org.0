Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0A6560252
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 16:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbiF2OMl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 10:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbiF2OMf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 10:12:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E322E08E;
        Wed, 29 Jun 2022 07:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F2FF2CE2489;
        Wed, 29 Jun 2022 14:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED2AC341CD;
        Wed, 29 Jun 2022 14:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656511949;
        bh=OKbfDOFsHJpH/aKP85UzWCpP7dM3YaM+DQIPp7aJ2Bs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rV0kcX2ohR6AdRNN4JqBj7nfNLn1pXsSyFXqDheZ2J7Kgy4M/Mz3Iv3N+ArTGq+30
         vFp4qsLmnqNwxzaaTjW+jY6vkZPuSZWSYVTPxLOO0mITk8fPFWP3ODn+4M5eMeTcXr
         STcjrIVoMTpf7cUjCqybKUQZfSEvW1Ks8Wqf2nByZe3nOSpq97ztY0GTzwQczk6+/D
         0sgFSRNSLv0DHj7ZxZq8+JGio49WK+8DfzP9g8Gi6h+cO+jGKKoYXfo7DK56BqL3q5
         SNsQbd8WOhabMbfUHhw7zhXP9i66L/J/su4zrj3dKnyswngKvDhbg2KHBgfx6sssst
         DpVgTMFtUn8xQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o6YQe-0004lI-QN; Wed, 29 Jun 2022 16:12:28 +0200
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
Subject: [PATCH 06/10] PCI: qcom: Add support for SC8280XP
Date:   Wed, 29 Jun 2022 16:09:56 +0200
Message-Id: <20220629141000.18111-7-johan+linaro@kernel.org>
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

The SC8280XP platform has seven PCIe controllers: two used with USB4,
two 4-lane, two 2-lane and one 1-lane.

Add a new "qcom,pcie-sc8280xp" compatible string and reuse the 1.9.0
ops.

Note that the SC8280XP controllers need two or three interconnect
clocks to be enabled. Model these as optional clocks to avoid encoding
devicetree data in the PCIe driver.

Note that the same could be done for the SM8450 interconnect clocks and
possibly also for the TBU clocks.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ff1b40f213c1..da3f1cdc4ba6 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -160,7 +160,7 @@ struct qcom_pcie_resources_2_3_3 {
 
 /* 6 clocks typically, 7 for sm8250 */
 struct qcom_pcie_resources_2_7_0 {
-	struct clk_bulk_data clks[9];
+	struct clk_bulk_data clks[12];
 	int num_clks;
 	struct regulator_bulk_data supplies[2];
 	struct reset_control *pci_reset;
@@ -1119,6 +1119,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
+	unsigned int num_clks, num_opt_clks;
 	unsigned int idx;
 	int ret;
 
@@ -1148,9 +1149,20 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
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
 
@@ -1449,6 +1461,11 @@ static const struct qcom_pcie_cfg ipq4019_cfg = {
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
@@ -1613,6 +1630,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sm8150", .data = &sm8150_cfg },
 	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
 	{ .compatible = "qcom,pcie-sc8180x", .data = &sc8180x_cfg },
+	{ .compatible = "qcom,pcie-sc8280xp", .data = &sc8280xp_cfg },
 	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &sm8450_pcie0_cfg },
 	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &sm8450_pcie1_cfg },
 	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
-- 
2.35.1

