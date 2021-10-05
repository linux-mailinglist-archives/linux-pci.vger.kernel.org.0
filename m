Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3967A42303C
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 20:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbhJESpZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 14:45:25 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:60275 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235253AbhJESpY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 14:45:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633459413; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=pNI+4Rnoy3e8T7runJ4/EvS5qSFB9OIMtAZOpyFhevs=; b=Yiv8r5IbIsEQFWCc++YXr9+5I4hj0GN47iLWlD3vx3g83SK3Nvxu5bXFDW87QwcO45t+b3hN
 zL9pJuNY3m0Ul60PJt80LjTXMlB6500SNPSCPaPnHoEN24dwt7ei/pSBQqZvtqGTDRaZ+kjV
 7kHgKIaiMBFk5ZQ8gs8yzUfw2UM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 615c9cce09ab553889492aad (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 05 Oct 2021 18:43:26
 GMT
Sender: pmaliset=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BA1C7C4361A; Tue,  5 Oct 2021 18:43:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from pmaliset-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmaliset)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 68BECC43618;
        Tue,  5 Oct 2021 18:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 68BECC43618
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Prasad Malisetty <pmaliset@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, swboyd@chromium.org, lorenzo.pieralisi@arm.com,
        svarbanov@mm-sol.com
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org, vbadigan@codeaurora.org,
        sallenki@codeaurora.org, manivannan.sadhasivam@linaro.org,
        linux-pci@vger.kernel.org,
        Prasad Malisetty <pmaliset@codeaurora.org>
Subject: [PATCH v11 4/5] PCI: qcom: Add a flag in match data along with ops
Date:   Wed,  6 Oct 2021 00:12:38 +0530
Message-Id: <1633459359-31517-5-git-send-email-pmaliset@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633459359-31517-1-git-send-email-pmaliset@codeaurora.org>
References: <1633459359-31517-1-git-send-email-pmaliset@codeaurora.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pipe_clk_need_muxing flag in match data and configure
If the platform needs to switch pipe_clk_src.

Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 70 ++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 8a7a300..1d7a9cb 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -189,6 +189,11 @@ struct qcom_pcie_ops {
 	int (*config_sid)(struct qcom_pcie *pcie);
 };
 
+struct qcom_pcie_cfg {
+	const struct qcom_pcie_ops *ops;
+	unsigned int pipe_clk_need_muxing:1;
+};
+
 struct qcom_pcie {
 	struct dw_pcie *pci;
 	void __iomem *parf;			/* DT parf */
@@ -197,6 +202,7 @@ struct qcom_pcie {
 	struct phy *phy;
 	struct gpio_desc *reset;
 	const struct qcom_pcie_ops *ops;
+	unsigned int pipe_clk_need_muxing:1;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -1456,6 +1462,39 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.config_sid = qcom_pcie_config_sid_sm8250,
 };
 
+static const struct qcom_pcie_cfg apq8084_cfg = {
+	.ops = &ops_1_0_0,
+};
+
+static const struct qcom_pcie_cfg ipq8064_cfg = {
+	.ops = &ops_2_1_0,
+};
+
+static const struct qcom_pcie_cfg msm8996_cfg = {
+	.ops = &ops_2_3_2,
+};
+
+static const struct qcom_pcie_cfg ipq8074_cfg = {
+	.ops = &ops_2_3_3,
+};
+
+static const struct qcom_pcie_cfg ipq4019_cfg = {
+	.ops = &ops_2_4_0,
+};
+
+static const struct qcom_pcie_cfg sdm845_cfg = {
+	.ops = &ops_2_7_0,
+};
+
+static const struct qcom_pcie_cfg sm8250_cfg = {
+	.ops = &ops_1_9_0,
+};
+
+static const struct qcom_pcie_cfg sc7280_cfg = {
+	.ops = &ops_1_9_0,
+	.pipe_clk_need_muxing = true,
+};
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
@@ -1467,6 +1506,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	struct pcie_port *pp;
 	struct dw_pcie *pci;
 	struct qcom_pcie *pcie;
+	const struct qcom_pcie_cfg *pcie_cfg;
 	int ret;
 
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
@@ -1488,7 +1528,14 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pcie->pci = pci;
 
-	pcie->ops = of_device_get_match_data(dev);
+	pcie_cfg = of_device_get_match_data(dev);
+	if (!pcie_cfg || !pcie_cfg->ops) {
+		dev_err(dev, "Invalid platform data\n");
+		return NULL;
+	}
+
+	pcie->ops = pcie_cfg->ops;
+	pcie->pipe_clk_need_muxing = pcie_cfg->pipe_clk_need_muxing;
 
 	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->reset)) {
@@ -1545,16 +1592,17 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_pcie_match[] = {
-	{ .compatible = "qcom,pcie-apq8084", .data = &ops_1_0_0 },
-	{ .compatible = "qcom,pcie-ipq8064", .data = &ops_2_1_0 },
-	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &ops_2_1_0 },
-	{ .compatible = "qcom,pcie-apq8064", .data = &ops_2_1_0 },
-	{ .compatible = "qcom,pcie-msm8996", .data = &ops_2_3_2 },
-	{ .compatible = "qcom,pcie-ipq8074", .data = &ops_2_3_3 },
-	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
-	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
-	{ .compatible = "qcom,pcie-sdm845", .data = &ops_2_7_0 },
-	{ .compatible = "qcom,pcie-sm8250", .data = &ops_1_9_0 },
+	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
+	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
+	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &ipq8064_cfg },
+	{ .compatible = "qcom,pcie-apq8064", .data = &ipq8064_cfg },
+	{ .compatible = "qcom,pcie-msm8996", .data = &msm8996_cfg },
+	{ .compatible = "qcom,pcie-ipq8074", .data = &ipq8074_cfg },
+	{ .compatible = "qcom,pcie-ipq4019", .data = &ipq4019_cfg },
+	{ .compatible = "qcom,pcie-qcs404", .data = &ipq4019_cfg },
+	{ .compatible = "qcom,pcie-sdm845", .data = &sdm845_cfg },
+	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
+	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
 	{ }
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

