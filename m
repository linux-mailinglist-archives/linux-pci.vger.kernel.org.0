Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCC23E0985
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 22:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240946AbhHDUmx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 16:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240958AbhHDUmt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 16:42:49 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC67FC06179B;
        Wed,  4 Aug 2021 13:42:35 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q2so4350375plr.11;
        Wed, 04 Aug 2021 13:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mTj0rf3a1EYwHmNg/sseGw7r3Ux8KGJ1n47pGcdfKY8=;
        b=sfnIVL7muaRf40wqXFWzLJh3uUesgvNBX9SCaKqe6QY30P8cTCi8y68BDPbvTMlxs0
         i985c0jiGUsq5B+3wtsDvwiqn8OF7EpUs2Y0uAU514hissqDCMCU1tHTk4NmywRrtYmq
         LMLlWkfOcmGBqTG41WrV+DRGG/UTkFJ5UKSiOHS79ONMh7ItawQd9ORXEI9mP/wKilTb
         wzYOPdw7t0rGRFtavk1ms7MvHTbD8I/MlBoHGb4K8Z/XDnRbKC81ppWAApKEzkJWL7dx
         4Vs56MsdtJ6mFYzQ+JDCTXTcLBD1QRRbkuf+jySSBK3xqcsKxi7v9coVjw56DQ4p8Ge5
         xXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mTj0rf3a1EYwHmNg/sseGw7r3Ux8KGJ1n47pGcdfKY8=;
        b=KeiFkp3wK76FcMvlNDW25hqnvBw0YpMBXgM4z7pqKcItybO+v5dZkQUgSxLU+dv460
         KYvVe/R4lgYbHim2fH/EKYowg7lZLBKvWTr4pfQGxCmkIm1uhm9ckwTZZdEOIX9Xzk5u
         Zu5oDVjfjN0t1Y7r5ldJ3x34WXvEudQV3+qMFowb4ajvv8ZSEE5MWK/jzVZe4tqBEUmL
         BGeVRwcySKaQh3DmycLyILtgGVMhahf1UtSkfoqIpS6o6bpV/OR2bbClerB/1yybgmjo
         D8eovkqsNWoI7eu5xFj8K17sySbl7CKq92S6C/uYaHPmkUrcx6lMdf3i4lTdJEv7ARAr
         hNPQ==
X-Gm-Message-State: AOAM532j3kPwaNQuhjI6CLaSIIg+B9crEZSeKb4LR/nwuJQm2bOOijHh
        CmgK81295UjpajkTC7S7Cjk=
X-Google-Smtp-Source: ABdhPJwQdVr+AmJ31hjhuUUKn9J5HG/zcCaxT+na4VGUQrjDcAWuv7PsMEV8OCL2ecOdtiCMmFUVXQ==
X-Received: by 2002:a17:90a:fef:: with SMTP id 102mr11302092pjz.148.1628109755355;
        Wed, 04 Aug 2021 13:42:35 -0700 (PDT)
Received: from localhost.localdomain ([139.5.31.161])
        by smtp.googlemail.com with ESMTPSA id w2sm7064922pjt.14.2021.08.04.13.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 13:42:35 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v14 5/9] PCI: Allow userspace to query and set device reset mechanism
Date:   Thu,  5 Aug 2021 02:11:57 +0530
Message-Id: <20210804204201.1282-6-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210804204201.1282-1-ameynarkhede03@gmail.com>
References: <20210804204201.1282-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add reset_method sysfs attribute to enable user to query and set user
preferred device reset methods and their ordering.

Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |  19 ++++
 drivers/pci/pci-sysfs.c                 |   1 +
 drivers/pci/pci.c                       | 116 ++++++++++++++++++++++++
 drivers/pci/pci.h                       |   2 +
 4 files changed, 138 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ef00fada2efb..ef66b62bf025 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -121,6 +121,25 @@ Description:
 		child buses, and re-discover devices removed earlier
 		from this part of the device tree.
 
