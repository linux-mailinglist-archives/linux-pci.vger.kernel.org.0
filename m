Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E86A3629D5
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbhDPU7d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:59:33 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:41625 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244516AbhDPU7d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 16:59:33 -0400
Received: by mail-ej1-f50.google.com with SMTP id mh2so22452698ejb.8
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 13:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YQdDvvb/NUYE/KyNp9dJGeLDR6zwYttostGpiT5NeHA=;
        b=HG1gQ0ohFvMLGx/zSw7Vu8d4pKpf71bajKeol+/UuM7NI9HrudlL7XCv9GcJxfYj3V
         0b3Sh5/JYdlxHKLeZ7UMmbVCmRBgB0lRP07f3cInIig4CJ/7/9XaWKSEhy909xW7DtBy
         ZPd175yy+b+wmy8Yhm5QJXNlM1n10PT9OEA9nlsW3TJr1xjbwRDCkRYuCDxLRzlxydo7
         w0MvkaYI8Ibxf6z0lv+LDddQ4CjXmymkl+hDmdH4qvnzIuugFJLS0r/J5frHEj401rcy
         1dDWix1u02q6/BbD0p/g1DFZYcACPmLGZprTJLJokM9VKi95uUVoryadvh8IytD4xrwr
         XHwA==
X-Gm-Message-State: AOAM532MLWUCTH6FPBd4iSeftB/GWySHPkRUgSfwOhViAZpsjvdfGobk
        Kec3wjgm9iphQlP+FG4paSQ=
X-Google-Smtp-Source: ABdhPJx8bamBJCIDwQBg4K0JfXb5oUdkc/gxlzchpkbCvcBb8AhvxoGUeZnsRA+abmS4xglGmSwlZg==
X-Received: by 2002:a17:906:5fc2:: with SMTP id k2mr10338549ejv.354.1618606746711;
        Fri, 16 Apr 2021 13:59:06 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm5103864ejg.43.2021.04.16.13.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:59:06 -0700 (PDT)
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
Subject: [PATCH 09/20] PCI: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Fri, 16 Apr 2021 20:58:45 +0000
Message-Id: <20210416205856.3234481-10-kw@linux.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210416205856.3234481-1-kw@linux.com>
References: <20210416205856.3234481-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The sysfs_emit() and sysfs_emit_at() functions were introduced to make
it less ambiguous which function is preferred when writing to the output
buffer in a device attribute's "show" callback [1].

Convert the PCI sysfs object "show" functions from sprintf(), snprintf()
and scnprintf() to sysfs_emit() and sysfs_emit_at() accordingly, as the
latter is aware of the PAGE_SIZE buffer and correctly returns the number
of bytes written into the buffer.

No functional change intended.

[1] Documentation/filesystems/sysfs.rst

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-label.c | 31 ++++++++-------
 drivers/pci/pci-sysfs.c | 88 ++++++++++++++++++-----------------------
 2 files changed, 56 insertions(+), 63 deletions(-)

diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index 31fedc4920bb..0ef863e598ad 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -74,13 +74,11 @@ static size_t find_smbios_instance_string(struct pci_dev *pdev, char *buf,
 				donboard->devfn == devfn) {
 			if (buf) {
 				if (attribute == SMBIOS_ATTR_INSTANCE_SHOW)
-					return scnprintf(buf, PAGE_SIZE,
-							 "%d\n",
-							 donboard->instance);
+					return sysfs_emit(buf, "%d\n",
+							  donboard->instance);
 				else if (attribute == SMBIOS_ATTR_LABEL_SHOW)
-					return scnprintf(buf, PAGE_SIZE,
-							 "%s\n",
-							 dmi->name);
+					return sysfs_emit(buf, "%s\n",
+							  dmi->name);
 			}
 			return strlen(dmi->name);
 		}
@@ -144,14 +142,17 @@ enum acpi_attr_enum {
 	ACPI_ATTR_INDEX_SHOW,
 };
 
