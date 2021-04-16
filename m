Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1813629D7
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343757AbhDPU7f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:59:35 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:33522 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244516AbhDPU7f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 16:59:35 -0400
Received: by mail-ej1-f44.google.com with SMTP id g5so37295144ejx.0
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 13:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zEMt8zlMmYDSPAeCcBkze5c5Ax6jXwqdG0prTSbuHtc=;
        b=p6kP+vOgx5ltmAukT3Woqg7fHs+x3TsCeRuhMVNIDuDVqK0GTawbEsKjN2t6n/Sue9
         CRay9q1L1oLxdaLSyS6v4b8W0okY3hbqya/TL7p+waba36cNxK0bqvZHjFqIM3vJYx1B
         wsJhy3W1S1GeG5KungCof3MOg9/j6wi5Hts0LUDMpeNuVfiwPJ8tRXycUOqFHTGU0A+G
         3ni3iAr+2+vMXfIDSBUF9ScXGAYtsByPPub4hYBOSdWSe+AKSmF4MdTv1mW3QYRe0+Xk
         xcWcrJJt1OTKvsekOkC3I6q4tD8Qc24NAYma7mm16AvAednt1hXwe4VNwqHxZ/GLhSE/
         mNZg==
X-Gm-Message-State: AOAM531OciFaSAMWrNHM55XFbjmhxkqYRu8S7rYw33vCN+cDo3bSAkNU
        a8wqaoHcWRLApALvU6odEio=
X-Google-Smtp-Source: ABdhPJw0Zgvsy83yPtRRCqR291wNUnO1PGIuY7JCVqj2VLmSA8IPlSiU2Y5Vce05spGiAwYDNTvyfw==
X-Received: by 2002:a17:906:7842:: with SMTP id p2mr10614167ejm.87.1618606749009;
        Fri, 16 Apr 2021 13:59:09 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm5103864ejg.43.2021.04.16.13.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:59:08 -0700 (PDT)
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
Subject: [PATCH 11/20] PCI: Rearrange attributes from the pci_dev_group
Date:   Fri, 16 Apr 2021 20:58:47 +0000
Message-Id: <20210416205856.3234481-12-kw@linux.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210416205856.3234481-1-kw@linux.com>
References: <20210416205856.3234481-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When new sysfs objects were added to the PCI device over time, the code
that implemented new attributes has been added in many different places
in the pci-sysfs.c file.  This makes it hard to read and also hard to
find relevant code.

Thus, collect all the attributes that are part of the "pci_dev_group"
attribute group together and move to the top of the file sorting
everything attribute in the order of use.

No functional change intended.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 695 +++++++++++++++++++++-------------------
 1 file changed, 369 insertions(+), 326 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 96302b63f6c5..5f83ff087f2c 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -30,50 +30,6 @@
 
 static int sysfs_initialized;	/* = 0 */
 
-/* show configuration fields */
-#define pci_config_attr(field, format_string)				\
-static ssize_t								\
-field##_show(struct device *dev, struct device_attribute *attr, char *buf)				\
-{									\
-	struct pci_dev *pdev = to_pci_dev(dev);				\
-									\
-	return sysfs_emit(buf, format_string, pdev->field);		\
-}									\
-static DEVICE_ATTR_RO(field)
-
-pci_config_attr(vendor, "0x%04x\n");
-pci_config_attr(device, "0x%04x\n");
-pci_config_attr(subsystem_vendor, "0x%04x\n");
-pci_config_attr(subsystem_device, "0x%04x\n");
-pci_config_attr(revision, "0x%02x\n");
-pci_config_attr(class, "0x%06x\n");
-pci_config_attr(irq, "%u\n");
-
-static ssize_t broken_parity_status_show(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	return sysfs_emit(buf, "%u\n", pdev->broken_parity_status);
-}
-
-static ssize_t broken_parity_status_store(struct device *dev,
-					  struct device_attribute *attr,
-					  const char *buf, size_t count)
-{
-	bool broken;
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	if (kstrtobool(buf, &broken) < 0)
-		return -EINVAL;
-
-	pdev->broken_parity_status = !!broken;
-
-	return count;
-}
-static DEVICE_ATTR_RW(broken_parity_status);
-
 static ssize_t pci_dev_show_local_cpu(struct device *dev, bool list,
 				      struct device_attribute *attr, char *buf)
 {
@@ -93,43 +49,6 @@ static ssize_t pci_dev_show_local_cpu(struct device *dev, bool list,
 	return cpumap_print_to_pagebuf(list, buf, mask);
 }
 
-static ssize_t local_cpus_show(struct device *dev,
-			       struct device_attribute *attr, char *buf)
-{
-	return pci_dev_show_local_cpu(dev, false, attr, buf);
-}
-static DEVICE_ATTR_RO(local_cpus);
-
-static ssize_t local_cpulist_show(struct device *dev,
-				  struct device_attribute *attr, char *buf)
-{
-	return pci_dev_show_local_cpu(dev, true, attr, buf);
-}
-static DEVICE_ATTR_RO(local_cpulist);
-
-/*
- * PCI Bus Class Devices
- */
-static ssize_t cpuaffinity_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct pci_bus *bus = to_pci_bus(dev);
-	const struct cpumask *cpumask = cpumask_of_pcibus(bus);
-
-	return cpumap_print_to_pagebuf(false, buf, cpumask);
-}
-static DEVICE_ATTR_RO(cpuaffinity);
-
-static ssize_t cpulistaffinity_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct pci_bus *bus = to_pci_bus(dev);
-	const struct cpumask *cpumask = cpumask_of_pcibus(bus);
-
-	return cpumap_print_to_pagebuf(true, buf, cpumask);
-}
-static DEVICE_ATTR_RO(cpulistaffinity);
-
 static ssize_t power_state_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -139,7 +58,6 @@ static ssize_t power_state_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(power_state);
 
