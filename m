Return-Path: <linux-pci+bounces-28158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AC9ABE674
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 23:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51D1C4C2309
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 21:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3339264A96;
	Tue, 20 May 2025 21:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qpnd0IGU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E13264A92;
	Tue, 20 May 2025 21:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747777868; cv=none; b=Y6u3hDsBaXueaCB7rmxIXoLb/rgzkKmG3AQfHgQ3d5RcZvJ//nm84r9vBfLixbTttlbsHCOtMniS5jVrQrR9ZIOXyTsuse09+y2xZY393QiM3suLRWAysEe0YpxW7Uvdjeye/LKOdORY5un0HnNlzC6ovIbw99hIxtj8EZZRd0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747777868; c=relaxed/simple;
	bh=2OyCh2zUVaDfVgIXc71EE7QnrDSytlrlZxpFNHO6w9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOpoh+IabDwpZPfH2Gy2eGtl9kfpvonOU8rRlT4z8OcD5zDvhIxMlzz6dPk8e4dJgdNMr2QZqL4Nh3S8w3ZgNn4h0fXFeCFTdppGRth3x0nYY+up7qkVsGws6Xa5jkuff7qRlR67Vtr5wMXJb2QvdndGoWkjl7YiLGtNAXEcPRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qpnd0IGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E5DC4CEE9;
	Tue, 20 May 2025 21:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747777868;
	bh=2OyCh2zUVaDfVgIXc71EE7QnrDSytlrlZxpFNHO6w9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qpnd0IGU0KMkco4HTOY3N/7EYmlfVwBg4a1niEasrtDNC5+vzTtzk/3sjV3I2QrJ4
	 dg69+MSp8x/24chJFwChm/O3zXYkJX4cOqFfD1Zlc/AImzU1vPYAxzeMpq1Fk5EYck
	 /bRfPamTA5M/jhLIzPNJiIddgAMNioxsS+j/3YWx/YumktjSKs31tziZ1JAgPviAvx
	 n+494QNjS2CwH4XARNWBgM5bfhL8l8YvesEIdyefVWXCgD1lMc5mU/8AwXlpMg8GvN
	 4WTfIdOoQumdA/BjxkmAjcaegry2ccYQSC4jZ9so8AHDbEqeacAW4tnKIGmru6G9ke
	 SHSTC783pUOEg==
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
Subject: [PATCH v7 11/17] PCI/AER: Combine trace_aer_event() with statistics updates
Date: Tue, 20 May 2025 16:50:28 -0500
Message-ID: <20250520215047.1350603-12-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520215047.1350603-1-helgaas@kernel.org>
References: <20250520215047.1350603-1-helgaas@kernel.org>
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

Call trace_aer_event() directly from pci_dev_aer_stats_incr(), where we
update the statistics.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/aer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 53b7559564a9..ec63825a808e 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -625,6 +625,9 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
 	u64 *counter = NULL;
 	struct aer_stats *aer_stats = pdev->aer_stats;
 
+	trace_aer_event(pci_name(pdev), (info->status & ~info->mask),
+			info->severity, info->tlp_header_valid, &info->tlp);
+
 	if (!aer_stats)
 		return;
 
@@ -741,9 +744,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 out:
 	if (info->id && info->error_dev_num > 1 && info->id == id)
 		pci_err(dev, "  Error of this Agent is reported first\n");
-
-	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
-			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -782,6 +782,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 
 	info.status = status;
 	info.mask = mask;
+	info.tlp_header_valid = tlp_header_valid;
+	if (tlp_header_valid)
+		info.tlp = aer->header_log;
 
 	pci_dev_aer_stats_incr(dev, &info);
 
@@ -799,9 +802,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 
 	if (tlp_header_valid)
 		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
-
-	trace_aer_event(pci_name(dev), (status & ~mask),
-			aer_severity, tlp_header_valid, &aer->header_log);
 }
 EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
 
-- 
2.43.0


