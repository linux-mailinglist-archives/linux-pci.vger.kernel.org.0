Return-Path: <linux-pci+bounces-11296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF38D947957
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 12:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACCD1C20E9C
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 10:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066CF158D9C;
	Mon,  5 Aug 2024 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vq5sBKqv"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF21158A2C;
	Mon,  5 Aug 2024 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853199; cv=none; b=Nz3Qi3JWvufwUoI7LI4sewDrcaTwmMByip4wnVBk++GjbjlKVPkSCdNCPPJG/gcALP1U8cZnO7eMbPrnF50VqQ+/j3pWVGU4HkCaNwOojIKeY4KqNuA7ux9oV/xdH4OFBI4VjuE5icTO8UAopAPqwUzD3sAQPf7mm3WRjIx5Kz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853199; c=relaxed/simple;
	bh=nhPkf7wgseJDhZAtkhb42G6JXubPm9Ki2AQx9/jbUDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAQAjGUC6CBubCLdQNCkUn/OyoBBTjt9irqt1qIVjZUePPuqWnwuhjfJWX+HH3RWSVVlTOIPE0VsYAQviqk8VHahr3Aw1lAytUM8hyLPxCxgLXm2qkxpFTlcV9R6TJ6PRa5eYI9gfNSZ7Rv6NozMd3lPjRaQDu3iFVy2ovL6dIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vq5sBKqv; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 0E39920002;
	Mon,  5 Aug 2024 10:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722853196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9I+0v1qx7CVrOS1djilPmB0cdboViIJolbKDdwWOXOM=;
	b=Vq5sBKqv72dKT3VLsh2EZwf5w7ki8vjpAFT5mc1/gcfoasDML1BzPtE+6lHZEc0+pBWyj4
	H7WPwSGdm4ukMba04njQ5FLr/YxUf5hhBSNWdlL+3hsJIkGgAZnWd1JTxBJQJF7XTwAAmU
	ZzqgYlPFXQPYNXjsaCyBSE9DWiHcsg61VxCdhyHJ36yRbEEQErouQF++78sqG47AvYj2oU
	W6quZeXf9ccspH1dJJDnLHp0/XVCkz0LlDYhFYbDbUig47Y+XJQicK/ZBNc9SVBDFBx7O/
	AK1RfdnlZAXKljZaPl5+3CtC/RNDftccha6cFE8qT+BG+cclvjCjVuHSOtlknQ==
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
Subject: [PATCH v4 8/8] reset: mchp: sparx5: set the dev member of the reset controller
Date: Mon,  5 Aug 2024 12:17:24 +0200
Message-ID: <20240805101725.93947-9-herve.codina@bootlin.com>
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

In order to guarantee the device will not be deleted by the reset
controller consumer, set the dev member of the reset controller.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/reset/reset-microchip-sparx5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
index c4fe65291a43..1ef2aa1602e3 100644
--- a/drivers/reset/reset-microchip-sparx5.c
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -117,6 +117,7 @@ static int mchp_sparx5_reset_probe(struct platform_device *pdev)
 		return err;
 
 	ctx->rcdev.owner = THIS_MODULE;
+	ctx->rcdev.dev = &pdev->dev;
 	ctx->rcdev.nr_resets = 1;
 	ctx->rcdev.ops = &sparx5_reset_ops;
 	ctx->rcdev.of_node = dn;
-- 
2.45.0


