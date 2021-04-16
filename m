Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212033629CF
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244245AbhDPU72 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:59:28 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:42918 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244287AbhDPU70 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 16:59:26 -0400
Received: by mail-ed1-f42.google.com with SMTP id d21so13717923edv.9
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 13:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GfONP6K8RDBHL1QgHrnC3J9ZMGcg9Jlord5rI4F6ZB8=;
        b=GNzMy3eroSIJQvwLEdUeWNIPuVHTHHnR3f3pS8gTnSZZKnWNdFSkbMql+n65XLqIwS
         Or4pRwENqZe1xuwViaLgiR/vutaWESh2tBISsUX1AeH8Scu9AWAozTXN8MIzIyS0lUhc
         D92VAOb7GDIQpvgFaut7h8JO4c2rJjM9raAG30Z1Iv9HAB6Nllq9qgdI6//LdlV39vJw
         1k/NPX+zIDDCpjF5OfUnJPkyXPN79mWaF2U9THCB0d5H3TJJfweRR5ceghsToyMxn0Kb
         wXYBTtytYZoxZJpn1Wg1+gId4vg/8jSeiKl1Lsl26PjvJbg3GRxcQ64/cf7SdSrQI+Lo
         U5nA==
X-Gm-Message-State: AOAM53041UfoAXk+T9jbkG05PqA+TM/hGQmqXhbTs0qJ2zGRyhRdDa1p
        e8YpiWQtZfS6v0drUN3/OOE=
X-Google-Smtp-Source: ABdhPJxxToO5ngxNP860ld5HXeJk7n59ZjptozTNcha06u25Aw4JdMdWzTlKjGBDWVqzm4D7/kxkmA==
X-Received: by 2002:a05:6402:40c9:: with SMTP id z9mr12385865edb.24.1618606740845;
        Fri, 16 Apr 2021 13:59:00 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm5103864ejg.43.2021.04.16.13.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:59:00 -0700 (PDT)
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
Subject: [PATCH 03/20] PCI: Convert dynamic "reset" sysfs object into static
Date:   Fri, 16 Apr 2021 20:58:39 +0000
Message-Id: <20210416205856.3234481-4-kw@linux.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210416205856.3234481-1-kw@linux.com>
References: <20210416205856.3234481-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The "reset" sysfs object, which is a write-only attribute, resides at
the "/sys/bus/pci/devices/.../reset" path and allows for resetting the
PCI function of a device if the device supports resetting a single
function.

At the moment, the static "reset" sysfs object is dynamically created
when the pci_create_capabilities_sysfs() function executes that is part
of the PCI sysfs objects initialisation and when a device is added:

  late_initcall()
    pci_sysfs_init()
      pci_create_sysfs_dev_files()
        pci_create_capabilities_sysfs()
          device_create_file()

  pci_bus_add_devices()
    pci_bus_add_device()
      pci_create_sysfs_dev_files()
        ...

And dynamically removed when the pci_remove_capabilities_sysfs()
function executes when the PCI device is stopped and removed:

  pci_stop_bus_device()
    pci_stop_dev()
      pci_remove_sysfs_dev_files()
        pci_remove_capabilities_sysfs()
          device_remove_file()

This attribute does not need to be created dynamically and removed
dynamically, and thus there is no need to also manage its create and
remove life cycle manually as the PCI driver core can do it when the
device is either added or removed.

Convert the "reset" sysfs object created dynamically to static and use
the .is_visible callback to check whether the device has a reset
function capability and to decide if the sysfs object should be made
available.

Then, add a newly created attribute group to the existing group called
"pci_dev_groups" to ensure that the "reset" sysfs object would be
automatically included when the PCI driver initialises.

Move to disable the "reset_fn" flag, and thus disabling the reset
function capability of a device, to the pci_stop_dev() function from the
pci_remove_capabilities_sysfs() function, as it makes more sense to
disable the flag when the device is about to be stopped, rather than
where sysfs objects are removed.

Suggested-by: Oliver O'Halloran <oohall@gmail.com>
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 51 +++++++++++++++++++----------------------
 drivers/pci/remove.c    |  2 ++
 2 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index fa8373685140..c469d9cad0a8 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1355,25 +1355,33 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 
 	return count;
 }
+static DEVICE_ATTR_WO(reset);
 
-static DEVICE_ATTR(reset, 0200, NULL, reset_store);
+static struct attribute *pci_dev_reset_attrs[] = {
+	&dev_attr_reset.attr,
+	NULL,
+};
 
-static int pci_create_capabilities_sysfs(struct pci_dev *dev)
+static umode_t pci_dev_reset_attr_is_visible(struct kobject *kobj,
+					     struct attribute *a, int n)
 {
-	int retval;
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
-	pcie_vpd_create_sysfs_dev_files(dev);
+	if (!pdev->reset_fn)
+		return 0;
 
-	if (dev->reset_fn) {
-		retval = device_create_file(&dev->dev, &dev_attr_reset);
-		if (retval)
-			goto error;
-	}
-	return 0;
+	return a->mode;
+}
 
-error:
-	pcie_vpd_remove_sysfs_dev_files(dev);
-	return retval;
+static const struct attribute_group pci_dev_reset_attr_group = {
+	.attrs = pci_dev_reset_attrs,
+	.is_visible = pci_dev_reset_attr_is_visible,
+};
+
+
+static void pci_create_capabilities_sysfs(struct pci_dev *dev)
+{
+	pcie_vpd_create_sysfs_dev_files(dev);
 }
 
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
@@ -1385,30 +1393,18 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 
 	retval = pci_create_resource_files(pdev);
 	if (retval)
-		goto err;
+		return retval;
 
 	/* add sysfs entries for various capabilities */
-	retval = pci_create_capabilities_sysfs(pdev);
-	if (retval)
-		goto err_resource_files;
-
+	pci_create_capabilities_sysfs(pdev);
 	pci_create_firmware_label_files(pdev);
 
 	return 0;
-
-err_resource_files:
-	pci_remove_resource_files(pdev);
-err:
-	return retval;
 }
 
 static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
 {
 	pcie_vpd_remove_sysfs_dev_files(dev);
-	if (dev->reset_fn) {
-		device_remove_file(&dev->dev, &dev_attr_reset);
-		dev->reset_fn = 0;
-	}
 }
 
 /**
@@ -1517,6 +1513,7 @@ const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_group,
 	&pci_dev_config_attr_group,
 	&pci_dev_rom_attr_group,
+	&pci_dev_reset_attr_group,
 	NULL,
 };
 
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 95dec03d9f2a..dd12c2fcc7dc 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -19,6 +19,8 @@ static void pci_stop_dev(struct pci_dev *dev)
 	pci_pme_active(dev, false);
 
 	if (pci_dev_is_added(dev)) {
+		dev->reset_fn = 0;
+
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
-- 
2.31.0

