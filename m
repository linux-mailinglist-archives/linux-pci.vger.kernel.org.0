Return-Path: <linux-pci+bounces-18700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FFB9F68B7
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 15:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F9E1885CA3
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 14:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DED1B041B;
	Wed, 18 Dec 2024 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJ65UKPV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC4F1C5CC2;
	Wed, 18 Dec 2024 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532680; cv=none; b=lTtvoiW5SRyt9lr0ekvdnVKhbIdmUUIR8+JvW0iy/femJAvYYgEHKlnopdnRdM8YCnVPFIQOlEE2Z2Noj5God58qOTakdOlAUQ1QQSDjbYG8uyDKY/MwODPVIg+FvFLQoKtqiHJqLcfLCGcpKfdn67Kttxb4joeZ1Mp4fRNNg7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532680; c=relaxed/simple;
	bh=hEYACrOz31CVWF4+kaFkukP67Pa2cOMxI/UHaf8xp/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JaVTPpP269tdMphLnH6mbhVthSXJq8y19MLJQRdw4ojfVtu9fYT/xnPUH0cgj6JThDZGI7FcJ+Iwou/THyVclpJkJRXAYlinWiEulSif42oYSrae05nfxrImFppVmvfiXxwyS8VLlTFTCNsaHT0UGzC6jxIQqvmkJ+hG5kNhzoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJ65UKPV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734532680; x=1766068680;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hEYACrOz31CVWF4+kaFkukP67Pa2cOMxI/UHaf8xp/A=;
  b=kJ65UKPVWsnhgYE/XKPhfid7KOvYozujzywlGQvSglIIWcmAgkIgICHQ
   mWda65uuLtce54ZW0kIjU+qlJbF/oepblAFcnzmAmeCViQiWJoKbFyeJs
   08k4URfKfofzqk5Z7in3v2+NavCRP6jR/7v8USsB2zLfr8EGdIaFxg366
   OhUfMjJXJ9m24kM0kG6PgAnrri744fOY+s47TUP4G0UmU4oF4Tu0XsK7P
   qHblM90Qh1ZgSTiPpn73uSCk4fdv50IqN5Q9oEBcvUHUF6XNL9aU6+N7y
   C9eZGFY3XdOEPQGv3QIFTQkJ1H45vDex5fmzww6FvuBbyaHMJOYBYOKN2
   Q==;
X-CSE-ConnectionGUID: /Wt5ELvMQOOKnd6S4/TSbg==
X-CSE-MsgGUID: Fi70ltiCQIS2ohEK4XApQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="45499306"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="45499306"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 06:37:59 -0800
X-CSE-ConnectionGUID: qVrAda+6R46rb42byuBurg==
X-CSE-MsgGUID: +bPR9X9US5y1ZRJjScW0Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="97726883"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.138])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 06:37:54 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v8 0/7] PCI: Consolidate TLP Log reading and printing
Date: Wed, 18 Dec 2024 16:37:40 +0200
Message-Id: <20241218143747.3159-1-ilpo.jarvinen@linux.intel.com>
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
 drivers/pci/pcie/aer.c        |  15 ++---
 drivers/pci/pcie/dpc.c        |  14 ++---
 drivers/pci/pcie/tlp.c        | 113 ++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c           |  14 +++--
 include/linux/aer.h           |   3 +-
 include/linux/pci.h           |   2 +-
 include/uapi/linux/pci_regs.h |  11 ++--
 11 files changed, 153 insertions(+), 60 deletions(-)
 create mode 100644 drivers/pci/pcie/tlp.c

-- 
2.39.5


