Return-Path: <linux-pci+bounces-7329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DAD8C219C
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 12:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812941F22C91
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 10:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515CC168AE6;
	Fri, 10 May 2024 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iw3ADmvS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7337E4AEFA;
	Fri, 10 May 2024 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335664; cv=none; b=JVvIdQBbhIthFvpspEECjwA4XNswgDNUxRNnY3p3I+uOvJkRhfZ8ihpm0gT58cRzM7nCG57aOP5mudjbcIrlNT68xXmRR4CnQcFqy8gmORM9272SUg9dWdrUpTkdoTW2dGreiryqmh/Py9sNN/P+Yr4P2GP8A9/cBYLKSfam4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335664; c=relaxed/simple;
	bh=OCWYMtnallfof9cmVRtJ1kPAbbWtnFDn34D2Owmif80=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=R4+kHNL7yJEzstgE1551vbjknicjLk7iZWLeuUzCh4BzphBObYTzZvbcZo1dQZeE2ZCvd7IEcQywLgeZ/j9PmUPpPeLglFbBlWD18LbJKYveaGMaA79HN5NjS5R8OVnlaGsgS8dHnLJ10u8+iQpRIO2gSQr5oR0GqbSE8sM1u8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iw3ADmvS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715335663; x=1746871663;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OCWYMtnallfof9cmVRtJ1kPAbbWtnFDn34D2Owmif80=;
  b=iw3ADmvSlN31zged0lShMKSPPp5H8SLX3KkNa2EbpDsNsirU1IKVTyWD
   z57aYsmj4qr1KcTEvdiosOLph9RoxtSHf4UIpaQi8KRTlFUCCBpGpvQvS
   wvyZlOtXLwonFGTJbNBSaT6RewFXStwWFb2hbiE9ZWzpm33GcMSxCs3bG
   hpsSX6ERopzE+/L6xp+L1XHgl//1Y4wsrvqaM0oB0MFMNG9aHrUpcyDUG
   ruK3e1hJe6VQGkLsJ3ZrxuepQzvPsjgaW7/hdHhXkpEOo0/V9tn2glSJH
   L/R+nnb0kKyD2nECf7OYYOreeOgpr3J1SbBDYlXjZYHmmniGV/iz1rKz4
   A==;
X-CSE-ConnectionGUID: PSu2ol+FSKS9xh4DVcsdiA==
X-CSE-MsgGUID: 38UwueWPSZaXNIR03L0Ryw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11144825"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="11144825"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 03:07:42 -0700
X-CSE-ConnectionGUID: TqrY0fPERpWwBY1Kjl+aIA==
X-CSE-MsgGUID: iZwTQAU0TY6ihNHFo1S42A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29588212"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.85])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 03:07:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 0/7] PCI: Consolidate TLP Log reading and printing
Date: Fri, 10 May 2024 13:07:23 +0300
Message-Id: <20240510100730.18805-1-ilpo.jarvinen@linux.intel.com>
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
 drivers/pci/pcie/tlp.c        | 107 ++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c           |  14 +++--
 include/linux/aer.h           |   3 +-
 include/linux/pci.h           |   2 +-
 include/uapi/linux/pci_regs.h |   2 +
 11 files changed, 141 insertions(+), 56 deletions(-)
 create mode 100644 drivers/pci/pcie/tlp.c

-- 
2.39.2


