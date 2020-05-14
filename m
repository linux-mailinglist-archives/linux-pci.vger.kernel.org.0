Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059CA1D3E8F
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 22:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgENUHv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 16:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726948AbgENUHu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2020 16:07:50 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1847DC061A0C;
        Thu, 14 May 2020 13:07:50 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g16so5250eds.1;
        Thu, 14 May 2020 13:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xwF/8TggwYiJz5YYlAf27n+3vrJFKgE879FgE8bDVK0=;
        b=pW2FhEPcUnR6cjOpBLOy6iIQNmLh4WUFuDQ/3imi3MOSugpc7Ex5Sh8bIhRZsC2Xxt
         mbjCLdJZfCFPAMyKLQbZr2aNHA0SLKcLva780H+7kr6e39B4ErvJ5oFOOdrxlgUgh6xQ
         GvLEJC51CUctgEuFr6TOr6fzdjqzbg6UOCfmVtT+DKSaf/RU4d9x76TQnC5vA/7TSwGI
         dHTV/Qv2ivK46oRcifzS48U0ODftu7mjBwgr7mECdedPwoPcmGOZXcNG/un5o7vb+C+a
         JOOn3vkM2xUIZNRk84AT0qWxGvtPwnz1pakW3N3XDpeWG4LYyeIe4eyyDcbaiEKuP5wV
         7L2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xwF/8TggwYiJz5YYlAf27n+3vrJFKgE879FgE8bDVK0=;
        b=GRyKWHbOxKDNN9WbIojiCQMte7zp3D58N5neaxCihFCxeQ9FnfwS0/roV3VRk0W0Rs
         vAIvme9LwrxzF4mXQ5UquUuWxiomVm/dxNI6L0xTAh+hXtRRePCfAltRYpADW/HFbTeA
         cs0owk28J1u5kFc5tgP4m3F0fLJvUM+wImBmQv7a82kKcskoigR+4v7MJNHt1+x7ZhMf
         SxAB/5kLZ/RMd6b1fhmfLDK73COzaIRdXG3GpjvyagxARgbR9KFBs4NbK3wDJ1k78qtD
         hPoKDJeF89avt1Yol+mIEHmuF8SsDEjhbiBBgoeGugeVh6+EdXYu/iD5blElsYkSnvDk
         c1kg==
X-Gm-Message-State: AOAM530ukoCH8fZn1Y2mJ5YXx7KSjZNJV9PcxiNMoI6GabfkqZ5mmuKh
        67rT5J5Zsf+rXBV++8UNXL4=
X-Google-Smtp-Source: ABdhPJzo8JLYQYZwyKaSIcJPIHFB00EXMtI5/hdYQctSgGQT35uJACfUqsSGkyFZp7qElTJi2yBIyw==
X-Received: by 2002:a05:6402:1adc:: with SMTP id ba28mr5593656edb.12.1589486868749;
        Thu, 14 May 2020 13:07:48 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host122-89-dynamic.247-95-r.retail.telecomitalia.it. [95.247.89.122])
        by smtp.googlemail.com with ESMTPSA id bd10sm1472edb.10.2020.05.14.13.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 13:07:48 -0700 (PDT)
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
Subject: [PATCH v4 08/10] PCI: qcom: Add ipq8064 rev2 variant and set tx term offset
Date:   Thu, 14 May 2020 22:07:09 +0200
Message-Id: <20200514200712.12232-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514200712.12232-1-ansuelsmth@gmail.com>
References: <20200514200712.12232-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add tx term offset support to pcie qcom driver need in some revision of
the ipq806x SoC. Ipq8064 have tx term offset set to 7. Ipq8064-v2 revision
and ipq8065 have the tx term offset set to 0.

Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index f5398b0d270c..ab6f1bdd24c3 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -45,6 +45,9 @@
 #define PCIE_CAP_CPL_TIMEOUT_DISABLE		0x10
 
 #define PCIE20_PARF_PHY_CTRL			0x40
+#define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
+#define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
+
 #define PCIE20_PARF_PHY_REFCLK			0x4C
 #define PHY_REFCLK_SSP_EN			BIT(16)
 #define PHY_REFCLK_USE_PAD			BIT(12)
@@ -363,7 +366,8 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	val &= ~BIT(0);
 	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
 
-	if (of_device_is_compatible(node, "qcom,pcie-ipq8064")) {
+	if (of_device_is_compatible(node, "qcom,pcie-ipq8064") |
+	    of_device_is_compatible(node, "qcom,pcie-ipq8064-v2")) {
 		writel(PCS_DEEMPH_TX_DEEMPH_GEN1(24) |
 			       PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(24) |
 			       PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(34),
@@ -374,9 +378,18 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 		writel(PHY_RX0_EQ(4), pcie->parf + PCIE20_PARF_CONFIG_BITS);
 	}
 
+	if (of_device_is_compatible(node, "qcom,pcie-ipq8064")) {
+		/* set TX termination offset */
+		val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
+		val &= ~PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK;
+		val |= PHY_CTRL_PHY_TX0_TERM_OFFSET(7);
+		writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+	}
+
 	/* enable external reference clock */
 	val = readl(pcie->parf + PCIE20_PARF_PHY_REFCLK);
-	val |= BIT(16);
+	val &= ~PHY_REFCLK_USE_PAD;
+	val |= PHY_REFCLK_SSP_EN;
 	writel(val, pcie->parf + PCIE20_PARF_PHY_REFCLK);
 
 	/* wait for clock acquisition */
@@ -1452,6 +1465,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-apq8084", .data = &ops_1_0_0 },
 	{ .compatible = "qcom,pcie-ipq8064", .data = &ops_2_1_0 },
+	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &ops_2_1_0 },
 	{ .compatible = "qcom,pcie-apq8064", .data = &ops_2_1_0 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &ops_2_3_2 },
 	{ .compatible = "qcom,pcie-ipq8074", .data = &ops_2_3_3 },
-- 
2.25.1

