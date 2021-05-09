Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1B03774BF
	for <lists+linux-pci@lfdr.de>; Sun,  9 May 2021 02:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhEIAm6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 May 2021 20:42:58 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:33718 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhEIAm6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 May 2021 20:42:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620520916; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=SD9OLK+Xie/V3bYXwDC9AsFVonphv9bIA6gkq44pVpU=; b=GCvcyI0QYnxQuXs+TFikY7dV+dM9WT6dQNEqPzB/QvfdObTQDWePoRzzWvwRr2CbK9t0U4rD
 WKkFa9WYUfc1K1KHkVQoWl06Wtxoo3AEn+sA/eYIlAwYck8fLPUpydx5qO1Mee3WBOPFm+o5
 FjxkuotmTCbV9LVaBP74PeFF8+M=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60972faefebcffa80f04bdc9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 09 May 2021 00:41:18
 GMT
Sender: pmaliset=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A209EC433D3; Sun,  9 May 2021 00:41:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from pmaliset-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmaliset)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 71B17C4338A;
        Sun,  9 May 2021 00:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 71B17C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pmaliset@codeaurora.org
From:   Prasad Malisetty <pmaliset@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mgautam@codeaurora.org, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, Prasad Malisetty <pmaliset@codeaurora.org>
Subject: [PATCH] PCIe: qcom: Add support to control pipe clk mux
Date:   Sun,  9 May 2021 06:11:00 +0530
Message-Id: <1620520860-8589-1-git-send-email-pmaliset@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe driver needs to toggle between bi_tcxo and phy pipe
clock as part of its LPM sequence. This is done by setting
pipe_clk/ref_clk_src as parent of pipe_clk_src after phy init

Dependent on below change:

	https://lore.kernel.org/patchwork/patch/1422499/

Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 8a7a300..a9f69e8 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/crc8.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
@@ -166,6 +167,9 @@ struct qcom_pcie_resources_2_7_0 {
 	struct regulator_bulk_data supplies[2];
 	struct reset_control *pci_reset;
 	struct clk *pipe_clk;
+	struct clk *pipe_clk_src;
+	struct clk *pipe_ext_src;
+	struct clk *ref_clk_src;
 };
 
 union qcom_pcie_resources {
@@ -1168,7 +1172,19 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 		return ret;
 
 	res->pipe_clk = devm_clk_get(dev, "pipe");
-	return PTR_ERR_OR_ZERO(res->pipe_clk);
+	if (IS_ERR(res->pipe_clk))
+		return PTR_ERR(res->pipe_clk);
+
+	res->pipe_clk_src = devm_clk_get(dev, "pipe_src");
+	if (IS_ERR(res->pipe_clk_src))
+		return PTR_ERR(res->pipe_clk_src);
+
+	res->pipe_ext_src = devm_clk_get(dev, "pipe_ext");
+	if (IS_ERR(res->pipe_ext_src))
+		return PTR_ERR(res->pipe_ext_src);
+
+	res->ref_clk_src = devm_clk_get(dev, "ref");
+	return PTR_ERR_OR_ZERO(res->ref_clk_src);
 }
 
 static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
@@ -1255,6 +1271,11 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+
+	if (of_device_is_compatible(dev->of_node, "qcom,pcie-sc7280"))
+		clk_set_parent(res->pipe_clk_src, res->pipe_ext_src);
 
 	return clk_prepare_enable(res->pipe_clk);
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

