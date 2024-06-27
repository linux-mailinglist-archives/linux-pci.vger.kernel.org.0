Return-Path: <linux-pci+bounces-9360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487DD91A257
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 11:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023AC282B0C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 09:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5FB13A3FF;
	Thu, 27 Jun 2024 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jtB0QqBa"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0939D137757;
	Thu, 27 Jun 2024 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479538; cv=none; b=R6iZVzX1+bGxUFXz5y1a8TKl4ZcpNIICDDaswnnczvVvqiruTMf8QL2X3Abk4Re4uv91TkAAaIjS8e9jI+giRssg3sbaYLLZTw6e1tjIksjB+ptbI42tHxg156m37wsg1jlQtiUIKi9PnVnOGvUCIV3DbDZ07k360XLSpLLCXDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479538; c=relaxed/simple;
	bh=0M1Hns7CDOYJ2aLM9KSawz/vJcM90IBbHl4CqMegdlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7G34EImzA715eIMU1AVIjE85A3YCFWNde+2Rxp/aGf0we9Y1RpjgXFbDTnteP8TsJsOV9o1MtAlc22ywIyvuhHNDmhyuiBswOAR1y7EcvLgiHomuhRTqIB6KpHHZ2ywiiyhXb/yyX8sDvI+YffmwKbJ9gX+diX2QlYTbdHmEZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jtB0QqBa; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id D62E020010;
	Thu, 27 Jun 2024 09:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719479533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9+p1hma003opriOOEox9fT6iYMjtITIcW1ZIQ2QLNo=;
	b=jtB0QqBajMb/K4aGw9+wYE3BC7lqgwcQMBfFZsmEY2RYiPZZE9/0hqHdNKXCK16fijICm9
	Aty2n9YVz6Aq4aAkabrK3217d1ZJ2jj9M7vFMoL3RI8WmNB9EFXmayoW12w75ZvHcoVVES
	L/PUJ8UAfgH3Z0FMAXcKC71tSx7+QRbtAvVkkPDjGbshwY7vru95d3z5Ax9AbEeY1eIS1a
	PuAVSV7JE7bjrJVvI1ijRP+pN0s6GJ/xsTZyQAbSs8eybLWUPL8xhLsjm6lZUH8IFYAT1N
	GgtDlAedw3+wW1CJnZ1KmRtxv98Eh/ZH/qJtq28KqUZk33FOFAiPfwP5RJv9sw==
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	UNGLinuxDriver@microchip.com,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH v3 1/7] mfd: syscon: Add reference counting and device managed support
Date: Thu, 27 Jun 2024 11:11:30 +0200
Message-ID: <20240627091137.370572-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240627091137.370572-1-herve.codina@bootlin.com>
References: <20240627091137.370572-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

From: Clément Léger <clement.leger@bootlin.com>

Syscon releasing is not supported.
Without release function, unbinding a driver that uses syscon whether
explicitly or due to a module removal left the used syscon in a in-use
state.

For instance a syscon_node_to_regmap() call from a consumer retrieve a
syscon regmap instance. Internally, syscon_node_to_regmap() can create
syscon instance and add it to the existing syscon list. No API is
available to release this syscon instance, remove it from the list and
free it when it is not used anymore.

Introduce reference counting in syscon in order to keep track of syscon
usage using syscon_{get,put}() and add a device managed version of
syscon_regmap_lookup_by_phandle(), to automatically release the syscon
instance on the consumer removal.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/mfd/syscon.c       | 145 ++++++++++++++++++++++++++++++++++---
 include/linux/mfd/syscon.h |  18 +++++
 2 files changed, 154 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 7d0e91164cba..86898831b842 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -34,6 +34,7 @@ struct syscon {
 	struct regmap *regmap;
 	struct reset_control *reset;
 	struct list_head list;
+	struct kref refcount;
 };
 
 static const struct regmap_config syscon_regmap_config = {
@@ -147,6 +148,8 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 
 	syscon->regmap = regmap;
 	syscon->np = np;
+	of_node_get(syscon->np);
+	kref_init(&syscon->refcount);
 
 	spin_lock(&syscon_list_slock);
 	list_add_tail(&syscon->list, &syscon_list);
@@ -168,7 +171,30 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 	return ERR_PTR(ret);
 }
 
