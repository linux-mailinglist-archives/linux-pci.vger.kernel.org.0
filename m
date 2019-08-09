Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFCBB8838C
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 21:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfHIT5c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 15:57:32 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42603 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfHIT5a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2019 15:57:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id l15so137138270otn.9;
        Fri, 09 Aug 2019 12:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QeE7q2BJkIjkpGDZgphDh+39oK407YM0dap/PDYMJHI=;
        b=kEcy4gAu2haY5Z6HTpOImskYlGxJkhQL7TR2JyIfBUE4WgUoI5fKnIqusJKp2bJCxR
         AyTn7j7Mx2iFS9APFS8nEgQ7YXOCXxe0Y9shbqncmfEJ7zFr1mySL78oXGOAeGl1p1ch
         2KBLmaqXyWzQ8GvDjqwlJv803mUif76il1xni945WF+oXQv8fa8iWOgB49Cze4PzA310
         5BMjHjFVFsdWsCKz6v/A2hNy87N5BiE98AeHNQ/4txGvpdEX7J4f0AeEsETimr3lpIo8
         AqMmfFj6HpIa/5ZgMfvkXZzNf+FE6iQiycLl+UX/VYK9U27h7B4nhbBJJnLCv3zkw9x6
         nRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QeE7q2BJkIjkpGDZgphDh+39oK407YM0dap/PDYMJHI=;
        b=miwGzPeDC/CDMJF4GDv2a1mnxu8cIQLH8bF47KQpEx5FOdkgbVCPEksIgBv8E5bE40
         94Ji+AnsIc5lW7Efn+xrLwmH74z4cGLXSE8sx/FPG6cwwfNLI7QCQ6QxZNDnkPno3HZ2
         i3UA7uuoXnA3tH8U1jgcc6rYffe+xl9FF2qBPa7wdqRYZaXOWdygjya1coOJDMpm5o4m
         yfHDvK3YhIL0HQ7xKZtwORvXVPHQG6vsi9yohqneTLhgjQVsyByfnlP6VAX5e+o0XEeL
         ijX7TqjOXfpVRDCahr/1a9/MmSj7Zllb6h1qUDb22xMbG2IeAcp6S31z8F6bwh1zVIdG
         2weA==
X-Gm-Message-State: APjAAAXxj2vOlPJlSE0nHpUq9t6LCbFNaun+CyuKnZgBT0zJrU7eo6dU
        Qn32okAxc5xs4pTkNtiRQ84=
X-Google-Smtp-Source: APXvYqzneuuJWfpFeg2GD5qM8Qo4P8uhAHfjCiSX4whFV27J8HogjCPfx02jyr5i2NybQVVWAZ2L+Q==
X-Received: by 2002:a5e:c914:: with SMTP id z20mr17224178iol.272.1565380648947;
        Fri, 09 Aug 2019 12:57:28 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id h8sm90331803ioq.61.2019.08.09.12.57.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 12:57:28 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skunberg.kelsey@gmail.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] PCI/IOV: Move sysfs SR-IOV functions to iov.c
Date:   Fri,  9 Aug 2019 13:57:21 -0600
Message-Id: <20190809195721.34237-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The sysfs SR-IOV functions are for an optional feature and will be better
organized to keep with the feature's code. Move the sysfs SR-IOV functions
to /pci/iov.c.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/iov.c       | 173 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-sysfs.c | 176 ----------------------------------------
 drivers/pci/pci.h       |   2 +-
 3 files changed, 174 insertions(+), 177 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 9b48818ced01..661051adf23f 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -240,6 +240,179 @@ void pci_iov_remove_virtfn(struct pci_dev *dev, int id)
 	pci_dev_put(dev);
 }
 
