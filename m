Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BB93BC399
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 23:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhGEVZt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 17:25:49 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:42747 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhGEVZs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 17:25:48 -0400
Received: by mail-lf1-f41.google.com with SMTP id u18so3566394lff.9
        for <linux-pci@vger.kernel.org>; Mon, 05 Jul 2021 14:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bGeSwqA1PGXcdIOF0QAiLqEJhbJ0OkQQxp/nfQHOIqY=;
        b=JENuCy66XMjkJvRuwYM5F8HfSxgo7r5bktNHFdEWKLqQ4cqH3/nl7Y2/iwD7yZbh1F
         8+kEngufjfDazvcPGex6UVOYFJDMtmp5GV8N+NeSyrsE7cbCtNA+DdNN5ZaTkbI4tlmX
         8sY/H9+io8aEGZjkjcXMQeex0Bq6DA+u7vNCPiur2qtmO9eHI7s05Y3GqGMdNejaz117
         uR1PajYRoRW0NX2zx2zhg1qySYEzmTbvWPejSIkjAkXnBl6f/eJkUZ0qqWQqNhIKdzlt
         5zDQ5upu3JucaR34g6E0oU/QypIm8ymo/2pqw6jSIA3pzXoZJZvXMvMsI3ekvMXPse8d
         mSng==
X-Gm-Message-State: AOAM532eQzA1CtBd/GWKHr3JGLP3rB9dKgiLNYpFMdTbxfR0uLaTpUjJ
        srDrJ0DE8HyYj4Zi91PXU/W2BxesU+2Gig==
X-Google-Smtp-Source: ABdhPJzShMJwcE3V/Ip2Cl5pjlDE6NEt2XLoOt5uFufuOsQ7yuh7H+PygdYVD/jxeSTaouGV27SU/g==
X-Received: by 2002:a05:6512:32a4:: with SMTP id q4mr7011633lfe.252.1625520190212;
        Mon, 05 Jul 2021 14:23:10 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id x1sm1191338lfa.21.2021.07.05.14.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 14:23:09 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/4] PCI/sysfs: Move to kstrtobool() to handle user input
Date:   Mon,  5 Jul 2021 21:23:05 +0000
Message-Id: <20210705212308.3050976-1-kw@linux.com>
X-Mailer: git-send-email 2.32.0
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

Related:
  commit d0f1fed29e6e ("Add a strtobool function matching semantics of existing in kernel equivalents")
  commit ef951599074b ("lib: move strtobool() to kstrtobool()")
  commit a81a5a17d44b ("lib: add "on"/"off" support to kstrtobool")
  commit 1404297ebf76 ("lib: update single-char callers of strtobool()")

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 97 ++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 50 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index beb8d1f4fafe..0f98c4843764 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -63,13 +63,13 @@ static ssize_t broken_parity_status_store(struct device *dev,
 					  struct device_attribute *attr,
 					  const char *buf, size_t count)
 {
+	bool enable;
 	struct pci_dev *pdev = to_pci_dev(dev);
-	unsigned long val;
 
-	if (kstrtoul(buf, 0, &val) < 0)
+	if (kstrtobool(buf, &enable) < 0)
 		return -EINVAL;
 
-	pdev->broken_parity_status = !!val;
+	pdev->broken_parity_status = enable;
 
 	return count;
 }
@@ -271,12 +271,12 @@ static DEVICE_ATTR_RO(modalias);
 static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
+	bool enable;
 	struct pci_dev *pdev = to_pci_dev(dev);
-	unsigned long val;
-	ssize_t result = kstrtoul(buf, 0, &val);
+	ssize_t result = 0;
 
-	if (result < 0)
-		return result;
+	if (kstrtobool(buf, &enable) < 0)
+		return -EINVAL;
 
 	/* this can crash the machine when done on the "wrong" device */
 	if (!capable(CAP_SYS_ADMIN))
@@ -285,7 +285,7 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
 	device_lock(dev);
 	if (dev->driver)
 		result = -EBUSY;
-	else if (val)
+	else if (enable)
 		result = pci_enable_device(pdev);
 	else if (pci_is_enabled(pdev))
 		pci_disable_device(pdev);
