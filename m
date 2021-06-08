Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302AD39EE59
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 07:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhFHFvd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 01:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHFvd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 01:51:33 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2F9C061574;
        Mon,  7 Jun 2021 22:49:26 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u11so20502353oiv.1;
        Mon, 07 Jun 2021 22:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2GwU7xVOO3aHdi2ZowTA3j4dg4Dx7tydRNZ94ujj3N0=;
        b=SAutUqtz+4NRqO7uYwZ+5el2wu14Cw3paIbS7yvlhgtFT6x8jnYfInvAofMUlGEzIE
         v+Pw0Zu9Pepp8qDh25bqkM1l6aCYDmxyOfidJLB8yz33giAh/BNwJCPQDcGTtvEbvtY7
         kZHUcWvbDbPtOp8YleZdi51lr3FOwXIpUEJUPOi1NtiW6wW8EvxxlGHGa/EpJ2Tt3Lfs
         VvdHRzIVfxA6yUuYc936dr0rtpLh2k1tm6ZSl4NA1ctrQf8ZegU1AzhqwWkFiZoW6Fx2
         CxPNom4vRpKX1/vhmn3FbdvC2mendID5OuHhxJ5LgfqzVxpBmcm1amEtX96RmpF8OY+M
         vN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2GwU7xVOO3aHdi2ZowTA3j4dg4Dx7tydRNZ94ujj3N0=;
        b=Je0eFZxKrQZt1CbmaFCia1yrw5z4DTYiYynfoGjmifvjDR2vOgBo03ZEKssxgKKDJM
         FRjn/Cucyj+oOgSs2mNrFTjC0LBPxVitZWsMtze/2PE/C+UT2laXMTRIVdiwl2kRgGuf
         STUgF/KKACmIQAIeb4Wwtgw6sTmNtXblAj/F9DUagV1C2BTP5m8cGLbAYsIxoH4DNFuZ
         i7n919EelH/GHnfTVdI2F/jNWPDeQfIOq4ym6H6oGPdKRY60dZbO42j8pz+dw3IClI6s
         h3ABubmADaIauVevZyx130Wpbwe+byTu3IdhNwRvyV1veB8gIR7Vf8WL+aHpRg2In701
         fN0g==
X-Gm-Message-State: AOAM531CQ5gAXlFsHmhwGROVyl3HUR4/r0iqctV00czBIFobD/LwXSC8
        LODjM/q+UWtOFrTFbmX+dJ8=
X-Google-Smtp-Source: ABdhPJzE6GmpfIvCizhkX04GrJxFqQ/WQ5k95I1/Wy2VH0i5ssw1487H9FKLagxjh/baEe9YsLIEGQ==
X-Received: by 2002:aca:d0a:: with SMTP id 10mr1758233oin.40.1623131365782;
        Mon, 07 Jun 2021 22:49:25 -0700 (PDT)
Received: from localhost.localdomain (static-198-54-128-46.cust.tzulo.com. [198.54.128.46])
        by smtp.googlemail.com with ESMTPSA id o2sm2489730oom.26.2021.06.07.22.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 22:49:25 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v7 4/8] PCI/sysfs: Allow userspace to query and set device reset mechanism
Date:   Tue,  8 Jun 2021 11:18:53 +0530
Message-Id: <20210608054857.18963-5-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608054857.18963-1-ameynarkhede03@gmail.com>
References: <20210608054857.18963-1-ameynarkhede03@gmail.com>
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

