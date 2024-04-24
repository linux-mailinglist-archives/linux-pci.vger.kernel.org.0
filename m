Return-Path: <linux-pci+bounces-6648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AFC8B11E3
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 20:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B871C23C6A
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 18:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3582173351;
	Wed, 24 Apr 2024 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/IL/Mrj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6435916DEBA;
	Wed, 24 Apr 2024 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982509; cv=none; b=KfvzPBkFNAszVnpD4SHdUHLOH/Q+rj0HOP5jRreGpDTeU3umeQWJor3ASs1jpKfvwjcvCNZAczoLqXy7jNbd8BT+GPHVa0jo1BgN15WUlks5QmyY0E+jlJega1fHuuYXSoYphpo/iRkuNpFtkOEms7mIuY0xJrqwwvx03zaFnag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982509; c=relaxed/simple;
	bh=Bj1Hh9P4phH3tXz7fAUpe9Zp5qNwRqIfye9t/fF1o6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGfhcC1RONOVtdatiQUzD45fjQu8YJvkja35MRoabVgUfsHLFDl6dF72DDl5J5u8jINvKfJWBIWKjV9afC6Wp5p4Yvv6cje/gFE7fviZsP8EAIUFZFFctlsCiM1ZwJhTAGpS7us+NPkpfRBYYYNiO7VLCFoPTarft0jmtNQLy3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/IL/Mrj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982508; x=1745518508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bj1Hh9P4phH3tXz7fAUpe9Zp5qNwRqIfye9t/fF1o6k=;
  b=V/IL/MrjOPZ6oaUPfKhcmtLQQdUdtCftRB+MBmtvDZ6T7jc+dK0/1VbS
   9VYUUXIP9kv3rUsm+sI/sExcnMizUI/TXBJoYOtvFwhCnEZ2hBjtJnyJw
   76VdveesYbkM/J8IXEsDJSMXmEy3lKRuVLXWxGqkHFcM3pkHY6Bqlr3Q4
   1qTrX9ewNpxgSseJElFveX/vrz2FVs7Vhg6LsMCI6Xh/2GcI9miIjLS2y
   vKMbY5lepmIaUW+ydoj8RB9GfvA4dqgZ4piLrwAuIt1XvZPVVdHIyo23+
   74j5djVDw7z7kMtfXuP4op1i4bVW0/V47iHLA5ojLPHjV01NaXTOWDEpw
   g==;
X-CSE-ConnectionGUID: KUKVJKFcSlmf/lqx0pvAPg==
X-CSE-MsgGUID: AaVHfvdlR0G7GlvnIML5kQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9481784"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9481784"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:14:53 -0700
X-CSE-ConnectionGUID: g9KL3PctSRGzgFMrYZHuPQ==
X-CSE-MsgGUID: 3ViPB0/LTzGJ4dCuXhhMOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262578"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:14:53 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 10/71] PCI: PM: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:14:52 -0700
Message-ID: <20240424181452.41346-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424181245.41141-1-tony.luck@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
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
2.44.0


