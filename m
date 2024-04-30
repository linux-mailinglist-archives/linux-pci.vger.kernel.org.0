Return-Path: <linux-pci+bounces-6861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27A38B6D35
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 10:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9106E1F22694
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 08:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C201C233C;
	Tue, 30 Apr 2024 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AeWRr0Io"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B43F1C2304;
	Tue, 30 Apr 2024 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466380; cv=none; b=Gve7HC/pLamaDfEOcYmIwE35jmeBWO0MvKT4wSKot+BeWU5dlnsKJa3ynjejb48XqLGM8TKBkylutocXfRTHA7fLTvNpwYRuB8Z/ZT3w4VDMM8d90GgZgNFiK48E63DBOVdicb2vTlCXN1HWnurg0ShMJdPSrAK1ozaT6GBJ+io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466380; c=relaxed/simple;
	bh=5RFr74Pe6D1ZFqvIhmLXlfFBy/4XhcaQ3RoCErooxVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfd85p1DtTa+8+Gzh292IPPcRd3696K8hTHtPYeRhtWfWjDKxKbaNc0oCwQ3oe0vKjmlWC2nn4BUq1ZznXVgt1bzzqKu0po8lq5/MCdkYisD7Aq7X2MLIJamloLryH1RFNowB/LEbe9s6qjkIDv9r9CGs6BNlvwxbSQtB41YIWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AeWRr0Io; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 7E7A320005;
	Tue, 30 Apr 2024 08:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714466377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h9Wz1fNXtXid8B91ankxGvMHVtEanfjUpTSsFi3KMI4=;
	b=AeWRr0IouEROb6M4dR7xEI6v5ErsDh8dNlttH5bdLK4fZ+HD/Sh36x4Mp2haqOSK7+EcYy
	tYKhlo6ZSkIyKD8C0YlNyqr2ZYqPn68ml3TAjWPPshG1asqzHCBQHioMWdX3W5UM4iQigS
	hzu/xySB6rv+53C/4ojuoc60Q+eNs+WkYwKgs95FiokWhQwnSwz+T0QZsR1bokAJcYUtf2
	Vv5oK9qcwpRz54RGq8nRh+9f+7TCmV9jRYVWJNObufHWuA96XwNj041LzWsgXYNXyShYpm
	ckZ06HlsumTk7uEqIR18tgU+RbTFlWR5ZTgoRi1KfN4Y904RpOXiGl0iTFz3FQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
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
Subject: [PATCH 17/17] MAINTAINERS: Add the Microchip LAN966x PCI driver entry
Date: Tue, 30 Apr 2024 10:37:26 +0200
Message-ID: <20240430083730.134918-18-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430083730.134918-1-herve.codina@bootlin.com>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
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
index a15f19008d6e..2dfb010dc211 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14471,6 +14471,12 @@ S:	Maintained
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
2.44.0


