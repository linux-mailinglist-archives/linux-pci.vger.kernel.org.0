Return-Path: <linux-pci+bounces-6341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F28C8A7CB3
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 09:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F91282532
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 07:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057776A337;
	Wed, 17 Apr 2024 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPp/P2Ax"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F187769E0C
	for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 07:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713337398; cv=none; b=pyhb/HwMhlp/gq3HVdScu9PDdwewatp9bTWYFASIBwmGIAYTTJOwoy64DcPvWcrPEyNvnegFLtS2mbAHhhXKV+ESuz1qf13YBNZGwMYpNgNUSgJMeoRvnp2avc0QfeuVIVZDR/F04DlxvOMQsB0RCXC9DNPiJWW8Nv2/6bTCcok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713337398; c=relaxed/simple;
	bh=+Szd0m7hc5ADliFv9J2r/gh6GKw8SfbHVeninK/Duxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f2wZTODv5KByfKK+nDA94gEZMc69NZIa2+CWef+10n1F4o61voSFZz2Hl6Mdbbk5bPOs0ZZiczUZzlFurmbQtjOpLWDA3ID5FG+Im83H9t8P/fO1iN2PgBV6Af2lPvWF949YaFd2yhSNB1SE5EOmf3pejK+oDbyud22VgVlaExA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mPp/P2Ax; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed2dc03df6so4640263b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 00:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713337396; x=1713942196; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NQWKlRWSEEy/WJ4wVuQ4VDIZfM4ZRFArXby6OLRDTnM=;
        b=mPp/P2AxA1geoMv0L1THoCUjCCa0ZJRgp5VHoPHDW5dKhD4/q3T5T+j9I52ZuXpPN5
         +E85TFwAMJP1raHI5nKqSJBimlKBK1Pm9lqIXCo4xb8k24FwgFUdD8A0NqS2PD/n8FpA
         vg06hMVaJnwxR/D26P8X1QmbPJJ9lWgy5oGEjGhijMOoXmORFJhWaMgHfFruVv3oG3nJ
         mw+8aL6yCx4IltAVLxYN5Mc84ivUOWA3XrYU/F/iAuuvJmnctHhzDuiLEIa/kc8BzGjG
         k6y2vhFW/K+KW1M2byQbaxPnV+8xoy4bVLUME9QL76lQwVP5a8s8R4N2+gKRJ0+FYjES
         v5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713337396; x=1713942196;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQWKlRWSEEy/WJ4wVuQ4VDIZfM4ZRFArXby6OLRDTnM=;
        b=rUli6KIdzIUHfQMUAnc250RuhuOxyvkpD2cWMekeBwtkWcdpj6bB/cXfKl3uYi6xMW
         G+7dHHeijnDsR0VsSm4rkolmdeoyEkFMGu8xy2KdA7VcgYLwIPih90yhdA2Hf2scaScI
         T9t7NtBdavqn3uwbvHQ+pt46ucFW4wa1dOMYVoLUwu4NNuBP+YHyJZT0V06HlOnh5ItM
         YZsJnquBAJHr83eiF1+w+oc7ezLb2A9WDMxKIwlFS+Qymmlm4HgJhA4YxjFigxy/sePX
         qYhEJi+gYcrEGYDayUX5yZShMDLsHDTzvvzJ9CCWSb0hQyf4p1Z8Xl89AFN+AnFYmb4a
         daZg==
X-Gm-Message-State: AOJu0Yzg+KRRKj+sfKjKkR+GFQQVjfN3YAl12B0FZa97Q5emZQeQwqlF
	wv5qHo4SDT8PyVJi8x0zzCBXsfenyHiydzRos7W6deP3aqQGrzwZ7+v/G16qWnurJ0CXOXvTkfo
	=
X-Google-Smtp-Source: AGHT+IGaf3DNNAsHOJ/kXMbb5A4c7QweFH2ITfo9IHf2mc3qos18GVYxl0zADTrr7kDLjyVKZ9GOBQ==
X-Received: by 2002:a05:6a00:9285:b0:6ed:416d:f86 with SMTP id jw5-20020a056a00928500b006ed416d0f86mr22646628pfb.15.1713337395276;
        Wed, 17 Apr 2024 00:03:15 -0700 (PDT)
Received: from [127.0.1.1] ([120.60.54.9])
        by smtp.gmail.com with ESMTPSA id ga22-20020a056a00621600b006ecf56cb55fsm10349771pfb.96.2024.04.17.00.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 00:03:14 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 17 Apr 2024 12:32:53 +0530
