Return-Path: <linux-pci+bounces-13909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF95F992358
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771411F225E3
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 04:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207EC4430;
	Mon,  7 Oct 2024 04:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHAXNMHa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E8E3C2F
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 04:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728273819; cv=none; b=P+KUCtotJP8XTR5KqjJ52eUmBCE7h5HpITxelhrdeMAEcWW1Cb5Oy/l+MLRA7Y8XyzCghMPwAKVzIkZJlDY/TfqDk0gplQw6MlemJYj8K1y5fMSxYvY37YJIuAXFlKs7XvAY8xODNrGPvR0huMnU3Y6D8vEgzidoOTa5TlgFxjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728273819; c=relaxed/simple;
	bh=yx4Q/rn6pqKvqmdQqzU9Qy7oW1jSZp2YseRN8m9MKkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GycEjsSakOIexxrcGiRn8GYRutXPVbL/o6dP2q6fcsBbwuKhHlbqZLYc1wtlO0J4veUEjwu2sfFjqX1g6wVdX6EWfxJ43OqNjva2js94B5DS3LvnHo2+YkzNUlvcB2/4qx72IUNANyw1BKFRNlIARJkoIL0WC1iXqq6Pw2iew4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHAXNMHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3198C4CED3;
	Mon,  7 Oct 2024 04:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728273817;
	bh=yx4Q/rn6pqKvqmdQqzU9Qy7oW1jSZp2YseRN8m9MKkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rHAXNMHaxU8cLQDlI6L10MU7XkB3OHUvzSAlXTrzQGMQv8OpX/Ni9s7zBjLmKRDZN
	 AvZ0Ysez8ODpAE5OxpsqnOxFwHaqGFKEgUAGOQAnKYNT1ZPLNh+tccRw04sH3kA3Xy
	 NzxScwTFRRSEGDXktohs/eEYaL6LfB+LavmdFv0kmF0RynM5x1effcf3qhKFayeiZ1
	 13mHZavxUSLav96ABdgSGoFaWD2VX00AN6hdIoK7gFZFeg/onyAj44cYlEv271zUB2
	 1Q0QUkZE+QIe6CKu1Ybkbcy4ldXS95mOYkGx07AM3hqk4zD0ePCP5RglemIXNfZOcQ
	 woDjIpiZ9d/Ww==
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
Subject: [PATCH v4 7/7] PCI: dwc: endpoint: Define the .map_align() controller operation
Date: Mon,  7 Oct 2024 13:03:19 +0900
Message-ID: <20241007040319.157412-8-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007040319.157412-1-dlemoal@kernel.org>
References: <20241007040319.157412-1-dlemoal@kernel.org>
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

Handle this PCI address alignment constraint by defining the endpoint
controller .map_align() operation to calculate a mapping size and the
offset into the mapping based on the requested RC PCI address and size
to map.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
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


