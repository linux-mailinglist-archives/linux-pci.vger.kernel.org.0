Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699FC3629D3
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbhDPU7c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:59:32 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:45720 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343620AbhDPU7a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 16:59:30 -0400
Received: by mail-ej1-f45.google.com with SMTP id sd23so35350244ejb.12
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 13:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z2TcPPTUR1JDJUVX5/dAzIrKyjR/9xMdAu1o7StmrtM=;
        b=ZpIQbGUwMQSEnkWPv3jChUVhEjP4vzuzCki8J6pVJgzh6kmIfwAkaVEgi2iAxEP9/b
         So0YUwGDfXVCjIt9E+UYWaJUhWOUpDBOAYXbiBwC8Z7s4JSF/MVnfte8whGvYeV0C5nf
         /bQbs91w1e3K0+hY+7Cus/rqzIy3aXwIhzfaPh4Ohz6tbDPKM8lsZINyvlT6Mnp4Ma2Z
         vUxMBwFMJRkJriANBRAJE9PdzfkhL3aH7r1xLotfx3qf73GL+yjJPurugcCK7EFT9FKf
         2UjiGxtUA79aACOrJ/+o5IBrcrlKnIxisIPm+GeaqvMS87v7n3hQ0ZM5iF5xmF8/9dV6
         iMFg==
X-Gm-Message-State: AOAM531jMpMmsEnHsdmv5MbiDNge4Db4XGP7ZJTkBAyPtHkjir5FduJz
        oicI2tEmDeLmKTRDftL3ykI=
X-Google-Smtp-Source: ABdhPJzTB7kg2S4c1K5HXNO0iB0LtElArHPUEk7sgTzDL6f3bT+kjTJu7JSQZlA97TqLIMoWpW/WIg==
X-Received: by 2002:a17:906:5949:: with SMTP id g9mr4626721ejr.356.1618606744704;
        Fri, 16 Apr 2021 13:59:04 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm5103864ejg.43.2021.04.16.13.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:59:04 -0700 (PDT)
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
Subject: [PATCH 07/20] PCI: Convert PCI sysfs objects to use BIN_ATTR_ADMIN_RW macro
Date:   Fri, 16 Apr 2021 20:58:43 +0000
Message-Id: <20210416205856.3234481-8-kw@linux.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210416205856.3234481-1-kw@linux.com>
References: <20210416205856.3234481-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the PCI "config", "rom" and "vpd" sysfs objects that currently use
an open coded BIN_ATTR macro to hide sensitive information that should
only be accessed by the root user to the new BIN_ATTR_ADMIN_RW macro,
and the BIN_ATTR_RW macro where otherwise appropriate.

Rename the "read" and "write" functions so that they are in the format
that is expected when using new macros as these have specific naming
requirements from the accessor functions.

No functional change intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 32 ++++++++++++++++----------------
 drivers/pci/vpd.c       | 14 +++++++-------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6a8a44d44127..07c3ddd7877e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -666,9 +666,9 @@ static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(boot_vga);
 
-static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
-			       struct bin_attribute *bin_attr, char *buf,
-			       loff_t off, size_t count)
+static ssize_t config_read(struct file *filp, struct kobject *kobj,
+			   struct bin_attribute *bin_attr, char *buf,
+			   loff_t off, size_t count)
 {
 	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
 	unsigned int size = 64;
@@ -743,9 +743,9 @@ static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *bin_attr, char *buf,
-				loff_t off, size_t count)
+static ssize_t config_write(struct file *filp, struct kobject *kobj,
+			    struct bin_attribute *bin_attr, char *buf,
+			    loff_t off, size_t count)
 {
 	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
 	unsigned int size = count;
@@ -808,7 +808,7 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 
 	return count;
 }
-static BIN_ATTR(config, 0644, pci_read_config, pci_write_config, 0);
+static BIN_ATTR_RW(config, 0);
 
 static struct bin_attribute *pci_dev_config_attrs[] = {
 	&bin_attr_config,
@@ -1243,7 +1243,7 @@ void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
 #endif
 
 /**
- * pci_write_rom - used to enable access to the PCI ROM display
+ * rom_write - used to enable access to the PCI ROM display
  * @filp: sysfs file
  * @kobj: kernel object handle
  * @bin_attr: struct bin_attribute for this file
@@ -1253,9 +1253,9 @@ void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
  *
  * writing anything except 0 enables it
  */
-static ssize_t pci_write_rom(struct file *filp, struct kobject *kobj,
-			     struct bin_attribute *bin_attr, char *buf,
-			     loff_t off, size_t count)
+static ssize_t rom_write(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *bin_attr, char *buf,
+			 loff_t off, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
@@ -1268,7 +1268,7 @@ static ssize_t pci_write_rom(struct file *filp, struct kobject *kobj,
 }
 
 /**
- * pci_read_rom - read a PCI ROM
+ * rom_read - read a PCI ROM
  * @filp: sysfs file
  * @kobj: kernel object handle
  * @bin_attr: struct bin_attribute for this file
@@ -1279,9 +1279,9 @@ static ssize_t pci_write_rom(struct file *filp, struct kobject *kobj,
  * Put @count bytes starting at @off into @buf from the ROM in the PCI
  * device corresponding to @kobj.
  */
-static ssize_t pci_read_rom(struct file *filp, struct kobject *kobj,
-			    struct bin_attribute *bin_attr, char *buf,
-			    loff_t off, size_t count)
+static ssize_t rom_read(struct file *filp, struct kobject *kobj,
+			struct bin_attribute *bin_attr, char *buf,
+			loff_t off, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 	void __iomem *rom;
@@ -1306,7 +1306,7 @@ static ssize_t pci_read_rom(struct file *filp, struct kobject *kobj,
 
 	return count;
 }
-static BIN_ATTR(rom, 0600, pci_read_rom, pci_write_rom, 0);
+static BIN_ATTR_ADMIN_RW(rom, 0);
 
 static struct bin_attribute *pci_dev_rom_attrs[] = {
 	&bin_attr_rom,
diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 3707671bc2f1..c8efb9ebdfd7 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -396,9 +396,9 @@ void pci_vpd_release(struct pci_dev *dev)
 	kfree(dev->vpd);
 }
 
-static ssize_t read_vpd_attr(struct file *filp, struct kobject *kobj,
-			     struct bin_attribute *bin_attr, char *buf,
-			     loff_t off, size_t count)
+static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
+			struct bin_attribute *bin_attr, char *buf,
+			loff_t off, size_t count)
 {
 	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
 
@@ -412,9 +412,9 @@ static ssize_t read_vpd_attr(struct file *filp, struct kobject *kobj,
 	return pci_read_vpd(dev, off, count, buf);
 }
 
-static ssize_t write_vpd_attr(struct file *filp, struct kobject *kobj,
-			      struct bin_attribute *bin_attr, char *buf,
-			      loff_t off, size_t count)
+static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *bin_attr, char *buf,
+			 loff_t off, size_t count)
 {
 	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
 
@@ -427,7 +427,7 @@ static ssize_t write_vpd_attr(struct file *filp, struct kobject *kobj,
 
 	return pci_write_vpd(dev, off, count, buf);
 }
-static BIN_ATTR(vpd, 0600, read_vpd_attr, write_vpd_attr, 0);
+static BIN_ATTR_ADMIN_RW(vpd, 0);
 
 static struct bin_attribute *vpd_attrs[] = {
 	&bin_attr_vpd,
-- 
2.31.0

