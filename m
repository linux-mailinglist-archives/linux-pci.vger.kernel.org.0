Return-Path: <linux-pci+bounces-20597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC8EA23FAB
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 16:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953961886C3E
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 15:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A421E0E18;
	Fri, 31 Jan 2025 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xs6RikSF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F3F1B85F6;
	Fri, 31 Jan 2025 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738337364; cv=none; b=cYldKiq+ueFIJxQIpjiW7YeCP26FYq0ZDQ7w/JgYRcnwod7rrlPTIE1qh2+OGRmKFDMlmLD9nTWDxPBn2D5rJiqx5yoduWYqD0nKTDS3zstviarT4RSRJAZ/wY2n7JIcs6fzy5/N4pXYBEmzVZqkPjKIgAKxj7dC2igqzinQ27E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738337364; c=relaxed/simple;
	bh=keN7CJ39AxoBR7CYBQVhQEcNv6r+vbPbpuhW79zq0pg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XKM2DZJXZ4JaGLLaEh4KfucPPpXn2tKWPWgW9BtqFpfLbCJZx9X9bhqx1YqqkWd2l42MnHWRKq8yUhiB6sZh+Ekhff+X8Cg//mEsMlcs/GraCP6WFLRHwo6etIi2Rih8ai/d1Ed0a7bS8K2TgRcZYlUoca1dwp9JsQR/BpUaNIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xs6RikSF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738337362; x=1769873362;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=keN7CJ39AxoBR7CYBQVhQEcNv6r+vbPbpuhW79zq0pg=;
  b=Xs6RikSFmQzMkIAYFBpl4Tc/uuSQLMJZ78+TRROAz9amufLKE+GVk2yC
   JMZJ4s4LCtk2C9OlyItQrr2r+yxm2nqdza4S2PlkGYWDTrffClWf869LT
   D6nrpyAs6sr3hASUe/lnUJ1fhRiGccYHJboy0P8Yr2Ej8b3bwwRpodhka
   DF11CGeON6cTEVdV0zfwcFNH65phTeZvK2MYw6oseNZU4276V5zc+C1rQ
   jQNXrX9k/IFwOpCB5CIZDZfwXsJvmehGEY3AL055nRqEXun/tArIV1Duu
   g4wGrWzkFwXXtZ1/9db7v5zqgve4FnmddibnlecEiOm73bGaYDJeEB3w5
   A==;
X-CSE-ConnectionGUID: V19HB69PQni1O3oEVYMp0w==
X-CSE-MsgGUID: Asot4E/mTTyKj2AxQnAwMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="38612003"
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; 
   d="scan'208";a="38612003"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 07:29:21 -0800
X-CSE-ConnectionGUID: Wmi0KgTWSUK8G67oDyZYfw==
X-CSE-MsgGUID: mQGcqElSQjSHhekv1yeqbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110108370"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 07:29:20 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Nikl=C4=81vs=20Ko=C4=BCes=C5=86ikovs?= <pinkflames.linux@gmail.com>
Subject: [PATCH 1/1] PCI/ASPM: Fix L1SS saving
Date: Fri, 31 Jan 2025 17:29:13 +0200
Message-Id: <20250131152913.2507-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit 1db806ec06b7 ("PCI/ASPM: Save parent L1SS config in
pci_save_aspm_l1ss_state()") aimed to perform L1SS config save for both
the Upstream Port and its upstream bridge when handling an Upstream
Port, which matches what the L1SS restore side does. However,
parent->state_saved can be set true at an earlier time when the
upstream bridge saved other parts of its state. Then later when
attempting to save the L1SS config while handling the Upstream Port,
parent->state_saved is true in pci_save_aspm_l1ss_state() resulting in
early return and skipping saving bridge's L1SS config because it is
assumed to be already saved. Later on restore, junk is written into
L1SS config which causes issues with some devices.

Remove parent->state_saved check and unconditionally save L1SS config
also for the upstream bridge from an Upstream Port which ought to be
harmless from correctness point of view. With the Upstream Port check
now present, saving the L1SS config more than once for the bridge is no
longer a problem (unlike when the parent->state_saved check got
introduced into the fix during its development).

Fixes: 1db806ec06b7 ("PCI/ASPM: Save parent L1SS config in pci_save_aspm_l1ss_state()")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219731
Reported-by: Niklāvs Koļesņikovs <pinkflames.linux@gmail.com>
Tested-by: Niklāvs Koļesņikovs <pinkflames.linux@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aspm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index e0bc90597dca..da3e7edcf49d 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -108,9 +108,6 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
 	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2, cap++);
 	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1, cap++);
 
-	if (parent->state_saved)
-		return;
-
 	/*
 	 * Save parent's L1 substate configuration so we have it for
 	 * pci_restore_aspm_l1ss_state(pdev) to restore.

base-commit: 72deda0abee6e705ae71a93f69f55e33be5bca5c
-- 
2.39.5


