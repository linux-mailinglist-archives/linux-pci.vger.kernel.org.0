Return-Path: <linux-pci+bounces-15982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EC89BBBB0
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 18:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B83F1F22481
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 17:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A291F1C9DDF;
	Mon,  4 Nov 2024 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gwe7fO99"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E401C5793;
	Mon,  4 Nov 2024 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740813; cv=none; b=qB1uaULEZv0dACNBAftN+Z3c0yfxyeVJf7J4P8IcAW2G4m55d+dqXzTTuVfvUTfENDoIhQXGtfuh/0SwC13J295cjkQ83qNOBoj7JmyD0t4sPFhFTidsSOVXEhndLHIfCvR5pqNAPEC8ZurW7JZ9IQTeI0CgSUY4cQD0+0tjnuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740813; c=relaxed/simple;
	bh=hiS6n9pheg1VmpHKj++eyaK6UcsY7Peml+xl4mdMBQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHnFaL6GAaf/StoZJuZQPYQfBQwvgZ1uuBHYUrZX6ZlUbbE6aiX7a6Py98Ho6t/mjCf6foUzhQcQzW6cV6yMUxE9hjQSU4lXk/jXr+kWccbaeJ0o1JJu4/3ylIco8bnjrMJ8dHp30XAR975ZSmPhcGV3b5i+lmkmD5dtRft0iAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gwe7fO99; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 8FE281BF20B;
	Mon,  4 Nov 2024 17:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730740809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xXuggkRMR/uQkcFh5AavFOlwv1DgC3rb6WoS70TIrr8=;
	b=gwe7fO991rjyA85LZ0ZKf8j1ola4vp/LSTDZGWfeHhi7UE2VzKCUenKz/AMVBUh6bPXZAA
	yNP8Mq4MAiZrWA54Jx0VN7rklMJ2kgKj0/5QbTtfZMroO9SD5WVPETK6N1DIC0OmVEpy7h
	g433FByH+AIOPf0XUthCb6l2PAAMNuJBRh7J1ZAsfhwKQU6I/Z+ZwnPwlqOQKXBL1BUb+c
	xwlmj+jNuMTX09X/v5KnPX9WmnM1Q4rQxJqer0WzDF9fzRuRJAuJsk9cklSEG+tpdX0Xsm
	5zDyLyX5gVjRpWeKtOlAel2TDLVpceM8wAMJsZmlpv7sh0rRvDMD3Nx0IUeM1Q==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
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
	Herve Codina <herve.codina@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/6] driver core: Introduce device_{add,remove}_of_node()
Date: Mon,  4 Nov 2024 18:19:55 +0100
Message-ID: <20241104172001.165640-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241104172001.165640-1-herve.codina@bootlin.com>
References: <20241104172001.165640-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/base/core.c    | 52 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |  2 ++
 2 files changed, 54 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 24c572031403..0aa63371f55d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5118,6 +5118,58 @@ void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
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
+ */
+void device_add_of_node(struct device *dev, struct device_node *of_node)
+{
+	if (!of_node)
+		return;
+
+	dev = get_device(dev);
+	if (!dev)
+		return;
+
+	if (WARN(dev->of_node, "%s: Cannot replace node %pOF with %pOF\n",
+		 dev_name(dev), dev->of_node, of_node))
+		goto end;
+
+	dev->of_node = of_node_get(of_node);
+
+	if (!dev->fwnode)
+		dev->fwnode = of_fwnode_handle(of_node);
+
+end:
+	put_device(dev);
+}
+EXPORT_SYMBOL_GPL(device_add_of_node);
+
 /**
  * device_set_of_node_from_dev - reuse device-tree node of another device
  * @dev: device whose device-tree node is being set
diff --git a/include/linux/device.h b/include/linux/device.h
index b4bde8d22697..e3aa25ce1f90 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1146,6 +1146,8 @@ int device_online(struct device *dev);
 void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
 void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
 void device_set_node(struct device *dev, struct fwnode_handle *fwnode);
+void device_add_of_node(struct device *dev, struct device_node *of_node);
+void device_remove_of_node(struct device *dev);
 void device_set_of_node_from_dev(struct device *dev, const struct device *dev2);
 
 static inline struct device_node *dev_of_node(struct device *dev)
-- 
2.46.2


