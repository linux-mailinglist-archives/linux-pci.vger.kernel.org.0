Return-Path: <linux-pci+bounces-7332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342C28C21A4
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 12:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4AD1F23601
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B498168B01;
	Fri, 10 May 2024 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDBynAai"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084451635A9;
	Fri, 10 May 2024 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335688; cv=none; b=Zu7pVHlR57q5xsGqLYCDULEzkhtexNj1Iz8GBB2vI5+SNIrIHOywMSz/idwtckIg0qonUXtEdmEzMAQB2wsbKF2BS859cflUu1F95sDgYGkWhnGRGVdRIrHeBo1iLCg1o/YQjyNtMs/Ge1PnUMo3v/fL2UQ7p8oZ0zQCMvklW8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335688; c=relaxed/simple;
	bh=TVMIEcYV4lRuU2NwGaITevK1+8W4KKh6YOoRO/qra7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EgyfXNKkf/p5XcJwt57fTFdJQD/AlRB5LeYx9DjBu2SfqJuAehCMN31GyxOwMgMgjcLIFe90UXHqvu5w5MHYAGjczOCzYeTtoDy5Lcb1Zwjvc47HzpzCsVlMh0GbkXvsMOTU0yZP80u5z0diVkosyUJejCfaLw1Uu400eDc9yd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDBynAai; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715335687; x=1746871687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TVMIEcYV4lRuU2NwGaITevK1+8W4KKh6YOoRO/qra7M=;
  b=IDBynAaii/KUwt2RmAHLrndOky546SImXrMzYfjr+EpImkPfZE3Ony+A
   WetsDXO3WcQhMQ0rJseyXc/C4PfXI9ml4HZvL1LhCY7k2cROBa/4/cx02
   KAQ+08Uq9xCbIabq167PAFD6MBFKv390CuE54ClDgILmrMsAq1I5zEfh5
   hoXTS4TtO2DOK2hJoVP0dPplpMDX4CA+5dROaCIhEmQbdq9+Ix4Gs4gfz
   TjUILlppRNYlcvwLHmmRTLpeJFS7hbRgYPNCCN1K6XJgEcujKrzckqlrR
   crMed61vDbx0QxSfBqDS4VcCy1raeUdIRcZc0C7i87LkvPgBEIAbtZayy
   g==;
X-CSE-ConnectionGUID: Vym4ihDVRxqkee9wxjxYYg==
X-CSE-MsgGUID: 5XQexlUyRrS49cv88cb7nw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="36687473"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="36687473"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 03:08:06 -0700
X-CSE-ConnectionGUID: RV+ByP7IRaqW++iFvT79NQ==
X-CSE-MsgGUID: TQZAEOqrR1u/FZX9fdQiBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29571396"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.85])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 03:08:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 3/7] PCI: Make pcie_read_tlp_log() signature same
Date: Fri, 10 May 2024 13:07:26 +0300
Message-Id: <20240510100730.18805-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240510100730.18805-1-ilpo.jarvinen@linux.intel.com>
References: <20240510100730.18805-1-ilpo.jarvinen@linux.intel.com>
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


