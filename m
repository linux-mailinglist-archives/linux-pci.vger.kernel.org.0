Return-Path: <linux-pci+bounces-7821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9398CED4D
	for <lists+linux-pci@lfdr.de>; Sat, 25 May 2024 03:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC02B2186B
	for <lists+linux-pci@lfdr.de>; Sat, 25 May 2024 01:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C365610F1;
	Sat, 25 May 2024 01:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fF19ZvpB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE948391;
	Sat, 25 May 2024 01:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716599956; cv=none; b=Z6xe0SvrMHdEPY326csrgkAwjG80697AxMlB3eduTgVpACYItdldEB30/wntZW0fucRiJkkP1jhgoTP8k21bHOJ5vxBgNhGpF22L8qJlB+2sQ0UK2oaWJCCdY0Hr1iaf/d4sRtKXf/66iCBBuXoP06Htm1XuNBnQ7vvXJVNrzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716599956; c=relaxed/simple;
	bh=ap4v45uI0enMHG9NFW2Bq1hG0XIksaXQL2xwlU8v4nc=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=YW5m+NWkx9XQ6DxeMIqA/J1u8hgaC+Gd8iN7GPyls9u5OcTOkSTgQ3na/uL4ZBJRlGgPBOWbgnlxMsPOOH+30PvcypXZ7CG7zQ02ZXzjPcGuCBKI0/Ot90Z4arBxZZWKqMnLRl2+StzIXCB4EbmR9pi/QHL8nW00LfJa6E06ums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fF19ZvpB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716599955; x=1748135955;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ap4v45uI0enMHG9NFW2Bq1hG0XIksaXQL2xwlU8v4nc=;
  b=fF19ZvpBZRtc6n6CEjot268TBaatq0lFuLGXyAVYJ2oWyMITsqfczzKU
   uiPBoGh+4e5DS28Y7g+iuPWy6o/FsDphQFdGcd0kDolPHf7VGYAdpKB6W
   et04exQJiTGNj+5OEB+EcQ8Las/q2hGQVfBgf7l8stNGy3GnM91uGkZOZ
   /pNZ3bt/5l5dEV1fwqJYLQKVRS86E9O/CTmQSLdPBEw3c9bAJTAoi7qkf
   kXw/onDJ2buWEEWBT2y62sGRUx/V9+t8Q6/xvjgrIX9nkynppjrAaY56+
   HtwkKQUuSx4BOf36xkTogHiA9p0ReGHV7vHXeJXnkkhRIKkZqc9oa8hjz
   Q==;
X-CSE-ConnectionGUID: +jforYnUSJutpo2doqhtlg==
X-CSE-MsgGUID: NtVEMAffSIykiNrcMU04Gw==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="30526421"
X-IronPort-AV: E=Sophos;i="6.08,187,1712646000"; 
   d="scan'208";a="30526421"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 18:19:14 -0700
X-CSE-ConnectionGUID: 061OwXMaQtSL/aW5i9gdyQ==
X-CSE-MsgGUID: DPJl48BSSP2O8N7+pA7c2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,187,1712646000"; 
   d="scan'208";a="34690044"
Received: from mdhassa1-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.164.6])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 18:19:14 -0700
Subject: [PATCH] PCI: Fix missing lockdep annotation for
 pci_cfg_access_trylock()
From: Dan Williams <dan.j.williams@intel.com>
To: bhelgaas@google.com
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Dave Jiang <dave.jiang@intel.com>, linux-pci@vger.kernel.org,
 linux-cxl@vger.kernel.org
Date: Fri, 24 May 2024 18:19:13 -0700
Message-ID: <171659995361.845588.6664390911348526329.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Alex reports a new vfio-pci lockdep warning resulting from the
cfg_access_lock lock_map added recently.

Add the missing annotation to pci_cfg_access_trylock() and adjust the
lock_map acquisition to be symmetrical relative to pci_lock.

Fixes: 7e89efc6e9e4 ("PCI: Lock upstream bridge for pci_reset_function()")
Reported-by: Alex Williamson <alex.williamson@redhat.com>
Closes: http://lore.kernel.org/r/20240523131005.5578e3de.alex.williamson@redhat.com
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/access.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 30f031de9cfe..3595130ff719 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -289,11 +289,10 @@ void pci_cfg_access_lock(struct pci_dev *dev)
 {
 	might_sleep();
 
-	lock_map_acquire(&dev->cfg_access_lock);
-
 	raw_spin_lock_irq(&pci_lock);
 	if (dev->block_cfg_access)
 		pci_wait_cfg(dev);
+	lock_map_acquire(&dev->cfg_access_lock);
 	dev->block_cfg_access = 1;
 	raw_spin_unlock_irq(&pci_lock);
 }
@@ -315,8 +314,10 @@ bool pci_cfg_access_trylock(struct pci_dev *dev)
 	raw_spin_lock_irqsave(&pci_lock, flags);
 	if (dev->block_cfg_access)
 		locked = false;
-	else
+	else {
+		lock_map_acquire(&dev->cfg_access_lock);
 		dev->block_cfg_access = 1;
+	}
 	raw_spin_unlock_irqrestore(&pci_lock, flags);
 
 	return locked;
@@ -342,11 +343,10 @@ void pci_cfg_access_unlock(struct pci_dev *dev)
 	WARN_ON(!dev->block_cfg_access);
 
 	dev->block_cfg_access = 0;
+	lock_map_release(&dev->cfg_access_lock);
 	raw_spin_unlock_irqrestore(&pci_lock, flags);
 
 	wake_up_all(&pci_cfg_wait);
-
-	lock_map_release(&dev->cfg_access_lock);
 }
 EXPORT_SYMBOL_GPL(pci_cfg_access_unlock);
 


