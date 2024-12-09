Return-Path: <linux-pci+bounces-17929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ACA9E95E4
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 14:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5203A16838D
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 13:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3D922A1F0;
	Mon,  9 Dec 2024 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eterYFYR"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E9622836B;
	Mon,  9 Dec 2024 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749442; cv=none; b=bxla2i7xlEzgaIDezMMog/aUMIF73YZGZ82Nf1VRO1VXXkRPwKJnX/awT53XLULQNDq0klISlj7UzTnxuV0oKwqWjTxplPrWqQUyaf3Z7coMjNw4CsoXmextkQd1UcgOFOmYK3nfui8NI0ZluUGN1KUpmbUIimF3rc9LZ6G+p7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749442; c=relaxed/simple;
	bh=2m0bRIt84esqdY2tbrfVc8hkhzt9dIH1Tu3l7xr/jOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ag0ROkgmTFMqEprOUNoPM2W7lQvFNcVhEZRSgKC11N2hB1GPQQHic0dSbv7hc0VVEhF2BpqN76Rxlv+UH2e1m8oLD3Yg++/AGkzvVUxeq0SX0AgHdS/QKPAN6GVkjFIgIZ1CYJQvL2u184vCaFJXNIFntxF1a1xhm23mH0iZjw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eterYFYR; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id B01C02000B;
	Mon,  9 Dec 2024 13:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733749437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwfUhO3+xL3wjByaS4cka9lum+biB/hQLNfnNUBPr5c=;
	b=eterYFYRQBT9nTiFjHPzhJQC0pdI5oY1z9DhHQlTV5iYPEZpNUGKiZwe4BaU9U3kPX9x9e
	7gm64ZP5cxdDKpogzB7CIS7xWENdq2dK3rtOfvgdoRuoYjnPE9W0Hm3sXfZEEXUsPSDIpu
	dDWZxuYoc+6LL9JcAsJxdPvj3PhMONEF6jYSvHMgtFRJ73VE8ySSROJ1Ot+2mX5ky6IHhR
	qsao6xPSEaCX504P9zY/uwBfX5Iu4Bjr6U5dMSLRfc8ZaChnFB17Cwxcl17mzJic7zNO+O
	YZLRAQZFTsG1R3/OPyMZONP9UzaYEb/v2xHWHEGsVO2T6Pgu9w8tXpmJcY73PQ==
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
Subject: [PATCH v5 5/5] PCI: of: Create device-tree PCI host bridge node
Date: Mon,  9 Dec 2024 14:03:37 +0100
Message-ID: <20241209130339.81354-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241209130339.81354-1-herve.codina@bootlin.com>
References: <20241209130339.81354-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

PCI devices device-tree nodes can be already created. This was
introduced by commit 407d1a51921e ("PCI: Create device tree node for
bridge").

In order to have device-tree nodes related to PCI devices attached on
their PCI root bus (the PCI bus handled by the PCI host bridge), a PCI
root bus device-tree node is needed. This root bus node will be used as
the parent node of the first level devices scanned on the bus. On
device-tree based systems, this PCI root bus device tree node is set to
the node of the related PCI host bridge. The PCI host bridge node is
available in the device-tree used to describe the hardware passed at
boot.

On non device-tree based system (such as ACPI), a device-tree node for
the PCI host bridge or for the root bus does not exist. Indeed, the PCI
host bridge is not described in a device-tree used at boot simply
because no device-tree are passed at boot.

The device-tree PCI host bridge node creation needs to be done at
runtime. This is done in the same way as for the creation of the PCI
device nodes. I.e. node and properties are created based on computed
information done by the PCI core. Also, as is done on device-tree based
systems, this PCI host bridge node is used for the PCI root bus.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pci/of.c          |  94 ++++++++++++++++++++++++++++++++++-
 drivers/pci/of_property.c | 102 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h         |   6 +++
 drivers/pci/probe.c       |   2 +
 drivers/pci/remove.c      |   2 +
 5 files changed, 205 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3cca33105b85..108a67be12ea 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -726,7 +726,99 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 out_free_name:
 	kfree(name);
 }
