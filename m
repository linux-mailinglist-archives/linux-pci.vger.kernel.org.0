Return-Path: <linux-pci+bounces-38139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E6ABDCF6B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 09:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83955501D4E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 07:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8B731A7E6;
	Wed, 15 Oct 2025 07:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fqvfc6xH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6827E315D30;
	Wed, 15 Oct 2025 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512701; cv=none; b=WZMySN1vCnRCV1/og0NTwfpF2YyIPs2Jsr1P589EXGZWwfmBjC0u99UWwalt8gEfgq1YHKXtVblDSFz3l4iJErEqIhiMh7Ktl3mfA2jBZQk6/RCdKrjCs7E4jvQw8l5dYjPIe9GKIgfevEhamdqdT/Ti/IyEt6jdCNh/5s7NJzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512701; c=relaxed/simple;
	bh=DqoI5TidDmIBqOSdAtBjzMhf9iClAUpHAWhAxcN3vp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFsXbXGGI7utTymRYUWCWS5uTFv15OlRnkac9NdIRMDFeUrXO7h65SsIBkHRoIhbd7eZpdGdahBjYmnIzqxnS2EHt9XWPBheBD8o+BW+s6JxgaX9nxN9DId2MHgV10Ka5+7v8i+C3L/OrIK7oMcSpL0jsZ3P8l2uE70VXEP4HSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fqvfc6xH; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E6C96C09FA9;
	Wed, 15 Oct 2025 07:17:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0C1E6606F9;
	Wed, 15 Oct 2025 07:18:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2AC6E102F22BC;
	Wed, 15 Oct 2025 09:18:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760512694; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=nT1PrzAFh54uaSU05XyjeWtw77LPjL/fGiV8mrNqv1k=;
	b=fqvfc6xHs6zRQawpRWgyja210yzVAfPWQha8TZ/3pbVZi8QNmxWcA6PC68BSChop6AeUWD
	szWEwSEdsWkRFA1tunagjaYL8yipSYRRHi92z5U18pjEA+v/6/2NW7z2WRXgtlEpBVyd8d
	57dOLSBTsQoT+f5EX3CwZRIA7MpjJzW6l/IP5reOOvcYJLn0G5W6+/fOu+fydd42/y4qg8
	gEs1J8rBEmv/s3g33Zv9OnSzZmYY85YYurBNf4i6C8q8JGvsBx2dKexYxTyYS6PFnfeI73
	DTou0OgWozndiH82E4vkb4DZB0LjPsC26p6tLmWm2xb9CZM8LgaTT4KrKtZpsQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Arnd Bergmann <arnd@arndb.de>,
	Herve Codina <herve.codina@bootlin.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 10/29] pinctrl: cs42l43: Use fw_devlink_set_device()
Date: Wed, 15 Oct 2025 09:13:57 +0200
Message-ID: <20251015071420.1173068-11-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015071420.1173068-1-herve.codina@bootlin.com>
References: <20251015071420.1173068-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The code set directly fwnode->dev field.

Use the dedicated fw_devlink_set_device() helper to perform this
operation.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/cirrus/pinctrl-cs42l43.c b/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
index 68abb6d6cecd..3609feabd33d 100644
--- a/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
+++ b/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
@@ -566,7 +566,7 @@ static int cs42l43_pin_probe(struct platform_device *pdev)
 		fwnode = fwnode_get_named_child_node(fwnode, "pinctrl");
 
 		if (fwnode && !fwnode->dev)
-			fwnode->dev = priv->dev;
+			fw_devlink_set_device(fwnode, priv->dev);
 	}
 
 	priv->gpio_chip.fwnode = fwnode;
-- 
2.51.0


