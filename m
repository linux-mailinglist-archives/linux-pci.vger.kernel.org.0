Return-Path: <linux-pci+bounces-7880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C728D0861
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 18:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64B51F228CB
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 16:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F95616EC1B;
	Mon, 27 May 2024 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hZGkBaDT"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5538616EBF7;
	Mon, 27 May 2024 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826536; cv=none; b=kkI4jVjVzahOTwC5j8aIa64QRCU2/pEl+RRn5NLaK8KFBSiruw4gzUHNIO9Kr9In9aKzvcoqgppzTTbnBXoM27ET2GzzvM1WLfgUZkltk3Isf9U0rP1Z3kNSFw3j7py+6b0CAVj4FfwsTwNSZfj+02ndzmvhmhVludJoaNpqlDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826536; c=relaxed/simple;
	bh=chCtCkqI/NY4Vy2ffwwkDxwHFQRfFlMjA49T/JZ0V2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r27VkhrCUxcO9+BNg6x5fcj6XWTsTiSNHju+p33+epUdJ70tV9yImdKBKJdRU+wVbg/IVn/08uyiZubi+r44uEO/5XYKGerI+6h0mE23gql7LtrV0LDvKX1k/6BDmAcCTObScGm/4b7bSU4E6tYjFVf7w0yOchHyGQjJq3aKuiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hZGkBaDT; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 7A5E0FF80E;
	Mon, 27 May 2024 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716826533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S5EWnWVm8Boacgm88RxHxweJ58Kbq8GGMqtCde3uKZI=;
	b=hZGkBaDT6XPUEKAWzhUuB2+uCGFMlArWDpCILqxRuPBbHcghizqQZSlO6wFCsZiI1gmal1
	qJix31+53cvT67bFzT2JMWd2PWAYeSdFM1JBSybqfgMBH9ymCqyP6eNoMY5TS+PA0UvHr5
	JP5evTTr7etsXnKUux/tPEQ/0JRsRD1zp8al+pZvukRpuvvTQUMs1ewOkEV/nbBaYldyXb
	OdwNsy9IevypTwYfC/wG2jQvoCEMvMe81wNzeCXH//bQZkxfHBHW/lg+ax8mQk+C3xk030
	GUKfOk8LDGvsh2bB27tPwafLEVhic2aBVX0Eu7S8iViYTvAmW7o8yOs4jNpA4Q==
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 19/19] MAINTAINERS: Add the Microchip LAN966x PCI driver entry
Date: Mon, 27 May 2024 18:14:46 +0200
Message-ID: <20240527161450.326615-20-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240527161450.326615-1-herve.codina@bootlin.com>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

After contributing the driver, add myself as the maintainer for the
Microchip LAN966x PCI driver.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index baeb307344cd..c84ec27ccbe4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14733,6 +14733,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
 F:	drivers/irqchip/irq-lan966x-oic.c
 
+MICROCHIP LAN966X PCI DRIVER
+M:	Herve Codina <herve.codina@bootlin.com>
+S:	Maintained
+F:	drivers/mfd/lan966x_pci.c
+F:	drivers/mfd/lan966x_pci.dtso
+
 MICROCHIP LCDFB DRIVER
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 L:	linux-fbdev@vger.kernel.org
-- 
2.45.0


