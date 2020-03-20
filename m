Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98B4018D742
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 19:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgCTSf0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 14:35:26 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35068 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCTSfX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 14:35:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id a20so8340211edj.2;
        Fri, 20 Mar 2020 11:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WNYRUFULee31Lm1KjTnY4zWnox8RMFbDtxuR2OFtEzI=;
        b=Yr8IMgYk/OnIfQBt54c2/wu5QbUMQsW4KWuVelx32qiWM+p71p49krEnEI3faLzgNo
         T1CcLUikSCzQDVsWxrismxeWwBSBl0F2FjmttruqEgh5Wq0WH33EVpqyNWlSC14YwgDr
         skKYJO/CLYDZIhetBwCNNXsfyCOWqDHa54EAM5DDtW6gdtNNVYs+XaOOxOCoMh7P8fLK
         vHNT1iSae8VqX+2N0CuLRBQ+ulZ+oOgXMhERNIaLhXgWRPVe+rcNhS9S10udY7ZNbNhl
         Mkg/8LGglLDipNrve1h1pRvBk86x068vnRkj7Gsg6zaK7Tgkk+O4651hw8MsqyK9CQ9q
         HD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WNYRUFULee31Lm1KjTnY4zWnox8RMFbDtxuR2OFtEzI=;
        b=W8a/uyud3y1w4UlQDV38g3TOctGm6OhMaCNXE4td7wZibxHnmgH49qCVpBAfI6qbzA
         4s08XDvcYcwX4gKD9jIxIY/vWF6hXVyG/F6YiNy5L7AOO4cPQRtYh5OyLTe0EoEmoXnr
         gHFjTK5V5nS2mqZJuH/Uddyqm/Qm2oNaI/wLEjlw73SCdTjA9YZFZf044YK3LUpo/LCh
         K5cbYecKkU16GTCBFz/VyQqtDuRBAIa5+yqdCU1KO6eOZrd8JM4xLoFFILcg+naCxi2n
         ZyiPtL8d32tZIFxzhsMBL0aJd/w+55xRkxPHvlO1AMd4YlugwwVjUw2fjXxvU4GzzSdF
         f/OA==
X-Gm-Message-State: ANhLgQ2E9PiFs+ZfS23NK0vW0aGHD1P2rP4MlaRmtldh82a4Lr+nJrqp
        kghLhl8DB287P6H+cZ5YsVQ=
X-Google-Smtp-Source: ADFU+vu8AW19omtsz4p5v1SCcaJKz9JTMA/bUWMxKE9V/XgDOHgX/qFmo+Ue2EvEDxfBuDtHV6Nyvw==
X-Received: by 2002:a50:cd5a:: with SMTP id d26mr9634264edj.65.1584729321016;
        Fri, 20 Mar 2020 11:35:21 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host203-232-dynamic.53-79-r.retail.telecomitalia.it. [79.53.232.203])
        by smtp.googlemail.com with ESMTPSA id y13sm172916eje.3.2020.03.20.11.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:35:20 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Sham Muthayyan <smuthayy@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
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
Subject: [PATCH 07/12] pcie: qcom: add tx term offset support
Date:   Fri, 20 Mar 2020 19:34:49 +0100
Message-Id: <20200320183455.21311-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320183455.21311-1-ansuelsmth@gmail.com>
References: <20200320183455.21311-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sham Muthayyan <smuthayy@codeaurora.org>

Add tx term offset support to pcie qcom driver
need in some revision of the ipq806x soc

Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 61 ++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ecc22fd27ea6..8009e3117765 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -45,7 +45,13 @@
 #define PCIE_CAP_CPL_TIMEOUT_DISABLE		0x10
 
 #define PCIE20_PARF_PHY_CTRL			0x40
+#define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	(0x1f << 16)
+#define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		(x << 16)
+
 #define PCIE20_PARF_PHY_REFCLK			0x4C
