Return-Path: <linux-pci+bounces-14389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9DF99B487
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 13:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D901C20CA6
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 11:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A07194136;
	Sat, 12 Oct 2024 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxGrmHhl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB9A194124
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732778; cv=none; b=VXIHMvNFoKs6thb4OfeKuH7kg9Z9MPG7UBUoizlEMKPnhJpIdS8TwbVKN+uuYwggemtBAVf0/6/j3BL4Ahd/aI0SR5GsA0zXceCYQZjh25LGMP2YRMixtuCN+Mywiu+vIgDedSJWSA/3e+Q8Iay+pufa0w8WJnN392SONQbqINA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732778; c=relaxed/simple;
	bh=qApH0Soz2QG8ZM1oHvLhdsJ1VR9oK74uvJD7yLG/jiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dn1N37DtSwykWe4eBxIkJKwCbu+DwMOWWhcDtARxkBPDgRaj2/cl8X5Ulg006k9YA414q9H9iiTElfJ6jkZgUa00WinU6eSp3haSbyFuIpjuAyvCiEbZxw+bYNFLa+t7Hp8xwstpp/ZDq0hqdl8+wtB2f+zhrbQrn7N0z80XcQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxGrmHhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC19C4CECF;
	Sat, 12 Oct 2024 11:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732778;
	bh=qApH0Soz2QG8ZM1oHvLhdsJ1VR9oK74uvJD7yLG/jiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VxGrmHhlOePtA3rdJpP1ShqGLgXAMWAmR6GgAghxjj/VuFqFfOuFjeTumwgRAeE+y
	 K0ZOe8QdyreWzP+/p0SFB2Axd1P67PUIZ9H5z5CTR+Wo6GXB10QYnuOsyAFDI5owJd
	 rqL7uKk4rdj6eKRSb1t4yZxpUgarW5zbbh7TZyeO41aqLJX1HDiA0+GJ6sk/eYebKn
	 8H2GZLriLy+tU5NYM8f3Vkz8nC1nsweTfXb5gWa2lrNkNE4sD+BInV8akIuOeOOVgZ
	 PdTJfSw0AVsJNWJSB0nXvuFAuXec38FtKfQ/m+1C+a2u45DCCHVHV1sJ7Xo/j0jNA2
	 hE4T/vg+ABJaQ==
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
Subject: [PATCH v6 6/6] PCI: dwc: endpoint: Implement the pci_epc_ops::align_addr() operation
Date: Sat, 12 Oct 2024 20:32:46 +0900
Message-ID: <20241012113246.95634-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241012113246.95634-1-dlemoal@kernel.org>
References: <20241012113246.95634-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function dw_pcie_prog_outbound_atu() used to program outbound ATU
entries for mapping RC PCI addresses to local CPU addresses does not
allow PCI addresses that are not aligned to the value of region_align
of struct dw_pcie. This value is determined from the iATU hardware
registers during probing of the iATU (done by dw_pcie_iatu_detect()).
This value is thus valid for all DWC PCIe controllers, and valid
regardless of the hardware configuration used when synthesizing the
DWC PCIe controller.

Implement the ->align_addr() endpoint controller operation to allow
this mapping alignment to be transparently handled by endpoint function
drivers through the function pci_epc_mem_map().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 43ba5c6738df..ad602b213ec4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -268,6 +268,20 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
 	return -EINVAL;
 }
 
+static phys_addr_t dw_pcie_ep_align_addr(struct pci_epc *epc,
+			phys_addr_t pci_addr, size_t *pci_size, size_t *offset)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	phys_addr_t mask = pci->region_align - 1;
+	size_t ofst = pci_addr & mask;
+
+	*pci_size = ALIGN(ofst + *pci_size, ep->page_size);
+	*offset = ofst;
+
+	return pci_addr & ~mask;
+}
+
 static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				  phys_addr_t addr)
 {
@@ -444,6 +458,7 @@ static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
 	.clear_bar		= dw_pcie_ep_clear_bar,
+	.align_addr		= dw_pcie_ep_align_addr,
 	.map_addr		= dw_pcie_ep_map_addr,
 	.unmap_addr		= dw_pcie_ep_unmap_addr,
 	.set_msi		= dw_pcie_ep_set_msi,
-- 
2.47.0


