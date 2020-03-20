Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DABD18D727
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 19:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgCTSfS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 14:35:18 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40258 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbgCTSfR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 14:35:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id w26so1961452edu.7;
        Fri, 20 Mar 2020 11:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPvURtOImvg+Fq3I5SMUmHKPxQmmWBaUP6s2M4NwlZQ=;
        b=HpNpcc7qIwDoPMdGsc7NGbMImJD6DrdDaZK3Yy5xtHZ+QwAgWvRAW/eRcCFOqtuvuz
         dXk086IKz5GKIjErWGoYGuxjg3bFGyJiF0AhV4oUD+UrBImxrymFC3098ylRAoY1mGE+
         sBrbaOOKqPVVckbBkMCmL0HtJ6xBJ4dIECM+HNPfJ5UA0HhplF6yLyoA6ANmnMt6xfD0
         3gSU1aWAEmaaNaaobnhprPixS//fWvvlcF2In7L2PHkX4hNfp0mfYvX3X9unC4VV61Sd
         +SghZXK1iKCo8wiPfIY6+paNExGu9PF9sNVZGolUPvy7cd0mmkgUEFGO/B99iGcrq4xX
         0akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPvURtOImvg+Fq3I5SMUmHKPxQmmWBaUP6s2M4NwlZQ=;
        b=XsxrCDewa3Mh5PMfgleBUsjaLpWv+sCsIYiKM+O5h2YlvYPJ0dIl2feWswyJGWvKqb
         ZRX9HBBJCZVHs8mFSJlliP0a6KwnYcBa6L3hiBb+exrKrQvtQdkapnK0j2BFk3x37WEd
         TO24eyvWPWzK1Bnvfj23seRzfdJm5n1oJS/yTENIh72JBGTrCnfq4Efi9bekOTn7shTn
         G67GwyqL91LZKxDfLqCfopVWIZC4VmiWk4hkUpFQ18m2yHbrCIDagsWBYnUWZcCyad25
         WWc9w/9+tR75NtxcwuYP0bJKalS6E2XUWBIXiaH93L6foJyUORF4cE343EqcYIRvBKkB
         5qEg==
X-Gm-Message-State: ANhLgQ24MAWcZ1kvi3xP2c9zm4SQnAnourue5RAlDuETPvQKidbBQB5j
        uXKtp6tcTD5i5COGTfJn8nQ=
X-Google-Smtp-Source: ADFU+vuXYF2hhGnUijVEzjlj+CFBaGaMl7Om2d8MHAJtuTemqOv3c30/xBnTBrDGKHk7vzi8VxgW9A==
X-Received: by 2002:a17:906:34d3:: with SMTP id h19mr9707812ejb.22.1584729315572;
        Fri, 20 Mar 2020 11:35:15 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host203-232-dynamic.53-79-r.retail.telecomitalia.it. [79.53.232.203])
        by smtp.googlemail.com with ESMTPSA id y13sm172916eje.3.2020.03.20.11.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:35:15 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Sham Muthayyan <smuthayy@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] pcie: qcom: add missing reset for ipq806x
Date:   Fri, 20 Mar 2020 19:34:47 +0100
Message-Id: <20200320183455.21311-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320183455.21311-1-ansuelsmth@gmail.com>
References: <20200320183455.21311-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add missing ext reset used by ipq806x soc in
pcie qcom driver

Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 596731b54728..ecc22fd27ea6 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -95,6 +95,7 @@ struct qcom_pcie_resources_2_1_0 {
 	struct reset_control *ahb_reset;
 	struct reset_control *por_reset;
 	struct reset_control *phy_reset;
+	struct reset_control *ext_reset;
 	struct regulator_bulk_data supplies[QCOM_PCIE_2_1_0_MAX_SUPPLY];
 };
 
@@ -272,6 +273,10 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
 	if (IS_ERR(res->por_reset))
 		return PTR_ERR(res->por_reset);
 
+	res->ext_reset = devm_reset_control_get(dev, "ext");
+	if (IS_ERR(res->ext_reset))
+		return PTR_ERR(res->ext_reset);
+
 	res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
 	return PTR_ERR_OR_ZERO(res->phy_reset);
 }
@@ -285,6 +290,7 @@ static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
 	reset_control_assert(res->axi_reset);
 	reset_control_assert(res->ahb_reset);
 	reset_control_assert(res->por_reset);
+	reset_control_assert(res->ext_reset);
 	reset_control_assert(res->phy_reset);
 	clk_disable_unprepare(res->iface_clk);
 	clk_disable_unprepare(res->core_clk);
@@ -301,18 +307,18 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	u32 val;
 	int ret;
 
+	ret = reset_control_assert(res->ahb_reset);
+	if (ret) {
+		dev_err(dev, "cannot assert ahb reset\n");
+		return ret;
+	}
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
 	if (ret < 0) {
 		dev_err(dev, "cannot enable regulators\n");
 		return ret;
 	}
 
-	ret = reset_control_assert(res->ahb_reset);
-	if (ret) {
-		dev_err(dev, "cannot assert ahb reset\n");
-		goto err_assert_ahb;
-	}
-
 	ret = clk_prepare_enable(res->iface_clk);
 	if (ret) {
 		dev_err(dev, "cannot prepare/enable iface clock\n");
@@ -343,6 +349,12 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 		goto err_deassert_ahb;
 	}
 
+	ret = reset_control_deassert(res->ext_reset);
+	if (ret) {
+		dev_err(dev, "cannot assert ext reset\n");
+		goto err_deassert_ahb;
+	}
+
 	/* enable PCIe clocks and resets */
 	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
 	val &= ~BIT(0);
-- 
2.25.1

