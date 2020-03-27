Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 410EB1955A5
	for <lists+linux-pci@lfdr.de>; Fri, 27 Mar 2020 11:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgC0Kry (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Mar 2020 06:47:54 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57574 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgC0Krv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Mar 2020 06:47:51 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02RAlhY6097373;
        Fri, 27 Mar 2020 05:47:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585306063;
        bh=G2PeNFXIlh49kkAbF78SFuvq87XpXT6JK3fAAHXLKqc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hM+Yevh6Szat5wXmLuMuj5uxHyS5goOmJwzl5fJfyTzPRM847y5zzHMq3AxhEebQk
         USl+e2U3csFZ3NJpIc7GiqlWAzIX40GiYH1RLp2AoVBByz60Xm0KeZb943yvdIHc0y
         33jtk+LPBeowBfSBRMG5mpQcuE2aTAQE0SU4oZd4=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02RAlhpI094865
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Mar 2020 05:47:43 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 27
 Mar 2020 05:47:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 27 Mar 2020 05:47:43 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02RAlT8r128190;
        Fri, 27 Mar 2020 05:47:40 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] PCI: Cadence: Remove using "cdns,max-outbound-regions" DT property
Date:   Fri, 27 Mar 2020 16:17:27 +0530
Message-ID: <20200327104727.4708-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327104727.4708-1-kishon@ti.com>
References: <20200327104727.4708-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"cdns,max-outbound-regions" device tree property provides the
maximum number of outbound regions supported by the Host PCIe
controller. However the outbound regions are configured based
on what is populated in the "ranges" DT property.
Avoid using two properties for configuring outbound regions and
use only "ranges" property instead.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 6 ------
 drivers/pci/controller/cadence/pcie-cadence.h      | 2 --
 2 files changed, 8 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 60f912a657b9..8f72967f298f 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -140,9 +140,6 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 	for_each_of_pci_range(&parser, &range) {
 		bool is_io;
 
-		if (r >= rc->max_regions)
-			break;
-
 		if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_MEM)
 			is_io = false;
 		else if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_IO)
@@ -221,9 +218,6 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	pcie = &rc->pcie;
 	pcie->is_rc = true;
 
-	rc->max_regions = 32;
-	of_property_read_u32(np, "cdns,max-outbound-regions", &rc->max_regions);
-
 	if (!of_pci_dma_range_parser_init(&parser, np))
 		if (of_pci_range_parser_one(&parser, &range))
 			rc->no_bar_nbits = ilog2(range.size);
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index a2b28b912ca4..6bd89a21bb1c 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -251,7 +251,6 @@ struct cdns_pcie {
  * @bus_range: first/last buses behind the PCIe host controller
  * @cfg_base: IO mapped window to access the PCI configuration space of a
  *            single function at a time
- * @max_regions: maximum number of regions supported by the hardware
  * @no_bar_nbits: Number of bits to keep for inbound (PCIe -> CPU) address
  *                translation (nbits sets into the "no BAR match" register)
  * @vendor_id: PCI vendor ID
@@ -262,7 +261,6 @@ struct cdns_pcie_rc {
 	struct resource		*cfg_res;
 	struct resource		*bus_range;
 	void __iomem		*cfg_base;
-	u32			max_regions;
 	u32			no_bar_nbits;
 	u16			vendor_id;
 	u16			device_id;
-- 
2.17.1

