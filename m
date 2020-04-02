Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAEF19C0C9
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 14:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbgDBMMO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Apr 2020 08:12:14 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35342 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388318AbgDBMMO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Apr 2020 08:12:14 -0400
Received: by mail-ed1-f65.google.com with SMTP id a20so3823099edj.2;
        Thu, 02 Apr 2020 05:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=siYXJ0KfUOVO29qQPm4eyONLoVr/YpaUx1vSJEqMS2g=;
        b=O7yp4kXD1dc2cH7QAbryxdYwYQPDMgjZn8y06TzsMomTXOGLloWUdF0AH9tkY+fpGZ
         2h6QbrctZurRQI2Qil1UeMNRpImEyIE0yZLA5usWcZz6XfqmnvoF9Uz00XLBUcQ1boxC
         4RDIiNvx6TOICGasmCWQCce4dckB/WlULHsb8JA2ehg+g+4zL7YgF2Ns9VaJl5TaS1oO
         gePFaWScSwuhaEpJFqte+MzptMpYxvRlgkaVrzENrP8Ivihk3ZxbNDXP22tI4vjXlxvx
         kTinewkrlfizHQfaoY6GGb/n6ioI5mDd5ubH+CgV7BcgIBxDnN+m3qDk7sDScpdAxmvl
         eEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=siYXJ0KfUOVO29qQPm4eyONLoVr/YpaUx1vSJEqMS2g=;
        b=URFOqU488NcS3oIMUnnFCnsZD92sT+MWdIBU+oyTLHLrZnXPrNOraaMFnFxi5cjDlw
         wDC/+cjFnHVp9QCsXANy5cuZROXGZPXXTdoIQM9bKQ3E0xvYvGVPa4n/TRvMjcwdnz2X
         uoXy+BLwh038vGBX30ddR1D7W8i0TV+6ob/hctzvR3RzIayjLaR1fgl0KUBc5OEnsQGQ
         sFfX+6hxgsLiiZsE+WKtVl07bMix84ETFOdENDp0ZR4Qfwg4W6/0N0oIQgIaEltm8O9/
         1/A+3EbHhslcD7bwkTWblXH1p2wCpVgJ/Ie+oHx6nUa3Fz+16IAK1FJz0GnHGxhXR459
         YF3A==
X-Gm-Message-State: AGi0PubHbn2vCb4VvELeD7bOffSu3aVKF74w+rSrZpK9o2UdMRsw7owS
        JYOpjUwwEcfqC8K4JmPGDqk=
X-Google-Smtp-Source: APiQypLl21LPxvZAZ1mpYDoTheGcJsI0a0ylEMWBlnokwvYvhkS7RNpTe49pyiEln83KUEnLseNHjQ==
X-Received: by 2002:a05:6402:13c8:: with SMTP id a8mr2664671edx.245.1585829531667;
        Thu, 02 Apr 2020 05:12:11 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host250-251-dynamic.250-95-r.retail.telecomitalia.it. [95.250.251.250])
        by smtp.googlemail.com with ESMTPSA id w20sm1083611ejv.40.2020.04.02.05.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 05:12:11 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
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
Subject: [PATCH v2 07/10] PCIe: qcom: fix init problem with missing PARF programming
Date:   Thu,  2 Apr 2020 14:11:44 +0200
Message-Id: <20200402121148.1767-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200402121148.1767-1-ansuelsmth@gmail.com>
References: <20200402121148.1767-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PARF programming was missing and this cause initilizzation problem on
some ipq806x based device (Netgear R7800 for example). This cause a
total lock of the system on kernel load.

Fixes: 82a82383 PCI: qcom: Add Qualcomm PCIe controller driver
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 48 +++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 211a1aa7d0f1..77b1ab7e23a3 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -46,6 +46,9 @@
 
 #define PCIE20_PARF_PHY_CTRL			0x40
 #define PCIE20_PARF_PHY_REFCLK			0x4C
+#define REF_SSP_EN				BIT(16)
+#define REF_USE_PAD				BIT(12)
+
 #define PCIE20_PARF_DBI_BASE_ADDR		0x168
 #define PCIE20_PARF_SLV_ADDR_SPACE_SIZE		0x16C
 #define PCIE20_PARF_MHI_CLOCK_RESET_CTRL	0x174
@@ -77,6 +80,18 @@
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
+#define PCIE20_PARF_CONFIG_BITS		0x50
+#define PHY_RX0_EQ(x)				(x << 24)
 
 #define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
 #define SLV_ADDR_SPACE_SZ			0x10000000
@@ -184,6 +199,16 @@ struct qcom_pcie {
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
 
+static inline void qcom_clear_and_set_dword(void __iomem *addr,
+				 u32 clear_mask, u32 set_mask)
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
@@ -304,7 +329,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	u32 val;
 	int ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
@@ -355,15 +379,21 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 		goto err_deassert_ahb;
 	}
 
-	/* enable PCIe clocks and resets */
-	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
-	val &= ~BIT(0);
-	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_PHY_CTRL, BIT(0), 0);
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
+	/* enable reference clock */
+	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_PHY_REFCLK,
+		      REF_USE_PAD, REF_SSP_EN);
 
 	ret = reset_control_deassert(res->phy_reset);
 	if (ret) {
-- 
2.25.1

