Return-Path: <linux-pci+bounces-28294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE346AC17C3
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 01:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8161C04B71
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 23:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C134F2D3A63;
	Thu, 22 May 2025 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJiY9s6O"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9975C2D323F;
	Thu, 22 May 2025 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956236; cv=none; b=sUWxBt+PJ1X4Vq3DX2C3lKDk1JaZcXpX0/4a5NJMYXAKO/leutf+ecCIXWuJkWNnd7pFsmureYhMy6+tJNI0T4+jh/o7rybaEBCvT5V/UjGH4Y03mZqVi6VOMwRznhjfOQSHkbxzF7PWuzoofww+/nJbkTKDjrgapWlaNYrrAAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956236; c=relaxed/simple;
	bh=0WV3S2hggEo8UB79jSOkfPluYQMTTXi8KwtvSdvTY18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKBvChy9k8DcbTFQ0RyGI1o8pS/7m0/V/W3WKgoJ4wcv3eUMg08MHf9d3EEcRDiXNBMmV6MPnmjaXMjxEzcLi9D0busAiSQJVk9GZO0sZiRKCrtT5dWOQtBIVbwNjekZkR1Fgpe3vhEKLGVh5G637wOdEIl4rbSfZ77sq9hF70w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJiY9s6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC70DC4CEE4;
	Thu, 22 May 2025 23:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747956236;
	bh=0WV3S2hggEo8UB79jSOkfPluYQMTTXi8KwtvSdvTY18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AJiY9s6OH7qIicXuS2Ll0QHIyK6j/AWpefUUSdt4LQ8yVlNr6r7iGmcfjJspy//UT
	 jgaj7B41td+8JM3OWqEiS6RXnYRM3z3RUfzS0psqsia66YER2qk0nNDZ5OvejnXPUD
	 IetaDWdOi8KHzJujxUQIjzh5a48tnUttgj3L3a/A4a1eG0609Tp7G1fM1frR+kT3Rs
	 TH6SOIdq6VWqnjbkOJc4abab2sCHcYURXPg0goPTRyEEXrJ3CIkCB+Txy0aTFkKAMh
	 KG+4EYdIPQkdKIWsvoNC5oqxexQCSZDyG0/AlE+V/1OVG6XW0Ie8/vrovK6d8w+H2R
	 KH0Sm/rRbQHcQ==
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
Subject: [PATCH v8 07/20] PCI/AER: Move aer_print_source() earlier in file
Date: Thu, 22 May 2025 18:21:13 -0500
Message-ID: <20250522232339.1525671-8-helgaas@kernel.org>
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

Move aer_print_source() earlier in the file so a future change can use it
from aer_print_error(), where it's easier to rate limit it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://patch.msgid.link/20250520215047.1350603-8-helgaas@kernel.org
---
 drivers/pci/pcie/aer.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 8b23ef90345b..c0481550363b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -696,6 +696,19 @@ static void __aer_print_error(struct pci_dev *dev,
 	pci_dev_aer_stats_incr(dev, info);
 }
 
+static void aer_print_source(struct pci_dev *dev, struct aer_err_info *info,
+			     bool found)
+{
+	u16 source = info->id;
+
+	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d%s\n",
+		 info->multi_error_valid ? "Multiple " : "",
+		 aer_error_severity_string[info->severity],
+		 pci_domain_nr(dev->bus), PCI_BUS_NUM(source),
+		 PCI_SLOT(source), PCI_FUNC(source),
+		 found ? "" : " (no details found");
+}
+
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	int layer, agent;
@@ -733,19 +746,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
-static void aer_print_source(struct pci_dev *dev, struct aer_err_info *info,
-			     bool found)
-{
-	u16 source = info->id;
-
-	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d%s\n",
-		 info->multi_error_valid ? "Multiple " : "",
-		 aer_error_severity_string[info->severity],
-		 pci_domain_nr(dev->bus), PCI_BUS_NUM(source),
-		 PCI_SLOT(source), PCI_FUNC(source),
-		 found ? "" : " (no details found");
-}
-
 #ifdef CONFIG_ACPI_APEI_PCIEAER
 int cper_severity_to_aer(int cper_severity)
 {
-- 
2.43.0


