Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A728466525
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 15:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358539AbhLBOVr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 09:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358455AbhLBOV0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 09:21:26 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FB7C0613F6
        for <linux-pci@vger.kernel.org>; Thu,  2 Dec 2021 06:17:37 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id k37so71923314lfv.3
        for <linux-pci@vger.kernel.org>; Thu, 02 Dec 2021 06:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L5vH+qkdW0RnnHR8bUSi4DKQOAjuN8wu7Yp/zMOVh1s=;
        b=NIzojU0X/ljxuVj1vbxH7xSKPgb3mdOQUrz/nRite7KGveqllHiWs/Bb9Z7XEUWZNR
         87FLplz+hPLnTDje7Wdbr0s7wiJcwkmR6ZN5WvHyLc6tKtD0wRA9vQGa5zJdKmoeFGrg
         8BBPVcMC57VYvRgeJPmzMTk8KvZfH0I3XDUF2eSrlZupwML6x5exTflr9ZJ8XKzWV95m
         jiq2BzcIbLXf7WYd54W4VFahDJpSq4xsOjCgDLGrvBlT9E403pb7eAQ8yjBe/H2520I8
         Ejml3phDgez0cGM9OElZT0QfSyKVO75uwXJIzHInxJHYPuHIKyMGEQs1oQKFDKbLEl7m
         xwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L5vH+qkdW0RnnHR8bUSi4DKQOAjuN8wu7Yp/zMOVh1s=;
        b=r+4Q6dOI3A1xllLqMsfBL8ydkX78Rt5VV1FuN+y6SU0V+oaQ+7rz4j7ZBTq2zFjmII
         nw6etW4dxtPeGB/rzs70MvN01x8XI2+voqMYrvHvXTzvI2KJLNWXlTjw5GrRIpV8+wMS
         6S9nMQRT/H4UD8GL88HkxUe0QnIB2UKWioyDm7fS+lVD6eie2kqOFhJ6Mu9FGr3PgkZ0
         yDPLXhF1xmEl8OGwsh5hytlwR0NFtLA+Nj+tfMPbI9UcT+YwfzFgeROQ6ci5BSmSeLVC
         Kv3V8bq4dgvAhZN8vyd9zqWIrKBjP1onmjdnR3srx6YtMahm/24T5OiVXC5oVWuPIaiz
         QKvA==
X-Gm-Message-State: AOAM530V23thaCGN5NhbkPT7L7ycD2BsxdEx3NgzvGI4RLmSJXAS43JM
        OFDg9Ry31nE0/ExQsJr1wzxjnA==
X-Google-Smtp-Source: ABdhPJx+n4sB1Vj7WxsLnv4cwsDX+ECkLjcgtQ8DyCxfzuScPF7JXtQYhCQNxtblxOmvzLyo5hsuEQ==
X-Received: by 2002:a05:6512:32c8:: with SMTP id f8mr12454410lfg.669.1638454655234;
        Thu, 02 Dec 2021 06:17:35 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id m15sm362487lfg.165.2021.12.02.06.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 06:17:34 -0800 (PST)
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
Subject: [PATCH v1 04/10] PCI: qcom: do not duplicate qcom_pcie_cfg fields in qcom_pcie struct
Date:   Thu,  2 Dec 2021 17:17:20 +0300
Message-Id: <20211202141726.1796793-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211202141726.1796793-1-dmitry.baryshkov@linaro.org>
References: <20211202141726.1796793-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation to adding more flags to configuration data, use struct
qcom_pcie_cfg directly inside struct qcom_pcie, rather than duplicating
all its fields. This would save us from the boilerplate code that just
copies flags values from one sruct to another one.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 34 ++++++++++++--------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 3bee901c4df7..64f762cdbc7d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -204,8 +204,7 @@ struct qcom_pcie {
 	union qcom_pcie_resources res;
 	struct phy *phy;
 	struct gpio_desc *reset;
-	const struct qcom_pcie_ops *ops;
-	unsigned int pipe_clk_need_muxing:1;
+	struct qcom_pcie_cfg cfg;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -229,8 +228,8 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
 	/* Enable Link Training state machine */
-	if (pcie->ops->ltssm_enable)
-		pcie->ops->ltssm_enable(pcie);
+	if (pcie->cfg.ops->ltssm_enable)
+		pcie->cfg.ops->ltssm_enable(pcie);
 
 	return 0;
 }
@@ -1176,7 +1175,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	if (ret < 0)
 		return ret;
 
-	if (pcie->pipe_clk_need_muxing) {
+	if (pcie->cfg.pipe_clk_need_muxing) {
 		res->pipe_clk_src = devm_clk_get(dev, "pipe_mux");
 		if (IS_ERR(res->pipe_clk_src))
 			return PTR_ERR(res->pipe_clk_src);
@@ -1209,7 +1208,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	}
 
 	/* Set TCXO as clock source for pcie_pipe_clk_src */
-	if (pcie->pipe_clk_need_muxing)
+	if (pcie->cfg.pipe_clk_need_muxing)
 		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
 
 	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
@@ -1287,7 +1286,7 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 
 	/* Set pipe clock as clock source for pcie_pipe_clk_src */
-	if (pcie->pipe_clk_need_muxing)
+	if (pcie->cfg.pipe_clk_need_muxing)
 		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
 
 	return clk_prepare_enable(res->pipe_clk);
@@ -1387,7 +1386,7 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 
 	qcom_ep_reset_assert(pcie);
 
-	ret = pcie->ops->init(pcie);
+	ret = pcie->cfg.ops->init(pcie);
 	if (ret)
 		return ret;
 
@@ -1395,16 +1394,16 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		goto err_deinit;
 
-	if (pcie->ops->post_init) {
-		ret = pcie->ops->post_init(pcie);
+	if (pcie->cfg.ops->post_init) {
+		ret = pcie->cfg.ops->post_init(pcie);
 		if (ret)
 			goto err_disable_phy;
 	}
 
 	qcom_ep_reset_deassert(pcie);
 
-	if (pcie->ops->config_sid) {
-		ret = pcie->ops->config_sid(pcie);
+	if (pcie->cfg.ops->config_sid) {
+		ret = pcie->cfg.ops->config_sid(pcie);
 		if (ret)
 			goto err;
 	}
@@ -1413,12 +1412,12 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 
 err:
 	qcom_ep_reset_assert(pcie);
-	if (pcie->ops->post_deinit)
-		pcie->ops->post_deinit(pcie);
+	if (pcie->cfg.ops->post_deinit)
+		pcie->cfg.ops->post_deinit(pcie);
 err_disable_phy:
 	phy_power_off(pcie->phy);
 err_deinit:
-	pcie->ops->deinit(pcie);
+	pcie->cfg.ops->deinit(pcie);
 
 	return ret;
 }
@@ -1562,8 +1561,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	pcie->ops = pcie_cfg->ops;
-	pcie->pipe_clk_need_muxing = pcie_cfg->pipe_clk_need_muxing;
+	pcie->cfg = *pcie_cfg;
 
 	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->reset)) {
@@ -1589,7 +1587,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
-	ret = pcie->ops->get_resources(pcie);
+	ret = pcie->cfg.ops->get_resources(pcie);
 	if (ret)
 		goto err_pm_runtime_put;
 
-- 
2.33.0

