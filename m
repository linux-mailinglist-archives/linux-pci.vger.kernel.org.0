Return-Path: <linux-pci+bounces-14148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD89997D5D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 08:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA58B1F21AF6
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 06:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7E51B5ED8;
	Thu, 10 Oct 2024 06:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l4HgT9bc"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0937B1AFB35;
	Thu, 10 Oct 2024 06:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728542183; cv=none; b=dKabpBkifjp7EQzmikjPxDBhLZa49DPjUOcgaAKStqDmKiMblzUuOO7OVlL+8CdcEAGQFTRhHwmVgCLsdHeW0Z9C7Krq3iZiqeVaOUbKcKJoS5YuZB4D1y2Ux9X6ZYYFDLsNfvypNccamJjqDBOjCWsCFxi+6q8FxxRBP0ATHi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728542183; c=relaxed/simple;
	bh=4kghCVbBraLlQpqx8DAgenOlDS6CE+jDcPdxfrAEDgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHW0N926ogNjQnecIRshCFQWXJA19I0Pc56Ta/gYPaEc2lZzpdBICwd2mJaXBxFp0KskHBUM1RXu/8TexbHkp5wbO4s5OcAUP8BQDxf1bk4pDvBrKIxjwdPdhdF8xxUndCPgd0gXPmfDJYF1OjdRu1WETbEdmauAkaxQzcIyLpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l4HgT9bc; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id C74501C0007;
	Thu, 10 Oct 2024 06:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728542179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0Ips3fu7+7BgqtN1VK4fBVu80FSths6Nq7bdNsRq4A=;
	b=l4HgT9bcsFNK7eMEZ/EyeuQiPnOxIhco8f63y0VOFKAhrxMZNhdmVFbDgX7LBsevSKh8V5
	dPpqC07N1gcroVCqI24DnA+X0LIKB8ZEYWZDedkjhhD7pinNIqQTXIR+/cpAZhni+5CMx3
	Jlhu+TauxjXL2t/h5DBtVLJJq2MNBFN/AW/Ulfep34j9wzJyCWI+IQ31MuBmrSxhQz0m9J
	50dy4coUZsnWUX/Ca9T32x96RXY1Oap3TqCukD0sOE51p7r9F4ElBtSZXc9UvgHb5AIfAV
	3vL9E7Wbs917XT9YoYQIT0fpR1iqobZLi+EloCHKzhMFFo7jkfVc/0BEfbobig==
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
Subject: [PATCH v9 2/6] MAINTAINERS: Add the Microchip LAN966x PCI driver entry
Date: Thu, 10 Oct 2024 08:36:02 +0200
Message-ID: <20241010063611.788527-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010063611.788527-1-herve.codina@bootlin.com>
References: <20241010063611.788527-1-herve.codina@bootlin.com>
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
index c27f3190737f..79125b6f7814 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15184,6 +15184,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
 F:	drivers/irqchip/irq-lan966x-oic.c
 
+MICROCHIP LAN966X PCI DRIVER
+M:	Herve Codina <herve.codina@bootlin.com>
+S:	Maintained
+F:	drivers/misc/lan966x_pci.c
+F:	drivers/misc/lan966x_pci.dtso
+
 MICROCHIP LCDFB DRIVER
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 L:	linux-fbdev@vger.kernel.org
-- 
2.46.2


