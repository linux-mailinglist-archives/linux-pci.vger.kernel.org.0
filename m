Return-Path: <linux-pci+bounces-10599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86047939066
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 16:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4217C28236B
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 14:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF7D16DC00;
	Mon, 22 Jul 2024 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VY6y6C5f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA3C16D9CD
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721657701; cv=none; b=qwpdIpS97lX2plsaNsN8PiKWCVk5EBvFqSk9Td35aNMT7b9xvQ4bgSvhRLiQG74xYqqqdcPxFWUHdYbvgh2lYXrRz2hbLtm4l7S7+MHyRfwPm4zjKT/Lw0WsWQXwsKNEFPDGF7za2FatkF7CJeJ3U6cyNY8VgUWR9ctkmpKjWDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721657701; c=relaxed/simple;
	bh=sE7sP8SxuITfWyzDrN0sRuYC4GybKpfmPZVoMYMukKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=apx+sStfnBtkx5oBrF0iN7lihuT08hF/JueLfZyjHpsZzJBHKqdtZqT223nxMNEozwPFt88kPm9fqAk/LEKbtLIXW88gJ9lCgUPiyO9xTSaMvVWWEd0HD1JRmqxnd0ESXVEuRZ1jNBbaufFk6JWJz5qpJCRrqxkSAfaaSV5lhiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VY6y6C5f; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721657700; x=1753193700;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sE7sP8SxuITfWyzDrN0sRuYC4GybKpfmPZVoMYMukKQ=;
  b=VY6y6C5fk52BtACWU6wqK2g8Dze0BhsoHHjjGXPsXP1Knv8UD5LsMFks
   8+jYCsdDic0jyvnXWvJWUD04TPnWee92xsCdPSvw8lxqRMYXhe4w5rgb3
   ZylNJ1j7eQ/oc+IC2lzkbvMO4NLYZAhnbUGRkCRZpH3ftuvB/tCBNob4U
   3WGSZmAQI87JTKgIM4I3ItSsNkxwHkl4m3yJj24NejrgyqHPBk1eRirj2
   RtBfOUjsHtqF23JhWQlKwZcHXNffhrXyUUjGwoWMyJ1j7ydd/CiFcV5Uc
   S8dY5kzOpWQTgN4svzxKJDKrlz39WsCIWoVS0XxoIy+ajYxeF/gdGRQaQ
   w==;
X-CSE-ConnectionGUID: pob2vfFkTXaERUD3MLh8og==
X-CSE-MsgGUID: xA4awiWDSQeyBXbJMKEXTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="44653195"
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="44653195"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 07:14:59 -0700
X-CSE-ConnectionGUID: D+6JZN8HTFWSvxEi+1OfUA==
X-CSE-MsgGUID: 3EfGnL/ERbSM+GJixPzNSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="51616967"
Received: from linux-myjy.igk.intel.com ([10.102.108.92])
  by fmviesa007.fm.intel.com with ESMTP; 22 Jul 2024 07:14:58 -0700
From: Blazej Kucman <blazej.kucman@intel.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	mariusz.tkaczyk@linux.intel.com, ernel.org@web.codeaurora.org
Subject: [PATCH] PCI: pciehp_hpc: Fix set raw indicator status
Date: Mon, 22 Jul 2024 16:14:40 +0200
Message-Id: <20240722141440.7210-1-blazej.kucman@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set raw indicator status interface has been designed to respect bits
responsible for Attention and Power Indicator Control [1]. But since
abaaac4845a0 ("PCI: hotplug: Use FIELD_GET/PREP()") only processes
Attention Indicator Control bits.

Mentioned change replace direct bit shift, via macro FIELD_PREP, which
additionally performs an AND operation with the passed bitmask. The
regression results from an incorrect bitmask, the mask should include bits
responsible for Attention and Power Indicator Control, but only Attention
Indicator Control was passed. This lead to a loss of passed bits
responsible for Power Indicator control.

This fix restores Power Indicator Control bits support.

[1] 576243b3f9ea ("PCI: pciehp: Allow exclusive userspace control of indicators")

Fixes: abaaac4845a0 ("PCI: hotplug: Use FIELD_GET/PREP()")
Signed-off-by: Blazej Kucman <blazej.kucman@intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 061f01f60db4..736ad8baa2a5 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -485,7 +485,9 @@ int pciehp_set_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 
 	pci_config_pm_runtime_get(pdev);
-	pcie_write_cmd_nowait(ctrl, FIELD_PREP(PCI_EXP_SLTCTL_AIC, status),
+
+	/* Attention and Power Indicator Control bits are supported */
+	pcie_write_cmd_nowait(ctrl, FIELD_PREP(PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC, status),
 			      PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC);
 	pci_config_pm_runtime_put(pdev);
 	return 0;
-- 
2.35.3


