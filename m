Return-Path: <linux-pci+bounces-13644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AFE98A21F
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 14:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F81E1C20CBD
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 12:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A47D199927;
	Mon, 30 Sep 2024 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cS0L1nBd"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460D11990AE;
	Mon, 30 Sep 2024 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698584; cv=none; b=dLUpDR60LW+5qK9MpHk4otb6R6hBZSwVCH4efKQrEyJ65rpWfeXXkQsB8Jl3dOBcQG+x7EjV2MmndihV+QkRbt4o1RaU9uzmz8++Nl/QY0BamB4J9d8w12LjcZi6Wl36Po8xmUWp0uM9RTju3miODvHqKKJksn2xbSuSpF5SfQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698584; c=relaxed/simple;
	bh=YqkT5IGi9UJunH2tshNXA2e24IZtms2Ugwn6KtSdJ+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHq17zFnv5b2wLf5OTFSReuyONgSI3QaE5LU4lrzstLQVUc/n227XIlBDzcPsEgFfm1l2VS/4ldRKIQJG+wFx5QSN0q5ChbhjB8psHi3nxmMdNkX8WtLxZUR6ZzCN+F25qKK4yeRlkAYMfBBLwYhDo46T4JagVkLvWBdGKUqXck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cS0L1nBd; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 37F091C000C;
	Mon, 30 Sep 2024 12:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727698580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YjuDwokkG7OF/4ROPKeyv/vcxKhZ7wMvKgFy1WdBHx4=;
	b=cS0L1nBdhie2Hf5FoT9Y7d67EIfa0ezwe3WrbEWmrMBAlZz5DMWnyvGlyOkV7Kse8J3dS6
	PK+8+L5lvYOrhrRNxbt9HgajRA56P1k+w73q7A0mj2rih1OgjqamOUe60b5VtBxN0fITRf
	SxmpKtRAUw7xn9hutrm34X4bOdtcuYKLl5pQRL7zRalRAtb41vR7xry7kWg51WLz/lMGN/
	Kv/aW+jvNMCqQWKY3AwDPFNVdfRE76sV1n5E1WtYwlNXynbNTmP+SNe2Mckeyy1UwD0MBs
	73chAvpNUWm5m1wyl1ZsiMDpt9Y/N6w2YyETZrugaBk2dS2zpj249+Da4mhXTg==
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
Subject: [PATCH v6 7/7] reset: mchp: sparx5: set the dev member of the reset controller
Date: Mon, 30 Sep 2024 14:15:47 +0200
Message-ID: <20240930121601.172216-8-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240930121601.172216-1-herve.codina@bootlin.com>
References: <20240930121601.172216-1-herve.codina@bootlin.com>
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
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 drivers/reset/reset-microchip-sparx5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
index 8b931af67383..6bcc3669b71a 100644
--- a/drivers/reset/reset-microchip-sparx5.c
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -135,6 +135,7 @@ static int mchp_sparx5_reset_probe(struct platform_device *pdev)
 		return err;
 
 	ctx->rcdev.owner = THIS_MODULE;
+	ctx->rcdev.dev = &pdev->dev;
 	ctx->rcdev.nr_resets = 1;
 	ctx->rcdev.ops = &sparx5_reset_ops;
 	ctx->rcdev.of_node = dn;
-- 
2.46.1


