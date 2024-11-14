Return-Path: <linux-pci+bounces-16784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2079C9041
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 17:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34E41F25F7E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 16:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04D618E750;
	Thu, 14 Nov 2024 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jCJ5sEf0"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B25C188703;
	Thu, 14 Nov 2024 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603304; cv=none; b=OwqQYottiLeT4K1M+c3s9T7/oTCWDB3qzwuCi2juaKYx+If4YOJEuZFASm5G9ZLW+9Uy87gqv3lApi0fP/SA+ubsA1Vns5fZW5mOSZxTutDXF5qjS37zJJNctZG5rg4t6hoIe9MhuykZ5xPMqEhiwxS41vtIxRDr8sGoollvfJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603304; c=relaxed/simple;
	bh=X1jO5oMtyP0jfnGU/DCU9nbdHu4XbZA426BHwEzqcTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cW2LlX22KdNZip7LzW/L9wkn41bug2BErGgo+BqpxonY2L8x0S7bE1Eb73X56AYMri2p68wNC+63m8E+c4UhtBHop3fJ4uqojkZOps10VzjfYUi1HhZ1q6dm/DLPY2x9AxGgQKtMLU2LUjjQvohzbJPSI7uBSn3+ZyJ+2F01kL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jCJ5sEf0; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 1BC5BE0009;
	Thu, 14 Nov 2024 16:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731603294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YlXInP/Xt7ICdvkV8lP0MjBbO+8189YppAjVn2WwHNM=;
	b=jCJ5sEf09yZRkk9kiemm+UfpCRzPPrbXXusSXUjuasdCfNsdS086oGM9FkDHpM9HefbdFh
	8w/HSVtL6/4syEPCGjtZcsjDKVjL4P8bSkt6WvGGcR4UVg52UuhYB2F2n8xUJxxToHriOV
	jKcm7i2DO5s8nIwHQ3y1hmiKjlg/Vy6WyoGNVJyI1R8zwqQc1ka97K2Iv04fHOmrF/fVow
	bpx56SchRzxYUvEMBqqsxFnvHzq4u6/vnZxVHuEWuzRRk5GnVWTRsh/nq+o5r43zGzABTu
	xzVacbPSgxXw7vz+nirx5XEEnDTZdYH7X71nPfge/kjte4hsCnpc/p6/rzQbgQ==
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
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v3 1/6] driver core: Introduce device_{add,remove}_of_node()
Date: Thu, 14 Nov 2024 17:54:37 +0100
Message-ID: <20241114165446.611458-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114165446.611458-1-herve.codina@bootlin.com>
References: <20241114165446.611458-1-herve.codina@bootlin.com>
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
2.47.0


