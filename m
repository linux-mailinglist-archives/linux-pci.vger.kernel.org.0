Return-Path: <linux-pci+bounces-6858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFD68B6D29
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 10:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E871C22812
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 08:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B261BF6EB;
	Tue, 30 Apr 2024 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F7kImKJ0"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B025A1BED87;
	Tue, 30 Apr 2024 08:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466376; cv=none; b=b26/H7qQB51ZZ53ROpz6PPN0fROx3kxLATFNIpnj5xfEuT+/w4WxOC7uUsVhCKxKv30QF4b5R62gKusZYLkHqcfcvn3Q4ptvNF8ncuhjc0VtN8oiKaDeW1ISzRgeGEg+5KKCuMDjYCNWf0dbORHtQSx4Z8GsWYWwhNQdn4LPj2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466376; c=relaxed/simple;
	bh=QZpvZsfKgX3F8oDhD1XKg83UlmJnd2VYkZjW6DQVGU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4RleFKudDKe/Nkh7LvVoqKgReMgPpAYsJgs5ZX6rSk+Dsz7riYoKl0ESollgr0lpwBf2UMjqTHpeAVQ9tax26gYyYvJ2ZPrth7FPO4KnAhGPFKLJdIAAEONDVzFrlWPNRO7EwUckOtrnm4VnfENgr+p1pKJTf/iOskHfUVXnaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F7kImKJ0; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 8EF7C2000F;
	Tue, 30 Apr 2024 08:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714466372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HOrdL8D1Yo1+FTRkcba34oG6bd3Uzs7JBNkhgICtpjg=;
	b=F7kImKJ0zmG8XOjLM+GJ3WGHJg94BRx9PKzFcwJtvbab1UExnVPJ2t0MEJyrQ2BBifkU68
	HeUwQkBVa6NFUWChkprKxl7x4daH0239zjzr7iW1Oq+xiZRl7NmoMbkfPF3p2PX0a2cPvt
	5hx/A/9725qGixJZbfHadeDiLoO3uR8wxKPr2+gXTKnddSnpb1JIbcbQj0KL/KGzLCaodc
	jhM5ig5JcSyahH/y9bRSct+7j9YPbbit16TsKCznxOvvOQsGMOdyr1nbjUuHVP6IPgc/iE
	5XUcWe5r+J0D10Id0dSE1a26F4lUj3D5caTy51zcfxrLsuU6dKX6b/UVUTcxsQ==
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
Subject: [PATCH 14/17] of: dynamic: Introduce of_changeset_add_prop_bool()
Date: Tue, 30 Apr 2024 10:37:23 +0200
Message-ID: <20240430083730.134918-15-herve.codina@bootlin.com>
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

APIs to add some properties in a changeset exist but nothing to add a DT
boolean property (i.e. a property without any values).

Fill this lack with of_changeset_add_prop_bool().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/of/dynamic.c | 25 +++++++++++++++++++++++++
 include/linux/of.h   |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 4d57a4e34105..37d3b0a272dc 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -1052,3 +1052,28 @@ int of_changeset_add_prop_u32_array(struct of_changeset *ocs,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(of_changeset_add_prop_u32_array);
+
+/**
+ * of_changeset_add_prop_bool - Add a boolean property (i.e. a property without
+ * any values) to a changeset.
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @prop_name:	name of the property to be added
+ *
+ * Create a boolean property and add it to a changeset.
+ *
+ * Return: 0 on success, a negative error value in case of an error.
+ */
+int of_changeset_add_prop_bool(struct of_changeset *ocs, struct device_node *np,
+			       const char *prop_name)
+{
+	struct property prop;
+
+	prop.name = (char *)prop_name;
+	prop.length = 0;
+	prop.value = NULL;
+
+	return of_changeset_add_prop_helper(ocs, np, &prop);
+}
+EXPORT_SYMBOL_GPL(of_changeset_add_prop_bool);
diff --git a/include/linux/of.h b/include/linux/of.h
index a0bedd038a05..9633199a954a 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1652,6 +1652,9 @@ static inline int of_changeset_add_prop_u32(struct of_changeset *ocs,
 	return of_changeset_add_prop_u32_array(ocs, np, prop_name, &val, 1);
 }
 
+int of_changeset_add_prop_bool(struct of_changeset *ocs, struct device_node *np,
+			       const char *prop_name);
+
 #else /* CONFIG_OF_DYNAMIC */
 static inline int of_reconfig_notifier_register(struct notifier_block *nb)
 {
-- 
2.44.0


