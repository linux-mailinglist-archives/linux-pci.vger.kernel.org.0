Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701C230D591
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 09:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhBCIvN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 03:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbhBCIvE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2021 03:51:04 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA65EC0613D6
        for <linux-pci@vger.kernel.org>; Wed,  3 Feb 2021 00:50:23 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a1so23217033wrq.6
        for <linux-pci@vger.kernel.org>; Wed, 03 Feb 2021 00:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4TN2rst9LRmCzPFUaWEqESF9NbkMdId6k7P+Ckralig=;
        b=WFf9vPUrQNUeYYoiG5Bdiq1+PUdmwPZl/EfiegBIeCPZkXWODNw5BJI8BAtETzKWLr
         r3qRyFdaYB+jJF6YqkhCGUAXpyxVZ0KR7v+O5jyGTrFnYHCV1wiwnx1ctDeV/Kb6MGea
         AR3Pe83/LPACrJXlAporcMnwr7fTaqzQj+YHSXuP8Nj6NLZr4LWcAZW6Hj9qSrovBN4N
         7eYKg1+YYJcGfcmtnDK5ptSkbXw2HOX0vlE3V9+QCGzf3PJeE3Zxw/ZdV5JZT4sUu+9e
         bf6yorm8SZo1Pp/g4Yxuy0iZigiHhBDf3Gu5H5jmr0+zs8zqimN5qhlCIJGFGRZPHFuH
         P3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4TN2rst9LRmCzPFUaWEqESF9NbkMdId6k7P+Ckralig=;
        b=sJR0XSWTrLcqX6428WZdQcilOQExsQhBt9FxqKpYO8xdrsylJRTusZsgpsBmK0GBSs
         LC+GnNYAGyQDxaDZsntj34Gi053m58vQBivsy2aouLTmHnH/M8CjBPTs8wAi4ONgsoFj
         4z/p1vQHRcq2QHJcUe308ntJ4Z0nboreRkdhjHtJt3sGi1YbgSPEYjUo81mJjkfH3fIb
         Db+WOoEVhpFYryvs7I2cjVznf2IuIiMbjV9yznS23oiMcCObTNnJYZ/i8qn9ZQHYP5JL
         mSSf109GsMJf4GvGR4GqQZFGOQ7x9QV8j66IyD6opyKDlb5DefjiRIi27+ro6iDwOgyV
         8nkQ==
X-Gm-Message-State: AOAM530nNkn/9unSpiJMSkEfIVfjjpZ5sdY+4NeKD7qJAdB2er3OM/aX
        Vq8aBb7feno9SxUNyJAR2qkGOTcAxyY=
X-Google-Smtp-Source: ABdhPJwjhr4HrOsqMHMP3+qt+71wa5ny8ZoUKiPWhvRtPl4mSUAUQXFZoQIrA1DHqxug7KQzBUs7Xw==
X-Received: by 2002:a5d:4e0e:: with SMTP id p14mr2275916wrt.58.1612342222184;
        Wed, 03 Feb 2021 00:50:22 -0800 (PST)
Received: from ?IPv6:2003:ea:8f1f:ad00:f08f:200e:76bc:9fee? (p200300ea8f1fad00f08f200e76bc9fee.dip0.t-ipconnect.de. [2003:ea:8f1f:ad00:f08f:200e:76bc:9fee])
        by smtp.googlemail.com with ESMTPSA id y14sm2431147wro.58.2021.02.03.00.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 00:50:21 -0800 (PST)
Subject: [PATCH v2 2/2] PCI/VPD: Let PCI sysfs core code handle VPD binary
 attribute
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <305704a7-f1da-a5a0-04e6-ee884be4f6da@gmail.com>
Message-ID: <7703024f-8882-9eec-a122-599871728a89@gmail.com>
Date:   Wed, 3 Feb 2021 09:50:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <305704a7-f1da-a5a0-04e6-ee884be4f6da@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since 104daa71b396 ("PCI: Determine actual VPD size on first access")
there's nothing that keeps us from using a static attribute.
This allows to use PCI sysfs core code for handling the attribute.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/pci-sysfs.c | 54 ++++++++++++++++++++++++++++++-----------
 drivers/pci/pci.h       |  2 --
 drivers/pci/vpd.c       | 54 -----------------------------------------
 3 files changed, 40 insertions(+), 70 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index fb072f4b3..ed2ded167 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -255,6 +255,25 @@ static ssize_t ari_enabled_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(ari_enabled);
 
+static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
+			struct bin_attribute *bin_attr, char *buf,
+			loff_t off, size_t count)
+{
+	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
+
+	return pci_read_vpd(dev, off, count, buf);
+}
+
+static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *bin_attr, char *buf,
+			 loff_t off, size_t count)
+{
+	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
+
+	return pci_write_vpd(dev, off, count, buf);
+}
+static BIN_ATTR_RW(vpd, 0);
+
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -621,6 +640,11 @@ static struct attribute *pci_dev_attrs[] = {
 	NULL,
 };
 
