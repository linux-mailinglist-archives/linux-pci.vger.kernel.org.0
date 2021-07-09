Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0D43C2389
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jul 2021 14:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhGIMlj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jul 2021 08:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhGIMli (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jul 2021 08:41:38 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5E9C0613DD;
        Fri,  9 Jul 2021 05:38:55 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y4so8584182pfi.9;
        Fri, 09 Jul 2021 05:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+SeOboOLlz+xap97sxOppn3yBL6kAtfgBYzXOsGvd0s=;
        b=gt4efscUHLLjbgAltWGtdyB8zUfh21GTWeznXmW4oC8/mZSeSkrPp8X5mWEB3aTdcw
         B8mLQWU+Zr53YzFIsyZ2SXeKn6Mq9RxZmNWeo3tLsSwOOojOS5R2p5ha2tbz9mGixwJW
         S/q1mWy62lDMB0+7SsvQGLwkv/iA8gTBR0+tfCG/chV0JEErQIsXG5OXma5JjP246el5
         3dhZr0UbbOS05h5n0iv70FdD8MwStBarVJaHCwJKDdi/b0MuxNrsIv8onZJFQmBAZZpc
         IiOCmmBXbzQ//9FGcNWCE/oPOLVbNQU2xqwaibn3k91sm2VfGXtBD2YBq5UDkaZWoNzk
         WftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+SeOboOLlz+xap97sxOppn3yBL6kAtfgBYzXOsGvd0s=;
        b=rrFjGkAFFS10gWc33S8ix0WmPRudwUn9ZgTVuL503QKafG4C+ia2e3mNKiPIGjIqGs
         1r0YKSvKUZ8WXhSSi1MEWM/XyL+VHxKrF4qs+hf+ZU+e8a579Du5w7nryF3BHqfuqcCJ
         mYz10p60PRSgEqk8QzdQ+N1fUHi5tJjBdvX+oVOh6ydKZXzGQoFASZYWg/ZF2dN4d1nw
         2wrgzzUzRlCjkwpA/momqvVK+k6UX9Vy9GMpqVD1r5YneNz4+fnrOPgbFcHNNyYMqPx5
         FyMkbX4YtOqtbVXAYvqRemePANUK5RhvAQ+pntYH6DQrXPtFD261w8C5rccKecRHhBs2
         X2Bg==
X-Gm-Message-State: AOAM532/wZZMAV8hD87Re0HDb8/26MsvPFw2SLwOj7GBhzERo98ll/1k
        B+slTcsL6MTP9faPVJihXxo=
X-Google-Smtp-Source: ABdhPJyEYZ+kJJwlNpY9xiVgxjiBUoNTFK7j5g/DsNXpVq2oB6thtj9jEe75llsK35UzoJa8qEzgKQ==
X-Received: by 2002:a63:6bc5:: with SMTP id g188mr38265726pgc.186.1625834334933;
        Fri, 09 Jul 2021 05:38:54 -0700 (PDT)
Received: from localhost.localdomain ([152.57.176.46])
        by smtp.googlemail.com with ESMTPSA id j6sm5592402pji.23.2021.07.09.05.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 05:38:54 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v10 4/8] PCI/sysfs: Allow userspace to query and set device reset mechanism
Date:   Fri,  9 Jul 2021 18:08:09 +0530
Message-Id: <20210709123813.8700-5-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210709123813.8700-1-ameynarkhede03@gmail.com>
References: <20210709123813.8700-1-ameynarkhede03@gmail.com>
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

