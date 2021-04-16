Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569673629CD
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244362AbhDPU7Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:59:25 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:44784 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244287AbhDPU7Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 16:59:24 -0400
Received: by mail-ed1-f46.google.com with SMTP id f8so33828506edd.11
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 13:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IwJd4epxm5V24MvuZj0Uq0t+/qsTh7e7QJtSqD/5M9M=;
        b=Mbd6ujd5OAhjQHWkpoPTtSZ4BI4F1cmzW19rEZNO2rM6R1J89mdemXGaS5tWORc1+Y
         4FPA47ORa6DQiaK2LPpblGpf/bbF6r5nT3Vej6QSFuIllnRojmvLPxohLWd9M9BXft1K
         BfFG0P2rya1ZX2SrPABSxzqeBtb7yZBweA6UkPLDZnkpupiw6R6o5kbvFeboZj7i63gT
         gc817+U39bZWITVnHQvZBOHebKq0CDsPFEwwnHGDx8jcQiGRsRgzeRgyy+bPDhNLqWeb
         EtpPE3ZpNzoeQfyHkccjT5aKS5WwWvihxI4cCoOh8JhXqnO20s3Gsmi7KA8peu8gsMvu
         +3BQ==
X-Gm-Message-State: AOAM530/GWLZ8mJXMgNmWF36uGHyaz0StBzWG+T68nznyJP5tXBJBbUG
        NjMRo2a0FUuGZ+GapKdeXTU=
X-Google-Smtp-Source: ABdhPJzvRd+WEBnOHpBx0ZGOb+mAL+HRhueUDohb36XD15szMDKSzfah37WE5ZAqYdsUGoLxrgypzA==
X-Received: by 2002:a05:6402:cbb:: with SMTP id cn27mr12194009edb.296.1618606738949;
        Fri, 16 Apr 2021 13:58:58 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm5103864ejg.43.2021.04.16.13.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:58:58 -0700 (PDT)
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
Subject: [PATCH 01/20] PCI: Convert dynamic "config" sysfs object into static
Date:   Fri, 16 Apr 2021 20:58:37 +0000
Message-Id: <20210416205856.3234481-2-kw@linux.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210416205856.3234481-1-kw@linux.com>
References: <20210416205856.3234481-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The "config" sysfs object, which is a binary read-and-write attribute,
resides at the "/sys/bus/pci/devices/.../config" path and allows for
accessing either the legacy (PCI and PCI-X Mode 1) or the extended
(PCI-X Mode 2 and PCIe) device PCI configuration space.

At the moment, the static "config" sysfs object is dynamically created
when the pci_create_sysfs_dev_files() function executes that is part of
the PCI sysfs objects initialisation and when a device is added:

  late_initcall()
    pci_sysfs_init()
      pci_create_sysfs_dev_files()
        sysfs_create_bin_file()

  pci_bus_add_devices()
    pci_bus_add_device()
      pci_create_sysfs_dev_files()
        ...

And dynamically removed when the pci_remove_sysfs_dev_files() function
executes when the PCI device is stopped and removed:

  pci_stop_bus_device()
    pci_stop_dev()
      pci_remove_sysfs_dev_files()
        sysfs_remove_bin_file()

This attribute does not need to be created dynamically and removed
dynamically, and thus there is no need to also manage its create and
remove life cycle manually as the PCI driver core can do it when the
device is either added or removed.

Convert the "config" sysfs object created dynamically to static and use
the .is_bin_visible callback to set the correct sysfs object size
(either 256 bytes of 4 KiB) at runtime.

Then, add a newly created attribute group to the existing group called
"pci_dev_groups" to ensure that the "config" sysfs object would be
automatically included when the PCI driver initializes.

Suggested-by: Oliver O'Halloran <oohall@gmail.com>
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 64 ++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index f8afd54ca3e1..dc14daf404f5 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -808,6 +808,29 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 
 	return count;
 }
+static BIN_ATTR(config, 0644, pci_read_config, pci_write_config, 0);
+
+static struct bin_attribute *pci_dev_config_attrs[] = {
+	&bin_attr_config,
+	NULL,
+};
+
+static umode_t pci_dev_config_attr_is_visible(struct kobject *kobj,
+					      struct bin_attribute *a, int n)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	a->size = PCI_CFG_SPACE_SIZE;
+	if (pdev->cfg_size > PCI_CFG_SPACE_SIZE)
+		a->size = PCI_CFG_SPACE_EXP_SIZE;
+
+	return a->attr.mode;
+}
+
+static const struct attribute_group pci_dev_config_attr_group = {
+	.bin_attrs = pci_dev_config_attrs,
+	.is_bin_visible = pci_dev_config_attr_is_visible,
+};
 
 #ifdef HAVE_PCI_LEGACY
 /**
@@ -1284,26 +1307,6 @@ static ssize_t pci_read_rom(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static const struct bin_attribute pci_config_attr = {
-	.attr =	{
-		.name = "config",
-		.mode = 0644,
-	},
-	.size = PCI_CFG_SPACE_SIZE,
-	.read = pci_read_config,
-	.write = pci_write_config,
-};
-
-static const struct bin_attribute pcie_config_attr = {
-	.attr =	{
-		.name = "config",
-		.mode = 0644,
-	},
-	.size = PCI_CFG_SPACE_EXP_SIZE,
-	.read = pci_read_config,
-	.write = pci_write_config,
-};
-
 static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
@@ -1355,16 +1358,9 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 	if (!sysfs_initialized)
 		return -EACCES;
 
-	if (pdev->cfg_size > PCI_CFG_SPACE_SIZE)
-		retval = sysfs_create_bin_file(&pdev->dev.kobj, &pcie_config_attr);
-	else
-		retval = sysfs_create_bin_file(&pdev->dev.kobj, &pci_config_attr);
-	if (retval)
-		goto err;
-
 	retval = pci_create_resource_files(pdev);
 	if (retval)
-		goto err_config_file;
+		goto err;
 
 	/* If the device has a ROM, try to expose it in sysfs. */
 	rom_size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
@@ -1405,11 +1401,6 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 	}
 err_resource_files:
 	pci_remove_resource_files(pdev);
-err_config_file:
-	if (pdev->cfg_size > PCI_CFG_SPACE_SIZE)
-		sysfs_remove_bin_file(&pdev->dev.kobj, &pcie_config_attr);
-	else
-		sysfs_remove_bin_file(&pdev->dev.kobj, &pci_config_attr);
 err:
 	return retval;
 }
@@ -1435,12 +1426,6 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 		return;
 
 	pci_remove_capabilities_sysfs(pdev);
-
-	if (pdev->cfg_size > PCI_CFG_SPACE_SIZE)
-		sysfs_remove_bin_file(&pdev->dev.kobj, &pcie_config_attr);
-	else
-		sysfs_remove_bin_file(&pdev->dev.kobj, &pci_config_attr);
-
 	pci_remove_resource_files(pdev);
 
 	if (pdev->rom_attr) {
@@ -1540,6 +1525,7 @@ static const struct attribute_group pci_dev_group = {
 
 const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_group,
+	&pci_dev_config_attr_group,
 	NULL,
 };
 
-- 
2.31.0