-/* show resources */
 static ssize_t resource_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
@@ -166,89 +84,82 @@ static ssize_t resource_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(resource);
 
-static ssize_t max_link_speed_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
+static ssize_t vendor_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sysfs_emit(buf, "%s\n",
-			  pci_speed_string(pcie_get_speed_cap(pdev)));
+	return sysfs_emit(buf, "0x%04x\n", pdev->vendor);
 }
-static DEVICE_ATTR_RO(max_link_speed);
+static DEVICE_ATTR_RO(vendor);
 
-static ssize_t max_link_width_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
+static ssize_t device_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
+	return sysfs_emit(buf, "0x%04x\n", pdev->device);
 }
-static DEVICE_ATTR_RO(max_link_width);
+static DEVICE_ATTR_RO(device);
 
-static ssize_t current_link_speed_show(struct device *dev,
-				       struct device_attribute *attr, char *buf)
+static ssize_t subsystem_vendor_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	enum pci_bus_speed speed;
-
-	pcie_bandwidth_available(pdev, NULL, &speed, NULL);
 
-	return sysfs_emit(buf, "%s\n", pci_speed_string(speed));
+	return sysfs_emit(buf, "0x%04x\n", pdev->subsystem_vendor);
 }
-static DEVICE_ATTR_RO(current_link_speed);
+static DEVICE_ATTR_RO(subsystem_vendor);
 
-static ssize_t current_link_width_show(struct device *dev,
-				       struct device_attribute *attr, char *buf)
+static ssize_t subsystem_device_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	enum pcie_link_width width;
 
-	pcie_bandwidth_available(pdev, NULL, NULL, &width);
-
-	return sysfs_emit(buf, "%u\n", width);
+	return sysfs_emit(buf, "0x%04x\n", pdev->subsystem_device);
 }
-static DEVICE_ATTR_RO(current_link_width);
+static DEVICE_ATTR_RO(subsystem_device);
 
-static ssize_t secondary_bus_number_show(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
+static ssize_t revision_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	u8 sec_bus;
-	int err;
-
-	err = pci_read_config_byte(pdev, PCI_SECONDARY_BUS, &sec_bus);
-	if (err)
-		return -EINVAL;
 
-	return sysfs_emit(buf, "%u\n", sec_bus);
+	return sysfs_emit(buf, "0x%02x\n", pdev->revision);
 }
-static DEVICE_ATTR_RO(secondary_bus_number);
+static DEVICE_ATTR_RO(revision);
 
-static ssize_t subordinate_bus_number_show(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
+static ssize_t class_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	u8 sub_bus;
-	int err;
 
-	err = pci_read_config_byte(pdev, PCI_SUBORDINATE_BUS, &sub_bus);
-	if (err)
-		return -EINVAL;
-
-	return sysfs_emit(buf, "%u\n", sub_bus);
+	return sysfs_emit(buf, "0x%06x\n", pdev->class);
 }
