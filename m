Return-Path: <linux-pci+bounces-8103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EEE8D5781
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 03:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E902288AC3
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 01:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7251F5258;
	Fri, 31 May 2024 01:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNe/DFRC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F1A1CFA8;
	Fri, 31 May 2024 01:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717117461; cv=none; b=ZxYeR/DeXSORfLQVppTAU5rAPqteBJx6uO2zVm3S0Sw0PjGrXf4e+IYdWXhKZCgwMhycBHdhbvkjuovgEGdQWYCSTsyD48YJUpYiKtghAe6uuNyOOA85jOVutqceMIl+p0GwFNr+pGRORiSxje5LteLS3VWT5BwxJYdUSLWsHAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717117461; c=relaxed/simple;
	bh=abAk7mA+rsV5IZXkrCgVcQjrR1gtG6P8LrgYPddhcik=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=MI8vM+KBMaZBcF08Yaj8aZ+RKu8GVieQaA6wgLJwqDFc5YQVvnmzv3iavCyXf/dBUC7cPWJdoJhMyupVwzhgCVy7IMuRwsKxa91grIWY6EXVxGKn0bgUQrqUmgOseo3F3HX+sViyTU6HQWnO/SH3gfTqXSh4BaZW4eYo1NzU8Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNe/DFRC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717117459; x=1748653459;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=abAk7mA+rsV5IZXkrCgVcQjrR1gtG6P8LrgYPddhcik=;
  b=JNe/DFRCBsYkdgZjAkmMBfgj7EcgI1CJeVzR2O8fCwChDsimkUd0CDPl
   mKZ2igGKcQjf7q3cB/mMyFVaG+lxKWQyZVYAn5DUTVfpjdpOiks8Zs4kH
   +HSaZIrdjLnYcPCmPxdDn9dSYOf90R+K6LGsdT+BECtOmocSXYsUSqkAA
   gUPwePqol026Pd+NY2t8jtZ9G7Wd0xP3cJst1dSHnty3mTv3AYXt964cz
   g5EJuPS8tsSok1RiyRY3Hqm3V6mDoE2MRGqHqs6A7+g+YADh0NWhrlo8F
   NrlEDSumnWzoHZJyYGJIXPopM4B6cEMjSHBlupp7b1aAkA51iV/lpDIrB
   A==;
X-CSE-ConnectionGUID: 06UbkPW1TiCw9hzZX5Dogg==
X-CSE-MsgGUID: unOAgcCJThmkqGKRrlrXyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24308742"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="24308742"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 18:04:19 -0700
X-CSE-ConnectionGUID: G487IlTsRqatTR+8oN4qKQ==
X-CSE-MsgGUID: dwdlnVFbTHehSUibmMlevA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36624024"
Received: from spittala-mobl3.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.84.244])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 18:04:19 -0700
Subject: [PATCH v2 0/3] PCI: Revert / replace the cfg_access_lock lockdep
 mechanism
From: Dan Williams <dan.j.williams@intel.com>
To: bhelgaas@google.com
Cc: Dave Jiang <dave.jiang@intel.com>, Imre Deak <imre.deak@intel.com>,
 Jani Saarinen <jani.saarinen@intel.com>, linux-pci@vger.kernel.org,
 linux-cxl@vger.kernel.org
Date: Thu, 30 May 2024 18:04:18 -0700
Message-ID: <171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Changes since v1 [1]:
- split out the new warning into its own patch (Bjorn)
- include the provisional fix to the pci_reset_bus() path

[1]: http://lore.kernel.org/r/171709637423.1568751.11773767969980847536.stgit@dwillia2-xfh.jf.intel.com

Hi Bjorn,

Here is the targeted revert of the cfg_access_lock lockdep
infrastructure, but with the new proposed warning for catching "unlocked
pci_bridge_secondary_bus_reset()" events broken out into its own change.
I also included the proposed fix for at least one known case where
pci_bridge_secondary_bus_reset() is being called without
cfg_access_lock.

Given there may be more cases to unwind, and the fact that I am not
convinced patch3 will be problem free I would, as you suggested,
consider patch2 and patch3 v6.11 material. Patch1 is urgent for v6.10-rc
to put out these lockdep false positive reports.

---

Dan Williams (3):
      PCI: Revert the cfg_access_lock lockdep mechanism
      PCI: Warn on missing cfg_access_lock during secondary bus reset
      PCI: Add missing bridge lock to pci_bus_lock()


 drivers/pci/access.c    |    4 ----
 drivers/pci/pci.c       |    8 +++++++-
 drivers/pci/probe.c     |    3 ---
 include/linux/lockdep.h |    5 -----
 include/linux/pci.h     |    2 --
 5 files changed, 7 insertions(+), 15 deletions(-)

base-commit: 56fb6f92854f29dcb6c3dc3ba92eeda1b615e88c

