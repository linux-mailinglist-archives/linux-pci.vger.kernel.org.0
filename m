Return-Path: <linux-pci+bounces-39300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892FFC08417
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 00:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358983BF39A
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 22:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C4424BBFD;
	Fri, 24 Oct 2025 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OUzS9495"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C4C35B130
	for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761345982; cv=none; b=uqWAZSyJ3x2MTi2gzYmNYdu6dyEgyFhfNK+1GV7ROKDFkxGl9ep/1BoT9KDoryq4GMkvb2t5m0jRsgQipuYX8SLWJOebfvYdVm2Comk66HTVoYNhl4jasOUWBZppktFgactUJG1GiB8zwbzSxOK3N/dVFF0fqmU9F81Wnxvfmmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761345982; c=relaxed/simple;
	bh=IhS4AOEI3/wzkSRbBumLxHWRksYyuUBKQRR2lHNyZns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z2mJPly4qzvHWbWsKUWuOIsvqkL7WgvFTu8SycnLGaPqzl56sm1MyAHTHnVrsGyb0hxMQ+sSp2XLB3rihiQzvm4q7PTe8fS87bDMdtEb1xsx2hWtnp/ubAXoY8Ks7Crst0mggAIOcxoWpiniOM0n864fA8eK3CFePEvhfUr8mDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OUzS9495; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761345980; x=1792881980;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IhS4AOEI3/wzkSRbBumLxHWRksYyuUBKQRR2lHNyZns=;
  b=OUzS9495PGMwV+IqIw7ra6vuarEx0hrvIvhgMYWWlq0TZxQDfObFxcCU
   cOzyJw1GJ1mVaXQCtVnAPI1t7d+zo358L8X3kN3WGbzj+K6dyoYbxswD3
   XCuUp4oEN0XEVyJ/oawbWt9jLoqTC8oq072ZIkCiDHfn5fG4eKITYWlK+
   I9KyqCSPjGYqJsUD3AQl1QvLpQZyqP3vBN33N6aviuetGJfNmC+NLTXWo
   qvi4tRcaMOpKJl63Dz33HUbD2kiuGYO31PyNlY/P3pgyGzIAgb6Htpd9P
   lPcDOSGnay2Y6H/oT1W/zdltFUhi4GccEXmFc50d0l3fstfWd/A3b3Ivp
   w==;
X-CSE-ConnectionGUID: E9jElcVNR86TUHCYs/S77Q==
X-CSE-MsgGUID: 37/yWt18SRuOM9y3CDvKmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="89001931"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="89001931"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 15:46:19 -0700
X-CSE-ConnectionGUID: nUQl/GoJTB+MkjWthg029w==
X-CSE-MsgGUID: uXqsvJ1wRbm5dxKq6v7Dpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="184608437"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa008.jf.intel.com with ESMTP; 24 Oct 2025 15:46:19 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	jonathan.derrick@linux.dev,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Szymon Durawa <szymon.durawa@linux.intel.com>,
	Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v2 0/2] PCI: Unify domain emulation
Date: Fri, 24 Oct 2025 15:46:20 -0700
Message-ID: <20251024224622.1470555-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1 [1]:
- Rebase on v6.18-rc2
- Support callers supplying both a hint and a range for the Hyper-V hint
  + fallback case (Michael)
- Add comment explaining domain number 0 vs Gen1 VMs, and domain values
  greater than U16_MAX concerns (Michael)
- Leave the VMD status quo comment about requesting domain numbers >
  U16_MAX

[1]: http://lore.kernel.org/20250716160835.680486-1-dan.j.williams@intel.com

The PCI/TSM effort created a sample driver to test ABI flows
(samples/devsec/ [2]). Suzuki observed that it only worked on x86 due to
its dependency on CONFIG_PCI_DOMAINS_GENERIC=n. I.e. an unfortunate
restriction for what should be an architecture agnostic test framework.

Introduce a new pci_bus_find_emul_domain_nr() helper that all "soft"
host-bridge drivers can share and hide the CONFIG_PCI_DOMAINS_GENERIC
details behind that helper.

[2]: https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/commit/?id=0e16ce0b9c64

Dan Williams (2):
  PCI: Enable host bridge emulation for PCI_DOMAINS_GENERIC platforms
  PCI: vmd: Switch to pci_bus_find_emul_domain_nr()

 include/linux/pci.h                 |  7 ++++
 drivers/pci/controller/pci-hyperv.c | 62 +++++------------------------
 drivers/pci/controller/vmd.c        | 40 ++++++++-----------
 drivers/pci/pci.c                   | 24 ++++++++++-
 drivers/pci/probe.c                 |  8 +++-
 5 files changed, 63 insertions(+), 78 deletions(-)


base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
-- 
2.51.0


