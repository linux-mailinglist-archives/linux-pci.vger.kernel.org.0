Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16E540727E
	for <lists+linux-pci@lfdr.de>; Fri, 10 Sep 2021 22:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhIJU1p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Sep 2021 16:27:45 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:33716 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbhIJU1n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Sep 2021 16:27:43 -0400
Received: by mail-lf1-f49.google.com with SMTP id n2so6537183lfk.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Sep 2021 13:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DiOpE3WyY4/ZpnwxyMCEu2mtrwH7ajbKZ/RguIir4mo=;
        b=aHSO3/erFGZQci+jdq3IaYEJf/mT7qzogSsasMstiSd4LEK+kcamq9rU4gxOSskpOC
         R2cmzJC36k2G3YPMltOCBIHL86T2u28FmaEoBYVNmWkPgZcNhV8xcrOTIJMjN36A/fWo
         /6OoLREaOoJ46MLgOcv0UQyi3cJrXKlLwxz1dysvG6xS8iJ7EjEAkCuhFSBYBr8++CSb
         bjDytiNrhLGhP6Uk/vAgXpF2NRwQwIS65Q+kFM78XMCM840hnJ+nVhbqQ5IX+gkZio/A
         USfnZBdmcHBpGl8PUvyqi8UNfgCt5V2qVt8M6ataZX723UwQyYvN3fRFz9iW7oRh9MwC
         73LA==
X-Gm-Message-State: AOAM532Q11gGsyObs/sXx0ZY4Cj5OzoczZjSFfcoGOuZTt4TK+TyBF/c
        UydglNPv/5I6T22YKDGhP2A=
X-Google-Smtp-Source: ABdhPJxJfkyu33jxnUZklxnt02d2H3BlVWwnctdbhxrj3QR2ai2JYqm2BBLIwK7BkY3rwzQMLBJvBg==
X-Received: by 2002:ac2:4e90:: with SMTP id o16mr5161328lfr.473.1631305590743;
        Fri, 10 Sep 2021 13:26:30 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id a22sm657667lfb.17.2021.09.10.13.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:26:30 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 5/7] PCI/sysfs: Convert PCI resource files to static attributes
Date:   Fri, 10 Sep 2021 20:26:21 +0000
Message-Id: <20210910202623.2293708-6-kw@linux.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910202623.2293708-1-kw@linux.com>
References: <20210910202623.2293708-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI resource files are a series of sysfs objects that allow for
access to the PCI BAR address space.

Previously, the PCI resource files for platforms that provide either
the HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE definitions were
dynamically created by pci_bus_add_device() or the pci_sysfs_init()
late_initcall, but since these objects do not need to be created or
removed dynamically, we can use static attributes so the device model
takes care of addition and removal automatically.

Thus, convert the PCI resources files to static attributes on supported
platforms using the pci_dev_resource_attr() macro.  This macro makes use
of the .is_bin_visible() callback to support creating either normal or
write-combine attributes as required.

Platforms that do currently do not define either the HAVE_PCI_MMAP or
ARCH_GENERIC_PCI_MMAP_RESOURCE such as the Alpha platform can keep using
their platform-specific methods for adding PCI resources files.

Also remove pci_create_resource_files(), pci_remove_resource_files() and
pci_create_attr() functions, which are no longer needed.

The PCI resource files were first added in the pre-Git era:
  https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/drivers/pci/pci-sysfs.c?id=42298be0eeb5ae98453b3374c36161b05a46c5dc

Support for write-combine resources was added in commit 45aec1a ("x86:
PAT export resource_wc in pci sysfs").

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 129 ++++++++--------------------------------
 include/linux/pci.h     |   2 +
 2 files changed, 28 insertions(+), 103 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2031b5da6bcf..084c386c94c4 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1142,109 +1142,6 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
 	return pci_resource_io(filp, kobj, attr, buf, off, count, true);
 }
 
