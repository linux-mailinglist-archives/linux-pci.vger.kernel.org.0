Return-Path: <linux-pci+bounces-28154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 973B7ABE661
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 23:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576044C1EE3
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 21:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBB3262FD6;
	Tue, 20 May 2025 21:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gesPznDC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A91262FD1;
	Tue, 20 May 2025 21:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747777862; cv=none; b=QDW6ckBQQADxuRuKnaKzRwkb4r6ts4oZLTPBR/ZVgNPmeZ8CTrFY4dITXWRQb7XeiHUHkrWCXDenVbK4mvGgQ5o+J30Fuk3o69c67lfZX3z5wcAvYGGEFCN1bPQCdfkkEqBtIaP6YdmPH6B9apaT9GG+VgbeHAx4j0Q6j8DgzVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747777862; c=relaxed/simple;
	bh=dpCtchW1Q/e/Nwy/CkYgrrg4p1BNgxFi9qKubhq9OqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqYewXULxofLnC1JrWkw9h4gxOODTH1g6joOXVXTbUZY6mfPS00iyI1RwuqgGI3ZtRcOam53V3TfcZPu5vFj4Ip0iKrtpyqjmCjnMeqraoIH0UaYvNFSlNsi4Hid/Esee9uRo2AaWFV3BMMNo9p6W53B2J6AnaYSRrpkpoKdJFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gesPznDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A8FC4CEE9;
	Tue, 20 May 2025 21:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747777862;
	bh=dpCtchW1Q/e/Nwy/CkYgrrg4p1BNgxFi9qKubhq9OqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gesPznDCrCcBrIneZgTAr8fgCKMtCBxeXi0no2IvZsLsEBqp4vop3xNCvvq8Sh6Sz
	 fp2YnI6n1P5YVyw0hYAgVKhTMhga8z1MpI1yNVQfBgxeRK5T786ddR1d+DrW1B6opK
	 IyI5wi/j6ZE1pNNnmJmfB0HTL9TFPJLRakLDcGm4jNOd+Ny5aGSgYO/vvDJT2RSdND
	 6lWS/qW0F4Vz7tIurlNEsBKNSqV8JgnCsoctQ12/znukMoVT64q3lE/ZWlLtRN6YRc
	 iX/KP2BdLsvfYCT8lgYzl7PKwCFJDrS7CFUX+q5jQzlWpbERUMMtaOe2hwwCtkVcb9
	 SgQwnrOxJe0iA==
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
Subject: [PATCH v7 07/17] PCI/AER: Move aer_print_source() earlier in file
Date: Tue, 20 May 2025 16:50:24 -0500
Message-ID: <20250520215047.1350603-8-helgaas@kernel.org>
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

Move aer_print_source() earlier in the file so a future change can use it
from aer_print_error(), where it's easier to rate limit it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aer.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 4f2527d9a365..520c21ed4ba9 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -696,6 +696,18 @@ static void __aer_print_error(struct pci_dev *dev,
 	pci_dev_aer_stats_incr(dev, info);
 }
 
+static void aer_print_source(struct pci_dev *dev, struct aer_err_info *info,
+			     const char *details)
+{
+	u16 source = info->id;
+
+	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d%s\n",
+		 info->multi_error_valid ? "Multiple " : "",
+		 aer_error_severity_string[info->severity],
+		 pci_domain_nr(dev->bus), PCI_BUS_NUM(source),
+		 PCI_SLOT(source), PCI_FUNC(source), details);
+}
+
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	int layer, agent;
@@ -733,18 +745,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
-static void aer_print_source(struct pci_dev *dev, struct aer_err_info *info,
-			     const char *details)
-{
-	u16 source = info->id;
-
-	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d%s\n",
-		 info->multi_error_valid ? "Multiple " : "",
-		 aer_error_severity_string[info->severity],
-		 pci_domain_nr(dev->bus), PCI_BUS_NUM(source),
-		 PCI_SLOT(source), PCI_FUNC(source), details);
-}
-
 #ifdef CONFIG_ACPI_APEI_PCIEAER
 int cper_severity_to_aer(int cper_severity)
 {
-- 
2.43.0


