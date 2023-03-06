Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC336AC54C
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 16:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjCFPe0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 10:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjCFPeR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 10:34:17 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173B235249
        for <linux-pci@vger.kernel.org>; Mon,  6 Mar 2023 07:33:32 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id y2so10142538pjg.3
        for <linux-pci@vger.kernel.org>; Mon, 06 Mar 2023 07:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678116808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FO7UUoMk85axnIoB/AfOqhv33JLBE3PRqs5r0gMesdo=;
        b=P/iaONH9ii28ji34Ov7o+sz8hqZo0qBVB/DcbCFzchV0HldizqbhsM4o4CCZSvZi58
         aaFC0q1/Jeb3vwleiVZrokO5kc61uUYo+xD4HGUGt5NHIF6kWPbLmFleEyx8RwMtooOk
         5HuNGffp6z5MzOwmgqGK14Z7VrtXBEVir2CB5yzjh68DtV5u0Fs6PKHfSlc0ldYturNB
         V4l0GSQaNQ3M3/kVgUr03mI1EslpAtXqwekA55jKakxrjq4LYfZcKMvNQCSqtJk/BPh/
         B2zYZe8LaLm+X9UCbRm/FZuQa/3VI/g2fNKq+5mjnThzpBr3CsIYYmz1DVoYJf4g+Nlo
         TTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FO7UUoMk85axnIoB/AfOqhv33JLBE3PRqs5r0gMesdo=;
        b=uLGOQkvzjQsX+sJYDZDX+rbIL4BSAiO/Yht+qdFLUKgSPWfquELo9/d+lRleOLhSxt
         g0HufY8GeIePcRjMUYsZQ3LTkfKUL82jly+aYCBaz7UbLSykNfPTUwhlzlO7ifXt85ub
         eP1ijGGUR2Qk6cImFYMOBm6g/xHVjol8zXZ0TzWuRg3eJrcikVBkwHH+hhF82NKGT9w+
         u2PxoLKiPMfycjQzdS1o1+s0mxzpDmLccmpJR2brs+MaOpwczkOhoL2gaTN2zuM8BTa5
         KCGtwTdfCnEodWp/PV0e59iFu3HdtUgEB12dENpoEYi2XmZQpjDNgLrgL+JKODVkRrk+
         J+GQ==
X-Gm-Message-State: AO0yUKXtqT9QIPr94dhpbJI579zSDYtKhgMuAmrGCaJji7ddJhl+Qj94
        MG2U64kNn9+vsf63o6CWk4fD
X-Google-Smtp-Source: AK7set+GBOA6jEOTRQKRKCvfEOdIIAnNGGUYRA30QBx9olRqh2b1eYjgh4ZpdrQ6tM/YDJMQycA4KQ==
X-Received: by 2002:a17:903:2290:b0:19c:dbce:dce8 with SMTP id b16-20020a170903229000b0019cdbcedce8mr14292386plh.15.1678116807708;
        Mon, 06 Mar 2023 07:33:27 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id kl4-20020a170903074400b0019a7c890c61sm6837430plb.252.2023.03.06.07.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:33:27 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 11/19] PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.4.0
Date:   Mon,  6 Mar 2023 21:02:14 +0530
Message-Id: <20230306153222.157667-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
References: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All the resets are asserted and deasserted at the same time. So the bulk
reset APIs can be used to handle them together. This simplifies the code
a lot.

It should be noted that there were delays in-between the reset asserts and
deasserts. But going by the config used by other revisions, those delays
are not really necessary. So a single delay after all asserts and one after
deasserts is used.

The total number of resets supported is 12 but only ipq4019 is using all of
them.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 238 ++++---------------------
 1 file changed, 30 insertions(+), 208 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 8c39fc554a89..ed43e03b972f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -176,22 +176,13 @@ struct qcom_pcie_resources_2_3_3 {
 	struct reset_control_bulk_data rst[QCOM_PCIE_2_3_3_MAX_RESETS];
 };
 
-#define QCOM_PCIE_2_4_0_MAX_CLOCKS	4
+#define QCOM_PCIE_2_4_0_MAX_CLOCKS		4
+#define QCOM_PCIE_2_4_0_MAX_RESETS		12
 struct qcom_pcie_resources_2_4_0 {
 	struct clk_bulk_data clks[QCOM_PCIE_2_4_0_MAX_CLOCKS];
 	int num_clks;
-	struct reset_control *axi_m_reset;
-	struct reset_control *axi_s_reset;
-	struct reset_control *pipe_reset;
-	struct reset_control *axi_m_vmid_reset;
-	struct reset_control *axi_s_xpu_reset;
-	struct reset_control *parf_reset;
-	struct reset_control *phy_reset;
-	struct reset_control *axi_m_sticky_reset;
-	struct reset_control *pipe_sticky_reset;
-	struct reset_control *pwr_reset;
-	struct reset_control *ahb_reset;
-	struct reset_control *phy_ahb_reset;
+	struct reset_control_bulk_data resets[QCOM_PCIE_2_4_0_MAX_RESETS];
+	int num_resets;
 };
 
 /* 6 clocks typically, 7 for sm8250 */