+static struct bin_attribute *pci_dev_bin_attrs[] = {
+	&bin_attr_vpd,
+	NULL,
+};
+
 static struct attribute *pci_bridge_attrs[] = {
 	&dev_attr_subordinate_bus_number.attr,
 	&dev_attr_secondary_bus_number.attr,
@@ -1323,20 +1347,10 @@ static DEVICE_ATTR(reset, 0200, NULL, reset_store);
 
 static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 {
-	int retval;
-
-	pcie_vpd_create_sysfs_dev_files(dev);
-
-	if (dev->reset_fn) {
-		retval = device_create_file(&dev->dev, &dev_attr_reset);
-		if (retval)
-			goto error;
-	}
-	return 0;
+	if (!dev->reset_fn)
+		return 0;
 
-error:
-	pcie_vpd_remove_sysfs_dev_files(dev);
-	return retval;
+	return device_create_file(&dev->dev, &dev_attr_reset);
 }
 
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
@@ -1409,7 +1423,6 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 
 static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
 {
-	pcie_vpd_remove_sysfs_dev_files(dev);
 	if (dev->reset_fn) {
 		device_remove_file(&dev->dev, &dev_attr_reset);
 		dev->reset_fn = 0;
@@ -1523,8 +1536,21 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
 	return 0;
 }
 
+static umode_t pci_dev_bin_attrs_visible(struct kobject *kobj,
+					 struct bin_attribute *a, int n)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	if (a == &bin_attr_vpd && !pdev->vpd)
+		return 0;
+
+	return a->attr.mode;
+}
+
 static const struct attribute_group pci_dev_group = {
 	.attrs = pci_dev_attrs,
+	.bin_attrs = pci_dev_bin_attrs,
+	.is_bin_visible = pci_dev_bin_attrs_visible,
 };
 
 const struct attribute_group *pci_dev_groups[] = {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ef7c46613..d6ad1a3e2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -143,8 +143,6 @@ static inline bool pcie_downstream_port(const struct pci_dev *dev)
 
 int pci_vpd_init(struct pci_dev *dev);
 void pci_vpd_release(struct pci_dev *dev);
-void pcie_vpd_create_sysfs_dev_files(struct pci_dev *dev);
-void pcie_vpd_remove_sysfs_dev_files(struct pci_dev *dev);
 
 /* PCI Virtual Channel */
 int pci_save_vc_state(struct pci_dev *dev);
diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 2096530ce..a33a8fd7e 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -21,7 +21,6 @@ struct pci_vpd_ops {
 
 struct pci_vpd {
 	const struct pci_vpd_ops *ops;
-	struct bin_attribute *attr;	/* Descriptor for sysfs VPD entry */
 	struct mutex	lock;
 	unsigned int	len;
 	u16		flag;
@@ -397,59 +396,6 @@ void pci_vpd_release(struct pci_dev *dev)
 	kfree(dev->vpd);
 }
 
-static ssize_t read_vpd_attr(struct file *filp, struct kobject *kobj,
-			     struct bin_attribute *bin_attr, char *buf,
-			     loff_t off, size_t count)
-{
-	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
-
-	return pci_read_vpd(dev, off, count, buf);
-}
-
-static ssize_t write_vpd_attr(struct file *filp, struct kobject *kobj,
-			      struct bin_attribute *bin_attr, char *buf,
-			      loff_t off, size_t count)
-{
-	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
-
-	return pci_write_vpd(dev, off, count, buf);
-}
-
-void pcie_vpd_create_sysfs_dev_files(struct pci_dev *dev)
-{
-	int retval;
-	struct bin_attribute *attr;
-
-	if (!dev->vpd)
-		return;
-
-	attr = kzalloc(sizeof(*attr), GFP_ATOMIC);
-	if (!attr)
-		return;
-
-	sysfs_bin_attr_init(attr);
-	attr->size = 0;
-	attr->attr.name = "vpd";
-	attr->attr.mode = S_IRUSR | S_IWUSR;
-	attr->read = read_vpd_attr;
-	attr->write = write_vpd_attr;
-	retval = sysfs_create_bin_file(&dev->dev.kobj, attr);
-	if (retval) {
-		kfree(attr);
-		return;
-	}
-
-	dev->vpd->attr = attr;
-}
-
-void pcie_vpd_remove_sysfs_dev_files(struct pci_dev *dev)
-{
-	if (dev->vpd && dev->vpd->attr) {
-		sysfs_remove_bin_file(&dev->dev.kobj, dev->vpd->attr);
-		kfree(dev->vpd->attr);
-	}
-}
-
 int pci_vpd_find_tag(const u8 *buf, unsigned int off, unsigned int len, u8 rdt)
 {
 	int i;
-- 
2.30.0


