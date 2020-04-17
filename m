Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97B61ADC6C
	for <lists+linux-pci@lfdr.de>; Fri, 17 Apr 2020 13:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbgDQLnx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Apr 2020 07:43:53 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52148 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbgDQLnx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Apr 2020 07:43:53 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03HBhZZg034317;
        Fri, 17 Apr 2020 06:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587123815;
        bh=6aSSBM0i5VIvjL6XkO+db3ofrSudsLQ7qzAvGhFRHCU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EXTd0EIWvC7SWpmIxLbRFkVaZUc/KPij8Qp5DOBtz8sNc6xk9pyIK18WgTBiBJf/9
         McKh1rsNmh9ja64Krjyhp4MsYvZBKp/OZjwo51hXVTOUqxHoBoIJ0oY4i20iR2nJrH
         B5dNe1dnvLs2Cb+LrJ8VNLGS7qSqRAi4fdLlng9k=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03HBhZSL086674
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Apr 2020 06:43:35 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 17
 Apr 2020 06:43:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 17 Apr 2020 06:43:35 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03HBhN9q088610;
        Fri, 17 Apr 2020 06:43:32 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] PCI: cadence: Remove "cdns,max-outbound-regions" DT property
Date:   Fri, 17 Apr 2020 17:13:21 +0530
Message-ID: <20200417114322.31111-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417114322.31111-1-kishon@ti.com>
References: <20200417114322.31111-1-kishon@ti.com>
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

