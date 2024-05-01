Return-Path: <linux-pci+bounces-6927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CF88B84EB
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 06:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 709E4B2288F
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 04:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E13487B3;
	Wed,  1 May 2024 04:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HV3Fa060"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB5B481D7;
	Wed,  1 May 2024 04:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714537746; cv=none; b=KlmYd0L0mrvbytKkDW2scQofvM280kfr8w8dGWon/nPyRoqC9VlczAaci9kyyftQiEe5afCvsd8C8xGduuBPFK/3MT4rMxSNZENpnX4mPmP1eDiR6vgZNi5S/bYkTCpV40lrjUoy2amjX+T0G9yeGOtLJ1g8uCfJt52v7oofBw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714537746; c=relaxed/simple;
	bh=q/n7/c+QbGO75Lsgh28Q9qhp+mrAJbfJBpNBP1WUkQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ffsrTXnGeIg1cOYIM/1SzAZeAINu2RozLKNMjDRwAAr10HpIUNAcOK9LU5Zihm68eNXxS7BBuOuYNs8JfpveY5c8boGn29FoD8cl+ubI/wEkOEyLAb/bdpwhEVCE9mVcpwDLd39TX03k2r4BLyqnFJ9tZBAKYhAgCusp1KkeUOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HV3Fa060; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ee2fda66easo1542772a34.3;
        Tue, 30 Apr 2024 21:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714537743; x=1715142543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKfzhKYKdzfcfGJdATuhwe4qCNYS9PL4DLkhaYC5y3s=;
        b=HV3Fa060Xq5pvv+qPJaLRNzcxx1r9UbN8ouredKJZYhq1eMAyPl+ypeImmskXXuKGe
         1VYO6vYw3MfL//ZPehWLpEglB3UY1FlQF8J8OGe5SVv4f6QTm2sqdGHxdCI8HZpW/hjf
         01mI/p8doHmCC1BJUt/jOyA7c6W6hPvsgJplbylLCbj1II6x1HKFETWAVNs266kNspsY
         9JVI4Xt7Ze8PMiBbO9MtweFLTwNoPdS8tRRm+r4TAQNHbcvxAMXIF55n2ZBsl21Y0Liv
         BCWXo2FQUkZdJtNJP5IZDacmkuSxNMQTJUdv9t7N6x7hhHXugQ/bGMO3C0R4prI6NDor
         86Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714537743; x=1715142543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKfzhKYKdzfcfGJdATuhwe4qCNYS9PL4DLkhaYC5y3s=;
        b=MOgjUy11BU4EugrxnUmDYn4AeX8vDJ5HFvL9RCCOE53ZO0Z4d5Ek3ygDKOfwQ3qXS3
         UPvalb8S4yvFD0uz0Fj2eG8J8njGsvk/84X3Z+bBYamoArrIidgm2Cn6hXzHceNVT9MM
         xFXUFJGghKPLkKOU6wTDqNm1zvQtCrPT/QKRPWd8qu9lUDwHsX5nSLvC8+OcZQLt9qbD
         TVwh3kgGBdtSiiSFHcIQKu2bkFSrmi3oUJlWWMJmQuF+mVT2ylB6+QMBpQoWNdXiwqYU
         GitZynGL6ZR+aL91661ZKi3P7E963PTuyi/cFPqJYQ3diKdYt58uBDT3yKq1nixhBac4
         K2CA==
X-Forwarded-Encrypted: i=1; AJvYcCXLDtX88DAYYByJaDcQ5r/t+ogGdSjmkyHAgd1iMoD6QyGJFRuREx0+/SoVVA4Pf5qAdmAqF+wnTUnVCvRYKD1GLBKZzcMZdsAeD4IEqJ+DILEsNAd1M/ag6xF7z8U05JynJngvgra7ojhSwaYvkIJYJzJ6dmrvLOqsfcgTyDT/VnrJgeJVmIWXJ3Bm9q9YALeB+hQWaxeIKBpZqA7dmsfR6ZhWIIrJgHFeZfDAJk2fOr2I7iMCRrHWbZhVo+A=
X-Gm-Message-State: AOJu0Yx+ajA0ndQgWfVBuxrU/qroI2TpLOjINa+pKHT/YSycl71LN0Yb
	qHTfUFj+yNp+8fLtR9SPCUuKYU6nbHERv234+QYlpnVEqpkyTLiX
X-Google-Smtp-Source: AGHT+IHFrczqlpCVGGQpIxs3o+EQjBK5qfRb76vNvMWCRqog+pDH+KQ7V8q7hfV2QawSTqaoyhMbiw==
X-Received: by 2002:a05:6830:e89:b0:6ee:627e:dd93 with SMTP id dp9-20020a0568300e8900b006ee627edd93mr1432775otb.16.1714537743115;
        Tue, 30 Apr 2024 21:29:03 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id do26-20020a0568300e1a00b006ed6dc9fd54sm2719058otb.25.2024.04.30.21.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:29:02 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-clk@vger.kernel.org
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH v4 RESEND 4/8] PCI: qcom: Switch to devm_clk_bulk_get_all() API to get the clocks from Devicetree
Date: Tue, 30 Apr 2024 23:28:43 -0500
Message-Id: <20240501042847.1545145-5-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501042847.1545145-1-mr.nuke.me@gmail.com>
References: <20240501042847.1545145-1-mr.nuke.me@gmail.com>
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


