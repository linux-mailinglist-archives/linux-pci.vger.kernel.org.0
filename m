Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594B3394DE2
	for <lists+linux-pci@lfdr.de>; Sat, 29 May 2021 21:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhE2T12 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 May 2021 15:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhE2T10 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 May 2021 15:27:26 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851D4C061574;
        Sat, 29 May 2021 12:25:48 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p39so5852074pfw.8;
        Sat, 29 May 2021 12:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9MvIdKhfq+0Mdk+szDC0tPoyoxwUROEYUAQaW6Hav6U=;
        b=hwN4ZdnjqDq5XpqauPc1yVGso8hRDB5GFuQuIng3qX4nIdWH71G/9tGKPYD6LZ5omu
         7AWbZUEE8szBScckodxmrcjbKz9O8UOHTBfyveJwSvkPGwMcUdFUVbEEnRc4YlbQvj28
         rhz+1yaC3VJmpIzaEVQe2+LaNzj7polJ4c+nE8Wmv2Kdunpht2gXK9UA0QFbnYRxz0cN
         ABSvZXITZMGo+DgLQBPnJq/zuTFowyYpWh6TTV7+z8wzPgpwKcz7QhaOykVCMfkhePco
         U4sV1WvNce/xvFRyIUuUgelPNxegso0kStdr/MeRQs73VSyq20iFWgxNR/+Oo67IsdSF
         KIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9MvIdKhfq+0Mdk+szDC0tPoyoxwUROEYUAQaW6Hav6U=;
        b=CSM+nz0HTDRYZNXLJvLR+qOur5x6uaDjEn8U8Cu/7zb6m0EvYqDxBAf/wamGMSz65/
         JvsSTffU+R47v+KFLpvlybS/OtRuRwVsnvYEw3RJ3nyfo4497kZAqMbvrSiRD7C57l5p
         ZVICy+sAlV6dufRrXsMhDGKB6gNPTqdDrpeV7B7Yq2oHgLUQGD3gIlU6WDN1y/Gmg+dL
         1wn7NGSiP12lFnBvSz+Y9FiGnUJMzX/EkgggAwruRvG5I+hIFpbExF4dgP1+g4J767Jd
         WcJyK4FQKuzaepmQfXWjChUAdvchpA2uDALVCQoRa9XIFOZFD26qu3OezpU9Shk6dxzg
         MuMQ==
X-Gm-Message-State: AOAM530IUjj2pxPD1fF36nmzOTV5k6kLNE6F4Mh64yU3q6RPvRNeq6dq
        1p477fgxDiYjN3WHX7TUY8o=
X-Google-Smtp-Source: ABdhPJyU22Er6YJCWflyaqNxjxaU6VtBu4ZlxRf/dj7qptIoAL7+HL+sw91s/Kxd3xDWYEkH90uxuw==
X-Received: by 2002:a62:860b:0:b029:28e:d45b:4d2e with SMTP id x11-20020a62860b0000b029028ed45b4d2emr9928353pfd.70.1622316348062;
        Sat, 29 May 2021 12:25:48 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.172])
        by smtp.googlemail.com with ESMTPSA id ge5sm7286754pjb.45.2021.05.29.12.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 12:25:47 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v5 4/7] PCI/sysfs: Allow userspace to query and set device reset mechanism
Date:   Sun, 30 May 2021 00:55:24 +0530
Message-Id: <20210529192527.2708-5-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529192527.2708-1-ameynarkhede03@gmail.com>
References: <20210529192527.2708-1-ameynarkhede03@gmail.com>
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
 Documentation/ABI/testing/sysfs-bus-pci |  16 ++++
 drivers/pci/pci-sysfs.c                 | 105 ++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ef00fada2..cf6dbbb3c 100644
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
index 316f70c3e..04b3d6565 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1334,6 +1334,110 @@ static const struct attribute_group pci_dev_rom_attr_group = {
 	.is_bin_visible = pci_dev_rom_attr_is_visible,
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
+		if (sysfs_streq(name, ""))
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
+static struct attribute *pci_dev_reset_method_attrs[] = {
+	&dev_attr_reset_method.attr,
+	NULL,
+};
+
+static umode_t pci_dev_reset_method_attr_is_visible(struct kobject *kobj,
+						    struct attribute *a, int n)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	if (!pci_reset_supported(pdev))
+		return 0;
+
+	return a->mode;
+}
+
+static const struct attribute_group pci_dev_reset_method_attr_group = {
+	.attrs = pci_dev_reset_method_attrs,
+	.is_visible = pci_dev_reset_method_attr_is_visible,
+};
+
 static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
@@ -1491,6 +1595,7 @@ const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_config_attr_group,
 	&pci_dev_rom_attr_group,
 	&pci_dev_reset_attr_group,
+	&pci_dev_reset_method_attr_group,
 	&pci_dev_vpd_attr_group,
 #ifdef CONFIG_DMI
 	&pci_dev_smbios_attr_group,
-- 
2.31.1

