Return-Path: <linux-pci+bounces-7446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E32078C530A
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 13:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20CBA1C21692
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 11:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E61F139580;
	Tue, 14 May 2024 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLT3tTdV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AD358AC4;
	Tue, 14 May 2024 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686282; cv=none; b=Nh+muwBJgG+MxymR3obhhNtdyXBE24RJA1JjwaFzipKqM/0ywNt2CH/lAeDHG4S/q4n3KOB6JwFtnKS9lVCCjtU5PpmlXHmJfPpW+mB1wOwRIyzSRR9jWXK4TI0La5T8BHxZyfE9pOVn5qDVDNsiY3reeGd2htbt9TvHez5WtDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686282; c=relaxed/simple;
	bh=jJsIyGCb+UYU0upD3tEgow1pHR8mvqbiW1YtMiSq/uk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=B+mjsnsnWpnYTfrDlneTKqgk6g/V8pZfbScTS+aLZwtLjkQnZFI+Pg95LLB6cbGxEa/7ujQp9PLqCe2uDaW/dt22vpEMPyACCsF9IqlBffcbnlmvgUTdgOpO463i4MG//3BplJS3KkYt1zObmaPEBm50CMqEGdIIQmhLFaut7IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLT3tTdV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715686281; x=1747222281;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jJsIyGCb+UYU0upD3tEgow1pHR8mvqbiW1YtMiSq/uk=;
  b=bLT3tTdV1B/BOHuHBgUENNqCBYSrUKiK4kl1leccxq1tGGGk0MCelrle
   i53iYEm/0DOlpUz4uervlutyHgavXRVq9XekvIAqMyOjE6XwBe69IUav7
   QN2o7gXzNrnVyblSBp/0HFPZxz+rtcf3mFatjv8trzanMlyMM/gCJdcXu
   +mrVo5grURR/oj1BM7CizH/hVq/whVI0QrYWPB5YHdigWoBSRnYFNsDQS
   kq/nKnfGAuiLXlvO+fi9U8e2aem3ZvYl9fTAqNqbq2pqzAv9U+BWXAwMF
   8hOv7R9x4oUck7XEtams/xevzXuXxYimqv6G1cgLlWjNrtVMD6tmeoYx2
   g==;
X-CSE-ConnectionGUID: bRt5z8nCSIu4t9ciQJ6crQ==
X-CSE-MsgGUID: AlY+29m4RH2qpon5L+7/Xw==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11532812"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11532812"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 04:31:20 -0700
X-CSE-ConnectionGUID: mijAQijJQFGOD+cpqW0VZg==
X-CSE-MsgGUID: Rk5dwf0BSwaiBBbO4hvl7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35179610"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.94])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 04:31:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 0/7] PCI: Consolidate TLP Log reading and printing
Date: Tue, 14 May 2024 14:31:02 +0300
Message-Id: <20240514113109.6690-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series has the remaining patches of the AER & DPC TLP Log handling
consolidation and now includes a few minor improvements to the earlier
accepted TLP Logging code.

v5:
- Fix build with AER=y and DPC=n
- Match kerneldoc and function parameter name

v4:
- Added patches:
	- Remove EXPORT of pcie_read_tlp_log()
	- Moved code to pcie/tlp.c and build only with AER enabled
	- Match variables in prototype and function
	- int -> unsigned int conversion
	- eetlp_prefix_max into own patch
- struct pcie_tlp_log param consistently called "log" within tlp.c
- Moved function prototypes into drivers/pci/pci.h
- Describe AER/DPC differences more clearly in one commit message

v3:
- Small rewording in a commit message

v2:
- Don't add EXPORT()s
- Don't include igxbe changes
- Don't use pr_cont() as it's incompatible with pci_err() and according
  to Andy Shevchenko should not be used in the first place

Ilpo Järvinen (7):
  PCI: Don't expose pcie_read_tlp_log() outside of PCI subsystem
  PCI: Move TLP Log handling to own file
  PCI: Make pcie_read_tlp_log() signature same
  PCI: Use unsigned int i in pcie_read_tlp_log()
  PCI: Store # of supported End-End TLP Prefixes
  PCI: Add TLP Prefix reading into pcie_read_tlp_log()
  PCI: Create helper to print TLP Header and Prefix Log

 drivers/pci/ats.c             |   2 +-
 drivers/pci/pci.c             |  28 ---------
 drivers/pci/pci.h             |   9 +++
 drivers/pci/pcie/Makefile     |   2 +-
 drivers/pci/pcie/aer.c        |  14 ++---
 drivers/pci/pcie/dpc.c        |  14 ++---
 drivers/pci/pcie/tlp.c        | 109 ++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c           |  14 +++--
 include/linux/aer.h           |   3 +-
 include/linux/pci.h           |   2 +-
 include/uapi/linux/pci_regs.h |   2 +
 11 files changed, 143 insertions(+), 56 deletions(-)
 create mode 100644 drivers/pci/pcie/tlp.c

-- 
2.39.2


