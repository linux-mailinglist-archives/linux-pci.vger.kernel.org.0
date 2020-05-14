Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8091D3E83
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 22:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgENUHe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 16:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726035AbgENUHc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2020 16:07:32 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4BFC061A0C;
        Thu, 14 May 2020 13:07:32 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id s3so3891eji.6;
        Thu, 14 May 2020 13:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c+B/Zi3TGJy/wJzPX/sk/wxwAeoUrjIFG+laybuWve4=;
        b=qOkmZlLoVWQ5EploTJn41sYQhgheLW9OOs3CzTPY/2EutVG1oDegoHqKFJUtaSM2Qo
         xpIoFwm0jsoUCOF25zNYD/xLrvmt2m7zO87H8JCeztnZ4dmdzjbiW+0KY6cFvivT5ZbC
         jVu0msbDdG7/GJbFK5tS8HmzQv6xL0T/LcTNcKNpBxrJ0WJczPhy0abQqeJ2zyEydkEm
         6pp9er5ynoNnbk9Dwh6yPATRXVvP6S+EZBt5ssION7OxxRSfuLtByjsJDC3DDsX0m2Rn
         ZKPqI5/UJ80kRCU8Krtkirk14txZCECpZoVg6QbvFpp/hr3EnkpznJFtjxAI9NLjRYpn
         ufHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c+B/Zi3TGJy/wJzPX/sk/wxwAeoUrjIFG+laybuWve4=;
        b=dN9sVoLVTBh7IwwcwVeOoEWhlHj0wAlsDlgjJWD7ZWTaz9sWqlzx7uIDP6du+oCDS9
         stjq9wIMP3EVwx0EMo+3NrM/MqGVQyiusMoitt2SDw8X4JvzHTgc61VizSjSMCtb1Gc/
         4mNCgoYV5gEuMDPDGYZYanFEiFnPhmolN539y2BwQNwdiuMwfaYhvV5OaSBPy5rtxYpQ
         Nj6DbyxdSE0KzDUXCYBqTQ543zSHzZwmASTYsOChsDfJLappoG7lsoh1wo542/zHuH1o
         A5fX4IH3/KIuIGjFL32mUVU6cXvscxVJwAt97aKJOHfawkDAQmo6hhDbn7IUtXZ8I3BE
         UM1A==
X-Gm-Message-State: AOAM530dnxlFqHcB/YY3CRFTLhZn/90wMXOjGg48o1hcW7F1eJhFMfeN
        pYpIiTgOHFC6Pi5MhHyhgaU=
X-Google-Smtp-Source: ABdhPJywLf1ZZsSM53mANa5ux9gsqKcoSlDyly9IRC9X+/z6gaVTSejZ5K99Zn3o8HIjWM8YWW0/hA==
X-Received: by 2002:a17:906:46d3:: with SMTP id k19mr3475034ejs.349.1589486851107;
        Thu, 14 May 2020 13:07:31 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host122-89-dynamic.247-95-r.retail.telecomitalia.it. [95.247.89.122])
        by smtp.googlemail.com with ESMTPSA id bd10sm1472edb.10.2020.05.14.13.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 13:07:30 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Sham Muthayyan <smuthayy@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/10] PCI: qcom: Add missing ipq806x clocks in PCIe driver
Date:   Thu, 14 May 2020 22:07:02 +0200
Message-Id: <20200514200712.12232-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514200712.12232-1-ansuelsmth@gmail.com>
References: <20200514200712.12232-1-ansuelsmth@gmail.com>
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

