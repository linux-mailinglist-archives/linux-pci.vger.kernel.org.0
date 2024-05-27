Return-Path: <linux-pci+bounces-7855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E907D8D0545
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 17:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7A2282B56
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 15:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7D816DED8;
	Mon, 27 May 2024 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BMc07xs9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E5716DED5;
	Mon, 27 May 2024 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821055; cv=none; b=Yg7c/19JgtpB03dBjZsTP3wtaIhjyUd34aFw1jd0GPGQOWLkAfzdpiUkTgwvkcsDp+7f/gyay3BX6YR/DtbVf34EiwgJ3SqRuX6KiLlG3VHBq62vpQ8U7D4J/CIb/+Bj8BNIrNZ93n4fbYq3F/veQvUtjco/ykdsayy0VqTHlzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821055; c=relaxed/simple;
	bh=N2BkBEfMjIfRh7g1dfIjn0MfLhYtzu3BShYG5yFIizg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=elpcgPIfv5DifaKLR+oFtak8ZTbIEctD+ebl7Zal+F85XHYh9EGTMvXk9YA7sr8sV3T2hVq2SBUJ3L2tqFxO8Xv1uUbna+Z2ezxMM6AaaKJlUI8CJfUoHvUEm0uph39a/yAUC1O+kHU9/CHx/4RYMuycQHC9vkOqa5sf1uUCx7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BMc07xs9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716821054; x=1748357054;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N2BkBEfMjIfRh7g1dfIjn0MfLhYtzu3BShYG5yFIizg=;
  b=BMc07xs9fWBvYLj1oBlPak5DdUH5Q9KHPix8OVZDlCbXI4USga4VPUsr
   caS0F1WSRhAIzw7/R8/Tg9nakOMbwf5JAyFQlq/490xBznFlMazHoMTUv
   aWFWh7OdMiOIUrcAV9jqoyxfNzbyvCQ8D+7tkSl2A+jYHR6VjyNJ1QaJN
   ZGioPMM3eG04Cbqor5JOahXem0teFvbJyt1ZrhTPHoJO/Y4VkEVO/wcw4
   pvMmtnnbqBnuK2PBWDr7vW9kKLZIJcGEH2cpUc/nIvjZ1JyaXqRSoRDrs
   +AdrMJtkCjw5GmKfn7CVUWhDZRTs50R6+RVyPi5jsEy1IFeg2/ZQIIJS5
   g==;
X-CSE-ConnectionGUID: WNaqFvGqSKqxbFgHYlUGIg==
X-CSE-MsgGUID: RLae22qHSGWcJjojIvUOag==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13269742"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="13269742"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 07:44:13 -0700
X-CSE-ConnectionGUID: Y71KIk33R0SQTM5KxhYC5w==
X-CSE-MsgGUID: R+PV6+o1R+Oqcy6DJptl2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="35279780"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.246.214])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 07:44:09 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 0/2] Make ELOG log and trace consistently with GHES
Date: Mon, 27 May 2024 16:43:39 +0200
Message-ID: <20240527144356.246220-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.45.1
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

Fabio M. De Francesco (2):
  ACPI: extlog: Trace CPER Non-standard Section Body
  ACPI: extlog: Trace CPER PCI Express Error Section

 drivers/acpi/acpi_extlog.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/aer.c     |  2 +-
 include/linux/aer.h        |  9 ++++++---
 3 files changed, 42 insertions(+), 4 deletions(-)

-- 
2.45.1


