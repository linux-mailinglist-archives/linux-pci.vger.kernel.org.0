Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89273629CE
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244438AbhDPU71 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:59:27 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:36380 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244245AbhDPU7Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 16:59:25 -0400
Received: by mail-ej1-f52.google.com with SMTP id r9so44003144ejj.3
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 13:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ySAfFGrSk2CnpJnaNlZ6qM0Yy8d5ZV25TZSLynyZ05U=;
        b=cfqyAPEJX9EvG6x6uaZvppJAI9dJqTkZn9IWuaH3L8BMCJoOcxBBlTSweEqcPg1cGE
         6fxRnvRIZZK+87dENE4/8N0LhsvUXUI3wKrq+CWlWgWWPF8Mk7h4fqXXXS9VRZ6NARV1
         V2xTZ1A/S2j//zezVLcqHV/2Dv9zPHVGlKK2OIPxyUdZxeYk5NIhDFhiIBEps5g39buu
         twgIdj4S8V/p7yntGAfpEJU5XYGE4xolTENpe0/UBN41+aoyT2QJWE0yCfHWLrOJKZyG
         iUtirK9Mt5glbDmy8uB+nISG9E4/gl4r7TbTr1JLCBN1l0aeWYlaWZkqZXe15PUPOXtX
         0EIg==
X-Gm-Message-State: AOAM530kF9uGAgnCqau2EzZKhKvffIqtC6/j3XVbaC3HNz7r2q4EWydl
        ScvwlO79qqyMBj4QZ+8bWPo=
X-Google-Smtp-Source: ABdhPJy3kKQ/5DJa9fJaYnlt6bjnqijuCBdieQzWps3E5fLrX9XASMsMPdDgKLTPD90Z3aCzYaADwA==
X-Received: by 2002:a17:906:6d50:: with SMTP id a16mr4090016ejt.31.1618606739897;
        Fri, 16 Apr 2021 13:58:59 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm5103864ejg.43.2021.04.16.13.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:58:59 -0700 (PDT)
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
Subject: [PATCH 02/20] PCI: Convert dynamic "rom" sysfs object into static
Date:   Fri, 16 Apr 2021 20:58:38 +0000
Message-Id: <20210416205856.3234481-3-kw@linux.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210416205856.3234481-1-kw@linux.com>
References: <20210416205856.3234481-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The "rom" sysfs object, which is a read-only binary attribute, resides
at the "/sys/bus/pci/devices/.../rom" path and allows for accessing the
PCI ROM if the device has one.

At the moment, the "rom" sysfs object is dynamically created when the
pci_create_sysfs_dev_files() function executes that is part of the PCI
sysfs objects initialisation and when a device is added:

  late_initcall()
    pci_sysfs_init()
      pci_create_sysfs_dev_files()
        sysfs_bin_attr_init()
        sysfs_create_bin_file()

  pci_bus_add_devices()
    pci_bus_add_device()
      pci_create_sysfs_dev_files()
        ...

And dynamically removed when the pci_remove_sysfs_dev_files() function
executes when the PCI device is stopped and removed, as per:

  pci_stop_bus_device()
    pci_stop_dev()
      pci_remove_sysfs_dev_files()
        sysfs_remove_bin_file()

This attribute does not need to be created dynamically and removed
dynamically, and thus there is no need to also manage its create and
remove life cycle manually as the PCI driver core can do it when the
device is either added or removed.

Convert the "rom" sysfs object created dynamically to static and use the
.is_bin_visible callback to set the correct sysfs object size based on
the PCI ROM size.

Then, add a newly created attribute group to the existing group called
"pci_dev_groups" to ensure that the "rom" sysfs object would be
automatically included when the PCI driver initializes.

Remove the no longer needed pointer "rom_attr" from the struct pci_dev
that used to hold a reference to the dynamically created "rom" sysfs
object.

