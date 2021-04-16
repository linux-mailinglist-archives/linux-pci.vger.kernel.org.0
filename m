Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61353629D4
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343620AbhDPU7d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:59:33 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:36354 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343757AbhDPU7b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 16:59:31 -0400
Received: by mail-ed1-f43.google.com with SMTP id j12so8810222edy.3
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 13:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fNBXyVO7q0K7664XA5cwoU96TPUWCzHYpT1Rz6FpGu0=;
        b=aIAAoalPL3dX6zW1yBauQfHEEAZnruTHft+0worcil2PC99pNmccyT1bOEUyjUx2wp
         gxOvDjEXo0ASqlcD5q90OZegglmtyAkucr0GJUQTyUAiRJRgmviAM9m5vvjyk5Lmsh9e
         jTn5wxRWeqEdauW4tsCzkroHTwb3Ji/zPE6flFbZHyZA5cg4fcwclsSAiy//oKSwobcA
         zerCON2IGvagK8uVVC3NaJS8zSZOafZwQDaf+CoZSuQSbON2KBwPGCUuJ4uVmtffM36n
         aLYj41zWoVkiUNUwbekjZMVeDWXzUTCg5XG9JZqixr0XeN38ktU/nb7UOeuEWhHPbKKR
         169Q==
X-Gm-Message-State: AOAM532V60j5rlo6n3EKO76/Zq/mAvVV5c63X1SkRgqBMvdKeZTYuzHP
        0rQVVmzOf54ixakkbiN+LAY=
X-Google-Smtp-Source: ABdhPJyF4PYmWa4qBKIdX1Q+o75HSu70b2u8x2ta+hPVn2632Q3ZnZAXF3RvVGnqqOA0JiB+JxVtKQ==
X-Received: by 2002:aa7:d2cc:: with SMTP id k12mr12169348edr.374.1618606745677;
        Fri, 16 Apr 2021 13:59:05 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm5103864ejg.43.2021.04.16.13.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:59:05 -0700 (PDT)
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
Subject: [PATCH 08/20] PCI: Move to kstrtobool() to handle user input
Date:   Fri, 16 Apr 2021 20:58:44 +0000
Message-Id: <20210416205856.3234481-9-kw@linux.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210416205856.3234481-1-kw@linux.com>
References: <20210416205856.3234481-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A common use case for many PCI sysfs objects is to either enable some
functionality or trigger an action following a write to a given
attribute where the value is written would be simply either "1" or "0"
synonymous with either disabling or enabling something.

Parsing and validation of the input values are currently done using the
kstrtoul() function to convert anything in the string buffer into an
integer value - anything non-zero would be accepted as "enable" and zero
simply as "disable".

For a while now, the kernel offers another function called kstrtobool()
which was created to parse common user inputs into a boolean value, so
that a range of values such as "y", "n", "1", "0", "on" and "off"
handled in a case-insensitive manner would yield a boolean true or false
result accordingly after the input string has been parsed.

Thus, move to kstrtobool() over kstrtoul() as it's a better fit for
parsing user input, and it also implicitly offers a range check as only
a finite amount of possible input values will be considered as valid.

Where appropriate, move the user input parsing after checking for
whether the "CAP_SYS_ADMIN" flag is set, as it makes more sense to first
check whether the current user has the right permissions before
accepting any input from such user.

Related:

  commit d0f1fed29e6e ("Add a strtobool function matching semantics of existing in kernel equivalents")
  commit ef951599074b ("lib: move strtobool() to kstrtobool()")
  commit a81a5a17d44b ("lib: add "on"/"off" support to kstrtobool")
  commit 1404297ebf76 ("lib: update single-char callers of strtobool()")

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 90 ++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 07c3ddd7877e..9ee003cc4375 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -64,12 +64,12 @@ static ssize_t broken_parity_status_store(struct device *dev,
 					  const char *buf, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	unsigned long val;
+	bool broken;
 
-	if (kstrtoul(buf, 0, &val) < 0)
+	if (kstrtobool(buf, &broken) < 0)
 		return -EINVAL;
 
-	pdev->broken_parity_status = !!val;
+	pdev->broken_parity_status = !!broken;
 
 	return count;
 }
@@ -272,20 +272,20 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	unsigned long val;
-	ssize_t result = kstrtoul(buf, 0, &val);
-
-	if (result < 0)
-		return result;
+	bool enable;
+	ssize_t result = 0;
 
 	/* this can crash the machine when done on the "wrong" device */
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (kstrtobool(buf, &enable) < 0)
+		return -EINVAL;
+
 	device_lock(dev);
 	if (dev->driver)
 		result = -EBUSY;
-	else if (val)
+	else if (enable)
 		result = pci_enable_device(pdev);
 	else if (pci_is_enabled(pdev))
 		pci_disable_device(pdev);