-static void dsm_label_utf16s_to_utf8s(union acpi_object *obj, char *buf)
+static int dsm_label_utf16s_to_utf8s(union acpi_object *obj, char *buf)
 {
 	int len;
+
 	len = utf16s_to_utf8s((const wchar_t *)obj->buffer.pointer,
 			      obj->buffer.length,
 			      UTF16_LITTLE_ENDIAN,
 			      buf, PAGE_SIZE);
 	buf[len] = '\n';
+
+	return strlen(buf);
 }
 
 static int dsm_get_label(struct device *dev, char *buf,
@@ -159,7 +160,7 @@ static int dsm_get_label(struct device *dev, char *buf,
 {
 	acpi_handle handle;
 	union acpi_object *obj, *tmp;
-	int len = -1;
+	int len = 0;
 
 	handle = ACPI_HANDLE(dev);
 	if (!handle)
@@ -181,20 +182,22 @@ static int dsm_get_label(struct device *dev, char *buf,
 		 * this entry must return a null string.
 		 */
 		if (attr == ACPI_ATTR_INDEX_SHOW) {
-			scnprintf(buf, PAGE_SIZE, "%llu\n", tmp->integer.value);
+			len = sysfs_emit(buf, "%llu\n", tmp->integer.value);
 		} else if (attr == ACPI_ATTR_LABEL_SHOW) {
 			if (tmp[1].type == ACPI_TYPE_STRING)
-				scnprintf(buf, PAGE_SIZE, "%s\n",
-					  tmp[1].string.pointer);
+				len = sysfs_emit(buf, "%s\n",
+						 tmp[1].string.pointer);
 			else if (tmp[1].type == ACPI_TYPE_BUFFER)
-				dsm_label_utf16s_to_utf8s(tmp + 1, buf);
+				len = dsm_label_utf16s_to_utf8s(tmp + 1, buf);
 		}
-		len = strlen(buf) > 0 ? strlen(buf) : -1;
 	}
 
 	ACPI_FREE(obj);
 
-	return len;
+	if (len > 0)
+		return len;
+
+	return -1;
 }
 
 static ssize_t acpi_label_show(struct device *dev,
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9ee003cc4375..c47c30cf063e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -39,7 +39,7 @@ field##_show(struct device *dev, struct device_attribute *attr, char *buf)				\
 	struct pci_dev *pdev;						\
 									\
 	pdev = to_pci_dev(dev);						\
-	return sprintf(buf, format_string, pdev->field);		\
+	return sysfs_emit(buf, format_string, pdev->field);		\
 }									\
 static DEVICE_ATTR_RO(field)
 
@@ -56,7 +56,7 @@ static ssize_t broken_parity_status_show(struct device *dev,
 					 char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	return sprintf(buf, "%u\n", pdev->broken_parity_status);
+	return sysfs_emit(buf, "%u\n", pdev->broken_parity_status);
 }
 
 static ssize_t broken_parity_status_store(struct device *dev,
@@ -129,7 +129,7 @@ static ssize_t power_state_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%s\n", pci_power_name(pdev->current_state));
+	return sysfs_emit(buf, "%s\n", pci_power_name(pdev->current_state));
 }
 static DEVICE_ATTR_RO(power_state);
 
@@ -138,10 +138,10 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
-	char *str = buf;
 	int i;
 	int max;
 	resource_size_t start, end;
+	size_t len = 0;
 
 	if (pci_dev->subordinate)
 		max = DEVICE_COUNT_RESOURCE;
@@ -151,12 +151,12 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 	for (i = 0; i < max; i++) {
 		struct resource *res =  &pci_dev->resource[i];
 		pci_resource_to_user(pci_dev, i, res, &start, &end);
-		str += sprintf(str, "0x%016llx 0x%016llx 0x%016llx\n",
-			       (unsigned long long)start,
-			       (unsigned long long)end,
-			       (unsigned long long)res->flags);
+		len += sysfs_emit_at(buf, len, "0x%016llx 0x%016llx 0x%016llx\n",
+				     (unsigned long long)start,
+				     (unsigned long long)end,
+				     (unsigned long long)res->flags);
 	}
-	return (str - buf);
+	return len;
 }
 static DEVICE_ATTR_RO(resource);
 
@@ -165,8 +165,8 @@ static ssize_t max_link_speed_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%s\n",
-		       pci_speed_string(pcie_get_speed_cap(pdev)));
+	return sysfs_emit(buf, "%s\n",
+			  pci_speed_string(pcie_get_speed_cap(pdev)));
 }
 static DEVICE_ATTR_RO(max_link_speed);
 
