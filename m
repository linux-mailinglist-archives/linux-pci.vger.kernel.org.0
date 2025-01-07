Return-Path: <linux-pci+bounces-19455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABB3A0490B
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 19:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895D3165E95
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 18:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FA6198A0D;
	Tue,  7 Jan 2025 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeGaWYE9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74AA1EE013
	for <linux-pci@vger.kernel.org>; Tue,  7 Jan 2025 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273730; cv=none; b=FBG8zQGUM1VF02SHzDm11pKncYswtbiUkG9MLfr/BO8lZuoL0uX1kWZBmY8mR+skAk4AG5rzYtW4GC6+T/SNxQ4q4zAfVu7gpcOUqPhf6X2v356cqG/k+ckvAq37OPurPV4p8VTApoWr9ERgA924bBD7T/gjg/9kevFz6zMMSE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273730; c=relaxed/simple;
	bh=Yp1kSs17kW6mzImsCQDNvZePX3qc9b5BoCNjhBaDlP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vadf/rve3Xb29rwFK9s43CBoourRmKEJBjAXPRDv0bkYfH++FlFB/m2Ux5X68o757w1CBgrA2xOII/MrtvgMUnhe4rEIVf24e0DXckNvEOp0GyFljpmY4e3onCmJN29N4uxyW6bgNvGEBDafl+2B/CHxJDApp+Ce414aBzYDaOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeGaWYE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FD2C4CEDE;
	Tue,  7 Jan 2025 18:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736273730;
	bh=Yp1kSs17kW6mzImsCQDNvZePX3qc9b5BoCNjhBaDlP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oeGaWYE9x9us2FW5SbEm9nlltag4bnw6O3KEfx0XjegWF6TzaXbNMJxJfByIpSI51
	 XQOks49Z9A01nOwRszB6UmGJ7EHcxp47inOGYjaosIRJ2HAjXIWjs6+xtIhmKDdO9/
	 Tp4L+Q9CBGYCoGhpu9R9TROkDf9wonceY0rHORWPPeWk3zwCdK0erAxwd0F725PzbT
	 RVHIiJLRTDVGC8d6Ggli9z8OuADW32qwlrzvYemLEbWMj4tKbexkqIVd9EMtySxLG9
	 3EY0Wkko+gniOy/RmloGbIaqtG4OrKw1sLtVp7LWeuEtvTZbCxJ3q9ulSXhbiuk1Ws
	 N1bXMAHv8CYJg==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/6] PCI: dwc: ep: Move dw_pcie_ep_find_ext_capability()
Date: Tue,  7 Jan 2025 19:14:52 +0100
Message-ID: <20250107181450.3182430-10-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107181450.3182430-8-cassel@kernel.org>
References: <20250107181450.3182430-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884; i=cassel@kernel.org; h=from:subject; bh=Yp1kSs17kW6mzImsCQDNvZePX3qc9b5BoCNjhBaDlP0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJr8xWE1ls+XCJh+XfJy3kz65tDIo6+nSa3vHWTzccrk iwnmLRKOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCR3W8Y/hfP/iR28Pjlulf9 zmmObH1rq1tDaus5D0U9WO+1aL/59lJGhsuPnnx1qU+R3sJSO7OERVnXPPRm8p4ip9/TXvhcWrv /PxMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Move dw_pcie_ep_find_ext_capability() so that it is located next to
dw_pcie_ep_find_capability().

Additionally, a follow-up commit requires this to be defined earlier
in order to avoid a forward declaration.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 8e07d432e74f..6b494781da42 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -102,6 +102,24 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
 	return __dw_pcie_ep_find_next_cap(ep, func_no, next_cap_ptr, cap);
 }
 
+static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
+{
+	u32 header;
+	int pos = PCI_CFG_SPACE_SIZE;
+
+	while (pos) {
+		header = dw_pcie_readl_dbi(pci, pos);
+		if (PCI_EXT_CAP_ID(header) == cap)
+			return pos;
+
+		pos = PCI_EXT_CAP_NEXT(header);
+		if (!pos)
+			break;
+	}
+
+	return 0;
+}
+
 static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				   struct pci_epf_header *hdr)
 {
@@ -690,24 +708,6 @@ void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit);
 
-static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
-{
-	u32 header;
-	int pos = PCI_CFG_SPACE_SIZE;
-
-	while (pos) {
-		header = dw_pcie_readl_dbi(pci, pos);
-		if (PCI_EXT_CAP_ID(header) == cap)
-			return pos;
-
-		pos = PCI_EXT_CAP_NEXT(header);
-		if (!pos)
-			break;
-	}
-
-	return 0;
-}
-
 static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
 {
 	unsigned int offset;
-- 
2.47.1


