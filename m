Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6649E1BAC70
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 20:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgD0SYV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 14:24:21 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:52950 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726226AbgD0SYV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 14:24:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 34B6B4C853;
        Mon, 27 Apr 2020 18:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1588011853; x=1589826254; bh=MHwrvBP5gh2GsVwic4sQO/g+7ejPNO8MZW2
        vGQqI81I=; b=rkciBREzoqmWXcUs0EI8n43HUOlId5hra/WAf+a5umg1YGj8Pif
        tKrHIo1UOUxcj9bdZNFA6rF2fXHZaHHzvO+Fi/GKtUA0gq03W9lC65sp+3TkeJSk
        mHmSFqiK37KUo7DW3bNGOnQ40UlsYrCD24QOxYc5stRxo9ihBDwL3CLE=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7jNyBtjofaIQ; Mon, 27 Apr 2020 21:24:13 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 912EF4C80C;
        Mon, 27 Apr 2020 21:24:11 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 27
 Apr 2020 21:24:10 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v8 03/24] PCI: hotplug: Initial support of the movable BARs feature
Date:   Mon, 27 Apr 2020 21:23:37 +0300
Message-ID: <20200427182358.2067702-4-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
References: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When hot-adding a device, the involved bridge may have windows not big
enough (or fragmented too much) for newly requested BARs to fit in. But
expanding these bridge windows may be impossible if they are wedged between
"neighboring" BARs.

Still, it may be possible to allocate a memory region for new BARs, if at
least some working BARs can be moved, using the following procedure:

1) Notify all the drivers which support movable BARs to pause and release
   the BARs; the rest of the drivers are guaranteed that their devices will
   not get BARs moved;

2) Release all the bridge windows and movable BARs;

3) Try to recalculate new bridge windows that will fit all the BAR types:
   - fixed (those marked with PCI_FIXED or bound by not-updated drivers);
   - movable;
   - newly requested by hot-added devices;

4) If that failed, disable BARs for one of the hot-added devices and repeat
   the step 3;

5) Notify the drivers, so they remap BARs and resume.

If bridge calculation and BAR assignment fail with hot-added devices, this
patchset disables their BARs, falling back to the same amount and size of
BARs as they were before the hotplug event. The kernel succeeded then - so
the same BAR layout will be reproduced again.

This makes the prior reservation of memory by BIOS/bootloader/firmware not
required anymore for the PCI hotplug.

Drivers indicate their support of movable BARs by implementing the new
.rescan_prepare() and .rescan_done() hooks in the struct pci_driver. All
device's activity must be paused during a rescan, and iounmap()+ioremap()
must be applied to every used BAR.

If a device is not bound to a driver, its BARs are considered movable.

For a higher probability of the successful BAR reassignment, all the BARs
and bridge windows should be released during a rescan, not only those with
higher addresses.

One example when it is needed, BAR(I) is moved to free a gap for the new
BAR(II):

Before:

    ==================== parent bridge window ===============
                   ---- hotplug bridge window ----
    |   BAR(I)    |   fixed BAR   |   fixed BAR   | fixed BAR |
        ^^^^^^                 ^
                               |
                           new BAR(II)

After:

    ==================== parent bridge window =========================
     ----------- hotplug bridge window -----------
    | new BAR(II) |   fixed BAR   |   fixed BAR   | fixed BAR | BAR(I)  |
      ^^^^^^^^^^^                                               ^^^^^^

Another example is a fragmented bridge window jammed between fixed BARs:

Before:

     ===================== parent bridge window ========================
                 ---------- hotplug bridge window ----------
    | fixed BAR |   | BAR(I) |    | BAR(II) |    | BAR(III) | fixed BAR |
                      ^^^^^^   ^    ^^^^^^^        ^^^^^^^^
                               |
                           new BAR(IV)

After:

     ==================== parent bridge window =========================
                 ---------- hotplug bridge window ----------
    | fixed BAR | BAR(I) | BAR(II) | BAR(III) | new BAR(IV) | fixed BAR |
                  ^^^^^^   ^^^^^^^   ^^^^^^^^   ^^^^^^^^^^^

This patch is a preparation for future patches with actual implementation,
and for now it just does the following:
 - declares the feature;
 - defines bool pci_can_move_bars and bool pci_dev_bar_fixed(dev, bar);
 - invokes the new .rescan_prepare() and .rescan_done() driver notifiers;
 - disables the feature for the powerpc (support will be added later, in
   another series).

The feature is disabled in this first patch of the series, until the actual
implementation if finalized by the following patches. It can be overridden
per-arch using the pci_can_move_bars=false flag or by the following command
line option:

    pci=no_movable_bars

