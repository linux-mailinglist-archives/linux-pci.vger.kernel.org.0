Return-Path: <linux-pci+bounces-40270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 012CEC329DD
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 19:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5965218C3736
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 18:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F39335097;
	Tue,  4 Nov 2025 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uv9hk/Vk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D07E21CC56;
	Tue,  4 Nov 2025 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280701; cv=none; b=NOxguQidSexpuF7FfCoR28a3ulxI2jd33q2mMBzxak51u7MlY3gplfHx6I1JPfpE4tIG+bQZRKvhG14zSNNRZo6fzerkHe8SHnGayTkMC23kD6TTM4arz+TxY+mOl0w293A0/RMYevjhyCWFq2TWdvjgwUw00QRr65pC6Z5cEI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280701; c=relaxed/simple;
	bh=ygSV/I+qI9txTatyENS+X8zLXLvRO8BaoyQZ9Ji+fjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eMkrKHaVWs+DvlaUujdIZFIntpqYgEvmg4ZW4YHUB9J49rwswIFFoZGZSgdrAvyBYobazieVb+rQ9upREc2TVg+fVcjrOAvnY5gUrfEqIjrdAPtDHtCOaLd9ZjzzX2yO4x9QXb5ZIKuZglglD/4ZS0qAUYnnQ3ms8WBbdahYCa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uv9hk/Vk; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762280699; x=1793816699;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ygSV/I+qI9txTatyENS+X8zLXLvRO8BaoyQZ9Ji+fjs=;
  b=Uv9hk/VkTpd6zleFrGVcq4vxwDVv4H+zdhDwzMlsHQy0WnUFf8JFt3AB
   FtlqyFPFHXEjJqtsztjeDM+bT256fn5zONxW/lNkTWvnN/wulVxrI/3R2
   c1WL/GgS/sYAuMjvTZ2GvMbZ7kzMwm+4NYsDbKNHfhJxe7T8J+SeIbd6I
   oebHmuHEi8MhbA6IxoODDxE077wJ0mb7fiUER9lfE1nCLVwI+y9iW7LwD
   4iZCrwV+B6pwok2V1muUiv6z6rxvdQ8o1Fgpi4d4env4Hn7teVdKdMHIb
   +c84KQ0+TxloVgqWfnaCcPLwoB8aHArDc013S9Es6TGXpZNdDlzjJ8Qv+
   w==;
X-CSE-ConnectionGUID: QsqOx4QxRGCl8HfoLv94Ng==
X-CSE-MsgGUID: x2ohezbKQFybkcPRK0ug4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64534894"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="64534894"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:24:59 -0800
X-CSE-ConnectionGUID: 0zaqPnPkRxO7iCv/hEIXvw==
X-CSE-MsgGUID: szvt4rU3T3WItWVCP4XBvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="191325204"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.211])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:24:52 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
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
Subject: [PATCH 0/6 v7] Make ELOG and GHES log and trace consistently 
Date: Tue,  4 Nov 2025 19:22:31 +0100
Message-ID: <20251104182446.863422-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.51.1
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

Fabio M. De Francesco (6):
  ACPI: extlog: Trace CPER Non-standard Section Body
  ACPI: extlog: Trace CPER PCI Express Error Section
  acpi/ghes: Make GHES select ACPI_APEI_PCIEAER
  acpi/ghes: Add helper for CPER CXL protocol errors validity checks
  acpi/ghes: Add helper to copy CPER CXL protocol error information to
    work struct
  ACPI: extlog: Trace CPER CXL Protocol Error Section

 drivers/acpi/Kconfig       |  7 ++++-
 drivers/acpi/acpi_extlog.c | 60 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/apei/Kconfig  |  2 ++
 drivers/acpi/apei/ghes.c   | 62 +++++++++++++++++++++++++-------------
 drivers/cxl/core/ras.c     |  3 +-
 drivers/pci/pcie/aer.c     |  2 +-
 include/cxl/event.h        | 22 ++++++++++++++
 7 files changed, 134 insertions(+), 24 deletions(-)


base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
-- 
2.51.1


