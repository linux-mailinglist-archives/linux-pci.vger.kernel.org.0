Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB28939E673
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 20:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFGSY3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 14:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbhFGSY2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 14:24:28 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B07C061789;
        Mon,  7 Jun 2021 11:22:37 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e20so2540002pgg.0;
        Mon, 07 Jun 2021 11:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2GwU7xVOO3aHdi2ZowTA3j4dg4Dx7tydRNZ94ujj3N0=;
        b=MIjew5yVD0th6cQq/FJP+aarKoKhSpZOm1Qah4059J/tpntR2hNOgmF7HxVrje22at
         l9ufVrRh9X8TmNc3bk5zFG8P7g9Acd5xnpTopJ0lk7w8Rdy8lYdIeEeuLxyQZvN3rPqK
         fzPm8DVCCWXffNDyIb0uORmHygVzBAamqkQmiTuRsdkBxj8bZZV7EBa+pAEjQqDETyJ6
         1X4ypa4Ue3ijxLPi4iaMblnb3OLi+tucUboDVGzIgGMdkFKN7IMZE3d+pcMYzXFQl85j
         F48zPKv7rk3XkLak0Wv43oZ+Dv72CCVHT3DB3oc/1kJC6DBW/BJyI6W6vTs0OlYIF7fx
         lI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2GwU7xVOO3aHdi2ZowTA3j4dg4Dx7tydRNZ94ujj3N0=;
        b=QkRQK4EhGfYlTgsWzP/p/tRUioe1rUhuLQ8ln/Wf6f2Hw4igs0bj4K6J8LmlgDas59
         HdWK/5/3c+yCQER/rSAWOwt50mDbDb7Xa3ENmNOSfBTPY1PnVlATdWjKAGwOZlBDQriA
         6bUr3v8Oj7QZPgQaRyM679K9893YVQhYBLs1IWGgxPr5gTosEFU3UYHttmlaAwfc2HeN
         fwTmH5k1Yoneq+eMcGNMXaV9RbRiMHHYA29nE6MRL4XP8m6su/U5eP1JskVN2QbvbAo9
         /gMjE4lq2MqeSRG+oY8MJBRDRoNmL2sOAKbHM1qa7VFuwbGaWvoyAHEceJ9Gn+YPLOwt
         w7pQ==
X-Gm-Message-State: AOAM530MRk3rmwIjxCd6636/aSYDwvm8hNmk2ZS8RpYpatabbuE2aqfN
        XcLiDUXYmr1HoixROoAhyNQVcEIyBvfugQ==
X-Google-Smtp-Source: ABdhPJxC5P7m1JL/YO3vsYyXTRhcXG5b+o58cWEj43c18k0KVk0MAfK1ZE8CZscsvaTxj2z2VCpfhw==
X-Received: by 2002:a63:404:: with SMTP id 4mr9761593pge.180.1623090156731;
        Mon, 07 Jun 2021 11:22:36 -0700 (PDT)
Received: from localhost.localdomain ([103.200.106.115])
        by smtp.googlemail.com with ESMTPSA id k1sm8687656pfa.30.2021.06.07.11.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 11:22:36 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v6 4/8] PCI/sysfs: Allow userspace to query and set device reset mechanism
Date:   Mon,  7 Jun 2021 23:51:33 +0530
Message-Id: <20210607182137.5794-5-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210607182137.5794-1-ameynarkhede03@gmail.com>
References: <20210607182137.5794-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add reset_method sysfs attribute to enable user to
query and set user preferred device reset methods and
their ordering.

Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |  16 ++++
 drivers/pci/pci-sysfs.c                 | 118 ++++++++++++++++++++++++
 2 files changed, 134 insertions(+)

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
index 316f70c3e..52def79aa 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1334,6 +1334,123 @@ static const struct attribute_group pci_dev_rom_attr_group = {
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
+	if (len)
+		len += sysfs_emit_at(buf, len, "\n");
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
+	char *name, *options;
+	int i;
+
+	if (count >= (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	options = kstrndup(buf, count, GFP_KERNEL);
+	if (!options)
+		return -ENOMEM;
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
+	if (sysfs_streq(options, "")) {
+		pci_warn(pdev, "All device reset methods disabled by user");
+		goto set_reset_methods;
+	}
+
+	if (sysfs_streq(options, "default")) {
+		for (i = 0; i < PCI_RESET_METHODS_NUM; i++)
+			reset_methods[i] = reset_methods[i] ? prio-- : 0;
+		goto set_reset_methods;
+	}
+
+	while ((name = strsep(&options, ",")) != NULL) {
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
+
+		if (i == PCI_RESET_METHODS_NUM) {
+			kfree(options);
+			return -EINVAL;
+		}
+	}
+
+	if (reset_methods[0] &&
+	    reset_methods[0] != PCI_RESET_METHODS_NUM)
+		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user");
+
+set_reset_methods:
+	kfree(options);
+	memcpy(pdev->reset_methods, reset_methods, sizeof(reset_methods));
+	return count;
+}
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
@@ -1491,6 +1608,7 @@ const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_config_attr_group,
 	&pci_dev_rom_attr_group,
 	&pci_dev_reset_attr_group,
+	&pci_dev_reset_method_attr_group,
 	&pci_dev_vpd_attr_group,
 #ifdef CONFIG_DMI
 	&pci_dev_smbios_attr_group,
-- 
2.31.1

