Return-Path: <linux-pci+bounces-11311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C1D947E11
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 17:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69EF2841DF
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 15:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2B615EFBD;
	Mon,  5 Aug 2024 15:24:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB36715B57C;
	Mon,  5 Aug 2024 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871467; cv=none; b=lRrI0tsWqu7KxU63V20dHNZexxfe0HasU1yNnkZCL6bmunG2VM7L0PB7a7lQ6w0YDOccGnT1g3BnbSfGh95vpdZCTsksgYrXCk9A2NdNlRfBYEAvXm/2Z19Vh6UMK+8y7/LmFR3F5CcsbyLaYQbcL6kbxx7eufg1/gIy/BHn2VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871467; c=relaxed/simple;
	bh=zO6iSk8R1JCdLWyy4O6A3cfcFyMwQqDks2Y7cB7hlsk=;
	h=Message-Id:From:Date:Subject:To:Cc; b=OxPE3vNUGueLhsRZbhFLQaFMFSR//OxuUYf7blIa3kNpUBNVx00wh8FLMv1Tx6rF2t8WmeeevPXpos3MZY0e+ZmWvr16PdxwwBAWq0ouLffgDddHnyYAtRTU9UQQkf8e4AnuLCUN2jVlR/ZC9btLvr1hWJzI0FKpefvv8JtRE1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id E3C36300002AF;
	Mon,  5 Aug 2024 17:24:14 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CD9F8E4BC; Mon,  5 Aug 2024 17:24:14 +0200 (CEST)
Message-Id: <7b970f7923e373d1b23784721208f93418720485.1722870934.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 5 Aug 2024 17:24:05 +0200
Subject: [PATCH] s390/pci: Stop usurping pdev->dev.groups
To: Niklas Schnelle <schnelle@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, Alistair Francis <alistair23@gmail.com>, Jonathan.Cameron@huawei.com, alex.williamson@redhat.com, christian.koenig@amd.com, kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com, chaitanyak@nvidia.com, rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>, Sebastian Ott <sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Bjorn suggests using pdev->dev.groups for attribute_groups constructed
on PCI device enumeration:

   "Is it feasible to build an attribute group in pci_doe_init() and
    add it to dev->groups so device_add() will automatically add them?"
    https://msgid.link/20231019165829.GA1381099@bhelgaas

Unfortunately on s390, pcibios_device_add() usurps pdev->dev.groups for
arch-specific attribute_groups, preventing its use for anything else.

Introduce an ARCH_PCI_DEV_GROUPS macro which arches can define in
<asm/pci.h>.  The macro is visible in drivers/pci/pci-sysfs.c through
the inclusion of <linux/pci.h>, which in turn includes <asm/pci.h>.

On s390, define the macro to the three attribute_groups previously
assigned to pdev->dev.groups.  Thereby pdev->dev.groups is made
available for use by the PCI core.

As a side effect, arch/s390/pci/pci_sysfs.c no longer needs to be
compiled into the kernel if CONFIG_SYSFS=n.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 arch/s390/include/asm/pci.h |  9 ++++++++-
 arch/s390/pci/Makefile      |  3 ++-
 arch/s390/pci/pci.c         |  1 -
 arch/s390/pci/pci_sysfs.c   | 14 ++++----------
 drivers/pci/pci-sysfs.c     |  5 +++++
 5 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 30820a6..9d920ce 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -191,7 +191,14 @@ static inline bool zdev_enabled(struct zpci_dev *zdev)
 	return (zdev->fh & (1UL << 31)) ? true : false;
 }
 
-extern const struct attribute_group *zpci_attr_groups[];
+extern const struct attribute_group zpci_attr_group;
+extern const struct attribute_group pfip_attr_group;
+extern const struct attribute_group zpci_ident_attr_group;
+
+#define ARCH_PCI_DEV_GROUPS &zpci_attr_group,		 \
+			    &pfip_attr_group,		 \
+			    &zpci_ident_attr_group,
+
 extern unsigned int s390_pci_force_floating __initdata;
 extern unsigned int s390_pci_no_rid;
 
diff --git a/arch/s390/pci/Makefile b/arch/s390/pci/Makefile
index 0547a10..2c21f03 100644
--- a/arch/s390/pci/Makefile
+++ b/arch/s390/pci/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the s390 PCI subsystem.
 #
 
-obj-$(CONFIG_PCI)	+= pci.o pci_irq.o pci_clp.o pci_sysfs.o \
+obj-$(CONFIG_PCI)	+= pci.o pci_irq.o pci_clp.o \
 			   pci_event.o pci_debug.o pci_insn.o pci_mmio.o \
 			   pci_bus.o pci_kvm_hook.o
 obj-$(CONFIG_PCI_IOV)	+= pci_iov.o
+obj-$(CONFIG_SYSFS)	+= pci_sysfs.o
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index cff4838..bd9624c 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -587,7 +587,6 @@ int pcibios_device_add(struct pci_dev *pdev)
 	if (pdev->is_physfn)
 		pdev->no_vf_scan = 1;
 
-	pdev->dev.groups = zpci_attr_groups;
 	zpci_map_resources(pdev);
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
index 0f4f1e8..1f81f6f 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -197,7 +197,7 @@ static umode_t zpci_index_is_visible(struct kobject *kobj,
 	NULL,
 };
 
-static struct attribute_group zpci_ident_attr_group = {
+const struct attribute_group zpci_ident_attr_group = {
 	.attrs = zpci_ident_attrs,
 	.is_visible = zpci_index_is_visible,
 };
@@ -223,7 +223,7 @@ static umode_t zpci_index_is_visible(struct kobject *kobj,
 	NULL,
 };
 
-static struct attribute_group zpci_attr_group = {
+const struct attribute_group zpci_attr_group = {
 	.attrs = zpci_dev_attrs,
 	.bin_attrs = zpci_bin_attrs,
 };
@@ -235,14 +235,8 @@ static umode_t zpci_index_is_visible(struct kobject *kobj,
 	&dev_attr_segment3.attr,
 	NULL,
 };
-static struct attribute_group pfip_attr_group = {
+
+const struct attribute_group pfip_attr_group = {
 	.name = "pfip",
 	.attrs = pfip_attrs,
 };
-
-const struct attribute_group *zpci_attr_groups[] = {
-	&zpci_attr_group,
-	&pfip_attr_group,
-	&zpci_ident_attr_group,
-	NULL,
-};
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 40cfa71..5d0f4db 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -31,6 +31,10 @@
 #include <linux/aperture.h>
 #include "pci.h"
 
+#ifndef ARCH_PCI_DEV_GROUPS
+#define ARCH_PCI_DEV_GROUPS
+#endif
+
 static int sysfs_initialized;	/* = 0 */
 
 /* show configuration fields */
@@ -1624,6 +1628,7 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
 	&pci_dev_acpi_attr_group,
 #endif
 	&pci_dev_resource_resize_group,
+	ARCH_PCI_DEV_GROUPS
 	NULL,
 };
 
-- 
2.43.0


