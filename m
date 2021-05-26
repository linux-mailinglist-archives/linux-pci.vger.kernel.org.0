Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DB43914A3
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 12:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbhEZKQQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 06:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhEZKQK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 06:16:10 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B971C06138D;
        Wed, 26 May 2021 03:14:36 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t193so549375pgb.4;
        Wed, 26 May 2021 03:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aAJUBtbuISXdNPNIabDS8u2Tx/aYHP3UeYaoNUzayWA=;
        b=iKcQKgqvh1SMWcT6R7MPfx7UKRKoI4VCwDSW0F2RGVpKKJtuxwnoGvUGcZAFW9NzBY
         hnZZhgaC7c7GPOQjOWHaMvUNil+f4GUmKeCifzGVMxrhfHMZuMc3/hX2VIaUi8Nvyzit
         him3O5G00jnVQOLL6MVjFUJdTo6KeER+Xkt83HXgbZ/6tuRNTYcRBs2Q1Qc1Vj854Cbu
         R++AFTwo9lXiOyoAMwts3GZHZqqgvBLFsilpWIlcpg9B9StRkRJ3Mivenrmhb4TTHBFY
         1X+dpuC51hTAbJ9vLpl7yrdEytvh37xX5z8xTVodba/JZ/5u47TZeCOpyJI3nY5ll02t
         46Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aAJUBtbuISXdNPNIabDS8u2Tx/aYHP3UeYaoNUzayWA=;
        b=WoXytey8D386V30DZhe0kzZucdqJ2p8UX+mYkGORJP+E0Mjsh2zBeDcOkQQkZBjF8t
         eWu4NlBqP8PvDcnJ8pOJl6Xfoj/OYGghRr9OLvNrKSRvkPAzQsQEZ1JGycfnog4UD/2H
         beCjXBDB9cYenmTHJcZTgqPGevdjuGnv7h5Lg8DYjFL2OH68Th+SJwM2S3992GNZLceY
         vOW5qdezD7daRnH7fsttvmOiwe1Md6C6lR/nry+9WQvEG8HkBVOd9DuqG0Q/ltixbpJ9
         zaXv3SukHIRRUlGzZawwZ9m/AZrtgESxtTteHYIcD7VhylmytEt/Tbbw4sRn2SMpEVt/
         D9jw==
X-Gm-Message-State: AOAM531QDk4+oTiqj6lv3hLieU0lojdXB/TTySikqXCPOT4ZSC5kighO
        1wW4Xj70dfSdc/BaOk2Ce+B55PYsDEI=
X-Google-Smtp-Source: ABdhPJySR4TtaMxuncqhehtngdtDcNJbuk5mPqoQHuftyIJk8/AlB8jR5I4IF+M2bt0RuALVD8CHnA==
X-Received: by 2002:a05:6a00:1742:b029:2cc:b1b0:731c with SMTP id j2-20020a056a001742b02902ccb1b0731cmr34521885pfc.15.1622024075995;
        Wed, 26 May 2021 03:14:35 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.164])
        by smtp.googlemail.com with ESMTPSA id c191sm15662614pfc.94.2021.05.26.03.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 03:14:35 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v3 4/7] PCI/sysfs: Allow userspace to query and set device reset mechanism
Date:   Wed, 26 May 2021 15:44:00 +0530
Message-Id: <20210526101403.108721-5-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526101403.108721-1-ameynarkhede03@gmail.com>
References: <20210526101403.108721-1-ameynarkhede03@gmail.com>
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
 drivers/pci/pci-sysfs.c                 | 95 ++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 3 deletions(-)

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
index 388895099..d9f6c6098 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1304,6 +1304,88 @@ static const struct bin_attribute pcie_config_attr = {
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
+	for (prio = PCI_RESET_METHODS_NUM; prio; prio--) {
+		for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
+			if (prio == pdev->reset_methods[i]) {
+				len += sysfs_emit_at(buf, len, "%s%s",
+						     len ? "," : "",
+						     pci_reset_fn_methods[i].name);
+				break;
+			}
+		}
+
+		if (i == PCI_RESET_METHODS_NUM)
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
+	u8 reset_methods[PCI_RESET_METHODS_NUM];
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u8 prio = PCI_RESET_METHODS_NUM;
+	char *name;
+	int i;
+
+	/*
+	 * Initialize reset_method such that 0xff indicates
+	 * supported but not currently enabled reset methods
+	 * as we only use priority values which are within
+	 * the range of PCI_RESET_FN_METHODS array size
+	 */
+	for (i = 0; i < PCI_RESET_METHODS_NUM; i++)
+		reset_methods[i] = pdev->reset_methods[i] ? 0xff : 0;
+
+	if (sysfs_streq(buf, "")) {
+		pci_warn(pdev, "All device reset methods disabled by user");
+		goto set_reset_methods;
+	}
+
+	if (sysfs_streq(buf, "default")) {
+		for (i = 0; i < PCI_RESET_METHODS_NUM; i++)
+			reset_methods[i] = reset_methods[i] ? prio-- : 0;
+		goto set_reset_methods;
+	}
+
+	while ((name = strsep((char **)&buf, ",")) != NULL) {
+		name = strim(name);
+		if (!strlen(name))
+			continue;
+
+		for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
+			if (reset_methods[i] &&
+			    sysfs_streq(name, pci_reset_fn_methods[i].name)) {
+				reset_methods[i] = prio--;
+				break;
+			}
+		}
+		if (i == PCI_RESET_METHODS_NUM)
+			return -EINVAL;
+	}
+
+	if (reset_methods[0] &&
+	    reset_methods[0] != PCI_RESET_METHODS_NUM)
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
@@ -1337,11 +1419,16 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
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
@@ -1417,8 +1504,10 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
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

