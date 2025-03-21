Return-Path: <linux-pci+bounces-24370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A65A6BFBB
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 17:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A1917E4FF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 16:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D0C1D86DC;
	Fri, 21 Mar 2025 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L0WuCZSX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB8514601C;
	Fri, 21 Mar 2025 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574085; cv=none; b=YAcGXMoE349Me9Swj7a4hRYDyc9FI1qLspyoKAmPzW8LCZVf+255vcE6B4k2nfPYHiGndEMMfPqlY5UuToeELg2Q7MionEajuNno8XPoa+cP8oQiAcMpOVXcc3miDzwv3rkRo0qLTCf0YYuGm5BrGyDZwDY6asj1sdFcujdilCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574085; c=relaxed/simple;
	bh=e8HyGx+31UnR/GpZxIrV+eNyLSuBm+MWfmWimk8Ut2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YI/dbJUaO4Fg+CJtDCv3ZRZ7iczA/2aAcG19buMlLXdORHczHKvueWETwG4es371Qqnwi2Eovo068eCsHz3Lr9yn8NlB800tIs6DfkbeOoLj4j0PyWIo/HNNjLRdiQs04i/XNbAcQ5Larf1N7EAcMqrVtIvFlyzvArOpWinygRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L0WuCZSX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742574084; x=1774110084;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e8HyGx+31UnR/GpZxIrV+eNyLSuBm+MWfmWimk8Ut2U=;
  b=L0WuCZSX3cbSqSHfkRkdCJ+r2vY23RAvu7RrFv5INIdjtquNj+JgTbDX
   HQ//VSjRptovklqgpApu+4NSvycvXldBdgSf/PXsTlc6wKYHHXTqvYqZS
   HiLQwYZC5s/K/J1WUOgttgGjjdJDUqaPBCLmzVeszImSIOVAvhqGHQFHP
   4kJ6KJks/hUdQb6JMJhEyV04C8GCP1i2VAoel4+tAoGvu+ZSCfq1jkf2q
   Um4FPfqGZyTBUVEu+n6nJK+/Yh+vGRgtck8UaDtJx9KfZGKCF8RBfJpia
   WVQc991E2q2HAvfCPFbvXq89Fw8Q8ZkdMUwtZg72XS4c2YvRvgHt+bkyt
   g==;
X-CSE-ConnectionGUID: DIrk0o+HQpu186eYAGXWiQ==
X-CSE-MsgGUID: vCBHv3CaT+CcjTeXxQ0K1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="47503046"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="47503046"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 09:21:23 -0700
X-CSE-ConnectionGUID: 944zfTjuQ1CMrijVWpKgVA==
X-CSE-MsgGUID: UjiuwLNOReaImB7My2ak+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="123618978"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 09:21:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v2 1/1] PCI/hotplug: Don't enable HPIE in poll mode
Date: Fri, 21 Mar 2025 18:21:14 +0200
Message-Id: <20250321162114.3939-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCIe hotplug can operate in poll mode without interrupt handlers using
a polling kthread only. The commit eb34da60edee ("PCI: pciehp: Disable
hotplug interrupt during suspend") failed to consider that and enables
HPIE (Hot-Plug Interrupt Enable) unconditionally when resuming the
Port.

Only set HPIE if non-poll mode is in use. This makes
pcie_enable_interrupt() match how pcie_enable_notification() already
handles HPIE.

Fixes: eb34da60edee ("PCI: pciehp: Disable hotplug interrupt during suspend")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
---

v2:
- Dropped other hotplug fixes/changes (Lukas' approach/fix is better)
- Fixed typo in shortlog

 drivers/pci/hotplug/pciehp_hpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bb5a8d9f03ad..28ab393af1c0 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -842,7 +842,9 @@ void pcie_enable_interrupt(struct controller *ctrl)
 {
 	u16 mask;
 
-	mask = PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
+	mask = PCI_EXP_SLTCTL_DLLSCE;
+	if (!pciehp_poll_mode)
+		mask |= PCI_EXP_SLTCTL_HPIE;
 	pcie_write_cmd(ctrl, mask, mask);
 }
 

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.39.5


