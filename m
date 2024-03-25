Return-Path: <linux-pci+bounces-5118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D5088AAD5
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 18:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7BA01C2F0C5
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 17:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F3074C1B;
	Mon, 25 Mar 2024 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kr5O9eyd"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E580713AA42;
	Mon, 25 Mar 2024 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381175; cv=none; b=PCBbM+i1qzqpNW5pbXJw08xqMej1xx2JH7GInFCcNS91La/O0v4EB5C9csdkPBLGEx8rA8oX6oqk4i2VKWKMetr28viSJr8bWRv+gspQ3YgwBALs4IgNyDjIi4Yg7pX78KpTQmdjK9OndHtt/T8xBpNYJ5rdfD+EuTWeDzsQ/SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381175; c=relaxed/simple;
	bh=h/gSBHnRArX2VKnlimaWRqSx2BilNLtlrRscxKyKgKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtaLLf5DL893BqIuOEheMxAiBMbolKWiKgVY+90h+ZPhMHgTxJ2s3aQ629MoZt1a/6ZRTuayFaUpmFNn8fwNp6OXCcC1Z6WirCZoBX16C4veMewYTansdof9saLShwStZNyktzhdpkbcbrMHIuFWmh07lvotgN+Zd9/kfISOdVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kr5O9eyd; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 0B9651BF209;
	Mon, 25 Mar 2024 15:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711381169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HQTGLkwc5FM7PqkTkKIyxo75nWhT3EHFGFIKtu+4NBE=;
	b=kr5O9eyd+6zYEO56uU+79EPm5uo3S0MZIDxkyj+fOYVQU4lPi2/ID9lCJ8QQFyakvPO0ID
	ucagZ3o+UBnKsxkeljBg4xvOWw/hpw8AL/k1QWXgcd6afKqX9dfPILD+qXpLlBcdfpF8ZM
	7/vMR4MErbBW7kgCEPnx3qk9tSbRXxaCRJaENLv3fXZfkaqyruCgLZ18mB55GDVCb9tXA1
	3RPk/1poj5uGYHHROgzoSpA3N5/20RzZzvaROBNKkSqnzJ/d3BIXjDpBFKGWDv7IAcPEet
	mUnwRENMB3oEft5vt1x5r6x/fAUo8UplhyqWhAm3Q4BzZ3vYiztN8XXADpcLPA==
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
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] driver core: Introduce device_{add,remove}_of_node()
Date: Mon, 25 Mar 2024 16:39:14 +0100
Message-ID: <20240325153919.199337-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325153919.199337-1-herve.codina@bootlin.com>
References: <20240325153919.199337-1-herve.codina@bootlin.com>
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
index 521757408fc0..7e3af0ad770a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5127,6 +5127,80 @@ void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
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
index 97c4b046c09d..1795121dee9a 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1127,6 +1127,8 @@ int device_offline(struct device *dev);
 int device_online(struct device *dev);
 void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
 void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
+void device_add_of_node(struct device *dev, struct device_node *of_node);
+void device_remove_of_node(struct device *dev);
 void device_set_of_node_from_dev(struct device *dev, const struct device *dev2);
 void device_set_node(struct device *dev, struct fwnode_handle *fwnode);
 
-- 
2.44.0