+#define REF_SSP_EN				BIT(16)
+#define REF_USE_PAD				BIT(12)
+
 #define PCIE20_PARF_DBI_BASE_ADDR		0x168
 #define PCIE20_PARF_SLV_ADDR_SPACE_SIZE		0x16C
 #define PCIE20_PARF_MHI_CLOCK_RESET_CTRL	0x174
@@ -77,6 +83,18 @@
 #define DBI_RO_WR_EN				1
 
 #define PERST_DELAY_US				1000
+/* PARF registers */
+#define PCIE20_PARF_PCS_DEEMPH			0x34
+#define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		(x << 16)
+#define PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(x)	(x << 8)
+#define PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(x)	(x << 0)
+
+#define PCIE20_PARF_PCS_SWING			0x38
+#define PCS_SWING_TX_SWING_FULL(x)		(x << 8)
+#define PCS_SWING_TX_SWING_LOW(x)		(x << 0)
+
+#define PCIE20_PARF_CONFIG_BITS			0x50
+#define PHY_RX0_EQ(x)				(x << 24)
 
 #define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
 #define SLV_ADDR_SPACE_SZ			0x10000000
@@ -97,6 +115,7 @@ struct qcom_pcie_resources_2_1_0 {
 	struct reset_control *phy_reset;
 	struct reset_control *ext_reset;
 	struct regulator_bulk_data supplies[QCOM_PCIE_2_1_0_MAX_SUPPLY];
+	uint8_t phy_tx0_term_offset;
 };
 
 struct qcom_pcie_resources_1_0_0 {
@@ -184,6 +203,16 @@ struct qcom_pcie {
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
 
+static inline void
+writel_masked(void __iomem *addr, u32 clear_mask, u32 set_mask)
+{
+	u32 val = readl(addr);
+
+	val &= ~clear_mask;
+	val |= set_mask;
+	writel(val, addr);
+}
+
 static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
 {
 	gpiod_set_value_cansleep(pcie->reset, 1);
@@ -277,6 +306,10 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
 	if (IS_ERR(res->ext_reset))
 		return PTR_ERR(res->ext_reset);
 
+	if (of_property_read_u8(dev->of_node, "phy-tx0-term-offset",
+				&res->phy_tx0_term_offset))
+		res->phy_tx0_term_offset = 0;
+
 	res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
 	return PTR_ERR_OR_ZERO(res->phy_reset);
 }
@@ -304,7 +337,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	u32 val;
 	int ret;
 
 	ret = reset_control_assert(res->ahb_reset);
@@ -355,15 +387,26 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 		goto err_deassert_ahb;
 	}
 
-	/* enable PCIe clocks and resets */
-	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
-	val &= ~BIT(0);
-	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+	writel_masked(pcie->parf + PCIE20_PARF_PHY_CTRL, BIT(0), 0);
+
+	/* Set Tx termination offset */
+	writel_masked(pcie->parf + PCIE20_PARF_PHY_CTRL,
+		      PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK,
+		      PHY_CTRL_PHY_TX0_TERM_OFFSET(res->phy_tx0_term_offset));
+
+	/* PARF programming */
+	writel(PCS_DEEMPH_TX_DEEMPH_GEN1(0x18) |
+	       PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(0x18) |
+	       PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(0x22),
+	       pcie->parf + PCIE20_PARF_PCS_DEEMPH);
+	writel(PCS_SWING_TX_SWING_FULL(0x78) |
+	       PCS_SWING_TX_SWING_LOW(0x78),
+	       pcie->parf + PCIE20_PARF_PCS_SWING);
+	writel(PHY_RX0_EQ(0x4), pcie->parf + PCIE20_PARF_CONFIG_BITS);
 
-	/* enable external reference clock */
-	val = readl(pcie->parf + PCIE20_PARF_PHY_REFCLK);
-	val |= BIT(16);
-	writel(val, pcie->parf + PCIE20_PARF_PHY_REFCLK);
+	/* Enable reference clock */
+	writel_masked(pcie->parf + PCIE20_PARF_PHY_REFCLK,
+		      REF_USE_PAD, REF_SSP_EN);
 
 	ret = reset_control_deassert(res->phy_reset);
 	if (ret) {
-- 
2.25.1

