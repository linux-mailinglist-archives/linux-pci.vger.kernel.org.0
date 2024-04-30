Return-Path: <linux-pci+bounces-6851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 727238B6D0D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 10:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C13D1F23C89
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 08:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F43199E85;
	Tue, 30 Apr 2024 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PkKYwEje"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01A9146D60;
	Tue, 30 Apr 2024 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466364; cv=none; b=SLUZQNMxMmiW9N7M7KCyQTWtQPTvOMtkOC+GLo/K3h084DJXiRoF/O1ylGw99SY1zRgvKz7HiPNyBrA691LIiqEmUuD4KxRUG2O8eGyLAePGa7TqZgTJ4AD2ZUixn7g1hvaPCEN3rqcGVzyIHB3SAuD/uh7iveIvtcg6tZ72wwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466364; c=relaxed/simple;
	bh=UkUmDmxYo9Z/orbhrhvuP0Jxzv03WEWdvOtiwQ6A4GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3MxDiaV+FiO8Wfs7ZtsmC3A8WqBzmuTAXAUGei/JpyOdB6b5vlbNfM2omKhuUTuDUY15aXljZSdExmhrjV9CXus0VUUGV1SqTCG4zFhY4syiXcvAt34Z3ZC5OVyunl3uxsBC+Otc+TJRm1CjtWGN+q+1vajF22OMM48Fc51+Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PkKYwEje; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id BB5E320015;
	Tue, 30 Apr 2024 08:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714466360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dJSqGEJGADbhF8fZ9qZ11gAumSDZqofEqkJWMC7XU28=;
	b=PkKYwEjepQFKsmPU6ES8oP7VCvNCO36bwkdceo9QDNFq/F7RZ3nr1wEqVMQXpLNRsfS8bd
	cziQpMvEEs/fkqqFQOdR6e68ArlctCWQB9WEpulWhkT6eVQOzmEe6bzKt0jSQoW3s6eRlq
	tenycx1I7v3xqyhPDekJWpV8ny+LFellPQStsWMbmexdypZw5VkNzsdpg9cxHNQY7WjyAA
	qDxU7JA8FCyv5rt3jo5PFEuL/OjqoSibtnRLJTCIUpEH/cWz075udAmO4FrGSZFM8ShcZE
	9i/ubSDBuQuKESoZ6SPibEipQ6xeCEEHBF8x7i51AzUs7UCl/H0+dzJ/m5HEfw==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 07/17] net: mdio: mscc-miim: Handle the switch reset
Date: Tue, 30 Apr 2024 10:37:16 +0200
Message-ID: <20240430083730.134918-8-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430083730.134918-1-herve.codina@bootlin.com>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The mscc-miim device can be impacted by the switch reset, at least when
this device is part of the LAN966x PCI device.

Handle this newly added (optional) resets property.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/net/mdio/mdio-mscc-miim.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/mdio/mdio-mscc-miim.c b/drivers/net/mdio/mdio-mscc-miim.c
index c29377c85307..6a6c1768f533 100644
--- a/drivers/net/mdio/mdio-mscc-miim.c
+++ b/drivers/net/mdio/mdio-mscc-miim.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 
 #define MSCC_MIIM_REG_STATUS		0x0
 #define		MSCC_MIIM_STATUS_STAT_PENDING	BIT(2)
@@ -270,11 +271,18 @@ static int mscc_miim_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct regmap *mii_regmap, *phy_regmap;
+	struct reset_control *reset;
 	struct device *dev = &pdev->dev;
 	struct mscc_miim_dev *miim;
 	struct mii_bus *bus;
 	int ret;
 
+	reset = devm_reset_control_get_optional_shared(dev, "switch");
+	if (IS_ERR(reset))
+		return dev_err_probe(dev, PTR_ERR(reset), "Failed to get reset\n");
+
+	reset_control_reset(reset);
+
 	mii_regmap = ocelot_regmap_from_resource(pdev, 0,
 						 &mscc_miim_regmap_config);
 	if (IS_ERR(mii_regmap))
-- 
2.44.0


