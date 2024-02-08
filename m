Return-Path: <linux-pci+bounces-3234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9361884E1E3
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 14:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8AF28FD18
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 13:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0F36D1C1;
	Thu,  8 Feb 2024 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aabiwvK7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC7376C61;
	Thu,  8 Feb 2024 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707398538; cv=none; b=JrJFcGRpA6iHN8XTajWVZJU39H6xBu+CxXN7Ew/DVD1WMkFJBJrHBMPc3omkU4hkUshMx14xHa91/dopLtk0kYkGYM5uSdGVJHa+JxGdxYcF2gM6ewAmXXRIBCIjy+5DYWuq99D3ar5TM/jv8ASqOI2gyrFFYJDnuvQeBUYBWk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707398538; c=relaxed/simple;
	bh=0bEAZsh/lFxSAyJ510AR/UirgS012kNEN7t1uDTzmew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YbDOkn58EwLUafgPD81SY9CbsagV8L2lGgiGrLEoUjveULcfTS+MFJXrRezlMLPiWM6mIqIBT8x2zGLJlFH6+Ym2/sSb9vPKME/Duv7ecS+RYjKb3XQYMS/4oD+x0CAUNT+gzq7UarfPQ/JayWP+s1+ud3bmwKYGW0IsGX4KR1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aabiwvK7; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707398537; x=1738934537;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0bEAZsh/lFxSAyJ510AR/UirgS012kNEN7t1uDTzmew=;
  b=aabiwvK7XjXuMBCpr2YeUwnNbMQ+W8Oy5bPUN1sFHmKiTX44CJwwYFTx
   8ReK5/r0ZP4sa9iWjjV5XLTj8rGoG4PbepidZ5+NCpLo+TaheOGg6GuBF
   EqzVCM33fnymLRACqmoqIeJEdIhMceJ3sbdrqaYBAneB1ZzNsZCoa4sfY
   CC1a+P2hVKNvCZ49rdsrnKnT/0dzxRbkuXjn70lSuk7GRV795QycsZBHv
   +apCBJveCaOstPN0jp+VtEueMDo6sUcI9Ht9Q/9X53UDssixuCp/Rc8A9
   Xc1YL4U9M8jPMcmHMlYYgdyW93ItkdvUCrAY/OICW1iUchTAg3Q2ROwIN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="26657874"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="26657874"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:22:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="6307827"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.52.95])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:22:13 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/1] PCI: Fix link activation wait logic
Date: Thu,  8 Feb 2024 15:22:04 +0200
Message-Id: <20240208132205.4550-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If link retraining fails in pcie_failed_link_retrain() it returns false
but the wrong logic in pcie_wait_for_link_delay() translates this into
success by returning true after a delay.

As a result, pci_bridge_wait_for_secondary_bus() does not print out a
message and return failure but goes into pci_dev_wait() which just
spends >60s waiting for a device that will not come up.

The long resume delay problem has been observed to occur when resuming
devices that got disconnected while suspended:

pcieport 0000:00:07.2: power state changed by ACPI to D3cold
...
thunderbolt 1-701: device disconnected
pcieport 0000:00:07.2: power state changed by ACPI to D0
pcieport 0000:00:07.2: waiting 100 ms for downstream link
pcieport 0000:57:03.0: waiting 100 ms for downstream link, after activation
pcieport 0000:57:03.0: broken device, retraining non-functional downstream link at 2.5GT/s
pcieport 0000:57:03.0: retraining failed
pcieport 0000:57:03.0: broken device, retraining non-functional downstream link at 2.5GT/s
pcieport 0000:57:03.0: retraining failed
pcieport 0000:73:00.0: not ready 1023ms after resume; waiting
pcieport 0000:73:00.0: not ready 2047ms after resume; waiting
pcieport 0000:73:00.0: not ready 4095ms after resume; waiting
pcieport 0000:73:00.0: not ready 8191ms after resume; waiting
pcieport 0000:73:00.0: not ready 16383ms after resume; waiting
pcieport 0000:73:00.0: not ready 32767ms after resume; waiting
pcieport 0000:73:00.0: not ready 65535ms after resume; giving up
pcieport 0000:57:03.0: pciehp: pciehp_check_link_active: lnk_status = 5041
pcieport 0000:73:00.0: Unable to change power state from D3cold to D0, device inaccessible
pcieport 0000:57:03.0: pciehp: Slot(3): Card not present

Fix the logic error by returning false immediately if
pcie_failed_link_retrain() fails.

Fixes: 1abb47390350 ("Merge branch 'pci/enumeration'")
Link: https://lore.kernel.org/linux-pci/a0b070b7-14ce-7cc5-4e6c-6e15f3fcab75@linux.intel.com/T/#t
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

I think this change should be made in the same change as the Target
Speed quirk fix (make it return false when no retraining was
attempted) because otherwise there are additional logic troubles
in the intermediate state.

v2:
- Removed quirks part (still needed but Maciej planned to test and send
  another patch for that)
- Improved commit message

---
 drivers/pci/pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d8f11a078924..ca4159472a72 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5068,9 +5068,7 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
 		msleep(20);
 	rc = pcie_wait_for_link_status(pdev, false, active);
 	if (active) {
-		if (rc)
-			rc = pcie_failed_link_retrain(pdev);
-		if (rc)
+		if (rc < 0 && !pcie_failed_link_retrain(pdev))
 			return false;
 
 		msleep(delay);
-- 
2.39.2


