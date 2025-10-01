Return-Path: <linux-pci+bounces-37323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0764BBAF1A5
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 06:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1259164416
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 04:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910B42D77ED;
	Wed,  1 Oct 2025 04:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iB940yrt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D9F23C8C5
	for <linux-pci@vger.kernel.org>; Wed,  1 Oct 2025 04:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759293537; cv=none; b=U0RA+KJ8MvC7QHNeN5aXfBOyP8yc3+IW6AfWTpdalM5HEiprVYE/aoV+nFpEpAkAXquR3AOI7MeOo8yxat3JsNTz9xeTIDCTw6O/1Wy91iZO2/z3e+xQ4+rWpvAjJIbBymlTtLILRGEzsORiz8QWWFb54M+xxiI92uFAVIwiZWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759293537; c=relaxed/simple;
	bh=lENQB59HpHoOeBimPGFcw37b9GlcmkhIvf5Ws8YqFr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jSlnis98OCdlu0gvP3/NeObJ6hm5Gaq7P6+3Ydxz3J8AalLr3q3e5Y2UhcRY8GuAewBZgeAlpgYUQnr8BVT3z1xreDMc4zUUPwpkQeyI2enUee+OPwm+Hb/gdbNfJ1w1EXe+QQ7o3f7mGGIUUf03+xoJgkafOtBQ85qRwuZtzhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iB940yrt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759293536; x=1790829536;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lENQB59HpHoOeBimPGFcw37b9GlcmkhIvf5Ws8YqFr4=;
  b=iB940yrtsD6GM9QhEIYmCCwGo6T6lMK9MIyMScsADEU+BerHfFTh4jJL
   OtMJJjZTdclU0N+XE7yXr8lALRT24wCJ1DROnCQ9SNlvc2av25kp2h79t
   wAs9g4MTGpSHhtvOSYPAGqjcfd7gX2gpyOhMs5/mJKHuSPeX2Nd6fnqCe
   SaI6psvu/Nh0QyWF2OUKUrvpRNoa+zK4ASgw2fieLaYBCxT5fCkt5sqqz
   uPEqfv9SWYDfEU45HZwtR6ZeuZJMftjcLCrdP5i5Y1q9tfRaEDIpSHWob
   eKGIpDeE7H/+1GgvSCNXJPzA1TeXukWrZitDaHNV4B9Pe/A6qcG4dReb1
   A==;
X-CSE-ConnectionGUID: z7eiucOYTGKgNLmqRAnIcQ==
X-CSE-MsgGUID: Mt62Pm18QbWgwvc6ueGGPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61728954"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61728954"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 21:38:55 -0700
X-CSE-ConnectionGUID: XDIYsm6TT1yLWU3C4esJPA==
X-CSE-MsgGUID: uzcXzs3HRhq0pNNO5G1n7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="177977806"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa010.jf.intel.com with ESMTP; 30 Sep 2025 21:38:54 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] PCI: Add lock  and reference count in pci_get_domain_bus_and_slot()
Date: Wed,  1 Oct 2025 10:07:05 +0530
Message-Id: <20251001043705.263609-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add proper locking and reference counting to pci_get_domain_bus_and_slot
during PCI device enumeration. The function now holds pci_bus_sem during
device iteration and properly increments the device reference count
before returning.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/pci/search.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 53840634fbfc..dc49d3db69a4 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -230,12 +230,17 @@ struct pci_dev *pci_get_domain_bus_and_slot(int domain, unsigned int bus,
 {
 	struct pci_dev *dev = NULL;
 
+	down_read(&pci_bus_sem);
 	for_each_pci_dev(dev) {
 		if (pci_domain_nr(dev->bus) == domain &&
 		    (dev->bus->number == bus && dev->devfn == devfn))
-			return dev;
+			goto out;
 	}
-	return NULL;
+	dev = NULL;
+ out:
+	pci_dev_get(dev);
+	up_read(&pci_bus_sem);
+	return dev;
 }
 EXPORT_SYMBOL(pci_get_domain_bus_and_slot);
 
-- 
2.34.1


