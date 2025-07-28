Return-Path: <linux-pci+bounces-33003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 181E1B1365A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFEE37A6A64
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158FD23E35B;
	Mon, 28 Jul 2025 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nc5D9WAx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98D523A9B0;
	Mon, 28 Jul 2025 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691090; cv=none; b=DyXklksXH4/v77eCsP+UE2P3zF0nDb/QkDNVf3d3MuAYzMpCzvrvo1n97fS09BXk3vjyjz+Hja2oEJogB0VIgO2XEgi2QmC9O2BXXCv9jP9ZFSi0ATOBU6aR5v3f20624dBYmLBkX78aEjyOqljgl0PZq7XQDT+DZmiN2n71p6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691090; c=relaxed/simple;
	bh=Jir/gBpBJ+r5ifaYxD/nIOTUYFdwjI6k89o91CyXUoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ntJtZFvluyDK7inu4zG3e3G4V7UyFvVKfF+qM+KzC/N9BpEL+BAuz2dNQiu+egy0aPftawZtC63H7RF4fZyHjAu7plA3ipyJRETyi9zwHenMTHers6kXMOs0X8+JFJ/zfOrZYHbZE7StpVxXv3YBSkXGIVKC1kMXVKZCmRoSKVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nc5D9WAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8C5C4CEE7;
	Mon, 28 Jul 2025 08:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691089;
	bh=Jir/gBpBJ+r5ifaYxD/nIOTUYFdwjI6k89o91CyXUoU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nc5D9WAxsEQ1kxwiN4/sxOCQGAw/DJBzQ9nib+P4Ert+MKa3yOGu2zI3wYWaJkFoM
	 fsKsqpNDYHqVnYyEejOr1RHmFCgTf4M/3Y+d3pqXfGd2XYPkKidMIZZzp6DwioE+nS
	 0PPbj2LyIzVPQE6CTFFjDBym7j9BqI4nuNohvRI5vtn43q34qGfdOcaJ0Pb3FYZs66
	 M8EDzMd7IuGsVhGMzYjlWH69dzWttb9YPPIrs5+VKO+kXKXKrWxWpjOSMDLOC+AYqC
	 RSXuJ+tWWuMZ+8IWGG6tICGR02M2SIRK4UrHQ7RjjX96C33WvwyKeZx40UiWoNpFUS
	 pkKxj5Jt0QFsA==
From: Chris Li <chrisl@kernel.org>
Date: Mon, 28 Jul 2025 01:24:33 -0700
Subject: [PATCH RFC 03/25] PCI/LUO: Create requested liveupdate device list
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-luo-pci-v1-3-955b078dd653@kernel.org>
References: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
In-Reply-To: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
 Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
 Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
 Mike Rapoport <rppt@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
X-Mailer: b4 0.14.2

In the PCI subsystem prepare callback, create the
requested device list as per the following rules:
- If the device is liveupdate requested, then the parent device will
  also be added to the list as "depended".
- If a SR-IOV VF device is liveupdate requested, then its corresponding
  PF device will also be added to the list as "depended".

The list of PCI root bus and its children bus lists form a tree of all
PCI buses. The tree is walked in postorder traversal, so that the device
on the child bus can mark the parent bridge as "depended".

Notice that the VF is always created after PF is created. Walk the
pci_bus->devices in the reverse order so that the VF can mark the PF as
"depended".

After the postorder traversal of the bus tree then reverse order
enumerates the devices in the bus, all device marks either requested or
depended will be added to the requested device list.

This list of devices will be used in the next change to forward the
liveupdate call back into individual devices.

Note that collect_liveupdate_devices() returns the number of devices it
added to request_devices. This will be used in a subsequent commit so that
the PCI subsystem can calculate what size folio to allocate for its save
state.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/liveupdate.c       | 81 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.c     |  1 +
 drivers/pci/probe.c            |  4 ++-
 include/linux/dev_liveupdate.h |  4 +++
 include/linux/device.h         |  9 +++++
 5 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 1c69adf412255c8ee5bc6db588ff04b1642e8e19..73cf13f58382d62969844ae6dd6160b1a77f844b 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -14,9 +14,90 @@
 
 #define PCI_SUBSYSTEM_NAME "pci"
 
