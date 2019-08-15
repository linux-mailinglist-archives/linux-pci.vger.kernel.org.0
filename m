Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 875758EF78
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2019 17:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbfHOPhO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 11:37:14 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42576 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730457AbfHOPhO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Aug 2019 11:37:14 -0400
Received: by mail-ot1-f68.google.com with SMTP id j7so6780576ota.9;
        Thu, 15 Aug 2019 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=paJogaN2g7AgODh9piCj/36tY2xkyxkFF55qGn68PeQ=;
        b=q6dQWxOE5D2qxkT8ULjQfFafTOXH74FE3EyuA4jhZHhMS1f7vRBG+hM2CjcCwk05Qh
         rAv+QME/Qj50ER7xYCUaUNSJba2y+cfvRPVyUehx22ANlHg0toRk80oUkjE3VZ1K8acC
         sCMhcSnUCwqQ3/CeuTgSnokiJqNF6eDNjdoamIhglgajqnGpeJ3nBc9xeSYPU8P3oyar
         rGy5F+qxRmK1ID+EH+zg5HE3FHFSLJe0oppIedlmdi17EYheXsnSiPVLYYawXdZwLwGc
         O1TLsji/SbsPAliO8yMelmgpeT3csbixw41+1h1BQHMyQ8/OKTu8tCvsn3uQzb/ekUWY
         6h4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=paJogaN2g7AgODh9piCj/36tY2xkyxkFF55qGn68PeQ=;
        b=oMB0H3E2PsP+xKjRP1s/WHJG6EIxLLpTMOkm/XwutvH73Zidzu7sWEl6Djuf1HyhIF
         MDEmSBFs81MHonkIM1PqjrsrCQRCOJCYjFVXEOIqQtElHMzs7+treAQOC4uPL0R5nnuj
         6CTTiaePTemfWfzKUZMPVmbam7QcAEB5t1ZA5I3G1aZDNtMZ+qjxiDFM7LShaiacYdG6
         exf2GmBp7SdVg+bnvFDrTbnpZTnUETEPYdRRerh9uWZLtktHtQw6tVlhs9g8YSXdmryp
         5ee8NmH74mFZGHae8ys8L1iS8kk1UQILe7q8YZb99fnVyG+r1qJoLNxa4fFUfpZ6qVdY
         pfSA==
X-Gm-Message-State: APjAAAXRgORDPOJlL6i0vXOLywBOqSyFO0+wQCguSydMknYKUUSePNSM
        7Qf+j9sLElAgHZ+oNM38wy0=
X-Google-Smtp-Source: APXvYqxESYSEpXSfVcLhgtuZ5w+iJwJ9dwTJob+NN1meynL+nTTmip6H+sm8t2vP3u/tcOpfyExo8g==
X-Received: by 2002:a6b:3784:: with SMTP id e126mr3758450ioa.8.1565883432600;
        Thu, 15 Aug 2019 08:37:12 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id c18sm1491856iod.19.2019.08.15.08.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 08:37:11 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        bodong@mellanox.com, ddutile@redhat.com,
        gregkh@linuxfoundation.org, skunberg.kelsey@gmail.com
Subject: [PATCH v3 1/4] PCI: sysfs: Define device attributes with DEVICE_ATTR*
Date:   Thu, 15 Aug 2019 09:33:50 -0600
Message-Id: <20190815153352.86143-2-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813204513.4790-1-skunberg.kelsey@gmail.com>
References: <20190813204513.4790-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Defining device attributes should be done through the helper
DEVICE_ATTR_RO(), DEVICE_ATTR_WO(), or similar. Change all instances using
__ATTR* to now use its equivalent DEVICE_ATTR*.

Example of old:

static struct device_attribute dev_name_##_attr=__ATTR_RO(_name);

Example of new:

static DEVICE_ATTR_RO(_name);

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/pci-sysfs.c | 59 +++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 965c72104150..8af7944fdccb 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -464,9 +464,7 @@ static ssize_t dev_rescan_store(struct device *dev,
 	}
 	return count;
 }
-static struct device_attribute dev_rescan_attr = __ATTR(rescan,
-							(S_IWUSR|S_IWGRP),
-							NULL, dev_rescan_store);
+static DEVICE_ATTR(rescan, (S_IWUSR | S_IWGRP), NULL, dev_rescan_store);
 
 static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
@@ -480,9 +478,8 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
 	return count;
 }
-static struct device_attribute dev_remove_attr = __ATTR_IGNORE_LOCKDEP(remove,
-							(S_IWUSR|S_IWGRP),
-							NULL, remove_store);
+static DEVICE_ATTR_IGNORE_LOCKDEP(remove, (S_IWUSR | S_IWGRP), NULL,
+				  remove_store);
 
 static ssize_t dev_bus_rescan_store(struct device *dev,
 				    struct device_attribute *attr,
@@ -504,7 +501,7 @@ static ssize_t dev_bus_rescan_store(struct device *dev,
 	}
 	return count;
 }
-static DEVICE_ATTR(rescan, (S_IWUSR|S_IWGRP), NULL, dev_bus_rescan_store);
+static DEVICE_ATTR(bus_rescan, (S_IWUSR | S_IWGRP), NULL, dev_bus_rescan_store);
 
 #if defined(CONFIG_PM) && defined(CONFIG_ACPI)
 static ssize_t d3cold_allowed_store(struct device *dev,
@@ -687,16 +684,14 @@ static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
 	return count;
 }
 
