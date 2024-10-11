Return-Path: <linux-pci+bounces-14289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9D699A326
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4551C20CEE
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFD921500F;
	Fri, 11 Oct 2024 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYFQjzJ2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4A7216A3E
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648093; cv=none; b=Qxm/7k2Qg8Eeyn5zTcDWkpEFpZcbHRu+GCFHqI/15M5LxOzow+A5hI1FcGrn0Te2snsrSwP92LDnF8N5YtA/BMhmApocmMcW2WZn2wmBDONNO6Gjsl81NRDr5jm1qEs43DZicG2WZSyKINIvnF0SGxxGmrec7HOQNVvKuOITqIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648093; c=relaxed/simple;
	bh=CQ6PvhizfGBwCyVuEIy1Tp0Fk7YOlbdHfJ+HxdHghA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fj2DnChRk1f6wYz2Y2mqyYIqHFa9FMNSfnjf2elpj2IKv0lcg++B2dt4QK8hNN9q7dPG95DNBaGBQlDNQhm9KVL1v3VUrb+0hovrMyUhfxuP3R4oG6eao2IfeAwghulzdtqx32VQJjAc2uOLXrDeYrrIW4NERujLjL6YtDj2d+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYFQjzJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E8AC4CECF;
	Fri, 11 Oct 2024 12:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728648092;
	bh=CQ6PvhizfGBwCyVuEIy1Tp0Fk7YOlbdHfJ+HxdHghA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LYFQjzJ2CDpJjQdZTLuendYnaAY0HckU6PZYMHpFqZCabSo+A01cCfyvMtJxOTRZ5
	 ZZItyYr60umRFA1WUASAWBkmUAzde4UEravu7B9+/Vf/SCb7vvQBRgvf8F3wbpGGx1
	 UKVlhwV8nKFFHd4aEr4Y4OsKODzJ/OyD1qQ1oiUVb5lWoF7IAgroMyIQeLTGiFQCVD
	 HMuX48a1X0yZ7kzDOGEN6jNnkZy9D+nsZ3Q5Hyn0yfVZebk9BvujMOdZrx0LxPvBzG
	 CfsUy/1WR3M4z+ftiZYR9EK95YADCDRA+DpG0dVPuU0RngMWJvjuNZfegN0CBCbjoQ
	 sccpRN4G/x2Qw==
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
Subject: [PATCH v5 6/6] PCI: dwc: endpoint: Implement the pci_epc_ops::get_mem_map() operation
Date: Fri, 11 Oct 2024 21:01:15 +0900
Message-ID: <20241011120115.89756-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011120115.89756-1-dlemoal@kernel.org>
References: <20241011120115.89756-1-dlemoal@kernel.org>
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

Implement the ->get_mem_map() endpoint controller operation to allow
this mapping alignment to be transparently handled by endpoint function
drivers through the function pci_epc_mem_map().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 43ba5c6738df..b65f4f0f5856 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -268,6 +268,20 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
 	return -EINVAL;
 }
 
+static int dw_pcie_ep_get_mem_map(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				  struct pci_epc_map *map)
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
+	.get_mem_map		= dw_pcie_ep_get_mem_map,
 	.map_addr		= dw_pcie_ep_map_addr,
 	.unmap_addr		= dw_pcie_ep_unmap_addr,
 	.set_msi		= dw_pcie_ep_set_msi,
-- 
2.47.0


