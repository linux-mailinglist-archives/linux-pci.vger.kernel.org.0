Return-Path: <linux-pci+bounces-28027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17409ABCA25
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 23:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD40173640
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 21:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5917B22541C;
	Mon, 19 May 2025 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3gP4m9a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE1F225413;
	Mon, 19 May 2025 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690631; cv=none; b=p37uh/G9hWla7+hnMRm5wv4SmUDA/Vr8eoa5CMR6mYQOb9zhQgCL9JdUbBNaiKoZyZR/R39gjnH08a6A27boFXyxYjwPgnJ9C8mCnroWPFC11zGDyVboVecmMX2sc0iv5lwbQyGpZN/IOQ+TX7UcNeYMuEkqqEA4sDY90rCpS9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690631; c=relaxed/simple;
	bh=wOlbd/AhG2UEes21QN0n7WyeptntoS/yWob+FRL5Zr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/o8gMcT4qVnr93J8OiFq1E7BwDHMI0iUw0okU6/HwLEg147Yck5SW4GUJI0RhYB6cH4dH/U3YCw/V/M1srUGVmfsbMaUrxlcdH7juy/siM6rkfYaJ2KQlOfEFrfu5zR9284JZkwmH8aKeUapoAZPeZAsR4AbnSOF0Dv1EzoC/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3gP4m9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8109EC4CEE4;
	Mon, 19 May 2025 21:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747690629;
	bh=wOlbd/AhG2UEes21QN0n7WyeptntoS/yWob+FRL5Zr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3gP4m9aPW2NsVE0xy/MHN/v0To6ljSLAxEBCwGF4MfF5EU8G3soT+MZBuMT1XmkQ
	 gPwl0jolukEG+ok4nCEziW/vgY6CUiu46p9Mb3n6tv8An5fzPgk69f8gUZ2bKJ7ZtE
	 BonoNkfpV/Q8FpsCbecgLiOvewlHuPnS+FLXq72RiyvMFfQ8G9g4he+YUmib8GNeRW
	 rUd2GXGM/IcI5tGX3LVmFcpjw57h6qRMye5WD4/f/BQmPdkvXcj3umMqdT7JeEAeu3
	 qpeAnioifLP4Kiysktj1aIPLtIk+dyaRW+LryYsqJFtCdhXF+g2/hu9Yj2qy+lExzj
	 URhun88hwlWjw==
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
Subject: [PATCH v6 12/16] PCI/AER: Make all pci_print_aer() log levels depend on error type
Date: Mon, 19 May 2025 16:35:54 -0500
Message-ID: <20250519213603.1257897-13-helgaas@kernel.org>
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

From: Karolina Stolarek <karolina.stolarek@oracle.com>

Some existing logs in pci_print_aer() log with error severity by default.
Convert them to depend on error type (consistent with rest of AER logging).

Link: https://lore.kernel.org/r/20250321015806.954866-3-pandoh@google.com
Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 73b03a195b14..06a7dda20846 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -788,15 +788,21 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	layer = AER_GET_LAYER_ERROR(aer_severity, status);
 	agent = AER_GET_AGENT(aer_severity, status);
 
-	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
+	aer_printk(info.level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n",
+		   status, mask);
 	__aer_print_error(dev, &info);
-	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
-		aer_error_layer[layer], aer_agent_string[agent]);
+	aer_printk(info.level, dev, "aer_layer=%s, aer_agent=%s\n",
+		   aer_error_layer[layer], aer_agent_string[agent]);
 
 	if (aer_severity != AER_CORRECTABLE)
-		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
-			aer->uncor_severity);
+		aer_printk(info.level, dev, "aer_uncor_severity: 0x%08x\n",
+			   aer->uncor_severity);
 
+	/*
+	 * pcie_print_tlp_log() uses KERN_ERR, but we only call it when
+	 * tlp_header_valid is set, and info.level is always KERN_ERR in
+	 * that case.
+	 */
 	if (tlp_header_valid)
 		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
 }
-- 
2.43.0


