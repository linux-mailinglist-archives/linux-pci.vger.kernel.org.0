Return-Path: <linux-pci+bounces-27014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D3BAA1530
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 19:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F814A02BE
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 17:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CDE25178C;
	Tue, 29 Apr 2025 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJuLm9EW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ADA82C60;
	Tue, 29 Apr 2025 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947282; cv=none; b=TYxYxnOWlKZRZa2YzDA4yji6M3bjWGPqO6TREMaH3LMgZd6efNS121pywGgIQb8fUV1hxrwvWcpH8haGs92eVW7WQoqc6OLG07tb1a/wBFPPc6/gm3oVW/jqnPU09Iizs+Mjhk9b/ihHemvZqnWt0YSrYX9AKfLCVa1MKENzD2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947282; c=relaxed/simple;
	bh=vYY2zbE6OK0wScySObCKJRjYLAvY/gAV9CwgCR4nPcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gt95Lsazm8X5izGnujeGFjYUAg94uttxt+M6JSMRIlTOYiOpfoVrsncFNgXCuVsGjvUUZT0Wx4IB5i1xtXSvSOm1LjSLySfoYL75ctHHK7fz0Nh3BdT+hKCSeNPyHZRkviOIOnuzTxSId3+hJtP92DwkCSC3Y7XCm4D6bVBhUEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJuLm9EW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745947281; x=1777483281;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vYY2zbE6OK0wScySObCKJRjYLAvY/gAV9CwgCR4nPcw=;
  b=lJuLm9EW5I1rvGoJhBGB0iikbdDB/5tMuGr0oQTnF5myfe5xKt/zCfvR
   NKsmPk5l0UMuNFZz+H6RIxpJVowuwS7vittyOUxDdky5tjm6Caw07QJbM
   hrWmwZjpxI1Dq0YA+F5Az133/H1o5BeW+Li4LDIwO7Ma9LvQE4wOca/yR
   IN6Ya922YKxSqoWxGeF8RG5yawv9C7nwjrGeUzuSmbv/flcXkBx6B+9ai
   oTLaN8ET/JLgqFIeParChHjz9DwfoQJKUf9RB/abBzlGMNyrUhBTYicvC
   Gi/9K/sGPck+WvGTcf/oeMCOmp0tSw/GkgoNHoHVRQ/UQI0IHc7kisEud
   A==;
X-CSE-ConnectionGUID: P4OYuo27QOuArCUuORCVJw==
X-CSE-MsgGUID: hm8/o+pzTkKit0jNTNjjMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="64996929"
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="64996929"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 10:21:20 -0700
X-CSE-ConnectionGUID: 8vZD04tyRg2Aa5RoJMWkAg==
X-CSE-MsgGUID: mHsBn+CMR4uPyr9hrkfPSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="139073305"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.45])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 10:21:14 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
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
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-edac@vger.kernel.org
Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 0/4 v2] Make ELOG log and trace consistently with GHES
Date: Tue, 29 Apr 2025 19:21:05 +0200
Message-ID: <20250429172109.3199192-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.48.1
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

--- Changes for RFC v2 ---
	
	- 0/3: rework the subject line and the letter.
        - 1/3: no changes.
        - 2/3: trace CPER PCIe Section only if CONFIG_ACPI_APEI_PCIEAER
          is defined; the kernel test robot reported the use of two
          undefined symbols because the test for the config option was
          missing; rewrite the subject line and part of commit message.
        - 3/3: no changes.


Fabio M. De Francesco (4):
  ACPI: extlog: Trace CPER Non-standard Section Body
  PCI/AER: Modify pci_print_aer() to take log level
  ACPI: extlog: Trace CPER PCI Express Error Section
  ACPI: extlog: Trace CPER CXL Protocol Errors

 drivers/acpi/acpi_extlog.c | 96 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/pci.c     |  2 +-
 drivers/cxl/core/ras.c     |  6 +++
 drivers/pci/pcie/aer.c     | 18 +++----
 drivers/ras/ras.c          |  1 +
 include/cxl/event.h        |  2 +
 include/linux/aer.h        | 13 +++++-
 7 files changed, 126 insertions(+), 12 deletions(-)

-- 
2.48.1


