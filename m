Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD9A339526
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 18:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhCLRhY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 12:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhCLRgy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Mar 2021 12:36:54 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDE9C061761;
        Fri, 12 Mar 2021 09:36:53 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id lr10-20020a17090b4b8ab02900dd61b95c5eso8813967pjb.4;
        Fri, 12 Mar 2021 09:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zjhsutfaeg2zNXMNMCFjuL9SYJCyEz5Q4XqI1wTv0Ik=;
        b=RF1TURJaNG+GldM5/SQ5joAXkkFNDBuM6+XdowZkvodau/rvsnvyF73wAIafTxZqBO
         8rC+JnPWv17QtUrQTGLCn5KLUGMBbaCI16q2z8FcQyOi38KYGJcUmvLPZpz/dOnb2+RW
         c3/+v1daRTRlp1Ox1h+BdTUvcQmo6Iv1Dr+ifqoiyAzlE4EhPFos6ippfrB8U5D2Rtuz
         I0fgFtnbj0JB0mkreB86chsonVUecAX97iELeurqJxxfzgRBtgPUQLS+GBqQnBS4e3g3
         ZvQKSejG9CkqckJb6TieLKtyZshMR7rjLwpTIs3YUqMxQTTXnnNH82TAbPDCno1IsKA/
         Pybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zjhsutfaeg2zNXMNMCFjuL9SYJCyEz5Q4XqI1wTv0Ik=;
        b=tyNOzVNOkLeD0HjB0A8zDsnbdAiLmVX6hQU0Zm4LGrhEiaNVfAZ2ag8jQBqGCf4not
         YN/ny77HI/yJldm4X6bGibUDhoNOJF/020YyL5qBnf2OQSm8whuarGYghPEdYcgZi+KU
         XIivJ2J3s9H8YIWCWL1RF3bKBXsppWUdQZzSk6C0gYDTVUTB2Tbs8nbyR9BhKuBraZ/Y
         Svk4Y3Yuvr0lOAdpEOwPq/emzX3FAdopptTs5MiJnhEq2/AHZqH+oDUeNzfgEUxA2V+T
         wOigJKxq667im9zbd0yPkbXMcU+XuXeVSAgmfeuPgDSn/iCWBWBdyt0OBfEzmRgo6voi
         KYzA==
X-Gm-Message-State: AOAM533euhx0kCk7KG86tWKIlHqq4FKZXcNW8pWTwSprdTCICW4eRh9G
        RRfKu/ts5uEfmvtK34HBvuE=
X-Google-Smtp-Source: ABdhPJxTH/NXED/lfZqHjFsm4/PGtY8ZKPZbRVS/szN/fl0IfyyToFyhfbcnYUS3XB1iCAI5DPxfKg==
X-Received: by 2002:a17:902:7444:b029:e4:30bf:8184 with SMTP id e4-20020a1709027444b02900e430bf8184mr115558plt.45.1615570613463;
        Fri, 12 Mar 2021 09:36:53 -0800 (PST)
Received: from localhost.localdomain ([103.248.31.144])
        by smtp.googlemail.com with ESMTPSA id l10sm180045pfc.125.2021.03.12.09.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 09:36:53 -0800 (PST)
From:   ameynarkhede03@gmail.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device reset mechanism
Date:   Fri, 12 Mar 2021 23:04:52 +0530
Message-Id: <20210312173452.3855-5-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210312173452.3855-1-ameynarkhede03@gmail.com>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Amey Narkhede <ameynarkhede03@gmail.com>

Add reset_methods_enabled bitmap to struct pci_dev to
keep track of user preferred device reset mechanisms.
Add reset_method sysfs attribute to query and set
user preferred device reset mechanisms.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

 Documentation/ABI/testing/sysfs-bus-pci | 15 ++++++
 drivers/pci/pci-sysfs.c                 | 66 +++++++++++++++++++++++--
 drivers/pci/pci.c                       |  3 +-
 include/linux/pci.h                     |  2 +
 4 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 25c9c3977..ae53ecd2e 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -121,6 +121,21 @@ Description:
 		child buses, and re-discover devices removed earlier
 		from this part of the device tree.

