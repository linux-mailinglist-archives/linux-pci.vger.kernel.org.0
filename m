Return-Path: <linux-pci+bounces-7449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E368C5318
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 13:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599BD283A6B
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 11:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8FA13A419;
	Tue, 14 May 2024 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TgHyshzJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8D213A3F4;
	Tue, 14 May 2024 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686303; cv=none; b=eaSNbzRUjt8jyXatpAxSf70socVG10/O2WPq1aH306AXDqd8MAvNjc1szcv5tKT54zWiTwA2IaDB+BNwUo/1SLTexZBVEvuIBVcVB47+Rgs6dFW+zGU0MbKPXfeC8pZEVrTj8uZv6X68TYZdxOC4L1fRKtg4YonNbGW9dN1bMPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686303; c=relaxed/simple;
	bh=TVMIEcYV4lRuU2NwGaITevK1+8W4KKh6YOoRO/qra7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6Ci2qJ8YVHuX9qAcVa82vYgmPGFopjx+/omvLUgj7rgDVkcBeb4nP8E8pAVUlHYcjM7WTZfOvAPfvJ2BFRR6R0RfLIqxvBba9D+p0q6Cgx/udsrs4xP4aoOoYGQ/wezxyIUBI5WgjbqcMS07AGCMaRjyYIs3fUzNlPpeSRhDgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TgHyshzJ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715686302; x=1747222302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TVMIEcYV4lRuU2NwGaITevK1+8W4KKh6YOoRO/qra7M=;
  b=TgHyshzJByyPypSUu8YTIuZSRbE3kzXaeSWNWancv4PWvY0uYzNJz4TZ
   dLjU/Dmr563yQnWF3wYv/htVihRrOjRwRJ+ba0H9opBh+iDIaWxFEM1MO
   CKnQ/fcDWcrG1MDyGabQxDyYbl5gZrjauIqHDKusnQk9mH+Ks+3gvSPXD
   e3jVzRs527i4vn0rBPpks4ZcEGLKHs59phBFLsFphu+gyOg2xPRTYEKoA
   ba2ecDADJJjuECcTfXQoEZSFGl3emEAnQu03CurZqoDX/61JgsTTdxbII
   Vf6Ct3K0Ba4aBiVfHxzbhZBkUNpcZ9HfwqQW3sxFFP5T69lN06SIoFBie
   A==;
X-CSE-ConnectionGUID: +GaiWyPkSHugrvLeQ5Y+Xg==
X-CSE-MsgGUID: w5FSi+ASSZiozgQGsIVRgg==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11532857"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11532857"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 04:31:41 -0700
X-CSE-ConnectionGUID: 844xaLByTxenDKOJuhlo9A==
X-CSE-MsgGUID: fNfF3l0LR+igBuWIpRYdGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35179648"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.94])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 04:31:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 3/7] PCI: Make pcie_read_tlp_log() signature same
Date: Tue, 14 May 2024 14:31:05 +0300
Message-Id: <20240514113109.6690-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240514113109.6690-1-ilpo.jarvinen@linux.intel.com>
References: <20240514113109.6690-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pcie_read_tlp_log()'s prototype and function signature diverged due to
changes made while applying.

Make the parameters of pcie_read_tlp_log() named identically.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/tlp.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
index 3f053cc62290..2bf15749cd31 100644
--- a/drivers/pci/pcie/tlp.c
+++ b/drivers/pci/pcie/tlp.c
@@ -15,22 +15,21 @@
  * pcie_read_tlp_log - read TLP Header Log
  * @dev: PCIe device
  * @where: PCI Config offset of TLP Header Log
- * @tlp_log: TLP Log structure to fill
+ * @log: TLP Log structure to fill
  *
- * Fill @tlp_log from TLP Header Log registers, e.g., AER or DPC.
+ * Fill @log from TLP Header Log registers, e.g., AER or DPC.
  *
  * Return: 0 on success and filled TLP Log structure, <0 on error.
  */
 int pcie_read_tlp_log(struct pci_dev *dev, int where,
-		      struct pcie_tlp_log *tlp_log)
+		      struct pcie_tlp_log *log)
 {
 	int i, ret;
 
-	memset(tlp_log, 0, sizeof(*tlp_log));
+	memset(log, 0, sizeof(*log));
 
 	for (i = 0; i < 4; i++) {
-		ret = pci_read_config_dword(dev, where + i * 4,
-					    &tlp_log->dw[i]);
+		ret = pci_read_config_dword(dev, where + i * 4, &log->dw[i]);
 		if (ret)
 			return pcibios_err_to_errno(ret);
 	}
-- 
2.39.2