-/**
- * pci_remove_resource_files - cleanup resource files
- * @pdev: dev to cleanup
- *
- * If we created resource files for @pdev, remove them from sysfs and
- * free their resources.
- */
-static void pci_remove_resource_files(struct pci_dev *pdev)
-{
-	int i;
-
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		struct bin_attribute *res_attr;
-
-		res_attr = pdev->res_attr[i];
-		if (res_attr) {
-			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
-			kfree(res_attr);
-		}
-
-		res_attr = pdev->res_attr_wc[i];
-		if (res_attr) {
-			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
-			kfree(res_attr);
-		}
-	}
-}
-
-static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
-{
-	/* allocate attribute structure, piggyback attribute name */
-	int name_len = write_combine ? 13 : 10;
-	struct bin_attribute *res_attr;
-	char *res_attr_name;
-	int retval;
-
-	res_attr = kzalloc(sizeof(*res_attr) + name_len, GFP_ATOMIC);
-	if (!res_attr)
-		return -ENOMEM;
-
-	res_attr_name = (char *)(res_attr + 1);
-
-	sysfs_bin_attr_init(res_attr);
-	if (write_combine) {
-		pdev->res_attr_wc[num] = res_attr;
-		sprintf(res_attr_name, "resource%d_wc", num);
-		res_attr->mmap = pci_mmap_resource_wc;
-	} else {
-		pdev->res_attr[num] = res_attr;
-		sprintf(res_attr_name, "resource%d", num);
-		if (pci_resource_flags(pdev, num) & IORESOURCE_IO) {
-			res_attr->read = pci_read_resource_io;
-			res_attr->write = pci_write_resource_io;
-			if (arch_can_pci_mmap_io())
-				res_attr->mmap = pci_mmap_resource_uc;
-		} else {
-			res_attr->mmap = pci_mmap_resource_uc;
-		}
-	}
-	if (res_attr->mmap)
-		res_attr->f_mapping = iomem_get_mapping;
-	res_attr->attr.name = res_attr_name;
-	res_attr->attr.mode = 0600;
-	res_attr->size = pci_resource_len(pdev, num);
-	res_attr->private = (void *)(unsigned long)num;
-	retval = sysfs_create_bin_file(&pdev->dev.kobj, res_attr);
-	if (retval)
-		kfree(res_attr);
-
-	return retval;
-}
-
-/**
- * pci_create_resource_files - create resource files in sysfs for @dev
- * @pdev: dev in question
- *
- * Walk the resources in @pdev creating files for each resource available.
- */
-static int pci_create_resource_files(struct pci_dev *pdev)
-{
-	int i;
-	int retval;
-
-	/* Expose the PCI resources from this device as files */
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-
-		/* skip empty resources */
-		if (!pci_resource_len(pdev, i))
-			continue;
-
-		retval = pci_create_attr(pdev, i, 0);
-		/* for prefetchable resources, create a WC mappable file */
-		if (!retval && arch_can_pci_mmap_wc() &&
-		    pdev->resource[i].flags & IORESOURCE_PREFETCH)
-			retval = pci_create_attr(pdev, i, 1);
-		if (retval) {
-			pci_remove_resource_files(pdev);
-			return retval;
-		}
-	}
-	return 0;
-}
-
 static umode_t pci_dev_resource_attr_is_visible(struct kobject *kobj,
 						struct bin_attribute *a,
 						int bar, bool write_combine)
@@ -1329,6 +1226,13 @@ attribute_group pci_dev_resource##_bar##_wc_attr_group = {		\
 	&pci_dev_resource##_bar##_attr_group,	\
 	&pci_dev_resource##_bar##_wc_attr_group
 
+pci_dev_resource_attr(0);
+pci_dev_resource_attr(1);
+pci_dev_resource_attr(2);
+pci_dev_resource_attr(3);
+pci_dev_resource_attr(4);
+pci_dev_resource_attr(5);
+
 #else /* !(defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)) */
 int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
 void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
@@ -1470,6 +1374,10 @@ static const struct attribute_group pci_dev_reset_attr_group = {
 	.is_visible = pci_dev_reset_attr_is_visible,
 };
 
+#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
+int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev) { return 0; }
+void pci_remove_sysfs_dev_files(struct pci_dev *pdev) { }
+#else /* !(defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)) */
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	if (!sysfs_initialized)
@@ -1491,9 +1399,15 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 
 	pci_remove_resource_files(pdev);
 }
+#endif
 
 static int __init pci_sysfs_init(void)
 {
+#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
+	struct pci_bus *pbus = NULL;
+
+	sysfs_initialized = 1;
+#else /* !(defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)) */
 	struct pci_dev *pdev = NULL;
 	struct pci_bus *pbus = NULL;
 	int retval;
@@ -1507,6 +1421,7 @@ static int __init pci_sysfs_init(void)
 		}
 	}
 
+#endif
 	while ((pbus = pci_find_next_bus(pbus)))
 		pci_create_legacy_files(pbus);
 
@@ -1580,6 +1495,14 @@ static const struct attribute_group pci_dev_group = {
 
 const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_group,
+#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
+	pci_dev_resource_group(0),
+	pci_dev_resource_group(1),
+	pci_dev_resource_group(2),
+	pci_dev_resource_group(3),
+	pci_dev_resource_group(4),
+	pci_dev_resource_group(5),
+#endif
 	&pci_dev_config_attr_group,
 	&pci_dev_rom_attr_group,
 	&pci_dev_reset_attr_group,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cd8aa6fce204..51c632e5d0f7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -459,8 +459,10 @@ struct pci_dev {
 	u32		saved_config_space[16]; /* Config space saved at suspend time */
 	struct hlist_head saved_cap_space;
 	int		rom_attr_enabled;	/* Display of ROM attribute enabled? */
+#if !(defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE))
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
 	struct bin_attribute *res_attr_wc[DEVICE_COUNT_RESOURCE]; /* sysfs file for WC mapping of resources */
+#endif
 
 #ifdef CONFIG_HOTPLUG_PCI_PCIE
 	unsigned int	broken_cmd_compl:1;	/* No compl for some cmds */
-- 
2.33.0

