Return-Path: <linux-pci+bounces-13758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B594698EB65
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 10:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC7F1C21F2C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 08:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4165C14D283;
	Thu,  3 Oct 2024 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VQDbWFnR"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8395139566;
	Thu,  3 Oct 2024 08:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943489; cv=none; b=gztxXz5pGuap2m5tOMYNhCwpBwCT2NVVCBE9roeerR+qY7ckQsA/arKnPGG3ARJW2Yl3OzFVd7dOUp4IuqOjM4SDUgoisIPvH6z2T8Viz+SdpqJ5Z2WfvXDGdMjVQjc6dI9URvWurQLrCdvbh1HPKq9AqloCpdSqMAAAxHX/m4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943489; c=relaxed/simple;
	bh=JBvgdSTm4TaKBIYGu/Ed4nV6mwdMwnaUrsH4h3Z8PEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=di9cfg2UliwpxSZY+eErymR6er0b3uLZo3MUIxxSjr6x3Ddhg6tsgXqSEoLQ4k4e9g6YylSVp/Q9C2DiWlaUGCH8/ikV/Ma44aVuJt939FbFz6xqj83ILT4Yq6URD9IfghToLG0kLHlguHLFa1mgZaLDacnUMUvMK+wEd/Ir4U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VQDbWFnR; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id AD891E0011;
	Thu,  3 Oct 2024 08:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727943485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZR904yq1HjgSxKBuw38kgqccc+ttNjuVW/ElKOGq4Oc=;
	b=VQDbWFnRnumAmgLWYYXAiTK54ExKXj9f8mq0eofPyKMuu39aQyPr7spnixTojCLdu64mxh
	FCQ1H2xr50P3GPt2gtq4o5DbeTZIJioKSr7K+bJAyZMbeRAxnTE00/n4nPqt9FsGY07P6V
	sSr9PWDggwrZ3I3rvAnW5sQHemlstmG5eCxoGXM8l5Ld8+m3aMI4XBX/gA9w1vlYpwuVMR
	iGjuafWaH9JQTO5baes3505edYKXWyRo6Am3857eiydlm1R2p/NJGlR2XMZj9yH5ES8+un
	KNGTHHQqy/as5pMUTYJNuZg/OCBIqGn3CrA59Q7APE61ocl21vLL1zSPUA6TKw==
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH v7 5/6] reset: mchp: sparx5: Allow building as a module
Date: Thu,  3 Oct 2024 10:16:42 +0200
Message-ID: <20241003081647.642468-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241003081647.642468-1-herve.codina@bootlin.com>
References: <20241003081647.642468-1-herve.codina@bootlin.com>
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

This reset controller can be used by the LAN966x PCI device.

The LAN966x PCI device driver can be built as a module and this reset
controller driver has no reason to be a builtin driver in that case.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 drivers/reset/Kconfig                  | 2 +-
 drivers/reset/reset-microchip-sparx5.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 86a5504950cb..93cddbe8609b 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -146,7 +146,7 @@ config RESET_LPC18XX
 	  This enables the reset controller driver for NXP LPC18xx/43xx SoCs.
 
 config RESET_MCHP_SPARX5
-	bool "Microchip Sparx5 reset driver"
+	tristate "Microchip Sparx5 reset driver"
 	depends on ARCH_SPARX5 || SOC_LAN966 || MCHP_LAN966X_PCI || COMPILE_TEST
 	default y if SPARX5_SWITCH
 	select MFD_SYSCON
diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
index 48a62d5da78d..c4cc0edbb250 100644
--- a/drivers/reset/reset-microchip-sparx5.c
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -191,6 +191,7 @@ static const struct of_device_id mchp_sparx5_reset_of_match[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(of, mchp_sparx5_reset_of_match);
 
 static struct platform_driver mchp_sparx5_reset_driver = {
 	.probe = mchp_sparx5_reset_probe,
@@ -213,3 +214,4 @@ postcore_initcall(mchp_sparx5_reset_init);
 
 MODULE_DESCRIPTION("Microchip Sparx5 switch reset driver");
 MODULE_AUTHOR("Steen Hegelund <steen.hegelund@microchip.com>");
+MODULE_LICENSE("GPL");
-- 
2.46.1


