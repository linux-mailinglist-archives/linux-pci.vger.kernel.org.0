Return-Path: <linux-pci+bounces-300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7787FF77C
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 17:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE911C21124
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 16:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7BC55C3F;
	Thu, 30 Nov 2023 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Xtp5wPQs"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7D510DB;
	Thu, 30 Nov 2023 08:57:12 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPA id E63221BF205;
	Thu, 30 Nov 2023 16:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701363431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jm60+J+CYJrK2sHEFWjb0jmzaPleL4egUI26kWWOyu8=;
	b=Xtp5wPQsc+mP8/wUeDLsebCQBiTDsHw4ja3/eEJNJ1j1mn2TXWLHLBXxfCiDdcSdhDIjCA
	sjAwfuSRUGBOGdXzNxh9def0VLeg51y1mRh0EaUldZfEZO6C3SjN8uLlvh9DjUyNW5IZIN
	1ukankeKO05V4VjC7D8fHCzVKcGqP/I52KVFDo81B1penFj1sjoXsBQLdpyyO7sNPzyy+9
	yPxKBIZ/0qK5g1N0m7C2rWShMwm2+ctyiq3ysSs6illr7s+f8lRUiMvnc4WF30Hx2aaHgG
	DZaF3p7bkyIn76547h8TMvl17T+vKwRBq2wAyjD5olDJpa7U5oQTxLf+7jWrWA==
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
	Herve Codina <herve.codina@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] driver core: Introduce device_{add,remove}_of_node()
Date: Thu, 30 Nov 2023 17:56:58 +0100
Message-ID: <20231130165700.685764-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130165700.685764-1-herve.codina@bootlin.com>
References: <20231130165700.685764-1-herve.codina@bootlin.com>
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

Cc: stable@vger.kernel.org
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


