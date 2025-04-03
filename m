Return-Path: <linux-pci+bounces-25218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA98A79D4E
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 09:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45E61897B9E
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 07:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59892417EC;
	Thu,  3 Apr 2025 07:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZvNMq/fP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E490E241684;
	Thu,  3 Apr 2025 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743666333; cv=none; b=JoJCA3t0Di878TXJ74BeA5+xHiI0UmA+O8baxzo1uHAgNAFoozzTQgrD4VdDdqVvh0lA9ksHFNAA3Vv0H8e83rvgQlIoIu96xzwNzftxmJbMcBLjqpJg0kmFjGMUNjcG6kDCdaYPdo9nTRSWhBRfSEyt5fYo/2p9HoDQXoZLH7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743666333; c=relaxed/simple;
	bh=osvwpmSaeCnsa2oIl3mVNrpD251AR8ZQaiVxUgCaMak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dnut3S9rinZxHaZYgFcL8Bs+DG8f7qQlT1HWtZAZw4GhZ34h4AUvoJ/FThVkOadsyDHoKLg/pZg1WSlZZjKwwDZ+QtB660TX2djFkOb9E/YH9q7KF+m4QYJN71uWb/LBqLI+xEniq4lJiQ+wLsPnUoG0hoOKNekkFx86Rh2BG0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZvNMq/fP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743666329; x=1775202329;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=osvwpmSaeCnsa2oIl3mVNrpD251AR8ZQaiVxUgCaMak=;
  b=ZvNMq/fPyPRwhsjWubaE6PiPvgOItSPS9c0uTg/Q+qs0uJbWpbeBPuCq
   J/5LGm+IjBRy1ZNJh54rx6DNugU9KsW0tsugQfo3Gr2BRjSK5AjZZVV8i
   jvcWf/Qeoru6twBF7RsHV4GhN38odxApEJ4D1zG5NDnvCr02bgBxhUeXX
   VhQIhKyrn5SCGCiE5M+uBXSN4FqOaePyZoWeu//KTdTBAqKkY+cjlKkII
   jXvKSao7MysRCoadz8O3/LA9lsKFdpB89M/5sgjP00iun6ooi65Nd/tpu
   rpvpiretoD+TeRrS54KP/xOP9M1LZCWLKo5uwIMG5uBOKoajFAMhnC7kV
   g==;
X-CSE-ConnectionGUID: 4Uph/TVXTfm7bgyHXy026Q==
X-CSE-MsgGUID: W+6VGDN9SwCRPJ5w6iJZsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="48721624"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="48721624"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 00:45:28 -0700
X-CSE-ConnectionGUID: c0HY7SxsRnyopPxLmYOGkw==
X-CSE-MsgGUID: h+84VRRCSkCsIdZIPSZQSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="164159449"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa001.jf.intel.com with ESMTP; 03 Apr 2025 00:45:26 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: rafael@kernel.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	lukas.wunner@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] PCI/AER: Avoid power state transition during system suspend
Date: Thu,  3 Apr 2025 13:14:25 +0530
Message-Id: <20250403074425.1181053-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error is triggered while system suspend is in progress, any bus
level power state transition will result in unpredictable error handling.
Mark skip_bus_pm flag as true to avoid this.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---

Ideally we'd want to defer recovery until system resume, but this is
good enough to prevent device suspend.

More discussion at [1].
[1] https://lore.kernel.org/r/Z-38rPeN_j7YGiEl@black.fi.intel.com

 drivers/pci/pcie/aer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 508474e17183..5acf4efc2df3 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1108,6 +1108,12 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
+	/*
+	 * Avoid any power state transition if an error is triggered during
+	 * system suspend.
+	 */
+	dev->skip_bus_pm = true;
+
 	cxl_rch_handle_error(dev, info);
 	pci_aer_handle_error(dev, info);
 	pci_dev_put(dev);
-- 
2.34.1


