Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DE2605C60
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 12:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiJTKbi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 06:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiJTKb1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 06:31:27 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328EE106A66
        for <linux-pci@vger.kernel.org>; Thu, 20 Oct 2022 03:31:26 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id bs14so25733591ljb.9
        for <linux-pci@vger.kernel.org>; Thu, 20 Oct 2022 03:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3ybdI1mbUKhPIhIWhpwVRK1EVfp/BMBBib0n1JTkYg=;
        b=qKJZ/aqaVUoN+eA1/H7Gv1dbjF7EcAyisLA+X36yEMrHd6fHylICMbq4j/XRaF3FI9
         B9cO3e0OdopZtGs7V4CPA1GxCOhg1zRd/W3rL/0JI5SJKG4Ku3PcxSGY6mwjzV3j00LQ
         YKTGUlSEJd181TA79vmWsnq/hp9xiE+QgFjUt9kl6NhycxDoKLt4cyNiynlKx5uozFo1
         8JmEY5PJbUWNcTbRTcUSXU/Cs6VX9ixaMGOy25z5GCp5z+C0LSgFbjTHzUKGxyX896s6
         SamNHSvwNDdSq5Me+UHvwwWcDSl58+UcFa9/msNVX6sbAdyzmOaRulwznk4RyMNtgVmC
         Tnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3ybdI1mbUKhPIhIWhpwVRK1EVfp/BMBBib0n1JTkYg=;
        b=sU3/M2zGstVr5dEpqGpjQHB0U+zBvWXfSirg1eBowCxWnAhhn0uRoQpxaKdAbjLdc8
         qX7cYtUz7WcWbNVLeDcIbCsfbelzPRL2BkvTJtqyRg2ccTnbGt0PlJqTVooqnHSOCZ4F
         RAboqVOCZ85fqDgbH9Q2c+oyTYAXS2oxjp2F/yxOvplMehxrrp4t3NDXRx/G6qWVnIvj
         yrW+mpbx7695ytEy/0aXaUNWMBfGAX0FW4vKJiBRJkp9zOqG0ACiLq3hh0rUfOhGsFTM
         2E663ZUt7Ial/H2ds4pxFIFECkJ1Lp0YPLIP4hj4KoDxJuS6u+4ueAHL5qYz8CXaANtQ
         bh4w==
X-Gm-Message-State: ACrzQf2Z6uNCDG04u9gK/cMAZHoQR/tpHx3BqwdKiplpeGCRYAkj90ek
        3e9i6a7e+kBNZAvMv++CVlGsxg==
X-Google-Smtp-Source: AMsMyM7zfTmCRIm5AV40WKJ4TKuVps9l947nbOPKEYUlYJcWh6j0q9WuPz4P5E77rCxlWW70/fljDg==
X-Received: by 2002:a2e:a4cf:0:b0:26e:704:9d7e with SMTP id p15-20020a2ea4cf000000b0026e07049d7emr4478742ljm.284.1666261884311;
        Thu, 20 Oct 2022 03:31:24 -0700 (PDT)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id l2-20020a2e3e02000000b0026be1de1500sm2829019lja.79.2022.10.20.03.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 03:31:23 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/4] PCI: qcom: Use clk_bulk_ API for 2.3.3 clocks handling
Date:   Thu, 20 Oct 2022 13:31:20 +0300
Message-Id: <20221020103120.1541862-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020103120.1541862-1-dmitry.baryshkov@linaro.org>
References: <20221020103120.1541862-1-dmitry.baryshkov@linaro.org>
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

Change hand-coded implementation of bulk clocks to use the existing
clk_bulk_* API.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 90 ++++----------------------
 1 file changed, 12 insertions(+), 78 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index eee4d2179e90..e64e504e531e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -164,11 +164,7 @@ struct qcom_pcie_resources_2_4_0 {
 };
 
 struct qcom_pcie_resources_2_3_3 {
-	struct clk *iface;
-	struct clk *axi_m_clk;
-	struct clk *axi_s_clk;
-	struct clk *ahb_clk;
-	struct clk *aux_clk;
+	struct clk_bulk_data clks[5];
 	struct reset_control *rst[7];
 };
 
@@ -929,29 +925,19 @@ static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
 	int i;
+	int ret;
 	const char *rst_names[] = { "axi_m", "axi_s", "pipe",
 				    "axi_m_sticky", "sticky",
 				    "ahb", "sleep", };
 
-	res->iface = devm_clk_get(dev, "iface");
-	if (IS_ERR(res->iface))
-		return PTR_ERR(res->iface);
-
-	res->axi_m_clk = devm_clk_get(dev, "axi_m");
-	if (IS_ERR(res->axi_m_clk))
-		return PTR_ERR(res->axi_m_clk);
-
-	res->axi_s_clk = devm_clk_get(dev, "axi_s");
-	if (IS_ERR(res->axi_s_clk))
-		return PTR_ERR(res->axi_s_clk);
-
-	res->ahb_clk = devm_clk_get(dev, "ahb");
-	if (IS_ERR(res->ahb_clk))
-		return PTR_ERR(res->ahb_clk);
-
-	res->aux_clk = devm_clk_get(dev, "aux");
-	if (IS_ERR(res->aux_clk))
-		return PTR_ERR(res->aux_clk);
+	res->clks[0].id = "iface";
+	res->clks[1].id = "axi_m";
+	res->clks[2].id = "axi_s";
+	res->clks[3].id = "ahb";
+	res->clks[4].id = "aux";
+	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
+	if (ret < 0)
+		return ret;
 
 	for (i = 0; i < ARRAY_SIZE(rst_names); i++) {
 		res->rst[i] = devm_reset_control_get(dev, rst_names[i]);
@@ -966,11 +952,7 @@ static void qcom_pcie_deinit_2_3_3(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
 
-	clk_disable_unprepare(res->iface);
-	clk_disable_unprepare(res->axi_m_clk);
-	clk_disable_unprepare(res->axi_s_clk);
-	clk_disable_unprepare(res->ahb_clk);
-	clk_disable_unprepare(res->aux_clk);
+	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
 }
 
 static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
@@ -1005,55 +987,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 	 */
 	usleep_range(2000, 2500);
 
-	ret = clk_prepare_enable(res->iface);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable core clock\n");
-		goto err_clk_iface;
-	}
-
-	ret = clk_prepare_enable(res->axi_m_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable core clock\n");
-		goto err_clk_axi_m;
-	}
-
-	ret = clk_prepare_enable(res->axi_s_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable axi slave clock\n");
-		goto err_clk_axi_s;
-	}
-
-	ret = clk_prepare_enable(res->ahb_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable ahb clock\n");
-		goto err_clk_ahb;
-	}
-
-	ret = clk_prepare_enable(res->aux_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable aux clock\n");
-		goto err_clk_aux;
-	}
-
-	return 0;
-
-err_clk_aux:
-	clk_disable_unprepare(res->ahb_clk);
-err_clk_ahb:
-	clk_disable_unprepare(res->axi_s_clk);
-err_clk_axi_s:
-	clk_disable_unprepare(res->axi_m_clk);
-err_clk_axi_m:
-	clk_disable_unprepare(res->iface);
-err_clk_iface:
-	/*
-	 * Not checking for failure, will anyway return
-	 * the original failure in 'ret'.
-	 */
-	for (i = 0; i < ARRAY_SIZE(res->rst); i++)
-		reset_control_assert(res->rst[i]);
-
-	return ret;
+	return clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
 }
 
 static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
-- 
2.35.1

