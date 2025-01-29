Return-Path: <linux-pci+bounces-20541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD97A21E81
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 15:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 722697A1873
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 14:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9D71DEFC5;
	Wed, 29 Jan 2025 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLrkepIB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A098A1DED68;
	Wed, 29 Jan 2025 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159398; cv=none; b=dQB9+nkCvwb1+sSqWpUXh1E/fe35DdA4fKlPe3tbA9kK/0esw01CoB2yw7ulb53J8l4F//Z26L5ig9iD0qhs6dLlE4n1RNDgKFt8CAhDcvFPCMD0XO6j/+ZTcmyB+6XA6hTVZRhndpQma24r0RqewdzHs61iaAKtbzN/mIhI1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159398; c=relaxed/simple;
	bh=1MTWfqf35aqxpgHwwG58jqOtBrNp5U+s5GIb8quwIpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PUG9HM4iVyB36aFu9GiqNDsBC3zP5j+GyG8TwVOiVFOpnpaOx5FQARQLBDq/XP/WObGh7uOEw8EEHfdExDjmS8K1rs9guqSayvyzLWJZ8ld+TvaMkwhoewDm2R71loczlUWBxzLf/yY0NoD18+dUEHhWwG6viyCjcfyQ1nRzmpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLrkepIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0F0C4CEDF;
	Wed, 29 Jan 2025 14:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738159398;
	bh=1MTWfqf35aqxpgHwwG58jqOtBrNp5U+s5GIb8quwIpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLrkepIBMNB+I4hK6Wh/His6bKnaAugqgLKwydB8bGoia4h5yb/26M+CfbyG1dyd+
	 Nl3H9hm1dRG/mH1nixMCZmrYOtoUOinBY/iFDQ3X2eqrAAnGup4N/WombW0xmfi5kA
	 6DZxmMtG89tLWg28ELuLSvbIMPo7hEj8ORUlVP/zhduYl9UiJGuAT6Q/K/fKr4LQc4
	 VqZsDLB6wfDZk/hihh7o0ZIsRVpt35wM4fCB+ga1E/CSNAU6G+gSConEJJ5h9mQIxT
	 OFhBisGWuuMPgjjTbKIBxzmT8/4Kjc07In+wnPi1NwFUV0RWCzjchjvBb8r8U+FCbc
	 Dgmn+norc+gEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	sudipm.mukherjee@gmail.com,
	jirislaby@kernel.org,
	bhelgaas@google.com,
	arnd@kernel.org,
	crescentcy.hsieh@moxa.com,
	macro@orcam.me.uk,
	schnelle@linux.ibm.com,
	dlemoal@kernel.org,
	peterz@infradead.org,
	linux-serial@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 2/8] serial: 8250_pci: Share WCH IDs with parport_serial driver
Date: Wed, 29 Jan 2025 07:59:22 -0500
Message-Id: <20250129125930.1273051-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250129125930.1273051-1-sashal@kernel.org>
References: <20250129125930.1273051-1-sashal@kernel.org>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 535a07698b8b3e6f305673102d297262cae2360a ]

