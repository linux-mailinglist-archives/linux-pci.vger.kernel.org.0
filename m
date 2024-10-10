Return-Path: <linux-pci+bounces-14144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDC3997D0C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 08:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA5C281B7C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 06:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB9B1BD034;
	Thu, 10 Oct 2024 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VDyxzHMW"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F0E1BBBF7;
	Thu, 10 Oct 2024 06:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728540996; cv=none; b=qu9FRYWZqzNPKLMiI//sltUxyD9fmtx5P5sUcP8vKbE7Qpdx8U+SvC33oCSc93KNVlvyOtSs/XbPsbLiMeUi1nZvd8CXUcIZtlR4D2nK5swLAEhxtbiKpKSoSDdld30w4Tb0+YoC4EqIrM19THrZIp8ikYFeotDyxI0RirT6X3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728540996; c=relaxed/simple;
	bh=pay+04IBkb6N6YqImnzm66VLMa5BmJvHR/MOacq+wLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTnjBGXsN5fmicNEr1vp21SII/Lzev+dBrV09TCPi1tO0mBYsnIQMGfmmAoivjU2Fc/DZj/BI89+0rkCYjh5O4CYKxx/IciLAZlJdnOw6l7CtYajIpijQUudUdnXmfEHveNA/Vtp++KIAo+qTahlvTUeV2JyA760qFEHzV/W0Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VDyxzHMW; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id AE7FDE000C;
	Thu, 10 Oct 2024 06:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728540991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=edIBHVUlBen2+dM0A9C3oLe4ngVIrfCfYAeOnVLi3Ts=;
	b=VDyxzHMWMrW/+0OrpAje2GziXWPYSI0ePRTQtXwG/wusoylMqbHJEjL/MQtl/YfmOVW4bs
	PAhNWZZ8cgaikRk0g5P+o3nv07fxP6xFuX0xGznoRYb7K8Ip0lA3mA3vtS3G1puY7i4Duy
	ihUpppqet9O5IzRzUEoP5SSx9svA30KMuRpXMi8XZOZdUKZ2SJWDvGSU+9ETRgkIcoqyu6
	7vsYCtMFAxm9rkg15yPrhDQrVnaTTxPErMjSl0xkUuBmr/cjq4+9nVj8XjZ9vEeOQqi5TX
	1/MSXmR4toVAZiGyfRyzQqBxvObHBeNPoQXtbjq86HyyV2UtXOjXSZH5ClbzLg==
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
Subject: [PATCH v8 6/6] reset: mchp: sparx5: set the dev member of the reset controller
Date: Thu, 10 Oct 2024 08:16:14 +0200
Message-ID: <20241010061615.787073-7-herve.codina@bootlin.com>
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

In order to guarantee the device will not be deleted by the reset
controller consumer, set the dev member of the reset controller.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 drivers/reset/reset-microchip-sparx5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
index c4cc0edbb250..aa5464be7053 100644
--- a/drivers/reset/reset-microchip-sparx5.c
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -154,6 +154,7 @@ static int mchp_sparx5_reset_probe(struct platform_device *pdev)
 		return err;
 
 	ctx->rcdev.owner = THIS_MODULE;
+	ctx->rcdev.dev = &pdev->dev;
 	ctx->rcdev.nr_resets = 1;
 	ctx->rcdev.ops = &sparx5_reset_ops;
 	ctx->rcdev.of_node = dn;
-- 
2.46.2


