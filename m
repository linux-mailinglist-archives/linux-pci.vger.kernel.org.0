Return-Path: <linux-pci+bounces-18515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DFC9F356A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B48188A77D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 16:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31303148FF0;
	Mon, 16 Dec 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFMkEtzC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D66114A095;
	Mon, 16 Dec 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365431; cv=none; b=lNXrO4tyHBrx6/pr/Ip4sPCMo1Ze6p1Du5hS0TMFSkT02XKCRtmz3StDf12nODnTjk+BDhexayDam9KFxUOjWnL+3ltTqiMaIzM5aFpC0hlTYPuWsgkMDDaePRr9Y4dOCliKfABOtmh+dM7bWbmpJs33NsWr251TjjkhCSgOaxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365431; c=relaxed/simple;
	bh=M8Snydld+G3bzzI1y2e+peBZwEHDa69ZjkPqObx7NeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WwCoyJ8+PcTj9PPc9kLgAdLaMi5CtO2lMJv8009D/02Zv+ghbj9F7QkZo5/qh1tVlDtFGfhG3KyDZji604YhY1MQcVAhlMCUB/uHdbwXZfaqCkGt/+cmjev07yK5uafC5vx8YisJtgA/Dkvev9PaqUTR5sYK48wJFNj3racHjNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFMkEtzC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734365430; x=1765901430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M8Snydld+G3bzzI1y2e+peBZwEHDa69ZjkPqObx7NeE=;
  b=aFMkEtzCJY8r4FkcR+xp63jNJgwajNnlnn1FTQssEIAl+WqYZwZ1/GS6
   kL0tSmp0m8IMNcEffykYP96FRCsIwGsBIrhejKtbwFlaFHaqF5hApLley
   6kpR0hbop6gxUtj3J19FCmfd/y79M3ZV3xWwxzuvbQF75rmaw8UPCfQCn
   Thj+jQOOR3GWocMG2IWJ/cczBzBxFx5448pQ+s1dYjz97jI5xDW3rxDP9
   bl+QZjHf5/aze5KoOsx0HOoz+IWG8k88egjXP+ijGJK1p8v5UgXxD9XWi
   UfEI2No0AwQ5RZFQsDqHIRUIwPq1w5v/NQxuzCCYy2G34DJBnqHJZIiK0
   Q==;
X-CSE-ConnectionGUID: /cQ0N9JWSe65dUUeeNA42g==
X-CSE-MsgGUID: Apup2XRbTpGy2eot151/gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34904197"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="34904197"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 08:10:29 -0800
X-CSE-ConnectionGUID: Q2+nlaXYSGGEBgO8/PGPZQ==
X-CSE-MsgGUID: d3bwhLe9RBuIaEBQXi8GsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="97120727"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 08:10:26 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/4] PCI: shpchp: Remove logging from module init/exit functions
Date: Mon, 16 Dec 2024 18:10:09 +0200
Message-Id: <20241216161012.1774-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216161012.1774-1-ilpo.jarvinen@linux.intel.com>
References: <20241216161012.1774-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The logging in shpchp module init/exit functions is not very useful.
Remove it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/shpchp_core.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index a92e28b72908..a10ce7be7f51 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -324,20 +324,12 @@ static struct pci_driver shpc_driver = {
 
 static int __init shpcd_init(void)
 {
-	int retval;
-
-	retval = pci_register_driver(&shpc_driver);
-	dbg("%s: pci_register_driver = %d\n", __func__, retval);
-	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
-
-	return retval;
+	return pci_register_driver(&shpc_driver);
 }
 
 static void __exit shpcd_cleanup(void)
 {
-	dbg("unload_shpchpd()\n");
 	pci_unregister_driver(&shpc_driver);
-	info(DRIVER_DESC " version: " DRIVER_VERSION " unloaded\n");
 }
 
 module_init(shpcd_init);
-- 
2.39.5


