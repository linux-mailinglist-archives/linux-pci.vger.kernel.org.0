Return-Path: <linux-pci+bounces-6854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D938B6D1A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 10:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F9D284290
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 08:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0021A0B1A;
	Tue, 30 Apr 2024 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mHAOEK+e"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC8819DF6E;
	Tue, 30 Apr 2024 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466369; cv=none; b=AbyxLTTf5vqwiMN44WYEwnaJyZCjLgbrsMAIfajIWf+tpgaNaZv9h4M4UGct1RsNuj5saSZM1YaPlqSy/TsOfkeEgmKBYa7r0JZXVY/eBoGfTzuSLgMYcfu8FEyMsJMPC8cYPe2gw0FcUuJukKxvR6vJvfHploYAJvdLyKeyojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466369; c=relaxed/simple;
	bh=gSXVwtdIWbvqyHA1LHIG2txFyFYNd3M5GrZOOtiWc6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZ5ZBNpIl8AMLjk2J7A9BgOX7Q71w5poGsHyQr5XQBBu8Ndn4L+REcs3Bh/yU4OwdRui/YhjJFz2R33ARFjjJZQ4Wd2xFM/N65TxN1rC9WRTMqVh2otsx5PpyQvUSSOPhPJucQo+SLE0PPO2ig+42SQce3Cqjfp/H42tbacKP3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mHAOEK+e; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id DC0462000F;
	Tue, 30 Apr 2024 08:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714466365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vW5ZHo+q6cI+MkyIRY7diNLEI/hwcmD0uHSjypXUjAM=;
	b=mHAOEK+eE7xWNOSsxKQaxgm5u3y1GZXmIyb8qWRuL9rrvzi4kMWMKI4BONS85C+XFQvjDz
	4dLS9dcfA92zvpqnRfaL0l2GWPYRb3JZRqm2wmxRdsJ7GB+xiKYGwVhiWJkZPZQyYKapLp
	owwE1LrrF2c8IMBkUfNKU7GRsRRbSPKMqqeFXpPsv13GSSSFbo0VglAGvcui8z6zrRQC6L
	yDtTiTlWrm3/7+Bs1NnoRX18c65wMvxYQnEgOJzuTXKsB3pVRLCCN77vTe2nu3KT82sRuj
	G+iQprPOdHzs6NnEr0+lZlX/J4VHJ7YGu+1oWd6WWcJJZocQqRGR1FHloTjn7A==
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
Subject: [PATCH 10/17] irqdomain: Add missing parameter descriptions in docs
Date: Tue, 30 Apr 2024 10:37:19 +0200
Message-ID: <20240430083730.134918-11-herve.codina@bootlin.com>
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

During compilation, several warning of the following form were raised:
  Function parameter or struct member 'x' not described in 'yyy'

Add the missing function parameter descriptions.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 kernel/irq/irqdomain.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 3dd1c871e091..1ed8c4d3cf2e 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -111,6 +111,7 @@ EXPORT_SYMBOL_GPL(__irq_domain_alloc_fwnode);
 
 /**
  * irq_domain_free_fwnode - Free a non-OF-backed fwnode_handle
+ * @fwnode: fwnode_handle to free
  *
  * Free a fwnode_handle allocated with irq_domain_alloc_fwnode.
  */
@@ -981,6 +982,12 @@ EXPORT_SYMBOL_GPL(__irq_resolve_mapping);
 
 /**
  * irq_domain_xlate_onecell() - Generic xlate for direct one cell bindings
+ * @d: IRQ domain involved in the translation
+ * @ctrlr: the DT node for the device whose interrupt we're translating
+ * @intspec: the interrupt specifier data from the DT
+ * @intsize: the number of entries in @intspec
+ * @out_hwirq: pointer at which to write the hwirq number
+ * @out_type: pointer at which to write the interrupt type
  *
  * Device Tree IRQ specifier translation function which works with one cell
  * bindings where the cell value maps directly to the hwirq number.
@@ -999,6 +1006,12 @@ EXPORT_SYMBOL_GPL(irq_domain_xlate_onecell);
 
 /**
  * irq_domain_xlate_twocell() - Generic xlate for direct two cell bindings
+ * @d: IRQ domain involved in the translation
+ * @ctrlr: the DT node for the device whose interrupt we're translating
+ * @intspec: the interrupt specifier data from the DT
+ * @intsize: the number of entries in @intspec
+ * @out_hwirq: pointer at which to write the hwirq number
+ * @out_type: pointer at which to write the interrupt type
  *
  * Device Tree IRQ specifier translation function which works with two cell
  * bindings where the cell values map directly to the hwirq number
@@ -1017,6 +1030,12 @@ EXPORT_SYMBOL_GPL(irq_domain_xlate_twocell);
 
 /**
  * irq_domain_xlate_onetwocell() - Generic xlate for one or two cell bindings
+ * @d: IRQ domain involved in the translation
+ * @ctrlr: the DT node for the device whose interrupt we're translating
+ * @intspec: the interrupt specifier data from the DT
+ * @intsize: the number of entries in @intspec
+ * @out_hwirq: pointer at which to write the hwirq number
+ * @out_type: pointer at which to write the interrupt type
  *
  * Device Tree IRQ specifier translation function which works with either one
  * or two cell bindings where the cell values map directly to the hwirq number
@@ -1050,6 +1069,10 @@ EXPORT_SYMBOL_GPL(irq_domain_simple_ops);
 /**
  * irq_domain_translate_onecell() - Generic translate for direct one cell
  * bindings
+ * @d: IRQ domain involved in the translation
+ * @fwspec: FW interrupt specifier to translate
+ * @out_hwirq: pointer at which to write the hwirq number
+ * @out_type: pointer at which to write the interrupt type
  */
 int irq_domain_translate_onecell(struct irq_domain *d,
 				 struct irq_fwspec *fwspec,
@@ -1067,6 +1090,10 @@ EXPORT_SYMBOL_GPL(irq_domain_translate_onecell);
 /**
  * irq_domain_translate_twocell() - Generic translate for direct two cell
  * bindings
+ * @d: IRQ domain involved in the translation
+ * @fwspec: FW interrupt specifier to translate
+ * @out_hwirq: pointer at which to write the hwirq number
+ * @out_type: pointer at which to write the interrupt type
  *
  * Device Tree IRQ specifier translation function which works with two cell
  * bindings where the cell values map directly to the hwirq number
-- 
2.44.0