@@ -175,7 +175,7 @@ static ssize_t max_link_width_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%u\n", pcie_get_width_cap(pdev));
+	return sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
 }
 static DEVICE_ATTR_RO(max_link_width);
 
@@ -183,17 +183,11 @@ static ssize_t current_link_speed_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
-	u16 linkstat;
-	int err;
 	enum pci_bus_speed speed;
 
-	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
-	if (err)
-		return -EINVAL;
-
-	speed = pcie_link_speed[linkstat & PCI_EXP_LNKSTA_CLS];
+	pcie_bandwidth_available(pci_dev, NULL, &speed, NULL);
 
-	return sprintf(buf, "%s\n", pci_speed_string(speed));
+	return sysfs_emit(buf, "%s\n", pci_speed_string(speed));
 }
 static DEVICE_ATTR_RO(current_link_speed);
 
@@ -201,15 +195,11 @@ static ssize_t current_link_width_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
-	u16 linkstat;
-	int err;
+	enum pcie_link_width width;
 
-	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
-	if (err)
-		return -EINVAL;
+	pcie_bandwidth_available(pci_dev, NULL, NULL, &width);
 
-	return sprintf(buf, "%u\n",
-		(linkstat & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT);
+	return sysfs_emit(buf, "%u\n", width);
 }
 static DEVICE_ATTR_RO(current_link_width);
 
@@ -225,7 +215,7 @@ static ssize_t secondary_bus_number_show(struct device *dev,
 	if (err)
 		return -EINVAL;
 
-	return sprintf(buf, "%u\n", sec_bus);
+	return sysfs_emit(buf, "%u\n", sec_bus);
 }
 static DEVICE_ATTR_RO(secondary_bus_number);
 
@@ -241,7 +231,7 @@ static ssize_t subordinate_bus_number_show(struct device *dev,
 	if (err)
 		return -EINVAL;
 
-	return sprintf(buf, "%u\n", sub_bus);
+	return sysfs_emit(buf, "%u\n", sub_bus);
 }
 static DEVICE_ATTR_RO(subordinate_bus_number);
 
@@ -251,7 +241,7 @@ static ssize_t ari_enabled_show(struct device *dev,
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 
-	return sprintf(buf, "%u\n", pci_ari_enabled(pci_dev->bus));
+	return sysfs_emit(buf, "%u\n", pci_ari_enabled(pci_dev->bus));
 }
 static DEVICE_ATTR_RO(ari_enabled);
 
@@ -260,11 +250,11 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 
-	return sprintf(buf, "pci:v%08Xd%08Xsv%08Xsd%08Xbc%02Xsc%02Xi%02X\n",
-		       pci_dev->vendor, pci_dev->device,
-		       pci_dev->subsystem_vendor, pci_dev->subsystem_device,
-		       (u8)(pci_dev->class >> 16), (u8)(pci_dev->class >> 8),
-		       (u8)(pci_dev->class));
+	return sysfs_emit(buf, "pci:v%08Xd%08Xsv%08Xsd%08Xbc%02Xsc%02Xi%02X\n",
+			  pci_dev->vendor, pci_dev->device,
+			  pci_dev->subsystem_vendor, pci_dev->subsystem_device,
+			  (u8)(pci_dev->class >> 16), (u8)(pci_dev->class >> 8),
+			  (u8)(pci_dev->class));
 }
 static DEVICE_ATTR_RO(modalias);
 
