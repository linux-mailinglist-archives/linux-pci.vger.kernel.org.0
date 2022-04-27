Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692835115B6
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 13:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbiD0LFP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 07:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbiD0LE7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 07:04:59 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976A55535A;
        Wed, 27 Apr 2022 03:54:55 -0700 (PDT)
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 0C2BFC56EA;
        Wed, 27 Apr 2022 09:48:19 +0000 (UTC)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2AD19240004;
        Wed, 27 Apr 2022 09:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651052811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uCL2E5kCBWUm8Rv1Y0Fyb1TZVoxBKQdT85eHkMBS2Gk=;
        b=K3CtJnVkdGWY/rajy2k4wBoDtHaTL8VcDQi3rR/3mSlToPj3Kv/u1ngd2sMhS0g40eehUc
        twIXRW6OhVa1QtltSABUu7vFxAa9aus2+7EgzEDSQ9a3WEWZoeGdjnd9eWGI3wy0m7NFiX
        MbRSA6uTj+xTd5cJ/e+IB7v0bYl1MaeALEE5jjyFWuFm4vxV6Kh1M7RmDrr52vSa5SGrIH
        q7lONIS0c9DqDlYSgNPlNrY2MVV4BCpETqWvScYWfic568JrdialNNqU2CjN82a9q+8vo1
        yUutaeTH6CMIOK1Q534FsGNCmV4xYzlCElcqw7HzlEy42FZGPua8eBqezKXxKw==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazonni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 2/3] PCI: of: create DT nodes for PCI devices if they do not exists
Date:   Wed, 27 Apr 2022 11:45:01 +0200
Message-Id: <20220427094502.456111-3-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220427094502.456111-1-clement.leger@bootlin.com>
References: <20220427094502.456111-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to apply overlays to PCI device nodes, the nodes must first
exist. This commit add support to populate a skeleton tree for PCI bus
and devices. These nodes can then be used by drivers to apply overlays.

Co-developed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 drivers/pci/of.c | 184 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 184 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index cb2e8351c2cc..f2325708726e 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -16,12 +16,194 @@
 #include "pci.h"
 
 #ifdef CONFIG_PCI
