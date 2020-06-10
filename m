Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850F61F58BC
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 18:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbgFJQIO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 12:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgFJQHQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2020 12:07:16 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3A6C03E96F;
        Wed, 10 Jun 2020 09:07:15 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o15so3160545ejm.12;
        Wed, 10 Jun 2020 09:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s9klwDUAQHUdrbunE/kS0tb+TnD6OrjCFpNB//xZIAs=;
        b=C+9URlX4DDs1ExBwdqCpKQePPhHXWLqg7VfMAB1p74sOH/oSGm81fKdRIqIQ2lbDNd
         13zFYSQEl5Q27eSMuAWbg622Ir+PP06KG201o+vC9CR/dqIYSSht1ZTBD0RQmb/6FIJu
         a6pofmnLWyIfZuEesX9Dh+Op5q7Xht9R4ZzyROXqps93PelML1K/nElH1DSmSROmxZft
         cBwqrKxBG+dAXUIhHYjj2Ui4LqixTqk7ziLLyw9JkTynjVbpO/u7BlGnDYkmVvmXovTn
         vs4jGLtfgH7mYBUKNg5gC+ruzunzRTmCkdHssTFHfyCRBd2g0drKEpZPI6V74Vn2zgt/
         5EPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s9klwDUAQHUdrbunE/kS0tb+TnD6OrjCFpNB//xZIAs=;
        b=pmk/9FI3PPrQ4NjbkpNuEK9VJViIFu05LXXkRGG1AOp1q8DiVl1jAGBPf9virT/QOC
         uaooJTpKwovp3DayPOLew/DFolY9a92OMF/15ae587SjpggDovp4yT1d9vWPqqQfkmiU
         yws0hE28YSTHNgeGEkA1PgeAeR/Aqr3oVTd0FrVMC63nxdvE5lRFTSG3QRZl+dNOFqFt
         Iuu7Ra6ykjzbsGgFQJEXfZ7HYMwQuXllqyDL3azbZPF3pF5ZNl/e6kKh26vm9LBg+5lu
         RQ9fRTF0SoLRY5CjeMvTgOL9FLFVozBtgkFesMST2YJFpN02CbubMaYwcpPlxWNi/cCa
         DYaA==
X-Gm-Message-State: AOAM531UvytO6TfLZzaBgsDrvzQNHxGyBGY7Wnd20gylYFXr956e20II
        KLUHZmQ+/CmYtbko0jPX6cNLfPp18jTsEMgI
X-Google-Smtp-Source: ABdhPJz996mO0a7CqiD4hWF2x1UtjKNsu/VbgUDj81kz742RAwI7WZqdB7LHe6rIz1UeYCp3P0+g/A==
X-Received: by 2002:a17:906:1d1a:: with SMTP id n26mr3897465ejh.351.1591805234537;
        Wed, 10 Jun 2020 09:07:14 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-79-35-249-242.retail.telecomitalia.it. [79.35.249.242])
        by smtp.googlemail.com with ESMTPSA id ce25sm56067edb.45.2020.06.10.09.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 09:07:13 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Abhishek Sahu <absahu@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
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
Subject: [PATCH v6 03/12] PCI: qcom: Change duplicate PCI reset to phy reset
Date:   Wed, 10 Jun 2020 18:06:45 +0200
Message-Id: <20200610160655.27799-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200610160655.27799-1-ansuelsmth@gmail.com>
References: <20200610160655.27799-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Abhishek Sahu <absahu@codeaurora.org>

The deinit issues reset_control_assert for PCI twice and does not contain
phy reset.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 4bf93ab8c7a7..4512c2c5f61c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -280,14 +280,14 @@ static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
 
+	clk_disable_unprepare(res->phy_clk);
 	reset_control_assert(res->pci_reset);
 	reset_control_assert(res->axi_reset);
 	reset_control_assert(res->ahb_reset);
 	reset_control_assert(res->por_reset);
-	reset_control_assert(res->pci_reset);
+	reset_control_assert(res->phy_reset);
 	clk_disable_unprepare(res->iface_clk);
 	clk_disable_unprepare(res->core_clk);
-	clk_disable_unprepare(res->phy_clk);
 	clk_disable_unprepare(res->aux_clk);
 	clk_disable_unprepare(res->ref_clk);
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
@@ -325,12 +325,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 		goto err_clk_core;
 	}
 
-	ret = clk_prepare_enable(res->phy_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable phy clock\n");
-		goto err_clk_phy;
-	}
-
 	ret = clk_prepare_enable(res->aux_clk);
 	if (ret) {
 		dev_err(dev, "cannot prepare/enable aux clock\n");
@@ -383,6 +377,12 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 		return ret;
 	}
 
+	ret = clk_prepare_enable(res->phy_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable phy clock\n");
+		goto err_deassert_ahb;
+	}
+
 	/* wait for clock acquisition */
 	usleep_range(1000, 1500);
 
@@ -400,8 +400,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 err_clk_ref:
 	clk_disable_unprepare(res->aux_clk);
 err_clk_aux:
-	clk_disable_unprepare(res->phy_clk);
-err_clk_phy:
 	clk_disable_unprepare(res->core_clk);
 err_clk_core:
 	clk_disable_unprepare(res->iface_clk);
-- 
2.25.1

