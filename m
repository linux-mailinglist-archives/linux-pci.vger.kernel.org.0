Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D7A1EBAE4
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 13:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgFBLy0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 07:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgFBLyX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 07:54:23 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A47C061A0E;
        Tue,  2 Jun 2020 04:54:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l10so3082595wrr.10;
        Tue, 02 Jun 2020 04:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2wtQFXbmzC4/d8oVsOGWU0M31JIOAZfPwOO9JlNgV6A=;
        b=rPaW7gDQP90eaYUWfocrZarTDq3foj9NBI2+vdBuQtKeJ8kaLi9E57oxNIcWynULgJ
         DTK2xwiglZZ62JPy3WayfYStIGIH7XqJtVpUq6BYu/j58La3U8Lmty5vRdZKVXglrBIR
         1yVqxjD35wsNWZ4ihE1Kk7yeCjv26bepc3JcTWTaBkERpJMOqV5QJZSTbAArI7OaF7M+
         5NzlaWwVJe2MJ2MktUEVtBx0XMvvu4B0wddNtVeWRKzt7at4/Kjj8SKNXQGRox1tNm25
         3cIb77wFxldAGH1AOLF5Nn0PvE9C1XO2pRmEuq/Q8ynLtbdc7FylSeVxpypJkikHWz6x
         uT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wtQFXbmzC4/d8oVsOGWU0M31JIOAZfPwOO9JlNgV6A=;
        b=d94DqipOuC7GSs2iBhwxJJZya/4BDeY5KCdSQnBp3xbNUKnWG2zNWLaYQYvZktJaY3
         srLErSSUQKbYEBM4h20dQunfyFSnhNLShNUwS+xIa5nMzVjLrgaifzOBkKe4LxGgQXWy
         zMpoQP1Utnv7s2/HBE4XBxXlzKRYZ1QJ3DzB3SoMTjUcECwaI0+QJfwrC28HwKmgbv36
         QNt4TTBRqimd14aQfiEKdcDUMkW6BFPjIWPHyVVbNZiY0hkXT8SlsLiVTyfEE2zGfwYC
         Lez/KBn9Y+5YesG0YpKnAsk6Rjz7Do9QZM1XS93JPJYppwCRZ7LWCnU1GpKyP8Gd5fFj
         BG0A==
X-Gm-Message-State: AOAM532mE3El+mC4On3mlNf90/Kc0fHf0Wv9lVYCYw1jjTlPaCurJZ3I
        S4Cg4SCOLaIwqO2TQx96UIA=
X-Google-Smtp-Source: ABdhPJyOdDG9ZJJFvykD+EoExCrvxVZTm1q7+KjEbm5cg4u0HptGlA9r8y73NrghpR5k7s5CMUPquQ==
X-Received: by 2002:a5d:4ec3:: with SMTP id s3mr28049104wrv.103.1591098861685;
        Tue, 02 Jun 2020 04:54:21 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host9-254-dynamic.3-87-r.retail.telecomitalia.it. [87.3.254.9])
        by smtp.googlemail.com with ESMTPSA id b18sm3273777wrn.88.2020.06.02.04.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 04:54:21 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Sham Muthayyan <smuthayy@codeaurora.org>,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/11] PCI: qcom: Add missing ipq806x clocks in PCIe driver
Date:   Tue,  2 Jun 2020 13:53:42 +0200
Message-Id: <20200602115353.20143-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200602115353.20143-1-ansuelsmth@gmail.com>
References: <20200602115353.20143-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Aux and Ref clk are missing in PCIe qcom driver. Add support for this
optional clks for ipq8064/apq8064 SoC.

Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")
Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 38 ++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 5ea527a6bd9f..4bf93ab8c7a7 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -88,6 +88,8 @@ struct qcom_pcie_resources_2_1_0 {
 	struct clk *iface_clk;
 	struct clk *core_clk;
 	struct clk *phy_clk;
+	struct clk *aux_clk;
+	struct clk *ref_clk;
 	struct reset_control *pci_reset;
 	struct reset_control *axi_reset;
 	struct reset_control *ahb_reset;
@@ -246,6 +248,14 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
 	if (IS_ERR(res->phy_clk))
 		return PTR_ERR(res->phy_clk);
 
+	res->aux_clk = devm_clk_get_optional(dev, "aux");
+	if (IS_ERR(res->aux_clk))
+		return PTR_ERR(res->aux_clk);
+
+	res->ref_clk = devm_clk_get_optional(dev, "ref");
+	if (IS_ERR(res->ref_clk))
+		return PTR_ERR(res->ref_clk);
+
 	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
 	if (IS_ERR(res->pci_reset))
 		return PTR_ERR(res->pci_reset);
@@ -278,6 +288,8 @@ static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
 	clk_disable_unprepare(res->iface_clk);
 	clk_disable_unprepare(res->core_clk);
 	clk_disable_unprepare(res->phy_clk);
+	clk_disable_unprepare(res->aux_clk);
+	clk_disable_unprepare(res->ref_clk);
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 }
 
@@ -307,16 +319,28 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 		goto err_assert_ahb;
 	}
 
+	ret = clk_prepare_enable(res->core_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable core clock\n");
+		goto err_clk_core;
+	}
+
 	ret = clk_prepare_enable(res->phy_clk);
 	if (ret) {
 		dev_err(dev, "cannot prepare/enable phy clock\n");
 		goto err_clk_phy;
 	}
 
-	ret = clk_prepare_enable(res->core_clk);
+	ret = clk_prepare_enable(res->aux_clk);
 	if (ret) {
-		dev_err(dev, "cannot prepare/enable core clock\n");
-		goto err_clk_core;
+		dev_err(dev, "cannot prepare/enable aux clock\n");
+		goto err_clk_aux;
+	}
+
+	ret = clk_prepare_enable(res->ref_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable ref clock\n");
+		goto err_clk_ref;
 	}
 
 	ret = reset_control_deassert(res->ahb_reset);
@@ -372,10 +396,14 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	return 0;
 
 err_deassert_ahb:
-	clk_disable_unprepare(res->core_clk);
-err_clk_core:
+	clk_disable_unprepare(res->ref_clk);
+err_clk_ref:
+	clk_disable_unprepare(res->aux_clk);
+err_clk_aux:
 	clk_disable_unprepare(res->phy_clk);
 err_clk_phy:
+	clk_disable_unprepare(res->core_clk);
+err_clk_core:
 	clk_disable_unprepare(res->iface_clk);
 err_assert_ahb:
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
-- 
2.25.1

