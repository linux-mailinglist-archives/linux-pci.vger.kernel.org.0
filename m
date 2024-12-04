Return-Path: <linux-pci+bounces-17624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB919E31E9
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 04:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E96A281574
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 03:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4351632DF;
	Wed,  4 Dec 2024 03:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ux5BwAWs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF5F15573A;
	Wed,  4 Dec 2024 03:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281885; cv=none; b=AFHoV2dg6oXPvSvJ9y8BflXXlb2YH+8oMnZQ1a/OdfhTRRoQDizHkShAo/MUl6Bbq/tilr152utzwNmUwdWvC64TRQ7gamnZHgTr7DKB/KpmRnVCbV3ZVi7gk5PlsCHrJLSa3pRzy9NdiIZVJmCxEizoV9J7T9l6HHJudOMbA98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281885; c=relaxed/simple;
	bh=dxD7msXptwxR0JyVF0+NfI1X+V7g58MyCqZUUdupXEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmAH4GoU2j2bV0GNKQsH1P/HGpYuALMtcxoVhmpApbfIzel5+vbmykpHY1dZ+1YnWWjrIqY4lLHFPXj8F0ihn5qZWjSmqSnlPrKA0vHvd3aiX3gNO8JDeNcJsgJRhi8/2FW7tLTCwQIwV+W8OkMLLrCmoTQw/KDZvrVgwvTnmUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ux5BwAWs; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733281884; x=1764817884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dxD7msXptwxR0JyVF0+NfI1X+V7g58MyCqZUUdupXEc=;
  b=Ux5BwAWsvM6855X3KaRIckMxj2iPutc0i1xB0LddrYDTBNvh13RK2fwJ
   hE/LG2iPqMrMkRbvEb/GrLDyleWmOcsOorKuxzozu3n0j6DH8uTHB/o77
   gVyE3wS5uiECRtOVDzB405ooazjjpYztbxWDRCaNo7+R6bdvpQyG1HeEs
   zj+t4Sdaqgsw1m4eKKzEtMqN/7oRUGPijdW0zkfyLqNt9M6PrX7RsvYMI
   oevVyri6mtbFNZTdMQLVCrXwK8MhKRgJ1xExAqbrkKBrIhsyzLrDigvuY
   n9Ub+0yqUKtt74Ni53d13LayQtwX6L98l6wE3etkMifdQ5wc27ADdK1U4
   w==;
X-CSE-ConnectionGUID: afmGwhVxR1arR2UZ5JZe2Q==
X-CSE-MsgGUID: dC4/LL6YRw+ucwq4IhR/Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33780580"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="33780580"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 19:11:21 -0800
X-CSE-ConnectionGUID: Y3su9jBFSPGhgtkS1CNeHQ==
X-CSE-MsgGUID: AyTcf2NKSNeQbCUukk53Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98645585"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 03 Dec 2024 19:11:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5F7A81EC; Wed, 04 Dec 2024 05:11:17 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Cameron Williams <cang1@live.co.uk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 1/2] serial: 8250_pci: Resolve WCH vendor ID ambiguity
Date: Wed,  4 Dec 2024 05:09:21 +0200
Message-ID: <20241204031114.1029882-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241204031114.1029882-1-andriy.shevchenko@linux.intel.com>
References: <20241204031114.1029882-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two sites of the same brand: wch.cn and wch-ic.com.
They are property of the same company, but it appears that they
managed to get two different PCI vendor IDs. Rename them accordingly
using standard pattern, i.e. PCI_VENDOR_ID_...

While at it, move to PCI_VDEVICE() in the ID tables.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_pci.c | 82 +++++++++++++++---------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 3c3f7c926afb..dfac79744d37 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -64,23 +64,23 @@
 #define PCIE_DEVICE_ID_NEO_2_OX_IBM	0x00F6
 #define PCI_DEVICE_ID_PLX_CRONYX_OMEGA	0xc001
 #define PCI_DEVICE_ID_INTEL_PATSBURG_KT 0x1d3d
