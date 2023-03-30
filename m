Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635966D0B31
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 18:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjC3Q2r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 12:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjC3Q2g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 12:28:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3C683FA;
        Thu, 30 Mar 2023 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680193715; x=1711729715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VJ1PyQpGGPwbQf2lA7TScIDKb/DRRzKOJStqePaN450=;
  b=QDVgFCAh3EJ+pMB+BYsqmtGjC+FerPaWqyncraQAYxNWFskfaSxPDUXj
   je2x3xuJdOU270FN5YiA5oO3su9qC/10tN+8NJNDOsKFxenHrBEraO4iR
   CEreuwh8ry30/LFjLw+85DNcICTTBwd9GrpiGdtxhMFbZmbd33t6AvzQz
   yHclRxWBUe/KrePyfSdVRAAoO4jJMk8ZtmqvSoAzCFJKMGc/+ccIDKgRs
   YVqMRzSr6+FneoyA4H+VH0cdZeJdR5jLoMkpeImku1lpN9sR+2Ou9wcXD
   NPx2OUUVfchZ2SADd+sGLTXOkJc1z0/ilPGByhh8iTn92yze+ee5Yk3a7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="427496137"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="427496137"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 09:28:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="858971556"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="858971556"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 30 Mar 2023 09:28:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E3FC727B; Thu, 30 Mar 2023 19:24:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Juergen Gross <jgross@suse.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Anatolij Gustschin <agust@denx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH v8 5/7] PCI: Allow pci_bus_for_each_resource() to take less arguments
Date:   Thu, 30 Mar 2023 19:24:32 +0300
Message-Id: <20230330162434.35055-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230330162434.35055-1-andriy.shevchenko@linux.intel.com>
References: <20230330162434.35055-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Refactor pci_bus_for_each_resource() in the same way as it's done in
pci_dev_for_each_resource() case. This will allow to hide iterator
inside the loop, where it's not used otherwise.

