Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D4514CD56
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgA2P34 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:29:56 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55780 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726893AbgA2P34 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:29:56 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 86DFE47617;
        Wed, 29 Jan 2020 15:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311792; x=1582126193; bh=VQoCGMDO2i0LihBl3EKKUplVZDpvhoPezO9
        +fTxjTdg=; b=a73zkjO0Y1P4lADJt2/tEPr1GzM2ZsefB15GmaWHzF8KsrQyZI0
        9GvdgUg433EuMnzGzt/9wSaVccUmiTTSeLvB+UiV7dPGKMTMtiUGCsv2ba7gZt9+
        rW4ko65RhlUP4WnuPIBOgfFe0BycBdB1zbHE4BSWr0JyqMTtx2EQGJYw=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hEAT51PHg9XD; Wed, 29 Jan 2020 18:29:52 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 3A60F47605;
        Wed, 29 Jan 2020 18:29:51 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Jan 2020 18:29:50 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Stefan Roese <sr@denx.de>,
        <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Rajat Jain <rajatja@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH v7 03/26] PCI: hotplug: Initial support of the movable BARs feature
Date:   Wed, 29 Jan 2020 18:29:14 +0300
Message-ID: <20200129152937.311162-4-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129152937.311162-1-s.miroshnichenko@yadro.com>
References: <20200129152937.311162-1-s.miroshnichenko@yadro.com>
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
least some utilized BARs can be moved, with the following procedure:

1) notify all the drivers which support movable BARs to pause and release
   the BARs; the rest of the drivers are guaranteed that their devices will
   not get BARs moved;

2) release all the bridge windows and movable BARs;

3) try to recalculate new bridge windows that will fit all the BAR types:
   - immovable (including those marked with PCI_FIXED);
   - movable;
   - newly requested by hot-added devices;

4) if the previous step fails, disable BARs for one of the hot-added
   devices and retry from step 3;

5) notify the drivers, so they remap BARs and resume.

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
 - defines bool pci_can_move_bars and bool pci_dev_bar_movable(dev, bar);
 - invokes the new .rescan_prepare() and .rescan_done() driver notifiers;
 - disables the feature for the powerpc (support will be added later, in
   another series).

This is disabled by default in this first patch of the series, until a
patch in the middle, which finalizes the actual implementation. Then it
can be overridden per-arch using the pci_can_move_bars=false flag or by the
following command line option:

    pci=no_movable_bars

CC: Sam Bobroff <sbobroff@linux.ibm.com>
CC: Rajat Jain <rajatja@google.com>
CC: Lukas Wunner <lukas@wunner.de>
CC: Oliver O'Halloran <oohall@gmail.com>
CC: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 .../admin-guide/kernel-parameters.txt         |  1 +
 arch/powerpc/platforms/powernv/pci.c          |  2 +
 arch/powerpc/platforms/pseries/setup.c        |  2 +
 drivers/pci/pci.c                             |  4 +
 drivers/pci/pci.h                             |  2 +
 drivers/pci/probe.c                           | 81 ++++++++++++++++++-
 include/linux/pci.h                           |  6 ++
 7 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ec92120a7952..9f42cf43bf08 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3610,6 +3610,7 @@
 				may put more devices in an IOMMU group.
 		force_floating	[S390] Force usage of floating interrupts.
 		nomio		[S390] Do not use MIO instructions.
+		no_movable_bars	Don't allow BARs to be moved during hotplug
 
 	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
 			Management.
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index c0bea75ac27b..ec772aa31ccf 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -939,6 +939,8 @@ void __init pnv_pci_init(void)
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
index cb0042f28e6a..6741c7f111ac 100644
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
@@ -6477,6 +6479,8 @@ static int __init pci_setup(char *str)
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
 			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
 				disable_acs_redir_param = str + 18;
+			} else if (!strncmp(str, "no_movable_bars", 15)) {
+				pci_can_move_bars = false;
 			} else {
 				pr_err("PCI: Unknown option `%s'\n", str);
 			}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a0a53bd05a0b..ce8c53ca7a1e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -289,6 +289,8 @@ void pci_disable_bridge_window(struct pci_dev *dev);
 struct pci_bus *pci_bus_get(struct pci_bus *bus);
 void pci_bus_put(struct pci_bus *bus);
 
+bool pci_dev_bar_movable(struct pci_dev *dev, struct resource *res);
+
 /* PCIe link information */
 #define PCIE_SPEED2STR(speed) \
 	((speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2a7e81f146e4..9b6d15587f5d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2935,6 +2935,7 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 	 * or pci_bus_assign_resources().
 	 */
 	if (pci_has_flag(PCI_PROBE_ONLY)) {
+		pci_can_move_bars = false;
 		pci_bus_claim_resources(bus);
 	} else {
 		pci_bus_size_bridges(bus);
@@ -3127,6 +3128,68 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
 	return max;
 }
 
+bool pci_dev_bar_movable(struct pci_dev *dev, struct resource *res)
+{
+	struct pci_bus_region region;
+
+	if (!pci_can_move_bars)
+		return false;
+
+	if (res->flags & IORESOURCE_PCI_FIXED)
+		return false;
+
+	if (dev->driver && dev->driver->rescan_prepare)
+		return true;
+
+	/* Workaround for the legacy VGA memory 0xa0000-0xbffff */
+	pcibios_resource_to_bus(dev->bus, &region, res);
+	if (region.start == 0xa0000)
+		return false;
+
+	if (!dev->driver && !res->child)
+		return true;
+
+	return false;
+}
+
+static void pci_bus_rescan_prepare(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	if (bus->self)
+		pci_config_pm_runtime_get(bus->self);
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
+	if (bus->self)
+		pci_config_pm_runtime_put(bus->self);
+}
+
 /**
  * pci_rescan_bus - Scan a PCI bus for devices
  * @bus: PCI bus to scan
@@ -3139,9 +3202,23 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
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
index e473e70834b5..a543f647d337 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -817,6 +817,8 @@ struct module;
  *		e.g. drivers/net/e100.c.
  * @sriov_configure: Optional driver callback to allow configuration of
  *		number of VFs to enable via sysfs "sriov_numvfs" file.
+ * @rescan_prepare: Prepare to BAR movement - called before PCI rescan.
+ * @rescan_done: Remap BARs and restore after PCI rescan.
  * @err_handler: See Documentation/PCI/pci-error-recovery.rst
  * @groups:	Sysfs attribute groups.
  * @driver:	Driver model structure.
@@ -832,6 +834,8 @@ struct pci_driver {
 	int  (*resume)(struct pci_dev *dev);	/* Device woken up */
 	void (*shutdown)(struct pci_dev *dev);
 	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
+	void (*rescan_prepare)(struct pci_dev *dev);
+	void (*rescan_done)(struct pci_dev *dev);
 	const struct pci_error_handlers *err_handler;
 	const struct attribute_group **groups;
 	struct device_driver	driver;
@@ -1392,6 +1396,8 @@ void pci_setup_bridge(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type);
 
+extern bool pci_can_move_bars;
+
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
 
-- 
2.24.1

