Return-Path: <linux-pci+bounces-19617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D162A08A0F
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 09:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCABF16188D
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 08:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CCB2080D0;
	Fri, 10 Jan 2025 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h3XFPOgw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9847D207E04;
	Fri, 10 Jan 2025 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736497611; cv=none; b=ONbKlRxTYEDY2pliZzWwYLvrXLBlCLEx6abAnSh+ZsVEJ+1QXd4xAHtsIz1+niuRcd+hCezqp1wnuCB8zkNz55GHj9NkUE6nQ6VZCySRyCFpgtv0798lOQol6WRhZQLYjUk2phG3u2oqlEQ8863hihKMCuVdKr2M5m7lj4gxE7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736497611; c=relaxed/simple;
	bh=5GTb6DZp06ovx0Ux9JTq0ypq0dxJ8Dwhha83bPb7smc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Piz11DnCipK5RVDWf9VAucCxZ7anWOGkYFPvFy1XMNXZBTsxn5yVDwlPNISFXerrVdM/iUadfp2x8siI8fyYZsJQ4r13qSS6EUPrlSewWQn26xPsXtyqoR+b8UKNfmd7ngAMiN6lM0xW7tQXgapaMb02kSBQHZatRmabfEFmxZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h3XFPOgw; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay7-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::227])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 8BBA9C47FA;
	Fri, 10 Jan 2025 08:21:57 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPA id B3F2720008;
	Fri, 10 Jan 2025 08:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736497315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNgXov3cni7kQDkWTh8wpdAuS8om6z2Gf6DhN7iBDVw=;
	b=h3XFPOgwu585jLlhhhV6jvs1PiDpZBBnQQguWwCxi7qZkRf+OEaP03KUGFlM1Lkzc0F31p
	MEPBp+vKiiGSTgppFNCrHEFV9v9WwfBpHpp8/i1eANOEhH/3ZVHpzV+2dyzYRFzr4Y5B6j
	WVK8fiJGt5K+DZjVUyBxnK0v1O6bFL4gMnT5haK6hI1fCB4dfXFoib7MR4mRhX/Nud+ML6
	5zLJmQs31kxM90tQHwNpzXX0lCFfxok7oHM/R4ueCHZ9l/KPZqZB0WHmd+28nB7/XmfVWS
	+3AxnqQRFX/Vzhe2G9VNNqLrv31ouYAFtkJBunrJG7K2bqpMIUQliV3AjPwgAg==
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
Subject: [PATCH v6 1/5] driver core: Introduce device_{add,remove}_of_node()
Date: Fri, 10 Jan 2025 09:21:37 +0100
Message-ID: <20250110082143.917590-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110082143.917590-1-herve.codina@bootlin.com>
References: <20250110082143.917590-1-herve.codina@bootlin.com>
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
 drivers/base/core.c    | 61 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |  2 ++
 2 files changed, 63 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 8b056306f04e..b32bff9ed18d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5216,6 +5216,67 @@ void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
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
index 667cb6db9019..ac1515f05e5d 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1149,6 +1149,8 @@ int device_online(struct device *dev);
 void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
 void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
 void device_set_node(struct device *dev, struct fwnode_handle *fwnode);
+int device_add_of_node(struct device *dev, struct device_node *of_node);
+void device_remove_of_node(struct device *dev);
 void device_set_of_node_from_dev(struct device *dev, const struct device *dev2);
 
 static inline struct device_node *dev_of_node(struct device *dev)
-- 
2.47.1