-static DEVICE_ATTR_RO(subordinate_bus_number);
+static DEVICE_ATTR_RO(class);
 
-static ssize_t ari_enabled_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t irq_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sysfs_emit(buf, "%u\n", pci_ari_enabled(pdev->bus));
+	return sysfs_emit(buf, "%u\n", pdev->irq);
 }
-static DEVICE_ATTR_RO(ari_enabled);
+static DEVICE_ATTR_RO(irq);
+
+static ssize_t local_cpus_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	return pci_dev_show_local_cpu(dev, false, attr, buf);
+}
+static DEVICE_ATTR_RO(local_cpus);
+
+static ssize_t local_cpulist_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	return pci_dev_show_local_cpu(dev, true, attr, buf);
+}
+static DEVICE_ATTR_RO(local_cpulist);
 
 static ssize_t modalias_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
@@ -263,6 +174,68 @@ static ssize_t modalias_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(modalias);
 
+#ifdef CONFIG_NUMA
+static ssize_t numa_node_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", dev->numa_node);
+}
+
+static ssize_t numa_node_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
+{
+	int node;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (kstrtoint(buf, 0, &node) < 0)
+		return -EINVAL;
+
+	if ((node < 0 && node != NUMA_NO_NODE) || node >= MAX_NUMNODES)
+		return -EINVAL;
+
+	if (node != NUMA_NO_NODE && !node_online(node))
+		return -EINVAL;
+
+	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+	pci_alert(pdev, FW_BUG "Overriding NUMA node to %d.  Contact your vendor for updates.",
+		  node);
+
+	dev->numa_node = node;
+
+	return count;
+}
+static DEVICE_ATTR_RW(numa_node);
+#endif
+
+static ssize_t dma_mask_bits_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sysfs_emit(buf, "%d\n", fls64(pdev->dma_mask));
+}
+static DEVICE_ATTR_RO(dma_mask_bits);
+
+static ssize_t consistent_dma_mask_bits_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	return sysfs_emit(buf, "%d\n", fls64(dev->coherent_dma_mask));
+}
+static DEVICE_ATTR_RO(consistent_dma_mask_bits);
+
+static ssize_t enable_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sysfs_emit(buf, "%u\n", atomic_read(&pdev->enable_cnt));
+}
+
 static ssize_t enable_store(struct device *dev,
 			    struct device_attribute *attr, const char *buf,
 			    size_t count)
@@ -294,118 +267,319 @@ static ssize_t enable_store(struct device *dev,
 
 	return count;
 }
+static DEVICE_ATTR_RW(enable);
 
-static ssize_t enable_show(struct device *dev,
-			   struct device_attribute *attr, char *buf)
+static ssize_t broken_parity_status_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sysfs_emit(buf, "%u\n", atomic_read(&pdev->enable_cnt));
+	return sysfs_emit(buf, "%u\n", pdev->broken_parity_status);
 }
-static DEVICE_ATTR_RW(enable);
 
-#ifdef CONFIG_NUMA
-static ssize_t numa_node_store(struct device *dev,
-			       struct device_attribute *attr, const char *buf,
-			       size_t count)
+static ssize_t broken_parity_status_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	bool broken;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (kstrtobool(buf, &broken) < 0)
+		return -EINVAL;
+
+	pdev->broken_parity_status = !!broken;
+
+	return count;
+}
+static DEVICE_ATTR_RW(broken_parity_status);
+
+static ssize_t msi_bus_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
 {
-	int node;
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_bus *subordinate = pdev->subordinate;
+
+	return sysfs_emit(buf, "%u\n", subordinate ?
+			  !(subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI)
+			    : !pdev->no_msi);
+}
+
+static ssize_t msi_bus_store(struct device *dev,
+			     struct device_attribute *attr, const char *buf,
+			     size_t count)
+{
+	bool allowed;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_bus *subordinate = pdev->subordinate;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (kstrtoint(buf, 0, &node) < 0)
+	if (kstrtobool(buf, &allowed) < 0)
 		return -EINVAL;
 
-	if ((node < 0 && node != NUMA_NO_NODE) || node >= MAX_NUMNODES)
+	/*
+	 * "no_msi" and "bus_flags" only affect what happens when a driver
+	 * requests MSI or MSI-X.  They don't affect any drivers that have
+	 * already requested MSI or MSI-X.
+	 */
+	if (!subordinate) {
+		pdev->no_msi = !allowed;
+		pci_info(pdev, "MSI/MSI-X %s for future drivers\n",
+			 allowed ? "allowed" : "disallowed");
+		return count;
+	}
+
+	if (allowed)
+		subordinate->bus_flags &= ~PCI_BUS_FLAGS_NO_MSI;
+	else
+		subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
+
+	dev_info(&subordinate->dev, "MSI/MSI-X %s for future drivers of devices on this bus\n",
+		 allowed ? "allowed" : "disallowed");
+
+	return count;
+}
+static DEVICE_ATTR_RW(msi_bus);
+
+#if defined(CONFIG_PM) && defined(CONFIG_ACPI)
+static ssize_t d3cold_allowed_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sysfs_emit(buf, "%u\n", pdev->d3cold_allowed);
+}
+
+static ssize_t d3cold_allowed_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	bool allowed;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (kstrtobool(buf, &allowed) < 0)
 		return -EINVAL;
 
