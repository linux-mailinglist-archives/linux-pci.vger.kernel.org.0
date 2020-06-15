Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628411FA258
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 23:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbgFOVGY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 17:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbgFOVGW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2020 17:06:22 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12729C061A0E;
        Mon, 15 Jun 2020 14:06:22 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q19so18970821eja.7;
        Mon, 15 Jun 2020 14:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5eNioSzRAf4AQLGTb/kkvDjy6KEFEuRvm0x+F0ZbzF4=;
        b=VnCzQmlYctVsVQYjJ3axxM4glTS3Y57J4kX5qmIoNZsFFozHmBkfW4nEOA79JF3d9D
         6fnR/CnokLIRnFZNx/dzHU+Gy9pxjy7VlYaMHxeNT+whVWqXj5BbIDQn4RsOnoSOE8Pa
         cKG8IU42NAf/obvMtS6Hxh02mU6M8JWZmFV4UbO/6GeiOJP9K9Y0m65i4qKbrAZLGOcM
         GTWOmH8DkbUSfcmRUgKj5Evr8sCpEfWAopHzxrlWSSidfraGW4rQ7berGqCjem0ifeZR
         58dzU+6n37qCxwrHPnqUHwvU1k1UKz3RtNdLvm27kDa+cJCiFFCGjOs/nxH03/xlvOoa
         1z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5eNioSzRAf4AQLGTb/kkvDjy6KEFEuRvm0x+F0ZbzF4=;
        b=I77JeEUMFbHCC95oqlMSivEyfi6pFzitnNYzHmw1fT4VX/5Lm1lYq24H+KxeoExs9y
         z0KfBaqAHgtJiKi9JVenA1y8zLVk6XurUVs/wvGKY3gomlrkOKWTfk0U1cxj5AFwEw2h
         Uld4pNSeNxVNVZG64R3oqRGWyZ6/+8A/H27PXWpgyoi4YgFwuPhZA26N2iwgpj3WgV5B
         x8UvzZfc1o+/gtpFUM7vHTbXkHPqSDHIQ17Mw7YgmRamNSg3vwd8rzS6qwe69oLeTS2c
         cvZz03iglrzu0sPewktPVm44ze6Frj49E7X617GmzC0P4rleOrduEyoj8383H8l5XIhp
         wnNA==
X-Gm-Message-State: AOAM5311M5TyFehqwftTAhM/G2YxoAXaRWdJELBdBnizDwT88Hd+djfW
        CUTSrNZKYUxaD6VYi7nJwcc=
X-Google-Smtp-Source: ABdhPJx0w5iJ+psNKUBmKdjkP5rzWezGYq/1AKAJFRbM5LtcJzvH29cNOapLfGBx67eisahRPqxZKA==
X-Received: by 2002:a17:906:fcb7:: with SMTP id qw23mr25865593ejb.229.1592255180585;
        Mon, 15 Jun 2020 14:06:20 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-95-238-254-39.retail.telecomitalia.it. [95.238.254.39])
        by smtp.googlemail.com with ESMTPSA id d5sm9662226ejr.78.2020.06.15.14.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 14:06:19 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Abhishek Sahu <absahu@codeaurora.org>,
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
Subject: [PATCH v7 03/12] PCI: qcom: Change duplicate PCI reset to phy reset
Date:   Mon, 15 Jun 2020 23:05:59 +0200
Message-Id: <20200615210608.21469-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200615210608.21469-1-ansuelsmth@gmail.com>
References: <20200615210608.21469-1-ansuelsmth@gmail.com>
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
2.27.0.rc0

