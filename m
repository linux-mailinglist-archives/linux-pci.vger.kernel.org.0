Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9962C3B7621
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jun 2021 18:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhF2QGH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Jun 2021 12:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbhF2QE5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jun 2021 12:04:57 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860B8C0617A8;
        Tue, 29 Jun 2021 09:02:14 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id n11so7565076pjo.1;
        Tue, 29 Jun 2021 09:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VvpCWdskRpMh6yccMWyMEzx05G3mmRmlDUW7trhWX84=;
        b=kN1DuS+t4jzL53IdZ8KVlatAIuSOjzbH7KD4kcuMrWQR4JTNGFRl0ipLnHRb16XxBm
         uvqr0nyK90GXIk5Ks1N07NIKOMcI5qODaQkPV2+1b6qxWMszgRQCjXDnXmOLMY2mL1pC
         Tj2GZQSA03UhE0HTI1qg/TsloeSHqfV/kGhsaRkfm15PE2FMZtHF+CE4yjJd2qJTD86i
         C95WsgSoecuDuUlQpjNgaEDnXcg8AFB47f/RDM5NYxAqmCS3a3o41gW61uynJE/Zlaas
         4J30+MMX82inqeEQTYgtvd+Zi/7pzwZBt7HkwzIYETHn7zeX8z+V9w04yvVomx3hpLag
         AiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VvpCWdskRpMh6yccMWyMEzx05G3mmRmlDUW7trhWX84=;
        b=cXGyd6QkFJBF5x+sCs2nHUisUTK2UXLbjokYaDs0i3yaj0NvS9lAMQUKuRf7ZHrB2w
         /C6h35gVMmBY2s6Bd3HUiWRzAMjD715yGKIfXNJQtyyqptHpFC9FJ+pUbMQrbbD8WvYF
         SQ4f2xSgNtIrbcLhVb8Q2qtOPHjo8jJSLXbgeU1W5fh/lnJLzza4vNLSmeHlH/FWgyFR
         6ybbYYHW4UlE2KcRjg8Mav+pdnCsflKwGK5kFwyfu7zNwIKx1F0l/c41uPKeIuFtlyNl
         H7u1CzMWp9pCbTXRjiPRxJ60EhynQKvb7rmqkppr+i4zkiTjJKbxnerAwTBcPw9MXzBJ
         kRww==
X-Gm-Message-State: AOAM531I3OeFv88RRdRDslspAMpPLe/XU5hxJ10r/tmEcmkTRqC+1Q1M
        ANIW032Q753faGKel5nbcec=
X-Google-Smtp-Source: ABdhPJzGdf9emVCsSzM+1z+u8PISqhNYxYBVdoPbedke6G9ETZnK3MnmE5+Beu9JGvG+YzhVqTom8A==
X-Received: by 2002:a17:90a:4584:: with SMTP id v4mr33973049pjg.77.1624982534020;
        Tue, 29 Jun 2021 09:02:14 -0700 (PDT)
Received: from localhost.localdomain ([103.200.106.119])
        by smtp.googlemail.com with ESMTPSA id m14sm19166240pgu.84.2021.06.29.09.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 09:02:13 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v8 4/8] PCI/sysfs: Allow userspace to query and set device reset mechanism
Date:   Tue, 29 Jun 2021 21:31:00 +0530
Message-Id: <20210629160104.2893-5-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629160104.2893-1-ameynarkhede03@gmail.com>
References: <20210629160104.2893-1-ameynarkhede03@gmail.com>
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
 drivers/pci/pci-sysfs.c                 | 102 ++++++++++++++++++++++++
 drivers/pci/pci.c                       |   1 +
 3 files changed, 122 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ef00fada2..43f4e33c7 100644
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
+		Writing the name or comma separated list of names of any of
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
index 316f70c3e..6713af211 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1334,6 +1334,107 @@ static const struct attribute_group pci_dev_rom_attr_group = {
 	.is_bin_visible = pci_dev_rom_attr_is_visible,
 };
 
+static ssize_t reset_method_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	ssize_t len = 0;
+	int i, idx;
+
+	for (i = 0; i < PCI_NUM_RESET_METHODS; i++) {
+		idx = pdev->reset_methods[i];
+		if (idx)
+			len += sysfs_emit_at(buf, len, "%s%s", len ? "," : "",
+					     pci_reset_fn_methods[idx].name);
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
+	int i, n;
+	char *name, *options;
+	u8 reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
+
+	if (count >= (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	if (sysfs_streq(buf, "")) {
+		pci_warn(pdev, "All device reset methods disabled by user");
+		memset(pdev->reset_methods, 0, PCI_NUM_RESET_METHODS);
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
+	n = 0;
+
+	while ((name = strsep(&options, ",")) != NULL) {
+		if (sysfs_streq(name, ""))
+			continue;
+
+		name = strim(name);
+
+		for (i = 1; i < PCI_NUM_RESET_METHODS; i++) {
+			if (sysfs_streq(name, pci_reset_fn_methods[i].name) &&
+			    !pci_reset_fn_methods[i].reset_fn(pdev, 1)) {
+				reset_methods[n++] = i;
+				break;
+			}
+		}
+
+		if (i == PCI_NUM_RESET_METHODS) {
+			kfree(options);
+			return -EINVAL;
+		}
+	}
+
+	if (!pci_reset_fn_methods[1].reset_fn(pdev, 1) && reset_methods[0] != 1)
+		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user");
+
+	memcpy(pdev->reset_methods, reset_methods, sizeof(reset_methods));
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
+static const struct attribute_group pci_dev_reset_method_attr_group = {
+	.attrs = pci_dev_reset_method_attrs,
+	.is_visible = pci_dev_reset_method_attr_is_visible,
+};
+
 static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
@@ -1491,6 +1592,7 @@ const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_config_attr_group,
 	&pci_dev_rom_attr_group,
 	&pci_dev_reset_attr_group,
+	&pci_dev_reset_method_attr_group,
 	&pci_dev_vpd_attr_group,
 #ifdef CONFIG_DMI
 	&pci_dev_smbios_attr_group,
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 90f0b35e6..db4e035cf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5198,6 +5198,7 @@ void pci_init_reset_methods(struct pci_dev *dev)
 		else if (rc != -ENOTTY)
 			break;
 	}
+
 	memcpy(dev->reset_methods, reset_methods, sizeof(reset_methods));
 }
 
-- 
2.32.0