-	if (node != NUMA_NO_NODE && !node_online(node))
+	pdev->d3cold_allowed = !!allowed;
+	if (pdev->d3cold_allowed)
+		pci_d3cold_enable(pdev);
+	else
+		pci_d3cold_disable(pdev);
+
+	pm_runtime_resume(dev);
+
+	return count;
+}
+static DEVICE_ATTR_RW(d3cold_allowed);
+#endif
+
+#ifdef CONFIG_OF
+static ssize_t devspec_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct device_node *np = pci_device_to_OF_node(pdev);
+
+	if (!np)
+		return 0;
+
+	return sysfs_emit(buf, "%pOF", np);
+}
+static DEVICE_ATTR_RO(devspec);
+#endif
+
+static ssize_t driver_override_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	ssize_t len;
+
+	device_lock(dev);
+	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
+	device_unlock(dev);
+
+	return len;
+}
+
+static ssize_t driver_override_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	char *driver_override, *old, *cp;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	/* We need to keep extra room for a newline */
+	if (count >= (PAGE_SIZE - 1))
 		return -EINVAL;
 
-	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
-	pci_alert(pdev, FW_BUG "Overriding NUMA node to %d.  Contact your vendor for updates.",
-		  node);
+	driver_override = kstrndup(buf, count, GFP_KERNEL);
+	if (!driver_override)
+		return -ENOMEM;
+
+	cp = strchr(driver_override, '\n');
+	if (cp)
+		*cp = '\0';
+
+	device_lock(dev);
+	old = pdev->driver_override;
+	if (strlen(driver_override)) {
+		pdev->driver_override = driver_override;
+	} else {
+		kfree(driver_override);
+		pdev->driver_override = NULL;
+	}
+	device_unlock(dev);
+
+	kfree(old);
+
+	return count;
+}
+static DEVICE_ATTR_RW(driver_override);
+
+static ssize_t ari_enabled_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sysfs_emit(buf, "%u\n", pci_ari_enabled(pdev->bus));
+}
+static DEVICE_ATTR_RO(ari_enabled);
+
+static struct attribute *pci_dev_attrs[] = {
+	&dev_attr_power_state.attr,
+	&dev_attr_resource.attr,
+	&dev_attr_vendor.attr,
+	&dev_attr_device.attr,
+	&dev_attr_subsystem_vendor.attr,
+	&dev_attr_subsystem_device.attr,
+	&dev_attr_revision.attr,
+	&dev_attr_class.attr,
+	&dev_attr_irq.attr,
+	&dev_attr_local_cpus.attr,
+	&dev_attr_local_cpulist.attr,
+	&dev_attr_modalias.attr,
+#ifdef CONFIG_NUMA
+	&dev_attr_numa_node.attr,
+#endif
+	&dev_attr_dma_mask_bits.attr,
+	&dev_attr_consistent_dma_mask_bits.attr,
+	&dev_attr_enable.attr,
+	&dev_attr_broken_parity_status.attr,
+	&dev_attr_msi_bus.attr,
+#if defined(CONFIG_PM) && defined(CONFIG_ACPI)
+	&dev_attr_d3cold_allowed.attr,
+#endif
+#ifdef CONFIG_OF
+	&dev_attr_devspec.attr,
+#endif
+	&dev_attr_driver_override.attr,
+	&dev_attr_ari_enabled.attr,
+	NULL,
+};
+
+static const struct attribute_group pci_dev_group = {
+	.attrs = pci_dev_attrs,
+};
 