-static struct device_attribute sriov_totalvfs_attr = __ATTR_RO(sriov_totalvfs);
-static struct device_attribute sriov_numvfs_attr =
-		__ATTR(sriov_numvfs, (S_IRUGO|S_IWUSR|S_IWGRP),
-		       sriov_numvfs_show, sriov_numvfs_store);
-static struct device_attribute sriov_offset_attr = __ATTR_RO(sriov_offset);
-static struct device_attribute sriov_stride_attr = __ATTR_RO(sriov_stride);
-static struct device_attribute sriov_vf_device_attr = __ATTR_RO(sriov_vf_device);
-static struct device_attribute sriov_drivers_autoprobe_attr =
-		__ATTR(sriov_drivers_autoprobe, (S_IRUGO|S_IWUSR|S_IWGRP),
-		       sriov_drivers_autoprobe_show, sriov_drivers_autoprobe_store);
+static DEVICE_ATTR_RO(sriov_totalvfs);
+static DEVICE_ATTR(sriov_numvfs, (S_IRUGO | S_IWUSR | S_IWGRP),
+				  sriov_numvfs_show, sriov_numvfs_store);
+static DEVICE_ATTR_RO(sriov_offset);
+static DEVICE_ATTR_RO(sriov_stride);
+static DEVICE_ATTR_RO(sriov_vf_device);
+static DEVICE_ATTR(sriov_drivers_autoprobe, (S_IRUGO | S_IWUSR | S_IWGRP),
+		   sriov_drivers_autoprobe_show, sriov_drivers_autoprobe_store);
 #endif /* CONFIG_PCI_IOV */
 
 static ssize_t driver_override_store(struct device *dev,
@@ -792,7 +787,7 @@ static struct attribute *pcie_dev_attrs[] = {
 };
 
 static struct attribute *pcibus_attrs[] = {
-	&dev_attr_rescan.attr,
+	&dev_attr_bus_rescan.attr,
 	&dev_attr_cpuaffinity.attr,
 	&dev_attr_cpulistaffinity.attr,
 	NULL,
@@ -820,7 +815,7 @@ static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
 		!!(pdev->resource[PCI_ROM_RESOURCE].flags &
 		   IORESOURCE_ROM_SHADOW));
 }
-static struct device_attribute vga_attr = __ATTR_RO(boot_vga);
+static DEVICE_ATTR_RO(boot_vga);
 
 static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
 			       struct bin_attribute *bin_attr, char *buf,
@@ -1458,7 +1453,7 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static struct device_attribute reset_attr = __ATTR(reset, 0200, NULL, reset_store);
+static DEVICE_ATTR(reset, 0200, NULL, reset_store);
 
 static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 {
@@ -1468,7 +1463,7 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 	pcie_aspm_create_sysfs_dev_files(dev);
 
 	if (dev->reset_fn) {
-		retval = device_create_file(&dev->dev, &reset_attr);
+		retval = device_create_file(&dev->dev, &dev_attr_reset);
 		if (retval)
 			goto error;
 	}
@@ -1553,7 +1548,7 @@ static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
 	pcie_vpd_remove_sysfs_dev_files(dev);
 	pcie_aspm_remove_sysfs_dev_files(dev);
 	if (dev->reset_fn) {
-		device_remove_file(&dev->dev, &reset_attr);
+		device_remove_file(&dev->dev, &dev_attr_reset);
 		dev->reset_fn = 0;
 	}
 }
@@ -1606,7 +1601,7 @@ static int __init pci_sysfs_init(void)
 late_initcall(pci_sysfs_init);
 
 static struct attribute *pci_dev_dev_attrs[] = {
-	&vga_attr.attr,
+	&dev_attr_boot_vga.attr,
 	NULL,
 };
 
@@ -1616,7 +1611,7 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	if (a == &vga_attr.attr)
+	if (a == &dev_attr_boot_vga.attr)
 		if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
 			return 0;
 
@@ -1624,8 +1619,8 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
 }
 
 static struct attribute *pci_dev_hp_attrs[] = {
-	&dev_remove_attr.attr,
-	&dev_rescan_attr.attr,
+	&dev_attr_remove.attr,
+	&dev_attr_rescan.attr,
 	NULL,
 };
 
@@ -1699,12 +1694,12 @@ static const struct attribute_group pci_dev_hp_attr_group = {
 
 #ifdef CONFIG_PCI_IOV
 static struct attribute *sriov_dev_attrs[] = {
-	&sriov_totalvfs_attr.attr,
-	&sriov_numvfs_attr.attr,
-	&sriov_offset_attr.attr,
-	&sriov_stride_attr.attr,
-	&sriov_vf_device_attr.attr,
-	&sriov_drivers_autoprobe_attr.attr,
+	&dev_attr_sriov_totalvfs.attr,
+	&dev_attr_sriov_numvfs.attr,
+	&dev_attr_sriov_offset.attr,
+	&dev_attr_sriov_stride.attr,
+	&dev_attr_sriov_vf_device.attr,
+	&dev_attr_sriov_drivers_autoprobe.attr,
 	NULL,
 };
 
-- 
2.20.1

