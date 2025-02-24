Return-Path: <linux-pci+bounces-22206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8399A422EA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 15:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4F3444936
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 14:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7119413D52B;
	Mon, 24 Feb 2025 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jy7rZ+6e"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C27913A88A;
	Mon, 24 Feb 2025 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406452; cv=none; b=owEVPQWnKzZsfa7OdoJTX4F4IO4OrrFb9sS/0uJPlNNle90K2XoEHJ9ZuBGyOfh/VLYmtxNdEWYgw4r3Mo8i1jWR5OHR6FhYuNn4juOf3zrGszqBhaMI7+dngslc3E7GYajiwGvzZkdjjrVy7nYNKzMwo2MDtTZnLbXUU4jdtSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406452; c=relaxed/simple;
	bh=0+fSfJ7ZPp1VZn2GKQuaLkrfVbKpHzYKeEcjf/jh2BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/p+Zp4c+3S8hrYjpugtGsEukG+G4HJsH7WG6iCSjlFRwE6v8NcvE8tziDJwLGcGl7qxaWpglf9G//nAKDQ1UNSuglYpzBdE6aYxwEKkVndPHP0HhWePhvGqO/6OSbLKynhB8Ym5rpRKU8oUlJum4RkSZW1sOoMX4S/ohwLbtcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jy7rZ+6e; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id E4E274328A;
	Mon, 24 Feb 2025 14:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740406448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oASGst2miNGsHk1TmMJThWUjFwMWFRccPa77crLA71s=;
	b=Jy7rZ+6eUzqE0UHwc495MT25qUHx9GX+51Qxj8/nUXGO19ElhsfFytmtcQrrt9sffuiZLD
	UoKp+nGheazSJzrgwh9Mj0vnpPbl3TfSEAm/m7TP6oDPVaTprZ5mvLWsWLiX40DE8HCQTo
	vD0a/zVOx33pn+porFFdqVhGGuWlJp+OZKDDAmoiF2morRpOtGSjjiK0aORntfYptFKgvc
	RI9SL8kBkCljgkBLZ3spBWAI0KtN4I6yIHEDohMTcuRLOH5sf0Mf3XSwcchKiN73V+qtEj
	XMJxS9Ap3IX+Me9u2GW0ZD5GX0oKEOk5cgI23dzR1dyCM0NnRx757b8/G1j2qg==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v8 1/5] driver core: Introduce device_{add,remove}_of_node()
Date: Mon, 24 Feb 2025 15:13:51 +0100
Message-ID: <20250224141356.36325-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224141356.36325-1-herve.codina@bootlin.com>
References: <20250224141356.36325-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehffeigfejueelueeuffelueefgfelhfejhfehieegudekteeiledttdfhffekffenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghrrghvrghnrghksehgohhoghhlvgdrtghomhdprhgtphhtthhopegsh
 hgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhiiihhihdrhhhouhesrghmugdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: herve.codina@bootlin.com

An of_node can be set to a device using device_set_node().
This function cannot prevent any of_node and/or fwnode overwrites.

When adding an of_node on an already present device, the following
operations need to be done:
- Attach the of_node if no of_node were already attached
- Attach the of_node as a fwnode if no fwnode were already attached

This is the purpose of device_add_of_node().
device_remove_of_node() reverts the operations done by
device_add_of_node().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/base/core.c    | 61 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |  2 ++
 2 files changed, 63 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5a1f05198114..d1b044af64de 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5170,6 +5170,67 @@ void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(set_secondary_fwnode);
 
+/**
+ * device_remove_of_node - Remove an of_node from a device
+ * @dev: device whose device-tree node is being removed
+ */
+void device_remove_of_node(struct device *dev)
+{
+	dev = get_device(dev);
+	if (!dev)
+		return;
+
+	if (!dev->of_node)
+		goto end;
+
+	if (dev->fwnode == of_fwnode_handle(dev->of_node))
+		dev->fwnode = NULL;
+
+	of_node_put(dev->of_node);
+	dev->of_node = NULL;
+
+end:
+	put_device(dev);
+}
+EXPORT_SYMBOL_GPL(device_remove_of_node);
+
+/**
+ * device_add_of_node - Add an of_node to an existing device
+ * @dev: device whose device-tree node is being added
+ * @of_node: of_node to add
+ *
+ * Return: 0 on success or error code on failure.
+ */
+int device_add_of_node(struct device *dev, struct device_node *of_node)
+{
+	int ret;
+
+	if (!of_node)
+		return -EINVAL;
+
+	dev = get_device(dev);
+	if (!dev)
+		return -EINVAL;
+
+	if (dev->of_node) {
+		dev_err(dev, "Cannot replace node %pOF with %pOF\n",
+			dev->of_node, of_node);
+		ret = -EBUSY;
+		goto end;
+	}
+
+	dev->of_node = of_node_get(of_node);
+
+	if (!dev->fwnode)
+		dev->fwnode = of_fwnode_handle(of_node);
+
+	ret = 0;
+end:
+	put_device(dev);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(device_add_of_node);
+
 /**
  * device_set_of_node_from_dev - reuse device-tree node of another device
  * @dev: device whose device-tree node is being set
diff --git a/include/linux/device.h b/include/linux/device.h
index 80a5b3268986..1244e5892292 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1191,6 +1191,8 @@ int device_online(struct device *dev);
 void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
 void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
 void device_set_node(struct device *dev, struct fwnode_handle *fwnode);
+int device_add_of_node(struct device *dev, struct device_node *of_node);
+void device_remove_of_node(struct device *dev);
 void device_set_of_node_from_dev(struct device *dev, const struct device *dev2);
 
 static inline struct device_node *dev_of_node(struct device *dev)
-- 
2.48.1


