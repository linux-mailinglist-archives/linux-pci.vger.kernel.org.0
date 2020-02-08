Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1A631561B4
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2020 01:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgBHAAf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Feb 2020 19:00:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:58200 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbgBHAAX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Feb 2020 19:00:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 16:00:22 -0800
X-IronPort-AV: E=Sophos;i="5.70,415,1574150400"; 
   d="scan'208";a="225545810"
Received: from nsgsw-rhel7p6.lm.intel.com ([10.232.116.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 16:00:21 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Pawel Baldysiak <pawel.baldysiak@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [RFC 7/9] PCI: Move pci_dev_str_match to search.c
Date:   Fri,  7 Feb 2020 17:00:05 -0700
Message-Id: <1581120007-5280-8-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
References: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The method which extracts a string descriptor of one or more PCI devices
and matches to a struct pci_dev is useful in general to other subsystems
needing to match parameters or sysfs strings. Move this function to
search.c for general use.

No functional changes.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/pci.c    | 163 ---------------------------------------------------
 drivers/pci/search.c | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |   2 +
 3 files changed, 164 insertions(+), 163 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3c30e72..dac1b08 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -203,169 +203,6 @@ void __iomem *pci_ioremap_wc_bar(struct pci_dev *pdev, int bar)
 EXPORT_SYMBOL_GPL(pci_ioremap_wc_bar);
 #endif
 
-/**
- * pci_dev_str_match_path - test if a path string matches a device
- * @dev: the PCI device to test
- * @path: string to match the device against
- * @endptr: pointer to the string after the match
- *
- * Test if a string (typically from a kernel parameter) formatted as a
- * path of device/function addresses matches a PCI device. The string must
- * be of the form:
- *
- *   [<domain>:]<bus>:<device>.<func>[/<device>.<func>]*
- *
- * A path for a device can be obtained using 'lspci -t'.  Using a path
- * is more robust against bus renumbering than using only a single bus,
- * device and function address.
- *
- * Returns 1 if the string matches the device, 0 if it does not and
- * a negative error code if it fails to parse the string.
- */
-static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
-				  const char **endptr)
-{
-	int ret;
-	int seg, bus, slot, func;
-	char *wpath, *p;
-	char end;
-
-	*endptr = strchrnul(path, ';');
-
-	wpath = kmemdup_nul(path, *endptr - path, GFP_KERNEL);
-	if (!wpath)
-		return -ENOMEM;
-
-	while (1) {
-		p = strrchr(wpath, '/');
-		if (!p)
-			break;
-		ret = sscanf(p, "/%x.%x%c", &slot, &func, &end);
-		if (ret != 2) {
-			ret = -EINVAL;
-			goto free_and_exit;
-		}
-
-		if (dev->devfn != PCI_DEVFN(slot, func)) {
-			ret = 0;
-			goto free_and_exit;
-		}
-
-		/*
-		 * Note: we don't need to get a reference to the upstream
-		 * bridge because we hold a reference to the top level
-		 * device which should hold a reference to the bridge,
-		 * and so on.
-		 */
-		dev = pci_upstream_bridge(dev);
-		if (!dev) {
-			ret = 0;
-			goto free_and_exit;
-		}
-
-		*p = 0;
-	}
-
-	ret = sscanf(wpath, "%x:%x:%x.%x%c", &seg, &bus, &slot,
-		     &func, &end);
-	if (ret != 4) {
-		seg = 0;
-		ret = sscanf(wpath, "%x:%x.%x%c", &bus, &slot, &func, &end);
-		if (ret != 3) {
-			ret = -EINVAL;
-			goto free_and_exit;
-		}
-	}
-
-	ret = (seg == pci_domain_nr(dev->bus) &&
-	       bus == dev->bus->number &&
-	       dev->devfn == PCI_DEVFN(slot, func));
-
-free_and_exit:
-	kfree(wpath);
-	return ret;
-}
-
-/**
- * pci_dev_str_match - test if a string matches a device
- * @dev: the PCI device to test
- * @p: string to match the device against
- * @endptr: pointer to the string after the match
- *
- * Test if a string (typically from a kernel parameter) matches a specified
- * PCI device. The string may be of one of the following formats:
- *
- *   [<domain>:]<bus>:<device>.<func>[/<device>.<func>]*
- *   pci:<vendor>:<device>[:<subvendor>:<subdevice>]
- *
- * The first format specifies a PCI bus/device/function address which
- * may change if new hardware is inserted, if motherboard firmware changes,
- * or due to changes caused in kernel parameters. If the domain is
- * left unspecified, it is taken to be 0.  In order to be robust against
- * bus renumbering issues, a path of PCI device/function numbers may be used
- * to address the specific device.  The path for a device can be determined
- * through the use of 'lspci -t'.
- *
- * The second format matches devices using IDs in the configuration
- * space which may match multiple devices in the system. A value of 0
- * for any field will match all devices. (Note: this differs from
- * in-kernel code that uses PCI_ANY_ID which is ~0; this is for
- * legacy reasons and convenience so users don't have to specify
- * FFFFFFFFs on the command line.)
- *
- * Returns 1 if the string matches the device, 0 if it does not and
- * a negative error code if the string cannot be parsed.
- */
-static int pci_dev_str_match(struct pci_dev *dev, const char *p,
-			     const char **endptr)
-{
-	int ret;
-	int count;
-	unsigned short vendor, device, subsystem_vendor, subsystem_device;
-
-	if (strncmp(p, "pci:", 4) == 0) {
-		/* PCI vendor/device (subvendor/subdevice) IDs are specified */
-		p += 4;
-		ret = sscanf(p, "%hx:%hx:%hx:%hx%n", &vendor, &device,
-			     &subsystem_vendor, &subsystem_device, &count);
-		if (ret != 4) {
-			ret = sscanf(p, "%hx:%hx%n", &vendor, &device, &count);
-			if (ret != 2)
-				return -EINVAL;
-
-			subsystem_vendor = 0;
-			subsystem_device = 0;
-		}
-
-		p += count;
-
-		if ((!vendor || vendor == dev->vendor) &&
-		    (!device || device == dev->device) &&
-		    (!subsystem_vendor ||
-			    subsystem_vendor == dev->subsystem_vendor) &&
-		    (!subsystem_device ||
-			    subsystem_device == dev->subsystem_device))
-			goto found;
-	} else {
-		/*
-		 * PCI Bus, Device, Function IDs are specified
-		 * (optionally, may include a path of devfns following it)
-		 */
-		ret = pci_dev_str_match_path(dev, p, &p);
-		if (ret < 0)
-			return ret;
-		else if (ret)
-			goto found;
-	}
-
-	*endptr = p;
-	return 0;
-
-found:
-	*endptr = p;
-	return 1;
-}
-
 static int __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
 				   u8 pos, int cap, int *ttl)
 {
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 2061672..6821b70 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -394,3 +394,165 @@ int pci_dev_present(const struct pci_device_id *ids)
 	return 0;
 }
 EXPORT_SYMBOL(pci_dev_present);