No functional changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 drivers/pci/bus.c                  |  7 +++----
 drivers/pci/hotplug/shpchp_sysfs.c |  8 ++++----
 drivers/pci/pci.c                  |  3 +--
 drivers/pci/probe.c                |  2 +-
 drivers/pci/setup-bus.c            | 10 ++++------
 include/linux/pci.h                | 24 +++++++++++++++++++-----
 6 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 549c4bd5caec..5bc81cc0a2de 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -182,13 +182,13 @@ static int pci_bus_alloc_from_region(struct pci_bus *bus, struct resource *res,
 		void *alignf_data,
 		struct pci_bus_region *region)
 {
-	int i, ret;
 	struct resource *r, avail;
 	resource_size_t max;
+	int ret;
 
 	type_mask |= IORESOURCE_TYPE_BITS;
 
-	pci_bus_for_each_resource(bus, r, i) {
+	pci_bus_for_each_resource(bus, r) {
 		resource_size_t min_used = min;
 
 		if (!r)
@@ -289,9 +289,8 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx)
 	struct resource *res = &dev->resource[idx];
 	struct resource orig_res = *res;
 	struct resource *r;
-	int i;
 
-	pci_bus_for_each_resource(bus, r, i) {
+	pci_bus_for_each_resource(bus, r) {
 		resource_size_t start, end;
 
 		if (!r)
diff --git a/drivers/pci/hotplug/shpchp_sysfs.c b/drivers/pci/hotplug/shpchp_sysfs.c
index 64beed7a26be..01d47a42da04 100644
--- a/drivers/pci/hotplug/shpchp_sysfs.c
+++ b/drivers/pci/hotplug/shpchp_sysfs.c
@@ -24,16 +24,16 @@
 static ssize_t show_ctrl(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev;
-	int index, busnr;
 	struct resource *res;
 	struct pci_bus *bus;
 	size_t len = 0;
+	int busnr;
 
 	pdev = to_pci_dev(dev);
 	bus = pdev->subordinate;
 
 	len += sysfs_emit_at(buf, len, "Free resources: memory\n");
-	pci_bus_for_each_resource(bus, res, index) {
+	pci_bus_for_each_resource(bus, res) {
 		if (res && (res->flags & IORESOURCE_MEM) &&
 				!(res->flags & IORESOURCE_PREFETCH)) {
 			len += sysfs_emit_at(buf, len,
@@ -43,7 +43,7 @@ static ssize_t show_ctrl(struct device *dev, struct device_attribute *attr, char
 		}
 	}
 	len += sysfs_emit_at(buf, len, "Free resources: prefetchable memory\n");
-	pci_bus_for_each_resource(bus, res, index) {
+	pci_bus_for_each_resource(bus, res) {
 		if (res && (res->flags & IORESOURCE_MEM) &&
 			       (res->flags & IORESOURCE_PREFETCH)) {
 			len += sysfs_emit_at(buf, len,
@@ -53,7 +53,7 @@ static ssize_t show_ctrl(struct device *dev, struct device_attribute *attr, char
 		}
 	}
 	len += sysfs_emit_at(buf, len, "Free resources: IO\n");
-	pci_bus_for_each_resource(bus, res, index) {
+	pci_bus_for_each_resource(bus, res) {
 		if (res && (res->flags & IORESOURCE_IO)) {
 			len += sysfs_emit_at(buf, len,
 					     "start = %8.8llx, length = %8.8llx\n",
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 45c3bb039f21..585bb3988ddf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -779,9 +779,8 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 {
 	const struct pci_bus *bus = dev->bus;
 	struct resource *r;
-	int i;
 
-	pci_bus_for_each_resource(bus, r, i) {
+	pci_bus_for_each_resource(bus, r) {
 		if (!r)
 			continue;
 		if (resource_contains(r, res)) {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a3f68b6ba6ac..f8191750f6b7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -533,7 +533,7 @@ void pci_read_bridge_bases(struct pci_bus *child)
 	pci_read_bridge_mmio_pref(child);
 
 	if (dev->transparent) {
-		pci_bus_for_each_resource(child->parent, res, i) {
+		pci_bus_for_each_resource(child->parent, res) {
 			if (res && res->flags) {
 				pci_bus_add_resource(child, res,
 						     PCI_SUBTRACTIVE_DECODE);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 027b985dd1ee..fdeb121e9175 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -770,9 +770,8 @@ static struct resource *find_bus_resource_of_type(struct pci_bus *bus,
 						  unsigned long type)
 {
 	struct resource *r, *r_assigned = NULL;
-	int i;
 
-	pci_bus_for_each_resource(bus, r, i) {
+	pci_bus_for_each_resource(bus, r) {
 		if (r == &ioport_resource || r == &iomem_resource)
 			continue;
 		if (r && (r->flags & type_mask) == type && !r->parent)
@@ -1204,7 +1203,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 			additional_mmio_pref_size = 0;
 	struct resource *pref;
 	struct pci_host_bridge *host;
-	int hdr_type, i, ret;
+	int hdr_type, ret;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct pci_bus *b = dev->subordinate;
@@ -1228,7 +1227,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		host = to_pci_host_bridge(bus->bridge);
 		if (!host->size_windows)
 			return;
-		pci_bus_for_each_resource(bus, pref, i)
+		pci_bus_for_each_resource(bus, pref)
 			if (pref && (pref->flags & IORESOURCE_PREFETCH))
 				break;
 		hdr_type = -1;	/* Intentionally invalid - not a PCI device. */
@@ -1333,12 +1332,11 @@ EXPORT_SYMBOL(pci_bus_size_bridges);
 
 static void assign_fixed_resource_on_bus(struct pci_bus *b, struct resource *r)
 {
-	int i;
 	struct resource *parent_r;
 	unsigned long mask = IORESOURCE_IO | IORESOURCE_MEM |
 			     IORESOURCE_PREFETCH;
 
-	pci_bus_for_each_resource(b, parent_r, i) {
+	pci_bus_for_each_resource(b, parent_r) {
 		if (!parent_r)
 			continue;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e3b3af606280..56670d016cac 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1446,11 +1446,21 @@ int devm_request_pci_bus_resources(struct device *dev,
 /* Temporary until new and working PCI SBR API in place */
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 
+#define __pci_bus_for_each_res0(bus, res, ...)				\
+	for (unsigned int __b = 0;					\
+	     (res = pci_bus_resource_n(bus, __b)) || __b < PCI_BRIDGE_RESOURCE_NUM; \
+	     __b++)
+
+#define __pci_bus_for_each_res1(bus, res, __b)				\
+	for (__b = 0;							\
+	     (res = pci_bus_resource_n(bus, __b)) || __b < PCI_BRIDGE_RESOURCE_NUM; \
+	     __b++)
+
 /**
  * pci_bus_for_each_resource - iterate over PCI bus resources
  * @bus: the PCI bus
  * @res: a varible to keep a pointer to the current resource
- * @i: a variable to keep the index of the current resource
+ * @...: an optional variable to keep the index of the current resource
  *
  * Iterate over PCI bus resources. The first part is to go over PCI bus
  * resource array, which has at most the %PCI_BRIDGE_RESOURCE_NUM entries.
@@ -1463,13 +1473,17 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
  *	struct resource *res;
  *	unsigned int i;
  *
+ * 	// With an additional index variable
  * 	pci_bus_for_each_resource(bus, res, i)
  * 		pr_info("PCI bus resource[%u]: %pR\n", i, res);
+ *
+ * 	// Without index
+ * 	pci_bus_for_each_resource(bus, res)
+ * 		_do_something_(res);
  */
-#define pci_bus_for_each_resource(bus, res, i)				\
-	for (i = 0;							\
-	    (res = pci_bus_resource_n(bus, i)) || i < PCI_BRIDGE_RESOURCE_NUM; \
-	     i++)
+#define pci_bus_for_each_resource(bus, res, ...)			\
+	CONCATENATE(__pci_bus_for_each_res, COUNT_ARGS(__VA_ARGS__))	\
+		    (bus, res, __VA_ARGS__)
 
 int __must_check pci_bus_alloc_resource(struct pci_bus *bus,
 			struct resource *res, resource_size_t size,
-- 
2.40.0.1.gaa8946217a0b

