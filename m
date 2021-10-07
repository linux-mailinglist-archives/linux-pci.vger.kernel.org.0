Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227994259D9
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 19:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243369AbhJGRvi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 13:51:38 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:11434 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243322AbhJGRvc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 13:51:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633628978; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=DNo+8aJm+mKN4zE2SfWWgMVGLr+FPDp7LlJB/DCgNPU=; b=vFV+rW40AK96/Q5LJB80Xzfi3ncXHyQ6lJsoj3JAkGckudwW9zDyTno+6I5KDRYD6PHLtT31
 9jAL5bvMUlHSQTXpFV6pEUwdmm6vHd79IrN2ENyxBeMI/RWctOVZeFjCD3bjuIEVetULjeFn
 3709WESZOW01lqr+LH3N70bETwo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 615f332dff0285fb0af6473d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 07 Oct 2021 17:49:33
 GMT
Sender: pmaliset=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D81A8C4361A; Thu,  7 Oct 2021 17:49:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from pmaliset-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmaliset)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1C946C43617;
        Thu,  7 Oct 2021 17:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 1C946C43617
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
Subject: [PATCH v12 5/5] PCI: qcom: Switch pcie_1_pipe_clk_src after PHY init in SC7280
Date:   Thu,  7 Oct 2021 23:18:43 +0530
Message-Id: <1633628923-25047-6-git-send-email-pmaliset@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633628923-25047-1-git-send-email-pmaliset@codeaurora.org>
References: <1633628923-25047-1-git-send-email-pmaliset@codeaurora.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On the SC7280, the clock source for gcc_pcie_1_pipe_clk_src
must be the TCXO while gdsc is enabled. After PHY init successful
clock source should switch to pipe clock for gcc_pcie_1_pipe_clk_src.

Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 41132dd..ded70e6 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -166,6 +166,9 @@ struct qcom_pcie_resources_2_7_0 {
 	struct regulator_bulk_data supplies[2];
 	struct reset_control *pci_reset;
 	struct clk *pipe_clk;
+	struct clk *pipe_clk_src;
+	struct clk *phy_pipe_clk;
+	struct clk *ref_clk_src;
 };
 
 union qcom_pcie_resources {
@@ -191,6 +194,7 @@ struct qcom_pcie_ops {
 
 struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
+	unsigned int pipe_clk_need_muxing:1;
 };
 
 struct qcom_pcie {
@@ -201,6 +205,7 @@ struct qcom_pcie {
 	struct phy *phy;
 	struct gpio_desc *reset;
 	const struct qcom_pcie_ops *ops;
+	unsigned int pipe_clk_need_muxing:1;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -1171,6 +1176,20 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	if (ret < 0)
 		return ret;
 
+	if (pcie->pipe_clk_need_muxing) {
+		res->pipe_clk_src = devm_clk_get(dev, "pipe_mux");
+		if (IS_ERR(res->pipe_clk_src))
+			return PTR_ERR(res->pipe_clk_src);
+
+		res->phy_pipe_clk = devm_clk_get(dev, "phy_pipe");
+		if (IS_ERR(res->phy_pipe_clk))
+			return PTR_ERR(res->phy_pipe_clk);
+
+		res->ref_clk_src = devm_clk_get(dev, "ref");
+		if (IS_ERR(res->ref_clk_src))
+			return PTR_ERR(res->ref_clk_src);
+	}
+
 	res->pipe_clk = devm_clk_get(dev, "pipe");
 	return PTR_ERR_OR_ZERO(res->pipe_clk);
 }
@@ -1189,6 +1208,10 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 		return ret;
 	}
 
+	/* Set TCXO as clock source for pcie_pipe_clk_src */
+	if (pcie->pipe_clk_need_muxing)
+		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
+
 	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
 	if (ret < 0)
 		goto err_disable_regulators;
@@ -1260,6 +1283,10 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 
+	/* Set pipe clock as clock source for pcie_pipe_clk_src */
+	if (pcie->pipe_clk_need_muxing)
+		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
+
 	return clk_prepare_enable(res->pipe_clk);
 }
 
@@ -1490,6 +1517,7 @@ static const struct qcom_pcie_cfg sm8250_cfg = {
 
 static const struct qcom_pcie_cfg sc7280_cfg = {
 	.ops = &ops_1_9_0,
+	.pipe_clk_need_muxing = true,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
@@ -1532,6 +1560,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	}
 
 	pcie->ops = pcie_cfg->ops;
+	pcie->pipe_clk_need_muxing = pcie_cfg->pipe_clk_need_muxing;
 
 	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->reset)) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

