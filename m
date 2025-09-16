Return-Path: <linux-pci+bounces-36225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF84B58F71
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 09:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559FF321906
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 07:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A2D2EB873;
	Tue, 16 Sep 2025 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e38VY6JO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F315C2EB853;
	Tue, 16 Sep 2025 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008717; cv=none; b=li33mjKmESICu9Yk5r9C9+26J7GbFYS6BWARybuHpBMa9KvATM4SQ35EjkBWRtUIdaTwaQCbipmvemo+0U6ufhDAhz8S5h7A2gc7ln7ETHyD9MsqbfffHJhLBJ6jYUsAOurAGgA/1Qu3D3nPDERDriZAheMxl1u9TZXGT2GZHWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008717; c=relaxed/simple;
	bh=L+rmVaZTkoNGFXRnqwO/2ib3IwA5h8QBXMSTU4xtLN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xy5jUjtyYuL0ibjYSktAlw1GbxzI0VVM6OlKAzxps7JUHH7SXdD1EWvS5l94nMYjg0/3sQ4aw30pL3OWFYsLdIbT3wOQ692Y6fFcF26lpx/YlH/6JeM2PNHcXGzaxavzt2JYQB6I38/Hr42ZGZA4NY7iroXApDlfBM4mM6ZUuTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e38VY6JO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4005C113CF;
	Tue, 16 Sep 2025 07:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758008716;
	bh=L+rmVaZTkoNGFXRnqwO/2ib3IwA5h8QBXMSTU4xtLN8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e38VY6JOPJo8UuZYtPEECUL7Sw/4CSkLvPNdCJL/OUPpO3qWgUHYKn9tdv3dfCnVi
	 Q3g7pSb5YGuMXOK8eC0uMzqFPcXxoBIbX7Zx12JyDR/0jg3TeuEbCXP7VLUezaeaFF
	 vKpdJBjm09itIrRHudKVTTfYd8QyRse7K5mqk8Luzy8iGyrqFYfTPr0AyN7VXcHnce
	 gt9JAK/pKiD5EDm6FVjF9JbmbY6G0bEhZXt8dGBUQ4YQy2QdTE5PvJs7rQtXaPEIc8
	 Jv8JI7koO3EHE44JI2lTz20QOBi7l1Hwrv5R7FuRpkbV7xMusY4UF1no04DeNH5eGf
	 PsRp24a2b8mdg==
From: Chris Li <chrisl@kernel.org>
Date: Tue, 16 Sep 2025 00:45:10 -0700
Subject: [PATCH v2 02/10] PCI/LUO: Create requested liveupdate device list
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-luo-pci-v2-2-c494053c3c08@kernel.org>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
In-Reply-To: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Len Brown <lenb@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
 Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
 Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
 Mike Rapoport <rppt@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
X-Mailer: b4 0.14.2

Introduce struct dev_liveupdate and add it to struct device.

Use the new struct to track a device's liveupdate states.
- flags: If not zero, the device participate the live update.

Currently the "flags" has two possible bit:
LU_BUSMASTER: The device is requested for perserving the bus master.
LU_BUSMASTER_BRIDGE: A child device is requested for preserving the
	bus master. The bridge will need to preserve bus master as well.

In the PCI subsystem prepare callback, create the requested device list
 as per the following rules:
- If the device is requested for liveupdate LU_BUSMASTER, then the parent
  bridge will be set LU_BUSMASTER_BRIDGE

The list of PCI root bus and its children bus lists form a tree of all
PCI buses. The tree is walked in postorder traversal, so that the device
on the child bus can mark the parent bridge for LU_BUSMASTER_BRIDGE.

After the postorder traversal of the bus tree then reverse order
enumerates the devices in the bus, all device marks either requested or
depended will be added to the requested device list.

This list of devices will be used in the next change to forward the
liveupdate call back into individual devices.

Note that collect_liveupdate_devices() returns the number of devices it
added to request_devices. This will be used in a subsequent commit so that
the PCI subsystem can calculate what size folio to allocate for its save

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 MAINTAINERS                    |  1 +
 drivers/pci/liveupdate.c       | 80 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.c     |  1 +
 drivers/pci/probe.c            |  4 ++-
 include/linux/dev_liveupdate.h | 44 +++++++++++++++++++++++
 include/linux/device.h         | 15 ++++++++
 6 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 85749a5da69f88544ccc749e9d723b1b54c0e3b7..1ae3d166cd35ec5c7818f202079ed5d10c09144b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14021,6 +14021,7 @@ F:	Documentation/ABI/testing/sysfs-kernel-liveupdate
 F:	Documentation/admin-guide/liveupdate.rst
 F:	drivers/misc/liveupdate/
 F:	drivers/pci/liveupdate/
