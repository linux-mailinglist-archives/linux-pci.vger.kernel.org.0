Return-Path: <linux-pci+bounces-43386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0B4CCFDA4
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 13:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 584DE3030DA5
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 12:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A334328615;
	Fri, 19 Dec 2025 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLui4ZYC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307A21C84DC;
	Fri, 19 Dec 2025 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766148057; cv=none; b=Yw4c/6S5FR3ZtwxEGrJPRr9fgGGZxTrJBmFEc6Eq668Y+abfv7U8yNgJDSgsAtx5G2LGN30pXW3RvW/2oPvcROTY9bKV/e/mCqR7D2wpBhxgyn7SMqFxDX0miBfX5iYraCrXzYeJSwiBXjG/hhsENJ0OeOik+DWHdkkvlGsNbBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766148057; c=relaxed/simple;
	bh=ZXNPCHloNzeHHbAH0ZYxqBgLEFoqkQfgEjOzAZkrfxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0cwmQfaxQFSFuht2R7epURT/WiwMGAUQYUFIKG2/C5ZfINGHc/MvwUc511WoCTuTN2wsVSNXnGjJM2m4YRfLobi0AnoFxTbenJ5rm8hoD6RuqkTYPyJq3vxHi42g5aJ0Z7RRKWvJ1WXT99Ve6+JPmuF4I3ois51ObyhEE19osM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLui4ZYC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766148055; x=1797684055;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZXNPCHloNzeHHbAH0ZYxqBgLEFoqkQfgEjOzAZkrfxs=;
  b=bLui4ZYC0begDyXk04qtr/wW7kPMWIFMoqPFZer2IGbzRx4RxU/FAnkk
   kDgUqrYk+kjV7+kvkSh+KTYq0moQ1wX7Ik+m0SYYr6B1TMx31JiD9tHj/
   9PauaEZQOBQESF8k/N3HVdXtKotxRNpKMokJUXvxkchttVmwyApgGD9G7
   21yP7oRx+ueV+N2CiJpHs4LA7pvL/YgpraigWIVhWNnX3euaBvDRmhXix
   4ufslI3RD4GO4oIOtF6px07FlZKMzjlhyGT368YNqqUFgwe8k920rOGZn
   DTQyUoWE6rcMeaTXly+GGUdXodI+AyP8JtvSycUSO0qC+tQFCXQxg6rX1
   w==;
X-CSE-ConnectionGUID: 36QNr+ZpSxyooGlcWvIRaA==
X-CSE-MsgGUID: UfVkze9IQi+jQufOIzB4ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="78742693"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="78742693"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 04:40:54 -0800
X-CSE-ConnectionGUID: YnF9SIHiTbeI7aKQ2Q6aMg==
X-CSE-MsgGUID: K5IYwhj5SSe9f6wU+tub8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="198444375"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.52])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 04:40:49 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: Rafael J Wysocki <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 0/5 v8] Make ELOG and GHES log and trace consistently
Date: Fri, 19 Dec 2025 13:39:39 +0100
Message-ID: <20251219124042.3759749-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Firmware First is enabled, BIOS handles errors first and then it
makes them available to the kernel via the Common Platform Error Record
(CPER) sections (UEFI 2.10 Appendix N). Linux parses the CPER sections
via one of two similar paths, either ELOG or GHES.

Currently, ELOG and GHES show some inconsistencies in how they print to
the kernel log as well as in how they report to userspace via trace
events.

Make the two mentioned paths act similarly for what relates to logging
and tracing.

--- Changes for v8 ---

	- Don't make GHES dependend on PCI and drop patch 3/6 -
	  incidentally it works out the issues that the KTR found with v7
	  (Jonathan, Hanjun)
	- Don't have EXTLOG dependend on CXL_BUS and move the new helpers
	  to a new file, then link it to ghes.c only if ACPI_APEI_PCIEAER is
	  selected. Placing the new helpers to their own translation unit seems
	  be a more flexible and safer solution than messing with Kconfig or
	  with conditional compilation macros within ghes.c. PCI may not be an
	  option in embedded platforms

