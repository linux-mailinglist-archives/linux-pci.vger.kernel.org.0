Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CD71D3EAA
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 22:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgENUHj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 16:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726035AbgENUHi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2020 16:07:38 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0453BC061A0E;
        Thu, 14 May 2020 13:07:38 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id se13so3870779ejb.9;
        Thu, 14 May 2020 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s9klwDUAQHUdrbunE/kS0tb+TnD6OrjCFpNB//xZIAs=;
        b=lgYWAvhnlWoeuSlKxHEiWo9lDRmXAv+LQuUg3uUiPZVd0etoitxx9sgGWrLnmkmhgB
         XVWKQIMcHBet2fLYzSXiVZjJsn70i/0pWqsH20sRTK5WaqDbGlrVBEOT0KtUwNiyKhkK
         pZRz58sgW8vv4ruOBZOcbHhg8lxFrorQGvMBG178/VC1SoeNv8h6U5SJiYOwzOqpQMyr
         M5lnP8jgD6OdjqStIwciFuyIwrHcLIVg7T/uPv1xpjvWZeiGzmv0G+EG87NgmMuO3dsy
         6LmzZ1kXx6EUSj8Y5jrc9NUWltYwTuufDaxTHK8pnliL9dgAncAkhN/rucK6qNiw8+BK
         2MeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s9klwDUAQHUdrbunE/kS0tb+TnD6OrjCFpNB//xZIAs=;
        b=oa1Bs1f+iVjzdmEnHw5zDEcaiAVmTADJp0lvjhEh4eb++i0t/ycaPUczPVhDGWL4dC
         WB0cRFfwivFxuFf9TWyRYlzhn51heqXWKK/1oGsFz13J/6cw3VkvVaVilCRoQmMtU3Pi
         7FoJ7ckY03SsTg785pfWtmt0WcR7UW2JrM7YvZvRNpbNDkW6riKsYg8HO3zRvEUB6oej
         sWW5dyZwGFKqx2OllokpFV4e7xdhHMo51UtL2yhbv/8tpOfLrIH9hiq/GjioLA/D3QiC
         IP2Ni8pd/xEAr/ruWELXJz0kbu/nSR+TFPBHRabMlnHXPmz8LddoSkce5qIsEVToRj2d
         WmKA==
X-Gm-Message-State: AOAM53250bH5wi055WgAYJPx5oQ76R/HM40Dli2nthtnn3RWaajLx1OE
        REhizOityWo5lgfEFXXvED03Q+tJICtHMPl+
X-Google-Smtp-Source: ABdhPJx2VN38BTsQQky5SYYq4CsRgqGboc3SVvuZTT/0POgaC7rFcBc1pDCLQq1RrwLvJRVgdRS0cA==
X-Received: by 2002:a17:906:51b:: with SMTP id j27mr5346654eja.246.1589486856614;
        Thu, 14 May 2020 13:07:36 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host122-89-dynamic.247-95-r.retail.telecomitalia.it. [95.247.89.122])
        by smtp.googlemail.com with ESMTPSA id bd10sm1472edb.10.2020.05.14.13.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 13:07:35 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Abhishek Sahu <absahu@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/10] PCI: qcom: Change duplicate PCI reset to phy reset
Date:   Thu, 14 May 2020 22:07:04 +0200
Message-Id: <20200514200712.12232-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514200712.12232-1-ansuelsmth@gmail.com>
References: <20200514200712.12232-1-ansuelsmth@gmail.com>
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

