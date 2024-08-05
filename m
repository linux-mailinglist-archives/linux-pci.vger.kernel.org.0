Return-Path: <linux-pci+bounces-11291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F001947940
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 12:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C1D1F20F2D
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 10:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A15155A47;
	Mon,  5 Aug 2024 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PkASJs5H"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34211154BEA;
	Mon,  5 Aug 2024 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853191; cv=none; b=hXvGA0XJD4h24cQ4T+uJ1uhFiXwhd6LUq3jhSLRdZOiSFHZniUmF8jQUEWMxC2js+MVKQhfIgvyxrRW51C6BCNTyyztTbxOMx6EJSOwY/uAPL5iAtChyrp0S5dZUnyl0cwwUfHetQs3kQHkMLeFsGNjujITADfyeR/vc+IZLBSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853191; c=relaxed/simple;
	bh=Ih+P5cxI4ylVS3d8uQWRpw7gHEbiMb8J1KtMZ6waHsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khM/4Stu8Tm6hkaVz5AzHKDmQOfqRm3m+q2XrBlMgNeQCMBCYU7tCFOieHHFS3NEFeksrKcbYdJpZBn1mt9Yj6x44BHTiohK/0Om3/j8bLjWMgIsDsNTymyXPYX9A5OQDfWdI2v7OIeSc8u3yC1eOyIpJlRRO6YpVenpDfVLiUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PkASJs5H; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id E78AA20003;
	Mon,  5 Aug 2024 10:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722853187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQ7FUvtot02O7z9jN0irvz2NgrtsqSR6wqBscO/qf14=;
	b=PkASJs5HTTN/vbJK11xPQNqeyc114uRxA/580R2v6iZs70XqEJAxYSoSGhQu9zTIdV5lAE
	H+/rSjNYmCF3Q0PfWbpH4Jyd0WvapR9i8Xci9yRB+x1gbNT0NTViC2vRNjOLQ8uB8RHlck
	liiKWtW7oMFJs+umGevSRi7lECOa5cz0zDoYLes1t3VscZUbRnAprx0EC1LAp5Zio8/1Jn
	8+7sIcamsSDOObnwWomrkwGwpWTLhzqnxY8MCchItGFOS1SJx8MUv3YuReSZR1kFeBK5JY
	qk3WkaOBkOe0toOTo5bx/IupgH8PpKH6IjXOZTfIQYcMKLCKfDRYw51IjwmMag==
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 4/8] reset: mchp: sparx5: Add MCHP_LAN966X_PCI dependency
Date: Mon,  5 Aug 2024 12:17:20 +0200
Message-ID: <20240805101725.93947-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240805101725.93947-1-herve.codina@bootlin.com>
References: <20240805101725.93947-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The sparx5 reset controller depends on the SPARX5 architecture or the
LAN966x SoC.

This reset controller can be used by the LAN966x PCI device and so it
needs to be available when the LAN966x PCI device is enabled.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 67bce340a87e..5b5a4d99616e 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -134,7 +134,7 @@ config RESET_LPC18XX
 
 config RESET_MCHP_SPARX5
 	bool "Microchip Sparx5 reset driver"
-	depends on ARCH_SPARX5 || SOC_LAN966 || COMPILE_TEST
+	depends on ARCH_SPARX5 || SOC_LAN966 || MCHP_LAN966X_PCI || COMPILE_TEST
 	default y if SPARX5_SWITCH
 	select MFD_SYSCON
 	help
-- 
2.45.0


