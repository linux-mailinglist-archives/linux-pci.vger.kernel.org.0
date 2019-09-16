Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCB6B3A9E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 14:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732826AbfIPMub (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 08:50:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45205 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732832AbfIPMub (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 08:50:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id r5so4780483wrm.12
        for <linux-pci@vger.kernel.org>; Mon, 16 Sep 2019 05:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v37YRUaZlEabq7YVJ6vC/oIxKBbvZ5ttPDUZlrXerbs=;
        b=FwV6HXM0xB9Sh5RDBNWs3vbJHkS4oiOfhW7BDcNZBH7xC46IXYZrUs/HdYuFS1JlL9
         1bJL1V5fydViQpgtBBuhmSylQakstrzh4srNFkHZZpfS+/2HTPO16PTOzGVUpKOta+Ga
         dA036vTgnAfozK02GiTzbDHqg+/igLznRXI1ocDxmXlJV2L9d21hdCtwPeAMhrhQSRYP
         f1GxLOwj09j+Dw1oVbvk59VzqVo5LbQZmBP8SKKLLhEQNo3475PM6Z1GZ1b1xIc9VxQ8
         wcFbdA0BQ5Uo9Cd8vVwewOY1LDEfiJXkWdXa0T37QX22JsuqbOFbMz8gGodVvM98HZV8
         qHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v37YRUaZlEabq7YVJ6vC/oIxKBbvZ5ttPDUZlrXerbs=;
        b=GG5uoMqBWjazx0P+Qz4O4RFcUX2FqgLsL2eJ5k/IFljW7FOYua2PPlboyGGCnMo9Zk
         KjQ9diLKwLyjqwpxx2ExGvZlBdFR4t4Er18CbPa1YDkGIxqcKind0Bdd/YIY+0eusXMS
         GWLrtHXq22RhcnJFMhNviO2wcFAzPpfEyoeBCpn7bZDk+xLMxx6gwWVVxHiC80zsAFTN
         Hdwqz9jEIzgfgUXX9kXj1aOK8hwYOUJAv4axEwEV7LRP5PWmGkN5eq2CirKLzNJVwQqx
         kydEI87YS5ueofFImZ0S36E+gMTCRXXOx9aXcbM5hKx6u1a/4H3Pdm1GSEAh0Ku+kfb4
         GfSA==
X-Gm-Message-State: APjAAAUz4mp/B82d6f9EYBRrcOtvXspyEb4oiiPWfikNJrCsh4FCjOkC
        H2AK/2WpMEmBiqVdB0fQ/pUxEg==
X-Google-Smtp-Source: APXvYqxqo0DsebMgSsfjoDkyv3+h2AlrRYOajCRyv1V+zM8U63v4xh8a32dBZWvtCncxQqLL5AOSzQ==
X-Received: by 2002:a5d:668d:: with SMTP id l13mr8313545wru.279.1568638228805;
        Mon, 16 Sep 2019 05:50:28 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o12sm15109960wrm.23.2019.09.16.05.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 05:50:28 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, lorenzo.pieralisi@arm.com, kishon@ti.com,
        bhelgaas@google.com, andrew.murray@arm.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yue.wang@Amlogic.com, maz@kernel.org, repk@triplefau.lt,
        nick@khadas.com, gouwa@khadas.com
Subject: [PATCH v2 4/6] phy: meson-g12a-usb3-pcie: Add support for PCIe mode
Date:   Mon, 16 Sep 2019 14:50:20 +0200
Message-Id: <20190916125022.10754-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190916125022.10754-1-narmstrong@baylibre.com>
References: <20190916125022.10754-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This adds extended PCIe PHY functions for the Amlogic G12A
USB3+PCIE Combo PHY to support reset, power_on and power_off for
PCIe exclusively.

With these callbacks, we can handle all the needed operations of the
Amlogic PCIe controller driver.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../phy/amlogic/phy-meson-g12a-usb3-pcie.c    | 70 ++++++++++++++++---
 1 file changed, 61 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
index ac322d643c7a..08e322789e59 100644
--- a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
+++ b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
@@ -50,6 +50,8 @@
 	#define PHY_R5_PHY_CR_ACK				BIT(16)
 	#define PHY_R5_PHY_BS_OUT				BIT(17)
 
+#define PCIE_RESET_DELAY					500
+
 struct phy_g12a_usb3_pcie_priv {
 	struct regmap		*regmap;
 	struct regmap		*regmap_cr;
@@ -196,6 +198,10 @@ static int phy_g12a_usb3_init(struct phy *phy)
 	struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
 	int data, ret;
 
+	ret = reset_control_reset(priv->reset);
+	if (ret)
+		return ret;
+
 	/* Switch PHY to USB3 */
 	/* TODO figure out how to handle when PCIe was set in the bootloader */
 	regmap_update_bits(priv->regmap, PHY_R0,
@@ -272,24 +278,64 @@ static int phy_g12a_usb3_init(struct phy *phy)
 	return 0;
 }
 
-static int phy_g12a_usb3_pcie_init(struct phy *phy)
+static int phy_g12a_usb3_pcie_power_on(struct phy *phy)
+{
+	struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
+
+	if (priv->mode == PHY_TYPE_USB3)
+		return 0;
+
+	regmap_update_bits(priv->regmap, PHY_R0,
+			   PHY_R0_PCIE_POWER_STATE,
+			   FIELD_PREP(PHY_R0_PCIE_POWER_STATE, 0x1c));
+
+	return 0;
+}
+
+static int phy_g12a_usb3_pcie_power_off(struct phy *phy)
+{
+	struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
+
+	if (priv->mode == PHY_TYPE_USB3)
+		return 0;
+
+	regmap_update_bits(priv->regmap, PHY_R0,
+			   PHY_R0_PCIE_POWER_STATE,
+			   FIELD_PREP(PHY_R0_PCIE_POWER_STATE, 0x1d));
+
+	return 0;
+}
+
+static int phy_g12a_usb3_pcie_reset(struct phy *phy)
 {
 	struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
 	int ret;
 
-	ret = reset_control_reset(priv->reset);
+	if (priv->mode == PHY_TYPE_USB3)
+		return 0;
+
+	ret = reset_control_assert(priv->reset);
 	if (ret)
 		return ret;
 
+	udelay(PCIE_RESET_DELAY);
+
+	ret = reset_control_deassert(priv->reset);
+	if (ret)
+		return ret;
+
+	udelay(PCIE_RESET_DELAY);
+
+	return 0;
+}
+
+static int phy_g12a_usb3_pcie_init(struct phy *phy)
+{
+	struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
+
 	if (priv->mode == PHY_TYPE_USB3)
 		return phy_g12a_usb3_init(phy);
 
-	/* Power UP PCIE */
-	/* TODO figure out when the bootloader has set USB3 mode before */
-	regmap_update_bits(priv->regmap, PHY_R0,
-			   PHY_R0_PCIE_POWER_STATE,
-			   FIELD_PREP(PHY_R0_PCIE_POWER_STATE, 0x1c));
-
 	return 0;
 }
 
@@ -297,7 +343,10 @@ static int phy_g12a_usb3_pcie_exit(struct phy *phy)
 {
 	struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
 
-	return reset_control_reset(priv->reset);
+	if (priv->mode == PHY_TYPE_USB3)
+		return reset_control_reset(priv->reset);
+
+	return 0;
 }
 
 static struct phy *phy_g12a_usb3_pcie_xlate(struct device *dev,
@@ -326,6 +375,9 @@ static struct phy *phy_g12a_usb3_pcie_xlate(struct device *dev,
 static const struct phy_ops phy_g12a_usb3_pcie_ops = {
 	.init		= phy_g12a_usb3_pcie_init,
 	.exit		= phy_g12a_usb3_pcie_exit,
+	.power_on	= phy_g12a_usb3_pcie_power_on,
+	.power_off	= phy_g12a_usb3_pcie_power_off,
+	.reset		= phy_g12a_usb3_pcie_reset,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.22.0

