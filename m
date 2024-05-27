Return-Path: <linux-pci+bounces-7866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AEA8D081D
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 18:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6991C2283C
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 16:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBE8168C30;
	Mon, 27 May 2024 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VSglVmn7"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB929167DA2;
	Mon, 27 May 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826510; cv=none; b=JVFeQeWGpXmGfqHdcnuAK9sfn1C6xaPBqmh7p5iueqbOh3F9KO56d+saY3PRm7hbmLXbeNqyUEIrvUbiehFEmiJimaywd0XaQGIvrtIqvtKDdlAzF1bpm+Hfc/Aab2XaCajSTvoJJUNf8i5r5Gk0sNFjVMeybMW6CO11ogOEfF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826510; c=relaxed/simple;
	bh=nhPkf7wgseJDhZAtkhb42G6JXubPm9Ki2AQx9/jbUDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGJIaDnWaMcUm6SkZsC7JYkPdb+gLDY/TMLGvmCbdAQWCRm+EdTocjwbFvvLRA5nz5Z9GIrSDRkfnHwMTGZpGla3fu5Y9W2xgmV7L08LrkkkDpYPY6RRXnKl8b/q/lZkKfwRDKYizI+cj0lOB/LT/5MqQjNZfSWEpjkWH0vgur8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VSglVmn7; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 93DE4FF806;
	Mon, 27 May 2024 16:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716826507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9I+0v1qx7CVrOS1djilPmB0cdboViIJolbKDdwWOXOM=;
	b=VSglVmn7Gn5q7PaPZMeEM6bfECigH6tLaVL8NUWhNemTLBGEvNVJLcDc6T9YvDDkvlxpjA
	fV//LwGH4SIqSRUZ8fchGyyAHLCwUO1EXWoBMtPB1RhydP/9eFwQUrOesXwA9gH1yQ2vPA
	MxSsABRZAWuMDHGtmrnTinbeyNYmMuf8wWfsxPBZoTz1/F7TDv8kUPOt0kvB+y3R60Pz+b
	1exgfqi4TxCVfhyIXuojkmJ7CZntnwnOOcOhTi9FW/p/2rypSK+b4fEZc0WdCEbaG6glRc
	yF0LCz3RVqU1Oyk/3So6CSacY7kNkZH1rF5iDA2YzcJMkU4McNqY44TRBLP7iA==
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
Subject: [PATCH v2 05/19] reset: mchp: sparx5: set the dev member of the reset controller
Date: Mon, 27 May 2024 18:14:32 +0200
Message-ID: <20240527161450.326615-6-herve.codina@bootlin.com>
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


