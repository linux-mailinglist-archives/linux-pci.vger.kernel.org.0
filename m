Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7A03EF151
	for <lists+linux-pci@lfdr.de>; Tue, 17 Aug 2021 20:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhHQSGT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 14:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbhHQSGB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Aug 2021 14:06:01 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5366FC0617AE;
        Tue, 17 Aug 2021 11:05:28 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso85950pjy.5;
        Tue, 17 Aug 2021 11:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S5vStBDkMo2hxqjx49ymxM0Lc5WHaVJd8lW5pLzPWBw=;
        b=Dx2aLlEUSIDt4HJl+umLvv7JDGiVQu3k4nos1Ubpy05N3461xvy142Yvf6C5mhki19
         STnfXY6L0mhsKY8BPTBtP+1SgNv+XMEdVaobH6uTY09PdbWLjdvbZYMlSYAKJ0sWG8G1
         zqIew99u7fULvZq/JyIXx7tnTJYCyt+bUQqVkXXv0vsaw7VEZt6dhJZAOUBE96rT/ffC
         ie/znwnjmLrfLDE66eThCXpo1o03aOx2unReM8ZyLmv7HGo40KFGXI7vAkelXuzc/9Zn
         hXKLl8RDHN48eFuukgW5DvpVTyUfWz9FgZLHLOl7j33n6IYAwcQ1uRPx4C8NEK9SYnNO
         CHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S5vStBDkMo2hxqjx49ymxM0Lc5WHaVJd8lW5pLzPWBw=;
        b=DptRs+tgCXvLljlgBY2zmkdDynl+bRI8fHVs1izoFe0ns9f8on1yIF7hLvA82IVEDG
         U+P1wXt4ykKID85R5HpbsZhDPlXrarm+pj0VLiRoydAWofVBYo1r5mChyOvtYQK3AbOb
         aeqbwWuz2TWG+XdS+wgbh0yjYBNOPr59T2otGFRzebU8Ypvo0d+/Wi0t4p4tlstPFgl9
         HD8ecYQRhaqd54rRTP4f4kv2ilxesU1A8LGwyON2hyFEzadsySgpHcjexUn3FNFaRMOE
         fDbOdDBTTcUxVcsnSlMh27yZx+26691niCXVzSlY+FV4bF7OGRxPXpkJqLApZTTPaXuE
         t6Bw==
X-Gm-Message-State: AOAM532Jgkv5grxKBiubQI/8NjopQsxZ4pSUVqEXXJ1oLbTUat9RBeRh
        3aE8kumM0ovIMIQjojY4Yjs=
X-Google-Smtp-Source: ABdhPJzGm7q0bl7+x+J1SfHUIjXK1eYHvpHj84NJ0DyHoHgTxB1IIKKxL9mLIfVKW9YcMGAmSV2mHQ==
X-Received: by 2002:a17:90a:fd11:: with SMTP id cv17mr4680246pjb.45.1629223527925;
        Tue, 17 Aug 2021 11:05:27 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.158])
        by smtp.googlemail.com with ESMTPSA id 65sm4065632pgi.12.2021.08.17.11.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:05:27 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v16 5/9] PCI: Allow userspace to query and set device reset mechanism
Date:   Tue, 17 Aug 2021 23:34:56 +0530
Message-Id: <20210817180500.1253-6-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817180500.1253-1-ameynarkhede03@gmail.com>
References: <20210817180500.1253-1-ameynarkhede03@gmail.com>
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
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |  19 ++++
 drivers/pci/pci-sysfs.c                 |   1 +
 drivers/pci/pci.c                       | 117 ++++++++++++++++++++++++
 drivers/pci/pci.h                       |   2 +
 4 files changed, 139 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ef00fada2..ef66b62bf 100644
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
index 316f70c3e..54ee7193b 100644
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
index 8a516e9ca..53d737708 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5132,6 +5132,123 @@ static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
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
+	int i, m = 0, n = 0;
+	char *name, *options;
+
+	if (count >= (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	if (sysfs_streq(buf, "")) {
+		goto exit;
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
+	kfree(options);
+
+exit:
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
index 743895374..31458d48e 100644
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
