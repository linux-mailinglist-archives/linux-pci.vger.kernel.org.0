Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139963BBE25
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 16:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhGEOY7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 10:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbhGEOY7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 10:24:59 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDDAC061574;
        Mon,  5 Jul 2021 07:22:21 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id p17-20020a17090b0111b02901723ab8d11fso60525pjz.1;
        Mon, 05 Jul 2021 07:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+SeOboOLlz+xap97sxOppn3yBL6kAtfgBYzXOsGvd0s=;
        b=PCN5YPo/uXxlpYhV7km3hBSh9UI9Xkyfi83u6e/mrhpT1TvHeBdO1RVous15RJPeJP
         8p4L/KW4D1z+IK6LP9DzxIYiEY/pc2YmlzU8OmIGsVp4YXgqe1ODvqk6O/YadOpe2vzo
         cjfIGHqTl38kqD3C3X22qMn4oZMrzg91PGxm4z5l8Jt/pel7C21Ekqqd75/CFpMX66ft
         Wdg/jIPee5VWnPsYd8djNOOOPbXSCzwRvx+b3egQDyX1hGXB/KeF/y5YlxaP0pEmow1S
         qgtloQEiBLjd4Hb3vPe2qLSUIGw3b0aCIL6SDgkrHT2IOzXIpk5AKWhHB4ezjpNHGikZ
         rdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+SeOboOLlz+xap97sxOppn3yBL6kAtfgBYzXOsGvd0s=;
        b=qQb0kRuxlYSxOK1RHc/B1jhMk/41iiwB+dhXlw18mkR9B0jc+Hwl+oVdu5hxpo2nqP
         Gszk2KCb13CkpCok0V4U105UF5O1qupu+n56NXwDavujWlDkK89CIqfWZitDglKuO5Xu
         YLZf8PYh140227X1H6XczjmerAVVp6wku6+6vb4CHdXJ7KlklZ3ABc9h4KU3KjX82hpd
         uBovi42JKEfld9JRC+5/+VznpTktVIc4o2yHsnFqo+m3brhZ8VcoDeDN+iBuSohHXoEO
         RkevNES3WNtauiMqkK7aLYbaFbwM0sKl2brdeXPmUJH2sZTf+dbPPZqYmZP6Me5oJ1G8
         hKAg==
X-Gm-Message-State: AOAM530dYMCBzQQEEycPdtJhL6v18ml15/Ey83SPxvvLvKsv9kosmC0l
        a6urNDrw6RHJmhEn4r9Eq2Q=
X-Google-Smtp-Source: ABdhPJyO5rFOq79dUCaOQUbUkXMSluWeDN2PSi5E1T3s5DgUta11uYPO3VXomZra9fxBf2jM9cvNzQ==
X-Received: by 2002:a17:902:9308:b029:129:7c79:e53d with SMTP id bc8-20020a1709029308b02901297c79e53dmr7591726plb.50.1625494941205;
        Mon, 05 Jul 2021 07:22:21 -0700 (PDT)
Received: from localhost.localdomain ([2409:4042:2696:1624:5e13:abf4:6ecf:a1f1])
        by smtp.googlemail.com with ESMTPSA id 92sm22615307pjv.29.2021.07.05.07.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 07:22:20 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v9 4/8] PCI/sysfs: Allow userspace to query and set device reset mechanism
Date:   Mon,  5 Jul 2021 19:51:34 +0530
Message-Id: <20210705142138.2651-5-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210705142138.2651-1-ameynarkhede03@gmail.com>
References: <20210705142138.2651-1-ameynarkhede03@gmail.com>
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
 drivers/pci/pci-sysfs.c                 | 103 ++++++++++++++++++++++++
 2 files changed, 122 insertions(+)

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
index 316f70c3e..8a740e211 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1334,6 +1334,108 @@ static const struct attribute_group pci_dev_rom_attr_group = {
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
+		if (!idx)
+			break;
+
+		len += sysfs_emit_at(buf, len, "%s%s", len ? "," : "",
+				     pci_reset_fn_methods[idx].name);
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
+	int n = 0;
+	char *name, *options = NULL;
+	u8 reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
+
+	if (count >= (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	if (sysfs_streq(buf, "")) {
+		pci_warn(pdev, "All device reset methods disabled by user");
+		goto set_reset_methods;
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
+	while ((name = strsep(&options, ",")) != NULL) {
+		int i;
+
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
+set_reset_methods:
+	memcpy(pdev->reset_methods, reset_methods, sizeof(reset_methods));
+	kfree(options);
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
@@ -1491,6 +1593,7 @@ const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_config_attr_group,
 	&pci_dev_rom_attr_group,
 	&pci_dev_reset_attr_group,
+	&pci_dev_reset_method_attr_group,
 	&pci_dev_vpd_attr_group,
 #ifdef CONFIG_DMI
 	&pci_dev_smbios_attr_group,
-- 
2.32.0

