Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23E5E18D71F
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 19:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgCTSfF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 14:35:05 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35005 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbgCTSfF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 14:35:05 -0400
Received: by mail-ed1-f65.google.com with SMTP id a20so8339174edj.2;
        Fri, 20 Mar 2020 11:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PjUrNIBTHiGRlXltBoWnInenBouwnlz0OaURyGduRc8=;
        b=hj0Gjr3w7oKqG+/bfA2jN473nqLzbMpQSum+y5Z1mOejc+pz4plw/F1SS2BcZJPin1
         3hSggqTP+ZKnFEorHvTKwBJGC6D8k1fe3lMlhlWO+2edrUDp6pA4DxdGmDFa6YWp2ZwF
         PIn2YbAmk2uwlWE9sBGAJdkhdTPUQxPi6XtXdgjZ6QP5+rhGhBPpJsuQ7UYyWxVO5xQE
         yNi9T6f9F575tiLs0KnMRN71falp6acddOa3YP63mskZDGNGzTPlJ7OVRd/JwfMH7aYs
         YOXt/F81Or2DZUD4kotD8mSSK6xX1Fy4UV9u3qjEWjQOyhgPsmTL8MQRZ6luhDX5Cby1
         Z6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PjUrNIBTHiGRlXltBoWnInenBouwnlz0OaURyGduRc8=;
        b=V//eSk71K+jJ0M1/9cIqbRYeYz1ReHdm/nG1efntCPLms48H66U9AlhCZqZXVwogur
         YoteZvx8qjlmVF4TbxG1nxK/CFezhyR+wcdqbBTF48c4yAcryDDaxikRjA7xRFfuM2+/
         oe6EANzOl6D05Fz3hIVqWdWHvL2ODrevJqS+y2dEevbCA595XJ2WMQOqUP2sHOOkW6DZ
         9SBIMIWIkaERxvJI5ARdmmYpR+4rCVfa1hHPwvve+CMiY5W40ovsZzfYFkAYYU5dW663
         cbkl6HEpaeN0nbGqPd6kgmMiJAv0TIRu88l6u2KTc+0w+urBx1h4eM1LwxdZkUe70VwJ
         YRwQ==
X-Gm-Message-State: ANhLgQ14xGU74G0MIYLKqQZbUVZE6IWltNkoag/2LwmBF2WK4jysqrE9
        5AmCdCtaAAKmYIXnU4hTT5A=
X-Google-Smtp-Source: ADFU+vvHAO5MesgNDreNBT9MSjyANUd4rdBiCnfzEigRlv0T/4Z7d4CGHTe31T+t2ccvEkSD2uqiZQ==
X-Received: by 2002:a50:cdc7:: with SMTP id h7mr9669266edj.208.1584729302756;
        Fri, 20 Mar 2020 11:35:02 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host203-232-dynamic.53-79-r.retail.telecomitalia.it. [79.53.232.203])
        by smtp.googlemail.com with ESMTPSA id y13sm172916eje.3.2020.03.20.11.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:35:02 -0700 (PDT)
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
Subject: [PATCH 01/12] pcie: qcom: add missing ipq806x clocks in pcie driver
Date:   Fri, 20 Mar 2020 19:34:43 +0100
Message-Id: <20200320183455.21311-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Aux and Ref clk are missing in pcie qcom driver.
Add support in the driver to fix pcie inizialization
in ipq806x

Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 38 ++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 5ea527a6bd9f..f958c535de6e 100644
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
 
+	res->aux_clk = devm_clk_get(dev, "aux");
+	if (IS_ERR(res->aux_clk))
+		return PTR_ERR(res->aux_clk);
+
+	res->ref_clk = devm_clk_get(dev, "ref");
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