+What:		/sys/bus/pci/devices/.../reset_method
+Date:		March 2021
+Contact:	Amey Narkhede <ameynarkhede03@gmail.com>
+Description:
+		Some devices allow an individual function to be reset
+		without affecting other functions in the same slot.
+		For devices that have this support, a file named reset_method
+		will be present in sysfs. Reading this file will give names
+		of the device supported reset methods. Currently used methods
+		are enclosed in brackets. Writing the name of any of the device
+		supported reset method to this file will set the reset method to
+		be used when resetting the device. Writing "none" to this file
+		will disable ability to reset the device and writing "default"
+		will return to the original value.
+
 What:		/sys/bus/pci/devices/.../reset
 Date:		July 2009
 Contact:	Michael S. Tsirkin <mst@redhat.com>
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 78d2c130c..3cd06d1c0 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1304,6 +1304,59 @@ static const struct bin_attribute pcie_config_attr = {
 	.write = pci_write_config,
 };

+static ssize_t reset_method_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	const struct pci_reset_fn_method *reset;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	ssize_t len = 0;
+	int i;
+
+	for (i = 0, reset = pci_reset_fn_methods; reset->reset_fn; i++, reset++) {
+		if (pdev->reset_methods_enabled & (1 << i))
+			len += sysfs_emit_at(buf, len, "[%s] ", reset->name);
+		else if (pdev->reset_methods & (1 << i))
+			len += sysfs_emit_at(buf, len, "%s ", reset->name);
+	}
+
+	return len;
+}
+
+static ssize_t reset_method_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	const struct pci_reset_fn_method *reset = pci_reset_fn_methods;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u8 reset_mechanism;
+	int i = 0;
+
+	/* Writing none disables reset */
+	if (sysfs_streq(buf, "none")) {
+		reset_mechanism = 0;
+	} else if (sysfs_streq(buf, "default")) {
+		/* Writing default returns to initial value */
+		reset_mechanism = pdev->reset_methods;
+	} else {
+		reset_mechanism = 0;
+		for (; reset->reset_fn; i++, reset++) {
+			if (sysfs_streq(buf, reset->name)) {
+				reset_mechanism = 1 << i;
+				break;
+			}
+		}
+		if (!reset_mechanism || !(pdev->reset_methods & reset_mechanism))
+			return -EINVAL;
+	}
+
+	pdev->reset_methods_enabled = reset_mechanism;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(reset_method);
+
 static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
@@ -1337,11 +1390,16 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 	if (dev->reset_methods) {
 		retval = device_create_file(&dev->dev, &dev_attr_reset);
 		if (retval)
-			goto error;
+			goto err_reset;
+		retval = device_create_file(&dev->dev, &dev_attr_reset_method);
+		if (retval)
+			goto err_method;
 	}
 	return 0;

-error:
+err_method:
+	device_remove_file(&dev->dev, &dev_attr_reset);
+err_reset:
 	pcie_vpd_remove_sysfs_dev_files(dev);
 	return retval;
 }
@@ -1417,8 +1475,10 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
 {
 	pcie_vpd_remove_sysfs_dev_files(dev);
-	if (dev->reset_methods)
+	if (dev->reset_methods) {
 		device_remove_file(&dev->dev, &dev_attr_reset);
+		device_remove_file(&dev->dev, &dev_attr_reset_method);
+	}
 }

 /**
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b7f6c6588..81cebea56 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5106,7 +5106,7 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 	might_sleep();

 	for (i = 0, reset = pci_reset_fn_methods; reset->reset_fn; i++, reset++) {
-		if (!(dev->reset_methods & (1 << i)))
+		if (!(dev->reset_methods_enabled & (1 << i)))
 			continue;

 		/*
@@ -5153,6 +5153,7 @@ void pci_init_reset_methods(struct pci_dev *dev)
 		else if (rc != -ENOTTY)
 			break;
 	}
+	dev->reset_methods_enabled = dev->reset_methods;
 }

 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a2f003f4e..400f614e0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -335,6 +335,8 @@ struct pci_dev {
 	 * See pci_reset_fn_methods array in pci.c
 	 */
 	u8 __bitwise reset_methods;		/* bitmap for device supported reset capabilities */
+	/* bitmap for user enabled and device supported reset capabilities */
+	u8 __bitwise reset_methods_enabled;
 #ifdef CONFIG_PCIEAER
 	u16		aer_cap;	/* AER capability offset */
 	struct aer_stats *aer_stats;	/* AER stats for this device */
--
2.30.2
