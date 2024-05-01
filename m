Return-Path: <linux-pci+bounces-6921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A78E8B84B9
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 06:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011DA28406B
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 04:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6596B51012;
	Wed,  1 May 2024 04:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZL8eG85X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804A7502B2;
	Wed,  1 May 2024 04:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714536507; cv=none; b=fILj2eBwoqxQocMuKQCg+ZvD9TIkj+X2j6Lt8/s4ZzHG9U6hzJ6wWexOzTEZ3il5KNf84HavXu4qvm2Iby4VH1AsyV49LUWKtEaBc/5kscz3n/JlsfHWcrDX3BCaasOFXMJ6AES28DYwIqWMCoaxW4MxUwl4XG/gkJ9CBz1jP88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714536507; c=relaxed/simple;
	bh=q/n7/c+QbGO75Lsgh28Q9qhp+mrAJbfJBpNBP1WUkQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QUyZ1p1h4IJN9l+4MJ7t31U37yjGvPJ8WWS8+gdkle/tJrD8esCSFY9RbD6Cus5L1gE8qQSUOxakUgHbjGg5agUBLnih8k/4hQ7K/wmPftYyIYPjd/rl+f9f2ziDq9yHkarg+etal3whxcPVJbbDBezpAQl3nE9E5mQWIH84dys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZL8eG85X; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c861a87d6dso2171338b6e.0;
        Tue, 30 Apr 2024 21:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714536504; x=1715141304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKfzhKYKdzfcfGJdATuhwe4qCNYS9PL4DLkhaYC5y3s=;
        b=ZL8eG85XC3etvK8SBWC/tvzNv5PjFbUqoiCG/wjAO08fYEI9RMZM5hqaptx2y96P9P
         HzBC9U6B+uFikZkPa3+DOMqKSpzPC1VIYYQtJ2cblt3Bf2yvNN8OP7uvl7/abQAmHlMP
         FjwCxSdJeLwl2xLCTWdaUTmPDi+7Du0VeQ79EYv5Oaf8s29NlaWZAWnDUhs4MCURqFAN
         RJlTLW6S4pJiuuQjE/8qV5WOIIOIj6THh221YqoRonJFaDXtjTvb3iZVAOtYesbwkJ4g
         240Nm6x6SzZkspJI2AOjHJdWmpR0cbpXldRY8PLJklGSBvpQviM3BaMj4o467PgRDixD
         2w1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714536504; x=1715141304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKfzhKYKdzfcfGJdATuhwe4qCNYS9PL4DLkhaYC5y3s=;
        b=URXsB4i1/nwfjitdV/KKQGK1JMpaPn4KgXZybXDh2IaiSgxnmvmu+gAQxZb16IHSU/
         nCY0LG/W2QNRO8oiMcM6lY7Tr5X76SBUmwWYEdWb85+Usqyq7wci6d7OloLpWuIvi1bK
         JWKo0IWLAMNOy/AU9gH0Qa1TdIK5VMPraO6YDSpj1AFzYkCRABLQsf4RLF/QTc4Ss4PH
         TZfGLpisj7zOrg+BQcmWx+thxCDKGo8w8kg1UTIkbJIddMwA2sK1kePnuH4OpIrIAXZd
         slGPf2xhGC9xmEpg+ixEMhZyKYk0KhU9m8vzO9Atm/dLuF/sSN7LCl+sjb6l3c2Bvh6g
         E9tw==
X-Forwarded-Encrypted: i=1; AJvYcCVvTS0X3NnI40eH65FrArzLrRAI75FdxX9hPaUnOspxrPkTi40n0q4s+18bozL4IeBzcswCEtuohFOKfzc1DDXv4aVFNIAcRozYJCBrJUM1OM78RvDORFPSnwpAs5nDUYXX8ylzwCvQqQ==
X-Gm-Message-State: AOJu0YwVYXGF/Y3kSNI/YLW7Lm4OblXx9cZgF6J9m6H8B9KeLCEbkz1U
	YR/N5v/cbwIDgUoNo1NkkuYE4Tr0MFiZfyUpiyqn9PTa9nSJHFyLm2HCj+TNwmk=
