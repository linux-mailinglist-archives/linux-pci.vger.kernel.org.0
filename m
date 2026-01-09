Return-Path: <linux-pci+bounces-44358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C36BAD08F5A
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 12:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15ECE3011185
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 11:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62C01946C8;
	Fri,  9 Jan 2026 11:36:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2502550097C
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 11:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958576; cv=none; b=ezHuexEWUbLQOxkgB1BItGpHSh+iYexj5UFDJbtN5Vwi5yVB+qE9NeQDx8sbZ2b4AwQnU+XUUcno8UpxaJ6KHnG+jmFwynXXOd28SlJk7khmrNAdH0r1pVS4Ma6DH2NeZubexbY8pbjOCFNql43B4m/GCX+C+5k6CQUp92n7Fo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958576; c=relaxed/simple;
	bh=Uhlkk3LVxRsNvWI7huS9pzK+/qSKKm9V9GgFmplCnCA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QHuqvk7F+uUXaDVpWprJfFu5ynSaXcTzpOXjgYaGsg6ImPyHiChyMv6LITiTdziKwMydFrSITYYXB4fO2HUD+FbVr++E6QxWoZBowtP75mhvgGeebA+oODBFrhmMM79dZPF3erXnKi2O1WUcrR8co3AUJfvlU6+hch/eQZPlAnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 609BYdaA080471
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Fri, 9 Jan 2026 19:34:39 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Jan
 2026 19:34:39 +0800
From: Randolph <randolph@andestech.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, <robh@kernel.org>,
        <kwilczynski@kernel.org>, <lpieralisi@kernel.org>, <mani@kernel.org>,
        <jingoohan1@gmail.com>, <samuel.holland@sifive.com>,
        <Frank.Li@nxp.com>, <cmirabil@redhat.com>, <randolph.sklin@gmail.com>,
        <tim609@andestech.com>, Randolph Lin <randolph@andestech.com>
Subject: [PATCH v2] PCI: dwc: Use multiple ATU regions for large bridge windows
Date: Fri, 9 Jan 2026 19:34:30 +0800
Message-ID: <20260109113430.2767264-1-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 609BYdaA080471

From: Samuel Holland <samuel.holland@sifive.com>

Some SoCs may allocate more address space for a bridge window than can
be covered by a single ATU region. Allow using a larger bridge window
by allocating multiple adjacent ATU regions.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Co-developed-by: Randolph Lin <randolph@andestech.com>
Signed-off-by: Randolph Lin <randolph@andestech.com>
---
Since our changes depend on the original patch and no updated revision
has been posted by the original author, we reached out to Samuel Holland
directly and received his approval.I have consolidated the required
changes and am resending them as v2.
---
 .../pci/controller/dwc/pcie-designware-host.c | 72 ++++++++++++++-----
 1 file changed, 55 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 372207c33a85..771e71b40f76 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -903,29 +903,49 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->windows) {
+		resource_size_t res_size;
+
 		if (resource_type(entry->res) != IORESOURCE_MEM)
 			continue;
 
-		if (pci->num_ob_windows <= ++i)
+		if (pci->num_ob_windows <= i + 1)
 			break;
 
-		atu.index = i;
 		atu.type = PCIE_ATU_TYPE_MEM;
 		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
 		atu.pci_addr = entry->res->start - entry->offset;
 
 		/* Adjust iATU size if MSG TLP region was allocated before */
 		if (pp->msg_res && pp->msg_res->parent == entry->res)
-			atu.size = resource_size(entry->res) -
+			res_size = resource_size(entry->res) -
 					resource_size(pp->msg_res);
 		else
-			atu.size = resource_size(entry->res);
+			res_size = resource_size(entry->res);
+
+		while (res_size > 0) {
+			/*
+			 * Make sure to fail probe if we run out of windows
+			 * in the middle and we would end up only partially
+			 * mapping a single resource
+			 */
+			if (pci->num_ob_windows <= ++i) {
+				dev_err(pci->dev, "Exhausted outbound windows mapping %pr\n",
+					entry->res);
+				return -ENOMEM;
+			}
+			atu.index = i;
+			atu.size = MIN(pci->region_limit + 1, res_size);
 
-		ret = dw_pcie_prog_outbound_atu(pci, &atu);
-		if (ret) {
-			dev_err(pci->dev, "Failed to set MEM range %pr\n",
-				entry->res);
-			return ret;
+			ret = dw_pcie_prog_outbound_atu(pci, &atu);
+			if (ret) {
+				dev_err(pci->dev, "Failed to set MEM range %pr\n",
+					entry->res);
+				return ret;
+			}
+
+			atu.parent_bus_addr += atu.size;
+			atu.pci_addr += atu.size;
+			res_size -= atu.size;
 		}
 	}
 
@@ -956,20 +976,38 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
+		resource_size_t res_start, res_size, window_size;
+
 		if (resource_type(entry->res) != IORESOURCE_MEM)
 			continue;
 
 		if (pci->num_ib_windows <= i)
 			break;
 
-		ret = dw_pcie_prog_inbound_atu(pci, i++, PCIE_ATU_TYPE_MEM,
-					       entry->res->start,
-					       entry->res->start - entry->offset,
-					       resource_size(entry->res));
-		if (ret) {
-			dev_err(pci->dev, "Failed to set DMA range %pr\n",
-				entry->res);
-			return ret;
+		res_size = resource_size(entry->res);
+		res_start = entry->res->start;
+		while (res_size >= 0) {
+			/*
+			 * Make sure to fail probe if we run out of windows
+			 * in the middle and we would end up only partially
+			 * mapping a single resource
+			 */
+			if (pci->num_ib_windows <= i) {
+				dev_err(pci->dev, "Exhausted inbound windows mapping %pr\n",
+					entry->res);
+				return -ENOMEM;
+			}
+			window_size = MIN(pci->region_limit + 1, res_size);
+			ret = dw_pcie_prog_inbound_atu(pci, i++, PCIE_ATU_TYPE_MEM, res_start,
+						       res_start - entry->offset, window_size);
+			if (ret) {
+				dev_err(pci->dev, "Failed to set DMA range %pr\n",
+					entry->res);
+				return ret;
+			}
+
+			res_start += window_size;
+			res_size -= window_size;
 		}
 	}
 
-- 
2.34.1


