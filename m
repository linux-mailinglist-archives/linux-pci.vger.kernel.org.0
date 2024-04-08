Return-Path: <linux-pci+bounces-5893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EE889CBCB
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 20:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A15F9B2440D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 18:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A32453E0A;
	Mon,  8 Apr 2024 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1pgYYWo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E852D535C8
	for <linux-pci@vger.kernel.org>; Mon,  8 Apr 2024 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712601585; cv=none; b=CFEseiT9OfK4btlhflAGu1vSfoWfFLSD8i7+0YmxkH7Y4en2FUgApFpZCXhyAmWgAoc0cnAwal6zEZYRlPkkXex3X4uU2G5r28Vs3UAqB11GFdj3DYWFgmP8w0f9dRuWtuJWfu4Dy9graKewfFetbRNEgY6xg9/2EaCan+2ZVZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712601585; c=relaxed/simple;
	bh=FdVfmAlCCga2rh0+qxJu9cr0YpJbv+gLx3q+FASeCKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KkU77URNL827zu0cBnC6/Ckcv+NjMgWGFn9cAk43Z3X5LL44Mp7/Te4eEhH6JfYWWwXCSja46RqV+dVompnnkdKI8hJenh0Ka6V9NbRcW8S6phLj2Rphyj26oHOrH6tRemJRh1vxa9AGkgNrcC2fYU/MSP61vtqr6r1+ylVYLbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1pgYYWo; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712601583; x=1744137583;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FdVfmAlCCga2rh0+qxJu9cr0YpJbv+gLx3q+FASeCKg=;
  b=W1pgYYWoW86ptLRmha8QeIZ1ZYw53Pk//eldBgTR37aBDhHk1c85uQX9
   VrgdcPM564WoGUzYkGHrpz6gS4+nseOcdVp356ftmSrCGO3v2nEjeK55l
   Up3u9SPBh3FOukgMjAptW7DwZI51aKYRvkabc5oEgAuFmlsGq/g36UHqw
   xiynpBGVb2qJcVULDX26K8X6yYsvsUtqEaEosgdXoSO8POJ7L/othxnda
   6CV8CAQXVq/nnlwB6ABPWgniRRw34c44JcjaJsTIFr5xaCQTkpSjRhRRd
   fzYeVH3SQxocRiO0f9cUhP9Yh9NrY+KtIQpthUfR2FNwE+GmSugAs7uGl
   w==;
X-CSE-ConnectionGUID: QuqicPE7RfuElnNMKrxw/g==
X-CSE-MsgGUID: zwxZ67ikSJ6qNwzezgdjvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="18467223"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="18467223"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 11:39:42 -0700
X-CSE-ConnectionGUID: ATo+4vXtTYeHPnUvyW4tLA==
X-CSE-MsgGUID: 1CG+b+hlRSKxUGOghleCtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="24675838"
Received: from pmstillw-desk1.amr.corp.intel.com ([10.246.116.100])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 11:39:41 -0700
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
To: linux-pci@vger.kernel.org
Cc: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: [PATCH v3] PCI: vmd: always enable host bridge hotplug support flags
Date: Mon,  8 Apr 2024 11:39:27 -0700
Message-Id: <20240408183927.135-1-paul.m.stillwell.jr@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features") added
code to copy the _OSC flags from the root bridge to the host bridge for each
vmd device because the AER bits were not being set correctly which was
causing an AER interrupt storm for certain NVMe devices.

This works fine in bare metal environments, but causes problems when the
vmd driver is run in a hypervisor environment. In a hypervisor all the
_OSC bits are 0 despite what the underlying hardware indicates. This is
a problem for vmd users because if vmd is enabled the user *always*
wants hotplug support enabled. To solve this issue the vmd driver always
enables the hotplug bits in the host bridge structure for each vmd.

Fixes: 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features")
Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
---
 drivers/pci/controller/vmd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 87b7856f375a..583b10bd5eb7 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -730,8 +730,14 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
 static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
 				       struct pci_host_bridge *vmd_bridge)
 {
-	vmd_bridge->native_pcie_hotplug = root_bridge->native_pcie_hotplug;
-	vmd_bridge->native_shpc_hotplug = root_bridge->native_shpc_hotplug;
+	/*
+	 * there is an issue when the vmd driver is running within a hypervisor
+	 * because all of the _OSC bits are 0 in that case. this disables
+	 * hotplug support, but users who enable VMD in their BIOS always want
+	 * hotplug suuport so always enable it.
+	 */
+	vmd_bridge->native_pcie_hotplug = 1;
+	vmd_bridge->native_shpc_hotplug = 1;
 	vmd_bridge->native_aer = root_bridge->native_aer;
 	vmd_bridge->native_pme = root_bridge->native_pme;
 	vmd_bridge->native_ltr = root_bridge->native_ltr;
-- 
2.39.1


