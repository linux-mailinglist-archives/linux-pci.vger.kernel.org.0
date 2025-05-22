Return-Path: <linux-pci+bounces-28298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E73F5AC17D1
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 01:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A17A44977
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 23:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3192D4B78;
	Thu, 22 May 2025 23:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMMQV3nY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E9C2D0286;
	Thu, 22 May 2025 23:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956242; cv=none; b=U+Gz3mVtENAqfQDlFblNv2NM3dTcYJ3ATKh6hewM0Fp7+fri7mekzwnyuax+/iJSycRtz6Sv1SkGmIctIfkl7kg5/4Ur8mpSvGkroGTlxNsMyRo37pT8D1vgLTT2nGHWEmAZ8MlMpyoMREVu9QuBl/e4aSMEnQaDYPbOP9nN/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956242; c=relaxed/simple;
	bh=UNgXV/OmBS6XzWhwhC+kkuFi7ERITkNf7w0qVbubW7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oxycrvRFfPsSgAxA7VWwjxX2fSei7a9ClPldyPya2cko12WJQa6UQml68WHqcNOamOCCxS0hrh8sNZYn8351GqHZkkRtsZRzn5Mu5bjFGIsFBViUHUCK/SoAFzZm3evJXgV1J4eF+prkjutILGQDP9/xn6nZ1xBaqF+J7fRMJy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMMQV3nY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9CBC4CEE4;
	Thu, 22 May 2025 23:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747956242;
	bh=UNgXV/OmBS6XzWhwhC+kkuFi7ERITkNf7w0qVbubW7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qMMQV3nY413SZHUGA7ZTLZm9sJPK+q0/t8R2Px72ZIoVNrFdQvWPwFFePax/+cRDX
	 3OQ82iuVCHEa2kN4D7N+C49x+FHq7ZIu50Bvz8B34ywcczBrKa1Vw1BkHls8JaiQ5+
	 LaMwxBn2R+nLBHsOqvxRjefRybuob14n2c/Sx1+4/GSsH/wYDc2Qm4IPFcPwVx7GZj
	 wqUA6WwJ2sNVX2YYeYnegmid3kV36QdCqfd8FbIlnfkx5++IjzMh69c6PggeNyXbgr
	 hLFouW59TEoBpGdufaLlgQAnT2dTAAhfDjx+ye3EImrYOUkwVYpC6++IARxc5ynyFy
	 gqA83HpvDIWRg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Weinan Liu <wnliu@google.com>,
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
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH v8 11/20] PCI/AER: Trace error event before ratelimiting
Date: Thu, 22 May 2025 18:21:17 -0500
Message-ID: <20250522232339.1525671-12-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522232339.1525671-1-helgaas@kernel.org>
References: <20250522232339.1525671-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

As with the AER statistics, we always want to emit trace events, even if
the actual dmesg logging is rate limited.

Call trace_aer_event() immediately after pci_dev_aer_stats_incr() so both
happen before ratelimiting.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Link: https://patch.msgid.link/20250520215047.1350603-12-helgaas@kernel.org
---
 drivers/pci/pcie/aer.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 53f460bb7e6c..636bcd92afa1 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -715,6 +715,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	const char *level;
 
 	pci_dev_aer_stats_incr(dev, info);
+	trace_aer_event(pci_name(dev), (info->status & ~info->mask),
+			info->severity, info->tlp_header_valid, &info->tlp);
 
 	if (!info->status) {
 		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
@@ -742,9 +744,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 out:
 	if (info->id && info->error_dev_num > 1 && info->id == id)
 		pci_err(dev, "  Error of this Agent is reported first\n");
-
-	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
-			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -785,6 +784,8 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	info.mask = mask;
 
 	pci_dev_aer_stats_incr(dev, &info);
+	trace_aer_event(pci_name(dev), (status & ~mask),
+			aer_severity, tlp_header_valid, &aer->header_log);
 
 	layer = AER_GET_LAYER_ERROR(aer_severity, status);
 	agent = AER_GET_AGENT(aer_severity, status);
@@ -800,9 +801,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 
 	if (tlp_header_valid)
 		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
-
-	trace_aer_event(pci_name(dev), (status & ~mask),
-			aer_severity, tlp_header_valid, &aer->header_log);
 }
 EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
 
-- 
2.43.0


