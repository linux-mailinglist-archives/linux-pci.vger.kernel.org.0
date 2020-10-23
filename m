Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434402977F5
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 21:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755252AbgJWT5W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 15:57:22 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1732 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374621AbgJWT5W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 15:57:22 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9335aa0001>; Fri, 23 Oct 2020 12:57:30 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 23 Oct
 2020 19:57:20 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 23 Oct 2020 19:57:16 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH 3/3] PCI: dwc: Add support to handle prefetchable memory mapping
Date:   Sat, 24 Oct 2020 01:26:55 +0530
Message-ID: <20201023195655.11242-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201023195655.11242-1-vidyas@nvidia.com>
References: <20201023195655.11242-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603483050; bh=TUW5Amy+q6/UT7sHDyTCeSoRQZL9+Z8R+mBZmXHdcD8=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=C4dkruROMqmRF8Ck0Eo3/CA6pjeJz8GCksYr7Z4mBWfG958FUYnMuNREIw9ytvBVi
         mrMiuoS3/QuUbevtBGOMx+PhySPGVe7hNVJ5qVTWDgf18cuv5oMnKVYTtdrHBIcAYo
         AtqOOhakNT6XgEx9FDreRgos4a10N5PvP+NSjOc3wlwBrV3Om1a5u9b/vLWbQfff6q
         n3HnZKMdPBjOOw47ikB1bDk1Ok4eDd3jReF2F1X1N+gU0f44GKHkNbGCdMaD+fIOek
         AXQGD9AUoZkq99yrPNgypvsy7h3ZUdV32kK8mbuT/HL7mVQx7TvLDQFJ6gxTNCq7L2
         ebvVNZ6c9mpdw==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DWC sub-system currently doesn't differentiate between prefetchable and
non-prefetchable memory aperture entries in the 'ranges' property and
provides ATU mapping only for the first memory aperture entry out of all
the entries present. This was introduced by the
commit 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources").
Mapping for a memory apreture is required if its CPU address and the bus
address are different and the current mechanism works only if the memory
aperture which needs mapping happens to be the first entry. It doesn't
work either if the memory aperture that needs mapping is not the first
entry or if both prefetchable and non-prefetchable apertures need mapping.

This patch fixes this issue by differentiating between prefetchable and
non-prefetchable apertures in the 'ranges' property there by removing the
dependency on the order in which they are specified and adds support for
mapping prefetchable aperture using ATU region-3 if required.

Fixes: 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources")
Link: http://patchwork.ozlabs.org/project/linux-pci/patch/20200513190855.23318-1-vidyas@nvidia.com/

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes from previous versions:
* Addressed Rob's comments and as part of that split the patch into three sub-patches
* Rewrote commit subject and description
* Addressed review comments from Lorenzo

 .../pci/controller/dwc/pcie-designware-host.c | 39 ++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 674f32db85ca..a1f319ccd816 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -529,9 +529,39 @@ static struct pci_ops dw_pcie_ops = {
 	.write = pci_generic_config_write,
 };
 
+static void dw_pcie_setup_mem_atu(struct pcie_port *pp,
+				  struct resource_entry *win)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	/* Check for prefetchable memory aperture */
+	if (win->res->flags & IORESOURCE_PREFETCH) {
+		/* Number of view ports must at least be 4 to enable mapping */
+		if (pci->num_viewport < 4) {
+			dev_warn(pci->dev,
+				 "Insufficient ATU regions to map Prefetchable memory\n");
+		} else {
+			dw_pcie_prog_outbound_atu(pci,
+						  PCIE_ATU_REGION_INDEX3,
+						  PCIE_ATU_TYPE_MEM,
+						  win->res->start,
+						  win->res->start - win->offset,
+						  resource_size(win->res));
+		}
+	} else { /* Non-prefetchable memory aperture */
+		dw_pcie_prog_outbound_atu(pci,
+					  PCIE_ATU_REGION_INDEX0,
+					  PCIE_ATU_TYPE_MEM,
+					  win->res->start,
+					  win->res->start - win->offset,
+					  resource_size(win->res));
+	}
+}
+
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
 	u32 val, ctrl, num_ctrls;
+	struct resource_entry *win;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	/*
@@ -586,13 +616,10 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	 * ATU, so we should not program the ATU here.
 	 */
 	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
-		struct resource_entry *entry =
-			resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
+		resource_list_for_each_entry(win, &pp->bridge->windows)
+			if (resource_type(win->res) == IORESOURCE_MEM)
+				dw_pcie_setup_mem_atu(pp, win);
 
-		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
-					  PCIE_ATU_TYPE_MEM, entry->res->start,
-					  entry->res->start - entry->offset,
-					  resource_size(entry->res));
 		if (pci->num_viewport > 2)
 			dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX2,
 						  PCIE_ATU_TYPE_IO, pp->io_base,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e7f441441db2..21dd06831b50 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -80,6 +80,7 @@
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		BIT(31)
 #define PCIE_ATU_REGION_OUTBOUND	0
+#define PCIE_ATU_REGION_INDEX3		0x3
 #define PCIE_ATU_REGION_INDEX2		0x2
 #define PCIE_ATU_REGION_INDEX1		0x1
 #define PCIE_ATU_REGION_INDEX0		0x0
-- 
2.17.1

