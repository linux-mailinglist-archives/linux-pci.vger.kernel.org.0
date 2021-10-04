Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF674217CD
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 21:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbhJDToJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 15:44:09 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38286 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239113AbhJDToA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Oct 2021 15:44:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633376530; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=d5xC/Y7qVaeIithoWkfnK7rPsYX3oYEtL52pGdth/kQ=; b=XiH/gUfMZKyDPRd95d5IEDvsy2o0nJlKx5lxNB3iIT4nei+CH5hO7XvqxEg9wXxAr0ZyQaoZ
 3kMpduTxN32g7huhVnV8FCWTdcVVdkZ3kaXyg/9x7FkrZKG7LpS3EnLm46FRGan20vYgIs8U
 hICNjHSj4xSSfxJASg7WKCdGrsc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 615b5912605ecf100b4961be (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 04 Oct 2021 19:42:10
 GMT
Sender: pmaliset=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 73063C4361C; Mon,  4 Oct 2021 19:42:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from pmaliset-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmaliset)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2FA2AC43618;
        Mon,  4 Oct 2021 19:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 2FA2AC43618
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
Subject: [PATCH v10 5/5] PCI: qcom: Switch pcie_1_pipe_clk_src after PHY init in SC7280
Date:   Tue,  5 Oct 2021 01:11:28 +0530
Message-Id: <1633376488-545-6-git-send-email-pmaliset@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633376488-545-1-git-send-email-pmaliset@codeaurora.org>
References: <1633376488-545-1-git-send-email-pmaliset@codeaurora.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On the SC7280, the clock source for gcc_pcie_1_pipe_clk_src
must be the TCXO while gdsc is enabled. After PHY init successful
clock source should switch to pipe clock for gcc_pcie_1_pipe_clk_src.

Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 152451b..7896a86 100644
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
@@ -1173,6 +1176,20 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
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
@@ -1191,6 +1208,10 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 		return ret;
 	}
 
+	/* Set TCXO as clock source for pcie_pipe_clk_src */
+	if (pcie->pipe_clk_need_muxing)
+		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
+
 	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
 	if (ret < 0)
 		goto err_disable_regulators;
@@ -1262,6 +1283,10 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 
+	/* Set pipe clock as clock source for pcie_pipe_clk_src */
+	if (pcie->pipe_clk_need_muxing)
+		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
+
 	return clk_prepare_enable(res->pipe_clk);
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

