Return-Path: <linux-pci+bounces-14149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D92EE997D63
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 08:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 754F0B2218C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 06:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCE71BBBF7;
	Thu, 10 Oct 2024 06:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OHoRfRhX"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5181B533F;
	Thu, 10 Oct 2024 06:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728542185; cv=none; b=PJDyoVhgHXlE8vnW3iDrJcJa4/1y2jYwThJ+bUTeqo3gG3Zecpuz2IO4qpugVf4SjtL5E2nA+Fipt55OnKGeBIOonxMXPbdRQIUK/QUEAJhYYB78joIY1xE6JBvI4B4YHmoZl0A2QtoGLMtFbctvnbzP86vzJePIICWIzJYjvQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728542185; c=relaxed/simple;
	bh=+SVdKl1IWa/HJRCY4IavIoOe2teX0PV4vUDkok6B1lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpRQ3XYlZzHGveLJMvEkEvqwQ5uikL9uJFuhs9hc0e8lr2K7t02t06OinMzsO5dX78F3NnKVkV/lEZGKVY4JRT5O3E4yWfhf+WZaWA3tSMXp93jW4cCgey+Hgy+vZ7tE1N6UtcVCnnThgPAls8COqFNcNHqb0xWdETCVjWObmvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OHoRfRhX; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 8025C1C0002;
	Thu, 10 Oct 2024 06:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728542181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfuIYqw7th60ZTkt8Ycp++b+l5ZZV6kmbe9D3MS4HFQ=;
	b=OHoRfRhXY4aHRMqd/QxPPu0rhMN7W6kyD/O2jRTHAXimoGP3d0WjQCwS8PsWY9hvWUcVID
	w/I0Kb2BJG9sWyE8Dld10TGvLRqAa0xBtAqiLx+2nc8nwHRDRiJSGy+EPvG6iXoCKT3hIJ
	2hSgN4+KHlzAIVq0nSv/yg60+Qgd+gboyOrpxUWp8u5yHIq/nrjNMqtmI0EBPqSiWcKW6q
	iKFLDO6HngyGcZpWoz5KoluLRa59TXGSdPBbanMCQdVwKphfr0PAjFi2lBjME1BvJjTY6N
	v9cDrGQ5liIp3ENPqbeiC30Pctv1s4eqgeoShOyaQePiV142EIVK0wXaBc86KQ==
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
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v9 3/6] reset: mchp: sparx5: Map cpu-syscon locally in case of LAN966x
Date: Thu, 10 Oct 2024 08:36:03 +0200
Message-ID: <20241010063611.788527-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010063611.788527-1-herve.codina@bootlin.com>
References: <20241010063611.788527-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

In the LAN966x PCI device use case, the syscon API cannot be used as
it does not support device removal [1]. A syscon device is a core
"system" device and not a device available in some addon boards and so,
it is not supposed to be removed. The syscon API follows this assumption
but this assumption is no longer valid in the LAN966x use case.

In order to avoid the use of the syscon API and so, support for removal,
use a local mapping of the syscon device.

Link: https://lore.kernel.org/all/20240923100741.11277439@bootlin.com/ [1]
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/reset-microchip-sparx5.c | 35 +++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
index 636e85c388b0..48a62d5da78d 100644
--- a/drivers/reset/reset-microchip-sparx5.c
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -62,6 +62,28 @@ static const struct reset_control_ops sparx5_reset_ops = {
 	.reset = sparx5_reset_noop,
 };
 
+static const struct regmap_config mchp_lan966x_syscon_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+static struct regmap *mchp_lan966x_syscon_to_regmap(struct device *dev,
+						    struct device_node *syscon_np)
+{
+	struct regmap_config regmap_config = mchp_lan966x_syscon_regmap_config;
+	resource_size_t size;
+	void __iomem *base;
+
+	base = devm_of_iomap(dev, syscon_np, 0, &size);
+	if (IS_ERR(base))
+		return ERR_CAST(base);
+
+	regmap_config.max_register = size - 4;
+
+	return devm_regmap_init_mmio(dev, base, &regmap_config);
+}
+
 static int mchp_sparx5_map_syscon(struct platform_device *pdev, char *name,
 				  struct regmap **target)
 {
@@ -72,7 +94,18 @@ static int mchp_sparx5_map_syscon(struct platform_device *pdev, char *name,
 	syscon_np = of_parse_phandle(pdev->dev.of_node, name, 0);
 	if (!syscon_np)
 		return -ENODEV;
-	regmap = syscon_node_to_regmap(syscon_np);
+
+	/*
+	 * The syscon API doesn't support syscon device removal.
+	 * When used in LAN966x PCI device, the cpu-syscon device needs to be
+	 * removed when the PCI device is removed.
+	 * In case of LAN966x, map the syscon device locally to support the
+	 * device removal.
+	 */
+	if (of_device_is_compatible(pdev->dev.of_node, "microchip,lan966x-switch-reset"))
+		regmap = mchp_lan966x_syscon_to_regmap(&pdev->dev, syscon_np);
+	else
+		regmap = syscon_node_to_regmap(syscon_np);
 	of_node_put(syscon_np);
 	if (IS_ERR(regmap)) {
 		err = PTR_ERR(regmap);
-- 
2.46.2


