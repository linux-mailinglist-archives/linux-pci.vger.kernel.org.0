Return-Path: <linux-pci+bounces-42955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C4CCB5F49
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 13:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 316503012BCB
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 12:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EA33009F4;
	Thu, 11 Dec 2025 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FIykEm7v"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4039E2FF648
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765457962; cv=none; b=fBdcJJWioZntuUID9S4Gvs01QTs0iD1YgtXe3lBEThjYPWwGQaZmZ6B1a/eU7Iev4h88ICSgeg5IgZ9LmKoFtvrOK5mhFICckRrg1bYTn7E39I9lBCX4rcfqHAPAL7Na0QL53uc8/wifwg0FGeF1j/qJ2Z1uhocJeJ0phFvG27s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765457962; c=relaxed/simple;
	bh=Up29Y0ACWFVsb86J8cdgNSzyZvmPNeznDEpoFpF9WpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAeCOBVmc8NLaMo1QoxtC72L6o8iGGlYGkGyj5S1aVmw3EpGRw7RWAmLRtOG/CYMdljxLjLCGLubXma2wVUPy2tpfi25Bl+wT4RF9Y4J9ZGGtGwmjTKuUtU02iEsgrBOuZ3X4/wXxm5S0A0RkexcmF/vpdnubruU8DHqk+OR/3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FIykEm7v; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765457955; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hd9Z0MrAy5o3q/a1/FvE2qMtTyv4IqVzZA7VkVp7lXI=;
	b=FIykEm7vCxcF5EtJeC0ezCQaw/X+F6jwEelJv3v/FBpl5bePPhJ0bVqgvxKOrCCPrFbvTX4V7K+pd6YgYH8X6ohcfQH4wNzD9VSkX13kipN91YS/GEmnK1+y7JV8eHMe6eo0BAVSV1jIrd+JCJr3Ogj0yHhjyDhKdGAlubG7wTg=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WuaVNw0_1765457950 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Dec 2025 20:59:14 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH v9 1/2] PCI: Introduce named defines for pci rom
Date: Thu, 11 Dec 2025 20:59:05 +0800
Message-ID: <20251211125906.57027-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251211125906.57027-1-kanie@linux.alibaba.com>
References: <20251211125906.57027-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the magic numbers associated with PCI ROM into named
definitions. Some of these definitions will be used in the second
fix patch.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/pci/rom.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index e18d3a4383ba..e2e37a9090f1 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -5,13 +5,26 @@
  * (C) Copyright 2004 Jon Smirl <jonsmirl@yahoo.com>
  * (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
  */
+
+#include <linux/bits.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/sizes.h>
 
 #include "pci.h"
 
+#define PCI_ROM_HEADER_SIZE			0x1A
+#define PCI_ROM_POINTER_TO_DATA_STRUCT		0x18
+#define PCI_ROM_LAST_IMAGE_INDICATOR		0x15
+#define PCI_ROM_LAST_IMAGE_INDICATOR_BIT	BIT(7)
+#define PCI_ROM_IMAGE_LEN			0x10
+#define PCI_ROM_IMAGE_LEN_UNIT_BYTES		SZ_512
+#define PCI_ROM_IMAGE_SIGNATURE			0xAA55
+#define PCI_ROM_DATA_STRUCT_SIGNATURE		0x52494350
+#define PCI_ROM_DATA_STRUCT_LEN			0x0A
+
 /**
  * pci_enable_rom - enable ROM decoding for a PCI device
  * @pdev: PCI device to enable
@@ -91,26 +104,27 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
 	do {
 		void __iomem *pds;
 		/* Standard PCI ROMs start out with these bytes 55 AA */
-		if (readw(image) != 0xAA55) {
-			pci_info(pdev, "Invalid PCI ROM header signature: expecting 0xaa55, got %#06x\n",
-				 readw(image));
+		if (readw(image) != PCI_ROM_IMAGE_SIGNATURE) {
+			pci_info(pdev, "Invalid PCI ROM header signature: expecting %#06x, got %#06x\n",
+				 PCI_ROM_IMAGE_SIGNATURE, readw(image));
 			break;
 		}
 		/* get the PCI data structure and check its "PCIR" signature */
-		pds = image + readw(image + 24);
-		if (readl(pds) != 0x52494350) {
-			pci_info(pdev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
-				 readl(pds));
+		pds = image + readw(image + PCI_ROM_POINTER_TO_DATA_STRUCT);
+		if (readl(pds) != PCI_ROM_DATA_STRUCT_SIGNATURE) {
+			pci_info(pdev, "Invalid PCI ROM data signature: expecting %#010x, got %#010x\n",
+				 PCI_ROM_DATA_STRUCT_SIGNATURE, readl(pds));
 			break;
 		}
-		last_image = readb(pds + 21) & 0x80;
-		length = readw(pds + 16);
-		image += length * 512;
+		last_image = readb(pds + PCI_ROM_LAST_IMAGE_INDICATOR) &
+				   PCI_ROM_LAST_IMAGE_INDICATOR_BIT;
+		length = readw(pds + PCI_ROM_IMAGE_LEN);
+		image += length * PCI_ROM_IMAGE_LEN_UNIT_BYTES;
 		/* Avoid iterating through memory outside the resource window */
 		if (image >= rom + size)
 			break;
 		if (!last_image) {
-			if (readw(image) != 0xAA55) {
+			if (readw(image) != PCI_ROM_IMAGE_SIGNATURE) {
 				pci_info(pdev, "No more image in the PCI ROM\n");
 				break;
 			}
-- 
2.43.0


