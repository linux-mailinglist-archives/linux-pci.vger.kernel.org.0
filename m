Return-Path: <linux-pci+bounces-11293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E5B947948
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 12:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B78B1F21F22
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 10:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4780F156C7B;
	Mon,  5 Aug 2024 10:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lFe8RMMX"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59D3155740;
	Mon,  5 Aug 2024 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853193; cv=none; b=FhbzmD/9TqkItyZIHqVNT72D8utqsYn1bxV6j3jWOKUVVIvrcfB+SH3O1TeMJdsy32RtkWYWDU6oC+Csx7yI760qbTv4TVZQCzwYTH09wC8lJB5uNG3UYB/n9cb8SMjVb5o0qX80pzyeJKWbU5kWHnQgSfhd80B2WvTFn4Xgk7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853193; c=relaxed/simple;
	bh=qyqDgT7lBKRF+3zP/gmUm73VZ30anbibmMmBYwSg0BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WsaWKmNqzhVMrlQnQ5cYP+94iNB9AwDcT82F0HRksxrYrEbCR0r/HZme/plq6edB+pr1av6EuVX4ndWTlz4qilnFDIMjb0wKebCp+HiCk8oGDhk7UKKInS3Gap/MKpyIFhiNhiiGFCyE6FrPnVb/jW6GCX4v7+iSOORdr82Hm9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lFe8RMMX; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id A8EDB20008;
	Mon,  5 Aug 2024 10:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722853189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MIgFxs9jjPssgTCtVZyeLPXhm7s22HvwTUxfstwNS6M=;
	b=lFe8RMMXwt81CPZoitAdYQL5PlMblbWc+vy2HfQOgsTJtDEtKCvAZdN09Aahtu9xs07sTR
	JSl2j8dHQ+4UGc8Pw6WAf4eB1aD+U7ZEKLtc/KYoewc+FwDHRB61YBe0BjGxjVpIa8eytU
	R7SHtbLe8U5hSaXAcWWo/opXB10njwlqZouQ6cPW9scDFYI+EZaslUv90SwH8PQpj6SjrU
	kQPfLXpYY1LLOOfoaNO99L5Q9YYxDEH+k1UMZQYSVAbfOKkYOnCBRZ4fKAtxlS0PfTJi+7
	L/442n3U00GkGSYSVVyZN7L0xkvfchQ8Kzgbnz4GR49ryeG+X4gqYOOQk4MdiQ==
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
Subject: [PATCH v4 5/8] reset: mchp: sparx5: Allow building as a module
Date: Mon,  5 Aug 2024 12:17:21 +0200
Message-ID: <20240805101725.93947-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240805101725.93947-1-herve.codina@bootlin.com>
References: <20240805101725.93947-1-herve.codina@bootlin.com>
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
---
 drivers/reset/Kconfig                  | 2 +-
 drivers/reset/reset-microchip-sparx5.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 5b5a4d99616e..88350aa8a51c 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -133,7 +133,7 @@ config RESET_LPC18XX
 	  This enables the reset controller driver for NXP LPC18xx/43xx SoCs.
 
 config RESET_MCHP_SPARX5
-	bool "Microchip Sparx5 reset driver"
+	tristate "Microchip Sparx5 reset driver"
 	depends on ARCH_SPARX5 || SOC_LAN966 || MCHP_LAN966X_PCI || COMPILE_TEST
 	default y if SPARX5_SWITCH
 	select MFD_SYSCON
diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
index 636e85c388b0..69915c7b4941 100644
--- a/drivers/reset/reset-microchip-sparx5.c
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -158,6 +158,7 @@ static const struct of_device_id mchp_sparx5_reset_of_match[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(of, mchp_sparx5_reset_of_match);
 
 static struct platform_driver mchp_sparx5_reset_driver = {
 	.probe = mchp_sparx5_reset_probe,
@@ -180,3 +181,4 @@ postcore_initcall(mchp_sparx5_reset_init);
 
 MODULE_DESCRIPTION("Microchip Sparx5 switch reset driver");
 MODULE_AUTHOR("Steen Hegelund <steen.hegelund@microchip.com>");
+MODULE_LICENSE("GPL");
-- 
2.45.0


