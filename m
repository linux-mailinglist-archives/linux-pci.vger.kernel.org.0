Return-Path: <linux-pci+bounces-28024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16641ABCA17
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 23:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322AB188AC96
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 21:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0732223DE7;
	Mon, 19 May 2025 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FanzLzd/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F83223DDA;
	Mon, 19 May 2025 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690625; cv=none; b=ckpJZusi7knBPdqXBIkREXEBogEZivOr+jsZqtv7nVytV1vmTpPScJKu70cspWkWeXadJNs3jLjnMnUaObpD8VB4IL7Bh0OJgKk9mg7PhBdtEdItdI66/sbRMb1NfVmXNN+iQKSX45JpakiXuzSBu1huI8fq7QaYhM2cYVUYlY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690625; c=relaxed/simple;
	bh=8K5sDprPkS4frD6Ujl8cJhUCTK82u2aJfFFj51dk78M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VugHrlnleclMoMHNxFK1QsOQJaGiODhqjUSA83TzvoEBFX3KW0D7xMWxg59LptJ51BOtCx/tULiPoOe3lCGg75c4JuE6bP7PMzwWKj9Ub2Msp1rBx+zmXlTpwUMLM0CcffHMrsWepYC79KwfpO91JWMzDLYA6EDkm3HimxcXpiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FanzLzd/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C125CC4CEE4;
	Mon, 19 May 2025 21:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747690624;
	bh=8K5sDprPkS4frD6Ujl8cJhUCTK82u2aJfFFj51dk78M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FanzLzd/XC+i2vgwSpoMtnfHCvFE+ndlzC5zS1V9xrvW3pvtPwg76YudFotYWcrYP
	 /0VZyV4Tc/h9XKxBYf6IV8Iis5rD3sBS8sazMTTzYFGYs2eSf0dQWTionBZWQYmJbc
	 mPGaauRPG+HkczhJPGbN866GWbGq/V3bSGpy3YEYEwWHyORMWnyUegPZp4vVHmO0Oz
	 I58sZ0UjIv9txf8aVRTL7g3qN7VqbMU/jkBx/2pj6tyNhSBMGMjHUtzcPfmcv9RE7M
	 bFYMb0xGqPOneMpdqAqdhzPaFMzT/1bqaTQfMGUlT9uSqPlaESsJaHJRGWc+pcj4I4
	 fDXmBtKn8IxDQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v6 09/16] PCI/AER: Update statistics early in logging
Date: Mon, 19 May 2025 16:35:51 -0500
Message-ID: <20250519213603.1257897-10-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519213603.1257897-1-helgaas@kernel.org>
References: <20250519213603.1257897-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

There are two AER logging entry points:

  - aer_print_error() is used by DPC (dpc_process_error()) and native AER
    handling (aer_process_err_devices()).

  - pci_print_aer() is used by GHES (aer_recover_work_func()) and CXL
    (cxl_handle_rdport_errors())

Both use __aer_print_error() to print the AER error bits.  Previously
__aer_print_error() also incremented the AER statistics via
pci_dev_aer_stats_incr().

Call pci_dev_aer_stats_incr() early in the entry points instead of in
__aer_print_error() so we update the statistics even if the actual printing
of error bits is rate limited by a future change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 73d618354f6a..eb80c382187d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -693,7 +693,6 @@ static void __aer_print_error(struct pci_dev *dev,
 		aer_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
 				info->first_error == i ? " (First)" : "");
 	}
-	pci_dev_aer_stats_incr(dev, info);
 }
 
 static void aer_print_source(struct pci_dev *dev, struct aer_err_info *info,
@@ -714,6 +713,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	int id = pci_dev_id(dev);
 	const char *level;
 
+	pci_dev_aer_stats_incr(dev, info);
+
 	if (!info->status) {
 		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
 			aer_error_severity_string[info->severity]);
@@ -782,6 +783,8 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	info.status = status;
 	info.mask = mask;
 
+	pci_dev_aer_stats_incr(dev, &info);
+
 	layer = AER_GET_LAYER_ERROR(aer_severity, status);
 	agent = AER_GET_AGENT(aer_severity, status);
 
-- 
2.43.0


