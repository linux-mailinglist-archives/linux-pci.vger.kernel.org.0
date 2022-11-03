Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BF3617B52
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 12:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiKCLGD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 07:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiKCLGB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 07:06:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA235FC8
        for <linux-pci@vger.kernel.org>; Thu,  3 Nov 2022 04:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667473560; x=1699009560;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OqXCjeEVTQItCfu/0zMRs8pAFhe29Rz5SIcDPTpqfBk=;
  b=bvfRxSH7LKROaQnKogpYG8EzIYMYXUaFOjPL2coi2zeOqbwkFXDbFi06
   tZpkBlJzGCIcx58IUfRkms0NS1lBh9r3RdXAU3A4fkn2LCDl9kIIKc1BJ
   xN9Vfe1DwQXEYrqBm5i10i47axrspUq7Sa9ZlWjE/ImkngvyWWm+n0r9T
   DTE/ehWushy9s0ggwSD+Hz66mIPgGTULHEJ+xyNDnIHQ1ogjzM1IXKHui
   5mMjSR4rNbQDqPZj/OiY7L5N/eEv9v17JEum7FLc4ROhUsaQt4cMnlhUd
   zOPB4/LU5iPv4xUbBj8x6IjlBHHalUE1icVNUt877WN5TkEY1UzS6CfEQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="395957356"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="395957356"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 04:06:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="585756028"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="585756028"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 Nov 2022 04:05:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 70824F7; Thu,  3 Nov 2022 13:06:20 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S . Miller" <davem@davemloft.net>,
        Juergen Gross <jgross@suse.com>, linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] PCI: Introduce pci_dev_for_each_resource()
Date:   Thu,  3 Nov 2022 13:06:20 +0200
Message-Id: <20221103110620.30938-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of open-coding it everywhere introduce a tiny helper that can be
used to iterate over each resource of a PCI device, and convert the most
obvious users into it.

While at it drop doubled empty line before pdev_sort_resources().

No functional changes intended.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
This applies on top of this patch I just sent out:

