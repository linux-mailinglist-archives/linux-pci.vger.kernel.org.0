Return-Path: <linux-pci+bounces-19739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A3CA10D0A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 18:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34691887461
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 17:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D38192B76;
	Tue, 14 Jan 2025 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GftmBiyW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F340314B97E;
	Tue, 14 Jan 2025 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874531; cv=none; b=UQZHlmccuLoafsEp5a+jqm0wR4TnJjy5N5ZA85Ml99szQPxKtEus/e69DzzSitxSTFiAmrXrvo4u568JfNXFQowRvOKYO/Cl+75z75dV8sDXBjgFqNOIDZG9p3KYsyrZcaD3Cb7l+t/9jVGDSuaLnvt0Bw61N9Bopk32BGCp9H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874531; c=relaxed/simple;
	bh=QoAbELA2hs+ktMu/3uW492VdOm9IyqJhwn5EdVVM7mI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SKcnKC1QssuacX9mrWbmMtszXfS63VLZOXMvM8Qc6Dighntq+V9D2/R+qPChRjJr+go01x0nxDfA7bbqXOPH4ZtG88hOchQvtdnl59nQcBHCGZ6gD5FE8t/e+l9yDF8KMtYfXKFEGjtMX6kEdeSZFj7TqqyOMpsr7dua5DPk/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GftmBiyW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736874530; x=1768410530;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QoAbELA2hs+ktMu/3uW492VdOm9IyqJhwn5EdVVM7mI=;
  b=GftmBiyW1npoFHSiL3Bc38k1KUX3LBJ2rZeQm7AVL3RK8gw0bXXyjQb2
   jbdj0oPSw5d+PhBxdXzkKafk4fiG0lrWdkJCZ9V+53yQEiwG2sG0ofkBw
   J7owPYgEEXrCMUMb5ZPUj+ycvxVPlQe/7DJmhv4YmLobTye00Dvm0ryNx
   V9tSrW2j5gpAlPlReOrLD23bK4++bWbR8KCND04aN3QWSfdAgufg4qD/E
   l1CAmQSn57YogAspFoMXrtojaPDnmO3HnSccXYA40krOuuDDg9zdnTVFE
   lpTrR+YcEqZY75FMaf7wSn42TunPHV6+SLjtMBZYpkSshWVDLEjFPTgzz
   A==;
X-CSE-ConnectionGUID: 8zfdUJ6ASl6P7c8MVo3zBA==
X-CSE-MsgGUID: 3Kue+DC3TlSpsS7Chha43w==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="24783638"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="24783638"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:08:49 -0800
X-CSE-ConnectionGUID: YlLpw4xMTxWet7T/w8XAHQ==
X-CSE-MsgGUID: SIWtfQiCSp+OuqElbEBLNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="105377249"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:08:45 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v9 0/8] PCI: Consolidate TLP Log reading and printing
Date: Tue, 14 Jan 2025 19:08:32 +0200
Message-Id: <20250114170840.1633-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
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

v9:
- Added patch to define header logging register sizes.

v8:
- Added missing parameter to kerneldoc.
- Dropped last patch due to conflict with the pci_printk() cleanup
  series (will move the patch into that series).

v7:
- Explain in commit message reasoning why eetlp_prefix_max stores Max
  End-End TLP Prefixes value instead of limiting it by the bridge/RP
  imposed limits
- Take account TLP Prefix Log Present flag.
- Align PCI_ERR_CAP_* flags in pci_regs.h
- Add EE_PREFIX_STR define to be able to take its sizeof() for output
  char[] sizing.

v6:
- Preserve "AER:"/"DPC:" prefix on the printed TLP line
- New patch to add "AER:" also  on other lines of the AER error dump

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


Ilpo Järvinen (8):
  PCI: Don't expose pcie_read_tlp_log() outside of PCI subsystem
  PCI: Move TLP Log handling to own file
  PCI: Add defines for TLP Header/Prefix log sizes
  PCI: Make pcie_read_tlp_log() signature same
  PCI: Use unsigned int i in pcie_read_tlp_log()
  PCI: Store # of supported End-End TLP Prefixes
  PCI: Add TLP Prefix reading into pcie_read_tlp_log()
  PCI: Create helper to print TLP Header and Prefix Log

 drivers/pci/ats.c             |   2 +-
 drivers/pci/pci.c             |  28 ---------
 drivers/pci/pci.h             |   9 +++
 drivers/pci/pcie/Makefile     |   2 +-
 drivers/pci/pcie/aer.c        |  15 ++---
 drivers/pci/pcie/dpc.c        |  22 +++----
 drivers/pci/pcie/tlp.c        | 115 ++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c           |  14 +++--
 drivers/pci/quirks.c          |   6 +-
 include/linux/aer.h           |  12 +++-
 include/linux/pci.h           |   2 +-
 include/uapi/linux/pci_regs.h |  11 ++--
 12 files changed, 172 insertions(+), 66 deletions(-)
 create mode 100644 drivers/pci/pcie/tlp.c


base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
-- 
2.39.5


