Return-Path: <linux-pci+bounces-13802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 194EF98FCE9
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 07:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A62B1C22015
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 05:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EB24DA04;
	Fri,  4 Oct 2024 05:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsRmerkn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424022868E
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 05:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728018475; cv=none; b=gM7/qHsBj8KRzhlf9lNU2HPwPHnRlkBucdOYoWJV1r2qfe2gjDGvH7wCGvusfqC14kb/mDt8Bm2M8HiQat+irYUHRORlGA15nf3RQ4gn8uVVDwE7J9/WMu9rqA61k2m5dLCbuW0XtisMm823j301PkEHKJGGiRTF0M3evEZh2eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728018475; c=relaxed/simple;
	bh=q2TrCapCGc8UI1RQFOlQzQ9SBIo9TvptPVNED+gV1WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILfDWqsmzpWdAv1L1ohx2M0TMQj0Kglc0oOLSAi2OWKDHDQSbuSA/y8+piQyP6iP7SzXPERqj2BkXsOui5g4jiK9sQzz5cEAq+kUttjUeqGOln0dIvxMor+LbiwC/KwpXMhkNsC6q1nbquVW9h7RXtKyxjWmmKftxSin9HukGoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsRmerkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E450FC4CECE;
	Fri,  4 Oct 2024 05:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728018475;
	bh=q2TrCapCGc8UI1RQFOlQzQ9SBIo9TvptPVNED+gV1WE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UsRmerknaI7No+xIlsejgFlqo4v4NRBppi6OOynHhOwD/ON3y6nVFvY/ckYT4e70H
	 RBVldvulBcJNnMuNlvt8f2VlJ1CByZS3IMjRYb2g73AScULBOLfJbOf1UMoQl7oSI9
	 l3Te2bZe7fMl0/2O/ju28sje6uM3bDz2JwYVftljv42y2gPFJi8ydsE7IkoEawaxkn
	 ofrcf354eCUGPaj9cuTqLoN+PsN5FhVsCc3fDx846EEM3EJsWM6AILwpqsOe4nlaZ7
	 RhoWjTx1Ghisk31Gqu0g2qw993o18KGnrRuDo/4Etav0ggt9lc79XotNb6kbqHzpB7
	 xYJSrpK7mK4jw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>,
	linux-pci@vger.kernel.org
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 7/7] PCI: dwc: endpoint: Define the .map_align() controller operation
Date: Fri,  4 Oct 2024 14:07:42 +0900
Message-ID: <20241004050742.140664-8-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241004050742.140664-1-dlemoal@kernel.org>
References: <20241004050742.140664-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function dw_pcie_prog_outbound_atu() used to program outbound ATU
entries for mapping RC PCI addresses to local CPU addresses does not
allow PCI addresses that are not aligned to struct dw_pcie->region_align
(generally 64K).

Handle this constraint by defining the endpoint controller .map_align()
operation to calculate a mapping size and the offset into the mapping
based on the requested RC PCI address and size to map.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 43ba5c6738df..501e527c188e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -268,6 +268,20 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
 	return -EINVAL;
 }
 
+static int dw_pcie_ep_map_align(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				struct pci_epc_map *map)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	size_t mask = pci->region_align - 1;
+
+	map->map_pci_addr = map->pci_addr & ~mask;
+	map->map_ofst = map->pci_addr & mask;
+	map->map_size = ALIGN(map->map_ofst + map->pci_size, ep->page_size);
+
+	return 0;
+}
+
 static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				  phys_addr_t addr)
 {
@@ -444,6 +458,7 @@ static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
 	.clear_bar		= dw_pcie_ep_clear_bar,
+	.map_align		= dw_pcie_ep_map_align,
 	.map_addr		= dw_pcie_ep_map_addr,
 	.unmap_addr		= dw_pcie_ep_unmap_addr,
 	.set_msi		= dw_pcie_ep_set_msi,
-- 
2.46.2