@@ -302,7 +292,7 @@ static ssize_t enable_show(struct device *dev, struct device_attribute *attr,
 	struct pci_dev *pdev;
 
 	pdev = to_pci_dev(dev);
-	return sprintf(buf, "%u\n", atomic_read(&pdev->enable_cnt));
+	return sysfs_emit(buf, "%u\n", atomic_read(&pdev->enable_cnt));
 }
 static DEVICE_ATTR_RW(enable);
 
@@ -337,7 +327,7 @@ static ssize_t numa_node_store(struct device *dev,
 static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
-	return sprintf(buf, "%d\n", dev->numa_node);
+	return sysfs_emit(buf, "%d\n", dev->numa_node);
 }
 static DEVICE_ATTR_RW(numa_node);
 #endif
@@ -347,7 +337,7 @@ static ssize_t dma_mask_bits_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%d\n", fls64(pdev->dma_mask));
+	return sysfs_emit(buf, "%d\n", fls64(pdev->dma_mask));
 }
 static DEVICE_ATTR_RO(dma_mask_bits);
 
@@ -355,7 +345,7 @@ static ssize_t consistent_dma_mask_bits_show(struct device *dev,
 					     struct device_attribute *attr,
 					     char *buf)
 {
-	return sprintf(buf, "%d\n", fls64(dev->coherent_dma_mask));
+	return sysfs_emit(buf, "%d\n", fls64(dev->coherent_dma_mask));
 }
 static DEVICE_ATTR_RO(consistent_dma_mask_bits);
 
@@ -365,9 +355,9 @@ static ssize_t msi_bus_show(struct device *dev, struct device_attribute *attr,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pci_bus *subordinate = pdev->subordinate;
 
-	return sprintf(buf, "%u\n", subordinate ?
-		       !(subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI)
-			   : !pdev->no_msi);
+	return sysfs_emit(buf, "%u\n", subordinate ?
+			  !(subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI)
+			    : !pdev->no_msi);
 }
 
 static ssize_t msi_bus_store(struct device *dev, struct device_attribute *attr,
@@ -522,7 +512,7 @@ static ssize_t d3cold_allowed_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	return sprintf(buf, "%u\n", pdev->d3cold_allowed);
+	return sysfs_emit(buf, "%u\n", pdev->d3cold_allowed);
 }
 static DEVICE_ATTR_RW(d3cold_allowed);
 #endif
@@ -536,7 +526,7 @@ static ssize_t devspec_show(struct device *dev,
 
 	if (np == NULL)
 		return 0;
-	return sprintf(buf, "%pOF", np);
+	return sysfs_emit(buf, "%pOF", np);
 }
 static DEVICE_ATTR_RO(devspec);
 #endif
@@ -582,7 +572,7 @@ static ssize_t driver_override_show(struct device *dev,
 	ssize_t len;
 
 	device_lock(dev);
-	len = scnprintf(buf, PAGE_SIZE, "%s\n", pdev->driver_override);
+	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
 	device_unlock(dev);
 	return len;
 }
@@ -657,11 +647,11 @@ static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
 	struct pci_dev *vga_dev = vga_default_device();
 
 	if (vga_dev)
-		return sprintf(buf, "%u\n", (pdev == vga_dev));
+		return sysfs_emit(buf, "%u\n", (pdev == vga_dev));
 
-	return sprintf(buf, "%u\n",
-		!!(pdev->resource[PCI_ROM_RESOURCE].flags &
-		   IORESOURCE_ROM_SHADOW));
+	return sysfs_emit(buf, "%u\n",
+			  !!(pdev->resource[PCI_ROM_RESOURCE].flags &
+			     IORESOURCE_ROM_SHADOW));
 }
 static DEVICE_ATTR_RO(boot_vga);
 
-- 
2.31.0

