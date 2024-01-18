Return-Path: <linux-pci+bounces-2316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCDF83181B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 12:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD35288329
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 11:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1562123760;
	Thu, 18 Jan 2024 11:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PNZI9q7x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3D92375A;
	Thu, 18 Jan 2024 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576109; cv=none; b=KKTsJS38jFVH+DI4EWE0yBUTW5Juv3Lpx7GeDtwZNCDFm0zYpVSPq88K/Lfc/1nBSxX1vbzqDZRjSLb+uUU428jKgd7J+HhlKMWYZMDYk+TXOQUKYQFoWC1zU9YW0u8pK9rqKt/68cc3pEMtZqtnLIfU4Av6B5VDmFeahizrqdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576109; c=relaxed/simple;
	bh=mjy35o3OcV45hLL1uxk3iUN5tBVkfvj+D2W44/uMvS8=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding; b=Yf0VlsxdfozLKECjHCrw1gaq6G2ipJHq1KjltdqUMryQs8X5rB4ZUdCIpR6ghSL3IvqwIG/kCUeaH1qcEtn5X4y+rlsMx6ZO3TWZJJ4Rdw3FB/v8NqxuJBhqqbjD4IepEpQTQHp0lWeuUUHx5vg179F0jdukPRwK6el/2zKwE5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PNZI9q7x; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705576107; x=1737112107;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mjy35o3OcV45hLL1uxk3iUN5tBVkfvj+D2W44/uMvS8=;
  b=PNZI9q7xZxh9gvSfEm8/7R4abwR6siIgTnhd1ahjKzDrEH9Bm9ScXkxc
   5Qi8bF6+/aepSKj9v0cbL37DCxXiaSvBNZTi1pxJmsD+PrVRa2Zy0eoIa
   LwAy8qvjOTVS0oOuvV27B1dOR9mt9l4Ihcwtx2qoOip8ZYvdBv8/lsUFp
   TpkYFa1pOxgKrCWNOTh8O+7P/HizWHRJZxgDH1NK6Fz7co65fJaXiVp4y
   OB6ovbSkPZ/4d9XjfWw2FKOwcvmWDEGDDUEfSnqKL8+LmpPOi4og+eOyy
   OCP4P8D/L+QFy+hJSHx9v/fXSawaKI4Felxx2dzxc3iEUqyJCA68j4l0G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="404183212"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="404183212"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 03:08:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="297769"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.254.202])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 03:08:23 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Keith Busch <kbusch@kernel.org>,
	Dongdong Liu <liudongdong3@huawei.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI/DPC: Fix TLP Prefix register reading offset
Date: Thu, 18 Jan 2024 13:08:15 +0200
Message-Id: <20240118110815.3867-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The TLP Prefix Log Register consists of multiple DWORDs (PCIe r6.1 sec
7.9.14.13) but the loop in dpc_process_rp_pio_error() keeps reading
from the first DWORD. Add the iteration count based offset calculation
into the config read.

Fixes: f20c4ea49ec4 ("PCI/DPC: Add eDPC support")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/dpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 94111e438241..e5d7c12854fa 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -234,7 +234,7 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 
 	for (i = 0; i < pdev->dpc_rp_log_size - 5; i++) {
 		pci_read_config_dword(pdev,
-			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG, &prefix);
+			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG + i * 4, &prefix);
 		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
 	}
  clear_status:
-- 
2.39.2


