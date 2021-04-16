Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDFB3629DB
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344001AbhDPU7m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:59:42 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:46963 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343938AbhDPU7j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 16:59:39 -0400
Received: by mail-ej1-f51.google.com with SMTP id u21so44008800ejo.13
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 13:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Fv8uv3c+thITNzU1vdfCbdGQyGnkllJf20yfYwGOy0=;
        b=QOVTgDMCjadqCPgX6Ht1/HTSo6AdCIlOvt0FH886uQUD5PAos3i0FUD55syAu8SLzp
         n/aSn58bDmxrZUnEd/TK9gHbR5XDRSUX8VJAfhGRWBnIFhCgeLKkLjqpBS8VN4QaOQ+E
         pmJJu2vgot/jQ6Zpm0XCHtXfnsbyceDftfzthqC4ILTV9EAVSkFbMhaUm1jpXFoaHYgx
         KrG84OCSHYy7aNThy9qrRx9s6VMMQ92k/HhKxOiA1lRuUoorPplVVSSIEEIqD7T3ELZq
         qNLPLvOpElwftH/17xJ6/VIfixpiWSw8kEP9g6l474x4RiAAY097SzuYUfmA/IGxo53i
         hM4Q==
X-Gm-Message-State: AOAM531NlLHLg7V709+O9ctZDk8LLp7nlJRWaWm/35MYsyd5P49zUxEE
        CPxZXu7I6NoWDd4Kxa8GB7k=
X-Google-Smtp-Source: ABdhPJz5dQbLqVcvRLHFH40AKIyLvxrXJLMjuZ1OzSLECwP+xMY4BaTiIGnLSTSoXYa4VY6+As5G/A==
X-Received: by 2002:a17:906:fa07:: with SMTP id lo7mr10291431ejb.321.1618606752998;
        Fri, 16 Apr 2021 13:59:12 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm5103864ejg.43.2021.04.16.13.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:59:12 -0700 (PDT)
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
Subject: [PATCH 15/20] PCI: Rearrange attributes from the pci_dev_attr_group
Date:   Fri, 16 Apr 2021 20:58:51 +0000
Message-Id: <20210416205856.3234481-16-kw@linux.com>
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

Thus, move attributes that are part of the "pci_dev_attr_group"
attribute group to the top of the file.

No functional change intended.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 74 ++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index f18b1728aefa..fd89a391b1c7 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -789,6 +789,43 @@ static const struct attribute_group pci_dev_reset_attr_group = {
 	.is_visible = pci_dev_reset_attr_is_visible,
 };
 
+static ssize_t boot_vga_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_dev *vga_dev = vga_default_device();
+
+	if (vga_dev)
+		return sysfs_emit(buf, "%u\n", (pdev == vga_dev));
+
+	return sysfs_emit(buf, "%u\n",
+			  !!(pdev->resource[PCI_ROM_RESOURCE].flags &
+			     IORESOURCE_ROM_SHADOW));
+}
+static DEVICE_ATTR_RO(boot_vga);
+
+static struct attribute *pci_dev_dev_attrs[] = {
+	&dev_attr_boot_vga.attr,
+	NULL,
+};
+
+static umode_t pci_dev_attr_is_visible(struct kobject *kobj,
+				       struct attribute *a, int n)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	if (a == &dev_attr_boot_vga.attr)
+		if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
+			return 0;
+
+	return a->mode;
+}
+
+static const struct attribute_group pci_dev_attr_group = {
+	.attrs = pci_dev_dev_attrs,
+	.is_visible = pci_dev_attr_is_visible,
+};
+
 /*
  * PCI Bus Class Devices
  */
@@ -1012,21 +1049,6 @@ const struct attribute_group *pcibus_groups[] = {
 	NULL,
 };
 
-static ssize_t boot_vga_show(struct device *dev,
-			     struct device_attribute *attr, char *buf)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct pci_dev *vga_dev = vga_default_device();
-
-	if (vga_dev)
-		return sysfs_emit(buf, "%u\n", (pdev == vga_dev));
-
-	return sysfs_emit(buf, "%u\n",
-			  !!(pdev->resource[PCI_ROM_RESOURCE].flags &
-			     IORESOURCE_ROM_SHADOW));
-}
-static DEVICE_ATTR_RO(boot_vga);
-
 #ifdef HAVE_PCI_LEGACY
 /**
  * pci_read_legacy_io - read byte(s) from legacy I/O port space
@@ -1495,23 +1517,6 @@ static int __init pci_sysfs_init(void)
 }
 late_initcall(pci_sysfs_init);
 
-static struct attribute *pci_dev_dev_attrs[] = {
-	&dev_attr_boot_vga.attr,
-	NULL,
-};
-
-static umode_t pci_dev_attr_is_visible(struct kobject *kobj,
-				       struct attribute *a, int n)
-{
-	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
-
-	if (a == &dev_attr_boot_vga.attr)
-		if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
-			return 0;
-
-	return a->mode;
-}
-
 static struct attribute *pci_dev_hp_attrs[] = {
 	&dev_attr_remove.attr,
 	&dev_attr_dev_rescan.attr,
@@ -1571,11 +1576,6 @@ static const struct attribute_group pci_dev_hp_attr_group = {
 	.is_visible = pci_dev_hp_attr_is_visible,
 };
 
-static const struct attribute_group pci_dev_attr_group = {
-	.attrs = pci_dev_dev_attrs,
-	.is_visible = pci_dev_attr_is_visible,
-};
-
 static const struct attribute_group pci_bridge_attr_group = {
 	.attrs = pci_bridge_attrs,
 	.is_visible = pci_bridge_attr_is_visible,
-- 
2.31.0

