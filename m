Return-Path: <linux-pci+bounces-42948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B37CB5C3D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 13:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FF633044847
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 12:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8F73093AE;
	Thu, 11 Dec 2025 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZFhWSYH3"
X-Original-To: linux-pci@vger.kernel.org
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CF030505F
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765454769; cv=none; b=K6QJj3SE/trR7DHDb3NaX96FqdURs7NgNNRDq4jt19WMdgH4LxREyGPc11kWpG4szGjHbQt6aIjCmhAsCkKCq7nhPxxjbYFWiGkXBpmHWa3SkYKf7fowaG1LaaKlxMHZV/kfjg2iUDPP1CvJn+WmYhCXPzrAlLM7ymkVAeE80q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765454769; c=relaxed/simple;
	bh=vgL5B2wk/9czsJ+BKbmpUVW6ha0UI/yjny3Cwdut958=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDh3jDDva/Ohob427H4stYGOGIrKKz5/YCGaxvVXW2U07qbVaCJ3REXH9qhtirz4UAJ6II6aH/k5vSfsu1vL1wXK9ZnTGQXRvsm5VT/rtqWaDj5HULA4syTiQN/CjTT3f/xQvcV5YBV2H5KoN0KxAnPM/Rsw1Wa6fYIt4tBZtcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZFhWSYH3; arc=none smtp.client-ip=47.90.199.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765454749; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pM7pG4XQi1UDdLWG06nTo+iCXAqYGabaigFq0F57cDc=;
	b=ZFhWSYH3NVxxaXUB/1YswbOVrFbmSBfD+txLxp/XgDUrpaWCxCp3ChC4AtqT45yVK0phkpLLzsEcaquKxigCjh3q6+zml0I6ZAe3pcnYH6zleu813NLV9B0eOd0UYwR9dM8YflN2YRe94G+rDePt/y2Bie3+keBiMzusT2H0Klk=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WuaJyGy_1765454744 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Dec 2025 20:05:48 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH v8 1/2] PCI: Introduce named defines for pci rom
Date: Thu, 11 Dec 2025 20:05:39 +0800
Message-ID: <20251211120540.3362-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251211120540.3362-1-kanie@linux.alibaba.com>
References: <20251211120540.3362-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preparation patch for the next fix patch.
Convert some magic numbers to named defines.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/pci/rom.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index e18d3a4383ba..3cb0e94f0e86 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -5,6 +5,8 @@
  * (C) Copyright 2004 Jon Smirl <jonsmirl@yahoo.com>
  * (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
  */
+
+#include <linux/bits.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/pci.h>
@@ -12,6 +14,16 @@
 
 #include "pci.h"
 
+#define PCI_ROM_HEADER_SIZE			0x1A
+#define PCI_ROM_POINTER_TO_DATA_STRUCT		0x18
+#define PCI_ROM_LAST_IMAGE_INDICATOR		0x15
+#define PCI_ROM_LAST_IMAGE_INDICATOR_BIT	BIT(7)
+#define PCI_ROM_IMAGE_LEN			0x10
+#define PCI_ROM_IMAGE_LEN_UNIT_SZ_512		512
+#define PCI_ROM_IMAGE_SIGNATURE			0xAA55
+#define PCI_ROM_DATA_STRUCT_SIGNATURE		0x52494350
+#define PCI_ROM_DATA_STRUCT_LEN			0x0A
+
 /**
  * pci_enable_rom - enable ROM decoding for a PCI device
  * @pdev: PCI device to enable
@@ -91,26 +103,27 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
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
+		image += length * PCI_ROM_IMAGE_LEN_UNIT_SZ_512;
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