@@ -626,65 +617,24 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 	if (ret < 0)
 		return ret;
 
-	res->axi_m_reset = devm_reset_control_get_exclusive(dev, "axi_m");
-	if (IS_ERR(res->axi_m_reset))
-		return PTR_ERR(res->axi_m_reset);
-
-	res->axi_s_reset = devm_reset_control_get_exclusive(dev, "axi_s");
-	if (IS_ERR(res->axi_s_reset))
-		return PTR_ERR(res->axi_s_reset);
-
-	if (is_ipq) {
-		/*
-		 * These resources relates to the PHY or are secure clocks, but
-		 * are controlled here for IPQ4019
-		 */
-		res->pipe_reset = devm_reset_control_get_exclusive(dev, "pipe");
-		if (IS_ERR(res->pipe_reset))
-			return PTR_ERR(res->pipe_reset);
-
-		res->axi_m_vmid_reset = devm_reset_control_get_exclusive(dev,
-									 "axi_m_vmid");
-		if (IS_ERR(res->axi_m_vmid_reset))
-			return PTR_ERR(res->axi_m_vmid_reset);
-
-		res->axi_s_xpu_reset = devm_reset_control_get_exclusive(dev,
-									"axi_s_xpu");
-		if (IS_ERR(res->axi_s_xpu_reset))
-			return PTR_ERR(res->axi_s_xpu_reset);
-
-		res->parf_reset = devm_reset_control_get_exclusive(dev, "parf");
-		if (IS_ERR(res->parf_reset))
-			return PTR_ERR(res->parf_reset);
-
-		res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
-		if (IS_ERR(res->phy_reset))
-			return PTR_ERR(res->phy_reset);
-	}
-
-	res->axi_m_sticky_reset = devm_reset_control_get_exclusive(dev,
-								   "axi_m_sticky");
-	if (IS_ERR(res->axi_m_sticky_reset))
-		return PTR_ERR(res->axi_m_sticky_reset);
-
-	res->pipe_sticky_reset = devm_reset_control_get_exclusive(dev,
-								  "pipe_sticky");
-	if (IS_ERR(res->pipe_sticky_reset))
-		return PTR_ERR(res->pipe_sticky_reset);
-
-	res->pwr_reset = devm_reset_control_get_exclusive(dev, "pwr");
-	if (IS_ERR(res->pwr_reset))
-		return PTR_ERR(res->pwr_reset);
-
-	res->ahb_reset = devm_reset_control_get_exclusive(dev, "ahb");
-	if (IS_ERR(res->ahb_reset))
-		return PTR_ERR(res->ahb_reset);
+	res->resets[0].id = "axi_m";
+	res->resets[1].id = "axi_s";
+	res->resets[2].id = "axi_m_sticky";
+	res->resets[3].id = "pipe_sticky";
+	res->resets[4].id = "pwr";
+	res->resets[5].id = "ahb";
+	res->resets[6].id = "pipe";
+	res->resets[7].id = "axi_m_vmid";
+	res->resets[8].id = "axi_s_xpu";
+	res->resets[9].id = "parf";
+	res->resets[10].id = "phy";
+	res->resets[11].id = "phy_ahb";
+
+	res->num_resets = is_ipq ? 12 : 6;
 
-	if (is_ipq) {
-		res->phy_ahb_reset = devm_reset_control_get_exclusive(dev, "phy_ahb");
-		if (IS_ERR(res->phy_ahb_reset))
-			return PTR_ERR(res->phy_ahb_reset);
-	}
+	ret = devm_reset_control_bulk_get_exclusive(dev, res->num_resets, res->resets);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
@@ -693,15 +643,7 @@ static void qcom_pcie_deinit_2_4_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
 
-	reset_control_assert(res->axi_m_reset);
-	reset_control_assert(res->axi_s_reset);
-	reset_control_assert(res->pipe_reset);
-	reset_control_assert(res->pipe_sticky_reset);
-	reset_control_assert(res->phy_reset);
-	reset_control_assert(res->phy_ahb_reset);
-	reset_control_assert(res->axi_m_sticky_reset);
-	reset_control_assert(res->pwr_reset);
-	reset_control_assert(res->ahb_reset);
+	reset_control_bulk_assert(res->num_resets, res->resets);
 	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 }
 
@@ -712,149 +654,29 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
 	struct device *dev = pci->dev;
 	int ret;
 