-#define PCI_VENDOR_ID_WCH		0x4348
-#define PCI_DEVICE_ID_WCH_CH352_2S	0x3253
-#define PCI_DEVICE_ID_WCH_CH353_4S	0x3453
-#define PCI_DEVICE_ID_WCH_CH353_2S1PF	0x5046
-#define PCI_DEVICE_ID_WCH_CH353_1S1P	0x5053
-#define PCI_DEVICE_ID_WCH_CH353_2S1P	0x7053
-#define PCI_DEVICE_ID_WCH_CH355_4S	0x7173
+#define PCI_VENDOR_ID_WCHCN		0x4348
+#define PCI_DEVICE_ID_WCHCN_CH352_2S	0x3253
+#define PCI_DEVICE_ID_WCHCN_CH353_4S	0x3453
+#define PCI_DEVICE_ID_WCHCN_CH353_2S1PF	0x5046
+#define PCI_DEVICE_ID_WCHCN_CH353_1S1P	0x5053
+#define PCI_DEVICE_ID_WCHCN_CH353_2S1P	0x7053
+#define PCI_DEVICE_ID_WCHCN_CH355_4S	0x7173
 #define PCI_VENDOR_ID_AGESTAR		0x5372
 #define PCI_DEVICE_ID_AGESTAR_9375	0x6872
 #define PCI_DEVICE_ID_BROADCOM_TRUMANAGE 0x160a
 #define PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800 0x818e
 
-#define PCIE_VENDOR_ID_WCH		0x1c00
-#define PCIE_DEVICE_ID_WCH_CH382_2S1P	0x3250
-#define PCIE_DEVICE_ID_WCH_CH384_4S	0x3470
-#define PCIE_DEVICE_ID_WCH_CH384_8S	0x3853
-#define PCIE_DEVICE_ID_WCH_CH382_2S	0x3253
+#define PCI_VENDOR_ID_WCHIC		0x1c00
+#define PCI_DEVICE_ID_WCHIC_CH382_2S1P	0x3250
+#define PCI_DEVICE_ID_WCHIC_CH384_4S	0x3470
+#define PCI_DEVICE_ID_WCHIC_CH384_8S	0x3853
+#define PCI_DEVICE_ID_WCHIC_CH382_2S	0x3253
 
 #define PCI_DEVICE_ID_MOXA_CP102E	0x1024
 #define PCI_DEVICE_ID_MOXA_CP102EL	0x1025
