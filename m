Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD6F69C32
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2019 22:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbfGOUAY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jul 2019 16:00:24 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:51300 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732359AbfGOUAY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jul 2019 16:00:24 -0400
Received: by mail-pg1-f202.google.com with SMTP id o16so11095995pgk.18
        for <linux-pci@vger.kernel.org>; Mon, 15 Jul 2019 13:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ae+mrOFMmNbS13ze66pnDjDUvUjQtnZm37VMj80uCqw=;
        b=kGFfI2kp0vs7fPFda0rD2APJ9FUrV8KTzNqZoDg9edVUXAPAhWyAJZJB52EkkhTI/c
         /BrBPHK65MG5bgvvfg05puV5Mlab7hsouQAse03MbALorI42GEC6hQyMYdtbYdHNwth7
         LlcI7b0LAgk4UKW7icylJnYyoumIzjfnCWYkPJbvsfsSXOApARGDo9Qhemk/Sj5mCFS/
         XrISpfX40sAI82HeH3JCWGTPG3BSDZl0pAU6zeieU5Ohx4dYOfA+TBJ0TWiyCfZcC4Al
         9OcDNLzQGxtgE2FBNAE9wc+feRb4+H4OJ8Z1F0eGsr2Ke1PEpRphHVx6ttvjK1wRbJCL
         Jucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ae+mrOFMmNbS13ze66pnDjDUvUjQtnZm37VMj80uCqw=;
        b=TlUNVtzdREIvoGdSP56uZgIGv+G595dQLO+vTq7J/yPBq7PscriSzAQnpJpyvUHj+J
         aT5Ez+CD+VcDD1xZSSkdPYmBAz5H8G1zy6L7aGQ3r8QIyOKC5ML+MX5erNybQ7bsd15I
         dtPebFElzRCPu5+HkSxR+gf2D5iq5KCU4Lf0SB9zRsd8KHN0U8t/OVb7CBuHYnByxnXs
         AXla9D9k38jFL7bCPmQhFZrnBARgHrhmXR9pg/yVJyWV0JkKcxN11J2WzKQFf05q1KwB
         qxIpmnVqdhAfjk3x4qjn1Z/fJWBAhbb4FOv1MWjXC3g+x7ilgQ7Ahdv38Pn1uqfss/rp
         nNwQ==
X-Gm-Message-State: APjAAAX9LWlFCtRsLcTrq+pn8V27EvjLwuRAWHIzvff2UclaLrk824yr
        VTMMgcZhBMf4oBi741ggl+rwnRIiWIDuYjAYoE92mQ==
X-Google-Smtp-Source: APXvYqyzcgU5WIiPz+emFhgYiHrUTwZNIxdL53YE0B46ZawKgz5c0wLyRLQu0utk9KLAZ5cT6sTvAoaR/wM/K78n7LhW/g==
X-Received: by 2002:a63:5823:: with SMTP id m35mr29162482pgb.329.1563220822679;
 Mon, 15 Jul 2019 13:00:22 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:28 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-12-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 11/29] PCI: Lock down BAR access when the kernel is locked down
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
index 304a155a5628..8adbd62b7669 100644
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
index a0996f75629f..655fe388e615 100644
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
2.22.0.510.g264f2c817a-goog

