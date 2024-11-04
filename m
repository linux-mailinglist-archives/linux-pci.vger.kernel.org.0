Return-Path: <linux-pci+bounces-15987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B45829BBBC9
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 18:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73EC92822B5
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 17:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163E91CDA3B;
	Mon,  4 Nov 2024 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Xia/Y4cV"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2D31CACFD;
	Mon,  4 Nov 2024 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740817; cv=none; b=IvrUMAO8O7qrD7NoaMj1nmZhLWDccaIQKqGFofod6akbqiW0Laa1WFCsnY+KlaYcpCC4tFoR3C5HlhjfCsMLAWLWPLHlnrzdbHxYOfENaUXYIDq1cDwlL5XSBlnM/ipIQjsmwWBMmVUjbgCOYuEu0NiJcWj6GhwGsZphUJzVzHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740817; c=relaxed/simple;
	bh=NwMSCaI0b8RGS3jn4oHDmv6MAzYS4vPG0txsV1EJP0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7OnkHYKRjnVVAX37NR+4pwBma3hk3nV4+kI8hd+ulQwPlwWIdigATLCwREQmXaV7x7T7V7+8eSDYllCNcfz4SYT0u8DvnjbrgBQHz8ZOrNstG1SIQV/x35sNI+SP1sPpTdV+wMpnAHqlf+x803dp7m02CpN5poy9QEp8XpOgOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Xia/Y4cV; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 5DA2A1BF203;
	Mon,  4 Nov 2024 17:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730740813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DoVk53M0b7TJweV9F3/GrYxUnWVI2icOOAP6maodiQs=;
	b=Xia/Y4cV7NLKY2ys9yYBiAIkmGNoNlbfZrPkGqxueCmeRM1q6O4edlLLTMnc+/mt04kxzc
	3DLnzhv8q6o/G+Vc5iREjobFBPdMkS+Fq2LQExo4krrh1QeJoXLTZhEk0v53MYHk22s5MZ
	xD1VXL8wmASpEf0UWTFxuwUK6lQCDIyn4k+86gRTIbTnnqKKZCjFPZz08rJU+bUUtdTveD
	QGZxXfhDQV750YyItpEj6BkGV9iiEG2nJ9OLoYhGIXKoQQu7CeJDlHbbKJDJus+QCDIf3m
	b0YNRTT6CJ/luecHv9bmdRx7xAgR5cKyOjZOgcPh58S38ALjIR6SJ1In7p5JuA==
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
Subject: [PATCH 6/6] PCI: of: Create device-tree root bus node
Date: Mon,  4 Nov 2024 18:20:00 +0100
Message-ID: <20241104172001.165640-7-herve.codina@bootlin.com>
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

PCI devices device-tree nodes can be already created. This was
introduced by commit 407d1a51921e ("PCI: Create device tree node for
bridge").

In order to have device-tree nodes related to PCI devices attached on
their PCI root bus, a root bus device-tree node is needed. This root bus
node will be used as the parent node of the first level devices scanned
on the bus.

On non device-tree based system (such as ACPI), a device-tree node for
the PCI root bus does not exist. Indeed, this component is not described
in a device-tree used at boot.

The device-tree PCI root bus node creation needs to be done at runtime.
This is done in the same way as for the creation of the PCI device
nodes. I.e. node and properties are created based on computed
information done by the PCI core.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pci/of.c          |  85 +++++++++++++++++++++++++++++++-
 drivers/pci/of_property.c | 101 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h         |   6 +++
 drivers/pci/probe.c       |   2 +
 drivers/pci/remove.c      |   2 +
 5 files changed, 195 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 141ffbb1b3e6..46733a293c3f 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -726,7 +726,90 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 out_free_name:
 	kfree(name);
 }
