Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FC9389A28
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 01:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhESX4S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 19:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhESX4Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 19:56:16 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585B8C061574;
        Wed, 19 May 2021 16:54:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id e19so11047765pfv.3;
        Wed, 19 May 2021 16:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lJOBwH8PLMV6va8nHZHAu/lGBTZiJMwsNPKzTsCadho=;
        b=shlelyBt1qer5wpAW1LO1ffaKwlZNc+NTVk/TDOT5Veelln89KUemjua0v5IN+I8Pw
         xCJMCWCPYNDdV5YtaCNkkuDKOPBWvdeQwBUfWoBmoOXoqmNfSFMvqcck/wnG+CiklpPa
         2qpUxmNrLT6UqQkG20zR0hhAer7qvJPUKGbQe5zPZyuxLsXASkifoaeXz+qXtWWnpmdx
         Kq6+Vrht1mT6Wij6555fgo659jwoRcJAh70yeO1grR+BBDsp+GmroNpVVFFdRawyStdr
         ABfNXZJDYXwZE38wxiPkr48YWMQLU7NcV8ILOi7RF72IhTAIJOxA4jldzaDmdrf/Vyvm
         O2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lJOBwH8PLMV6va8nHZHAu/lGBTZiJMwsNPKzTsCadho=;
        b=hKaGiJA7EaWs0Ao6+LADli4/aSaqXLFih3EiHwXSJiB2YN/VtL6tzO0Gg1HqVfIDbY
         yY5pebyM3Vpj3MRZuQ8aLcBW5TKpe4BpUNSBrlZPxMVCsjjMFP5VwerMkkAj2II4lCDK
         iaxvfEPl0mbHqEiNTWUI4bobb6K5LlsPWfdvy9zNJie7ugq9SPycxhIaDT9kVLMlKjxP
         IFkcUBVPdepQf6a8pPTEXXZyP19/HErIWO5YA1DPFsbGfSQbaOWuXNNi9x0W96FxFIpW
         aMgSiX5HJ2JdkdxtzO29dPDjLY+D04RMhbRkqSnW2LThyQJwLp74PkQ3c+KGXj1vuf8H
         jRCg==
X-Gm-Message-State: AOAM531HNZziPGq3TjwZMciqkcFsgSXJl6qakCAvTWcYyGCTkPA7zwJq
        rZWP4z9zlSRS0ZZUSeWd8No=
X-Google-Smtp-Source: ABdhPJwBR5UiqxPKh5orhB46cc6OgROEopUdOd9YV2XyQc/FczqPS0T5Ng4oOE16A/l+SwLuucDAKQ==
X-Received: by 2002:aa7:8d5a:0:b029:227:7b07:7d8b with SMTP id s26-20020aa78d5a0000b02902277b077d8bmr1594306pfe.26.1621468495847;
        Wed, 19 May 2021 16:54:55 -0700 (PDT)
Received: from localhost.localdomain ([94.140.8.39])
        by smtp.googlemail.com with ESMTPSA id z12sm397670pfk.45.2021.05.19.16.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 16:54:55 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH RESEND v2 5/7] PCI/sysfs: Allow userspace to query and set device reset mechanism
Date:   Thu, 20 May 2021 05:24:24 +0530
Message-Id: <20210519235426.99728-6-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519235426.99728-1-ameynarkhede03@gmail.com>
References: <20210519235426.99728-1-ameynarkhede03@gmail.com>
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

