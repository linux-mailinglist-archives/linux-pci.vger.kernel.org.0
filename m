Return-Path: <linux-pci+bounces-11294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 204BE94794F
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 12:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8CA1F21508
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 10:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3495E158202;
	Mon,  5 Aug 2024 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RJBwyTVC"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A0415698B;
	Mon,  5 Aug 2024 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853195; cv=none; b=npll911tPLkKeAuAf29D/YXCbGD3qR0Phcgit/DCr6ve3kiTztYw3wBdzzUZMZDTWvNvSpLul9XHEH3vqWCsiv1IWskIFVinAytLmbbKQUpA4vH0RgRvdkn9sFKOLjNs9vfk9jSMoyqebRFSgaUcrwC31i2N+swG45mvBwmFJx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853195; c=relaxed/simple;
	bh=wDXdXZDe5krRitdqjY8S6IfoignV9HVmYqJZDUl7H6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JV0KU7GbN5dJxwf0Q4R7dxypP8XDNRWoiIBUwXaeTpZ/CW2/WbxeRFEr55xBRYg2GMwnfiHMZIo/YnjYPUXQAq+C4fRxGJf852wp9Qffcur0Fiqvuj9XsgLCqPGgwKb6pQB02ebWvngjUgM+4/gAvfikZutg55L7crzbDkyNwsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RJBwyTVC; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 8E02E20007;
	Mon,  5 Aug 2024 10:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722853191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6TlKweuD4lCqBxL9SdGBmVX01IhcfhXMnuiuGHqhBE=;
	b=RJBwyTVCoOxkHjkMFGB+Mzrf7HcrInc1h/CkFTS1xDlSmF9H4sZnEeKianxcihfBaPcGpr
	Lg4wIw4XTgZctMN4SErINpva/Xi88khTrR1sgi27bWIlYzyrTykC7aLFOoidJ9A/UaQVY0
	w/5wFFleAlyt7NRqSN0/O/u2yNX8NKIvBDuJeCFFJng2PNAhPxe2WjBr9Re0TsdYKOdiw7
	qnxTik1Nm5HnWZn+/B/k4VHu40zUlwNhxhkyZb26ncCvvJuRyJHQ/I1Wb/C9xJ8YRUrVhs
	YbMDfGRD0yHbR+u8Xg45KgliMR/TnBVugaUNcRNiVXOXe04papUFTsijcQnQIA==
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
Subject: [PATCH v4 6/8] reset: mchp: sparx5: Release syscon when not use anymore
Date: Mon,  5 Aug 2024 12:17:22 +0200
Message-ID: <20240805101725.93947-7-herve.codina@bootlin.com>
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
2.45.0


