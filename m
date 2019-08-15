Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44DBB8EF80
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2019 17:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbfHOPhP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 11:37:15 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45908 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730458AbfHOPhP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Aug 2019 11:37:15 -0400
Received: by mail-ot1-f68.google.com with SMTP id m24so6717749otp.12;
        Thu, 15 Aug 2019 08:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kQ4S8ur3vr3qxRaUYRW4OdIC5U4PUCHsOB8rxdHjszU=;
        b=lKvcbzvNcFprNMDrjrMo5q0PUO+HiSJnw/zWVdIO2yk8Bb2KZUoAzSDIqkrNR4VF4v
         0HDX4DrPN8ZP6ik8ee1D62FstFBgi0J82mTJYP3gg3ILmWglkXOCKWCQ1zwbizeanSSS
         i0yA4eb2mFfu6lXAQT9NF58PQ0KXGtXDF9+mGWyNdXTJfy11qdBXYV7cSOQAfJpzCGGR
         YLKwCbGbOomGe2/DmHz83Pruz2zD4QWn9UXRAfw3X/BfzyMayY9yuxS1Opw9tGCRbAXy
         YhuUOTfMch17Ar4PSFJxxLU3uR7vyxZEcValQqkWbOxMAvM219lO31SjfC63JcTF0MwV
         brFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kQ4S8ur3vr3qxRaUYRW4OdIC5U4PUCHsOB8rxdHjszU=;
        b=qs/a5Q8MrcWk7VKxlJwbdrG9FIQdMrYttCoB9dX/vms82Kx+oQWOvQSfEOjG4Gqexf
         bRykQSSeLm9oD+I8k5mokjNRXKX0mboQYNb/l2viuujes5MC3Ct8+Q5OpXiulW7nE48P
         NexUz4FSLqvpU4xgCj5iOTpK2g9gCh4cUgvZUkuErTKqvHXvu9/sZ3ykm+W3SekDK6Ji
         nJsQldgmX59XMn0l1CumMK8m5EaLgV9Kxx6+1/znJke4ij5Ruc2Gg9ii5coyRnC1jWJf
         RkE4tSnmZYZOERwqthmyG9MtxMgjD38gLkjfrV4842PFIkSQtxXYndt+rEGPmbQMoCMp
         UrXg==
X-Gm-Message-State: APjAAAUML5AfDYZR17Y27wSXkGJQv6hCKrz5a1BPsH+v7A8xwjCrifFC
        9WctMS+RAxa2aGPBAib8vvk=
X-Google-Smtp-Source: APXvYqy+9XuGeDuc12MROh9tmAPYXQh8Scb1+f+TxPky0uSPDrwMB4F/PLP8J2QifNpcX6fEn4fMeQ==
X-Received: by 2002:a5d:8404:: with SMTP id i4mr6144590ion.146.1565883433992;
        Thu, 15 Aug 2019 08:37:13 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id c18sm1491856iod.19.2019.08.15.08.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 08:37:13 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        bodong@mellanox.com, ddutile@redhat.com,
        gregkh@linuxfoundation.org, skunberg.kelsey@gmail.com
Subject: [PATCH v3 2/4] PCI: sysfs: Change permissions from symbolic to octal
Date:   Thu, 15 Aug 2019 09:33:51 -0600
Message-Id: <20190815153352.86143-3-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813204513.4790-1-skunberg.kelsey@gmail.com>
References: <20190813204513.4790-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Symbolic permissions such as "(S_IWUSR | S_IWGRP)" are not
preferred and octal permissions should be used instead. Change all
symbolic permissions to octal permissions.

Example of old:

"(S_IWUSR | S_IWGRP)"

Example of new:

"0220"

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/pci-sysfs.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 8af7944fdccb..346193ca4826 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -464,7 +464,7 @@ static ssize_t dev_rescan_store(struct device *dev,
 	}
 	return count;
 }
-static DEVICE_ATTR(rescan, (S_IWUSR | S_IWGRP), NULL, dev_rescan_store);
+static DEVICE_ATTR(rescan, 0220, NULL, dev_rescan_store);
 
 static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
@@ -478,7 +478,7 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
 	return count;
 }
-static DEVICE_ATTR_IGNORE_LOCKDEP(remove, (S_IWUSR | S_IWGRP), NULL,
+static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL,
 				  remove_store);
 
 static ssize_t dev_bus_rescan_store(struct device *dev,
@@ -501,7 +501,7 @@ static ssize_t dev_bus_rescan_store(struct device *dev,
 	}
 	return count;
 }