+static ssize_t sriov_totalvfs_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%u\n", pci_sriov_get_totalvfs(pdev));
+}
+
+static ssize_t sriov_numvfs_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%u\n", pdev->sriov->num_VFs);
+}
+
+/*
+ * num_vfs > 0; number of VFs to enable
+ * num_vfs = 0; disable all VFs
+ *
+ * Note: SRIOV spec does not allow partial VF
+ *       disable, so it's all or none.
+ */
+static ssize_t sriov_numvfs_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ret;
+	u16 num_vfs;
+
+	ret = kstrtou16(buf, 0, &num_vfs);
+	if (ret < 0)
+		return ret;
+
+	if (num_vfs > pci_sriov_get_totalvfs(pdev))
+		return -ERANGE;
+
+	device_lock(&pdev->dev);
+
+	if (num_vfs == pdev->sriov->num_VFs)
+		goto exit;
+
+	/* is PF driver loaded w/callback */
+	if (!pdev->driver || !pdev->driver->sriov_configure) {
+		pci_info(pdev, "Driver does not support SRIOV configuration via sysfs\n");
+		ret = -ENOENT;
+		goto exit;
+	}
+
+	if (num_vfs == 0) {
+		/* disable VFs */
+		ret = pdev->driver->sriov_configure(pdev, 0);
+		goto exit;
+	}
+
+	/* enable VFs */
+	if (pdev->sriov->num_VFs) {
+		pci_warn(pdev, "%d VFs already enabled. Disable before enabling %d VFs\n",
+			 pdev->sriov->num_VFs, num_vfs);
+		ret = -EBUSY;
+		goto exit;
+	}
+
+	ret = pdev->driver->sriov_configure(pdev, num_vfs);
+	if (ret < 0)
+		goto exit;
+
+	if (ret != num_vfs)
+		pci_warn(pdev, "%d VFs requested; only %d enabled\n",
+			 num_vfs, ret);
+
+exit:
+	device_unlock(&pdev->dev);
+
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t sriov_offset_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%u\n", pdev->sriov->offset);
+}
+
+static ssize_t sriov_stride_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%u\n", pdev->sriov->stride);
+}
+
+static ssize_t sriov_vf_device_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%x\n", pdev->sriov->vf_device);
+}
+
+static ssize_t sriov_drivers_autoprobe_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%u\n", pdev->sriov->drivers_autoprobe);
+}
+
+static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	bool drivers_autoprobe;
+
+	if (kstrtobool(buf, &drivers_autoprobe) < 0)
+		return -EINVAL;
+
+	pdev->sriov->drivers_autoprobe = drivers_autoprobe;
+
+	return count;
+}
+
+static struct device_attribute sriov_totalvfs_attr = __ATTR_RO(sriov_totalvfs);
+static struct device_attribute sriov_numvfs_attr =
+		__ATTR(sriov_numvfs, (S_IRUGO | S_IWUSR | S_IWGRP),
+		       sriov_numvfs_show, sriov_numvfs_store);
+static struct device_attribute sriov_offset_attr = __ATTR_RO(sriov_offset);
+static struct device_attribute sriov_stride_attr = __ATTR_RO(sriov_stride);
+static struct device_attribute sriov_vf_device_attr =
+		__ATTR_RO(sriov_vf_device);
+static struct device_attribute sriov_drivers_autoprobe_attr =
+		__ATTR(sriov_drivers_autoprobe, (S_IRUGO | S_IWUSR | S_IWGRP),
+		       sriov_drivers_autoprobe_show,
+		       sriov_drivers_autoprobe_store);
+
+static struct attribute *sriov_dev_attrs[] = {
+	&sriov_totalvfs_attr.attr,
+	&sriov_numvfs_attr.attr,
+	&sriov_offset_attr.attr,
+	&sriov_stride_attr.attr,
+	&sriov_vf_device_attr.attr,
+	&sriov_drivers_autoprobe_attr.attr,
+	NULL,
+};
+
+static umode_t sriov_attrs_are_visible(struct kobject *kobj,
+				       struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+
+	if (!dev_is_pf(dev))
+		return 0;
+
+	return a->mode;
+}
+
+const struct attribute_group sriov_dev_attr_group = {
+	.attrs = sriov_dev_attrs,
+	.is_visible = sriov_attrs_are_visible,
+};
+
 int __weak pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 {
 	return 0;
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 965c72104150..d5c35434810b 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -551,154 +551,6 @@ static ssize_t devspec_show(struct device *dev,
 static DEVICE_ATTR_RO(devspec);
 #endif
 
-#ifdef CONFIG_PCI_IOV
-static ssize_t sriov_totalvfs_show(struct device *dev,
-				   struct device_attribute *attr,
-				   char *buf)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	return sprintf(buf, "%u\n", pci_sriov_get_totalvfs(pdev));
-}
-
-
-static ssize_t sriov_numvfs_show(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	return sprintf(buf, "%u\n", pdev->sriov->num_VFs);
-}
-
-/*
- * num_vfs > 0; number of VFs to enable
- * num_vfs = 0; disable all VFs
- *
- * Note: SRIOV spec doesn't allow partial VF
- *       disable, so it's all or none.
- */
-static ssize_t sriov_numvfs_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	int ret;
-	u16 num_vfs;
-
-	ret = kstrtou16(buf, 0, &num_vfs);
-	if (ret < 0)
-		return ret;
-
-	if (num_vfs > pci_sriov_get_totalvfs(pdev))
-		return -ERANGE;
-
-	device_lock(&pdev->dev);
-
-	if (num_vfs == pdev->sriov->num_VFs)
-		goto exit;
-
-	/* is PF driver loaded w/callback */
-	if (!pdev->driver || !pdev->driver->sriov_configure) {
-		pci_info(pdev, "Driver doesn't support SRIOV configuration via sysfs\n");
-		ret = -ENOENT;
-		goto exit;
-	}
-
-	if (num_vfs == 0) {
-		/* disable VFs */
-		ret = pdev->driver->sriov_configure(pdev, 0);
-		goto exit;
-	}
-
-	/* enable VFs */
-	if (pdev->sriov->num_VFs) {
-		pci_warn(pdev, "%d VFs already enabled. Disable before enabling %d VFs\n",
-			 pdev->sriov->num_VFs, num_vfs);
-		ret = -EBUSY;
-		goto exit;
-	}
-
-	ret = pdev->driver->sriov_configure(pdev, num_vfs);
-	if (ret < 0)
-		goto exit;
-
-	if (ret != num_vfs)
-		pci_warn(pdev, "%d VFs requested; only %d enabled\n",
-			 num_vfs, ret);
-
-exit:
-	device_unlock(&pdev->dev);
-
-	if (ret < 0)
-		return ret;
-
-	return count;
-}
-
-static ssize_t sriov_offset_show(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	return sprintf(buf, "%u\n", pdev->sriov->offset);
-}
-
-static ssize_t sriov_stride_show(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	return sprintf(buf, "%u\n", pdev->sriov->stride);
-}
-
-static ssize_t sriov_vf_device_show(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	return sprintf(buf, "%x\n", pdev->sriov->vf_device);
-}
-
-static ssize_t sriov_drivers_autoprobe_show(struct device *dev,
-					    struct device_attribute *attr,
-					    char *buf)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	return sprintf(buf, "%u\n", pdev->sriov->drivers_autoprobe);
-}
-
-static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
-					     struct device_attribute *attr,
-					     const char *buf, size_t count)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	bool drivers_autoprobe;
-
-	if (kstrtobool(buf, &drivers_autoprobe) < 0)
-		return -EINVAL;
-
-	pdev->sriov->drivers_autoprobe = drivers_autoprobe;
-
-	return count;
-}
-
-static struct device_attribute sriov_totalvfs_attr = __ATTR_RO(sriov_totalvfs);
-static struct device_attribute sriov_numvfs_attr =
-		__ATTR(sriov_numvfs, (S_IRUGO|S_IWUSR|S_IWGRP),
-		       sriov_numvfs_show, sriov_numvfs_store);
-static struct device_attribute sriov_offset_attr = __ATTR_RO(sriov_offset);
-static struct device_attribute sriov_stride_attr = __ATTR_RO(sriov_stride);
-static struct device_attribute sriov_vf_device_attr = __ATTR_RO(sriov_vf_device);
-static struct device_attribute sriov_drivers_autoprobe_attr =
-		__ATTR(sriov_drivers_autoprobe, (S_IRUGO|S_IWUSR|S_IWGRP),
-		       sriov_drivers_autoprobe_show, sriov_drivers_autoprobe_store);
-#endif /* CONFIG_PCI_IOV */
-
 static ssize_t driver_override_store(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf, size_t count)