parport_serial driver uses subset of WCH IDs that are present in 8250_pci.
Share them via pci_ids.h and switch parport_serial to use defined constants.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20241204031114.1029882-3-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/parport/parport_serial.c   | 12 ++++++++----
 drivers/tty/serial/8250/8250_pci.c | 10 ++--------
 include/linux/pci_ids.h            | 11 +++++++++++
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 3644997a83425..24d4f3a3ec3d0 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -266,10 +266,14 @@ static struct pci_device_id parport_serial_pci_tbl[] = {
 	{ 0x1409, 0x7168, 0x1409, 0xd079, 0, 0, timedia_9079c },
 
 	/* WCH CARDS */
-	{ 0x4348, 0x5053, PCI_ANY_ID, PCI_ANY_ID, 0, 0, wch_ch353_1s1p},
-	{ 0x4348, 0x7053, 0x4348, 0x3253, 0, 0, wch_ch353_2s1p},
-	{ 0x1c00, 0x3050, 0x1c00, 0x3050, 0, 0, wch_ch382_0s1p},
-	{ 0x1c00, 0x3250, 0x1c00, 0x3250, 0, 0, wch_ch382_2s1p},
+	{ PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH353_1S1P,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, wch_ch353_1s1p },
+	{ PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH353_2S1P,
+	  0x4348, 0x3253, 0, 0, wch_ch353_2s1p },
+	{ PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH382_0S1P,
+	  0x1c00, 0x3050, 0, 0, wch_ch382_0s1p },
+	{ PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH382_2S1P,
+	  0x1c00, 0x3250, 0, 0, wch_ch382_2s1p },
 
 	/* BrainBoxes PX272/PX306 MIO card */
 	{ PCI_VENDOR_ID_INTASHIELD, 0x4100,
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 82fba431a95cf..de6d90bf0d70a 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -64,23 +64,17 @@
 #define PCIE_DEVICE_ID_NEO_2_OX_IBM	0x00F6
 #define PCI_DEVICE_ID_PLX_CRONYX_OMEGA	0xc001
 #define PCI_DEVICE_ID_INTEL_PATSBURG_KT 0x1d3d
-#define PCI_VENDOR_ID_WCHCN		0x4348
+
 #define PCI_DEVICE_ID_WCHCN_CH352_2S	0x3253
-#define PCI_DEVICE_ID_WCHCN_CH353_4S	0x3453
-#define PCI_DEVICE_ID_WCHCN_CH353_2S1PF	0x5046
-#define PCI_DEVICE_ID_WCHCN_CH353_1S1P	0x5053
-#define PCI_DEVICE_ID_WCHCN_CH353_2S1P	0x7053
 #define PCI_DEVICE_ID_WCHCN_CH355_4S	0x7173
+
 #define PCI_VENDOR_ID_AGESTAR		0x5372
 #define PCI_DEVICE_ID_AGESTAR_9375	0x6872
 #define PCI_DEVICE_ID_BROADCOM_TRUMANAGE 0x160a
 #define PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800 0x818e
 
-#define PCI_VENDOR_ID_WCHIC		0x1c00
-#define PCI_DEVICE_ID_WCHIC_CH382_2S1P	0x3250
 #define PCI_DEVICE_ID_WCHIC_CH384_4S	0x3470
 #define PCI_DEVICE_ID_WCHIC_CH384_8S	0x3853
-#define PCI_DEVICE_ID_WCHIC_CH382_2S	0x3253
 
 #define PCI_DEVICE_ID_MOXA_CP102E	0x1024
 #define PCI_DEVICE_ID_MOXA_CP102EL	0x1025
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4cf6aaed5f35d..22f6b018cff8d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2589,6 +2589,11 @@
 
 #define PCI_VENDOR_ID_REDHAT		0x1b36
 
+#define PCI_VENDOR_ID_WCHIC		0x1c00
+#define PCI_DEVICE_ID_WCHIC_CH382_0S1P	0x3050
+#define PCI_DEVICE_ID_WCHIC_CH382_2S1P	0x3250
+#define PCI_DEVICE_ID_WCHIC_CH382_2S	0x3253
+
 #define PCI_VENDOR_ID_SILICOM_DENMARK	0x1c2c
 
 #define PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS	0x1c36
@@ -2643,6 +2648,12 @@
 #define PCI_VENDOR_ID_AKS		0x416c
 #define PCI_DEVICE_ID_AKS_ALADDINCARD	0x0100
 
+#define PCI_VENDOR_ID_WCHCN		0x4348
+#define PCI_DEVICE_ID_WCHCN_CH353_4S	0x3453
+#define PCI_DEVICE_ID_WCHCN_CH353_2S1PF	0x5046
+#define PCI_DEVICE_ID_WCHCN_CH353_1S1P	0x5053
+#define PCI_DEVICE_ID_WCHCN_CH353_2S1P	0x7053
+
 #define PCI_VENDOR_ID_ACCESSIO		0x494f
 #define PCI_DEVICE_ID_ACCESSIO_WDG_CSM	0x22c0
 
-- 
2.39.5


