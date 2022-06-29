Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0F8560237
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 16:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbiF2OMp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 10:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbiF2OMf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 10:12:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0D82EA28;
        Wed, 29 Jun 2022 07:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4AB70CE2742;
        Wed, 29 Jun 2022 14:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2554BC36AF2;
        Wed, 29 Jun 2022 14:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656511949;
        bh=BBR83r4Z8wYISqoy9N8mcRo90majWxT9oz32aYE16B4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gew/QVJJ/o5eGLVzrXqIw7oT9Dk9Rrn/kVBT+qcMXVua0irWxj/utDhGeiXF9OrGG
         saeCu8T87R2lWeXzyt2IKpNsVlPhKTeUo6+dX2hQ+chlmf0vYlEWnSHmuNfLAnWOZI
         4AgopHSEcpuijvC0BBDpJMDnBD43nNgoDJrP88sBmqwggq1uWeKHAW6P8f6HybXSsD
         F8TrxmaC/FcIJCPYqo9VNMA2UJldNkxWMr909qFHGgEtWFWewGT8Xi1W70nKee/RiE
         faq5hSuy+YLOfErfQOolgJOVM4EG9NqTHMUgdBMxZHa4tktzwh1DDmUHMJTfqUu/JX
         oZgTsyLZw3VFQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o6YQf-0004lS-0X; Wed, 29 Jun 2022 16:12:29 +0200
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
Subject: [PATCH 08/10] PCI: qcom: Make all optional clocks optional
Date:   Wed, 29 Jun 2022 16:09:58 +0200
Message-Id: <20220629141000.18111-9-johan+linaro@kernel.org>
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

The kernel is not a devicetree validator and does not need to re-encode
information which is already available in the devicetree.

This is specifically true for the optional PCIe clocks, some of which
are really interconnect clocks.

Treat also the 2.7.0 optional clocks as truly optional instead of
maintaining a list of clocks per compatible (including two compatible
strings for the two identical controllers on sm8450) just to validate
the devicetree.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 28 ++++----------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 8ab88e5743da..1a564f624bb1 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -189,10 +189,6 @@ struct qcom_pcie_ops {
 
 struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
-	unsigned int has_tbu_clk:1;
-	unsigned int has_ddrss_sf_tbu_clk:1;
-	unsigned int has_aggre0_clk:1;
-	unsigned int has_aggre1_clk:1;
 };
 
 struct qcom_pcie {
@@ -1140,14 +1136,6 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
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
 
@@ -1155,6 +1143,10 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	if (ret < 0)
 		return ret;
 
+	res->clks[idx++].id = "tbu";
+	res->clks[idx++].id = "ddrss_sf_tbu";
+	res->clks[idx++].id = "aggre0";
+	res->clks[idx++].id = "aggre1";
 	res->clks[idx++].id = "noc_aggr_4";
 	res->clks[idx++].id = "noc_aggr_south_sf";
 	res->clks[idx++].id = "cnoc_qx";
@@ -1463,17 +1455,14 @@ static const struct qcom_pcie_cfg ipq4019_cfg = {
 
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
@@ -1485,31 +1474,22 @@ static const struct qcom_pcie_cfg sm8150_cfg = {
 
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
 
 static const struct dw_pcie_ops dw_pcie_ops = {
-- 
2.35.1

