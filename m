Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 820154F234
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2019 02:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfFVAEb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 20:04:31 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:56586 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfFVAEa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2019 20:04:30 -0400
Received: by mail-qt1-f201.google.com with SMTP id p43so9712586qtk.23
        for <linux-pci@vger.kernel.org>; Fri, 21 Jun 2019 17:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QR1Fq3MnogoZDxR5LoHcfLT1JRgAByQ+Bas4Z8/9Vdo=;
        b=cfhgJlRMYlL1ZQu+27acnf30xFuMCjbXTCAainFoeEtW6sZfy4z78AwyGDy66Snw59
         pvtbyWjFtVqv2AKhiP7OGS07Od6EaserX0vCQ10ANdg4TLN7ndS3gF8OdAbzxSMsZSjY
         sgeyCW+DZbTYK5bDNnjil5OmnI6NDxkWpYVsoDss5Tq0elODK37VxHU4y9hCNubVo7H9
         D6Jc4/affqcgrEdydVrRLwyNXiUAVcnoLZVmNAKzcNEAxu/tKT5a4J7pWmeE/G0DMrk1
         UjiODKe8fvrl0qgaiKwOCtBZVX6C122MMiRCGRrT/OHEGYG0c08Il4sj/O4286/d7H/A
         e7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QR1Fq3MnogoZDxR5LoHcfLT1JRgAByQ+Bas4Z8/9Vdo=;
        b=OSny68EhaPSelzhGzFvbnrbmUB5Y7fxG3nZtJ9pwEtJMGc2O1tRgPsxDOcHLIVa2NS
         MG/ufZzvGaJ+WxAY3G+aRRekAS8LEfcQxr0LnmGhSxc+TDmsWXiSIsEN0CBrTRF9/Wyo
         SxaG0YIJagLFiUPbF9NoNWz8Cv+fHTq3HQyyWNTBmXcg1+vKSUMda5Y2YTl2VgN1sJ2h
         xLjVC7l9q4WaTfGYPgxwBg9CFy2P/7B06+XWc7aPFchlcldbX2HYEJ9ka3BJXuzOblry
         hq0k1zt5Z1ywUwT427p+HL93Pyc9f2mZ+glLDaLjUEtBVQBd86lCAkzWz5MW7GLm4sTa
         QjTQ==
X-Gm-Message-State: APjAAAViFteT80D1dW4zrXaJ0YpYL+9ADaLYjEJTaaRgshSL3p32fi0F
        1Vz3PozwRdqdQe1bolGEsjx+s4bnOrxmvGVv7vWAFw==
X-Google-Smtp-Source: APXvYqzqeYXV9vwwXpTuqXyUuPT7+AwixwFvcs5ahBxR269UhwHGbFEprjzHgFntrzvSS2eF903JUTvnb8Dc9mAG5s87nw==
X-Received: by 2002:a37:a98c:: with SMTP id s134mr109806733qke.176.1561161869518;
 Fri, 21 Jun 2019 17:04:29 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:40 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-12-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 11/29] PCI: Lock down BAR access when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
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
 drivers/pci/pci-sysfs.c      | 16 ++++++++++++++++
 drivers/pci/proc.c           | 14 ++++++++++++--
 drivers/pci/syscall.c        |  4 +++-
 include/linux/security.h     |  1 +
 security/lockdown/lockdown.c |  1 +
 5 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 25794c27c7a4..e1011efb5a31 100644
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
@@ -1165,6 +1170,11 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
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
@@ -1241,6 +1251,12 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
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
index 6fa1627ce08d..a72258d70407 100644
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
@@ -237,7 +246,8 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
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
index a051f21a1144..1b849f10dec6 100644
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
index ce5b3da9bd09..e2ee8a16b94c 100644
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

