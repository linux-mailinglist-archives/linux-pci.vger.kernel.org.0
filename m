Return-Path: <linux-pci+bounces-13639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C4298A206
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 14:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6881F25097
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 12:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3686E192D97;
	Mon, 30 Sep 2024 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SL/jQ8hy"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB0218EFDC;
	Mon, 30 Sep 2024 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698576; cv=none; b=Nc1sUFR0TdYgw7X5PW0jUScYXm+IDz4G6pmc+tkRqyyB95uGN3W7cJoA+GuM2J8xyO3kdqh9k2mN9lbxcZGPNC4+Z++7gCvH9+5nIJSszpWxcX0ryyXgVpU9a8HU+QOcronNIoS0mXNM9mLHfMZNDjc4UXGObcOHfqkGELi4a6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698576; c=relaxed/simple;
	bh=y1h4hhHoRe7G8lecZ58inUZ7WynZOxZHzgFrr6trPZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BL2yBrcf/K3U10rT4huBYZIJavMZv/jb9+6JQMiVsq7A3weZxhDwPdeq92/8ah1v3s/qb9DPdOsIeslSkpyYNA3LZ7oTewNugPFWGf+FMolR7eoGJ6IyIBupXRpp+vplbHxxrUhIOc4xTuuRerb70ft2KLQ6kymPMLdSSdGHba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SL/jQ8hy; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id A92421C000E;
	Mon, 30 Sep 2024 12:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727698572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H75kKm8YWb4wMHVGvZX4AtY6DIz/y+0Eo67GzMZxTeo=;
	b=SL/jQ8hy+sdq1J4IGu4jIz6hcaZlN9zy6u/VrUxQHo1AI/mHTo/ElX0/uxRhemRaEHnPqz
	OlZRLQrGxRnHvUrzO6wDDSAJ81n238mFIwKRN/0IrWfNTth2zDZvRpMDzWly/jy/gn2Z5B
	JwwqMTZa+Sf+bw1VV23P6mDLw0CS+VuXlPkLKUfdjkQUFAR1YR5ZUv2/bBJfIFMiuTTCcA
	rIOsGlqk4UKVCPvhsUj83whRpVa4sLKHKeDDEIrrfMl9gjmI+o0sDaqgL6DbhGdhmq3wRm
	A4AykhT0T+Mt7JFYXBAZy8WBYhkwCKR8eM7dmsDgDnkShOvn/Y8P5+NkPPiHUg==
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
Subject: [PATCH v6 2/7] reset: mchp: sparx5: Use the second reg item when cpu-syscon is not present
Date: Mon, 30 Sep 2024 14:15:42 +0200
Message-ID: <20240930121601.172216-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240930121601.172216-1-herve.codina@bootlin.com>
References: <20240930121601.172216-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

In the LAN966x PCI device use case, syscon cannot be used as syscon
devices do not support removal [1]. A syscon device is a core "system"
device and not a device available in some addon boards and so, it is not
supposed to be removed.

In order to remove the syscon usage, use a local mapping of a reg
address range when cpu-syscon is not present.

Link: https://lore.kernel.org/all/20240923100741.11277439@bootlin.com/ [1]
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/reset/reset-microchip-sparx5.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
index 636e85c388b0..1c095fa41d69 100644
--- a/drivers/reset/reset-microchip-sparx5.c
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -114,8 +114,22 @@ static int mchp_sparx5_reset_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	err = mchp_sparx5_map_syscon(pdev, "cpu-syscon", &ctx->cpu_ctrl);
-	if (err)
+	switch (err) {
+	case 0:
+		break;
+	case -ENODEV:
+		/*
+		 * The cpu-syscon device is not available.
+		 * Fall back with IO mapping (i.e. mapping from reg property).
+		 */
+		err = mchp_sparx5_map_io(pdev, 1, &ctx->cpu_ctrl);
+		if (err)
+			return err;
+		break;
+	default:
 		return err;
+	}
+
 	err = mchp_sparx5_map_io(pdev, 0, &ctx->gcb_ctrl);
 	if (err)
 		return err;
-- 
2.46.1