-	dev->numa_node = node;
+/*
+ * PCI Bus Class Devices
+ */
+static ssize_t cpuaffinity_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct pci_bus *bus = to_pci_bus(dev);
+	const struct cpumask *cpumask = cpumask_of_pcibus(bus);
 
-	return count;
+	return cpumap_print_to_pagebuf(false, buf, cpumask);
 }
+static DEVICE_ATTR_RO(cpuaffinity);
 
-static ssize_t numa_node_show(struct device *dev,
-			      struct device_attribute *attr, char *buf)
+static ssize_t cpulistaffinity_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", dev->numa_node);
+	struct pci_bus *bus = to_pci_bus(dev);
+	const struct cpumask *cpumask = cpumask_of_pcibus(bus);
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask);
 }
-static DEVICE_ATTR_RW(numa_node);
-#endif
+static DEVICE_ATTR_RO(cpulistaffinity);
 
-static ssize_t dma_mask_bits_show(struct device *dev,
-				  struct device_attribute *attr, char *buf)
+static ssize_t max_link_speed_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sysfs_emit(buf, "%d\n", fls64(pdev->dma_mask));
+	return sysfs_emit(buf, "%s\n",
+			  pci_speed_string(pcie_get_speed_cap(pdev)));
 }
-static DEVICE_ATTR_RO(dma_mask_bits);
+static DEVICE_ATTR_RO(max_link_speed);
 
-static ssize_t consistent_dma_mask_bits_show(struct device *dev,
-					     struct device_attribute *attr,
-					     char *buf)
+static ssize_t max_link_width_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", fls64(dev->coherent_dma_mask));
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
 }
-static DEVICE_ATTR_RO(consistent_dma_mask_bits);
+static DEVICE_ATTR_RO(max_link_width);
 
-static ssize_t msi_bus_show(struct device *dev,
-			    struct device_attribute *attr, char *buf)
+static ssize_t current_link_speed_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct pci_bus *subordinate = pdev->subordinate;
+	enum pci_bus_speed speed;
 
-	return sysfs_emit(buf, "%u\n", subordinate ?
-			  !(subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI)
-			    : !pdev->no_msi);
+	pcie_bandwidth_available(pdev, NULL, &speed, NULL);
+
+	return sysfs_emit(buf, "%s\n", pci_speed_string(speed));
 }
+static DEVICE_ATTR_RO(current_link_speed);
 
-static ssize_t msi_bus_store(struct device *dev,
-			     struct device_attribute *attr, const char *buf,
-			     size_t count)
+static ssize_t current_link_width_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
 {
-	bool allowed;
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct pci_bus *subordinate = pdev->subordinate;
+	enum pcie_link_width width;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
+	pcie_bandwidth_available(pdev, NULL, NULL, &width);
 
-	if (kstrtobool(buf, &allowed) < 0)
+	return sysfs_emit(buf, "%u\n", width);
+}
+static DEVICE_ATTR_RO(current_link_width);
+
+static ssize_t secondary_bus_number_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u8 sec_bus;
+	int err;
+
+	err = pci_read_config_byte(pdev, PCI_SECONDARY_BUS, &sec_bus);
+	if (err)
 		return -EINVAL;
 
-	/*
-	 * "no_msi" and "bus_flags" only affect what happens when a driver
-	 * requests MSI or MSI-X.  They don't affect any drivers that have
-	 * already requested MSI or MSI-X.
-	 */
-	if (!subordinate) {
-		pdev->no_msi = !allowed;
-		pci_info(pdev, "MSI/MSI-X %s for future drivers\n",
-			 allowed ? "allowed" : "disallowed");
-		return count;
-	}
+	return sysfs_emit(buf, "%u\n", sec_bus);
+}
+static DEVICE_ATTR_RO(secondary_bus_number);
 
-	if (allowed)
-		subordinate->bus_flags &= ~PCI_BUS_FLAGS_NO_MSI;
-	else
-		subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
+static ssize_t subordinate_bus_number_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u8 sub_bus;
+	int err;
 
-	dev_info(&subordinate->dev, "MSI/MSI-X %s for future drivers of devices on this bus\n",
-		 allowed ? "allowed" : "disallowed");
+	err = pci_read_config_byte(pdev, PCI_SUBORDINATE_BUS, &sub_bus);
+	if (err)
+		return -EINVAL;
 
