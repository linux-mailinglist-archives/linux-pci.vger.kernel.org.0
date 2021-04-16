Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0783629D6
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244639AbhDPU7e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:59:34 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:34747 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343707AbhDPU7e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 16:59:34 -0400
Received: by mail-ed1-f41.google.com with SMTP id i3so8148397edt.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 13:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=chnXS5vlnNEAjx2DkDD/rfaMsl7xw9YzjK1dkczZPx8=;
        b=kH3Os25UUhdx11QsfHNxfOng7MmsXfFHE4OL8NrlaAxkRGctT5LfpiyZ2UogxWr5xR
         m1KPEdjMcmH2+QOlpUwN/R2yKeM3PnkvYgxHGKOM5suJfjASyR8bdDmWsSXENX+gK6zI
         aUN0s590gPEDBqzd6+GZ86TA5tKKjYp4B3Jzr2UO/BvvXHDFCoJHt5I1xkkKVjdG+gGp
         9iEtlMmzEHMgnpPHjnJajobfELRWWAraMuuQLsl5h2OvFRJQIMT3UNraD8IYdxNZsBpD
         aZyD4DZpEskWpG+6XHkmHHALQrhjVrex5EDhE8kUmS/NbcQsY1MKKyKmb/1koP4N6ZxD
         L/Ig==
X-Gm-Message-State: AOAM530iGN82cqT6XURr5A8t5/tLZZF7+i9DRSXeFo8ckC/zS0TdQmkI
        1YmrVswMZ3U1IqDGD7+uLF4=
X-Google-Smtp-Source: ABdhPJztiek1E12EuWfxeukL0dkQLP4boqPMtzKwltOjoIOU/t04ZB81cjksT3H1cgiDK34q4DQKug==
X-Received: by 2002:a05:6402:40ca:: with SMTP id z10mr11995612edb.215.1618606747791;
        Fri, 16 Apr 2021 13:59:07 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm5103864ejg.43.2021.04.16.13.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:59:07 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joe Perches <joe@perches.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        David Sterba <dsterba@suse.com>, linux-pci@vger.kernel.org
Subject: [PATCH 10/20] PCI: Update style to be more consistent
Date:   Fri, 16 Apr 2021 20:58:46 +0000
Message-Id: <20210416205856.3234481-11-kw@linux.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210416205856.3234481-1-kw@linux.com>
References: <20210416205856.3234481-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The number of sysfs object added to the PCI device grew over time, and
with each addition, the style of the code in the pci-sysfc.c file also
changed.

Thus, update to coding style in the file, so that it's consistent:

  - Update variable naming
  - Sort variables in the order of use
  - Update functions signatures to be more aligned
  - Correct white spaces and indentation
  - Remove ternary operator in favour of the if-else style
  - Update brackets and if-statements to better match kernel code style

Also, rename the .is_visible and .bin_is_visible callbacks functions so
that these end with the "_is_visible" suffix, rather than "_are_visible"
to be consistent with rest of the code in the kernel.

No functional change intended.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 470 +++++++++++++++++++++-------------------
 1 file changed, 251 insertions(+), 219 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index c47c30cf063e..96302b63f6c5 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -12,7 +12,6 @@
  * Modeled after usb's driverfs.c
  */
 
-
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/pci.h>
@@ -36,9 +35,8 @@ static int sysfs_initialized;	/* = 0 */
 static ssize_t								\
 field##_show(struct device *dev, struct device_attribute *attr, char *buf)				\
 {									\
-	struct pci_dev *pdev;						\
+	struct pci_dev *pdev = to_pci_dev(dev);				\
 									\
-	pdev = to_pci_dev(dev);						\
 	return sysfs_emit(buf, format_string, pdev->field);		\
 }									\
 static DEVICE_ATTR_RO(field)
@@ -56,6 +54,7 @@ static ssize_t broken_parity_status_show(struct device *dev,
 					 char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+
 	return sysfs_emit(buf, "%u\n", pdev->broken_parity_status);
 }
 
@@ -63,8 +62,8 @@ static ssize_t broken_parity_status_store(struct device *dev,
 					  struct device_attribute *attr,
 					  const char *buf, size_t count)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
 	bool broken;
+	struct pci_dev *pdev = to_pci_dev(dev);
 
 	if (kstrtobool(buf, &broken) < 0)
 		return -EINVAL;
@@ -79,12 +78,17 @@ static ssize_t pci_dev_show_local_cpu(struct device *dev, bool list,
 				      struct device_attribute *attr, char *buf)
 {
 	const struct cpumask *mask;
-
 #ifdef CONFIG_NUMA
-	mask = (dev_to_node(dev) == -1) ? cpu_online_mask :
-					  cpumask_of_node(dev_to_node(dev));
+	int node = dev_to_node(dev);
+
+	if (node == NUMA_NO_NODE)
+		mask = cpu_online_mask;
+	else
+		mask = cpumask_of_node(node);
 #else
-	mask = cpumask_of_pcibus(to_pci_dev(dev)->bus);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	mask = cpumask_of_pcibus(pdev->bus);
 #endif
 	return cpumap_print_to_pagebuf(list, buf, mask);
 }
@@ -109,7 +113,8 @@ static DEVICE_ATTR_RO(local_cpulist);
 static ssize_t cpuaffinity_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	const struct cpumask *cpumask = cpumask_of_pcibus(to_pci_bus(dev));
