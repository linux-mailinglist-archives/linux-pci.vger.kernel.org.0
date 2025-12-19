Return-Path: <linux-pci+bounces-43415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 710B6CD130A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E3D1B302D2E0
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2441630E0FC;
	Fri, 19 Dec 2025 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KrbFCkDh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4471F168BD;
	Fri, 19 Dec 2025 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166047; cv=none; b=ONf9Oftyaq8z9B8NGIErPxywWfFVGK0xTEjC93MsglzvEdFlCI3ivFEBXPUcIazoMT2JxHJt9YsmphJBcprjZtVoHyuUP1qFUwcRG2KMg0kerScFsbFqFyrsm1x3w+JKUCYBHPbadlkYmP5aAsJthnD+Ju8/N2pHBGhgIhvMt48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166047; c=relaxed/simple;
	bh=m80wU3GhDejso1q2x+1T2e2nwWTxzJOz+8PD0DGTHeo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rwNhSaBhMS+MOAqishuQXlB92yhBURpJJqQvb1tWraCI08vzOAqGdxxCbX9lwZkMR+UWI7AagMEtUCmHwSzGCq2fcHSF5LYDniTYZkeydQ6vA1r540hbwQ4nZzhcVkXJ8P3WtQ/M6CY+YEpBbaQcHL6ZmG1X3QlgbvB8dkn+OGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KrbFCkDh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166045; x=1797702045;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m80wU3GhDejso1q2x+1T2e2nwWTxzJOz+8PD0DGTHeo=;
  b=KrbFCkDhppsQ4Hl5TJp/pP1CneTi5DbsmCNqYQMN873JXhnG4QA9CHHa
   VU9d4nuiBBFJGEfwseeUtcWTEHyhKmonC4PRaaq2wEj/RcHNgnV6xK5Lv
   90Ah6WPAa/ufhgZr9zEFGvDb6oWJ7egCJx0Ect9hhl9hs9XBdC0z2WLGc
   O/mxTdc/QtCXhvB/5A9k6BXE9fIFnfXcTZ/tJ/P1OkcytPtA/kGn+DH+7
   dCMxm/giEx3gb2xaJT2hNh/6kgcakERVSVNRdzgmccDnrTWnLohciOM45
   mXtT7IFyRTYdD6cAEstAINmexBHpBkSCuAco+iz+eqTvmh9gA/Pij0kR1
   Q==;
X-CSE-ConnectionGUID: nJKL9jABQKepjOexsXhj6Q==
X-CSE-MsgGUID: Tnf+cKfnQu6Ryl7zDuYxmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="71987457"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="71987457"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:40:44 -0800
X-CSE-ConnectionGUID: PIx8BFD0QCCckD8F25e3ZA==
X-CSE-MsgGUID: tUwhg/+oTcax689p9lPoQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="203315345"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:40:42 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 00/23] PCI: Resource code fixes (supercedes earlier series) & cleanups
Date: Fri, 19 Dec 2025 19:40:13 +0200
Message-Id: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

Here's the resource code fixes and cleanups series. The 6 patches (the
first 5 + 1 cleanup) have been submitted earlier (not yet applied, I've
closed the patchwork entries for them) but due to a number conflicts
that could easily ensue if these are applied independently, I had to
put all these into the same series.

The series consists of:

1. The first 5 are the most important changes as they relate to
   regressions. These may case shrinkage of bridge windows that
   previous had surplus space beyond the HP reservation size (due to
   sizes inherited from FW). In some HP scenarios the smaller bridge
   window could cause a regression, but this seems a case the pci=hpmm*
   parameters are meant to address.

2. Followed by cleanups (no functional change intended, excluding the
   extra debug logging added).

3. Introduction of pbus_mem_size_optional() to avoid the need to handle
   optional resource in a deeply nested loop (rebar awareness changes
   will have to add some code there). Doing all optional calculations
   in one place feels more logical and consistent anyway. There's a
   minor functional change in this change related to bridge windows
   with only optional resources (I don't expect issues because of it).

4. Separating CardBus bridge setup code to own file + compile it only
   when CONFIG_CARDBUS is set (I'd have wanted to send this separately
   but it seems impractical given that I need to rename the
   pci_dev_resource handling functions when exposing them to another
   file).

Any comments are welcome.


Ilpo Järvinen (23):
  PCI: Fix bridge window alignment with optional resources
  PCI: Rewrite bridge window head alignment function
  PCI: Stop over-estimating bridge window size
  resource: Increase MAX_IORES_LEVEL to 8
  PCI: Remove old_size limit from bridge window sizing
  PCI: Push realloc check into pbus_size_mem()
  PCI: Pass bridge window resource to pbus_size_mem()
  PCI: Use res_to_dev_res() in reassign_resources_sorted()
  PCI: Fetch dev_res to local var in __assign_resources_sorted()
  PCI: Add pci_resource_is_bridge_win()
  PCI: Log reset and restore of resources
  PCI: Check invalid align earlier in pbus_size_mem()
  PCI: Add pbus_mem_size_optional() to handle optional sizes
  resource: Mark res given to resource_assigned() as const
  PCI: Use resource_assigned() in setup-bus.c algorithm
  PCI: Properly prefix struct pci_dev_resource handling functions
  PCI: Separate cardbus setup & build it only with CONFIG_CARDBUS
  PCI: Handle CardBus specific params in setup-cardbus.c
  PCI: Use scnprintf() instead of sprintf()
  PCI: Add Bus Number + Secondary Latency Timer as dword fields
  PCI: Convert to use Bus Number field defines
  PCI: Add pbus_validate_busn() for Bus Number validation
  PCI: Move scanbus bridge scanning to setup-cardbus.c

 drivers/pci/Makefile          |   1 +
 drivers/pci/pci-sysfs.c       |   2 +-
 drivers/pci/pci.c             |  14 +-
 drivers/pci/pci.h             |  49 ++-
 drivers/pci/probe.c           | 128 +++----
 drivers/pci/setup-bus.c       | 644 ++++++++++++----------------------
 drivers/pci/setup-cardbus.c   | 306 ++++++++++++++++
 drivers/pci/setup-res.c       |   2 +-
 drivers/pcmcia/yenta_socket.c |   2 +-
 include/linux/ioport.h        |   2 +-
 include/linux/pci.h           |   6 +-
 include/uapi/linux/pci_regs.h |   5 +
 kernel/resource.c             |   2 +-
 13 files changed, 648 insertions(+), 515 deletions(-)
 create mode 100644 drivers/pci/setup-cardbus.c


base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.39.5


