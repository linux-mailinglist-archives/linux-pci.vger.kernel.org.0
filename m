Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DD13629D0
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244287AbhDPU73 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:59:29 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:34348 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244489AbhDPU72 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 16:59:28 -0400
Received: by mail-ej1-f45.google.com with SMTP id x12so23230464ejc.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 13:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WG/g5y0DViW7yjKYVrQwqq+4O3GQmP8ASlsa/r+oCP4=;
        b=Vfb0rgtpS4myg9Qvj0hubjteroAtyF1LgFRQrKfNUUaEuwEB8FUDkPK39Pk+NiAFZe
         iuvT5anEUh2mbJx8G4XwJwbZpprRG5kuKye9Pjtf5CR5XpiTbkUAJD6wjfJtl4MmIsMD
         2+OruZn1JBHC/IOiv4VZCw8ZEUGoC8f7czsNTnX9Hri/K9jTK/J/mWzL+tNYm4BgAysf
         Xdf72/5ly736wluevB3odhC6nt5WtbmmdysEjweEAg3bzWq9kjubdhQ3JCm3E1yKpo0h
         E/eJxtRCtOt2O9dmJw6ry0RmdFUzaqS0dyKrbFQVMAHBuNxjdwvhNASiAesXXW3KJ7pI
         v7LA==
X-Gm-Message-State: AOAM531nsCBzaWHWDtRbz4uGjqjE4j7cWGMwsceh5UIEJDftyWlEjPRc
        LYeG3wlvcSElsmClTo4L93o=
X-Google-Smtp-Source: ABdhPJzBpLjV9gCEOH0OlyjqQJ8ozJaEZ29pPD7ptwU5rm3xbICJ4Zg+Hel6XM7We9cj/oa7b+dZ+Q==
X-Received: by 2002:a17:906:2652:: with SMTP id i18mr10039217ejc.189.1618606741791;
        Fri, 16 Apr 2021 13:59:01 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm5103864ejg.43.2021.04.16.13.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:59:01 -0700 (PDT)
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
Subject: [PATCH 04/20] PCI/VPD: Convert dynamic "vpd" sysfs object into static
Date:   Fri, 16 Apr 2021 20:58:40 +0000
Message-Id: <20210416205856.3234481-5-kw@linux.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210416205856.3234481-1-kw@linux.com>
References: <20210416205856.3234481-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The "vpd" sysfs object, which is a read-and-write binary attribute,
resides at the "/sys/bus/pci/devices/.../vpd" path and allows for
accessing the Vital Product Data (VPD) for a device.

At the moment, the "vpd" sysfs object is dynamically created when the
pcie_vpd_create_sysfs_dev_files() function executes that is part of the
PCI sysfs objects initialisation and when a device is added:

  late_initcall()
    pci_sysfs_init()
      pci_create_sysfs_dev_files()
        pci_create_capabilities_sysfs()
          pcie_vpd_create_sysfs_dev_files()
            sysfs_bin_attr_init()
            sysfs_create_bin_file()

  pci_bus_add_devices()
    pci_bus_add_device()
      pci_create_sysfs_dev_files()
        ...

And dynamically removed when the pcie_vpd_remove_sysfs_dev_files()
function executes when the PCI device is stopped and removed:

  pci_stop_bus_device()
    pci_stop_dev()
      pci_remove_sysfs_dev_files()
        pci_remove_capabilities_sysfs()
          pcie_vpd_remove_sysfs_dev_files()
            sysfs_remove_bin_file()

This attribute does not need to be created dynamically and removed
dynamically, and thus there is no need to also manage its create and
remove life cycle manually as the PCI driver core can do it when the
device is either added or removed.

Convert the "vpd" sysfs object created dynamically to static and use the
.is_bin_visible callback to check whether the device supports VPD and to
decide if the sysfs object should be made available.

Then, add a newly created attribute group to the existing group called
"pci_dev_groups" to ensure that the "vpd" sysfs object would be
automatically included when the PCI driver initializes.

Remove the no longer needed pointer "attr" from the struct pci_vpd
that used to hold a reference to the dynamically created "vpd" sysfs
object.

And also remove functions such as pcie_vpd_create_sysfs_dev_files(),
pcie_vpd_remove_sysfs_dev_files(), pci_create_capabilities_sysfs() and
pci_create_capabilities_sysfs() that are no longer needed to be called
from the pci_create_sysfs_dev_files() or pci_remove_sysfs_dev_files()
functions.

