Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC1C68C26B
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 22:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfHMU5v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 16:57:51 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35151 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfHMU5u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Aug 2019 16:57:50 -0400
Received: by mail-ot1-f66.google.com with SMTP id g17so26356029otl.2;
        Tue, 13 Aug 2019 13:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kQ4S8ur3vr3qxRaUYRW4OdIC5U4PUCHsOB8rxdHjszU=;
        b=ttM8Kp95EuDtIAWXlf3xqLFiOaXH7gSbYbjFo1T/D4YKvwTljcSr74NzwdoxeOC3sy
         8ylTJGmlOJl+3K4rRMCEtyVdnLA60+9iu9vv7idnmh5CGOuF7usSZxaKvQPm7kLFRSL7
         8JWudKmKR25fHWlsbFBHSSim8tQ4Sbg8Uhu35uqy5MR+H6wHOlzwmsb764RUsP+ZcJOI
         WfnR5hudksQsgwcLejcEmXSP/Yk11NNJxaa5/9PVkHe0ngjRRsL8g4cyw8dtT6CuIl64
         eRd0ega3Vu+kwLyq/f3SNvbZ5Hpuz64anVsH3VwArvtLFzAlqKTdOLu/KCNkofJ6Q6LT
         zTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kQ4S8ur3vr3qxRaUYRW4OdIC5U4PUCHsOB8rxdHjszU=;
        b=LXcNqvbgyjh5zngYnGfuGebiyU18ITlVJAT3WwBq093iHfZLpvolK3wCKvbiMdUuhq
         XYP/+3Zu2KhqlWrGnT8+YI5g5e8fD3iAI3jaiPqS6WGn8J0hKQqRYZiG2MkrD2VlCYrV
         IXkvm2biyTYl06XNIG8NA+zCmQkL9D0oqLZKkuj8a0oKV6JUPj8U+ctkRAk0cG1uKPnV
         x1d9zCtCu5lzpR4BSoDtEmSzsltQvczBhAe8D9L2FxkflBkp+Dq7Cp3hsiyfNsVWqlrp
         p5oIjDOwD9j1v8D7DXOPGZfIgbtfy75x2HXOfKnHByTj3KQ73oXogjK6tW/FZmo1JFLk
         E/Pg==
X-Gm-Message-State: APjAAAUnlzoQfqMdaK864UWdfv8+BEVYFPe/ZypuyZaDrNWN/zDiWC/i
        mjV0q7nniV7cbRzxEBZ1jj8=
X-Google-Smtp-Source: APXvYqyp/do8l8Qi2cUlSBDAMT8XEpHD0RHVThXpZTJXZ4F87Ui89Tqr+e6VgkKCS4Ys8+CB9YRFOw==
X-Received: by 2002:a6b:3c0a:: with SMTP id k10mr28059480iob.271.1565729870079;
        Tue, 13 Aug 2019 13:57:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id y25sm12874419iol.59.2019.08.13.13.57.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 13:57:49 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skunberg.kelsey@gmail.com
Subject: [PATCH v2 2/3] PCI: sysfs: Change permissions from symbolic to octal
Date:   Tue, 13 Aug 2019 14:45:12 -0600
Message-Id: <20190813204513.4790-3-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813204513.4790-1-skunberg.kelsey@gmail.com>
References: <20190809195721.34237-1-skunberg.kelsey@gmail.com>
 <20190813204513.4790-1-skunberg.kelsey@gmail.com>
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