X-Google-Smtp-Source: AGHT+IHKrQ38lOr4uhJyMV4K9xZO9g34DDBYI7mzSeHjNgoHhoBFlwL2ujJxfcbg1UWhe19S4hobag==
X-Received: by 2002:a05:6808:1b12:b0:3c6:f339:7f4c with SMTP id bx18-20020a0568081b1200b003c6f3397f4cmr1838087oib.49.1714536504371;
        Tue, 30 Apr 2024 21:08:24 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id w2-20020a056808018200b003c8643f0e5csm1067872oic.16.2024.04.30.21.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:08:23 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	quic_kathirav@quicinc.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 4/8] PCI: qcom: Switch to devm_clk_bulk_get_all() API to get the clocks from Devicetree
Date: Tue, 30 Apr 2024 23:07:55 -0500
Message-Id: <20240501040800.1542805-14-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
References: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

There is no need for the device drivers to validate the clocks defined in
Devicetree. The validation should be performed by the DT schema and the
drivers should just get all the clocks from DT. Right now the driver
hardcodes the clock info and validates them against DT which is redundant.

So use devm_clk_bulk_get_all() that just gets all the clocks defined in DT
and get rid of all static clocks info from the driver. This simplifies the
driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
[moved clks to struct qcom_pcie to reduce code duplication]
---
 drivers/pci/controller/dwc/pcie-qcom.c | 163 ++++---------------------
 1 file changed, 25 insertions(+), 138 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 14772edcf0d3..ea81ff68d433 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -154,58 +154,42 @@
 #define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
 		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
 
-#define QCOM_PCIE_1_0_0_MAX_CLOCKS		4
 struct qcom_pcie_resources_1_0_0 {
-	struct clk_bulk_data clks[QCOM_PCIE_1_0_0_MAX_CLOCKS];
 	struct reset_control *core;
 	struct regulator *vdda;
 };
 
-#define QCOM_PCIE_2_1_0_MAX_CLOCKS		5
 #define QCOM_PCIE_2_1_0_MAX_RESETS		6
 #define QCOM_PCIE_2_1_0_MAX_SUPPLY		3
 struct qcom_pcie_resources_2_1_0 {
-	struct clk_bulk_data clks[QCOM_PCIE_2_1_0_MAX_CLOCKS];
 	struct reset_control_bulk_data resets[QCOM_PCIE_2_1_0_MAX_RESETS];
 	int num_resets;
 	struct regulator_bulk_data supplies[QCOM_PCIE_2_1_0_MAX_SUPPLY];
 };
 
-#define QCOM_PCIE_2_3_2_MAX_CLOCKS		4
 #define QCOM_PCIE_2_3_2_MAX_SUPPLY		2
 struct qcom_pcie_resources_2_3_2 {
-	struct clk_bulk_data clks[QCOM_PCIE_2_3_2_MAX_CLOCKS];
 	struct regulator_bulk_data supplies[QCOM_PCIE_2_3_2_MAX_SUPPLY];
 };
 
-#define QCOM_PCIE_2_3_3_MAX_CLOCKS		5
 #define QCOM_PCIE_2_3_3_MAX_RESETS		7
 struct qcom_pcie_resources_2_3_3 {
-	struct clk_bulk_data clks[QCOM_PCIE_2_3_3_MAX_CLOCKS];
 	struct reset_control_bulk_data rst[QCOM_PCIE_2_3_3_MAX_RESETS];
 };
 
-#define QCOM_PCIE_2_4_0_MAX_CLOCKS		4
 #define QCOM_PCIE_2_4_0_MAX_RESETS		12
 struct qcom_pcie_resources_2_4_0 {
-	struct clk_bulk_data clks[QCOM_PCIE_2_4_0_MAX_CLOCKS];
-	int num_clks;
 	struct reset_control_bulk_data resets[QCOM_PCIE_2_4_0_MAX_RESETS];
 	int num_resets;
 };
 
-#define QCOM_PCIE_2_7_0_MAX_CLOCKS		15
 #define QCOM_PCIE_2_7_0_MAX_SUPPLIES		2
 struct qcom_pcie_resources_2_7_0 {
-	struct clk_bulk_data clks[QCOM_PCIE_2_7_0_MAX_CLOCKS];
-	int num_clks;
 	struct regulator_bulk_data supplies[QCOM_PCIE_2_7_0_MAX_SUPPLIES];
 	struct reset_control *rst;
 };
 
-#define QCOM_PCIE_2_9_0_MAX_CLOCKS		5
 struct qcom_pcie_resources_2_9_0 {
-	struct clk_bulk_data clks[QCOM_PCIE_2_9_0_MAX_CLOCKS];
 	struct reset_control *rst;
 };
 
