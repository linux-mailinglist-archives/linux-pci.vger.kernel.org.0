Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C543629DD
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343947AbhDPU7o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:59:44 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:39509 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343954AbhDPU7k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 16:59:40 -0400
Received: by mail-ej1-f51.google.com with SMTP id v6so42706287ejo.6
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 13:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=imUCWi5f0L0u44r4h5ePrxjMjkXDq587H6qCYb8kQvE=;
        b=PxclICk0vbACZjOXqP3DScizUQO0k0h26EHTBNUQZSDNYL7oUbQ9qK5GHZXmO9BLf1
         bTj4VzYThLqdPctiwz9fAK8EfHajZV+sVUh26K5jOGmg0xJbm4WaWnUfwzPoIB02mFE+
         0BXe3jCvweO62zveJHRNejqOsLZ5vg9xXiVyO1rkVZ5BGSrLHw073VjlhdY0H7HcH/wR
         lSlyOIkkzOVWTuPDmbfbdB0h9djW9romjs+rQKubMS9YMTqZPpJgwaWLpmc3q/sZGaA9
         aYKMi7kK/YclR/3wIXdncl6RpaBN8zLkayrcROV+QhjXrVJmvbs7YFyltAlQvslC5ZZI
         r1Jw==
X-Gm-Message-State: AOAM530B+7SP3TODVxMf7nh642CKjHYAhnCyzZgzcga2v6a1S33ZvxEo
        M9JILZCCIuHLLPV5u7FQoas=
X-Google-Smtp-Source: ABdhPJw5PQ1ZoXzIDd+BYON0gNtmEdml9gLAKllaEqpuZ/gPEM5mL2RMO9aizP/o61O5o4l6bky/Cg==
X-Received: by 2002:a17:907:f93:: with SMTP id kb19mr9993175ejc.207.1618606754838;
        Fri, 16 Apr 2021 13:59:14 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm5103864ejg.43.2021.04.16.13.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:59:14 -0700 (PDT)
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
Subject: [PATCH 17/20] PCI: Rearrange attributes from the pci_bridge_attr_group
Date:   Fri, 16 Apr 2021 20:58:53 +0000
Message-Id: <20210416205856.3234481-18-kw@linux.com>
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

Thus, collect all the attributes that are part of the "pci_bridge_attr_group"
attribute group together and move to the top of the file sorting
everything attribute in the order of use.

No functional change intended.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 108 ++++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index bf909e9a9528..1899c24081f7 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -886,6 +886,60 @@ static const struct attribute_group pci_dev_hp_attr_group = {
 	.is_visible = pci_dev_hp_attr_is_visible,
 };
 
+static ssize_t subordinate_bus_number_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u8 sub_bus;
+	int err;
+
+	err = pci_read_config_byte(pdev, PCI_SUBORDINATE_BUS, &sub_bus);
+	if (err)
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%u\n", sub_bus);
+}
+static DEVICE_ATTR_RO(subordinate_bus_number);
+
+static ssize_t secondary_bus_number_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u8 sec_bus;
+	int err;
+
+	err = pci_read_config_byte(pdev, PCI_SECONDARY_BUS, &sec_bus);
+	if (err)
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%u\n", sec_bus);
+}
+static DEVICE_ATTR_RO(secondary_bus_number);
+
+static struct attribute *pci_bridge_attrs[] = {
+	&dev_attr_subordinate_bus_number.attr,
+	&dev_attr_secondary_bus_number.attr,
+	NULL,
+};
+
+static umode_t pci_bridge_attr_is_visible(struct kobject *kobj,
+					  struct attribute *a, int n)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	if (!pci_is_bridge(pdev))
+		return 0;
+
+	return a->mode;
+}
+
+static const struct attribute_group pci_bridge_attr_group = {
+	.attrs = pci_bridge_attrs,
+	.is_visible = pci_bridge_attr_is_visible,
+};
+
 /*
  * PCI Bus Class Devices
  */
@@ -952,38 +1006,6 @@ static ssize_t current_link_width_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(current_link_width);
 
-static ssize_t secondary_bus_number_show(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	u8 sec_bus;
-	int err;
-
-	err = pci_read_config_byte(pdev, PCI_SECONDARY_BUS, &sec_bus);
-	if (err)
-		return -EINVAL;
-
-	return sysfs_emit(buf, "%u\n", sec_bus);
-}
-static DEVICE_ATTR_RO(secondary_bus_number);
-
-static ssize_t subordinate_bus_number_show(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	u8 sub_bus;
-	int err;
-
-	err = pci_read_config_byte(pdev, PCI_SUBORDINATE_BUS, &sub_bus);
-	if (err)
-		return -EINVAL;
-
-	return sysfs_emit(buf, "%u\n", sub_bus);
-}
-static DEVICE_ATTR_RO(subordinate_bus_number);
-
 static ssize_t rescan_store(struct bus_type *bus, const char *buf, size_t count)
 {
 	bool rescan;
@@ -1041,12 +1063,6 @@ static ssize_t bus_rescan_store(struct device *dev,
 static struct device_attribute dev_attr_bus_rescan = __ATTR(rescan, 0200, NULL,
 							    bus_rescan_store);
 
-static struct attribute *pci_bridge_attrs[] = {
-	&dev_attr_subordinate_bus_number.attr,
-	&dev_attr_secondary_bus_number.attr,
-	NULL,
-};
-
 static struct attribute *pcie_dev_attrs[] = {
 	&dev_attr_current_link_speed.attr,
 	&dev_attr_current_link_width.attr,
@@ -1539,17 +1555,6 @@ static int __init pci_sysfs_init(void)
 }
 late_initcall(pci_sysfs_init);
 
-static umode_t pci_bridge_attr_is_visible(struct kobject *kobj,
-					  struct attribute *a, int n)
-{
-	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
-
-	if (!pci_is_bridge(pdev))
-		return 0;
-
-	return a->mode;
-}
-
 static umode_t pcie_dev_attr_is_visible(struct kobject *kobj,
 					struct attribute *a, int n)
 {
@@ -1576,11 +1581,6 @@ const struct attribute_group *pci_dev_groups[] = {
 	NULL,
 };
 
-static const struct attribute_group pci_bridge_attr_group = {
-	.attrs = pci_bridge_attrs,
-	.is_visible = pci_bridge_attr_is_visible,
-};
-
 static const struct attribute_group pcie_dev_attr_group = {
 	.attrs = pcie_dev_attrs,
 	.is_visible = pcie_dev_attr_is_visible,
-- 
2.31.0

