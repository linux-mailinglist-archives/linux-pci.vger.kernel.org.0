Return-Path: <linux-pci+bounces-8603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E795D904265
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 19:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728CB2869E9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 17:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232E2376E9;
	Tue, 11 Jun 2024 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exse4AzJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9709B5F47D;
	Tue, 11 Jun 2024 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126917; cv=none; b=drUYpgs/+kMafkFzQjQOYyNuC1XSSmKvMZhUdGLuZeZL6IImPGOKiIitD1ZI+SVg2rnCsO4LT1wFT9xb0AE3sLObn+hFKcH+GvmAfs2+riAmngFk35axFxBkqIxTTCOucAWO0QKEnfJ6YWFbkrSd4YVeHdaGdeMlvuX0SFmdVCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126917; c=relaxed/simple;
	bh=rtDEIL04VdxqcxFsE+T72+DwoGQup8VelSb9IAMQ9bI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YEH894JV0w4vbsgUabnJ/BL/XHwsXbcIsL7dpLlgS74ormP14gKnc+w9VwjECV/1UV9AssPpKp1mcv4CiWnTOC5zPAwQif9e8JbQzssWNS0pSPT6tzVT9AiNQuoXUVEg28ELiL1SvNXPnLs5ObwF7AmIoLltymLOMjgYRuWF/YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exse4AzJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718126916; x=1749662916;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rtDEIL04VdxqcxFsE+T72+DwoGQup8VelSb9IAMQ9bI=;
  b=exse4AzJAFW6oliQCM+HdG6ADsUfZB4012khHWmNKwN4sbjb2g/2mhz9
   aFmpdSW8TNAVYA/SsoGzbfpEdRrNl7aY7gtHZi14Mc+MAwcTIfq9cd1gw
   Gg/y1f2ZbvPPO6AB8MZQ1/q4pqhr+PIJjAqCDFVAgD/PhhPUyF551CgMm
   GKCN8TBv48zEhIOKWkEaA8i0mtPm/1vHgUMbwOEpX7NzUsa3N0nPKhYFN
   h9EVtgf9GFI+rYfR2/7Wh4KleBmTU/Miu+ltC/wxDflNtAPEX47PYc7xq
   M2thYnw91PD4bunOMDYLhLUDSDK6rK0fRTbtaq1QRswrl6BsMpwo4QpPr
   w==;
X-CSE-ConnectionGUID: VD5a2+bNT3CINVD4yYgtUQ==
X-CSE-MsgGUID: Qz4ncBLSTrSXnXxq8bM5eQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="32338231"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="32338231"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 10:28:24 -0700
X-CSE-ConnectionGUID: DjOz2plHScucD2maiOBIJA==
X-CSE-MsgGUID: 5DK9nDGPShKYjeASXLjw2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="39361269"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 10:28:21 -0700
From: Tony Luck <tony.luck@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v6 12/49 RESEND] PCI: PM: Switch to new Intel CPU model defines
Date: Tue, 11 Jun 2024 10:28:16 -0700
Message-ID: <20240611172816.352828-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---

Bjorn: You acked this. Are you planning to apply it this cycle? It
hasn't shown up in linux-next yet.

 drivers/pci/pci-mid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-mid.c b/drivers/pci/pci-mid.c
index fbfd78127123..bed9f0755271 100644
--- a/drivers/pci/pci-mid.c
+++ b/drivers/pci/pci-mid.c
@@ -38,8 +38,8 @@ pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * arch/x86/platform/intel-mid/pwr.c.
  */
 static const struct x86_cpu_id lpss_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL_MID, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, NULL),
+	X86_MATCH_VFM(INTEL_ATOM_SALTWELL_MID, NULL),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, NULL),
 	{}
 };
 
-- 
2.45.0


