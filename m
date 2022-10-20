Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CE9605C5D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 12:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiJTKbd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 06:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiJTKb0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 06:31:26 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BDC10691F
        for <linux-pci@vger.kernel.org>; Thu, 20 Oct 2022 03:31:24 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id o12so24308309lfq.9
        for <linux-pci@vger.kernel.org>; Thu, 20 Oct 2022 03:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5BmTwpjRBMqOjFOAsW0IWwVCfl5QyLsy8zHhQXR3YM=;
        b=v0IV7+00vtmHwXP1s0u1LEplz2dx2rb0YSGSqUyAwib/LqCEDEgITGv9qovXLtqF54
         EXucQE3/rnHoBo9bbKr+PItaZuZMQmTdJXr18kQJZz4Vva9hWCBAAxMJwr4nIgVHtegJ
         vz8Eg7isAC2AuKWiHbnRmyB//TNUPRFVXkVmhNDjjq+0dLAPZ7PmFeTrbTRCh46g2srl
         4vSSKvSuShfsCGJ3xQYXdfozrcQ4l5cOkleeA/2r+ji5xQk4IsM/GkSGpzW2uBIYAIOm
         1ZHh7Xclz8cw2CaX97MahgD9Tq+71iagKLoyhWlYUobZgtSi4b1zKunHizdYKqftdj1M
         59JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5BmTwpjRBMqOjFOAsW0IWwVCfl5QyLsy8zHhQXR3YM=;
        b=6gVts2mLeenWEhHKbreCpyg5d2MelH7TyHZqN+vordXgfZ80PvHE+dQwr0LuNLtpYv
         zBgxm6zN7o7KK/4zxEf0hn6TEJvvzfI1K/ul6eS3FjpxpTz9SlFQ8pAlfxCFZBpgqQnh
         GdTIeZq+N1+ayq21WkHbHMMUpcXhnZR7bLwkx4SEQBcSHtPSN/YeQ2JCnkKdz1W/Fv/9
         59/UalXHzttmJhe86jnEgMXEOBoV6RnfLmJzIiOsJDxbgU9brY3EER1RbeiZcnwM/FeN
         JUMLC0ftyr6/+vWtehn7KR9dziHCX5Cz2z8jb3cVdjuqWNdlIZbdCdGPAOmAPB28ZnbE
         tNkA==
X-Gm-Message-State: ACrzQf0CsqhKVPcndVr8DTfyaFLE4uDkkX83H2K2xcaxt2+hUkv20Vcm
        DXwWTmJl/yWj028DRoZVXiqHUQ==
X-Google-Smtp-Source: AMsMyM6yHpG4iAaYCbgn6F8NWMX4mEnM+cRq8ja/E0ftK7uoyWkOaTDleJVjd5v5A5+kSCStZrmYdg==
X-Received: by 2002:a05:6512:68b:b0:4a2:5304:bde4 with SMTP id t11-20020a056512068b00b004a25304bde4mr4615616lfe.324.1666261882852;
        Thu, 20 Oct 2022 03:31:22 -0700 (PDT)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id l2-20020a2e3e02000000b0026be1de1500sm2829019lja.79.2022.10.20.03.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 03:31:22 -0700 (PDT)
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
Subject: [PATCH 2/4] PCI: qcom: Use clk_bulk_ API for 1.0.0 clocks handling
Date:   Thu, 20 Oct 2022 13:31:18 +0300
Message-Id: <20221020103120.1541862-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020103120.1541862-1-dmitry.baryshkov@linaro.org>
References: <20221020103120.1541862-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change hand-coded implementation of bulk clocks to use the existing
clk_bulk_* API.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 67 ++++++--------------------
 1 file changed, 16 insertions(+), 51 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 939f19241356..74588438db07 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -133,10 +133,7 @@ struct qcom_pcie_resources_2_1_0 {
 };
 
 struct qcom_pcie_resources_1_0_0 {
-	struct clk *iface;
-	struct clk *aux;
-	struct clk *master_bus;
-	struct clk *slave_bus;
+	struct clk_bulk_data clks[4];
 	struct reset_control *core;
 	struct regulator *vdda;
 };
@@ -472,26 +469,20 @@ static int qcom_pcie_get_resources_1_0_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
+	int ret;
 
 	res->vdda = devm_regulator_get(dev, "vdda");
 	if (IS_ERR(res->vdda))
 		return PTR_ERR(res->vdda);
 
-	res->iface = devm_clk_get(dev, "iface");
-	if (IS_ERR(res->iface))
-		return PTR_ERR(res->iface);
-
-	res->aux = devm_clk_get(dev, "aux");
-	if (IS_ERR(res->aux))
-		return PTR_ERR(res->aux);
-
-	res->master_bus = devm_clk_get(dev, "master_bus");
-	if (IS_ERR(res->master_bus))
-		return PTR_ERR(res->master_bus);
+	res->clks[0].id = "aux";
+	res->clks[1].id = "iface";
+	res->clks[2].id = "master_bus";
+	res->clks[3].id = "slave_bus";
 
-	res->slave_bus = devm_clk_get(dev, "slave_bus");
-	if (IS_ERR(res->slave_bus))
-		return PTR_ERR(res->slave_bus);
+	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
+	if (ret < 0)
+		return ret;
 
 	res->core = devm_reset_control_get_exclusive(dev, "core");
 	return PTR_ERR_OR_ZERO(res->core);
@@ -502,10 +493,7 @@ static void qcom_pcie_deinit_1_0_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
 
 	reset_control_assert(res->core);
-	clk_disable_unprepare(res->slave_bus);
-	clk_disable_unprepare(res->master_bus);
-	clk_disable_unprepare(res->iface);
-	clk_disable_unprepare(res->aux);
+	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
 	regulator_disable(res->vdda);
 }
 
@@ -522,45 +510,22 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
 		return ret;
 	}
 
-	ret = clk_prepare_enable(res->aux);
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
 	if (ret) {
-		dev_err(dev, "cannot prepare/enable aux clock\n");
+		dev_err(dev, "cannot prepare/enable clocks\n");
 		goto err_res;
 	}
 
-	ret = clk_prepare_enable(res->iface);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable iface clock\n");
-		goto err_aux;
-	}
-
-	ret = clk_prepare_enable(res->master_bus);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable master_bus clock\n");
-		goto err_iface;
-	}
-
-	ret = clk_prepare_enable(res->slave_bus);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable slave_bus clock\n");
-		goto err_master;
-	}
-
 	ret = regulator_enable(res->vdda);
 	if (ret) {
 		dev_err(dev, "cannot enable vdda regulator\n");
-		goto err_slave;
+		goto err_clocks;
 	}
 
 	return 0;
-err_slave:
-	clk_disable_unprepare(res->slave_bus);
-err_master:
-	clk_disable_unprepare(res->master_bus);
-err_iface:
-	clk_disable_unprepare(res->iface);
-err_aux:
-	clk_disable_unprepare(res->aux);
+
+err_clocks:
+	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
 err_res:
 	reset_control_assert(res->core);
 
-- 
2.35.1

