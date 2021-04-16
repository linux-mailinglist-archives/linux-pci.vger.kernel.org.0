Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723753629D9
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343707AbhDPU7h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:59:37 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:41629 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343791AbhDPU7h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 16:59:37 -0400
Received: by mail-ej1-f44.google.com with SMTP id mh2so22452907ejb.8
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 13:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xYXmofRcGdnImmAQP35u+j5nMlwM8TKpfiEH+XxcCUo=;
        b=YzpppqHtc7J4BuYlmAebR7fIiZ99rdhBVzoz1vey0j8w2O94Z9/5AC08RAhzwqNWhs
         ENdxhGJHGiTJi4FXygUqFWixikJimGYMlNBGrqSN49DVgD4Cq1Wnu4vv5Q2OLgO+wZ9Y
         9EHTqwlFZ1WnptCDGKrRHF/NMWisa7E2o6FXnwGJFhfwlP4g6S0T4zPbAcXi7kMoSVUy
         +wKqM1978660Mg2EcjYqAWH+WvxxfXkSWSjD8Hz0UaokvZ7Ni6zMO0uwJgx4bo3pMLAN
         zWtmIOugeVYJ/BWdTTX352m/KYDnsN9cZgX/k89GUcd575+UZjWNJjYyaLJ+qRicDsM8
         lL/Q==
X-Gm-Message-State: AOAM530G/DJ7W43PsclDzD5YZaDwP2dWBL29u2q9WchM2Xj6SL9/FMj5
        Z/MPC5aYEEd2VBxGNXI0yVU=
X-Google-Smtp-Source: ABdhPJwpFWTXUCe/YqezHByd/SX4RShjdY88amiM8Mo1OdayvXj9e1A0nfVjo4R7cxM05XXVjbNd2g==
X-Received: by 2002:a17:906:f6c1:: with SMTP id jo1mr9842089ejb.262.1618606751146;
        Fri, 16 Apr 2021 13:59:11 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm5103864ejg.43.2021.04.16.13.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:59:10 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joe Perches <joe@perches.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        David Sterba <dsterba@suse.com>, linux-pci@vger.kernel.org
Subject: [PATCH 13/20] PCI: Rearrange attributes from the pci_dev_rom_attr_group
Date:   Fri, 16 Apr 2021 20:58:49 +0000
Message-Id: <20210416205856.3234481-14-kw@linux.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210416205856.3234481-1-kw@linux.com>
References: <20210416205856.3234481-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When new sysfs objects were added to the PCI device over time, the code
that implemented new attributes has been added in many different places
in the pci-sysfs.c file.  This makes it hard to read and also hard to
find relevant code.

Thus, move attributes that are part of the "pci_dev_rom_attr_group"
attribute group to the top of the file.

No functional change intended.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 186 ++++++++++++++++++++--------------------
 1 file changed, 93 insertions(+), 93 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 513e19154a93..794c97424456 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -651,6 +651,99 @@ static const struct attribute_group pci_dev_config_attr_group = {
 	.is_bin_visible = pci_dev_config_attr_is_visible,
 };
 