+	struct pci_bus *bus = to_pci_bus(dev);
+	const struct cpumask *cpumask = cpumask_of_pcibus(bus);
 
 	return cpumap_print_to_pagebuf(false, buf, cpumask);
 }
@@ -118,7 +123,8 @@ static DEVICE_ATTR_RO(cpuaffinity);
 static ssize_t cpulistaffinity_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
-	const struct cpumask *cpumask = cpumask_of_pcibus(to_pci_bus(dev));
+	struct pci_bus *bus = to_pci_bus(dev);
+	const struct cpumask *cpumask = cpumask_of_pcibus(bus);
 
 	return cpumap_print_to_pagebuf(true, buf, cpumask);
 }
@@ -134,28 +140,28 @@ static ssize_t power_state_show(struct device *dev,
 static DEVICE_ATTR_RO(power_state);
 
 /* show resources */
-static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
-			     char *buf)
+static ssize_t resource_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-	int i;
-	int max;
+	int i, max;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct resource *res;
 	resource_size_t start, end;
 	size_t len = 0;
 
-	if (pci_dev->subordinate)
+	max = PCI_BRIDGE_RESOURCES;
+	if (pdev->subordinate)
 		max = DEVICE_COUNT_RESOURCE;
-	else
-		max = PCI_BRIDGE_RESOURCES;
 
 	for (i = 0; i < max; i++) {
-		struct resource *res =  &pci_dev->resource[i];
-		pci_resource_to_user(pci_dev, i, res, &start, &end);
+		res = &pdev->resource[i];
+		pci_resource_to_user(pdev, i, res, &start, &end);
 		len += sysfs_emit_at(buf, len, "0x%016llx 0x%016llx 0x%016llx\n",
 				     (unsigned long long)start,
 				     (unsigned long long)end,
 				     (unsigned long long)res->flags);
 	}
+
 	return len;
 }
 static DEVICE_ATTR_RO(resource);
@@ -182,10 +188,10 @@ static DEVICE_ATTR_RO(max_link_width);
 static ssize_t current_link_speed_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
-	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
 	enum pci_bus_speed speed;
 
-	pcie_bandwidth_available(pci_dev, NULL, &speed, NULL);
+	pcie_bandwidth_available(pdev, NULL, &speed, NULL);
 
 	return sysfs_emit(buf, "%s\n", pci_speed_string(speed));
 }
@@ -194,10 +200,10 @@ static DEVICE_ATTR_RO(current_link_speed);
 static ssize_t current_link_width_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
-	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
 	enum pcie_link_width width;
 
-	pcie_bandwidth_available(pci_dev, NULL, NULL, &width);
+	pcie_bandwidth_available(pdev, NULL, NULL, &width);
 
 	return sysfs_emit(buf, "%u\n", width);
 }
@@ -207,11 +213,11 @@ static ssize_t secondary_bus_number_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
 	u8 sec_bus;
 	int err;
 
-	err = pci_read_config_byte(pci_dev, PCI_SECONDARY_BUS, &sec_bus);
+	err = pci_read_config_byte(pdev, PCI_SECONDARY_BUS, &sec_bus);
 	if (err)
 		return -EINVAL;
 
@@ -223,11 +229,11 @@ static ssize_t subordinate_bus_number_show(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
 {
-	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
 	u8 sub_bus;
 	int err;
 
-	err = pci_read_config_byte(pci_dev, PCI_SUBORDINATE_BUS, &sub_bus);
+	err = pci_read_config_byte(pdev, PCI_SUBORDINATE_BUS, &sub_bus);
 	if (err)
 		return -EINVAL;
 
@@ -236,34 +242,34 @@ static ssize_t subordinate_bus_number_show(struct device *dev,
 static DEVICE_ATTR_RO(subordinate_bus_number);
 
 static ssize_t ari_enabled_show(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
+				struct device_attribute *attr, char *buf)
 {
-	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sysfs_emit(buf, "%u\n", pci_ari_enabled(pci_dev->bus));
+	return sysfs_emit(buf, "%u\n", pci_ari_enabled(pdev->bus));
 }
 static DEVICE_ATTR_RO(ari_enabled);
 
-static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
-			     char *buf)
+static ssize_t modalias_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
-	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
 
 	return sysfs_emit(buf, "pci:v%08Xd%08Xsv%08Xsd%08Xbc%02Xsc%02Xi%02X\n",
-			  pci_dev->vendor, pci_dev->device,
-			  pci_dev->subsystem_vendor, pci_dev->subsystem_device,
-			  (u8)(pci_dev->class >> 16), (u8)(pci_dev->class >> 8),
-			  (u8)(pci_dev->class));
+			  pdev->vendor, pdev->device,
+			  pdev->subsystem_vendor, pdev->subsystem_device,
+			  (u8)(pdev->class >> 16), (u8)(pdev->class >> 8),
+			  (u8)(pdev->class));
 }
 static DEVICE_ATTR_RO(modalias);
 
-static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
-			     const char *buf, size_t count)
+static ssize_t enable_store(struct device *dev,
+			    struct device_attribute *attr, const char *buf,
+			    size_t count)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
 	bool enable;
-	ssize_t result = 0;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	ssize_t ret = 0;
 
 	/* this can crash the machine when done on the "wrong" device */
 	if (!capable(CAP_SYS_ADMIN))
@@ -274,24 +280,26 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
 
 	device_lock(dev);
 	if (dev->driver)
-		result = -EBUSY;
+		ret = -EBUSY;
 	else if (enable)