-#endif
+
+void of_pci_remove_root_bus_node(struct pci_bus *bus)
+{
+	struct device_node *np;
+
+	np = pci_bus_to_OF_node(bus);
+	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
+		return;
+
+	device_remove_of_node(&bus->dev);
+	of_changeset_revert(np->data);
+	of_changeset_destroy(np->data);
+	of_node_put(np);
+}
+
+void of_pci_make_root_bus_node(struct pci_bus *bus)
+{
+	struct device_node *np = NULL;
+	struct of_changeset *cset;
+	const char *name;
+	int ret;
+
+	/*
+	 * If there is already a device tree node linked to this device,
+	 * return immediately.
+	 */
+	if (pci_bus_to_OF_node(bus))
+		return;
+
+	/* Check if there is a DT root node to attach this created node */
+	if (!of_root) {
+		pr_err("of_root node is NULL, cannot create PCI root bus node");
+		return;
+	}
+
+	name = kasprintf(GFP_KERNEL, "pci-root@%x,%x", pci_domain_nr(bus),
+			 bus->number);
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
+	ret = of_pci_add_root_bus_properties(bus, cset, np);
+	if (ret)
+		goto out_free_node;
+
+	/*
+	 * This of_node will be added to an existing device. The of_node parent
+	 * is the root OF node and so this node will be handled by the platform
+	 * bus. Avoid any new device creation.
+	 */
+	of_node_set_flag(np, OF_POPULATED);
+	np->fwnode.dev = &bus->dev;
+	fwnode_dev_initialized(&np->fwnode, true);
+
+	ret = of_changeset_apply(cset);
+	if (ret)
+		goto out_free_node;
+
+	np->data = cset;
+
+	/* Add the of_node to the existing device */
+	device_add_of_node(&bus->dev, np);
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
 
 #endif /* CONFIG_PCI */
 
diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index e56159cc48e8..527fc51565f3 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -394,3 +394,104 @@ int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
 
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
+static int of_pci_root_bus_prop_ranges(struct pci_bus *bus,
+				       struct of_changeset *ocs,
+				       struct device_node *np)
+{
+	struct pci_host_bridge *bridge = to_pci_host_bridge(bus->bridge);
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
+		of_pci_set_address(NULL, &ranges[ranges_sz], val64, 0, flags, false);
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
+int of_pci_add_root_bus_properties(struct pci_bus *bus, struct of_changeset *ocs,
+				   struct device_node *np)
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
+	ret = of_pci_root_bus_prop_ranges(bus, ocs, np);
+	if (ret)
+		return ret;
+
+	return 0;
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 14d00ce45bfa..56e450807d5d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -802,9 +802,15 @@ void of_pci_make_dev_node(struct pci_dev *pdev);
 void of_pci_remove_node(struct pci_dev *pdev);
 int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
 			  struct device_node *np);
+void of_pci_make_root_bus_node(struct pci_bus *bus);
+void of_pci_remove_root_bus_node(struct pci_bus *bus);
+int of_pci_add_root_bus_properties(struct pci_bus *bus, struct of_changeset *ocs,
+				   struct device_node *np);
 #else
 static inline void of_pci_make_dev_node(struct pci_dev *pdev) { }
 static inline void of_pci_remove_node(struct pci_dev *pdev) { }
+static inline void of_pci_make_root_bus_node(struct pci_bus *bus) { }
+static inline void of_pci_remove_root_bus_node(struct pci_bus *bus) { }
 #endif
 
 #ifdef CONFIG_PCIEAER
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4f68414c3086..063780bec45e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1049,6 +1049,8 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 		dev_info(&bus->dev, "root bus resource %pR%s\n", res, addr);
 	}
 
+	of_pci_make_root_bus_node(bus);
+
 	down_write(&pci_bus_sem);
 	list_add_tail(&bus->node, &pci_root_buses);
 	up_write(&pci_bus_sem);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index e4ce1145aa3e..80cbe02f66b2 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -160,6 +160,8 @@ void pci_stop_root_bus(struct pci_bus *bus)
 					 &bus->devices, bus_list)
 		pci_stop_bus_device(child);
 
+	of_pci_remove_root_bus_node(bus);
+
 	/* stop the host bridge */
 	device_release_driver(&host_bridge->dev);
 }
-- 
2.46.2