+F:	include/linux/dev_liveupdate.h
 F:	include/linux/liveupdate.h
 F:	include/uapi/linux/liveupdate.h
 F:	tools/testing/selftests/liveupdate/
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 86b4f3a2fb44781c6e323ba029db510450556fa9..e8891844b8194dabf8d1e8e2d74d9c701bd741ca 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -6,14 +6,94 @@
  */
 
 #define pr_fmt(fmt) "PCI liveupdate: " fmt
+#define dev_fmt(fmt) "PCI liveupdate: " fmt
 
+#include <linux/types.h>
 #include <linux/liveupdate.h>
+#include "pci.h"
 
 #define PCI_SUBSYSTEM_NAME "pci"
 
+static void stack_push_buses(struct list_head *stack, struct list_head *buses)
+{
+	struct pci_bus *bus;
+
+	list_for_each_entry(bus, buses, node)
+		list_move_tail(&bus->dev.lu.lu_next, stack);
+}
+
+static void liveupdate_add_dev(struct device *dev, struct list_head *head)
+{
+	dev_info(dev, "collect liveupdate device: flags %x\n", dev->lu.flags);
+	list_move_tail(&dev->lu.lu_next, head);
+}
+
+static int collect_bus_devices_reverse(struct pci_bus *bus, struct list_head *head)
+{
+	struct pci_dev *pdev;
+	int count = 0;
+
+	list_for_each_entry_reverse(pdev, &bus->devices, bus_list) {
+		if (pdev->dev.lu.flags & LU_BUSMASTER &&  pdev->dev.parent)
+			pdev->dev.parent->lu.flags |= LU_BUSMASTER_BRIDGE;
+		if (pdev->dev.lu.flags) {
+			liveupdate_add_dev(&pdev->dev, head);
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
+		d->lu.flags &= ~LU_DEPENDED;
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
new file mode 100644
index 0000000000000000000000000000000000000000..72297cba08a999e89f7bc0997dabdbe14e0aa12c
--- /dev/null
+++ b/include/linux/dev_liveupdate.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ * Chris Li <chrisl@kernel.org>
+ */
+#ifndef _LINUX_DEV_LIVEUPDATE_H
+#define _LINUX_DEV_LIVEUPDATE_H
+
+#include <linux/liveupdate.h>
+
+#ifdef CONFIG_LIVEUPDATE
+
+enum liveupdate_flag {
+	LU_BUSMASTER = 1 << 0,
+	LU_BUSMASTER_BRIDGE = 2 << 0,
+};
+
+#define	LU_REQUESTED	(LU_BUSMASTER)
+#define	LU_DEPENDED	(LU_BUSMASTER_BRIDGE)
+
+/**
+ * struct dev_liveupdate - Device state for live update operations
+ * @lu_next:	List head for linking the device into live update
+ *		related lists (e.g., a list of devices participating
+ *		in a live update sequence).
+ * @flags:	Indicate what liveupdate feature does the device
+ *		participtate.
+ * @visited:	Only used by the bus devices when travese the PCI buses
+ *		to build the liveupdate devices list. Set if the child
+ *		buses have been pushed into the pending stack.
+ *
+ * This structure holds the state information required for performing
+ * live update operations on a device. It is embedded within a struct device.
+ */
+struct dev_liveupdate {
+	struct list_head lu_next;
+	enum liveupdate_flag flags;
+	bool visited:1;
+};
+
+#endif /* CONFIG_LIVEUPDATE */
+#endif /* _LINUX_DEV_LIVEUPDATE_H */
diff --git a/include/linux/device.h b/include/linux/device.h
index 4940db137fffff4ceacf819b32433a0f4898b125..e0b35c723239f1254a3b6152f433e0412cd3fb34 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -21,6 +21,7 @@
 #include <linux/lockdep.h>
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/dev_liveupdate.h>
 #include <linux/mutex.h>
 #include <linux/pm.h>
 #include <linux/atomic.h>
@@ -508,6 +509,7 @@ struct device_physical_location {
  * @pm_domain:	Provide callbacks that are executed during system suspend,
  * 		hibernation, system resume and during runtime PM transitions
  * 		along with subsystem-level and driver-level callbacks.
+ * @lu:		Live update state.
  * @em_pd:	device's energy model performance domain
  * @pins:	For device pin management.
  *		See Documentation/driver-api/pin-control.rst for details.
@@ -603,6 +605,10 @@ struct device {
 	struct dev_pm_info	power;
 	struct dev_pm_domain	*pm_domain;
 
+#ifdef CONFIG_LIVEUPDATE
+	struct dev_liveupdate	lu;
+#endif
+
 #ifdef CONFIG_ENERGY_MODEL
 	struct em_perf_domain	*em_pd;
 #endif
@@ -1168,4 +1174,13 @@ void device_link_wait_removal(void);
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
2.51.0.384.g4c02a37b29-goog


