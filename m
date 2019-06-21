Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC334DE71
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 03:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfFUBUT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 21:20:19 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:44625 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfFUBUT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2019 21:20:19 -0400
Received: by mail-vk1-f201.google.com with SMTP id m1so1919359vkl.11
        for <linux-pci@vger.kernel.org>; Thu, 20 Jun 2019 18:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cq9xxUSBxvrYMk9MXakXLthVefrg+hCixnWCHiwuLcc=;
        b=TqWIA2YKqZX0yQEbFqGJZzIXtPBZCBzVoK0cY2KHMnE5PUCREycd/462jOMgayn8/l
         Mab6Kv6xZJqaNu2OKDgmAwtYHJdBNUDvPWtKfWQAASVvNPcp1qav3pXad7oqE+FBzOpB
         cHdJMRjUTsfjSgKhgyY5gyljrmlp2KPfAfEGq5hKi52scMv7rIdg/Qa8BurO9O3nfnHy
         OIHyLYPR2XskPnc8mlJMUyibmpSyYMQazx3xiD8GIycmT1S3P4ARU038jBNUzvzZdbro
         EO0AUk9klnZEMhf7kRf1CY/II1vQzfe315+hvSwh24XQfFTUzk0q65RqqZXDcaTpkwLf
         1ruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cq9xxUSBxvrYMk9MXakXLthVefrg+hCixnWCHiwuLcc=;
        b=bX2ZYMNhuEUIttMRpLujrpq/hesnBOtCcLgZIq4p8teQ7Jrygyte18+LSQwWPz/TPf
         plCNIPkFvLD6Xdo/0cfTdZMv0ZR0r8czQcNJCn4AZNN2EJXIBiXO5ATJccj6mH4oKNJ/
         CQO8Pf52HhE/E6BZA8GTVggMp7zyxbuVLA28dA2uqOSlOqUoSyNXdz+2T63biQY1m48F
         0/xI55oZGFg+J5wHjUdAGrQD3UpeMfM4+BVhJiZqrABm4uGf0Gmu/foDWV8T1SeV0iVy
         am8w6SjOmuhE2akMRDJtDorX5XuRsAYZCSU8aYb50Qrruki51J2+BZBJVzBHk6/rORJb
         e12w==
X-Gm-Message-State: APjAAAVpFAssSj8YS0QX+fc+mGlz7yj0sXT9a8htamg0hB8iz2yHBUdm
        lzXuJfQcwbCOloaLmi9sL39pfkm/iYC1NLFID1ta0w==
X-Google-Smtp-Source: APXvYqyK/mHdVK5vBxd1Ia8QuuPtii1qq23hu0rbS0Wq3mcY3Tt9J2/V4eLnS9qsdvGlHugPdCH5mJzn/hq9LLv6OBtcrQ==
X-Received: by 2002:a67:cb06:: with SMTP id b6mr71717295vsl.65.1561080018101;
 Thu, 20 Jun 2019 18:20:18 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:23 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-13-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 12/30] PCI: Lock down BAR access when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
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
cc: linux-pci@vger.kernel.org
---
 drivers/pci/pci-sysfs.c      |  9 +++++++++
 drivers/pci/proc.c           | 10 +++++++++-
 drivers/pci/syscall.c        |  4 +++-
 include/linux/security.h     |  1 +
 security/lockdown/lockdown.c |  1 +
 5 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 25794c27c7a4..00625267a5e4 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -904,6 +904,9 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 	loff_t init_off = off;
 	u8 *data = (u8 *) buf;
 
+	if (security_is_locked_down(LOCKDOWN_PCI_ACCESS))
+		return -EPERM;
+
 	if (off > dev->cfg_size)
 		return 0;
 	if (off + count > dev->cfg_size) {
@@ -1166,6 +1169,9 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 	enum pci_mmap_state mmap_type;
 	struct resource *res = &pdev->resource[bar];
 
+	if (security_is_locked_down(LOCKDOWN_PCI_ACCESS))
+		return -EPERM;
+
 	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
 		return -EINVAL;
 
@@ -1241,6 +1247,9 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
 				     struct bin_attribute *attr, char *buf,
 				     loff_t off, size_t count)
 {
+	if (security_is_locked_down(LOCKDOWN_PCI_ACCESS))
+		return -EPERM;
+
 	return pci_resource_io(filp, kobj, attr, buf, off, count, true);
 }
 
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 6fa1627ce08d..56e438bbefa4 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -13,6 +13,7 @@
 #include <linux/seq_file.h>
 #include <linux/capability.h>
 #include <linux/uaccess.h>
+#include <linux/security.h>
 #include <asm/byteorder.h>
 #include "pci.h"
 
@@ -117,6 +118,9 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 	int size = dev->cfg_size;
 	int cnt;
 
+	if (security_is_locked_down(LOCKDOWN_PCI_ACCESS))
+		return -EPERM;
+
 	if (pos >= size)
 		return 0;
 	if (nbytes >= size)
@@ -196,6 +200,9 @@ static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
 #endif /* HAVE_PCI_MMAP */
 	int ret = 0;
 
+	if (security_is_locked_down(LOCKDOWN_PCI_ACCESS))
+		return -EPERM;
+
 	switch (cmd) {
 	case PCIIOC_CONTROLLER:
 		ret = pci_domain_nr(dev->bus);
@@ -237,7 +244,8 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 	struct pci_filp_private *fpriv = file->private_data;
 	int i, ret, write_combine = 0, res_bit = IORESOURCE_MEM;
 
-	if (!capable(CAP_SYS_RAWIO))
+	if (!capable(CAP_SYS_RAWIO) ||
+	    security_is_locked_down(LOCKDOWN_PCI_ACCESS))
 		return -EPERM;
 
 	if (fpriv->mmap_state == pci_mmap_io) {
diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
index d96626c614f5..54f0a7721104 100644
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
+	    security_is_locked_down(LOCKDOWN_PCI_ACCESS))
 		return -EPERM;
 
 	dev = pci_get_domain_bus_and_slot(0, bus, dfn);
diff --git a/include/linux/security.h b/include/linux/security.h
index deac722f0d86..95aa5ac1fa6b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -86,6 +86,7 @@ enum lockdown_reason {
 	LOCKDOWN_DEV_MEM,
 	LOCKDOWN_KEXEC,
 	LOCKDOWN_HIBERNATION,
+	LOCKDOWN_PCI_ACCESS,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 42b7bc467ef6..ae76a7cce7ba 100644
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
2.22.0.410.gd8fdbe21b5-goog

