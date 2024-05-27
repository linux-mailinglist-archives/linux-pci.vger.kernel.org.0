Return-Path: <linux-pci+bounces-7876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DE98D0849
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 18:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5516C1C226D4
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 16:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1068116D9D7;
	Mon, 27 May 2024 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l6qhSOfm"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8A716D4C5;
	Mon, 27 May 2024 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826529; cv=none; b=atSrGUKk+5Az8TA234JhUvyZjDzxzcWeahU7Eg2xDOTKaK0nnwioHilqdm5zAY3Klpy8Wn8mBPqR3bCwb4KMYYZv3XzuiGf+wiQEZ5MP8Qcc/EWdcJ94gn9xGLZ0gZj+bXXijHiQxdHf8mup+fatASxDKinoxbsYoRRUZCLnhuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826529; c=relaxed/simple;
	bh=TFHpjk5EIjM4ZgDHiMQQnW5vfs5uqYWd3y1N5tamdQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxrR7H7IdmtP7GJK3Y8EIgF2fIi+aHw3Jc9eOOYpd4ENeFh/LFQUIiPtgoZOa2cx+0Kv2GUQMmkiH2mFfvYnjkGK/crXr3C49O2Eoii/snSNFEVD/6SMCaCno8Ps5YBt41LSjglE9Bowi9eeqeut4PKUS2ono1lFsUsd0cJfxsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l6qhSOfm; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id E6986FF80A;
	Mon, 27 May 2024 16:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716826525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKJZsAxNSsb/7pw9huzbORlG49qO99fnpLGyuR8WMG8=;
	b=l6qhSOfmmCXe0Qy9DLq9Czxf2AYRZaR1NFx56gJZsppXR1JNfWwdVvM4h0bFoPEs9g3f3e
	YYQpuiWsBfvyK1dWaYru8sGEFvMsvpyXkFgfmLQwA6Wy1Mmg6dkIzb97tVi6H15t3CmbvL
	hhZ03dmeb63YfefyctlUwYK51rMwTX9ZgHuGC3e4A/NJeUwV00D8KTel7R3HvxvgfnugZ9
	oJneBRXp0MBGOS7zM1MXeXu1DoAAWAgWKIcF/JNVDb/jWUZaoC0MriAfQPoO7g/5tZZvMC
	Y2XOYLWZX9P1z0VlLrARtoLiuLviaeP77d31lMOI7tC8XvFjHkAq5o1fK54kOg==
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
Subject: [PATCH v2 15/19] of: dynamic: Introduce of_changeset_add_prop_bool()
Date: Mon, 27 May 2024 18:14:42 +0200
Message-ID: <20240527161450.326615-16-herve.codina@bootlin.com>
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

APIs to add some properties in a changeset exist but nothing to add a DT
boolean property (i.e. a property without any values).

Fill this lack with of_changeset_add_prop_bool().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/of/dynamic.c | 25 +++++++++++++++++++++++++
 include/linux/of.h   |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 70011a98c500..110104a936d9 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -1047,3 +1047,28 @@ int of_changeset_add_prop_u32_array(struct of_changeset *ocs,
 	return of_changeset_add_prop_helper(ocs, np, &prop);
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
index ee9a385a13db..13cf7a43b473 100644
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
2.45.0


