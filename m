Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6193629DE
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244280AbhDPU7o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:59:44 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:37626 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343968AbhDPU7l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 16:59:41 -0400
Received: by mail-ej1-f49.google.com with SMTP id w3so44033715ejc.4
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 13:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QuzMAqSHj63WrHC/FbcYb9iuqVgBJBCPeYJtkJ/Y10w=;
        b=SudTsEqxburb2Qju64+ohazDlqW7BsTaT2gVA9hAw/VFOJyoTHm2cE3FbsyOW1Zi/6
         U5WKj97k1k0sAByZi+KlYDmMZlORp6rysBp3dF4G6XuaBYGUpw8Fl5dramR4GmQnvc4R
         NLm69YBK0Eh7Z7Vh/KJDVFJjN9LVuWxQ9VRNPiZCLaa0gS7O64yXqPl4RGEbo7JwSC3n
         YJfIPFwOpgnm2kzVEVQBr+Nb3xOkdXWT7VQxJWqP75it1FAyS8qaYDVvCqdziM2Bfwmh
         vuQkJaZVYLr5C4e9RjefgNcg/n1RWhYSC8rlCrZ1cyOk95vSV1KVuxnPcxaUuUFizX0j
         /F/g==
X-Gm-Message-State: AOAM532K4U79PG26zqPFCdOkwXEYSyuROt8tlctQq60453mibihQ//Es
        TPT7c034kJ0ni6+6/fvwqew=
X-Google-Smtp-Source: ABdhPJxshZ5evBhgHGTC7ixtmO+e6480PhIDTVhQdCLgaF2xBLD/C6VXm8PjgMBk0OLvr0tbhxNtsw==
X-Received: by 2002:a17:906:9385:: with SMTP id l5mr10276852ejx.32.1618606755885;
        Fri, 16 Apr 2021 13:59:15 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm5103864ejg.43.2021.04.16.13.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:59:15 -0700 (PDT)
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
Subject: [PATCH 18/20] PCI: Rearrange attributes from the pcie_dev_attr_group
Date:   Fri, 16 Apr 2021 20:58:54 +0000
Message-Id: <20210416205856.3234481-19-kw@linux.com>
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

Thus, collect all the attributes that are part of the "pcie_dev_attr_group"
attribute group together and move to the top of the file sorting
everything attribute in the order of use.

No functional change intended.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 106 ++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 1899c24081f7..44ce65bcacba 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -940,28 +940,29 @@ static const struct attribute_group pci_bridge_attr_group = {
 	.is_visible = pci_bridge_attr_is_visible,
 };
 
-/*
- * PCI Bus Class Devices
- */
-static ssize_t cpuaffinity_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t current_link_speed_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
 {
-	struct pci_bus *bus = to_pci_bus(dev);
-	const struct cpumask *cpumask = cpumask_of_pcibus(bus);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	enum pci_bus_speed speed;
 
-	return cpumap_print_to_pagebuf(false, buf, cpumask);
+	pcie_bandwidth_available(pdev, NULL, &speed, NULL);
+
+	return sysfs_emit(buf, "%s\n", pci_speed_string(speed));
 }
-static DEVICE_ATTR_RO(cpuaffinity);
+static DEVICE_ATTR_RO(current_link_speed);
 
-static ssize_t cpulistaffinity_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
+static ssize_t current_link_width_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
 {
-	struct pci_bus *bus = to_pci_bus(dev);
-	const struct cpumask *cpumask = cpumask_of_pcibus(bus);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	enum pcie_link_width width;
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask);
+	pcie_bandwidth_available(pdev, NULL, NULL, &width);
+
+	return sysfs_emit(buf, "%u\n", width);
 }
-static DEVICE_ATTR_RO(cpulistaffinity);
+static DEVICE_ATTR_RO(current_link_width);
 
 static ssize_t max_link_speed_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
@@ -982,29 +983,52 @@ static ssize_t max_link_width_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(max_link_width);
 
-static ssize_t current_link_speed_show(struct device *dev,
-				       struct device_attribute *attr, char *buf)
+static struct attribute *pcie_dev_attrs[] = {
+	&dev_attr_current_link_speed.attr,
+	&dev_attr_current_link_width.attr,
+	&dev_attr_max_link_speed.attr,
+	&dev_attr_max_link_width.attr,
+	NULL,
+};
+
+static umode_t pcie_dev_attr_is_visible(struct kobject *kobj,
+					struct attribute *a, int n)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	enum pci_bus_speed speed;
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
-	pcie_bandwidth_available(pdev, NULL, &speed, NULL);
+	if (!pci_is_pcie(pdev))
+		return 0;
 
-	return sysfs_emit(buf, "%s\n", pci_speed_string(speed));
+	return a->mode;
 }
-static DEVICE_ATTR_RO(current_link_speed);
 
-static ssize_t current_link_width_show(struct device *dev,
-				       struct device_attribute *attr, char *buf)
+static const struct attribute_group pcie_dev_attr_group = {
+	.attrs = pcie_dev_attrs,
+	.is_visible = pcie_dev_attr_is_visible,
+};
+
+/*
+ * PCI Bus Class Devices
+ */
+static ssize_t cpuaffinity_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	enum pcie_link_width width;
+	struct pci_bus *bus = to_pci_bus(dev);
+	const struct cpumask *cpumask = cpumask_of_pcibus(bus);
 
-	pcie_bandwidth_available(pdev, NULL, NULL, &width);
+	return cpumap_print_to_pagebuf(false, buf, cpumask);
+}
+static DEVICE_ATTR_RO(cpuaffinity);
 
-	return sysfs_emit(buf, "%u\n", width);
+static ssize_t cpulistaffinity_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct pci_bus *bus = to_pci_bus(dev);
+	const struct cpumask *cpumask = cpumask_of_pcibus(bus);
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask);
 }
-static DEVICE_ATTR_RO(current_link_width);
+static DEVICE_ATTR_RO(cpulistaffinity);
 
 static ssize_t rescan_store(struct bus_type *bus, const char *buf, size_t count)
 {
@@ -1063,14 +1087,6 @@ static ssize_t bus_rescan_store(struct device *dev,
 static struct device_attribute dev_attr_bus_rescan = __ATTR(rescan, 0200, NULL,
 							    bus_rescan_store);
 
-static struct attribute *pcie_dev_attrs[] = {
-	&dev_attr_current_link_speed.attr,
-	&dev_attr_current_link_width.attr,
-	&dev_attr_max_link_width.attr,
-	&dev_attr_max_link_speed.attr,
-	NULL,
-};
-
 static struct attribute *pcibus_attrs[] = {
 	&dev_attr_bus_rescan.attr,
 	&dev_attr_cpuaffinity.attr,
@@ -1555,17 +1571,6 @@ static int __init pci_sysfs_init(void)
 }
 late_initcall(pci_sysfs_init);
 
-static umode_t pcie_dev_attr_is_visible(struct kobject *kobj,
-					struct attribute *a, int n)
-{
-	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
-
-	if (!pci_is_pcie(pdev))
-		return 0;
-
-	return a->mode;
-}
-
 const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_group,
 	&pci_dev_config_attr_group,
@@ -1581,11 +1586,6 @@ const struct attribute_group *pci_dev_groups[] = {
 	NULL,
 };
 
-static const struct attribute_group pcie_dev_attr_group = {
-	.attrs = pcie_dev_attrs,
-	.is_visible = pcie_dev_attr_is_visible,
-};
-
 static const struct attribute_group *pci_dev_attr_groups[] = {
 	&pci_dev_attr_group,
 	&pci_dev_hp_attr_group,
-- 
2.31.0

