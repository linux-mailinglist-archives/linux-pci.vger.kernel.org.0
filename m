Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898903629DC
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343888AbhDPU7n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:59:43 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:38640 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343947AbhDPU7j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 16:59:39 -0400
Received: by mail-ed1-f52.google.com with SMTP id m3so33809395edv.5
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 13:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6qxNYzZBqS/3l+6iffEqt9nD120CmaQyJj6jPaGw3Nw=;
        b=RNAVIpVFt4KCa6oHr1MdBrxxUpZYMq608p9Kq8NT0zVexsFowsK7GEqodHk5wECLwd
         cw5YWoRdEZ5ETWPlYd6rCTOBapC/LRsMD1JwY6/EAojf3bQVGh853iCqXxPLVziGjcYD
         0kHGL4uKHOuxGgX4Y+3MrFgh+XDhnXfS0DKtbiv4BcNrIiDn11HbduKVlcPEoDMtyey2
         BfMEfw1LWwNAAV8MSYaMHWAs0Qf9wUV2H+GQ9MDta6IZwr72E+Ec4y7dPZUu1zsmmRvD
         RY3nnskWDCJH7TvHfyEW/VJsLvSqXV3F3Pj7rAqBYijddBzxhSCO30JJXY8h+MHdxXPD
         a5IA==
X-Gm-Message-State: AOAM533XbXcRH2d7j52Kh6L5hJchk5kTreKX4maHs5/FeIA0rOWRCIqA
        OLQPNCGHWRxbjWljEEONIhc=
X-Google-Smtp-Source: ABdhPJxSwupV8+2GHx4KMde0bKr/CYzofemZLeHLeCRkMLFoTx1PBB6mQjrW1lzjaFnSXEakAZpx5g==
X-Received: by 2002:a05:6402:b66:: with SMTP id cb6mr11504723edb.248.1618606753911;
        Fri, 16 Apr 2021 13:59:13 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm5103864ejg.43.2021.04.16.13.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:59:13 -0700 (PDT)
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
Subject: [PATCH 16/20] PCI: Rearrange attributes from the pci_dev_hp_attr_group
Date:   Fri, 16 Apr 2021 20:58:52 +0000
Message-Id: <20210416205856.3234481-17-kw@linux.com>
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

Thus, collect all the attributes that are part of the "pci_dev_hp_attr_group"
attribute group together and move to the top of the file sorting
everything attribute in the order of use.

No functional change intended.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 120 ++++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index fd89a391b1c7..bf909e9a9528 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -826,6 +826,66 @@ static const struct attribute_group pci_dev_attr_group = {
 	.is_visible = pci_dev_attr_is_visible,
 };
 
+static ssize_t remove_store(struct device *dev,
+			    struct device_attribute *attr, const char *buf,
+			    size_t count)
+{
+	bool remove;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (kstrtobool(buf, &remove) < 0)
+		return -EINVAL;
+
+	if (remove && device_remove_file_self(dev, attr))
+		pci_stop_and_remove_bus_device_locked(pdev);
+
+	return count;
+}
+static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL, remove_store);
+
+static ssize_t dev_rescan_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	bool rescan;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (kstrtobool(buf, &rescan) < 0)
+		return -EINVAL;
+
+	if (rescan) {
+		pci_lock_rescan_remove();
+		pci_rescan_bus(pdev->bus);
+		pci_unlock_rescan_remove();
+	}
+
+	return count;
+}
+static struct device_attribute dev_attr_dev_rescan = __ATTR(rescan, 0200, NULL,
+							    dev_rescan_store);
+
+static struct attribute *pci_dev_hp_attrs[] = {
+	&dev_attr_remove.attr,
+	&dev_attr_dev_rescan.attr,
+	NULL,
+};
+
+static umode_t pci_dev_hp_attr_is_visible(struct kobject *kobj,
+					  struct attribute *a, int n)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	if (pdev->is_virtfn)
+		return 0;
+
+	return a->mode;
+}
+
+static const struct attribute_group pci_dev_hp_attr_group = {
+	.attrs = pci_dev_hp_attrs,
+	.is_visible = pci_dev_hp_attr_is_visible,
+};
+
 /*
  * PCI Bus Class Devices
  */
@@ -957,44 +1017,6 @@ const struct attribute_group *pci_bus_groups[] = {
 	NULL,
 };
 
-static ssize_t dev_rescan_store(struct device *dev,
-				struct device_attribute *attr, const char *buf,
-				size_t count)
-{
-	bool rescan;
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	if (kstrtobool(buf, &rescan) < 0)
-		return -EINVAL;
-
-	if (rescan) {
-		pci_lock_rescan_remove();
-		pci_rescan_bus(pdev->bus);
-		pci_unlock_rescan_remove();
-	}
-
-	return count;
-}
-static struct device_attribute dev_attr_dev_rescan = __ATTR(rescan, 0200, NULL,
-							    dev_rescan_store);
-
-static ssize_t remove_store(struct device *dev,
-			    struct device_attribute *attr, const char *buf,
-			    size_t count)
-{
-	bool remove;
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	if (kstrtobool(buf, &remove) < 0)
-		return -EINVAL;
-
-	if (remove && device_remove_file_self(dev, attr))
-		pci_stop_and_remove_bus_device_locked(pdev);
-
-	return count;
-}
-static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL, remove_store);
-
 static ssize_t bus_rescan_store(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
@@ -1517,23 +1539,6 @@ static int __init pci_sysfs_init(void)
 }
 late_initcall(pci_sysfs_init);
 
-static struct attribute *pci_dev_hp_attrs[] = {
-	&dev_attr_remove.attr,
-	&dev_attr_dev_rescan.attr,
-	NULL,
-};
-
-static umode_t pci_dev_hp_attr_is_visible(struct kobject *kobj,
-					  struct attribute *a, int n)
-{
-	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
-
-	if (pdev->is_virtfn)
-		return 0;
-
-	return a->mode;
-}
-
 static umode_t pci_bridge_attr_is_visible(struct kobject *kobj,
 					  struct attribute *a, int n)
 {
@@ -1571,11 +1576,6 @@ const struct attribute_group *pci_dev_groups[] = {
 	NULL,
 };
 
-static const struct attribute_group pci_dev_hp_attr_group = {
-	.attrs = pci_dev_hp_attrs,
-	.is_visible = pci_dev_hp_attr_is_visible,
-};
-
 static const struct attribute_group pci_bridge_attr_group = {
 	.attrs = pci_bridge_attrs,
 	.is_visible = pci_bridge_attr_is_visible,
-- 
2.31.0