Subject: [PATCH] PCI: qcom: Switch to devm_clk_bulk_get_all() API to get
 the clocks from Devicetree
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-pci-qcom-clk-bulk-v1-1-52ca19b3d6b2@linaro.org>
X-B4-Tracking: v=1; b=H4sIABx0H2YC/x2MQQ5AMBAAvyJ7tgklob4iDrUWG7S0IRLxd43LJ
 HOYeSCwFw7QJA94viSIs1HyNAGajZ0YZYgOKlNlVuYV7iR4kNuQ1gX7M6Ko9agrZVgrA7HbPY9
 y/8+2e98P++V/rGMAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=12747;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=+Szd0m7hc5ADliFv9J2r/gh6GKw8SfbHVeninK/Duxk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmH3Qv25M05uztUbVZD0RxoawN8s9Osy/JH3tpw
 Hr7KxW7bhiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZh90LwAKCRBVnxHm/pHO
 9TUdB/0T2Il1+zxUpOwNsMnPickdbfCAfszUY6sSonbPDPJTku6Ili0iSGhjYk5sx6W7GdK4zeJ
 VUmMTI8MKq8Ftw9IhLpduhKJ3LNagqFNBhhs06BXIhbWAES0OIrS/pV+HId6eqInZ0Yu91ueePP
 O/g06iNvXuCetW+iRh7fMK6XEldnjk/qJTHJnDZy5EUBlxocAIfN98u7uK7CFF/bUqjBQvVgstc
 w3P0nMR4mmDPNHdOChWVbEw7BOnq1oJIvpbFvTj5UiEbGensFciZ5fSgKVYmY6gVVUhIVAfi0QX
 TkyuqjomyHtgpxWUERq7/uVK7/vj2TLH1hl4xF4WcPYcwb0X
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

There is no need for the device drivers to validate the clocks defined in
Devicetree. The validation should be performed by the DT schema and the
drivers should just get all the clocks from DT. Right now the driver
hardcodes the clock info and validates them against DT which is redundant.

So use devm_clk_bulk_get_all() that just gets all the clocks defined in DT
and get rid of all static clocks info from the driver. This simplifies the
driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 177 +++++++++++----------------------
 1 file changed, 58 insertions(+), 119 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 14772edcf0d3..3d2eeff9a876 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -154,58 +154,56 @@
 #define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
 		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
 
-#define QCOM_PCIE_1_0_0_MAX_CLOCKS		4
 struct qcom_pcie_resources_1_0_0 {
-	struct clk_bulk_data clks[QCOM_PCIE_1_0_0_MAX_CLOCKS];
+	struct clk_bulk_data *clks;
+	int num_clks;
 	struct reset_control *core;
 	struct regulator *vdda;
 };
 
-#define QCOM_PCIE_2_1_0_MAX_CLOCKS		5
 #define QCOM_PCIE_2_1_0_MAX_RESETS		6
 #define QCOM_PCIE_2_1_0_MAX_SUPPLY		3
 struct qcom_pcie_resources_2_1_0 {
-	struct clk_bulk_data clks[QCOM_PCIE_2_1_0_MAX_CLOCKS];
+	struct clk_bulk_data *clks;
+	int num_clks;
 	struct reset_control_bulk_data resets[QCOM_PCIE_2_1_0_MAX_RESETS];
 	int num_resets;
 	struct regulator_bulk_data supplies[QCOM_PCIE_2_1_0_MAX_SUPPLY];
 };
 
-#define QCOM_PCIE_2_3_2_MAX_CLOCKS		4
 #define QCOM_PCIE_2_3_2_MAX_SUPPLY		2
 struct qcom_pcie_resources_2_3_2 {
-	struct clk_bulk_data clks[QCOM_PCIE_2_3_2_MAX_CLOCKS];
+	struct clk_bulk_data *clks;
+	int num_clks;
 	struct regulator_bulk_data supplies[QCOM_PCIE_2_3_2_MAX_SUPPLY];
 };
 
-#define QCOM_PCIE_2_3_3_MAX_CLOCKS		5
 #define QCOM_PCIE_2_3_3_MAX_RESETS		7
 struct qcom_pcie_resources_2_3_3 {
-	struct clk_bulk_data clks[QCOM_PCIE_2_3_3_MAX_CLOCKS];
+	struct clk_bulk_data *clks;
+	int num_clks;
 	struct reset_control_bulk_data rst[QCOM_PCIE_2_3_3_MAX_RESETS];
 };
 
-#define QCOM_PCIE_2_4_0_MAX_CLOCKS		4
 #define QCOM_PCIE_2_4_0_MAX_RESETS		12
 struct qcom_pcie_resources_2_4_0 {
-	struct clk_bulk_data clks[QCOM_PCIE_2_4_0_MAX_CLOCKS];
+	struct clk_bulk_data *clks;
 	int num_clks;
 	struct reset_control_bulk_data resets[QCOM_PCIE_2_4_0_MAX_RESETS];
 	int num_resets;
 };
 
-#define QCOM_PCIE_2_7_0_MAX_CLOCKS		15
 #define QCOM_PCIE_2_7_0_MAX_SUPPLIES		2
 struct qcom_pcie_resources_2_7_0 {
-	struct clk_bulk_data clks[QCOM_PCIE_2_7_0_MAX_CLOCKS];
+	struct clk_bulk_data *clks;
 	int num_clks;
 	struct regulator_bulk_data supplies[QCOM_PCIE_2_7_0_MAX_SUPPLIES];
 	struct reset_control *rst;
 };
 