@@ -247,6 +231,8 @@ struct qcom_pcie {
 	struct icc_path *icc_mem;
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
+	struct clk_bulk_data *clks;
+	int num_clks;
 	bool suspended;
 };
 
@@ -337,22 +323,6 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
 	if (ret)
 		return ret;
 
-	res->clks[0].id = "iface";
-	res->clks[1].id = "core";
-	res->clks[2].id = "phy";
-	res->clks[3].id = "aux";
-	res->clks[4].id = "ref";
-
-	/* iface, core, phy are required */
-	ret = devm_clk_bulk_get(dev, 3, res->clks);
-	if (ret < 0)
-		return ret;
-
-	/* aux, ref are optional */
-	ret = devm_clk_bulk_get_optional(dev, 2, res->clks + 3);
-	if (ret < 0)
-		return ret;
-
 	res->resets[0].id = "pci";
 	res->resets[1].id = "axi";
 	res->resets[2].id = "ahb";
@@ -373,7 +343,7 @@ static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
 	reset_control_bulk_assert(res->num_resets, res->resets);
 
 	writel(1, pcie->parf + PARF_PHY_CTRL);
@@ -413,7 +383,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 
 static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
 {
-	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
 	struct device_node *node = dev->of_node;
@@ -425,7 +394,7 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
-	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
+	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
 	if (ret)
 		return ret;
 
@@ -476,21 +445,11 @@ static int qcom_pcie_get_resources_1_0_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	int ret;
 
 	res->vdda = devm_regulator_get(dev, "vdda");
 	if (IS_ERR(res->vdda))
 		return PTR_ERR(res->vdda);
 
-	res->clks[0].id = "iface";
-	res->clks[1].id = "aux";
-	res->clks[2].id = "master_bus";
-	res->clks[3].id = "slave_bus";
-
-	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
-	if (ret < 0)
-		return ret;
-
 	res->core = devm_reset_control_get_exclusive(dev, "core");
 	return PTR_ERR_OR_ZERO(res->core);
 }
@@ -500,7 +459,7 @@ static void qcom_pcie_deinit_1_0_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
 
 	reset_control_assert(res->core);
-	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
 	regulator_disable(res->vdda);
 }
 
@@ -517,7 +476,7 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
 		return ret;
 	}
 
-	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
+	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
 	if (ret) {
 		dev_err(dev, "cannot prepare/enable clocks\n");
 		goto err_assert_reset;
@@ -532,7 +491,7 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
 	return 0;
 
 err_disable_clks:
-	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
 err_assert_reset:
 	reset_control_assert(res->core);
 
@@ -580,15 +539,6 @@ static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
 	if (ret)
 		return ret;
 
-	res->clks[0].id = "aux";
-	res->clks[1].id = "cfg";
-	res->clks[2].id = "bus_master";
-	res->clks[3].id = "bus_slave";
-
-	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
@@ -596,7 +546,7 @@ static void qcom_pcie_deinit_2_3_2(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 }
 
@@ -613,7 +563,7 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
 		return ret;
 	}
 
-	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
+	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
 	if (ret) {
 		dev_err(dev, "cannot prepare/enable clocks\n");
 		regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
@@ -661,18 +611,6 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 	bool is_ipq = of_device_is_compatible(dev->of_node, "qcom,pcie-ipq4019");
 	int ret;
 
-	res->clks[0].id = "aux";
-	res->clks[1].id = "master_bus";
-	res->clks[2].id = "slave_bus";
-	res->clks[3].id = "iface";
-
-	/* qcom,pcie-ipq4019 is defined without "iface" */
-	res->num_clks = is_ipq ? 3 : 4;
-
-	ret = devm_clk_bulk_get(dev, res->num_clks, res->clks);
-	if (ret < 0)
-		return ret;
-
 	res->resets[0].id = "axi_m";
 	res->resets[1].id = "axi_s";
 	res->resets[2].id = "axi_m_sticky";
@@ -700,7 +638,7 @@ static void qcom_pcie_deinit_2_4_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
 
 	reset_control_bulk_assert(res->num_resets, res->resets);
-	clk_bulk_disable_unprepare(res->num_clks, res->clks);
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
 }
 
 static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
@@ -726,7 +664,7 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
 
 	usleep_range(10000, 12000);
 
