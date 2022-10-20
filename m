Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB89605C5E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 12:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiJTKbh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 06:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiJTKb1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 06:31:27 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918C8106A5D
        for <linux-pci@vger.kernel.org>; Thu, 20 Oct 2022 03:31:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id b2so32789464lfp.6
        for <linux-pci@vger.kernel.org>; Thu, 20 Oct 2022 03:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xS4NbLd3+w4J4i/Fj/rcqtMb9R3cTfUxG+88rJJXULg=;
        b=BbZVDj4rwemrkH59vmOd3N2168GbgNyo0PqHrLS9n4dTqxFyaJSSrcLveOYx/XoLuT
         Ww8F/AGg6hdgxRc58XcfZiRcUY6rWZ1clOGzpwoNK2TTWzRtR7sVC64rQGVme5S//Atf
         uwcuT3oJrsGhJqg8qhlVXSKopnW73s5sNh8bUAK+XbzNYFnDTjpGKnifAAcKwxl0h5Yf
         hXuAirux+6vXbc9yc6ArKoos7M0HVxcAjfv+ufV6OjRHd57BUnSExh2iOxd/YopZrDAe
         3JP8uU5oOGIUVVZdJ0Yl64n2WwjU26Ou8EHw9fACABhxpe3iy475pt397hvPtKWMXVMN
         3YlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xS4NbLd3+w4J4i/Fj/rcqtMb9R3cTfUxG+88rJJXULg=;
        b=gqgdn6zm3RKrJdRHA2ElgA0AA4zMKDrDM/XZevnVpgElEd6awexab1ctKemRPuhNbb
         vy3O4YjOHuNJcVTWjgCwjw0pthJFtcxDHaiAE7yvCZnRHpm+9UZAwQqBC2zIKCBWW8mv
         WOVpb+6M3SfV/RRq/K2VckxQJlrUZkaUB2vh8W50v7EWJyNwkOvVotriYZytW9a4Mqwd
         I3wBvO7rKKBD1C79s4/ne7RJ1xlhQBrutp0X+lRulZ3n78mLoUintnEk82ZR/X27msMf
         +VEvFiJ2nf7gbWGlLVZ/HnPBn/1ffFKiWfYUGq/JdXW+R4nOCosaYxY1kL2GEbovg4a2
         LY7g==
X-Gm-Message-State: ACrzQf3h69wimtu5X57ZVfjmv6XNm15tgWOLO/mkXW10eadEhKRfI7ru
        9y5UObyT9AxUkwPNtr+S6nIcbg==
X-Google-Smtp-Source: AMsMyM7N94CTLz10yodk36hz7Lg5rKd/lZbA7U1ZhnIJ4zIeSLdJh7b5IfNXwDtUiXRHl8gCKhFM+A==
X-Received: by 2002:ac2:4882:0:b0:4a2:2da0:391d with SMTP id x2-20020ac24882000000b004a22da0391dmr4686885lfc.160.1666261883641;
        Thu, 20 Oct 2022 03:31:23 -0700 (PDT)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id l2-20020a2e3e02000000b0026be1de1500sm2829019lja.79.2022.10.20.03.31.22
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
Subject: [PATCH 3/4] PCI: qcom: Use clk_bulk_ API for 2.3.2 clocks handling
Date:   Thu, 20 Oct 2022 13:31:19 +0300
Message-Id: <20221020103120.1541862-4-dmitry.baryshkov@linaro.org>
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
 drivers/pci/controller/dwc/pcie-qcom.c | 68 ++++++--------------------
 1 file changed, 15 insertions(+), 53 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 74588438db07..eee4d2179e90 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -139,11 +139,9 @@ struct qcom_pcie_resources_1_0_0 {
 };
 
 #define QCOM_PCIE_2_3_2_MAX_SUPPLY	2
+#define QCOM_PCIE_2_3_2_MAX_CLOCKS	4
 struct qcom_pcie_resources_2_3_2 {
-	struct clk *aux_clk;
-	struct clk *master_clk;
-	struct clk *slave_clk;
-	struct clk *cfg_clk;
+	struct clk_bulk_data clks[QCOM_PCIE_2_3_2_MAX_CLOCKS];
 	struct regulator_bulk_data supplies[QCOM_PCIE_2_3_2_MAX_SUPPLY];
 };
 
@@ -571,21 +569,14 @@ static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
 	if (ret)
 		return ret;
 
-	res->aux_clk = devm_clk_get(dev, "aux");
-	if (IS_ERR(res->aux_clk))
-		return PTR_ERR(res->aux_clk);
-
-	res->cfg_clk = devm_clk_get(dev, "cfg");
-	if (IS_ERR(res->cfg_clk))
-		return PTR_ERR(res->cfg_clk);
-
-	res->master_clk = devm_clk_get(dev, "bus_master");
-	if (IS_ERR(res->master_clk))
-		return PTR_ERR(res->master_clk);
+	res->clks[0].id = "aux";
+	res->clks[1].id = "cfg";
+	res->clks[2].id = "master";
+	res->clks[3].id = "slave";
 
-	res->slave_clk = devm_clk_get(dev, "bus_slave");
-	if (IS_ERR(res->slave_clk))
-		return PTR_ERR(res->slave_clk);
+	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
@@ -594,11 +585,7 @@ static void qcom_pcie_deinit_2_3_2(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
 
-	clk_disable_unprepare(res->slave_clk);
-	clk_disable_unprepare(res->master_clk);
-	clk_disable_unprepare(res->cfg_clk);
-	clk_disable_unprepare(res->aux_clk);
-
+	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 }
 
@@ -615,40 +602,15 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
 		return ret;
 	}
 
-	ret = clk_prepare_enable(res->aux_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable aux clock\n");
-		goto err_aux_clk;
-	}
-
-	ret = clk_prepare_enable(res->cfg_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable cfg clock\n");
-		goto err_cfg_clk;
-	}
-
-	ret = clk_prepare_enable(res->master_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable master clock\n");
-		goto err_master_clk;
-	}
-
-	ret = clk_prepare_enable(res->slave_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable slave clock\n");
-		goto err_slave_clk;
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
+	if (ret < 0) {
+		dev_err(dev, "cannot prepare/enable clocks\n");
+		goto err_clks;
 	}
 
 	return 0;
 
-err_slave_clk:
-	clk_disable_unprepare(res->master_clk);
-err_master_clk:
-	clk_disable_unprepare(res->cfg_clk);
-err_cfg_clk:
-	clk_disable_unprepare(res->aux_clk);
-
-err_aux_clk:
+err_clks:
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 
 	return ret;
-- 
2.35.1

