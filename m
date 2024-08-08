Return-Path: <linux-pci+bounces-11490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E30594C1C0
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 17:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9531C221DB
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 15:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D447D190062;
	Thu,  8 Aug 2024 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V3S6EPii"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887F618C925;
	Thu,  8 Aug 2024 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132064; cv=none; b=u9M/MHcUwYxjwqL/6TGPXEGLnOspI0TGdx4BY5lKaUWQcf+cQMTPzDQl89ML8TavxUBoNADiFLozdNjO/ZoO8UG7yZ0Z9x7ven6KrPmqwTKAzxnh1+kAtGrbrWPLn4b7J2SohfP8/mGQ6MqgFNu5Eg4eKmwk9cUD1U5mhUeqruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132064; c=relaxed/simple;
	bh=l5FjrOQYITOyjVxkJZZpKt0ln/rAz+4YjTxwXZkgUv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDO0WEFN0q8YPirrwJJpUPSQGC9K1KrFJyRIjueTDoNPbvwzlEK3IrVh+Iq2HzBRBbiD9FMoA6vywKOJKeaDH58ZbpCZCSWUlYSO8QCkSAAyIN1v5lsSTuGv6fFkrK4MjF3sZtyg6gJdokSNXhqlGhlzQZY64I94EuuLe6pfDzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V3S6EPii; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 85E8820008;
	Thu,  8 Aug 2024 15:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723132061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQJa/uO3moMWBYvBHYzg1OLE26y6a/vVj3qon89DFNU=;
	b=V3S6EPiiO7hU/lfn8GItH0QN2Fdt5nf+LNmqem3F3TMZAbIY2T5qQObXIbLsNPpyv023fn
	UAFC7ezwmM5Gm6I/PjpsYwOijC3r/mUMyg5QA4/k+lcGXKydG/b4YjSGIZDNgx6k+VGhoO
	uUb47YMFKF+0hFDRCjB4wphXKmkJF18m72HLKCyvxa3L8HaVyS3MZ/OJLGS9bH8314ddQW
	cysoIFTXMbyL6vIZx1eLfTsf+rK0J3TlqqxBrVLpSejcewQgeu33tKolbremA6KzHuz+qA
	y39A2JZovYEriiyS0PWB7cLrXMHm7K7NEXogFW+hWGdapQ6VPBVMVVzLZg5Dew==
From: Herve Codina <herve.codina@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH v5 6/8] reset: mchp: sparx5: Release syscon when not use anymore
Date: Thu,  8 Aug 2024 17:46:55 +0200
Message-ID: <20240808154658.247873-7-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240808154658.247873-1-herve.codina@bootlin.com>
References: <20240808154658.247873-1-herve.codina@bootlin.com>
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
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
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


