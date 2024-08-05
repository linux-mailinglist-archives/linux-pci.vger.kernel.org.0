Return-Path: <linux-pci+bounces-11290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C5894793E
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 12:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7791C2117B
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 10:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697BF155353;
	Mon,  5 Aug 2024 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QG0iu5QT"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F64513A40C;
	Mon,  5 Aug 2024 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853190; cv=none; b=JR5UifFVTA3Zbua4t3rdqoS/y28G01QMan7UTMBCIFtY8H/QmEed9x7fX/iB9CUW1KaLQ9MoGYhN0cdAfC3ehZe/AiAU0f3zR+vcFtojLRd94al9JXAdglFeD3h0xVkDPXG2cRYVYBJH6qgc7BCBsyFhRt4NvjLm/1MFndercWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853190; c=relaxed/simple;
	bh=1Hsl1DZ/TphMC7b15QqqWibCczAyNcSPfH1r3e5it9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uv1MicslTVf7lPCeaj/FQNkwQ8zoD/hfTFIK55QSKkhGn9iTSrbA5FO5SVona+kI40G3sCt2CNt6AHgCCONsHwMC4MssGIC9OopUJhaDvWYxjqyOlc4tXiuz+d36n0JdZi6SbUsB6Hdj+U3vQuaBIwTVALQ+WZuB3PNUHAnXYwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QG0iu5QT; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 2DE0B20005;
	Mon,  5 Aug 2024 10:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722853185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AtQAENyFiX4qzjNmAXkQQ8GKLH8T1wLEJY+LVMQa6YI=;
	b=QG0iu5QTt3SrYsBZb+cvB2pf53ZHW2E1rFJnAXs5kwCX2h5K99SA1B/F0Qo2DASPRTys+e
	8CXrKY8m1A/Hmg/Ks6N1pptv09ynip90FERbKjsGO4cNMzo8yvz5Q8h4VYynk499LATzyi
	3Y/r8oqSPI7C8TNsB5xf7o1xXNp/JtQedOU7sOhI0VcHPNWYGjQo6lYnc3+0eKUtTwt/uM
	nx1dkdTCqj6tCNrGlgRRCIQJ/pikWP+Gxz0L92f+dxwNSpEZdjB0AZvZRkpI9ZoE/b4jTB
	TKYanYlATG12foWKrZgy5vJEojkgOPIEvG6rv8Sql131gfYMqqiD+MJotuKl/Q==
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
	Saravana Kannan <saravanak@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH v4 3/8] mfd: syscon: Add reference counting and device managed support
Date: Mon,  5 Aug 2024 12:17:19 +0200
Message-ID: <20240805101725.93947-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240805101725.93947-1-herve.codina@bootlin.com>
References: <20240805101725.93947-1-herve.codina@bootlin.com>
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
 include/linux/mfd/syscon.h |  16 ++++
 2 files changed, 152 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 33f1e07ab24d..b602fa7c5c63 100644
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
 
@@ -246,12 +286,23 @@ struct regmap *device_node_to_regmap(struct device_node *np)
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
 
@@ -271,11 +322,11 @@ struct regmap *syscon_regmap_lookup_by_compatible(const char *s)
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
@@ -285,12 +336,24 @@ struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
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
 
@@ -341,6 +404,70 @@ struct regmap *syscon_regmap_lookup_by_phandle_optional(struct device_node *np,
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
index aad9c6b50463..a3025b4efb4a 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 
 struct device_node;
+struct device;
 
 #ifdef CONFIG_MFD_SYSCON
 struct regmap *device_node_to_regmap(struct device_node *np);
@@ -30,6 +31,10 @@ struct regmap *syscon_regmap_lookup_by_phandle_optional(struct device_node *np,
 							const char *property);
 int of_syscon_register_regmap(struct device_node *np,
 			      struct regmap *regmap);
+void syscon_put_regmap(struct regmap *regmap);
+struct regmap *devm_syscon_regmap_lookup_by_phandle(struct device *dev,
+						    struct device_node *np,
+						    const char *property);
 #else
 static inline struct regmap *device_node_to_regmap(struct device_node *np)
 {
@@ -73,6 +78,17 @@ static inline int of_syscon_register_regmap(struct device_node *np,
 					struct regmap *regmap)
 {
 	return -EOPNOTSUPP;
+
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
 }
 
 #endif
-- 
2.45.0


