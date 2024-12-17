Return-Path: <linux-pci+bounces-18627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C36199F4CD2
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 14:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169BC164EA4
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 13:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96331F4274;
	Tue, 17 Dec 2024 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dTc1nlP1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F521E485;
	Tue, 17 Dec 2024 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443655; cv=none; b=f/xeZhUuJgzHsKRLxSYSyCx1YH7vRWBWoSqh2Pdu2b3JxnoC7q49X8+vGDjwokX4jac9Pqe04APdeYVnYc2Ayh7r4QK5AC+oo26eoND0jfXhZw7MzqC67pgXhUB76fr69p4p3GVyemOCOKO/NNSQ7qMNLK2v5+KHDSvzNuCs8qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443655; c=relaxed/simple;
	bh=CZX/6/+OxDVXx5b5rYNO8um6p31384Ad+FAPxWdGq8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uGQxOwU4Vr60ZFtLfaa9/Gl+715P6DODgl+tGGcDNEMh6vGuzZbk9WhUub299By6HlJRSAm72z94J63wFpOibcdf521XVpPhyS6dpQwrjZEh0oxEdtlkimJ2qF5fANK/5OJMzJnNwW002fkCXQo0Zo/rE1hjZ+SMnTS48dWr9rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dTc1nlP1; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734443654; x=1765979654;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CZX/6/+OxDVXx5b5rYNO8um6p31384Ad+FAPxWdGq8E=;
  b=dTc1nlP1PKkgqyBlZnmiCVvIlFHUkTsW7lEViDw7dfgtRivQ73YqHEzQ
   lBnJPmE+lbJ4MTwAZ5TCCcvIWKXTAs1qcPZgqmZzn9FFW6k+F28bZKC5/
   5Io5H+22Q7K6Q0BvWKQ4Sf8V+9uifRBLaiFTNZDnaGDsf+/42gelfuljP
   zL5OBeB8184m+gZxwy78CuCs9jZc2SJnSPb0ABJJh3qit4EY0X5AdrOKi
   fsGDnM/Zl5p3jD6/eSxtNzVIDq3ge8y3mL0IzoTcThQy474b6QMMb3/Yo
   A5oe1WMRUG6M7fP9vsG+VOBUXPJhDiKyxSTu/EZ2pku2RW25juoXKFZdM
   g==;
X-CSE-ConnectionGUID: Dhzv5/vmSjCr4KHYZHe9bA==
X-CSE-MsgGUID: VJXK/fVmSNe5ch4EIGSeAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34192958"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="34192958"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 05:54:13 -0800
X-CSE-ConnectionGUID: js4GW3CoTES7nTTrGKNphw==
X-CSE-MsgGUID: 9tpaRidnRuqgyvaom6Gz5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="102634412"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.192])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 05:54:09 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v7 0/8] PCI: Consolidate TLP Log reading and printing
Date: Tue, 17 Dec 2024 15:53:50 +0200
Message-Id: <20241217135358.9345-1-ilpo.jarvinen@linux.intel.com>
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

I only now realized the last patch will conflict with my pci_printk()
cleanups series. I'm sorry for the extra hassle.

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
  PCI: Make pcie_read_tlp_log() signature same
  PCI: Use unsigned int i in pcie_read_tlp_log()
  PCI: Store # of supported End-End TLP Prefixes
  PCI: Add TLP Prefix reading into pcie_read_tlp_log()
  PCI: Create helper to print TLP Header and Prefix Log
  PCI/AER: Add prefixes to printouts

 drivers/pci/ats.c             |   2 +-
 drivers/pci/pci.c             |  28 ---------
 drivers/pci/pci.h             |   9 +++
 drivers/pci/pcie/Makefile     |   2 +-
 drivers/pci/pcie/aer.c        |  27 ++++----
 drivers/pci/pcie/dpc.c        |  14 ++---
 drivers/pci/pcie/tlp.c        | 112 ++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c           |  14 +++--
 include/linux/aer.h           |   3 +-
 include/linux/pci.h           |   2 +-
 include/uapi/linux/pci_regs.h |  11 ++--
 11 files changed, 158 insertions(+), 66 deletions(-)
 create mode 100644 drivers/pci/pcie/tlp.c

-- 
2.39.5


