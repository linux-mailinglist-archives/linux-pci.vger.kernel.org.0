Return-Path: <linux-pci+bounces-28023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0963CABCA10
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 23:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3028F1B67D10
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 21:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2052C2236EB;
	Mon, 19 May 2025 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWRWJyaC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADDD222595;
	Mon, 19 May 2025 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690624; cv=none; b=DtV1o4HtgKgh97Jqo++t+BQWtfDVW0YmwGp6egFd0nzPiaOnA4ocsNZRyk9SMfYmcVFAj328dXefvNMNW+xUMC29vbh4HARamWfy0q611Jm/lu3iTdjtWmNaoqeeU0J79kUBxnxK7DanxWBhjvFis+55dFlS6OmmoXDU7ob784w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690624; c=relaxed/simple;
	bh=aIk3s78Pjc+1Yr5MfxrprcdbuGy62ZG0jyrmmvahF1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zx7ojkGzxN9kMgaX/hn6NewgwpKXJesjwRzrMn20rLMNQex+H3w18sOBLhjyw+mRj/+eivaJCP8cf/B+f+grqXZSIKzzGuYPK6u7Fi/eOkUuos9Lf22AQZKoTRgVTCxE6kEigP3GlKu5pdV9l0IiaMDg3nkStrFpD6mjoLcBNv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWRWJyaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E541C4CEE4;
	Mon, 19 May 2025 21:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747690623;
	bh=aIk3s78Pjc+1Yr5MfxrprcdbuGy62ZG0jyrmmvahF1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CWRWJyaCEr9Wq1Bq7IbazqaALn2KniioErpwVjFrt6dwkUCcPXEnkfR/99bzOTsUT
	 /4xhjS4UByA6qTpir4SoXPYs9tJRj5w3wBOYBAqLN1XN7dxkwzQV3qNCnkODW+kGS7
	 GZ11Eq/6Y1Pe2dT+JeQ2AhtLshsgdqjsHty2QmnONvhrUTG4alCX60FYL1uoLmTuXt
	 hIPzTrLlJ15jmQU5A7E/40edQhPyZQfJKIt+saC5FprcEMa4vjvuoU0260YVEiQQLb
	 OW3uN++ML5A3STxwyNdzvBOeO5vm6qHRyZHmxeuTA16ZYeDLeftimstnUdjhcrn0dV
	 99inID0+bH+nA==
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
Subject: [PATCH v6 08/16] PCI/AER: Simplify pci_print_aer()
Date: Mon, 19 May 2025 16:35:50 -0500
Message-ID: <20250519213603.1257897-9-helgaas@kernel.org>
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

Simplify pci_print_aer() by initializing the struct aer_err_info "info"
with a designated initializer list (it was previously initialized with
memset()) and using pci_name().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 40f003eca1c5..73d618354f6a 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -765,7 +765,10 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 {
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
-	struct aer_err_info info;
+	struct aer_err_info info = {
+		.severity = aer_severity,
+		.first_error = PCI_ERR_CAP_FEP(aer->cap_control),
+	};
 
 	if (aer_severity == AER_CORRECTABLE) {
 		status = aer->cor_status;
@@ -776,14 +779,11 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		tlp_header_valid = status & AER_LOG_TLP_MASKS;
 	}
 
-	layer = AER_GET_LAYER_ERROR(aer_severity, status);
-	agent = AER_GET_AGENT(aer_severity, status);
-
-	memset(&info, 0, sizeof(info));
-	info.severity = aer_severity;
 	info.status = status;
 	info.mask = mask;
-	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
+
+	layer = AER_GET_LAYER_ERROR(aer_severity, status);
+	agent = AER_GET_AGENT(aer_severity, status);
 
 	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
 	__aer_print_error(dev, &info);
@@ -797,7 +797,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	if (tlp_header_valid)
 		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
 
-	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
+	trace_aer_event(pci_name(dev), (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 }
 EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
-- 
2.43.0