https://lore.kernel.org/linux-pci/20221103103254.30497-1-mika.westerberg@linux.intel.com/

 arch/alpha/kernel/pci.c          |  5 ++---
 arch/arm/kernel/bios32.c         | 13 +++++++------
 arch/mips/pci/pci-legacy.c       |  3 +--
 arch/powerpc/kernel/pci-common.c |  5 ++---
 arch/sparc/kernel/leon_pci.c     |  5 ++---
 arch/sparc/kernel/pci.c          | 10 ++++------
 arch/sparc/kernel/pcic.c         |  5 ++---
 drivers/pci/remove.c             |  4 ++--
 drivers/pci/setup-bus.c          | 23 ++++++++++-------------
 drivers/pci/setup-res.c          |  4 +---
 drivers/pci/xen-pcifront.c       |  4 +---
 include/linux/pci.h              | 11 +++++++++++
 12 files changed, 45 insertions(+), 47 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 64fbfb0763b2..4458eb7f44f0 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -288,11 +288,10 @@ pcibios_claim_one_bus(struct pci_bus *b)
 	struct pci_bus *child_bus;
 
 	list_for_each_entry(dev, &b->devices, bus_list) {
+		struct resource *r;
 		int i;
 
-		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-			struct resource *r = &dev->resource[i];
-
+		pci_dev_for_each_resource(dev, r, i) {
 			if (r->parent || !r->start || !r->flags)
 				continue;
 			if (pci_has_flag(PCI_PROBE_ONLY) ||
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index e7ef2b5bea9c..6135b81c3351 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -145,12 +145,14 @@ static void pci_fixup_dec21285(struct pci_dev *dev)
 	int i;
 
 	if (dev->devfn == 0) {
+		struct resource *r;
+
 		dev->class &= 0xff;
 		dev->class |= PCI_CLASS_BRIDGE_HOST << 8;
-		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-			dev->resource[i].start = 0;
-			dev->resource[i].end   = 0;
-			dev->resource[i].flags = 0;
+		pci_dev_for_each_resource(dev, r, i) {
+			r->start = 0;
+			r->end = 0;
+			r->flags = 0;
 		}
 	}
 }
@@ -167,8 +169,7 @@ static void pci_fixup_ide_bases(struct pci_dev *dev)
 	if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE)
 		return;
 
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		r = dev->resource + i;
+	pci_dev_for_each_resource(dev, r, i) {
 		if ((r->start & ~0x80) == 0x374) {
 			r->start |= 2;
 			r->end = r->start;
diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
index 468722c8a5c6..ec2567f8efd8 100644
--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -249,12 +249,11 @@ static int pcibios_enable_resources(struct pci_dev *dev, int mask)
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	old_cmd = cmd;
-	for (idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
+	pci_dev_for_each_resource(dev, r, idx) {
 		/* Only set up the requested stuff */
 		if (!(mask & (1<<idx)))
 			continue;
 
-		r = &dev->resource[idx];
 		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
 			continue;
 		if ((idx == PCI_ROM_RESOURCE) &&
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index d67cf79bf5d0..8ddcfa6bcb50 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1452,11 +1452,10 @@ void pcibios_claim_one_bus(struct pci_bus *bus)
 	struct pci_bus *child_bus;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct resource *r;
 		int i;
 
-		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-			struct resource *r = &dev->resource[i];
-
+		pci_dev_for_each_resource(dev, r, i) {
 			if (r->parent || !r->start || !r->flags)
 				continue;
 
diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
index e5e5ff6b9a5c..b6663a3fbae9 100644
--- a/arch/sparc/kernel/leon_pci.c
+++ b/arch/sparc/kernel/leon_pci.c
@@ -62,15 +62,14 @@ void leon_pci_init(struct platform_device *ofdev, struct leon_pci_info *info)
 
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
+	struct resource *res;
 	u16 cmd, oldcmd;
 	int i;
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	oldcmd = cmd;
 
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *res = &dev->resource[i];
-
+	pci_dev_for_each_resource(dev, res, i) {
 		/* Only set up the requested stuff */
 		if (!(mask & (1<<i)))
 			continue;
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index cb1ef25116e9..a948a49817c7 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -663,11 +663,10 @@ static void pci_claim_bus_resources(struct pci_bus *bus)
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct resource *r;
 		int i;
 
-		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-			struct resource *r = &dev->resource[i];
-
+		pci_dev_for_each_resource(dev, r, i) {
 			if (r->parent || !r->start || !r->flags)
 				continue;
 
@@ -724,15 +723,14 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
+	struct resource *res;
 	u16 cmd, oldcmd;
 	int i;
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	oldcmd = cmd;
 
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *res = &dev->resource[i];
-
+	pci_dev_for_each_resource(dev, res, i) {
 		/* Only set up the requested stuff */
 		if (!(mask & (1<<i)))
 			continue;
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index ee4c9a9a171c..25fe0a061732 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -643,15 +643,14 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
+	struct resource *res;
 	u16 cmd, oldcmd;
 	int i;
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	oldcmd = cmd;
 
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *res = &dev->resource[i];
-
+	pci_dev_for_each_resource(dev, res, i) {
 		/* Only set up the requested stuff */
 		if (!(mask & (1<<i)))
 			continue;
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 4c54c75050dc..dee2dcb60339 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -5,10 +5,10 @@
 
 static void pci_free_resources(struct pci_dev *dev)
 {
+	struct resource *res;
 	int i;
 
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *res = dev->resource + i;
+	pci_dev_for_each_resource(dev, res, i) {
 		if (res->parent)
 			release_resource(res);
 	}
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e512f9ecb9d0..549283aa31e6 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -124,20 +124,17 @@ static resource_size_t get_res_add_align(struct list_head *head,
 	return dev_res ? dev_res->min_align : 0;
 }
 
-
 /* Sort resources by alignment */
 static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 {
+	struct resource *r;
 	int i;
 
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *r;
+	pci_dev_for_each_resource(dev, r, i) {
 		struct pci_dev_resource *dev_res, *tmp;
 		resource_size_t r_align;
 		struct list_head *n;
 
-		r = &dev->resource[i];
-
 		if (r->flags & IORESOURCE_PCI_FIXED)
 			continue;
 
@@ -895,10 +892,10 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 
 	min_align = window_alignment(bus, IORESOURCE_IO);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct resource *r;
 		int i;
 
-		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-			struct resource *r = &dev->resource[i];
+		pci_dev_for_each_resource(dev, r, i) {
 			unsigned long r_size;
 
 			if (r->parent || !(r->flags & IORESOURCE_IO))
@@ -1014,10 +1011,10 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	size = 0;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct resource *r;
 		int i;
 
-		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-			struct resource *r = &dev->resource[i];
+		pci_dev_for_each_resource(dev, r, i) {
 			resource_size_t r_size;
 
 			if (r->parent || (r->flags & IORESOURCE_PCI_FIXED) ||
@@ -1358,11 +1355,11 @@ static void assign_fixed_resource_on_bus(struct pci_bus *b, struct resource *r)
  */
 static void pdev_assign_fixed_resources(struct pci_dev *dev)
 {
+	struct resource *r;
 	int i;
 
-	for (i = 0; i <  PCI_NUM_RESOURCES; i++) {
+	pci_dev_for_each_resource(dev, r, i) {
 		struct pci_bus *b;
-		struct resource *r = &dev->resource[i];
 
 		if (r->parent || !(r->flags & IORESOURCE_PCI_FIXED) ||
 		    !(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
@@ -1845,6 +1842,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 		 * distributing the rest.
 		 */
 		list_for_each_entry(dev, &bus->devices, bus_list) {
+			struct resource *dev_res;
 			int i;
 
 			if (dev == bridge)
@@ -1857,8 +1855,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 			if (!dev->multifunction)
 				return;
 
-			for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-				const struct resource *dev_res = &dev->resource[i];
+			pci_dev_for_each_resource(dev, dev_res, i) {
 				resource_size_t dev_sz;
 				struct resource *b_res;
 
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index b492e67c3d87..967f9a758923 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -484,12 +484,10 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	old_cmd = cmd;
 
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+	pci_dev_for_each_resource(dev, r, i) {
 		if (!(mask & (1 << i)))
 			continue;
 
-		r = &dev->resource[i];
-
 		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
 			continue;
 		if ((i == PCI_ROM_RESOURCE) &&
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 7378e2f3e525..ce485ef59656 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -390,9 +390,7 @@ static int pcifront_claim_resource(struct pci_dev *dev, void *data)
 	int i;
 	struct resource *r;
 
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		r = &dev->resource[i];
-
+	pci_dev_for_each_resource(dev, r, i) {
 		if (!r->parent && r->start && r->flags) {
 			dev_info(&pdev->xdev->dev, "claiming resource %s/%d\n",
 				pci_name(dev), i);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2bda4a4e47e8..461ac1ecf6a6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1407,6 +1407,17 @@ int pci_request_selected_regions(struct pci_dev *, int, const char *);
 int pci_request_selected_regions_exclusive(struct pci_dev *, int, const char *);
 void pci_release_selected_regions(struct pci_dev *, int);
 
+/**
+ * pci_dev_for_each_resource() - Iterate over each PCI device resource
+ * @dev: PCI device
+ * @res: Variable that holds the current resource
+ * @i: Iterator
+ */
+#define pci_dev_for_each_resource(dev, res, i)			\
+	for (i = 0;						\
+	     res = &(dev)->resource[i], i < PCI_NUM_RESOURCES;	\
+	     i++)
+
 /* drivers/pci/bus.c */
 void pci_add_resource(struct list_head *resources, struct resource *res);
 void pci_add_resource_offset(struct list_head *resources, struct resource *res,
-- 
2.35.1