-static struct regmap *device_node_get_regmap(struct device_node *np,
+static void syscon_free(struct kref *kref)
+{
+	struct syscon *syscon = container_of(kref, struct syscon, refcount);
+
+	spin_lock(&syscon_list_slock);
+	list_del(&syscon->list);
+	spin_unlock(&syscon_list_slock);
+
+	regmap_exit(syscon->regmap);
+	of_node_put(syscon->np);
+	kfree(syscon);
+}
+
+static void syscon_get(struct syscon *syscon)
+{
+	kref_get(&syscon->refcount);
+}
+
+static void syscon_put(struct syscon *syscon)
+{
+	kref_put(&syscon->refcount, syscon_free);
+}
+
+static struct syscon *device_node_get_syscon(struct device_node *np,
 					     bool check_res)
 {
 	struct syscon *entry, *syscon = NULL;
@@ -183,9 +209,23 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 
 	spin_unlock(&syscon_list_slock);
 
-	if (!syscon)
+	if (!syscon) {
 		syscon = of_syscon_register(np, check_res);
+		if (IS_ERR(syscon))
+			return ERR_CAST(syscon);
+	} else {
+		syscon_get(syscon);
+	}
+
+	return syscon;
+}
 
+static struct regmap *device_node_get_regmap(struct device_node *np,
+					     bool check_res)
+{
+	struct syscon *syscon;
+
+	syscon = device_node_get_syscon(np, check_res);
 	if (IS_ERR(syscon))
 		return ERR_CAST(syscon);
 
@@ -198,12 +238,23 @@ struct regmap *device_node_to_regmap(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(device_node_to_regmap);
 
-struct regmap *syscon_node_to_regmap(struct device_node *np)
+static struct syscon *syscon_node_to_syscon(struct device_node *np)
 {
 	if (!of_device_is_compatible(np, "syscon"))
 		return ERR_PTR(-EINVAL);
 
-	return device_node_get_regmap(np, true);
+	return device_node_get_syscon(np, true);
+}
+
+struct regmap *syscon_node_to_regmap(struct device_node *np)
+{
+	struct syscon *syscon;
+
+	syscon = syscon_node_to_syscon(np);
+	if (IS_ERR(syscon))
+		return ERR_CAST(syscon);
+
+	return syscon->regmap;
 }
 EXPORT_SYMBOL_GPL(syscon_node_to_regmap);
 
@@ -223,11 +274,11 @@ struct regmap *syscon_regmap_lookup_by_compatible(const char *s)
 }
 EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_compatible);
 
-struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
-					const char *property)
+static struct syscon *syscon_lookup_by_phandle(struct device_node *np,
+					       const char *property)
 {
 	struct device_node *syscon_np;
-	struct regmap *regmap;
+	struct syscon *syscon;
 
 	if (property)
 		syscon_np = of_parse_phandle(np, property, 0);
@@ -237,12 +288,24 @@ struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
 	if (!syscon_np)
 		return ERR_PTR(-ENODEV);
 
-	regmap = syscon_node_to_regmap(syscon_np);
+	syscon = syscon_node_to_syscon(syscon_np);
 
 	if (property)
 		of_node_put(syscon_np);
 
-	return regmap;
+	return syscon;
+}
+
+struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
+					       const char *property)
+{
+	struct syscon *syscon;
+
+	syscon = syscon_lookup_by_phandle(np, property);
+	if (IS_ERR(syscon))
+		return ERR_CAST(syscon);
+
+	return syscon->regmap;
 }
 EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle);
 
@@ -293,6 +356,70 @@ struct regmap *syscon_regmap_lookup_by_phandle_optional(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle_optional);
 
+static struct syscon *syscon_from_regmap(struct regmap *regmap)
+{
+	struct syscon *entry, *syscon = NULL;
+
+	spin_lock(&syscon_list_slock);
+
+	list_for_each_entry(entry, &syscon_list, list)
+		if (entry->regmap == regmap) {
+			syscon = entry;
+			break;
+		}
+
+	spin_unlock(&syscon_list_slock);
+
+	return syscon;
+}
+
+void syscon_put_regmap(struct regmap *regmap)
+{
+	struct syscon *syscon;
+
+	syscon = syscon_from_regmap(regmap);
+	if (!syscon)
+		return;
+
+	syscon_put(syscon);
+}
+EXPORT_SYMBOL_GPL(syscon_put_regmap);
+
+static void devm_syscon_release(struct device *dev, void *res)
+{
+	syscon_put(*(struct syscon **)res);
+}
+
+static struct regmap *__devm_syscon_get(struct device *dev,
+					struct syscon *syscon)
+{
+	struct syscon **ptr;
+
+	if (IS_ERR(syscon))
+		return ERR_CAST(syscon);
+
+	ptr = devres_alloc(devm_syscon_release, sizeof(struct syscon *), GFP_KERNEL);
+	if (!ptr) {
+		syscon_put(syscon);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	*ptr = syscon;
+	devres_add(dev, ptr);
+
+	return syscon->regmap;
+}
+
+struct regmap *devm_syscon_regmap_lookup_by_phandle(struct device *dev,
+						    struct device_node *np,
+						    const char *property)
+{
+	struct syscon *syscon = syscon_lookup_by_phandle(np, property);
+
+	return __devm_syscon_get(dev, syscon);
+}
+EXPORT_SYMBOL_GPL(devm_syscon_regmap_lookup_by_phandle);
+
 static int syscon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index c315903f6dab..f742d865a37a 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 
 struct device_node;
+struct device;
 
 #ifdef CONFIG_MFD_SYSCON
 struct regmap *device_node_to_regmap(struct device_node *np);
@@ -28,6 +29,11 @@ struct regmap *syscon_regmap_lookup_by_phandle_args(struct device_node *np,
 						    unsigned int *out_args);
 struct regmap *syscon_regmap_lookup_by_phandle_optional(struct device_node *np,
 							const char *property);
+void syscon_put_regmap(struct regmap *regmap);
+
+struct regmap *devm_syscon_regmap_lookup_by_phandle(struct device *dev,
+						    struct device_node *np,
+						    const char *property);
 #else
 static inline struct regmap *device_node_to_regmap(struct device_node *np)
 {
@@ -67,6 +73,18 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle_optional(
 	return NULL;
 }
 
+static inline void syscon_put_regmap(struct regmap *regmap)
+{
+}
+
+static inline
+struct regmap *devm_syscon_regmap_lookup_by_phandle(struct device *dev,
+						    struct device_node *np,
+						    const char *property)
+{
+	return NULL;
+}
+
 #endif
 
 #endif /* __LINUX_MFD_SYSCON_H__ */
-- 
2.45.0