--- Changes for v7 ---

	- Reference UEFI v2.11 (Sathyanarayanan)
	- Substitute !(A || B) with !(A && B) in an 'if' statement to
	  convey the intended logic (Jonathan) 
	- Make ACPI_APEI_GHES explicitly select PCIAER because the needed
	  ACPI_APEI_PCIEAER doesn't recursively select that prerequisite (Jonathan)
	  Reported-by: kernel test robot <lkp@intel.com>
	  Closes: https://lore.kernel.org/oe-kbuild-all/202510232204.7aYBpl7h-lkp@intel.com/
	  Closes: https://lore.kernel.org/oe-kbuild-all/202510232204.XIXgPWD7-lkp@intel.com/
	- Don't add the unnecessary cxl_cper_ras_handle_prot_err() wrapper
	  for cxl_cper_handle_prot_err() (Jonathan) 
	- Make ACPI_EXTLOG explicitly select PCIAER && ACPI_APEI because
	  the needed ACPI_APEI_PCIEAER doesn't recursively select the
	  prerequisites
	- Make ACPI_EXTLOG select CXL_BUS

--- Changes for v6 ---

	- Rename the helper that copies the CPER CXL protocol error
	  information to work struct (Dave)
	- Return -EOPNOTSUPP (instead of -EINVAL) from the two helpers if
	  ACPI_APEI_PCIEAER is not defined (Dave)

--- Changes for v5 ---

	- Add 3/6 to select ACPI_APEI_PCIEAER for GHES
	- Add 4,5/6 to move common code between ELOG and GHES out to new
	  helpers use them in 6/6 (Jonathan).

--- Changes for v4 ---

	- Re-base on top of recent changes of the AER error logging and
	  drop obsoleted 2/4 (Sathyanarayanan)
	- Log with pr_warn_ratelimited() (Dave)
	- Collect tags
--- Changes for v3 ---

    1/4, 2/4:
	- collect tags; no functional changes
    3/4:
	- Invert logic of checks (Yazen)
	- Select CONFIG_ACPI_APEI_PCIEAER (Yazen)
    4/4:
	- Check serial number only for CXL devices (Yazen)
	- Replace "invalid" with "unknown" in the output of a pr_err()
	  (Yazen)
	
--- Changes for v2 ---

	- Add a patch to pass log levels to pci_print_aer() (Dan)
	- Add a patch to trace CPER CXL Protocol Errors
	- Rework commit messages (Dan)
	- Use log_non_standard_event() (Bjorn)

--- Changes for v1 ---

	- Drop the RFC prefix and restart from PATCH v1
	- Drop patch 3/3 because a discussion on it has not yet been
	  settled
	- Drop namespacing in export of pci_print_aer while() (Dan)
	- Don't use '#ifdef' in *.c files (Dan)
	- Drop a reference on pdev after operation is complete (Dan)
	- Don't log an error message if pdev is NULL (Dan)

Fabio M. De Francesco (5):
  ACPI: extlog: Trace CPER Non-standard Section Body
  ACPI: extlog: Trace CPER PCI Express Error Section
  acpi/ghes: Add helper for CPER CXL protocol errors checks
  acpi/ghes: Add helper to copy CPER CXL protocol error info to work
    struct
  ACPI: extlog: Trace CPER CXL Protocol Error Section

 drivers/acpi/Kconfig             |  2 +
 drivers/acpi/acpi_extlog.c       | 64 +++++++++++++++++++++++++++++++
 drivers/acpi/apei/Makefile       |  1 +
 drivers/acpi/apei/ghes.c         | 40 +-------------------
 drivers/acpi/apei/ghes_helpers.c | 65 ++++++++++++++++++++++++++++++++
 drivers/cxl/core/ras.c           |  3 +-
 drivers/pci/pcie/aer.c           |  2 +-
 include/cxl/event.h              | 22 +++++++++++
 8 files changed, 159 insertions(+), 40 deletions(-)
 create mode 100644 drivers/acpi/apei/ghes_helpers.c


base-commit: ea1013c1539270e372fc99854bc6e4d94eaeff66
-- 
2.52.0