-	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
+	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
 	if (ret) {
 		reset_control_bulk_assert(res->num_resets, res->resets);
 		return ret;
@@ -742,16 +680,6 @@ static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
 	struct device *dev = pci->dev;
 	int ret;
 
-	res->clks[0].id = "iface";
-	res->clks[1].id = "axi_m";
-	res->clks[2].id = "axi_s";
-	res->clks[3].id = "ahb";
-	res->clks[4].id = "aux";
-
-	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
-	if (ret < 0)
-		return ret;
-
 	res->rst[0].id = "axi_m";
 	res->rst[1].id = "axi_s";
 	res->rst[2].id = "pipe";
@@ -769,9 +697,7 @@ static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
 
 static void qcom_pcie_deinit_2_3_3(struct qcom_pcie *pcie)
 {
-	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
-
-	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
 }
 
 static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
@@ -801,7 +727,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 	 */
 	usleep_range(2000, 2500);
 
-	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
+	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
 	if (ret) {
 		dev_err(dev, "cannot prepare/enable clocks\n");
 		goto err_assert_resets;
@@ -862,8 +788,6 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	unsigned int num_clks, num_opt_clks;
-	unsigned int idx;
 	int ret;
 
 	res->rst = devm_reset_control_array_get_exclusive(dev);
@@ -877,37 +801,6 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	if (ret)
 		return ret;
 
-	idx = 0;
-	res->clks[idx++].id = "aux";
-	res->clks[idx++].id = "cfg";
-	res->clks[idx++].id = "bus_master";
-	res->clks[idx++].id = "bus_slave";
-	res->clks[idx++].id = "slave_q2a";
-
-	num_clks = idx;
-
-	ret = devm_clk_bulk_get(dev, num_clks, res->clks);
-	if (ret < 0)
-		return ret;
-
-	res->clks[idx++].id = "tbu";
-	res->clks[idx++].id = "ddrss_sf_tbu";
-	res->clks[idx++].id = "aggre0";
-	res->clks[idx++].id = "aggre1";
-	res->clks[idx++].id = "noc_aggr";
-	res->clks[idx++].id = "noc_aggr_4";
-	res->clks[idx++].id = "noc_aggr_south_sf";
-	res->clks[idx++].id = "cnoc_qx";
-	res->clks[idx++].id = "sleep";
-	res->clks[idx++].id = "cnoc_sf_axi";
-
-	num_opt_clks = idx - num_clks;
-	res->num_clks = idx;
-
-	ret = devm_clk_bulk_get_optional(dev, num_opt_clks, res->clks + num_clks);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
@@ -925,7 +818,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 		return ret;
 	}
 
-	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
+	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
 	if (ret < 0)
 		goto err_disable_regulators;
 
@@ -977,7 +870,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 
 	return 0;
 err_disable_clocks:
-	clk_bulk_disable_unprepare(res->num_clks, res->clks);
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
 err_disable_regulators:
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 
@@ -1015,7 +908,7 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 
-	clk_bulk_disable_unprepare(res->num_clks, res->clks);
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
 
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 }
@@ -1101,17 +994,6 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	int ret;
-
-	res->clks[0].id = "iface";
-	res->clks[1].id = "axi_m";
-	res->clks[2].id = "axi_s";
-	res->clks[3].id = "axi_bridge";
-	res->clks[4].id = "rchng";
-
-	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
-	if (ret < 0)
-		return ret;
 
 	res->rst = devm_reset_control_array_get_exclusive(dev);
 	if (IS_ERR(res->rst))
@@ -1122,9 +1004,7 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
 
 static void qcom_pcie_deinit_2_9_0(struct qcom_pcie *pcie)
 {
-	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
-
-	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
 }
 
 static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
@@ -1153,7 +1033,7 @@ static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
 
 	usleep_range(2000, 2500);
 
-	return clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
+	return clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
 }
 
 static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
@@ -1561,6 +1441,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
+	pcie->num_clks = devm_clk_bulk_get_all(dev, &pcie->clks);
+	if (pcie->num_clks < 0) {
+		ret = pcie->num_clks;
+		dev_err(dev, "Failed to get clocks\n");
+		goto err_pm_runtime_put;
+	}
+
 	ret = qcom_pcie_icc_init(pcie);
 	if (ret)
 		goto err_pm_runtime_put;
-- 
2.40.1


