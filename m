Return-Path: <linux-pci+bounces-17623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F319E31E6
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 04:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552CE2848D7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 03:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C234B155398;
	Wed,  4 Dec 2024 03:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxNsIiFO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48B51531E8;
	Wed,  4 Dec 2024 03:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281883; cv=none; b=TsA7UkE61745+82Sphe4c7TAW7JnQtnp4Up72OcHkymvuujNx/g/ftMM22kHyv1J3uMLpFCzSA5CJyO3bSstqMMd4PGZt+exCbUQkkxdwCIF9ZpJc/SK4JBtAO6GxKuccv9VYzC+9P7xQaS9aiSWYZc5eWkZnYrYghT+5RJVKeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281883; c=relaxed/simple;
	bh=JsDNVtluo61TdCYhEdaRBqVPFwLweNYUscfhLSpyek0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwNGoUETrtQ/pq2AHeyJcwrh3Hm0JH4QtAiSeUCGdRMlaKhdZ5EBdV7X0AXxCYuCNk1kDid2DeCINCw1gCitff6lxJwxi/CdIknGgF3iF0zQW47N3e/DzdSc8ydlKmN31R2+mGUqDDGlIl3599lOOCd201lCcRLkYOJC7OVOvqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bxNsIiFO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733281882; x=1764817882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JsDNVtluo61TdCYhEdaRBqVPFwLweNYUscfhLSpyek0=;
  b=bxNsIiFOAIaFwmxCQTxkSn/6Ra6YDundNvbAONVkDvM9keG4GnQgYLhW
   VfzGuys8tXqUBQXMvQezKp9WJ2kZaIE4wGMrhSA3LRFEHWvQ65oyPh7JM
   YbFxjcc3nLdbrn1NsfQLtPTM8vTj9BJVNKKLZ7WkaZm0aFvC+29ZRoNQh
   ymmrVQi+SqT07xkxpo9stsJTqm5gi8rma7z2X8BQZPO2RXkQp0eYhmFVa
   8GXXpcgcc4t9a5PBVXpaEbDl3rnc1fYgHBYRdnyzbFMuf67WgKJSb/rKA
   9xNb+bCj7asbUrhhiT8sTBX09cJyOfZN+UBkVjD7dyPAHUOCTgQNCNgti
   Q==;
X-CSE-ConnectionGUID: wXfFmnT3RUq8KA5H+QFLvA==
X-CSE-MsgGUID: 6CG5tIOHTOeXTfi7bGc4dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33780570"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="33780570"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 19:11:21 -0800
X-CSE-ConnectionGUID: KCOUUiiORQiUDeuaF1ZIzw==
X-CSE-MsgGUID: +hYxjkDYTRyn2tes42HEeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98645583"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 03 Dec 2024 19:11:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6624342D; Wed, 04 Dec 2024 05:11:17 +0200 (EET)
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
Subject: [PATCH v1 2/2] serial: 8250_pci: Share WCH IDs with parport_serial driver
Date: Wed,  4 Dec 2024 05:09:22 +0200
Message-ID: <20241204031114.1029882-3-andriy.shevchenko@linux.intel.com>
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

parport_serial driver uses subset of WCH IDs that are present in 8250_pci.
Share them via pci_ids.h and switch parport_serial to use defined constants.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/parport/parport_serial.c   | 12 ++++++++----
 drivers/tty/serial/8250/8250_pci.c | 10 ++--------
 include/linux/pci_ids.h            | 11 +++++++++++
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 3644997a8342..24d4f3a3ec3d 100644
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
index dfac79744d37..df4d0d832e54 100644
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
index d2402bf4aea2..de5deb1a0118 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2593,6 +2593,11 @@
 
 #define PCI_VENDOR_ID_REDHAT		0x1b36
 
+#define PCI_VENDOR_ID_WCHIC		0x1c00
+#define PCI_DEVICE_ID_WCHIC_CH382_0S1P	0x3050
+#define PCI_DEVICE_ID_WCHIC_CH382_2S1P	0x3250
+#define PCI_DEVICE_ID_WCHIC_CH382_2S	0x3253
+
 #define PCI_VENDOR_ID_SILICOM_DENMARK	0x1c2c
 
 #define PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS	0x1c36
@@ -2647,6 +2652,12 @@
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
2.43.0.rc1.1336.g36b5255a03ac


