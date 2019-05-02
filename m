Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C25511093
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2019 02:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfEBAUC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 20:20:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41881 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfEBAUB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 May 2019 20:20:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so204813pgs.8
        for <linux-pci@vger.kernel.org>; Wed, 01 May 2019 17:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/psW1srJduDZnTK6cT7esw1bLk3kuN/B2zGTRQYrIZU=;
        b=zGUZGCHCANIrHMyTiRT/yYY3cXjKLd59llaczWZVdmNLgUJvSL8lXkZMF/9XG4+qYS
         LOErogw0yIHk9SKCJZAFXcLtN5mE0CQPulZczyplyY/zAyy04lCL69NQ/DhqBnprextG
         g+O6hgZdYWhqp3Gxy33J8pVBYuRgWE9Bvuh3s2p54BO1BruuoUrNdeZCK8KWrpB7j+L1
         fWjj/cgAmogCkZvpt4MYyH26nyRpImpgVpun/rb77RvlORsKaPcJIqT832QzXqeteE3H
         lHOL3aCJVJGk5jtCXXjO71TfsOFjCQU9+FaV9ZFBVRmKZOWa7F2H9oqiM5VIbzMfvXao
         FO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/psW1srJduDZnTK6cT7esw1bLk3kuN/B2zGTRQYrIZU=;
        b=f+bL7T9Y2xdqzQfxBBr6yh5RgeGvB2MtgUuKfR4/67SVU1Hz8FmE5owXRJ8eSOidJQ
         fSz9FTItirgd90lqa9sXLow1FfedlZfOkJ4tRtGV6XjEyOmBJ3ycwJKJkdb7AAh53TU7
         zAJDyw6EuJHutZpI0PSjrrn1I/o0C4GP3aF+y5Z7j9kLsFA/QIYsoSBocXGuqRVyoNFk
         pnGIMr7w+zjuuYPnprsHg+W80+KWxDXW/1bXBcC7cUZoUlXGfIjnk5ihoqIYGsjG4lIb
         gZyWGpFOAIp67xkrr/vzGu5wyOQUlw5ZXdzEDFuw2nGyPzelw+G2ms8RbYC9q1x59O7g
         AOig==
X-Gm-Message-State: APjAAAWOtOPYhxOXL4w1Ppq2CJSLFYY9TZb7vm2Ic03EKQ6iiLd+Ho6I
        kWn+4uMSpy4rG+erPmbHgcJjlQ==
X-Google-Smtp-Source: APXvYqxa1ZKUWnI/qCHjV9dxzxTsV8RrtihOubt8KXD+l5y6/8t+jzp+oZdQf6kAYFxnkKuc5vZULA==
X-Received: by 2002:a63:1b11:: with SMTP id b17mr822754pgb.207.1556756400430;
        Wed, 01 May 2019 17:20:00 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s198sm36927534pfs.34.2019.05.01.17.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 17:19:59 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] PCI: qcom: Use clk_bulk API for 2.4.0 controllers
Date:   Wed,  1 May 2019 17:19:53 -0700
Message-Id: <20190502001955.10575-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190502001955.10575-1-bjorn.andersson@linaro.org>
References: <20190502001955.10575-1-bjorn.andersson@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Before introducing the QCS404 platform, which uses the same PCIe
controller as IPQ4019, migrate this to use the bulk clock API, in order
to make the error paths slighly cleaner.

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- Defined QCOM_PCIE_2_4_0_MAX_CLOCKS

 drivers/pci/controller/dwc/pcie-qcom.c | 49 ++++++++------------------
 1 file changed, 14 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 0ed235d560e3..d740cbe0e56d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -112,10 +112,10 @@ struct qcom_pcie_resources_2_3_2 {
 	struct regulator_bulk_data supplies[QCOM_PCIE_2_3_2_MAX_SUPPLY];
 };
 
+#define QCOM_PCIE_2_4_0_MAX_CLOCKS	3
 struct qcom_pcie_resources_2_4_0 {
-	struct clk *aux_clk;
-	struct clk *master_clk;
-	struct clk *slave_clk;
+	struct clk_bulk_data clks[QCOM_PCIE_2_4_0_MAX_CLOCKS];
+	int num_clks;
 	struct reset_control *axi_m_reset;
 	struct reset_control *axi_s_reset;
 	struct reset_control *pipe_reset;
@@ -638,18 +638,17 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
+	int ret;
 
-	res->aux_clk = devm_clk_get(dev, "aux");
-	if (IS_ERR(res->aux_clk))
-		return PTR_ERR(res->aux_clk);
+	res->clks[0].id = "aux";
+	res->clks[1].id = "master_bus";
+	res->clks[2].id = "slave_bus";
 
-	res->master_clk = devm_clk_get(dev, "master_bus");
-	if (IS_ERR(res->master_clk))
-		return PTR_ERR(res->master_clk);
+	res->num_clks = 3;
 
-	res->slave_clk = devm_clk_get(dev, "slave_bus");
-	if (IS_ERR(res->slave_clk))
-		return PTR_ERR(res->slave_clk);
+	ret = devm_clk_bulk_get(dev, res->num_clks, res->clks);
+	if (ret < 0)
+		return ret;
 
 	res->axi_m_reset = devm_reset_control_get_exclusive(dev, "axi_m");
 	if (IS_ERR(res->axi_m_reset))
@@ -719,9 +718,7 @@ static void qcom_pcie_deinit_2_4_0(struct qcom_pcie *pcie)
 	reset_control_assert(res->axi_m_sticky_reset);
 	reset_control_assert(res->pwr_reset);
 	reset_control_assert(res->ahb_reset);
-	clk_disable_unprepare(res->aux_clk);
-	clk_disable_unprepare(res->master_clk);
-	clk_disable_unprepare(res->slave_clk);
+	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 }
 
 static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
@@ -850,23 +847,9 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
 
 	usleep_range(10000, 12000);
 
-	ret = clk_prepare_enable(res->aux_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable iface clock\n");
+	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
+	if (ret)
 		goto err_clk_aux;
-	}
-
-	ret = clk_prepare_enable(res->master_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable core clock\n");
-		goto err_clk_axi_m;
-	}
-
-	ret = clk_prepare_enable(res->slave_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable phy clock\n");
-		goto err_clk_axi_s;
-	}
 
 	/* enable PCIe clocks and resets */
 	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
@@ -891,10 +874,6 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
 
 	return 0;
 
-err_clk_axi_s:
-	clk_disable_unprepare(res->master_clk);
-err_clk_axi_m:
-	clk_disable_unprepare(res->aux_clk);
 err_clk_aux:
 	reset_control_assert(res->ahb_reset);
 err_rst_ahb:
-- 
2.18.0

