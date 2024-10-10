Return-Path: <linux-pci+bounces-14140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 885CF997CFA
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 08:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978AC1F212A0
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 06:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD241A3031;
	Thu, 10 Oct 2024 06:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GeTLEo8N"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E2D16A395;
	Thu, 10 Oct 2024 06:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728540988; cv=none; b=hJj/yUeEF/rNZ4uszRyGzVlHQ2RN5LAHDBmA7GqFsOMBgFp7NC20U217UskMjUVIC6iuf63+adUz/3czQrKpsICkw3J4zYyx6kh/63ZUEL2Cv9el91/LGjms5Q9qOK5rlEUY0oIoIeyw3jmFSUSHzV3oMWAFpTpGRMzPtDhfoAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728540988; c=relaxed/simple;
	bh=4kghCVbBraLlQpqx8DAgenOlDS6CE+jDcPdxfrAEDgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f38oX32QJWO75UQ8pyJMyf5bkUxGEAKhDSRoG5y/IMTRyLfDBdH6wSRSp8PBwnaVZa28xdUFdG0oriw8fk6mS2DV+iVDgPXoUvN77HetCoGGk1CbprrzKGBOp3p2O1tumFcMCty+WJn1RhN+S9taPE7HuJpA2errWzqyeqHmdnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GeTLEo8N; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 91DAEE0005;
	Thu, 10 Oct 2024 06:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728540984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0Ips3fu7+7BgqtN1VK4fBVu80FSths6Nq7bdNsRq4A=;
	b=GeTLEo8NYsu9RldZlVsgic6qli6TRymxhx2V3GufCuKD6jIq46takb4a7zsV22RAFsMWqi
	ExIoT/q0tRVJ2eaRg725HHgPVCrb1ODN0vXoEGcQVaVdNIV1M7VBLYlPw3P01dRhSGAhS/
	T96G6ITbiOeMdfZwU630f/xntGIUJ92WxdyQ2nwVH7xAudmOyWrHLL2fcvfEqoLbSDRjr7
	d+drSCCc8cbwkQz1T6d9R74ERwKG7qoSXmEtZBEiua1pS5jvu8omTfHpdimehqB23itOA9
	di8JxAVqL4SfPj3QueARmaq316rWm3raRx/ghbWy4BNfnwfE6J+haArmX1sjtw==
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
Subject: [PATCH v8 2/6] MAINTAINERS: Add the Microchip LAN966x PCI driver entry
Date: Thu, 10 Oct 2024 08:16:10 +0200
Message-ID: <20241010061615.787073-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010061615.787073-1-herve.codina@bootlin.com>
References: <20241010061615.787073-1-herve.codina@bootlin.com>
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


