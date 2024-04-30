Return-Path: <linux-pci+bounces-6845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A26E8B6CEF
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 10:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180821F23CDA
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 08:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D571272CA;
	Tue, 30 Apr 2024 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k8zW+xUF"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB75B41C89;
	Tue, 30 Apr 2024 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466354; cv=none; b=YAb7Qn/mJayr4IbjjwqdpOIT9yXPwBk/6MFfCpetxumpxiU2TbYggL0DW+3ApGd9CtEWUxKt2dFFp81mTrqh7dm+D/yRaO1CQYXhgRN+1SXhtGlzwOdqpLIjTFJmCTTaVGUJbyKDCdxubopdpQWYZsjUOGpryFtj0GNfo5YJ6D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466354; c=relaxed/simple;
	bh=G1UAW0H9h1wFRSfJQIj8x5FIWwrzTgw72kS9F2yRFtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nD/RAravCiZUKjarFus8ODdyzHe7ciwXJUunbwpT+kSDWt9sBevDTmd2XmHCC563NxVyM1/G2Q+UMwxyDSlPfstqRTodG3WQvchnNiSw+jzSDWoGWIMctXoBq2WdiojCPgv6SUMinKJtQcdHKC+uB9WYvaPwGekJqc7y8+ntkXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k8zW+xUF; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id AF2AA20005;
	Tue, 30 Apr 2024 08:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714466350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TKlAO4KsYqpHiNkyQhj+YDisqgQI3Psuq2ZrhzBKVbE=;
	b=k8zW+xUF9Ig2N46QYNzzXAZWkk9CwpQGFVoL1lcxo7Ne2Tyt12nrZm4PxjG/LH00SmaMB/
	NPpyw/hwPz60R0x13V+NbvA3m87UJYXm3oYZDpiWInwc1xVubDenz3jCXxFx5vKahNLwDd
	dulid62Pnia2byihDIgvvoUmmt6xXx8CoufsOP9pQHO/IJtJJYhBn11qWdqYHqB/N5NDVK
	ceBa8baD+QBXcS+ZOXnxIvY3iTSsk1egyBCEprHswV6oJsEBUG9+BKSkf8YnAvhM3wFdgG
	3pvdYrxeGS5er10NdS6UNmQMHiMwPMhmkPNa6qdbGjxX4HivsFkGP6yKze3U2A==
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH 01/17] mfd: syscon: Add reference counting and device managed support
Date: Tue, 30 Apr 2024 10:37:10 +0200
Message-ID: <20240430083730.134918-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430083730.134918-1-herve.codina@bootlin.com>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
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
index c315903f6dab..164b9bcb49c3 100644
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
 
+static intline void syscon_put_regmap(struct regmap *regmap)
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
2.44.0


