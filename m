Return-Path: <linux-pci+bounces-35097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E05D7B3BC09
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FAA51890731
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C462EB869;
	Fri, 29 Aug 2025 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bEn+vtKS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B485333F3;
	Fri, 29 Aug 2025 13:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473086; cv=none; b=tXUWmJV4Q2F1B04a2ybmrJHgWJ0992t22VY61H8K2951APJT/mZophLttLkRvxRINW/oCkv5dcVMRY11Xsz4hkZthi7xUlCTDeDPn4lmwbESVfMxs6Wki7q/bVnZKGSDgc+STQjCb+3+2clJmg9AogJXoYi3htrkHCU4Qq6Bqpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473086; c=relaxed/simple;
	bh=6MKDfUnRhY6hfFmnDtD7dFoQMyonLl3m8ha2jnhnSWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=to0mH09268A+8GYP7rXCGArQ+1tifu/RyaBprEp2uEmnedP4DcKWbzF7/tKK3X82ppwWHLeKJ6rUrNAaYYPl0UpYoUmCs2t+qkb0u+0PtYId8lzvwb6S7frF2ZiNz4BJQyNjKebqmPZYXgj36lwKToahk+oVF3xkXiXh9xhQgjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bEn+vtKS; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473085; x=1788009085;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6MKDfUnRhY6hfFmnDtD7dFoQMyonLl3m8ha2jnhnSWk=;
  b=bEn+vtKSrFk1THQaAe9jm+QUzpAGv5fjvOUQK3ns/18cG0i8ITEyAatV
   VL5NjCZLnQ9N/+RBQqjQTD7EXV7qMyJLZTk0zNXQHmP8TrLnbYKiy82fY
   ZF+J2MID6ie1bOUKB8zjqL1II+NTZhLcyrKsS/02sNMWAi4/+1ACygexF
   tDAmw2727ZKIqxHFqPcR4XcgmZfbG8cYYcFDSA4wLmfb90eb2SsIlAp1y
   uMR3ewarv5K1c+PfmnwWRRCEXNBNiT41oKZid5ODbgXcKYa+7GWJYVP5c
   HqiQMaayGGSKPyCU+XHrrqoLDteiXM6U0Klj7o10V/hkMMHYYZL2Y7CXf
   w==;
X-CSE-ConnectionGUID: dsr7DY3FQ7+IdDTf/tfxSg==
X-CSE-MsgGUID: 7APJvEgWS3KWCm9Pm1R5Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58687479"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58687479"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:11:24 -0700
X-CSE-ConnectionGUID: PztaruqKTTGTV9qsMIMQqQ==
X-CSE-MsgGUID: ItUXWdWHR26EesRk9+WzIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="174550832"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:11:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 00/24] PCI: Bridge window selection improvements
Date: Fri, 29 Aug 2025 16:10:49 +0300
Message-Id: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series is based on top of the three resource fitting and assignment
algorithm fixes already in the pci/resource branch. I've tried to compare
these patch with the commits in the pci/resource branch to retain the minor
spelling/grammar corrections Bjorn made while applying v1.

v2 is just to fix two small issues within the series intermediate patches.
These corrections attempt to ensure this series is bisectable if
troubleshooting requires that in the future.

In addition, a few corrections to changelog texts were made.

I'm left to wonder though if the added double spaces after some stops
within the commit messages in the pci/resource branch were intentional or
not (I did remove them for v2).

As the changes are very minimal, I'm only sending this to lists and Bjorn
to spare people's inboxes. If somebody provides a Tested-by tag for v1, it
should be counted in for this v2 (v1 vs v2 difference does not matter if
testing the entire series).

v2:
- In pci_bridge_release_resources():
    - Keep type assignment in until removing the type hack.
    - Introduce res_name in the patch it is used avoid compiler warning
      about unused variable. Place it into the block that needs it.
- Minor corrections to changelog texts

Ilpo Järvinen (24):
  m68k/PCI: Use pci_enable_resources() in pcibios_enable_device()
  sparc/PCI: Remove pcibios_enable_device() as they do nothing extra
  MIPS: PCI: Use pci_enable_resources()
  PCI: Move find_bus_resource_of_type() earlier
  PCI: Refactor find_bus_resource_of_type() logic checks
  PCI: Always claim bridge window before its setup
  PCI: Disable non-claimed bridge window
  PCI: Use pci_release_resource() instead of release_resource()
  PCI: Enable bridge even if bridge window fails to assign
  PCI: Preserve bridge window resource type flags
  PCI: Add defines for bridge window indexing
  PCI: Add bridge window selection functions
  PCI: Fix finding bridge window in pci_reassign_bridge_resources()
  PCI: Warn if bridge window cannot be released when resizing BAR
  PCI: Use pbus_select_window() during BAR resize
  PCI: Use pbus_select_window_for_type() during IO window sizing
  PCI: Rename resource variable from r to res
  PCI: Use pbus_select_window() in space available checker
  PCI: Use pbus_select_window_for_type() during mem window sizing
  PCI: Refactor distributing available memory to use loops
  PCI: Refactor remove_dev_resources() to use pbus_select_window()
  PCI: Add pci_setup_one_bridge_window()
  PCI: Pass bridge window to pci_bus_release_bridge_resources()
  PCI: Alter misleading recursion to pci_bus_release_bridge_resources()

 arch/m68k/kernel/pcibios.c   |  39 +-
 arch/mips/pci/pci-legacy.c   |  38 +-
 arch/sparc/kernel/leon_pci.c |  27 --
 arch/sparc/kernel/pci.c      |  27 --
 arch/sparc/kernel/pcic.c     |  27 --
 drivers/pci/bus.c            |   3 +
 drivers/pci/pci-sysfs.c      |  27 +-
 drivers/pci/pci.h            |   8 +-
 drivers/pci/probe.c          |  35 +-
 drivers/pci/setup-bus.c      | 798 ++++++++++++++++++-----------------
 drivers/pci/setup-res.c      |  46 +-
 include/linux/pci.h          |   5 +-
 12 files changed, 504 insertions(+), 576 deletions(-)


base-commit: 295524c65d8b4850efbb809f12176eb1262a5aba
-- 
2.39.5