@@ -2817,80 +2817,80 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 	},
 	/* WCH CH353 1S1P card (16550 clone) */
 	{
-		.vendor         = PCI_VENDOR_ID_WCH,
-		.device         = PCI_DEVICE_ID_WCH_CH353_1S1P,
+		.vendor         = PCI_VENDOR_ID_WCHCN,
+		.device         = PCI_DEVICE_ID_WCHCN_CH353_1S1P,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch353_setup,
 	},
 	/* WCH CH353 2S1P card (16550 clone) */
 	{
-		.vendor         = PCI_VENDOR_ID_WCH,
-		.device         = PCI_DEVICE_ID_WCH_CH353_2S1P,
+		.vendor         = PCI_VENDOR_ID_WCHCN,
+		.device         = PCI_DEVICE_ID_WCHCN_CH353_2S1P,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch353_setup,
 	},
 	/* WCH CH353 4S card (16550 clone) */
 	{
-		.vendor         = PCI_VENDOR_ID_WCH,
-		.device         = PCI_DEVICE_ID_WCH_CH353_4S,
+		.vendor         = PCI_VENDOR_ID_WCHCN,
+		.device         = PCI_DEVICE_ID_WCHCN_CH353_4S,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch353_setup,
 	},
 	/* WCH CH353 2S1PF card (16550 clone) */
 	{
-		.vendor         = PCI_VENDOR_ID_WCH,
-		.device         = PCI_DEVICE_ID_WCH_CH353_2S1PF,
+		.vendor         = PCI_VENDOR_ID_WCHCN,
+		.device         = PCI_DEVICE_ID_WCHCN_CH353_2S1PF,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch353_setup,
 	},
 	/* WCH CH352 2S card (16550 clone) */
 	{
-		.vendor		= PCI_VENDOR_ID_WCH,
-		.device		= PCI_DEVICE_ID_WCH_CH352_2S,
+		.vendor		= PCI_VENDOR_ID_WCHCN,
+		.device		= PCI_DEVICE_ID_WCHCN_CH352_2S,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_wch_ch353_setup,
 	},
 	/* WCH CH355 4S card (16550 clone) */
 	{
-		.vendor		= PCI_VENDOR_ID_WCH,
-		.device		= PCI_DEVICE_ID_WCH_CH355_4S,
+		.vendor		= PCI_VENDOR_ID_WCHCN,
+		.device		= PCI_DEVICE_ID_WCHCN_CH355_4S,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_wch_ch355_setup,
 	},
 	/* WCH CH382 2S card (16850 clone) */
 	{
-		.vendor         = PCIE_VENDOR_ID_WCH,
-		.device         = PCIE_DEVICE_ID_WCH_CH382_2S,
+		.vendor         = PCI_VENDOR_ID_WCHIC,
+		.device         = PCI_DEVICE_ID_WCHIC_CH382_2S,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch38x_setup,
 	},
 	/* WCH CH382 2S1P card (16850 clone) */
 	{
-		.vendor         = PCIE_VENDOR_ID_WCH,
-		.device         = PCIE_DEVICE_ID_WCH_CH382_2S1P,
+		.vendor         = PCI_VENDOR_ID_WCHIC,
+		.device         = PCI_DEVICE_ID_WCHIC_CH382_2S1P,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch38x_setup,
 	},
 	/* WCH CH384 4S card (16850 clone) */
 	{
-		.vendor         = PCIE_VENDOR_ID_WCH,
-		.device         = PCIE_DEVICE_ID_WCH_CH384_4S,
+		.vendor         = PCI_VENDOR_ID_WCHIC,
+		.device         = PCI_DEVICE_ID_WCHIC_CH384_4S,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch38x_setup,
 	},
 	/* WCH CH384 8S card (16850 clone) */
 	{
-		.vendor         = PCIE_VENDOR_ID_WCH,
-		.device         = PCIE_DEVICE_ID_WCH_CH384_8S,
+		.vendor         = PCI_VENDOR_ID_WCHIC,
+		.device         = PCI_DEVICE_ID_WCHIC_CH384_8S,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.init           = pci_wch_ch38x_init,
@@ -3967,11 +3967,11 @@ static const struct pci_device_id blacklist[] = {
 
 	/* multi-io cards handled by parport_serial */
 	/* WCH CH353 2S1P */
-	{ PCI_DEVICE(0x4348, 0x7053), 0, 0, REPORT_CONFIG(PARPORT_SERIAL), },
+	{ PCI_VDEVICE(WCHCN, 0x7053), REPORT_CONFIG(PARPORT_SERIAL), },
 	/* WCH CH353 1S1P */
-	{ PCI_DEVICE(0x4348, 0x5053), 0, 0, REPORT_CONFIG(PARPORT_SERIAL), },
+	{ PCI_VDEVICE(WCHCN, 0x5053), REPORT_CONFIG(PARPORT_SERIAL), },
 	/* WCH CH382 2S1P */
-	{ PCI_DEVICE(0x1c00, 0x3250), 0, 0, REPORT_CONFIG(PARPORT_SERIAL), },
+	{ PCI_VDEVICE(WCHIC, 0x3250), REPORT_CONFIG(PARPORT_SERIAL), },
 
 	/* Intel platforms with MID UART */
 	{ PCI_VDEVICE(INTEL, 0x081b), REPORT_8250_CONFIG(MID), },
@@ -6044,27 +6044,27 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	 * WCH CH353 series devices: The 2S1P is handled by parport_serial
 	 * so not listed here.
 	 */
-	{	PCI_VENDOR_ID_WCH, PCI_DEVICE_ID_WCH_CH353_4S,
+	{	PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH353_4S,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_b0_bt_4_115200 },
 
-	{	PCI_VENDOR_ID_WCH, PCI_DEVICE_ID_WCH_CH353_2S1PF,
+	{	PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH353_2S1PF,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_b0_bt_2_115200 },
 
-	{	PCI_VENDOR_ID_WCH, PCI_DEVICE_ID_WCH_CH355_4S,
+	{	PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH355_4S,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_b0_bt_4_115200 },
 
-	{	PCIE_VENDOR_ID_WCH, PCIE_DEVICE_ID_WCH_CH382_2S,
+	{	PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH382_2S,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_wch382_2 },
 
-	{	PCIE_VENDOR_ID_WCH, PCIE_DEVICE_ID_WCH_CH384_4S,
+	{	PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH384_4S,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_wch384_4 },
 
-	{	PCIE_VENDOR_ID_WCH, PCIE_DEVICE_ID_WCH_CH384_8S,
+	{	PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH384_8S,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_wch384_8 },
 	/*
-- 
2.43.0.rc1.1336.g36b5255a03ac