+static void stack_push_buses(struct list_head *stack, struct list_head *buses)
+{
+	struct pci_bus *bus;
+
+	list_for_each_entry(bus, buses, node)
+		list_move_tail(&bus->dev.lu.lu_next, stack);
+}
+
+static void requested_devices_add(struct device *dev, struct list_head *head)
+{
+	dev_info(dev, "collect liveupdate device:%s%s\n",
+		 dev->lu.depended ? " [depended]" : "",
+		 dev->lu.requested ? " [requested]" : "");
+	list_move_tail(&dev->lu.lu_next, head);
+}
+
+static int collect_bus_devices_reverse(struct pci_bus *bus, struct list_head *head)
+{
+	struct pci_dev *pdev;
+	int count = 0;
+
+	list_for_each_entry_reverse(pdev, &bus->devices, bus_list) {
+		if (pdev->dev.lu.requested || pdev->dev.lu.depended) {
+			if (pdev->is_virtfn)
+				pdev->physfn->dev.lu.depended = 1;
+			if (pdev->dev.parent)
+				pdev->dev.parent->lu.depended = 1;
+			requested_devices_add(&pdev->dev, head);
+			count++;
+		}
+	}
+	return count;
+}
+
+static int build_liveupdate_devices(struct list_head *head)
+{
+	LIST_HEAD(bus_stack);
+	int count = 0;
+
+	stack_push_buses(&bus_stack, &pci_root_buses);
+
+	while (!list_empty(&bus_stack)) {
+		struct device *busdev;
+		struct pci_bus *bus;
+
+		busdev = list_last_entry(&bus_stack, struct device, lu.lu_next);
+		bus = to_pci_bus(busdev);
+		if (!busdev->lu.visited && !list_empty(&bus->children)) {
+			stack_push_buses(&bus_stack, &bus->children);
+			busdev->lu.visited = 1;
+			continue;
+		}
+
+		count += collect_bus_devices_reverse(bus, head);
+		busdev->lu.visited = 0;
+		list_del_init(&busdev->lu.lu_next);
+	}
+	return count;
+}
+
+static void cleanup_liveupdate_devices(struct list_head *head)
+{
+	struct device *d, *n;
+
+	list_for_each_entry_safe(d, n, head, lu.lu_next) {
+		d->lu.depended = 0;
+		list_del_init(&d->lu.lu_next);
+	}
+}
+
 static int pci_liveupdate_prepare(void *arg, u64 *data)
 {
+	LIST_HEAD(requested_devices);
+
 	pr_info("prepare data[%llx]\n", *data);
+
+	pci_lock_rescan_remove();
+	down_write(&pci_bus_sem);
+
+	build_liveupdate_devices(&requested_devices);
+	cleanup_liveupdate_devices(&requested_devices);
+
+	up_write(&pci_bus_sem);
+	pci_unlock_rescan_remove();
 	return 0;
 }
 
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index e8318fd5f6ed537a1b236a3a0f054161d5710abd..0e9ef387182856771d857181d88f376632b46f0d 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -304,6 +304,7 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
 	device = &pcie->device;
 	device->bus = &pcie_port_bus_type;
 	device->release = release_pcie_device;	/* callback to free pcie dev */
+	dev_liveupdate_init(device);
 	dev_set_name(device, "%s:pcie%03x",
 		     pci_name(pdev),
 		     get_descriptor_id(pci_pcie_type(pdev), service));
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4b8693ec9e4c67fc1655e0057b3b96b4098e6630..dddd7ebc03d1a6e6ee456e0bf02ab9833a819509 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -614,6 +614,7 @@ static struct pci_bus *pci_alloc_bus(struct pci_bus *parent)
 	INIT_LIST_HEAD(&b->devices);
 	INIT_LIST_HEAD(&b->slots);
 	INIT_LIST_HEAD(&b->resources);
+	dev_liveupdate_init(&b->dev);
 	b->max_bus_speed = PCI_SPEED_UNKNOWN;
 	b->cur_bus_speed = PCI_SPEED_UNKNOWN;
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
@@ -1985,6 +1986,7 @@ int pci_setup_device(struct pci_dev *dev)
 	dev->sysdata = dev->bus->sysdata;
 	dev->dev.parent = dev->bus->bridge;
 	dev->dev.bus = &pci_bus_type;
+	dev_liveupdate_init(&dev->dev);
 	dev->hdr_type = hdr_type & 0x7f;
 	dev->multifunction = !!(hdr_type & 0x80);
 	dev->error_state = pci_channel_io_normal;
@@ -3184,7 +3186,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		return NULL;
 
 	bridge->dev.parent = parent;
-
+	dev_liveupdate_init(&bridge->dev);
 	list_splice_init(resources, &bridge->windows);
 	bridge->sysdata = sysdata;
 	bridge->busnr = bus;
diff --git a/include/linux/dev_liveupdate.h b/include/linux/dev_liveupdate.h
index 057407c030b0872bfa8cd666e6ffc305f7aa4083..6b45452c8f1420b59ed3ce954a1623fd472045f4 100644
--- a/include/linux/dev_liveupdate.h
+++ b/include/linux/dev_liveupdate.h
@@ -21,6 +21,9 @@
  *		device (i.e. device will participate in live update).
  * @depended:	Set if the device participtate the live update due to
  *		one of its child device is requested in live update.
+ * @visited:	Only used by the bus devices when travese the PCI buses
+ *		to build the liveupdate devices list. Set if the child
+ *		buses have been pushed into the pending stack.
  *
  * This structure holds the state information required for performing
  * live update operations on a device. It is embedded within a struct device.
@@ -29,6 +32,7 @@ struct dev_liveupdate {
 	struct list_head lu_next;
 	bool requested:1;
 	bool depended:1;
+	bool visited:1;
 };
 
 #endif /* CONFIG_LIVEUPDATE */
diff --git a/include/linux/device.h b/include/linux/device.h
index 4aee7912218865168a73fe4c6d3a82646b8dd86f..e0b35c723239f1254a3b6152f433e0412cd3fb34 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1174,4 +1174,13 @@ void device_link_wait_removal(void);
 #define MODULE_ALIAS_CHARDEV_MAJOR(major) \
 	MODULE_ALIAS("char-major-" __stringify(major) "-*")
 
+#ifdef CONFIG_LIVEUPDATE
+static inline void dev_liveupdate_init(struct device *dev)
+{
+	INIT_LIST_HEAD(&dev->lu.lu_next);
+}
+#else
+static inline void dev_liveupdate_init(struct device *dev) {}
+#endif
+
 #endif /* _DEVICE_H_ */

-- 
2.50.1.487.gc89ff58d15-goog