-#endif
+
+void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge)
+{
+	struct device_node *np;
+
+	np = pci_bus_to_OF_node(bridge->bus);
+	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
+		return;
+
+	device_remove_of_node(&bridge->bus->dev);
+	device_remove_of_node(&bridge->dev);
+	of_changeset_revert(np->data);
+	of_changeset_destroy(np->data);
+	of_node_put(np);
+}
+
+void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
+{
+	struct device_node *np = NULL;
+	struct of_changeset *cset;
+	const char *name;
+	int ret;
+
+	/*
+	 * If there is already a device-tree node linked to the PCI bus handled
+	 * by this bridge (i.e. the PCI root bus), nothing to do.
+	 */
+	if (pci_bus_to_OF_node(bridge->bus))
+		return;
+
+	/* The root bus has no node. Check that the host bridge has no node too */
+	if (bridge->dev.of_node) {
+		dev_err(&bridge->dev, "PCI host bridge of_node already set");
+		return;
+	}
+
+	/* Check if there is a DT root node to attach the created node */
+	if (!of_root) {
+		pr_err("of_root node is NULL, cannot create PCI host bridge node\n");
+		return;
+	}
+
+	name = kasprintf(GFP_KERNEL, "pci@%x,%x", pci_domain_nr(bridge->bus),
+			 bridge->bus->number);
+	if (!name)
+		return;
+
+	cset = kmalloc(sizeof(*cset), GFP_KERNEL);
+	if (!cset)
+		goto out_free_name;
+	of_changeset_init(cset);
+
+	np = of_changeset_create_node(cset, of_root, name);
+	if (!np)
+		goto out_destroy_cset;
+
+	ret = of_pci_add_host_bridge_properties(bridge, cset, np);
+	if (ret)
+		goto out_free_node;
+
+	/*
+	 * This of_node will be added to an existing device. The of_node parent
+	 * is the root OF node and so this node will be handled by the platform
+	 * bus. Avoid any new device creation.
+	 */
+	of_node_set_flag(np, OF_POPULATED);
+	np->fwnode.dev = &bridge->dev;
+	fwnode_dev_initialized(&np->fwnode, true);
+
+	ret = of_changeset_apply(cset);
+	if (ret)
+		goto out_free_node;
+
+	np->data = cset;
+
+	/* Add the of_node to host bridge and the root bus */
+	device_add_of_node(&bridge->dev, np);
+	device_add_of_node(&bridge->bus->dev, np);
+
+	kfree(name);
+
+	return;
+
+out_free_node:
+	of_node_put(np);
+out_destroy_cset:
+	of_changeset_destroy(cset);
+	kfree(cset);
+out_free_name:
+	kfree(name);
+}
+
+#endif /* CONFIG_PCI_DYNAMIC_OF_NODES */
 
 /**
  * of_pci_supply_present() - Check if the power supply is present for the PCI
diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 400c4c2e434d..b03baff651ee 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -394,3 +394,105 @@ int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
 
 	return 0;
 }
+
+static bool of_pci_is_range_resource(const struct resource *res, u32 *flags)
+{
+	if (!(resource_type(res) & IORESOURCE_MEM) &&
+	    !(resource_type(res) & IORESOURCE_MEM_64))
+		return false;
+
+	if (of_pci_get_addr_flags(res, flags))
+		return false;
+
+	return true;
+}
+
+static int of_pci_host_bridge_prop_ranges(struct pci_host_bridge *bridge,
+					  struct of_changeset *ocs,
+					  struct device_node *np)
+{
+	struct resource_entry *window;
+	unsigned int ranges_sz = 0;
+	unsigned int n_range = 0;
+	struct resource *res;
+	int n_addr_cells;
+	u32 *ranges;
+	u64 val64;
+	u32 flags;
+	int ret;
+
+	n_addr_cells = of_n_addr_cells(np);
+	if (n_addr_cells <= 0 || n_addr_cells > 2)
+		return -EINVAL;
+
+	resource_list_for_each_entry(window, &bridge->windows) {
+		res = window->res;
+		if (!of_pci_is_range_resource(res, &flags))
+			continue;
+		n_range++;
+	}
+
+	if (!n_range)
+		return 0;
+
+	ranges = kcalloc(n_range,
+			 (OF_PCI_ADDRESS_CELLS + OF_PCI_SIZE_CELLS +
+			  n_addr_cells) * sizeof(*ranges),
+			 GFP_KERNEL);
+	if (!ranges)
+		return -ENOMEM;
+
+	resource_list_for_each_entry(window, &bridge->windows) {
+		res = window->res;
+		if (!of_pci_is_range_resource(res, &flags))
+			continue;
+
+		/* PCI bus address */
+		val64 = res->start;
+		of_pci_set_address(NULL, &ranges[ranges_sz], val64 - window->offset,
+				   0, flags, false);
+		ranges_sz += OF_PCI_ADDRESS_CELLS;
+
+		/* Host bus address */
+		if (n_addr_cells == 2)
+			ranges[ranges_sz++] = upper_32_bits(val64);
+		ranges[ranges_sz++] = lower_32_bits(val64);
+
+		/* Size */
+		val64 = resource_size(res);
+		ranges[ranges_sz] = upper_32_bits(val64);
+		ranges[ranges_sz + 1] = lower_32_bits(val64);
+		ranges_sz += OF_PCI_SIZE_CELLS;
+	}
+
+	ret = of_changeset_add_prop_u32_array(ocs, np, "ranges", ranges, ranges_sz);
+	kfree(ranges);
+	return ret;
+}
+
+int of_pci_add_host_bridge_properties(struct pci_host_bridge *bridge,
+				      struct of_changeset *ocs,
+				      struct device_node *np)
+{
+	int ret;
+
+	ret = of_changeset_add_prop_string(ocs, np, "device_type", "pci");
+	if (ret)
+		return ret;
+
+	ret = of_changeset_add_prop_u32(ocs, np, "#address-cells",
+					OF_PCI_ADDRESS_CELLS);
+	if (ret)
+		return ret;
+
+	ret = of_changeset_add_prop_u32(ocs, np, "#size-cells",
+					OF_PCI_SIZE_CELLS);
+	if (ret)
+		return ret;
+
+	ret = of_pci_host_bridge_prop_ranges(bridge, ocs, np);
+	if (ret)
+		return ret;
+
+	return 0;
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2e40fc63ba31..0cdb2b3daea8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -871,9 +871,15 @@ void of_pci_make_dev_node(struct pci_dev *pdev);
 void of_pci_remove_node(struct pci_dev *pdev);
 int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
 			  struct device_node *np);
+void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge);
+void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge);
+int of_pci_add_host_bridge_properties(struct pci_host_bridge *bridge, struct of_changeset *ocs,
+				      struct device_node *np);
 #else
 static inline void of_pci_make_dev_node(struct pci_dev *pdev) { }
 static inline void of_pci_remove_node(struct pci_dev *pdev) { }
+static inline void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge) { }
+static inline void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge) { }
 #endif
 
 #ifdef CONFIG_PCIEAER
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2e81ab0f5a25..629287f6b3d9 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1051,6 +1051,8 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 		dev_info(&bus->dev, "root bus resource %pR%s\n", res, addr);
 	}
 
+	of_pci_make_host_bridge_node(bridge);
+
 	down_write(&pci_bus_sem);
 	list_add_tail(&bus->node, &pci_root_buses);
 	up_write(&pci_bus_sem);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index efc37fcb73e2..9f7df2b20183 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -163,6 +163,8 @@ void pci_stop_root_bus(struct pci_bus *bus)
 					 &bus->devices, bus_list)
 		pci_stop_bus_device(child);
 
+	of_pci_remove_host_bridge_node(host_bridge);
+
 	/* stop the host bridge */
 	device_release_driver(&host_bridge->dev);
 }
-- 
2.47.0


