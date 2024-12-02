Return-Path: <linux-pci+bounces-17553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1699E0BEC
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 20:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6514B39D29
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 19:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A66F1DE4F8;
	Mon,  2 Dec 2024 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ru/X1cQp"
X-Original-To: linux-pci@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C08F1DE3C4;
	Mon,  2 Dec 2024 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166182; cv=none; b=r9NdPQtXJyUAA02gVaUzpnvuCZ6U+dOFVVoKDeF2G0uwy+VqJB7GBPOh6kh6cb1uKT8jtSSqBybTaGNs5vqrLDz428f/1tW1GQOMi31QRH1db+ITMJBVwOz2GolfwsZsqO+uHoVCMCl2+f9YH8LWcSzzQR2LcRv8b8Y5LmX8ktY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166182; c=relaxed/simple;
	bh=uHM1UhfYdRZ6N8xcPihWTT3Dt+4pxM6VrmWQK6SvFgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z0CnzrR+8zeyGEMWKjBlOwKbzXLxhht8xJfSscl5jm7dSQxEIP0o9n824rvJilx8vICWcKmZE5dReZKob9NqwviKRzpVCfFyBoqF+pdKdRZiAPmfqimdJN+hYEW25OyXYrdi+fsNPnzc21mB6YC1Yj6Nhji+Q7MFIpiy+p6kJ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ru/X1cQp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733166178;
	bh=uHM1UhfYdRZ6N8xcPihWTT3Dt+4pxM6VrmWQK6SvFgE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ru/X1cQptkxJ/uVTFjmipOHc/DXjdiiDfBpRJ5ON9pPrmT6/8tim3oe8B+CqtZsWa
	 evlXrdSe13pjKywX6bGEU8KrzkxcldzZvnefUr0RMr3Eq4T1t6SLCkohK12RqOLGCt
	 fBtKkr2hJDQEXX5QSqkGSPkZPVti/GA77b22h0Rw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 02 Dec 2024 20:02:57 +0100
Subject: [PATCH 1/4] PCI/sysfs: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241202-sysfs-const-bin_attr-pci-v1-1-c32360f495a7@weissschuh.net>
References: <20241202-sysfs-const-bin_attr-pci-v1-0-c32360f495a7@weissschuh.net>
In-Reply-To: <20241202-sysfs-const-bin_attr-pci-v1-0-c32360f495a7@weissschuh.net>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Logan Gunthorpe <logang@deltatee.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733166177; l=6597;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=uHM1UhfYdRZ6N8xcPihWTT3Dt+4pxM6VrmWQK6SvFgE=;
 b=eHNiv2Nx/FBJHseNW5xk4DD74P9+Wq87tyeILQR7db+9m4lSIrM/JU+VYkbItpomaflhOe78z
 80fgFRKhZuoCwgxlIoUxrLRQFAT/Rvi6UPClaeSuOK83us05ej+pi21
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/pci/pci-sysfs.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 7679d75d71e534d4f3d1e1b4ae6c5ee5f8518ea1..6f1bb7514efb3281281fc7d9b9f1f8f9d501b969 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -694,7 +694,7 @@ static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR_RO(boot_vga);
 
 static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
-			       struct bin_attribute *bin_attr, char *buf,
+			       const struct bin_attribute *bin_attr, char *buf,
 			       loff_t off, size_t count)
 {
 	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
@@ -769,7 +769,7 @@ static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *bin_attr, char *buf,
+				const struct bin_attribute *bin_attr, char *buf,
 				loff_t off, size_t count)
 {
 	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
@@ -837,9 +837,9 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 
 	return count;
 }
-static BIN_ATTR(config, 0644, pci_read_config, pci_write_config, 0);
+static const BIN_ATTR(config, 0644, pci_read_config, pci_write_config, 0);
 