-		result = pci_enable_device(pdev);
+		ret = pci_enable_device(pdev);
 	else if (pci_is_enabled(pdev))
 		pci_disable_device(pdev);
 	else
-		result = -EIO;
+		ret = -EIO;
 	device_unlock(dev);
 
-	return result < 0 ? result : count;
+	if (ret < 0)
+		return ret;
+
+	return count;
 }
 
-static ssize_t enable_show(struct device *dev, struct device_attribute *attr,
-			    char *buf)
+static ssize_t enable_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
 {
-	struct pci_dev *pdev;
+	struct pci_dev *pdev = to_pci_dev(dev);
 
-	pdev = to_pci_dev(dev);
 	return sysfs_emit(buf, "%u\n", atomic_read(&pdev->enable_cnt));
 }
 static DEVICE_ATTR_RW(enable);
@@ -301,8 +309,8 @@ static ssize_t numa_node_store(struct device *dev,
 			       struct device_attribute *attr, const char *buf,
 			       size_t count)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
 	int node;
+	struct pci_dev *pdev = to_pci_dev(dev);
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -321,11 +329,12 @@ static ssize_t numa_node_store(struct device *dev,
 		  node);
 
 	dev->numa_node = node;
+
 	return count;
 }
 
-static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
-			      char *buf)
+static ssize_t numa_node_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	return sysfs_emit(buf, "%d\n", dev->numa_node);
 }
@@ -349,8 +358,8 @@ static ssize_t consistent_dma_mask_bits_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(consistent_dma_mask_bits);
 
-static ssize_t msi_bus_show(struct device *dev, struct device_attribute *attr,
-			    char *buf)
+static ssize_t msi_bus_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pci_bus *subordinate = pdev->subordinate;
@@ -360,12 +369,13 @@ static ssize_t msi_bus_show(struct device *dev, struct device_attribute *attr,
 			    : !pdev->no_msi);
 }
 
-static ssize_t msi_bus_store(struct device *dev, struct device_attribute *attr,
-			     const char *buf, size_t count)
+static ssize_t msi_bus_store(struct device *dev,
+			     struct device_attribute *attr, const char *buf,
+			     size_t count)
 {
+	bool allowed;
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pci_bus *subordinate = pdev->subordinate;
-	bool allowed;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -392,6 +402,7 @@ static ssize_t msi_bus_store(struct device *dev, struct device_attribute *attr,
 
 	dev_info(&subordinate->dev, "MSI/MSI-X %s for future drivers of devices on this bus\n",
 		 allowed ? "allowed" : "disallowed");
+
 	return count;
 }
 static DEVICE_ATTR_RW(msi_bus);
@@ -410,6 +421,7 @@ static ssize_t rescan_store(struct bus_type *bus, const char *buf, size_t count)
 			pci_rescan_bus(b);
 		pci_unlock_rescan_remove();
 	}
+
 	return count;
 }
 static BUS_ATTR_WO(rescan);
@@ -443,29 +455,32 @@ static ssize_t dev_rescan_store(struct device *dev,
 		pci_rescan_bus(pdev->bus);
 		pci_unlock_rescan_remove();
 	}
+
 	return count;
 }
 static struct device_attribute dev_attr_dev_rescan = __ATTR(rescan, 0200, NULL,
 							    dev_rescan_store);
 
-static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t count)
+static ssize_t remove_store(struct device *dev,
+			    struct device_attribute *attr, const char *buf,
+			    size_t count)
 {
 	bool remove;
+	struct pci_dev *pdev = to_pci_dev(dev);
 
 	if (kstrtobool(buf, &remove) < 0)
 		return -EINVAL;
 
 	if (remove && device_remove_file_self(dev, attr))
-		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
+		pci_stop_and_remove_bus_device_locked(pdev);
+
 	return count;
 }
-static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL,
-				  remove_store);
+static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL, remove_store);
 
 static ssize_t bus_rescan_store(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf, size_t count)
+				struct device_attribute *attr, const char *buf,
+				size_t count)
 {
 	bool rescan;
 	struct pci_bus *bus = to_pci_bus(dev);
@@ -481,6 +496,7 @@ static ssize_t bus_rescan_store(struct device *dev,
 			pci_rescan_bus(bus);
 		pci_unlock_rescan_remove();
 	}
+
 	return count;
 }
 static struct device_attribute dev_attr_bus_rescan = __ATTR(rescan, 0200, NULL,
@@ -491,8 +507,8 @@ static ssize_t d3cold_allowed_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
 	bool allowed;
+	struct pci_dev *pdev = to_pci_dev(dev);
 
 	if (kstrtobool(buf, &allowed) < 0)
 		return -EINVAL;
@@ -512,6 +528,7 @@ static ssize_t d3cold_allowed_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+
 	return sysfs_emit(buf, "%u\n", pdev->d3cold_allowed);
 }
 static DEVICE_ATTR_RW(d3cold_allowed);
@@ -524,8 +541,9 @@ static ssize_t devspec_show(struct device *dev,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct device_node *np = pci_device_to_OF_node(pdev);
 
-	if (np == NULL)
+	if (!np)
 		return 0;
+
 	return sysfs_emit(buf, "%pOF", np);
 }
 static DEVICE_ATTR_RO(devspec);
@@ -535,8 +553,8 @@ static ssize_t driver_override_store(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf, size_t count)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
 	char *driver_override, *old, *cp;
+	struct pci_dev *pdev = to_pci_dev(dev);
 
 	/* We need to keep extra room for a newline */
 	if (count >= (PAGE_SIZE - 1))