Suggested-by: Oliver O'Halloran <oohall@gmail.com>
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 15 +-------------
 drivers/pci/pci.h       |  3 +--
 drivers/pci/vpd.c       | 46 ++++++++++++++---------------------------
 3 files changed, 18 insertions(+), 46 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index c469d9cad0a8..501d120e268b 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1378,12 +1378,6 @@ static const struct attribute_group pci_dev_reset_attr_group = {
 	.is_visible = pci_dev_reset_attr_is_visible,
 };
 
-
-static void pci_create_capabilities_sysfs(struct pci_dev *dev)
-{
-	pcie_vpd_create_sysfs_dev_files(dev);
-}
-
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	int retval;
@@ -1395,18 +1389,11 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 	if (retval)
 		return retval;
 
-	/* add sysfs entries for various capabilities */
-	pci_create_capabilities_sysfs(pdev);
 	pci_create_firmware_label_files(pdev);
 
 	return 0;
 }
 
-static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
-{
-	pcie_vpd_remove_sysfs_dev_files(dev);
-}
-
 /**
  * pci_remove_sysfs_dev_files - cleanup PCI specific sysfs files
  * @pdev: device whose entries we should free
@@ -1418,7 +1405,6 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 	if (!sysfs_initialized)
 		return;
 
-	pci_remove_capabilities_sysfs(pdev);
 	pci_remove_resource_files(pdev);
 	pci_remove_firmware_label_files(pdev);
 }
@@ -1514,6 +1500,7 @@ const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_config_attr_group,
 	&pci_dev_rom_attr_group,
 	&pci_dev_reset_attr_group,
+	&vpd_attr_group,
 	NULL,
 };
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ef7c4661314f..0dc52e60d03c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -143,8 +143,7 @@ static inline bool pcie_downstream_port(const struct pci_dev *dev)
 
 int pci_vpd_init(struct pci_dev *dev);
 void pci_vpd_release(struct pci_dev *dev);
-void pcie_vpd_create_sysfs_dev_files(struct pci_dev *dev);
-void pcie_vpd_remove_sysfs_dev_files(struct pci_dev *dev);
+extern const struct attribute_group vpd_attr_group;
 
 /* PCI Virtual Channel */
 int pci_save_vc_state(struct pci_dev *dev);
diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 7915d10f9aa1..3707671bc2f1 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -21,7 +21,6 @@ struct pci_vpd_ops {
 
 struct pci_vpd {
 	const struct pci_vpd_ops *ops;
-	struct bin_attribute *attr;	/* Descriptor for sysfs VPD entry */
 	struct mutex	lock;
 	unsigned int	len;
 	u16		flag;
@@ -428,41 +427,28 @@ static ssize_t write_vpd_attr(struct file *filp, struct kobject *kobj,
 
 	return pci_write_vpd(dev, off, count, buf);
 }
+static BIN_ATTR(vpd, 0600, read_vpd_attr, write_vpd_attr, 0);
 
-void pcie_vpd_create_sysfs_dev_files(struct pci_dev *dev)
-{
-	int retval;
-	struct bin_attribute *attr;
-
-	if (!dev->vpd)
-		return;
+static struct bin_attribute *vpd_attrs[] = {
+	&bin_attr_vpd,
+	NULL,
+};
 
-	attr = kzalloc(sizeof(*attr), GFP_ATOMIC);
-	if (!attr)
-		return;
+static umode_t vpd_attr_is_visible(struct kobject *kobj,
+				   struct bin_attribute *a, int n)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
-	sysfs_bin_attr_init(attr);
-	attr->size = 0;
-	attr->attr.name = "vpd";
-	attr->attr.mode = S_IRUSR | S_IWUSR;
-	attr->read = read_vpd_attr;
-	attr->write = write_vpd_attr;
-	retval = sysfs_create_bin_file(&dev->dev.kobj, attr);
-	if (retval) {
-		kfree(attr);
-		return;
-	}
+	if (!pdev->vpd)
+		return 0;
 
-	dev->vpd->attr = attr;
+	return a->attr.mode;
 }
 
-void pcie_vpd_remove_sysfs_dev_files(struct pci_dev *dev)
-{
-	if (dev->vpd && dev->vpd->attr) {
-		sysfs_remove_bin_file(&dev->dev.kobj, dev->vpd->attr);
-		kfree(dev->vpd->attr);
-	}
-}
+const struct attribute_group vpd_attr_group = {
+	.bin_attrs = vpd_attrs,
+	.is_bin_visible = vpd_attr_is_visible,
+};
 
 int pci_vpd_find_tag(const u8 *buf, unsigned int off, unsigned int len, u8 rdt)
 {
-- 
2.31.0

