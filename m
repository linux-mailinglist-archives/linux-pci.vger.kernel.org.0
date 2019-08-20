Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACDF195294
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 02:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbfHTASm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 20:18:42 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:45387 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbfHTASk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Aug 2019 20:18:40 -0400
Received: by mail-vs1-f73.google.com with SMTP id v20so1382989vsi.12
        for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2019 17:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C21FECnausr3Tl5okiJoQyTfXKFmIyPVDnhM6LCvplE=;
        b=NH7bfyD5O+gMXQWiRJKY74n3aIL9gst/DgjEm7lzZ+DlpZ6d+uwgt5b3pnxuJZGuqt
         nGwavCYuxnDNUBKXsw8mf/7bnSf5H5Rp0lUsE9QwG5vSOHS1WIr+dJM8+IGcqBQVgAgv
         RR8ok4Qe/MQsYEsjVVvZ0pHppnTiHmt/0fCQut5r7f33QGlPhtUs23InXWb8oa/QElos
         0kHHFqTseiw/1hff9/LiaTJD0DkxK1VLmsFRvXL1Aix9SEcLFZqeRJtUo6JrVaeEQ3uF
         dbLGcqVdOGta+eIpB0Sa0qDDg2NWpi1/FlmsOfrWhUCE/T+f8sYfu6rDTgzYNPDbdNJQ
         HvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C21FECnausr3Tl5okiJoQyTfXKFmIyPVDnhM6LCvplE=;
        b=ASPV9YpWRJJ6Pnj1t5Q8ZAqokBujRqWO6+aYvx+PDH6ZZYxTRIxE5NEiS3xhWLSd2W
         GP5p+lGj8JbILVsFaGmn2NmDuxO90nWqeWts7wm6iBhN/UC/Af8cc5JQx+hmNRx+LcmG
         5chrtgu8YxMN5e2/kajWk8zdfGzuQBP0nWX524LXPaa392J+Xa67tN3svgEcHr6HfUB2
         4i5N0t66OP6nfJhfZBeADtPfygGYtxYfJO8JTG2hazEHM36CQKbuzbK+j2OQ4Wg1XqfR
         7hAPTn6U92OHo1FIwGNUqlmPFWWxiUjnOITRCCHndr7/+rjCHl6inBM41B0RfxEIf2FX
         5dYw==
X-Gm-Message-State: APjAAAXwHZdpPO/jvIV1jDCuM0VguWRHwL2jbTg8mxwiZ3XsAyaNFIbf
        U2eujomVMGyfvHrwOczF6iPjngfoHJlu7iGzLNElCg==
X-Google-Smtp-Source: APXvYqxN9EDYRByV2JMtzYzTa/IUcXtjUmQL77YxgWlXkE42Mz+D6/SFU+9rI4k9OcYzBwdXSj9Y9wb9pUwh8JDeCKt24w==
X-Received: by 2002:a05:6102:24c:: with SMTP id a12mr15472758vsq.226.1566260318809;
 Mon, 19 Aug 2019 17:18:38 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:47 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-12-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 11/29] PCI: Lock down BAR access when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kees Cook <keescook@chromium.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

Any hardware that can potentially generate DMA has to be locked down in
order to avoid it being possible for an attacker to modify kernel code,
allowing them to circumvent disabled module loading or module signing.
Default to paranoid - in future we can potentially relax this for
sufficiently IOMMU-isolated devices.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: linux-pci@vger.kernel.org
Signed-off-by: James Morris <jmorris@namei.org>
---
 drivers/pci/pci-sysfs.c      | 16 ++++++++++++++++
 drivers/pci/proc.c           | 14 ++++++++++++--
 drivers/pci/syscall.c        |  4 +++-
 include/linux/security.h     |  1 +
 security/lockdown/lockdown.c |  1 +
 5 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6d27475e39b2..ec103a7e13fc 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -903,6 +903,11 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 	unsigned int size = count;
 	loff_t init_off = off;
 	u8 *data = (u8 *) buf;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
+	if (ret)
+		return ret;
 
 	if (off > dev->cfg_size)
 		return 0;
@@ -1164,6 +1169,11 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 	int bar = (unsigned long)attr->private;
 	enum pci_mmap_state mmap_type;
 	struct resource *res = &pdev->resource[bar];
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
+	if (ret)
+		return ret;
 
 	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
 		return -EINVAL;
@@ -1240,6 +1250,12 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
 				     struct bin_attribute *attr, char *buf,
 				     loff_t off, size_t count)
 {
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
+	if (ret)
+		return ret;
+
 	return pci_resource_io(filp, kobj, attr, buf, off, count, true);
 }
 
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 445b51db75b0..e29b0d5ced62 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -13,6 +13,7 @@
 #include <linux/seq_file.h>
 #include <linux/capability.h>
 #include <linux/uaccess.h>
+#include <linux/security.h>
 #include <asm/byteorder.h>
 #include "pci.h"
 
@@ -115,7 +116,11 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 	struct pci_dev *dev = PDE_DATA(ino);
 	int pos = *ppos;
 	int size = dev->cfg_size;
-	int cnt;
+	int cnt, ret;
+
+	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
+	if (ret)
+		return ret;
 
 	if (pos >= size)
 		return 0;
@@ -196,6 +201,10 @@ static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
 #endif /* HAVE_PCI_MMAP */
 	int ret = 0;
 
+	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
+	if (ret)
+		return ret;
+
 	switch (cmd) {
 	case PCIIOC_CONTROLLER:
 		ret = pci_domain_nr(dev->bus);
@@ -238,7 +247,8 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 	struct pci_filp_private *fpriv = file->private_data;
 	int i, ret, write_combine = 0, res_bit = IORESOURCE_MEM;
 
-	if (!capable(CAP_SYS_RAWIO))
+	if (!capable(CAP_SYS_RAWIO) ||
+	    security_locked_down(LOCKDOWN_PCI_ACCESS))
 		return -EPERM;
 
 	if (fpriv->mmap_state == pci_mmap_io) {
diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
index d96626c614f5..31e39558d49d 100644
--- a/drivers/pci/syscall.c
+++ b/drivers/pci/syscall.c
@@ -7,6 +7,7 @@
 
 #include <linux/errno.h>
 #include <linux/pci.h>
+#include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 #include "pci.h"
@@ -90,7 +91,8 @@ SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
 	u32 dword;
 	int err = 0;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!capable(CAP_SYS_ADMIN) ||
+	    security_locked_down(LOCKDOWN_PCI_ACCESS))
 		return -EPERM;
 
 	dev = pci_get_domain_bus_and_slot(0, bus, dfn);
diff --git a/include/linux/security.h b/include/linux/security.h
index 80ac7fb27aa9..2b763f0ee352 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -107,6 +107,7 @@ enum lockdown_reason {
 	LOCKDOWN_DEV_MEM,
 	LOCKDOWN_KEXEC,
 	LOCKDOWN_HIBERNATION,
+	LOCKDOWN_PCI_ACCESS,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 3462f7edcaac..410e90eda848 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -22,6 +22,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
 	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
 	[LOCKDOWN_HIBERNATION] = "hibernation",
+	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.23.0.rc1.153.gdeed80330f-goog

