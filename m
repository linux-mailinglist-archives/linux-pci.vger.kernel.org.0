Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE36A479B32
	for <lists+linux-pci@lfdr.de>; Sat, 18 Dec 2021 15:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbhLROKe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Dec 2021 09:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbhLROKe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Dec 2021 09:10:34 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC965C06173E
        for <linux-pci@vger.kernel.org>; Sat, 18 Dec 2021 06:10:33 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id u22so7891297lju.7
        for <linux-pci@vger.kernel.org>; Sat, 18 Dec 2021 06:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rvSwVuO78Cx/9LClJZNQ6JHCIIDtS0AVpejNJ+1isaE=;
        b=PM0SiMqUQlgV9hEXRVXzXNXJVx7Arb05j6wzgqJigJsZHqWj1w9hekVRnG0dNZdaCH
         HSE4CnXXQ+Ezd/NzaZqVbCP5ILXg4BuZsFQxuGq34ZIoiLO159tOc2VIlAzdyPnx4kGF
         m1ppL9+fjL5AbGoN96WacWsIJfYWeUBPUjxkPBApJyX/NDxDuu5rugX4N3oGs7eTH5RJ
         GZqsoWqQ9OZLW5t2QhMmPgz8/5G1ejSqWOUFi76ClZVCyEI2oWj/K/+C4Rd2A1t5b+uC
         m6parSe0lvu6eC5Kbiy/GCJM/CHP+/80v4J070BaXYO6HBVNVLddnjZTQZxqU8hkMPb+
         0deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rvSwVuO78Cx/9LClJZNQ6JHCIIDtS0AVpejNJ+1isaE=;
        b=mftQvLq+UqO6PW3r4hv0v/HzYkuLvlf3DCpAQjOY3VVOQDH4eT4alOcamCzTr/sy9m
         n9+lCHzPyD0AZzqHq0HgN5GVH4rgdHU0m6BM5a0uX/LM9GTFmVeCYGdPvmQYdC3LYKa4
         kRzA/gHHeq7BPmpMK68/7+teH6eqVBiPTRGCAYUzAyXqV0R/5ZOjkpFaPMxhzChAPKC0
         LMaiqHO+KUi+8jpIkcPHxtt/Ok4AgIYct45A5pr6CdLXRI47qQaxux+D2u5E172KUZg9
         x9tZhkkzkDa2tX5jVbLNWZKOtxW4DVBbDaqdBtbCuFV8XrDG/su3Gkd393D/5qvXPz4+
         Y7nw==
X-Gm-Message-State: AOAM533CzIHChmCUQvo4EvwzU9o5oqzD+W2AwRYoQp5UuKrhWrEFN1Cj
        ID5j68NXScsD1qYSrWB73zKhdg==
X-Google-Smtp-Source: ABdhPJztfeez48yZNh3f3oxMUO4c2emdc96OCZ+twoDOHq+s2jLnkLwaOeRzZYHxZ2zDknQwmDvvnQ==
X-Received: by 2002:a2e:7807:: with SMTP id t7mr6623958ljc.426.1639836632239;
        Sat, 18 Dec 2021 06:10:32 -0800 (PST)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id c2sm145789lfh.189.2021.12.18.06.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 06:10:31 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v5 2/5] PCI: qcom: Remove redundancy between qcom_pcie and qcom_pcie_cfg
Date:   Sat, 18 Dec 2021 17:10:21 +0300
Message-Id: <20211218141024.500952-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211218141024.500952-1-dmitry.baryshkov@linaro.org>
References: <20211218141024.500952-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation to adding more flags to configuration data, use pointer
to struct qcom_pcie_cfg directly inside struct qcom_pcie, rather than
duplicating all its fields. This would save us from the boilerplate code
that just copies flag values from one struct to another one.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 31 +++++++++++---------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 4e668da96ef4..1204011c96ee 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -200,8 +200,7 @@ struct qcom_pcie {
 	union qcom_pcie_resources res;
 	struct phy *phy;
 	struct gpio_desc *reset;
-	const struct qcom_pcie_ops *ops;
-	unsigned int pipe_clk_need_muxing:1;
+	const struct qcom_pcie_cfg *cfg;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -225,8 +224,8 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
 	/* Enable Link Training state machine */
-	if (pcie->ops->ltssm_enable)
-		pcie->ops->ltssm_enable(pcie);
+	if (pcie->cfg->ops->ltssm_enable)
+		pcie->cfg->ops->ltssm_enable(pcie);
 
 	return 0;
 }
@@ -1145,7 +1144,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	if (ret < 0)
 		return ret;
 
-	if (pcie->pipe_clk_need_muxing) {
+	if (pcie->cfg->pipe_clk_need_muxing) {
 		res->pipe_clk_src = devm_clk_get(dev, "pipe_mux");
 		if (IS_ERR(res->pipe_clk_src))
 			return PTR_ERR(res->pipe_clk_src);
@@ -1180,7 +1179,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	}
 
 	/* Set pipe clock as clock source for pcie_pipe_clk_src */
-	if (pcie->pipe_clk_need_muxing)
+	if (pcie->cfg->pipe_clk_need_muxing)
 		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
 
 	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
@@ -1243,7 +1242,7 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 
 	/* Set TCXO as clock source for pcie_pipe_clk_src */
-	if (pcie->pipe_clk_need_muxing)
+	if (pcie->cfg->pipe_clk_need_muxing)
 		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
 
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
@@ -1336,7 +1335,7 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 
 	qcom_ep_reset_assert(pcie);
 
-	ret = pcie->ops->init(pcie);
+	ret = pcie->cfg->ops->init(pcie);
 	if (ret)
 		return ret;
 
@@ -1346,8 +1345,8 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 
 	qcom_ep_reset_deassert(pcie);
 
-	if (pcie->ops->config_sid) {
-		ret = pcie->ops->config_sid(pcie);
+	if (pcie->cfg->ops->config_sid) {
+		ret = pcie->cfg->ops->config_sid(pcie);
 		if (ret)
 			goto err;
 	}
@@ -1358,7 +1357,7 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	qcom_ep_reset_assert(pcie);
 	phy_power_off(pcie->phy);
 err_deinit:
-	pcie->ops->deinit(pcie);
+	pcie->cfg->ops->deinit(pcie);
 
 	return ret;
 }
@@ -1468,7 +1467,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	struct pcie_port *pp;
 	struct dw_pcie *pci;
 	struct qcom_pcie *pcie;
-	const struct qcom_pcie_cfg *pcie_cfg;
 	int ret;
 
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
@@ -1485,15 +1483,12 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pcie->pci = pci;
 
-	pcie_cfg = of_device_get_match_data(dev);
-	if (!pcie_cfg || !pcie_cfg->ops) {
+	pcie->cfg = of_device_get_match_data(dev);
+	if (!pcie->cfg || !pcie->cfg->ops) {
 		dev_err(dev, "Invalid platform data\n");
 		return -EINVAL;
 	}
 
-	pcie->ops = pcie_cfg->ops;
-	pcie->pipe_clk_need_muxing = pcie_cfg->pipe_clk_need_muxing;
-
 	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->reset))
 		return PTR_ERR(pcie->reset);
@@ -1510,7 +1505,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pcie->phy))
 		return PTR_ERR(pcie->phy);
 
-	ret = pcie->ops->get_resources(pcie);
+	ret = pcie->cfg->ops->get_resources(pcie);
 	if (ret)
 		return ret;
 
-- 
2.34.1