@@ -311,15 +311,14 @@ static ssize_t numa_node_store(struct device *dev,
 			       struct device_attribute *attr, const char *buf,
 			       size_t count)
 {
+	int node;
 	struct pci_dev *pdev = to_pci_dev(dev);
-	int node, ret;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	ret = kstrtoint(buf, 0, &node);
-	if (ret)
-		return ret;
+	if (kstrtoint(buf, 0, &node) < 0)
+		return -EINVAL;
 
 	if ((node < 0 && node != NUMA_NO_NODE) || node >= MAX_NUMNODES)
 		return -EINVAL;
@@ -374,11 +373,11 @@ static ssize_t msi_bus_show(struct device *dev, struct device_attribute *attr,
 static ssize_t msi_bus_store(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
+	bool enable;
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pci_bus *subordinate = pdev->subordinate;
-	unsigned long val;
 
-	if (kstrtoul(buf, 0, &val) < 0)
+	if (kstrtobool(buf, &enable) < 0)
 		return -EINVAL;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -390,32 +389,32 @@ static ssize_t msi_bus_store(struct device *dev, struct device_attribute *attr,
 	 * already requested MSI or MSI-X.
 	 */
 	if (!subordinate) {
-		pdev->no_msi = !val;
+		pdev->no_msi = !enable;
 		pci_info(pdev, "MSI/MSI-X %s for future drivers\n",
-			 val ? "allowed" : "disallowed");
+			 enable ? "allowed" : "disallowed");
 		return count;
 	}
 
-	if (val)
+	if (enable)
 		subordinate->bus_flags &= ~PCI_BUS_FLAGS_NO_MSI;
 	else
 		subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
 
 	dev_info(&subordinate->dev, "MSI/MSI-X %s for future drivers of devices on this bus\n",
-		 val ? "allowed" : "disallowed");
+		 enable ? "allowed" : "disallowed");
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
@@ -502,14 +501,14 @@ static ssize_t d3cold_allowed_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	bool allowed;
 	struct pci_dev *pdev = to_pci_dev(dev);
-	unsigned long val;
 
-	if (kstrtoul(buf, 0, &val) < 0)
+	if (kstrtobool(buf, &allowed) < 0)
 		return -EINVAL;
 
-	pdev->d3cold_allowed = !!val;
-	if (pdev->d3cold_allowed)
+	pdev->d3cold_allowed = allowed;
+	if (allowed)
 		pci_d3cold_enable(pdev);
 	else
 		pci_d3cold_disable(pdev);
@@ -1257,12 +1256,13 @@ static ssize_t pci_write_rom(struct file *filp, struct kobject *kobj,
 			     struct bin_attribute *bin_attr, char *buf,
 			     loff_t off, size_t count)
 {
+	bool enable;
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
-	if ((off ==  0) && (*buf == '0') && (count == 2))
-		pdev->rom_attr_enabled = 0;
-	else
-		pdev->rom_attr_enabled = 1;
+	if (kstrtobool(buf, &enable) < 0)
+		return -EINVAL;
+
+	pdev->rom_attr_enabled = enable;
 
 	return count;
 }
@@ -1337,23 +1337,20 @@ static const struct attribute_group pci_dev_rom_attr_group = {
 static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
+	bool reset;
 	struct pci_dev *pdev = to_pci_dev(dev);
-	unsigned long val;
-	ssize_t result = kstrtoul(buf, 0, &val);
-
-	if (result < 0)
-		return result;
+	ssize_t result = 0;
 
-	if (val != 1)
+	if (kstrtobool(buf, &reset) < 0)
 		return -EINVAL;
 
-	pm_runtime_get_sync(dev);
-	result = pci_reset_function(pdev);
-	pm_runtime_put(dev);
-	if (result < 0)
-		return result;
+	if (reset) {
+		pm_runtime_get_sync(dev);
+		result = pci_reset_function(pdev);
+		pm_runtime_put(dev);
+	}
 
-	return count;
+	return result < 0 ? result : count;
 }
 static DEVICE_ATTR_WO(reset);
 
-- 
2.32.0

