Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6362F9013
	for <lists+linux-pci@lfdr.de>; Sun, 17 Jan 2021 02:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbhAQBcP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jan 2021 20:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbhAQBcM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jan 2021 20:32:12 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E40C0613D3
        for <linux-pci@vger.kernel.org>; Sat, 16 Jan 2021 17:31:21 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id s26so18898884lfc.8
        for <linux-pci@vger.kernel.org>; Sat, 16 Jan 2021 17:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TqPs2Rrxfynaryc0Bxb5YregqUil4E5/ABS7A7T0BQ8=;
        b=KGBEtXkESMkft2WFrHsXWAyTDavpVgH1cEfLREQnwb1BeC/ljj6rk7I4j7hvCgLQOy
         Mvn8KPnxvo/ZY7YX/8Jw46/d83rPeglNMiKLym3TDjlHUkq9ydGmbqt3Kbnf4lf5245I
         DYJse/VrQ8pTec0C1amc18zrMLL/FLmBx4NSbxQ4uzsyRT90pBE/6uoP2kbMN8JlwyN1
         IuLT4M6hsWKru9Orb1ssdX978WYS9AweeZDzovCSgc3ghUeROGVFdRNhavBviXcFEBgf
         tmkMw/Smxm8zbmClrWM2tVIBI/3SJyv9kRFF+EZjK3NklGyaA2V6mhw0NMuhS28F+TUO
         bpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TqPs2Rrxfynaryc0Bxb5YregqUil4E5/ABS7A7T0BQ8=;
        b=Z8xfakcI0vSYdUGtGQ4iOv/JYvFOyv/6ZzFQMqeo8NsneMdGqDmLX4n9uIDQlTEboy
         o67pNcUhGchy8RmDBXmCDBVIQsLu0dWjZ5PnyVjKy6EeBQ6/Hzx24336ocNB53USvAka
         /Gp1K1sjPipb6MWjkX7wkkvulWEDc2HWraqbDRc4s07ThCtz1iyO9XB/0/cn8tc8SuVm
         OzueOYqNoUAZqVmLKXxcVuBIrb6K6dWGVfqVJ8xn1T441LzgbO2Sl+BEi517JRHb8Rlh
         w+d1FqDqhTwurEpuXqqhjeXmNoSt4tfjbSP4y2vywXAD6Ol1S8irD0hQW1EtZzk5E67q
         QJHg==
X-Gm-Message-State: AOAM533/ACgo9xs6o44U08ltWCB4GCfUWIu0qZDLGAS28kRcS0beVDPn
        60Lw7gES8YSO8BAVfyj9UHZVwQ==
X-Google-Smtp-Source: ABdhPJxBy/AxQ1DlYezLG9RQrHb26ETt2mxrHycxSKXf3pnEPS9WJcXast9Tu1QlFdtJgtq7Gt0drA==
X-Received: by 2002:a19:c215:: with SMTP id l21mr8134361lfc.142.1610847079827;
        Sat, 16 Jan 2021 17:31:19 -0800 (PST)
Received: from eriador.lumag.spb.ru ([94.25.228.101])
        by smtp.gmail.com with ESMTPSA id c1sm1286298ljd.117.2021.01.16.17.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 17:31:19 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH v5 2/2] PCI: qcom: add support for ddrss_sf_tbu clock
Date:   Sun, 17 Jan 2021 04:31:14 +0300
Message-Id: <20210117013114.441973-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117013114.441973-1-dmitry.baryshkov@linaro.org>
References: <20210117013114.441973-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On SM8250 additional clock is required for PCIe devices to access NOC.
Update PCIe controller driver to control this clock.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: e1dd639e374a ("PCI: qcom: Add SM8250 SoC support")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index affa2713bf80..ab21aa01c95d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -159,8 +159,10 @@ struct qcom_pcie_resources_2_3_3 {
 	struct reset_control *rst[7];
 };
 
+/* 6 clocks typically, 7 for sm8250 */
 struct qcom_pcie_resources_2_7_0 {
-	struct clk_bulk_data clks[6];
+	struct clk_bulk_data clks[7];
+	int num_clks;
 	struct regulator_bulk_data supplies[2];
 	struct reset_control *pci_reset;
 	struct clk *pipe_clk;
@@ -1152,8 +1154,14 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	res->clks[3].id = "bus_slave";
 	res->clks[4].id = "slave_q2a";
 	res->clks[5].id = "tbu";
+	if (of_device_is_compatible(dev->of_node, "qcom,pcie-sm8250")) {
+		res->clks[6].id = "ddrss_sf_tbu";
+		res->num_clks = 7;
+	} else {
+		res->num_clks = 6;
+	}
 
-	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
+	ret = devm_clk_bulk_get(dev, res->num_clks, res->clks);
 	if (ret < 0)
 		return ret;
 
@@ -1175,7 +1183,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 		return ret;
 	}
 
-	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
+	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
 	if (ret < 0)
 		goto err_disable_regulators;
 
@@ -1227,7 +1235,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 
 	return 0;
 err_disable_clocks:
-	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
+	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 err_disable_regulators:
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 
@@ -1238,7 +1246,7 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
+	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 }
 
-- 
2.29.2

