Return-Path: <linux-pci+bounces-20133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFD2A16A09
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 10:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7F63A2FD3
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 09:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739E219AD8D;
	Mon, 20 Jan 2025 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kXY1ZzXI"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B0718801A;
	Mon, 20 Jan 2025 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737366945; cv=none; b=GjYLPExa133Dy2JfNCSvfjDwRXM6qjMuldPKRRA5F576g2qdxKpc5d5tTVmNVRJOcxzkB4uo8ANXuttizVmfMYr8pDhTOnFXxo7P/1leDVZyGdNqiGmu0BNXqBhm4OwHqZrFrUJ8Fkvq3sAA1+VznOcgz03LfoqQlUevLpwmjzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737366945; c=relaxed/simple;
	bh=I54i+ZWCVgGW5NTgibLD/RO6y/vU9wXDqKfm515KwTY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qvGOMn9ADiFq7u2MBSd3ZzuO65znLb0kVzeUmlnCzwld1WfxFaMyz4r1h+mHMMaMp4JCECIQWDFE3NhGcQRx3UIUHciRocWY0lKY6sqjT967LtsJ/mbGeNtP4y8h8fA2ujh2Kn3b2slzJASAREQLSHXKM4tVC6zruF8FXrasmd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kXY1ZzXI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1737366944; x=1768902944;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I54i+ZWCVgGW5NTgibLD/RO6y/vU9wXDqKfm515KwTY=;
  b=kXY1ZzXI9nHJPp2c7TQFeGBoqeNiJnlP3T9UNW9+BhNcsA0/SO8M4UfD
   LqAVBp0QWb0uqY9zU2Fh9tiXhqaUn7EbgH2kOLX/1oEpl+x9lpdvzhX/8
   80MHD+Mwl19dkQGwP+q0XrksLIZetY73/qoDc/Dimuy7h/vjq2M7j9Wo2
   F/kZvWplvfULcFtqncGeWAnlPPY4V2N92NUcEyifKDIpDjoyxgS2NyVoq
   3etikC/fsZiPwIXHGM6970O7cxg5EygluFoBWJ1hHhYnGwOaZBTk/Mlgn
   DrFsDm1zZCKYK4FVWHJaVmqA7lXTv0cn+BM4LHuIA7O8xOQ7HLxhXY/Yy
   w==;
X-CSE-ConnectionGUID: 07psnHMRRASIv3VVHpCQ7w==
X-CSE-MsgGUID: vQpb8xuBSJSGc4XqvvYdSw==
X-IronPort-AV: E=Sophos;i="6.13,218,1732604400"; 
   d="scan'208";a="36711325"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jan 2025 02:55:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 20 Jan 2025 02:55:29 -0700
Received: from che-ld-ungapp04.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 20 Jan 2025 02:55:27 -0700
From: Rakesh Babu Saladi <Saladi.Rakeshbabu@microchip.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<logang@deltatee.com>, <bhelgaas@google.com>, <kurt.schwemmer@microsemi.com>
CC: <unglinuxdriver@microchip.com>
Subject: [PATCH] PCI: switchtec: Include PCI100X devices support
Date: Mon, 20 Jan 2025 15:25:24 +0530
Message-ID: <20250120095524.243103-1-Saladi.Rakeshbabu@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the Microchip Parts to the existing device ID
table so that the driver supports PCI100x devices too.

Add a new macro to quirk the Microchip switchtec PCI100x parts
to allow DMA access via NTB to work when the IOMMU is turned on.

PCI100x family has 6 variants, each variant is designed for different
application usages, different port counts and lane counts.

PCI1001 has 1 x4 upstream port and 3 x4 downstream ports.
PCI1002 has 1 x4 upstream port and 4 x2 downstream ports.
PCI1003 has 2 x4 upstream ports, 2 x2 upstream ports and 2 x2
downstream ports.
PCI1004 has 4 x4 upstream ports.
PCI1005 has 1 x4 upstream port and 6 x2 downstream ports.
PCI1006 has 6 x2 upstream ports and 2 x2 downstream ports.

