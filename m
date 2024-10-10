Return-Path: <linux-pci+bounces-14143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B72997D05
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 08:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93AA51F24A6F
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 06:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ADE1BC088;
	Thu, 10 Oct 2024 06:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jp1bCegg"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE4F1BBBC0;
	Thu, 10 Oct 2024 06:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728540993; cv=none; b=IdOkcRAtWvQvB0kfyg5rhH5mKGswOhU/GvDUlsXidhrBFMajqBGAg6uOCMJ+hj3hDyxvxr7+/CDM9tcp2QiIlo2WYfv3M6Y/mvYtwYbB+Q1f1VNNVrZufacAJlgufnkp3JumMtR8La1kKnk043S7fMM8y6m9FBpZ0/oTQM3Ev0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728540993; c=relaxed/simple;
	bh=zOwm1cxscEGCjNLHPiQEn5PI7KQsbTev9ncSYRPwirA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AI8vIhVz9a6pD/V3C9Z1me5JYcW3bC5Vq79qULBA9/LmM4oK0WOqpmZ6muudF18i+fghcxH9k8Q6acd8Bb2FoC1287RZh2lQU2tZpuoRD3lA1Ko51Yzz2ezv0RRHRrcAiA+0QkiGUe7ggVT2tiUeMVyfV0SXu6Ag6pr/Mb36uuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jp1bCegg; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id D0B1FE000E;
	Thu, 10 Oct 2024 06:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728540989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOckyBBlTDDnkyo3cyvGWjnrUpORqQ7Zmtbq/7BIU3A=;
	b=Jp1bCegg8QC2uRHpYTP57pzql+JaomweDkcTCHe5AHiZTYpwEm+JM1FgDbtZeQV+swTmRw
	sqCxHBudDN/jA+XA/GXzMGankPusf7XJfjLogUo7/oIPmrLYOAIz8IakniCh5bgCY4Uthq
	RP+zLKlOPglrpp1ODcUm5kKnZuqTJk+nQS48AXoke+o9gBS4pFwr12AiuoI8U3d3mlYwM6
	ssL7pNBfE5c5X4QL4Wbzq0D8ElmAg/PBvb93dxEg5cg+8Ovz/EnpsQdQXlAAMJ9vSX70f7
	f2ZnzGH3xl4W5LrT7jyC2utVhKxDOYVlXGVzIQEFcysHFeZUZDK9zmMnR4XbRw==
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
Subject: [PATCH v8 5/6] reset: mchp: sparx5: Allow building as a module
Date: Thu, 10 Oct 2024 08:16:13 +0200
Message-ID: <20241010061615.787073-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010061615.787073-1-herve.codina@bootlin.com>
References: <20241010061615.787073-1-herve.codina@bootlin.com>
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
2.46.2


