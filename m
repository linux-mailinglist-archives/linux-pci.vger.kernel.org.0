Return-Path: <linux-pci+bounces-13173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E129782A5
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 16:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 709F4B20E88
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 14:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690178F6A;
	Fri, 13 Sep 2024 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZxE1l5kH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B7F1A269;
	Fri, 13 Sep 2024 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238209; cv=none; b=s2ZDGWC06cvI8KyHbcqENefAM+VQdBvt7e0WKC70EImat8qvMZdRhss9rebzx3GfTm2ELBt8i1OZQc0yrWzoKJlqxsWVj/W8pf5q2CRXbFgG9QCyU9crwxJdkvuQarF1lT4dwWZT+xUHanKmn3l4jA8CUnh+hG72NVWSGaUMehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238209; c=relaxed/simple;
	bh=4EVcw5ALi48rEKGiCGqMlcmXwSupGapNFrHyhpwwt9M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gTPOi6ocgfoZHoURtaV8Zt19mKnoZO5+Qdh+dBqQVGkYqdkq8qwSNDj0SDpP7h8vRwp9rK7AgE+t+prXUcAt6oBuAN82tOTfcTgjolgYb9VUTeg3J99PnWuDC2UZ++Uj9pgWZuHuuzahRdAUghiyju8dJ0P8Nb7sB2YnmqAXyMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZxE1l5kH; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726238207; x=1757774207;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4EVcw5ALi48rEKGiCGqMlcmXwSupGapNFrHyhpwwt9M=;
  b=ZxE1l5kHBwY/bkcpgX7pL6DGwV0LyYb5kSYUq4Xu/vfEDa9rpokjjOei
   5ENRztUqlselhM014Hb+U7+ggbamKq2JQ4XwzrgDUSmWfy4bY3zscXc26
   U5dUfmebm9tONUVc42GCizV7SA0nv7nARbk5se02Fed954mb+sJPJsdyr
   /8f4CB149syzDn5IO8rGJoWZjqIuzS2HmRkAZVVsI2OHxZXMkjd+RWBc5
   Qs33EtWGhDgE4iD4f4bLQlGzMjDzTjN5Z8b4taW/XH7ZM/RkzMAsr6BgU
   u1zDrS+a0rTNWjN1aSXT4J36W6IopmviPUd5uRfNB3weiKRYPciUDj347
   g==;
X-CSE-ConnectionGUID: VmR8LNf2Q0KZqnt9md9RBA==
X-CSE-MsgGUID: QQpGMMNCR3mAkoiMrtb2Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25075216"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="25075216"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 07:36:46 -0700
X-CSE-ConnectionGUID: 6GCoO4HsQIyf9VPHugOaeQ==
X-CSE-MsgGUID: sK3F++UySP2dM8Q4dUBCdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="67934555"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.154])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 07:36:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v6 0/8] PCI: Consolidate TLP Log reading and printing
Date: Fri, 13 Sep 2024 17:36:24 +0300
Message-Id: <20240913143632.5277-1-ilpo.jarvinen@linux.intel.com>
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
 drivers/pci/pcie/aer.c        |  26 ++++----
 drivers/pci/pcie/dpc.c        |  14 ++---
 drivers/pci/pcie/tlp.c        | 109 ++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c           |  14 +++--
 include/linux/aer.h           |   3 +-
 include/linux/pci.h           |   2 +-
 include/uapi/linux/pci_regs.h |   2 +
 11 files changed, 149 insertions(+), 62 deletions(-)
 create mode 100644 drivers/pci/pcie/tlp.c

-- 
2.39.2