-#define QCOM_PCIE_2_9_0_MAX_CLOCKS		5
 struct qcom_pcie_resources_2_9_0 {
-	struct clk_bulk_data clks[QCOM_PCIE_2_9_0_MAX_CLOCKS];
+	struct clk_bulk_data *clks;
+	int num_clks;
 	struct reset_control *rst;
 };
 
@@ -337,21 +335,11 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
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
+	res->num_clks = devm_clk_bulk_get_all(dev, &res->clks);
+	if (res->num_clks < 0) {
+		dev_err(dev, "Failed to get clocks\n");
+		return res->num_clks;
+	}
 
 	res->resets[0].id = "pci";
 	res->resets[1].id = "axi";
@@ -373,7 +361,7 @@ static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
+	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 	reset_control_bulk_assert(res->num_resets, res->resets);
 
 	writel(1, pcie->parf + PARF_PHY_CTRL);
@@ -425,7 +413,7 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
-	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
+	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
 	if (ret)
 		return ret;
 
@@ -476,20 +464,16 @@ static int qcom_pcie_get_resources_1_0_0(struct qcom_pcie *pcie)
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
+	res->num_clks = devm_clk_bulk_get_all(dev, &res->clks);
+	if (res->num_clks < 0) {
+		dev_err(dev, "Failed to get clocks\n");
+		return res->num_clks;
+	}
 
 	res->core = devm_reset_control_get_exclusive(dev, "core");
 	return PTR_ERR_OR_ZERO(res->core);
@@ -500,7 +484,7 @@ static void qcom_pcie_deinit_1_0_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
 
 	reset_control_assert(res->core);
-	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
+	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 	regulator_disable(res->vdda);
 }
 
@@ -517,7 +501,7 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
 		return ret;
 	}
 
-	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
+	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
 	if (ret) {
 		dev_err(dev, "cannot prepare/enable clocks\n");
 		goto err_assert_reset;
@@ -532,7 +516,7 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
 	return 0;
 
 err_disable_clks:
-	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
+	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 err_assert_reset:
 	reset_control_assert(res->core);
 
@@ -580,14 +564,11 @@ static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
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
+	res->num_clks = devm_clk_bulk_get_all(dev, &res->clks);
+	if (res->num_clks < 0) {
+		dev_err(dev, "Failed to get clocks\n");
+		return res->num_clks;
+	}
 
 	return 0;
 }
@@ -596,7 +577,7 @@ static void qcom_pcie_deinit_2_3_2(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
+	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 }
 
@@ -613,7 +594,7 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
 		return ret;
 	}
 
-	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
+	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
 	if (ret) {
 		dev_err(dev, "cannot prepare/enable clocks\n");
 		regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
@@ -661,17 +642,11 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
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
+	res->num_clks = devm_clk_bulk_get_all(dev, &res->clks);
+	if (res->num_clks < 0) {
+		dev_err(dev, "Failed to get clocks\n");
+		return res->num_clks;
+	}
 
 	res->resets[0].id = "axi_m";
 	res->resets[1].id = "axi_s";
@@ -742,15 +717,11 @@ static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
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
+	res->num_clks = devm_clk_bulk_get_all(dev, &res->clks);
+	if (res->num_clks < 0) {
+		dev_err(dev, "Failed to get clocks\n");
+		return res->num_clks;
+	}
 
 	res->rst[0].id = "axi_m";
 	res->rst[1].id = "axi_s";
@@ -771,7 +742,7 @@ static void qcom_pcie_deinit_2_3_3(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
+	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 }
 
 static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
@@ -801,7 +772,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 	 */
 	usleep_range(2000, 2500);
 
-	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
+	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
 	if (ret) {
 		dev_err(dev, "cannot prepare/enable clocks\n");
 		goto err_assert_resets;
@@ -862,8 +833,6 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	unsigned int num_clks, num_opt_clks;
-	unsigned int idx;
 	int ret;
 
 	res->rst = devm_reset_control_array_get_exclusive(dev);
@@ -877,36 +846,11 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
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
+	res->num_clks = devm_clk_bulk_get_all(dev, &res->clks);
+	if (res->num_clks < 0) {
+		dev_err(dev, "Failed to get clocks\n");
+		return res->num_clks;
+	}
 
 	return 0;
 }
@@ -1101,17 +1045,12 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
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
 
-	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
-	if (ret < 0)
-		return ret;
+	res->num_clks = devm_clk_bulk_get_all(dev, &res->clks);
+	if (res->num_clks < 0) {
+		dev_err(dev, "Failed to get clocks\n");
+		return res->num_clks;
+	}
 
 	res->rst = devm_reset_control_array_get_exclusive(dev);
 	if (IS_ERR(res->rst))
@@ -1124,7 +1063,7 @@ static void qcom_pcie_deinit_2_9_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
+	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 }
 
 static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
@@ -1153,7 +1092,7 @@ static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
 
 	usleep_range(2000, 2500);
 
-	return clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
+	return clk_bulk_prepare_enable(res->num_clks, res->clks);
 }
 
 static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240417-pci-qcom-clk-bulk-389f972ae92a

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


