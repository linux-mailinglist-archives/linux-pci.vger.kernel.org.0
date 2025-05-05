Return-Path: <linux-pci+bounces-27149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A41AA9258
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 13:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FCDA172D04
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 11:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF76E1FBE8B;
	Mon,  5 May 2025 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="byuMQ2au"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0401F582C;
	Mon,  5 May 2025 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746446064; cv=none; b=Ptl7bZ+y3TdmESNVDKwW0ToxAeJ65hYChkm+PDBMzHy6uswJNsPTseKp6r8GPhrq+X3YlhtDYs/WiLU8/sWXkFTJov4CtXDLl3wSxXysAtO3QLot7az1DOf4K0xB+bBIvChhsYDDZeQIu3gA+YlpVtJalgoDOJN0gHLmRuQWlLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746446064; c=relaxed/simple;
	bh=qmzVyPm7j3nmQE46OISA4W3ZMSMKJlH5HQQ8JPoNguc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=S37OI0VDlGOOfRakyOH4EZ4xHQaq0PMxy59sIq7m2V5pkXn9kVqQxiKgWzcHBpqRjP77Fj3hBWlW5EnX1t8GdUoIi6PjCTou6EdfZkkSm6y3QTLiNMBUnwJJ4xSvEAxfLEycKDxZdmhjxvQbVomZsNf7WZ64ROVruDY/Y4j0jZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=byuMQ2au; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746446064; x=1777982064;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qmzVyPm7j3nmQE46OISA4W3ZMSMKJlH5HQQ8JPoNguc=;
  b=byuMQ2ausMS+unF8cUd6ybAiOHDSSh6wNAgiStNIKbr1R+Az+mUlgdGB
   fMAw6lZnEU387O1BYh2IkWVtqgbObFbPqPPnSD2g5FjHfWb7jpuDsS81C
   bVvKHPnaTinRTpgVLQ6qoLcFXSgggMyaECHIkVBpPR01qQVivAA/Xgdw5
   2GCwrWtUoRAWfwAFjpybiEn1rVQ0nfAleABOjgR25DOtNyXC5oc472dco
   6fbZDiC54uBFuWuvtQO1TNUFxGVM4PNQ0R3H2aSkwU1RSvdZn5brq4C8x
   0rsQery73kuMZb7LWUpxYAbK158KRyTGXzbdl1IEfrrfH8uisSvCTJ000
   Q==;
X-CSE-ConnectionGUID: U4BJrhi3QG+sNuRw3VMfVg==
X-CSE-MsgGUID: GH4r7fzuQIqQq3iC/5utwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11423"; a="59441780"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="59441780"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 04:54:23 -0700
X-CSE-ConnectionGUID: Frs+DaCMTxOWwOFnr8IS2A==
X-CSE-MsgGUID: aiFvh5/xR5GJvDin/W2IzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="166282629"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.68])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 04:54:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>,
	Moshe Shemesh <moshe@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] PCI: Fix lock symmetry in pci_slot_unlock()
Date: Mon,  5 May 2025 14:54:12 +0300
Message-Id: <20250505115412.37628-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit a4e772898f8b ("PCI: Add missing bridge lock to
pci_bus_lock()") made the lock function to call depend on
dev->subordinate but left pci_slot_unlock() unmodified creating locking
asymmetry compared with pci_slot_lock().

Because of the asymmetric lock handling, the same bridge device is
unlocked twice. First pci_bus_unlock() unlocks bus->self and then
pci_slot_unlock() will unconditionally unlock the same bridge device.

Move pci_dev_unlock() inside an else branch to match the logic in
pci_slot_lock().

Fixes: a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: <stable@vger.kernel.org>
---

v2:
- Improve changelog (Lukas)
- Added Cc stable

 drivers/pci/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4d7c9f64ea24..26507aa906d7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5542,7 +5542,8 @@ static void pci_slot_unlock(struct pci_slot *slot)
 			continue;
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
 }
 

base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.39.5


