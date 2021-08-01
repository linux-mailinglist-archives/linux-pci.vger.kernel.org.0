Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A913DCC0B
	for <lists+linux-pci@lfdr.de>; Sun,  1 Aug 2021 16:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhHAOZ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Aug 2021 10:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhHAOZ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Aug 2021 10:25:57 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24060C06179A;
        Sun,  1 Aug 2021 07:25:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so27827526pjb.3;
        Sun, 01 Aug 2021 07:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mrgRbYBJ3TutCw5MQ7UwdvxpZcgSoowZXm3m+uMfmKY=;
        b=pSUmieMJcGaOZ0GPOmtCXqMZDj090GpQH7D6OItwRRDpbKDrm8CJaSz2P5l0HABHY4
         lGkenr81OB0TyMi1memQBVLsW9kHRZO2BDbEWNvKw7hKsDLA9tJuCPn6mVzFebgvhddp
         6L/UfLYGUWXGoNZ4G3ncc1mIzLf541ceq3U9u3MGwr1VcPTdN0JQUaSHmYsymLJx1VJo
         4CmcoCX/Jlvmn0WbLulayVpJhHg/ponpgpglEmevpzQ52iQBPjd2PDZc2KrrOj+FAMvr
         7TJtbs+W+iMatpcN31W1nST0937y3py3JYyhL4nP2/o9U18HUETFkUgKZhW5VQEaPUyD
         UWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mrgRbYBJ3TutCw5MQ7UwdvxpZcgSoowZXm3m+uMfmKY=;
        b=MTvrRyRF4IgslBnjw4dUE/+DzAAHEHpfZYGlb2dVvuVdRoMXsfiHQGCbAvX7d2sC5p
         9y6E30bnT96kyX5sYSWeV6zUG2UWepKKb9JACuZe0PLlugsKj6VFrwytDzUXyBhlAlm2
         wUVSwwWHRdrmYTQ1lGwubWcfHOMDKk97prIUnJiwghLt9J3pXWgco6fEgvM2G1VIFXI8
         W2uO7o6QWlPqlvD9nZGOkAdWaivFOvLy/FzcRxqGUypK35gBXL5J/RVVz5QQdlE2lZ+Y
         l7R21aw69HKFViVw+QX2iz5K7bU093of2Mrd1/f/Jj01bpHAH7P2wmLNCjiEqdtqahth
         cZQA==
X-Gm-Message-State: AOAM530lD7xlmp1Kpd2y3c76K1dsvK8og394xS9zH4Sm3q/Ll2MI/kfu
        ckVJKRKIhi8PLy3tsOtF094=
X-Google-Smtp-Source: ABdhPJzy++7Z72Q+O9JVfxOFw9bmK4FboPUplH0NDQrKCUHAIDRyE3n+NP1crZygtrDkTA1CwP+aVA==
X-Received: by 2002:a17:90a:ba09:: with SMTP id s9mr12984285pjr.126.1627827946755;
        Sun, 01 Aug 2021 07:25:46 -0700 (PDT)
Received: from localhost.localdomain ([139.5.31.186])
        by smtp.googlemail.com with ESMTPSA id g11sm7740897pju.13.2021.08.01.07.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 07:25:46 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v13 5/9] PCI: Allow userspace to query and set device reset mechanism
Date:   Sun,  1 Aug 2021 19:55:14 +0530
Message-Id: <20210801142518.1224-6-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210801142518.1224-1-ameynarkhede03@gmail.com>
References: <20210801142518.1224-1-ameynarkhede03@gmail.com>
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
 Documentation/ABI/testing/sysfs-bus-pci |  19 +++++
 drivers/pci/pci-sysfs.c                 |   1 +
 drivers/pci/pci.c                       | 105 ++++++++++++++++++++++++
 drivers/pci/pci.h                       |   2 +
 4 files changed, 127 insertions(+)

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
index 932dd21e759b..c496cd164aca 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5132,6 +5132,111 @@ static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ pci_reset_bus_function, .name = "bus" },
 };
 
+static ssize_t reset_method_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
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
+	int i = 0;
+	char *name, *options = NULL;
+
+	if (count >= (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	if (sysfs_streq(buf, "")) {
+		pdev->reset_methods[0] = 0;
+		pci_warn(pdev, "All device reset methods disabled by user");
+		return count;
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
+		int m;
+
+		if (sysfs_streq(name, ""))
+			continue;
+
+		name = strim(name);
+
+		for (m = 1; m < PCI_NUM_RESET_METHODS && i < PCI_NUM_RESET_METHODS; m++) {
+			if (sysfs_streq(name, pci_reset_fn_methods[m].name) &&
+			    !pci_reset_fn_methods[m].reset_fn(pdev, 1)) {
+				pdev->reset_methods[i++] = m;
+				break;
+			}
+		}
+
+		if (m == PCI_NUM_RESET_METHODS) {
+			kfree(options);
+			return -EINVAL;
+
+		}
+	}
+
+	if (i < PCI_NUM_RESET_METHODS)
+		pdev->reset_methods[i] = 0;
+
+	if (!pci_reset_fn_methods[1].reset_fn(pdev, 1) && pdev->reset_methods[0] != 1)
+		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user");
+
+	kfree(options);
+
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