+/**
+ * rom_read - read a PCI ROM
+ * @filp: sysfs file
+ * @kobj: kernel object handle
+ * @bin_attr: struct bin_attribute for this file
+ * @buf: where to put the data we read from the ROM
+ * @off: file offset
+ * @count: number of bytes to read
+ *
+ * Put @count bytes starting at @off into @buf from the ROM in the PCI
+ * device corresponding to @kobj.
+ */
+static ssize_t rom_read(struct file *filp, struct kobject *kobj,
+			struct bin_attribute *bin_attr, char *buf,
+			loff_t off, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	void __iomem *rom;
+	size_t size;
+
+	if (!pdev->rom_attr_enabled)
+		return -EINVAL;
+
+	rom = pci_map_rom(pdev, &size);	/* size starts out as PCI window size */
+	if (!rom || !size)
+		return -EIO;
+
+	if (off >= size) {
+		count = 0;
+	} else {
+		if (off + count > size)
+			count = size - off;
+
+		memcpy_fromio(buf, rom + off, count);
+	}
+	pci_unmap_rom(pdev, rom);
+
+	return count;
+}
+
+/**
+ * rom_write - used to enable access to the PCI ROM display
+ * @filp: sysfs file
+ * @kobj: kernel object handle
+ * @bin_attr: struct bin_attribute for this file
+ * @buf: user input
+ * @off: file offset
+ * @count: number of byte in input
+ *
+ * writing anything except 0 enables it
+ */
+static ssize_t rom_write(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *bin_attr, char *buf,
+			 loff_t off, size_t count)
+{
+	bool allowed;
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	if (kstrtobool(buf, &allowed) < 0)
+		return -EINVAL;
+
+	pdev->rom_attr_enabled = !!allowed;
+
+	return count;
+}
+static BIN_ATTR_ADMIN_RW(rom, 0);
+
+static struct bin_attribute *pci_dev_rom_attrs[] = {
+	&bin_attr_rom,
+	NULL,
+};
+
+static umode_t pci_dev_rom_attr_is_visible(struct kobject *kobj,
+					   struct bin_attribute *a, int n)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	size_t rom_size;
+
+	/* If the device has a ROM, try to expose it in sysfs. */
+	rom_size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
+	if (!rom_size)
+		return 0;
+
+	a->size = rom_size;
+
+	return a->attr.mode;
+}
+
+static const struct attribute_group pci_dev_rom_attr_group = {
+	.bin_attrs = pci_dev_rom_attrs,
+	.is_bin_visible = pci_dev_rom_attr_is_visible,
+};
+
 /*
  * PCI Bus Class Devices
  */
@@ -1313,99 +1406,6 @@ int __weak pci_create_resource_files(struct pci_dev *pdev) { return 0; }
 void __weak pci_remove_resource_files(struct pci_dev *pdev) { return; }
 #endif
 
-/**
- * rom_write - used to enable access to the PCI ROM display
- * @filp: sysfs file
- * @kobj: kernel object handle
- * @bin_attr: struct bin_attribute for this file
- * @buf: user input
- * @off: file offset
- * @count: number of byte in input
- *
- * writing anything except 0 enables it
- */
-static ssize_t rom_write(struct file *filp, struct kobject *kobj,
-			 struct bin_attribute *bin_attr, char *buf,
-			 loff_t off, size_t count)
-{
-	bool allowed;
-	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
-
-	if (kstrtobool(buf, &allowed) < 0)
-		return -EINVAL;
-
-	pdev->rom_attr_enabled = !!allowed;
-
-	return count;
-}
-
-/**
- * rom_read - read a PCI ROM
- * @filp: sysfs file
- * @kobj: kernel object handle
- * @bin_attr: struct bin_attribute for this file
- * @buf: where to put the data we read from the ROM
- * @off: file offset
- * @count: number of bytes to read
- *
- * Put @count bytes starting at @off into @buf from the ROM in the PCI
- * device corresponding to @kobj.
- */
-static ssize_t rom_read(struct file *filp, struct kobject *kobj,
-			struct bin_attribute *bin_attr, char *buf,
-			loff_t off, size_t count)
-{
-	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
-	void __iomem *rom;
-	size_t size;
-
-	if (!pdev->rom_attr_enabled)
-		return -EINVAL;
-
-	rom = pci_map_rom(pdev, &size);	/* size starts out as PCI window size */
-	if (!rom || !size)
-		return -EIO;
-
-	if (off >= size) {
-		count = 0;
-	} else {
-		if (off + count > size)
-			count = size - off;
-
-		memcpy_fromio(buf, rom + off, count);
-	}
-	pci_unmap_rom(pdev, rom);
-
-	return count;
-}
-static BIN_ATTR_ADMIN_RW(rom, 0);
-
-static struct bin_attribute *pci_dev_rom_attrs[] = {
-	&bin_attr_rom,
-	NULL,
-};
-
-static umode_t pci_dev_rom_attr_is_visible(struct kobject *kobj,
-					   struct bin_attribute *a, int n)
-{
-	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
-	size_t rom_size;
-
-	/* If the device has a ROM, try to expose it in sysfs. */
-	rom_size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
-	if (!rom_size)
-		return 0;
-
-	a->size = rom_size;
-
-	return a->attr.mode;
-}
-
-static const struct attribute_group pci_dev_rom_attr_group = {
-	.bin_attrs = pci_dev_rom_attrs,
-	.is_bin_visible = pci_dev_rom_attr_is_visible,
-};
-
 static ssize_t reset_store(struct device *dev,
 			   struct device_attribute *attr, const char *buf,
 			   size_t count)
-- 
2.31.0