-	return count;
+	return sysfs_emit(buf, "%u\n", sub_bus);
 }
-static DEVICE_ATTR_RW(msi_bus);
+static DEVICE_ATTR_RO(subordinate_bus_number);
 
 static ssize_t rescan_store(struct bus_type *bus, const char *buf, size_t count)
 {
@@ -502,133 +676,6 @@ static ssize_t bus_rescan_store(struct device *dev,
 static struct device_attribute dev_attr_bus_rescan = __ATTR(rescan, 0200, NULL,
 							    bus_rescan_store);
 
-#if defined(CONFIG_PM) && defined(CONFIG_ACPI)
-static ssize_t d3cold_allowed_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
-{
-	bool allowed;
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	if (kstrtobool(buf, &allowed) < 0)
-		return -EINVAL;
-
-	pdev->d3cold_allowed = !!allowed;
-	if (pdev->d3cold_allowed)
-		pci_d3cold_enable(pdev);
-	else
-		pci_d3cold_disable(pdev);
-
-	pm_runtime_resume(dev);
-
-	return count;
-}
-
-static ssize_t d3cold_allowed_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	return sysfs_emit(buf, "%u\n", pdev->d3cold_allowed);
-}
-static DEVICE_ATTR_RW(d3cold_allowed);
-#endif
-
-#ifdef CONFIG_OF
-static ssize_t devspec_show(struct device *dev,
-			    struct device_attribute *attr, char *buf)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct device_node *np = pci_device_to_OF_node(pdev);
-
-	if (!np)
-		return 0;
-
-	return sysfs_emit(buf, "%pOF", np);
-}
-static DEVICE_ATTR_RO(devspec);
-#endif
-
-static ssize_t driver_override_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
-{
-	char *driver_override, *old, *cp;
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	/* We need to keep extra room for a newline */
-	if (count >= (PAGE_SIZE - 1))
-		return -EINVAL;
-
-	driver_override = kstrndup(buf, count, GFP_KERNEL);
-	if (!driver_override)
-		return -ENOMEM;
-
-	cp = strchr(driver_override, '\n');
-	if (cp)
-		*cp = '\0';
-
-	device_lock(dev);
-	old = pdev->driver_override;
-	if (strlen(driver_override)) {
-		pdev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		pdev->driver_override = NULL;
-	}
-	device_unlock(dev);
-
-	kfree(old);
-
-	return count;
-}
-
-static ssize_t driver_override_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	ssize_t len;
-
-	device_lock(dev);
-	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
-	device_unlock(dev);
-
-	return len;
-}
-static DEVICE_ATTR_RW(driver_override);
-
-static struct attribute *pci_dev_attrs[] = {
-	&dev_attr_power_state.attr,
-	&dev_attr_resource.attr,
-	&dev_attr_vendor.attr,
-	&dev_attr_device.attr,
-	&dev_attr_subsystem_vendor.attr,
-	&dev_attr_subsystem_device.attr,
-	&dev_attr_revision.attr,
-	&dev_attr_class.attr,
-	&dev_attr_irq.attr,
-	&dev_attr_local_cpus.attr,
-	&dev_attr_local_cpulist.attr,
-	&dev_attr_modalias.attr,
-#ifdef CONFIG_NUMA
-	&dev_attr_numa_node.attr,
-#endif
-	&dev_attr_dma_mask_bits.attr,
-	&dev_attr_consistent_dma_mask_bits.attr,
-	&dev_attr_enable.attr,
-	&dev_attr_broken_parity_status.attr,
-	&dev_attr_msi_bus.attr,
-#if defined(CONFIG_PM) && defined(CONFIG_ACPI)
-	&dev_attr_d3cold_allowed.attr,
-#endif
-#ifdef CONFIG_OF
-	&dev_attr_devspec.attr,
-#endif
-	&dev_attr_driver_override.attr,
-	&dev_attr_ari_enabled.attr,
-	NULL,
-};
-
 static struct attribute *pci_bridge_attrs[] = {
 	&dev_attr_subordinate_bus_number.attr,
 	&dev_attr_secondary_bus_number.attr,
@@ -1504,10 +1551,6 @@ static umode_t pcie_dev_attr_is_visible(struct kobject *kobj,
 	return a->mode;
 }
 
-static const struct attribute_group pci_dev_group = {
-	.attrs = pci_dev_attrs,
-};
-
 const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_group,
 	&pci_dev_config_attr_group,
-- 
2.31.0

