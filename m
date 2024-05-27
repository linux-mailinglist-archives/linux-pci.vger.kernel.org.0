Return-Path: <linux-pci+bounces-7870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1638D082E
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 18:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C1F28B825
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 16:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4417F16C438;
	Mon, 27 May 2024 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QLQ/luKn"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA88416078F;
	Mon, 27 May 2024 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826518; cv=none; b=RV59xGQYAIlxlwWZoMarXwfgco+vUfx+GKzRaD8L6F5craUEvNp+QWREFSrT+10LoSlY1jyU/mN53TpQBddwzYiJquwElIub5i6vvIToBx7MeauqhVmZsgxtuz8ZBscBqUtBW4KtlUlTng5ZJg3wmjIGRg0PqaEGkX1uqBh56CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826518; c=relaxed/simple;
	bh=SWk5vonVG5e7P8hVz9wxahmL3ihBK/v20lKtBj8oZs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2uRC5ov3mRUDIqsecFZcg92oUQLV8TUld73WaCG22mjM6Y/e+AomFEAYYHc9pfuYIU+aUX0Bsw5Ddvlmy6dWoGQo8HKSfniLGpKijnmoUL1BKDVmV0henk1oLXQkL07x5Ff0B9D/XvhM4LcbkNat3BDxpEMn6yM68Vn4ulErcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QLQ/luKn; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id D7790FF812;
	Mon, 27 May 2024 16:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716826514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHznhiXiwWKJVWaiiQdYYwLlbRzFssggqMn3mMXWlQs=;
	b=QLQ/luKn4+ghM6v9/p8DpdWBEA3GwVIQLBiLX7mC0xBsAGC+kFA/Na9ucOwoyKROROd+Lr
	16cLBhXSYGv0GG0JVVSWT94LuoTJxfswQ17QnWycK2Afpjd7TxQHaeOW9haF+r5AXTVDMS
	zHxJ6fSDj3ZOKRT+SW5Uc8zrHcGMcsJC7r59mmwJDO8CNyxzPWGlX37RalyfCdMnfa81cG
	hbfSprCnq1crc7gNcJneranGveI/WVMhQLiESWm6ktrlaDD46VemSHoM+v7j3Twffznuum
	J4M6XtZ0cAiwM4hxVKtekaWam8Hq4l+foq1bxe791CUNmChG5bseU8LW5xKK8g==
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
Subject: [PATCH v2 09/19] irqdomain: Add missing parameter descriptions in docs
Date: Mon, 27 May 2024 18:14:36 +0200
Message-ID: <20240527161450.326615-10-herve.codina@bootlin.com>
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

During compilation, several warning of the following form were raised:
  Function parameter or struct member 'x' not described in 'yyy'

Add the missing function parameter descriptions.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 kernel/irq/irqdomain.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index aadc8891cc16..86f8b91b0d3a 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -111,6 +111,7 @@ EXPORT_SYMBOL_GPL(__irq_domain_alloc_fwnode);
 
 /**
  * irq_domain_free_fwnode - Free a non-OF-backed fwnode_handle
+ * @fwnode: fwnode_handle to free
  *
  * Free a fwnode_handle allocated with irq_domain_alloc_fwnode.
  */
@@ -982,6 +983,12 @@ EXPORT_SYMBOL_GPL(__irq_resolve_mapping);
 
 /**
  * irq_domain_xlate_onecell() - Generic xlate for direct one cell bindings
+ * @d:		Interrupt domain involved in the translation
+ * @ctrlr:	The device tree node for the device whose interrupt is translated
+ * @intspec:	The interrupt specifier data from the device tree
+ * @intsize:	The number of entries in @intspec
+ * @out_hwirq:	Pointer to storage for the hardware interrupt number
+ * @out_type:	Pointer to storage for the interrupt type
  *
  * Device Tree IRQ specifier translation function which works with one cell
  * bindings where the cell value maps directly to the hwirq number.
@@ -1000,6 +1007,12 @@ EXPORT_SYMBOL_GPL(irq_domain_xlate_onecell);
 
 /**
  * irq_domain_xlate_twocell() - Generic xlate for direct two cell bindings
+ * @d:		Interrupt domain involved in the translation
+ * @ctrlr:	The device tree node for the device whose interrupt is translated
+ * @intspec:	The interrupt specifier data from the device tree
+ * @intsize:	The number of entries in @intspec
+ * @out_hwirq:	Pointer to storage for the hardware interrupt number
+ * @out_type:	Pointer to storage for the interrupt type
  *
  * Device Tree IRQ specifier translation function which works with two cell
  * bindings where the cell values map directly to the hwirq number
@@ -1018,6 +1031,12 @@ EXPORT_SYMBOL_GPL(irq_domain_xlate_twocell);
 
 /**
  * irq_domain_xlate_onetwocell() - Generic xlate for one or two cell bindings
+ * @d:		Interrupt domain involved in the translation
+ * @ctrlr:	The device tree node for the device whose interrupt is translated
+ * @intspec:	The interrupt specifier data from the device tree
+ * @intsize:	The number of entries in @intspec
+ * @out_hwirq:	Pointer to storage for the hardware interrupt number
+ * @out_type:	Pointer to storage for the interrupt type
  *
  * Device Tree IRQ specifier translation function which works with either one
  * or two cell bindings where the cell values map directly to the hwirq number
@@ -1051,6 +1070,10 @@ EXPORT_SYMBOL_GPL(irq_domain_simple_ops);
 /**
  * irq_domain_translate_onecell() - Generic translate for direct one cell
  * bindings
+ * @d:		Interrupt domain involved in the translation
+ * @fwspec:	The firmware interrupt specifier to translate
+ * @out_hwirq:	Pointer to storage for the hardware interrupt number
+ * @out_type:	Pointer to storage for the interrupt type
  */
 int irq_domain_translate_onecell(struct irq_domain *d,
 				 struct irq_fwspec *fwspec,
@@ -1068,6 +1091,10 @@ EXPORT_SYMBOL_GPL(irq_domain_translate_onecell);
 /**
  * irq_domain_translate_twocell() - Generic translate for direct two cell
  * bindings
+ * @d:		Interrupt domain involved in the translation
+ * @fwspec:	The firmware interrupt specifier to translate
+ * @out_hwirq:	Pointer to storage for the hardware interrupt number
+ * @out_type:	Pointer to storage for the interrupt type
  *
  * Device Tree IRQ specifier translation function which works with two cell
  * bindings where the cell values map directly to the hwirq number
-- 
2.45.0