@@ -312,14 +312,13 @@ static ssize_t numa_node_store(struct device *dev,
 			       size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	int node, ret;
+	int node;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	ret = kstrtoint(buf, 0, &node);
-	if (ret)
-		return ret;
+	if (kstrtoint(buf, 0, &node) < 0)
+		return -EINVAL;
 
 	if ((node < 0 && node != NUMA_NO_NODE) || node >= MAX_NUMNODES)
 		return -EINVAL;
@@ -376,46 +375,46 @@ static ssize_t msi_bus_store(struct device *dev, struct device_attribute *attr,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pci_bus *subordinate = pdev->subordinate;
-	unsigned long val;
-
-	if (kstrtoul(buf, 0, &val) < 0)
-		return -EINVAL;
+	bool allowed;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (kstrtobool(buf, &allowed) < 0)
+		return -EINVAL;
+
 	/*
 	 * "no_msi" and "bus_flags" only affect what happens when a driver
 	 * requests MSI or MSI-X.  They don't affect any drivers that have
 	 * already requested MSI or MSI-X.
 	 */
 	if (!subordinate) {
-		pdev->no_msi = !val;
+		pdev->no_msi = !allowed;
 		pci_info(pdev, "MSI/MSI-X %s for future drivers\n",
-			 val ? "allowed" : "disallowed");
+			 allowed ? "allowed" : "disallowed");
 		return count;
 	}
 
-	if (val)
+	if (allowed)
 		subordinate->bus_flags &= ~PCI_BUS_FLAGS_NO_MSI;
 	else
 		subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
 
 	dev_info(&subordinate->dev, "MSI/MSI-X %s for future drivers of devices on this bus\n",
-		 val ? "allowed" : "disallowed");
+		 allowed ? "allowed" : "disallowed");
 	return count;
 }
 static DEVICE_ATTR_RW(msi_bus);
 
 static ssize_t rescan_store(struct bus_type *bus, const char *buf, size_t count)
 {
-	unsigned long val;
+	bool rescan;
 	struct pci_bus *b = NULL;
 
-	if (kstrtoul(buf, 0, &val) < 0)
+	if (kstrtobool(buf, &rescan) < 0)
 		return -EINVAL;
 
-	if (val) {
+	if (rescan) {
 		pci_lock_rescan_remove();
 		while ((b = pci_find_next_bus(b)) != NULL)
 			pci_rescan_bus(b);
@@ -443,13 +442,13 @@ static ssize_t dev_rescan_store(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
 {
-	unsigned long val;
+	bool rescan;
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	if (kstrtoul(buf, 0, &val) < 0)
+	if (kstrtobool(buf, &rescan) < 0)
 		return -EINVAL;
 
-	if (val) {
+	if (rescan) {
 		pci_lock_rescan_remove();
 		pci_rescan_bus(pdev->bus);
 		pci_unlock_rescan_remove();
@@ -462,12 +461,12 @@ static struct device_attribute dev_attr_dev_rescan = __ATTR(rescan, 0200, NULL,
 static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
-	unsigned long val;
+	bool remove;
 
-	if (kstrtoul(buf, 0, &val) < 0)
+	if (kstrtobool(buf, &remove) < 0)
 		return -EINVAL;
 
-	if (val && device_remove_file_self(dev, attr))
+	if (remove && device_remove_file_self(dev, attr))
 		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
 	return count;
 }
@@ -478,13 +477,13 @@ static ssize_t bus_rescan_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
-	unsigned long val;
+	bool rescan;
 	struct pci_bus *bus = to_pci_bus(dev);
 
-	if (kstrtoul(buf, 0, &val) < 0)
+	if (kstrtobool(buf, &rescan) < 0)
 		return -EINVAL;
 
-	if (val) {
+	if (rescan) {
 		pci_lock_rescan_remove();
 		if (!pci_is_root_bus(bus) && list_empty(&bus->devices))
 			pci_rescan_bus_bridge_resize(bus->self);
@@ -503,12 +502,12 @@ static ssize_t d3cold_allowed_store(struct device *dev,
 				    const char *buf, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	unsigned long val;
+	bool allowed;
 
-	if (kstrtoul(buf, 0, &val) < 0)
+	if (kstrtobool(buf, &allowed) < 0)
 		return -EINVAL;
 
-	pdev->d3cold_allowed = !!val;
+	pdev->d3cold_allowed = !!allowed;
 	if (pdev->d3cold_allowed)
 		pci_d3cold_enable(pdev);
 	else
@@ -1257,12 +1256,13 @@ static ssize_t rom_write(struct file *filp, struct kobject *kobj,
 			 struct bin_attribute *bin_attr, char *buf,
 			 loff_t off, size_t count)
 {
+	bool allowed;
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
-	if ((off ==  0) && (*buf == '0') && (count == 2))
-		pdev->rom_attr_enabled = 0;
-	else
-		pdev->rom_attr_enabled = 1;
+	if (kstrtobool(buf, &allowed) < 0)
+		return -EINVAL;
+
+	pdev->rom_attr_enabled = !!allowed;
 
 	return count;
 }
@@ -1337,14 +1337,14 @@ static const struct attribute_group pci_dev_rom_attr_group = {
 static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
+	bool reset;
 	struct pci_dev *pdev = to_pci_dev(dev);
-	unsigned long val;
-	ssize_t result = kstrtoul(buf, 0, &val);
+	ssize_t result;
 
-	if (result < 0)
-		return result;
+	if (kstrtobool(buf, &reset) < 0)
+		return -EINVAL;
 
-	if (val != 1)
+	if (!reset)
 		return -EINVAL;
 
 	pm_runtime_get_sync(dev);
-- 
2.31.0

