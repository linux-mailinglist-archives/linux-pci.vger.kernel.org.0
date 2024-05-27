Return-Path: <linux-pci+bounces-7864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A75B8D08A4
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 18:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96B9BB2A4D2
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 16:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8B3161306;
	Mon, 27 May 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LtHFpVXe"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B240161305;
	Mon, 27 May 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826508; cv=none; b=Hcdz6jup2RAjPNwLd6ZnQ+FAnRB366oMePrPUp4vRoftz9dcmB/xahx2Eqj6aHA189rQDRVcbSx8AWxJ9CigwZnoyneFDU75MbN2f3fUszvVtdTlbvlBB5fazXNOzJ0IlKBfMPXA31g58Uu1HKB0Rv5x0LCAeB1dCBU/7mmJ+44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826508; c=relaxed/simple;
	bh=wDXdXZDe5krRitdqjY8S6IfoignV9HVmYqJZDUl7H6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYlssVil9zusyPinWdXvigVb5Cy1EhtZYX0fszBQuBri5Bozk5ggjnUlIRQfh+6MMUDRjG439OrNeAsIXZGV10qY6fIUDX3KWGi5utXq5Z7bmUIVu6uoOxy7YVG6bv3pnHIK8RJAnb4ZQszjwkIvPAaAxizeAS8lkbovNk4Qo7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LtHFpVXe; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 32A06FF814;
	Mon, 27 May 2024 16:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716826503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6TlKweuD4lCqBxL9SdGBmVX01IhcfhXMnuiuGHqhBE=;
	b=LtHFpVXekRIXkrs7LdaUhIszxGChykZckIjc6rfeFQbR143lKPfrrkGozoUsSbCANSU8G+
	DAmdTGQug3jbxQXkSTixWiSMeho85cZrdJXuo8EvFlE3CJvBN0k0WQeQ6D2JJPS8XAK+ix
	/JsVq2vmdTcuL0T+uKMtiOoU0UBJDVOTssifl+cnHUXqh6AIRVT90KgZLq7IGwru/d2Q8L
	wrzKQiNZSdgUopemE8Ppfor34GyNDBJIa8XNtOrtHgsMx3wdVvbs6A7P/Zs8oXUNHVprrH
	ZJgCcgoKQw5Cz/ep1BehMie58Ui9546uvoVSMLXNrFa4o2I72pRBJut3359Lng==
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH v2 03/19] reset: mchp: sparx5: Release syscon when not use anymore
Date: Mon, 27 May 2024 18:14:30 +0200
Message-ID: <20240527161450.326615-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240527161450.326615-1-herve.codina@bootlin.com>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

From: Clément Léger <clement.leger@bootlin.com>

The sparx5 reset controller does not release syscon when it is not used
anymore.

This reset controller is used by the LAN966x PCI device driver.
It can be removed from the system at runtime and needs to release its
consumed syscon on removal.

Use the newly introduced devm_syscon_regmap_lookup_by_phandle() in order
to get the syscon and automatically release it on removal.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/reset/reset-microchip-sparx5.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
index 69915c7b4941..c4fe65291a43 100644
--- a/drivers/reset/reset-microchip-sparx5.c
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -65,15 +65,11 @@ static const struct reset_control_ops sparx5_reset_ops = {
 static int mchp_sparx5_map_syscon(struct platform_device *pdev, char *name,
 				  struct regmap **target)
 {
-	struct device_node *syscon_np;
+	struct device *dev = &pdev->dev;
 	struct regmap *regmap;
 	int err;
 
-	syscon_np = of_parse_phandle(pdev->dev.of_node, name, 0);
-	if (!syscon_np)
-		return -ENODEV;
-	regmap = syscon_node_to_regmap(syscon_np);
-	of_node_put(syscon_np);
+	regmap = devm_syscon_regmap_lookup_by_phandle(dev, dev->of_node, name);
 	if (IS_ERR(regmap)) {
 		err = PTR_ERR(regmap);
 		dev_err(&pdev->dev, "No '%s' map: %d\n", name, err);
-- 
2.45.0