@@ -574,6 +592,7 @@ static ssize_t driver_override_show(struct device *dev,
 	device_lock(dev);
 	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
 	device_unlock(dev);
+
 	return len;
 }
 static DEVICE_ATTR_RW(driver_override);
@@ -640,8 +659,8 @@ const struct attribute_group *pcibus_groups[] = {
 	NULL,
 };
 
-static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
-			     char *buf)
+static ssize_t boot_vga_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pci_dev *vga_dev = vga_default_device();
@@ -659,19 +678,20 @@ static ssize_t config_read(struct file *filp, struct kobject *kobj,
 			   struct bin_attribute *bin_attr, char *buf,
 			   loff_t off, size_t count)
 {
-	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 	unsigned int size = 64;
 	loff_t init_off = off;
-	u8 *data = (u8 *) buf;
+	u8 *data = (u8 *)buf;
 
 	/* Several chips lock up trying to read undefined config space */
 	if (file_ns_capable(filp, &init_user_ns, CAP_SYS_ADMIN))
-		size = dev->cfg_size;
-	else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
+		size = pdev->cfg_size;
+	else if (pdev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
 		size = 128;
 
 	if (off > size)
 		return 0;
+
 	if (off + count > size) {
 		size -= off;
 		count = size;
@@ -679,11 +699,11 @@ static ssize_t config_read(struct file *filp, struct kobject *kobj,
 		size = count;
 	}
 
-	pci_config_pm_runtime_get(dev);
+	pci_config_pm_runtime_get(pdev);
 
 	if ((off & 1) && size) {
 		u8 val;
-		pci_user_read_config_byte(dev, off, &val);
+		pci_user_read_config_byte(pdev, off, &val);
 		data[off - init_off] = val;
 		off++;
 		size--;
@@ -691,7 +711,7 @@ static ssize_t config_read(struct file *filp, struct kobject *kobj,
 
 	if ((off & 3) && size > 2) {
 		u16 val;
-		pci_user_read_config_word(dev, off, &val);
+		pci_user_read_config_word(pdev, off, &val);
 		data[off - init_off] = val & 0xff;
 		data[off - init_off + 1] = (val >> 8) & 0xff;
 		off += 2;
@@ -700,7 +720,7 @@ static ssize_t config_read(struct file *filp, struct kobject *kobj,
 
 	while (size > 3) {
 		u32 val;
-		pci_user_read_config_dword(dev, off, &val);
+		pci_user_read_config_dword(pdev, off, &val);
 		data[off - init_off] = val & 0xff;
 		data[off - init_off + 1] = (val >> 8) & 0xff;
 		data[off - init_off + 2] = (val >> 16) & 0xff;
@@ -712,7 +732,7 @@ static ssize_t config_read(struct file *filp, struct kobject *kobj,
 
 	if (size >= 2) {
 		u16 val;
-		pci_user_read_config_word(dev, off, &val);
+		pci_user_read_config_word(pdev, off, &val);
 		data[off - init_off] = val & 0xff;
 		data[off - init_off + 1] = (val >> 8) & 0xff;
 		off += 2;
@@ -721,13 +741,13 @@ static ssize_t config_read(struct file *filp, struct kobject *kobj,
 
 	if (size > 0) {
 		u8 val;
-		pci_user_read_config_byte(dev, off, &val);
+		pci_user_read_config_byte(pdev, off, &val);
 		data[off - init_off] = val;
 		off++;
 		--size;
 	}
 
-	pci_config_pm_runtime_put(dev);
+	pci_config_pm_runtime_put(pdev);
 
 	return count;
 }
@@ -736,27 +756,28 @@ static ssize_t config_write(struct file *filp, struct kobject *kobj,
 			    struct bin_attribute *bin_attr, char *buf,
 			    loff_t off, size_t count)
 {
-	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 	unsigned int size = count;
 	loff_t init_off = off;
-	u8 *data = (u8 *) buf;
-	int ret;
+	u8 *data = (u8 *)buf;
+	size_t ret;
 
 	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
 	if (ret)
 		return ret;
 
-	if (off > dev->cfg_size)
+	if (off > pdev->cfg_size)
 		return 0;
-	if (off + count > dev->cfg_size) {
-		size = dev->cfg_size - off;
+
+	if (off + count > pdev->cfg_size) {
+		size = pdev->cfg_size - off;
 		count = size;
 	}
 
-	pci_config_pm_runtime_get(dev);
+	pci_config_pm_runtime_get(pdev);
 
 	if ((off & 1) && size) {
-		pci_user_write_config_byte(dev, off, data[off - init_off]);
+		pci_user_write_config_byte(pdev, off, data[off - init_off]);
 		off++;
 		size--;
 	}
@@ -764,7 +785,7 @@ static ssize_t config_write(struct file *filp, struct kobject *kobj,
 	if ((off & 3) && size > 2) {
 		u16 val = data[off - init_off];
 		val |= (u16) data[off - init_off + 1] << 8;
-		pci_user_write_config_word(dev, off, val);
+		pci_user_write_config_word(pdev, off, val);
 		off += 2;
 		size -= 2;
 	}
@@ -774,7 +795,7 @@ static ssize_t config_write(struct file *filp, struct kobject *kobj,
 		val |= (u32) data[off - init_off + 1] << 8;
 		val |= (u32) data[off - init_off + 2] << 16;
 		val |= (u32) data[off - init_off + 3] << 24;
-		pci_user_write_config_dword(dev, off, val);
+		pci_user_write_config_dword(pdev, off, val);
 		off += 4;
 		size -= 4;
 	}
@@ -782,18 +803,18 @@ static ssize_t config_write(struct file *filp, struct kobject *kobj,
 	if (size >= 2) {
 		u16 val = data[off - init_off];
 		val |= (u16) data[off - init_off + 1] << 8;
-		pci_user_write_config_word(dev, off, val);
+		pci_user_write_config_word(pdev, off, val);
 		off += 2;
 		size -= 2;
 	}
 
 	if (size) {
-		pci_user_write_config_byte(dev, off, data[off - init_off]);
+		pci_user_write_config_byte(pdev, off, data[off - init_off]);
 		off++;
 		--size;
 	}
 
-	pci_config_pm_runtime_put(dev);
+	pci_config_pm_runtime_put(pdev);
 
 	return count;
 }
@@ -876,7 +897,7 @@ static ssize_t pci_write_legacy_io(struct file *filp, struct kobject *kobj,
  * pci_mmap_legacy_mem - map legacy PCI memory into user memory space
  * @filp: open sysfs file
  * @kobj: kobject corresponding to device to be mapped
- * @attr: struct bin_attribute for this file
+ * @bin_attr: struct bin_attribute for this file
  * @vma: struct vm_area_struct passed to mmap
  *
  * Uses an arch specific callback, pci_mmap_legacy_mem_page_range, to mmap
@@ -884,7 +905,7 @@ static ssize_t pci_write_legacy_io(struct file *filp, struct kobject *kobj,
  * memory space.
  */
 static int pci_mmap_legacy_mem(struct file *filp, struct kobject *kobj,
-			       struct bin_attribute *attr,
+			       struct bin_attribute *bin_attr,
 			       struct vm_area_struct *vma)
 {
 	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
@@ -896,7 +917,7 @@ static int pci_mmap_legacy_mem(struct file *filp, struct kobject *kobj,
  * pci_mmap_legacy_io - map legacy PCI IO into user memory space
  * @filp: open sysfs file
  * @kobj: kobject corresponding to device to be mapped
- * @attr: struct bin_attribute for this file
+ * @bin_attr: struct bin_attribute for this file
  * @vma: struct vm_area_struct passed to mmap
  *
  * Uses an arch specific callback, pci_mmap_legacy_io_page_range, to mmap
@@ -904,7 +925,7 @@ static int pci_mmap_legacy_mem(struct file *filp, struct kobject *kobj,
  * memory space. Returns -ENOSYS if the operation isn't supported
  */
 static int pci_mmap_legacy_io(struct file *filp, struct kobject *kobj,
-			      struct bin_attribute *attr,
+			      struct bin_attribute *bin_attr,
 			      struct vm_area_struct *vma)
 {
 	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
@@ -914,19 +935,19 @@ static int pci_mmap_legacy_io(struct file *filp, struct kobject *kobj,
 
 /**
  * pci_adjust_legacy_attr - adjustment of legacy file attributes
- * @b: bus to create files under
+ * @bus: bus to create files under
  * @mmap_type: I/O port or memory
  *
  * Stub implementation. Can be overridden by arch if necessary.
  */
-void __weak pci_adjust_legacy_attr(struct pci_bus *b,
+void __weak pci_adjust_legacy_attr(struct pci_bus *bus,
 				   enum pci_mmap_state mmap_type)
 {
 }
 
 /**
  * pci_create_legacy_files - create legacy I/O port and memory files
- * @b: bus to create files under
+ * @bus: bus to create files under
  *
  * Some platforms allow access to legacy I/O port and ISA memory space on
  * a per-bus basis.  This routine creates the files and ties them into
@@ -935,67 +956,71 @@ void __weak pci_adjust_legacy_attr(struct pci_bus *b,
  * On error unwind, but don't propagate the error to the caller
  * as it is ok to set up the PCI bus without these files.
  */
-void pci_create_legacy_files(struct pci_bus *b)
+void pci_create_legacy_files(struct pci_bus *bus)
 {
-	int error;
+	int ret;
 
 	if (!sysfs_initialized)
 		return;
 
-	b->legacy_io = kcalloc(2, sizeof(struct bin_attribute),
-			       GFP_ATOMIC);
-	if (!b->legacy_io)
+	bus->legacy_io = kcalloc(2, sizeof(struct bin_attribute),
+				 GFP_ATOMIC);
+	if (!bus->legacy_io)
 		goto kzalloc_err;
 
-	sysfs_bin_attr_init(b->legacy_io);
-	b->legacy_io->attr.name = "legacy_io";
-	b->legacy_io->size = 0xffff;
-	b->legacy_io->attr.mode = 0600;
-	b->legacy_io->read = pci_read_legacy_io;
-	b->legacy_io->write = pci_write_legacy_io;
-	b->legacy_io->mmap = pci_mmap_legacy_io;
-	b->legacy_io->mapping = iomem_get_mapping();
-	pci_adjust_legacy_attr(b, pci_mmap_io);
-	error = device_create_bin_file(&b->dev, b->legacy_io);
-	if (error)
+	sysfs_bin_attr_init(bus->legacy_io);
+	bus->legacy_io->attr.name = "legacy_io";
+	bus->legacy_io->size = 0xffff;
+	bus->legacy_io->attr.mode = 0600;
+	bus->legacy_io->read = pci_read_legacy_io;
+	bus->legacy_io->write = pci_write_legacy_io;
+	bus->legacy_io->mmap = pci_mmap_legacy_io;
+	bus->legacy_io->mapping = iomem_get_mapping();
+
+	pci_adjust_legacy_attr(bus, pci_mmap_io);
+
+	ret = device_create_bin_file(&bus->dev, bus->legacy_io);
+	if (ret)
 		goto legacy_io_err;
 
 	/* Allocated above after the legacy_io struct */
-	b->legacy_mem = b->legacy_io + 1;
-	sysfs_bin_attr_init(b->legacy_mem);
-	b->legacy_mem->attr.name = "legacy_mem";
-	b->legacy_mem->size = 1024*1024;
-	b->legacy_mem->attr.mode = 0600;
-	b->legacy_mem->mmap = pci_mmap_legacy_mem;
-	b->legacy_io->mapping = iomem_get_mapping();
-	pci_adjust_legacy_attr(b, pci_mmap_mem);
-	error = device_create_bin_file(&b->dev, b->legacy_mem);
-	if (error)
+	bus->legacy_mem = bus->legacy_io + 1;
+
+	sysfs_bin_attr_init(bus->legacy_mem);
+	bus->legacy_mem->attr.name = "legacy_mem";
+	bus->legacy_mem->size = 1024*1024;
+	bus->legacy_mem->attr.mode = 0600;
+	bus->legacy_mem->mmap = pci_mmap_legacy_mem;
+	bus->legacy_io->mapping = iomem_get_mapping();
+
+	pci_adjust_legacy_attr(bus, pci_mmap_mem);
+
+	ret = device_create_bin_file(&bus->dev, bus->legacy_mem);
+	if (ret)
 		goto legacy_mem_err;
 
 	return;
 
 legacy_mem_err:
-	device_remove_bin_file(&b->dev, b->legacy_io);
+	device_remove_bin_file(&bus->dev, bus->legacy_io);
 legacy_io_err:
-	kfree(b->legacy_io);
-	b->legacy_io = NULL;
+	kfree(bus->legacy_io);
+	bus->legacy_io = NULL;
 kzalloc_err:
-	dev_warn(&b->dev, "could not create legacy I/O port and ISA memory resources in sysfs\n");
+	dev_warn(&bus->dev, "could not create legacy I/O port and ISA memory resources in sysfs\n");
 }
 
-void pci_remove_legacy_files(struct pci_bus *b)
+void pci_remove_legacy_files(struct pci_bus *bus)
 {
-	if (b->legacy_io) {
-		device_remove_bin_file(&b->dev, b->legacy_io);
-		device_remove_bin_file(&b->dev, b->legacy_mem);
-		kfree(b->legacy_io); /* both are allocated here */
+	if (bus->legacy_io) {
+		device_remove_bin_file(&bus->dev, bus->legacy_io);
+		device_remove_bin_file(&bus->dev, bus->legacy_mem);
+		kfree(bus->legacy_io); /* both are allocated here */
 	}
 }
 #endif /* HAVE_PCI_LEGACY */
 
 #if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
-
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vma,
 		  enum pci_mmap_api mmap_api)
 {
@@ -1004,36 +1029,41 @@ int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vma,
 
 	if (pci_resource_len(pdev, resno) == 0)
 		return 0;
+
 	nr = vma_pages(vma);
 	start = vma->vm_pgoff;
 	size = ((pci_resource_len(pdev, resno) - 1) >> PAGE_SHIFT) + 1;
+
 	if (mmap_api == PCI_MMAP_PROCFS) {
 		pci_resource_to_user(pdev, resno, &pdev->resource[resno],
 				     &pci_start, &pci_end);
 		pci_start >>= PAGE_SHIFT;
 	}
+
 	if (start >= pci_start && start < pci_start + size &&
 			start + nr <= pci_start + size)
 		return 1;
+
 	return 0;
 }
 
 /**
  * pci_mmap_resource - map a PCI resource into user memory space
  * @kobj: kobject for mapping
- * @attr: struct bin_attribute for the file being mapped
+ * @bin_attr: struct bin_attribute for the file being mapped
  * @vma: struct vm_area_struct passed into the mmap
  * @write_combine: 1 for write_combine mapping
  *
  * Use the regular PCI mapping routines to map a PCI resource into userspace.
  */
-static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
+static int pci_mmap_resource(struct kobject *kobj,
+			     struct bin_attribute *bin_attr,
 			     struct vm_area_struct *vma, int write_combine)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
-	int bar = (unsigned long)attr->private;
-	enum pci_mmap_state mmap_type;
+	int bar = (unsigned long)bin_attr->private;
 	struct resource *res = &pdev->resource[bar];
+	enum pci_mmap_state mmap_type;
 	int ret;
 
 	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
@@ -1046,31 +1076,33 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 	if (!pci_mmap_fits(pdev, bar, vma, PCI_MMAP_SYSFS))
 		return -EINVAL;
 
-	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
+	mmap_type = pci_mmap_io;
+	if (res->flags & IORESOURCE_MEM)
+		mmap_type = pci_mmap_mem;
 
 	return pci_mmap_resource_range(pdev, bar, vma, mmap_type, write_combine);
 }
 
 static int pci_mmap_resource_uc(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *attr,
+				struct bin_attribute *bin_attr,
 				struct vm_area_struct *vma)
 {
-	return pci_mmap_resource(kobj, attr, vma, 0);
+	return pci_mmap_resource(kobj, bin_attr, vma, 0);
 }
 
 static int pci_mmap_resource_wc(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *attr,
+				struct bin_attribute *bin_attr,
 				struct vm_area_struct *vma)
 {
-	return pci_mmap_resource(kobj, attr, vma, 1);
+	return pci_mmap_resource(kobj, bin_attr, vma, 1);
 }
 
 static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
-			       struct bin_attribute *attr, char *buf,
+			       struct bin_attribute *bin_attr, char *buf,
 			       loff_t off, size_t count, bool write)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
-	int bar = (unsigned long)attr->private;
+	int bar = (unsigned long)bin_attr->private;
 	unsigned long port = off;
 
 	port += pci_resource_start(pdev, bar);
@@ -1101,27 +1133,28 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 			*(u32 *)buf = inl(port);
 		return 4;
 	}
+
 	return -EINVAL;
 }
 
 static ssize_t pci_read_resource_io(struct file *filp, struct kobject *kobj,
-				    struct bin_attribute *attr, char *buf,
+				    struct bin_attribute *bin_attr, char *buf,
 				    loff_t off, size_t count)
 {
-	return pci_resource_io(filp, kobj, attr, buf, off, count, false);
+	return pci_resource_io(filp, kobj, bin_attr, buf, off, count, false);
 }
 
 static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
-				     struct bin_attribute *attr, char *buf,
+				     struct bin_attribute *bin_attr, char *buf,
 				     loff_t off, size_t count)
 {
-	int ret;
+	size_t ret;
 
 	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
 	if (ret)
 		return ret;
 
-	return pci_resource_io(filp, kobj, attr, buf, off, count, true);
+	return pci_resource_io(filp, kobj, bin_attr, buf, off, count, true);
 }
 
 /**
@@ -1134,10 +1167,9 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
 static void pci_remove_resource_files(struct pci_dev *pdev)
 {
 	int i;
+	struct bin_attribute *res_attr;
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		struct bin_attribute *res_attr;
-
 		res_attr = pdev->res_attr[i];
 		if (res_attr) {
 			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
@@ -1152,13 +1184,13 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
 	}
 }
 
-static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
+static int pci_create_attr(struct pci_dev *pdev, int resno, int write_combine)
 {
 	/* allocate attribute structure, piggyback attribute name */
 	int name_len = write_combine ? 13 : 10;
 	struct bin_attribute *res_attr;
 	char *res_attr_name;
-	int retval;
+	int ret;
 
 	res_attr = kzalloc(sizeof(*res_attr) + name_len, GFP_ATOMIC);
 	if (!res_attr)
@@ -1168,13 +1200,13 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
 
 	sysfs_bin_attr_init(res_attr);
 	if (write_combine) {
-		pdev->res_attr_wc[num] = res_attr;
-		sprintf(res_attr_name, "resource%d_wc", num);
+		pdev->res_attr_wc[resno] = res_attr;
+		sprintf(res_attr_name, "resource%d_wc", resno);
 		res_attr->mmap = pci_mmap_resource_wc;
 	} else {
-		pdev->res_attr[num] = res_attr;
-		sprintf(res_attr_name, "resource%d", num);
-		if (pci_resource_flags(pdev, num) & IORESOURCE_IO) {
+		pdev->res_attr[resno] = res_attr;
+		sprintf(res_attr_name, "resource%d", resno);
+		if (pci_resource_flags(pdev, resno) & IORESOURCE_IO) {
 			res_attr->read = pci_read_resource_io;
 			res_attr->write = pci_write_resource_io;
 			if (arch_can_pci_mmap_io())
@@ -1183,17 +1215,20 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
 			res_attr->mmap = pci_mmap_resource_uc;
 		}
 	}
+
 	if (res_attr->mmap)
 		res_attr->mapping = iomem_get_mapping();
+
 	res_attr->attr.name = res_attr_name;
 	res_attr->attr.mode = 0600;
-	res_attr->size = pci_resource_len(pdev, num);
-	res_attr->private = (void *)(unsigned long)num;
-	retval = sysfs_create_bin_file(&pdev->dev.kobj, res_attr);
-	if (retval)
+	res_attr->size = pci_resource_len(pdev, resno);
+	res_attr->private = (void *)(unsigned long)resno;
+
+	ret = sysfs_create_bin_file(&pdev->dev.kobj, res_attr);
+	if (ret)
 		kfree(res_attr);
 
-	return retval;
+	return ret;
 }
 
 /**
@@ -1204,31 +1239,31 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
  */
 static int pci_create_resource_files(struct pci_dev *pdev)
 {
-	int i;
-	int retval;
+	int i, ret;
 
 	/* Expose the PCI resources from this device as files */
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-
 		/* skip empty resources */
 		if (!pci_resource_len(pdev, i))
 			continue;
 
-		retval = pci_create_attr(pdev, i, 0);
+		ret = pci_create_attr(pdev, i, 0);
 		/* for prefetchable resources, create a WC mappable file */
-		if (!retval && arch_can_pci_mmap_wc() &&
+		if (!ret && arch_can_pci_mmap_wc() &&
 		    pdev->resource[i].flags & IORESOURCE_PREFETCH)
-			retval = pci_create_attr(pdev, i, 1);
-		if (retval) {
+			ret = pci_create_attr(pdev, i, 1);
+
+		if (ret) {
 			pci_remove_resource_files(pdev);
-			return retval;
+			return ret;
 		}
 	}
+
 	return 0;
 }
 #else /* !(defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)) */
-int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
-void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
+int __weak pci_create_resource_files(struct pci_dev *pdev) { return 0; }
+void __weak pci_remove_resource_files(struct pci_dev *pdev) { return; }
 #endif
 
 /**
@@ -1284,9 +1319,9 @@ static ssize_t rom_read(struct file *filp, struct kobject *kobj,
 	if (!rom || !size)
 		return -EIO;
 
-	if (off >= size)
+	if (off >= size) {
 		count = 0;
-	else {
+	} else {
 		if (off + count > size)
 			count = size - off;
 
@@ -1324,12 +1359,13 @@ static const struct attribute_group pci_dev_rom_attr_group = {
 	.is_bin_visible = pci_dev_rom_attr_is_visible,
 };
 
-static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
-			   const char *buf, size_t count)
+static ssize_t reset_store(struct device *dev,
+			   struct device_attribute *attr, const char *buf,
+			   size_t count)
 {
 	bool reset;
 	struct pci_dev *pdev = to_pci_dev(dev);
-	ssize_t result;
+	ssize_t ret;
 
 	if (kstrtobool(buf, &reset) < 0)
 		return -EINVAL;
@@ -1338,10 +1374,10 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	pm_runtime_get_sync(dev);
-	result = pci_reset_function(pdev);
+	ret = pci_reset_function(pdev);
 	pm_runtime_put(dev);
-	if (result < 0)
-		return result;
+	if (ret < 0)
+		return ret;
 
 	return count;
 }
@@ -1393,20 +1429,20 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 static int __init pci_sysfs_init(void)
 {
 	struct pci_dev *pdev = NULL;
-	struct pci_bus *pbus = NULL;
-	int retval;
+	struct pci_bus *bus = NULL;
+	int ret;
 
 	sysfs_initialized = 1;
 	for_each_pci_dev(pdev) {
-		retval = pci_create_sysfs_dev_files(pdev);
-		if (retval) {
+		ret = pci_create_sysfs_dev_files(pdev);
+		if (ret) {
 			pci_dev_put(pdev);
-			return retval;
+			return ret;
 		}
 	}
 
-	while ((pbus = pci_find_next_bus(pbus)))
-		pci_create_legacy_files(pbus);
+	while ((bus = pci_find_next_bus(bus)))
+		pci_create_legacy_files(bus);
 
 	return 0;
 }
@@ -1417,11 +1453,10 @@ static struct attribute *pci_dev_dev_attrs[] = {
 	NULL,
 };
 
-static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
-					 struct attribute *a, int n)
+static umode_t pci_dev_attr_is_visible(struct kobject *kobj,
+				       struct attribute *a, int n)
 {
-	struct device *dev = kobj_to_dev(kobj);
-	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
 	if (a == &dev_attr_boot_vga.attr)
 		if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
@@ -1436,11 +1471,10 @@ static struct attribute *pci_dev_hp_attrs[] = {
 	NULL,
 };
 
-static umode_t pci_dev_hp_attrs_are_visible(struct kobject *kobj,
-					    struct attribute *a, int n)
+static umode_t pci_dev_hp_attr_is_visible(struct kobject *kobj,
+					  struct attribute *a, int n)
 {
-	struct device *dev = kobj_to_dev(kobj);
-	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
 	if (pdev->is_virtfn)
 		return 0;
@@ -1448,28 +1482,26 @@ static umode_t pci_dev_hp_attrs_are_visible(struct kobject *kobj,
 	return a->mode;
 }
 
-static umode_t pci_bridge_attrs_are_visible(struct kobject *kobj,
-					    struct attribute *a, int n)
+static umode_t pci_bridge_attr_is_visible(struct kobject *kobj,
+					  struct attribute *a, int n)
 {
-	struct device *dev = kobj_to_dev(kobj);
-	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
-	if (pci_is_bridge(pdev))
-		return a->mode;
+	if (!pci_is_bridge(pdev))
+		return 0;
 
-	return 0;
+	return a->mode;
 }
 
-static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
-					  struct attribute *a, int n)
+static umode_t pcie_dev_attr_is_visible(struct kobject *kobj,
+					struct attribute *a, int n)
 {
-	struct device *dev = kobj_to_dev(kobj);
-	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
-	if (pci_is_pcie(pdev))
-		return a->mode;
+	if (!pci_is_pcie(pdev))
+		return 0;
 
-	return 0;
+	return a->mode;
 }
 
 static const struct attribute_group pci_dev_group = {
@@ -1493,22 +1525,22 @@ const struct attribute_group *pci_dev_groups[] = {
 
 static const struct attribute_group pci_dev_hp_attr_group = {
 	.attrs = pci_dev_hp_attrs,
-	.is_visible = pci_dev_hp_attrs_are_visible,
+	.is_visible = pci_dev_hp_attr_is_visible,
 };
 
 static const struct attribute_group pci_dev_attr_group = {
 	.attrs = pci_dev_dev_attrs,
-	.is_visible = pci_dev_attrs_are_visible,
+	.is_visible = pci_dev_attr_is_visible,
 };
 
 static const struct attribute_group pci_bridge_attr_group = {
 	.attrs = pci_bridge_attrs,
-	.is_visible = pci_bridge_attrs_are_visible,
+	.is_visible = pci_bridge_attr_is_visible,
 };
 
 static const struct attribute_group pcie_dev_attr_group = {
 	.attrs = pcie_dev_attrs,
-	.is_visible = pcie_dev_attrs_are_visible,
+	.is_visible = pcie_dev_attr_is_visible,
 };
 
 static const struct attribute_group *pci_dev_attr_groups[] = {
-- 
2.31.0

