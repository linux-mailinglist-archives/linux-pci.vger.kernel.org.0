Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D046BA82E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 07:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjCOGoi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 02:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjCOGo3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 02:44:29 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5484334C07
        for <linux-pci@vger.kernel.org>; Tue, 14 Mar 2023 23:43:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id h8so18998509plf.10
        for <linux-pci@vger.kernel.org>; Tue, 14 Mar 2023 23:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678862631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfdqQH4sC3T3WUlStmaUXFOPF8SZ60hxKnyQr7AYExQ=;
        b=MH6D/0kMHME6L2uOyjVrbZdpw2gmWdPo+aKN82pF3e/k2/DbBL1s0+8Bk0hxQePHxn
         HzTveqImVu8eRda0Z7WADg5sg67FvoONnxXcVZnGdtE90GeDDEDwmUoKYMnpdZufR1RB
         eNEzEi4/YcLZf7IL+2utlcnMvkTzfLwJ6UTWazjJxrJQjoMGnHt0mv/7+Kk8X51RCg53
         PWms8QIKl9SC2JSloeC7sGa36YIXgx1SdyOqMQjYpLmlVGl1zL+vsYqeia/YvuBrh6vX
         eREyUHx4t5JwmNQDFpkq+pFNyIeTGHO42qWBnH0bKy86FDOcbnX4E6l6I0WgTzChCGgr
         PWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678862631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfdqQH4sC3T3WUlStmaUXFOPF8SZ60hxKnyQr7AYExQ=;
        b=d9yOJ8e+YJijxi5yccCtnChyEA7GaLROGLRYWoRBR6vgWD0YNQvPL1Tk1kA7IggJwV
         oYyG0mjyaSlReOp0jAh/F0ydgazgQeDUPry9PFfhPOX47a88zbxPGbIbRE70ckQFSrkU
         LdYOyHeeqtMBvBV+utAmMZl86cQIEaM+PFLEu0Dia6noK9N2oBXNidN/KLk5QFC1hKhX
         T+1UjdiS0pJpDYeK7s464EOk5ONRMutjO5LCEEE3XCt47AlCe9/ms5GOq2Ve8R9P4x0B
         oy/nKShLSOoneVixlhdDoJQvt/cMY2h16pzAoTdzXmS0I5l5B1XPMnmfi8ChkVzqYwxZ
         kivw==
X-Gm-Message-State: AO0yUKVS6g+6BnQi78uGUa7EL7dXzTorTa/9IHGga5DHWagQwIXsDU3/
        xh584ybYLPdZV/FFFvupUGoy
X-Google-Smtp-Source: AK7set/aR1G0P/+BxG8oqjHfYtRegpcG/Ul1lMCwkwJ45C6zLQSyVsIEvRd4oZgdAwl5yiDvBeuOew==
X-Received: by 2002:a17:90b:38c3:b0:237:d44c:5861 with SMTP id nn3-20020a17090b38c300b00237d44c5861mr42100496pjb.12.1678862631632;
        Tue, 14 Mar 2023 23:43:51 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.35])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090a6a8400b002367325203fsm550747pjj.50.2023.03.14.23.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 23:43:50 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 11/18] PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.4.0
Date:   Wed, 15 Mar 2023 12:12:48 +0530
Message-Id: <20230315064255.15591-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315064255.15591-1-manivannan.sadhasivam@linaro.org>
References: <20230315064255.15591-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Tested-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
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

