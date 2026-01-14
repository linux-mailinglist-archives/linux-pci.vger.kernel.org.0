Return-Path: <linux-pci+bounces-44727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C8FD1DEA0
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 11:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECC1B3019BD2
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 10:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648A031A7FB;
	Wed, 14 Jan 2026 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ii2BqAyq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C889F347DD;
	Wed, 14 Jan 2026 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385758; cv=none; b=RMcwQOe5wF2Da8ucmXXLRFIS5J6ugsz+fOsdOncPNPbX+DLymrI4KqY+KO0lT2vrH90pe4pZGZORSVCmPYU2k01U28XTWMF+N6uhmjKe5ySe2DJ7ecu8Ax89ZX63LwK4odFtxFA16+tHY1s48pT5zoYw69fCC4h/99dTYhauVuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385758; c=relaxed/simple;
	bh=MQi58lIxeirVopK0zZ+tUuUpYRwLp1BLjQ9AcO3m0Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MH7zSQTIL4Pz992WdUHTFNm64aDcK3hyqYdjF8BeRKQFtrjv2vkwAWCvIKO5JX1yVRJlvQ57Ub+uhZVG0YXXsgpNs9DYXm5kVD47p4Zl2cPitPR9ioqpuWhQLf733qsAulBWABF1alScQagWPK6ym21vspAWLbvVKOgVZKQu98o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ii2BqAyq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768385757; x=1799921757;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MQi58lIxeirVopK0zZ+tUuUpYRwLp1BLjQ9AcO3m0Q8=;
  b=Ii2BqAyqIs7Clb22bAMmZeFz5iXtmJrB/KvRr2yTvHITnH3wAA92MGAK
   yGiTaegLkesZ+qDgVNHtQ0IbC6HxCDzdvmWBaclMVKiRODJmCIxBjnLV3
   YcRVR81zeMy053UbmuNPQumX7SheCcTg+I5FMBhrcK9EZZwGPokGb+iir
   3aUGP89inG3/tKgRpFsrjrsy6vDgzs77qK+8i0P2iT63SMy2MfDpmW7pO
   /x66dNr2Go0EkYc9Yx0MfFzTFYWPApdi0pRC7iIhMy7RMOjY48QlYsmRo
   PmZAbMkgjuyEVXhFTWBTSRsp0fS3U3/gazffElAiM2eTkxIXzvQcZ3HSG
   A==;
X-CSE-ConnectionGUID: mWMh5XsrRvGTM5Tho+btCQ==
X-CSE-MsgGUID: l48qUN9AR4icR+0e8uEiow==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69765781"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="69765781"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 02:15:56 -0800
X-CSE-ConnectionGUID: V6gTHZTeSYeEaDud2DeoHw==
X-CSE-MsgGUID: x0iffcUXRx6UlBYFLGobyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="208792729"
Received: from unknown (HELO fdefranc-mobl3.igk.intel.com) ([10.237.142.167])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 02:15:50 -0800
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
Subject: [PATCH 0/5 v9] Make ELOG and GHES log and trace consistently
Date: Wed, 14 Jan 2026 11:14:20 +0100
Message-ID: <20260114101543.85926-1-fabio.m.de.francesco@linux.intel.com>
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

--- Changes for v9 ---

	- #include linux/printk.h for pr_*_ratelimited() in ghes_helpers.c
	  Reported-by: kernel test robot <lkp@intel.com>
	  Closes: https://lore.kernel.org/oe-kbuild-all/202512240711.Iv57ik8I-lkp@intel.com/

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
 drivers/acpi/apei/ghes.c         | 40 +------------------
 drivers/acpi/apei/ghes_helpers.c | 66 ++++++++++++++++++++++++++++++++
 drivers/cxl/core/ras.c           |  3 +-
 drivers/pci/pcie/aer.c           |  2 +-
 include/cxl/event.h              | 22 +++++++++++
 8 files changed, 160 insertions(+), 40 deletions(-)
 create mode 100644 drivers/acpi/apei/ghes_helpers.c


base-commit: b71e635feefc8
-- 
2.52.0


