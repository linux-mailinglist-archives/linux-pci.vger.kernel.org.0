Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48C73629D1
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244489AbhDPU73 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:59:29 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:42510 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244516AbhDPU72 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 16:59:28 -0400
Received: by mail-ej1-f50.google.com with SMTP id w23so28189131ejb.9
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 13:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fyxBBbYogYtY/0SVOORvDrmKaBSe5CZpPNs55FdoAQc=;
        b=LvK1GngrT3koJuPdWXOH3uuKla9Ipw4w8d8gi8DnIzVRGeZtR8xVU/qCeGFiK4vaq2
         9dKDhQAaKnjO0Q5OrBsbrYf0ViOWGFqKDKMsfwLrtAwnTN+llr7MCiGj4ybCI+tty08K
         cJ5fX/Wfwb8HZ5V+CEVyTtPPv4Qftbqc98eZOzeZcPUlqJORHRSY7qsk666A+axCLRUM
         D6ZXlF90eb9OpdUaaVa8LSGjL0z0kggqjsqaZsLXaAv1MuBs7D9t6Lj6t8wa7WxRqcIV
         7IV3RXzevn9Zymz683qroj7dYlDprVhSdVLD6Npmp8KRpcDGrS7fdzJBDWdGabgW8mET
         bVkA==
X-Gm-Message-State: AOAM530NkOd3Kaxtnx85UvmISn3bWBRJnidhTEgTpjuzFTaPzYVJgtHB
        A7twxiXVl7JEBBDRpEfYRVg=
X-Google-Smtp-Source: ABdhPJzdtoQIys0WGOg+wUN2UYqcu1h5ushBqwM9Qwk661qBQK70axSFUptB6pZUIYbyLGUvK0+cog==
X-Received: by 2002:a17:906:b156:: with SMTP id bt22mr6097642ejb.181.1618606742781;
        Fri, 16 Apr 2021 13:59:02 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm5103864ejg.43.2021.04.16.13.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:59:02 -0700 (PDT)
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
Subject: [PATCH 05/20] PCI: Convert dynamic "index" and "label" sysfs objects into static
Date:   Fri, 16 Apr 2021 20:58:41 +0000
Message-Id: <20210416205856.3234481-6-kw@linux.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210416205856.3234481-1-kw@linux.com>
References: <20210416205856.3234481-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The "index" and "label" sysfs objects, which are read-only attributes,
that reside at the "/sys/bus/pci/devices/.../index" (or "acpi_index"
with the ACPI _DSM support) and "/sys/bus/pci/devices/.../label" (when
using either SMBIOS or ACPI _DSM) paths and allow for accessing the PCI
device label, either from the BIOS (SMBIOS) or through the ACPI _DSM
(Device-Specific Methods), and the device function index.

At the moment, both the "index" (or "acpi_index") and "label" static
sysfs objects are dynamically created when the pci_create_sysfs_dev_files()
function executes that is part of the PCI sysfs objects initialisation
and when a device is added:

  late_initcall()
    pci_sysfs_init()
      pci_create_sysfs_dev_files()
        pci_create_firmware_label_files()
          pci_create_acpi_index_label_files()
            <--------------------------- Depending on what is supported.
          pci_create_smbiosname_file()

  pci_bus_add_devices()
    pci_bus_add_device()
      pci_create_sysfs_dev_files()
        ...

And dynamically removed when the pci_remove_sysfs_dev_files() function
executes when the PCI device is stopped and removed:

  pci_stop_bus_device()
    pci_stop_dev()
      pci_remove_sysfs_dev_files()
        pci_remove_firmware_label_files()
          pci_remove_acpi_index_label_files()
            <--------------------------- Depending on what is supported.
          pci_remove_smbiosname_file()

These attributes do not need to be created dynamically and removed
dynamically, and thus there is no need to also manage their create and
remove life cycle manually as the PCI driver core can do it when the
device is either added or removed.

