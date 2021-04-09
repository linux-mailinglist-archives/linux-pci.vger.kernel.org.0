Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8446835A713
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 21:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbhDITZh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 15:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbhDITZa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Apr 2021 15:25:30 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF65C061763;
        Fri,  9 Apr 2021 12:25:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a4so6664511wrr.2;
        Fri, 09 Apr 2021 12:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lJOBwH8PLMV6va8nHZHAu/lGBTZiJMwsNPKzTsCadho=;
        b=YFeiAQqkzRyLI7KPbrQihpTSznzNqlJw1kxh0MqV7ediPPGoojzm1wAEA1kSiEXdXU
         JZoMDIn6oVAYQH8INKXfOX6c6gS6puekLieBoc1uMGTUV2EqLv0mXwUAoFbsGqKjpTZx
         NwCYNN69C0Pqk5GidET3IIfe3wsrhbghxvY78yGZwwWQ95GIDBGOBYtz1BiEe3kMWIOv
         J+VufKAH86tBlkzcqkORr0myrx0RE+3UGiMriZ8jzKOYStJF1ddB5tU0hJD8pWrSApFN
         fR4jD56DLA5hSP91y1bNAJUNR0YWCn3/a/V8vScaeO0JK5dSWJQ4sexjLsJ1vC/EcYmX
         5K+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lJOBwH8PLMV6va8nHZHAu/lGBTZiJMwsNPKzTsCadho=;
        b=OXIff24Ty09lii/vPGZfwQa86AC32plp4qHB9N9dq8qiKDjDPkErRwD0ZEEO0eOaSV
         AQjcmY0zwgVmKKZMRnEajlFRcv2v2cJHrOJRB5eUURiVSDfaSWqP74qqBpI0/jipMSvD
         kG9gTI3d5LOz8HIrC5l/vkUVQB5Z3dQUm7h5HLBYW34xXsPxm3DsSuqpH/IOoQPANPQl
         Ty3ZJ5ULNg/DI7rg8C0UUz5qZutYupptgDfrlTh4BSWUqIrB+fccv6Qarvt7xcPtWvvy
         JT+2CfLqPHLavLNt6IyF0qSCA3pwQCtb35Ku9X1Xz21L/9B0mZYpV6vkZ5BeAP+mI2vk
         ICuQ==
X-Gm-Message-State: AOAM532XJZF/31CBCLfnS/VAtJmVWfEnJ2YcVgEbCcQkVxQtZbgmOc2S
        Jf9QvntG/62z2h+8om0QTGuCSzoEqpHzmA==
X-Google-Smtp-Source: ABdhPJxdote4h5p5q5ywYLtODBQR4XcGJaybGZxhzoLFFxbMQYCux2/HmBqhju8mE/wpI1QSMY1PwQ==
X-Received: by 2002:adf:ffc3:: with SMTP id x3mr3749501wrs.263.1617996315835;
        Fri, 09 Apr 2021 12:25:15 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.176])
        by smtp.googlemail.com with ESMTPSA id j6sm6618573wru.18.2021.04.09.12.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 12:25:15 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v2 5/5] PCI/sysfs: Allow userspace to query and set device reset mechanism
Date:   Sat, 10 Apr 2021 00:53:24 +0530
Message-Id: <20210409192324.30080-6-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210409192324.30080-1-ameynarkhede03@gmail.com>
References: <20210409192324.30080-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add reset_method sysfs attribute to enable user to
query and set user preferred device reset methods and
their ordering.

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 16 +++++
 drivers/pci/pci-sysfs.c                 | 91 ++++++++++++++++++++++++-
 2 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 25c9c3977..36fba7ebf 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -121,6 +121,22 @@ Description:
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
+		of the device supported reset methods and their ordering.
+		Writing the name or comma separated list of names of any of
+		the device supported reset methods to this file will set the
+		reset methods and their ordering to be used when resetting
+		the device. Writing empty string to this file will disable
+		ability to reset the device and writing "default" will return
+		to the original value.
+
 What:		/sys/bus/pci/devices/.../reset
 Date:		July 2009
 Contact:	Michael S. Tsirkin <mst@redhat.com>
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 388895099..cf2f66270 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1304,6 +1304,84 @@ static const struct bin_attribute pcie_config_attr = {
 	.write = pci_write_config,
 };
 
+static ssize_t reset_method_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	ssize_t len = 0;
+	int i, prio;
+
+	for (prio = PCI_RESET_FN_METHODS; prio; prio--) {
+		for (i = 0; i < PCI_RESET_FN_METHODS; i++) {
+			if (prio == pdev->reset_methods[i]) {
+				len += sysfs_emit_at(buf, len, "%s%s",
+						     len ? "," : "",
+						     pci_reset_fn_methods[i].name);
+				break;
+			}
+		}
+
+		if (i == PCI_RESET_FN_METHODS)
+			break;
+	}
+
+	return len;
+}
+
+static ssize_t reset_method_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	u8 reset_methods[PCI_RESET_FN_METHODS];
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u8 prio = PCI_RESET_FN_METHODS;
+	char *name;
+	int i;
+
+	/*
+	 * Initialize reset_method such that 0xff indicates
+	 * supported but not currently enabled reset methods
+	 * as we only use priority values which are within
+	 * the range of PCI_RESET_FN_METHODS array size
+	 */
+	for (i = 0; i < PCI_RESET_FN_METHODS; i++)
+		reset_methods[i] = pdev->reset_methods[i] ? 0xff : 0;
+
+	if (sysfs_streq(buf, "")) {
+		pci_warn(pdev, "All device reset methods disabled by user");
+		goto set_reset_methods;
+	}
+
+	if (sysfs_streq(buf, "default")) {
+		for (i = 0; i < PCI_RESET_FN_METHODS; i++)
+			reset_methods[i] = reset_methods[i] ? prio-- : 0;
+		goto set_reset_methods;
+	}
+
+	while ((name = strsep((char **)&buf, ",")) != NULL) {
+		for (i = 0; i < PCI_RESET_FN_METHODS; i++) {
+			if (reset_methods[i] &&
+			    sysfs_streq(name, pci_reset_fn_methods[i].name)) {
+				reset_methods[i] = prio--;
+				break;
+			}
+		}
+		if (i == PCI_RESET_FN_METHODS)
+			return -EINVAL;
+	}
+
+	if (reset_methods[0] &&
+	    reset_methods[0] != PCI_RESET_FN_METHODS)
+		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user");
+
+set_reset_methods:
+	memcpy(pdev->reset_methods, reset_methods, sizeof(reset_methods));
+	return count;
+}
+
+static DEVICE_ATTR_RW(reset_method);
+
 static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
@@ -1337,11 +1415,16 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 	if (pci_reset_supported(dev)) {
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
@@ -1417,8 +1500,10 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
 {
 	pcie_vpd_remove_sysfs_dev_files(dev);
-	if (pci_reset_supported(dev))
+	if (pci_reset_supported(dev)) {
 		device_remove_file(&dev->dev, &dev_attr_reset);
+		device_remove_file(&dev->dev, &dev_attr_reset_method);
+	}
 }
 
 /**
-- 
2.31.1

