Return-Path: <linux-pci+bounces-291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6831B7FF383
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 16:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A8D1C20D59
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 15:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BA3524B8;
	Thu, 30 Nov 2023 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lJk5cY2e"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFD31A3;
	Thu, 30 Nov 2023 07:24:26 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPA id 72988FF806;
	Thu, 30 Nov 2023 15:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701357865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPvyel4ZeW38fPIJ9TsfdFm6eZp6ZKA8PPSc++A7E08=;
	b=lJk5cY2ed3iNnANukJPQox3YYcMSQEsgyKi0f8gRc841baqVBOjsFIuHZzL4YrZRkcA5Q9
	KF3RsiHyKNKFvHzlpo8RnKqxE7rhaKCMjLZNLj0ixfXCtkjEgWF7VTf2L6s6ALkYaEj4kv
	8vroojrxIja/9rkH98cZqgkAbbLVu5CnY3XuYbFGVuqEFemIykIE8mWh2TG24z89moKLR9
	fyB8p7U7FNpwvy0ardVyl1zNQEOloHo5LoboJhLiCM1GNRu+3FBOxyTdB4W+KawN/R2Ae9
	a6u5xHTTu4AS6qqFFID4OI1r22cJdaPUN9v+xlvEOET6Rd0piK/dO6LP54Canw==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Rob Herring <robh@kernel.org>
Cc: Max Zhen <max.zhen@amd.com>,
	Sonal Santan <sonal.santan@amd.com>,
	Stefano Stabellini <stefano.stabellini@xilinx.com>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 1/2] driver core: Introduce device_{add,remove}_of_node()
Date: Thu, 30 Nov 2023 16:24:03 +0100
Message-ID: <20231130152418.680966-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130152418.680966-1-herve.codina@bootlin.com>
References: <20231130152418.680966-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

An of_node can be duplicated from an existing device using
device_set_of_node_from_dev() or initialized using device_set_node()
In both cases, these functions have to be called before the device_add()
call in order to have the of_node link created in the device sysfs
directory. Further more, these function cannot prevent any of_node
and/or fwnode overwrites.

When adding an of_node on an already present device, the following
operations need to be done:
- Attach the of_node if no of_node were already attached
- Attach the of_node as a fwnode if no fwnode were already attached
- Create the of_node sysfs link if needed

This is the purpose of device_add_of_node().
device_remove_of_node() reverts the operations done by
device_add_of_node().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/base/core.c    | 74 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |  2 ++
 2 files changed, 76 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2926f3b1f868..ac026187ac6a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5046,6 +5046,80 @@ void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
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
+	sysfs_remove_link(&dev->kobj, "of_node");
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
+	int ret;
+
+	if (!of_node)
+		return;
+
+	dev = get_device(dev);
+	if (!dev)
+		return;
+
+	if (dev->of_node) {
+		dev_warn(dev, "Replace node %pOF with %pOF\n", dev->of_node, of_node);
+		device_remove_of_node(dev);
+	}
+
+	dev->of_node = of_node_get(of_node);
+
+	if (!dev->fwnode)
+		dev->fwnode = of_fwnode_handle(of_node);
+
+	if (!dev->p) {
+		/*
+		 * device_add() was not previously called.
+		 * The of_node link will be created when device_add() is called.
+		 */
+		goto end;
+	}
+
+	/*
+	 * device_add() was previously called and so the of_node link was not
+	 * created by device_add_class_symlinks().
+	 * Create this link now.
+	 */
+	ret = sysfs_create_link(&dev->kobj, of_node_kobj(of_node), "of_node");
+	if (ret)
+		dev_warn(dev, "Error %d creating of_node link\n", ret);
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
index d7a72a8749ea..2b093e62907a 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1128,6 +1128,8 @@ int device_offline(struct device *dev);
 int device_online(struct device *dev);
 void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
 void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
+void device_add_of_node(struct device *dev, struct device_node *of_node);
+void device_remove_of_node(struct device *dev);
 void device_set_of_node_from_dev(struct device *dev, const struct device *dev2);
 void device_set_node(struct device *dev, struct fwnode_handle *fwnode);
 
-- 
2.42.0