Convert the "index", "acpi_index" and "label" sysfs objects created
dynamically to static and use the .is_visible callback to check whether
the SMBIOS or ACPI _DSM is available to decide if and which of the sysfs
objects should be made available.

Then, add a newly created attribute group to the existing group called
"pci_dev_groups" to ensure that the "config" sysfs object would be
automatically included when the PCI driver initializes.

And also rename the device_has_dsm() function to device_has_acpi_name()
to better relfect its purpose.

Suggested-by: Oliver O'Halloran <oohall@gmail.com>
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-label.c | 212 +++++++++++++---------------------------
 drivers/pci/pci-sysfs.c |  17 ++--
 drivers/pci/pci.h       |  13 +--
 3 files changed, 80 insertions(+), 162 deletions(-)

diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index 781e45cf60d1..31fedc4920bb 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -33,6 +33,22 @@
 #include <linux/pci-acpi.h>
 #include "pci.h"
 
+static bool device_has_acpi_name(struct device *dev)
+{
+#ifdef CONFIG_ACPI
+	acpi_handle handle;
+
+	handle = ACPI_HANDLE(dev);
+	if (!handle)
+		return false;
+
+	return !!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 0x2,
+				1 << DSM_PCI_DEVICE_NAME);
+#else
+	return false;
+#endif
+}
+
 #ifdef CONFIG_DMI
 enum smbios_attr_enum {
 	SMBIOS_ATTR_NONE = 0,
@@ -45,13 +61,9 @@ static size_t find_smbios_instance_string(struct pci_dev *pdev, char *buf,
 {
 	const struct dmi_device *dmi;
 	struct dmi_dev_onboard *donboard;
-	int domain_nr;
-	int bus;
-	int devfn;
-
-	domain_nr = pci_domain_nr(pdev->bus);
-	bus = pdev->bus->number;
-	devfn = pdev->devfn;
+	int domain_nr = pci_domain_nr(pdev->bus);
+	int bus = pdev->bus->number;
+	int devfn = pdev->devfn;
 
 	dmi = NULL;
 	while ((dmi = dmi_find_device(DMI_DEV_TYPE_DEV_ONBOARD,
@@ -73,81 +85,57 @@ static size_t find_smbios_instance_string(struct pci_dev *pdev, char *buf,
 			return strlen(dmi->name);
 		}
 	}
-	return 0;
-}
-
-static umode_t smbios_instance_string_exist(struct kobject *kobj,
-					    struct attribute *attr, int n)
-{
-	struct device *dev;
-	struct pci_dev *pdev;
 
-	dev = kobj_to_dev(kobj);
-	pdev = to_pci_dev(dev);
-
-	return find_smbios_instance_string(pdev, NULL, SMBIOS_ATTR_NONE) ?
-					   S_IRUGO : 0;
+	return 0;
 }
 
-static ssize_t smbioslabel_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t smbios_label_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
 {
-	struct pci_dev *pdev;
-	pdev = to_pci_dev(dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
 
 	return find_smbios_instance_string(pdev, buf,
 					   SMBIOS_ATTR_LABEL_SHOW);
 }
+static struct device_attribute dev_attr_smbios_label = __ATTR(label, 0444,
+							      smbios_label_show,
+							      NULL);
 
-static ssize_t smbiosinstance_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
+static ssize_t index_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
 {
-	struct pci_dev *pdev;
-	pdev = to_pci_dev(dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
 
 	return find_smbios_instance_string(pdev, buf,
 					   SMBIOS_ATTR_INSTANCE_SHOW);
 }
+static DEVICE_ATTR_RO(index);
 
-static struct device_attribute smbios_attr_label = {
-	.attr = {.name = "label", .mode = 0444},
-	.show = smbioslabel_show,
-};
-
-static struct device_attribute smbios_attr_instance = {
-	.attr = {.name = "index", .mode = 0444},
-	.show = smbiosinstance_show,
-};
-
-static struct attribute *smbios_attributes[] = {
-	&smbios_attr_label.attr,
-	&smbios_attr_instance.attr,
+static struct attribute *smbios_attrs[] = {
+	&dev_attr_smbios_label.attr,
+	&dev_attr_index.attr,
 	NULL,
 };
 
-static const struct attribute_group smbios_attr_group = {
-	.attrs = smbios_attributes,
-	.is_visible = smbios_instance_string_exist,
-};
-
-static int pci_create_smbiosname_file(struct pci_dev *pdev)
+static umode_t smbios_attr_is_visible(struct kobject *kobj,
+				      struct attribute *a, int n)
 {
-	return sysfs_create_group(&pdev->dev.kobj, &smbios_attr_group);
-}
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
 
-static void pci_remove_smbiosname_file(struct pci_dev *pdev)
-{
-	sysfs_remove_group(&pdev->dev.kobj, &smbios_attr_group);
-}
-#else
-static inline int pci_create_smbiosname_file(struct pci_dev *pdev)
-{
-	return -1;
-}
+	if (device_has_acpi_name(dev))
+		return 0;
 
-static inline void pci_remove_smbiosname_file(struct pci_dev *pdev)
-{
+	if (!find_smbios_instance_string(pdev, NULL, SMBIOS_ATTR_NONE))
+		return 0;
+
+	return a->mode;
 }
+
+const struct attribute_group smbios_attr_group = {
+	.attrs = smbios_attrs,
+	.is_visible = smbios_attr_is_visible,
+};
 #endif
 
 #ifdef CONFIG_ACPI
@@ -209,103 +197,41 @@ static int dsm_get_label(struct device *dev, char *buf,
 	return len;
 }
 
-static bool device_has_dsm(struct device *dev)
-{
-	acpi_handle handle;
-
-	handle = ACPI_HANDLE(dev);
-	if (!handle)
-		return false;
-
-	return !!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 0x2,
-				1 << DSM_PCI_DEVICE_NAME);
-}
-
-static umode_t acpi_index_string_exist(struct kobject *kobj,
-				       struct attribute *attr, int n)
-{
-	struct device *dev;
-
-	dev = kobj_to_dev(kobj);
-
-	if (device_has_dsm(dev))
-		return S_IRUGO;
-
-	return 0;
-}
-
-static ssize_t acpilabel_show(struct device *dev,
-			      struct device_attribute *attr, char *buf)
+static ssize_t acpi_label_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	return dsm_get_label(dev, buf, ACPI_ATTR_LABEL_SHOW);
 }
+static struct device_attribute dev_attr_acpi_label = __ATTR(label, 0444,
+							    acpi_label_show,
+							    NULL);
 
-static ssize_t acpiindex_show(struct device *dev,
-			      struct device_attribute *attr, char *buf)
+static ssize_t acpi_index_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	return dsm_get_label(dev, buf, ACPI_ATTR_INDEX_SHOW);
 }
+static DEVICE_ATTR_RO(acpi_index);
 
-static struct device_attribute acpi_attr_label = {
-	.attr = {.name = "label", .mode = 0444},
-	.show = acpilabel_show,
-};
-
-static struct device_attribute acpi_attr_index = {
-	.attr = {.name = "acpi_index", .mode = 0444},
-	.show = acpiindex_show,
-};
-
-static struct attribute *acpi_attributes[] = {
-	&acpi_attr_label.attr,
-	&acpi_attr_index.attr,
+static struct attribute *acpi_attrs[] = {
+	&dev_attr_acpi_label.attr,
+	&dev_attr_acpi_index.attr,
 	NULL,
 };
 
-static const struct attribute_group acpi_attr_group = {
-	.attrs = acpi_attributes,
-	.is_visible = acpi_index_string_exist,
-};
-
-static int pci_create_acpi_index_label_files(struct pci_dev *pdev)
+static umode_t acpi_attr_is_visible(struct kobject *kobj,
+				    struct attribute *a, int n)
 {
-	return sysfs_create_group(&pdev->dev.kobj, &acpi_attr_group);
-}
+	struct device *dev = kobj_to_dev(kobj);
 
-static int pci_remove_acpi_index_label_files(struct pci_dev *pdev)
-{
-	sysfs_remove_group(&pdev->dev.kobj, &acpi_attr_group);
-	return 0;
-}
-#else
-static inline int pci_create_acpi_index_label_files(struct pci_dev *pdev)
-{
-	return -1;
-}
+	if (!device_has_acpi_name(dev))
+		return 0;
 
-static inline int pci_remove_acpi_index_label_files(struct pci_dev *pdev)
-{
-	return -1;
+	return a->mode;
 }
 
-static inline bool device_has_dsm(struct device *dev)
-{
-	return false;
-}
+const struct attribute_group acpi_attr_group = {
+	.attrs = acpi_attrs,
+	.is_visible = acpi_attr_is_visible,
+};
 #endif
-
-void pci_create_firmware_label_files(struct pci_dev *pdev)
-{
-	if (device_has_dsm(&pdev->dev))
-		pci_create_acpi_index_label_files(pdev);
-	else
-		pci_create_smbiosname_file(pdev);
-}
-
-void pci_remove_firmware_label_files(struct pci_dev *pdev)
-{
-	if (device_has_dsm(&pdev->dev))
-		pci_remove_acpi_index_label_files(pdev);
-	else
-		pci_remove_smbiosname_file(pdev);
-}
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 501d120e268b..6a8a44d44127 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1380,18 +1380,10 @@ static const struct attribute_group pci_dev_reset_attr_group = {
 
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
-	int retval;
-
 	if (!sysfs_initialized)
 		return -EACCES;
 
-	retval = pci_create_resource_files(pdev);
-	if (retval)
-		return retval;
-
-	pci_create_firmware_label_files(pdev);
-
-	return 0;
+	return pci_create_resource_files(pdev);
 }
 
 /**
@@ -1406,7 +1398,6 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 		return;
 
 	pci_remove_resource_files(pdev);
-	pci_remove_firmware_label_files(pdev);
 }
 
 static int __init pci_sysfs_init(void)
@@ -1501,6 +1492,12 @@ const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_rom_attr_group,
 	&pci_dev_reset_attr_group,
 	&vpd_attr_group,
+#ifdef CONFIG_DMI
+	&smbios_attr_group,
+#endif
+#ifdef CONFIG_ACPI
+	&acpi_attr_group,
+#endif
 	NULL,
 };
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0dc52e60d03c..d6678124e8ea 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -21,16 +21,10 @@ bool pcie_cap_has_rtctl(const struct pci_dev *dev);
 
 int pci_create_sysfs_dev_files(struct pci_dev *pdev);
 void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
-#if !defined(CONFIG_DMI) && !defined(CONFIG_ACPI)
-static inline void pci_create_firmware_label_files(struct pci_dev *pdev)
-{ return; }
-static inline void pci_remove_firmware_label_files(struct pci_dev *pdev)
-{ return; }
-#else
-void pci_create_firmware_label_files(struct pci_dev *pdev);
-void pci_remove_firmware_label_files(struct pci_dev *pdev);
-#endif
 void pci_cleanup_rom(struct pci_dev *dev);
+#ifdef CONFIG_DMI
+extern const struct attribute_group smbios_attr_group;
+#endif
 
 enum pci_mmap_api {
 	PCI_MMAP_SYSFS,	/* mmap on /sys/bus/pci/devices/<BDF>/resource<N> */
@@ -695,6 +689,7 @@ static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL
 
 #ifdef CONFIG_ACPI
 int pci_acpi_program_hp_params(struct pci_dev *dev);
+extern const struct attribute_group acpi_attr_group;
 #else
 static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
 {
-- 
2.31.0

