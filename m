Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8803A1F588A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 18:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbgFJQHN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 12:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgFJQHM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2020 12:07:12 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3460C03E96B;
        Wed, 10 Jun 2020 09:07:10 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e12so1807923eds.2;
        Wed, 10 Jun 2020 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2wtQFXbmzC4/d8oVsOGWU0M31JIOAZfPwOO9JlNgV6A=;
        b=dv1+MAQei2yu8tc9NiXHkLyBVWamgfvo5hf7Ahs8ZyjcGI1rRUQJyLb4KhMwIbl3Ky
         r8uYILKaDzbyCLJ7Qn5R7XQ3LBHXGFqtB9LvSEHpJLhHJwsPADJnlaFrhY3Y9zwE5RGP
         V26rH3jLZ08D8pXWgVrxAL7ChENSwZ9OEIZVgl7EU5jcszt2vr4/3JeUyW+VNmXAW6kp
         Eio2wgiGor/5R75FCRaYGzyD3/9Lv1nuYlT/e+ctC/D66UO9owkDHsyd9XpIFewBWhVe
         UdVCAVH51oslV23eZDhRpiOcYRLlA1Ydq70ow0FDnUy3O/DhpaJmNIkWhg7QNEYCwnUu
         l5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wtQFXbmzC4/d8oVsOGWU0M31JIOAZfPwOO9JlNgV6A=;
        b=phQe8i4dZkdDubvzAIPTZgmL4BIn01BbEH5F9Dm2fDjKSozq+gyr0QMRPflL8W1EtQ
         N2LBp/dwWVz2c4dtXwlXhIBfwwVtulLLxgMftgqkIBGM+pXFM/43IibIKuxcqrIw0Eq1
         T9XZ4RhPBScRa1cDoyMpcRjLp1ySpnX6Pns5kEovxX5XMR3QmgNEPEnHt/4MMEgX4egc
         35KxesmdNzLbTgZLGAm6aVBRvo5Vm0RwOQI0VybE0ZrVi31tK2Z0vkFFAY3PBneSyeLc
         Ex+XonG5yyXSSjWjC+KGOUrTnj67no0eBYISyde4U1At2xv86fVl7OjvxqNSg6uqWu4S
         R2Hw==
X-Gm-Message-State: AOAM531SwGCJJNYgf2U+nw/3neJpJml0oKFGcgEKMbeSE3rTl0V+CWm7
        74+xUgM4fBNacrl2W3+IvLc=
X-Google-Smtp-Source: ABdhPJypmstF+84GTqUN05fLQyZM319vjxm1J2mVMRgUv3VAZi9aErb6Dn+C+VwbxhOeL3iQpyzoyQ==
X-Received: by 2002:a50:d556:: with SMTP id f22mr3178103edj.307.1591805229333;
        Wed, 10 Jun 2020 09:07:09 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-79-35-249-242.retail.telecomitalia.it. [79.35.249.242])
        by smtp.googlemail.com with ESMTPSA id ce25sm56067edb.45.2020.06.10.09.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 09:07:08 -0700 (PDT)
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
Subject: [PATCH v6 01/12] PCI: qcom: Add missing ipq806x clocks in PCIe driver
Date:   Wed, 10 Jun 2020 18:06:43 +0200
Message-Id: <20200610160655.27799-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200610160655.27799-1-ansuelsmth@gmail.com>
References: <20200610160655.27799-1-ansuelsmth@gmail.com>
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

