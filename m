Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3757B1EBAF8
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 13:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgFBLyb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 07:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgFBLy3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 07:54:29 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0220C061A0E;
        Tue,  2 Jun 2020 04:54:29 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g10so2627251wmh.4;
        Tue, 02 Jun 2020 04:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s9klwDUAQHUdrbunE/kS0tb+TnD6OrjCFpNB//xZIAs=;
        b=IF8EoKhEoV6G2tqq6uLVNzyik+LsxddjgENfK5q27xfR6rvBQ0AWqO0R51+rqquoh5
         6UTt1ketVQz1Dy+lQdPNeyVdAxWo6kHAJdnfr43IP+93VwysWqQSmCsMqOjg/eC15j1y
         XDOh8aqzswhdiNHEB6/JXb7sBl9QUot8Lf8OpJMk5+PJF4tv8f6uDBAAfiJOyZxiY8T5
         fXweBCzhyKpNVXp1zc/uddB3Mmhp9JyGP9P2MNdrfGR7CoXe25s/7dF/w3GqFnWGcYMc
         PFuZDy/qVlQEIdFOqTOzCjieEpge2RLlRMKDuNCZGIUxFVjQ8RHcR/jLGEJ12NSDSR2U
         Kozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s9klwDUAQHUdrbunE/kS0tb+TnD6OrjCFpNB//xZIAs=;
        b=hnzwkDwa6AyW65W8tw5kAj5TwniC/uATLYRERHmBTX5R5C9AaaweyTMjHRs1mEudJv
         BncuR5D15F3J8TLojol9GBIih2CucilruXhz7+JEfIACFl6tqgr7MQBBNxy8K1QKiNem
         Yz6e7GuWvyZ1NtXa+/L8ndg7g3C9gJaXFANqzOfrFyHtiwGNq0wzq1R8kZLcXzGyoi+D
         vp59O7ATGMUkSpxgptVL++Uwiocey91O14afp9Z9Q7amf2rkHt0f5gTwm1uvctJ7nHC2
         LRcVX9i1oYt+tljV0Xou0SD7s2eeUJ7tE8QqARpKDqV+GJ/ddB08VIrBNrsY0dAKYc2N
         T2xw==
X-Gm-Message-State: AOAM531rTtBCY2G7CeyzXDS2T4m2POg33SeXyM+b3O+8H7UfAQoiq22J
        TdB9LP8J3SkK9IzVjUsahLs=
X-Google-Smtp-Source: ABdhPJznN0h7KwcJtw/jowMO0Vfn2BJVS4GYS2C93zi1okD4NPM2j9RfwMPJWBRUshgfb1Yo9mNZYA==
X-Received: by 2002:a7b:c0d9:: with SMTP id s25mr4037720wmh.175.1591098868301;
        Tue, 02 Jun 2020 04:54:28 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host9-254-dynamic.3-87-r.retail.telecomitalia.it. [87.3.254.9])
        by smtp.googlemail.com with ESMTPSA id b18sm3273777wrn.88.2020.06.02.04.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 04:54:27 -0700 (PDT)
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
Subject: [PATCH v5 03/11] PCI: qcom: Change duplicate PCI reset to phy reset
Date:   Tue,  2 Jun 2020 13:53:44 +0200
Message-Id: <20200602115353.20143-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200602115353.20143-1-ansuelsmth@gmail.com>
References: <20200602115353.20143-1-ansuelsmth@gmail.com>
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

