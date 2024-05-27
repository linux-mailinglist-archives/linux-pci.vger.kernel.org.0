Return-Path: <linux-pci+bounces-7868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4EB8D0828
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 18:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6681D28A437
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 16:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA42E169AE6;
	Mon, 27 May 2024 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nRG74e6A"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E949169387;
	Mon, 27 May 2024 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826514; cv=none; b=HBHQcKCHVy+myPxVSFxWOqLJBAHJu8SPWPToPtzNs0msFWcpwgxosZNj7gE7FLSarL5a9hcZndQjJamQvv0T7WjovTHTY3nEjp7dERd05gudVOf2fFNVylbIKnDdi13YUpn4q+4bDxo0AqoIesiriJBTuS6oRFpVu2xd1HlxCrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826514; c=relaxed/simple;
	bh=7biFMyr8CXy0R1UVAUiDgnLTqYU6ZUjkIFA6XHx8ITY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8VJ5NYpgaCl8t3tUoHktzoGSHWdzjG83vWiqzrBPq2woHxDSo6vWUZxPqnEjsStIt7oWXyhuohe9YOGU7mJ5noL1nUgfFE+eZ1cf7VQmrZoAZEl+MQxHr5gxlEQ69rkfu1QtGrOsvTMx7hvwlen6d6w/zQnT9FfnvmNAL09uXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nRG74e6A; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id E9899FF80C;
	Mon, 27 May 2024 16:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716826511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C0FElzUrrqTg+6Zrh4rlEJ/rv8Dcx7Vbub0Y2cEk6FE=;
	b=nRG74e6ADGPIgwQsZuZBPe2LcWBuaXAzegAM7AbrhXlZhxCR880uyAgg/LWEAxtQpaMRmE
	AQqGHgGFzWjTc6p2gKF1Iaz1tIPSpYJjQDvQDTa08KCTB82evOwKwFxsQhGn2LHimY6Pot
	dWuga1MB+Dc00u7OKeXCacQQOqOOLOYWWKs1uwwDD6w7GMynB9tFljHGdHiWZFKa0XZ2gK
	pqAvbGL59bvXUHBIH4bxYe2sm+fj3RpXGgZaZ6frFHlmaxkw4gOqSYbKsjJuz1hQbOUX6p
	178Afcvx1Hz6ie/kn6DykBmZQBr+6SFaxhSHJB45DFaZCXgHrD4ZpzafnzJovA==
From: Herve Codina <herve.codina@bootlin.com>
To: Simon Horman <horms@kernel.org>,
	Sai Krishna Gajula <saikrishnag@marvell.com>,
	Herve Codina <herve.codina@bootlin.com>,
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
Subject: [PATCH v2 07/19] net: mdio: mscc-miim: Handle the switch reset
Date: Mon, 27 May 2024 18:14:34 +0200
Message-ID: <20240527161450.326615-8-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240527161450.326615-1-herve.codina@bootlin.com>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
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
index c29377c85307..62c47e0dd142 100644
--- a/drivers/net/mdio/mdio-mscc-miim.c
+++ b/drivers/net/mdio/mdio-mscc-miim.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 
 #define MSCC_MIIM_REG_STATUS		0x0
 #define		MSCC_MIIM_STATUS_STAT_PENDING	BIT(2)
@@ -271,10 +272,17 @@ static int mscc_miim_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct regmap *mii_regmap, *phy_regmap;
 	struct device *dev = &pdev->dev;
+	struct reset_control *reset;
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
2.45.0