Current approach doesn't support calculating windows for subtractive decode
bridges, so disable BAR movement if such bridge is present.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 Documentation/PCI/pci.rst                     | 55 +++++++++++
 .../admin-guide/kernel-parameters.txt         |  1 +
 arch/powerpc/platforms/powernv/pci.c          |  2 +
 arch/powerpc/platforms/pseries/setup.c        |  2 +
 drivers/pci/pci.c                             |  4 +
 drivers/pci/pci.h                             |  2 +
 drivers/pci/probe.c                           | 99 ++++++++++++++++++-
 include/linux/pci.h                           |  6 ++
 8 files changed, 169 insertions(+), 2 deletions(-)

diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
index 8c016d8c9862..2449f0b43c5a 100644
--- a/Documentation/PCI/pci.rst
+++ b/Documentation/PCI/pci.rst
@@ -576,3 +576,58 @@ handle the PCI master abort on all platforms if the PCI device is
 expected to not respond to a readl().  Most x86 platforms will allow
 MMIO reads to master abort (a.k.a. "Soft Fail") and return garbage
 (e.g. ~0). But many RISC platforms will crash (a.k.a."Hard Fail").
+
+
+Movable BARs
+============
+
+To increase the probability of finding a space for BARs of hot-added devices,
+the kernel requests the drivers to release used BARs, so they can be moved
+to free a gap for new BARs.
+
+This ability can be added to a driver by implementing the
+:c:type:`rescan_prepare()` and :c:type:`rescan_done()` hooks from the
+:c:type:`struct pci_driver`.
+
+Before a PCI bus rescan the driver must pause its activity and unmap its
+BARs, here is an example of how the NVME driver can perform this::
+
+    static struct pci_driver nvme_driver = {
+            ...
+            .rescan_prepare = nvme_rescan_prepare,
+            .rescan_done    = nvme_rescan_done,
+    };
+
+    static void nvme_rescan_prepare(struct pci_dev *pdev)
+    {
+            struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+            nvme_dev_disable(dev, false);
+            nvme_dev_unmap(dev);
+            dev->bar = NULL;
+    }
+
+After a PCI rescan, the driver must re-read new addresses of BARs, remap
+them and resume::
+
+    static void nvme_rescan_done(struct pci_dev *pdev)
+    {
+            struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+            nvme_dev_map(dev);
+            nvme_reset_ctrl_sync(&dev->ctrl);
+    }
+
+Currently there are no reliable way to determine if a driver uses BARs of
+its devices or not (their :c:type:`struct resource` don't always have a child),
+so if it doesn't explicitly support movable BARs, they are considered fixed.
+To let the PCI subsystem move unused BARs, a driver still must implement empty
+hooks::
+
+    static void pcie_portdrv_rescan_prepare(struct pci_dev *pdev)
+    {
+    }
+
+    static void pcie_portdrv_rescan_done(struct pci_dev *pdev)
+    {
+    }
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7bc83f3d9bdf..0ef5635961ca 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3669,6 +3669,7 @@
 				may put more devices in an IOMMU group.
 		force_floating	[S390] Force usage of floating interrupts.
 		nomio		[S390] Do not use MIO instructions.
+		no_movable_bars	Don't allow BARs to be moved during hotplug
 
 	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
 			Management.
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 5bf818246339..20e2f4289c23 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -896,6 +896,8 @@ void __init pnv_pci_init(void)
 {
 	struct device_node *np;
 
+	pci_can_move_bars = false;
+
 	pci_add_flags(PCI_CAN_SKIP_ISA_ALIGN);
 
 	/* If we don't have OPAL, eg. in sim, just skip PCI probe */
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 0c8421dd01ab..2edb41f55237 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -927,6 +927,8 @@ static void __init pseries_init(void)
 {
 	pr_debug(" -> pseries_init()\n");
 
+	pci_can_move_bars = false;
+
 #ifdef CONFIG_HVC_CONSOLE
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		hvc_vio_init_early();
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2c0ae81d260d..5ae07991edff 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -79,6 +79,8 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
 int pci_domains_supported = 1;
 #endif
 
+bool pci_can_move_bars;
+
 #define DEFAULT_CARDBUS_IO_SIZE		(256)
 #define DEFAULT_CARDBUS_MEM_SIZE	(64*1024*1024)
 /* pci=cbmemsize=nnM,cbiosize=nn can override this */
@@ -6553,6 +6555,8 @@ static int __init pci_setup(char *str)
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
 			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
 				disable_acs_redir_param = str + 18;
+			} else if (!strncmp(str, "no_movable_bars", 15)) {
+				pci_can_move_bars = false;
 			} else {
 				pr_err("PCI: Unknown option `%s'\n", str);
 			}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6d3f75867106..25e49c5b998b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -292,6 +292,8 @@ void pci_disable_bridge_window(struct pci_dev *dev);
 struct pci_bus *pci_bus_get(struct pci_bus *bus);
 void pci_bus_put(struct pci_bus *bus);
 
+bool pci_dev_bar_fixed(struct pci_dev *dev, struct resource *res);
+
 /* PCIe link information from Link Capabilities 2 */
 #define PCIE_LNKCAP2_SLS2SPEED(lnkcap2) \
 	((lnkcap2) & PCI_EXP_LNKCAP2_SLS_32_0GB ? PCIE_SPEED_32_0GT : \
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dd169e2935df..1ac08b64ce83 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2443,6 +2443,11 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	/* Fix up broken headers */
 	pci_fixup_device(pci_fixup_header, dev);
 
+	if (dev->transparent && pci_can_move_bars) {
+		pci_info(dev, "Disable movable BARs in presence of a transparent bridge\n");
+		pci_can_move_bars = false;
+	}
+
 	pci_reassigndev_resource_alignment(dev);
 
 	dev->state_saved = false;
@@ -2977,6 +2982,7 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 	 * or pci_bus_assign_resources().
 	 */
 	if (pci_has_flag(PCI_PROBE_ONLY)) {
+		pci_can_move_bars = false;
 		pci_bus_claim_resources(bus);
 	} else {
 		pci_bus_size_bridges(bus);
@@ -3169,6 +3175,81 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
 	return max;
 }
 
+bool pci_dev_bar_fixed(struct pci_dev *dev, struct resource *res)
+{
+	struct pci_bus_region region;
+	int resno = res - dev->resource;
+
+	/* Bridge windows are never fixed */
+	if (resno >= PCI_BRIDGE_RESOURCES)
+		return false;
+
+	if (res->flags & IORESOURCE_PCI_FIXED)
+		return true;
+
+	if (!pci_can_move_bars)
+		return false;
+
+	if (dev->driver && dev->driver->rescan_prepare)
+		return false;
+
+	/* Workaround for the legacy VGA memory 0xa0000-0xbffff */
+	pcibios_resource_to_bus(dev->bus, &region, res);
+	if (region.start == 0xa0000)
+		return true;
+
+	if (!dev->driver && !res->child)
+		return false;
+
+	return true;
+}
+
+static void pci_bus_rescan_prepare(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	if (bus->self) {
+		pci_config_pm_runtime_get(bus->self);
+		pm_runtime_get_sync(&bus->self->dev);
+	}
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *child = dev->subordinate;
+
+		if (child)
+			pci_bus_rescan_prepare(child);
+
+		if (dev->driver &&
+		    dev->driver->rescan_prepare)
+			dev->driver->rescan_prepare(dev);
+	}
+}
+
+static void pci_bus_rescan_done(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	if (bus->self && !pci_dev_is_added(bus->self))
+		return;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *child = dev->subordinate;
+
+		if (dev->driver &&
+		    dev->driver->rescan_done)
+			dev->driver->rescan_done(dev);
+
+		if (child)
+			pci_bus_rescan_done(child);
+	}
+
+	if (bus->self) {
+		pci_save_state(bus->self);
+		pm_runtime_put(&bus->self->dev);
+		pci_config_pm_runtime_put(bus->self);
+	}
+}
+
 /**
  * pci_rescan_bus - Scan a PCI bus for devices
  * @bus: PCI bus to scan
@@ -3181,9 +3262,23 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
 unsigned int pci_rescan_bus(struct pci_bus *bus)
 {
 	unsigned int max;
+	struct pci_bus *root = bus;
+
+	while (!pci_is_root_bus(root))
+		root = root->parent;
+
+	if (pci_can_move_bars) {
+		pci_bus_rescan_prepare(root);
+
+		max = pci_scan_child_bus(root);
+		pci_assign_unassigned_root_bus_resources(root);
+
+		pci_bus_rescan_done(root);
+	} else {
+		max = pci_scan_child_bus(bus);
+		pci_assign_unassigned_bus_resources(bus);
+	}
 
-	max = pci_scan_child_bus(bus);
-	pci_assign_unassigned_bus_resources(bus);
 	pci_bus_add_devices(bus);
 
 	return max;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d3c9fc20fc1f..adfc8dfdc87b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -831,6 +831,8 @@ struct module;
  *		e.g. drivers/net/e100.c.
  * @sriov_configure: Optional driver callback to allow configuration of
  *		number of VFs to enable via sysfs "sriov_numvfs" file.
+ * @rescan_prepare: Prepare to BAR movement - called before PCI rescan.
+ * @rescan_done: Remap BARs and restore after PCI rescan.
  * @err_handler: See Documentation/PCI/pci-error-recovery.rst
  * @groups:	Sysfs attribute groups.
  * @driver:	Driver model structure.
@@ -846,6 +848,8 @@ struct pci_driver {
 	int  (*resume)(struct pci_dev *dev);	/* Device woken up */
 	void (*shutdown)(struct pci_dev *dev);
 	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
+	void (*rescan_prepare)(struct pci_dev *dev);
+	void (*rescan_done)(struct pci_dev *dev);
 	const struct pci_error_handlers *err_handler;
 	const struct attribute_group **groups;
 	struct device_driver	driver;
@@ -1409,6 +1413,8 @@ void pci_setup_bridge(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type);
 
+extern bool pci_can_move_bars;
+
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
 
-- 
2.24.1

