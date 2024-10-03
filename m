Return-Path: <linux-pci+bounces-13757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D94098EB62
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 10:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A27128169B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 08:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CBD1494D4;
	Thu,  3 Oct 2024 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R6lYQxfb"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B04B13E04C;
	Thu,  3 Oct 2024 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943487; cv=none; b=iD+vP3vU+mJqXSU7jts+edgrP6eEGRV5XcKG5Cwx/fhEoRjcrGBvJHWzT0ddsS6u65Lqkagncqkjlmm+qQjJI1nXiqLsO4wI87PLnupH/AhJM9QBFL2HWgOS8w8s5xX/G+0LA6xBJSwBO/gvi5s8xbZfo9bGZmV2YzVrJpue4Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943487; c=relaxed/simple;
	bh=Yv6trJDcY8dRr9upr/+22Oz6O6qPvicMhYtUiKecTIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9cjEuISK3TVUfZ/O7wcqDUe6XOO6L5XyVbjkii0aqWyvO9IbQIQWNRxSgkuBbf1810+ok3sJr6+1iBNp1wbWYbfxraAzzh3jCgNWoMY3SzDAFOAQcTam1QOsATCswW0jab9b8RAFjWXPOATAFeM5BmmVA0HKCYKwR1x7sRdUz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R6lYQxfb; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id A7A0DE000C;
	Thu,  3 Oct 2024 08:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727943483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhvovnJI7ARZ4teDGL2XIqgm4wnhHdz7ckK46wOUTTk=;
	b=R6lYQxfbaFYl/8bDhsnTTCHq856r9/5NhwdwkCAhgOR2+sB+6Gc9bN1+WqAeqk22vP+YjN
	n6FpbkL4YlXRQcoeb8mxZAlY7mI7aAehwcpo0SQILE/sdltVRIeGKEtDiKyl47qNtTtRiT
	8pSC2c4dkTjD9rdHwtmmaLhcA07VnGyyy/v3UhXjYBLUl/ohkMi94iIEw4+JVneJBL9N4T
	2/HEL2r9GgAh8WYJMX7oTnST6p4m3N59gqwuc8vXPByNhhfLqV6RBgw6hFEZIgtNcV88oy
	Yu5rOPHBFedB/SN9HQ+E36VFBdl6bqI7iYUk/q1YUchYxFpHrO702ol4qTQKEg==
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
Subject: [PATCH v7 4/6] reset: mchp: sparx5: Add MCHP_LAN966X_PCI dependency
Date: Thu,  3 Oct 2024 10:16:41 +0200
Message-ID: <20241003081647.642468-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241003081647.642468-1-herve.codina@bootlin.com>
References: <20241003081647.642468-1-herve.codina@bootlin.com>
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
2.46.1