-static DEVICE_ATTR(bus_rescan, (S_IWUSR | S_IWGRP), NULL, dev_bus_rescan_store);
+static DEVICE_ATTR(bus_rescan, 0220, NULL, dev_bus_rescan_store);
 
 #if defined(CONFIG_PM) && defined(CONFIG_ACPI)
 static ssize_t d3cold_allowed_store(struct device *dev,
@@ -685,13 +685,12 @@ static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
 }
 
 static DEVICE_ATTR_RO(sriov_totalvfs);
-static DEVICE_ATTR(sriov_numvfs, (S_IRUGO | S_IWUSR | S_IWGRP),
-				  sriov_numvfs_show, sriov_numvfs_store);
+static DEVICE_ATTR(sriov_numvfs, 0664, sriov_numvfs_show, sriov_numvfs_store);
 static DEVICE_ATTR_RO(sriov_offset);
 static DEVICE_ATTR_RO(sriov_stride);
 static DEVICE_ATTR_RO(sriov_vf_device);
-static DEVICE_ATTR(sriov_drivers_autoprobe, (S_IRUGO | S_IWUSR | S_IWGRP),
-		   sriov_drivers_autoprobe_show, sriov_drivers_autoprobe_store);
+static DEVICE_ATTR(sriov_drivers_autoprobe, 0664, sriov_drivers_autoprobe_show,
+		   sriov_drivers_autoprobe_store);
 #endif /* CONFIG_PCI_IOV */
 
 static ssize_t driver_override_store(struct device *dev,
@@ -1080,7 +1079,7 @@ void pci_create_legacy_files(struct pci_bus *b)
 	sysfs_bin_attr_init(b->legacy_io);
 	b->legacy_io->attr.name = "legacy_io";
 	b->legacy_io->size = 0xffff;
-	b->legacy_io->attr.mode = S_IRUSR | S_IWUSR;
+	b->legacy_io->attr.mode = 0600;
 	b->legacy_io->read = pci_read_legacy_io;
 	b->legacy_io->write = pci_write_legacy_io;
 	b->legacy_io->mmap = pci_mmap_legacy_io;
@@ -1094,7 +1093,7 @@ void pci_create_legacy_files(struct pci_bus *b)
 	sysfs_bin_attr_init(b->legacy_mem);
 	b->legacy_mem->attr.name = "legacy_mem";
 	b->legacy_mem->size = 1024*1024;
-	b->legacy_mem->attr.mode = S_IRUSR | S_IWUSR;
+	b->legacy_mem->attr.mode = 0600;
 	b->legacy_mem->mmap = pci_mmap_legacy_mem;
 	pci_adjust_legacy_attr(b, pci_mmap_mem);
 	error = device_create_bin_file(&b->dev, b->legacy_mem);
@@ -1301,7 +1300,7 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
 		}
 	}
 	res_attr->attr.name = res_attr_name;
-	res_attr->attr.mode = S_IRUSR | S_IWUSR;
+	res_attr->attr.mode = 0600;
 	res_attr->size = pci_resource_len(pdev, num);
 	res_attr->private = (void *)(unsigned long)num;
 	retval = sysfs_create_bin_file(&pdev->dev.kobj, res_attr);
@@ -1414,7 +1413,7 @@ static ssize_t pci_read_rom(struct file *filp, struct kobject *kobj,
 static const struct bin_attribute pci_config_attr = {
 	.attr =	{
 		.name = "config",
-		.mode = S_IRUGO | S_IWUSR,
+		.mode = 0644,
 	},
 	.size = PCI_CFG_SPACE_SIZE,
 	.read = pci_read_config,
@@ -1424,7 +1423,7 @@ static const struct bin_attribute pci_config_attr = {
 static const struct bin_attribute pcie_config_attr = {
 	.attr =	{
 		.name = "config",
-		.mode = S_IRUGO | S_IWUSR,
+		.mode = 0644,
 	},
 	.size = PCI_CFG_SPACE_EXP_SIZE,
 	.read = pci_read_config,
@@ -1506,7 +1505,7 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 		sysfs_bin_attr_init(attr);
 		attr->size = rom_size;
 		attr->attr.name = "rom";
-		attr->attr.mode = S_IRUSR | S_IWUSR;
+		attr->attr.mode = 0600;
 		attr->read = pci_read_rom;
 		attr->write = pci_write_rom;
 		retval = sysfs_create_bin_file(&pdev->dev.kobj, attr);
-- 
2.20.1

