Return-Path: <linux-pci+bounces-6847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4878B6CF9
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 10:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C94281AAB
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 08:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74D51292FF;
	Tue, 30 Apr 2024 08:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ei6Cc0i5"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F61128376;
	Tue, 30 Apr 2024 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466357; cv=none; b=i4ZIJMf1MTJbPzeOS0RBnr/iOhpmbaOax0xzUK7LNpQNFSPQfhFB21c9ULg/9NO+f/V/KPspfrmw/NUbBWqaZH2Hf8UDKHWiKNmVmMg72F9NekhtR3ofOKdDh0yp1fBYuwi/AkyetjaBnDc5PR9RE2ABn573Rs2nXIA2Rz3AGlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466357; c=relaxed/simple;
	bh=QvIZPcFIxECl5ypxatKmykPf8ABcwLk+5NAwN21I9+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cSeWZfS4gnZsMfgMa+rQoBkvubbPbXWOi6L3m3zV0j5X8f4Z34o+k6+mqS+GsES/iC3Z4bCRkDlaOhFZVY/FblhzS1VdDhAb1GoeMENVkmwf56NHCd6eG8pPxfTXbkE+ewzCtJ+Q2eCDSlY9Qi1kKLuQ2dcFveOzJgAbRaaI5DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ei6Cc0i5; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id E117B20010;
	Tue, 30 Apr 2024 08:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714466353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qxAq7qxzKoem8aXbH9fXtuWzQPqQzhAER6fvu7zb1R4=;
	b=ei6Cc0i5Tyy6hry1zGIuvQ738sLwbRXunJcfF5AXysqct4QsgJI1HqHFs5KG5LW6qrGPX4
	NrKBs8HIy8IYahz7V0CtSsHA14Fsb3pCZjnRfliX9knEypLMmO6mAcI6nYK2djDCI88vqP
	edWu0zy+Y9dUbMZNcm3Cg+ZssEjU6FTHBBBEeIS4eqFixUCraHl3mFFigtomyo17bOXHWp
	hmtGGLrlWfo+aJaB/ixdz9fq/btWAre7sYQMti3JLyJO4W5WrVSneohrBnhYJ4p+CTJJ8w
	sRsxu8MQKxmpVLAI2VxKXfWCdKS/jwRyokyBEQ6bEU3SiJ+8NEI4yYjECkl5+g==
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH 03/17] reset: mchp: sparx5: Release syscon when not use anymore
Date: Tue, 30 Apr 2024 10:37:12 +0200
Message-ID: <20240430083730.134918-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430083730.134918-1-herve.codina@bootlin.com>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
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
2.44.0


