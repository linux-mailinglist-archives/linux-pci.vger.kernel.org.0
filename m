Return-Path: <linux-pci+bounces-39144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD94C011CA
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 14:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3950F3A59C3
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 12:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ACD3074AA;
	Thu, 23 Oct 2025 12:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XL1J53yy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1DD3009C1;
	Thu, 23 Oct 2025 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761222389; cv=none; b=YOUmtZVrpdtEEMOyALGaYcGP8Mh5rzNHo9mS4n1fA5WIaEfoYkUXz1tk89IYYWSmyuHYhCO8jqBdVJmSUFyi4dbiPbSQHAg7nUJ04Coxd1toeZnzujpf3z3QUnyVhkrGXF7xNxJB6ab3RylWgmSff2YL1Ljjdb9G/tW2FOpzPI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761222389; c=relaxed/simple;
	bh=WkRBZU6DdRBPBvlJ2N3/YkvCzsXVTcOCM1yMrI1FnBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KXDs/mSRXdO5+MiabN87MvT9ndsy/qKOJeSdSPfuMcd2Bj6gdRs+Lt0qxWY0FtC5HeBTIaLcvxOFvw/z+oab5loDnvqp9OApWpt0L3fqG+HXxKjsAPdoSCOa8esIi3MMR0Mdj8tythvE8lb9ZP83XxqMEXU/+9m9lHiqiCgxal4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XL1J53yy; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761222388; x=1792758388;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WkRBZU6DdRBPBvlJ2N3/YkvCzsXVTcOCM1yMrI1FnBQ=;
  b=XL1J53yy9A1x2CwuIACbnVU6be6/JKwJNpdL6cmUu4E9xgpOw3MNCQlR
   hX4LCwRLSlbdGk6vgGkGtyNdTpJwG5o3HryefyUm4nEPTnSreQhIMHXpz
   FqbKJmEXc9BTuj2aVDDIJLN3euddcLjPXPcpndZLAvIzZL44LCM6H1Wsd
   DMFwoR15Npz1T8emFt8NR27rgViVW4eIPT+jr/hJT4VR4qcNOD28cGnMW
   /DC2kue1TN9Cf6kTvXb/TBGCKiNF1kQ4YAIpLhpfiprQhifYWrGRrk7kd
   yJgNiby4lVnPcie8J6ygQ6Yp2OPf1bBOUnx9LwM0MNygjLE4oJ90sKXtK
   w==;
X-CSE-ConnectionGUID: CaTSF8OJQlSLCYlHFJSMtg==
X-CSE-MsgGUID: EO+RrIOOTXWa51nqqdr9wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73992775"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="73992775"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 05:26:27 -0700
X-CSE-ConnectionGUID: rbNur2/2SmyTNh2buCmzcQ==
X-CSE-MsgGUID: Thbs1WH3RtSINmLU3Tnm6g==
X-ExtLoop1: 1
Received: from unknown (HELO fdefranc-mobl3.igk.intel.com) ([10.237.142.160])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 05:26:16 -0700
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
	Sunil V L <sunilvl@ventanamicro.com>,
	Xiaofei Tan <tanxiaofei@huawei.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	Xin Li <xin@zytor.com>,
	Will Deacon <will@kernel.org>,
	Huang Yiwei <quic_hyiwei@quicinc.com>,
	Gavin Shan <gshan@redhat.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Li Ming <ming.li@zohomail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Jon Pan-Doh <pandoh@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Shiju Jose <shiju.jose@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 0/6 v6] Make ELOG and GHES log and trace consistently
Date: Thu, 23 Oct 2025 14:25:35 +0200
Message-ID: <20251023122612.1326748-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.51.0
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

 drivers/acpi/Kconfig       |  1 +
 drivers/acpi/acpi_extlog.c | 60 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/apei/Kconfig  |  1 +
 drivers/acpi/apei/ghes.c   | 62 +++++++++++++++++++++++++-------------
 drivers/cxl/core/ras.c     |  6 ++++
 drivers/pci/pcie/aer.c     |  2 +-
 include/cxl/event.h        | 22 ++++++++++++++
 7 files changed, 132 insertions(+), 22 deletions(-)


base-commit: 552c50713f273b494ac6c77052032a49bc9255e2
-- 
2.51.0