Signed-off-by: Rakesh Babu Saladi <Saladi.Rakeshbabu@microchip.com>
---
 drivers/pci/quirks.c           | 11 +++++++++++
 drivers/pci/switch/switchtec.c | 26 ++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index eeec1d6f9023..266ab5f8c6e1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5906,6 +5906,17 @@ SWITCHTEC_QUIRK(0x5552);  /* PAXA 52XG5 */
 SWITCHTEC_QUIRK(0x5536);  /* PAXA 36XG5 */
 SWITCHTEC_QUIRK(0x5528);  /* PAXA 28XG5 */
 
+#define SWITCHTEC_PCI100X_QUIRK(vid) \
+	DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_EFAR, vid, \
+		PCI_CLASS_BRIDGE_OTHER, 8, quirk_switchtec_ntb_dma_alias)
+SWITCHTEC_PCI100X_QUIRK(0x1001);  /* PCI1001XG4 */
+SWITCHTEC_PCI100X_QUIRK(0x1002);  /* PCI1002XG4 */
+SWITCHTEC_PCI100X_QUIRK(0x1003);  /* PCI1003XG4 */
+SWITCHTEC_PCI100X_QUIRK(0x1004);  /* PCI1004XG4 */
+SWITCHTEC_PCI100X_QUIRK(0x1005);  /* PCI1005XG4 */
+SWITCHTEC_PCI100X_QUIRK(0x1006);  /* PCI1006XG4 */
+
+
 /*
  * The PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints.
  * These IDs are used to forward responses to the originator on the other
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 5b921387eca6..faaca76407c8 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1726,6 +1726,26 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
 		.driver_data = gen, \
 	}
 
+#define SWITCHTEC_PCI100X_DEVICE(device_id, gen) \
+	{ \
+		.vendor     = PCI_VENDOR_ID_EFAR, \
+		.device     = device_id, \
+		.subvendor  = PCI_ANY_ID, \
+		.subdevice  = PCI_ANY_ID, \
+		.class      = (PCI_CLASS_MEMORY_OTHER << 8), \
+		.class_mask = 0xFFFFFFFF, \
+		.driver_data = gen, \
+	}, \
+	{ \
+		.vendor     = PCI_VENDOR_ID_EFAR, \
+		.device     = device_id, \
+		.subvendor  = PCI_ANY_ID, \
+		.subdevice  = PCI_ANY_ID, \
+		.class      = (PCI_CLASS_BRIDGE_OTHER << 8), \
+		.class_mask = 0xFFFFFFFF, \
+		.driver_data = gen, \
+	}
+
 static const struct pci_device_id switchtec_pci_tbl[] = {
 	SWITCHTEC_PCI_DEVICE(0x8531, SWITCHTEC_GEN3),  /* PFX 24xG3 */
 	SWITCHTEC_PCI_DEVICE(0x8532, SWITCHTEC_GEN3),  /* PFX 32xG3 */
@@ -1820,6 +1840,12 @@ static const struct pci_device_id switchtec_pci_tbl[] = {
 	SWITCHTEC_PCI_DEVICE(0x5552, SWITCHTEC_GEN5),  /* PAXA 52XG5 */
 	SWITCHTEC_PCI_DEVICE(0x5536, SWITCHTEC_GEN5),  /* PAXA 36XG5 */
 	SWITCHTEC_PCI_DEVICE(0x5528, SWITCHTEC_GEN5),  /* PAXA 28XG5 */
+	SWITCHTEC_PCI100X_DEVICE(0x1001, SWITCHTEC_GEN4),  /* PCI1001 16XG4 */
+	SWITCHTEC_PCI100X_DEVICE(0x1002, SWITCHTEC_GEN4),  /* PCI1002 12XG4 */
+	SWITCHTEC_PCI100X_DEVICE(0x1003, SWITCHTEC_GEN4),  /* PCI1003 16XG4 */
+	SWITCHTEC_PCI100X_DEVICE(0x1004, SWITCHTEC_GEN4),  /* PCI1004 16XG4 */
+	SWITCHTEC_PCI100X_DEVICE(0x1005, SWITCHTEC_GEN4),  /* PCI1005 16XG4 */
+	SWITCHTEC_PCI100X_DEVICE(0x1006, SWITCHTEC_GEN4),  /* PCI1006 16XG4 */
 	{0}
 };
 MODULE_DEVICE_TABLE(pci, switchtec_pci_tbl);
-- 
2.34.1


