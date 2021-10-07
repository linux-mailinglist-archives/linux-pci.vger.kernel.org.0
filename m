Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2474259E0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 19:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243204AbhJGRvn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 13:51:43 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:12349 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243277AbhJGRve (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Oct 2021 13:51:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633628980; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=wUPARESSRVfxaSHngoFI0iSwtypyXKHpyN/Lf8vlRas=; b=d7hDafI+Dm1YBexoYqrLtn9jQKvm0mgAfFOYRbchUTq26Ikugc8OrGw2hyDrvieYvw0KgXIU
 VKFdTStFDTXs4OJ2FpI1XUJ9tu9l1Wxb5KP8J9ILaEon7scTqfdaHm7zvep3wm2o6c/Nng4k
 3Jf+phNEiLFUAnh7b+IKUo9rihs=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 615f332722fe3a98e5036a45 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 07 Oct 2021 17:49:27
 GMT
Sender: pmaliset=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C6E42C43616; Thu,  7 Oct 2021 17:49:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from pmaliset-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmaliset)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7AC51C4360C;
        Thu,  7 Oct 2021 17:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 7AC51C4360C
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
Subject: [PATCH v12 4/5] PCI: qcom: Add a flag in match data along with ops
Date:   Thu,  7 Oct 2021 23:18:42 +0530
Message-Id: <1633628923-25047-5-git-send-email-pmaliset@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633628923-25047-1-git-send-email-pmaliset@codeaurora.org>
References: <1633628923-25047-1-git-send-email-pmaliset@codeaurora.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pipe_clk_need_muxing flag in match data and configure
If the platform needs to switch pipe_clk_src.

Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 66 ++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 8a7a300..41132dd 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -189,6 +189,10 @@ struct qcom_pcie_ops {
 	int (*config_sid)(struct qcom_pcie *pcie);
 };
 
+struct qcom_pcie_cfg {
+	const struct qcom_pcie_ops *ops;
+};
+
 struct qcom_pcie {
 	struct dw_pcie *pci;
 	void __iomem *parf;			/* DT parf */
@@ -1456,6 +1460,38 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
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
+};
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
@@ -1467,6 +1503,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	struct pcie_port *pp;
 	struct dw_pcie *pci;
 	struct qcom_pcie *pcie;
+	const struct qcom_pcie_cfg *pcie_cfg;
 	int ret;
 
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
@@ -1488,7 +1525,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pcie->pci = pci;
 
-	pcie->ops = of_device_get_match_data(dev);
+	pcie_cfg = of_device_get_match_data(dev);
+	if (!pcie_cfg || !pcie_cfg->ops) {
+		dev_err(dev, "Invalid platform data\n");
+		return NULL;
+	}
+
+	pcie->ops = pcie_cfg->ops;
 
 	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->reset)) {
@@ -1545,16 +1588,17 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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