+static int of_pci_add_property(struct of_changeset *ocs, struct device_node *np,
+			       const char *name, const void *value, int length)
+{
+	struct property *prop;
+	int ret = -ENOMEM;
+
+	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+	if (!prop)
+		return -ENOMEM;
+
+	prop->name = kstrdup(name, GFP_KERNEL);
+	if (!prop->name)
+		goto out_err;
+
+	if (value) {
+		prop->value = kmemdup(value, length, GFP_KERNEL);
+		if (!prop->value)
+			goto out_err;
+	} else {
+		/*
+		 * Even if the property has no value, it must be set to a
+		 * non-null value since of_get_property() is used to check
+		 * some values that might or not have a values (ranges for
+		 * instance). Moreover, when the node is released, prop->value
+		 * is kfreed so the memory must come from kmalloc.
+		 */
+		prop->value = kmalloc(1, GFP_KERNEL);
+		if (!prop->value)
+			goto out_err;
+	}
+
+	of_property_set_flag(prop, OF_DYNAMIC);
+
+	prop->length = length;
+
+	ret = of_changeset_add_property(ocs, np, prop);
+	if (!ret)
+		return 0;
+
+out_err:
+	kfree(prop->value);
+	kfree(prop->name);
+	kfree(prop);
+
+	return ret;
+}
+
+static struct device_node *of_pci_make_node(void)
+{
+	struct device_node *node;
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return NULL;
+
+	of_node_set_flag(node, OF_DYNAMIC);
+	of_node_set_flag(node, OF_DETACHED);
+	of_node_init(node);
+
+	return node;
+}
+
+static int of_pci_add_cells_props(struct device_node *node,
+				  struct of_changeset *cs, int n_addr_cells,
+				  int n_size_cells)
+{
+	__be32 val;
+	int ret;
+
+	ret = of_pci_add_property(cs, node, "ranges", NULL, 0);
+	if (ret)
+		return ret;
+
+	val = __cpu_to_be32(n_addr_cells);
+	ret = of_pci_add_property(cs, node, "#address-cells", &val,
+				  sizeof(__be32));
+	if (ret)
+		return ret;
+
+	val = __cpu_to_be32(n_size_cells);
+	return of_pci_add_property(cs, node, "#size-cells", &val,
+				   sizeof(__be32));
+}
+
+static int of_pci_add_pci_bus_props(struct device_node *node,
+				    struct of_changeset *cs)
+{
+	int ret;
+
+	ret = of_pci_add_property(cs, node, "device_type", "pci",
+				  strlen("pci") + 1);
+	if (ret)
+		return ret;
+
+	return of_pci_add_cells_props(node, cs, 3, 2);
+}
+
+static void of_pci_make_dev_node(struct pci_dev *dev)
+{
+	static struct of_changeset cs;
+	const char *pci_type = "dev";
+	struct device_node *node;
+	__be32 val[5] = {0};
+	int ret;
+
+	node = of_pci_make_node();
+	if (!node)
+		return;
+
+	node->parent = dev->bus->dev.of_node;
+	of_changeset_init(&cs);
+
+	if (pci_is_bridge(dev)) {
+		ret = of_pci_add_pci_bus_props(node, &cs);
+		if (ret)
+			goto changeset_destroy;
+		pci_type = "pci";
+	}
+
+	node->full_name = kasprintf(GFP_KERNEL, "%s@%x,%x", pci_type,
+				    PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+
+	val[0] = __cpu_to_be32(dev->devfn << 8);
+	val[4] = __cpu_to_be32(SZ_4K);
+	ret = of_pci_add_property(&cs, node, "reg", val, 5 * sizeof(__be32));
+	if (ret)
+		goto changeset_destroy;
+
+	ret = of_changeset_attach_node(&cs, node);
+	if (ret)
+		goto changeset_destroy;
+
+	ret = of_changeset_apply(&cs);
+	if (ret)
+		goto changeset_destroy;
+
+	dev->dev.of_node = node;
+
+	return;
+
+changeset_destroy:
+	of_changeset_destroy(&cs);
+	kfree(node);
+}
+
+static struct device_node *of_pci_create_root_bus_node(struct pci_bus *bus)
+{
+	static struct of_changeset cs;
+	struct device_node *node;
+	int ret;
+
+	node = of_pci_make_node();
+	if (!node)
+		return NULL;
+
+	node->full_name = "pci";
+	node->parent = of_root;
+
+	of_changeset_init(&cs);
+	ret = of_pci_add_pci_bus_props(node, &cs);
+	if (ret)
+		goto changeset_destroy;
+
+	ret = of_changeset_attach_node(&cs, node);
+	if (ret)
+		goto changeset_destroy;
+
+	ret = of_changeset_apply(&cs);
+	if (ret)
+		goto changeset_destroy;
+
+	return node;
+
+changeset_destroy:
+	of_changeset_destroy(&cs);
+	kfree(node);
+
+	return NULL;
+}
+
 void pci_set_of_node(struct pci_dev *dev)
 {
 	if (!dev->bus->dev.of_node)
 		return;
 	dev->dev.of_node = of_pci_find_child_device(dev->bus->dev.of_node,
 						    dev->devfn);
+	if (!dev->dev.of_node)
+		of_pci_make_dev_node(dev);
 	if (dev->dev.of_node)
 		dev->dev.fwnode = &dev->dev.of_node->fwnode;
 }
@@ -39,6 +221,8 @@ void pci_set_bus_of_node(struct pci_bus *bus)
 
 	if (bus->self == NULL) {
 		node = pcibios_get_phb_of_node(bus);
+		if (!node)
+			node = of_pci_create_root_bus_node(bus);
 	} else {
 		node = of_node_get(bus->self->dev.of_node);
 		if (node && of_property_read_bool(node, "external-facing"))
-- 
2.34.1

