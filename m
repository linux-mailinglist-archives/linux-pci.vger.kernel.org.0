Return-Path: <linux-pci+bounces-14454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5494699CA8F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 14:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC3C1F22A1C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 12:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE18B1AB6FC;
	Mon, 14 Oct 2024 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HPr3JIqW"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847EB1AB507;
	Mon, 14 Oct 2024 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910019; cv=none; b=FyYAw5eR0ibcKpH2ytHG5y3Df3uNp3DCMg1UwKroj5xva+lj0xA6lm376181eVXwRDmiwDDLue1bPTW54REtyW/EUVqwe5KCbGQv6/qevQH8uhMttS4/BXZKqnFYcjFkumbMG/pmbHI8ay6E2Uz68lty3KuOVHySbxxsF+M8MIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910019; c=relaxed/simple;
	bh=jollOnYB3ZVReWrGRS+rgeKWKQwFThCykoKCVMLNfOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsspEbX9Jmt9FV2uDBu3HykjflkVdgZn6NF0Y6G/xAW3zbXTeQ6zf/ZsX/uSTHq6XY53eyHOGaE8zvzUbooPAN0DFtk5WI/17IB5G5De6ozIiK8of+QgESzEwqhZsnDP/oyWETu2jD9/oJ/nVy6Vr8Xg2HV4c8wBYN+S/PVAWFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HPr3JIqW; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 2611BE0008;
	Mon, 14 Oct 2024 12:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728910015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNMFzeQRbq08ia/IaCQZGCzpyn3wLeQNa91TNNzpFRw=;
	b=HPr3JIqWn0L3QJcV1FWqxXlxSyM+4hxbPuBHk2KZKVLnBfhSwp3RsEm0qRvBs8Ufnw+nVV
	rY7r0w+d/2OAigaYpzzZT9paVm41GLvGflJE/MbGWsgIKYHz0KQeBUleHp5bkbzxGZ9XVF
	ZLebphSpDCaFAyX56o6cE6xYcQeikypo6jwtR25BomgDGVhuzmCU9fzpKxZqwi7lofCj1l
	SuxPPHI+QbIHGA0w8If5FDUy6TCHsNBXZbrH45CbmwyERCLMJWu4GQXDtjA8ttiLFSB0B0
	+d4A0qKwhfFg4nfauqa9qd4oR02Mdbvd9884ODmTpbw+lqWKmatKKjXx+qCuyQ==
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
Subject: [PATCH v10 4/6] reset: mchp: sparx5: Add MCHP_LAN966X_PCI dependency
Date: Mon, 14 Oct 2024 14:46:33 +0200
Message-ID: <20241014124636.24221-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014124636.24221-1-herve.codina@bootlin.com>
References: <20241014124636.24221-1-herve.codina@bootlin.com>
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
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 5484a65f66b9..86a5504950cb 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -147,7 +147,7 @@ config RESET_LPC18XX
 
 config RESET_MCHP_SPARX5
 	bool "Microchip Sparx5 reset driver"
-	depends on ARCH_SPARX5 || SOC_LAN966 || COMPILE_TEST
+	depends on ARCH_SPARX5 || SOC_LAN966 || MCHP_LAN966X_PCI || COMPILE_TEST
 	default y if SPARX5_SWITCH
 	select MFD_SYSCON
 	help
-- 
2.46.2