@@ -1697,34 +1549,6 @@ static const struct attribute_group pci_dev_hp_attr_group = {
 	.is_visible = pci_dev_hp_attrs_are_visible,
 };
 
-#ifdef CONFIG_PCI_IOV
-static struct attribute *sriov_dev_attrs[] = {
-	&sriov_totalvfs_attr.attr,
-	&sriov_numvfs_attr.attr,
-	&sriov_offset_attr.attr,
-	&sriov_stride_attr.attr,
-	&sriov_vf_device_attr.attr,
-	&sriov_drivers_autoprobe_attr.attr,
-	NULL,
-};
-
-static umode_t sriov_attrs_are_visible(struct kobject *kobj,
-				       struct attribute *a, int n)
-{
-	struct device *dev = kobj_to_dev(kobj);
-
-	if (!dev_is_pf(dev))
-		return 0;
-
-	return a->mode;
-}
-
-static const struct attribute_group sriov_dev_attr_group = {
-	.attrs = sriov_dev_attrs,
-	.is_visible = sriov_attrs_are_visible,
-};
-#endif /* CONFIG_PCI_IOV */
-
 static const struct attribute_group pci_dev_attr_group = {
 	.attrs = pci_dev_dev_attrs,
 	.is_visible = pci_dev_attrs_are_visible,
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 61bbfd611140..7e3c6c8ae6f9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -455,7 +455,7 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno);
 resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
 void pci_restore_iov_state(struct pci_dev *dev);
 int pci_iov_bus_range(struct pci_bus *bus);
-
+extern const struct attribute_group sriov_dev_attr_group;
 #else
 static inline int pci_iov_init(struct pci_dev *dev)
 {
-- 
2.20.1

