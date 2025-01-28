Return-Path: <linux-pci+bounces-20486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E43D7A2101E
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 19:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE951188B091
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 17:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369FF1F9A92;
	Tue, 28 Jan 2025 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5fHiTRT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B5E1DFE31;
	Tue, 28 Jan 2025 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738086875; cv=none; b=tG5kcYte6eocWMXt90Ch3urZ8KXKz3OEG7Lh4SFdN9fjYg3pZpzBQEe6au79M7+tndsqhYV/TrgxIxLZyWmWbq+2j7bWcnfsZ4alLI05MISxGmUHJJegpzFDhI2s/9/wyY/3/i1kEHLcojSGGnSuKnOeRywx77ZwZB6dPNZqdRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738086875; c=relaxed/simple;
	bh=FP4JMx1kDPqHVig1/xbN38mmVj2/GFnOYNM/DOkg480=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ot0AfEM/zBYy2GUBfiUwSjQIerWILVnmnvpEmc0Abn0zlI3wHVWLK7VZiDcf3SC7BFSsBOkDcFLYggjfXmnrU3DXx5YUfpqxAfGc5ejOmNOhA4oenOpxDs1HhD62afPVIepqRmh4vvhEZTHJaOEQdNU32lRmHYFQ05yHtGGeN8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5fHiTRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAE2C4CEE2;
	Tue, 28 Jan 2025 17:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738086874;
	bh=FP4JMx1kDPqHVig1/xbN38mmVj2/GFnOYNM/DOkg480=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n5fHiTRTKh0ZMRZPsfVisvjIr1njesmcTZr5G8C8/dtKRnkW6wcu6eIJ9KaFdGR0w
	 AfoJznFW1/UCPrJMpeOoRNgkze85/tSe1C+lqvZ+12SRF+ZNeXc3wt/oQ//KvRpDh+
	 JOzXkPwfrgXxBVl4ADnQt6No+UFwDZbp37Y/eHL46nWA3F9j8oBoYPvJFuKLmQrcmM
	 h6TV1er7UTC3E54htZ88dKzOd/z7X4jYPfHhs1R8PUa58/CEoTsBue+4njAtWuSmuT
	 HHhfA2ezbHkGifZSYSlDKJhO8lIMkgJn0XGH9+HeR/ffzxq6HB/Rx0RT+2R+EcsZq6
	 IAb/V4Dt5OmCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rakesh Babu Saladi <Saladi.Rakeshbabu@microchip.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Sasha Levin <sashal@kernel.org>,
	kurt.schwemmer@microsemi.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 12/12] PCI: switchtec: Add Microchip PCI100X device IDs
Date: Tue, 28 Jan 2025 12:54:14 -0500
Message-Id: <20250128175414.1197295-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250128175414.1197295-1-sashal@kernel.org>
References: <20250128175414.1197295-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Rakesh Babu Saladi <Saladi.Rakeshbabu@microchip.com>

[ Upstream commit a3282f84b2151d254dc4abf24d1255c6382be774 ]

Add Microchip parts to the Device ID table so the driver supports PCI100x
devices.

Add a new macro to quirk the Microchip Switchtec PCI100x parts to allow DMA
access via NTB to work when the IOMMU is turned on.

PCI100x family has 6 variants; each variant is designed for different
application usages, different port counts and lane counts:

  PCI1001 has 1 x4 upstream port and 3 x4 downstream ports
  PCI1002 has 1 x4 upstream port and 4 x2 downstream ports
  PCI1003 has 2 x4 upstream ports, 2 x2 upstream ports, and 2 x2
    downstream ports
  PCI1004 has 4 x4 upstream ports
  PCI1005 has 1 x4 upstream port and 6 x2 downstream ports
  PCI1006 has 6 x2 upstream ports and 2 x2 downstream ports

[Historical note: these parts use PCI_VENDOR_ID_EFAR (0x1055), from EFAR
Microsystems, which was acquired in 1996 by Standard Microsystems Corp,
which was acquired by Microchip Technology in 2012.  The PCI-SIG confirms
that Vendor ID 0x1055 is assigned to Microchip even though it's not
visible via https://pcisig.com/membership/member-companies]

Link: https://lore.kernel.org/r/20250120095524.243103-1-Saladi.Rakeshbabu@microchip.com
Signed-off-by: Rakesh Babu Saladi <Saladi.Rakeshbabu@microchip.com>
[bhelgaas: Vendor ID history]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-By: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c           | 11 +++++++++++
 drivers/pci/switch/switchtec.c | 26 ++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 11fe6869ec3ab..af6cfd88f4b64 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5985,6 +5985,17 @@ SWITCHTEC_QUIRK(0x5552);  /* PAXA 52XG5 */
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
index c7e1089ffdafc..b14dfab04d846 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1739,6 +1739,26 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
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
@@ -1833,6 +1853,12 @@ static const struct pci_device_id switchtec_pci_tbl[] = {
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
2.39.5