+What:		/sys/bus/pci/devices/.../reset_method
+Date:		March 2021
+Contact:	Amey Narkhede <ameynarkhede03@gmail.com>
+Description:
+		Some devices allow an individual function to be reset
+		without affecting other functions in the same slot.
+
+		For devices that have this support, a file named
+		reset_method will be present in sysfs. Initially reading
+		this file will give names of the device supported reset
+		methods and their ordering. After write, this file will
+		give names and ordering of currently enabled reset methods.
+		Writing the name or space separated list of names of any of
+		the device supported reset methods to this file will set
+		the reset methods and their ordering to be used when
+		resetting the device. Writing empty string to this file
+		will disable ability to reset the device and writing
+		"default" will return to the original value.
+
 What:		/sys/bus/pci/devices/.../reset
 Date:		July 2009
 Contact:	Michael S. Tsirkin <mst@redhat.com>
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 316f70c3e3b4..54ee7193b463 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1491,6 +1491,7 @@ const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_config_attr_group,
 	&pci_dev_rom_attr_group,
 	&pci_dev_reset_attr_group,
+	&pci_dev_reset_method_attr_group,
 	&pci_dev_vpd_attr_group,
 #ifdef CONFIG_DMI
 	&pci_dev_smbios_attr_group,
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8a516e9ca316..994426b2b502 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5132,6 +5132,122 @@ static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ pci_reset_bus_function, .name = "bus" },
 };
 
+static ssize_t reset_method_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	ssize_t len = 0;
+	int i, m;
+
+	for (i = 0; i < PCI_NUM_RESET_METHODS; i++) {
+		m = pdev->reset_methods[i];
+		if (!m)
+			break;
+
+		len += sysfs_emit_at(buf, len, "%s%s", len ? " " : "",
+				     pci_reset_fn_methods[m].name);
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
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int i, m, n = 0;
+	char *name, *options = NULL;
+
+	if (count >= (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	if (sysfs_streq(buf, "")) {
+		goto free_and_exit;
+	}
+
+	if (sysfs_streq(buf, "default")) {
+		pci_init_reset_methods(pdev);
+		return count;
+	}
+
+	options = kstrndup(buf, count, GFP_KERNEL);
+	if (!options)
+		return -ENOMEM;
+
+	while ((name = strsep(&options, " ")) != NULL) {
+		if (sysfs_streq(name, ""))
+			continue;
+
+		name = strim(name);
+
+		for (m = 1; m < PCI_NUM_RESET_METHODS; m++) {
+			if (sysfs_streq(name, pci_reset_fn_methods[m].name))
+				break;
+		}
+
+		if (m == PCI_NUM_RESET_METHODS) {
+			pci_warn(pdev, "Skip invalid reset method '%s'", name);
+			continue;
+		}
+
+		for (i = 0; i < n; i++) {
+			if (pdev->reset_methods[i] == m)
+				break;
+		}
+
+		if (i < n)
+			continue;
+
+		if (pci_reset_fn_methods[m].reset_fn(pdev, 1)) {
+			pci_warn(pdev, "Unsupported reset method '%s'", name);
+			continue;
+		}
+
+		pdev->reset_methods[n++] = m;
+		BUG_ON(n == PCI_NUM_RESET_METHODS);
+	}
+
+free_and_exit:
+	kfree(options);
+	/* All the reset methods are invalid */
+	if (n == 0 && m == PCI_NUM_RESET_METHODS)
+		return -EINVAL;
+	pdev->reset_methods[n] = 0;
+	if (pdev->reset_methods[0] == 0) {
+		pci_warn(pdev, "All device reset methods disabled by user");
+	} else if ((pdev->reset_methods[0] != 1) &&
+		   !pci_reset_fn_methods[1].reset_fn(pdev, 1)) {
+		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user");
+	}
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
+const struct attribute_group pci_dev_reset_method_attr_group = {
+	.attrs = pci_dev_reset_method_attrs,
+	.is_visible = pci_dev_reset_method_attr_is_visible,
+};
+
 /**
  * __pci_reset_function_locked - reset a PCI device function while holding
  * the @dev mutex lock.
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 7438953745e0..31458d48eda7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -714,4 +714,6 @@ static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
 extern const struct attribute_group aspm_ctrl_attr_group;
 #endif
 
+extern const struct attribute_group pci_dev_reset_method_attr_group;
+
 #endif /* DRIVERS_PCI_H */
-- 
2.32.0