-	ret = reset_control_assert(res->axi_m_reset);
-	if (ret) {
-		dev_err(dev, "cannot assert axi master reset\n");
-		return ret;
-	}
-
-	ret = reset_control_assert(res->axi_s_reset);
-	if (ret) {
-		dev_err(dev, "cannot assert axi slave reset\n");
-		return ret;
-	}
-
-	usleep_range(10000, 12000);
-
-	ret = reset_control_assert(res->pipe_reset);
-	if (ret) {
-		dev_err(dev, "cannot assert pipe reset\n");
-		return ret;
-	}
-
-	ret = reset_control_assert(res->pipe_sticky_reset);
-	if (ret) {
-		dev_err(dev, "cannot assert pipe sticky reset\n");
-		return ret;
-	}
-
-	ret = reset_control_assert(res->phy_reset);
-	if (ret) {
-		dev_err(dev, "cannot assert phy reset\n");
-		return ret;
-	}
-
-	ret = reset_control_assert(res->phy_ahb_reset);
-	if (ret) {
-		dev_err(dev, "cannot assert phy ahb reset\n");
+	ret = reset_control_bulk_assert(res->num_resets, res->resets);
+	if (ret < 0) {
+		dev_err(dev, "cannot assert resets\n");
 		return ret;
 	}
 
 	usleep_range(10000, 12000);
 
-	ret = reset_control_assert(res->axi_m_sticky_reset);
-	if (ret) {
-		dev_err(dev, "cannot assert axi master sticky reset\n");
-		return ret;
-	}
-
-	ret = reset_control_assert(res->pwr_reset);
-	if (ret) {
-		dev_err(dev, "cannot assert power reset\n");
-		return ret;
-	}
-
-	ret = reset_control_assert(res->ahb_reset);
-	if (ret) {
-		dev_err(dev, "cannot assert ahb reset\n");
+	ret = reset_control_bulk_deassert(res->num_resets, res->resets);
+	if (ret < 0) {
+		dev_err(dev, "cannot deassert resets\n");
 		return ret;
 	}
 
 	usleep_range(10000, 12000);
 
-	ret = reset_control_deassert(res->phy_ahb_reset);
+	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
 	if (ret) {
-		dev_err(dev, "cannot deassert phy ahb reset\n");
+		reset_control_bulk_assert(res->num_resets, res->resets);
 		return ret;
 	}
 
-	ret = reset_control_deassert(res->phy_reset);
-	if (ret) {
-		dev_err(dev, "cannot deassert phy reset\n");
-		goto err_rst_phy;
-	}
-
-	ret = reset_control_deassert(res->pipe_reset);
-	if (ret) {
-		dev_err(dev, "cannot deassert pipe reset\n");
-		goto err_rst_pipe;
-	}
-
-	ret = reset_control_deassert(res->pipe_sticky_reset);
-	if (ret) {
-		dev_err(dev, "cannot deassert pipe sticky reset\n");
-		goto err_rst_pipe_sticky;
-	}
-
-	usleep_range(10000, 12000);
-
-	ret = reset_control_deassert(res->axi_m_reset);
-	if (ret) {
-		dev_err(dev, "cannot deassert axi master reset\n");
-		goto err_rst_axi_m;
-	}
-
-	ret = reset_control_deassert(res->axi_m_sticky_reset);
-	if (ret) {
-		dev_err(dev, "cannot deassert axi master sticky reset\n");
-		goto err_rst_axi_m_sticky;
-	}
-
-	ret = reset_control_deassert(res->axi_s_reset);
-	if (ret) {
-		dev_err(dev, "cannot deassert axi slave reset\n");
-		goto err_rst_axi_s;
-	}
-
-	ret = reset_control_deassert(res->pwr_reset);
-	if (ret) {
-		dev_err(dev, "cannot deassert power reset\n");
-		goto err_rst_pwr;
-	}
-
-	ret = reset_control_deassert(res->ahb_reset);
-	if (ret) {
-		dev_err(dev, "cannot deassert ahb reset\n");
-		goto err_rst_ahb;
-	}
-
-	usleep_range(10000, 12000);
-
-	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
-	if (ret)
-		goto err_clks;
-
 	return 0;
-
-err_clks:
-	reset_control_assert(res->ahb_reset);
-err_rst_ahb:
-	reset_control_assert(res->pwr_reset);
-err_rst_pwr:
-	reset_control_assert(res->axi_s_reset);
-err_rst_axi_s:
-	reset_control_assert(res->axi_m_sticky_reset);
-err_rst_axi_m_sticky:
-	reset_control_assert(res->axi_m_reset);
-err_rst_axi_m:
-	reset_control_assert(res->pipe_sticky_reset);
-err_rst_pipe_sticky:
-	reset_control_assert(res->pipe_reset);
-err_rst_pipe:
-	reset_control_assert(res->phy_reset);
-err_rst_phy:
-	reset_control_assert(res->phy_ahb_reset);
-	return ret;
 }
 
 static int qcom_pcie_post_init_2_4_0(struct qcom_pcie *pcie)
-- 
2.25.1