Suggested-by: Oliver O'Halloran <oohall@gmail.com>
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 67 ++++++++++++++++++-----------------------
 include/linux/pci.h     |  1 -
 2 files changed, 29 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index dc14daf404f5..fa8373685140 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1306,6 +1306,33 @@ static ssize_t pci_read_rom(struct file *filp, struct kobject *kobj,
 
 	return count;
 }
+static BIN_ATTR(rom, 0600, pci_read_rom, pci_write_rom, 0);
+
+static struct bin_attribute *pci_dev_rom_attrs[] = {
+	&bin_attr_rom,
+	NULL,
+};
+
+static umode_t pci_dev_rom_attr_is_visible(struct kobject *kobj,
+					   struct bin_attribute *a, int n)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	size_t rom_size;
+
+	/* If the device has a ROM, try to expose it in sysfs. */
+	rom_size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
+	if (!rom_size)
+		return 0;
+
+	a->size = rom_size;
+
+	return a->attr.mode;
+}
+
+static const struct attribute_group pci_dev_rom_attr_group = {
+	.bin_attrs = pci_dev_rom_attrs,
+	.is_bin_visible = pci_dev_rom_attr_is_visible,
+};
 
 static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
@@ -1352,8 +1379,6 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	int retval;
-	int rom_size;
-	struct bin_attribute *attr;
 
 	if (!sysfs_initialized)
 		return -EACCES;
@@ -1362,43 +1387,15 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 	if (retval)
 		goto err;
 
-	/* If the device has a ROM, try to expose it in sysfs. */
-	rom_size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
-	if (rom_size) {
-		attr = kzalloc(sizeof(*attr), GFP_ATOMIC);
-		if (!attr) {
-			retval = -ENOMEM;
-			goto err_resource_files;
-		}
-		sysfs_bin_attr_init(attr);
-		attr->size = rom_size;
-		attr->attr.name = "rom";
-		attr->attr.mode = 0600;
-		attr->read = pci_read_rom;
-		attr->write = pci_write_rom;
-		retval = sysfs_create_bin_file(&pdev->dev.kobj, attr);
-		if (retval) {
-			kfree(attr);
-			goto err_resource_files;
-		}
-		pdev->rom_attr = attr;
-	}
-
 	/* add sysfs entries for various capabilities */
 	retval = pci_create_capabilities_sysfs(pdev);
 	if (retval)
-		goto err_rom_file;
+		goto err_resource_files;
 
 	pci_create_firmware_label_files(pdev);
 
 	return 0;
 
-err_rom_file:
-	if (pdev->rom_attr) {
-		sysfs_remove_bin_file(&pdev->dev.kobj, pdev->rom_attr);
-		kfree(pdev->rom_attr);
-		pdev->rom_attr = NULL;
-	}
 err_resource_files:
 	pci_remove_resource_files(pdev);
 err:
@@ -1427,13 +1424,6 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 
 	pci_remove_capabilities_sysfs(pdev);
 	pci_remove_resource_files(pdev);
-
-	if (pdev->rom_attr) {
-		sysfs_remove_bin_file(&pdev->dev.kobj, pdev->rom_attr);
-		kfree(pdev->rom_attr);
-		pdev->rom_attr = NULL;
-	}
-
 	pci_remove_firmware_label_files(pdev);
 }
 
@@ -1526,6 +1516,7 @@ static const struct attribute_group pci_dev_group = {
 const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_group,
 	&pci_dev_config_attr_group,
+	&pci_dev_rom_attr_group,
 	NULL,
 };
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 86c799c97b77..45f1fef80b50 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -458,7 +458,6 @@ struct pci_dev {
 
 	u32		saved_config_space[16]; /* Config space saved at suspend time */
 	struct hlist_head saved_cap_space;
-	struct bin_attribute *rom_attr;		/* Attribute descriptor for sysfs ROM entry */
 	int		rom_attr_enabled;	/* Display of ROM attribute enabled? */
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
 	struct bin_attribute *res_attr_wc[DEVICE_COUNT_RESOURCE]; /* sysfs file for WC mapping of resources */
-- 
2.31.0

