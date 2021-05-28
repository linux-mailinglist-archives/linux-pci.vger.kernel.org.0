Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842613943D7
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 16:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbhE1OJ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 10:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236564AbhE1OJw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 May 2021 10:09:52 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC3FC061763;
        Fri, 28 May 2021 07:08:17 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u7so1688944plq.4;
        Fri, 28 May 2021 07:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nu1k1tGDq0snirEw7ma5Tb6EEXyl6eSPsLQoQU6sDGs=;
        b=gWBChIjxkhzZ6vyp35//4UkPzaUHFwStUa0JHUxswYe1aI5Z/OzmQNnyxhRaDWfFX3
         BtJpGKwAY3h3XAHfXkDguRD9MGiCUvybQ70JebK58C669mtSa3jUJbAtpAO363UEhA/u
         FFB8QeySX0jRf+Wod/HXRtmQWTr4kI+Q28XvtA8nXsHhLo7/esGowBZRHuAStYe+EcTZ
         54kOBEmz2o4/MbrDwy/XvPeqPZin6wuuUsnxuwVg1IgNaftCrIdD04Jn+ulXVnKp/PJB
         6j2gvQvZx2cbOnRRYFcUGgasehhPBUburHcyffXU43JwbsJpYcAGCteAvWngaVeZoSE0
         B6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nu1k1tGDq0snirEw7ma5Tb6EEXyl6eSPsLQoQU6sDGs=;
        b=QzfB2DRyNIBprL/eE5tKrWZhzxZCECEouui6xAx7a3fslfJ4gfEya0X8geUQmz9rSQ
         aTaC5tyDn4VrZKxoIjtbEpyBmPuW//S1xmamjOx3mRHOVEEbUCsQdeckF6CGdu3miJ8p
         qRDTbbcOdsO/ZR6S296nHudE2IVF5sNJdXXXoPxnW5GBCyzv+yH23169u8Ni0Cr3XVJW
         6yZSCn0lSAt1+++3hDOnSamuwzmjeArkq5EgOHS9hmtq+ESvyFW/fgHlYsSq90X6Lgix
         B/IxK7T28Jt4nnK0nAqXwXW+oLz+Db1TgTuZWSPSsVoFcdfITRnTDErK/MvSpChDSpy4
         rvAA==
X-Gm-Message-State: AOAM533/ckJcjNsTQ7tNsv9QPle/kNetsOxBYIn6j6lfTXPwWhQ+jXgE
        84Xy7gxbcGmO98PXbXRDUB0=
X-Google-Smtp-Source: ABdhPJyT99+g9MUc01FczSveF5/WicBH4THTektQhejGnXcGyCK04CeO0ocXuxBfYV8MA+yGyEf+EQ==
X-Received: by 2002:a17:90a:549:: with SMTP id h9mr4880480pjf.158.1622210897339;
        Fri, 28 May 2021 07:08:17 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.164])
        by smtp.googlemail.com with ESMTPSA id j3sm4607841pfe.98.2021.05.28.07.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 07:08:17 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v4 4/7] PCI/sysfs: Allow userspace to query and set device reset mechanism
Date:   Fri, 28 May 2021 19:37:52 +0530
Message-Id: <20210528140755.7044-5-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528140755.7044-1-ameynarkhede03@gmail.com>
References: <20210528140755.7044-1-ameynarkhede03@gmail.com>
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
 drivers/pci/pci-sysfs.c                 | 96 ++++++++++++++++++++++++-
 2 files changed, 109 insertions(+), 3 deletions(-)

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
index 388895099..1c715b262 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1304,6 +1304,89 @@ static const struct bin_attribute pcie_config_attr = {
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
+		if (!strlen(name))
+			continue;
+
+		name = strim(name);
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
@@ -1337,11 +1420,16 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
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
@@ -1417,8 +1505,10 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
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

