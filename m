Return-Path: <linux-pci+bounces-25358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30007A7D4E6
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 09:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D263ACB77
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 07:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A454224B10;
	Mon,  7 Apr 2025 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ez1E0dBp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E12218ADC;
	Mon,  7 Apr 2025 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744009418; cv=none; b=Vi64nMKqrixZP6e3/yaq57Bb5UrNXl0/t+0wPhTIh2DhKrgCAMNyGOUcyQ39vA3R0UBC7Fr2Xl0nY8pQSCm7ZSozZ2htWU+YvE0w5hvsVlpHQd2osBKZ15LMCNhQ1hW/+nbt+yPn40iApNUd6dvwFkxOU2/zZcq0jXVhGV76JNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744009418; c=relaxed/simple;
	bh=qW7X0O7a7+RV3ifNkS2U5b666avtSFWmEmJEcTSbnS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gLSkTlMcaeoCmOtCuc7kM0CZFDDpcAqilkZKv5GibrPYiMtPr6iT0C98IU8ZE+iM9HLD5V2NG+4CG9efDC1ttUhmMrQGMEnGi37BM38ZWRxcN4taYHBI/sXjTiBI9gFNAyxCEnL5pfCVnv3nay7m55u41pnnlr2mgRqkfQHK54o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ez1E0dBp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744009416; x=1775545416;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qW7X0O7a7+RV3ifNkS2U5b666avtSFWmEmJEcTSbnS0=;
  b=Ez1E0dBpBlG6lvcbCr6N4W2pFkpdBLn4PjXGyn4briX/mX531aVbwIIA
   5IDdoXWT7pOsf1TEMY1V+SBe8baadeBi+IiSec8VZqr8+o8C3ntGiVv39
   0FyzlrZcV5R2B6SiUanbGPt9wv4MeQYc0nwggc2siSZrV3B/Sj38Nysjj
   eGX+dKBQPwYpi/tdpWV+PVSIfZiuHwbv/j1cB7LnYY+9Ye/bdvHIGkyOQ
   oqjvBtYpezaKevGJpPHdTkll/J48aFHdzcfL1FuNzSOGmnb4emLjAj+5T
   rbUUJUryixNsoW3DWXxXAGOxaPsuxvPX1BYkeVZqJvomYvUkZ8Ez2fxst
   A==;
X-CSE-ConnectionGUID: 3Gn3CUh+QBi2SX127xZ5gg==
X-CSE-MsgGUID: rNuoRTmQQWGGfJopggyyXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="56747195"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="56747195"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 00:03:35 -0700
X-CSE-ConnectionGUID: keA3zv7tRKemDMN0Z8a4Xw==
X-CSE-MsgGUID: vhLbNFZ4SnqsNkiuBpWrzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="127616903"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 07 Apr 2025 00:03:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 328F5338; Mon, 07 Apr 2025 10:03:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 1/1] x86/PCI: Drop 'pci' suffix from intel_mid_pci.c
Date: Mon,  7 Apr 2025 10:03:21 +0300
Message-ID: <20250407070321.3761063-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CE4100 PCI specific code has no 'pci' suffix in the filename,
intel_mid_pci.c is the only one that duplicates the folder
name in its filename, drop that redundancy.

While at it, group the respective modules in the Makefile.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS                                   | 2 +-
 arch/x86/pci/Makefile                         | 6 +++---
 arch/x86/pci/{intel_mid_pci.c => intel_mid.c} | 0
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename arch/x86/pci/{intel_mid_pci.c => intel_mid.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96b827049501..1f6514d55b17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12120,7 +12120,7 @@ M:	Andy Shevchenko <andy@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	arch/x86/include/asm/intel-mid.h
-F:	arch/x86/pci/intel_mid_pci.c
+F:	arch/x86/pci/intel_mid.c
 F:	arch/x86/platform/intel-mid/
 F:	drivers/dma/hsu/
 F:	drivers/extcon/extcon-intel-mrfld.c
diff --git a/arch/x86/pci/Makefile b/arch/x86/pci/Makefile
index 4933fb337983..c1efd5b0d198 100644
--- a/arch/x86/pci/Makefile
+++ b/arch/x86/pci/Makefile
@@ -8,13 +8,13 @@ obj-$(CONFIG_PCI_OLPC)		+= olpc.o
 obj-$(CONFIG_PCI_XEN)		+= xen.o
 
 obj-y				+= fixup.o
-obj-$(CONFIG_X86_INTEL_CE)      += ce4100.o
 obj-$(CONFIG_ACPI)		+= acpi.o
 obj-y				+= legacy.o irq.o
 
-obj-$(CONFIG_X86_NUMACHIP)	+= numachip.o
+obj-$(CONFIG_X86_INTEL_CE)	+= ce4100.o
+obj-$(CONFIG_X86_INTEL_MID)	+= intel_mid.o
 
-obj-$(CONFIG_X86_INTEL_MID)	+= intel_mid_pci.o
+obj-$(CONFIG_X86_NUMACHIP)	+= numachip.o
 
 obj-y				+= common.o early.o
 obj-y				+= bus_numa.o
diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid.c
similarity index 100%
rename from arch/x86/pci/intel_mid_pci.c
rename to arch/x86/pci/intel_mid.c
-- 
2.47.2


