Return-Path: <linux-pci+bounces-11492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C14E094C1C9
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 17:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E6D1F2383E
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 15:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F1C191497;
	Thu,  8 Aug 2024 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FTcbuWxF"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F2818FDC5;
	Thu,  8 Aug 2024 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132068; cv=none; b=rRGV5oeXLOHzhXdJRwSn384snpIq5aaEoKPlEeVOFSrV/CPeXzUOvin+l+F1Dt1VAf4j2l3/WCRQTpfiCDq/sdHJtOTd8k1uhbjEFeRFJDMo2YuL3awARW3VmR7h8I/E4OkKpR4kms/VkHF59HL8lJW458w+4M24j5sVGqE6xRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132068; c=relaxed/simple;
	bh=A3wCMdYHNoumXNzbYsxpr8D8ELhXRhnFZU9NU1TgzT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vy4wpgzW9YmP+9youzDzDSpeZEg8Jk97oRntH/zslkDolT6sOTpJHOWtdYb2aUTkSubAGkYUHZWioQvvyHZraI7hqdonKzAhZTU2uu59MArfUX5Rnm5O2SgybfY6MaU5g01Q/acFlhMHufhPBFs+hc4B+HwJNt+FVUX1PjZHrgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FTcbuWxF; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id DF16920005;
	Thu,  8 Aug 2024 15:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723132064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVeQ7PlO4X+v9TEpBxk1CG/ZinM6HCdKh29wvuZH2Tk=;
	b=FTcbuWxFusgrheVlDMoEMACUixHpdCsRJyishEUKw8xgblCZ9vgyqaRT2BRVLksUi9OcnJ
	4QkWOarfhAkgfbcRntuVJYthY9XYpkcLVDWMuGAaJ0glsxNN5w6HRW3OEeVXkndqAgjOUu
	QcwkFG1eP/jdxPj71z35zbOdRWddKecqnI72kjWAEvsgtHqYQCR1fdkK1MSJsL51MdloR1
	nYeQRyCVHtVKxs1w4DNHuM4zUcNxdzr2IX/ppRh39SitDDcA9zL2x2qmCmoAL3YrNkSslt
	6sym2fMpxQirze+Y8Qij4+tWHBxtOfV6edr9zSh+CZ+eJSWD136cy8ctPuPnyQ==
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
Subject: [PATCH v5 8/8] reset: mchp: sparx5: set the dev member of the reset controller
Date: Thu,  8 Aug 2024 17:46:57 +0200
Message-ID: <20240808154658.247873-9-herve.codina@bootlin.com>
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

In order to guarantee the device will not be deleted by the reset
controller consumer, set the dev member of the reset controller.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
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


