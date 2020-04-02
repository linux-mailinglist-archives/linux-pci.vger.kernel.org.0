Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3DF819C0CA
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 14:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbgDBMMS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Apr 2020 08:12:18 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42945 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388344AbgDBMMR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Apr 2020 08:12:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id cw6so3770371edb.9;
        Thu, 02 Apr 2020 05:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qIsXnJxxk0m6qyI/yCLLK7erVOjynmxVwqiZQYZT6Zk=;
        b=GlqcSDTz/QooHwS6HQZubgExv3RoXWLWBwLA5xbY+YeXTQv9Rh7pWMZHA/FTz7gRmf
         MD4zznzIEJylxbej/Eh/dWr1iWuOSUbwfjNL63D+ydEH+Xj9klSbJs3qhizAPbJHPnN2
         x0UojCGrriafMDVPxwSx2vyLKKGmdi38xAkZJKM28lgDodWQg/iGO7heGPSVRmmgKM+0
         J8svawiUloXe1P1PLldkcKSrcLXhW93yAQIlPUJHp0DqEEcETkVEgIyDQS3mg7J8Ef/n
         IHgnb9k+5eVMueQ3mIknD6llOUpLVAyZ9DjEB6KzG4sPsGcDrzO4Qc1fPdPj5O9qcO6/
         5wDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qIsXnJxxk0m6qyI/yCLLK7erVOjynmxVwqiZQYZT6Zk=;
        b=Rjxq1ITnXe4T0Y9OVN//X5xGM1B0hq73gx9vKlX2gUPwFspb0C44EwGZdIXPv/b0/m
         nr29/UMMQSpOPiYemE0VImyl5MqLPNWWdT+4lPY6ugPPs9MKMOEgUz9h/weEZe2ya50d
         Z8nesG919LtoRhwkxEkCgH6xj4I0djX7X4Th+823EHLzvqlEl5rNqfy++RQG3WufCjV0
         YQBOENaCU7hkwGD8uxGG+iIM1Egv/ZjnVsjwSYjeVd/hoPImLeUmTEYhXrR9q1hbOJYB
         sff1bFXJJ1hUJNiclgaACQDnqyWunCiQW/U5veL8eRJFs2rEM1kt/kTrS8ngNDCPvvmA
         LdMQ==
X-Gm-Message-State: AGi0PuazeeJXdvQXwmnHRzsNzq/1mR09djwpoRe2oAqTkqjG8EItyWS0
        S7kVa3+dlp1mFxmJgWEIdGc=
X-Google-Smtp-Source: APiQypLL4gP6X44xDMXHVEPhCf8hemwmvrlF2t2duwBWHQY+2szbxcgdFMSmY6vvZiWsK4vC5dRo9w==
X-Received: by 2002:a05:6402:2076:: with SMTP id bd22mr2623617edb.348.1585829535167;
        Thu, 02 Apr 2020 05:12:15 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host250-251-dynamic.250-95-r.retail.telecomitalia.it. [95.250.251.250])
        by smtp.googlemail.com with ESMTPSA id w20sm1083611ejv.40.2020.04.02.05.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 05:12:13 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>
Cc:     Sham Muthayyan <smuthayy@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/10] PCIe: qcom: add ipq8064 rev2 variant and set tx term offset
Date:   Thu,  2 Apr 2020 14:11:45 +0200
Message-Id: <20200402121148.1767-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200402121148.1767-1-ansuelsmth@gmail.com>
References: <20200402121148.1767-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sham Muthayyan <smuthayy@codeaurora.org>

Add tx term offset support to pcie qcom driver need in some revision of
the ipq806x SoC.
Ipq8064 have tx term offset set to 7.
Ipq8064 v2 revision and ipq8065 have the tx term offset set to 0.

Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 77b1ab7e23a3..8047ac7dc8c7 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -45,6 +45,9 @@
 #define PCIE_CAP_CPL_TIMEOUT_DISABLE		0x10
 
 #define PCIE20_PARF_PHY_CTRL			0x40
+#define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(12, 16)
+#define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)	(x << 16)
+
 #define PCIE20_PARF_PHY_REFCLK			0x4C
 #define REF_SSP_EN				BIT(16)
 #define REF_USE_PAD				BIT(12)
@@ -112,6 +115,7 @@ struct qcom_pcie_resources_2_1_0 {
 	struct reset_control *phy_reset;
 	struct reset_control *ext_reset;
 	struct regulator_bulk_data supplies[QCOM_PCIE_2_1_0_MAX_SUPPLY];
+	uint8_t phy_tx0_term_offset;
 };
 
 struct qcom_pcie_resources_1_0_0 {
@@ -302,6 +306,11 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
 	if (IS_ERR(res->ext_reset))
 		return PTR_ERR(res->ext_reset);
 
+	if (of_device_is_compatible(dev->of_node, "qcom,pcie-ipq8064"))
+		res->phy_tx0_term_offset = 7;
+	else
+		res->phy_tx0_term_offset = 0;
+
 	res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
 	return PTR_ERR_OR_ZERO(res->phy_reset);
 }
@@ -381,6 +390,11 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 
 	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_PHY_CTRL, BIT(0), 0);
 
+	/* set TX termination offset */
+	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_PHY_CTRL,
+			PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK,
+			PHY_CTRL_PHY_TX0_TERM_OFFSET(res->phy_tx0_term_offset));
+
 	/* PARF programming */
 	writel(PCS_DEEMPH_TX_DEEMPH_GEN1(0x18) |
 	       PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(0x18) |
@@ -1494,6 +1508,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-apq8084", .data = &ops_1_0_0 },
 	{ .compatible = "qcom,pcie-ipq8064", .data = &ops_2_1_0 },
+	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &ops_2_1_0 },
 	{ .compatible = "qcom,pcie-apq8064", .data = &ops_2_1_0 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &ops_2_3_2 },
 	{ .compatible = "qcom,pcie-ipq8074", .data = &ops_2_3_3 },
-- 
2.25.1