+
+/**
+ * pci_dev_str_match_path - test if a path string matches a device
+ * @dev: the PCI device to test
+ * @path: string to match the device against
+ * @endptr: pointer to the string after the match
+ *
+ * Test if a string (typically from a kernel parameter) formatted as a
+ * path of device/function addresses matches a PCI device. The string must
+ * be of the form:
+ *
+ *   [<domain>:]<bus>:<device>.<func>[/<device>.<func>]*
+ *
+ * A path for a device can be obtained using 'lspci -t'.  Using a path
+ * is more robust against bus renumbering than using only a single bus,
+ * device and function address.
+ *
+ * Returns 1 if the string matches the device, 0 if it does not and
+ * a negative error code if it fails to parse the string.
+ */
+static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
+				  const char **endptr)
+{
+	int ret;
+	int seg, bus, slot, func;
+	char *wpath, *p;
+	char end;
+
+	*endptr = strchrnul(path, ';');
+
+	wpath = kmemdup_nul(path, *endptr - path, GFP_KERNEL);
+	if (!wpath)
+		return -ENOMEM;
+
+	while (1) {
+		p = strrchr(wpath, '/');
+		if (!p)
+			break;
+		ret = sscanf(p, "/%x.%x%c", &slot, &func, &end);
+		if (ret != 2) {
+			ret = -EINVAL;
+			goto free_and_exit;
+		}
+
+		if (dev->devfn != PCI_DEVFN(slot, func)) {
+			ret = 0;
+			goto free_and_exit;
+		}
+
+		/*
+		 * Note: we don't need to get a reference to the upstream
+		 * bridge because we hold a reference to the top level
+		 * device which should hold a reference to the bridge,
+		 * and so on.
+		 */
+		dev = pci_upstream_bridge(dev);
+		if (!dev) {
+			ret = 0;
+			goto free_and_exit;
+		}
+
+		*p = 0;
+	}
+
+	ret = sscanf(wpath, "%x:%x:%x.%x%c", &seg, &bus, &slot,
+		     &func, &end);
+	if (ret != 4) {
+		seg = 0;
+		ret = sscanf(wpath, "%x:%x.%x%c", &bus, &slot, &func, &end);
+		if (ret != 3) {
+			ret = -EINVAL;
+			goto free_and_exit;
+		}
+	}
+
+	ret = (seg == pci_domain_nr(dev->bus) &&
+	       bus == dev->bus->number &&
+	       dev->devfn == PCI_DEVFN(slot, func));
+
+free_and_exit:
+	kfree(wpath);
+	return ret;
+}
+
+/**
+ * pci_dev_str_match - test if a string matches a device
+ * @dev: the PCI device to test
+ * @p: string to match the device against
+ * @endptr: pointer to the string after the match
+ *
+ * Test if a string (typically from a kernel parameter) matches a specified
+ * PCI device. The string may be of one of the following formats:
+ *
+ *   [<domain>:]<bus>:<device>.<func>[/<device>.<func>]*
+ *   pci:<vendor>:<device>[:<subvendor>:<subdevice>]
+ *
+ * The first format specifies a PCI bus/device/function address which
+ * may change if new hardware is inserted, if motherboard firmware changes,
+ * or due to changes caused in kernel parameters. If the domain is
+ * left unspecified, it is taken to be 0.  In order to be robust against
+ * bus renumbering issues, a path of PCI device/function numbers may be used
+ * to address the specific device.  The path for a device can be determined
+ * through the use of 'lspci -t'.
+ *
+ * The second format matches devices using IDs in the configuration
+ * space which may match multiple devices in the system. A value of 0
+ * for any field will match all devices. (Note: this differs from
+ * in-kernel code that uses PCI_ANY_ID which is ~0; this is for
+ * legacy reasons and convenience so users don't have to specify
+ * FFFFFFFFs on the command line.)
+ *
+ * Returns 1 if the string matches the device, 0 if it does not and
+ * a negative error code if the string cannot be parsed.
+ */
+int pci_dev_str_match(struct pci_dev *dev, const char *p, const char **endptr)
+{
+	int ret;
+	int count;
+	unsigned short vendor, device, subsystem_vendor, subsystem_device;
+
+	if (strncmp(p, "pci:", 4) == 0) {
+		/* PCI vendor/device (subvendor/subdevice) IDs are specified */
+		p += 4;
+		ret = sscanf(p, "%hx:%hx:%hx:%hx%n", &vendor, &device,
+			     &subsystem_vendor, &subsystem_device, &count);
+		if (ret != 4) {
+			ret = sscanf(p, "%hx:%hx%n", &vendor, &device, &count);
+			if (ret != 2)
+				return -EINVAL;
+
+			subsystem_vendor = 0;
+			subsystem_device = 0;
+		}
+
+		p += count;
+
+		if ((!vendor || vendor == dev->vendor) &&
+		    (!device || device == dev->device) &&
+		    (!subsystem_vendor ||
+			    subsystem_vendor == dev->subsystem_vendor) &&
+		    (!subsystem_device ||
+			    subsystem_device == dev->subsystem_device))
+			goto found;
+	} else {
+		/*
+		 * PCI Bus, Device, Function IDs are specified
+		 * (optionally, may include a path of devfns following it)
+		 */
+		ret = pci_dev_str_match_path(dev, p, &p);
+		if (ret < 0)
+			return ret;
+		else if (ret)
+			goto found;
+	}
+
+	*endptr = p;
+	return 0;
+
+found:
+	*endptr = p;
+	return 1;
+}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0391e39..c5c9bb5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1056,6 +1056,8 @@ struct pci_dev *pci_get_domain_bus_and_slot(int domain, unsigned int bus,
 struct pci_dev *pci_get_class(unsigned int class, struct pci_dev *from);
 int pci_dev_present(const struct pci_device_id *ids);
 
+int pci_dev_str_match(struct pci_dev *dev, const char *p, const char **endptr);
+
 int pci_bus_read_config_byte(struct pci_bus *bus, unsigned int devfn,
 			     int where, u8 *val);
 int pci_bus_read_config_word(struct pci_bus *bus, unsigned int devfn,
-- 
1.8.3.1