-static struct bin_attribute *pci_dev_config_attrs[] = {
+static const struct bin_attribute *const pci_dev_config_attrs[] = {
 	&bin_attr_config,
 	NULL,
 };
@@ -856,7 +856,7 @@ static size_t pci_dev_config_attr_bin_size(struct kobject *kobj,
 }
 
 static const struct attribute_group pci_dev_config_attr_group = {
-	.bin_attrs = pci_dev_config_attrs,
+	.bin_attrs_new = pci_dev_config_attrs,
 	.bin_size = pci_dev_config_attr_bin_size,
 };
 
@@ -887,8 +887,8 @@ pci_llseek_resource(struct file *filep,
  * callback routine (pci_legacy_read).
  */
 static ssize_t pci_read_legacy_io(struct file *filp, struct kobject *kobj,
-				  struct bin_attribute *bin_attr, char *buf,
-				  loff_t off, size_t count)
+				  const struct bin_attribute *bin_attr,
+				  char *buf, loff_t off, size_t count)
 {
 	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
 
@@ -912,8 +912,8 @@ static ssize_t pci_read_legacy_io(struct file *filp, struct kobject *kobj,
  * callback routine (pci_legacy_write).
  */
 static ssize_t pci_write_legacy_io(struct file *filp, struct kobject *kobj,
-				   struct bin_attribute *bin_attr, char *buf,
-				   loff_t off, size_t count)
+				   const struct bin_attribute *bin_attr,
+				   char *buf, loff_t off, size_t count)
 {
 	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
 
@@ -1003,8 +1003,8 @@ void pci_create_legacy_files(struct pci_bus *b)
 	b->legacy_io->attr.name = "legacy_io";
 	b->legacy_io->size = 0xffff;
 	b->legacy_io->attr.mode = 0600;
-	b->legacy_io->read = pci_read_legacy_io;
-	b->legacy_io->write = pci_write_legacy_io;
+	b->legacy_io->read_new = pci_read_legacy_io;
+	b->legacy_io->write_new = pci_write_legacy_io;
 	/* See pci_create_attr() for motivation */
 	b->legacy_io->llseek = pci_llseek_resource;
 	b->legacy_io->mmap = pci_mmap_legacy_io;
@@ -1099,7 +1099,7 @@ static int pci_mmap_resource_wc(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
-			       struct bin_attribute *attr, char *buf,
+			       const struct bin_attribute *attr, char *buf,
 			       loff_t off, size_t count, bool write)
 {
 #ifdef CONFIG_HAS_IOPORT
@@ -1142,14 +1142,14 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t pci_read_resource_io(struct file *filp, struct kobject *kobj,
-				    struct bin_attribute *attr, char *buf,
+				    const struct bin_attribute *attr, char *buf,
 				    loff_t off, size_t count)
 {
 	return pci_resource_io(filp, kobj, attr, buf, off, count, false);
 }
 
 static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
-				     struct bin_attribute *attr, char *buf,
+				     const struct bin_attribute *attr, char *buf,
 				     loff_t off, size_t count)
 {
 	int ret;
@@ -1210,8 +1210,8 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
 	} else {
 		sprintf(res_attr_name, "resource%d", num);
 		if (pci_resource_flags(pdev, num) & IORESOURCE_IO) {
-			res_attr->read = pci_read_resource_io;
-			res_attr->write = pci_write_resource_io;
+			res_attr->read_new = pci_read_resource_io;
+			res_attr->write_new = pci_write_resource_io;
 			if (arch_can_pci_mmap_io())
 				res_attr->mmap = pci_mmap_resource_uc;
 		} else {
@@ -1292,7 +1292,7 @@ void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
  * writing anything except 0 enables it
  */
 static ssize_t pci_write_rom(struct file *filp, struct kobject *kobj,
-			     struct bin_attribute *bin_attr, char *buf,
+			     const struct bin_attribute *bin_attr, char *buf,
 			     loff_t off, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
@@ -1318,7 +1318,7 @@ static ssize_t pci_write_rom(struct file *filp, struct kobject *kobj,
  * device corresponding to @kobj.
  */
 static ssize_t pci_read_rom(struct file *filp, struct kobject *kobj,
-			    struct bin_attribute *bin_attr, char *buf,
+			    const struct bin_attribute *bin_attr, char *buf,
 			    loff_t off, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
@@ -1344,9 +1344,9 @@ static ssize_t pci_read_rom(struct file *filp, struct kobject *kobj,
 
 	return count;
 }
-static BIN_ATTR(rom, 0600, pci_read_rom, pci_write_rom, 0);
+static const BIN_ATTR(rom, 0600, pci_read_rom, pci_write_rom, 0);
 
-static struct bin_attribute *pci_dev_rom_attrs[] = {
+static const struct bin_attribute *const pci_dev_rom_attrs[] = {
 	&bin_attr_rom,
 	NULL,
 };
@@ -1372,7 +1372,7 @@ static size_t pci_dev_rom_attr_bin_size(struct kobject *kobj,
 }
 
 static const struct attribute_group pci_dev_rom_attr_group = {
-	.bin_attrs = pci_dev_rom_attrs,
+	.bin_attrs_new = pci_dev_rom_attrs,
 	.is_bin_visible = pci_dev_rom_attr_is_visible,
 	.bin_size = pci_dev_rom_attr_bin_size,
 };

-- 
2.47.1


